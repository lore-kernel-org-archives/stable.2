Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5F734C130;
	Mon,  3 Aug 2026 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785749679; cv=none; b=BE3+iTDpcAGM0XUzO1rYsHi3WcWuW8rqE8jIva0xYZK/+Yashp3BAQRk9J3hh7c060DvC6kLmTWXSQ4bE7Li4/LoRPVQm8WS/Aah3m0ve57GF9xkHQcUFE+sp4nczH7iRP6Td9C84Gn3RAmEi4FSck/71qfSVeDL3o5XztI0snA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785749679; c=relaxed/simple;
	bh=zkSe5qC3hSscID7st6UxaGARfEUsitlZipudUFholb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZNQwTwkhWtmobjVK2AF0A4rD7LFlxMewhBaPoZQe17qbQckgCf4FsiFO+tUcL5GVjVl7agWWy/V6krROuJ8sYcDV0Kbms8jUOAIPOdntQy9z3MXH5BQMPYeyMJMF7dQp+y6EWpbybMS3Vl5iA9rzjOpmDPQ4oMZhvYFWW/Qs6+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BRtSMMeQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BRtSMMeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66181F00A3A;
	Mon,  3 Aug 2026 09:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785749675;
	bh=0JxKlAcMyxhdP5mmWwsHgZ4n3ebJHsxClW1hTrlvCJY=;
	h=From:To:Cc:Subject:Date;
	b=BRtSMMeQYG7VJAF98Rf+pdAb23MGEY/Kr2j77x2R+ytTzlOORichyxXy3gmuHvw7c
	 hir86bCSw1RL+Fzm8N48DchFh5Ls3r0I/UoimYGJ6FvUp44TIbkb65AVZ83j2OLNWu
	 eQ49auDZcqnJHSvJf4J9Dv7ECa5WDMJt2w/uU4p0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.148
Date: Mon,  3 Aug 2026 11:34:17 +0200
Message-ID: <2026080318-sturdily-detonator-205b@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.148 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                              |    2 
 arch/arm64/boot/dts/nvidia/tegra234.dtsi                              |   24 
 arch/arm64/kvm/arm.c                                                  |    2 
 arch/loongarch/kernel/kgdb.c                                          |    3 
 arch/mips/kvm/mips.c                                                  |    2 
 arch/powerpc/include/asm/cputime.h                                    |   13 
 arch/powerpc/kernel/time.c                                            |   65 +
 arch/powerpc/kvm/powerpc.c                                            |    2 
 arch/riscv/include/asm/kvm_host.h                                     |   10 
 arch/riscv/kvm/aia.c                                                  |   35 
 arch/riscv/kvm/vcpu.c                                                 |   66 -
 arch/riscv/kvm/vcpu_onereg.c                                          |    8 
 arch/s390/kvm/kvm-s390.c                                              |    2 
 arch/x86/boot/compressed/Makefile                                     |    1 
 arch/x86/kernel/cpu/resctrl/rdtgroup.c                                |   12 
 arch/x86/kvm/lapic.c                                                  |    2 
 arch/x86/kvm/mmu/mmu.c                                                |   11 
 arch/x86/kvm/mmu/paging_tmpl.h                                        |   10 
 arch/x86/kvm/svm/svm.c                                                |    7 
 arch/x86/kvm/vmx/nested.c                                             |   11 
 arch/x86/kvm/x86.c                                                    |    4 
 crypto/rsa-pkcs1pad.c                                                 |    2 
 drivers/accel/ivpu/ivpu_fw_log.c                                      |    4 
 drivers/ata/libata-core.c                                             |   18 
 drivers/ata/libata-scsi.c                                             |    2 
 drivers/ata/libata.h                                                  |    9 
 drivers/ata/sata_dwc_460ex.c                                          |   38 
 drivers/block/rbd.c                                                   |    7 
 drivers/bluetooth/btqca.c                                             |    2 
 drivers/bluetooth/btusb.c                                             |    4 
 drivers/bluetooth/hci_qca.c                                           |    4 
 drivers/cdrom/cdrom.c                                                 |    1 
 drivers/char/ipmi/ipmi_msghandler.c                                   |    8 
 drivers/comedi/drivers/comedi_parport.c                               |   13 
 drivers/dma-buf/udmabuf.c                                             |   21 
 drivers/dma/dw-edma/dw-edma-pcie.c                                    |   63 -
 drivers/dma/sh/rz-dmac.c                                              |   96 -
 drivers/firewire/net.c                                                |   39 
 drivers/firmware/arm_ffa/driver.c                                     |    2 
 drivers/firmware/arm_scmi/notify.c                                    |    6 
 drivers/fpga/dfl-afu-main.c                                           |    3 
 drivers/gpio/gpio-mt7621.c                                            |    2 
 drivers/gpio/gpio-mvebu.c                                             |    4 
 drivers/gpio/gpio-pxa.c                                               |    4 
 drivers/gpio/gpio-tegra.c                                             |   18 
 drivers/gpio/gpio-vf610.c                                             |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c                              |   45 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                            |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                            |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                               |   54 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c                               |   58 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                               |   17 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                                |   13 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                |   13 
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                                 |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                 |   10 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c                               |   11 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c                              |    4 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                                 |   15 
 drivers/gpu/drm/amd/amdkfd/kfd_events.c                               |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                     |   11 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c          |    9 
 drivers/gpu/drm/amd/display/dc/link/link_detection.c                  |    5 
 drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c         |    2 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                                    |    5 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c                        |    7 
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c                        |   11 
 drivers/gpu/drm/display/drm_dp_mst_topology.c                         |   36 
 drivers/gpu/drm/i915/gem/i915_gem_context.c                           |   25 
 drivers/gpu/drm/i915/gt/intel_engine_user.c                           |    2 
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c                              |    8 
 drivers/gpu/drm/i915/i915_active.c                                    |    7 
 drivers/gpu/drm/nouveau/nouveau_exec.c                                |    4 
 drivers/gpu/drm/nouveau/nouveau_uvmm.c                                |    4 
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c                        |    1 
 drivers/gpu/drm/radeon/r100.c                                         |   13 
 drivers/gpu/drm/rockchip/cdn-dp-reg.c                                 |    2 
 drivers/gpu/drm/vc4/vc4_bo.c                                          |   10 
 drivers/gpu/drm/virtio/virtgpu_kms.c                                  |    5 
 drivers/gpu/drm/virtio/virtgpu_vq.c                                   |    6 
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c                               |   22 
 drivers/gpu/host1x/bus.c                                              |    4 
 drivers/hwmon/asus-ec-sensors.c                                       |   18 
 drivers/hwmon/corsair-cpro.c                                          |    1 
 drivers/hwmon/corsair-psu.c                                           |    1 
 drivers/hwmon/nzxt-smart2.c                                           |    2 
 drivers/hwmon/occ/common.c                                            |   38 
 drivers/hwtracing/intel_th/core.c                                     |   10 
 drivers/hwtracing/intel_th/msu.c                                      |    2 
 drivers/i2c/busses/i2c-davinci.c                                      |    4 
 drivers/i2c/busses/i2c-i801.c                                         |    2 
 drivers/i2c/busses/i2c-imx.c                                          |  126 +-
 drivers/infiniband/core/cma.c                                         |    2 
 drivers/infiniband/core/mad.c                                         |   30 
 drivers/infiniband/core/umem_dmabuf.c                                 |  174 +++
 drivers/infiniband/hw/erdma/erdma_qp.c                                |    2 
 drivers/infiniband/hw/hns/hns_roce_hem.c                              |    2 
 drivers/infiniband/hw/irdma/verbs.c                                   |    7 
 drivers/infiniband/sw/siw/siw_verbs.c                                 |   62 -
 drivers/input/misc/ims-pcu.c                                          |   37 
 drivers/iommu/amd/init.c                                              |    6 
 drivers/iommu/amd/iommu.c                                             |   25 
 drivers/iommu/intel/perf.c                                            |    2 
 drivers/iommu/intel/svm.c                                             |    2 
 drivers/md/dm-verity-target.c                                         |   14 
 drivers/md/dm-verity.h                                                |    2 
 drivers/media/cec/platform/seco/seco-cec.c                            |    6 
 drivers/media/common/videobuf2/videobuf2-core.c                       |   12 
 drivers/media/dvb-frontends/rtl2832.c                                 |    4 
 drivers/media/dvb-frontends/rtl2832_sdr.c                             |   19 
 drivers/media/pci/cx23885/cx23885-core.c                              |   14 
 drivers/media/pci/dm1105/dm1105.c                                     |    1 
 drivers/media/pci/saa7134/saa7134-video.c                             |   25 
 drivers/media/platform/aspeed/aspeed-video.c                          |    1 
 drivers/media/platform/marvell/cafe-driver.c                          |    1 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c                   |    2 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h                   |   16 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c               |    1 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c                     |    9 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c                    |   11 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c                   |   20 
 drivers/media/platform/st/stm32/stm32-dcmi.c                          |    1 
 drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c                    |    6 
 drivers/media/platform/ti/davinci/vpif_capture.c                      |    2 
 drivers/media/platform/ti/vpe/vpe.c                                   |    3 
 drivers/media/radio/radio-si476x.c                                    |    1 
 drivers/media/test-drivers/vidtv/vidtv_bridge.c                       |    4 
 drivers/media/test-drivers/vimc/vimc-core.c                           |    1 
 drivers/media/test-drivers/vivid/vivid-ctrls.c                        |   15 
 drivers/media/test-drivers/vivid/vivid-vid-cap.c                      |   38 
 drivers/media/test-drivers/vivid/vivid-vid-cap.h                      |    1 
 drivers/media/test-drivers/vivid/vivid-vid-out.c                      |    6 
 drivers/media/usb/airspy/airspy.c                                     |    8 
 drivers/media/usb/cx231xx/cx231xx-cards.c                             |   16 
 drivers/media/usb/msi2500/msi2500.c                                   |   32 
 drivers/media/usb/pwc/pwc-if.c                                        |   13 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                             |   13 
 drivers/media/v4l2-core/v4l2-ctrls-request.c                          |   14 
 drivers/misc/mei/bus.c                                                |   16 
 drivers/mtd/mtdcore.c                                                 |   23 
 drivers/mtd/mtdswap.c                                                 |    5 
 drivers/mtd/nand/ecc-mtk.c                                            |   16 
 drivers/mtd/nand/raw/nand_base.c                                      |   43 
 drivers/net/amt.c                                                     |   87 +
 drivers/net/bonding/bond_main.c                                       |    3 
 drivers/net/ethernet/amd/pds_core/adminq.c                            |   12 
 drivers/net/ethernet/amd/pds_core/auxbus.c                            |   17 
 drivers/net/ethernet/amd/pds_core/core.c                              |    1 
 drivers/net/ethernet/amd/pds_core/devlink.c                           |    6 
 drivers/net/ethernet/amd/pds_core/main.c                              |    9 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                             |   11 
 drivers/net/ethernet/cadence/macb_main.c                              |   22 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                      |    1 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c                   |    1 
 drivers/net/ethernet/freescale/fman/fman_dtsec.c                      |   17 
 drivers/net/ethernet/hisilicon/hip04_eth.c                            |   11 
 drivers/net/ethernet/huawei/hinic/hinic_dev.h                         |    2 
 drivers/net/ethernet/huawei/hinic/hinic_ethtool.c                     |   21 
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c                        |  121 --
 drivers/net/ethernet/intel/ice/ice_lag.c                              |    2 
 drivers/net/ethernet/intel/ice/ice_ptp.c                              |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                       |   14 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                       |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c                 |    9 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c               |    1 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                  |   28 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c                  |   13 
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c                    |   15 
 drivers/net/ethernet/mellanox/mlx5/core/esw/acl/helper.c              |    2 
 drivers/net/ethernet/microsoft/mana/mana_en.c                         |   13 
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c             |    3 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                     |   92 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                       |   35 
 drivers/net/geneve.c                                                  |    3 
 drivers/net/gtp.c                                                     |    5 
 drivers/net/ipa/ipa_smp2p.c                                           |   30 
 drivers/net/mctp/mctp-serial.c                                        |    2 
 drivers/net/pcs/pcs-xpcs.c                                            |   32 
 drivers/net/ppp/ppp_generic.c                                         |  154 +-
 drivers/net/ppp/pppoe.c                                               |    2 
 drivers/net/ppp/pptp.c                                                |    1 
 drivers/net/slip/slip.c                                               |    4 
 drivers/net/vmxnet3/vmxnet3_drv.c                                     |   22 
 drivers/net/vxlan/vxlan_core.c                                        |    3 
 drivers/net/vxlan/vxlan_mdb.c                                         |   30 
 drivers/net/wan/wanxl.c                                               |    3 
 drivers/net/wireless/ath/ath11k/dp_rx.c                               |    3 
 drivers/net/wireless/ath/ath11k/pci.c                                 |    4 
 drivers/net/wireless/ath/ath11k/qmi.c                                 |   11 
 drivers/net/wireless/ath/ath12k/pci.c                                 |    4 
 drivers/net/wireless/ath/ath6kl/txrx.c                                |   10 
 drivers/net/wireless/ath/ath6kl/wmi.c                                 |   20 
 drivers/net/wireless/ath/ath9k/hif_usb.c                              |    7 
 drivers/net/wireless/ath/carl9170/rx.c                                |    7 
 drivers/net/wireless/ath/carl9170/tx.c                                |    2 
 drivers/net/wireless/atmel/at76c50x-usb.c                             |    7 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c           |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c               |    8 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c               |    2 
 drivers/net/wireless/intel/ipw2x00/ipw2100.c                          |    8 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                           |    3 
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                           |   10 
 drivers/net/wireless/intersil/p54/txrx.c                              |    8 
 drivers/net/wireless/marvell/libertas/firmware.c                      |    1 
 drivers/net/wireless/marvell/libertas_tf/main.c                       |    2 
 drivers/net/wireless/marvell/mwifiex/tdls.c                           |    2 
 drivers/net/wireless/marvell/mwifiex/uap_event.c                      |   24 
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c                       |    6 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c                  |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                       |   18 
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c                       |   10 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                       |   19 
 drivers/net/wireless/microchip/wilc1000/hif.c                         |    5 
 drivers/net/wireless/virtual/mac80211_hwsim.c                         |    1 
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c                              |    4 
 drivers/pinctrl/cirrus/pinctrl-lochnagar.c                            |    2 
 drivers/pinctrl/core.c                                                |   14 
 drivers/pinctrl/intel/pinctrl-cherryview.c                            |    4 
 drivers/pinctrl/intel/pinctrl-intel.c                                 |    4 
 drivers/pinctrl/intel/pinctrl-lynxpoint.c                             |    4 
 drivers/pinctrl/mediatek/pinctrl-moore.c                              |    4 
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c                         |    4 
 drivers/pinctrl/mediatek/pinctrl-paris.c                              |    4 
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c                             |    4 
 drivers/pinctrl/pinctrl-as3722.c                                      |    4 
 drivers/pinctrl/pinctrl-axp209.c                                      |    2 
 drivers/pinctrl/pinctrl-cy8c95x0.c                                    |    4 
 drivers/pinctrl/pinctrl-ingenic.c                                     |   11 
 drivers/pinctrl/pinctrl-ocelot.c                                      |    4 
 drivers/pinctrl/pinctrl-rk805.c                                       |    4 
 drivers/pinctrl/pinctrl-st.c                                          |    4 
 drivers/pinctrl/renesas/gpio.c                                        |    4 
 drivers/pinctrl/stm32/pinctrl-stm32.c                                 |    4 
 drivers/pinctrl/vt8500/pinctrl-wmt.c                                  |    4 
 drivers/platform/loongarch/loongson-laptop.c                          |    1 
 drivers/platform/x86/amd/pmc/pmc.c                                    |   39 
 drivers/platform/x86/amd/pmc/pmc.h                                    |    1 
 drivers/platform/x86/dell/dell-laptop.c                               |   28 
 drivers/platform/x86/dell/dell-smbios-base.c                          |   25 
 drivers/platform/x86/dell/dell-smbios.h                               |    5 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c |    7 
 drivers/staging/media/meson/vdec/vdec.c                               |    4 
 drivers/staging/media/sunxi/cedrus/cedrus.c                           |    6 
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c                      |    3 
 drivers/staging/media/tegra-video/vi.c                                |    4 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c                        |    9 
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c                     |    2 
 drivers/tty/serial/8250/8250_mid.c                                    |   14 
 drivers/tty/serial/max310x.c                                          |   20 
 drivers/tty/serial/sc16is7xx.c                                        |   12 
 drivers/usb/atm/ueagle-atm.c                                          |   17 
 drivers/usb/chipidea/core.c                                           |    1 
 drivers/usb/gadget/function/f_midi.c                                  |    1 
 drivers/usb/gadget/function/f_ncm.c                                   |   17 
 drivers/usb/gadget/function/f_printer.c                               |   23 
 drivers/usb/gadget/function/uvc_v4l2.c                                |    2 
 drivers/usb/gadget/udc/bdc/bdc_core.c                                 |   20 
 drivers/usb/gadget/udc/bdc/bdc_udc.c                                  |    7 
 drivers/usb/gadget/udc/dummy_hcd.c                                    |   40 
 drivers/usb/gadget/udc/fsl_udc_core.c                                 |    1 
 drivers/usb/gadget/udc/snps_udc_core.c                                |    1 
 drivers/usb/host/xhci-pci.c                                           |    1 
 drivers/usb/host/xhci.c                                               |   15 
 drivers/usb/host/xhci.h                                               |    1 
 drivers/usb/serial/ftdi_sio.c                                         |    2 
 drivers/usb/serial/ftdi_sio_ids.h                                     |    5 
 drivers/usb/serial/io_edgeport.c                                      |    3 
 drivers/usb/serial/keyspan_pda.c                                      |   44 
 drivers/usb/serial/option.c                                           |    1 
 drivers/usb/storage/unusual_devs.h                                    |    7 
 drivers/vdpa/vdpa_user/iova_domain.c                                  |  163 ++-
 drivers/vdpa/vdpa_user/iova_domain.h                                  |   13 
 drivers/vdpa/vdpa_user/vduse_dev.c                                    |   16 
 drivers/video/fbdev/core/bitblit.c                                    |  124 +-
 drivers/video/fbdev/core/fbcon.c                                      |  420 +++-----
 drivers/video/fbdev/core/fbcon.h                                      |    6 
 drivers/video/fbdev/core/fbcon_ccw.c                                  |  148 +-
 drivers/video/fbdev/core/fbcon_cw.c                                   |  148 +-
 drivers/video/fbdev/core/fbcon_rotate.c                               |   44 
 drivers/video/fbdev/core/fbcon_rotate.h                               |    6 
 drivers/video/fbdev/core/fbcon_ud.c                                   |  164 +--
 drivers/video/fbdev/core/softcursor.c                                 |   18 
 drivers/video/fbdev/core/tileblit.c                                   |   28 
 drivers/video/fbdev/efifb.c                                           |  125 +-
 drivers/watchdog/watchdog_pretimeout.c                                |    2 
 fs/afs/addr_list.c                                                    |   10 
 fs/afs/fs_probe.c                                                     |    6 
 fs/afs/internal.h                                                     |    6 
 fs/afs/proc.c                                                         |    4 
 fs/afs/rotate.c                                                       |    2 
 fs/afs/rxrpc.c                                                        |   15 
 fs/afs/server.c                                                       |    4 
 fs/afs/vl_alias.c                                                     |    4 
 fs/afs/vl_probe.c                                                     |    6 
 fs/afs/vl_rotate.c                                                    |    2 
 fs/binfmt_elf_fdpic.c                                                 |    4 
 fs/binfmt_misc.c                                                      |    5 
 fs/btrfs/free-space-cache.c                                           |    3 
 fs/btrfs/relocation.c                                                 |    2 
 fs/ceph/caps.c                                                        |    1 
 fs/coredump.c                                                         |    1 
 fs/crypto/inline_crypt.c                                              |   57 -
 fs/crypto/keysetup_v1.c                                               |    8 
 fs/exec.c                                                             |    2 
 fs/exfat/balloc.c                                                     |   54 -
 fs/f2fs/super.c                                                       |   25 
 fs/iomap/buffered-io.c                                                |   12 
 fs/namei.c                                                            |   43 
 fs/nfs/internal.h                                                     |   14 
 fs/nfs/pnfs_nfs.c                                                     |    2 
 fs/nfs/write.c                                                        |   14 
 fs/nfsd/nfs4xdr.c                                                     |    8 
 fs/nfsd/vfs.c                                                         |    7 
 fs/nfsd/vfs.h                                                         |    2 
 fs/overlayfs/copy_up.c                                                |   12 
 fs/posix_acl.c                                                        |    7 
 fs/proc/namespaces.c                                                  |    4 
 fs/smb/client/misc.c                                                  |   34 
 fs/smb/client/smb2ops.c                                               |   25 
 fs/smb/server/oplock.c                                                |    6 
 fs/smb/server/smb2misc.c                                              |    5 
 fs/smb/server/smb2pdu.c                                               |    9 
 fs/smb/server/smbacl.c                                                |   42 
 include/linux/audit.h                                                 |    6 
 include/linux/audit_arch.h                                            |   12 
 include/linux/bootconfig.h                                            |    3 
 include/linux/bpf_lsm.h                                               |    4 
 include/linux/firmware.h                                              |    3 
 include/linux/fscrypt.h                                               |   18 
 include/linux/kvm_host.h                                              |    1 
 include/linux/lsm_hooks.h                                             |    1 
 include/linux/namei.h                                                 |    1 
 include/linux/pinctrl/consumer.h                                      |   13 
 include/linux/ppp_channel.h                                           |    3 
 include/linux/seqlock.h                                               |   10 
 include/linux/sunrpc/svcsock.h                                        |    3 
 include/linux/sunrpc/xdr.h                                            |   19 
 include/linux/vtime.h                                                 |    6 
 include/linux/workqueue.h                                             |    8 
 include/media/videobuf2-core.h                                        |    8 
 include/net/af_rxrpc.h                                                |   25 
 include/net/bluetooth/rfcomm.h                                        |    3 
 include/net/netfilter/nf_tables.h                                     |   37 
 include/net/netfilter/nft_fib.h                                       |    2 
 include/net/netfilter/nft_meta.h                                      |    3 
 include/net/sctp/structs.h                                            |    3 
 include/rdma/ib_umem.h                                                |   41 
 include/trace/events/rxrpc.h                                          |    3 
 include/uapi/linux/btrfs.h                                            |    2 
 init/main.c                                                           |   39 
 io_uring/rw.c                                                         |   28 
 kernel/audit.c                                                        |    2 
 kernel/audit.h                                                        |   32 
 kernel/audit_fsnotify.c                                               |   39 
 kernel/audit_tree.c                                                   |    2 
 kernel/audit_watch.c                                                  |   42 
 kernel/auditfilter.c                                                  |   17 
 kernel/auditsc.c                                                      |    6 
 kernel/bpf/bpf_inode_storage.c                                        |    9 
 kernel/bpf/bpf_lsm.c                                                  |    1 
 kernel/bpf/verifier.c                                                 |   17 
 kernel/locking/spinlock_rt.c                                          |   27 
 kernel/sched/cputime.c                                                |   13 
 kernel/taskstats.c                                                    |   67 -
 kernel/trace/ftrace.c                                                 |   13 
 kernel/trace/trace_eprobe.c                                           |    3 
 kernel/trace/trace_events_user.c                                      |   39 
 kernel/trace/trace_mmiotrace.c                                        |    4 
 kernel/trace/trace_probe.c                                            |   13 
 kernel/workqueue.c                                                    |   46 
 lib/bootconfig.c                                                      |   65 +
 lib/compat_audit.c                                                    |   12 
 mm/damon/core.c                                                       |   13 
 mm/mm_init.c                                                          |   34 
 net/bluetooth/hci_sync.c                                              |   13 
 net/bluetooth/mgmt.c                                                  |   42 
 net/bluetooth/rfcomm/core.c                                           |   17 
 net/bluetooth/rfcomm/tty.c                                            |    7 
 net/bridge/br_netlink_tunnel.c                                        |    3 
 net/bridge/br_private.h                                               |    6 
 net/bridge/br_vlan.c                                                  |   10 
 net/bridge/br_vlan_options.c                                          |    3 
 net/bridge/netfilter/nft_meta_bridge.c                                |   20 
 net/bridge/netfilter/nft_reject_bridge.c                              |    1 
 net/can/bcm.c                                                         |  520 +++++++---
 net/can/isotp.c                                                       |  280 ++++-
 net/can/j1939/transport.c                                             |   18 
 net/ceph/auth_x.c                                                     |    9 
 net/ceph/ceph_common.c                                                |    4 
 net/ceph/mon_client.c                                                 |    4 
 net/ceph/osdmap.c                                                     |   12 
 net/core/sock_map.c                                                   |    2 
 net/hsr/hsr_slave.c                                                   |    2 
 net/ipv4/fib_trie.c                                                   |    2 
 net/ipv4/icmp.c                                                       |   18 
 net/ipv4/netfilter/nft_dup_ipv4.c                                     |    1 
 net/ipv4/netfilter/nft_fib_ipv4.c                                     |    2 
 net/ipv4/netfilter/nft_reject_ipv4.c                                  |    1 
 net/ipv4/nexthop.c                                                    |    2 
 net/ipv4/tcp_bpf.c                                                    |    2 
 net/ipv6/ila/ila_common.c                                             |   12 
 net/ipv6/ip6_tunnel.c                                                 |    3 
 net/ipv6/ndisc.c                                                      |    8 
 net/ipv6/netfilter/nft_dup_ipv6.c                                     |    1 
 net/ipv6/netfilter/nft_fib_ipv6.c                                     |    2 
 net/ipv6/netfilter/nft_reject_ipv6.c                                  |    1 
 net/ipv6/raw.c                                                        |    2 
 net/ipv6/xfrm6_policy.c                                               |    1 
 net/iucv/af_iucv.c                                                    |   21 
 net/l2tp/l2tp_ppp.c                                                   |    1 
 net/mac80211/iface.c                                                  |    8 
 net/mac80211/link.c                                                   |    4 
 net/mac80211/rx.c                                                     |    2 
 net/mac802154/llsec.c                                                 |    5 
 net/mac802154/scan.c                                                  |   11 
 net/mpls/af_mpls.c                                                    |    3 
 net/mptcp/options.c                                                   |   12 
 net/mptcp/protocol.c                                                  |    1 
 net/netfilter/nf_conntrack_sip.c                                      |   10 
 net/netfilter/nf_tables_api.c                                         |   67 -
 net/netfilter/nft_bitwise.c                                           |  104 --
 net/netfilter/nft_byteorder.c                                         |   11 
 net/netfilter/nft_cmp.c                                               |    3 
 net/netfilter/nft_compat.c                                            |   10 
 net/netfilter/nft_connlimit.c                                         |    1 
 net/netfilter/nft_counter.c                                           |    1 
 net/netfilter/nft_ct.c                                                |   46 
 net/netfilter/nft_dup_netdev.c                                        |    1 
 net/netfilter/nft_dynset.c                                            |    1 
 net/netfilter/nft_exthdr.c                                            |   34 
 net/netfilter/nft_fib.c                                               |   51 
 net/netfilter/nft_fib_inet.c                                          |    1 
 net/netfilter/nft_fib_netdev.c                                        |   30 
 net/netfilter/nft_flow_offload.c                                      |    1 
 net/netfilter/nft_fwd_netdev.c                                        |    2 
 net/netfilter/nft_hash.c                                              |   36 
 net/netfilter/nft_immediate.c                                         |   12 
 net/netfilter/nft_last.c                                              |    1 
 net/netfilter/nft_limit.c                                             |    2 
 net/netfilter/nft_log.c                                               |    1 
 net/netfilter/nft_lookup.c                                            |   12 
 net/netfilter/nft_masq.c                                              |    3 
 net/netfilter/nft_meta.c                                              |   45 
 net/netfilter/nft_nat.c                                               |    2 
 net/netfilter/nft_numgen.c                                            |   22 
 net/netfilter/nft_objref.c                                            |    2 
 net/netfilter/nft_osf.c                                               |   25 
 net/netfilter/nft_payload.c                                           |   47 
 net/netfilter/nft_queue.c                                             |    2 
 net/netfilter/nft_quota.c                                             |    1 
 net/netfilter/nft_range.c                                             |    1 
 net/netfilter/nft_redir.c                                             |    3 
 net/netfilter/nft_reject_inet.c                                       |    1 
 net/netfilter/nft_reject_netdev.c                                     |    1 
 net/netfilter/nft_rt.c                                                |    1 
 net/netfilter/nft_set_pipapo.c                                        |  253 ++--
 net/netfilter/nft_set_pipapo.h                                        |    8 
 net/netfilter/nft_socket.c                                            |   26 
 net/netfilter/nft_synproxy.c                                          |    1 
 net/netfilter/nft_tproxy.c                                            |    1 
 net/netfilter/nft_tunnel.c                                            |   26 
 net/netfilter/nft_xfrm.c                                              |   27 
 net/openvswitch/actions.c                                             |   15 
 net/openvswitch/datapath.c                                            |   25 
 net/openvswitch/datapath.h                                            |    2 
 net/openvswitch/vport.c                                               |    2 
 net/packet/af_packet.c                                                |    6 
 net/phonet/pep.c                                                      |    2 
 net/qrtr/af_qrtr.c                                                    |    8 
 net/qrtr/ns.c                                                         |    4 
 net/rds/recv.c                                                        |   15 
 net/rxrpc/af_rxrpc.c                                                  |   24 
 net/rxrpc/ar-internal.h                                               |    3 
 net/rxrpc/call_accept.c                                               |   77 -
 net/rxrpc/call_object.c                                               |   42 
 net/rxrpc/conn_client.c                                               |   12 
 net/rxrpc/conn_event.c                                                |   14 
 net/rxrpc/conn_object.c                                               |    8 
 net/rxrpc/input.c                                                     |    5 
 net/rxrpc/io_thread.c                                                 |    8 
 net/rxrpc/peer_event.c                                                |    8 
 net/rxrpc/peer_object.c                                               |    1 
 net/rxrpc/recvmsg.c                                                   |   26 
 net/rxrpc/rxperf.c                                                    |   10 
 net/rxrpc/security.c                                                  |    4 
 net/rxrpc/sendmsg.c                                                   |    8 
 net/rxrpc/txbuf.c                                                     |    4 
 net/sched/act_tunnel_key.c                                            |   14 
 net/sctp/auth.c                                                       |    2 
 net/sctp/sm_make_chunk.c                                              |    6 
 net/sctp/sm_statefuns.c                                               |    2 
 net/sctp/stream.c                                                     |    6 
 net/sunrpc/svcsock.c                                                  |   51 
 net/sunrpc/xdr.c                                                      |  210 +++-
 net/sunrpc/xprtrdma/rpc_rdma.c                                        |    4 
 net/sunrpc/xprtrdma/verbs.c                                           |   12 
 net/tipc/netlink.c                                                    |    6 
 net/tipc/netlink_compat.c                                             |    4 
 net/tipc/socket.c                                                     |    7 
 net/tls/tls_device.c                                                  |    6 
 net/wireless/core.c                                                   |    1 
 net/wireless/nl80211.c                                                |   20 
 net/wireless/pmsr.c                                                   |   21 
 net/wireless/scan.c                                                   |    2 
 net/x25/af_x25.c                                                      |    8 
 net/xfrm/xfrm_policy.c                                                |    4 
 security/apparmor/include/net.h                                       |    6 
 security/apparmor/lsm.c                                               |   38 
 security/apparmor/net.c                                               |    2 
 security/bpf/hooks.c                                                  |    3 
 security/security.c                                                   |   36 
 security/selinux/hooks.c                                              |   99 -
 security/selinux/include/objsec.h                                     |    5 
 security/selinux/netlabel.c                                           |   23 
 security/smack/smack.h                                                |    5 
 security/smack/smack_lsm.c                                            |   70 -
 security/smack/smack_netfilter.c                                      |    4 
 sound/core/seq/seq_timer.c                                            |   13 
 sound/hda/hdac_regmap.c                                               |    4 
 sound/pci/hda/patch_conexant.c                                        |    3 
 sound/soc/amd/ps/pci-ps.c                                             |    2 
 sound/soc/codecs/bt-sco.c                                             |   10 
 sound/soc/codecs/cs35l56-i2c.c                                        |    4 
 sound/soc/codecs/cs35l56-spi.c                                        |    4 
 sound/soc/codecs/cs35l56.c                                            |   25 
 sound/soc/codecs/cs42l43-jack.c                                       |    3 
 sound/soc/codecs/tas2562.c                                            |    5 
 sound/soc/codecs/tas2781-fmwlib.c                                     |   63 +
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c                            |   14 
 sound/soc/mediatek/mt7986/mt7986-afe-pcm.c                            |   14 
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c                            |   26 
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c                            |   21 
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c                            |  135 --
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c                            |   54 -
 sound/soc/mediatek/mt8195/mt8195-mt6359.c                             |   38 
 sound/soc/meson/aiu-fifo-spdif.c                                      |    5 
 sound/usb/quirks.c                                                    |    2 
 tools/testing/selftests/alsa/mixer-test.c                             |    1 
 tools/testing/selftests/bpf/progs/verifier_ld_ind.c                   |  142 ++
 tools/testing/selftests/net/af_unix/config                            |    4 
 tools/testing/selftests/net/openvswitch/config                        |   16 
 virt/kvm/kvm_main.c                                                   |    3 
 547 files changed, 6118 insertions(+), 3938 deletions(-)

Abdun Nihaal (2):
      wifi: ipw2100: fix potential memory leak in ipw2100_pci_init_one()
      fbdev: efifb: fix memory leak in efifb_probe()

Abinash Singh (1):
      dma: dw-edma: Fix build warning in dw_edma_pcie_probe()

Aldo Ariel Panzardo (2):
      rds: drop incoming messages that cross network namespace boundaries
      net: qrtr: restrict socket creation to the initial network namespace

Aleksandrova Alyona (1):
      RDMA/irdma: Prevent overflows in memory contiguity checks

Alex Deucher (9):
      drm/amdgpu/sdma6.0: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma5.2: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma5.0: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx10: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx11: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx8: drop unecessary BUG_ON()
      drm/amdgpu/gfx9.4.3: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx9: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma4.4.2: replace BUG_ON() with WARN_ON()

Alexander Gordeev (1):
      sched/vtime: Get rid of generic vtime_task_switch() implementation

Alexander Usyskin (1):
      mei: bus: access mei_device under device_lock on cleanup

Alexei Lazar (2):
      net/mlx5e: Report zero bandwidth for non-ETS traffic classes
      net/mlx5e: Reject unsupported CB Shaper TSA in ETS validation

Amir Goldstein (1):
      fs: preserve ACL_DONT_CACHE state in forget_cached_acl()

Anand Moon (1):
      media: meson: vdec: Fix memory leak in error path of vdec_open

Andrew Pope (1):
      wifi: mac80211: recalculate TIM when a station enters power save

AngeloGioacchino Del Regno (4):
      ASoC: mediatek: mt8195: Remove afe-dai component and rework codec link
      ASoC: mediatek: mt8192-afe-pcm: Convert to devm_pm_runtime_enable()
      ASoC: mediatek: mt8192-afe-pcm: Simplify with dev_err_probe()
      ASoC: mediatek: Use common mtk_afe_pcm_platform with common probe cb

Asad Kamal (1):
      drm/amdgpu: fix aperture mapping leak

Ashutosh Desai (3):
      drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply parsers
      drm/dp/mst: fix buffer overflows in sideband chunk accumulation
      drm/dp/mst: fix OOB reads on 2-byte fields in sideband reply parsers

Asim Viladi Oglu Manizada (1):
      pppoe: reload header pointer after dev_hard_header()

Bartosz Golaszewski (1):
      pinctrl: remove pinctrl_gpio_direction_output()

Benjamin Coddington (1):
      NFS: Charge unstable writes by request size, not folio size

Boyuan Zhang (3):
      drm/amdgpu/vce: fix integer overflow in image size
      drm/amdgpu/vcn4: avoid rereading IB param length
      drm/amdgpu: fix division by zero with invalid uvd dimensions

Breno Leitao (3):
      phonet: pep: fix use-after-free in pep_get_sb()
      bootconfig: move xbc_snprint_cmdline() to lib/bootconfig.c
      bootconfig: fix NULL-pointer arithmetic in xbc_snprint_cmdline()

Bryam Vargas (6):
      wifi: mac80211_hwsim: clamp virtio RX length before skb_put
      net/iucv: take a reference on the socket found in afiucv_hs_rcv()
      drm/virtio: bound EDID block reads to the response buffer
      ceph: fix pre-auth out-of-bounds read on snaptrace in ceph_handle_caps()
      net/iucv: fix use-after-free of a severed iucv_path
      ata: libata-core: Reject an invalid concurrent positioning ranges count

Casey Schaufler (1):
      lsm: infrastructure management of the sock security

Ce Sun (1):
      drm/amdgpu: invoke pm_genpd_remove() before freeing genpd

Cen Zhang (2):
      wifi: cfg80211: cancel sched scan results work on unregister
      wifi: mac80211: free AP_VLAN bc_buf SKBs outside IRQ lock

Cen Zhang (Microsoft) (2):
      sctp: validate stream count in sctp_process_strreset_inreq()
      tipc: fix u16 MTU truncation in media and bearer MTU validation

Charles Keepax (1):
      ASoC: cs42l43: Correct report for forced microphone jack

Chen-Yu Tsai (1):
      ASoC: mediatek: mt8195: Add platform entry for ETDM1_OUT_BE dai link

Cheng Yongkang (1):
      wifi: ath9k: hif_usb: don't dereference hif_dev after re-arming firmware request

Chengfeng Ye (3):
      bpf, sockmap: Fix cork use-after-free in tcp_bpf_sendmsg()
      Bluetooth: hci_sync: Protect UUID list traversal
      Bluetooth: RFCOMM: Fix session UAF in set_termios

Chenguang Zhao (2):
      hinic: remove unused ethtool RSS user configuration buffers
      mptcp: decrement subflows counter on failed passive join

Christian Brauner (3):
      exec: fix unsigned loop counter wrap in transfer_args_to_stack()
      binfmt_misc: set have_execfd only once the interpreter is opened
      binfmt_elf_fdpic: only honour the first PT_INTERP

Christian Hewitt (1):
      ASoC: meson: aiu: fifo-spdif: soft reset the S/PDIF datapath on start/stop

Christoph Hellwig (1):
      nfs: remove dead code for the old swap over NFS implementation

Chuck Lever (3):
      xprtrdma: Clear receive-side ownership pointers on release
      SUNRPC: Add helpers to convert xdr_buf byte ranges to scatterlists
      SUNRPC: Return an error from xdr_buf_to_bvec() on overflow

Chukun Pan (1):
      USB: serial: option: add TDTECH MT5710-CN

Claudiu Beznea (1):
      dmaengine: sh: rz-dmac: Move interrupt request after everything is set up

Coia Prant (1):
      net: pcs: xpcs: fix SGMII state reading

Cássio Gabriel (2):
      ASoC: mediatek: mt8192: Check runtime resume during probe
      ASoC: mediatek: mt8183: Check runtime resume during probe

Daehyeon Ko (1):
      tipc: clear sock->sk on the failed-insert path in tipc_sk_create()

Daniel Borkmann (2):
      bpf: Fix ld_{abs,ind} failure path analysis in subprogs
      selftests/bpf: Add tests for ld_{abs,ind} failure path in subprogs

Daniel Gibson (2):
      platform/x86/amd/pmc: Don't log during intermediate wakeups
      platform/x86/amd/pmc: Avoid logging "(null)" for DMI values

Danila Chernetsov (1):
      RDMA/hns: Fix potential integer overflow in mhop hem cleanup

David Carlier (1):
      media: aspeed: fix missing of_reserved_mem_device_release() on probe failure

David Francis (1):
      drm/amdkfd: Check bounds in allocate_event_notification_slot

David Howells (7):
      afs: Turn the afs_addr_list address array into an array of structs
      rxrpc: Pull out certain app callback funcs into an ops table
      rxrpc: Don't need barrier for ->tx_bottom and ->acks_hard_ack
      rxrpc: Use irq-disabling spinlocks between app and I/O thread
      rxrpc: Fix notification vs call-release vs recvmsg
      rxrpc: Fix socket notification race
      rxrpc: Disable IRQ, not BH, to take the lock for ->attend_link

David Lee (2):
      net/packet: avoid fanout hook re-registration after unregister
      net/x25: fix use-after-free in x25_kill_by_neigh()

David Matlack (1):
      KVM: Introduce vcpu->wants_to_run

Dawei Feng (2):
      wifi: libertas: fix memory leak in helper_firmware_cb()
      octeontx2-pf: fix SQB pointer leak on init failure

Deepanshu Kartikey (1):
      media: rtl2832: fix use-after-free in rtl2832_remove()

Devin Wittmayer (2):
      wifi: mt76: mt7615: drop TXRX_NOTIFY on non-mmio buses
      wifi: mt76: mt7921: drop TXRX_NOTIFY on non-mmio buses

Dexuan Cui (1):
      net: mana: Validate the packet length reported by the NIC

Diego Fernando Mancera Gomez (1):
      usb: atm: ueagle-atm: reject descriptors that confuse probe and disconnect

Dmitry Morgun (1):
      wifi: ath11k: fix potential buffer underflow in ath11k_hal_rx_msdu_list_get()

Dmitry Torokhov (3):
      Input: ims-pcu - fix logic error in packet reset
      firmware_loader: introduce __free() cleanup hanler
      Input: ims-pcu - fix firmware leak in async update

Doruk Tan Ozturk (6):
      crypto: rsa-pkcs1pad: Don't WARN on an empty digest
      wifi: mwifiex: fix NULL dereference when the AP has HT-cap but no HT-oper
      vxlan: require CAP_NET_ADMIN in the device netns for changelink
      geneve: require CAP_NET_ADMIN in the device netns for changelink
      mac802154: llsec: reject frames shorter than the authentication tag
      mctp: serial: handle zero-length frames to prevent rx buffer overflow

Douya Le (3):
      libceph: bound get_version reply decode to front len
      libceph: reject zero bucket types in crush_decode
      libceph: remove debugfs files before client teardown

Edward Adam Davis (1):
      hwmon: (corsair-psu) Stop device IO before calling hid_hw_stop

Emre Cecanpunar (1):
      drm/i915/selftests: Fix GT PM sort comparators

Eric Biggers (2):
      fscrypt: Add missing superblock check in find_or_insert_direct_key()
      fscrypt: Avoid dynamic allocation in fscrypt_get_devices()

Eric Dumazet (3):
      net: hsr: fix memory leak on slave unregistration by removing synced VLANs
      ipv4: icmp: fill flow parameters in icmp_route_lookup decoy lookup
      ppp: annotate data races in ppp_generic

Eugene Shalygin (3):
      hwmon: (asus-ec-sensors) fix looping over banks while reading from EC
      hwmon: (asus-ec-sensors) fix EC read intervals
      hwmon: (asus-ec-sensors) add missed handle for ENOMEM

Eugenio Pérez (2):
      vduse: remove unused vaddr parameter of vduse_domain_free_coherent
      vduse: take out allocations from vduse_dev_alloc_coherent

Fan Wu (4):
      usb: gadget: f_midi: cancel pending IN work before freeing the midi object
      usb: gadget: udc: bdc: free IRQ and drain func_wake_notify before teardown
      wifi: brcmfmac: make release_scratchbuffers idempotent
      net: hip04: fix RX buffer leak on build_skb failure

Filipe Manana (1):
      btrfs: fix root leak if its reloc root is unexpected in merge_reloc_roots()

Florian Westphal (10):
      netfilter: nft_set_pipapo: use GFP_KERNEL for insertions
      netfilter: nft_set_pipapo: move prove_locking helper around
      netfilter: nft_set_pipapo: make pipapo_clone helper return NULL
      netfilter: nft_set_pipapo: prepare walk function for on-demand clone
      netfilter: nft_set_pipapo: merge deactivate helper into caller
      netfilter: nft_set_pipapo: prepare pipapo_get helper for on-demand clone
      netfilter: nft_set_pipapo: move cloning of match info to insert/removal path
      netfilter: nft_set_pipapo: don't leak bad clone into future transaction
      netfilter: nf_conntrack_sip: remove net variable shadowing
      netfilter: nf_tables: remove register tracking infrastructure

Frederic Weisbecker (1):
      powerpc/time: Prepare to stop elapsing in dynticks-idle

Gaole Zhang (1):
      wifi: ath11k: fix NULL pointer dereference in ath11k_hal_srng_access_begin

Greg Kroah-Hartman (1):
      Linux 6.6.148

Guanghui Feng (1):
      iommu/amd: Wait for completion instead of returning early in iommu_completion_wait()

Guanghui Yang (1):
      btrfs: free mapping node on duplicate reloc root insert

Guangshuo Li (6):
      dpaa2-switch: put MAC endpoint device on disconnect
      dpaa2-eth: put MAC endpoint device on disconnect
      media: marvell-cam: fix missing pci_disable_device() on remove
      media: vidtv: fix reference leak on failed device registration
      media: vimc: fix reference leak on failed device registration
      intel_th: fix MSC output device reference leak

Guenter Roeck (2):
      hwmon: (corsair-cpro) Stop device IO before calling hid_hw_stop
      hwmon: (nzxt-smart2) Stop device IO before calling hid_hw_stop

Guixiong Wei (1):
      platform/x86/intel-uncore-freq: Fix current_freq_khz after CPU hotplug

Guoniu Zhou (2):
      media: nxp: imx8-isi: Fix potential out-of-bounds issues
      media: nxp: imx8-isi: Fix scale factor calculation for hardware rounding

Guoqing Jiang (1):
      RDMA/siw: Only check attrs->cap.max_send_wr in siw_create_qp

HE WEI (ギカク) (2):
      wifi: cfg80211: bound element ID read when checking non-inheritance
      wifi: mwifiex: bound uAP association event IEs to the event buffer

HanQuan (1):
      sctp: fix auth_chunk_list capacity check in sctp_auth_ep_add_chunkid

Hans Verkuil (2):
      media: vivid: add vivid_update_reduced_fps()
      media: vivid: check for vb2_is_busy() when toggling caps

Haofeng Li (1):
      ksmbd: validate num_subauth when copying ACE in set_ntacl_dacl

Haoran Jiang (1):
      LoongArch: Fix oops during single-step debugging

Haoxiang Li (3):
      i2c: davinci: Unregister cpufreq notifier on probe failure
      platform/x86: dell-laptop: fix missing cleanups in init error path
      net: ipa: fix SMEM state handle leaks in SMP2P init

Harry Wentland (1):
      drm/amd/display: Fix dcn32 DTB DTO update breaking live pixel rate sources

Harshaka Narayana (1):
      vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for Geneve packets

Heiko Carstens (1):
      seqlock: Allow UBSAN_ALIGNMENT to fail optimizing

Helen Koike (1):
      tipc: fix infinite loop in __tipc_nl_compat_dumpit

Hidayath Khan (1):
      net/af_iucv: fix NULL deref in afiucv_hs_callback_syn()

Huang Wei (1):
      USB: storage: add NO_ATA_1X quirk for Longmai USB Key

Hugo Villeneuve (2):
      serial: sc16is7xx: implement gpio get_direction() callback
      serial: max310x: replace bare use of 'unsigned' with 'unsigned int' (checkpatch)

Huihui Huang (2):
      wifi: at76c50x-usb: avoid length underflow in at76_guess_freq()
      wifi: wilc1000: validate assoc response length before subtracting header

Huiwen He (1):
      smb/client: handle overlapping allocated ranges in fallocate

Hungyu Lin (1):
      media: tegra-video: vi: fix invalid u32 return value in format lookup

Hyunwoo Kim (1):
      KVM: nVMX: Hide shadow VMCS right after VMCLEAR

Ian Abbott (1):
      comedi: comedi_parport: deal with premature interrupt

Ian Forbes (1):
      drm/vmwgfx: Validate vmw_surface_metadata::array_size

Ibrahim Hashimov (1):
      mac802154: hold an interface reference across the scan worker

Jacob Keller (1):
      i40e: remove read access to debugfs files

Jacob Moroni (5):
      RDMA/umem: Add ib_umem_dmabuf_get_pinned_and_lock helper
      RDMA/umem: Move umem dmabuf revoke logic into helper function
      RDMA/umem: Add pinned revocable dmabuf import interface
      RDMA/umem: Add helpers for umem dmabuf revoke lock
      RDMA/irdma: Prevent rereg_mr for non-mem regions

Jamal Hadi Salim (1):
      net/sched: act_tunnel_key: Defer dst_release to RCU callback

James Montgomery (1):
      ksmbd: defer destroy_previous_session() until after NTLM authentication

James Raphael Tiovalen (1):
      vxlan: mdb: Fix source list corruption on a failed replace

Jann Horn (1):
      proc: Fix broken error paths for namespace links

Jason Gunthorpe (1):
      udmabuf: Do not create malformed scatterlists

Jason Wang (1):
      VDUSE: avoid leaking information to userspace

Jeff Layton (2):
      audit: widen ino fields to u64
      sunrpc: allocate a separate bvec array for socket sends

Jhonraushan (1):
      accel/ivpu: Reject firmware log with size smaller than header

Jiacheng Yu (1):
      fbcon: Use correct type for vc_resize() return value

Jiangshan Yi (1):
      serial: 8250_mid: Fix NULL function pointer dereference on DNV/ICX-D/SNR platforms

Jinchao Wang (1):
      usb: gadget: dummy_hcd: prevent fifo_req reuse during giveback

Johan Hovold (5):
      USB: gadget: snps-udc: fix device name leak on probe failure
      USB: gadget: fsl-udc: fix device name leak on probe failure
      USB: serial: keyspan_pda: fix data loss on receive throttling
      media: cx231xx: fix devres lifetime
      media: vpif_capture: fix OF node reference imbalance

Joonas Lahtinen (4):
      drm/i915/gem: Add missing nospec on parallel submit slot
      drm/i915: Return NULL on error in active_instance
      drm/i915/gem: Do not leak siblings[] on proto context error
      drm/i915/gem: Fix NULL deref in I915_CONTEXT_PARAM_SSEU

Julien Massot (1):
      ASoC: mediatek: mt8195: Set ETDM1/2 IN/OUT to COMP_DUMMY()

Jun Yang (1):
      sctp: don't free the ASCONF's own transport in DEL-IP processing

Junrui Luo (2):
      drm/nouveau: fix reversed error cleanup order in ucopy functions
      octeontx2-af: cn10k: restrict VF LMTLINE sharing to its own PF

Kees Cook (1):
      afs: Annotate struct afs_addr_list with __counted_by

Koichiro Den (1):
      dmaengine: dw-edma-pcie: Reject devices without driver data

Krzysztof Kozlowski (2):
      media: pci: dm1105: Free allocated workqueue
      dmaengine: dw-edma: Fix confusing cleanup.h syntax

Kuniyuki Iwashima (1):
      selftest: af_unix: Add Kconfig file.

Kyle Zeng (1):
      openvswitch: fix GSO userspace truncation underflow

Li Daming (1):
      rxrpc: serialize kernel accept preallocation with socket teardown

Li RongQing (2):
      iommu/intel: Fix out-of-bounds memset in dmar_latency_disable()
      net: ipv6: fix dif and sdif mismatch in raw6_icmp_error

Li Xiasong (1):
      tipc: restrict socket queue dumps in enqueue tracepoints

Linmao Li (1):
      drm/vc4: Prevent shader BO mappings from becoming writable

Lorenzo Bianconi (3):
      wifi: mt76: connac: fix possible NULL-pointer deref in mt76_connac_mcu_uni_bss_he_tlv()
      wifi: mt76: mt7996: check pointer returned by mt76_connac_get_he_phy_cap()
      wifi: mt76: mt7996: fix possible NULL-pointer deref in mt7996_mcu_sta_bfer_eht()

Lu Baolu (1):
      iommu/vt-d: Disallow SVA if page walk is not coherent

Luca Coelho (1):
      drm/dp_mst: Handle torn-down topology gracefully in drm_dp_mst_topology_queue_probe()

Lyndon Sanche (1):
      platform/x86: dell-smbios: Move request functions for reuse

Ma Ke (1):
      media: saa7134: Fix a possible memory leak in saa7134_video_init1

Malaya Kumar Rout (1):
      selftests/alsa: Fix memory leak in find_controls error path

Manivannan Sadhasivam (2):
      wifi: ath11k: Flush the posted write after writing to PCIE_SOC_GLOBAL_RESET
      wifi: ath12k: Flush the posted write after writing to PCIE_SOC_GLOBAL_RESET

Maoyi Xie (2):
      wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()
      net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink

Marcin Szycik (1):
      ice: fix LAG recipe to profile association

Marco Crivellari (1):
      workqueue: Add system_percpu_wq and system_dfl_wq

Mario Limonciello (2):
      drm/amdgpu: validate CP_GFX_SHADOW chunk size in CS pass1
      drm/amdgpu: Fix VFCT bus number matching with soft filter

Masami Hiramatsu (Google) (4):
      tracing/eprobe: Fix exact system name matching in eprobe_dyn_event_match()
      tracing/probes: Avoid temporary buffer truncation in trace_probe_match_command_args()
      tracing/probes: Fix potential underflow in LEN_OR_ZERO macro
      tracing/probes: Prevent out-of-bounds write in __trace_probe_log_err()

Matt Bobrowski (1):
      bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF LSM is uninitialized

Matthieu Baerts (NGI0) (2):
      selftests: af_unix: add USER_NS config
      selftests: openvswitch: add config file

Melbin K Mathew (1):
      usb: gadget: printer: fix infinite loop in printer_read()

Michael Bommarito (6):
      IB/mad: Drop unmatched RMPP responses before reassembly
      amt: re-read skb header pointers after every pull
      amt: make the head writable before rewriting the L2 header
      mptcp: only set DATA_FIN when a mapping is present
      ila: reload IPv6 header after pskb_may_pull in checksum adjust
      tracing/user_events: Fix use-after-free in user_event_mm_dup()

Michael Walle (1):
      net: dpaa: fix mode setting

Michal Luczaj (1):
      bpf, sockmap: Reject unhashed UDP sockets on sockmap update

Mike Snitzer (1):
      NFSD: pass nfsd_file to nfsd_iter_read()

Mikhail Gavrilov (1):
      dma-buf/udmabuf: skip redundant cpu sync to fix cacheline EEXIST warning

Mikko Perttunen (1):
      gpu: host1x: Fix use-after-free in host1x_bo_clear_cached_mappings

Mikulas Patocka (2):
      dm-verity: avoid double increment of &use_bh_wq_enabled
      dm-verity: make error counter atomic

MinJea Kim (1):
      staging: rtl8723bs: fix inverted HT40 secondary channel offset

Mingyu Wang (1):
      i2c: i801: fix hardware state machine corruption in error path

Miquel Raynal (3):
      mtd: rawnand: Add a helper for calculating a page index
      mtd: rawnand: Ensure all continuous terms are always in sync
      mtd: rawnand: Pause continuous reads at block boundaries

Moksh Panicker (1):
      staging: rtl8723bs: fix OOB reads in rtw_get_wps_ie()

Muchun Song (1):
      mm/mm_init: fix pageblock migratetype for ZONE_DEVICE compound pages

Muhammad Bilal (1):
      usb: gadget: uvc: clamp SEND_RESPONSE length to the response buffer

Myeonghun Pak (5):
      media: cec: seco: unregister adapter on IR probe failure
      media: cedrus: clean up media device on probe failure
      media: radio-si476x: Unregister v4l2_device on probe failure
      media: stm32: dcmi: unregister notifier on probe failure
      media: ti: vpe: unwind v4l2 device registration on probe error

Namjae Jeon (3):
      ksmbd: bound DACL dedup walk to copied ACEs
      ksmbd: validate ACE size against SID sub-authorities
      exfat: validate cluster allocation bits of the allocation bitmap

Nathan Chancellor (1):
      x86/boot/compressed: Disable jump tables

Nazim Amirul (2):
      net: stmmac: fix l3l4 filter rejecting unsupported offload requests
      net: stmmac: reset residual action in L3L4 filters on delete

NeilBrown (1):
      VFS/audit: introduce kern_path_parent() for audit

Nikhil P. Rao (5):
      pds_core: reject component parameter in legacy firmware update
      pds_core: yield the CPU while waiting for the adminq to drain
      pds_core: order completion reads after the ownership check
      pds_core: fix auxiliary device add/del races
      pds_core: check for workqueue allocation failure

Nikolay Aleksandrov (1):
      net: bridge: vlan: fix vlan range dumps starting with pvid

Nikunj A Dadhania (1):
      KVM: SVM: Bump asid_generation on CPU online to avoid ASID collision after hotplug

Norbert Szetei (2):
      ppp: defer channel free to an RCU grace period to fix pppol2tp RX UAF
      ALSA: seq: close a re-opened queue timer in the destructor

Oleg Nesterov (1):
      taskstats: fill_stats_for_tgid: use for_each_thread()

Oliver Hartkopp (10):
      can: bcm: add locking when updating filter and timer values
      can: bcm: fix CAN frame rx/tx statistics
      can: bcm: extend bcm_tx_lock usage for data and timer updates
      can: bcm: validate frame length in bcm_rx_setup() for RTR replies
      can: bcm: add missing device refcount for CAN filter removal
      can: bcm: fix stale rx/tx ops after device removal
      can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
      can: bcm: track a single source interface for ANYDEV timeout/throttle ops
      can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER
      can: isotp: serialize TX state transitions under so->rx_lock

Or Gerlitz (1):
      RDMA/cma: Fix hardware address comparison length in netevent callback

Pablo Neira Ayuso (1):
      netfilter: nf_conntrack_sip: validate skb_dst() before accessing it

Pagadala Yesu Anjaneyulu (1):
      wifi: iwlwifi: mvm: validate SAR GEO response payload size

Pauli Virtanen (2):
      Bluetooth: mgmt: fix locking in unpair_device/disconnect_sync
      Bluetooth: mgmt: hold reference for hci_conn in mgmt_pending_cmds

Pavel Ondračka (1):
      drm/radeon: fix r100_copy_blit for large BOs

Pengpeng Hou (9):
      mtd: mtdswap: remove debugfs stats file on teardown
      mtd: nand: mtk-ecc: stop on ECC idle timeouts
      drm/i915/gt: use correct selftest config symbol
      ASoC: tas2781: bound firmware description string parsing
      hwmon: occ: validate poll response sensor blocks
      Bluetooth: btusb: validate Realtek vendor event length
      iommu/amd: Bound the early ACPI HID map
      media: cedrus: skip invalid H.264 reference list entries
      media: v4l2-ctrls: validate HEVC active reference counts

Peter Zijlstra (2):
      seqlock: Cure some more scoped_seqlock() optimization fails
      seqlock: Allow KASAN to fail optimizing

Phil Rosenthal (1):
      KVM: x86/mmu: Fix use-after-free on vendor module reload

Prashanth Kumar KR (1):
      amd-xgbe: fix MAC_AUTO_SW handling in CL37 AN

Pushpendra Singh (1):
      firmware: arm_scmi: Rate-limit queue-full warnings in IRQ context

Qian Zuo (1):
      coredump: fix pidfs file refcount leak in umh_coredump_setup

Qihang (1):
      ksmbd: pin conn during async oplock break notification

Qing Luo (1):
      sctp: auth: verify auth requirement when auth_chunk is NULL

Qingfang Deng (3):
      ppp: use IFF_NO_QUEUE in virtual interfaces
      ppp: convert to percpu netstats
      ppp: enable TX scatter-gather

Raphael Zimmer (3):
      libceph: Fix multiplication overflow in decode_new_up_state_weight()
      libceph: Reject monmaps advertising zero monitors
      rbd: Reset positive result codes to zero in object map update path

Rasmus Villemoes (1):
      bootconfig: do not put quotes on cmdline items unless necessary

Reinette Chatre (1):
      fs/resctrl: Fix double-add of pseudo-locked region's RMID to free list

Ricardo Robaina (2):
      audit: use 'unsigned int' instead of 'unsigned'
      audit: fix recursive locking deadlock in audit_dupe_exe()

Richard Fitzgerald (3):
      ASoC: cs35l56: Don't use devres to unregister component
      ASoC: cs35l56: Fix potential probe() deadlock
      ASoC: cs35l56: Use complete_all() to signal init_completion

Rishikesh Jethwani (1):
      tls: device: push pending open record on splice EOF

Robert Mader (1):
      udmabuf: Ensure to perform cache synchronisation in begin_cpu_udmabuf()

Rosen Penev (4):
      ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is registered
      ata: sata_dwc_460ex: use platform_get_irq()
      ata: sata_dwc_460ex: fix clear_interrupt_bit() clearing all pending interrupts
      ata: sata_dwc_460ex: fix infinite loop in NCQ tag completion bit-scanning

Runyu Xiao (4):
      wifi: brcmfmac: initialize SDIO data work before cleanup
      octeontx2-pf: clear stale mailbox IRQ state before request_irq()
      octeontx2-vf: clear stale mailbox IRQ state before request_irq()
      gpio: tegra: do not call pinctrl for GPIO direction

Ruoyu Wang (7):
      RDMA/erdma: initialize ret for empty receive WR lists
      RDMA/siw: publish QP after initialization
      Bluetooth: hci_qca: Clear memdump state on invalid dump size
      firewire: net: Fix fragmented datagram reassembly
      nfp: Check resource mutex allocation
      wan: wanxl: Only reset hardware after BAR mapping
      wifi: mt76: mt7915: guard HE capability lookups

Ryosuke Yasuoka (1):
      drm/virtio: fix deadlock in display_info_cb by removing hotplug from dequeue worker

SJ Park (2):
      mm/damon/core: validate ranges in damon_set_regions()
      mm/damon/core: disallow overlapping input ranges for damon_set_regions()

Samuel Holland (1):
      media: cedrus: Fix missing cleanup in error path

Sasha Levin (1):
      Revert "drm/amd/display: Add missing kdoc for ALLM parameters"

Sean Christopherson (1):
      KVM: x86: Check for invalid/obsolete root *after* making MMU pages available

Sebastian Alba Vives (1):
      fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()

Sergey Shtylyov (2):
      drm/rockchip: cdn-dp: add missing check in cdn_dp_config_video()
      media: v4l2-ctrls-request: add NULL check in v4l2_ctrl_request_complete()

Sergey Temerkhanov (1):
      ice: use READ_ONCE() to access cached PHC time

Sergio Paracuellos (1):
      gpio: mt7621: avoid corruption of shared interrupt trigger state

Seungjin Bae (1):
      Input: ims-pcu - fix heap-buffer-overflow in ims_pcu_process_data()

Shahar Tzarfati (1):
      wifi: iwlwifi: mvm: fix read in wake packet notification handler

Shelley Yang (1):
      wifi: brcmfmac: fix 802.1X-SHA256 call trace warning

Sheng Zhao (1):
      vduse: Use fixed 4KB bounce pages for non-4KB page size

Shengjiu Wang (1):
      ASoC: bt-sco: fix duplicate DAPM widget names for wideband DAI

Shrikanth Hegde (1):
      powerpc/vtime: Initialize starttime at boot for native accounting

Shuangpeng Bai (1):
      libceph: refresh auth->authorizer_buf{,_len} after authorizer update

Shuhao Fu (1):
      can: j1939: fix lockless local-destination check

Sonali Pradhan (1):
      usb: gadget: f_ncm: validate datagram bounds in ncm_unwrap_ntb()

Souvik Banerjee (1):
      ovl: use linked upper dentry in copy-up tmpfile

Stefan Eichenberger (1):
      i2c: imx: separate atomic, dma and non-dma use case

Steven Rostedt (1):
      tracing: Fix mmiotrace possible NULL dereferencing of hiter->dev

Subbaraya Sundeep (1):
      octeontx2: Annotate mmio regions as __iomem

Suman Ghosh (1):
      octeontx2-vf: set TC flower flag on MCAM entry allocation

Sumit Gupta (1):
      arm64: tegra: Fix CPU compatible string to cortex-a78ae on Tegra234

Sungmin Kang (1):
      net: slip: serialize receive against buffer reallocation

Sunho Park (1):
      USB: serial: io_edgeport: cap received transmit credits

Takashi Iwai (1):
      ALSA: usb-audio: Skip DSD quirk for Musical Fidelity M6s DAC

Tang Bin (1):
      ASoC: mediatek: mt8192-afe-pcm: Simplify probe() with local dev variable

Tapio Reijonen (1):
      serial: max310x: implement gpio_chip::get_direction()

Tejun Heo (1):
      workqueue: Factor out init_cpu_worker_pool()

Tengda Wu (1):
      ftrace: Add global mutex to serialize trace_parser access

Theodor Arsenij Larionov-Trichkine (1):
      netfilter: nft_fib: reject fib expression on the netdev egress hook

Thomas Gleixner (1):
      locking/rt: Fix the incorrect RCU protection in rt_spin_unlock()

Thomas Zimmermann (3):
      drm/amd/display: Handle struct drm_plane_state.ignore_damage_clips
      fbcon: Rename struct fbcon_ops to struct fbcon_par
      fbdev/efifb: Replace references to global screen_info by local pointer

Théo Lebrun (1):
      net: macb: drop in-flight Tx SKBs on close

Tim Pambor (1):
      USB: serial: ftdi_sio: add support for E+H FXA291

Timur Kristóf (4):
      drm/amdgpu/uvd: Fix forcing MSG, FB BOs into VCPU segment when it isn't at 0 (v2)
      drm/amdgpu/uvd: Place VCPU BO only in VRAM for UVD 4.x and older
      drm/amdgpu: Fix amdgpu_bo_move() when old_mem and new_mem are both GTT
      drm/amd/pm/ci: Don't disable MCLK DPM on Bonaire 0x6658 (R7 260X)

Tristan Madani (7):
      wifi: ath6kl: fix OOB read from firmware num_msg in TX complete handler
      wifi: ath6kl: fix OOB read from firmware IE lengths in connect event
      wifi: carl9170: bound memcpy length in cmd callback to prevent OOB read
      wifi: carl9170: fix OOB read from off-by-two in TX status handler
      wifi: carl9170: fix buffer overflow in rx_stream failover path
      wifi: ath6kl: fix OOB access from firmware ADDBA window size
      selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()

Tzung-Bi Shih (1):
      watchdog: pretimeout: Fix UAF in watchdog_unregister_governor()

Uday Khare (1):
      ASoC: tas2562: fix deprecated 'shut-down' GPIO always cleared after lookup

Unnathi Chalicheemala (1):
      firmware: arm_ffa: Fix NULL dereference in ffa_partition_info_get()

Valery Borovsky (6):
      media: airspy: Return queued buffers on start_streaming() failure
      media: msi2500: Return queued buffers on start_streaming() failure
      media: pwc: Drain fill_buf on start_streaming() failure
      media: pwc: Return queued buffers on start_streaming() failure
      media: rtl2832_sdr: Return queued buffers on start_streaming() failure
      media: sun4i-csi: Return queued buffers on start_streaming() failure

Venkatesh Srinivas (1):
      KVM: x86: Only reset TSC Deadline Timer in apic_timer_expired on KVM_RUN

Vijendar Mukunda (1):
      ASoC: amd: ps: fix wrong ACP version string in pci_request_regions()

Vincent Jardin (1):
      i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)

Vitor Soares (1):
      drm/bridge: cdns-dsi: Replace deprecated UNIVERSAL_DEV_PM_OPS()

Wang Jun (1):
      media: cx23885: add ioremap return check and cleanup

Weiming Shi (3):
      ipv4: fib: free fib_alias with kfree_rcu() on insert error path
      mpls: fix NULL deref in mpls_valid_fib_dump_req() on CONFIG_INET=n
      ipv6: ndisc: fix NULL deref in accept_untracked_na()

Weinan Liu (1):
      iommu/amd: Don't split flush for amd_iommu_domain_flush_all()

WenTao Liang (2):
      drm/amd/display: detect_link_and_local_sink: DP alt mode timeout path leaks prev_sink reference
      drm/amd/display: set new_stream to NULL after release

Wentao Guan (2):
      ksmbd: restore DACL size on check_add_overflow() to avoid malformed ACL
      bpf: drop bpf_lsm_getselfattr from hook list

Wentao Liang (2):
      drm/nouveau/acr: fix missing nvkm_done() in error path of nvkm_acr_oneinit()
      ipmi: fix refcount leak in i_ipmi_request()

Will Deacon (2):
      arm64: syscall: Ensure saved x0 is kept in-sync with tracer updates
      Revert "arm64: syscall: Ensure saved x0 is kept in-sync with tracer updates"

Xiang Mei (4):
      btrfs: reject free space cache with more entries than pages
      wifi: p54: validate RX frame length in p54_rx_eeprom_readback()
      Bluetooth: qca: fix NVM tag length underflow in TLV parser
      wifi: mac80211: tear down new links on vif update error path

Xiang Mei (Microsoft) (5):
      xfrm6: clear dst.dev on error to avoid double netdev_put in xfrm6_fill_dst()
      xfrm: policy: preallocate inexact bins before xfrm_hash_rebuild reinsert
      ksmbd: validate compound request size before reading StructureSize2
      gtp: check skb_pull_data() return in gtp1u_send_echo_resp()
      nexthop: initialize extack in nh_res_bucket_migrate()

Xiaolei Wang (3):
      media: nxp: imx8-isi: Add missing v4l2_subdev_cleanup() in crossbar and pipe
      media: nxp: imx8-isi: Clean up already-initialized pipes on probe failure
      media: nxp: imx8-isi: Fix missing v4l2_subdev_cleanup() in pipe init error path

Xie Bo (1):
      RISC-V: KVM: Serialize virtual interrupt pending state updates

Xin Long (1):
      sctp: fix auth_hmacs array size in struct sctp_cookie

Xincheng Zhang (1):
      usb: xhci-pci: Limit VIA VL805 DMA addressing to 36 bits

Xu Rao (2):
      cdrom: fix stack out-of-bounds read in CDROMVOLCTRL
      ALSA: hda: Fix cached processing coefficient verbs

Xu Yang (1):
      usb: chipidea: fix usage_count leak when autosuspend_delay is negative

Xue Lei (1):
      mtd: fix double free and WARN_ON in add_mtd_device() error paths

Yael Chemla (1):
      net/mlx5: E-Switch, fix zero num_dest in prio_tag egress vlan rule

Yang Wang (1):
      drm/amd/pm: make pp_features read-only when scpm is enabled

Yichong Chen (1):
      smb: client: validate DFS referral PathConsumed

Yishai Hadas (2):
      RDMA/umem: Add support for creating pinned DMABUF umem with a given dma device
      RDMA/umem: Introduce an option to revoke DMABUF umem

Yitang Yang (1):
      io_uring/rw: fix missing ERESTARTSYS conversion in read paths

Yiyang Chen (1):
      taskstats: retain dead thread stats in TGID queries

You-Kai Zheng (1):
      btrfs: declare btrfs_ioctl_search_args_v2::buf as __u8

Youssef Samir (1):
      net: qrtr: ns: Raise node count limit to 512

Yue Haibing (1):
      netfilter: nf_tables: Remove unused nft_reduce_is_readonly()

Zhang Heng (1):
      ALSA: hda: conexant: Remove mic bias threshold override

Zhang Yi (1):
      iomap: correct the range of a partial dirty clear

Zhao Li (5):
      wifi: nl80211: free RNR data on MBSSID mismatch
      wifi: nl80211: validate nested MBSSID IE blobs
      wifi: cfg80211: validate PMSR measurement type data
      wifi: cfg80211: validate PMSR FTM preamble range
      wifi: cfg80211: reject unsupported PMSR FTM location requests

Zhao Zhang (1):
      libceph: guard missing CRUSH type name lookup

Zhaolong Zhang (1):
      bonding: fix devconf_all NULL dereference when IPv6 is disabled

Zhu Lingshan (1):
      drm/amdgpu: fix bo->pin leaking in amdgpu_bo_create_reserved

Zile Xiong (1):
      media: vb2: use ssize_t for vb2_read/vb2_write

Zixing Liu (1):
      platform/loongarch: laptop: Explicitly reset bl_powered state when suspend

deepakraog (1):
      tracing: Fix resource leak on mmiotrace trace_pipe close

vadik likholetov (1):
      net: stmmac: enable the MAC on link up for all supported speeds

