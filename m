Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72ED47F79E;
	Wed, 19 Aug 2026 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158342; cv=none; b=lAg+8SOc4xXeuBVCmpCA0PJjecP/DEzsnTLGyXSKTpv8+SRnYNHqJN7TAFZ2gqJg0aWhtVsJJoX4AIgrAOmNzYBXLZfFxYHjlS9qmrLPYwUzB5k7jMcnrmwfEUuHZCQ1dJRwrdCBFPWZtRdPZUwIRQxrn+Q917ExM5cXZDe3qwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158342; c=relaxed/simple;
	bh=CnZ7LQEI2F5wqxULX/TKr+MzqTzOHdqOtNR3Fj1rWCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=be0oV/wV/+34hWkhPwYqUE0m57CMWRzXEDRQ+Ck44/73wYSiuAfIB/pstM4kYpDrAnLcdsN0QZst8CXjbNRTbBmuURaN8/b1JdD+jbAVovutcbLwrXMoGvYLO2Llz34aTOLd0yNPEjxa5fPfRnYNawQT+MtayYfjnzkklMNiXsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pUWGMM0n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pUWGMM0n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2F01F00A3A;
	Wed, 19 Aug 2026 16:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787158338;
	bh=PpMXzSULGMJ8iUKeVhpkojTwBd+SVFCW5M4CSyeBXOw=;
	h=From:To:Cc:Subject:Date;
	b=pUWGMM0ntOJO905mtc4Aqdegvbn+WWcjpPc0fq+XBTSu3VcVQ7sFBL8DhPB+NoPkk
	 M2Bn/bvvgsp14UsHOXAQtmdI4J/f/u7IUAbVskLj0wJW8TpBnJqGLyYj/g7D3ayhXS
	 XFc2lk0fdOx7GbVK5HgsdoKKvkwzgVYL8+5Us0F0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.183
Date: Wed, 19 Aug 2026 18:51:56 +0200
Message-ID: <2026081956-scoff-tractor-8a19@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.183 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/driver-api/driver-model/devres.rst                      |    1 
 Makefile                                                              |    2 
 arch/arm/mach-npcm/platsmp.c                                          |    2 
 arch/arm64/boot/dts/nvidia/tegra234.dtsi                              |   24 
 arch/powerpc/boot/simpleboot.c                                        |    2 
 arch/powerpc/boot/treeboot-akebono.c                                  |    2 
 arch/powerpc/boot/treeboot-currituck.c                                |    2 
 arch/powerpc/platforms/ps3/mm.c                                       |    1 
 arch/riscv/include/asm/kvm_host.h                                     |   10 
 arch/riscv/kvm/vcpu.c                                                 |   78 +
 arch/s390/kvm/pci.c                                                   |   28 
 arch/um/drivers/vector_kern.c                                         |    3 
 arch/x86/boot/compressed/Makefile                                     |    1 
 arch/x86/events/amd/brs.c                                             |   10 
 arch/x86/include/asm/nospec-branch.h                                  |    4 
 arch/x86/kernel/cpu/bugs.c                                            |   50 
 arch/x86/kvm/mmu/mmu.c                                                |   67 -
 arch/x86/kvm/mmu/mmu_internal.h                                       |    3 
 arch/x86/kvm/mmu/paging_tmpl.h                                        |   14 
 arch/x86/kvm/svm/avic.c                                               |    8 
 arch/x86/kvm/svm/svm.c                                                |    7 
 arch/x86/kvm/vmx/nested.c                                             |   11 
 arch/x86/net/bpf_jit_comp.c                                           |    3 
 crypto/rsa-pkcs1pad.c                                                 |    2 
 drivers/ata/ahci.h                                                    |   17 
 drivers/ata/ahci_brcm.c                                               |    3 
 drivers/ata/ahci_ceva.c                                               |   24 
 drivers/ata/libahci.c                                                 |    1 
 drivers/ata/libahci_platform.c                                        |   38 
 drivers/ata/pata_sl82c105.c                                           |    4 
 drivers/ata/sata_dwc_460ex.c                                          |    8 
 drivers/ata/sata_mv.c                                                 |    2 
 drivers/block/rbd.c                                                   |    7 
 drivers/block/ublk_drv.c                                              |    9 
 drivers/bluetooth/btqca.c                                             |    2 
 drivers/cdrom/cdrom.c                                                 |    1 
 drivers/comedi/drivers/comedi_parport.c                               |   13 
 drivers/counter/microchip-tcb-capture.c                               |    4 
 drivers/cpufreq/powernow-k8.c                                         |    1 
 drivers/dma/sh/rz-dmac.c                                              |   96 -
 drivers/dma/sun6i-dma.c                                               |   11 
 drivers/firewire/net.c                                                |   39 
 drivers/firmware/arm_ffa/driver.c                                     |    2 
 drivers/firmware/arm_scmi/notify.c                                    |    6 
 drivers/firmware/stratix10-svc.c                                      |   10 
 drivers/gpio/gpio-pca953x.c                                           |   15 
 drivers/gpio/gpio-pch.c                                               |   28 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c                              |   45 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                               |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                            |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                               |   30 
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c                               |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                               |   17 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                                |   13 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                |   13 
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                                 |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                 |   10 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c                                |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_events.c                               |   26 
 drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c         |    2 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                                    |    5 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c                        |    7 
 drivers/gpu/drm/display/drm_dp_helper.c                               |   12 
 drivers/gpu/drm/display/drm_dp_mst_topology.c                         |   32 
 drivers/gpu/drm/i915/gem/i915_gem_context.c                           |   25 
 drivers/gpu/drm/i915/gt/intel_engine_user.c                           |    2 
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c                              |    8 
 drivers/gpu/drm/i915/i915_active.c                                    |    7 
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c                               |    6 
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c                        |    1 
 drivers/gpu/drm/radeon/r100.c                                         |   13 
 drivers/gpu/drm/rockchip/cdn-dp-reg.c                                 |    2 
 drivers/gpu/drm/vc4/vc4_irq.c                                         |    2 
 drivers/gpu/drm/vc4/vc4_validate.c                                    |   29 
 drivers/gpu/drm/virtio/virtgpu_vq.c                                   |    3 
 drivers/gpu/drm/vmwgfx/ttm_object.c                                   |    7 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                               |   14 
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c                               |   22 
 drivers/gpu/host1x/bus.c                                              |    4 
 drivers/hid/hid-logitech-dj.c                                         |   28 
 drivers/hwmon/ads7828.c                                               |   11 
 drivers/hwmon/adt7470.c                                               |  129 +-
 drivers/hwmon/asus-ec-sensors.c                                       |   18 
 drivers/hwmon/corsair-cpro.c                                          |    1 
 drivers/hwmon/corsair-psu.c                                           |    5 
 drivers/hwmon/lm90.c                                                  |    4 
 drivers/hwmon/nct6775-core.c                                          |  441 +++++---
 drivers/hwmon/nct6775-i2c.c                                           |    2 
 drivers/hwmon/nct6775-platform.c                                      |   41 
 drivers/hwmon/nct6775.h                                               |   33 
 drivers/hwmon/npcm750-pwm-fan.c                                       |   11 
 drivers/hwmon/nzxt-smart2.c                                           |   10 
 drivers/hwmon/occ/common.c                                            |   38 
 drivers/hwmon/pmbus/lm25066.c                                         |   19 
 drivers/hwmon/pmbus/pmbus_core.c                                      |    2 
 drivers/hwtracing/intel_th/core.c                                     |   10 
 drivers/hwtracing/intel_th/msu.c                                      |    2 
 drivers/i2c/busses/i2c-amd-mp2-plat.c                                 |    4 
 drivers/i2c/busses/i2c-imx.c                                          |    9 
 drivers/i2c/busses/i2c-jz4780.c                                       |    5 
 drivers/infiniband/core/addr.c                                        |    6 
 drivers/infiniband/core/cma.c                                         |    2 
 drivers/infiniband/core/mad.c                                         |   30 
 drivers/infiniband/hw/erdma/erdma_qp.c                                |    2 
 drivers/infiniband/hw/hns/hns_roce_hem.c                              |    2 
 drivers/infiniband/hw/irdma/verbs.c                                   |    4 
 drivers/infiniband/sw/rxe/rxe_mmap.c                                  |   19 
 drivers/infiniband/sw/siw/siw_verbs.c                                 |   62 -
 drivers/input/evdev.c                                                 |   27 
 drivers/input/misc/ims-pcu.c                                          |   32 
 drivers/iommu/amd/init.c                                              |    6 
 drivers/iommu/intel/perf.c                                            |    2 
 drivers/iommu/intel/svm.c                                             |    2 
 drivers/media/cec/platform/seco/seco-cec.c                            |    6 
 drivers/media/common/videobuf2/videobuf2-core.c                       |   12 
 drivers/media/dvb-frontends/rtl2832.c                                 |    4 
 drivers/media/dvb-frontends/rtl2832_sdr.c                             |   19 
 drivers/media/pci/cx23885/cx23885-core.c                              |   14 
 drivers/media/pci/dm1105/dm1105.c                                     |    1 
 drivers/media/pci/saa7134/saa7134-video.c                             |   25 
 drivers/media/platform/aspeed/aspeed-video.c                          |    1 
 drivers/media/platform/marvell/cafe-driver.c                          |    1 
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
 drivers/media/usb/uvc/uvc_video.c                                     |   76 +
 drivers/media/usb/uvc/uvcvideo.h                                      |    4 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                             |   13 
 drivers/media/v4l2-core/v4l2-ctrls-request.c                          |   14 
 drivers/misc/fastrpc.c                                                |    3 
 drivers/mtd/mtdswap.c                                                 |    5 
 drivers/mtd/nand/ecc-mtk.c                                            |   16 
 drivers/net/amt.c                                                     |   87 +
 drivers/net/bonding/bond_alb.c                                        |   10 
 drivers/net/bonding/bond_main.c                                       |    3 
 drivers/net/can/c_can/c_can_main.c                                    |    8 
 drivers/net/can/ctucanfd/ctucanfd_base.c                              |   14 
 drivers/net/can/ctucanfd/ctucanfd_pci.c                               |    3 
 drivers/net/can/softing/softing_fw.c                                  |   46 
 drivers/net/can/usb/ems_usb.c                                         |   43 
 drivers/net/can/usb/etas_es58x/es58x_core.c                           |    1 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c                     |    1 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c                      |   13 
 drivers/net/can/usb/peak_usb/pcan_usb_core.c                          |    1 
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c                            |   40 
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c                           |   20 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                             |   11 
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c                      |   51 
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h                      |    1 
 drivers/net/ethernet/aquantia/atlantic/aq_vec.c                       |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                             |   12 
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                             |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c                         |    7 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                      |   22 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c                   |    1 
 drivers/net/ethernet/google/gve/gve.h                                 |    3 
 drivers/net/ethernet/google/gve/gve_main.c                            |    3 
 drivers/net/ethernet/google/gve/gve_rx_dqo.c                          |   33 
 drivers/net/ethernet/hisilicon/hip04_eth.c                            |   11 
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c                         |    1 
 drivers/net/ethernet/huawei/hinic/hinic_dev.h                         |    2 
 drivers/net/ethernet/huawei/hinic/hinic_ethtool.c                     |   21 
 drivers/net/ethernet/intel/e1000/e1000_main.c                         |    2 
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c                        |  121 --
 drivers/net/ethernet/intel/ice/ice_main.c                             |   10 
 drivers/net/ethernet/intel/ice/ice_ptp.c                              |    2 
 drivers/net/ethernet/intel/igbvf/netdev.c                             |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c               |    1 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                  |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c                  |    6 
 drivers/net/ethernet/marvell/prestera/prestera_pci.c                  |    3 
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c              |   16 
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c                    |   15 
 drivers/net/ethernet/mellanox/mlx5/core/esw/acl/helper.c              |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c                   |    2 
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c             |    3 
 drivers/net/ethernet/nvidia/forcedeth.c                               |    4 
 drivers/net/ethernet/qlogic/qede/qede_main.c                          |   44 
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c                       |   14 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                       |   35 
 drivers/net/geneve.c                                                  |    3 
 drivers/net/gtp.c                                                     |    5 
 drivers/net/mctp/mctp-serial.c                                        |    2 
 drivers/net/phy/phylink.c                                             |   29 
 drivers/net/ppp/ppp_generic.c                                         |  154 +-
 drivers/net/ppp/pppoe.c                                               |    2 
 drivers/net/ppp/pptp.c                                                |    1 
 drivers/net/slip/slip.c                                               |    4 
 drivers/net/thunderbolt.c                                             |   33 
 drivers/net/usb/ax88179_178a.c                                        |    4 
 drivers/net/vmxnet3/vmxnet3_drv.c                                     |   22 
 drivers/net/vrf.c                                                     |    2 
 drivers/net/vxlan/vxlan_core.c                                        |   22 
 drivers/net/wan/wanxl.c                                               |    3 
 drivers/net/wireless/ath/ath11k/dp_rx.c                               |    3 
 drivers/net/wireless/ath/ath11k/pci.c                                 |    4 
 drivers/net/wireless/ath/ath11k/qmi.c                                 |   11 
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
 drivers/net/wireless/intersil/p54/txrx.c                              |    8 
 drivers/net/wireless/mac80211_hwsim.c                                 |    1 
 drivers/net/wireless/marvell/libertas/firmware.c                      |    1 
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c                  |    2 
 drivers/net/wireless/marvell/mwifiex/tdls.c                           |    2 
 drivers/net/wireless/marvell/mwifiex/uap_event.c                      |   24 
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c                       |    6 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c                  |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                       |   18 
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c                       |   10 
 drivers/net/wireless/microchip/wilc1000/hif.c                         |    5 
 drivers/phy/xilinx/phy-zynqmp.c                                       |  127 +-
 drivers/pinctrl/Kconfig                                               |    2 
 drivers/pinctrl/devicetree.c                                          |    4 
 drivers/pinctrl/pinctrl-amd.c                                         |    3 
 drivers/pinctrl/qcom/pinctrl-sc8280xp.c                               |   21 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                               |    4 
 drivers/platform/loongarch/loongson-laptop.c                          |    1 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c |   11 
 drivers/power/supply/bq25890_charger.c                                |    2 
 drivers/ptp/ptp_ocp.c                                                 |    4 
 drivers/regulator/devres.c                                            |   59 +
 drivers/s390/block/dasd_ioctl.c                                       |    2 
 drivers/s390/crypto/zcrypt_api.c                                      |    2 
 drivers/s390/crypto/zcrypt_ccamisc.c                                  |   26 
 drivers/s390/net/qeth_core.h                                          |    4 
 drivers/s390/net/qeth_core_main.c                                     |    3 
 drivers/s390/scsi/zfcp_aux.c                                          |    1 
 drivers/scsi/aic94xx/aic94xx_hwi.c                                    |    2 
 drivers/scsi/aic94xx/aic94xx_init.c                                   |    6 
 drivers/scsi/hisi_sas/hisi_sas_main.c                                 |    6 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                                |   16 
 drivers/scsi/isci/host.h                                              |    2 
 drivers/scsi/isci/init.c                                              |    4 
 drivers/scsi/libiscsi.c                                               |    2 
 drivers/scsi/libiscsi_tcp.c                                           |    8 
 drivers/scsi/libsas/sas_ata.c                                         |    8 
 drivers/scsi/libsas/sas_discover.c                                    |   35 
 drivers/scsi/libsas/sas_expander.c                                    |    2 
 drivers/scsi/libsas/sas_host_smp.c                                    |    4 
 drivers/scsi/libsas/sas_init.c                                        |   51 
 drivers/scsi/libsas/sas_phy.c                                         |    8 
 drivers/scsi/libsas/sas_port.c                                        |    6 
 drivers/scsi/libsas/sas_scsi_host.c                                   |   14 
 drivers/scsi/mvsas/mv_init.c                                          |    4 
 drivers/scsi/pm8001/pm8001_init.c                                     |    2 
 drivers/scsi/scsi_debug.c                                             |   12 
 drivers/spi/spi-fsl-dspi.c                                            |   13 
 drivers/staging/media/meson/vdec/vdec.c                               |    4 
 drivers/staging/media/sunxi/cedrus/cedrus.c                           |    6 
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c                      |    3 
 drivers/staging/media/tegra-video/vi.c                                |    4 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c                        |   12 
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c                         |    2 
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c                        |    3 
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c                     |    6 
 drivers/target/target_core_transport.c                                |   12 
 drivers/thermal/thermal_hwmon.c                                       |    3 
 drivers/thunderbolt/eeprom.c                                          |    9 
 drivers/thunderbolt/icm.c                                             |    2 
 drivers/tty/serial/8250/8250_dma.c                                    |   12 
 drivers/tty/serial/8250/8250_mid.c                                    |   14 
 drivers/tty/serial/sc16is7xx.c                                        |   12 
 drivers/tty/vt/keyboard.c                                             |    5 
 drivers/tty/vt/vt_ioctl.c                                             |    2 
 drivers/usb/atm/cxacru.c                                              |    2 
 drivers/usb/atm/ueagle-atm.c                                          |   17 
 drivers/usb/cdns3/cdnsp-gadget.c                                      |    4 
 drivers/usb/chipidea/core.c                                           |    1 
 drivers/usb/gadget/function/f_midi.c                                  |    1 
 drivers/usb/gadget/function/f_ncm.c                                   |   19 
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
 drivers/vhost/vdpa.c                                                  |    9 
 drivers/vhost/vhost.c                                                 |    8 
 drivers/video/fbdev/core/bitblit.c                                    |    9 
 drivers/watchdog/watchdog_pretimeout.c                                |    2 
 fs/binfmt_elf_fdpic.c                                                 |    4 
 fs/binfmt_misc.c                                                      |    9 
 fs/btrfs/free-space-cache.c                                           |    3 
 fs/btrfs/inode.c                                                      |    1 
 fs/btrfs/relocation.c                                                 |    2 
 fs/ceph/caps.c                                                        |    1 
 fs/crypto/fscrypt_private.h                                           |   32 
 fs/crypto/inline_crypt.c                                              |   57 -
 fs/crypto/keyring.c                                                   |  212 +---
 fs/crypto/keysetup_v1.c                                               |    8 
 fs/exec.c                                                             |    2 
 fs/exfat/balloc.c                                                     |   54 -
 fs/f2fs/super.c                                                       |   25 
 fs/namespace.c                                                        |    5 
 fs/nfs/nfs4proc.c                                                     |    5 
 fs/proc/namespaces.c                                                  |    4 
 fs/smb/client/cifssmb.c                                               |   12 
 fs/smb/client/misc.c                                                  |   34 
 fs/smb/client/sess.c                                                  |    2 
 fs/smb/client/smb2ops.c                                               |   25 
 fs/smb/server/smb2misc.c                                              |    5 
 fs/smb/server/smb2pdu.c                                               |    9 
 fs/smb/server/vfs_cache.c                                             |    6 
 include/linux/dma/qcom_bam_dma.h                                      |   21 
 include/linux/filter.h                                                |   15 
 include/linux/fscrypt.h                                               |   18 
 include/linux/netdevice.h                                             |    5 
 include/linux/netfilter/ipset/ip_set.h                                |    2 
 include/linux/netfilter/nf_conntrack_sip.h                            |    2 
 include/linux/ppp_channel.h                                           |    3 
 include/linux/regulator/consumer.h                                    |    7 
 include/linux/seqlock.h                                               |   10 
 include/media/videobuf2-core.h                                        |    8 
 include/net/act_api.h                                                 |   19 
 include/net/addrconf.h                                                |    4 
 include/net/af_unix.h                                                 |    1 
 include/net/bluetooth/hci_core.h                                      |   18 
 include/net/bluetooth/l2cap.h                                         |    1 
 include/net/bluetooth/rfcomm.h                                        |    3 
 include/net/ip6_fib.h                                                 |    6 
 include/net/ip6_route.h                                               |   11 
 include/net/ip_vs.h                                                   |   56 -
 include/net/neighbour.h                                               |    8 
 include/net/netfilter/nf_conntrack_expect.h                           |    5 
 include/net/route.h                                                   |    2 
 include/net/sch_generic.h                                             |    1 
 include/net/sctp/structs.h                                            |    3 
 include/scsi/libsas.h                                                 |    8 
 include/uapi/linux/btrfs.h                                            |    2 
 io_uring/rw.c                                                         |   28 
 kernel/audit.c                                                        |   11 
 kernel/auditfilter.c                                                  |    6 
 kernel/bpf/bpf_lsm.c                                                  |    1 
 kernel/bpf/core.c                                                     |   68 +
 kernel/bpf/dispatcher.c                                               |    2 
 kernel/bpf/verifier.c                                                 |   32 
 kernel/futex/core.c                                                   |   82 +
 kernel/sched/psi.c                                                    |    6 
 kernel/trace/ftrace.c                                                 |   13 
 kernel/trace/ring_buffer.c                                            |    2 
 kernel/trace/trace_eprobe.c                                           |    3 
 kernel/trace/trace_events.c                                           |    6 
 kernel/trace/trace_events_filter.c                                    |    3 
 kernel/trace/trace_mmiotrace.c                                        |    5 
 kernel/trace/trace_probe.c                                            |   13 
 lib/.gitignore                                                        |    2 
 lib/Makefile                                                          |   34 
 lib/assoc_array.c                                                     |    3 
 lib/rhashtable.c                                                      |    1 
 lib/test_fortify/.gitignore                                           |    2 
 lib/test_fortify/Makefile                                             |   29 
 mm/damon/core.c                                                       |   13 
 mm/huge_memory.c                                                      |   16 
 mm/hugetlb.c                                                          |   20 
 mm/page_reporting.c                                                   |    6 
 mm/percpu-km.c                                                        |    2 
 net/atm/common.c                                                      |   14 
 net/bluetooth/6lowpan.c                                               |   20 
 net/bluetooth/hci_conn.c                                              |   19 
 net/bluetooth/hci_sync.c                                              |   13 
 net/bluetooth/hidp/core.c                                             |   30 
 net/bluetooth/l2cap_core.c                                            |   38 
 net/bluetooth/rfcomm/core.c                                           |   17 
 net/bluetooth/rfcomm/tty.c                                            |    7 
 net/bridge/br_mrp.c                                                   |    8 
 net/bridge/br_multicast.c                                             |    1 
 net/bridge/br_netfilter_hooks.c                                       |    6 
 net/bridge/br_netlink_tunnel.c                                        |    3 
 net/bridge/br_private.h                                               |    6 
 net/bridge/br_vlan.c                                                  |   10 
 net/bridge/br_vlan_options.c                                          |    3 
 net/bridge/netfilter/ebt_nflog.c                                      |   17 
 net/bridge/netfilter/nf_conntrack_bridge.c                            |    1 
 net/can/bcm.c                                                         |  520 +++++++---
 net/can/isotp.c                                                       |  293 ++++-
 net/can/j1939/bus.c                                                   |    2 
 net/can/j1939/j1939-priv.h                                            |    3 
 net/can/j1939/main.c                                                  |    8 
 net/can/j1939/transport.c                                             |   22 
 net/ceph/auth_x.c                                                     |    9 
 net/ceph/ceph_common.c                                                |    4 
 net/ceph/mon_client.c                                                 |    4 
 net/ceph/osdmap.c                                                     |   12 
 net/core/dst_cache.c                                                  |    2 
 net/core/filter.c                                                     |    2 
 net/core/lwt_bpf.c                                                    |    4 
 net/core/sock.c                                                       |    1 
 net/core/sock_map.c                                                   |    2 
 net/core/xdp.c                                                        |    2 
 net/hsr/hsr_slave.c                                                   |    2 
 net/ipv4/fib_semantics.c                                              |  101 +
 net/ipv4/fib_trie.c                                                   |    2 
 net/ipv4/icmp.c                                                       |   18 
 net/ipv4/inet_connection_sock.c                                       |   20 
 net/ipv4/ip_tunnel.c                                                  |    2 
 net/ipv4/nexthop.c                                                    |    2 
 net/ipv4/route.c                                                      |   31 
 net/ipv4/tcp_bpf.c                                                    |    4 
 net/ipv4/tcp_ipv4.c                                                   |  292 ++++-
 net/ipv4/udp_offload.c                                                |    4 
 net/ipv6/fib6_rules.c                                                 |    1 
 net/ipv6/icmp.c                                                       |    8 
 net/ipv6/ila/ila_common.c                                             |   12 
 net/ipv6/ila/ila_lwt.c                                                |    4 
 net/ipv6/ip6_fib.c                                                    |   17 
 net/ipv6/ip6_output.c                                                 |   20 
 net/ipv6/ip6_tunnel.c                                                 |    3 
 net/ipv6/ip6mr.c                                                      |    2 
 net/ipv6/ndisc.c                                                      |   12 
 net/ipv6/ping.c                                                       |    2 
 net/ipv6/raw.c                                                        |    6 
 net/ipv6/route.c                                                      |   36 
 net/ipv6/tcp_ipv6.c                                                   |    4 
 net/ipv6/udp.c                                                        |   11 
 net/ipv6/xfrm6_policy.c                                               |    3 
 net/iucv/af_iucv.c                                                    |   21 
 net/l2tp/l2tp_ip6.c                                                   |    2 
 net/l2tp/l2tp_ppp.c                                                   |    1 
 net/mac80211/iface.c                                                  |    8 
 net/mac80211/rx.c                                                     |    2 
 net/mac80211/s1g.c                                                    |    4 
 net/mac802154/llsec.c                                                 |    5 
 net/mpls/af_mpls.c                                                    |    4 
 net/mpls/mpls_iptunnel.c                                              |    2 
 net/mptcp/options.c                                                   |   12 
 net/mptcp/protocol.c                                                  |    1 
 net/ncsi/ncsi-netlink.c                                               |    4 
 net/netfilter/ipset/ip_set_bitmap_gen.h                               |    4 
 net/netfilter/ipset/ip_set_core.c                                     |    6 
 net/netfilter/ipset/ip_set_hash_gen.h                                 |    4 
 net/netfilter/ipset/ip_set_list_set.c                                 |    4 
 net/netfilter/ipvs/ip_vs_app.c                                        |    4 
 net/netfilter/ipvs/ip_vs_conn.c                                       |   44 
 net/netfilter/ipvs/ip_vs_core.c                                       |  230 ++--
 net/netfilter/ipvs/ip_vs_ctl.c                                        |   77 +
 net/netfilter/ipvs/ip_vs_lc.c                                         |    4 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                                 |   21 
 net/netfilter/ipvs/ip_vs_proto_tcp.c                                  |   50 
 net/netfilter/ipvs/ip_vs_proto_udp.c                                  |   54 -
 net/netfilter/ipvs/ip_vs_sync.c                                       |    7 
 net/netfilter/ipvs/ip_vs_xmit.c                                       |   56 -
 net/netfilter/nf_conntrack_broadcast.c                                |    1 
 net/netfilter/nf_conntrack_core.c                                     |    7 
 net/netfilter/nf_conntrack_expect.c                                   |    1 
 net/netfilter/nf_conntrack_h323_main.c                                |   12 
 net/netfilter/nf_conntrack_helper.c                                   |    5 
 net/netfilter/nf_conntrack_netlink.c                                  |   18 
 net/netfilter/nf_conntrack_sip.c                                      |    4 
 net/netfilter/nf_flow_table_core.c                                    |    8 
 net/netfilter/nf_flow_table_ip.c                                      |    4 
 net/netfilter/nf_nat_sip.c                                            |    2 
 net/netfilter/nft_payload.c                                           |   12 
 net/netfilter/nft_rt.c                                                |    2 
 net/netfilter/xt_hashlimit.c                                          |   16 
 net/openvswitch/actions.c                                             |   26 
 net/openvswitch/datapath.c                                            |   54 -
 net/openvswitch/datapath.h                                            |    2 
 net/openvswitch/flow.c                                                |   11 
 net/openvswitch/meter.c                                               |   33 
 net/openvswitch/vport.c                                               |    2 
 net/packet/af_packet.c                                                |   13 
 net/phonet/pep.c                                                      |    2 
 net/qrtr/af_qrtr.c                                                    |    8 
 net/qrtr/ns.c                                                         |   33 
 net/rds/ib.c                                                          |    4 
 net/rds/ib_cm.c                                                       |    4 
 net/rds/recv.c                                                        |   15 
 net/rds/tcp.c                                                         |   14 
 net/sched/act_gact.c                                                  |    5 
 net/sched/act_police.c                                                |    6 
 net/sched/act_tunnel_key.c                                            |   14 
 net/sched/cls_route.c                                                 |   35 
 net/sched/sch_api.c                                                   |    9 
 net/sched/sch_cake.c                                                  |    1 
 net/sctp/associola.c                                                  |   14 
 net/sctp/auth.c                                                       |    2 
 net/sctp/ipv6.c                                                       |    2 
 net/sctp/outqueue.c                                                   |    1 
 net/sctp/sm_make_chunk.c                                              |   26 
 net/sctp/sm_statefuns.c                                               |    8 
 net/sctp/stream.c                                                     |    6 
 net/smc/af_smc.c                                                      |    3 
 net/smc/smc_core.c                                                    |    2 
 net/smc/smc_llc.c                                                     |    3 
 net/smc/smc_rx.c                                                      |   19 
 net/sunrpc/xprtrdma/rpc_rdma.c                                        |    4 
 net/sunrpc/xprtrdma/verbs.c                                           |   12 
 net/tipc/core.c                                                       |    5 
 net/tipc/discover.c                                                   |   14 
 net/tipc/netlink.c                                                    |    6 
 net/tipc/netlink_compat.c                                             |    4 
 net/tipc/node.c                                                       |   15 
 net/tipc/socket.c                                                     |    3 
 net/tls/tls_sw.c                                                      |    2 
 net/unix/af_unix.c                                                    |    2 
 net/unix/garbage.c                                                    |   81 +
 net/vmw_vsock/virtio_transport.c                                      |   14 
 net/wireless/core.c                                                   |    1 
 net/wireless/nl80211.c                                                |   20 
 net/wireless/pmsr.c                                                   |   21 
 net/wireless/scan.c                                                   |    2 
 net/x25/af_x25.c                                                      |    8 
 net/xfrm/xfrm_policy.c                                                |    7 
 scripts/remove-stale-files                                            |    2 
 security/integrity/ima/ima_appraise.c                                 |    9 
 security/keys/keyring.c                                               |   14 
 sound/core/pcm_native.c                                               |    7 
 sound/core/seq/seq_timer.c                                            |   13 
 sound/pci/lx6464es/lx6464es.c                                         |    5 
 sound/pci/lx6464es/lx_core.c                                          |    5 
 sound/soc/amd/ps/pci-ps.c                                             |    2 
 sound/soc/codecs/bt-sco.c                                             |   10 
 sound/soc/codecs/max98090.c                                           |    5 
 sound/soc/codecs/max98095.c                                           |    5 
 sound/soc/codecs/tas2562.c                                            |   35 
 sound/soc/meson/aiu-fifo-spdif.c                                      |    5 
 sound/usb/6fire/chip.c                                                |    4 
 sound/usb/endpoint.c                                                  |   20 
 sound/usb/midi.c                                                      |    2 
 sound/usb/quirks.c                                                    |    2 
 sound/usb/usx2y/usX2Yhwdep.c                                          |    2 
 sound/usb/usx2y/usx2yhwdeppcm.c                                       |    2 
 tools/testing/selftests/alsa/mixer-test.c                             |    1 
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c               |   21 
 tools/testing/selftests/bpf/test_maps.c                               |   13 
 tools/testing/selftests/clone3/clone3_set_tid.c                       |    2 
 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc   |   16 
 tools/testing/selftests/net/af_unix/config                            |    4 
 tools/testing/selftests/net/openvswitch/config                        |   16 
 563 files changed, 6099 insertions(+), 2849 deletions(-)

Aaron Ma (1):
      ice: wait for reset completion in ice_resume()

Abdun Nihaal (3):
      wifi: ipw2100: fix potential memory leak in ipw2100_pci_init_one()
      cpufreq: powernow-k8: Fix possible memory leak in powernowk8_cpu_init()
      can: kvaser_usb: kvaser_usb_hydra_get_busparams(): fix memory leak in kvaser_usb_hydra_get_busparams()

Ahmad Byagowi (1):
      ptp: ocp: Fix board ID over-read

Ahmad Khalifa (6):
      hwmon: (nct6775) Fix IN scaling factors for 6798/6799
      hwmon: (nct6775) Increase and reorder ALARM/BEEP bits
      hwmon: (nct6775) Add support for 18 IN readings for nct6799
      hwmon: (nct6775) Additional TEMP registers for nct6799
      hwmon: (nct6775) Fix register for nct6799
      hwmon: (nct6775) Fix non-existent ALARM warning

Al Viro (1):
      mount: honour SB_NOUSER in the new mount API

Aldo Ariel Panzardo (2):
      rds: drop incoming messages that cross network namespace boundaries
      net: qrtr: restrict socket creation to the initial network namespace

Aleksandr Nogikh (1):
      usb: atm: cxacru: properly kill rcv_urb on error in cxacru_cm()

Aleksandrova Alyona (1):
      RDMA/irdma: Prevent overflows in memory contiguity checks

Alex Deucher (7):
      drm/amdgpu/sdma6.0: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma5.2: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma5.0: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx10: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx11: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx8: drop unecessary BUG_ON()
      drm/amdgpu/gfx9: replace BUG_ON() with WARN_ON()

Alexander Kaplan (1):
      drm/dp: Read the PCON max FRL bandwidth only for HDMI DFPs

Alexei Lazar (2):
      net/mlx5e: Report zero bandwidth for non-ETS traffic classes
      net/mlx5e: Reject unsupported CB Shaper TSA in ETS validation

Anand Moon (1):
      media: meson: vdec: Fix memory leak in error path of vdec_open

Anandu Krishnan E (1):
      misc: fastrpc: fix channel ctx ref leak when session alloc fails

Andrew Pope (1):
      wifi: mac80211: recalculate TIM when a station enters power save

Anna Schumaker (1):
      NFS: Pin the 'struct nfs_server' during a FREE_STATEID call

Ashutosh Desai (3):
      drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply parsers
      drm/dp/mst: fix buffer overflows in sideband chunk accumulation
      drm/dp/mst: fix OOB reads on 2-byte fields in sideband reply parsers

Asim Viladi Oglu Manizada (2):
      pppoe: reload header pointer after dev_hard_header()
      sctp: prevent peer transport count overflow

Aswin Karuvally (1):
      s390/qeth: Check CAP_NET_ADMIN for private ioctls

Avi Weiss (4):
      can: ctucanfd: use self-test mode for PRESUME_ACK
      can: ctucanfd: unmap BAR0 using base address
      can: ctucanfd: handle bus error interrupts
      can: ctucanfd: mark error-active controller status valid

Babanpreet Singh (1):
      counter: microchip-tcb-capture: Fix DT channel validation

Baul Lee (6):
      ALSA: usb-audio: fix OOB write in snd_usbmidi_akai_output()
      ALSA: usb-audio: fix OOB write on Type II inbound URBs
      net: bridge: mrp: fix uninitialised bytes on the wire
      ALSA: usx2y: bound the hwdep mmap fault offset
      vxlan: do not arm the ageing timer on a device that is down
      sctp: keep chunk->transport in step with the list it is queued on

Benjamin Block (1):
      scsi: zfcp: Fix memory leak during adapter release by destroying gid_pn_req

Benjamin Boortz (2):
      pinctrl: microchip-sgpio: add missing select REGMAP_MMIO
      pinctrl: bm1880: add missing select GENERIC_PINCONF

Benjamin Tissoires (1):
      HID: logitech-dj: fix wrong detection of bad DJ_SHORT output report

Boyuan Zhang (2):
      drm/amdgpu/vce: fix integer overflow in image size
      drm/amdgpu: fix division by zero with invalid uvd dimensions

Breno Leitao (1):
      phonet: pep: fix use-after-free in pep_get_sb()

Bryam Vargas (6):
      wifi: mac80211_hwsim: clamp virtio RX length before skb_put
      net/iucv: take a reference on the socket found in afiucv_hs_rcv()
      drm/virtio: bound EDID block reads to the response buffer
      ceph: fix pre-auth out-of-bounds read on snaptrace in ceph_handle_caps()
      net/iucv: fix use-after-free of a severed iucv_path
      thunderbolt: Bound the DROM dual link port number before indexing sw->ports

Candice Li (1):
      drm/amdgpu: restore UMD profile pstate after runtime resume

Ce Sun (1):
      drm/amdgpu: invoke pm_genpd_remove() before freeing genpd

Cen Zhang (2):
      wifi: cfg80211: cancel sched scan results work on unregister
      wifi: mac80211: free AP_VLAN bc_buf SKBs outside IRQ lock

Cen Zhang (Microsoft) (4):
      sctp: validate stream count in sctp_process_strreset_inreq()
      tipc: fix u16 MTU truncation in media and bearer MTU validation
      rhashtable: clear stale iter->p on table restart
      net/openvswitch: check Ethernet header length in key_extract()

Charles Vosburgh (1):
      sctp: validate Adaptation Indication parameter length

Cheng Yongkang (1):
      wifi: ath9k: hif_usb: don't dereference hif_dev after re-arming firmware request

Chengfeng Ye (6):
      bpf, sockmap: Fix cork use-after-free in tcp_bpf_sendmsg()
      Bluetooth: hci_sync: Protect UUID list traversal
      Bluetooth: RFCOMM: Fix session UAF in set_termios
      netfilter: ebt_nflog: pin the NFLOG backend
      ipv4: fix use-after-free in fib_nhc_update_mtu()
      bpf, sockmap: Fix sk_redir use-after-free in send verdict

Chenguang Zhao (5):
      hinic: remove unused ethtool RSS user configuration buffers
      mptcp: decrement subflows counter on failed passive join
      forcedeth: fix UAF of txrx_stats in nv_remove
      net: sxgbe: free TX rings on RX allocation failure
      net: sxgbe: check descriptor ring allocation failures

Chris Gellermann (1):
      selftests/clone3: fix wild pointer access of getline due to missing init

Christian Brauner (4):
      exec: fix unsigned loop counter wrap in transfer_args_to_stack()
      binfmt_misc: set have_execfd only once the interpreter is opened
      binfmt_elf_fdpic: only honour the first PT_INTERP
      binfmt_misc: reject a flag character as the field delimiter

Christian Hewitt (1):
      ASoC: meson: aiu: fifo-spdif: soft reset the S/PDIF datapath on start/stop

Christian Marangi (1):
      net: phylink: put link_gpio if phylink_create fails

Chuck Lever (1):
      xprtrdma: Clear receive-side ownership pointers on release

Chukun Pan (1):
      USB: serial: option: add TDTECH MT5710-CN

Claudiu Beznea (2):
      dmaengine: sh: rz-dmac: Move interrupt request after everything is set up
      pinctrl: renesas: rzg2l: Use -ENOTSUPP instead of -EOPNOTSUPP

Cunhao Lu (1):
      serial: 8250_dma: Clear stale RX state on shutdown

Daehyeon Ko (1):
      tipc: clear sock->sk on the failed-insert path in tipc_sk_create()

Damien Le Moal (2):
      ahci: Introduce ahci_ignore_port() helper
      ata: libahci_platform: Do not set mask_port_map when not needed

Daming Li (1):
      net: smc: fix splice entry lifetime imbalance in smc_rx_splice

Daniel Borkmann (1):
      bpf: Fix ld_{abs,ind} failure path analysis in subprogs

Danila Chernetsov (1):
      RDMA/hns: Fix potential integer overflow in mhop hem cleanup

David Carlier (2):
      media: aspeed: fix missing of_reserved_mem_device_release() on probe failure
      Bluetooth: hci_conn: fix potential UAF in create_big_sync

David Corvaglia (1):
      net: bridge: mrp: fix Option TLV length in MRP_Test frames

David Francis (2):
      drm/amdkfd: Check bounds in allocate_event_notification_slot
      drm/amdkfd: Handle invalid event type in CRIU event restore

David Lechner (2):
      regulator: devres: add API for reference voltage supplies
      regulator: devres: fix devm_regulator_get_enable_read_voltage() return

David Lee (3):
      net/packet: avoid fanout hook re-registration after unregister
      net/x25: fix use-after-free in x25_kill_by_neigh()
      netfilter: ipset: do not update comments from kernel-side hash adds

David Matlack (1):
      KVM: x86/mmu: Rename __direct_map() to direct_map()

Dawei Feng (3):
      wifi: libertas: fix memory leak in helper_firmware_cb()
      smb: client: fix buffer leaks in SMB1 read and write
      e1000: fix memory leak in e1000_probe()

Deepanshu Kartikey (1):
      media: rtl2832: fix use-after-free in rtl2832_remove()

Denis V. Lunev (1):
      qede: sync udp_tunnel ports outside qede_lock in the recovery path

Devin Wittmayer (2):
      wifi: mt76: mt7615: drop TXRX_NOTIFY on non-mmio buses
      wifi: mt76: mt7921: drop TXRX_NOTIFY on non-mmio buses

Diego Fernando Mancera Gomez (1):
      usb: atm: ueagle-atm: reject descriptors that confuse probe and disconnect

Dmitry Antipov (1):
      btrfs: fix memory leak in btrfs_do_encoded_write()

Dmitry Morgun (1):
      wifi: ath11k: fix potential buffer underflow in ath11k_hal_rx_msdu_list_get()

Dmitry Torokhov (3):
      Input: ims-pcu - fix logic error in packet reset
      Input: evdev - sanitize event type index when fetching event masks
      Input: evdev - fix information leak in evdev_pass_values()

Doruk Tan Ozturk (7):
      crypto: rsa-pkcs1pad: Don't WARN on an empty digest
      wifi: mwifiex: fix NULL dereference when the AP has HT-cap but no HT-oper
      vxlan: require CAP_NET_ADMIN in the device netns for changelink
      geneve: require CAP_NET_ADMIN in the device netns for changelink
      mac802154: llsec: reject frames shorter than the authentication tag
      mctp: serial: handle zero-length frames to prevent rx buffer overflow
      net/packet: reset the MAC header on the packet-socket transmit path

Douya Le (3):
      libceph: bound get_version reply decode to front len
      libceph: reject zero bucket types in crush_decode
      libceph: remove debugfs files before client teardown

Eddie Lin (1):
      misc: fastrpc: fix memory leak in fastrpc_channel_ctx_free

Eddie Phillips (1):
      gve: fix Rx queue stall on alloc failure

Edward Adam Davis (1):
      hwmon: (corsair-psu) Stop device IO before calling hid_hw_stop

Emre Cecanpunar (1):
      drm/i915/selftests: Fix GT PM sort comparators

Eric Biggers (3):
      fscrypt: Add missing superblock check in find_or_insert_direct_key()
      fscrypt: Avoid dynamic allocation in fscrypt_get_devices()
      fscrypt: Replace mk_users keyring with simple list

Eric Dumazet (11):
      net: hsr: fix memory leak on slave unregistration by removing synced VLANs
      ipv4: icmp: fill flow parameters in icmp_route_lookup decoy lookup
      ppp: annotate data races in ppp_generic
      ipv6: introduce dst_rt6_info() helper
      net: do not send ICMP/NDISC Redirects when peer allocation fails
      vxlan: re-fetch eth header after route_shortcircuit()
      vxlan: unclone skb head before modifying eth header in route_shortcircuit()
      vxlan: use neigh_ha_snapshot() in route_shortcircuit()
      vxlan: use pskb_network_may_pull() in route_shortcircuit()
      net: remove WARN_ON_ONCE() from sk_mc_loop()
      net/atm: fix slab-out-of-bounds read in vcc_setsockopt()

Eugene Shalygin (3):
      hwmon: (asus-ec-sensors) fix looping over banks while reading from EC
      hwmon: (asus-ec-sensors) fix EC read intervals
      hwmon: (asus-ec-sensors) add missed handle for ENOMEM

Fan Wu (4):
      usb: gadget: f_midi: cancel pending IN work before freeing the midi object
      usb: gadget: udc: bdc: free IRQ and drain func_wake_notify before teardown
      wifi: brcmfmac: make release_scratchbuffers idempotent
      net: hip04: fix RX buffer leak on build_skb failure

Fan XinRan (1):
      net: thunderbolt: Tear down DMA paths before stopping the rings

Fan Ye (1):
      Revert "net: thunderbolt: Enable end-to-end flow control also in transmit"

Farhan Ali (3):
      KVM: s390: pci: Reject adapter interrupt forwarding if already enabled
      KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
      KVM: s390: pci: Validate AIBV and AISB before pinning guest pages

Filipe Manana (1):
      btrfs: fix root leak if its reloc root is unexpected in merge_reloc_roots()

Gaole Zhang (1):
      wifi: ath11k: fix NULL pointer dereference in ath11k_hal_srng_access_begin

Greg Kroah-Hartman (1):
      Linux 6.1.183

Guanghui Yang (1):
      btrfs: free mapping node on duplicate reloc root insert

Guangshuo Li (7):
      dpaa2-switch: put MAC endpoint device on disconnect
      dpaa2-eth: put MAC endpoint device on disconnect
      media: marvell-cam: fix missing pci_disable_device() on remove
      media: vidtv: fix reference leak on failed device registration
      media: vimc: fix reference leak on failed device registration
      intel_th: fix MSC output device reference leak
      can: etas_es58x: es58x_read_bulk_callback(): fix RX buffer leak on URB resubmit failure

Guenter Roeck (10):
      hwmon: (corsair-cpro) Stop device IO before calling hid_hw_stop
      hwmon: (nzxt-smart2) Stop device IO before calling hid_hw_stop
      hwmon: (nct6755) Add support for NCT6799D
      hwmon: (nct6775) Fix access to temperature configuration registers
      hwmon: (nct6775-core) Fix number of temperature registers for NCT6116
      hwmon: (lm90) Only report alarms if driver is ready
      hwmon: (nzxt-smart2) DMA-align output buffer
      hwmon: (nct6775-core) Prevent access to unsupported weight registers
      hwmon: (pmbus) Fix return value from pmbus_update_byte_data()
      hwmon: (pmbus/lm25066) Fix PMBus coefficient calculations

Guixiong Wei (1):
      platform/x86/intel-uncore-freq: Fix current_freq_khz after CPU hotplug

Guoqing Jiang (1):
      RDMA/siw: Only check attrs->cap.max_send_wr in siw_create_qp

H. Nikolaus Schaller (1):
      i2c: jz4780: Cache host clock rate at probe to prevent CCF prepare_lock deadlock

HE WEI (ギカク) (2):
      wifi: cfg80211: bound element ID read when checking non-inheritance
      wifi: mwifiex: bound uAP association event IEs to the event buffer

Haidar Lee (2):
      ASoC: tas2562: fix DVC coefficient write order
      ASoC: tas2562: fix broken entries in the volume lookup table

HanQuan (1):
      sctp: fix auth_chunk_list capacity check in sctp_auth_ep_add_chunkid

Hans Verkuil (2):
      media: vivid: add vivid_update_reduced_fps()
      media: vivid: check for vb2_is_busy() when toggling caps

Harald Freudenberger (2):
      s390/zcrypt: Fix wrong domain value verification with EP11 CPRBs
      s390/zcrypt: Fix missing mem scrub at clear key import in cca_clr2cipherkey()

Harkirat Gill (1):
      drm/amdgpu: cap GTT size to physical RAM on APUs

Harshaka Narayana (1):
      vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for Geneve packets

Heiko Carstens (1):
      seqlock: Allow UBSAN_ALIGNMENT to fail optimizing

Helen Koike (1):
      tipc: fix infinite loop in __tipc_nl_compat_dumpit

Henry Martin (1):
      net/ncsi: fix heap OOB read in NCSI_CMD_SEND_CMD payload length

Hidayath Khan (1):
      net/af_iucv: fix NULL deref in afiucv_hs_callback_syn()

Holger Dengler (2):
      s390/zcrypt: Validate length for CCA AES cipher key requests
      s390/zcrypt: Validate length for CCA ECC private key requests

Hongling Zeng (1):
      dmaengine: sun6i-dma: Fix reclaim descriptors while terminating DMA

Hongyan Xu (2):
      hwmon: (npcm750-pwm-fan): stop fan timer on device detach
      ata: pata_sl82c105: fix bridge revision use-after-free

Huang Wei (1):
      USB: storage: add NO_ATA_1X quirk for Longmai USB Key

Hugo Villeneuve (1):
      serial: sc16is7xx: implement gpio get_direction() callback

Hui Su (1):
      ring-buffer: Fix crash passing ERR_PTR to kthread_stop()

Huihui Huang (2):
      wifi: at76c50x-usb: avoid length underflow in at76_guess_freq()
      wifi: wilc1000: validate assoc response length before subtracting header

Huiwen He (1):
      smb/client: handle overlapping allocated ranges in fallocate

Hungyu Lin (1):
      media: tegra-video: vi: fix invalid u32 return value in format lookup

HyeongJun An (3):
      scsi: libiscsi: Fix stale-data leak into the SCSI sense buffer
      scsi: libiscsi_tcp: Bound SCSI Response data segment to the connection buffer
      HID: logitech-dj: Fix maxfield check in DJ short report validation

Hyunjung Ko (1):
      net/sched: act_gact, act_police: range check the fallback control action

Hyunwoo Kim (1):
      KVM: nVMX: Hide shadow VMCS right after VMCLEAR

Ian Abbott (1):
      comedi: comedi_parport: deal with premature interrupt

Ian Forbes (1):
      drm/vmwgfx: Validate vmw_surface_metadata::array_size

Ibrahim Hashimov (1):
      scsi: scsi_debug: Fix REPORT ZONES alloc_len underflow OOB write

Ilia Gavrilov (1):
      rds: Fix inet6_addr_lst NULL dereference when IPv6 is disabled

Ilya Maximets (3):
      net: openvswitch: fix potential UAF on meter attach failure
      net: openvswitch: fix skb leak on flow key update failure during ct
      net: openvswitch: fix skb leak on flow key update failure during recirculation

Isaac Scott (1):
      media: uvcvideo: Implement dual stream quirk to fix loss of usb packets

Jacob Keller (1):
      i40e: remove read access to debugfs files

Jamal Hadi Salim (2):
      net/sched: act_tunnel_key: Defer dst_release to RCU callback
      net/sched: cls_route: fix fastmap use-after-free on filter

James Gao (1):
      can: peak_usb: add bounds check for USB channel index

James Montgomery (1):
      ksmbd: defer destroy_previous_session() until after NTLM authentication

Jan Höppner (1):
      s390/dasd: Fix potential NULL pointer dereference

Jann Horn (1):
      proc: Fix broken error paths for namespace links

Jason Yan (1):
      scsi: libsas: Abort all in-flight requests when device is gone

Jiale Yao (1):
      Bluetooth: L2CAP: fix UAF in l2cap_le_connect_rsp

Jian Wen (1):
      tcp: add a scheduling point in established_get_first()

Jiangshan Yi (1):
      serial: 8250_mid: Fix NULL function pointer dereference on DNV/ICX-D/SNR platforms

Jiawen Liu (1):
      net: hisilicon: hix5hd2_gmac: remove redundant NAPI delete

Jiayuan Chen (1):
      tcp: fix TFO max_qlen accounting across reuseport migration

Jinchao Wang (1):
      usb: gadget: dummy_hcd: prevent fifo_req reuse during giveback

Johan Hovold (5):
      USB: gadget: snps-udc: fix device name leak on probe failure
      USB: gadget: fsl-udc: fix device name leak on probe failure
      USB: serial: keyspan_pda: fix data loss on receive throttling
      media: cx231xx: fix devres lifetime
      media: vpif_capture: fix OF node reference imbalance

John Garry (1):
      scsi: libsas: Delete struct scsi_core

Joonas Lahtinen (4):
      drm/i915/gem: Add missing nospec on parallel submit slot
      drm/i915: Return NULL on error in active_instance
      drm/i915/gem: Do not leak siblings[] on proto context error
      drm/i915/gem: Fix NULL deref in I915_CONTEXT_PARAM_SSEU

Jordan Rife (5):
      bpf: tcp: Make mem flags configurable through bpf_iter_tcp_realloc_batch
      bpf: tcp: Make sure iter->batch always contains a full bucket snapshot
      bpf: tcp: Get rid of st_bucket_done
      bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch items
      bpf: tcp: Avoid socket skips and repeats during iteration

Jose Fernandez (Anthropic) (1):
      bpf: tcp: Fix use-after-free in bpf_iter_tcp_established_batch()

Jose Maria Casanova Crespo (1):
      drm/vc4: Supply the overflow slot size in BPOS, not the whole bin BO size

Joshua Rogers (2):
      vt: add permission check for KDSKBMETA ioctl
      vt: stabilize tty reference in kbd_keycode with tty_port_tty_get

Josua Mayer (1):
      ata: libahci_platform: support non-consecutive port numbers

Jozsef Kadlecsik (1):
      netfilter: ipset: switch ext_size to atomic64_t

Julian Anastasov (7):
      ipvs: fix the checksum validations
      ipvs: fix places with wrong packet offsets
      ipvs: do not mangle ICMP replies for non-first fragments
      ipvs: avoid out-of-bounds write in ip_vs_nat_icmp
      ipvs: return the csum validation for forward hook
      ipvs: add totalconns for dest
      ipvs: properly update the overload flag on dest edit

Jun Yang (3):
      sctp: don't free the ASCONF's own transport in DEL-IP processing
      vhost: reset the vring metadata cache on vring reconfiguration
      tipc: read le->link under the node lock in tipc_node_link_down()

Junjie Cao (1):
      gpio: pch: use raw_spinlock_t for the register lock

Karl Mehltretter (1):
      pinctrl: devicetree: don't free uninitialized dev_name on error path

Keegan Freyhof (1):
      bnxt_en: Fix PTP PPS setting bug

Keno Fischer (1):
      futex: Prevent robust futex exit race some more

Kiryl Shutsemau (Meta) (2):
      mm/hugetlb: fix swap entry corruption when clearing uffd-wp at fork()
      mm/huge_memory: unlock i_mmap_rwsem before releasing after-split folios

Konrad Dybcio (1):
      pinctrl: qcom: sc8280xp: Add missing wakeup entries for GPIO143/151

Krzysztof Kozlowski (1):
      media: pci: dm1105: Free allocated workqueue

Kuniyuki Iwashima (3):
      af_unix: Set gc_in_progress to true in unix_gc().
      selftest: af_unix: Add Kconfig file.
      af_unix: Give up GC if MSG_PEEK intervened.

Kyle Zeng (3):
      openvswitch: fix GSO userspace truncation underflow
      ipvs: clear IPv4 options after rebasing tunnel ICMP errors
      ipv6: prevent in6_dev_get() from resurrecting inet6_dev

Larisa Grigore (1):
      spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers

Lee Jones (2):
      HID: logitech-dj: Standardise hid_report_enum variable nomenclature
      HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT related user initiated OOB write

Leon Romanovsky (1):
      scsi: target: Clear cmd_cnt when initial counter enrollment fails

Li RongQing (2):
      iommu/intel: Fix out-of-bounds memset in dmar_latency_disable()
      net: ipv6: fix dif and sdif mismatch in raw6_icmp_error

Liem (2):
      i2c: imx: Fix slave registration race and error handling
      i2c: imx: Cancel hrtimer before clearing slave pointer

Lincoln Wallace (1):
      ima: fix out-of-bounds read in xattr_verify()

Link Lin (1):
      mm/page_reporting: use system_freezable_wq to fix UAF during suspend

Lorenzo Bianconi (2):
      wifi: mt76: connac: fix possible NULL-pointer deref in mt76_connac_mcu_uni_bss_he_tlv()
      netfilter: br_netfilter: Reallocate headroom if necessary in neigh_hh_bridge()

Lu Baolu (1):
      iommu/vt-d: Disallow SVA if page walk is not coherent

Lucas Martins Alves (1):
      can: c_can: c_can_chip_config(): keep controller in init mode until bittiming is configured

Luiz Angelo Daros de Luca (8):
      hwmon: (adt7470) Fix fans stuck in manual mode on I2C errors
      hwmon: (adt7470) Fix cache updated before hardware write on I2C error
      hwmon: (adt7470) Fix busy-loop and I2C flooding in update thread
      hwmon: (adt7470) Fix temperature alarm logic in hwmon_temp_read()
      hwmon: (adt7470) Fix swapped PWM3 and PWM4 auto mode masks
      hwmon: (adt7470) Use cached PWM frequency value
      hwmon: (adt7470) Fix divide-by-zero TOCTOU crash in fan speed read
      hwmon: (adt7470) Fix PWM auto temp state array and bounds check

Luiz Augusto von Dentz (1):
      Bluetooth: 6lowpan: Fix using chan->conn as indication to no remote netdev

Luxiao Xu (1):
      audit: fix potential use-after-free in audit_del_rule()

Ma Ke (1):
      media: saa7134: Fix a possible memory leak in saa7134_video_init1

Mahanta Jambigi (1):
      net/smc: fix qentry overwrite for CONFIRM_LINK and ADD_LINK_CONT in smc_llc_event_handler()

Malaya Kumar Rout (1):
      selftests/alsa: Fix memory leak in find_controls error path

Manivannan Sadhasivam (2):
      wifi: ath11k: Flush the posted write after writing to PCIE_SOC_GLOBAL_RESET
      net: qrtr: ns: Limit the maximum server registration per node

Maoyi Xie (1):
      can: peak_usb: peak_usb_start(): fix double free of transfer buffer on URB submit error

Marco Elver (1):
      Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref

Mariano Baragiola (1):
      staging: rtl8723bs: validate monitor transmit frame lengths

Mario Limonciello (2):
      drm/amdgpu: Fix VFCT bus number matching with soft filter
      pinctrl-amd: Don't clear S4 wake bits at probe

Martin Kaiser (1):
      selftests/ftrace: refactor eprobes test to fix argument checks

Masahiro Yamada (1):
      fortify: refactor test_fortify Makefile to fix some build problems

Masami Hiramatsu (Google) (7):
      tracing/eprobe: Fix exact system name matching in eprobe_dyn_event_match()
      tracing/probes: Avoid temporary buffer truncation in trace_probe_match_command_args()
      tracing/probes: Fix potential underflow in LEN_OR_ZERO macro
      tracing/probes: Prevent out-of-bounds write in __trace_probe_log_err()
      tracing/mmiotrace: Reset dropped_count in mmio_reset_data()
      tracing: Check return value of __register_event() in trace_module_add_events()
      tracing/filters: Fix false positive match in regex_match_full()

Matt Vollrath (1):
      igbvf: Fix leak in TX DMA error cleanup

Matthieu Baerts (NGI0) (2):
      selftests: af_unix: add USER_NS config
      selftests: openvswitch: add config file

Maximilian Immanuel Brandtner (1):
      tls: don't abort the connection on signal-interrupted sends

Maíra Canal (1):
      drm/vc4: Zero the tile state data array before each BIN job

Md Sadre Alam (1):
      dmaengine: qcom: bam_dma: Fix command element mask field for BAM v1.6.0+

Melbin K Mathew (1):
      usb: gadget: printer: fix infinite loop in printer_read()

Michael Bommarito (9):
      IB/mad: Drop unmatched RMPP responses before reassembly
      amt: re-read skb header pointers after every pull
      amt: make the head writable before rewriting the L2 header
      mptcp: only set DATA_FIN when a mapping is present
      ila: reload IPv6 header after pskb_may_pull in checksum adjust
      keys: fix out-of-bounds read in keyring_get_key_chunk()
      keys: make keyring key-chunk byte order agree with keyring_diff_objects()
      assoc_array: trim the final shortcut word using the current chunk end
      um: vector: fix use-after-free in vector_mmsg_rx()

Michael Chan (2):
      bnxt_en: Do not set EOP on RX AGG BDs on 5760X chips
      bnxt_en: Disable EOP for TPA on all chips to prevent data corruption

Michael Guralnik (1):
      net/mlx5: fw_tracer, return NULL on create error

Michael Wu (1):
      tracing: Fix race between update_event_fields and, event_define_fields

Michal Luczaj (3):
      bpf, sockmap: Reject unhashed UDP sockets on sockmap update
      selftests/bpf: Adapt sockmap update error handling
      selftests/bpf: Fail unbound UDP on sockmap update

Mike Looijmans (1):
      phy-zynqmp: Postpone getting clock rate until actually needed

Mikko Perttunen (1):
      gpu: host1x: Fix use-after-free in host1x_bo_clear_cached_mappings

MinJea Kim (1):
      staging: rtl8723bs: fix inverted HT40 secondary channel offset

Ming Lei (1):
      ublk: reset kernel-owned dev_info fields in ublk_ctrl_add_dev()

Minhong He (1):
      can: isotp: check register_netdevice_notifier() error in module init

Moksh Panicker (1):
      staging: rtl8723bs: fix OOB reads in rtw_get_wps_ie()

Muhammad Bilal (3):
      usb: gadget: uvc: clamp SEND_RESPONSE length to the response buffer
      staging: rtl8723bs: fix OOB read in rtw_get_wpa_ie()
      staging: rtl8723bs: fix OOB read in WMM_param_handler()

Myeonghun Pak (6):
      media: cec: seco: unregister adapter on IR probe failure
      media: cedrus: clean up media device on probe failure
      media: radio-si476x: Unregister v4l2_device on probe failure
      media: stm32: dcmi: unregister notifier on probe failure
      media: ti: vpe: unwind v4l2 device registration on probe error
      i2c: amd-mp2: Unregister callback on adapter add failure

Namjae Jeon (3):
      exfat: validate cluster allocation bits of the allocation bitmap
      ksmbd: return success for deferred final close
      ksmbd: fix use-after-free in __close_file_table_ids()

Nathan Chancellor (2):
      x86/boot/compressed: Disable jump tables
      fortify: Disable -Wstringop-overread in tests

Nava kishore Manne (3):
      phy: zynqmp: fix L0_TM_DISABLE_SCRAMBLE_ENCODER mask
      phy: zynqmp: use read-modify-write for SERDES scrambler bypass
      phy: zynqmp: keep SERDES scrambler and 8b/10b enabled for USB

Nazim Amirul (2):
      net: stmmac: fix l3l4 filter rejecting unsupported offload requests
      net: stmmac: reset residual action in L3L4 filters on delete

Niklas Cassel (1):
      ata: ahci: Make ahci_ignore_port() handle empty mask_port_map

Nikolay Aleksandrov (1):
      net: bridge: vlan: fix vlan range dumps starting with pvid

Nikunj A Dadhania (1):
      KVM: SVM: Bump asid_generation on CPU online to avoid ASID collision after hotplug

Norbert Szetei (3):
      ppp: defer channel free to an RCU grace period to fix pppol2tp RX UAF
      ALSA: seq: close a re-opened queue timer in the destructor
      ALSA: pcm: wake linked drain waiters on unlink

Oleksij Rempel (1):
      can: j1939: transport: j1939_session_fresh_new(): initialize receive buffer

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

Pablo Neira Ayuso (2):
      netfilter: nf_conntrack_expect: restore helper propagation via expectation
      netfilter: xt_hashlimit: validate hashtable supports XT_HASHLIMIT_RATE_MATCH

Panagiotis Petrakopoulos (1):
      staging: rtl8723bs: fix missing shared-key auth challenge length check

Pavel Ondračka (1):
      drm/radeon: fix r100_copy_blit for large BOs

Pawan Gupta (6):
      bpf: Support for hardening against JIT spraying
      x86/bugs: Enable IBPB flush on BPF JIT allocation
      bpf: Restrict JIT predictor flush to cBPF
      bpf: Skip redundant IBPB in pack allocator
      bpf: Prefer packs that won't trigger an IBPB flush on allocation
      bpf: Prefer dirty packs for eBPF allocations

Pawel Laszczak (1):
      usb: cdnsp: fix incorrect endian conversions for APB timeout register

Pengfei Zhang (1):
      ipv6: fib6: fix NULL deref in fib6_walk_continue() on multi-batch dump

Pengpeng Hou (13):
      mtd: mtdswap: remove debugfs stats file on teardown
      mtd: nand: mtk-ecc: stop on ECC idle timeouts
      drm/i915/gt: use correct selftest config symbol
      hwmon: occ: validate poll response sensor blocks
      iommu/amd: Bound the early ACPI HID map
      media: cedrus: skip invalid H.264 reference list entries
      media: v4l2-ctrls: validate HEVC active reference counts
      can: ems_usb: validate CPC message lengths
      can: kvaser_usb_leaf: kvaser_usb_leaf_wait_cmd(): validate received command extents
      can: softing: fw_parse(): validate firmware record spans
      can: peak_usb: validate uCAN receive record lengths
      can: ctucanfd: add missing MODULE_DEVICE_TABLE()
      net: prestera: validate firmware header length

Peter Zijlstra (2):
      seqlock: Cure some more scoped_seqlock() optimization fails
      seqlock: Allow KASAN to fail optimizing

Phil Rosenthal (1):
      KVM: x86/mmu: Fix use-after-free on vendor module reload

Prashanth Kumar KR (1):
      amd-xgbe: fix MAC_AUTO_SW handling in CL37 AN

Pushpendra Singh (1):
      firmware: arm_scmi: Rate-limit queue-full warnings in IRQ context

Qihang Tang (1):
      net: remove CAP_SYS_RAWIO zero-padding in dev_validate_header

Qing Luo (2):
      sctp: auth: verify auth requirement when auth_chunk is NULL
      sctp: fix addip_serial increment on ASCONF_ACK allocation failure

Qing Ming (1):
      sctp: clear new_transport when removing a peer

Qingfang Deng (3):
      ppp: use IFF_NO_QUEUE in virtual interfaces
      ppp: convert to percpu netstats
      ppp: enable TX scatter-gather

Qingshuang Fu (2):
      hwmon: (nzxt-smart2) Check return value of init_device() in probe
      hwmon: (ads7828) Fix external VREF regulator handling

Radhey Shyam Pandey (3):
      ata: ahci_ceva: fix error paths in ceva_ahci_platform_enable_resources()
      phy: zynqmp: fix clock error handling in xpsgtr_phy_init()
      phy: zynqmp: fix runtime PM leak on probe allocation failure

Rafael J. Wysocki (1):
      Revert "thermal/drivers/hwmon: Cleanup coding style a bit"

Raphael Zimmer (3):
      libceph: Fix multiplication overflow in decode_new_up_state_weight()
      libceph: Reject monmaps advertising zero monitors
      rbd: Reset positive result codes to zero in object map update path

Ricardo Ribalda (1):
      media: uvcvideo: Fix sequence number when no EOF

Rik van Riel (1):
      fbdev: bitblit: bound-check glyph index in bit_cursor()

Rob Herring (1):
      hwmon: (lm25066) Use i2c_get_match_data()

Rosen Penev (3):
      ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is registered
      ata: sata_dwc_460ex: fix clear_interrupt_bit() clearing all pending interrupts
      ata: sata_mv: accept 1 or 2 resources in platform probe

Runyu Xiao (1):
      wifi: brcmfmac: initialize SDIO data work before cleanup

Ruoyu Wang (7):
      RDMA/erdma: initialize ret for empty receive WR lists
      RDMA/siw: publish QP after initialization
      firewire: net: Fix fragmented datagram reassembly
      nfp: Check resource mutex allocation
      wan: wanxl: Only reset hardware after BAR mapping
      wifi: mt76: mt7915: guard HE capability lookups
      drm/mediatek: Check CRTC state before freeing

SJ Park (2):
      mm/damon/core: validate ranges in damon_set_regions()
      mm/damon/core: disallow overlapping input ranges for damon_set_regions()

Samuel Holland (1):
      media: cedrus: Fix missing cleanup in error path

Sandipan Das (1):
      perf/x86/amd/brs: Fix kernel address leakage

Sangho Lee (2):
      Bluetooth: HIDP: reject frames without a transaction header
      Bluetooth: HIDP: validate numbered report payloads

Sasha Levin (1):
      Revert "drm/amd/display: Add missing kdoc for ALLM parameters"

Sean Anderson (1):
      phy: zynqmp: Allow variation in refclk rate

Sean Christopherson (3):
      KVM: SVM: Update x2APIC MSR intercepts if AVIC is inhibited while L2 is active
      KVM: x86: Check for invalid/obsolete root *after* making MMU pages available
      KVM: x86/mmu: WARN and clear role.invalid when creating a child shadow page

Sergey Shtylyov (2):
      drm/rockchip: cdn-dp: add missing check in cdn_dp_config_video()
      media: v4l2-ctrls-request: add NULL check in v4l2_ctrl_request_complete()

Sergey Temerkhanov (1):
      ice: use READ_ONCE() to access cached PHC time

Sergey V. Frolov (1):
      net: octeontx2-pf: Fix UB in shift operation

Seungjin Bae (1):
      Input: ims-pcu - fix heap-buffer-overflow in ims_pcu_process_data()

Shahar Tzarfati (1):
      wifi: iwlwifi: mvm: fix read in wake packet notification handler

Shelley Yang (1):
      wifi: brcmfmac: fix 802.1X-SHA256 call trace warning

Shengjiu Wang (1):
      ASoC: bt-sco: fix duplicate DAPM widget names for wideband DAI

Shuangpeng Bai (2):
      libceph: refresh auth->authorizer_buf{,_len} after authorizer update
      smb: client: Fix use-after-free in cifs_try_adding_channels()

Shuhao Fu (1):
      can: j1939: fix lockless local-destination check

Sidraya Jayagond (1):
      net/smc: fix TOCTOU race between smc_listen_out() and listener close

Sonali Pradhan (4):
      usb: gadget: f_ncm: validate datagram bounds in ncm_unwrap_ntb()
      ALSA: usb-audio: Fix DMA buffer out-of-bounds write when fill_max is set
      ALSA: usb-audio: Clamp frame size in implicit-feedback mode
      usb: gadget: f_ncm: Use unsigned int for ndp_index

Steven Rostedt (1):
      tracing: Fix mmiotrace possible NULL dereferencing of hiter->dev

Suman Ghosh (2):
      octeontx2-vf: set TC flower flag on MCAM entry allocation
      octeontx2-pf: Set correct sequence for carrier off and tx queue stop

Sumit Gupta (1):
      arm64: tegra: Fix CPU compatible string to cortex-a78ae on Tegra234

Sungmin Kang (1):
      net: slip: serialize receive against buffer reallocation

Sunho Park (1):
      USB: serial: io_edgeport: cap received transmit credits

Takashi Iwai (2):
      ALSA: usb-audio: Skip DSD quirk for Musical Fidelity M6s DAC
      ALSA: 6fire: Fix UAF at error handling during probe

Tejun Heo (1):
      sched/psi: Shut down rtpoll_timer in psi_cgroup_free()

Tengda Wu (1):
      ftrace: Add global mutex to serialize trace_parser access

Tetsuo Handa (1):
      can: j1939: use netdevice_tracker for j1939_{priv,session,ecu} tracking

Thorsten Blum (4):
      powerpc/boot: Fix simpleboot CPU node lookup check
      powerpc/boot: Fix treeboot-currituck CPU node lookup check
      powerpc/boot: Fix treeboot-akebono CPU node lookup check
      powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()

Tim Pambor (1):
      USB: serial: ftdi_sio: add support for E+H FXA291

Timur Kristóf (2):
      drm/amdgpu: Fix amdgpu_bo_move() when old_mem and new_mem are both GTT
      drm/amd/pm/ci: Don't disable MCLK DPM on Bonaire 0x6658 (R7 260X)

Toke Høiland-Jørgensen (1):
      net/sched: sch_cake: drop WARN_ON(1) for malformed packets in ACK filter

Tristan Madani (6):
      wifi: ath6kl: fix OOB read from firmware num_msg in TX complete handler
      wifi: ath6kl: fix OOB read from firmware IE lengths in connect event
      wifi: carl9170: bound memcpy length in cmd callback to prevent OOB read
      wifi: carl9170: fix OOB read from off-by-two in TX status handler
      wifi: carl9170: fix buffer overflow in rx_stream failover path
      wifi: ath6kl: fix OOB access from firmware ADDBA window size

Tze Yee Ng (1):
      firmware: stratix10-svc: fix memory leaks and list corruption bugs

Tzung-Bi Shih (1):
      watchdog: pretimeout: Fix UAF in watchdog_unregister_governor()

Uday Khare (3):
      ASoC: tas2562: fix deprecated 'shut-down' GPIO always cleared after lookup
      ASoC: max98095: fix missing IS_ERR() before PTR_ERR() on mclk lookup
      ASoC: max98090: fix missing IS_ERR() before PTR_ERR() on mclk lookup

Unnathi Chalicheemala (1):
      firmware: arm_ffa: Fix NULL dereference in ffa_partition_info_get()

Valery Borovsky (6):
      media: airspy: Return queued buffers on start_streaming() failure
      media: msi2500: Return queued buffers on start_streaming() failure
      media: pwc: Drain fill_buf on start_streaming() failure
      media: pwc: Return queued buffers on start_streaming() failure
      media: rtl2832_sdr: Return queued buffers on start_streaming() failure
      media: sun4i-csi: Return queued buffers on start_streaming() failure

Vijendar Mukunda (1):
      ASoC: amd: ps: fix wrong ACP version string in pci_request_regions()

Vladimir Oltean (1):
      net: dpaa2-eth: assign priv->mac after dpaa2_mac_connect() call

Wang Jun (1):
      media: cx23885: add ioremap return check and cleanup

Weiming Shi (6):
      ipv4: fib: free fib_alias with kfree_rcu() on insert error path
      mpls: fix NULL deref in mpls_valid_fib_dump_req() on CONFIG_INET=n
      ipv6: ndisc: fix NULL deref in accept_untracked_na()
      tipc: fix use-after-free of the discoverer in tipc_disc_rcv()
      vsock/virtio: read virtqueues under worker locks
      vsock/virtio: avoid refilling the RX queue after teardown

Wentao Guan (1):
      bpf: drop bpf_lsm_getselfattr from hook list

Wentao Liang (1):
      drm/nouveau/acr: fix missing nvkm_done() in error path of nvkm_acr_oneinit()

Wilken Gottwalt (1):
      hwmon: (corsair-psu) fix possible out-of-bounds access on missing string termination

Will Deacon (2):
      arm64: syscall: Ensure saved x0 is kept in-sync with tracer updates
      Revert "arm64: syscall: Ensure saved x0 is kept in-sync with tracer updates"

William Palacek (1):
      drm/amdkfd: hold event_mutex while checkpointing CRIU events

Xiang Mei (5):
      btrfs: reject free space cache with more entries than pages
      wifi: p54: validate RX frame length in p54_rx_eeprom_readback()
      Bluetooth: qca: fix NVM tag length underflow in TLV parser
      netfilter: nf_conntrack_sip: widen NAT rewrite delta to s32 in sip_help_tcp()
      rds: tcp: hold the RCU lock across ipv6_chk_addr() in rds_tcp_laddr_check()

Xiang Mei (Microsoft) (8):
      xfrm6: clear dst.dev on error to avoid double netdev_put in xfrm6_fill_dst()
      xfrm: policy: preallocate inexact bins before xfrm_hash_rebuild reinsert
      ksmbd: validate compound request size before reading StructureSize2
      gtp: check skb_pull_data() return in gtp1u_send_echo_resp()
      nexthop: initialize extack in nh_res_bucket_migrate()
      netfilter: nft_payload: fix mask build for partial field offload
      bonding: alb: re-check primary_is_promisc under RTNL in bond_alb_monitor
      bpf: tcp: fix double sock release on batch realloc

Xiangfeng Cai (1):
      mm/hugetlb: fix list corruption in allocate_file_region_entries()

Xie Bo (1):
      RISC-V: KVM: Serialize virtual interrupt pending state updates

Xin Long (2):
      sctp: fix auth_hmacs array size in struct sctp_cookie
      sctp: clear control chunk transport if it is being removed

Xincheng Zhang (1):
      usb: xhci-pci: Limit VIA VL805 DMA addressing to 36 bits

Xingui Yang (1):
      scsi: libsas: Fix HA resume deadlock and hisi_sas disk-wake race

Xu Rao (5):
      cdrom: fix stack out-of-bounds read in CDROMVOLCTRL
      ALSA: lx6464es: fix period byte count for 16-bit streams
      power: supply: bq25890: fix the -10 C NTC lookup entry
      thunderbolt: icm: Preserve USB4 proxy data-valid bit
      scsi: scsi_debug: Negate wrapped memcmp() result

Xu Yang (1):
      usb: chipidea: fix usage_count leak when autosuspend_delay is negative

Xuanqiang Luo (3):
      bpf: lwt: Fix dst reference leak on reroute failure
      net/smc: fix socket use-after-free during link group termination
      udp: fix potential use-after-free in tunnel segmentation

Yael Chemla (1):
      net/mlx5: E-Switch, fix zero num_dest in prio_tag egress vlan rule

Yang Wang (1):
      drm/amd/pm: make pp_features read-only when scpm is enabled

Yangyu Chen (2):
      net: atlantic: free stranded TX buffers on ring deinit
      net: atlantic: free RX pages of consumed but not refilled buffers

Yehyeong Lee (1):
      net: mpls: initialize rtm_tos in mpls_getroute()

Yi Cong (1):
      net: usb: ax88179_178a: fix skb leak in ax88179_tx_fixup()

Yichong Chen (1):
      smb: client: validate DFS referral PathConsumed

Yitang Yang (1):
      io_uring/rw: fix missing ERESTARTSYS conversion in read paths

Yiyang Chen (1):
      bpf: Preserve pointer state for commuted arithmetic

You-Kai Zheng (1):
      btrfs: declare btrfs_ioctl_search_args_v2::buf as __u8

Yousef Alhouseen (1):
      vhost/vdpa: reject overflowing PA map page counts on 32-bit

Youssef Samir (1):
      net: qrtr: ns: Raise node count limit to 512

Yuejie Shi (1):
      ipv6: fix Route Information option length validation

Yuho Choi (1):
      ARM: npcm: Fix OF node refcount leaks in SMP setup

Yuxiang Yang (2):
      sctp: reject stale cookies with mismatched verification tags
      sctp: fix use-after-free of cached ASCONF chunk

Zack Rusin (3):
      drm/vmwgfx: drop dma_buf reference on foreign-fd prime import
      drm/vmwgfx: validate DRAW_PRIMITIVES header size before division
      drm/vmwgfx: bound DMA command body size against suffix pointer

Zhan Xusheng (1):
      audit: fix potential integer overflow in audit_log_n_string()

Zhao Li (7):
      wifi: nl80211: free RNR data on MBSSID mismatch
      wifi: nl80211: validate nested MBSSID IE blobs
      wifi: cfg80211: validate PMSR measurement type data
      wifi: cfg80211: validate PMSR FTM preamble range
      wifi: cfg80211: reject unsupported PMSR FTM location requests
      wifi: mac80211: validate individual TWT params before driver setup
      wifi: mwifiex: use the subframe length when parsing A-MSDU TDLS frames

Zhao Zhang (1):
      libceph: guard missing CRUSH type name lookup

Zhaolong Zhang (1):
      bonding: fix devconf_all NULL dereference when IPv6 is disabled

Zhiling Zou (7):
      ipvs: do not propagate one-packet flag to synced conns
      net: bridge: stop fast-leave after deleting a port group
      net: ipv6: clear suppressed fib6 rule result
      net: openvswitch: reallocate update replies for mismatched IDs
      netfilter: bridge: release template ct on non-IP path
      xdp: reject clones that overrun skb_shared_info tailroom
      ip6_tunnel: clear skb2->cb[] in ip6ip6_err()

Zhu Lingshan (1):
      drm/amdgpu: fix bo->pin leaking in amdgpu_bo_create_reserved

Zhu Yanjun (1):
      RDMA/rxe: Fix a use-after-free problem in rxe_mmap

Zi Yan (1):
      mm/percpu-km: fix bitmap overflow and accounting in pcpu_create_chunk()

Zihan Xi (2):
      tipc: avoid use-after-free in poll trace queue dumps
      ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops

Zijie Huang (1):
      net/sched: reject overly deep qdisc hierarchies

Zile Xiong (1):
      media: vb2: use ssize_t for vb2_read/vb2_write

Zixing Liu (1):
      platform/loongarch: laptop: Explicitly reset bl_powered state when suspend

bui duc phuc (1):
      gpio: pca953x: fix cache_only and IRQ state on restore_context() failure

deepakraog (1):
      tracing: Fix resource leak on mmiotrace trace_pipe close

Łukasz Patron (1):
      net: qrtr: ns: Raise lookup limit to 128

