Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB983370AD4;
	Sun,  9 Aug 2026 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786300612; cv=none; b=EAGFNvz/jiAKvgX4ZVgnRWt5gqBlyDzZwmtxI2rhlZMrtgP7BYystobarLPW/ggb5xwcUHEbAd2EvcoCB13jR8xMuv+nEtl6u4t6lLopDE3sPrLz5inkPXGgDCesMXmrcQWPfn0IsHILxNCZd/7yAznvaQebGNkZyqr9Lhv9mWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786300612; c=relaxed/simple;
	bh=b0ssZeTdLFGnHum26leCC1sGD8DlmxLklQu4bbn6RKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O18+ImHMRpYawoa9IfEFOEmCgIgIjV23v3d0/EEZfcnuwGfaOzHN431BfjhlasIUrcc5/ge1tyLb2VGwsAgV1sp98KJ1dUH1IuYnyeEDs2aI5PIeDLg79rWDnJy8K88bmsFreanJ+qlzbbjEE2W8zKpfnw9A2sblB1j+EB051RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vpO3S0qv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vpO3S0qv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD391F00A3F;
	Sun,  9 Aug 2026 18:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786300607;
	bh=/ZIQz+9ODGbKz6KxUmL51CXMUF/RkZWW69XQT5t7eUo=;
	h=From:To:Cc:Subject:Date;
	b=vpO3S0qva6dnLiPJ/a8+YdAOTiQGk+eUmsOl4OF1Yh5vLL5fCA7EWYxEYSQ7sBPwa
	 qEzI33QKW/LXjMTCKuXOXSmat63E7ZLHSRRrbu+06BUJqp3IzZrEH1N5nIvjHwqZ79
	 x7VpLdGv36XkECR5vRCunF/zW3BtdfzWM3OvI2oc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.1.8
Date: Sun,  9 Aug 2026 20:34:56 +0200
Message-ID: <2026080957-praying-sponsor-cf52@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.1.8 kernel.

All users of the 7.1 kernel series must upgrade.

The updated 7.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arch/arm64/silicon-errata.rst                                      |    4 
 Documentation/devicetree/bindings/ufs/qcom,sa8255p-ufshc.yaml                    |    9 
 Documentation/filesystems/erofs.rst                                              |    9 
 Documentation/networking/af_xdp.rst                                              |   54 
 Documentation/virt/kvm/api.rst                                                   |    6 
 Makefile                                                                         |   10 
 arch/arm64/include/asm/kvm_hypevents.h                                           |    1 
 arch/arm64/kvm/arm.c                                                             |   25 
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                                               |    1 
 arch/arm64/kvm/hyp_trace.c                                                       |   36 
 arch/arm64/kvm/mmu.c                                                             |    4 
 arch/arm64/kvm/vgic/vgic-its.c                                                   |   25 
 arch/arm64/kvm/vgic/vgic-v3.c                                                    |    8 
 arch/arm64/kvm/vgic/vgic.c                                                       |   18 
 arch/powerpc/boot/simpleboot.c                                                   |    2 
 arch/powerpc/boot/treeboot-akebono.c                                             |    2 
 arch/powerpc/boot/treeboot-currituck.c                                           |    2 
 arch/powerpc/platforms/ps3/mm.c                                                  |    1 
 arch/riscv/Makefile                                                              |    2 
 arch/riscv/kernel/unaligned_access_speed.c                                       |    4 
 arch/riscv/mm/init.c                                                             |    7 
 arch/s390/kvm/pci.c                                                              |  107 +
 arch/s390/kvm/pci.h                                                              |    2 
 arch/s390/pci/pci_mmio.c                                                         |    1 
 arch/um/drivers/vector_kern.c                                                    |    3 
 arch/x86/boot/string.c                                                           |   11 
 arch/x86/kernel/cpu/amd.c                                                        |    4 
 arch/x86/kvm/svm/avic.c                                                          |    8 
 arch/x86/kvm/vmx/vmx_ops.h                                                       |    8 
 arch/x86/kvm/x86.c                                                               |    6 
 drivers/accel/qaic/qaic_control.c                                                |    2 
 drivers/acpi/cppc_acpi.c                                                         |   29 
 drivers/ata/ahci_ceva.c                                                          |   18 
 drivers/ata/libata-eh.c                                                          |   37 
 drivers/ata/libata-sata.c                                                        |    2 
 drivers/ata/libata-scsi.c                                                        |  119 +
 drivers/ata/libata.h                                                             |    3 
 drivers/ata/sata_mv.c                                                            |    2 
 drivers/block/ublk_drv.c                                                         |    9 
 drivers/bluetooth/btintel.c                                                      |    3 
 drivers/bluetooth/btmtk.c                                                        |   86 -
 drivers/bluetooth/btusb.c                                                        |   30 
 drivers/cpufreq/cppc_cpufreq.c                                                   |   33 
 drivers/cpufreq/powernow-k8.c                                                    |    1 
 drivers/dibs/dibs_loopback.c                                                     |   47 
 drivers/dma/idxd/cdev.c                                                          |    4 
 drivers/dma/idxd/init.c                                                          |   36 
 drivers/dma/sun6i-dma.c                                                          |   11 
 drivers/dma/switchtec_dma.c                                                      |    2 
 drivers/gpio/gpio-by-pinctrl.c                                                   |   18 
 drivers/gpio/gpio-pca953x.c                                                      |   15 
 drivers/gpio/gpio-pch.c                                                          |   28 
 drivers/gpio/gpio-sloppy-logic-analyzer.c                                        |   10 
 drivers/gpio/gpiolib.c                                                           |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                           |   39 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                                      |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                          |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c                               |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                                          |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                          |   12 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                         |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_events.c                                          |   23 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c                           |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c                                           |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                                |  243 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c                                         |   45 
 drivers/gpu/drm/amd/display/dc/dc.h                                              |    1 
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c                            |   20 
 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c                        |   15 
 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c |   31 
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c                          |   16 
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c                                  |   16 
 drivers/gpu/drm/amd/include/kgd_pp_interface.h                                   |    6 
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                                              |   39 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                                               |   29 
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h                                          |    6 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c                              |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c                            |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c                            |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c                            |    5 
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h                                     |    5 
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c                                |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c                          |    6 
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c                                  |    8 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c                          |    7 
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c                                 |    9 
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c                                  |    5 
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c                               |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c                             |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c                            |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c                             |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c                             |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c                             |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                             |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c                             |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c                             |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c                             |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c                             |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c                             |    3 
 drivers/gpu/drm/bridge/display-connector.c                                       |   11 
 drivers/gpu/drm/display/drm_dp_helper.c                                          |   12 
 drivers/gpu/drm/drm_exec.c                                                       |    6 
 drivers/gpu/drm/drm_gpuvm.c                                                      |    3 
 drivers/gpu/drm/i915/display/intel_ddi.c                                         |    2 
 drivers/gpu/drm/i915/display/intel_dp.c                                          |    9 
 drivers/gpu/drm/i915/display/intel_hdmi.c                                        |   26 
 drivers/gpu/drm/i915/display/intel_hdmi.h                                        |    2 
 drivers/gpu/drm/mediatek/mtk_crtc.c                                              |    6 
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c                                  |    7 
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c                                           |    8 
 drivers/gpu/drm/panthor/panthor_fw.c                                             |   47 
 drivers/gpu/drm/vc4/vc4_irq.c                                                    |    2 
 drivers/gpu/drm/vc4/vc4_validate.c                                               |   29 
 drivers/gpu/drm/vmwgfx/ttm_object.c                                              |    7 
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c                                             |   39 
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c                                     |   49 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                                          |   20 
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c                                            |   13 
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c                                       |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c                                         |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c                                           |   13 
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c                                             |   17 
 drivers/gpu/drm/xe/tests/xe_pci.c                                                |    6 
 drivers/gpu/drm/xe/xe_device.c                                                   |   56 
 drivers/gpu/drm/xe/xe_device.h                                                   |    4 
 drivers/gpu/drm/xe/xe_exec.c                                                     |   22 
 drivers/gpu/drm/xe/xe_gt_debugfs.c                                               |    4 
 drivers/gpu/drm/xe/xe_hw_engine.c                                                |    2 
 drivers/gpu/drm/xe/xe_hw_engine_types.h                                          |    8 
 drivers/gpu/drm/xe/xe_oa.c                                                       |    7 
 drivers/gpu/drm/xe/xe_oa_types.h                                                 |    3 
 drivers/gpu/drm/xe/xe_pci.c                                                      |   15 
 drivers/gpu/drm/xe/xe_pt.c                                                       |   13 
 drivers/gpu/drm/xe/xe_reg_whitelist.c                                            |   87 +
 drivers/gpu/drm/xe/xe_reg_whitelist.h                                            |    4 
 drivers/gpu/drm/xe/xe_vm.c                                                       |    3 
 drivers/hv/mshv_eventfd.c                                                        |   39 
 drivers/hv/mshv_irq.c                                                            |    2 
 drivers/hv/mshv_portid_table.c                                                   |    6 
 drivers/hv/mshv_root_main.c                                                      |   41 
 drivers/hv/mshv_vtl_main.c                                                       |    1 
 drivers/hv/vmbus_drv.c                                                           |   13 
 drivers/hwmon/adt7470.c                                                          |  129 +
 drivers/hwmon/ina2xx.c                                                           |   61 
 drivers/hwmon/lm90.c                                                             |    4 
 drivers/hwmon/ltc4282.c                                                          |    4 
 drivers/hwmon/nct6775-core.c                                                     |   20 
 drivers/hwmon/npcm750-pwm-fan.c                                                  |   11 
 drivers/hwmon/nzxt-smart2.c                                                      |    2 
 drivers/hwmon/pmbus/pmbus_core.c                                                 |    7 
 drivers/hwmon/sht3x.c                                                            |    9 
 drivers/i2c/busses/i2c-amd-mp2-plat.c                                            |    4 
 drivers/i2c/busses/i2c-bcm-iproc.c                                               |   11 
 drivers/i2c/busses/i2c-imx.c                                                     |   54 
 drivers/i2c/busses/i2c-jz4780.c                                                  |    5 
 drivers/i2c/busses/i2c-k1.c                                                      |   10 
 drivers/i2c/busses/i2c-qcom-cci.c                                                |   18 
 drivers/infiniband/hw/mana/main.c                                                |   40 
 drivers/infiniband/hw/mana/mana_ib.h                                             |   14 
 drivers/infiniband/hw/mana/qp.c                                                  |   68 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c                              |   15 
 drivers/iommu/io-pgfault.c                                                       |   24 
 drivers/iommu/iommufd/device.c                                                   |    2 
 drivers/iommu/iommufd/eventq.c                                                   |    2 
 drivers/iommu/iommufd/pages.c                                                    |    3 
 drivers/iommu/iommufd/viommu.c                                                   |   22 
 drivers/media/platform/chips-media/wave5/wave5-hw.c                              |    3 
 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c                         |    5 
 drivers/media/platform/chips-media/wave5/wave5-vpuapi.h                          |    1 
 drivers/net/can/c_can/c_can_main.c                                               |    8 
 drivers/net/can/ctucanfd/ctucanfd_base.c                                         |   14 
 drivers/net/can/ctucanfd/ctucanfd_pci.c                                          |    3 
 drivers/net/can/rcar/rcar_canfd.c                                                |   32 
 drivers/net/can/softing/softing_fw.c                                             |   46 
 drivers/net/can/usb/ems_usb.c                                                    |   43 
 drivers/net/can/usb/etas_es58x/es58x_core.c                                      |    1 
 drivers/net/can/usb/gs_usb.c                                                     |    4 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c                                |    1 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c                                 |   13 
 drivers/net/can/usb/peak_usb/pcan_usb_core.c                                     |    1 
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c                                       |   40 
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c                                      |   20 
 drivers/net/dsa/mt7530-mdio.c                                                    |   11 
 drivers/net/dsa/mt7530.c                                                         |   86 -
 drivers/net/ethernet/intel/e1000/e1000_main.c                                    |    2 
 drivers/net/ethernet/intel/ice/ice_dpll.c                                        |   19 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                                     |   10 
 drivers/net/ethernet/intel/ice/ice_main.c                                        |   10 
 drivers/net/ethernet/intel/ice/ice_vf_lib.c                                      |   27 
 drivers/net/ethernet/intel/ice/ice_vf_lib_private.h                              |    1 
 drivers/net/ethernet/intel/ice/virt/queues.c                                     |   21 
 drivers/net/ethernet/intel/idpf/idpf_dev.c                                       |    2 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                                       |    2 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                                      |    5 
 drivers/net/ethernet/intel/idpf/idpf_txrx.h                                      |    2 
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c                                    |    2 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c                                  |    5 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h                                  |    2 
 drivers/net/ethernet/intel/igbvf/netdev.c                                        |    2 
 drivers/net/ethernet/intel/igc/igc_main.c                                        |    3 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                                  |   12 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h                                  |    1 
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h                                 |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                                  |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c                              |   79 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                              |   97 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c                              |   49 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                             |    8 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                                      |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en.h                                     |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                                |    7 
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c                               |   19 
 drivers/net/ethernet/microsoft/mana/mana_en.c                                    |  143 +-
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c                               |   23 
 drivers/net/ethernet/nvidia/forcedeth.c                                          |    4 
 drivers/net/ethernet/qlogic/qede/qede_main.c                                     |   44 
 drivers/net/ethernet/realtek/rtase/rtase_main.c                                  |    3 
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c                                  |   14 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                                |    3 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                                      |    2 
 drivers/net/phy/phylink.c                                                        |   29 
 drivers/net/veth.c                                                               |    4 
 drivers/net/vxlan/vxlan_core.c                                                   |   21 
 drivers/net/vxlan/vxlan_mdb.c                                                    |    4 
 drivers/net/wireless/ath/ath12k/mac.c                                            |    5 
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c                             |    2 
 drivers/of/address.c                                                             |   22 
 drivers/of/of_reserved_mem.c                                                     |   14 
 drivers/pci/controller/dwc/pci-imx6.c                                            |    9 
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c                                        |    2 
 drivers/phy/xilinx/phy-zynqmp.c                                                  |   62 
 drivers/pinctrl/Kconfig                                                          |    2 
 drivers/pinctrl/devicetree.c                                                     |    4 
 drivers/pinctrl/pinctrl-amd.c                                                    |    3 
 drivers/pinctrl/qcom/pinctrl-msm.c                                               |    8 
 drivers/pinctrl/qcom/pinctrl-sc8280xp.c                                          |   21 
 drivers/power/supply/bq25890_charger.c                                           |    2 
 drivers/power/supply/macsmc-power.c                                              |   52 
 drivers/power/supply/max17040_battery.c                                          |    6 
 drivers/ptp/ptp_netc.c                                                           |   15 
 drivers/s390/block/dasd_eckd.c                                                   |   11 
 drivers/s390/block/dasd_ioctl.c                                                  |    2 
 drivers/s390/crypto/pkey_cca.c                                                   |   15 
 drivers/s390/crypto/zcrypt_api.c                                                 |    4 
 drivers/s390/crypto/zcrypt_ccamisc.c                                             |   89 +
 drivers/s390/crypto/zcrypt_ccamisc.h                                             |    6 
 drivers/s390/net/qeth_core_main.c                                                |    3 
 drivers/s390/scsi/zfcp_aux.c                                                     |    1 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                                           |   10 
 drivers/scsi/libiscsi.c                                                          |    2 
 drivers/scsi/libiscsi_tcp.c                                                      |    8 
 drivers/scsi/libsas/sas_init.c                                                   |   37 
 drivers/scsi/libsas/sas_scsi_host.c                                              |   15 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                                  |    9 
 drivers/scsi/scsi_debug.c                                                        |    8 
 drivers/spi/spi-cadence.c                                                        |   26 
 drivers/spi/spi-nxp-fspi.c                                                       |   83 +
 drivers/spi/spi-qcom-qspi.c                                                      |    3 
 drivers/spi/spi-qpic-snand.c                                                     |   22 
 drivers/target/target_core_iblock.c                                              |    6 
 drivers/target/target_core_transport.c                                           |   12 
 drivers/thunderbolt/xdomain.c                                                    |   40 
 drivers/ufs/core/ufs-rpmb.c                                                      |    2 
 drivers/ufs/core/ufshcd.c                                                        |   46 
 drivers/usb/typec/ucsi/ucsi.c                                                    |   90 -
 drivers/usb/typec/ucsi/ucsi.h                                                    |    1 
 fs/afs/fsclient.c                                                                |    5 
 fs/afs/internal.h                                                                |    3 
 fs/binfmt_misc.c                                                                 |   54 
 fs/btrfs/block-group.c                                                           |   34 
 fs/btrfs/block-rsv.c                                                             |   19 
 fs/btrfs/disk-io.c                                                               |   58 
 fs/btrfs/extent_io.c                                                             |    6 
 fs/btrfs/extent_io.h                                                             |    6 
 fs/btrfs/fs.h                                                                    |    9 
 fs/btrfs/raid56.c                                                                |   15 
 fs/btrfs/super.c                                                                 |    8 
 fs/btrfs/zoned.c                                                                 |   27 
 fs/erofs/Kconfig                                                                 |   36 
 fs/erofs/Makefile                                                                |    1 
 fs/erofs/data.c                                                                  |    4 
 fs/erofs/decompressor_lzma.c                                                     |    3 
 fs/erofs/fscache.c                                                               |  664 ----------
 fs/erofs/inode.c                                                                 |    2 
 fs/erofs/internal.h                                                              |   76 -
 fs/erofs/ishare.c                                                                |  103 -
 fs/erofs/super.c                                                                 |   94 -
 fs/erofs/zdata.c                                                                 |    6 
 fs/iomap/ioend.c                                                                 |   21 
 fs/netfs/buffered_read.c                                                         |   10 
 fs/netfs/internal.h                                                              |    1 
 fs/netfs/main.c                                                                  |    7 
 fs/netfs/objects.c                                                               |   30 
 fs/netfs/read_pgpriv2.c                                                          |    3 
 fs/netfs/rolling_buffer.c                                                        |   22 
 fs/netfs/write_issue.c                                                           |   15 
 fs/ntfs/attrib.c                                                                 |   10 
 fs/ntfs/namei.c                                                                  |    3 
 fs/ntfs/runlist.c                                                                |   50 
 fs/ocfs2/dir.c                                                                   |    5 
 fs/proc/task_mmu.c                                                               |   34 
 fs/smb/client/cifssmb.c                                                          |   12 
 fs/smb/client/inode.c                                                            |    1 
 fs/smb/server/connection.h                                                       |    5 
 fs/smb/server/smb2pdu.c                                                          |   14 
 fs/smb/server/smb_common.c                                                       |   37 
 fs/smb/server/vfs_cache.c                                                        |    6 
 include/acpi/cppc_acpi.h                                                         |    5 
 include/drm/drm_exec.h                                                           |   20 
 include/hyperv/hvhdk_mini.h                                                      |    3 
 include/kvm/arm_vgic.h                                                           |    3 
 include/linux/alloc_tag.h                                                        |    3 
 include/linux/dma/qcom_bam_dma.h                                                 |   21 
 include/linux/ethtool.h                                                          |    1 
 include/linux/iommu.h                                                            |    5 
 include/linux/libata.h                                                           |    6 
 include/linux/memcontrol.h                                                       |   25 
 include/linux/netfilter/nf_conntrack_sip.h                                       |    2 
 include/linux/netfs.h                                                            |    1 
 include/linux/rolling_buffer.h                                                   |    6 
 include/linux/slab.h                                                             |   19 
 include/linux/thunderbolt.h                                                      |    3 
 include/net/bluetooth/hci_core.h                                                 |    4 
 include/net/ip_vs.h                                                              |   45 
 include/net/mana/mana.h                                                          |   15 
 include/net/netfilter/nf_conntrack_expect.h                                      |    3 
 include/net/netfilter/nf_tables.h                                                |    4 
 include/net/xdp_sock.h                                                           |    1 
 include/net/xsk_buff_pool.h                                                      |    9 
 include/scsi/libsas.h                                                            |    3 
 io_uring/cancel.c                                                                |    2 
 io_uring/net.c                                                                   |    1 
 io_uring/tctx.c                                                                  |    7 
 io_uring/tctx.h                                                                  |    1 
 kernel/audit.c                                                                   |   11 
 kernel/auditfilter.c                                                             |    6 
 kernel/events/uprobes.c                                                          |    2 
 kernel/sched/cpufreq_schedutil.c                                                 |   11 
 kernel/sched/deadline.c                                                          |    3 
 kernel/trace/fprobe.c                                                            |    6 
 kernel/trace/ring_buffer.c                                                       |    2 
 kernel/trace/trace_events.c                                                      |    4 
 kernel/trace/trace_events_filter.c                                               |    3 
 kernel/trace/trace_fprobe.c                                                      |   12 
 kernel/trace/trace_mmiotrace.c                                                   |   13 
 kernel/trace/trace_probe.c                                                       |    6 
 lib/alloc_tag.c                                                                  |    9 
 lib/assoc_array.c                                                                |    3 
 lib/test_fortify/Makefile                                                        |    1 
 lib/test_hmm.c                                                                   |    2 
 mm/huge_memory.c                                                                 |   14 
 mm/hugetlb.c                                                                     |   12 
 mm/memcontrol-v1.h                                                               |    6 
 mm/migrate_device.c                                                              |    5 
 mm/mm_init.c                                                                     |   15 
 mm/page_reporting.c                                                              |    6 
 mm/percpu-km.c                                                                   |    2 
 mm/slab.h                                                                        |   28 
 mm/slab_common.c                                                                 |   13 
 mm/slub.c                                                                        |   97 -
 mm/util.c                                                                        |    2 
 mm/vmscan.c                                                                      |   11 
 net/bluetooth/hci_conn.c                                                         |   14 
 net/bluetooth/hci_sync.c                                                         |  216 ++-
 net/bluetooth/hidp/core.c                                                        |   30 
 net/bluetooth/iso.c                                                              |  273 ++--
 net/bluetooth/l2cap_core.c                                                       |    5 
 net/bluetooth/mgmt.c                                                             |   84 -
 net/bluetooth/sco.c                                                              |   22 
 net/bridge/br_mrp.c                                                              |    2 
 net/bridge/br_multicast.c                                                        |    1 
 net/can/isotp.c                                                                  |  330 +++-
 net/can/j1939/bus.c                                                              |    2 
 net/can/j1939/j1939-priv.h                                                       |    3 
 net/can/j1939/main.c                                                             |    8 
 net/can/j1939/transport.c                                                        |    4 
 net/core/lwt_bpf.c                                                               |    4 
 net/core/pktgen.c                                                                |    4 
 net/core/skbuff.c                                                                |   18 
 net/ipv4/fou_core.c                                                              |    2 
 net/ipv4/netfilter/nf_nat_h323.c                                                 |   22 
 net/ipv4/nexthop.c                                                               |   25 
 net/ipv4/route.c                                                                 |    2 
 net/ipv4/udp_tunnel_nic.c                                                        |   32 
 net/ipv6/fib6_rules.c                                                            |    1 
 net/ipv6/ip6_fib.c                                                               |    1 
 net/ipv6/ip6_output.c                                                            |    2 
 net/ipv6/ndisc.c                                                                 |    2 
 net/mac80211/agg-tx.c                                                            |    4 
 net/mac80211/s1g.c                                                               |    4 
 net/mpls/af_mpls.c                                                               |    1 
 net/netfilter/ipset/ip_set_hash_gen.h                                            |    2 
 net/netfilter/ipvs/ip_vs_app.c                                                   |    4 
 net/netfilter/ipvs/ip_vs_conn.c                                                  |  192 ++
 net/netfilter/ipvs/ip_vs_core.c                                                  |  190 +-
 net/netfilter/ipvs/ip_vs_proto_sctp.c                                            |   19 
 net/netfilter/ipvs/ip_vs_proto_tcp.c                                             |   48 
 net/netfilter/ipvs/ip_vs_proto_udp.c                                             |   54 
 net/netfilter/ipvs/ip_vs_xmit.c                                                  |   42 
 net/netfilter/nf_conntrack_expect.c                                              |   35 
 net/netfilter/nf_conntrack_sip.c                                                 |    2 
 net/netfilter/nf_nat_sip.c                                                       |   22 
 net/netfilter/nf_tables_api.c                                                    |   34 
 net/netfilter/nft_payload.c                                                      |   12 
 net/netfilter/xt_hashlimit.c                                                     |   16 
 net/openvswitch/actions.c                                                        |   12 
 net/openvswitch/meter.c                                                          |   33 
 net/rds/tcp.c                                                                    |    8 
 net/sched/cls_u32.c                                                              |    7 
 net/sched/sch_cake.c                                                             |    8 
 net/sctp/associola.c                                                             |    3 
 net/sctp/sm_make_chunk.c                                                         |   17 
 net/smc/smc_core.c                                                               |    2 
 net/tipc/socket.c                                                                |    2 
 net/unix/af_unix.c                                                               |    1 
 net/xdp/xsk.c                                                                    |  255 +++
 net/xdp/xsk_buff_pool.c                                                          |   13 
 net/xdp/xsk_queue.h                                                              |   65 
 security/keys/keyring.c                                                          |   14 
 security/keys/trusted-keys/trusted_dcp.c                                         |   15 
 sound/core/pcm_native.c                                                          |    7 
 sound/core/seq/seq_timer.c                                                       |    9 
 sound/core/timer.c                                                               |    2 
 sound/core/ump.c                                                                 |    1 
 sound/hda/codecs/realtek/alc269.c                                                |    4 
 sound/pci/lx6464es/lx6464es.c                                                    |    5 
 sound/pci/lx6464es/lx_core.c                                                     |    5 
 sound/soc/codecs/max98090.c                                                      |    5 
 sound/soc/codecs/max98095.c                                                      |    5 
 sound/soc/codecs/tas2562.c                                                       |   30 
 sound/soc/codecs/tas2781-i2c.c                                                   |    4 
 sound/soc/fsl/fsl_asrc.c                                                         |    2 
 sound/soc/fsl/fsl_easrc.c                                                        |    2 
 sound/soc/sdca/sdca_device.c                                                     |    2 
 sound/soc/sdca/sdca_fdl.c                                                        |    5 
 sound/soc/sdca/sdca_functions.c                                                  |    2 
 sound/soc/sdca/sdca_ump.c                                                        |    4 
 sound/soc/sophgo/cv1800b-sound-adc.c                                             |   10 
 sound/usb/6fire/chip.c                                                           |    4 
 sound/usb/endpoint.c                                                             |   14 
 sound/usb/midi.c                                                                 |    2 
 sound/usb/midi2.c                                                                |    4 
 sound/usb/mixer_quirks.c                                                         |    2 
 tools/testing/selftests/clone3/clone3_set_tid.c                                  |    2 
 tools/testing/selftests/filesystems/fclog.c                                      |    4 
 tools/testing/selftests/lkdtm/tests.txt                                          |    2 
 tools/testing/selftests/mm/mlock-random-test.c                                   |    2 
 tools/testing/selftests/mm/pagemap_ioctl.c                                       |   56 
 tools/testing/selftests/net/af_unix/.gitignore                                   |    1 
 tools/testing/selftests/net/af_unix/Makefile                                     |    1 
 tools/testing/selftests/net/af_unix/unix_listen.c                                |  187 ++
 tools/testing/selftests/net/netfilter/nft_flowtable.sh                           |   14 
 tools/testing/selftests/seccomp/seccomp_bpf.c                                    |    3 
 tools/tracing/rtla/src/timerlat_top.c                                            |    2 
 454 files changed, 5956 insertions(+), 3358 deletions(-)

Aaron Ma (1):
      ice: wait for reset completion in ice_resume()

Abdun Nihaal (3):
      gpio: sloppy-logic-analyzer: Fix memory leak in gpio_la_poll_probe()
      cpufreq: powernow-k8: Fix possible memory leak in powernowk8_cpu_init()
      can: kvaser_usb: kvaser_usb_hydra_get_busparams(): fix memory leak in kvaser_usb_hydra_get_busparams()

Aboorva Devarajan (1):
      mm/util: don't read __page_2 for order-1 folios in snapshot_page()

Aditya Garg (1):
      net: mana: Return error code from mana_create_rxq()

Alan Swanson (1):
      drm/amd/display: Silence link_dpms I2C retimer failures

Aldo Ariel Panzardo (1):
      Bluetooth: SCO: give the socket its own sco_conn reference

Alex Deucher (1):
      drm/amd/display: check if dml21_add_phantom_plane() is successful

Alex Tran (1):
      gpio: gpio-by-pinctrl: Apply initial value in direction output wrapper

Alexander Kaplan (2):
      drm/i915/dp: Ignore the sink's DSC max FRL rate without a PCON DSC encoder
      drm/dp: Read the PCON max FRL bandwidth only for HDMI DFPs

Alexandru Elisei (1):
      KVM: arm64: Reject guest_memfd memslots when the VM has MTE

Andrei Kuchynski (2):
      usb: typec: ucsi: Fix race condition and ordering in port unregistration
      usb: typec: ucsi: Correct teardown ordering in ucsi_init() error path

Anirudh Srinivasan (1):
      riscv: drop __init from vec_check_unaligned_access_speed_all_cpus

Ao Sun (1):
      scsi: ufs: core: Initialize hba->rpmbs list in ufshcd

Ashutosh Dixit (8):
      drm/xe/rtp: Maintain OA whitelists separately
      drm/xe/rtp: Keep track of non-OA nonpriv slots
      drm/xe/rtp: Generalize whitelist_apply_to_hwe
      drm/xe/rtp: Save OA nonpriv registers to register save/restore lists
      drm/xe/rtp: Toggle 'deny' bit to (de-)whitelist OA regs
      drm/xe/rtp: (De-)whitelist OA registers for all hwe's for a gt
      drm/xe/oa: (De-)whitelist OA registers on OA stream open/release
      drm/xe/rtp: Ensure locking/ref counting for OA whitelists

Asim Viladi Oglu Manizada (1):
      sctp: prevent peer transport count overflow

Aswin Karuvally (1):
      s390/qeth: Check CAP_NET_ADMIN for private ioctls

Avi Weiss (4):
      can: ctucanfd: use self-test mode for PRESUME_ACK
      can: ctucanfd: unmap BAR0 using base address
      can: ctucanfd: handle bus error interrupts
      can: ctucanfd: mark error-active controller status valid

Baochen Qiang (1):
      wifi: ath12k: fix out-of-bounds clear_bit in ath12k_mac_dp_peer_cleanup()

Bart Van Assche (1):
      scsi: ufs: core: Revert "Delegate the interrupt service routine to a threaded IRQ handler"

Baul Lee (4):
      ALSA: ump: fix double free of out_cvts on rawmidi error
      ALSA: usb-audio: fix use-after-free in ump_to_endpoint()
      ALSA: usb-audio: fix stack info leak in RME Digiface status
      ALSA: usb-audio: fix OOB write in snd_usbmidi_akai_output()

Benjamin Block (1):
      scsi: zfcp: Fix memory leak during adapter release by destroying gid_pn_req

Benjamin Boortz (2):
      pinctrl: microchip-sgpio: add missing select REGMAP_MMIO
      pinctrl: bm1880: add missing select GENERIC_PINCONF

Breno Leitao (2):
      mm: memcg: initialize *locked in memcg1_oom_prepare() stub
      uprobes: Fix NULL pointer dereference in hprobe_expire()

Candice Li (1):
      drm/amdgpu: restore UMD profile pstate after runtime resume

Carlo Caione (1):
      of/address: Fix NULL bus dereference in of_pci_range_parser_one()

Carlos López (2):
      KVM: arm64: vgic: Fix race between LPI release and re-registration
      KVM: arm64: vgic: Mitigate potential LPI registration failure

Carlos Song (1):
      i2c: imx: mark I2C adapter when hardware is powered down

Cen Zhang (Microsoft) (1):
      net/sched: cls_u32: validate offshift to prevent shift-out-of-bounds

Chandrakanth Patil (1):
      scsi: mpi3mr: Fix potential deadlock in mpi3mr_fault_uevent_emit

Charles Keepax (4):
      ASoC: SDCA: Correct pointer passed to devm_acpi_table_put
      ASoC: SDCA: Always free firmware in FDL path
      ASoC: SDCA: Make UMP message size check more robust
      ASoC: SDCA: Ensure that Control Range is large enough for header

Charles Vosburgh (1):
      sctp: validate Adaptation Indication parameter length

Chengfeng Ye (2):
      Bluetooth: hci_sync: Fix advertising data UAFs
      net: pktgen: fix proc entry use-after-free

Chenguang Zhao (4):
      forcedeth: fix UAF of txrx_stats in nv_remove
      net: ethernet: mtk_eth_soc: pass eth to mtk_handle_irq_rx in poll_controller
      net: sxgbe: free TX rings on RX allocation failure
      net: sxgbe: check descriptor ring allocation failures

Chris Gellermann (2):
      selftests/mm: fix potential wild pointer access of getline due to missing init
      selftests/clone3: fix wild pointer access of getline due to missing init

Christian Brauner (5):
      binfmt_misc: restore write access when removing an entry
      binfmt_misc: use exe_file_deny_write_access() for the interpreter clone
      binfmt_misc: reject a flag character as the field delimiter
      binfmt_misc: don't let an 'F' entry pin its own instance
      binfmt_misc: don't leak the user namespace when the mount fails

Christian Loehle (3):
      ACPI: CPPC: Skip writes to unsupported performance controls
      ACPI: CPPC: Check all controls for fast switching
      cpufreq: cppc: Sanitize lockless policy limit snapshots

Christian Marangi (1):
      net: phylink: put link_gpio if phylink_create fails

Christoph Hellwig (1):
      iomap: add a separate bio_set for iomap_split_ioend

D Scott Phillips (1):
      KVM: arm64: vgic: Avoid double-deactivate of IRQs in the nested context

Damien Le Moal (3):
      ata: libata-scsi: terminate deferred commands on time out
      ata: libata-scsi: schedule deferred atapi command
      scsi: libsas: terminate deferred commands on time out

Daniel Golle (4):
      net: dsa: mt7530: check bus->read() errors in the MDIO regmap backend
      net: dsa: mt7530: error out on failed reads in ATC/VTCR command polling
      net: dsa: mt7530: error out on failed reads in MT7531 PHY polling
      gpiolib: tolerate gpio-hogs lacking a hogging state

David Carlier (2):
      dmaengine: switchtec-dma: fix FIELD_GET misuse when programming SE threshold
      igc: remove napi_synchronize() in igc_down()

David Corvaglia (1):
      net: bridge: mrp: fix Option TLV length in MRP_Test frames

David Francis (1):
      drm/amdkfd: Handle invalid event type in CRIU event restore

David Howells (4):
      netfs: Fix folio_queue ENOMEM in writeback by adding a mempool
      afs: Fix afs_fs_fetch_data() to set call->async
      afs: Fix afs_fs_fetch_data() to subtract transferred from len
      afs: Fix UAF when sending a message

David Lee (1):
      netfilter: ipset: do not update comments from kernel-side hash adds

Dawei Feng (3):
      smb: client: fix buffer leaks in SMB1 read and write
      e1000: fix memory leak in e1000_probe()
      ice: fix memory leak in ice_lbtest_prepare_rings()

Dawid Osuchowski (1):
      ice: fix VF interrupts cleanup

Denis V. Lunev (1):
      qede: sync udp_tunnel ports outside qede_lock in the recovery path

Dongjiang Zhu (1):
      btrfs: skip global block reserve accounting for rescue mounts

Eckhart Mohr (1):
      ALSA: hda/realtek: Add quirk for TongFang X6SP45xU

Eric Dumazet (7):
      net: do not send ICMP/NDISC Redirects when peer allocation fails
      net: udp_tunnel: fix memory leak in udp_tunnel_nic_unregister()
      vxlan: re-fetch eth header after route_shortcircuit()
      vxlan: unclone skb head before modifying eth header in route_shortcircuit()
      vxlan: use neigh_ha_snapshot() in route_shortcircuit()
      vxlan: use pskb_network_may_pull() for transmit path header pulls
      vxlan: use pskb_network_may_pull() in route_shortcircuit()

Eric Joyner (1):
      ethtool: Embed FEC hist ranges as buffer in struct

Fabrice Derepas (1):
      KEYS: trusted: dcp: fix key_len validation and calc_blob_len() return type

Farhan Ali (6):
      KVM: s390: pci: Reject adapter interrupt forwarding if already enabled
      KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
      KVM: s390: pci: Fix missing error codes and memory unaccounting
      KVM: s390: pci: Fix resource leak on IRQ registration failure
      KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
      KVM: s390: pci: Validate AIBV and AISB before pinning guest pages

Frank Sorenson (1):
      cifs: add fscache_resize_cookie() to cifs_setsize()

Gabriele Monaco (1):
      sched/deadline: Use revised wakeup rule only for running dl_server

Gang Ba (1):
      drm/amdkfd: Fix missing authorization check in KFD_IOC_DBG_TRAP_DISABLE

Gao Xiang (3):
      erofs: clean up erofs_ishare_fill_inode()
      erofs: remove fscache backend entirely
      erofs: ensure valid f_path for page cache sharing

George Zhang (1):
      drm/amd/display: Fix divide-by-zero in calculate_mcache_setting on zero viewport

Greg Kroah-Hartman (4):
      Bluetooth: btusb: Fix short read errors in btusb_qca_send_vendor_req()
      Bluetooth: btmtk: Fix short read errors in btmtk_usb_uhw_reg_read()
      Bluetooth: btmtk: Fix short read errors in btmtk_usb_reg_read()
      Linux 7.1.8

Gregory Price (1):
      mm/vmstat: fold stranded per-cpu node stats when a node comes online

Guanghui Yang (1):
      btrfs: zoned: fix missing chunk metadata reservation

Guangshuo Li (3):
      scsi: ufs: core: Cancel RTC work in active-active suspend
      can: etas_es58x: es58x_read_bulk_callback(): fix RX buffer leak on URB resubmit failure
      drm/mediatek: mtk_hdmi: Fix DDC adapter double put in v2

Guenter Roeck (8):
      hwmon: (nct6775-core) Fix number of temperature registers for NCT6116
      hwmon: (ina2xx) Fix various overflow issues
      hwmon: (ltc4282) Fix reading the minimum alarm voltage
      hwmon: (sht3x) Fix unaligned accesses
      hwmon: (lm90) Only report alarms if driver is ready
      hwmon: (nzxt-smart2) DMA-align output buffer
      hwmon: (nct6775-core) Prevent access to unsupported weight registers
      hwmon: (pmbus) Fix return value from pmbus_update_byte_data()

H. Nikolaus Schaller (1):
      i2c: jz4780: Cache host clock rate at probe to prevent CCF prepare_lock deadlock

Haibo Chen (1):
      spi: spi-nxp-fspi: add per-SoC SDR/DTR clock rate limits for all supported SoCs

Haidar Lee (2):
      ASoC: tas2562: fix DVC coefficient write order
      ASoC: tas2562: fix broken entries in the volume lookup table

Haofeng Li (1):
      selftests/lkdtm: rename STACKLEAK_ERASING to KSTACK_ERASE

Harald Freudenberger (4):
      s390/zcrypt: Fix wrong domain value verification with EP11 CPRBs
      s390/zcrypt: Close speculative mem read possibility
      s390/zcrypt: Fix buffer over-read in cca_cipher2protkey
      s390/zcrypt: Fix missing mem scrub at clear key import in cca_clr2cipherkey()

Hariprasad Kelam (1):
      octeontx2-af: Block VFs from clobbering special CGX PKIND state

Harkirat Gill (1):
      drm/amdgpu: cap GTT size to physical RAM on APUs

Harry Yoo (Oracle) (3):
      mm/slab: decouple SLAB_NO_SHEAVES from SLAB_NO_OBJ_EXT
      lib/alloc_tag: introduce mem_alloc_profiling_permanently_disabled()
      mm/slab: prevent unbounded recursion in free path with new kmalloc type

Hidayath Khan (1):
      dibs: fix use-after-free of dmb_node in loopback attach/detach/unregister

Himal Prasad Ghimiray (1):
      drm/xe/pt: check no-DMA huge-pte cases before DMA segment test

Holger Dengler (2):
      s390/zcrypt: Validate length for CCA AES cipher key requests
      s390/zcrypt: Validate length for CCA ECC private key requests

Hongling Zeng (1):
      dmaengine: sun6i-dma: Fix reclaim descriptors while terminating DMA

Hongyan Xu (1):
      hwmon: (npcm750-pwm-fan): stop fan timer on device detach

HyeongJun An (2):
      scsi: libiscsi: Fix stale-data leak into the SCSI sense buffer
      scsi: libiscsi_tcp: Bound SCSI Response data segment to the connection buffer

Ibrahim Hashimov (1):
      scsi: scsi_debug: Fix REPORT ZONES alloc_len underflow OOB write

Ilya Maximets (3):
      net: openvswitch: fix potential UAF on meter attach failure
      net: openvswitch: fix skb leak on flow key update failure during recirculation
      net: openvswitch: fix skb leak on flow key update failure during ct

Jackson Lee (1):
      media: chips-media: wave5: Support CBP profile

James Gao (1):
      can: peak_usb: add bounds check for USB channel index

Jan Höppner (1):
      s390/dasd: Fix potential NULL pointer dereference

Jason Xing (2):
      xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
      xsk: drain continuation descs after overflow in xsk_build_skb()

Jens Axboe (1):
      io_uring/net: initialize mshot_len for send

Jerome Tollet (1):
      drm/i915/hdmi: Poll for 200 msec for TMDS_Scrambler_Status

Jiakai Xu (1):
      riscv/mm: use physical alignment for vmemmap_start_pfn

Jiale Yao (1):
      Bluetooth: L2CAP: fix UAF in l2cap_le_connect_rsp

Jianing Li (1):
      power: supply: max17040: handle missing status supplier

Jiawen Wu (1):
      net: libwx: fix FDIR ATR queue mismatch for software VLAN packets

Jiri Slaby (SUSE) (1):
      drm/amd/display: use proper context for logging

Johannes Thumshirn (3):
      btrfs: zoned: fix deadlock between metadata writeback and transaction commit
      btrfs: zoned: reset meta_write_pointer on zone reset
      btrfs: zoned: skip fully truncated ordered extents at zone finish

John Ericson (2):
      af_unix: fix listen() succeeding on sockets in the wrong state
      selftests/net/af_unix: test listen() rejects wrong socket states

Jonas Gorski (1):
      i2c: iproc: reset bus after timeout if START_BUSY is stuck

Jonas Köppeler (1):
      net/sched: sch_cake: skip clearing unused tins during rate adjustment

Jori Koolstra (1):
      selftest: fix headers in fclog.c

Jose Maria Casanova Crespo (1):
      drm/vc4: Supply the overflow slot size in BPOS, not the whole bin BO size

Joseph Qi (1):
      ocfs2: fix boundary check in ocfs2_check_dir_entry() to use buffer offset

Joshua Hay (1):
      idpf: adjust TxQ ring count minimum

Julian Anastasov (5):
      ipvs: adjust double hashing when fwd method changes
      ipvs: fix the checksum validations
      ipvs: fix places with wrong packet offsets
      ipvs: do not mangle ICMP replies for non-first fragments
      ipvs: clear the nfct flag under lock

Junjie Cao (1):
      gpio: pch: use raw_spinlock_t for the register lock

Karl Mehltretter (2):
      riscv: mm: Fix out-of-bounds page-table walk during memory hot-remove
      pinctrl: devicetree: don't free uninitialized dev_name on error path

Kefeng Wang (1):
      mm: migrate_device: fix pte_pfn/pte_dirty called on non-present PTE

Kiryl Shutsemau (Meta) (4):
      mm/hugetlb: fix swap entry corruption when clearing uffd-wp at fork()
      fs/proc/task_mmu: fix PAGEMAP_SCAN written state for unpopulated ptes
      fs/proc/task_mmu: fix PAGEMAP_SCAN written state for PMD holes
      mm/huge_memory: unlock i_mmap_rwsem before releasing after-split folios

Konrad Dybcio (1):
      pinctrl: qcom: sc8280xp: Add missing wakeup entries for GPIO143/151

Krishna Kurapati (1):
      phy: qcom: m31-eusb2: Fix return value of init call

Kuan-Ying Lee (1):
      selftests/seccomp: Fix pointer type mismatch build error

Kyumin Lee (1):
      io_uring: preserve task restrictions across exec

Laurent Pinchart (1):
      drm/bridge: display-connector: Fix I2C adapter resource leak

Leo Li (2):
      drm/amd/display: check GRPH_FLIP status before sending event
      drm/amd/display: Exit idle optimizations before programming

Leon Romanovsky (1):
      scsi: target: Clear cmd_cnt when initial counter enrollment fails

Liem (2):
      i2c: imx: Fix slave registration race and error handling
      i2c: imx: Cancel hrtimer before clearing slave pointer

Link Lin (1):
      mm/page_reporting: use system_freezable_wq to fix UAF during suspend

Linmao Li (1):
      i2c: spacemit: request IRQ after controller initialization

Long Li (1):
      net: mana: Create separate EQs for each vPort

Lorenzo Bianconi (1):
      selftests: netfilter: nft_flowtable.sh: fix offload counter verification for tunnel tests

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

Luxiao Xu (1):
      audit: fix potential use-after-free in audit_del_rule()

Maciej Fijalkowski (2):
      xsk: provide sufficient space in pool->tx_descs
      xsk: reclaim invalid Tx descriptors in ZC batch path

Maoyi Xie (1):
      can: peak_usb: peak_usb_start(): fix double free of transfer buffer on URB submit error

Marc Kleine-Budde (1):
      can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on skb allocation failure

Mario Limonciello (1):
      pinctrl-amd: Don't clear S4 wake bits at probe

Masami Hiramatsu (Google) (6):
      fprobe: Fix module reference count leak on error in register_fprobe()
      tracing/mmiotrace: Reset dropped_count in mmio_reset_data()
      tracing/mmiotrace: Add NULL check for mmio_trace_array in logging functions
      ring-buffer: Fix subbuf_ids memory leak in rb_allocate_cpu_buffer() error path
      tracing: Check return value of __register_event() in trace_module_add_events()
      tracing/filters: Fix false positive match in regex_match_full()

Matt Fleming (1):
      veth: convert frag_list skbs before running XDP

Matt Vollrath (2):
      ata: libata-eh: Increase STANDBY IMMEDIATE timeout
      igbvf: Fix leak in TX DMA error cleanup

Matthew Brost (2):
      drm/xe: Set TTM device beneficial_order to 9 (2M)
      drm/xe: Wait on external BO kernel fences in exec IOCTL

Mauricio Faria de Oliveira (1):
      x86/boot: Add volatile, clobbers and zero-length test in memcmp()

Maíra Canal (1):
      drm/vc4: Zero the tile state data array before each BIN job

Md Sadre Alam (1):
      dmaengine: qcom: bam_dma: Fix command element mask field for BAM v1.6.0+

Michael Bommarito (7):
      thunderbolt: Prevent XDomain delayed work use-after-free on disconnect
      keys: fix out-of-bounds read in keyring_get_key_chunk()
      keys: make keyring key-chunk byte order agree with keyring_diff_objects()
      assoc_array: trim the final shortcut word using the current chunk end
      idpf: bound interrupt-vector register fill to the allocated array
      erofs: cap LZMA stream pool size
      um: vector: fix use-after-free in vector_mmsg_rx()

Michael Diesen (1):
      ALSA: hda/realtek: Add quirk for HP Dragonfly Folio G3 2-in-1 (103c:8a05)

Michal Wajdeczko (4):
      drm/xe: Drop unused param from xe_device_create()
      drm/xe: Move xe->info.force_execlist initialization
      drm/xe: Move xe->info.devid|revid initialization
      drm/xe: Separate early xe_device initialization

Ming Lei (1):
      ublk: reset kernel-owned dev_info fields in ublk_ctrl_add_dev()

Minhong He (1):
      can: isotp: check register_netdevice_notifier() error in module init

Muhammad Bilal (1):
      accel/qaic: use sizeof(*trans_hdr) for transaction length check

Myeonghun Pak (2):
      i2c: amd-mp2: Unregister callback on adapter add failure
      drm/mediatek: ovl_adaptor: balance component registrations

Mykola Lysenko (1):
      btrfs: raid56: fix scrub read assembly submitting no reads

Namjae Jeon (7):
      ntfs: preserve RECALL_ON_OPEN on WSL special-file reparse points
      ntfs: harden runlist realloc size calculations
      ntfs: drop stale page-cache when shrinking a non-resident attr
      ksmbd: return success for deferred final close
      ksmbd: fix use-after-free in __close_file_table_ids()
      ksmbd: use memcmp() to compare ClientGUIDs
      ksmbd: reject repeated SMB2 NEGOTIATE requests

Nathan Chancellor (1):
      fortify: Disable -Wstringop-overread in tests

Nava kishore Manne (3):
      phy: zynqmp: fix L0_TM_DISABLE_SCRAMBLE_ENCODER mask
      phy: zynqmp: use read-modify-write for SERDES scrambler bypass
      phy: zynqmp: keep SERDES scrambler and 8b/10b enabled for USB

Nazim Amirul (1):
      net: stmmac: Fix E2E delay mechanism

Nicolas Schier (1):
      kbuild: Stop modifying $(objtree)/Makefile when building oot-kmods oos

Nicolin Chen (3):
      iommu/arm-smmu-v3-iommufd: Require exactly one Stream ID for a vDEVICE
      iommufd/viommu: Release the igroup lock on the vdevice_size error path
      iommufd/viommu: Publish a vDEVICE only after vdevice_init() succeeds

Niklas Cassel (1):
      ata: libata-sata: fix ata_scsi_lpm_supported() iteration

Niklas Schnelle (1):
      s390/pci: Fix s390_pci_mmio_write syscall error return without MIO

Norbert Szetei (3):
      ALSA: pcm: wake linked drain waiters on unlink
      ALSA: seq: Fix division by zero in initialize_timer()
      ALSA: timer: Clear SNDRV_TIMER_IFLG_DEAD once the close completes

Oleksij Rempel (1):
      can: j1939: transport: j1939_session_fresh_new(): initialize receive buffer

Oliver Hartkopp (1):
      can: isotp: fix timer drain order, wakeup handling and tx_gen ordering

Osama Abdelkader (2):
      drm/panthor: reject firmware sections with oversized data
      drm/panthor: validate firmware interface structure sizes

Pablo Neira Ayuso (3):
      netfilter: nf_conntrack_expect: add and use nf_ct_expect_related_pair()
      netfilter: nf_tables: make nft_object rhltable per table
      netfilter: xt_hashlimit: validate hashtable supports XT_HASHLIMIT_RATE_MATCH

Paolo Bonzini (1):
      KVM: VMX: add memory clobber to asm for VMX instructions

Pauli Virtanen (19):
      Bluetooth: ISO: clear iso_data always when detaching conn from hcon
      Bluetooth: ISO: fix CONNECTED -> CLOSED transition on shutdown/release
      Bluetooth: ISO: lock sk in iso_sock_getname
      Bluetooth: ISO: lock sk in iso_connect_ind
      Bluetooth: ISO: fix timeout vs sync_timeout typo in check_bcast_qos
      Bluetooth: ISO: validate sockaddr_iso first in iso_sock_rebind_bis()
      Bluetooth: ISO: hold sk properly in iso_conn_ready
      Bluetooth: ISO: fix leaking sk after socket release
      Bluetooth: ISO: avoid deadlocks in iso_sock_timeout
      Bluetooth: ISO: ensure no dangling hcon references in iso_conn
      Bluetooth: ISO: fix refcounting of iso_conn
      Bluetooth: ISO: fix race of kfree vs kref_get_unless_zero
      Bluetooth: hci_conn: hold conn reference in abort_conn_sync()
      Bluetooth: hci_sync: hold conn in hci_connect_acl/le_sync() callbacks
      Bluetooth: hci_sync: hold conn in hci_connect_big_sync() callback
      Bluetooth: hci_sync: hold conn in hci_connect_pa_sync() callback
      Bluetooth: hci_sync: hold conn in hci_past_sync() callback
      Bluetooth: hci_sync: fix hci_conn_del() use in hci_le_create_conn_sync
      Bluetooth: hci_sync: remove unnecessary hci_conn_get in create_conn_sync

Peiyang He (3):
      iommufd: Reject DMABUF pages from the access pin path
      iommufd: Fix wrong hwpt passed to iommufd_auto_response_faults on replace
      iommu/iommufd: Fix IOPF group ownership UAF

Pengpeng Hou (5):
      can: ems_usb: validate CPC message lengths
      can: kvaser_usb_leaf: kvaser_usb_leaf_wait_cmd(): validate received command extents
      can: softing: fw_parse(): validate firmware record spans
      can: peak_usb: validate uCAN receive record lengths
      can: ctucanfd: add missing MODULE_DEVICE_TABLE()

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: move debug_vm handling to amdgpu_cs_parser_fini

Pratik Vishwakarma (1):
      x86/CPU/AMD: Carve out a Zen5 models range

Przemyslaw Korba (1):
      ice: suppress DPLL errors during reset recovery

Qi Zheng (1):
      mm: mglru: fix stale batch updates after memcg reparenting

Qu Wenruo (3):
      btrfs: fix leaking BTRFS_FS_STATE_REMOUNTING flag
      btrfs: warn about extent buffer that can not be released
      btrfs: raid56: fix an incorrect csum skip during scrub

Radhey Shyam Pandey (3):
      ata: ahci_ceva: fix error paths in ceva_ahci_platform_enable_resources()
      phy: zynqmp: fix clock error handling in xpsgtr_phy_init()
      phy: zynqmp: fix runtime PM leak on probe allocation failure

Ratheesh Kannoth (1):
      octeontx2: cn20k: Coordinate default rules with NIX LF lifecycle

Raushan Patel (2):
      tracing/probes: Reject $arg0 in meta argument expansion
      tracing/fprobe: Roll back on enable_trace_fprobe() failure

Ray Wu (1):
      drm/amd/display: Increase HDMI AV mute wait from 2 to 3 frames

Rosen Penev (1):
      ata: sata_mv: accept 1 or 2 resources in platform probe

Ruoyu Wang (1):
      drm/mediatek: Check CRTC state before freeing

Sang-Heon Jeon (1):
      of: reserved_mem: prevent OOB when too many dynamic regions are defined

Sangho Lee (2):
      Bluetooth: HIDP: reject frames without a transaction header
      Bluetooth: HIDP: validate numbered report payloads

Sasha Finkelstein (1):
      power: supply: macsmc: Support macOS 27 SMC firmware

Sean Christopherson (1):
      KVM: SVM: Update x2APIC MSR intercepts if AVIC is inhibited while L2 is active

Sebastian Andrzej Siewior (1):
      Drivers: hv: vmbus: Replace lockdep_hardirq_threaded() with lockdep annotation

Sergey Senozhatsky (1):
      usb: typec: ucsi: split connector lock classes

Shawn Guo (1):
      scsi: ufs: dt-bindings: Add missing mcq reg for qcom,sa8255p-ufshc

Shengjiu Wang (2):
      ASoC: fsl_asrc: fix m2m_init error path to use goto instead of bare return
      ASoC: fsl_easrc: fix m2m_init error path to use goto instead of bare return

Shuangpeng Bai (1):
      ipv6: release fib6_null_entry on subtree failure

Sneh Mankad (1):
      pinctrl: qcom: Unconditionally mark gpio as wakeup enable

Soeren Moch (1):
      PCI: imx6: Keep i.MX6 Root Port MSI/MSI-X Capabilities with iMSI-RX to work around hardware bug

Sonali Pradhan (2):
      ALSA: usb-audio: Fix DMA buffer out-of-bounds write when fill_max is set
      ALSA: usb-audio: Clamp frame size in implicit-feedback mode

Srikanth Boyapally (1):
      spi: spi-cadence: Move TX FIFO full busy-wait into FIFO

Stanislav Kinsburskii (8):
      mshv: Fix duplicate GSI detection for GSI 0
      mshv: Fix sleeping under spinlock in mshv_portid_alloc
      mshv: Fix race in mshv_irqfd_deassign
      mshv: Fix level-triggered check on uninitialized data
      mshv: Fix missing error code on VP allocation failure
      mshv: Order pt_vp_array publish against irqfd assertion path
      mshv: Publish VP to pt_vp_array before installing the file descriptor
      lib: test_hmm: use device devt for coherent device range selection

Stanislaw Pal (1):
      spi: spi-qpic-snand: write the feature value before executing SET_FEATURE

Stefan Haberland (1):
      s390/dasd: Fix undersized format-check buffer

Suman Ghosh (1):
      octeontx2-pf: Set correct sequence for carrier off and tx queue stop

Surendra Singh Chouhan (1):
      ASoC: sophgo: return 1 on volume change in cv1800b_adc_volume_set()

Takashi Iwai (1):
      ALSA: 6fire: Fix UAF at error handling during probe

TanZheng (1):
      scsi: target: iblock: Fix wrong PR ops NULL check for PREEMPT/RELEASE

Tetsuo Handa (1):
      can: j1939: use netdevice_tracker for j1939_{priv,session,ecu} tracking

Thomas Hellström (1):
      drm/exec: Remove the index parameter from drm_exec_for_each_locked_obj[_reverse]

Thomas Weißschuh (1):
      riscv: vdso: Only try to install vDSO when present

Thorsten Blum (4):
      powerpc/boot: Fix simpleboot CPU node lookup check
      powerpc/boot: Fix treeboot-currituck CPU node lookup check
      powerpc/boot: Fix treeboot-akebono CPU node lookup check
      powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()

Tomas Glozar (1):
      rtla/timerlat_top: Fix on-threshold actions firing on signal

Tu Nguyen (1):
      can: rcar_canfd: change the initializing flow for clocks and resets

Uday Khare (2):
      ASoC: max98095: fix missing IS_ERR() before PTR_ERR() on mclk lookup
      ASoC: max98090: fix missing IS_ERR() before PTR_ERR() on mclk lookup

Usama Arif (1):
      userfaultfd: wait on source PMD during UFFDIO_MOVE

Vijaya Krishna Nivarthi (1):
      spi: qcom-qspi: Correct max DMA length to avoid 64K boundary failure

Vincent Donnefort (5):
      KVM: arm64: Fix hyp_trace clock disabling
      KVM: arm64: Fix potential leak in hyp_trace_buffer_alloc_bpages_backing
      KVM: arm64: Fix hyp_trace_desc allocation size in hyp_trace_load()
      KVM: arm64: Add missing hyp_enter when trapping sysreg
      ring-buffer: Fix reader page read offset for remote buffers

Vincent Jardin (1):
      hwmon: (pmbus/core) notify on the hwmon device, not the i2c client

Vladimir Marioukhine (1):
      drm/amdkfd: fix QID bit leak in pqm_create_queue()

Wei Fang (1):
      ptp: netc: fix potential interrupt storm caused by incorrect unbind order

Wei Liu (1):
      mshv: fix hv_input_get_system_property struct

Weiming Shi (1):
      KVM: x86: Cancel delayed I/O APIC EOI handling before destroying vCPUs

Wenmeng Liu (1):
      i2c: qcom-cci: drop custom suspend/resume and rely on runtime PM helpers

William Palacek (2):
      drm/amdkfd: fix uint32_t overflow in EOP ring buffer size alignment
      drm/amdkfd: hold event_mutex while checkpointing CRIU events

Xiang Mei (2):
      netfilter: nf_conntrack_sip: widen NAT rewrite delta to s32 in sip_help_tcp()
      rds: tcp: hold the RCU lock across ipv6_chk_addr() in rds_tcp_laddr_check()

Xiang Mei (Microsoft) (3):
      netfilter: nft_payload: fix mask build for partial field offload
      nexthop: take nh->lock for f6i_list walks in replace check and notify
      nexthop: avoid unlocked f6i_list walk in nh_rt_cache_flush

Xiangfeng Cai (1):
      mm/hugetlb: fix list corruption in allocate_file_region_entries()

Xingui Yang (1):
      scsi: libsas: Fix HA resume deadlock and hisi_sas disk-wake race

Xu Rao (2):
      ALSA: lx6464es: fix period byte count for 16-bit streams
      power: supply: bq25890: fix the -10 C NTC lookup entry

Xuanqiang Luo (3):
      bpf: lwt: Fix dst reference leak on reroute failure
      fou: Fix use-after-free in fou_create()
      net/smc: fix socket use-after-free during link group termination

Yang Wang (4):
      drm/amd/pm: fix torn gpu metrics reads
      drm/amd/pm: fix pptable use-after-free
      drm/amd/pm: hide pp_table sysfs on APUs
      drm/amd/pm: use milliwatts for GPU power sensors

Yehyeong Lee (1):
      net: mpls: initialize rtm_tos in mpls_getroute()

Yi Xie (1):
      mshv_vtl: fix fd leak in mshv_ioctl_create_vtl()

Yichong Chen (3):
      netfs: clear PG_private_2 on copy-to-cache append failure
      netfs: handle single writeback rolling buffer allocation failure
      netfs: release readahead folios on iterator preparation failure

Yuho Choi (3):
      dmaengine: idxd: fix double free of wq, engine, and group structs
      dmaengine: idxd: fix fdev setup failure cleanup in idxd_cdev_open()
      idpf: Fix mailbox IRQ name leak on request failure

Yun Lu (1):
      rtase: fix double free of multi-frag skb on DMA map failure

Yuxiang Yang (1):
      sctp: reject stale cookies with mismatched verification tags

Zack Rusin (11):
      drm/vmwgfx: fix guest_memory_dirty bitfield clobbered as size
      drm/vmwgfx: reject DX_BIND_QUERY without a DX context
      drm/vmwgfx: clamp dirty-page range with min, not max
      drm/vmwgfx: take fman->lock around fence list mutation in fifo_down
      drm/vmwgfx: drop dma_buf reference on foreign-fd prime import
      drm/vmwgfx: validate DRAW_PRIMITIVES header size before division
      drm/vmwgfx: bound DMA command body size against suffix pointer
      drm/vmwgfx: avoid destroy_workqueue(NULL) on vkms init failure
      drm/vmwgfx: enforce cursor size limits for MOB cursors
      drm/vmwgfx: use check_add_overflow for shader size+offset bound
      drm/vmwgfx: validate external BO copy bounds for both stride paths

Zhan Xusheng (1):
      audit: fix potential integer overflow in audit_log_n_string()

Zhao Li (3):
      wifi: mac80211: validate individual TWT params before driver setup
      wifi: mac80211: fix tid_tx use-after-free on BA session stop
      wifi: mwifiex: use the subframe length when parsing A-MSDU TDLS frames

Zhiling Zou (3):
      ipvs: do not propagate one-packet flag to synced conns
      net: bridge: stop fast-leave after deleting a port group
      net: ipv6: clear suppressed fib6 rule result

Zhongqiu Han (1):
      cpufreq: schedutil: Publish util hooks only after all sg_cpu are initialized

Zi Yan (1):
      mm/percpu-km: fix bitmap overflow and accounting in pcpu_create_chunk()

Zihan Xi (3):
      Bluetooth: mgmt: fix pending command UAF in EIR updates
      Bluetooth: mgmt: fix UAF in pair command cancellation
      tipc: avoid use-after-free in poll trace queue dumps

Zijun Hu (1):
      Bluetooth: btintel: Validate length before parsing diagnostics TLV

bui duc phuc (1):
      gpio: pca953x: fix cache_only and IRQ state on restore_context() failure

wangdicheng (1):
      ASoC: tas2781: Use correct calibration data for SINEGAIN2 register

