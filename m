Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5E72C3255;
	Mon,  1 Jun 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330022; cv=none; b=uI8jVhbeLzMxLfKL0YSQqomhe4HUiVRP5+OfbCAGoTdv+O/rzZcrH6Yv5VWVNNJwS81XpnySUNEBf2KZwan40nx5idqnyBEIFR76OjiZ9/9NSG1CKk0Q4bHodzwMXOHBqdAm3znAwjVtBUQBFRv4hS2vc1EdeIsGwbn1cWHDr6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330022; c=relaxed/simple;
	bh=DGY+EECkdNRobdJuSHfPAypBR/JY4rMlSxu4Q/7szYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bhtl4vX09AYq+OJnO/pObFYKdkyCjpOOnRlvGvHo4/v3ruMcRHY77xjTErJL8KM13qH/QXc2rtEHie22PhpBZ90oc8DLqg8TPgQ3qJemxelf7yX3UiU1uD+vCN2HInflqdis3Z/ndqZQMfjC+UDmTvSEqIxJi/d+4VBsmU9uu60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s3LTJH+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s3LTJH+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043EA1F00898;
	Mon,  1 Jun 2026 16:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780330016;
	bh=nZp8bCqqUrxBbnyU4Akqly9IfgPdUtLe56XCVb/I4Nw=;
	h=From:To:Cc:Subject:Date;
	b=s3LTJH+MmXCJzyoloh2iOySPLyby795oUf9Tq3qFBn6C08wtAjndPEaNal15Swoa9
	 7ik2lqeexOteDmTPuEmMiDd7k5hBTFjuxMpZ9bueFvDpGmbgiO4czcg2is3+frv3JT
	 XJPGFveXoqAsKS3+AKVlG307noGs5jVKosXSq4GM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.175
Date: Mon,  1 Jun 2026 18:05:38 +0200
Message-ID: <2026060139-demotion-likeness-bb81@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.175 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/mm/damon/reclaim.rst                  |    4 
 Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml |    4 
 Documentation/mm/hugetlbfs_reserv.rst                           |    2 
 Documentation/networking/bonding.rst                            |   15 
 Makefile                                                        |    2 
 arch/arm/boot/dts/mt7623.dtsi                                   |    2 
 arch/arm/mach-omap1/clock_data.c                                |    4 
 arch/arm/mach-versatile/integrator_cp.c                         |   13 
 arch/arm/net/bpf_jit_32.c                                       |    6 
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts            |    3 
 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi             |    2 
 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi             |    2 
 arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi             |    2 
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts                    |    2 
 arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp.dtsi           |    2 
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi               |    2 
 arch/arm64/boot/dts/freescale/imx8mq.dtsi                       |    2 
 arch/arm64/boot/dts/mediatek/mt6795.dtsi                        |    2 
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi                       |    2 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts            |    1 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                            |    5 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                            |    5 
 arch/arm64/crypto/aes-modes.S                                   |    4 
 arch/arm64/include/asm/exception.h                              |    5 
 arch/arm64/include/asm/xor.h                                    |    2 
 arch/arm64/kernel/machine_kexec.c                               |    3 
 arch/arm64/kvm/vgic/vgic-its.c                                  |    4 
 arch/arm64/kvm/vgic/vgic-mmio-v2.c                              |    2 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                              |    2 
 arch/arm64/mm/mmu.c                                             |    4 
 arch/arm64/net/bpf_jit_comp.c                                   |    4 
 arch/loongarch/kernel/cpu-probe.c                               |    7 
 arch/loongarch/mm/init.c                                        |    4 
 arch/loongarch/pci/acpi.c                                       |    5 
 arch/loongarch/pci/pci.c                                        |    3 
 arch/parisc/kernel/syscalls/syscall.tbl                         |    2 
 arch/powerpc/kernel/time.c                                      |    6 
 arch/powerpc/kexec/Makefile                                     |    2 
 arch/powerpc/kexec/file_load_64.c                               |    2 
 arch/powerpc/platforms/44x/warp.c                               |    2 
 arch/s390/kernel/debug.c                                        |    8 
 arch/s390/kvm/interrupt.c                                       |    3 
 arch/s390/kvm/pci.c                                             |    6 
 arch/um/drivers/cow_user.c                                      |    8 
 arch/x86/events/intel/uncore_discovery.c                        |    2 
 arch/x86/include/asm/segment.h                                  |    8 
 arch/x86/include/uapi/asm/kvm.h                                 |   12 
 arch/x86/kvm/mmu/mmu.c                                          |   36 
 arch/x86/kvm/mmu/spte.h                                         |    5 
 arch/x86/kvm/svm/nested.c                                       |   38 
 arch/x86/kvm/svm/sev.c                                          |   11 
 arch/x86/kvm/svm/svm.c                                          |   13 
 arch/x86/kvm/svm/svm.h                                          |    1 
 arch/x86/kvm/trace.h                                            |    2 
 arch/x86/kvm/x86.c                                              |   14 
 block/blk-cgroup.c                                              |   15 
 block/blk-mq.c                                                  |   10 
 certs/extract-cert.c                                            |    6 
 crypto/af_alg.c                                                 |    2 
 crypto/authencesn.c                                             |    5 
 crypto/pcrypt.c                                                 |    7 
 drivers/acpi/arm64/agdi.c                                       |    2 
 drivers/acpi/cppc_acpi.c                                        |    6 
 drivers/acpi/power.c                                            |    2 
 drivers/acpi/scan.c                                             |    2 
 drivers/acpi/video_detect.c                                     |    8 
 drivers/ata/ahci.c                                              |   14 
 drivers/base/core.c                                             |   39 
 drivers/base/dd.c                                               |   20 
 drivers/base/devres.c                                           |    2 
 drivers/block/drbd/drbd_nl.c                                    |    8 
 drivers/block/rbd.c                                             |    6 
 drivers/block/ublk_drv.c                                        |   28 
 drivers/bluetooth/btintel.c                                     |   11 
 drivers/bluetooth/hci_ldisc.c                                   |   51 
 drivers/bluetooth/virtio_bt.c                                   |   39 
 drivers/bus/imx-weim.c                                          |    2 
 drivers/cdrom/cdrom.c                                           |   73 
 drivers/char/ipmi/ipmi_si_intf.c                                |   70 
 drivers/char/ipmi/ipmi_ssif.c                                   |   23 
 drivers/char/tpm/tpm_tis_core.c                                 |    4 
 drivers/clk/clk-qoriq.c                                         |   17 
 drivers/clk/clk-xgene.c                                         |    2 
 drivers/clk/imx/clk-imx6q.c                                     |   12 
 drivers/clk/imx/clk-imx8mq.c                                    |    4 
 drivers/clk/microchip/clk-mpfs-ccc.c                            |    6 
 drivers/clk/qcom/dispcc-sc7180.c                                |    8 
 drivers/clk/qcom/dispcc-sm8250.c                                |    6 
 drivers/clk/qcom/dispcc-sm8450.c                                |    2 
 drivers/clk/qcom/gcc-sc8180x.c                                  |   64 
 drivers/clk/visconti/pll.c                                      |    2 
 drivers/cpuidle/cpuidle-powernv.c                               |    5 
 drivers/cpuidle/cpuidle-pseries.c                               |    5 
 drivers/crypto/atmel-aes.c                                      |    2 
 drivers/crypto/atmel-ecc.c                                      |    1 
 drivers/crypto/atmel-sha204a.c                                  |    6 
 drivers/crypto/atmel-tdes.c                                     |    8 
 drivers/crypto/ccp/ccp-crypto-aes.c                             |    7 
 drivers/crypto/ccp/sev-dev.c                                    |   19 
 drivers/crypto/ccree/cc_hash.c                                  |    1 
 drivers/crypto/hisilicon/sec/sec_algs.c                         |    2 
 drivers/crypto/sa2ul.c                                          |    4 
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c                  |    2 
 drivers/dma/idxd/sysfs.c                                        |    1 
 drivers/dma/mxs-dma.c                                           |    1 
 drivers/extcon/extcon-ptn5150.c                                 |   14 
 drivers/firmware/arm_ffa/bus.c                                  |    4 
 drivers/firmware/arm_ffa/driver.c                               |    2 
 drivers/firmware/efi/capsule-loader.c                           |    2 
 drivers/firmware/google/framebuffer-coreboot.c                  |    2 
 drivers/firmware/imx/scu-pd.c                                   |    1 
 drivers/gpio/gpio-tegra.c                                       |    2 
 drivers/gpio/gpiolib-cdev.c                                     |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c                     |   43 
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c                  |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c                        |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                         |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h                        |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                         |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                         |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                          |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                          |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c                           |   66 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                           |    3 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                          |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c                           |   16 
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c                           |    3 
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c                           |    2 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                           |   25 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                           |   23 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                        |   26 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                           |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c               |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h               |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c     |    7 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c               |   62 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c              |    9 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c        |    9 
 drivers/gpu/drm/amd/display/dc/core/dc.c                        |    6 
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c           |    4 
 drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h     |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c                  |   15 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c             |  118 +
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h             |    1 
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h                    |    1 
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c             |   28 
 drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c         |    6 
 drivers/gpu/drm/bridge/chipone-icn6211.c                        |    4 
 drivers/gpu/drm/bridge/ite-it66121.c                            |    5 
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c        |   16 
 drivers/gpu/drm/drm_file.c                                      |    5 
 drivers/gpu/drm/drm_gem_framebuffer_helper.c                    |    4 
 drivers/gpu/drm/drm_mode_config.c                               |    9 
 drivers/gpu/drm/gma500/oaktrail_hdmi.c                          |    1 
 drivers/gpu/drm/gma500/oaktrail_lvds.c                          |    9 
 drivers/gpu/drm/i915/display/intel_dp.c                         |    9 
 drivers/gpu/drm/i915/display/intel_psr.c                        |   18 
 drivers/gpu/drm/i915/display/skl_watermark.c                    |   43 
 drivers/gpu/drm/i915/display/skl_watermark.h                    |    2 
 drivers/gpu/drm/i915/gt/intel_reset.c                           |    3 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c                     |    2 
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c                           |   14 
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c                         |    2 
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c               |   24 
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                               |    4 
 drivers/gpu/drm/msm/dsi/dsi_cfg.h                               |    2 
 drivers/gpu/drm/msm/dsi/dsi_host.c                              |    1 
 drivers/gpu/drm/msm/msm_gem_shrinker.c                          |    5 
 drivers/gpu/drm/msm/msm_iommu.c                                 |    5 
 drivers/gpu/drm/nouveau/nouveau_gem.c                           |    2 
 drivers/gpu/drm/panel/panel-simple.c                            |    2 
 drivers/gpu/drm/panfrost/panfrost_drv.c                         |    2 
 drivers/gpu/drm/radeon/ci_dpm.c                                 |    9 
 drivers/gpu/drm/sun4i/sun4i_backend.c                           |    6 
 drivers/gpu/drm/tiny/arcpgu.c                                   |    3 
 drivers/gpu/drm/vc4/vc4_bo.c                                    |    3 
 drivers/gpu/drm/vc4/vc4_gem.c                                   |   19 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                  |   14 
 drivers/gpu/drm/vc4/vc4_v3d.c                                   |    1 
 drivers/gpu/drm/virtio/virtgpu_drv.h                            |    1 
 drivers/gpu/drm/virtio/virtgpu_gem.c                            |   17 
 drivers/gpu/drm/virtio/virtgpu_plane.c                          |   10 
 drivers/hid/hid-alps.c                                          |    3 
 drivers/hid/hid-asus.c                                          |   28 
 drivers/hid/hid-core.c                                          |    3 
 drivers/hid/hid-ids.h                                           |    3 
 drivers/hid/hid-quirks.c                                        |    3 
 drivers/hid/hid-roccat.c                                        |    2 
 drivers/hid/hid-uclogic-core.c                                  |    4 
 drivers/hid/usbhid/hid-core.c                                   |    2 
 drivers/hwmon/corsair-psu.c                                     |    4 
 drivers/hwmon/ltc2992.c                                         |   43 
 drivers/hwmon/pmbus/adm1266.c                                   |   32 
 drivers/i2c/busses/i2c-s3c2410.c                                |    7 
 drivers/i2c/i2c-core-of.c                                       |    2 
 drivers/i3c/master/mipi-i3c-hci/dma.c                           |    5 
 drivers/iio/adc/ad7768-1.c                                      |    9 
 drivers/iio/adc/ti-ads7950.c                                    |   11 
 drivers/infiniband/core/addr.c                                  |    3 
 drivers/infiniband/core/iwpm_msg.c                              |    6 
 drivers/infiniband/hw/hns/hns_roce_qp.c                         |    7 
 drivers/infiniband/hw/mlx4/srq.c                                |    4 
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c                     |    4 
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c                 |    2 
 drivers/infiniband/sw/rxe/rxe_recv.c                            |   14 
 drivers/infiniband/sw/siw/siw_qp_rx.c                           |   15 
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c                    |    2 
 drivers/iommu/intel/iommu.c                                     |    3 
 drivers/irqchip/irq-ath79-cpu.c                                 |    7 
 drivers/irqchip/irq-pic32-evic.c                                |    2 
 drivers/leds/blink/leds-lgm-sso.c                               |    2 
 drivers/mailbox/mailbox-test.c                                  |   39 
 drivers/mailbox/mailbox.c                                       |    3 
 drivers/md/bcache/super.c                                       |    8 
 drivers/md/dm-cache-metadata.c                                  |   24 
 drivers/md/dm-cache-metadata.h                                  |    5 
 drivers/md/dm-cache-policy-smq.c                                |    4 
 drivers/md/dm-cache-target.c                                    |  143 +
 drivers/md/dm-init.c                                            |    4 
 drivers/md/dm-ioctl.c                                           |    6 
 drivers/md/dm-log.c                                             |    6 
 drivers/md/dm-raid1.c                                           |    6 
 drivers/md/dm-verity-fec.c                                      |    8 
 drivers/md/persistent-data/dm-btree-remove.c                    |    8 
 drivers/md/raid10.c                                             |    6 
 drivers/md/raid5-cache.c                                        |   48 
 drivers/md/raid5.c                                              |    8 
 drivers/media/dvb-frontends/dib8000.c                           |    4 
 drivers/media/i2c/imx219.c                                      |    3 
 drivers/media/i2c/imx412.c                                      |    2 
 drivers/media/i2c/ov08d10.c                                     |   10 
 drivers/media/i2c/ov8856.c                                      |   10 
 drivers/media/pci/saa7164/saa7164-core.c                        |   47 
 drivers/media/pci/zoran/zoran_card.c                            |    2 
 drivers/media/platform/amphion/vpu_v4l2.c                       |    9 
 drivers/media/platform/ti/omap3isp/ispvideo.c                   |    1 
 drivers/media/rc/streamzap.c                                    |   12 
 drivers/media/rc/xbox_remote.c                                  |    9 
 drivers/media/test-drivers/vidtv/vidtv_bridge.c                 |    4 
 drivers/media/test-drivers/vidtv/vidtv_channel.c                |    4 
 drivers/media/test-drivers/vidtv/vidtv_mux.c                    |    4 
 drivers/media/test-drivers/vidtv/vidtv_ts.c                     |   48 
 drivers/media/test-drivers/vidtv/vidtv_ts.h                     |    4 
 drivers/media/usb/as102/as102_usb_drv.c                         |    2 
 drivers/media/usb/em28xx/em28xx-video.c                         |   14 
 drivers/media/usb/hackrf/hackrf.c                               |    7 
 drivers/media/usb/uvc/uvc_queue.c                               |    3 
 drivers/memory/tegra/tegra124-emc.c                             |    2 
 drivers/memory/tegra/tegra30-emc.c                              |    6 
 drivers/mfd/mc13xxx-core.c                                      |    2 
 drivers/misc/ibmasm/ibmasmfs.c                                  |    7 
 drivers/misc/ibmasm/lowlevel.c                                  |   12 
 drivers/misc/ibmasm/remote.c                                    |    5 
 drivers/mmc/core/block.c                                        |   12 
 drivers/mmc/core/queue.h                                        |    3 
 drivers/mmc/host/sdhci-of-dwcmshc.c                             |   19 
 drivers/mtd/devices/docg3.c                                     |    8 
 drivers/mtd/maps/physmap-gemini.c                               |    2 
 drivers/mtd/nand/raw/sunxi_nand.c                               |    6 
 drivers/mtd/parsers/ofpart_core.c                               |    4 
 drivers/mtd/spi-nor/core.c                                      |    2 
 drivers/mtd/spi-nor/core.h                                      |   10 
 drivers/mtd/spi-nor/micron-st.c                                 |    4 
 drivers/mtd/spi-nor/sfdp.c                                      |   47 
 drivers/mtd/spi-nor/spansion.c                                  |  106 +
 drivers/mtd/spi-nor/sst.c                                       |   50 
 drivers/mtd/spi-nor/swp.c                                       |    4 
 drivers/net/bareudp.c                                           |   24 
 drivers/net/bonding/bond_3ad.c                                  |  123 -
 drivers/net/bonding/bond_main.c                                 |   90 +
 drivers/net/bonding/bond_netlink.c                              |   37 
 drivers/net/bonding/bond_options.c                              |   74 +
 drivers/net/bonding/bond_procfs.c                               |    3 
 drivers/net/bonding/bond_sysfs_slave.c                          |   17 
 drivers/net/can/spi/mcp251x.c                                   |   29 
 drivers/net/can/usb/ucan.c                                      |    2 
 drivers/net/dsa/mt7530.c                                        |   89 -
 drivers/net/dsa/mt7530.h                                        |   76 -
 drivers/net/dsa/realtek/rtl8365mb.c                             |    2 
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c            |    2 
 drivers/net/ethernet/atheros/ag71xx.c                           |    3 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                  |  737 ++++------
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                  |   68 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c              |    4 
 drivers/net/ethernet/broadcom/genet/bcmmii.c                    |    6 
 drivers/net/ethernet/cirrus/cs89x0.c                            |    2 
 drivers/net/ethernet/cortina/gemini.c                           |   21 
 drivers/net/ethernet/freescale/Makefile                         |    3 
 drivers/net/ethernet/freescale/dpaa2/Kconfig                    |    4 
 drivers/net/ethernet/freescale/enetc/enetc.c                    |   25 
 drivers/net/ethernet/ibm/ibmveth.c                              |   22 
 drivers/net/ethernet/ibm/ibmveth.h                              |    1 
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c                |    8 
 drivers/net/ethernet/intel/e1000e/netdev.c                      |    1 
 drivers/net/ethernet/intel/i40e/i40e.h                          |    1 
 drivers/net/ethernet/intel/i40e/i40e_main.c                     |    2 
 drivers/net/ethernet/intel/i40e/i40e_ptp.c                      |    3 
 drivers/net/ethernet/intel/iavf/iavf.h                          |    9 
 drivers/net/ethernet/intel/iavf/iavf_main.c                     |   52 
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c                 |   76 -
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c                    |    4 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                    |   11 
 drivers/net/ethernet/intel/ice/ice_main.c                       |    2 
 drivers/net/ethernet/intel/ice/ice_sriov.c                      |    2 
 drivers/net/ethernet/intel/ice/ice_vf_lib.c                     |   26 
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c               |    1 
 drivers/net/ethernet/intel/ixgbevf/vf.c                         |    7 
 drivers/net/ethernet/micrel/ks8851.h                            |    6 
 drivers/net/ethernet/micrel/ks8851_common.c                     |   69 
 drivers/net/ethernet/micrel/ks8851_par.c                        |   15 
 drivers/net/ethernet/micrel/ks8851_spi.c                        |   11 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c           |    8 
 drivers/net/ethernet/microsoft/mana/hw_channel.c                |   29 
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c         |   17 
 drivers/net/ethernet/qlogic/qed/qed_cxt.c                       |    2 
 drivers/net/ethernet/xscale/ixp4xx_eth.c                        |   60 
 drivers/net/ethernet/xscale/ptp_ixp46x.c                        |    3 
 drivers/net/hamradio/6pack.c                                    |   39 
 drivers/net/ifb.c                                               |   11 
 drivers/net/macvlan.c                                           |    8 
 drivers/net/mctp/mctp-i2c.c                                     |    4 
 drivers/net/netconsole.c                                        |   26 
 drivers/net/netdevsim/dev.c                                     |    2 
 drivers/net/phy/dp83869.c                                       |   13 
 drivers/net/phy/mdio_bus.c                                      |    4 
 drivers/net/ppp/ppp_generic.c                                   |    5 
 drivers/net/ppp/pppoe.c                                         |    8 
 drivers/net/slip/slhc.c                                         |   49 
 drivers/net/usb/cdc-phonet.c                                    |    7 
 drivers/net/usb/r8152.c                                         |    2 
 drivers/net/usb/rtl8150.c                                       |   12 
 drivers/net/vrf.c                                               |   15 
 drivers/net/wan/lapbether.c                                     |   13 
 drivers/net/wireless/ath/ath11k/ahb.c                           |   44 
 drivers/net/wireless/ath/ath11k/ce.h                            |   16 
 drivers/net/wireless/ath/ath11k/core.c                          |   91 +
 drivers/net/wireless/ath/ath11k/core.h                          |   12 
 drivers/net/wireless/ath/ath11k/dp_rx.c                         |    3 
 drivers/net/wireless/ath/ath11k/hal.c                           |   31 
 drivers/net/wireless/ath/ath11k/hal.h                           |    5 
 drivers/net/wireless/ath/ath11k/hal_rx.c                        |   13 
 drivers/net/wireless/ath/ath11k/hal_rx.h                        |   18 
 drivers/net/wireless/ath/ath11k/hw.c                            |  398 +++++
 drivers/net/wireless/ath/ath11k/hw.h                            |   14 
 drivers/net/wireless/ath/ath11k/mac.c                           |    7 
 drivers/net/wireless/ath/ath11k/pci.c                           |    2 
 drivers/net/wireless/ath/ath11k/wmi.c                           |   19 
 drivers/net/wireless/ath/ath5k/base.c                           |    3 
 drivers/net/wireless/ath/ath9k/channel.c                        |    6 
 drivers/net/wireless/broadcom/b43/xmit.c                        |    3 
 drivers/net/wireless/broadcom/b43legacy/xmit.c                  |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c         |   15 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c         |    5 
 drivers/net/wireless/intel/iwlwifi/queue/tx.c                   |    3 
 drivers/net/wireless/mac80211_hwsim.c                           |    1 
 drivers/net/wireless/marvell/mwifiex/11n_aggr.c                 |    1 
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                 |    3 
 drivers/net/wireless/realtek/rtlwifi/pci.c                      |    1 
 drivers/net/wireless/realtek/rtw88/pci.c                        |    3 
 drivers/net/wireless/realtek/rtw89/phy.c                        |    2 
 drivers/net/wireless/rsi/rsi_common.h                           |    5 
 drivers/net/wireless/ti/wl1251/tx.c                             |    8 
 drivers/net/wwan/iosm/iosm_ipc_imem.c                           |    2 
 drivers/nfc/s3fwrn5/uart.c                                      |   10 
 drivers/nfc/trf7970a.c                                          |    3 
 drivers/nvme/host/apple.c                                       |    6 
 drivers/nvme/host/core.c                                        |    2 
 drivers/nvme/host/pci.c                                         |    3 
 drivers/nvme/target/core.c                                      |    2 
 drivers/nvme/target/tcp.c                                       |   51 
 drivers/of/base.c                                               |    2 
 drivers/of/dynamic.c                                            |    2 
 drivers/of/platform.c                                           |    2 
 drivers/parisc/lasi.c                                           |   12 
 drivers/pci/controller/dwc/pcie-tegra194.c                      |  149 --
 drivers/pci/controller/pci-hyperv.c                             |    8 
 drivers/pci/controller/pcie-mediatek-gen3.c                     |    8 
 drivers/pci/endpoint/functions/pci-epf-ntb.c                    |   56 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                   |   19 
 drivers/pci/pci.c                                               |   48 
 drivers/pci/pci.h                                               |    6 
 drivers/pci/pcie/aer.c                                          |    2 
 drivers/pcmcia/rsrc_nonstatic.c                                 |    6 
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c                      |    5 
 drivers/pinctrl/intel/pinctrl-intel.c                           |    2 
 drivers/pinctrl/nomadik/pinctrl-abx500.c                        |    2 
 drivers/pinctrl/pinctrl-cy8c95x0.c                              |   27 
 drivers/pinctrl/pinctrl-pic32.c                                 |   20 
 drivers/pinctrl/qcom/pinctrl-sm8150.c                           |    8 
 drivers/platform/surface/surfacepro3_button.c                   |    1 
 drivers/platform/x86/adv_swbutton.c                             |    6 
 drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c     |   34 
 drivers/platform/x86/dell/dell_rbu.c                            |    6 
 drivers/platform/x86/hp/hp-wmi.c                                |    5 
 drivers/platform/x86/hp/hp_accel.c                              |    3 
 drivers/platform/x86/intel/hid.c                                |    6 
 drivers/platform/x86/intel/vbtn.c                               |    6 
 drivers/platform/x86/panasonic-laptop.c                         |    5 
 drivers/power/supply/axp288_charger.c                           |   19 
 drivers/power/supply/max17042_battery.c                         |    2 
 drivers/pwm/pwm-imx-tpm.c                                       |    8 
 drivers/regulator/act8945a-regulator.c                          |    3 
 drivers/regulator/bd9571mwv-regulator.c                         |    3 
 drivers/regulator/max77650-regulator.c                          |    2 
 drivers/rtc/rtc-abx80x.c                                        |    2 
 drivers/rtc/rtc-ntxec.c                                         |    2 
 drivers/s390/cio/css.c                                          |    2 
 drivers/scsi/isci/host.c                                        |    3 
 drivers/scsi/sd.c                                               |    1 
 drivers/scsi/sg.c                                               |   29 
 drivers/scsi/sr.c                                               |   11 
 drivers/scsi/sr.h                                               |    1 
 drivers/soc/aspeed/aspeed-socinfo.c                             |    2 
 drivers/soc/qcom/llcc-qcom.c                                    |    2 
 drivers/soc/qcom/ocmem.c                                        |   22 
 drivers/soc/qcom/qcom_aoss.c                                    |    2 
 drivers/soc/tegra/cbb/tegra234-cbb.c                            |    4 
 drivers/soc/ti/omap_prm.c                                       |    1 
 drivers/soundwire/bus.c                                         |    8 
 drivers/spi/spi-fsl-qspi.c                                      |    3 
 drivers/spi/spi-hisi-kunpeng.c                                  |   12 
 drivers/spi/spi-imx.c                                           |    1 
 drivers/spi/spi-meson-spicc.c                                   |    2 
 drivers/spi/spi-mpc52xx.c                                       |    3 
 drivers/spi/spi-mtk-nor.c                                       |    4 
 drivers/spi/spi-mtk-snfi.c                                      |   16 
 drivers/spi/spi-orion.c                                         |    6 
 drivers/spi/spi-rockchip.c                                      |   66 
 drivers/spi/spi-sprd.c                                          |    3 
 drivers/spi/spi-ti-qspi.c                                       |    1 
 drivers/spi/spi-topcliff-pch.c                                  |    6 
 drivers/spi/spi-zynqmp-gqspi.c                                  |    4 
 drivers/spi/spi.c                                               |    2 
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c               |    4 
 drivers/staging/media/rkvdec/rkvdec-vp9.c                       |    3 
 drivers/staging/rtl8723bs/core/rtw_security.c                   |    2 
 drivers/staging/sm750fb/sm750.c                                 |    3 
 drivers/staging/vme_user/vme_fake.c                             |    2 
 drivers/target/target_core_configfs.c                           |    2 
 drivers/target/target_core_sbc.c                                |    3 
 drivers/thermal/spear_thermal.c                                 |    2 
 drivers/thermal/sprd_thermal.c                                  |    4 
 drivers/tty/hvc/hvc_iucv.c                                      |    2 
 drivers/ufs/core/ufshcd.c                                       |   31 
 drivers/ufs/host/ufshcd-pci.c                                   |    2 
 drivers/ufs/host/ufshcd-pltfrm.c                                |   25 
 drivers/usb/class/cdc-acm.c                                     |   53 
 drivers/usb/class/usblp.c                                       |    3 
 drivers/usb/common/ulpi.c                                       |    5 
 drivers/usb/core/port.c                                         |    1 
 drivers/usb/gadget/function/f_ncm.c                             |    4 
 drivers/usb/gadget/function/f_phonet.c                          |    9 
 drivers/usb/gadget/udc/omap_udc.c                               |    4 
 drivers/usb/gadget/udc/renesas_usb3.c                           |    7 
 drivers/usb/host/xhci.c                                         |    1 
 drivers/usb/serial/option.c                                     |    6 
 drivers/usb/storage/unusual_devs.h                              |    7 
 drivers/usb/usbip/usbip_common.c                                |   12 
 drivers/vhost/net.c                                             |    4 
 drivers/video/backlight/sky81452-backlight.c                    |    3 
 drivers/video/fbdev/matrox/g450_pll.c                           |    2 
 drivers/video/fbdev/offb.c                                      |    7 
 drivers/video/fbdev/tdfxfb.c                                    |    3 
 drivers/video/fbdev/udlfb.c                                     |   34 
 fs/adfs/super.c                                                 |    3 
 fs/binfmt_elf.c                                                 |    2 
 fs/btrfs/inode.c                                                |    2 
 fs/btrfs/space-info.c                                           |    2 
 fs/ceph/xattr.c                                                 |    1 
 fs/dcache.c                                                     |    4 
 fs/debugfs/file.c                                               |    5 
 fs/erofs/dir.c                                                  |   28 
 fs/eventpoll.c                                                  |  199 +-
 fs/ext2/inode.c                                                 |   14 
 fs/ext4/extents.c                                               |   15 
 fs/ext4/xattr.c                                                 |    4 
 fs/f2fs/compress.c                                              |   90 -
 fs/f2fs/data.c                                                  |   28 
 fs/f2fs/f2fs.h                                                  |    2 
 fs/f2fs/inode.c                                                 |    2 
 fs/f2fs/node.c                                                  |   17 
 fs/f2fs/super.c                                                 |    8 
 fs/f2fs/sysfs.c                                                 |   52 
 fs/fuse/control.c                                               |    4 
 fs/fuse/readdir.c                                               |    4 
 fs/gfs2/dir.c                                                   |   37 
 fs/gfs2/glops.c                                                 |   40 
 fs/gfs2/inode.c                                                 |    3 
 fs/gfs2/log.c                                                   |   33 
 fs/gfs2/xattr.c                                                 |   28 
 fs/isofs/export.c                                               |    2 
 fs/isofs/rock.c                                                 |    9 
 fs/nfs/blocklayout/blocklayout.c                                |    4 
 fs/nilfs2/dat.c                                                 |    3 
 fs/nilfs2/ioctl.c                                               |    6 
 fs/notify/fsnotify.c                                            |    2 
 fs/notify/inotify/inotify_user.c                                |    1 
 fs/notify/mark.c                                                |   18 
 fs/ntfs3/fslog.c                                                |   12 
 fs/ntfs3/run.c                                                  |   18 
 fs/ntfs3/super.c                                                |    7 
 fs/ocfs2/aops.c                                                 |   75 -
 fs/ocfs2/dlm/dlmdomain.c                                        |   10 
 fs/ocfs2/inode.c                                                |   31 
 fs/ocfs2/ioctl.c                                                |   18 
 fs/ocfs2/mmap.c                                                 |    7 
 fs/ocfs2/ocfs2_trace.h                                          |   10 
 fs/ocfs2/resize.c                                               |   22 
 fs/ocfs2/xattr.c                                                |    4 
 fs/omfs/inode.c                                                 |    6 
 fs/pstore/ram_core.c                                            |    4 
 fs/quota/dquot.c                                                |   38 
 fs/smb/client/cached_dir.c                                      |    8 
 fs/smb/client/cifs_spnego.c                                     |   16 
 fs/smb/client/cifsacl.c                                         |    1 
 fs/smb/client/cifsfs.c                                          |    2 
 fs/smb/client/fs_context.c                                      |    4 
 fs/smb/client/smb2file.c                                        |   27 
 fs/smb/client/smb2misc.c                                        |    3 
 fs/smb/client/smb2ops.c                                         |   17 
 fs/smb/client/smb2pdu.h                                         |    2 
 fs/smb/server/auth.c                                            |   11 
 fs/smb/server/mgmt/user_session.c                               |   12 
 fs/smb/server/smb2pdu.c                                         |    7 
 fs/smb/server/smbacl.c                                          |   19 
 fs/smb/server/transport_tcp.c                                   |    4 
 fs/sysfs/group.c                                                |    2 
 fs/udf/misc.c                                                   |    8 
 fs/userfaultfd.c                                                |    2 
 include/dt-bindings/clock/qcom,dispcc-sc7180.h                  |    7 
 include/dt-bindings/clock/qcom,gcc-sc8180x.h                    |    5 
 include/linux/cdrom.h                                           |    1 
 include/linux/container_of.h                                    |   23 
 include/linux/cpuhotplug.h                                      |    1 
 include/linux/dev_printk.h                                      |   10 
 include/linux/device.h                                          |   48 
 include/linux/dmi.h                                             |    5 
 include/linux/f2fs_fs.h                                         |    1 
 include/linux/fsnotify_backend.h                                |    1 
 include/linux/fwnode.h                                          |   45 
 include/linux/kvm_host.h                                        |    3 
 include/linux/module.h                                          |    2 
 include/linux/moduleparam.h                                     |   11 
 include/linux/padata.h                                          |   12 
 include/linux/ppp_defs.h                                        |   16 
 include/linux/printk.h                                          |    5 
 include/linux/quotaops.h                                        |    9 
 include/linux/randomize_kstack.h                                |   26 
 include/linux/sched.h                                           |    4 
 include/linux/soc/qcom/apr.h                                    |    2 
 include/linux/spinlock_up.h                                     |   20 
 include/linux/string.h                                          |   12 
 include/linux/tcp.h                                             |   10 
 include/linux/tpm_eventlog.h                                    |    9 
 include/linux/usb.h                                             |    3 
 include/net/bluetooth/hci_sync.h                                |   17 
 include/net/bond_3ad.h                                          |    3 
 include/net/bond_options.h                                      |    2 
 include/net/bonding.h                                           |    4 
 include/net/ipv6.h                                              |    6 
 include/net/mac80211.h                                          |    4 
 include/net/netfilter/nf_queue.h                                |    1 
 include/net/netfilter/nf_tables.h                               |    2 
 include/net/pie.h                                               |    2 
 include/net/pkt_cls.h                                           |    2 
 include/net/route.h                                             |    6 
 include/net/tcp.h                                               |    2 
 include/net/udp_tunnel.h                                        |   15 
 include/trace/events/btrfs.h                                    |    9 
 include/trace/events/rxrpc.h                                    |    4 
 include/trace/events/timer.h                                    |   11 
 include/uapi/linux/bpf.h                                        |    2 
 include/uapi/linux/if_link.h                                    |    3 
 include/uapi/linux/kvm.h                                        |   11 
 include/ufs/ufshcd.h                                            |    1 
 include/video/udlfb.h                                           |    1 
 init/main.c                                                     |    1 
 io_uring/io-wq.c                                                |    3 
 io_uring/io_uring.c                                             |    2 
 io_uring/poll.c                                                 |   14 
 io_uring/timeout.c                                              |    4 
 kernel/audit.c                                                  |    4 
 kernel/auditsc.c                                                |    2 
 kernel/bpf/bpf_lsm.c                                            |    1 
 kernel/bpf/devmap.c                                             |    8 
 kernel/bpf/helpers.c                                            |   17 
 kernel/bpf/local_storage.c                                      |    2 
 kernel/cgroup/rdma.c                                            |    2 
 kernel/exit.c                                                   |    3 
 kernel/fork.c                                                   |   13 
 kernel/futex/requeue.c                                          |   13 
 kernel/irq_work.c                                               |    7 
 kernel/locking/rtmutex.c                                        |   13 
 kernel/module/main.c                                            |    4 
 kernel/padata.c                                                 |  266 +--
 kernel/params.c                                                 |   46 
 kernel/regset.c                                                 |    6 
 kernel/taskstats.c                                              |    1 
 kernel/time/hrtimer.c                                           |   56 
 kernel/trace/ring_buffer.c                                      |    8 
 kernel/trace/trace_branch.c                                     |    8 
 kernel/trace/trace_events_hist.c                                |   12 
 kernel/trace/trace_probe.c                                      |    2 
 kernel/trace/tracing_map.c                                      |   17 
 lib/kunit/Kconfig                                               |    5 
 lib/ts_kmp.c                                                    |   18 
 mm/backing-dev.c                                                |    5 
 mm/kasan/init.c                                                 |    8 
 net/batman-adv/bat_iv_ogm.c                                     |   85 -
 net/batman-adv/bridge_loop_avoidance.c                          |   65 
 net/batman-adv/distributed-arp-table.c                          |    3 
 net/batman-adv/fragmentation.c                                  |   58 
 net/batman-adv/gateway_client.c                                 |    4 
 net/batman-adv/originator.c                                     |    4 
 net/batman-adv/tp_meter.c                                       |   32 
 net/batman-adv/types.h                                          |    6 
 net/bluetooth/af_bluetooth.c                                    |   10 
 net/bluetooth/bnep/core.c                                       |    2 
 net/bluetooth/hci_event.c                                       |   21 
 net/bluetooth/hci_request.h                                     |   21 
 net/bluetooth/hci_sync.c                                        |   14 
 net/bluetooth/iso.c                                             |   14 
 net/bluetooth/l2cap_core.c                                      |    8 
 net/bluetooth/l2cap_sock.c                                      |   60 
 net/bluetooth/mgmt.c                                            |    6 
 net/bluetooth/rfcomm/sock.c                                     |    9 
 net/bluetooth/sco.c                                             |    9 
 net/bpf/test_run.c                                              |   63 
 net/bridge/br_multicast.c                                       |   27 
 net/caif/cfsrvl.c                                               |   14 
 net/can/raw.c                                                   |   11 
 net/ceph/auth.c                                                 |    4 
 net/ceph/crush/crush.c                                          |    6 
 net/ceph/mon_client.c                                           |    2 
 net/ceph/osdmap.c                                               |   14 
 net/core/filter.c                                               |    4 
 net/core/flow_dissector.c                                       |   13 
 net/core/neighbour.c                                            |   34 
 net/core/net-procfs.c                                           |   49 
 net/core/rtnetlink.c                                            |    1 
 net/dsa/dsa2.c                                                  |   38 
 net/ethtool/bitset.c                                            |    8 
 net/ipv4/icmp.c                                                 |   15 
 net/ipv4/inet_connection_sock.c                                 |    5 
 net/ipv4/netfilter/arp_tables.c                                 |   18 
 net/ipv4/netfilter/arpt_mangle.c                                |    8 
 net/ipv4/netfilter/arptable_filter.c                            |    2 
 net/ipv4/netfilter/iptable_filter.c                             |    2 
 net/ipv4/netfilter/iptable_mangle.c                             |    2 
 net/ipv4/netfilter/iptable_raw.c                                |    2 
 net/ipv4/netfilter/iptable_security.c                           |    2 
 net/ipv4/nexthop.c                                              |    4 
 net/ipv4/raw.c                                                  |    2 
 net/ipv4/route.c                                                |   48 
 net/ipv4/tcp.c                                                  |   17 
 net/ipv4/tcp_input.c                                            |    6 
 net/ipv4/tcp_minisocks.c                                        |    5 
 net/ipv4/tcp_output.c                                           |   20 
 net/ipv4/tcp_recovery.c                                         |    2 
 net/ipv4/udp_tunnel_core.c                                      |   48 
 net/ipv6/exthdrs.c                                              |   13 
 net/ipv6/icmp.c                                                 |   10 
 net/ipv6/ip6_gre.c                                              |    5 
 net/ipv6/ip6_output.c                                           |   68 
 net/ipv6/ip6_udp_tunnel.c                                       |   69 
 net/ipv6/netfilter/ip6t_eui64.c                                 |    3 
 net/ipv6/netfilter/ip6t_hbh.c                                   |    4 
 net/ipv6/netfilter/ip6table_filter.c                            |    2 
 net/ipv6/netfilter/ip6table_mangle.c                            |    2 
 net/ipv6/netfilter/ip6table_raw.c                               |    2 
 net/ipv6/netfilter/ip6table_security.c                          |    2 
 net/ipv6/rpl_iptunnel.c                                         |    9 
 net/ipv6/seg6_hmac.c                                            |    2 
 net/ipv6/seg6_iptunnel.c                                        |   12 
 net/ipv6/xfrm6_protocol.c                                       |    4 
 net/l2tp/l2tp_core.c                                            |    5 
 net/mac80211/tdls.c                                             |    2 
 net/mac80211/tx.c                                               |    4 
 net/mptcp/sockopt.c                                             |   12 
 net/mptcp/subflow.c                                             |    4 
 net/netfilter/ipset/ip_set_hash_ipmark.c                        |    6 
 net/netfilter/ipset/ip_set_hash_ipport.c                        |    5 
 net/netfilter/ipset/ip_set_hash_ipportip.c                      |    5 
 net/netfilter/ipset/ip_set_hash_ipportnet.c                     |    5 
 net/netfilter/ipvs/ip_vs_xmit.c                                 |   19 
 net/netfilter/nf_conntrack_netlink.c                            |    2 
 net/netfilter/nf_conntrack_proto_sctp.c                         |   13 
 net/netfilter/nf_conntrack_sip.c                                |  160 +-
 net/netfilter/nf_nat_amanda.c                                   |    2 
 net/netfilter/nf_nat_sip.c                                      |   34 
 net/netfilter/nf_queue.c                                        |    4 
 net/netfilter/nf_tables_api.c                                   |    4 
 net/netfilter/nfnetlink_log.c                                   |    8 
 net/netfilter/nfnetlink_osf.c                                   |   45 
 net/netfilter/nfnetlink_queue.c                                 |    2 
 net/netfilter/nft_bitwise.c                                     |    3 
 net/netfilter/nft_ct.c                                          |    2 
 net/netfilter/nft_dynset.c                                      |   10 
 net/netfilter/nft_fwd_netdev.c                                  |   10 
 net/netfilter/nft_osf.c                                         |    6 
 net/netfilter/nft_set_pipapo_avx2.c                             |   20 
 net/netfilter/xt_mac.c                                          |   34 
 net/netfilter/xt_multiport.c                                    |   34 
 net/netfilter/xt_owner.c                                        |   37 
 net/netfilter/xt_physdev.c                                      |   29 
 net/netfilter/xt_policy.c                                       |    2 
 net/netfilter/xt_realm.c                                        |    2 
 net/netfilter/xt_socket.c                                       |   23 
 net/nfc/digital_technology.c                                    |    6 
 net/nfc/llcp_core.c                                             |    2 
 net/openvswitch/datapath.c                                      |   35 
 net/openvswitch/vport-netdev.c                                  |    6 
 net/openvswitch/vport.c                                         |    3 
 net/phonet/pep.c                                                |   19 
 net/qrtr/ns.c                                                   |   11 
 net/rds/af_rds.c                                                |   10 
 net/rds/connection.c                                            |   14 
 net/rds/ib.c                                                    |   24 
 net/rds/ib.h                                                    |    1 
 net/rds/ib_rdma.c                                               |    2 
 net/rds/message.c                                               |   21 
 net/rds/rdma.c                                                  |    4 
 net/rxrpc/call_object.c                                         |   22 
 net/rxrpc/conn_event.c                                          |   17 
 net/rxrpc/key.c                                                 |    9 
 net/rxrpc/proc.c                                                |   26 
 net/rxrpc/recvmsg.c                                             |   22 
 net/rxrpc/rxkad.c                                               |    7 
 net/rxrpc/sendmsg.c                                             |    2 
 net/sched/act_csum.c                                            |    6 
 net/sched/act_ct.c                                              |    8 
 net/sched/em_cmp.c                                              |    5 
 net/sched/em_nbyte.c                                            |    2 
 net/sched/em_text.c                                             |   11 
 net/sched/sch_cake.c                                            |   15 
 net/sched/sch_choke.c                                           |   26 
 net/sched/sch_fq_codel.c                                        |    3 
 net/sched/sch_fq_pie.c                                          |   19 
 net/sched/sch_hhf.c                                             |   19 
 net/sched/sch_netem.c                                           |   44 
 net/sched/sch_pie.c                                             |   52 
 net/sched/sch_red.c                                             |   33 
 net/sched/sch_sfb.c                                             |   54 
 net/sched/sch_taprio.c                                          |  176 +-
 net/sctp/inqueue.c                                              |    1 
 net/sctp/sm_statefuns.c                                         |    6 
 net/sctp/socket.c                                               |   11 
 net/smc/af_smc.c                                                |    3 
 net/smc/smc_clc.c                                               |    4 
 net/smc/smc_tracepoint.h                                        |    2 
 net/strparser/strparser.c                                       |    8 
 net/tipc/msg.c                                                  |   14 
 net/tls/tls.h                                                   |    1 
 net/tls/tls_strp.c                                              |    6 
 net/tls/tls_sw.c                                                |   30 
 net/unix/af_unix.c                                              |    9 
 net/unix/diag.c                                                 |   21 
 net/unix/unix_bpf.c                                             |    3 
 net/vmw_vsock/af_vsock.c                                        |    6 
 net/vmw_vsock/hyperv_transport.c                                |    4 
 net/vmw_vsock/virtio_transport_common.c                         |   23 
 net/vmw_vsock/vmci_transport.c                                  |    2 
 net/wireless/core.c                                             |    4 
 net/wireless/scan.c                                             |    3 
 net/xdp/xdp_umem.c                                              |    3 
 net/xfrm/xfrm_user.c                                            |    2 
 scripts/checkpatch.pl                                           |   10 
 scripts/dtc/dtc-lexer.l                                         |    3 
 scripts/generate_rust_analyzer.py                               |   17 
 security/integrity/ima/ima_crypto.c                             |    2 
 security/keys/keyring.c                                         |    1 
 sound/aoa/soundbus/i2sbus/core.c                                |    9 
 sound/core/compress_offload.c                                   |    7 
 sound/core/control.c                                            |    4 
 sound/core/control_led.c                                        |   14 
 sound/core/misc.c                                               |   44 
 sound/core/seq/oss/seq_oss_rw.c                                 |    6 
 sound/core/sound.c                                              |    7 
 sound/firewire/fireworks/fireworks_command.c                    |    5 
 sound/firewire/tascam/tascam-hwdep.c                            |    1 
 sound/isa/sc6000.c                                              |  285 ++-
 sound/pci/asihpi/hpicmn.c                                       |    6 
 sound/pci/asihpi/hpimsgx.c                                      |    6 
 sound/pci/ctxfi/ctatc.c                                         |    3 
 sound/pci/ctxfi/ctvmem.h                                        |    2 
 sound/pci/hda/patch_conexant.c                                  |   34 
 sound/pci/hda/patch_realtek.c                                   |    8 
 sound/soc/amd/yc/acp6x-mach.c                                   |   35 
 sound/soc/codecs/ab8500-codec.c                                 |    6 
 sound/soc/fsl/fsl_easrc.c                                       |  125 +
 sound/soc/fsl/fsl_micfil.c                                      |   28 
 sound/soc/fsl/fsl_xcvr.c                                        |   22 
 sound/soc/intel/boards/bytcr_wm5102.c                           |    1 
 sound/soc/qcom/qdsp6/q6apm-dai.c                                |    1 
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c                         |    2 
 sound/soc/qcom/qdsp6/q6apm.c                                    |   17 
 sound/soc/qcom/qdsp6/q6core.c                                   |    4 
 sound/soc/qcom/qdsp6/topology.c                                 |    8 
 sound/soc/soc-core.c                                            |    1 
 sound/soc/sof/amd/acp-common.c                                  |    1 
 sound/soc/sof/amd/acp-ipc.c                                     |   34 
 sound/soc/sof/amd/acp.h                                         |    7 
 sound/soc/sof/compress.c                                        |   11 
 sound/soc/sof/intel/hda-ipc.c                                   |    8 
 sound/soc/sof/intel/hda.h                                       |    4 
 sound/soc/sof/ipc3-pcm.c                                        |    3 
 sound/soc/sof/ipc3.c                                            |    4 
 sound/soc/sof/mediatek/mt8186/mt8186.c                          |    2 
 sound/soc/sof/mediatek/mt8195/mt8195.c                          |    2 
 sound/soc/sof/ops.h                                             |    8 
 sound/soc/sof/pcm.c                                             |    2 
 sound/soc/sof/sof-priv.h                                        |   13 
 sound/soc/sof/stream-ipc.c                                      |   57 
 sound/soc/sti/uniperif_player.c                                 |    9 
 sound/soc/stm/stm32_sai_sub.c                                   |    3 
 sound/usb/6fire/chip.c                                          |   17 
 sound/usb/6fire/control.c                                       |   10 
 sound/usb/caiaq/control.c                                       |   52 
 sound/usb/caiaq/device.c                                        |   39 
 sound/usb/caiaq/input.c                                         |    2 
 sound/usb/endpoint.c                                            |    6 
 sound/usb/format.c                                              |    2 
 sound/usb/midi.c                                                |   21 
 sound/usb/misc/ua101.c                                          |   12 
 sound/usb/mixer.c                                               |   14 
 sound/usb/mixer_quirks.c                                        |   12 
 sound/usb/mixer_scarlett2.c                                     |    2 
 sound/usb/quirks.c                                              |    4 
 sound/usb/stream.c                                              |   62 
 sound/usb/stream.h                                              |    3 
 tools/accounting/getdelays.c                                    |   41 
 tools/accounting/procacct.c                                     |   40 
 tools/include/uapi/linux/bpf.h                                  |    2 
 tools/lib/bpf/relo_core.c                                       |    2 
 tools/perf/util/branch.h                                        |    3 
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c                 |   51 
 tools/perf/util/expr.c                                          |    3 
 tools/perf/util/util.h                                          |    1 
 tools/testing/ktest/ktest.pl                                    |   37 
 tools/testing/selftests/bpf/prog_tests/snprintf.c               |    3 
 tools/testing/selftests/cgroup/test_memcontrol.c                |   11 
 tools/testing/selftests/mqueue/setting                          |    1 
 tools/testing/selftests/mqueue/settings                         |    1 
 tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh     |    1 
 tools/testing/selftests/vm/migration.c                          |    3 
 virt/kvm/dirty_ring.c                                           |    3 
 846 files changed, 8633 insertions(+), 4119 deletions(-)

Aaro Koskinen (2):
      USB: omap_udc: DMA: Don't enable burst 4 mode
      ARM: OMAP1: Fix DEBUG_LL and earlyprintk on OMAP16XX

Aaron Sacks (1):
      KVM: Reject wrapped offset in kvm_reset_dirty_gfn()

Abd-Alrhman Masalkhi (1):
      media: vidtv: fix pass-by-value structs causing MSAN warnings

Abdun Nihaal (3):
      media: pci: zoran: fix potential memory leak in zoran_probe()
      mfd: mc13xxx-core: Fix memory leak in mc13xxx_add_subdevice_pdata()
      net: wwan: iosm: fix potential memory leaks in ipc_imem_init()

Abdurrahman Hussain (10):
      hwmon: (pmbus/adm1266) widen blackbox-info buffer to I2C_SMBUS_BLOCK_MAX
      hwmon: (pmbus/adm1266) seed timestamp from the real-time clock
      hwmon: (pmbus/adm1266) reject implausible blackbox record_count
      hwmon: (pmbus/adm1266) include PEC byte in pmbus_block_xfer read buffer
      hwmon: (pmbus/adm1266) bounce blackbox records through a protocol-sized buffer
      hwmon: (pmbus/adm1266) cap PDIO scan in get_multiple at ADM1266_PDIO_NR
      hwmon: (pmbus/adm1266) don't clobber GPIO bits before PDIO read in get_multiple
      hwmon: (pmbus/adm1266) register the gpio_chip after pmbus_do_probe()
      hwmon: (pmbus/adm1266) register the nvmem device after pmbus_do_probe()
      hwmon: (pmbus/adm1266) reject short block-read responses in the GPIO accessors

Abhishek Kumar (1):
      media: em28xx: fix use-after-free in em28xx_v4l2_open()

Aditya Garg (1):
      net: mana: validate rx_req_idx to prevent out-of-bounds array access

Agalakov Daniil (1):
      e1000: check return value of e1000_read_eeprom

Akari Tsuyukusa (2):
      arm64: dts: mediatek: mt6795: Fix gpio-ranges pin count
      arm64: dts: mediatek: mt7986a: Fix gpio-ranges pin count

Akhil P Oommen (1):
      drm/msm/a6xx: Use barriers while updating HFI Q headers

Alex Deucher (4):
      drm/radeon: add missing revision check for CI
      drm/amdgpu/pm: add missing revision check for CI
      drm/amdgpu/pm: align Hawaii mclk workaround with radeon
      drm/amdgpu/gfx10: look at the right prop for gfx queue priority

Alexander Konyukhov (1):
      drm/komeda: fix integer overflow in AFBC framebuffer size check

Alexander Koskovich (3):
      media: i2c: ov8856: free control handler on error in ov8856_init_controls()
      drm/msm/dsi: rename MSM8998 DSI version from V2_2_0 to V2_0_0
      arm64: dts: qcom: sm8250: Add missing CPU7 3.09GHz OPP

Alexandre Demers (1):
      drm/amdgpu: fix spelling typos

Alexey Kodanev (1):
      nfp: fix swapped arguments in nfp_encode_basic_qdr() calls

Alexey Velichayshiy (1):
      wifi: rtw89: phy: fix uninitialized variable access in rtw89_phy_cfo_set_crystal_cap()

Alice Mikityanska (1):
      l2tp: Drop large packets with UDP encap

Allison Henderson (1):
      net/rds: reset op_nents when zerocopy page pin fails

Alok Tiwari (2):
      soc: qcom: llcc: fix v1 SB syndrome register offset
      soc: qcom: aoss: compare against normalized cooling state

Alysa Liu (1):
      drm/amdkfd: validate SVM ioctl nattr against buffer size

Amit Kumar Mahapatra (1):
      mtd: spi-nor: sst: Fix SST write failure

Anderson Nascimento (1):
      rxrpc: Fix missing validation of ticket length in non-XDR key preparsing

Andrea Mayer (2):
      seg6: fix seg6 lwtunnel output redirect for L2 reduced encap mode
      net: ipv6: fix NOREF dst use in seg6 and rpl lwtunnels

Andreas Gruenbacher (3):
      gfs2: Call unlock_new_inode before d_instantiate
      gfs2: add some missing log locking
      gfs2: prevent NULL pointer dereference during unmount

Andreas Haarmann-Thiemann (1):
      net: ethernet: cortina: Drop half-assembled SKB

Andrew Price (2):
      gfs2: Improve gfs2_consist_inode() usage
      gfs2: Validate i_depth for exhash directories

Andrii Kovalchuk (1):
      ALSA: hda/realtek: Add HP ENVY Laptop 13-ba0xxx quirk

André Draszik (2):
      scsi: ufs: core: Fix use-after free in init error and remove paths
      power: supply: max17042: avoid overflow when determining health

Andy Shevchenko (8):
      pinctrl: intel: Fix the revision for new features (1kOhm PD, HW debouncer)
      fbdev: matroxfb: Mark variable with __maybe_unused to avoid W=1 build break
      pinctrl: cy8c95x0: remove duplicate error message
      pinctrl: cy8c95x0: Unify messages with help of dev_err_probe()
      pinctrl: cy8c95x0: Avoid returning positive values to user space
      driver core: Move dev_err_probe() to where it belogs
      nfs/blocklayout: Fix compilation error (`make W=1`) in bl_write_pagelist()
      gpiolib: cdev: use !mem_is_zero() instead of memchr_inv(s, 0, n)

AnishMulay (1):
      selftests/mm: skip migration tests if NUMA is unavailable

Anthony Pighin (Nokia) (1):
      rtc: abx80x: Disable alarm feature if no interrupt attached

Ao Zhou (1):
      net: rds: fix MR cleanup on copy error

Arjan van de Ven (1):
      drm/amdgpu: fix zero-size GDS range init on RDNA4

Arnaldo Carvalho de Melo (1):
      perf util: Kill die() prototype, dead for a long time

Arnd Bergmann (4):
      media: rkvdec: reduce stack usage in rkvdec_init_v4l2_vp9_count_tbl()
      ALSA: asihpi: avoid write overflow check warning
      tpm: avoid -Wunused-but-set-variable
      clk: qoriq: avoid format string warning

Arthur Husband (1):
      ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585

Arınç ÜNAL (1):
      net: dsa: mt7530: rename mt753x_bpdu_port_fw enum to mt753x_to_cpu_fw

Ashutosh Desai (1):
      drm/gem: Fix inconsistent plane dimension calculation in drm_gem_fb_init_with_funcs()

Asim Viladi Oglu Manizada (1):
      smb: client: reject userspace cifs.spnego descriptions

Bae Yeonju (1):
      fs/adfs: validate nzones in adfs_validate_bblk()

Bart Van Assche (3):
      drbd: Balance RCU calls in drbd_adm_dump_devices()
      locking: Fix rwlock support in <linux/spinlock_up.h>
      ice: fix locking in ice_dcb_rebuild()

Bartosz Golaszewski (2):
      device property: set fwnode->secondary to NULL in fwnode_init()
      gpio: cdev: check if uAPI v2 config attributes are correctly zeroed

Ben Morris (1):
      sctp: revalidate list cursor after sctp_sendmsg_to_asoc() in SCTP_SENDALL

Bence Csókás (1):
      mtd: spi-nor: sst: Factor out common write operation to `sst_nor_write_data()`

Beniamino Galvani (4):
      ipv4: rename and move ip_route_output_tunnel()
      ipv4: remove "proto" argument from udp_tunnel_dst_lookup()
      ipv4: add new arguments to udp_tunnel_dst_lookup()
      ipv6: rename and move ip6_dst_lookup_tunnel()

Benjamin Cheng (6):
      drm/amdgpu: Add bounds checking to ib_{get,set}_value
      drm/amdgpu/vce: Prevent partial address patches
      drm/amdgpu/vcn4: Prevent OOB reads when parsing dec msg
      drm/amdgpu/vcn3: Prevent OOB reads when parsing dec msg
      drm/amdgpu/vcn3: Avoid overflow on msg bound check
      drm/amdgpu/vcn4: Avoid overflow on msg bound check

Benoît Sevens (1):
      HID: roccat: fix use-after-free in roccat_report_event

Berk Cem Goksel (2):
      ALSA: 6fire: fix use-after-free on disconnect
      ALSA: caiaq: take a reference on the USB device in create_card()

Billy Tsai (1):
      i3c: mipi-i3c-hci: fix IBI payload length calculation for final status

Bin Liu (1):
      mmc: block: use single block write in retry

Breno Leitao (4):
      mm: blk-cgroup: fix use-after-free in cgwb_release_workfn()
      tracing: branch: Fix inverted check on stat tracer registration
      netconsole: propagate device name truncation in dev_name_store()
      netconsole: avoid out-of-bounds access on empty string in trim_newline()

Brian Masney (2):
      irqchip/irq-pic32-evic: Address warning related to wrong printf() formatter
      clk: visconti: pll: initialize clk_init_data to zero

Cai Xinchen (2):
      dpaa2: add independent dependencies for FSL_DPAA2_SWITCH
      dpaa2: compile dpaa2 even CONFIG_FSL_DPAA2_ETH=n

Cen Zhang (2):
      Bluetooth: btintel: serialize btintel_hw_error() with hci_req_sync_lock
      f2fs: add READ_ONCE() for i_blocks in f2fs_update_inode()

Chaitanya Kulkarni (1):
      nvmet: avoid recursive nvmet-wq flush in nvmet_ctrl_free

Chaitanya Kumar Borah (1):
      drm/i915/dp: Fix VSC dynamic range signaling for RGB formats

Chao Yu (1):
      f2fs: fix to detect potential corrupted nid in free_nid_list

Chen Ni (4):
      media: i2c: imx219: Check return value of devm_gpiod_get_optional() in imx219_probe()
      mtd: physmap_of_gemini: Fix disabled pinctrl state check
      backlight: sky81452-backlight: Check return value of devm_gpiod_get_optional() in sky81452_bl_parse_dt()
      leds: lgm-sso: Remove duplicate assignments for priv->mmap

Chen Zhao (1):
      IB/core: Fix zero dmac race in neighbor resolution

Chen-Yu Tsai (1):
      PCI: mediatek-gen3: Prevent leaking IRQ domains when IRQ not found

Chenguang Zhao (1):
      ethtool: fix ethnl_bitmap32_not_zero() bit interval semantics

Chia-Ming Chang (2):
      md/raid5: fix soft lockup in retry_aligned_read()
      inotify: fix watch count leak when fsnotify_add_inode_mark_locked() fails

Chih Kai Hsu (1):
      r8152: fix incorrect register write to USB_UPHY_XTAL

Christian A. Ehrhardt (1):
      ASoC: codecs: ab8500: Fix casting of private data

Christian König (1):
      drm/amdgpu: remove two invalid BUG_ON()s

Christoph Hellwig (1):
      arm64/xor: fix conflicting attributes for xor_block_template

Christophe JAILLET (1):
      f2fs: Use sysfs_emit_at() to simplify code

Chuyi Zhou (1):
      padata: Remove cpu online check from cpu add and removal

Cole Leavitt (2):
      pstore/ram: fix resource leak when ioremap() fails
      soundwire: bus: demote UNATTACHED state warnings to dev_dbg()

Conor Dooley (1):
      clk: microchip: mpfs-ccc: fix out of bounds access during output registration

Corey Minyard (3):
      ipmi: Add limits to event and receive message requests
      ipmi: Check event message buffer response for bad data
      ipmi:si: Return state to normal if message allocation fails

Cosmin Tanislav (2):
      mtd: parsers: ofpart: call of_node_put() only in ofpart_fail path
      mtd: parsers: ofpart: call of_node_get() for dedicated subpartitions

Cryolitia PukNgae (1):
      ALSA: usb-audio: apply quirk for MOONDROP JU Jiu

Cássio Gabriel (16):
      ALSA: usb-audio: stop parsing UAC2 rates at MAX_NR_RATES
      ALSA: usb-audio: Avoid false E-MU sample-rate notifications
      ALSA: usb-audio: Fix Audio Advantage Micro II SPDIF switch
      ALSA: aoa: i2sbus: fix OF node lifetime handling
      ALSA: seq_oss: return full count for successful SEQ_FULLSIZE writes
      ALSA: caiaq: Fix control_put() result and cache rollback
      ALSA: 6fire: Fix input volume change detection
      ALSA: usb-audio: Fix UAC3 cluster descriptor size check
      ALSA: firewire-tascam: Do not drop unread control events
      ASoC: Intel: bytcr_wm5102: Fix MCLK leak on platform_clock_control error
      ALSA: core: Validate compress device numbers without dynamic minors
      ASoC: SOF: compress: return the configured codec from get_params
      ALSA: sc6000: Keep the programmed board state in card-private data
      ALSA: core: Serialize deferred fasync state checks
      ALSA: usb-audio: Bound MIDI endpoint descriptor scans
      ALSA: ua101: Reject too-short USB descriptors

César Montoya (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Pavilion 15-eg0xxx

Daan De Meyer (1):
      cdrom, scsi: sr: propagate read-only status to block layer via set_disk_ro()

DaeMyung Kang (2):
      smb: server: fix max_connections off-by-one in tcp accept path
      ksmbd: destroy tree_conn_ida in ksmbd_session_destroy()

Daniel Baluta (3):
      ASoC: SOF: Prepare ipc_msg_data to be used with compress API
      ASoC: SOF: Prepare set_stream_data_offset for compress API
      ASoC: SOF: Add support for compress API for stream data/offset

Daniel Borkmann (2):
      bpf, arm64: Fix off-by-one in check_imm signed range check
      bpf: Fix precedence bug in convert_bpf_ld_abs alignment check

Daniel Brát (1):
      usb: storage: Expand range of matched versions for VL817 quirks entry

Daniel Golle (4):
      selftests: net: bridge_vlan_mcast: wait for h1 before querier check
      net: dsa: mt7530: sync driver-specific behavior of MT7531 variants
      net: dsa: mt7530: fix FDB entries not aging out with short timeout
      net: dsa: mt7530: preserve VLAN tags on trapped link-local frames

Daniel Hodges (1):
      ima: check return value of crypto_shash_final() in boot aggregate

Daniel Jordan (1):
      padata: Put CPU offline callback in ONLINE section to allow failure

Danilo Krummrich (1):
      devres: fix missing node debug info in devm_krealloc()

Darrick J. Wong (1):
      fuse: quiet down complaints in fuse_conn_limit_write

Dave Carey (1):
      USB: cdc-acm: Add quirks for Yoga Book 9 14IAH10 INGENIC touchscreen

David Carlier (3):
      bpf: Use RCU-safe iteration in dev_map_redirect_multi() SKB path
      Bluetooth: ISO: drop ISO_END frames received without prior ISO_START
      tracing: Avoid NULL return from hist_field_name() on truncation

David Gow (2):
      kunit: config: Enable KUNIT_DEBUGFS by default
      kunit: config: KUNIT_DEBUGFS should depend on DEBUG_FS

David Heidelberg (1):
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Mark l1a regulator as powered during boot

David Howells (4):
      rxrpc: Fix key quota calculation for multitoken keys
      rxrpc: Fix call removal to use RCU safe deletion
      rxrpc: Fix recvmsg() unconditional requeue
      rxrpc: Fix anonymous key handling

David Lechner (1):
      iio: adc: ti-ads7950: use iio_push_to_buffers_with_ts_unaligned()

David Woodhouse (2):
      KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI structures with VLAs
      KVM: arm64: vgic: Fix IIDR revision field extracted from wrong value

Dawei Feng (2):
      rbd: fix null-ptr-deref when device_add_disk() fails
      qed: fix double free in qed_cxt_tables_alloc()

Dawei Li (1):
      soc: qcom: apr: make remove callback of apr driver void returned

Deepanshu Kartikey (6):
      nilfs2: fix NULL i_assoc_inode dereference in nilfs_mdt_save_to_shadow_map
      ocfs2: validate inline data i_size during inode read
      ALSA: caiaq: fix usb_dev refcount leak on probe failure
      nilfs2: reject zero bd_oblocknr in nilfs_ioctl_mark_blocks_dirty()
      wifi: mac80211: check tdls flag in ieee80211_tdls_oper
      drm/virtio: use uninterruptible resv lock for plane updates

Denis Benato (2):
      HID: asus: make asus_resume adhere to linux kernel coding standards
      HID: asus: do not abort probe when not necessary

Denis M. Karpov (1):
      userfaultfd: allow registration of ranges below mmap_min_addr

Dmitry Antipov (1):
      ocfs2: add inline inode consistency check to ocfs2_validate_inode_block()

Dmitry Baryshkov (5):
      soc: qcom: ocmem: register reasons for probe deferrals
      soc: qcom: ocmem: return -EPROBE_DEFER is ocmem is not available
      clk: qcom: dispcc-sm8450: use RCG2 ops for DPTX1 AUX clock source
      drm/msm/dsi: don't dump registers past the mapped region
      drm/msm/snapshot: fix dumping of the unaligned regions

Dong Chenchen (1):
      net: Fix icmp host relookup triggering ip_rt_bug

Doug Berger (3):
      net: bcmgenet: add bcmgenet_has_* helpers
      net: bcmgenet: move DESC_INDEX flow to ring 0
      net: bcmgenet: support reclaiming unsent Tx packets

Douglas Anderson (4):
      regset: use kvzalloc() for regset_get_alloc()
      device property: Make modifications of fwnode "flags" thread safe
      driver core: Don't let a device probe until it's ready
      driver core: Add kernel-doc for DEV_FLAG_COUNT enum value

Dudu Lu (3):
      vsock/virtio: fix accept queue count leak on transport mismatch
      Bluetooth: l2cap: Add missing chan lock in l2cap_ecred_reconf_rsp
      net/sched: sch_cake: fix NAT destination port not being updated in cake_update_flowkeys

Duoming Zhou (1):
      wifi: rtlwifi: pci: fix possible use-after-free caused by unfinished irq_prepare_bcn_tasklet

Dustin L. Howett (1):
      ALSA: hda/realtek: add quirk for Framework F111:000F

Eric Biggers (3):
      crypto: arm64/aes - Fix 32-bit aes_mac_update() arg treated as 64-bit
      dm-verity-fec: correctly reject too-small FEC devices
      dm-verity-fec: correctly reject too-small hash devices

Eric Dumazet (22):
      net: lapbether: handle NETDEV_PRE_TYPE_CHANGE
      net: add proper RCU protection to /proc/net/ptype
      net: sched: fix TCF_LAYER_TRANSPORT handling in tcf_get_base_ptr()
      macvlan: annotate data-races around port->bc_queue_len_used
      tcp: preserve const qualifier in tcp_sk()
      tcp: add data-race annotations around tp->data_segs_out and tp->total_retrans
      tcp: annotate data-races around tp->bytes_sent
      tcp: annotate data-races around tp->bytes_retrans
      tcp: annotate data-races around tp->dsack_dups
      tcp: annotate data-races around (tp->write_seq - tp->snd_nxt)
      ipv6: fix possible UAF in icmpv6_rcv()
      net_sched: sch_hhf: annotate data-races in hhf_dump_stats()
      net/sched: sch_pie: annotate data-races in pie_dump_stats()
      net/sched: sch_fq_codel: remove data-races from fq_codel_dump_stats()
      net/sched: sch_red: annotate data-races in red_dump_stats()
      net/sched: sch_sfb: annotate data-races in sfb_dump_stats()
      net/sched: sch_choke: annotate data-races in choke_dump_stats()
      net/sched: sch_fq_pie: annotate data-races in fq_pie_dump_stats()
      neighbour: add RCU protection to neigh_tables[]
      net/sched: sch_cake: annotate data-races in cake_dump_stats() (V)
      bonding: 3ad: implement proper RCU rules for port->aggregator
      net/sched: sch_pie: annotate more data-races in pie_dump_stats()

Erni Sri Satya Vennela (1):
      net: mana: Fix TOCTOU double-fetch of hwc_msg_id from DMA buffer

Ethan Nelson-Moore (1):
      net: ethernet: cs89x0: remove stale CONFIG_MACH_MX31ADS reference

Ethan Tidmore (4):
      wifi: brcmfmac: Fix error pointer dereference
      drm/sun4i: backend: fix error pointer dereference
      drm/sun4i: Fix resource leaks
      pinctrl: pinctrl-pic32: Fix resource leak

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FN990A MBIM composition
      USB: serial: option: add Telit Cinterion LE910Cx compositions

Fedor Pchelkin (3):
      wifi: rtw88: check for PCI upstream bridge existence
      nvme-apple: drop invalid put of admin queue reference count
      platform/x86: dell_rbu: avoid uninit value usage in packet_size_write()

Felix Fietkau (1):
      wifi: mac80211: always free skb on ieee80211_tx_prepare_skb() failure

Felix Gu (8):
      spi: meson-spicc: Fix double-put in remove path
      usb: ulpi: fix memory leak on ulpi_register() error paths
      spi: fsl-qspi: Use reinit_completion() for repeated operations
      pmdomain: ti: omap_prm: Fix a reference leak on device node
      pmdomain: imx: scu-pd: Fix device_node reference leak during ->probe()
      clk: imx: imx6q: Fix device node reference leak in pll6_bypassed()
      clk: imx: imx6q: Fix device node reference leak in of_assigned_ldb_sels()
      spi: mtk-snfi: Fix resource leak in mtk_snand_read_page_cache()

Feng Yang (1):
      bpf: test_run: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap

Fernando Fernandez Mancera (2):
      netfilter: nfnetlink_osf: fix out-of-bounds read on option matching
      netfilter: nfnetlink_osf: fix potential NULL dereference in ttl check

Filipe Manana (1):
      btrfs: tracepoints: fix sleep while in atomic context in btrfs_sync_file()

Florian Fainelli (2):
      net: bcmgenet: Remove TX ring full logging
      net: bcmgenet: Remove custom ndo_poll_controller()

Florian Westphal (9):
      netfilter: nft_set_pipapo_avx2: don't return non-matching entry on expiry
      netfilter: conntrack: add missing netlink policy validations
      netfilter: xt_socket: enable defrag after all other checks
      netfilter: nft_fwd_netdev: check ttl/hl before forwarding
      RDMA/core: Prefer NLA_NUL_STRING
      netfilter: conntrack: remove sprintf usage
      netfilter: nf_conntrack_sip: don't use simple_strtoul
      neigh: let neigh_xmit take skb ownership
      netfilter: x_tables: unregister the templates first

Frank Li (2):
      PCI: Add PCIE_PME_TO_L2_TIMEOUT_US L2 ready timeout value
      dmaengine: mxs-dma: Fix missing return value from of_dma_controller_register()

Fredric Cover (1):
      fs/smb/client: fix out-of-bounds read in cifs_sanitize_prepath

Gabor Juhos (1):
      phy: marvell: mvebu-a3700-utmi: fix incorrect USB2_PHY_CTRL register access

Gang Yan (2):
      mptcp: sockopt: set timestamp flags on subflow socket, not msk
      mptcp: fix scheduling with atomic in timestamp sockopt

Gao Xiang (1):
      erofs: fix the out-of-bounds nameoff handling for trailing dirents

Geert Uytterhoeven (2):
      clk: xgene: Fix mapping leak in xgene_pllclk_init()
      lib/hexdump: print_hex_dump_bytes() calls print_hex_dump_debug()

George Saad (1):
      f2fs: fix use-after-free of sbi in f2fs_compress_write_end_io()

Gerd Bayer (1):
      PCI: Enable AtomicOps only if Root Port supports them

Gilson Marquato Júnior (1):
      ASoC: amd: yc: Add DMI entry for HP Laptop 15-fc0xxx

Goldwyn Rodrigues (1):
      btrfs: tracepoints: get correct superblock from dentry in event btrfs_sync_file()

Gopi Krishna Menon (1):
      thermal/drivers/spear: Fix error condition for reading st,thermal-flags

Greg Jumper (1):
      net/rds: Restrict use of RDS/IB to the initial network namespace

Greg Kroah-Hartman (27):
      xfrm_user: fix info leak in build_mapping()
      i2c: s3c24xx: check the size of the SMBUS message before using it
      HID: alps: fix NULL pointer dereference in alps_raw_event()
      HID: core: clamp report_size in s32ton() to avoid undefined shift
      net: usb: cdc-phonet: fix skb frags[] overflow in rx_complete()
      NFC: digital: Bounds check NFC-A cascade depth in SDD response handler
      drm/vc4: platform_get_irq_byname() returns an int
      ALSA: fireworks: bound device-supplied status before string array lookup
      fbdev: tdfxfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
      usb: gadget: f_ncm: validate minimum block_len in ncm_unwrap_ntb()
      usb: gadget: f_phonet: fix skb frags[] overflow in pn_rx_complete()
      usb: gadget: renesas_usb3: validate endpoint index in standard request handlers
      ksmbd: validate EaNameLength in smb2_get_ea()
      ksmbd: require 3 sub-authorities before reading sub_auth[2]
      fbdev: udlfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
      fs/ntfs3: validate rec->used in journal-replay file record check
      drm/nouveau: fix u32 overflow in pushbuf reloc bounds check
      ipv6: rpl: reserve mac_len headroom when recompressed SRH grows
      scsi: target: configfs: Bound snprintf() return in tg_pt_gp_members_show()
      usb: usblp: fix heap leak in IEEE 1284 device ID via short response
      usb: usblp: fix uninitialized heap leak via LPGETSTATUS ioctl
      driver core: device.h: remove extern from function prototypes
      container_of: remove container_of_safe()
      container_of: add container_of_const() that preserves const-ness of the pointer
      smb: client: fix OOB reads parsing symlink error response
      sysfs: don't remove existing directory on update failure
      Linux 6.1.175

Guangshuo Li (3):
      ACPI: scan: Use acpi_dev_put() in object add error paths
      btrfs: fix double free in create_space_info() error path
      RDMA/rtrs: Fix use-after-free in path file creation cleanup

Guenter Roeck (1):
      ARM: integrator: Fix early initialization

Gui-Dong Han (1):
      debugfs: check for NULL pointer in debugfs_create_str()

Guillaume Gonnet (1):
      dm init: ensure device probing has finished in dm-mod.waitfor=

Guocai He (1):
      Revert "wifi: cfg80211: stop NAN and P2P in cfg80211_leave"

Gustavo Sousa (1):
      drm/i915: Extract intel_dbuf_mdclk_cdclk_ratio_update()

Gyeyoung Baek (1):
      drm/panfrost: Fix wait_bo ioctl leaking positive return from dma_resv_wait_timeout()

Haibo Chen (1):
      mtd: spi-nor: core: correct the op.dummy.nbytes when check read operations

Hamza Mahfooz (1):
      hv_sock: fix ARM64 support

Hangbin Liu (4):
      bonding: return detailed error when loading native XDP fails
      bonding: add support for per-port LACP actor priority
      bonding: print churn state via netlink
      bonding: fix NULL pointer dereference in actor_port_prio setting

Haoxiang Li (2):
      crypto: ccree - fix a memory leak in cc_mac_digest()
      media: omap3isp: drop the use count of v4l2 pipeline

Haoyu Lu (1):
      ACPI: AGDI: fix missing newline in error message

Haoze Xie (1):
      netfilter: nf_queue: hold bridge skb->dev while queued

Harin Lee (2):
      ALSA: ctxfi: Limit PTP to a single page
      ALSA: ctxfi: Add fallback to default RSR for S/PDIF

Harry Wentland (3):
      drm/amd/display: Fix integer overflow in bios_get_image()
      drm/amd/display: Validate GPIO pin LUT table size before iterating
      drm/amd/display: Validate payload length and link_index in dc_process_dmub_aux_transfer_async

Heiko Schocher (1):
      net: phy: dp83869: fix setting CLK_O_SEL field.

Helge Deller (1):
      parisc: _llseek syscall is only available for 32-bit userspace

Heming Zhao (1):
      ocfs2: split transactions in dio completion to avoid credit exhaustion

Herbert Xu (4):
      padata: Fix pd UAF once and for all
      padata: Remove comment for reorder_work
      crypto: pcrypt - Fix handling of MAY_BACKLOG requests
      crypto: af_alg - Cap AEAD AD length to 0x80000000

Hongling Zeng (1):
      parisc: Fix IRQ leak in LASI driver

Huacai Chen (3):
      LoongArch: Show CPU vulnerabilites correctly
      LoongArch: Use per-root-bridge PCIH flag to skip mem resource fixup
      LoongArch: Remove unused code to avoid build warning

HyungJung Joo (1):
      fs/omfs: reject s_sys_blocksize smaller than OMFS_DIR_START

Hyunwoo Kim (1):
      ksmbd: scope conn->binding slowpath to bound sessions only

Håkon Bugge (1):
      net/rds: Optimize rds_ib_laddr_check

Ian Rogers (1):
      perf branch: Avoid incrementing NULL

Ido Schimmel (2):
      vrf: Fix a potential NPD when removing a port from a VRF
      bridge: mcast: Fix a possible use-after-free when removing a bridge port

Ilya Maximets (1):
      openvswitch: vport: fix self-deadlock on release of tunnel ports

Jacob Keller (1):
      ice: Pull common tasks into ice_vf_post_vsi_rebuild

Jacqueline Wong (1):
      tpm: tpm_tis: add error logging for data transfer

Jakub Kicinski (3):
      net: tls: fix strparser anchor skb leak on offload RX setup failure
      net: tls: fix off-by-one in sg_chain entry count for wrapped sk_msg ring
      net: tls: prevent chain-after-chain in plain text SG

Jamal Hadi Salim (2):
      net/sched: sch_red: Replace direct dequeue call with peek and qdisc_dequeue_peeked
      net/sched: act_ct: Only release RCU read lock after ct_ft

James Kim (1):
      mtd: docg3: fix use-after-free in docg3_release()

Jan Kara (1):
      quota: Fix race of dquot_scan_active() with quota deactivation

Jane Chu (1):
      Documentation: fix a hugetlbfs reservation statement

Jani Nikula (1):
      string: add mem_is_zero() helper to check if memory area is all zeros

Jann Horn (2):
      exit: prevent preemption of oopsing TASK_DEAD task
      Bluetooth: bnep: Fix UAF read of dev->name

Jason Gunthorpe (4):
      RDMA/hns: Fix unlocked call to hns_roce_qp_remove()
      RDMA/mlx4: Fix resource leak on error in mlx4_ib_create_srq()
      RDMA/ocrdma: Don't NULL deref uctx on errors in ocrdma_copy_pd_uresp()
      RDMA/vmw_pvrdma: Fix double free on pvrdma_alloc_ucontext() error path

Jens Axboe (2):
      io_uring/poll: ensure EPOLL_ONESHOT is propagated for EPOLL_URING_WAKE
      io_uring/poll: fix multishot recv missing EOF on wakeup race

Jeongjun Park (4):
      ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free
      media: as102: fix to not free memory after the device is registered in as102_usb_probe()
      media: hackrf: fix to not free memory after the device is registered in hackrf_probe()
      wifi: rsi: fix kthread lifetime race between self-exit and external-stop

Jesse.Zhang (1):
      drm/amdgpu: Limit BO list entry count to prevent resource exhaustion

Jianpeng Chang (1):
      net: enetc: fix the deadlock of enetc_mdio_lock

Jiayuan Chen (4):
      bpf: Drop task_to_inode and inet_conn_established from lsm sleepable hooks
      net, bpf: fix null-ptr-deref in xdp_master_redirect() for down master
      nexthop: fix IPv6 route referencing IPv4 nexthop
      irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT

Jiexun Wang (4):
      af_unix: read UNIX_DIAG_VFS data under unix_state_lock
      batman-adv: reject new tp_meter sessions during teardown
      batman-adv: stop caching unowned originator pointers in BAT IV
      netfilter: xt_policy: fix strict mode inbound policy matching

Jinjie Ruan (1):
      ACPI: CPPC: Fix related_cpus inconsistency during CPU hotplug

Jiri Slaby (SUSE) (2):
      wifi: ath5k: do not access array OOB
      6pack: propagage new tty types

Johan Hovold (18):
      rtc: ntxec: fix OF node reference imbalance
      can: ucan: fix devres lifetime
      spi: rockchip: fix controller deregistration
      spi: zynqmp-gqspi: fix controller deregistration
      staging: vme_user: fix root device leak on init failure
      spi: topcliff-pch: fix use-after-free on unbind
      regulator: max77650: fix OF node reference imbalance
      regulator: act8945a: fix OF node reference imbalance
      regulator: bd9571mwv: fix OF node reference imbalance
      spi: mtk-nor: fix controller deregistration
      spi: imx: fix runtime pm leak on probe deferral
      spi: orion: fix clock imbalance on registration failure
      spi: mpc52xx: fix use-after-free on unbind
      drm/gma500/oaktrail_hdmi: fix i2c adapter leak on setup
      drm/gma500/oaktrail_lvds: fix hang on init failure
      drm/gma500/oaktrail_lvds: fix i2c adapter leaks on init
      spi: sprd: fix error pointer deref after DMA setup failure
      spi: ti-qspi: fix use-after-free after DMA setup failure

Johannes Berg (1):
      wifi: iwlwifi: read txq->read_ptr under lock

John B. Moore (2):
      drm/amdgpu/gfx9: drop unnecessary 64-bit fence flag check in KIQ
      drm/amdgpu/sdma4: replace BUG_ON with WARN_ON in fence emission

John Madieu (1):
      spi: rockchip: Read ISR, not IMR, to detect cs-inactive IRQ

John Walker (1):
      wifi: cfg80211: advance loop vars in cfg80211_merge_profile()

Jon Hunter (1):
      dt-bindings: net: Fix Tegra234 MGBE PTP clock

Jonas Gorski (1):
      mtd: spi-nor: update spi_nor_fixups::post_sfdp() documentation

Jonathan Rissanen (1):
      Bluetooth: hci_ldisc: Clear HCI_UART_PROTO_INIT on error

Jonathan Santos (1):
      iio: adc: ad7768-1: fix one-shot mode data acquisition

Jones Syue 薛懷宗 (1):
      bonding: 802.3ad replace MAC_ADDRESS_EQUAL with __agg_has_partner

Joseph Qi (2):
      ocfs2: fix possible deadlock between unlink and dio_end_io_write
      ocfs2: fix out-of-bounds write in ocfs2_write_end_inline

Joseph Salisbury (1):
      ASoC: fsl_easrc: fix comment typo

Josh Hunt (1):
      md/raid10: fix deadlock with check operation and nowait requests

Josh Law (1):
      lib/ts_kmp: fix integer overflow in pattern length calculation

Joshua Klinesmith (1):
      ksmbd: fix use-after-free from async crypto on Qualcomm crypto engine

Jouni Högander (1):
      drm/i915/psr: Do not use pipe_src as borders for SU area

Julien Chauveau (1):
      drm/bridge: it66121: acquire reset GPIO in probe

Jun Yan (1):
      arm64: dts: meson-gxl-p230: fix ethernet PHY interrupt number

Junrui Luo (9):
      staging: sm750fb: fix division by zero in ps_to_hz()
      md/raid5: validate payload size before accessing journal metadata
      dm mirror: fix integer overflow in create_dirty_log()
      md/raid10: fix divide-by-zero in setup_geo() with zero far_copies
      dm log: fix out-of-bounds write due to region_count overflow
      ocfs2/dlm: validate qr_numregions in dlm_match_regions()
      ocfs2/dlm: fix off-by-one in dlm_match_regions() region comparison
      scsi: target: core: Fix integer overflow in UNMAP bounds check
      KVM: s390: pci: fix GAIT table indexing due to double-scaling pointer arithmetic

Junxi Qian (1):
      nfc: llcp: add missing return after LLCP_CLOSED checks

Justin Chen (3):
      net: bcmgenet: fix off-by-one in bcmgenet_put_txcb
      net: bcmgenet: fix racing timeout handler
      net: bcmgenet: fix leaking free_bds

Kai Ma (1):
      netfilter: reject zero shift in nft_bitwise

Kai Zen (1):
      net: rtnetlink: zero ifla_vf_broadcast to avoid stack infoleak in rtnl_fill_vfinfo

Keenan Dong (1):
      rtmutex: Use waiter::task instead of current in remove_waiter()

Keith Busch (1):
      nvme-pci: fix missed admin queue sq doorbell write

Kevin Cheng (1):
      KVM: SVM: Inject #UD for INVLPGA if EFER.SVME=0

Khairul Anuar Romli (1):
      dmaengine: dw-axi-dmac: Remove unnecessary return statement from void function

Kohei Enju (2):
      i40e: don't advertise IFF_SUPP_NOFCS
      vhost_net: fix sleeping with preempt-disabled in vhost_net_busy_poll()

Koichiro Den (3):
      PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
      PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
      PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown

Konrad Dybcio (3):
      arm64: dts: qcom: sm8450: Fix GIC_ITS range length
      dt-bindings: clock: qcom,dispcc-sc7180: Define MDSS resets
      clk: qcom: dispcc-sc7180: Add missing MDSS resets

Krishna Chomal (1):
      platform/x86: hp-wmi: Ignore backlight and FnLock events

Krzysztof Kozlowski (2):
      power: supply: axp288_charger: Do not cancel work before initializing it
      soc: qcom: ocmem: use scoped device node handling to simplify error paths

Kuninori Morimoto (1):
      ASoC: soc-core: call missing INIT_LIST_HEAD() for card_aux_list

Kuniyuki Iwashima (1):
      tcp: Fix imbalanced icsk_accept_queue count.

Kyle Farnung (1):
      wifi: ath11k: clear shared SRNG pointer state on restart

Lee Jones (1):
      tipc: fix double-free in tipc_buf_append()

Lei Huang (1):
      ALSA: hda/realtek: fix code style (ERROR: else should follow close brace '}')

Leo Yan (1):
      perf expr: Return -EINVAL for syntax error in expr__find_ids()

Leon Yen (1):
      wifi: mt76: mt7921: fix a potential clc buffer length underflow

Li Xiasong (2):
      netfilter: nf_conntrack_sip: get helper before allocating expectation
      netfilter: nft_ct: fix missing expect put in obj eval

Liang Jie (1):
      smb: client: correctly handle ErrorContextData as a flexible array

Lin YuChen (1):
      staging: rtl8723bs: initialize le_tmp64 in rtw_BIP_verify()

Linus Torvalds (1):
      security/keys: fix missed RCU read section on lookup

Linus Walleij (2):
      net: ethernet: cortina: Make RX SKB per-port
      net: ethernet: cortina: Carry over frag counter

Lizhe (1):
      drivers/spi-rockchip.c : Remove redundant variable slave

Long Li (1):
      PCI: hv: Set default NUMA node to 0 for devices without affinity info

Longxuan Yu (1):
      io_uring/poll: fix signed comparison in io_poll_get_ownership()

Luca Ceresoli (1):
      drm/arcpgu: fix device node leak

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Remove remaining dependencies of hci_request
      Bluetooth: L2CAP: Fix printing wrong information if SDU length exceeds MTU

Lukas Bulwahn (1):
      HID: quirks: really enable the intended work around for appledisplay

Lukas Wunner (1):
      PCI/AER: Stop ruling out unbound devices as error source

Luke D. Jones (1):
      ALSA: hda/realtek: Whitespace fix

Luxiao Xu (2):
      net: strparser: fix skb_head leak in strp_abort_strp()
      batman-adv: fix tp_meter counter underflow during shutdown

Lyes Bourennani (1):
      batman-adv: fix integer overflow on buff_pos

Ma Ke (1):
      powerpc/warp: Fix error handling in pika_dtm_thread

Maarten Lankhorst (1):
      Revert "drm: Fix use-after-free on framebuffers and property blobs when calling drm_dev_unplug"

Maciej Fijalkowski (1):
      xsk: tighten UMEM headroom validation to account for tailroom and min frame

Manikanta Maddireddy (3):
      PCI: tegra194: Increase LTSSM poll time on surprise link down
      PCI: tegra194: Disable LTSSM after transition to Detect on surprise link down
      PCI: tegra194: Disable PERST# IRQ only in Endpoint mode

Manivannan Sadhasivam (2):
      net: qrtr: ns: Fix use-after-free in driver remove()
      PCI: tegra194: Rename 'root_bus' to 'root_port_bus' in tegra_pcie_downstream_dev_to_D0()

Maoyi Xie (1):
      ip6_gre: Use cached t->net in ip6erspan_changelink().

Marcin Szycik (1):
      ice: fix setting promisc mode while adding VID filter

Marek Vasut (2):
      net: ks8851: Reinstate disabling of BHs around IRQ handler
      net: ks8851: Avoid excess softirq scheduling

Mario Limonciello (AMD) (1):
      firmware: dmi: Correct an indexing error in dmi.h

Mark Brown (1):
      ASoC: SOF: Don't allow pointer operations on unconfigured streams

Mark Harmstone (1):
      btrfs: fix double-decrement of bytes_may_use in submit_one_async_extent()

Mark Rutland (1):
      arm64: mm: fix VA-range sanity check

Masami Hiramatsu (Google) (1):
      tracing: Do not call map->ops->elt_free() if elt_alloc() fails

Mashiro Chen (1):
      net: hamradio: 6pack: fix uninit-value in sixpack_receive_buf

Matt Vollrath (2):
      e1000e: Unroll PTP in probe error handling
      i40e: Cleanup PTP pins on probe failure

Matthew Leach (1):
      wifi: ath11k: fix peer resolution on rx path when peer_id=0

Matthew Wood (1):
      net: netconsole: move newline trimming to function

Matthias Fend (1):
      media: i2c: ov08d10: fix image vertical start setting

Maulik Shah (1):
      pinctrl: qcom: Fix wakeirq map by removing disconnected irqs for sm8150

Maurizio Lombardi (1):
      nvmet-tcp: propagate nvmet_tcp_build_pdu_iovec() errors to its callers

Maíra Canal (4):
      drm/vc4: Release runtime PM reference after binding V3D
      drm/vc4: Fix memory leak of BO array in hang state
      drm/vc4: Fix a memory leak in hang state error path
      drm/vc4: Protect madv read in vc4_gem_object_mmap() with madv_lock

Michael Bommarito (19):
      smb: server: fix active_num_conn leak on transport allocation failure
      smb: client: require a full NFS mode SID before reading mode bits
      smb: client: fix OOB read in smb2_ioctl_query_info QUERY_INFO path
      um: drivers: call kernel_strrchr() explicitly in cow_user.c
      Bluetooth: virtio_bt: clamp rx length before skb_put
      Bluetooth: virtio_bt: validate rx pkt_type header length
      udf: reject descriptors with oversized CRC length
      isofs: validate Rock Ridge CE continuation extent against volume size
      isofs: validate block number from NFS file handle in isofs_export_iget
      RDMA/rxe: Reject unknown opcodes before ICRC processing
      sctp: fix OOB write to userspace in sctp_getsockopt_peer_auth_chunks
      net/rds: zero per-item info buffer before handing it to visitors
      Bluetooth: MGMT: validate Add Extended Advertising Data length
      net: ifb: report ethtool stats over num_tx_queues
      ipv4: raw: reject IP_HDRINCL packets with ihl < 5
      ixgbevf: fix use-after-free in VEPA multicast source pruning
      KVM: arm64: vgic-its: Reject restored DTE with out-of-range num_eventid_bits
      scsi: isci: Fix use-after-free in device removal path
      RDMA/siw: Reject MPA FPDU length underflow before signed receive math

Michal Grzedzicki (1):
      unshare: fix nsproxy leak in ksys_unshare() on set_cred_ucounts() failure

Michal Luczaj (3):
      bpf, sockmap: Fix af_unix iter deadlock
      bpf, sockmap: Fix af_unix null-ptr-deref in proto update
      bpf, sockmap: Take state lock for af_unix iter

Michal Pecio (1):
      usb: xhci: Make usb_host_endpoint.hcpriv survive endpoint_disable()

Michal Schmidt (1):
      ixgbevf: add missing negotiate_features op to Hyper-V ops table

Mieczyslaw Nalewaj (1):
      net: dsa: realtek: rtl8365mb: fix mode mask calculation

Mike Leach (1):
      perf: tools: cs-etm: Fix print issue for Coresight debug in ETE/TRBE trace

Mikko Perttunen (3):
      memory: tegra124-emc: Fix dll_change check
      memory: tegra30-emc: Fix dll_change check
      drm/msm: Fix iommu_map_sgtable() return value check and avoid WARN

Miklos Szeredi (1):
      fanotify: fix false positive on permission events

Mikulas Patocka (3):
      dm-thin: fix metadata refcount underflow
      dm: don't report warning when doing deferred remove
      dm: fix a buffer overflow in ioctl processing

Ming Lei (3):
      ublk: fix deadlock when reading partition table
      blk-mq: fix NULL dereference on q->elevator in blk_mq_elv_switch_none
      blk-cgroup: wait for blkcg cleanup before initializing new disk

Ming Qian (1):
      media: amphion: Fix race between m2m job_abort and device_run

Ming-Hung Tsai (9):
      dm cache: fix null-deref with concurrent writes in passthrough mode
      dm cache: fix write path cache coherency in passthrough mode
      dm cache: fix write hang in passthrough mode
      dm cache policy smq: fix missing locks in invalidating cache blocks
      dm cache: fix concurrent write failure in passthrough mode
      dm cache: support shrinking the origin device
      dm cache: fix dirty mapping checking in passthrough mode switching
      dm cache metadata: fix memory leak on metadata abort retry
      dm cache: fix missing return in invalidate_committed's error path

Mingming Cao (1):
      ibmveth: Disable GSO for packets with small MSS

Mingyu Wang (1):
      Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths

Mingzhe Zou (2):
      bcache: fix cached_dev.sb_bio use-after-free and crash
      bcache: fix uninitialized closure object

Minh Nguyen (1):
      vsock/vmci: fix UAF when peer resets connection during handshake

Minhong He (1):
      ipv6: add NULL checks for idev in SRv6 paths

Morduan Zang (1):
      net: usb: rtl8150: free skb on usb_submit_urb() failure in xmit

Myeonghun Pak (2):
      hwmon: (corsair-psu) Close HID device on probe errors
      net: lan966x: avoid unregistering netdev on register failure

Nan Li (2):
      net/rds: handle zerocopy send cleanup before the message is queued
      netfilter: ipset: stop hash:* range iteration at end

Nathan Chancellor (2):
      scripts/dtc: Remove unused dts_version in dtc-lexer.l
      extract-cert: Wrap key_pass with '#ifdef USE_PKCS11_ENGINE'

Nathan Rebello (1):
      usbip: validate number_of_packets in usbip_pack_ret_submit()

Naval Alcalá (1):
      iommu/vt-d: Disable DMAR for Intel Q35 IGFX

Nicholas Carlini (2):
      eventpoll: defer struct eventpoll free to RCU grace period
      io-wq: check that the predecessor is hashed in io_wq_remove_pending()

Nicolai Buchwitz (1):
      net: bcmgenet: keep RBUF EEE/PM disabled

Nicolas Escande (1):
      wifi: ath11k: fix error path leaks in some WMI WOW calls

Nikola Z. Ivanov (1):
      netdevsim: zero initialize struct iphdr in dummy sk_buff

Norbert Szetei (1):
      vsock: fix buffer size clamping order

Nuno Sa (1):
      dev_printk: add new dev_err_probe() helpers

Oldherl Oh (1):
      ALSA: hda/conexant: fix some typos

Oliver Neukum (3):
      media: rc: xbox_remote: heed DMA restrictions
      media: rc: streamzap: Error handling in probe
      HID: usbhid: fix deadlock in hid_post_reset()

Osama Abdelkader (2):
      drm/bridge: chipone-icn6211: use devm_drm_bridge_add in i2c probe
      drm/bridge: megachips: remove bridge when irq request fails

P Praneesh (1):
      wifi: ath11k: fix rssi station dump not updated in QCN9074

Pablo Neira Ayuso (4):
      nf_tables: nft_dynset: fix possible stateful expression memleak in error path
      netfilter: nft_osf: restrict it to ipv4
      netfilter: xtables: restrict several matches to inet family
      netfilter: arp_tables: fix IEEE1394 ARP payload parsing

Panagiotis Petrakopoulos (1):
      ALSA: scarlett2: Add missing sentinel initializer field

Paolo Abeni (2):
      epoll: use refcount to reduce ep_mutex contention
      net/sched: cls_flower: revert unintended changes

Paul E. McKenney (1):
      exit: Sleep at TASK_IDLE when waiting for application core dump

Paul Geurts (1):
      NFC: trf7970a: Ignore antenna noise when checking for RF field

Paul Moses (1):
      crypto: ccp - copy IV using skcipher ivsize

Pauli Virtanen (1):
      Bluetooth: fix locking in hci_conn_request_evt() with HCI_PROTO_DEFER

Pavel Begunkov (2):
      io_uring/timeout: check unused sqe fields
      io_uring: prevent opcode speculation

Pei Xiao (2):
      spi: hisi-kunpeng: prevent infinite while() loop in hisi_spi_flush_fifo
      spi: mtk-snfi: unregister ECC engine on probe failure and remove() callback

Peng Fan (4):
      arm64: dts: imx8mp-icore-mx8mp: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mp-dhcom-som: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mn-tqma8mqnl: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mm-tqma8mqml: Correct PAD settings for PMIC_nINT

Pengpeng Hou (9):
      wifi: wl1251: validate packet IDs before indexing tx_frames
      wifi: brcmfmac: validate bsscfg indices in IF events
      nfc: s3fwrn5: allocate rx skb before consuming bytes
      tracing/probe: reject non-closed empty immediate strings
      rxrpc: proc: size address buffers for %pISpc output
      tracing: Rebuild full_name on each hist_field_name() call
      fs/ntfs3: terminate the cached volume label after UTF-8 conversion
      platform/x86: dell-wmi-sysman: bound enumeration string aggregation
      s390/debug: Reject zero-length input before trimming a newline

Peter Ujfalusi (2):
      ASoC: SOF: pcm: Clear the susbstream pointer to NULL on close
      ASoC: SOF: stream-ipc: Check for cstream nullity in sof_ipc_msg_data()

Peter Zijlstra (1):
      hrtimer: Avoid pointless reprogramming in __hrtimer_start_range_ns()

Petr Machata (1):
      net: bridge: Flush multicast groups when snooping is disabled

Petr Oros (5):
      iavf: rename IAVF_VLAN_IS_NEW to IAVF_VLAN_ADDING
      iavf: stop removing VLAN filters from PF on interface down
      iavf: wait for PF confirmation before removing VLAN filters
      iavf: add VIRTCHNL_OP_ADD_VLAN to success completion handler
      ice: fix NULL pointer dereference in ice_reset_all_vfs()

Petr Pavlu (2):
      params: Replace __modinit with __init_or_module
      module: Fix freeing of charp module parameters when CONFIG_SYSFS=n

Phil Willoughby (1):
      ALSA: usb-audio: Fix quirk flags for NeuralDSP Quad Cortex

Philip Yang (1):
      drm/amdgpu: zero-initialize GART table on allocation

Potin Lai (1):
      soc: aspeed: socinfo: Mask table entries for accurate SoC ID matching

Puranjay Mohan (1):
      bpf, arm32: Reject BPF-to-BPF calls and callbacks in the JIT

Qiang Ma (1):
      KVM: x86: Fix Xen hypercall tracepoint argument assignment

Qingfang Deng (2):
      flow_dissector: do not dissect PPPoE PFC frames
      pppoe: drop PFC frames

Rafael J. Wysocki (6):
      platform/surface: surfacepro3_button: Drop wakeup source on remove
      platform/x86: panasonic-laptop: Fix OPTD notifier registration and cleanup
      platform/x86: adv_swbutton: Check ACPI_HANDLE() against NULL
      platform/x86: hp_accel: Check ACPI_COMPANION() against NULL
      platform/x86: intel-hid: Check ACPI_HANDLE() against NULL
      platform/x86: intel-vbtn: Check ACPI_HANDLE() against NULL

Rafał Miłecki (1):
      ARM: dts: mediatek: mt7623: fix efuse fallback compatible

Rajat Gupta (1):
      fbdev: udlfb: add vm_ops to dlfb_ops_mmap to prevent use-after-free

Randy Dunlap (1):
      tty: hvc_iucv: fix off-by-one in number of supported devices

Raphael Zimmer (6):
      libceph: Prevent potential null-ptr-deref in ceph_handle_auth_reply()
      libceph: Fix slab-out-of-bounds access in auth message processing
      libceph: Fix potential out-of-bounds access in osdmap_decode()
      libceph: Fix potential null-ptr-deref in decode_choose_args()
      libceph: Fix potential out-of-bounds access in crush_decode()
      libceph: handle rbtree insertion error in decode_choose_args()

Ren Wei (1):
      netfilter: xt_multiport: validate range encoding in checkentry

René Rebe (1):
      PCMCIA: Fix garbled log messages for KERN_CONT

Ricardo B. Marlière (3):
      ktest: Avoid undef warning when WARNINGS_FILE is unset
      ktest: Honor empty per-test option overrides
      ktest: Run POST_KTEST hooks on failure and cancellation

Ricardo Ribalda (1):
      media: uvcvideo: Enable VB2_DMABUF for metadata stream

Richard Clark (1):
      hrtimers: Update the return type of enqueue_hrtimer()

Richard Genoud (1):
      mtd: rawnand: sunxi: fix sunxi_nfc_hw_ecc_read_extra_oob

Ritesh Harjani (IBM) (1):
      mm/kasan: fix double free for kasan pXds

Rob Clark (2):
      drm/msm/a6xx: Fix HLSQ register dumping
      drm/msm/shrinker: Fix can_block() logic

Robert Beckett (2):
      nvme-pci: add NVME_QUIRK_DISABLE_WRITE_ZEROES for Kingston OM3SGP4
      nvme: respect NVME_QUIRK_DISABLE_WRITE_ZEROES when wzsl is set

Rong Zhang (1):
      Revert "ALSA: usb: Increase volume range that triggers a warning"

Rosen Penev (2):
      irqchip/ath79-cpu: Remove unused function
      net: ag71xx: check error for platform_get_irq

Ruide Cao (3):
      net: sched: act_csum: validate nested VLAN headers
      ipv4: icmp: validate reply type before using icmp_pointers
      batman-adv: fix fragment reassembly length accounting

Ruijie Li (3):
      net/smc: avoid early lgr access in smc_clc_wait_msg
      xfrm: provide message size for XFRM_MSG_MAPPING
      batman-adv: clear current gateway during teardown

Ruslan Valiyev (2):
      media: vidtv: fix NULL pointer dereference in vidtv_channel_pmt_match_sections
      media: vidtv: fix nfeeds state corruption on start_streaming failure

Ryan Roberts (1):
      randomize_kstack: Maintain kstack_offset per task

Ryo Takakura (1):
      net: bcmgenet: Initialize u64 stats seq counter

Safa Karakuş (1):
      Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()

Sakari Ailus (1):
      staging: media: atomisp: Disallow all private IOCTLs

Samasth Norway Ananda (1):
      gpio: tegra: fix irq_release_resources calling enable instead of disable

Samuel Page (2):
      can: raw: fix ro->uniq use-after-free in raw_rcv()
      fuse: reject oversized dirents in page cache

Sander Vanheule (2):
      ASoC: sti: Return errors from regmap_field_alloc()
      ASoC: sti: use managed regmap_field allocations

Sanjaikumar V S (1):
      mtd: spi-nor: sst: Fix write enable before AAI sequence

Sanman Pradhan (2):
      hwmon: (ltc2992) Clamp threshold writes to hardware range
      hwmon: (ltc2992) Fix u32 overflow in power read path

Sasha Levin (6):
      Revert "dmaengine: idxd: Fix not releasing workqueue on .release()"
      checkpatch: add support for Assisted-by tag
      Revert "net: ethernet: xscale: Check for PTP support properly"
      Revert "net: ixp4xx_eth: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()"
      Revert "x86/vdso: Fix output operand size of RDPID"
      Revert "s390/cio: Fix device lifecycle handling in css_alloc_subchannel()"

Sayali Patil (1):
      powerpc/time: Remove redundant preempt_disable|enable() calls from arch_irq_work_raise()

Sean Christopherson (7):
      KVM: SEV: Drop WARN on large size for KVM_MEMORY_ENCRYPT_REG_REGION
      KVM: x86: Use scratch field in MMIO fragment to hold small write values
      crypto: ccp: Don't attempt to copy CSR to userspace if PSP command failed
      crypto: ccp: Don't attempt to copy PDH cert to userspace if PSP command failed
      crypto: ccp: Don't attempt to copy ID to userspace if PSP command failed
      KVM: SVM: Explicitly mark vmcb01 dirty after modifying VMCB intercepts
      KVM: x86: Fix shadow paging use-after-free due to unexpected GFN

Sebastian Andrzej Siewior (1):
      futex: Prevent lockup in requeue-PI during signal/ timeout wakeup

Sebastian Brzezinka (1):
      drm/i915: skip __i915_request_skip() for already signaled requests

Sebastian Krzyszkowiak (6):
      arm64: dts: imx8mq: Set the correct gpu_ahb clock frequency
      arm64: dts: imx8mq-librem5: Set the DVS voltages lower
      arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage to 0.81V
      Revert "arm64: dts: imx8mq-librem5: Set the DVS voltages lower"
      arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage up to 0.85V
      clk: imx8mq: Correct the CSI PHY sels

Sebastian Reichel (1):
      drm/panel: simple: Correct G190EAN01 prepare timing

SeongJae Park (1):
      Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates race

Sergey Shtylyov (1):
      media: dib8000: avoid division by 0 in dib8000_set_dds()

Sergio Correia (2):
      audit: fix incorrect inheritable capability in CAPSET records
      audit: enforce AUDIT_LOCKED for AUDIT_TRIM and AUDIT_MAKE_EQUIV

SeungJu Cheon (1):
      sound: ua101: fix division by zero at probe

Shardul Bankar (2):
      mptcp: use MPJoinSynAckHMacFailure for SynAck HMAC failure
      mptcp: use MPTCP_RST_EMPTCP for ACK HMAC validation failure

Shawn Lin (1):
      mmc: sdhci-of-dwcmshc: Disable clock before DLL configuration

Shengjiu Wang (6):
      ASoC: fsl_micfil: Fix event generation in micfil_quality_set()
      ASoC: fsl_xcvr: Fix event generation in fsl_xcvr_arc_mode_put()
      ASoC: fsl_xcvr: Fix event generation in fsl_xcvr_mode_put()
      ASoC: fsl_easrc: Check the variable range in fsl_easrc_iec958_put_bits()
      ASoC: fsl_easrc: Fix value type in fsl_easrc_iec958_get_bits()
      ASoC: fsl_easrc: Change the type for iec958 channel status controls

Sherry Sun (1):
      arm64: dts: imx8mp-evk: Enable pull select bit for PCIe regulator GPIO (M.2 W_DISABLE1)

Shiji Yang (1):
      mtd: spi-nor: swp: check SR_TB flag when getting tb_mask

Shivam Kalra (1):
      ACPI: video: force native backlight on HP OMEN 16 (8A44)

Shrikanth Hegde (1):
      cpuidle: powerpc: avoid double clear when breaking snooze

Shuai Xue (1):
      PCI/AER: Clear only error bits in PCIe Device Status

Shuvam Pandey (1):
      Bluetooth: hci_event: fix potential UAF in SSP passkey handlers

Shyam Prasad N (2):
      cifs: abort open_cached_dir if we don't request leases
      cifs: change_conf needs to be called for session setup

Shyam Saini (2):
      kernel: param: rename locate_module_kobject
      kernel: globalize lookup_or_create_module_kobject()

Simon Liebold (1):
      selftests/mqueue: Fix incorrectly named file

Siwei Zhang (3):
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_new_connection_cb()
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_state_change_cb()
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()

Sohei Koyama (1):
      ext4: fix missing brelse() in ext4_xattr_inode_dec_ref_all()

Sourabh Jain (2):
      powerpc/kdump: fix KASAN sanitization flag for core_$(BITS).o
      powerpc/crash: fix backup region offset update to elfcorehdr

Srinivas Kandagatla (5):
      ASoC: qcom: q6apm: move component registration to unmanaged version
      ASoC: qcom: q6apm-dai: reset queue ptr on trigger stop
      ASoC: qcom: q6apm-lpass-dai: Fix multiple graph opens
      ASoC: qcom: q6apm: remove child devices when apm is removed
      ASoC: qcom: qdsp6: topology: check widget type before accessing data

Srinivasan Shanmugam (1):
      drm/amdgpu: Add default case in DVI mode validation

Sriram R (6):
      wifi: ath11k: update hw params for IPQ5018
      wifi: ath11k: update ce configurations for IPQ5018
      wifi: ath11k: remap ce register space for IPQ5018
      wifi: ath11k: update hal srng regs for IPQ5018
      wifi: ath11k: initialize hw_ops for IPQ5018
      wifi: ath11k: add new hw ops for IPQ5018 to get rx dest ring hashmap

Stanislav Lisovskiy (1):
      drm/i915: Loop over all active pipes in intel_mbus_dbox_update

Stefano Garzarella (1):
      vsock/virtio: reset connection on receiving queue overflow

Stephen Hemminger (4):
      net/sched: netem: fix probability gaps in 4-state loss model
      net/sched: netem: fix queue limit check to include reordered packets
      net/sched: netem: validate slot configuration
      net/sched: netem: fix slot delay calculation overflow

Steven Rostedt (2):
      ktest: Fix the month in the name of the failure directory
      ring-buffer: Fix reporting of missed events in iterator

Sudeep Holla (2):
      firmware: arm_ffa: Check for NULL FF-A ID table while driver registration
      firmware: arm_ffa: Skip free_pages on RX buffer alloc failure

Sumit Gupta (1):
      soc/tegra: cbb: Set ERD on resume for err interrupt

Sun Jian (1):
      bpf: reject short IPv4/IPv6 inputs in bpf_prog_test_run_skb

Sven Eckelmann (10):
      batman-adv: bla: prevent use-after-free when deleting claims
      batman-adv: bla: only purge non-released claims
      batman-adv: bla: put backbone reference on failed claim hash insert
      batman-adv: mcast: fix use-after-free in orig_node RCU release
      batman-adv: dat: handle forward allocation error
      batman-adv: frag: disallow unicast fragment in fragment
      batman-adv: bla: fix report_work leak on backbone_gw purge
      batman-adv: tp_meter: avoid use of uninit sender vars
      batman-adv: tt: fix negative last_changeset_len
      batman-adv: tt: fix negative tt_buff_len

T Pratham (1):
      crypto: sa2ul - Fix AEAD fallback algorithm names

Taegu Ha (1):
      ppp: require CAP_NET_ADMIN in target netns for unattached ioctls

Takahiro Kuwano (6):
      mtd: spi-nor: spansion: Rename s28hs512t prefix
      mtd: spi-nor: spansion: Make RD_ANY_REG_OP macro take number of dummy bytes
      mtd: spi-nor: spansion: Add support for Infineon S25FS256T
      mtd: spi-nor: sfdp: introduce smpt_read_dummy fixup hook
      mtd: spi-nor: sfdp: introduce smpt_map_id fixup hook
      mtd: spi-nor: spansion: Enable JFFS2 write buffer for S25FS256T

Takashi Iwai (12):
      ALSA: control: Avoid WARN() for symlink errors
      ALSA: usb-audio: Evaluate packsize caps at the right place
      ALSA: core: Fix potential data race at fasync handling
      ALSA: caiaq: Handle probe errors properly
      ALSA: caiaq: Fix potentially leftover ep1_in_urb at error path
      ALSA: caiaq: Don't abort when no input device is available
      ALSA: usb-audio: Avoid potential endless loop in convert_chmap_v3()
      ALSA: sc6000: Use standard print API
      ALSA: usb-audio: Fix potential leak of pd at parsing UAC3 streams
      ALSA: misc: Use guard() for spin locks
      ALSA: asihpi: Fix potential OOB array access at reading cache
      HID: uclogic: Fix regression of input name assignment

Tamir Duberstein (2):
      scripts: generate_rust_analyzer.py: avoid FD leak
      scripts: generate_rust_analyzer.py: define scripts

Tejas Bharambe (2):
      ocfs2: fix use-after-free in ocfs2_fault() when VM_FAULT_RETRY
      ext4: validate p_idx bounds in ext4_ext_correct_indexes

Thomas Fourier (1):
      crypto: hisilicon - Fix dma_unmap_single() direction

Thomas Gleixner (1):
      hrtimer: Reduce trace noise in hrtimer_start()

Thomas Huth (1):
      efi/capsule-loader: fix incorrect sizeof in phys array reallocation

Thomas Zimmermann (1):
      firmware: google: framebuffer: Do not mark framebuffer as busy

Thorsten Blum (7):
      crypto: atmel-aes - Fix 3-page memory leak in atmel_aes_buff_cleanup
      crypto: atmel-ecc - Release client on allocation failure
      crypto: atmel-tdes - fix DMA sync direction
      crypto: atmel-sha204a - Fix potential UAF and memory leak in remove path
      thermal/drivers/sprd: Fix temperature clamping in sprd_thm_temp_to_rawdata
      thermal/drivers/sprd: Fix raw temperature clamping in sprd_thm_rawdata_to_temp
      bpf, devmap: Remove unnecessary if check in for loop

Timur Kristóf (11):
      drm/amd/pm/ci: Use highest MCLK on CI when MCLK DPM is disabled
      drm/amd/pm/ci: Disable MCLK DPM on problematic CI ASICs
      drm/amd/pm/smu7: Fix SMU7 voltage dependency on display clock
      drm/amd/pm/ci: Fix powertune defaults for Hawaii 0x67B0
      drm/amd/pm/ci: Clear EnabledForActivity field for memory levels
      drm/amd/pm/ci: Fill DW8 fields from SMC
      drm/amd/pm/smu7: Add SCLK cap for quirky Hawaii board
      drm/amdgpu/uvd3.1: Don't validate the firmware when already validated
      drm/amdgpu/gfx6: Support harvested SI chips with disabled TCCs (v2)
      drm/amd/display: Allow DCE link encoder without AUX registers
      drm/amd/display: Read EDID from VBIOS embedded panel info

Tobias Gaertner (2):
      ntfs3: add buffer boundary checks to run_unpack()
      ntfs3: fix integer overflow in run_unpack() volume boundary check

Tomasz Merta (1):
      ASoC: stm32_sai: fix incorrect BCLK polarity for DSP_A/B, LEFT_J

Tommaso Soncin (1):
      ASoC: amd: yc: Add HP OMEN Gaming Laptop 16-ap0xxx product line in quirk table

Tonghao Zhang (2):
      net: bonding: add broadcast_neighbor option for 802.3ad
      net: bonding: update the slave array for broadcast mode

Tristan Madani (4):
      ksmbd: fix out-of-bounds write in smb2_get_ea() EA alignment
      ksmbd: use check_add_overflow() to prevent u16 DACL size overflow
      wifi: b43legacy: enforce bounds check on firmware key index in RX path
      wifi: b43: enforce bounds check on firmware key index in b43_rx()

Tudor Ambarus (2):
      mtd: spi-nor: spansion: Replace hardcoded values for addr_nbytes/addr_mode_nbytes
      mtd: spi-nor: Allow post_sfdp hook to return errors

Tvrtko Ursulin (1):
      drm/amdgpu: Use vmemdup_array_user in amdgpu_bo_create_list_entry_array

Tyllis Xu (3):
      misc: ibmasm: fix OOB MMIO read in ibmasm_handle_mouse_interrupt()
      ibmasm: fix OOB reads in command_file_write due to missing size checks
      ibmasm: fix heap over-read in ibmasm_send_i2o_message()

Uwe Kleine-König (1):
      mtd: docg3: Convert to platform remove callback returning void

V sujith kumar Reddy (1):
      ASoC: SOF: amd: Fix for reading position updates from stream box.

Vadim Fedorenko (1):
      bpf: Add CHECKSUM_COMPLETE to bpf test progs

Val Packett (6):
      dt-bindings: clock: qcom,gcc-sc8180x: Add missing GDSCs
      clk: qcom: gcc-sc8180x: Add missing GDSCs
      clk: qcom: gcc-sc8180x: Use retention for USB power domains
      clk: qcom: gcc-sc8180x: Use retention for PCIe power domains
      clk: qcom: dispcc-sm8250: Use shared ops on the mdss vsync clk
      clk: qcom: dispcc-sm8250: Enable parents for pixel clocks

Vasiliy Kovalev (1):
      ext2: reject inodes with zero i_nlink and valid mode in ext2_iget()

Vasily Gorbik (1):
      s390/debug: Reject zero-length input in debug_input_flush_fn()

Vee Satayamas (1):
      ASoC: amd: yc: Add DMI quirk for ASUS EXPERTBOOK BM1403CDA

Viacheslav Dubeyko (1):
      ceph: fix a buffer leak in __ceph_setxattr()

Vidya Sagar (5):
      PCI: tegra194: Fix polling delay for L2 state
      PCI: tegra194: Don't force the device into the D0 state before L2
      PCI: tegra194: Use devm_gpiod_get_optional() to parse "nvidia,refclk-select"
      PCI: tegra194: Disable direct speed change for Endpoint mode
      PCI: tegra194: Allow system suspend when the Endpoint link is not up

Ville Syrjälä (2):
      drm/i915: Constify watermark state checker
      drm/i915/wm: Verify the correct plane DDB entry

Vinicius Costa Gomes (1):
      net/sched: taprio: fix use-after-free in advance_sched() on schedule switch

Viorel Suman (OSS) (1):
      pwm: imx-tpm: Count the number of enabled channels in probe

Vladimir Oltean (4):
      net: dsa: clean up FDB, MDB, VLAN entries on unbind
      net/sched: taprio: continue with other TXQs if one dequeue() failed
      net/sched: taprio: refactor one skb dequeue from TXQ to separate function
      net/sched: taprio: rename close_time to end_time

Vladimir Zapolskiy (1):
      arm64: dts: qcom: sm8450: Enable UHS-I SDR50 and SDR104 SD card modes

Waiman Long (1):
      selftest: memcg: skip memcg_sock test if address family not supported

Wang Jie (1):
      rxrpc: only handle RESPONSE during service challenge

Wang Jun (1):
      media: saa7164: add ioremap return checks and cleanups

Wang Liang (1):
      bonding: check xdp prog when set bond mode

Wang Wensheng (1):
      arm64: kexec: Remove duplicate allocation for trans_pgd

Weiming Shi (6):
      bpf: fix end-of-list detection in cgroup_storage_get_next_key()
      bpf: reject negative CO-RE accessor indices in bpf_core_parse_spec()
      openvswitch: cap upcall PID array size and pre-size vport replies
      slip: reject VJ receive packets on instances with no rstate array
      slip: bound decode() reads against the compressed packet length
      bareudp: fix NULL pointer dereference in bareudp_fill_metadata_dst()

Wenmeng Liu (1):
      media: i2c: imx412: Assert reset GPIO during probe

Wentao Guan (1):
      LoongArch: Fix potential ADE in loongson_gpu_fixup_dma_hang()

Wenyuan Li (1):
      can: mcp251x: add error handling for power enable in open and resume

William A. Kennington III (1):
      net: mctp i2c: check length before marking flow active

Wolfram Sang (5):
      mailbox: mailbox-test: free channels on probe error
      mailbox: add sanity check for channel array
      mailbox: mailbox-test: don't free the reused channel
      mailbox: mailbox-test: initialize struct earlier
      mailbox: mailbox-test: make data_ready a per-instance variable

Xiang Mei (4):
      netfilter: nfnetlink_log: initialize nfgenmsg in NLMSG_DONE terminator
      netfilter: nfnetlink_osf: fix divide-by-zero in OSF_WSS_MODULO
      net/smc: avoid NULL deref of conn->lnk in smc_msg_event tracepoint
      net/smc: reject CHID-0 ACCEPT that matches an empty ism_dev slot

Xin Long (3):
      sctp: fix missing encap_port propagation for GSO fragments
      netfilter: skip recording stale or retransmitted INIT
      sctp: discard stale INIT after handshake completion

Xu Yang (2):
      usb: port: add delay after usb_hub_set_port_power()
      extcon: ptn5150: handle pending IRQ events during system resume

Yang Erkun (1):
      scsi: sg: Resolve soft lockup issue when opening /dev/sgX

Yang Xiuwei (1):
      scsi: sd: fix missing put_disk() when device_add(&disk_dev) fails

Yang Yingliang (1):
      spi: rockchip: switch to use modern name

Ye Bin (2):
      f2fs: fix null-ptr-deref in f2fs_submit_page_bio()
      smb/client: fix possible infinite loop and oob read in symlink_data()

Yihan Ding (1):
      bpf: allow UTF-8 literals in bpf_bprintf_prepare()

Yilin Zhu (1):
      ipv6: xfrm6: release dst on error in xfrm6_rcv_encap()

Yingnan Zhang (1):
      ipvs: fix MTU check for GSO packets in tunnel mode

Yiqi Sun (1):
      ipv4: icmp: fix null-ptr-deref in icmp_build_probe()

Yiyang Chen (2):
      tools/accounting: handle truncated taskstats netlink messages
      taskstats: set version in TGID exit notifications

Yongpeng Yang (3):
      f2fs: fix fiemap boundary handling when read extent cache is incomplete
      f2fs: fix incorrect multidevice info in trace_f2fs_map_blocks()
      f2fs: protect extension_list reading with sb_lock in f2fs_sbi_show()

Yosry Ahmed (10):
      KVM: nSVM: Mark all of vmcb02 dirty when restoring nested state
      KVM: nSVM: Sync NextRIP to cached vmcb12 after VMRUN of L2
      KVM: nSVM: Sync interrupt shadow to cached vmcb12 after VMRUN of L2
      KVM: nSVM: Ensure AVIC is inhibited when restoring a vCPU to guest mode
      KVM: nSVM: Use vcpu->arch.cr2 when updating vmcb12 on nested #VMEXIT
      KVM: nSVM: Always inject a #GP if mapping VMCB12 fails on nested VMRUN
      KVM: nSVM: Clear GIF on nested #VMEXIT(INVALID)
      KVM: nSVM: Clear tracking of L1->L2 NMI and soft IRQ on nested #VMEXIT
      KVM: nSVM: Add missing consistency check for EFER, CR0, CR4, and CS
      KVM: nSVM: Add missing consistency check for nCR3 validity

Youghandhar Chintala (1):
      wifi: ath11k: Trigger sta disconnect on hardware restart

Youngmin Nam (1):
      arm64: set __exception_irq_entry with __irq_entry as a default

Yu-Chun Lin (1):
      pinctrl: abx500: Fix type of 'argument' variable

Yuanjie Yang (1):
      drm/msm/dpu: fix mismatch between power and frequency

Yucheng Lu (1):
      crypto: authencesn - reject short ahash digests during instance creation

Yuho Choi (1):
      fbdev: offb: fix PCI device reference leak on probe failure

Yuqi Xu (1):
      rxrpc: reject undecryptable rxkad response tickets

Yussuf Khalil (1):
      drm/amd/display: Do not skip unrelated mode changes in DSC validation

Zak Kemble (1):
      net: bcmgenet: switch to use 64bit statistics

Zhan Jun (1):
      net: usb: rtl8150: fix use-after-free in rtl8150_start_xmit()

Zhang Heng (1):
      ASoC: amd: yc: Add DMI quirk for Thin A15 B7VF

ZhengYuan Huang (4):
      ocfs2: handle invalid dinode in ocfs2_group_extend
      ocfs2: fix listxattr handling when the buffer is full
      ocfs2: validate bg_bits during freefrag scan
      ocfs2: validate group add input before caching

Zhengchuan Liang (3):
      netfilter: ip6t_eui64: reject invalid MAC header for all packets
      net: caif: clear client service pointer on teardown
      netfilter: ip6t_hbh: reject oversized option lists

Zhenzhong Wu (1):
      tcp: call sk_data_ready() after listener migration

Zhiguo Niu (2):
      f2fs: compress: change the first parameter of page_array_{alloc,free} to sbi
      f2fs: compress: fix UAF of f2fs_inode_info in f2fs_free_dic

Zhihao Cheng (2):
      dcache: Limit the minimal number of bucket to two
      cifs: Fix busy dentry used after unmounting

Zide Chen (1):
      perf/x86/intel/uncore: Skip discovery table for offline dies

Zijing Yin (1):
      phonet/pep: disable BH around forwarded sk_receive_skb()

Zilin Guan (2):
      ice: Fix memory leak in ice_set_ringparam()
      wifi: mwifiex: Fix memory leak in mwifiex_11n_aggregate_pkt()

Ziqing Chen (1):
      ALSA: control: Validate buf_len before strnlen() in snd_ctl_elem_init_enum_names()

Zisen Ye (1):
      smb/client: fix out-of-bounds read in symlink_data()

Zoran Ilievski (1):
      net: atlantic: preserve PCI wake-from-D3 on shutdown when WOL enabled

cuitao (1):
      cgroup/rdma: fix integer overflow in rdmacg_try_charge()

hkbinbin (1):
      RDMA/rxe: Validate pad and ICRC before payload_size() in rxe_rcv

leo vriska (1):
      HID: quirks: add HID_QUIRK_ALWAYS_POLL for 8BitDo Pro 3

songxiebing (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14IAH10

wangdicheng (2):
      ALSA: hda/conexant: Renaming the codec with device ID 0x1f86 and 0x1f87
      ALSA: hda/conexant: Fix missing error check for jack detection

