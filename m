Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651382836E;
	Mon,  3 Aug 2026 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785749718; cv=none; b=uPo79JHAGl5iecCGJM1Pnnvo6u9oxqAYEDfegY65wNIdZvz63A03gRqR+WMqHmYahYjB4Ke+1k958pGUhLBvPRcBQVZXXUFsdX5wJ6xTtG0SOyPEr/ZBuVlnyp/6g2SoyLiuPjkFAiN/UBU4u3qInzPWmYUz/wQZfHqzJ5wjojE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785749718; c=relaxed/simple;
	bh=Wj8OcqB7jZb7+DhkU56viA6gwu/KHzApULwsztamr10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FMV07ESGiAYU+CfRWcxFsjX/Aaw0MOneAMhMufA4EOOId54CsArfuW46RtvCN9AixcfunuNdKKySK4NgF7D1vPGq5SfbLVHDrMTrKtsidkxnJ13AfFe5AcE3ofZCRmf3FhkP7PrWTncYoXkMuu/mBZQ7RKOGoymffPNhoNHd5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LmlJyru/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LmlJyru/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA6F1F00ACF;
	Mon,  3 Aug 2026 09:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785749706;
	bh=KNUOgy+pJDITLEAjlHYewd4FEHzas5j7ZGx2koS+qw8=;
	h=From:To:Cc:Subject:Date;
	b=LmlJyru/2x+6uDWQi46Nytx/rl9hNZmLRzht+CtkR/cHwe9Qsd1BN3lkshBJtSIkE
	 pnqw4HSmNmqbp2Fqmnabrbq7lDD558wvEeAilJ4gy1pvvxWfBdUZ1PDlf9PDvqdoyZ
	 Vp3bxVhUXBQPoIyEaK2XboC0sllZ539MVIa6nIG8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.42
Date: Mon,  3 Aug 2026 11:34:30 +0200
Message-ID: <2026080331-unadvised-spelling-faa3@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.42 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/gpu/drm-mm.rst                                          |   10 
 Documentation/netlink/specs/rt-link.yaml                              |   40 
 MAINTAINERS                                                           |   13 
 Makefile                                                              |    7 
 arch/arm64/boot/dts/nvidia/tegra234.dtsi                              |   24 
 arch/arm64/boot/dts/nvidia/tegra264.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/lemans.dtsi                                  |    8 
 arch/arm64/boot/dts/qcom/sc7180.dtsi                                  |    4 
 arch/arm64/boot/dts/qcom/sc7280.dtsi                                  |    8 
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                                 |   12 
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                                |   32 
 arch/arm64/boot/dts/qcom/sm6350.dtsi                                  |    4 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                                  |    4 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                                  |    4 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                                  |    4 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                                  |    4 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                                |   77 
 arch/arm64/include/asm/esr.h                                          |    2 
 arch/arm64/mm/hugetlbpage.c                                           |    2 
 arch/loongarch/kernel/acpi.c                                          |   27 
 arch/loongarch/kernel/kgdb.c                                          |    3 
 arch/loongarch/kernel/machine_kexec.c                                 |    5 
 arch/loongarch/kernel/setup.c                                         |    3 
 arch/loongarch/kernel/smp.c                                           |    4 
 arch/powerpc/kernel/time.c                                            |   43 
 arch/powerpc/platforms/85xx/common.c                                  |    2 
 arch/riscv/include/asm/kvm_host.h                                     |   10 
 arch/riscv/kernel/sys_hwprobe.c                                       |    1 
 arch/riscv/kvm/aia.c                                                  |   35 
 arch/riscv/kvm/vcpu.c                                                 |   68 
 arch/riscv/kvm/vcpu_onereg.c                                          |    8 
 arch/s390/kernel/time.c                                               |    1 
 arch/s390/lib/csum-partial.c                                          |    2 
 arch/x86/boot/compressed/Makefile                                     |    1 
 arch/x86/kernel/cpu/resctrl/core.c                                    |   32 
 arch/x86/kernel/cpu/resctrl/internal.h                                |   18 
 arch/x86/kernel/cpu/resctrl/monitor.c                                 |   36 
 arch/x86/kvm/lapic.c                                                  |    2 
 arch/x86/kvm/mmu/mmu.c                                                |   11 
 arch/x86/kvm/mmu/paging_tmpl.h                                        |   10 
 arch/x86/kvm/svm/svm.c                                                |    7 
 arch/x86/kvm/vmx/nested.c                                             |   11 
 drivers/accel/amdxdna/amdxdna_ctx.c                                   |    8 
 drivers/accel/ivpu/ivpu_hw_btrs.c                                     |    2 
 drivers/android/binder/thread.rs                                      |   14 
 drivers/ata/libata-core.c                                             |   18 
 drivers/ata/libata-scsi.c                                             |    2 
 drivers/ata/libata.h                                                  |    9 
 drivers/ata/sata_dwc_460ex.c                                          |   38 
 drivers/block/rbd.c                                                   |    7 
 drivers/block/ublk_drv.c                                              |   52 
 drivers/bluetooth/btqca.c                                             |    2 
 drivers/bluetooth/btusb.c                                             |    4 
 drivers/bluetooth/hci_qca.c                                           |    4 
 drivers/cdrom/cdrom.c                                                 |    1 
 drivers/comedi/drivers/comedi_parport.c                               |   13 
 drivers/cpufreq/cpufreq.c                                             |    3 
 drivers/crypto/tegra/tegra-se-main.c                                  |    3 
 drivers/cxl/Kconfig                                                   |    4 
 drivers/cxl/core/Makefile                                             |    2 
 drivers/cxl/core/core.h                                               |   31 
 drivers/cxl/core/pci.c                                                |  215 -
 drivers/cxl/core/ras.c                                                |  197 +
 drivers/cxl/core/trace.h                                              |   24 
 drivers/cxl/cxl.h                                                     |   22 
 drivers/cxl/cxlpci.h                                                  |   16 
 drivers/dma-buf/udmabuf.c                                             |    9 
 drivers/dma/dw-edma/dw-edma-pcie.c                                    |    7 
 drivers/dma/sh/rz-dmac.c                                              |   96 
 drivers/dpll/dpll_netlink.c                                           |    3 
 drivers/firewire/net.c                                                |   39 
 drivers/firmware/arm_ffa/driver.c                                     |   54 
 drivers/firmware/arm_scmi/notify.c                                    |    6 
 drivers/firmware/stratix10-svc.c                                      |   10 
 drivers/firmware/xilinx/zynqmp.c                                      |    1 
 drivers/gpu/Kconfig                                                   |   13 
 drivers/gpu/Makefile                                                  |    4 
 drivers/gpu/buddy.c                                                   | 1347 ++++++++++
 drivers/gpu/drm/Kconfig                                               |    5 
 drivers/gpu/drm/Kconfig.debug                                         |    1 
 drivers/gpu/drm/Makefile                                              |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c                               |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c                              |   62 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                            |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c                               |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                               |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c                               |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                            |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h                        |   12 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                               |   54 
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c                               |   58 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                               |   17 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                                |   25 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c                          |   79 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h                          |   20 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                                |   22 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                |   13 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                                |   13 
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                                 |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                 |   49 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c                               |   11 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c                              |    2 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c                              |    2 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c                              |    4 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/soc24.c                                    |   28 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                                 |   15 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                              |   12 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c                 |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h                 |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_events.c                               |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                                 |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c                |   24 
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c                                |   23 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                     |  374 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c                |   81 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c          |    9 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c          |    9 
 drivers/gpu/drm/amd/display/dc/link/link_detection.c                  |    5 
 drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c      |    7 
 drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c         |    2 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                                    |   26 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c                        |    7 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c                  |   11 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                  |   15 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c                  |   28 
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c                        |   11 
 drivers/gpu/drm/display/drm_dp_mst_topology.c                         |   36 
 drivers/gpu/drm/drm_buddy.c                                           | 1278 ---------
 drivers/gpu/drm/drm_connector.c                                       |   12 
 drivers/gpu/drm/drm_displayid_internal.h                              |    2 
 drivers/gpu/drm/drm_gpusvm.c                                          |    4 
 drivers/gpu/drm/drm_panel_backlight_quirks.c                          |    9 
 drivers/gpu/drm/i915/display/intel_bios.c                             |   36 
 drivers/gpu/drm/i915/display/intel_dp.c                               |    8 
 drivers/gpu/drm/i915/display/intel_hdcp.c                             |   12 
 drivers/gpu/drm/i915/display/skl_watermark.c                          |    2 
 drivers/gpu/drm/i915/gem/i915_gem_context.c                           |   25 
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c                               |    3 
 drivers/gpu/drm/i915/gt/intel_engine_user.c                           |    2 
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c                              |    8 
 drivers/gpu/drm/i915/i915_active.c                                    |    7 
 drivers/gpu/drm/i915/i915_scatterlist.c                               |   10 
 drivers/gpu/drm/i915/i915_ttm_buddy_manager.c                         |   59 
 drivers/gpu/drm/i915/i915_ttm_buddy_manager.h                         |    4 
 drivers/gpu/drm/i915/selftests/intel_memory_region.c                  |   20 
 drivers/gpu/drm/imagination/pvr_context.c                             |   22 
 drivers/gpu/drm/imagination/pvr_drv.c                                 |   13 
 drivers/gpu/drm/imagination/pvr_queue.c                               |   65 
 drivers/gpu/drm/imagination/pvr_queue.h                               |    2 
 drivers/gpu/drm/imagination/pvr_vm.c                                  |    2 
 drivers/gpu/drm/lib/drm_random.c                                      |   44 
 drivers/gpu/drm/lib/drm_random.h                                      |   28 
 drivers/gpu/drm/nouveau/nouveau_exec.c                                |    4 
 drivers/gpu/drm/nouveau/nouveau_uvmm.c                                |    4 
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c                        |    1 
 drivers/gpu/drm/panel/Kconfig                                         |    1 
 drivers/gpu/drm/panthor/panthor_device.c                              |    5 
 drivers/gpu/drm/panthor/panthor_fw.c                                  |    1 
 drivers/gpu/drm/radeon/r100.c                                         |   13 
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c                        |   18 
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c                       |    2 
 drivers/gpu/drm/rockchip/cdn-dp-reg.c                                 |    2 
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h                              |    2 
 drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c                         |   13 
 drivers/gpu/drm/sysfb/efidrm.c                                        |    7 
 drivers/gpu/drm/sysfb/vesadrm.c                                       |    6 
 drivers/gpu/drm/tests/Makefile                                        |    1 
 drivers/gpu/drm/tests/drm_buddy_test.c                                |  788 -----
 drivers/gpu/drm/tests/drm_exec_test.c                                 |    2 
 drivers/gpu/drm/tests/drm_gem_shmem_test.c                            |   16 
 drivers/gpu/drm/tests/drm_mm_test.c                                   |    2 
 drivers/gpu/drm/tidss/tidss_encoder.c                                 |    2 
 drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c                      |    4 
 drivers/gpu/drm/ttm/tests/ttm_mock_manager.c                          |   18 
 drivers/gpu/drm/ttm/tests/ttm_mock_manager.h                          |    4 
 drivers/gpu/drm/ttm/ttm_pool.c                                        |   34 
 drivers/gpu/drm/v3d/v3d_gem.c                                         |   12 
 drivers/gpu/drm/vc4/vc4_bo.c                                          |   12 
 drivers/gpu/drm/virtio/virtgpu_gem.c                                  |   14 
 drivers/gpu/drm/virtio/virtgpu_kms.c                                  |    5 
 drivers/gpu/drm/virtio/virtgpu_vq.c                                   |    6 
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c                               |   22 
 drivers/gpu/drm/xe/xe_bo.c                                            |   58 
 drivers/gpu/drm/xe/xe_bo.h                                            |    3 
 drivers/gpu/drm/xe/xe_bo_types.h                                      |    2 
 drivers/gpu/drm/xe/xe_dma_buf.c                                       |    2 
 drivers/gpu/drm/xe/xe_guc_buf.c                                       |   44 
 drivers/gpu/drm/xe/xe_guc_buf.h                                       |    1 
 drivers/gpu/drm/xe/xe_i2c.c                                           |    5 
 drivers/gpu/drm/xe/xe_migrate.c                                       |   62 
 drivers/gpu/drm/xe/xe_migrate.h                                       |    4 
 drivers/gpu/drm/xe/xe_pt.c                                            |   14 
 drivers/gpu/drm/xe/xe_res_cursor.h                                    |   34 
 drivers/gpu/drm/xe/xe_sa.c                                            |   67 
 drivers/gpu/drm/xe/xe_sa.h                                            |   20 
 drivers/gpu/drm/xe/xe_sa_types.h                                      |    3 
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.c                                  |   42 
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.h                                  |    4 
 drivers/gpu/drm/xe/xe_svm.c                                           |   18 
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c                                  |   71 
 drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h                            |    4 
 drivers/gpu/drm/xe/xe_vm.c                                            |   10 
 drivers/gpu/drm/xe/xe_wopcm.c                                         |   15 
 drivers/gpu/host1x/bus.c                                              |    4 
 drivers/gpu/tests/Makefile                                            |    4 
 drivers/gpu/tests/gpu_buddy_test.c                                    |  788 +++++
 drivers/gpu/tests/gpu_random.c                                        |   44 
 drivers/gpu/tests/gpu_random.h                                        |   28 
 drivers/hwmon/asus-ec-sensors.c                                       |   18 
 drivers/hwmon/corsair-cpro.c                                          |    1 
 drivers/hwmon/corsair-psu.c                                           |    1 
 drivers/hwmon/gigabyte_waterforce.c                                   |    4 
 drivers/hwmon/nzxt-kraken3.c                                          |    6 
 drivers/hwmon/nzxt-smart2.c                                           |    2 
 drivers/hwmon/occ/common.c                                            |   38 
 drivers/hwtracing/intel_th/core.c                                     |   10 
 drivers/hwtracing/intel_th/msu.c                                      |    2 
 drivers/i3c/master/mipi-i3c-hci/core.c                                |   16 
 drivers/i3c/master/mipi-i3c-hci/hci.h                                 |    1 
 drivers/infiniband/core/cma.c                                         |    2 
 drivers/infiniband/core/mad.c                                         |   30 
 drivers/infiniband/core/umem_dmabuf.c                                 |   61 
 drivers/infiniband/hw/erdma/erdma_qp.c                                |    2 
 drivers/infiniband/hw/hns/hns_roce_hem.c                              |    2 
 drivers/infiniband/hw/irdma/uk.c                                      |    9 
 drivers/infiniband/hw/irdma/user.h                                    |    1 
 drivers/infiniband/hw/irdma/verbs.c                                   |   33 
 drivers/infiniband/hw/mana/wr.c                                       |    2 
 drivers/infiniband/sw/siw/siw_verbs.c                                 |   44 
 drivers/input/misc/ims-pcu.c                                          |   32 
 drivers/iommu/amd/init.c                                              |    6 
 drivers/iommu/amd/iommu.c                                             |   22 
 drivers/iommu/intel/perf.c                                            |    2 
 drivers/iommu/intel/svm.c                                             |    2 
 drivers/md/dm-verity-fec.c                                            |  110 
 drivers/md/dm-verity-fec.h                                            |    6 
 drivers/md/dm.c                                                       |   11 
 drivers/media/cec/platform/seco/seco-cec.c                            |    6 
 drivers/media/common/videobuf2/videobuf2-core.c                       |   12 
 drivers/media/dvb-frontends/rtl2832.c                                 |    4 
 drivers/media/dvb-frontends/rtl2832_sdr.c                             |   19 
 drivers/media/i2c/alvium-csi2.c                                       |   21 
 drivers/media/i2c/imx219.c                                            |    2 
 drivers/media/pci/cx23885/cx23885-core.c                              |   14 
 drivers/media/pci/dm1105/dm1105.c                                     |    1 
 drivers/media/pci/intel/ipu6/ipu6-isys-dwc-phy.c                      |   26 
 drivers/media/pci/saa7134/saa7134-video.c                             |   25 
 drivers/media/platform/amlogic/c3/isp/c3-isp-params.c                 |    4 
 drivers/media/platform/aspeed/aspeed-video.c                          |    1 
 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c              |   29 
 drivers/media/platform/marvell/cafe-driver.c                          |    1 
 drivers/media/platform/nuvoton/npcm-video.c                           |   34 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c                   |    2 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h                   |   16 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c               |    1 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c                     |    9 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c                    |   11 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c                   |   20 
 drivers/media/platform/qcom/camss/camss-csid-680.c                    |   30 
 drivers/media/platform/qcom/camss/camss-csid-gen2.c                   |   47 
 drivers/media/platform/qcom/camss/camss-csid-gen3.c                   |   28 
 drivers/media/platform/qcom/iris/iris_probe.c                         |    6 
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h             |    1 
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c                |   17 
 drivers/media/platform/st/stm32/stm32-dcmi.c                          |    1 
 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c         |    6 
 drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c                    |    6 
 drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c                  |    4 
 drivers/media/platform/ti/davinci/vpif_capture.c                      |    2 
 drivers/media/platform/ti/vpe/vpe.c                                   |    3 
 drivers/media/platform/verisilicon/hantro_v4l2.c                      |    6 
 drivers/media/radio/radio-si476x.c                                    |    1 
 drivers/media/test-drivers/vidtv/vidtv_bridge.c                       |    4 
 drivers/media/test-drivers/vimc/vimc-core.c                           |    1 
 drivers/media/test-drivers/vivid/vivid-core.c                         |    6 
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
 drivers/media/v4l2-core/v4l2-fwnode.c                                 |    6 
 drivers/media/v4l2-core/v4l2-subdev.c                                 |    4 
 drivers/misc/mei/bus.c                                                |   16 
 drivers/misc/nsm.c                                                    |    3 
 drivers/mmc/host/vub300.c                                             |   24 
 drivers/mtd/maps/vmu-flash.c                                          |    8 
 drivers/mtd/mtdcore.c                                                 |   23 
 drivers/mtd/mtdswap.c                                                 |    5 
 drivers/mtd/nand/ecc-mtk.c                                            |   16 
 drivers/net/amt.c                                                     |  101 
 drivers/net/bonding/bond_main.c                                       |    3 
 drivers/net/ethernet/airoha/airoha_eth.c                              |    3 
 drivers/net/ethernet/airoha/airoha_npu.c                              |    4 
 drivers/net/ethernet/airoha/airoha_ppe.c                              |    1 
 drivers/net/ethernet/amd/pds_core/adminq.c                            |   12 
 drivers/net/ethernet/amd/pds_core/auxbus.c                            |   17 
 drivers/net/ethernet/amd/pds_core/core.c                              |   22 
 drivers/net/ethernet/amd/pds_core/devlink.c                           |    6 
 drivers/net/ethernet/amd/pds_core/main.c                              |   14 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                             |   11 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                      |    1 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c                   |    1 
 drivers/net/ethernet/freescale/fman/fman_dtsec.c                      |   17 
 drivers/net/ethernet/google/gve/gve.h                                 |    3 
 drivers/net/ethernet/google/gve/gve_rx_dqo.c                          |   34 
 drivers/net/ethernet/hisilicon/hip04_eth.c                            |   11 
 drivers/net/ethernet/huawei/hinic/hinic_dev.h                         |    2 
 drivers/net/ethernet/huawei/hinic/hinic_ethtool.c                     |   21 
 drivers/net/ethernet/intel/ice/ice.h                                  |    3 
 drivers/net/ethernet/intel/ice/ice_eswitch.c                          |    3 
 drivers/net/ethernet/intel/ice/ice_lag.c                              |    2 
 drivers/net/ethernet/intel/ice/ice_parser.c                           |    3 
 drivers/net/ethernet/intel/ice/ice_ptp.c                              |    7 
 drivers/net/ethernet/intel/ice/ice_sriov.c                            |   14 
 drivers/net/ethernet/intel/ice/ice_vf_lib.c                           |    3 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                       |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                       |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c                 |    9 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c                   |    8 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c               |    1 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c                  |   29 
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c                    |   15 
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c                  |   19 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                     |    4 
 drivers/net/ethernet/mellanox/mlx5/core/esw/acl/helper.c              |    2 
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h                   |    4 
 drivers/net/ethernet/mellanox/mlx5/core/port.c                        |   39 
 drivers/net/ethernet/microsoft/mana/gdma_main.c                       |   78 
 drivers/net/ethernet/microsoft/mana/mana_en.c                         |   13 
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c             |    3 
 drivers/net/ethernet/realtek/rtase/rtase.h                            |    8 
 drivers/net/ethernet/realtek/rtase/rtase_main.c                       |  197 +
 drivers/net/ethernet/stmicro/stmmac/common.h                          |    3 
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c                     |   31 
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c                  |    5 
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c                   |  162 +
 drivers/net/ethernet/stmicro/stmmac/dwmac100.h                        |    9 
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h                       |   16 
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c                  |   49 
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c                   |   16 
 drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c                   |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c                    |    3 
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h                          |   49 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c                     |   53 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c                      |   44 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h                      |   16 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c                      |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h                       |   10 
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c                       |   10 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h                        |   34 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c                   |   45 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c                    |   75 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                     |   92 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                       |   35 
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c                       |    1 
 drivers/net/geneve.c                                                  |    3 
 drivers/net/gtp.c                                                     |   17 
 drivers/net/ipa/ipa_smp2p.c                                           |   30 
 drivers/net/mctp/mctp-i3c.c                                           |   11 
 drivers/net/mctp/mctp-serial.c                                        |    2 
 drivers/net/ovpn/io.c                                                 |    4 
 drivers/net/ovpn/peer.c                                               |   16 
 drivers/net/ovpn/tcp.c                                                |    6 
 drivers/net/pcs/pcs-xpcs.c                                            |   32 
 drivers/net/phy/marvell.c                                             |    2 
 drivers/net/ppp/ppp_generic.c                                         |  237 +
 drivers/net/ppp/pppoe.c                                               |    1 
 drivers/net/slip/slip.c                                               |    4 
 drivers/net/vmxnet3/vmxnet3_drv.c                                     |   22 
 drivers/net/vxlan/vxlan_core.c                                        |    3 
 drivers/net/vxlan/vxlan_mdb.c                                         |   30 
 drivers/net/wan/wanxl.c                                               |    3 
 drivers/net/wireless/ath/ath11k/ahb.c                                 |    1 
 drivers/net/wireless/ath/ath11k/dp_rx.c                               |    3 
 drivers/net/wireless/ath/ath11k/pci.c                                 |    4 
 drivers/net/wireless/ath/ath11k/qmi.c                                 |   11 
 drivers/net/wireless/ath/ath12k/pci.c                                 |    4 
 drivers/net/wireless/ath/ath6kl/txrx.c                                |   12 
 drivers/net/wireless/ath/ath6kl/wmi.c                                 |   20 
 drivers/net/wireless/ath/ath9k/hif_usb.c                              |    7 
 drivers/net/wireless/ath/carl9170/rx.c                                |    7 
 drivers/net/wireless/ath/carl9170/tx.c                                |    2 
 drivers/net/wireless/atmel/at76c50x-usb.c                             |    7 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c             |    1 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c           |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c               |    8 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c               |    2 
 drivers/net/wireless/intel/ipw2x00/ipw2100.c                          |    8 
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c                          |    9 
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c                    |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                           |    3 
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                           |   10 
 drivers/net/wireless/intersil/p54/txrx.c                              |    8 
 drivers/net/wireless/marvell/libertas/firmware.c                      |    1 
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c                      |   14 
 drivers/net/wireless/marvell/mwifiex/tdls.c                           |    2 
 drivers/net/wireless/marvell/mwifiex/uap_event.c                      |   24 
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c                       |    6 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c                  |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                       |   18 
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c                       |   10 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c                       |   13 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                      |    3 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                       |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                       |   19 
 drivers/net/wireless/microchip/wilc1000/hif.c                         |    5 
 drivers/net/wireless/virtual/mac80211_hwsim.c                         |    1 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                               |    8 
 drivers/platform/loongarch/loongson-laptop.c                          |    1 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c |    7 
 drivers/pmdomain/imx/imx93-blk-ctrl.c                                 |  118 
 drivers/ptp/ptp_netc.c                                                |    1 
 drivers/ptp/ptp_s390.c                                                |    6 
 drivers/regulator/mt6358-regulator.c                                  |    2 
 drivers/remoteproc/xlnx_r5_remoteproc.c                               |   50 
 drivers/scsi/hosts.c                                                  |    2 
 drivers/scsi/scsi_error.c                                             |   22 
 drivers/scsi/scsi_priv.h                                              |    1 
 drivers/staging/media/meson/vdec/vdec.c                               |    4 
 drivers/staging/media/sunxi/cedrus/cedrus.c                           |    6 
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c                      |    3 
 drivers/staging/media/tegra-video/vi.c                                |    4 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c                        |    9 
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c                     |    2 
 drivers/tty/serial/8250/8250_mid.c                                    |   14 
 drivers/tty/serial/sc16is7xx.c                                        |   12 
 drivers/uio/uio_hv_generic.c                                          |    8 
 drivers/usb/atm/ueagle-atm.c                                          |   17 
 drivers/usb/chipidea/core.c                                           |    1 
 drivers/usb/core/port.c                                               |    2 
 drivers/usb/core/sysfs.c                                              |    8 
 drivers/usb/gadget/function/f_midi.c                                  |    1 
 drivers/usb/gadget/function/f_ncm.c                                   |   17 
 drivers/usb/gadget/function/f_printer.c                               |   23 
 drivers/usb/gadget/function/f_tcm.c                                   |  192 +
 drivers/usb/gadget/function/tcm.h                                     |   13 
 drivers/usb/gadget/function/uvc_v4l2.c                                |    2 
 drivers/usb/gadget/udc/bdc/bdc_core.c                                 |   20 
 drivers/usb/gadget/udc/bdc/bdc_udc.c                                  |    7 
 drivers/usb/gadget/udc/dummy_hcd.c                                    |   40 
 drivers/usb/gadget/udc/fsl_udc_core.c                                 |   93 
 drivers/usb/gadget/udc/fsl_usb2_udc.h                                 |    1 
 drivers/usb/gadget/udc/snps_udc_core.c                                |    1 
 drivers/usb/host/xhci-pci.c                                           |    1 
 drivers/usb/host/xhci.c                                               |   15 
 drivers/usb/host/xhci.h                                               |    1 
 drivers/usb/musb/omap2430.c                                           |    2 
 drivers/usb/serial/ftdi_sio.c                                         |    2 
 drivers/usb/serial/ftdi_sio_ids.h                                     |    5 
 drivers/usb/serial/io_edgeport.c                                      |    3 
 drivers/usb/serial/keyspan_pda.c                                      |   44 
 drivers/usb/serial/option.c                                           |    1 
 drivers/usb/storage/unusual_devs.h                                    |    7 
 drivers/usb/typec/ucsi/ucsi.c                                         |  158 +
 drivers/vdpa/vdpa_user/iova_domain.c                                  |   29 
 drivers/vdpa/vdpa_user/iova_domain.h                                  |    8 
 drivers/vdpa/vdpa_user/vduse_dev.c                                    |  112 
 drivers/vhost/net.c                                                   |    8 
 drivers/video/Kconfig                                                 |    1 
 drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c                         |    2 
 drivers/watchdog/airoha_wdt.c                                         |    3 
 drivers/watchdog/s32g_wdt.c                                           |    3 
 drivers/watchdog/watchdog_pretimeout.c                                |    2 
 fs/afs/dir_edit.c                                                     |    2 
 fs/binfmt_elf_fdpic.c                                                 |    4 
 fs/binfmt_misc.c                                                      |    5 
 fs/btrfs/backref.c                                                    |   16 
 fs/btrfs/block-group.c                                                |    8 
 fs/btrfs/ctree.c                                                      |   28 
 fs/btrfs/ctree.h                                                      |   16 
 fs/btrfs/defrag.c                                                     |    4 
 fs/btrfs/dev-replace.c                                                |    4 
 fs/btrfs/extent-tree.c                                                |    8 
 fs/btrfs/extent_io.c                                                  |    4 
 fs/btrfs/extent_map.c                                                 |    4 
 fs/btrfs/file-item.c                                                  |   38 
 fs/btrfs/free-space-cache.c                                           |    7 
 fs/btrfs/free-space-tree.c                                            |    4 
 fs/btrfs/inode-item.c                                                 |    2 
 fs/btrfs/inode.c                                                      |    4 
 fs/btrfs/qgroup.c                                                     |    4 
 fs/btrfs/raid-stripe-tree.c                                           |    4 
 fs/btrfs/relocation.c                                                 |   10 
 fs/btrfs/scrub.c                                                      |   20 
 fs/btrfs/send.c                                                       |   14 
 fs/btrfs/tree-log.c                                                   |   20 
 fs/btrfs/volumes.c                                                    |    6 
 fs/btrfs/xattr.c                                                      |    2 
 fs/ceph/addr.c                                                        |    9 
 fs/ceph/caps.c                                                        |    1 
 fs/ceph/dir.c                                                         |    7 
 fs/crypto/inline_crypt.c                                              |   57 
 fs/crypto/keysetup_v1.c                                               |    8 
 fs/exec.c                                                             |    2 
 fs/f2fs/super.c                                                       |   25 
 fs/fuse/dev_uring.c                                                   |   22 
 fs/fuse/file.c                                                        |    5 
 fs/iomap/buffered-io.c                                                |   34 
 fs/nfsd/nfs4xdr.c                                                     |    8 
 fs/nfsd/vfs.c                                                         |   15 
 fs/nfsd/vfs.h                                                         |    2 
 fs/overlayfs/copy_up.c                                                |   12 
 fs/overlayfs/file.c                                                   |   51 
 fs/overlayfs/overlayfs.h                                              |    5 
 fs/overlayfs/xattrs.c                                                 |    2 
 fs/posix_acl.c                                                        |    7 
 fs/proc/namespaces.c                                                  |    4 
 fs/proc/task_mmu.c                                                    |   14 
 fs/resctrl/ctrlmondata.c                                              |    6 
 fs/resctrl/internal.h                                                 |   22 
 fs/resctrl/monitor.c                                                  |  200 -
 fs/resctrl/rdtgroup.c                                                 |   75 
 fs/smb/client/misc.c                                                  |   34 
 fs/smb/client/smb2file.c                                              |   21 
 fs/smb/client/smb2inode.c                                             |   23 
 fs/smb/client/smb2ops.c                                               |   25 
 fs/smb/server/oplock.c                                                |    6 
 fs/smb/server/smb2misc.c                                              |    5 
 fs/smb/server/smb2pdu.c                                               |    9 
 fs/smb/server/smbacl.c                                                |   42 
 fs/super.c                                                            |   34 
 fs/xfs/scrub/cow_repair.c                                             |  203 -
 fs/xfs/scrub/trace.h                                                  |   28 
 include/drm/drm_buddy.h                                               |  165 -
 include/drm/drm_connector.h                                           |    6 
 include/drm/drm_utils.h                                               |    1 
 include/linux/arm_ffa.h                                               |    2 
 include/linux/audit.h                                                 |    6 
 include/linux/audit_arch.h                                            |   12 
 include/linux/bootconfig.h                                            |    3 
 include/linux/cred.h                                                  |   15 
 include/linux/firmware/xlnx-zynqmp.h                                  |   13 
 include/linux/fscrypt.h                                               |   18 
 include/linux/gpu_buddy.h                                             |  177 +
 include/linux/mlx5/mlx5_ifc.h                                         |   13 
 include/linux/resctrl.h                                               |   28 
 include/linux/seqlock.h                                               |   10 
 include/linux/sunrpc/svcsock.h                                        |    3 
 include/linux/sunrpc/xdr.h                                            |   19 
 include/linux/virtio.h                                                |    6 
 include/linux/vtime.h                                                 |    6 
 include/media/v4l2-async.h                                            |    4 
 include/media/videobuf2-core.h                                        |    8 
 include/net/bluetooth/rfcomm.h                                        |    3 
 include/net/cfg80211.h                                                |    2 
 include/net/dropreason-core.h                                         |    3 
 include/net/ip6_tunnel.h                                              |    2 
 include/net/netfilter/nf_tables.h                                     |   32 
 include/net/netfilter/nft_fib.h                                       |    2 
 include/net/netfilter/nft_meta.h                                      |    3 
 include/net/sctp/structs.h                                            |    3 
 include/net/tcp.h                                                     |    2 
 include/rdma/ib_umem.h                                                |   19 
 include/scsi/scsi_host.h                                              |    3 
 include/uapi/linux/btrfs.h                                            |    2 
 init/Kconfig                                                          |    3 
 init/main.c                                                           |   45 
 io_uring/rw.c                                                         |   42 
 kernel/audit.c                                                        |    2 
 kernel/audit.h                                                        |   32 
 kernel/audit_fsnotify.c                                               |   36 
 kernel/audit_tree.c                                                   |    2 
 kernel/audit_watch.c                                                  |   35 
 kernel/auditfilter.c                                                  |   17 
 kernel/auditsc.c                                                      |    6 
 kernel/bpf/verifier.c                                                 |   17 
 kernel/kexec_handover.c                                               |   32 
 kernel/sched/ext.c                                                    |    9 
 kernel/trace/ftrace.c                                                 |   13 
 kernel/trace/trace.c                                                  |    2 
 kernel/trace/trace_eprobe.c                                           |    3 
 kernel/trace/trace_events.c                                           |    4 
 kernel/trace/trace_mmiotrace.c                                        |    4 
 kernel/trace/trace_probe.c                                            |   13 
 lib/bootconfig.c                                                      |   65 
 lib/compat_audit.c                                                    |   12 
 lib/rhashtable.c                                                      |    1 
 mm/damon/core.c                                                       |   13 
 mm/huge_memory.c                                                      |   12 
 mm/kmemleak.c                                                         |    7 
 mm/sparse.c                                                           |   32 
 net/bluetooth/hci_sync.c                                              |   55 
 net/bluetooth/mgmt.c                                                  |   86 
 net/bluetooth/rfcomm/core.c                                           |   17 
 net/bluetooth/rfcomm/tty.c                                            |    7 
 net/bridge/br_netlink_tunnel.c                                        |    3 
 net/bridge/br_private.h                                               |    6 
 net/bridge/br_vlan.c                                                  |   10 
 net/bridge/br_vlan_options.c                                          |    3 
 net/bridge/netfilter/nft_meta_bridge.c                                |   20 
 net/bridge/netfilter/nft_reject_bridge.c                              |    1 
 net/can/bcm.c                                                         |  520 ++-
 net/can/j1939/transport.c                                             |   18 
 net/can/raw.c                                                         |   66 
 net/ceph/auth_x.c                                                     |    9 
 net/ceph/ceph_common.c                                                |    4 
 net/ceph/mon_client.c                                                 |    4 
 net/ceph/osdmap.c                                                     |   12 
 net/core/dev.c                                                        |   91 
 net/core/filter.c                                                     |    6 
 net/core/gro.c                                                        |    4 
 net/core/sock.c                                                       |   10 
 net/core/sock_map.c                                                   |    2 
 net/hsr/hsr_slave.c                                                   |    2 
 net/ipv4/datagram.c                                                   |    4 
 net/ipv4/fib_trie.c                                                   |    2 
 net/ipv4/icmp.c                                                       |   18 
 net/ipv4/ip_gre.c                                                     |    4 
 net/ipv4/ip_tunnel_core.c                                             |    2 
 net/ipv4/netfilter/nft_dup_ipv4.c                                     |    1 
 net/ipv4/netfilter/nft_fib_ipv4.c                                     |    2 
 net/ipv4/netfilter/nft_reject_ipv4.c                                  |    1 
 net/ipv4/nexthop.c                                                    |    2 
 net/ipv4/raw.c                                                        |   23 
 net/ipv4/tcp_bpf.c                                                    |    2 
 net/ipv4/tcp_input.c                                                  |   56 
 net/ipv4/tcp_ipv4.c                                                   |   14 
 net/ipv4/tcp_minisocks.c                                              |   12 
 net/ipv6/ila/ila_common.c                                             |   12 
 net/ipv6/ip6_gre.c                                                    |    4 
 net/ipv6/netfilter/nft_dup_ipv6.c                                     |    1 
 net/ipv6/netfilter/nft_fib_ipv6.c                                     |    2 
 net/ipv6/netfilter/nft_reject_ipv6.c                                  |    1 
 net/ipv6/raw.c                                                        |    2 
 net/ipv6/route.c                                                      |    4 
 net/ipv6/tcp_ipv6.c                                                   |    8 
 net/ipv6/xfrm6_policy.c                                               |    1 
 net/iucv/af_iucv.c                                                    |   21 
 net/mac80211/cfg.c                                                    |   11 
 net/mac80211/iface.c                                                  |    8 
 net/mac80211/link.c                                                   |    4 
 net/mac80211/mlme.c                                                   |    6 
 net/mac80211/rx.c                                                     |    2 
 net/mac80211/sta_info.c                                               |   15 
 net/mac802154/llsec.c                                                 |    5 
 net/mac802154/scan.c                                                  |   11 
 net/mctp/device.c                                                     |    4 
 net/mpls/af_mpls.c                                                    |    3 
 net/mptcp/options.c                                                   |   12 
 net/mptcp/pm_userspace.c                                              |    7 
 net/mptcp/protocol.c                                                  |    1 
 net/netfilter/nf_conntrack_sip.c                                      |   10 
 net/netfilter/nf_tables_api.c                                         |  315 --
 net/netfilter/nft_bitwise.c                                           |  104 
 net/netfilter/nft_byteorder.c                                         |   11 
 net/netfilter/nft_cmp.c                                               |    3 
 net/netfilter/nft_compat.c                                            |   10 
 net/netfilter/nft_connlimit.c                                         |    1 
 net/netfilter/nft_counter.c                                           |   21 
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
 net/netfilter/nft_quota.c                                             |   14 
 net/netfilter/nft_range.c                                             |    1 
 net/netfilter/nft_redir.c                                             |    3 
 net/netfilter/nft_reject_inet.c                                       |    1 
 net/netfilter/nft_reject_netdev.c                                     |    1 
 net/netfilter/nft_rt.c                                                |    1 
 net/netfilter/nft_socket.c                                            |   26 
 net/netfilter/nft_synproxy.c                                          |    1 
 net/netfilter/nft_tproxy.c                                            |    1 
 net/netfilter/nft_tunnel.c                                            |   26 
 net/netfilter/nft_xfrm.c                                              |   27 
 net/openvswitch/actions.c                                             |   19 
 net/openvswitch/datapath.c                                            |   25 
 net/openvswitch/datapath.h                                            |    2 
 net/openvswitch/vport.c                                               |    2 
 net/packet/af_packet.c                                                |    6 
 net/phonet/pep.c                                                      |    2 
 net/qrtr/af_qrtr.c                                                    |    8 
 net/qrtr/ns.c                                                         |    4 
 net/rds/recv.c                                                        |   15 
 net/rds/tcp.c                                                         |    4 
 net/rxrpc/ar-internal.h                                               |    6 
 net/sched/act_tunnel_key.c                                            |   14 
 net/sctp/auth.c                                                       |    2 
 net/sctp/protocol.c                                                   |   21 
 net/sctp/sm_make_chunk.c                                              |    6 
 net/sctp/sm_statefuns.c                                               |    2 
 net/sctp/stream.c                                                     |    6 
 net/sctp/sysctl.c                                                     |    9 
 net/sunrpc/svcsock.c                                                  |   69 
 net/sunrpc/xdr.c                                                      |  210 +
 net/sunrpc/xprtrdma/rpc_rdma.c                                        |    4 
 net/sunrpc/xprtrdma/verbs.c                                           |   12 
 net/tipc/netlink.c                                                    |    6 
 net/tipc/netlink_compat.c                                             |    4 
 net/tipc/socket.c                                                     |    1 
 net/tls/tls_device.c                                                  |    6 
 net/vmw_vsock/virtio_transport_common.c                               |  165 +
 net/wireless/core.c                                                   |    4 
 net/wireless/core.h                                                   |    2 
 net/wireless/nl80211.c                                                |   22 
 net/wireless/pmsr.c                                                   |   29 
 net/wireless/scan.c                                                   |   13 
 net/x25/af_x25.c                                                      |    8 
 net/xfrm/xfrm_device.c                                                |   12 
 net/xfrm/xfrm_iptfs.c                                                 |    1 
 net/xfrm/xfrm_policy.c                                                |    4 
 net/xfrm/xfrm_state.c                                                 |    7 
 net/xfrm/xfrm_user.c                                                  |    3 
 rust/bindings/lib.rs                                                  |    4 
 rust/kernel/device.rs                                                 |   16 
 rust/kernel/time.rs                                                   |   11 
 rust/uapi/lib.rs                                                      |    4 
 security/landlock/domain.c                                            |    8 
 security/landlock/domain.h                                            |    5 
 security/landlock/ruleset.c                                           |    7 
 sound/core/seq/seq_timer.c                                            |   13 
 sound/core/timer.c                                                    |   21 
 sound/hda/codecs/hdmi/hdmi.c                                          |    3 
 sound/hda/codecs/hdmi/hdmi_local.h                                    |    9 
 sound/hda/codecs/hdmi/intelhdmi.c                                     |   36 
 sound/hda/codecs/realtek/alc269.c                                     |    9 
 sound/hda/codecs/side-codecs/cs35l41_hda.c                            |   11 
 sound/soc/amd/ps/pci-ps.c                                             |   33 
 sound/soc/codecs/bt-sco.c                                             |   10 
 sound/soc/codecs/cs35l56-i2c.c                                        |    4 
 sound/soc/codecs/cs35l56-spi.c                                        |    4 
 sound/soc/codecs/cs35l56.c                                            |   25 
 sound/soc/codecs/cs42l43-jack.c                                       |    3 
 sound/soc/codecs/tas2562.c                                            |    5 
 sound/soc/codecs/tas2781-fmwlib.c                                     |   63 
 sound/soc/fsl/fsl_sai.c                                               |   29 
 sound/soc/fsl/imx-card.c                                              |   12 
 sound/soc/meson/aiu-fifo-spdif.c                                      |    5 
 sound/soc/sunxi/sun4i-codec.c                                         |    1 
 sound/usb/quirks.c                                                    |    2 
 tools/objtool/check.c                                                 |    1 
 tools/testing/cxl/Kbuild                                              |    2 
 tools/testing/selftests/alsa/mixer-test.c                             |    1 
 tools/testing/selftests/bpf/progs/verifier_ld_ind.c                   |  142 +
 tools/testing/selftests/bpf/progs/verifier_map_ptr.c                  |   36 
 tools/testing/selftests/drivers/net/settings                          |    1 
 tools/testing/selftests/drivers/ntsync/config                         |    2 
 tools/testing/selftests/net/af_unix/config                            |    1 
 tools/testing/selftests/net/openvswitch/config                        |   16 
 tools/testing/selftests/net/ovpn/config                               |    2 
 tools/testing/selftests/net/ovpn/ovpn-cli.c                           |    4 
 tools/testing/selftests/net/ovpn/settings                             |    1 
 771 files changed, 11310 insertions(+), 7179 deletions(-)

Abdun Nihaal (1):
      wifi: ipw2100: fix potential memory leak in ipw2100_pci_init_one()

Abel Vesa (1):
      arm64: dts: qcom: hamoa: Fix OPP tables for all DisplayPort controllers

Adrian Hunter (2):
      i3c: mipi-i3c-hci: Fix Hot-Join NACK
      i3c: mipi-i3c-hci: Fix handling of shared IRQs during early initialization

Akhil R (1):
      arm64: tegra: Remove fallback compatible for GPCDMA

Aldo Ariel Panzardo (2):
      rds: drop incoming messages that cross network namespace boundaries
      net: qrtr: restrict socket creation to the initial network namespace

Aleksandr Loktionov (1):
      ice: reject out-of-range ptype in ice_parser_profile_init

Aleksandrova Alyona (1):
      RDMA/irdma: Prevent overflows in memory contiguity checks

Alessandro Rinaldi (1):
      drm/amd/display: Force PWM backlight on Lenovo Legion 5 15ARH05

Alessio Belle (2):
      drm/imagination: Count paired job fence as dependency in prepare_job()
      drm/imagination: Fit paired fragment job in the correct CCCB

Alex Deucher (12):
      drm/amdgpu/sdma7.0: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma6.0: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma5.2: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma5.0: replace BUG_ON() with WARN_ON()
      drm/gfx10: Program DB_RING_CONTROL
      drm/amdgpu/gfx10: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx11: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx12: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx8: drop unecessary BUG_ON()
      drm/amdgpu/gfx9.4.3: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx9: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma4.4.2: replace BUG_ON() with WARN_ON()

Alexander Usyskin (1):
      mei: bus: access mei_device under device_lock on cleanup

Alexandre Courbot (1):
      rust: allow `clippy::unwrap_or_default` globally

Alexei Lazar (2):
      net/mlx5e: Report zero bandwidth for non-ETS traffic classes
      net/mlx5e: Reject unsupported CB Shaper TSA in ETS validation

Alice Ryhl (2):
      rust_binder: only print failure if error has source
      rust: device: avoid trailing ; in printing macros

Amir Goldstein (2):
      ovl: check access to copy_file_range source with src mounter creds
      fs: preserve ACL_DONT_CACHE state in forget_cached_acl()

Anand Moon (1):
      media: meson: vdec: Fix memory leak in error path of vdec_open

Andrew Pope (1):
      wifi: mac80211: recalculate TIM when a station enters power save

Andriy Korud (1):
      drm/amd/display: dce100: skip non-DP stream encoders for DP MST

Antony Antony (1):
      xfrm: reject optional IPTFS templates in outbound policies

Arunpravin Paneer Selvam (1):
      gpu/buddy: bail out of try_harder when alignment cannot be honoured

Asad Kamal (2):
      drm/amdgpu/gfx: fix cleaner shader IB buffer overflow
      drm/amdgpu: fix aperture mapping leak

Ashutosh Desai (3):
      drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply parsers
      drm/dp/mst: fix buffer overflows in sideband chunk accumulation
      drm/dp/mst: fix OOB reads on 2-byte fields in sideband reply parsers

Asim Viladi Oglu Manizada (1):
      pppoe: reload header pointer after dev_hard_header()

Ben Hutchings (1):
      uio_hv_generic: Bind to FCopy device by default

Benjamin Gaignard (1):
      media: verisilicon: Export only needed pixels formats

Biju Das (2):
      drm: renesas: rzg2l_mipi_dsi: Increase reset deassertion delay
      drm: renesas: rzg2l_mipi_dsi: Move rzg2l_mipi_dsi_set_display_timing()

Boris Burkov (1):
      btrfs: fallback to transaction csum tree on a commit root csum miss

Boyuan Zhang (5):
      drm/amdgpu/jpeg: fix jpeg_v4_0_3_is_idle detection
      drm/amdgpu/jpeg: fix jpeg_v5_0_1_is_idle detection
      drm/amdgpu/vce: fix integer overflow in image size
      drm/amdgpu/vcn4: avoid rereading IB param length
      drm/amdgpu: fix division by zero with invalid uvd dimensions

Brajesh Gupta (1):
      drm/imagination: Fix double call to drm_sched_entity_fini()

Brandon Brnich (1):
      media: chips-media: wave5: Move src_buf Removal to finish_encode

Breno Leitao (4):
      mm/kmemleak: fix checksum computation for per-cpu objects
      phonet: pep: fix use-after-free in pep_get_sb()
      bootconfig: move xbc_snprint_cmdline() to lib/bootconfig.c
      bootconfig: fix NULL-pointer arithmetic in xbc_snprint_cmdline()

Brian Witte (3):
      netfilter: nft_counter: serialize reset with spinlock
      netfilter: nft_quota: use atomic64_xchg for reset
      netfilter: nf_tables: revert commit_mutex usage in reset path

Bryam Vargas (6):
      wifi: mac80211_hwsim: clamp virtio RX length before skb_put
      net/iucv: take a reference on the socket found in afiucv_hs_rcv()
      drm/virtio: bound EDID block reads to the response buffer
      ceph: fix pre-auth out-of-bounds read on snaptrace in ceph_handle_caps()
      net/iucv: fix use-after-free of a severed iucv_path
      ata: libata-core: Reject an invalid concurrent positioning ranges count

Bryan O'Donoghue (3):
      media: qcom: camss: Fix RDI streaming for CSID 680
      media: qcom: camss: Fix RDI streaming for CSID GEN2
      media: qcom: camss: Fix RDI streaming for CSID GEN3

Carl Johnson (1):
      smb: client: handle STATUS_STOPPED_ON_SYMLINK responses without a symlink target

Ce Sun (2):
      drm/amdgpu: fix resource leak on ACP reset timeout
      drm/amdgpu: invoke pm_genpd_remove() before freeing genpd

Cen Zhang (5):
      xfrm: clear mode callbacks after failed mode setup
      wifi: cfg80211: cancel sched scan results work on unregister
      wifi: mac80211: free AP_VLAN bc_buf SKBs outside IRQ lock
      Bluetooth: MGMT: revalidate LOAD_CONN_PARAM queued update
      usb: gadget: f_tcm: synchronize delayed set_alt with teardown

Cen Zhang (Microsoft) (4):
      sctp: validate stream count in sctp_process_strreset_inreq()
      tipc: fix u16 MTU truncation in media and bearer MTU validation
      rds: tcp: unregister sysctl before tearing down listen socket
      rhashtable: clear stale iter->p on table restart

Chancel Liu (2):
      ASoC: fsl: imx-card: Skip sysclk reset for active DAIs in shutdown
      ASoC: fsl_sai: Fix spurious BCLK on resume by clearing BYP

Charles Keepax (1):
      ASoC: cs42l43: Correct report for forced microphone jack

Chen Changcheng (1):
      fs/super: fix emergency thaw double-unlock of s_umount

Chen Ni (1):
      drm/rockchip: analogix_dp: Add missing error check for platform_get_resource()

Chen YanJun (1):
      xfrm: iptfs: propagate SKBFL_SHARED_FRAG in iptfs_skb_add_frags()

Chen-Yu Tsai (1):
      ASoC: sun4i-codec: Set quirks.playback_only for H616 codec

Cheng Yongkang (1):
      wifi: ath9k: hif_usb: don't dereference hif_dev after re-arming firmware request

Chengfeng Ye (3):
      bpf, sockmap: Fix cork use-after-free in tcp_bpf_sendmsg()
      Bluetooth: hci_sync: Protect UUID list traversal
      Bluetooth: RFCOMM: Fix session UAF in set_termios

Chenguang Zhao (3):
      net: txgbe: fix FDIR filter leak on remove
      hinic: remove unused ethtool RSS user configuration buffers
      mptcp: decrement subflows counter on failed passive join

Chia-Lin Kao (AceLan) (3):
      usb: core: port: Deattach Type-C connector on component unbind
      usb: typec: ucsi: Detect and skip duplicate altmodes from buggy firmware
      usb: typec: ucsi: Add duplicate detection to nvidia registration path

Christian Brauner (8):
      cred: add scoped_with_kernel_creds()
      ovl: add override_creds cleanup guard extension for overlayfs
      ovl: port ovl_copyfile() to cred guard
      exec: fix unsigned loop counter wrap in transfer_args_to_stack()
      binfmt_misc: set have_execfd only once the interpreter is opened
      binfmt_elf_fdpic: only honour the first PT_INTERP
      super: fix emergency thaw deadlock on frozen block devices
      cred: add kernel_cred() helper

Christian Hewitt (1):
      ASoC: meson: aiu: fifo-spdif: soft reset the S/PDIF datapath on start/stop

Christian König (1):
      drm/amdgpu: fix check in amdgpu_hmm_invalidate_gfx

Christophe JAILLET (1):
      wifi: cfg80211: Fix an error handling path in cfg80211_wext_siwscan()

Chuck Lever (3):
      xprtrdma: Clear receive-side ownership pointers on release
      SUNRPC: Add helpers to convert xdr_buf byte ranges to scatterlists
      SUNRPC: Return an error from xdr_buf_to_bvec() on overflow

Chukun Pan (1):
      USB: serial: option: add TDTECH MT5710-CN

Clark Wang (1):
      ptp: netc: explicitly clear TMR_OFF during initialization

Claudiu Beznea (2):
      dmaengine: sh: rz-dmac: Move interrupt request after everything is set up
      pinctrl: renesas: rzg2l: Use -ENOTSUPP instead of -EOPNOTSUPP

Coia Prant (1):
      net: pcs: xpcs: fix SGMII state reading

Daehyeon Ko (1):
      tipc: clear sock->sk on the failed-insert path in tipc_sk_create()

Daniel Borkmann (3):
      bpf: Fix ld_{abs,ind} failure path analysis in subprogs
      selftests/bpf: Add tests for ld_{abs,ind} failure path in subprogs
      selftests/bpf: Keep verifier_map_ptr exercising ops pointer access

Daniel Golle (1):
      regulator: mt6358: use regmap helper to read fixed LDO calibration

Daniel Hodges (1):
      wifi: ath6kl: fix use-after-free in aggr_reset_state()

Daniele Ceraolo Spurio (1):
      drm/xe/wopcm: fix WOPCM size for LNL+

Danielle Ratson (1):
      netlink: specs: rt-link: convert bridge port flag attributes to u8

Danila Chernetsov (1):
      RDMA/hns: Fix potential integer overflow in mhop hem cleanup

Darrick J. Wong (1):
      xfs: don't replace the wrong part of the cow fork

Dave Airlie (1):
      drm: drop lib from header search path.

Dave Chen (1):
      btrfs: fix u32 to s64 type conversion in dirty_metadata_bytes accounting

Dave Jiang (1):
      cxl/pci: Remove CXL VH handling in CONFIG_PCIEAER_CXL conditional blocks from core/pci.c

David Carlier (3):
      media: aspeed: fix missing of_reserved_mem_device_release() on probe failure
      media: nuvoton: npcm-video: fix error handling in npcm_video_init()
      media: nuvoton: npcm-video: fix memory leaks in probe and remove

David Francis (3):
      drm/amdkfd: Use kvcalloc to allocate arrays
      drm/amdkfd: Check bounds in allocate_event_notification_slot
      drm/amdkfd: Check bounds on CRIU restore queue type and mqd size

David Howells (1):
      afs: Fix afs_edit_dir_remove() to get, not find, block 0

David Jeffery (1):
      scsi: core: wake eh reliably when using scsi_schedule_eh

David Lee (2):
      net/packet: avoid fanout hook re-registration after unregister
      net/x25: fix use-after-free in x25_kill_by_neigh()

Dawei Feng (1):
      wifi: libertas: fix memory leak in helper_firmware_cb()

Deepanshu Kartikey (1):
      media: rtl2832: fix use-after-free in rtl2832_remove()

Dev Jain (1):
      arm64: make huge_ptep_get handled unaligned addresses

Devin Wittmayer (3):
      wifi: mt76: mt7615: drop TXRX_NOTIFY on non-mmio buses
      wifi: mt76: mt7921: drop TXRX_NOTIFY on non-mmio buses
      wifi: mt76: mt7925: drop TXRX_NOTIFY on non-mmio buses

Dexuan Cui (1):
      net: mana: Validate the packet length reported by the NIC

Diego Fernando Mancera Gomez (1):
      usb: atm: ueagle-atm: reject descriptors that confuse probe and disconnect

Dmitry Baryshkov (2):
      media: iris: Fix use IRQF_NO_AUTOEN when requesting the IRQ
      arm64: dts: qcom: correct RBR opp entry

Dmitry Morgun (1):
      wifi: ath11k: fix potential buffer underflow in ath11k_hal_rx_msdu_list_get()

Dmitry Osipenko (1):
      media: synopsys: hdmirx: Fix HPD lane hold time

Dmitry Torokhov (1):
      Input: ims-pcu - fix logic error in packet reset

Doruk Tan Ozturk (6):
      wifi: mwifiex: fix NULL dereference when the AP has HT-cap but no HT-oper
      vxlan: require CAP_NET_ADMIN in the device netns for changelink
      geneve: require CAP_NET_ADMIN in the device netns for changelink
      mac802154: llsec: reject frames shorter than the authentication tag
      mctp: serial: handle zero-length frames to prevent rx buffer overflow
      accel/amdxdna: reject command submission on devices without a submit op

Douya Le (3):
      libceph: bound get_version reply decode to front len
      libceph: reject zero bucket types in crush_decode
      libceph: remove debugfs files before client teardown

Eddie Phillips (1):
      gve: fix Rx queue stall on alloc failure

Edward Adam Davis (1):
      hwmon: (corsair-psu) Stop device IO before calling hid_hw_stop

Emmanuel Grumbach (2):
      wifi: iwlwifi: fix pointer arithmetic in iwl_add_mcc_to_tas_block_list
      wifi: iwlwifi: validate payload length in iwl_pnvm_complete_fn

Emre Cecanpunar (1):
      drm/i915/selftests: Fix GT PM sort comparators

Enrico Zanda (1):
      vhost-net: fix TX stall when vhost owns virtio-net header

Eric Biggers (5):
      fscrypt: Add missing superblock check in find_or_insert_direct_key()
      dm-verity-fec: fix the size of dm_verity_fec_io::erasures
      dm-verity-fec: fix reading parity bytes split across blocks (take 3)
      dm-verity-fec: replace {MAX,MIN}_RSN with {MIN,MAX}_ROOTS
      fscrypt: Avoid dynamic allocation in fscrypt_get_devices()

Eric Dumazet (7):
      net: dropreason: add SKB_DROP_REASON_RECURSION_LIMIT
      net: plumb drop reasons to __dev_queue_xmit()
      tcp: fix TIME_WAIT socket reference leak on PSP policy failure
      ppp: annotate concurrent dev->stats accesses
      net: hsr: fix memory leak on slave unregistration by removing synced VLANs
      ipv4: icmp: fill flow parameters in icmp_route_lookup decoy lookup
      ppp: annotate data races in ppp_generic

Ethan Nelson-Moore (2):
      selftests: ntsync: correct CONFIG_NTSYNC name
      watchdog: s32g_wdt: remove incorrect options in watchdog_info struct

Eugene Shalygin (3):
      hwmon: (asus-ec-sensors) fix looping over banks while reading from EC
      hwmon: (asus-ec-sensors) fix EC read intervals
      hwmon: (asus-ec-sensors) add missed handle for ENOMEM

Eugenio Pérez (3):
      vduse: return internal vq group struct as map token
      vduse: remove unused vaddr parameter of vduse_domain_free_coherent
      vduse: take out allocations from vduse_dev_alloc_coherent

FUJITA Tomonori (1):
      rust: time: fix as_micros_ceil() to round correctly for negative Delta

Fan Wu (4):
      usb: gadget: f_midi: cancel pending IN work before freeing the midi object
      usb: gadget: udc: bdc: free IRQ and drain func_wake_notify before teardown
      wifi: brcmfmac: make release_scratchbuffers idempotent
      net: hip04: fix RX buffer leak on build_skb failure

Filipe Manana (2):
      btrfs: fix root leak if its reloc root is unexpected in merge_reloc_roots()
      btrfs: use bool type for btrfs_path members used as booleans

Florian Fuchs (1):
      mtd: maps: vmu-flash: fix fault in unaligned fixup

Florian Westphal (2):
      netfilter: nf_tables: remove register tracking infrastructure
      netfilter: nf_conntrack_sip: remove net variable shadowing

Frederic Weisbecker (1):
      powerpc/time: Prepare to stop elapsing in dynticks-idle

Gal Pressman (3):
      net/mlx5: Refactor EEPROM query error handling to return status separately
      net/mlx5: Fix MCIA register buffer overflow on 32 dword reads
      net/mlx5e: Fix NULL pointer dereference in ioctl module EEPROM query

Gaole Zhang (1):
      wifi: ath11k: fix NULL pointer dereference in ath11k_hal_srng_access_begin

Geliang Tang (1):
      mptcp: pm: userspace: fix use-after-free in get_local_id

George Guo (1):
      LoongArch: Fix address space mismatch in kexec command line lookup

Georgi Valkov (1):
      wifi: mwifiex: fix freeze for 60 seconds caused by request_firmware

Greg Kroah-Hartman (1):
      Linux 6.18.42

Griffin Kroah-Hartman (1):
      usb: core: sysfs: add lock to bos_descriptors_read()

Guanghui Feng (1):
      iommu/amd: Wait for completion instead of returning early in iommu_completion_wait()

Guanghui Yang (1):
      btrfs: free mapping node on duplicate reloc root insert

Guangshuo Li (11):
      usb: musb: omap2430: Do not put borrowed of_node in probe
      ALSA: hda: cs35l41: validate and free ACPI mute object
      dpaa2-switch: put MAC endpoint device on disconnect
      dpaa2-eth: put MAC endpoint device on disconnect
      wifi: mt76: mt7925: guard link STA in decap offload
      media: marvell-cam: fix missing pci_disable_device() on remove
      media: vidtv: fix reference leak on failed device registration
      media: vimc: fix reference leak on failed device registration
      media: vivid: fix cleanup bugs in vivid_init()
      intel_th: fix MSC output device reference leak
      mmc: vub300: fix use-after-free on probe failure

Guenter Roeck (4):
      hwmon: (corsair-cpro) Stop device IO before calling hid_hw_stop
      hwmon: (gigabyte_waterforce) Stop device IO before calling hid_hw_stop
      hwmon: (nzxt-smart2) Stop device IO before calling hid_hw_stop
      hwmon: (nzxt-kraken3) Stop device IO before calling hid_hw_stop

Guixiong Wei (1):
      platform/x86/intel-uncore-freq: Fix current_freq_khz after CPU hotplug

Guoniu Zhou (3):
      media: nxp: imx8-isi: Fix potential out-of-bounds issues
      media: nxp: imx8-isi: Fix scale factor calculation for hardware rounding
      pmdomain: imx93-blk-ctrl: Extract PHY as shared domain for DSI/CSI

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

Haoxiang Li (1):
      net: ipa: fix SMEM state handle leaks in SMP2P init

Hariprasad Kelam (1):
      octeontx2-pf: tc: fix egress ratelimiting

Harry Wentland (1):
      drm/amd/display: Fix DTB DTO updates breaking live pixel rate sources

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

Hugo Villeneuve (1):
      serial: sc16is7xx: implement gpio get_direction() callback

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

Icenowy Zheng (1):
      drm/imagination: acquire vm_ctx->lock before mapping memory to GPU VM

Ingo Blechschmidt (1):
      dm: avoid leaking the caller's thread keyring via the table device file

Ivan Vecera (1):
      dpll: fix NULL pointer dereference in dpll_msg_add_pin_ref_sync()

Jacob Moroni (4):
      RDMA/umem: Add pinned revocable dmabuf import interface
      RDMA/irdma: Prevent rereg_mr for non-mem regions
      RDMA/irdma: Remove redundant legacy_mode checks
      RDMA/irdma: Prevent user-triggered null deref on QP create

Jakob Linke (1):
      drm/amdgpu/soc24: reset dGPU if suspend got aborted

Jamal Hadi Salim (1):
      net/sched: act_tunnel_key: Defer dst_release to RCU callback

James Montgomery (1):
      ksmbd: defer destroy_previous_session() until after NTLM authentication

James Raphael Tiovalen (1):
      vxlan: mdb: Fix source list corruption on a failed replace

Jani Nikula (5):
      drm/displayid: fix Tiled Display Topology ID size
      drm/i915/hdcp: require monotonically increasing seq_num_v
      drm/i915/hdcp: check streams[] bounds before overflow
      drm/i915/bios: range check LFP Data Block panel_type2
      drm/i915/mst: limit DP MST ESI service loop

Jann Horn (1):
      proc: Fix broken error paths for namespace links

Jason Macnak (1):
      drm/virtio: Don't detach GEM from a non-created context

Jason Wang (1):
      VDUSE: avoid leaking information to userspace

Jeff Layton (2):
      audit: widen ino fields to u64
      sunrpc: allocate a separate bvec array for socket sends

Jia Yao (1):
      drm/xe/uapi: Reject coh_none PAT index for CPU_ADDR_MIRROR

Jiangshan Yi (1):
      serial: 8250_mid: Fix NULL function pointer dereference on DNV/ICX-D/SNR platforms

Jiayuan Chen (1):
      bpf: Fix same-register dst/src OOB read and pointer leak in sock_ops

Jinchao Wang (1):
      usb: gadget: dummy_hcd: prevent fifo_req reuse during giveback

Jiqian Chen (1):
      drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2

Joanne Koong (1):
      fuse-uring: fix race between registration and connection abortion

Joel Fernandes (1):
      gpu: Move DRM buddy allocator one level up (part two)

Johan Hovold (7):
      USB: gadget: snps-udc: fix device name leak on probe failure
      USB: gadget: fsl-udc: fix device name leak on probe failure
      USB: gadget: fsl-udc: fix dev_printk() device
      USB: serial: keyspan_pda: fix data loss on receive throttling
      media: cx231xx: fix devres lifetime
      media: vpif_capture: fix OF node reference imbalance
      mmc: vub300: rename probe error labels

John Stultz (1):
      sched/ext: Avoid null ptr traversal when ->put_prev_task() is called with NULL next

Joonas Lahtinen (4):
      drm/i915/gem: Add missing nospec on parallel submit slot
      drm/i915: Return NULL on error in active_instance
      drm/i915/gem: Do not leak siblings[] on proto context error
      drm/i915/gem: Fix NULL deref in I915_CONTEXT_PARAM_SSEU

José Expósito (1):
      drm/tests: shmem: Set DMA mask to 64-bit in drm_gem_shmem

Julian Braha (1):
      drm/panel: s6e3ha8: fix unmet dependency on DRM_DISPLAY_HELPER

Jun Yang (1):
      sctp: don't free the ASCONF's own transport in DEL-IP processing

Junrui Luo (2):
      drm/nouveau: fix reversed error cleanup order in ucopy functions
      octeontx2-af: cn10k: restrict VF LMTLINE sharing to its own PF

Junxi Qian (1):
      fuse: fix writeback array overflow when max_pages is one

Justin Lai (1):
      rtase: Workaround for TX hang caused by hardware packet parsing

KP Singh (1):
      selftests/bpf: Adjust verifier_map_ptr for the map's excl field

Kai Vehmanen (1):
      ALSA: hda: codecs: hdmi: disable keep-alive before audio format change

Kanglong Wang (1):
      LoongArch: Move jump_label_init() before parse_early_param()

Karol Wachowski (1):
      accel/ivpu: Fix wrong register read in LNL failure diagnostics

Kenneth Feng (1):
      drm/amd/amdgpu: disable ASPM on VI if pcie dpm is disabled

Kiryl Shutsemau (1):
      fs/proc/task_mmu: fix make_uffd_wp_huge_pte() prot-update race

Koen Koning (1):
      gpu: Fix uninitialized buddy for built-in drivers

Koichiro Den (1):
      dmaengine: dw-edma-pcie: Reject devices without driver data

Krzysztof Kozlowski (2):
      media: pci: dm1105: Free allocated workqueue
      dmaengine: dw-edma: Fix confusing cleanup.h syntax

Kuniyuki Iwashima (2):
      soreuseport: Clear sk_reuseport_cb before failure in sk_clone().
      net: Call net_enable_timestamp() before failure in sk_clone().

Kyle Zeng (1):
      openvswitch: fix GSO userspace truncation underflow

Leo Li (3):
      drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_no_lock
      drm/amd/display: Fix flip-done timeouts on mode1 reset
      drm/amd/display: Fix missing DCE check in dm_gpureset_toggle_interrupts()

Leo Martins (1):
      btrfs: don't propagate EXTENT_FLAG_LOGGING to split extent maps

Li RongQing (2):
      iommu/intel: Fix out-of-bounds memset in dmar_latency_disable()
      net: ipv6: fix dif and sdif mismatch in raw6_icmp_error

LiangCheng Wang (1):
      wifi: brcmfmac: set F2 blocksize to 256 for BCM43752

Linmao Li (3):
      drm/panthor: Check debugfs GEM lock initialization
      drm/vc4: Shut down BO cache timer before teardown
      drm/vc4: Prevent shader BO mappings from becoming writable

Lizhi Hou (1):
      accel/amdxdna: Fix use-after-free of mm_struct in job scheduler

Lorenzo Bianconi (5):
      wifi: mt76: connac: fix possible NULL-pointer deref in mt76_connac_mcu_uni_bss_he_tlv()
      wifi: mt76: mt7925: fix possible NULL-pointer deref in mt7925_mcu_bss_he_tlv()
      wifi: mt76: mt7996: check pointer returned by mt76_connac_get_he_phy_cap()
      wifi: mt76: mt7996: fix possible NULL-pointer deref in mt7996_mcu_sta_bfer_eht()
      net: airoha: fix ETS channel derivation in airoha_tc_setup_qdisc_ets()

Lu Baolu (1):
      iommu/vt-d: Disallow SVA if page walk is not coherent

Luca Coelho (1):
      drm/dp_mst: Handle torn-down topology gracefully in drm_dp_mst_topology_queue_probe()

Luigi Santivetti (1):
      drm/imagination: fix error checking of pvr_vm_context_lookup()

Ma Ke (1):
      media: saa7134: Fix a possible memory leak in saa7134_video_init1

Malaya Kumar Rout (1):
      selftests/alsa: Fix memory leak in find_controls error path

Manivannan Sadhasivam (2):
      wifi: ath11k: Flush the posted write after writing to PCIE_SOC_GLOBAL_RESET
      wifi: ath12k: Flush the posted write after writing to PCIE_SOC_GLOBAL_RESET

Manjunath Patil (1):
      net/mlx5e: Use sender devcom for MPV master-up

Maoyi Xie (1):
      wifi: mac80211: defer link RX stats percpu free to RCU

Marcin Szycik (1):
      ice: fix LAG recipe to profile association

Marco Baffo (2):
      ovpn: fix use after free in unlock_ovpn()
      ovpn: use monotonic clock for peer keepalive timeouts

Marco Felsch (1):
      pmdomain: imx93-blk-ctrl: convert to devm_* only

Marco Nenciarini (1):
      media: intel/ipu6: Improve DWC PHY HSFREQRANGE band selection for overlapping ranges

Mario Limonciello (6):
      drm/amdgpu: check amdgpu_vm_bo_find() result in GET_MAPPING_INFO
      drm/amdgpu: validate CP_GFX_SHADOW chunk size in CS pass1
      drm/amdgpu: Release VFCT ACPI table reference
      drm/amdgpu: Fix VFCT bus number matching with soft filter
      drm/amd/display: Fix backlight max_brightness to match exported range
      drm/amdgpu: Disable PCIe dynamic speed switching on Ryzen Pinnacle Ridge

Mark Harris (1):
      riscv: hwprobe: Avoid uninitialized read in hwprobe_get_cpus()

Markus Breitenberger (1):
      net: stmmac: intel: skip SerDes reconfig when rate is unchanged

Martin Hecht (1):
      media: i2c: alvium: fix critical pointer access in alvium_ctrl_init

Masami Hiramatsu (Google) (5):
      tracing: Fix union collision of module and refcnt for dynamic events
      tracing/eprobe: Fix exact system name matching in eprobe_dyn_event_match()
      tracing/probes: Avoid temporary buffer truncation in trace_probe_match_command_args()
      tracing/probes: Fix potential underflow in LEN_OR_ZERO macro
      tracing/probes: Prevent out-of-bounds write in __trace_probe_log_err()

Matthew Brost (5):
      drm/xe/vf: Fix VF CCS attach/detach race with in-flight BO moves
      drm/xe: Return error on non-migratable faults requiring devmem
      drm/xe: Fix PTE index in xe_vm_populate_pgtable() for chunked binds
      drm/ttm: Account for NULL and handle pages in ttm_pool_backup
      drm/gpusvm: Fix MM reference leak in drm_gpusvm_range_evict

Matthieu Baerts (NGI0) (5):
      selftests: af_unix: add USER_NS config
      selftests: openvswitch: add config file
      selftests: ovpn: add IPV6 and VETH configs
      selftests: ovpn: increase timeout
      selftests: drv-net: increase timeout

Maíra Canal (1):
      drm/v3d: Reach the GMP through the hub registers on V3D 7.x

Melbin K Mathew (1):
      usb: gadget: printer: fix infinite loop in printer_read()

Michael Bommarito (6):
      IB/mad: Drop unmatched RMPP responses before reassembly
      amt: re-read skb header pointers after every pull
      amt: make the head writable before rewriting the L2 header
      mptcp: only set DATA_FIN when a mapping is present
      ila: reload IPv6 header after pskb_may_pull in checksum adjust
      octeontx2-af: validate body pcifunc in rvu_mbox_handler_rep_event_notify

Michael Walle (2):
      net: phy: marvell: fix return code
      net: dpaa: fix mode setting

Michal Luczaj (1):
      bpf, sockmap: Reject unhashed UDP sockets on sockmap update

Michał Winiarski (1):
      drm/xe: Allow the caller to pass guc_buf_cache size

Mickaël Salaün (2):
      landlock: Fix formatting
      landlock: Account all audit data allocations to user space

Miguel Ojeda (2):
      objtool/rust: add one more `noreturn` Rust function for Rust 1.99.0
      rust: allow `suspicious_runtime_symbol_definitions` lint for Rust >= 1.98

Mike Snitzer (1):
      NFSD: pass nfsd_file to nfsd_iter_read()

Mikko Perttunen (2):
      gpu: host1x: Fix use-after-free in host1x_bo_clear_cached_mappings
      crypto: tegra - Don't touch bo refcount in host1x bo pin/unpin

Mikulas Patocka (1):
      dm-verity: fix buffer overflow in FEC calculation

MinJea Kim (1):
      staging: rtl8723bs: fix inverted HT40 secondary channel offset

Ming Lei (1):
      ublk: wait on ublk_dev_ready() instead of ub->completion

Minhong He (1):
      mctp: check register_netdevice_notifier() error in mctp_device_init()

Mirela Rabulea (1):
      media: v4l2-fwnode: Fix subdev owner overwritten in v4l2_async_register_subdev_sensor()

Moksh Panicker (1):
      staging: rtl8723bs: fix OOB reads in rtw_get_wps_ie()

Mostafa Saleh (2):
      firmware: arm_ffa: Fix out-of-bound writes in ffa_setup_and_transmit()
      drivers/virt: pkvm: Fix end calculation in mmio_guard_ioremap_hook()

Muchun Song (1):
      mm/sparse-vmemmap: fix vmemmap accounting underflow

Muhammad Bilal (1):
      usb: gadget: uvc: clamp SEND_RESPONSE length to the response buffer

Myeonghun Pak (6):
      net: mctp i3c: clean up notifier and buses if driver register fails
      media: cec: seco: unregister adapter on IR probe failure
      media: cedrus: clean up media device on probe failure
      media: radio-si476x: Unregister v4l2_device on probe failure
      media: stm32: dcmi: unregister notifier on probe failure
      media: ti: vpe: unwind v4l2 device registration on probe error

Namjae Jeon (2):
      ksmbd: bound DACL dedup walk to copied ACEs
      ksmbd: validate ACE size against SID sub-authorities

Nathan Chancellor (1):
      x86/boot/compressed: Disable jump tables

Nazim Amirul (3):
      net: stmmac: xgmac: fix l4 filter port overwrite on register update
      net: stmmac: fix l3l4 filter rejecting unsupported offload requests
      net: stmmac: reset residual action in L3L4 filters on delete

Nikhil P. Rao (7):
      pds_core: reject component parameter in legacy firmware update
      pds_core: fix deadlock between reset thread and remove
      pds_core: fix use-after-free on workqueue during remove
      pds_core: yield the CPU while waiting for the adminq to drain
      pds_core: order completion reads after the ownership check
      pds_core: fix auxiliary device add/del races
      pds_core: check for workqueue allocation failure

Nikita Maksimov (1):
      ALSA: hda/realtek: Fix speakers on Lunnen Ground 14

Nikola Z. Ivanov (1):
      ipv6: Change allocation flags to match rcu_read_lock section requirements

Nikolay Aleksandrov (1):
      net: bridge: vlan: fix vlan range dumps starting with pvid

Nikunj A Dadhania (1):
      KVM: SVM: Bump asid_generation on CPU online to avoid ASID collision after hotplug

Nitin Gote (1):
      drm/xe: Hold a dma-buf reference for imported BOs

Norbert Szetei (4):
      ppp: defer channel free to an RCU grace period to fix pppol2tp RX UAF
      ALSA: seq: close a re-opened queue timer in the destructor
      ALSA: timer: drain a slave's callback before its master detaches it
      ALSA: timer: don't re-enter an instance callback that is still running

Oliver Hartkopp (9):
      can: bcm: add locking when updating filter and timer values
      can: bcm: fix CAN frame rx/tx statistics
      can: bcm: extend bcm_tx_lock usage for data and timer updates
      can: bcm: validate frame length in bcm_rx_setup() for RTR replies
      can: bcm: add missing device refcount for CAN filter removal
      can: bcm: fix stale rx/tx ops after device removal
      can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
      can: bcm: track a single source interface for ANYDEV timeout/throttle ops
      can: raw: add locking for raw flags bitfield

Or Gerlitz (1):
      RDMA/cma: Fix hardware address comparison length in netevent callback

Osama Abdelkader (1):
      drm/panthor: return error on truncated firmware

Pablo Neira Ayuso (1):
      netfilter: nf_conntrack_sip: validate skb_dst() before accessing it

Pagadala Yesu Anjaneyulu (1):
      wifi: iwlwifi: mvm: validate SAR GEO response payload size

Paul Greenwalt (2):
      ice: prevent tstamp ring allocation for non-PF VSI types
      ice: fix PTP Call Trace during PTP release

Pauli Virtanen (3):
      Bluetooth: hci_sync: extend conn_hash lookup critical sections
      Bluetooth: mgmt: fix locking in unpair_device/disconnect_sync
      Bluetooth: mgmt: hold reference for hci_conn in mgmt_pending_cmds

Pavel Ondračka (1):
      drm/radeon: fix r100_copy_blit for large BOs

Pavitra Jha (1):
      ovpn: fix peer refcount leak in TCP error paths

Peddolla Harshavardhan Reddy (1):
      wifi: cfg80211: convert pmsr_free_wk to wiphy_work to fix deadlock

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

Petr Wozniak (2):
      xfrm: propagate -EINPROGRESS from validate_xmit_xfrm()
      xfrm: fix stale skb->prev after async crypto steals a GSO segment

Phil Rosenthal (1):
      KVM: x86/mmu: Fix use-after-free on vendor module reload

Prashanth Kumar KR (1):
      amd-xgbe: fix MAC_AUTO_SW handling in CL37 AN

Pratyush Yadav (Google) (1):
      kho: make sure scratch size is always aligned by CMA_MIN_ALIGNMENT_BYTES

Pushpendra Singh (1):
      firmware: arm_scmi: Rate-limit queue-full warnings in IRQ context

Qihang (1):
      ksmbd: pin conn during async oplock break notification

Qing Luo (1):
      sctp: auth: verify auth requirement when auth_chunk is NULL

Qing Ming (1):
      ovpn: avoid putting unrelated P2P peer on socket release

Qingfang Deng (2):
      ppp: enable TX scatter-gather
      ppp: don't store tx skb in the fastpath

Raag Jadav (1):
      drm/xe/i2c: Allow per domain unique id

Rafael J. Wysocki (1):
      cpufreq: Make cpufreq_update_pressure() fall back to cpuinfo.max_freq

Raphael Zimmer (3):
      libceph: Fix multiplication overflow in decode_new_up_state_weight()
      libceph: Reject monmaps advertising zero monitors
      rbd: Reset positive result codes to zero in object map update path

Ricardo Ribalda (1):
      media: amlogic-c3: Add validations for ae and awb config

Ricardo Robaina (2):
      audit: use 'unsigned int' instead of 'unsigned'
      audit: fix recursive locking deadlock in audit_dupe_exe()

Richard Fitzgerald (3):
      ASoC: cs35l56: Don't use devres to unregister component
      ASoC: cs35l56: Fix potential probe() deadlock
      ASoC: cs35l56: Use complete_all() to signal init_completion

Rik van Riel (1):
      mm/huge_memory: set PG_has_hwpoisoned only after new folio head is established

Rishikesh Jethwani (1):
      tls: device: push pending open record on splice EOF

Robert Mader (1):
      udmabuf: Ensure to perform cache synchronisation in begin_cpu_udmabuf()

Rohan G Thomas (3):
      net: stmmac: socfpga: Agilex5 EMAC platform configuration
      net: stmmac: socfpga: Enable TBS support for Agilex5
      net: stmmac: socfpga: Add hardware supported cross-timestamp

Rong Bao (1):
      LoongArch: Retrieve CPU package ID from PPTT when available

Rosen Penev (5):
      ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is registered
      ata: sata_dwc_460ex: use platform_get_irq()
      ata: sata_dwc_460ex: fix clear_interrupt_bit() clearing all pending interrupts
      ata: sata_dwc_460ex: fix infinite loop in NCQ tag completion bit-scanning
      powerpc/85xx: Add fsl,ifc to common device ids

Runyu Xiao (3):
      wifi: brcmfmac: initialize SDIO data work before cleanup
      raw: annotate lockless match fields in raw_v4_match()
      misc: nsm: only unlock nsm_dev on post-lock error paths

Ruoyu Wang (8):
      RDMA/erdma: initialize ret for empty receive WR lists
      RDMA/mana_ib: initialize err for empty send WR lists
      RDMA/siw: publish QP after initialization
      Bluetooth: hci_qca: Clear memdump state on invalid dump size
      firewire: net: Fix fragmented datagram reassembly
      nfp: Check resource mutex allocation
      wan: wanxl: Only reset hardware after BAR mapping
      wifi: mt76: mt7915: guard HE capability lookups

Russell King (Oracle) (3):
      net: stmmac: remove xstats.pcs_* members
      net: stmmac: cores: remove many xxx_SHIFT definitions
      net: stmmac: fix dwmac4 transmit performance regression

Ryosuke Yasuoka (1):
      drm/virtio: fix deadlock in display_info_cb by removing hotplug from dequeue worker

SJ Park (2):
      mm/damon/core: validate ranges in damon_set_regions()
      mm/damon/core: disallow overlapping input ranges for damon_set_regions()

Sakari Ailus (2):
      media: imx219: Fix maximum frame length in lines
      media: v4l2-subdev: Fail {enable,disable}_streams and s_streaming nicely

Samuel Holland (1):
      media: cedrus: Fix missing cleanup in error path

Sasha Levin (1):
      Revert "drm/amd/display: Add missing kdoc for ALLM parameters"

Satyanarayana K V P (2):
      drm/xe/sa: Shadow buffer support in the sub-allocator pool
      drm/xe/vf: Shadow buffer management for CCS read/write operations

Sean Christopherson (1):
      KVM: x86: Check for invalid/obsolete root *after* making MMU pages available

Sean Wang (1):
      wifi: mt76: mt7925: fix crash in reset link replay

Sebastian Ene (1):
      firmware: arm_ffa: Fix Endpoint Memory Access Descriptor offset calculation

Sergey Shtylyov (2):
      drm/rockchip: cdn-dp: add missing check in cdn_dp_config_video()
      media: v4l2-ctrls-request: add NULL check in v4l2_ctrl_request_complete()

Sergey Temerkhanov (1):
      ice: use READ_ONCE() to access cached PHC time

Seth Forshee (1):
      firmware: arm_ffa: Respect firmware advertised RX/TX buffer size limits

Seungjin Bae (1):
      Input: ims-pcu - fix heap-buffer-overflow in ims_pcu_process_data()

Shahar Tzarfati (1):
      wifi: iwlwifi: mvm: fix read in wake packet notification handler

Shahyan Soltani (1):
      drm/amdgpu: fix lifetime issue of amdgpu_vm_get_task_info_pasid()

Shelley Yang (1):
      wifi: brcmfmac: fix 802.1X-SHA256 call trace warning

Shengjiu Wang (1):
      ASoC: bt-sco: fix duplicate DAPM widget names for wideband DAI

Shihuang Liu (1):
      amt: fix use-after-free in AMT delayed works

Shiming Cheng (1):
      net: gro: fix double aggregation of flush-marked skbs

Shradha Gupta (1):
      net: mana: Optimize irq affinity for low vcpu configs

Shrikanth Hegde (1):
      powerpc/vtime: Initialize starttime at boot for native accounting

Shuangpeng Bai (1):
      libceph: refresh auth->authorizer_buf{,_len} after authorizer update

Shuhao Fu (1):
      can: j1939: fix lockless local-destination check

Shuicheng Lin (1):
      drm/xe/vm: Fix SVM leak on resv obj alloc failure in xe_vm_create()

Shuvam Pandey (2):
      drm/imagination: Fix user array stride in pvr_set_uobj_array()
      ovpn: hold peer before scheduling keepalive work

Sonali Pradhan (1):
      usb: gadget: f_ncm: validate datagram bounds in ncm_unwrap_ntb()

Souvik Banerjee (1):
      ovl: use linked upper dentry in copy-up tmpfile

Stefano Garzarella (1):
      vsock/virtio: collapse receive queue under memory pressure

Steven Price (1):
      arm64: Correct value returned by ESR_ELx_FSC_ADDRSZ_nL()

Steven Rostedt (1):
      tracing: Fix mmiotrace possible NULL dereferencing of hiter->dev

Suman Ghosh (1):
      octeontx2-vf: set TC flower flag on MCAM entry allocation

Sumit Gupta (1):
      arm64: tegra: Fix CPU compatible string to cortex-a78ae on Tegra234

Sungmin Kang (1):
      net: slip: serialize receive against buffer reallocation

Sunho Park (1):
      USB: serial: io_edgeport: cap received transmit credits

Sven Schnelle (2):
      s390/ptff: Export ptff_function_mask[]
      ptp: ptp_s390: Add missing facility check

Takashi Iwai (1):
      ALSA: usb-audio: Skip DSD quirk for Musical Fidelity M6s DAC

Tanmay Shah (1):
      remoteproc: xlnx: Check remote core state

Tejun Heo (1):
      sched_ext: Don't warn on core-sched forced idle in put_prev_task_scx()

Tengda Wu (1):
      ftrace: Add global mutex to serialize trace_parser access

Terry Bowman (3):
      cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
      cxl/pci: Remove unnecessary CXL RCH handling helper functions
      cxl: Fix CXL_HEADERLOG_SIZE to match RAS Capability size

Theodor Arsenij Larionov-Trichkine (1):
      netfilter: nft_fib: reject fib expression on the netdev egress hook

Thomas Zimmermann (5):
      drm/sysfb: Do not page-align visible size of the framebuffer
      drm/sysfb: Avoid truncating maximum stride
      drm/sysfb: Avoid possible truncation with calculating visible size
      drm/sysfb: Return errno code from drm_sysfb_get_visible_size()
      drm/amd/display: Handle struct drm_plane_state.ignore_damage_clips

Tim Pambor (1):
      USB: serial: ftdi_sio: add support for E+H FXA291

Timur Kristóf (4):
      drm/amdgpu/uvd: Fix forcing MSG, FB BOs into VCPU segment when it isn't at 0 (v2)
      drm/amdgpu/uvd: Place VCPU BO only in VRAM for UVD 4.x and older
      drm/amdgpu: Fix amdgpu_bo_move() when old_mem and new_mem are both GTT
      drm/amd/pm/ci: Don't disable MCLK DPM on Bonaire 0x6658 (R7 260X)

Tomi Valkeinen (1):
      drm/tidss: Fix missing drm_bridge_add() call

Tommaso Merciai (1):
      media: rzg2l-cru: Skip ICnMC configuration when ICnSVC is used

Tony Luck (6):
      fs/resctrl: Split L3 dependent parts out of __mon_event_count()
      x86,fs/resctrl: Rename struct rdt_mon_domain and rdt_hw_mon_domain
      x86,fs/resctrl: Rename some L3 specific functions
      fs/resctrl: Move allocation/free of closid_num_dirty_rmid[]
      fs/resctrl: Move RMID initialization to first mount
      fs/resctrl: Fix use-after-free during unmount

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

Uday Khare (1):
      ASoC: tas2562: fix deprecated 'shut-down' GPIO always cleared after lookup

Unnathi Chalicheemala (1):
      firmware: arm_ffa: Fix NULL dereference in ffa_partition_info_get()

Usama Arif (1):
      tracing: Fix context switch counter truncation

Valery Borovsky (7):
      media: airspy: Return queued buffers on start_streaming() failure
      media: msi2500: Return queued buffers on start_streaming() failure
      media: pwc: Drain fill_buf on start_streaming() failure
      media: pwc: Return queued buffers on start_streaming() failure
      media: rtl2832_sdr: Return queued buffers on start_streaming() failure
      media: stm32-dcmipp: Return queued buffers on start_streaming() failure
      media: sun4i-csi: Return queued buffers on start_streaming() failure

Vasily Gorbik (1):
      s390/checksum: Fix csum_partial() without vector facility

Venkatesh Srinivas (1):
      KVM: x86: Only reset TSC Deadline Timer in apic_timer_expired on KVM_RUN

Vijendar Mukunda (3):
      ASoC: amd: ps: disable MSI on resume in ACP PCI driver
      ASoC: amd: ps: fix wrong ACP version string in pci_request_regions()
      ASoC: amd: ps: replace bitwise OR with logical OR in IRQ return check

Vincent Chen (1):
      ice: allow creating VFs when !CONFIG_ICE_SWITCHDEV

Vinod Govindapillai (1):
      drm/i915/wm: clear the plane ddb_y entries on plane disable

Vitor Soares (1):
      drm/bridge: cdns-dsi: Replace deprecated UNIVERSAL_DEV_PM_OPS()

Wang Jun (1):
      media: cx23885: add ioremap return check and cleanup

Wayen Yan (3):
      watchdog: airoha: Prevent division by zero when clock frequency is zero
      net: airoha: Fix potential use-after-free in airoha_ppe_deinit()
      net: airoha: Fix DMA direction for NPU mailbox buffer

Weiming Shi (2):
      ipv4: fib: free fib_alias with kfree_rcu() on insert error path
      mpls: fix NULL deref in mpls_valid_fib_dump_req() on CONFIG_INET=n

WenTao Liang (3):
      drm/amd/display: detect_link_and_local_sink: DP alt mode timeout path leaks prev_sink reference
      drm/amd/display: set new_stream to NULL after release
      ceph: fix refcount leak in ceph_readdir()

Wentao Guan (1):
      ksmbd: restore DACL size on check_add_overflow() to avoid malformed ACL

Wentao Liang (3):
      drm/nouveau/acr: fix missing nvkm_done() in error path of nvkm_acr_oneinit()
      wifi: ath11k: fix refcount leak in ath11k_ahb_fw_resources_init()
      ceph: fix writeback_count leak in write_folio_nounlock()

Will Deacon (2):
      arm64: syscall: Ensure saved x0 is kept in-sync with tracer updates
      Revert "arm64: syscall: Ensure saved x0 is kept in-sync with tracer updates"

Xiang Mei (6):
      btrfs: reject free space cache with more entries than pages
      wifi: mac80211: fix unsol_bcast_probe_resp double free on alloc failure
      wifi: mac80211: fix fils_discovery double free on alloc failure
      wifi: p54: validate RX frame length in p54_rx_eeprom_readback()
      Bluetooth: qca: fix NVM tag length underflow in TLV parser
      wifi: mac80211: tear down new links on vif update error path

Xiang Mei (Microsoft) (6):
      xfrm6: clear dst.dev on error to avoid double netdev_put in xfrm6_fill_dst()
      xfrm: policy: preallocate inexact bins before xfrm_hash_rebuild reinsert
      ksmbd: validate compound request size before reading StructureSize2
      gtp: check skb_pull_data() return in gtp1u_send_echo_resp()
      nexthop: initialize extack in nh_res_bucket_migrate()
      bpf: tcp: fix double sock release on batch realloc

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
      misc: nsm: pin the module while the device is open

Xu Yang (1):
      usb: chipidea: fix usage_count leak when autosuspend_delay is negative

Xuanqiang Luo (1):
      rxrpc: fix io_thread race in rxrpc_wake_up_io_thread()

Xue Lei (1):
      mtd: fix double free and WARN_ON in add_mtd_device() error paths

Yael Chemla (1):
      net/mlx5: E-Switch, fix zero num_dest in prio_tag egress vlan rule

Yang Wang (4):
      drm/amd/pm: fix smu14 power limit range calculation
      drm/amd/pm: fix amdgpu_pm_info power display units
      drm/amd/pm: make pp_features read-only when scpm is enabled
      drm/amd/pm: fix smu13 power limit range calculation

Yichong Chen (2):
      smb: client: validate DFS referral PathConsumed
      ovl: fix trusted xattr escape prefix matching

Yitang Yang (1):
      io_uring/rw: fix missing ERESTARTSYS conversion in read paths

Yizhou Zhao (1):
      tcp: initialize standalone TCP-AO response padding

Yongqiang Sun (1):
      drm/amdkfd: fix 32-bit overflow in CWSR total size calculation

You-Kai Zheng (1):
      btrfs: declare btrfs_ioctl_search_args_v2::buf as __u8

Youssef Samir (1):
      net: qrtr: ns: Raise node count limit to 512

Yun Zhou (1):
      net: gre: fix lltx regression for GRE tunnels with SEQ/CSUM

Yuxiang Yang (1):
      tcp: challenge ACK for non-exact RST in SYN-RECEIVED

Zhang Yi (2):
      iomap: correct the range of a partial dirty clear
      iomap: fix out-of-bounds bitmap_set() with zero-length range

Zhao Li (8):
      wifi: nl80211: free RNR data on MBSSID mismatch
      wifi: cfg80211: derive S1G beacon TSF from S1G fields
      wifi: nl80211: validate nested MBSSID IE blobs
      wifi: nl80211: constrain MBSSID TX link ID range
      wifi: cfg80211: validate PMSR measurement type data
      wifi: cfg80211: validate PMSR FTM preamble range
      wifi: cfg80211: reject unsupported PMSR FTM location requests
      wifi: mac80211: avoid non-S1G AID fallback for S1G assoc

Zhao Zhang (1):
      libceph: guard missing CRUSH type name lookup

Zhaolong Zhang (1):
      bonding: fix devconf_all NULL dereference when IPv6 is disabled

Zhiling Zou (2):
      sctp: avoid auth_enable sysctl UAF during netns teardown
      sctp: close UDP tunnel sockets during netns teardown

Zhixing Chen (1):
      gtp: parse extension headers before reading inner protocol

Zhu Lingshan (1):
      drm/amdgpu: fix bo->pin leaking in amdgpu_bo_create_reserved

Zile Xiong (1):
      media: vb2: use ssize_t for vb2_read/vb2_write

Zixing Liu (1):
      platform/loongarch: laptop: Explicitly reset bl_powered state when suspend

deepakraog (1):
      tracing: Fix resource leak on mmiotrace trace_pipe close

longlong yan (1):
      selftests/net: ovpn: fix getaddrinfo memory leak in ovpn_parse_remote()

vadik likholetov (1):
      net: stmmac: enable the MAC on link up for all supported speeds

