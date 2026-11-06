Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985461;
	b=V/akZO81hVdqETNw+rsCIX4tIXs4U6qHpFPsMSGZNEUwZGEW3KCyGKLHuWuH86x0MRZ2
	 G1T57ow7zFbd6m0LYOJ1JvxX7MjjQBP+Px5EFbsMeplpAc1qEDeeRUsHzZM2CrlV/VP1D
	 hvwEi2ZvIo6FVnjvgGh/vSAdF25moM8aPIVcwufr6/BZpI3jjbuYzMCh4MXDAWs1hR/4i
	 ZhvNx2Ew0qNnPOKJNUD0N/vacpK3eMmlpxJlh8dZAEzc+DNhph0ZKUojIeGMZgVkBjduE
	 qZkka1fhUbXT0Y3QoCYMsSnIxRAVedyb+CWjLJbYo6Ru48CrMqRhHyvCbxduI3IwzEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985461;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YTXNt9vuDnYMF9yC942951zoX+rysuKAj91zy0R+C+Q=;
	b=EfcWaLcQ34BRVgGsCfRr+dwe6VfbFEJjbGSvWYloamXV+cOnZoXeNS4gqZTfUFePoE7D
	 ONFxEaj3dyc7XyeSVOTE4F5Bhh5fBFutQMSefevnUjK/YKVoL/MzvLMKLNAW2Fmaz7ikY
	 IwI3KRIAut2vQPCLUam7Bqc/P3/W1hXDJR/mlUo5GbzactL2hog8PfHW/rkbvWrQ5/uzu
	 g7JYwrzQC5ThucBZzshUEr+ymaSJbpBHJUzBYNvGzn2T1K2coCJ0VecqKjneF5PaAfmmh
	 xWPpgy81C7ulii5qpe8ouktDejHa+zMdhQ/Yov0kc7+tuk5QnJPqTbt04NujkVJCL+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KLGqFMii;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF384606A326;
	Fri,  6 Nov 2026 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KLGqFMii
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E991F008A3;
	Fri,  6 Nov 2026 17:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793985460;
	bh=YTXNt9vuDnYMF9yC942951zoX+rysuKAj91zy0R+C+Q=;
	h=From:To:Cc:Subject:Date;
	b=KLGqFMiiix0hEi0lRTtrC0a+i2IiOMl29JyXXXLjTlIiMYAv+eK6oDcXcX9hMB/sD
	 XPHdp2RYAq22FwMIomMOFs3xyBMOar9uTDDV5JY1UZxj78Wyi7J4W/bYyf7k7aSGMz
	 O2XR7Rmvl/MNi6wY+EwXvQvhwYYVSpvh/DTy5eqw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.61
Date: Fri,  6 Nov 2026 12:17:33 -0500
Message-ID: <2026110634-colony-supper-80ed@gregkh>
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

I'm announcing the release of the 6.18.61 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/cgroup-v2.rst                                          |   10 
 Documentation/block/blk-mq.rst                                                   |    2 
 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5.yaml           |    9 
 Documentation/filesystems/sharedsubtree.rst                                      |   20 
 Documentation/networking/rxrpc.rst                                               |   21 
 Makefile                                                                         |    5 
 arch/alpha/kernel/rtc.c                                                          |   37 
 arch/arm/mach-omap2/sleep44xx.S                                                  |    5 
 arch/arm/mm/mmap.c                                                               |   11 
 arch/arm64/include/asm/runtime-const.h                                           |   17 
 arch/arm64/mm/mmu.c                                                              |   14 
 arch/loongarch/include/asm/kvm_eiointc.h                                         |    1 
 arch/loongarch/include/asm/kvm_ipi.h                                             |    1 
 arch/loongarch/include/asm/kvm_pch_pic.h                                         |    1 
 arch/loongarch/include/asm/pgtable.h                                             |    2 
 arch/loongarch/kvm/intc/eiointc.c                                                |    5 
 arch/loongarch/kvm/intc/ipi.c                                                    |    5 
 arch/loongarch/kvm/intc/pch_pic.c                                                |    5 
 arch/loongarch/kvm/main.c                                                        |   23 
 arch/loongarch/kvm/vcpu.c                                                        |   24 
 arch/loongarch/mm/init.c                                                         |   17 
 arch/mips/Kconfig                                                                |    3 
 arch/powerpc/kvm/book3s_hv.c                                                     |   76 
 arch/powerpc/kvm/book3s_paired_singles.c                                         |    7 
 arch/riscv/Kconfig.errata                                                        |   14 
 arch/riscv/errata/sifive/errata.c                                                |   20 
 arch/riscv/include/asm/errata_list_vendors.h                                     |    3 
 arch/riscv/include/asm/insn-def.h                                                |   16 
 arch/riscv/kernel/sys_hwprobe.c                                                  |    4 
 arch/riscv/kernel/traps.c                                                        |    3 
 arch/riscv/kvm/mmu.c                                                             |    8 
 arch/riscv/kvm/vcpu_pmu.c                                                        |    9 
 arch/riscv/net/bpf_jit_comp32.c                                                  |   47 
 arch/s390/crypto/paes_s390.c                                                     |  209 
 arch/s390/crypto/phmac_s390.c                                                    |   25 
 arch/s390/include/asm/pkey.h                                                     |   16 
 arch/s390/kernel/kprobes.c                                                       |    3 
 arch/s390/kernel/perf_cpum_cf.c                                                  |    3 
 arch/s390/kernel/process.c                                                       |   12 
 arch/s390/kernel/signal.c                                                        |    6 
 arch/s390/lib/probes.c                                                           |    2 
 arch/s390/mm/extable.c                                                           |    4 
 arch/s390/mm/fault.c                                                             |    7 
 arch/x86/events/core.c                                                           |   19 
 arch/x86/events/intel/lbr.c                                                      |    2 
 arch/x86/events/intel/uncore.c                                                   |    5 
 arch/x86/include/asm/cpufeatures.h                                               |    1 
 arch/x86/include/asm/cpuid/api.h                                                 |    1 
 arch/x86/include/asm/kvm-x86-ops.h                                               |    1 
 arch/x86/include/asm/kvm_host.h                                                  |   25 
 arch/x86/kernel/cpu/bugs.c                                                       |   18 
 arch/x86/kernel/cpu/scattered.c                                                  |    1 
 arch/x86/kernel/process.c                                                        |    1 
 arch/x86/kvm/hyperv.c                                                            |    5 
 arch/x86/kvm/mmu/mmu.c                                                           |    8 
 arch/x86/kvm/mmu/paging_tmpl.h                                                   |   39 
 arch/x86/kvm/regs.c                                                              |    3 
 arch/x86/kvm/svm/nested.c                                                        |   15 
 arch/x86/kvm/svm/svm.c                                                           |   35 
 arch/x86/kvm/svm/svm.h                                                           |    1 
 arch/x86/kvm/vmx/common.h                                                        |   20 
 arch/x86/kvm/vmx/main.c                                                          |   26 
 arch/x86/kvm/vmx/nested.c                                                        |   41 
 arch/x86/kvm/vmx/posted_intr.c                                                   |    2 
 arch/x86/kvm/vmx/tdx.c                                                           |   32 
 arch/x86/kvm/vmx/vmx.c                                                           |   33 
 arch/x86/kvm/vmx/x86_ops.h                                                       |    1 
 arch/x86/kvm/x86.c                                                               |   99 
 arch/x86/kvm/xen.c                                                               |   18 
 arch/x86/mm/pat/set_memory.c                                                     |    8 
 block/bdev.c                                                                     |   12 
 block/blk-crypto-fallback.c                                                      |    6 
 crypto/af_alg.c                                                                  |    2 
 drivers/accel/rocket/rocket_job.c                                                |    2 
 drivers/acpi/acpi_fpdt.c                                                         |   53 
 drivers/acpi/apei/ghes.c                                                         |   10 
 drivers/acpi/battery.c                                                           |   14 
 drivers/acpi/button.c                                                            |   11 
 drivers/acpi/sysfs.c                                                             |    9 
 drivers/acpi/video_detect.c                                                      |    8 
 drivers/ata/ata_generic.c                                                        |    6 
 drivers/ata/pata_ep93xx.c                                                        |   30 
 drivers/ata/sata_fsl.c                                                           |   18 
 drivers/base/attribute_container.c                                               |    7 
 drivers/base/base.h                                                              |    1 
 drivers/base/bus.c                                                               |   35 
 drivers/base/core.c                                                              |    4 
 drivers/base/dd.c                                                                |   92 
 drivers/base/regmap/regcache-maple.c                                             |    2 
 drivers/base/regmap/regmap-debugfs.c                                             |    1 
 drivers/base/regmap/regmap-irq.c                                                 |    2 
 drivers/base/regmap/regmap.c                                                     |   15 
 drivers/block/drbd/drbd_receiver.c                                               |    4 
 drivers/block/xen-blkfront.c                                                     |   12 
 drivers/bluetooth/bfusb.c                                                        |   37 
 drivers/bluetooth/btnxpuart.c                                                    |    4 
 drivers/bluetooth/btrsi.c                                                        |    3 
 drivers/bluetooth/btusb.c                                                        |   10 
 drivers/bluetooth/hci_bcsp.c                                                     |    5 
 drivers/bluetooth/hci_nokia.c                                                    |   20 
 drivers/bluetooth/hci_vhci.c                                                     |    4 
 drivers/bus/mhi/host/pm.c                                                        |   14 
 drivers/char/ipmi/ipmi_msghandler.c                                              |    1 
 drivers/char/tpm/Kconfig                                                         |    3 
 drivers/char/tpm/tpm_tis_spi.h                                                   |    8 
 drivers/char/virtio_console.c                                                    |   13 
 drivers/clk/imx/clk-imx8qxp-lpcg.c                                               |    1 
 drivers/clk/imx/clk-imx8qxp.c                                                    |    1 
 drivers/clk/mediatek/clk-mt6735-vdecsys.c                                        |    1 
 drivers/clk/mediatek/clk-mt6735-vencsys.c                                        |    1 
 drivers/clk/sunxi-ng/ccu_common.c                                                |   12 
 drivers/clk/tegra/clk-pll.c                                                      |    1 
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c                                       |    2 
 drivers/clk/zynq/clkc.c                                                          |    8 
 drivers/comedi/drivers/aio_iiro_16.c                                             |    3 
 drivers/comedi/drivers/das6402.c                                                 |   10 
 drivers/comedi/drivers/dt2811.c                                                  |    7 
 drivers/comedi/drivers/ni_at_a2150.c                                             |   13 
 drivers/comedi/drivers/ni_atmio16d.c                                             |    3 
 drivers/comedi/drivers/pcl711.c                                                  |    3 
 drivers/comedi/drivers/pcl816.c                                                  |    3 
 drivers/comedi/drivers/pcl818.c                                                  |    3 
 drivers/comedi/drivers/pcmmio.c                                                  |    3 
 drivers/comedi/drivers/pcmuio.c                                                  |    5 
 drivers/comedi/drivers/quatech_daqp_cs.c                                         |    4 
 drivers/cpufreq/rcpufreq_dt.rs                                                   |    1 
 drivers/crypto/intel/keembay/keembay-ocs-aes-core.c                              |    3 
 drivers/crypto/intel/keembay/keembay-ocs-ecc.c                                   |    1 
 drivers/crypto/intel/keembay/ocs-aes.c                                           |    3 
 drivers/crypto/sa2ul.c                                                           |    3 
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c                                   |    2 
 drivers/dma/pl330.c                                                              |   19 
 drivers/edac/edac_mc.c                                                           |    6 
 drivers/firmware/imx/imx-scu.c                                                   |   25 
 drivers/gpio/gpio-mvebu.c                                                        |   33 
 drivers/gpio/gpio-pca9570.c                                                      |    2 
 drivers/gpio/gpio-sifive.c                                                       |    1 
 drivers/gpio/gpio-vf610.c                                                        |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                                         |   68 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c                               |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c                                 |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c                                 |   33 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c                                         |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                                      |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                          |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c                                       |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                                          |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c                                          |   11 
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c                                       |   63 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                           |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                                           |    2 
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c                                           |    4 
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c                                           |   27 
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c                                            |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_events.c                                          |   17 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c                                 |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c                                 |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c                                 |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c                                  |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c                                  |    7 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c                           |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                             |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c                      |    3 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c                        |    8 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_display_cfg_types.h        |   11 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_soc_parameter_types.h      |    7 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h                    |   13 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c   |   66 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_factory.c      |    2 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h |   54 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c        |    2 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c     |  459 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h   |   36 
 drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c                   |    7 
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_6_0_0_offset.h                      |15799 ++
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_6_0_0_sh_mask.h                     |58556 ++++++++++
 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_6_0_0_offset.h                    |   47 
 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_6_0_0_sh_mask.h                   |   55 
 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_5_0_1_offset.h                  |   17 
 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_5_0_1_sh_mask.h                 |   17 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                                 |   21 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c                              |   28 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c                   |  675 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c                         |  446 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c                              |   34 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c                            |   46 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c                  |  623 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c                  |    7 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c                  |    7 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                                        |   19 
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c                                |   25 
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c                                  |   32 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c                          |   28 
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c                               |    8 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c                             |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                             |    4 
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                                            |   33 
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h                                            |    6 
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c                                        |    2 
 drivers/gpu/drm/msm/msm_drv.c                                                    |   13 
 drivers/gpu/drm/msm/msm_gem_shrinker.c                                           |    3 
 drivers/gpu/drm/msm/msm_gem_submit.c                                             |    5 
 drivers/gpu/drm/panel/panel-edp.c                                                |   11 
 drivers/gpu/drm/panel/panel-simple.c                                             |    3 
 drivers/gpu/drm/panthor/panthor_sched.c                                          |   14 
 drivers/gpu/drm/radeon/atombios_crtc.c                                           |    5 
 drivers/gpu/drm/radeon/atombios_encoders.c                                       |   23 
 drivers/gpu/drm/radeon/r600_dpm.c                                                |   21 
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c                                      |    7 
 drivers/gpu/drm/sysfb/simpledrm.c                                                |   24 
 drivers/gpu/drm/virtio/virtgpu_drv.c                                             |   15 
 drivers/gpu/drm/virtio/virtgpu_drv.h                                             |    2 
 drivers/gpu/drm/virtio/virtgpu_kms.c                                             |    1 
 drivers/gpu/drm/virtio/virtgpu_vq.c                                              |   38 
 drivers/gpu/drm/xe/display/intel_fb_bo.c                                         |    3 
 drivers/gpu/drm/xe/display/xe_fb_pin.c                                           |    3 
 drivers/gpu/drm/xe/xe_exec_queue_types.h                                         |   12 
 drivers/gpu/drm/xe/xe_preempt_fence.c                                            |    7 
 drivers/gpu/drm/xe/xe_vm.c                                                       |   18 
 drivers/gpu/host1x/hw/cdma_hw.c                                                  |    2 
 drivers/greybus/manifest.c                                                       |    2 
 drivers/hid/amd-sfh-hid/amd_sfh_client.c                                         |    4 
 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h                        |    2 
 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h                 |    7 
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c                               |    6 
 drivers/hid/hid-core.c                                                           |    4 
 drivers/hid/hid-cougar.c                                                         |    3 
 drivers/hid/hid-cp2112.c                                                         |    9 
 drivers/hid/hid-elecom.c                                                         |    6 
 drivers/hid/hid-elo.c                                                            |    3 
 drivers/hid/hid-ids.h                                                            |   13 
 drivers/hid/hid-input.c                                                          |   17 
 drivers/hid/hid-logitech-dj.c                                                    |    3 
 drivers/hid/hid-logitech-hidpp.c                                                 |    2 
 drivers/hid/hid-mcp2200.c                                                        |    5 
 drivers/hid/hid-mcp2221.c                                                        |    2 
 drivers/hid/hid-multitouch.c                                                     |   19 
 drivers/hid/hid-picolcd_fb.c                                                     |   12 
 drivers/hid/hid-prodikeys.c                                                      |    7 
 drivers/hid/hid-pxrc.c                                                           |    3 
 drivers/hid/hid-quirks.c                                                         |    7 
 drivers/hid/hid-rmi.c                                                            |    2 
 drivers/hid/hid-roccat-isku.c                                                    |    3 
 drivers/hid/hid-roccat-koneplus.c                                                |    3 
 drivers/hid/hid-roccat-konepure.c                                                |    3 
 drivers/hid/hid-roccat-kovaplus.c                                                |    3 
 drivers/hid/hid-roccat-pyra.c                                                    |    3 
 drivers/hid/hid-roccat-ryos.c                                                    |    3 
 drivers/hid/hid-roccat-savu.c                                                    |    3 
 drivers/hid/hid-roccat.c                                                         |    8 
 drivers/hid/hid-universal-pidff.c                                                |    1 
 drivers/hid/hid-zydacron.c                                                       |    3 
 drivers/hid/i2c-hid/i2c-hid-core.c                                               |    6 
 drivers/hid/intel-ish-hid/ishtp-hid-client.c                                     |    5 
 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c                          |    6 
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c                          |    3 
 drivers/hid/usbhid/hiddev.c                                                      |   37 
 drivers/hid/wacom_sys.c                                                          |  198 
 drivers/hid/wacom_wac.c                                                          |  107 
 drivers/hid/wacom_wac.h                                                          |    6 
 drivers/hsi/controllers/omap_ssi_core.c                                          |    3 
 drivers/hv/ring_buffer.c                                                         |   29 
 drivers/hwmon/asus_rog_ryujin.c                                                  |  149 
 drivers/hwmon/lm90.c                                                             |   25 
 drivers/i2c/busses/i2c-amd-asf-plat.c                                            |    4 
 drivers/i2c/busses/i2c-imx-lpi2c.c                                               |   21 
 drivers/i2c/busses/i2c-qup.c                                                     |   31 
 drivers/i2c/i2c-core-acpi.c                                                      |    1 
 drivers/i3c/master.c                                                             |    3 
 drivers/iio/accel/fxls8962af-core.c                                              |    2 
 drivers/iio/adc/max1241.c                                                        |    1 
 drivers/iio/light/hid-sensor-als.c                                               |   22 
 drivers/infiniband/hw/erdma/erdma_cm.c                                           |    4 
 drivers/infiniband/hw/irdma/i40iw_hw.c                                           |    4 
 drivers/infiniband/hw/irdma/icrdma_hw.c                                          |    2 
 drivers/infiniband/hw/irdma/icrdma_hw.h                                          |    2 
 drivers/infiniband/hw/irdma/icrdma_if.c                                          |   17 
 drivers/infiniband/hw/irdma/irdma.h                                              |    2 
 drivers/infiniband/sw/rxe/rxe_mw.c                                               |   20 
 drivers/infiniband/sw/siw/siw_cm.c                                               |    6 
 drivers/iommu/amd/amd_iommu_types.h                                              |    1 
 drivers/iommu/amd/iommu.c                                                        |   38 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                                      |    2 
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c                                   |   16 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                                       |    1 
 drivers/iommu/arm/arm-smmu/qcom_iommu.c                                          |   18 
 drivers/iommu/intel/cache.c                                                      |    5 
 drivers/iommu/iommufd/eventq.c                                                   |    4 
 drivers/iommu/rockchip-iommu.c                                                   |   13 
 drivers/ipack/devices/ipoctal.c                                                  |   16 
 drivers/irqchip/irq-gic-v5-irs.c                                                 |    4 
 drivers/isdn/mISDN/l1oip_core.c                                                  |    2 
 drivers/isdn/mISDN/socket.c                                                      |    4 
 drivers/md/md.c                                                                  |   13 
 drivers/md/raid5.c                                                               |   13 
 drivers/media/cec/core/cec-adap.c                                                |    1 
 drivers/media/cec/platform/stm32/stm32-cec.c                                     |   16 
 drivers/media/cec/platform/tegra/tegra_cec.c                                     |   14 
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c                                    |   14 
 drivers/media/dvb-core/dmxdev.c                                                  |   11 
 drivers/media/i2c/ov8865.c                                                       |   44 
 drivers/media/pci/cx18/cx18-vbi.c                                                |    2 
 drivers/media/pci/cx23885/cx23885-core.c                                         |    4 
 drivers/media/pci/cx23885/cx23885-dvb.c                                          |   14 
 drivers/media/pci/cx88/cx88-mpeg.c                                               |   10 
 drivers/media/pci/intel/ipu-bridge.c                                             |    2 
 drivers/media/pci/ivtv/ivtv-vbi.c                                                |    2 
 drivers/media/platform/marvell/mcam-core.c                                       |   14 
 drivers/media/platform/microchip/microchip-csi2dc.c                              |    1 
 drivers/media/platform/microchip/microchip-isc-base.c                            |    6 
 drivers/media/platform/microchip/microchip-sama5d2-isc.c                         |   17 
 drivers/media/platform/microchip/microchip-sama7g5-isc.c                         |   17 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                                   |    2 
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c                                 |    4 
 drivers/media/rc/bpf-lirc.c                                                      |   18 
 drivers/media/rc/fintek-cir.c                                                    |    4 
 drivers/media/rc/imon.c                                                          |    5 
 drivers/media/rc/ir-mce_kbd-decoder.c                                            |    5 
 drivers/media/rc/lirc_dev.c                                                      |    3 
 drivers/media/rc/rc-ir-raw.c                                                     |   66 
 drivers/media/rc/rc-main.c                                                       |   42 
 drivers/media/rc/redrat3.c                                                       |    4 
 drivers/media/usb/au0828/au0828-dvb.c                                            |    1 
 drivers/media/usb/em28xx/em28xx-audio.c                                          |    7 
 drivers/media/usb/em28xx/em28xx-cards.c                                          |    2 
 drivers/media/usb/em28xx/em28xx-video.c                                          |   26 
 drivers/media/usb/go7007/go7007-driver.c                                         |    5 
 drivers/media/usb/go7007/go7007-fw.c                                             |   28 
 drivers/media/usb/go7007/s2250-board.c                                           |   54 
 drivers/media/usb/gspca/gspca.c                                                  |    3 
 drivers/media/usb/hackrf/hackrf.c                                                |    7 
 drivers/media/usb/usbtv/usbtv-core.c                                             |    6 
 drivers/media/usb/usbtv/usbtv-video.c                                            |    4 
 drivers/memory/stm32_omm.c                                                       |    2 
 drivers/mfd/axp20x.c                                                             |    2 
 drivers/mfd/ipaq-micro.c                                                         |    2 
 drivers/misc/bcm-vk/bcm_vk_msg.c                                                 |   18 
 drivers/misc/genwqe/card_utils.c                                                 |    2 
 drivers/misc/hpilo.c                                                             |    7 
 drivers/misc/ibmvmc.c                                                            |   17 
 drivers/misc/rp1/rp1_pci.c                                                       |    3 
 drivers/mmc/core/block.c                                                         |    5 
 drivers/mmc/host/cqhci-core.c                                                    |   14 
 drivers/mmc/host/dw_mmc.c                                                        |    1 
 drivers/mmc/host/moxart-mmc.c                                                    |   11 
 drivers/mmc/host/rtsx_usb_sdmmc.c                                                |   13 
 drivers/mmc/host/sdhci-of-ma35d1.c                                               |    1 
 drivers/net/bonding/bond_3ad.c                                                   |    7 
 drivers/net/bonding/bond_main.c                                                  |   96 
 drivers/net/dsa/mt7530.c                                                         |   44 
 drivers/net/ethernet/marvell/mvneta.c                                            |   18 
 drivers/net/ethernet/marvell/mvneta_bm.c                                         |   72 
 drivers/net/ethernet/marvell/prestera/prestera_router.c                          |    6 
 drivers/net/ethernet/mediatek/mtk_wed.c                                          |    5 
 drivers/net/ethernet/mediatek/mtk_wed_regs.h                                     |    1 
 drivers/net/ethernet/sfc/efx.c                                                   |    4 
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c                                 |    3 
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c                                  |    3 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                                |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c                            |    6 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                                      |   24 
 drivers/net/pcs/pcs-mtk-lynxi.c                                                  |    7 
 drivers/net/phy/sfp.c                                                            |    3 
 drivers/net/ppp/pptp.c                                                           |    4 
 drivers/net/tap.c                                                                |    5 
 drivers/net/tun.c                                                                |   14 
 drivers/net/usb/cdc_ether.c                                                      |   16 
 drivers/net/usb/pegasus.c                                                        |    6 
 drivers/net/usb/qmi_wwan.c                                                       |    1 
 drivers/net/usb/rtl8150.c                                                        |    4 
 drivers/net/wireless/ath/ath10k/htt_rx.c                                         |    6 
 drivers/net/wireless/ath/ath11k/ahb.c                                            |   79 
 drivers/net/wireless/ath/ath11k/wmi.c                                            |    6 
 drivers/net/wireless/ath/ath12k/wmi.c                                            |   37 
 drivers/net/wireless/ath/ath12k/wmi.h                                            |   10 
 drivers/net/wireless/ath/ath9k/channel.c                                         |    2 
 drivers/net/wireless/broadcom/b43/main.c                                         |    5 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c                        |   47 
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c                                      |    4 
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c                                     |    6 
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c                                     |    6 
 drivers/net/wireless/intel/iwlwifi/mld/d3.c                                      |   76 
 drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c                           |   21 
 drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h                           |    1 
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c                                |   19 
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.h                                |    2 
 drivers/net/wireless/intel/iwlwifi/mld/mld.c                                     |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                                     |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/time-sync.h                               |    4 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                                    |    1 
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c                               |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c                                  |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c                               |    1 
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c                                  |   73 
 drivers/net/wireless/mediatek/mt76/mt7603/main.c                                 |   76 
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h                               |    4 
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c                              |    5 
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c                             |    5 
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                                 |    3 
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                                  |    9 
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                                  |    4 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                                  |    4 
 drivers/net/wireless/mediatek/mt76/tx.c                                          |   16 
 drivers/net/wireless/mediatek/mt76/wed.c                                         |    7 
 drivers/net/wireless/microchip/wilc1000/mon.c                                    |   30 
 drivers/net/wireless/realtek/rtlwifi/pci.c                                       |   39 
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c                              |    6 
 drivers/net/wireless/realtek/rtw89/fw.c                                          |   31 
 drivers/net/wireless/realtek/rtw89/wow.c                                         |    3 
 drivers/net/wireless/rsi/rsi_91x_coex.c                                          |    3 
 drivers/net/wireless/rsi/rsi_91x_main.c                                          |    7 
 drivers/net/wireless/rsi/rsi_91x_sdio_ops.c                                      |    3 
 drivers/net/wireless/rsi/rsi_91x_usb_ops.c                                       |    7 
 drivers/net/wireless/rsi/rsi_common.h                                            |    2 
 drivers/net/wireless/rsi/rsi_sdio.h                                              |    2 
 drivers/net/wireless/rsi/rsi_usb.h                                               |    2 
 drivers/net/wireless/virtual/mac80211_hwsim.c                                    |   10 
 drivers/net/wwan/wwan_hwsim.c                                                    |    4 
 drivers/nfc/nfcmrvl/spi.c                                                        |    4 
 drivers/nfc/nxp-nci/i2c.c                                                        |    4 
 drivers/nvme/host/auth.c                                                         |    3 
 drivers/nvme/host/core.c                                                         |    6 
 drivers/nvme/host/fc.c                                                           |    2 
 drivers/nvme/host/ioctl.c                                                        |    2 
 drivers/nvme/host/nvme.h                                                         |    6 
 drivers/nvme/host/pci.c                                                          |    6 
 drivers/nvme/host/sysfs.c                                                        |    4 
 drivers/nvme/host/tcp.c                                                          |    8 
 drivers/nvme/host/zns.c                                                          |    8 
 drivers/nvme/target/fabrics-cmd-auth.c                                           |    3 
 drivers/nvme/target/fc.c                                                         |    8 
 drivers/nvme/target/passthru.c                                                   |    9 
 drivers/nvme/target/pr.c                                                         |    2 
 drivers/nvme/target/tcp.c                                                        |    2 
 drivers/nvmem/brcm_nvram.c                                                       |   15 
 drivers/nvmem/core.c                                                             |    4 
 drivers/opp/core.c                                                               |   52 
 drivers/pci/ats.c                                                                |    7 
 drivers/pci/controller/vmd.c                                                     |    7 
 drivers/pci/pci.c                                                                |   25 
 drivers/pci/pcie/portdrv.c                                                       |   28 
 drivers/pci/quirks.c                                                             |    1 
 drivers/pci/switch/switchtec.c                                                   |    1 
 drivers/perf/marvell_cn10k_ddr_pmu.c                                             |    6 
 drivers/perf/riscv_pmu_sbi.c                                                     |   33 
 drivers/phy/phy-core.c                                                           |   45 
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c                                        |   96 
 drivers/pinctrl/pinctrl-sx150x.c                                                 |    1 
 drivers/platform/cznic/turris-omnia-mcu-base.c                                   |    1 
 drivers/platform/x86/amd/hfi/hfi.c                                               |    5 
 drivers/platform/x86/amd/hsmp/acpi.c                                             |   15 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                                        |    8 
 drivers/platform/x86/asus-nb-wmi.c                                               |    1 
 drivers/platform/x86/dell/dell-smbios-wmi.c                                      |   67 
 drivers/platform/x86/intel/int1092/intel_sar.c                                   |    8 
 drivers/platform/x86/lenovo/thinkpad_acpi.c                                      |    1 
 drivers/platform/x86/msi-ec.c                                                    |    1 
 drivers/pmdomain/qcom/rpmhpd.c                                                   |   14 
 drivers/power/reset/piix4-poweroff.c                                             |    1 
 drivers/power/supply/cros_peripheral_charger.c                                   |   13 
 drivers/power/supply/sbs-battery.c                                               |   11 
 drivers/powercap/intel_rapl_common.c                                             |    4 
 drivers/pps/generators/pps_gen.c                                                 |   81 
 drivers/rapidio/devices/rio_mport_cdev.c                                         |    5 
 drivers/regulator/fan53555.c                                                     |    6 
 drivers/regulator/rt6245-regulator.c                                             |    5 
 drivers/remoteproc/remoteproc_core.c                                             |   80 
 drivers/rpmsg/rpmsg_char.c                                                       |    5 
 drivers/rtc/rtc-ab-eoz9.c                                                        |    1 
 drivers/rtc/rtc-brcmstb-waketimer.c                                              |    1 
 drivers/rtc/rtc-ds1307.c                                                         |    2 
 drivers/s390/block/dasd.c                                                        |   10 
 drivers/s390/crypto/zcrypt_ccamisc.c                                             |   22 
 drivers/scsi/dc395x.c                                                            |   10 
 drivers/scsi/ibmvscsi/ibmvfc.c                                                   |   10 
 drivers/scsi/qla2xxx/qla_os.c                                                    |   15 
 drivers/scsi/scsi_devinfo.c                                                      |    2 
 drivers/scsi/smartpqi/smartpqi_init.c                                            |   36 
 drivers/scsi/snic/snic_main.c                                                    |    1 
 drivers/soc/amlogic/meson-clk-measure.c                                          |   14 
 drivers/soc/ixp4xx/ixp4xx-qmgr.c                                                 |    1 
 drivers/soc/mediatek/mtk-dvfsrc.c                                                |    1 
 drivers/soc/qcom/socinfo.c                                                       |    1 
 drivers/soundwire/dmi-quirks.c                                                   |   42 
 drivers/soundwire/intel_auxdevice.c                                              |    1 
 drivers/spi/spi-bcm-qspi.c                                                       |    6 
 drivers/spi/spi-bcm63xx-hsspi.c                                                  |    6 
 drivers/spi/spi-bcm63xx.c                                                        |    5 
 drivers/spi/spi-bcmbca-hsspi.c                                                   |    6 
 drivers/spi/spi-cadence-quadspi.c                                                |    3 
 drivers/spi/spi-fsl-dspi.c                                                       |   21 
 drivers/spi/spi-loongson-core.c                                                  |    6 
 drivers/spi/spi-nxp-fspi.c                                                       |   31 
 drivers/spi/spi-pci1xxxx.c                                                       |   71 
 drivers/spi/spi-qpic-snand.c                                                     |    6 
 drivers/spmi/spmi.c                                                              |    3 
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c                                     |    5 
 drivers/target/iscsi/iscsi_target_login.c                                        |    2 
 drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c                   |   11 
 drivers/thunderbolt/icm.c                                                        |    6 
 drivers/thunderbolt/tb.c                                                         |    4 
 drivers/thunderbolt/test.c                                                       |   37 
 drivers/thunderbolt/tunnel.c                                                     |   47 
 drivers/thunderbolt/tunnel.h                                                     |    8 
 drivers/tty/serial/8250/8250_platform.c                                          |    1 
 drivers/tty/serial/8250/8250_pnp.c                                               |    1 
 drivers/tty/serial/pch_uart.c                                                    |    5 
 drivers/tty/serial/qcom_geni_serial.c                                            |    8 
 drivers/tty/serial/serial_core.c                                                 |    7 
 drivers/uio/uio_sercos3.c                                                        |    1 
 drivers/usb/core/driver.c                                                        |    1 
 drivers/usb/core/message.c                                                       |    1 
 drivers/usb/gadget/configfs.c                                                    |    4 
 drivers/usb/gadget/function/u_audio.c                                            |   12 
 drivers/usb/gadget/legacy/inode.c                                                |   20 
 drivers/usb/gadget/udc/fsl_qe_udc.c                                              |    8 
 drivers/usb/host/xhci-ring.c                                                     |   27 
 drivers/usb/host/xhci.c                                                          |    4 
 drivers/usb/host/xhci.h                                                          |    9 
 drivers/usb/misc/cypress_cy7c63.c                                                |    8 
 drivers/usb/misc/uss720.c                                                        |    1 
 drivers/usb/mtu3/mtu3_trace.h                                                    |    4 
 drivers/usb/musb/musb_host.c                                                     |   14 
 drivers/usb/typec/mux/tusb1046.c                                                 |    1 
 drivers/vdpa/mlx5/net/mlx5_vnet.c                                                |   23 
 drivers/vdpa/vdpa_sim/vdpa_sim.c                                                 |    3 
 drivers/video/backlight/lm3630a_bl.c                                             |    1 
 drivers/video/backlight/qcom-wled.c                                              |   35 
 drivers/video/fbdev/atmel_lcdfb.c                                                |   11 
 drivers/video/fbdev/core/fbcon.c                                                 |    7 
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c                                       |    9 
 drivers/video/fbdev/platinumfb.c                                                 |   35 
 drivers/video/fbdev/udlfb.c                                                      |   27 
 drivers/virtio/virtio_balloon.c                                                  |    6 
 drivers/virtio/virtio_ring.c                                                     |    8 
 drivers/w1/masters/ds2482.c                                                      |    8 
 drivers/xen/pvcalls-back.c                                                       |    2 
 fs/afs/rxrpc.c                                                                   |   63 
 fs/btrfs/relocation.c                                                            |   11 
 fs/ceph/caps.c                                                                   |   17 
 fs/ceph/dir.c                                                                    |   14 
 fs/ceph/inode.c                                                                  |    3 
 fs/coredump.c                                                                    |    2 
 fs/dlm/lowcomms.c                                                                |    6 
 fs/exec.c                                                                        |   11 
 fs/exfat/balloc.c                                                                |   31 
 fs/exfat/dir.c                                                                   |    8 
 fs/exfat/namei.c                                                                 |   27 
 fs/ext4/balloc.c                                                                 |    4 
 fs/ext4/ext4.h                                                                   |    2 
 fs/ext4/inode.c                                                                  |    7 
 fs/ext4/super.c                                                                  |   10 
 fs/f2fs/gc.c                                                                     |    9 
 fs/fat/namei_msdos.c                                                             |    3 
 fs/fuse/dev.c                                                                    |    3 
 fs/fuse/dir.c                                                                    |    3 
 fs/fuse/file.c                                                                   |    9 
 fs/hfs/catalog.c                                                                 |   41 
 fs/hfs/hfs_fs.h                                                                  |   19 
 fs/hfs/inode.c                                                                   |   13 
 fs/hfs/super.c                                                                   |    5 
 fs/hfsplus/extents.c                                                             |    2 
 fs/iomap/ioend.c                                                                 |   10 
 fs/lockd/svclock.c                                                               |    2 
 fs/namei.c                                                                       |   29 
 fs/namespace.c                                                                   |    7 
 fs/nfs/blocklayout/blocklayout.h                                                 |    5 
 fs/nfs/blocklayout/rpc_pipefs.c                                                  |   79 
 fs/nfs/callback_proc.c                                                           |    3 
 fs/nfs/callback_xdr.c                                                            |    2 
 fs/nfs/dir.c                                                                     |    8 
 fs/nfs/filelayout/filelayout.c                                                   |    8 
 fs/nfs/filelayout/filelayoutdev.c                                                |   17 
 fs/nfs/flexfilelayout/flexfilelayout.c                                           |   75 
 fs/nfs/flexfilelayout/flexfilelayout.h                                           |    2 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                                        |   17 
 fs/nfs/localio.c                                                                 |   16 
 fs/nfs/netns.h                                                                   |    5 
 fs/nfs/nfs4_fs.h                                                                 |    2 
 fs/nfs/nfs4proc.c                                                                |    8 
 fs/nfs/nfs4state.c                                                               |   78 
 fs/nfs/nfstrace.h                                                                |    5 
 fs/nfs/pnfs.c                                                                    |   24 
 fs/nfs/pnfs.h                                                                    |    3 
 fs/nfs/pnfs_nfs.c                                                                |   21 
 fs/nfsd/filecache.c                                                              |    4 
 fs/nfsd/flexfilelayout.c                                                         |   20 
 fs/nfsd/flexfilelayoutxdr.c                                                      |    4 
 fs/nfsd/flexfilelayoutxdr.h                                                      |    5 
 fs/nfsd/netns.h                                                                  |    6 
 fs/nfsd/nfs3acl.c                                                                |   15 
 fs/nfsd/nfs4idmap.c                                                              |    4 
 fs/nfsd/nfs4proc.c                                                               |    4 
 fs/nfsd/nfs4recover.c                                                            |   78 
 fs/nfsd/nfs4state.c                                                              |  116 
 fs/nfsd/nfs4xdr.c                                                                |   26 
 fs/nfsd/nfsctl.c                                                                 |   73 
 fs/nfsd/nfsproc.c                                                                |   19 
 fs/nfsd/xdr4.h                                                                   |    1 
 fs/ntfs3/attrib.c                                                                |    2 
 fs/ntfs3/dir.c                                                                   |   14 
 fs/ntfs3/index.c                                                                 |    1 
 fs/ntfs3/inode.c                                                                 |   10 
 fs/ntfs3/namei.c                                                                 |    9 
 fs/ntfs3/ntfs_fs.h                                                               |    2 
 fs/ntfs3/super.c                                                                 |   18 
 fs/ocfs2/cluster/heartbeat.c                                                     |   13 
 fs/ocfs2/cluster/netdebug.c                                                      |    4 
 fs/ocfs2/cluster/nodemanager.c                                                   |    3 
 fs/ocfs2/cluster/quorum.c                                                        |    7 
 fs/ocfs2/cluster/quorum.h                                                        |    1 
 fs/ocfs2/cluster/tcp.c                                                           |    4 
 fs/ocfs2/dlm/dlmconvert.c                                                        |   10 
 fs/ocfs2/dlm/dlmdebug.c                                                          |    5 
 fs/ocfs2/dlm/dlmdomain.c                                                         |    3 
 fs/ocfs2/dlm/dlmlock.c                                                           |    8 
 fs/ocfs2/dlmglue.c                                                               |    2 
 fs/ocfs2/file.c                                                                  |  100 
 fs/ocfs2/filecheck.c                                                             |    5 
 fs/ocfs2/quota_local.c                                                           |   12 
 fs/ocfs2/refcounttree.c                                                          |   15 
 fs/ocfs2/super.c                                                                 |    1 
 fs/overlayfs/copy_up.c                                                           |  112 
 fs/overlayfs/dir.c                                                               |   22 
 fs/overlayfs/inode.c                                                             |   16 
 fs/overlayfs/namei.c                                                             |   11 
 fs/overlayfs/overlayfs.h                                                         |    8 
 fs/overlayfs/readdir.c                                                           |   33 
 fs/overlayfs/super.c                                                             |   34 
 fs/proc/task_mmu.c                                                               |    9 
 fs/romfs/super.c                                                                 |    8 
 fs/smb/client/cached_dir.c                                                       |   30 
 fs/smb/client/cifsacl.c                                                          |    9 
 fs/smb/client/cifsfs.c                                                           |   62 
 fs/smb/client/cifsfs.h                                                           |    5 
 fs/smb/client/cifssmb.c                                                          |   69 
 fs/smb/client/connect.c                                                          |    6 
 fs/smb/client/file.c                                                             |    3 
 fs/smb/client/inode.c                                                            |   32 
 fs/smb/client/readdir.c                                                          |    3 
 fs/smb/client/reparse.c                                                          |   40 
 fs/smb/client/sess.c                                                             |    6 
 fs/smb/client/smb2ops.c                                                          |   74 
 fs/smb/client/smb2pdu.c                                                          |   12 
 fs/smb/client/transport.c                                                        |    6 
 fs/smb/server/auth.c                                                             |    3 
 fs/smb/server/connection.c                                                       |   22 
 fs/smb/server/mgmt/user_config.c                                                 |    6 
 fs/smb/server/mgmt/user_session.c                                                |    4 
 fs/smb/server/misc.c                                                             |    8 
 fs/smb/server/oplock.c                                                           |   16 
 fs/smb/server/server.c                                                           |   21 
 fs/smb/server/smb2pdu.c                                                          |  423 
 fs/smb/server/smb2pdu.h                                                          |    1 
 fs/smb/server/smb_common.c                                                       |    6 
 fs/smb/server/smbacl.c                                                           |   51 
 fs/smb/server/transport_ipc.c                                                    |   16 
 fs/smb/server/transport_rdma.c                                                   |    1 
 fs/smb/server/transport_tcp.c                                                    |   19 
 fs/smb/server/vfs.c                                                              |  137 
 fs/smb/server/vfs.h                                                              |    3 
 fs/smb/server/vfs_cache.c                                                        |   46 
 fs/smb/server/vfs_cache.h                                                        |    2 
 fs/udf/balloc.c                                                                  |   12 
 fs/udf/inode.c                                                                   |   33 
 fs/udf/truncate.c                                                                |    2 
 fs/udf/udfdecl.h                                                                 |    3 
 fs/ufs/dir.c                                                                     |    2 
 fs/xfs/libxfs/xfs_attr_leaf.c                                                    |   13 
 fs/xfs/libxfs/xfs_da_btree.c                                                     |   14 
 fs/xfs/libxfs/xfs_inode_fork.c                                                   |    4 
 fs/xfs/libxfs/xfs_symlink_remote.c                                               |    8 
 fs/xfs/libxfs/xfs_symlink_remote.h                                               |    2 
 fs/xfs/libxfs/xfs_trans_space.c                                                  |    6 
 fs/xfs/scrub/agheader_repair.c                                                   |   13 
 fs/xfs/scrub/alloc_repair.c                                                      |   11 
 fs/xfs/scrub/attr.c                                                              |   17 
 fs/xfs/scrub/attr_repair.c                                                       |   18 
 fs/xfs/scrub/bitmap.c                                                            |   20 
 fs/xfs/scrub/bmap.c                                                              |    7 
 fs/xfs/scrub/btree.c                                                             |   16 
 fs/xfs/scrub/common.c                                                            |    7 
 fs/xfs/scrub/cow_repair.c                                                        |   84 
 fs/xfs/scrub/dabtree.c                                                           |   27 
 fs/xfs/scrub/dir.c                                                               |    2 
 fs/xfs/scrub/dir_repair.c                                                        |    9 
 fs/xfs/scrub/dirtree.c                                                           |    4 
 fs/xfs/scrub/dirtree_repair.c                                                    |   76 
 fs/xfs/scrub/dqiterate.c                                                         |    1 
 fs/xfs/scrub/fscounters.c                                                        |   38 
 fs/xfs/scrub/ialloc_repair.c                                                     |    8 
 fs/xfs/scrub/inode.c                                                             |    2 
 fs/xfs/scrub/inode_repair.c                                                      |  181 
 fs/xfs/scrub/iscan.c                                                             |    2 
 fs/xfs/scrub/metapath.c                                                          |   17 
 fs/xfs/scrub/newbt.c                                                             |   15 
 fs/xfs/scrub/newbt.h                                                             |    1 
 fs/xfs/scrub/parent_repair.c                                                     |    4 
 fs/xfs/scrub/quota.c                                                             |    8 
 fs/xfs/scrub/quota_repair.c                                                      |   39 
 fs/xfs/scrub/quotacheck_repair.c                                                 |   54 
 fs/xfs/scrub/readdir.c                                                           |    2 
 fs/xfs/scrub/reap.c                                                              |   65 
 fs/xfs/scrub/refcount.c                                                          |   17 
 fs/xfs/scrub/repair.c                                                            |   18 
 fs/xfs/scrub/repair.h                                                            |    2 
 fs/xfs/scrub/rmap.c                                                              |   20 
 fs/xfs/scrub/rtbitmap_repair.c                                                   |    2 
 fs/xfs/scrub/rtrefcount.c                                                        |    2 
 fs/xfs/scrub/rtsummary.c                                                         |    9 
 fs/xfs/scrub/rtsummary.h                                                         |    1 
 fs/xfs/scrub/rtsummary_repair.c                                                  |    2 
 fs/xfs/scrub/stats.c                                                             |    5 
 fs/xfs/scrub/symlink.c                                                           |   17 
 fs/xfs/scrub/trace.c                                                             |   13 
 fs/xfs/scrub/trace.h                                                             |   10 
 fs/xfs/scrub/xfarray.c                                                           |    4 
 fs/xfs/xfs_dquot.c                                                               |   20 
 fs/xfs/xfs_dquot.h                                                               |    2 
 fs/xfs/xfs_handle.c                                                              |    2 
 fs/xfs/xfs_inode_item_recover.c                                                  |   20 
 fs/xfs/xfs_mount.c                                                               |    9 
 fs/xfs/xfs_qm.c                                                                  |   42 
 fs/xfs/xfs_quota.h                                                               |    9 
 fs/xfs/xfs_trans_dquot.c                                                         |    6 
 include/asm-generic/bitops/le.h                                                  |   18 
 include/dt-bindings/arm/qcom,ids.h                                               |    1 
 include/linux/device.h                                                           |    5 
 include/linux/device/bus.h                                                       |    3 
 include/linux/hid.h                                                              |    1 
 include/linux/hiddev.h                                                           |    2 
 include/linux/interrupt.h                                                        |    2 
 include/linux/net.h                                                              |    4 
 include/linux/pps_gen_kernel.h                                                   |    2 
 include/linux/remoteproc.h                                                       |    2 
 include/linux/socket.h                                                           |   17 
 include/net/af_rxrpc.h                                                           |    5 
 include/net/bonding.h                                                            |    2 
 include/net/dropreason-core.h                                                    |    6 
 include/net/inet_common.h                                                        |    2 
 include/net/ipv6.h                                                               |    5 
 include/net/netfilter/nf_conntrack_expect.h                                      |   19 
 include/net/netfilter/nf_tables.h                                                |    4 
 include/net/netfilter/nf_tables_ipv4.h                                           |   17 
 include/net/netfilter/nf_tables_ipv6.h                                           |   16 
 include/net/sock.h                                                               |    2 
 include/sound/hda_codec.h                                                        |    1 
 include/trace/events/huge_memory.h                                               |    6 
 include/trace/events/rxrpc.h                                                     |    2 
 include/trace/misc/nfs.h                                                         |   10 
 include/uapi/linux/netfilter/nf_conntrack_common.h                               |    1 
 include/video/maxinefb.h                                                         |    4 
 io_uring/io-wq.c                                                                 |   14 
 io_uring/io_uring.c                                                              |   30 
 io_uring/kbuf.c                                                                  |    4 
 io_uring/net.c                                                                   |   23 
 io_uring/rsrc.c                                                                  |    6 
 io_uring/sqpoll.c                                                                |   28 
 io_uring/sqpoll.h                                                                |    3 
 io_uring/tctx.c                                                                  |    6 
 io_uring/timeout.c                                                               |    3 
 ipc/namespace.c                                                                  |    9 
 kernel/cgroup/cgroup.c                                                           |   28 
 kernel/events/core.c                                                             |   37 
 kernel/fork.c                                                                    |    4 
 kernel/irq/internals.h                                                           |    2 
 kernel/irq/irqdomain.c                                                           |    4 
 kernel/irq/manage.c                                                              |   31 
 kernel/kcov.c                                                                    |    8 
 kernel/kcsan/core.c                                                              |    7 
 kernel/reboot.c                                                                  |    9 
 kernel/resource.c                                                                |    9 
 kernel/sched/ext.c                                                               |   23 
 kernel/trace/trace_events_hist.c                                                 |  105 
 lib/klist.c                                                                      |   16 
 lib/kobject_uevent.c                                                             |    6 
 mm/hugetlb.c                                                                     |   15 
 mm/khugepaged.c                                                                  |    4 
 mm/kmemleak.c                                                                    |   32 
 mm/migrate.c                                                                     |    6 
 mm/migrate_device.c                                                              |    6 
 mm/page_alloc.c                                                                  |    4 
 mm/rmap.c                                                                        |   11 
 mm/slab_common.c                                                                 |   17 
 mm/vmscan.c                                                                      |   17 
 net/8021q/vlan_dev.c                                                             |   33 
 net/9p/trans_fd.c                                                                |    2 
 net/appletalk/ddp.c                                                              |    2 
 net/atm/pvc.c                                                                    |    4 
 net/atm/svc.c                                                                    |    2 
 net/ax25/af_ax25.c                                                               |    2 
 net/bluetooth/Kconfig                                                            |    2 
 net/bluetooth/bnep/Kconfig                                                       |    2 
 net/bluetooth/hci_event.c                                                        |    7 
 net/bluetooth/hci_sock.c                                                         |    2 
 net/bluetooth/hci_sync.c                                                         |   30 
 net/bluetooth/hidp/Kconfig                                                       |    2 
 net/bluetooth/iso.c                                                              |    4 
 net/bluetooth/l2cap_sock.c                                                       |    2 
 net/bluetooth/rfcomm/Kconfig                                                     |    2 
 net/bluetooth/rfcomm/core.c                                                      |    4 
 net/bluetooth/rfcomm/sock.c                                                      |    2 
 net/bluetooth/sco.c                                                              |    2 
 net/bridge/netfilter/ebtables.c                                                  |   12 
 net/can/isotp.c                                                                  |    2 
 net/can/j1939/socket.c                                                           |    2 
 net/can/raw.c                                                                    |    2 
 net/ceph/mon_client.c                                                            |    2 
 net/core/netpoll.c                                                               |    2 
 net/core/rtnetlink.c                                                             |    4 
 net/core/skbuff.c                                                                |    2 
 net/core/sock.c                                                                  |    2 
 net/ieee802154/socket.c                                                          |    4 
 net/ipv4/af_inet.c                                                               |    4 
 net/ipv4/inet_connection_sock.c                                                  |    2 
 net/ipv4/ip_gre.c                                                                |   42 
 net/ipv4/metrics.c                                                               |    5 
 net/ipv4/netfilter/nf_nat_h323.c                                                 |   22 
 net/ipv4/netfilter/nf_reject_ipv4.c                                              |    6 
 net/ipv4/netfilter/nf_tproxy_ipv4.c                                              |    2 
 net/ipv4/udp_tunnel_core.c                                                       |    2 
 net/ipv6/af_inet6.c                                                              |    4 
 net/ipv6/exthdrs_core.c                                                          |    7 
 net/ipv6/ip6_gre.c                                                               |    5 
 net/ipv6/ip6_input.c                                                             |    5 
 net/ipv6/ip6_tunnel.c                                                            |    4 
 net/ipv6/ip6_udp_tunnel.c                                                        |    2 
 net/ipv6/netfilter/nf_reject_ipv6.c                                              |    8 
 net/ipv6/netfilter/nf_tproxy_ipv6.c                                              |    2 
 net/ipv6/udp.c                                                                   |   13 
 net/iucv/af_iucv.c                                                               |    2 
 net/l2tp/l2tp_core.c                                                             |    4 
 net/llc/af_llc.c                                                                 |    2 
 net/mac80211/ibss.c                                                              |    4 
 net/mctp/af_mctp.c                                                               |    2 
 net/mctp/test/route-test.c                                                       |    2 
 net/mctp/test/utils.c                                                            |    2 
 net/mptcp/protocol.c                                                             |    6 
 net/mptcp/subflow.c                                                              |    2 
 net/netfilter/ipvs/ip_vs_sync.c                                                  |    4 
 net/netfilter/nf_conntrack_core.c                                                |   33 
 net/netfilter/nf_conntrack_expect.c                                              |  180 
 net/netfilter/nf_conntrack_h323_main.c                                           |    4 
 net/netfilter/nf_conntrack_helper.c                                              |   10 
 net/netfilter/nf_conntrack_netlink.c                                             |   24 
 net/netfilter/nf_conntrack_proto_tcp.c                                           |    6 
 net/netfilter/nf_conntrack_sip.c                                                 |   13 
 net/netfilter/nf_nat_sip.c                                                       |   20 
 net/netfilter/nf_tables_api.c                                                    |   34 
 net/netfilter/nf_tables_core.c                                                   |    2 
 net/netfilter/nfnetlink_queue.c                                                  |  242 
 net/netfilter/nft_ct.c                                                           |    3 
 net/netfilter/nft_meta.c                                                         |   60 
 net/netfilter/nft_payload.c                                                      |  314 
 net/netfilter/nft_rt.c                                                           |    6 
 net/netfilter/nft_xfrm.c                                                         |    9 
 net/netlink/af_netlink.c                                                         |    2 
 net/netrom/af_netrom.c                                                           |    2 
 net/nfc/llcp_sock.c                                                              |    4 
 net/packet/af_packet.c                                                           |   11 
 net/phonet/socket.c                                                              |    8 
 net/qrtr/af_qrtr.c                                                               |    2 
 net/qrtr/ns.c                                                                    |    2 
 net/rds/bind.c                                                                   |    2 
 net/rds/ib_rdma.c                                                                |    4 
 net/rds/message.c                                                                |   26 
 net/rds/rdma.c                                                                   |   63 
 net/rds/rds.h                                                                    |   17 
 net/rds/send.c                                                                   |   18 
 net/rds/tcp_connect.c                                                            |    2 
 net/rds/tcp_listen.c                                                             |    2 
 net/rose/af_rose.c                                                               |    2 
 net/rxrpc/af_rxrpc.c                                                             |    2 
 net/rxrpc/recvmsg.c                                                              |   22 
 net/rxrpc/rxperf.c                                                               |   43 
 net/rxrpc/sendmsg.c                                                              |   86 
 net/sched/act_ct.c                                                               |    5 
 net/sched/act_ife.c                                                              |    4 
 net/sched/cls_bpf.c                                                              |   28 
 net/sched/cls_flower.c                                                           |   50 
 net/sched/sch_generic.c                                                          |   10 
 net/sched/sch_teql.c                                                             |   60 
 net/sctp/associola.c                                                             |    4 
 net/sctp/endpointola.c                                                           |    4 
 net/smc/af_smc.c                                                                 |    2 
 net/smc/smc.h                                                                    |    2 
 net/socket.c                                                                     |    6 
 net/sunrpc/auth_gss/svcauth_gss.c                                                |   29 
 net/sunrpc/clnt.c                                                                |    4 
 net/sunrpc/svc.c                                                                 |    9 
 net/sunrpc/svc_xprt.c                                                            |   24 
 net/sunrpc/svcauth_unix.c                                                        |    7 
 net/sunrpc/svcsock.c                                                             |   88 
 net/sunrpc/xprtsock.c                                                            |    4 
 net/tipc/socket.c                                                                |    4 
 net/unix/af_unix.c                                                               |    4 
 net/vmw_vsock/af_vsock.c                                                         |    4 
 net/wireless/nl80211.c                                                           |    4 
 net/x25/af_x25.c                                                                 |    2 
 net/xdp/xsk.c                                                                    |    2 
 net/xdp/xsk_queue.c                                                              |   12 
 rust/kernel/bitmap.rs                                                            |  103 
 rust/kernel/block/mq/gen_disk.rs                                                 |   10 
 rust/kernel/block/mq/operations.rs                                               |    2 
 rust/kernel/configfs.rs                                                          |   43 
 rust/kernel/cpufreq.rs                                                           |   22 
 rust/kernel/id_pool.rs                                                           |   39 
 scripts/kconfig/conf.c                                                           |   17 
 scripts/link-vmlinux.sh                                                          |   20 
 security/apparmor/include/policy_ns.h                                            |   16 
 security/apparmor/mount.c                                                        |    4 
 security/apparmor/policy_ns.c                                                    |    2 
 security/landlock/fs.c                                                           |   10 
 sound/core/control.c                                                             |    2 
 sound/drivers/pcmtest.c                                                          |   42 
 sound/hda/codecs/conexant.c                                                      |   26 
 sound/hda/codecs/hdmi/hdmi.c                                                     |    5 
 sound/hda/codecs/realtek/alc269.c                                                |  109 
 sound/hda/codecs/realtek/realtek.c                                               |    6 
 sound/hda/common/codec.c                                                         |   11 
 sound/hda/controllers/intel.c                                                    |   18 
 sound/hda/core/device.c                                                          |    1 
 sound/soc/amd/acp-config.c                                                       |   14 
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c                                    |    8 
 sound/soc/amd/ps/acp63.h                                                         |    8 
 sound/soc/amd/ps/pci-ps.c                                                        |    2 
 sound/soc/amd/ps/ps-common.c                                                     |    2 
 sound/soc/amd/yc/acp6x-mach.c                                                    |   21 
 sound/soc/codecs/cs35l56-sdw.c                                                   |    2 
 sound/soc/codecs/cs35l56-shared.c                                                |    4 
 sound/soc/codecs/cs35l56.c                                                       |    1 
 sound/soc/codecs/hdac_hdmi.c                                                     |   10 
 sound/soc/codecs/max98396.c                                                      |   24 
 sound/soc/codecs/max98926.c                                                      |    2 
 sound/soc/codecs/rt712-sdca.c                                                    |    1 
 sound/soc/codecs/rt712-sdca.h                                                    |    1 
 sound/soc/codecs/sma1303.c                                                       |    2 
 sound/soc/codecs/tlv320aic26.c                                                   |    6 
 sound/soc/codecs/uda1342.c                                                       |    9 
 sound/soc/generic/audio-graph-card2.c                                            |    3 
 sound/soc/intel/boards/bytcr_rt5651.c                                            |   17 
 sound/soc/sof/intel/mtl.c                                                        |   23 
 sound/synth/emux/emux_synth.c                                                    |    3 
 sound/synth/emux/soundfont.c                                                     |    9 
 sound/usb/card.c                                                                 |   70 
 sound/usb/line6/pcm.c                                                            |    8 
 sound/usb/mixer_maps.c                                                           |   27 
 sound/usb/quirks-table.h                                                         |   22 
 sound/usb/quirks.c                                                               |    4 
 sound/usb/usx2y/usbusx2yaudio.c                                                  |    1 
 tools/lib/api/fd/array.c                                                         |    5 
 tools/lib/bpf/libbpf.c                                                           |   10 
 tools/lib/bpf/ringbuf.c                                                          |    2 
 tools/lib/thermal/include/thermal.h                                              |    4 
 tools/objtool/check.c                                                            |    1 
 tools/power/x86/turbostat/turbostat.c                                            |   22 
 tools/sched_ext/scx_flatcg.bpf.c                                                 |    3 
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c                             |    2 
 tools/testing/selftests/cgroup/lib/include/cgroup_util.h                         |    1 
 tools/testing/selftests/cgroup/test_cpu.c                                        |   43 
 tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c               |   16 
 tools/testing/selftests/ftrace/ftracetest                                        |    3 
 tools/testing/selftests/net/fin_ack_lat.c                                        |    2 
 tools/testing/selftests/net/reuseport_bpf_numa.c                                 |   24 
 tools/testing/selftests/ublk/.gitignore                                          |    6 
 tools/testing/selftests/ublk/Makefile                                            |   11 
 tools/testing/selftests/ublk/metadata_size.c                                     |   36 
 tools/testing/selftests/ublk/settings                                            |    1 
 virt/kvm/kvm_main.c                                                              |   31 
 969 files changed, 86874 insertions(+), 4408 deletions(-)

Aamir Ahmed (1):
      ksmbd: deny access for an empty DACL instead of granting the request

Aaron Ma (1):
      HID: quirks: Add ALWAYS_POLL quirk for Beitong BTP-KP20D dongle

Abdifatah Suruur (2):
      ksmbd: reserve space for the UTF-16 terminator in stream info
      smb: client: fix fiemap wild read on empty truncated response

Abdun Nihaal (1):
      platform/x86: int1092: Fix info leak in parse_package()

Abhijeeth Babu (1):
      i2c: acpi: Force ELAN1300 touchpads to 100 kHz

Adarsh Das (1):
      smb: client: delete compound mids on send failure before unlock

Aditya Sherawat (1):
      drm/msm/adreno: Add support for A704 GPU

Adrian Hunter (1):
      i3c: master: Fix potential UAF in i3c_device_uevent()

Ahmed Naseef (1):
      wifi: mt76: mt7603: add 0x7592 EEPROM chip ID

Alan Stern (1):
      HID: core: Fix out-of-bounds left shift by 32 in s32ton()

Aldo Ariel Panzardo (8):
      xfs: reject out-of-range attribute value lengths in xfs_attr_copy_value
      xfs: reject remote xattr entries with an out-of-range value length
      xfs: bound da-node entry count against the correct geometry
      xfs: bound inode fork length against the fork size during log recovery
      nfsd: clear XDR padding in GETXATTR replies
      NFSD: copy SETXATTR data from all XDR buffer segments
      nfsd: propagate SETXATTR value decode errors
      nfsd: zero NFSv4 COMPOUND tag padding

Aleksander Jan Bajkowski (1):
      net: sfp: add quirk for HORACO copper SFP+ module

Aleksandr Nogikh (1):
      media: usbtv: fix null-pointer dereference on disconnect

Alex Deucher (3):
      drm/amdgpu/atomfirmware: WARN() rather than BUG()
      drm/amdgpu/gfx11: WARN() rather than BUG() for invalid SDMA engine
      drm/amdgpu/gmc12: properly pass flush_type to gmc_v12_0_flush_vm_hub()

Alex Elder (1):
      net: stmmac: use dma_addr_t for DMA addresses

Alexander Atanasov (1):
      selftests: ublk: add missing gitignore for metadata_size binary

Alexander Wilhelm (1):
      wifi: ath12k: fix scan command endianness on big endian

Ali Ahmet Memis (1):
      tools/power turbostat: Read complete CPU lists

Ali Alaei (1):
      PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow Lake-HX

Alice Ryhl (1):
      rust: bitmap: add MAX_LEN and MAX_INLINE_LEN constants

Allison Henderson (2):
      net/rds: don't use unpin_user_pages_dirty_lock() from atomic context
      net/rds: unpin MR pages with unpin_user_pages_dirty_lock()

Amber Lin (1):
      drm/amdkfd: Fix signal reset event

Ameer Hamza (3):
      nfsd: fix race between client_info_show() and free_client()
      nfsd: don't modify a session slot when replaying its cached reply
      sunrpc: treat empty auth.unix.gid replies as negative entries

Amir Goldstein (3):
      ovl: fortify ovl_copy_xattr() against underlying layer modifications
      ovl: skip copy up of empty security.capability
      ovl: fix mount setup failing when override_creds drops CAP_SYS_ADMIN

Amit Machhiwal (3):
      KVM: PPC: Book3S HV: Add SRCU protection for virtual-mode HPT hcalls
      KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE bit-lock users
      KVM: PPC: Fix get_d_signext() 12-bit displacement for paired-single D-form

Andrea Parri (3):
      kcsan: Avoid division by zero in kcsan_prandom_u32_max()
      iomap: don't resubmit an ioend after ->writeback_submit() failed
      rtnetlink: wait for RCU readers in rtnl_link_unregister()

Andreas Haufler (1):
      tools/lib/thermal: Fix misplaced extern "C" closing brace

Andreas Hindborg (3):
      rust: block: fix `Send` bound for `GenDisk`
      rust: block: require `Sync` for `Operations::QueueData`
      rust: configfs: fix data offset calculation for subsystem callbacks

Andreas Kemnade (1):
      fbdev: omap2: dsi: do not copy isr table

Andreas Wendleder (1):
      wifi: b43: fix use-after-free in b43_bcma_remove()

Andrew Onyshchuk (1):
      platform/x86: thinkpad_acpi: Fix fan speed reporting on Edge E330

André Draszik (1):
      kbuild: link-vmlinux.sh: improve detection of third pass requirement

Andy Chiu (1):
      riscv: hwprobe: initialize pair->value in hwprobe_one_pair()

Andy Moreton (1):
      sfc: add X4D PF support

AngeloGioacchino Del Regno (1):
      spmi: Fix potential use-after-free by grabbing of_node reference

Aniket Randive (1):
      serial: qcom_geni: Disable closing_wait for console to prevent shutdown timeout

Antonio Quartulli (1):
      net/sched: fix packet reordering on requeue

Anuj Bolewar (2):
      drm/virtio: reclaim pending vbufs before tearing down vqs
      media: hackrf: fix use-after-free in hackrf_alloc_urbs() error path

Arash Golgol (1):
      regulator: fan53555: Add support for FAN53555BUC23X type

Arie Miller (3):
      hwmon: (asus_rog_ryujin) Add per-device configuration
      hwmon: (asus_rog_ryujin) Validate HID report lengths
      hwmon: (asus_rog_ryujin) Synchronize HID command and report handling

Armin Wolf (1):
      platform/x86: dell-smbios-wmi: Fix chardev resource management

Arnd Bergmann (1):
      media: v4l2-tpg: reduce stack usage for kasan builds

Arvind Yadav (1):
      mm/migrate_device: clear stale mapping after freeing swapcache

Asad Kamal (3):
      drm/amd/pm: Validate OD DPM triples before mutating tables
      drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
      drm/amdgpu: validate XCP topology counts before division

Atish Patra (1):
      RISC-V: perf: fix resource cleanup on driver probe failure

Aurabindo Pillai (1):
      drm/amd: Add DCN6 register headers

Austin Zheng (3):
      drm/amd/display: DML2.1 Reintegration
      drm/amd/display: Update P-state naming for clarity.
      drm/amd/display: Remove const Qualifier From Non-Pointer Fields

Avraham Stern (1):
      wifi: iwlwifi: mld: support aborting an ongoing ftm request

Ayala Beker (1):
      wifi: iwlwifi: mld: drop connection on D3 resume failure

Balakrishnan Sambath (1):
      media: microchip-isc: take a reference on the parsed endpoints

Baokun Li (3):
      ext4: reduce max cluster size to match documented 256MB limit
      ext4: reject mount if clusters/inodes per group are not 8-aligned
      blk-crypto: fix NULL deref and UAF in __blk_crypto_evict_key()

Baolin Wang (1):
      mm: vmscan: fix dirty folios throttling on cgroup v1 for MGLRU

Bard Liao (1):
      soundwire: dmi-quirks: add a global ghost list

Basavaraj Natikar (3):
      HID: amd_sfh: Serialize access to the shared emp2 pointer
      HID: amd_sfh: Remove unsupported motion-state field from accelerometer report
      HID: amd_sfh: Use report type from request node

Ben Dooks (2):
      dmaengine: dw-axi-dmac: fix __le32 on set of CH_CTL_H_LLI_VALID
      mmc: cqhci: fix to missed endian conversions

Benjamin Coddington (10):
      pNFS: honor clora_changed when recalling a layout
      NFSv4/flexfiles: report cancelled I/O as a layout error
      pNFS: Fix CB_NOTIFY_DEVICEID CHANGE to consume ndc_immediate
      NFSv4/pnfs: Free the netid when draining a data-server address list
      NFSv4.1/pnfs: suspend pNFS on NFS4ERR_TOOSMALL from LAYOUTGET
      NFSv4/filelayout: Anchor page coalescing on pattern_offset
      NFSv4/flexfiles: fail I/O to the data server once a lock is lost
      NFSv4/flexfiles: Use the full 64-bit offset for read DS selection
      NFSv4/flexfiles: Use the full 64-bit stripe_unit
      NFSv4/flexfiles: Bound page coalescing on the absolute stripe offset

Benjamin Marzinski (1):
      bitops: make the *_bit_le functions use unsigned long

Berke Durak (1):
      HID: elecom: Add support for ELECOM M-XT4DRBK (018E)

Bibo Mao (3):
      LoongArch: KVM: Check kvm_request_pending() in kvm_late_check_requests()
      LoongArch: KVM: Deliver interrupt after IN_GUEST_MODE is set
      LoongArch: KVM: Set vcpu->cpu before IN_GUEST_MODE is set

Binbin Deng (1):
      apparmor: fix a use-after-free in aa_lookupn_ns()

BingKun Yue (1):
      fbdev: platinumfb: add error checking for ioremap calls

Bjorn Andersson (1):
      remoteproc: Force shutdown during device removal

Bob Song (4):
      ALSA: hda: Check snd_hda_power_pm construct error before executing verb
      ALSA: hda/realtek: add missing NULL check for codec->bus->pci
      ALSA: hda/realtek: add missing error checks for COEF index reads in alc269
      ALSA: hda/conexant: Always enable the headset-mic pin on plugin

Borislav Petkov (AMD) (1):
      x86/bugs: Adapt SRSO mitigation to Zen6

Brendan Jackman (1):
      mm/page_alloc: don't spin_trylock() when disallowed in free_one_page()

Breno Leitao (3):
      netpoll: do not warn when the best-effort pool refill fails
      mm/kmemleak: stop the task stack scan early when interrupted
      mm/kmemleak: report RCU-tasks quiescent states during the scan

Brian Grech (1):
      selftests/net: fin_ack_lat: fix latency threshold typo

Brian Norris (1):
      PCI/portdrv: Allow probing even without child services

Bryam Vargas (1):
      iio: accel: fxls8962af: clamp the device-reported FIFO sample count

Bryan O'Donoghue (1):
      phy: core: Fix race-condition between _of_phy_get() and try_module_get()

Bui Viet Dung (2):
      wwan: wwan_hwsim: Pin module for debugfs file operations
      Bluetooth: hci_vhci: Pin module for debugfs file operations

Caleb Sander Mateos (1):
      selftests: ublk: add utility to get block device metadata size

Can Peng (2):
      wifi: brcmfmac: Set DMA direction for msgbuf packet IDs
      wifi: brcmfmac: validate msgbuf flowring IDs before use

Carl Quist (1):
      ALSA: hda/realtek: Enable mute LED on HP Laptop 15-dy0xxx

Carlos Song (1):
      i2c: imx-lpi2c: properly unwind resources on probe failure

Cen Zhang (10):
      ALSA: usb-audio: Release components on probe errors
      ocfs2/dlm: drain join handlers before releasing module text
      ocfs2: drain quorum work before removing the cluster
      ocfs2: pin owning modules for open debugfs files
      ocfs2: publish the filecheck owner before adding sysfs attributes
      ocfs2/heartbeat: unlink live slots when their node is missing
      ocfs2/dlm: hold a lock reference across grant AST enqueue
      ocfs2: cancel quota sync work before freeing quota info
      ocfs2: pin refcount trees before dropping the lookup lock
      ocfs2: snapshot dentry names in file and setattr traces

Cen Zhang (Microsoft Security FORGE Labs) (1):
      nfsd: hold cl_lock in client_has_openowners()

Cen Zhang (Microsoft) (1):
      ksmbd: fix parent dentry lifetime in directory enumeration

Chad Talbott (1):
      ALSA: usb-audio: Add MIN_MUTE quirk for Creative Sound Blaster Play! 3

Chaithanya Lagisetty (2):
      LoongArch: KVM: Add unregister helpers for the KVM interrupt devices
      LoongArch: KVM: Fix resource leak in kvm_loongarch_env_init() error path

Chao Shi (1):
      nvme: ratelimit the completion-path messages driven by device data

Charlene Liu (1):
      drm/amd/display: fix max dispclk_khz/dppclk_khz double 1000

Charles Keepax (4):
      soundwire: dmi-quirks: Disable ghost Realtek on Asus Expertbook
      soundwire: intel_auxdevice: Add cs42l44 to wake_capable_list
      soundwire: dmi-quirks: Disable ghost Realtek on Asus Zenbook Duo
      soundwire: dmi-quirks: Disable ghost Realtek on Asus ROG Zephyrus Duo

Chen Changcheng (3):
      media: cx88: fix memory leak in cx8802_register_driver() error path
      Bluetooth: btrsi: Move set_bt_context after successful HCI registration
      scsi: snic: Fix SCSI host leak on workqueue allocation failure

ChenXiaoSong (1):
      smb/server: cancel async requests when closing connection

Cheng Yongkang (2):
      io_uring/timeout: count cancelled timeouts in cq_timeouts
      io_uring/net: fix multishot recv length limit accounting

Cheng-Yang Chou (1):
      sched_ext: Fix scx_flush_disable_work() UAF race

Chengfeng Ye (1):
      KVM: x86: Take SRCU in kvm_zap_gfn_range()

Chih-Kang Chang (1):
      wifi: rtw89: wow: only WiFi 6 chips initialize RF registers in WoWLAN mode

Chin-Yen Lee (1):
      wifi: rtw89: wow: add QoS control field to WoWLAN ARP response for MLO

Chris Lew (1):
      rpmsg: char: Check for ongoing chrdev destroy

Chris Mason (17):
      ovl: set OVL_WHITEOUTS before publishing the upper dir
      ovl: take a snapshot of the name for copy up
      ovl: use the pinned upper dir in ovl_fix_origin()
      ovl: always encode the origin fh when index is enabled
      ovl: check the casefold flag of directories only
      ovl: do not copy up an xattr value that was never read
      ovl: fix a torn path in ovl_get_redirect()
      ovl: read the nlink xattr of every indexed non-dir
      ovl: set the revalidate flags after d_instantiate()
      sunrpc: pin gss module across auth_domain RCU free
      ovl: check that the parents of volatile/dirty are dirs
      ovl: hold a reference on the parent in readdir
      ovl: do not copy up a dentry that was removed
      io_uring/rsrc: charge buffer arrays and nodes to memcg
      io_uring: charge tctx nodes and personalities
      io_uring: free XArray nodes left by a failed store
      io_uring/sqpoll: don't wait for the thread to exit

Christian Brauner (9):
      exec: cancel io_uring requests before de_thread()
      fork: move the coredump and exec checks into create_io_thread()
      fork: don't create io threads once PF_POSTCOREDUMP is set
      coredump: prevent TIF_NOTIFY_SIGNAL from interrupting coredumps
      selftests/filesystems/overlayfs: fix set_layers_via_fds link error
      docs: update the unmount propagation rule
      Revert "namei: don't reveal overmounted entries in refwalk"
      ipc: drop the mqueue mount with kern_unmount() on setup failure
      ntfs3: free replaced mount options after a grace period

Christoph Zwerschke (2):
      Revert "Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU"
      Revert "Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU"

Chuck Lever (19):
      lockd: Fix use-after-free in nlmsvc_retry_blocked
      pnfs/blocklayout: Complete a device upcall only on its own reply
      pnfs/blocklayout: Complete a device upcall when the pipe is closed
      NFSD: Do not send CB_RECALL_ANY to NFSv4.0 clients
      NFSD: Don't complete a cld upcall the daemon has not read
      NFSD: Fail a pool_threads read whose reply does not fit
      NFSD: Fix out-of-bounds read in the rpc_status dump
      NFSD: map fh_verify() status codes for NFS_ACLv3 replies
      NFSD: Map flex file layout IDs through the request's user namespace
      NFSD: Reject an oversized principal hash from nfsdcld
      NFSD: Resolve the recall-any mask names in the trace format
      NFSD: Return NFSERR_ISDIR for NFSv2 READ and WRITE on a non-regular file
      NFSD: Set nn->cld_net before registering the cld pipe
      SUNRPC: Copy the deferred RPC Call from the head buffer
      SUNRPC: Do not credit control-record octets to the RPC stream
      SUNRPC: Reject a socket that already has an svc_sock attached
      SUNRPC: Reject a TLS alert record that is not two octets
      SUNRPC: Resume receiving after a TLS control record
      SUNRPC: Treat every TLS error alert as fatal

Colin Foster (1):
      clk: clocking-wizard: fix clock difference detection

Cong Nguyen (1):
      media: microchip-csi2dc: fix async notifier leak on probe error path

Csaba Budai (1):
      ALSA: hda/realtek: Fix ALC700 audio on Intel Hades Canyon

Daan De Meyer (1):
      io_uring/net: don't retry a non-blocking connect() that fails with -EAGAIN

DaeMyung Kang (5):
      ksmbd: avoid restoring only in-memory EOF after allocation change
      ksmbd: preserve unreadable named streams on open
      ksmbd: return end of file for reads past a named stream's data
      ksmbd: use the existing xattr name for a named stream
      ksmbd: fix named stream write and EOF handling

Daeho Jeong (1):
      f2fs: avoid setting SBI_NEED_FSCK on transient resize failure

Daehyeon Ko (1):
      cgroup: serialize migrations of newly forked processes

Daejun Park (1):
      nvmet: fix use-after-free of the old registrant in nvmet_pr_preempt()

Dairui Zhang (2):
      ksmbd: fix OOB read and cross-share confusion in ksmbd_validate_name_reconnect()
      ksmbd: verify transform SessionId matches the decrypted header

Damon Ding (1):
      drm/panel-edp: Add BOE NE160QDM-NY1 panel

Daniel Borkmann (1):
      ipv6: Implement limits on extension header parsing

Daniel Golle (4):
      net: dsa: mt7530: error out on failed PHY_IAC command writes
      net: dsa: mt7530: check bus->read() error in core_rmw()
      net: pcs: mtk-lynxi: check regmap reads in mtk_pcs_lynxi_get_state()
      net: dsa: mt7530: check CORE_PLL_GROUP4 access in mt7531_setup()

Daniel Ortiz (1):
      ASoC: amd: yc: Add DMI quirk for Lenovo V15 G6 ARP

Daniel Schaefer (1):
      iio: hid-sensor: als: scale each channel individually

Danish Khateeb (1):
      pps: generators: fix use-after-free when closing a removed device

Dapeng Mi (4):
      perf/x86/intel: Fallback to sw branch type decoding if no hw decoding
      perf/core: Fix kernel register info leak via hardware skid
      perf/x86: Unregister PMI handler on PMU init failure
      perf/x86: Free hybrid state on PMU init failure

Darrick J. Wong (70):
      xfs: fix integer overflow problem when setting large free areas
      xfs: don't cross reference rmapbt with bitmaps if they're incomplete
      xfs: clear the symlink zapped flag if inline symlink is ok
      xfs: mark cow extents bad if there's no rmap mapping for them
      xfs: compute the correct fdblocks/frextents for repair when they're negative
      xfs: fix ondisk symlink target validation in xrep_dinode_check_dfork
      xfs: fix xfs_rename_space_res for non-pptr filesystems
      xfs: fix missing xfs_qm_adjust_dqlimits call in quotacheck repair
      xfs: fix buffer overruns in xfs_ioc_attr_list
      xfs: online quotacheck must dirty dquot if enforcement adjustments needed
      xfs: avoid cross-rtgroup reaping after a repair
      xfs: actually lock the metafile reservation when adjusting after repair
      xfs: fix unnecessary dapos truncation in xchk_dir_walk
      xfs: fix buffer overflow in corrupt inline attr structure
      xfs: actually report corrupt xattrs as XFAIL during cross-referencing
      xfs: fix inode btree repair when a cluster is larger than a chunk
      xfs: always reset incore attr fork buffer when resetting fork
      xfs: don't pass iget failures up when marking ondisk inodes
      xfs: zero out di_metatype when removing the metadir file iflag
      xfs: flag excessive delalloc rt extents as corruption
      xfs: don't fix the directory tree if live update fails
      xfs: don't proceed with xattr repair if the live update fails
      xfs: fix skipped inode mask handling in iscan
      xfs: don't repair fs summary counters with garbage
      xfs: fix lost errno returned from xfarray_foliosort
      xfs: allow softlimit with no hardlimit in quota scrub
      xfs: assign an owner to scrub_stats_fops
      xfs: bail out of directory tree repairs on error
      xfs: fix revalidation of xchk_dquot_iter cached mappings
      xfs: abort dirtree repair if the live update hook dies
      xfs: check fork type against dabtree block magic number
      xfs: mark overfull dabtree node blocks as corrupt
      xfs: jump out of xchk_bmap_check_rmap if fatal signals
      xfs: adjust checks for cross-AG reaping issues
      xfs: actually check XFS_DIFLAG2_METADATA for metadata btree data forks
      xfs: fix xchk_stats_estimate_bufsize to allow for the trailing null
      xfs: reduce new btree slack factor if free space is negative
      xfs: reject absurdly large xattr value lengths in xchk_xattr_actor
      xfs: release ip after unlinked list store failure
      xfs: rescan the AGs if incore delalloc counter is negative
      xfs: update quota flags on secondary supers when metadir enabled
      xfs: abort directory tree repair whenever dl->aborted is set
      xfs: always forget cached ACLs if the attr fork swap succeeds
      xfs: always report inode repair setup failures
      xfs: always report scrub errors in tracepoints
      xfs: always zero the whole shortform header when zeroing attr fork
      xfs: check for fragments when full-extent sharing matches
      xfs: check for termination during rmap btree walk
      xfs: clarify various parts of the bitmap API
      xfs: clear set[ug]id mode bits when zapping attr fork
      xfs: complain loudly when dirtree checker finds broken links
      xfs: don't allow sm_agno for non-group metadir path checking
      xfs: don't clear COWEXTSIZE on directories on reflink filesystems
      xfs: don't overrun incore inode when cleaning attr forks
      xfs: don't queue rmap update twice when reaping a fork
      xfs: don't rescan ifree and icount when frozen
      xfs: don't scan across metadata/regular directory trees for dirents
      xfs: don't set a metadata directory's parent to sb_rootino
      xfs: don't subtract excess usage twice when computing agf_btreeblks
      xfs: don't try to repair rtsummary if the summary file isn't computed
      xfs: don't try to scrub self-referential dirent in metapath checker
      xfs: fix correction of unwritten extents in quota file data fork
      xfs: fix data fork block count check in xrep_inode_blockcounts
      xfs: init inode number for tracepoint
      xfs: never reset the default quota timer
      xfs: only written file data blocks can be shared
      xfs: opportunistically skip btree block checks
      xfs: propagate errors while checking null siblings
      xfs: range-check bc_levels array access in scrub tracepoints
      xfs: reattach dquots after changing inode ids

Dave Carey (1):
      HID: multitouch: Fix stale MT slots when contact count drops to zero

David Bauer (2):
      wifi: mt76: mt7603: free beacon SKB on error
      wifi: mt76: mt7915: configure noise floor reporting on reset

David C.C.M. Gall (3):
      crypto: keembay - use crypto_memneq() to compare GCM AEAD tags
      crypto: sa2ul - use crypto_memneq() to compare AEAD tag
      crypto: keembay - use crypto_memneq() to compare CCM AEAD tags

David Flynn (1):
      nfsd: fetch direct I/O alignment for files handed to the filecache

David Francis (2):
      drm/amdkfd: Avoid integer underflow with ffs in EOP ring size calc
      drm/amdkfd: Avoid integer underflow in EOP ring size calculation.

David Heidelberg (5):
      soc: qcom: socinfo: Add SoC ID for SDM850
      dt-bindings: arm: qcom,ids: Add SoC ID for Snapdragon SDM 850
      backlight: qcom-wled: Fix NULL pointer dereference in wled_remove()
      backlight: qcom-wled: Fix unbalanced OVP IRQ enable at probe
      backlight: qcom-wled: Fix WLED3 brightness register stride

David Hildenbrand (Arm) (1):
      mm/hugetlb: fix use-after-free in hugetlb_mfill_atomic_pte()

David Howells (5):
      rxrpc: Fix update of call->tx_pending without holding lock
      rxrpc: Fix lack of short-send handling in rxrpc_kernel_send_data()
      afs: Fix afs to abort the rxrpc call on send error
      rxrpc: Fix double IRQ enablement
      rxrpc: Fix return in rxrpc_recvmsg_data() for service calls

David Laight (1):
      usb_string_copy: Use kzalloc() to avoid leaking old data

David Maximiliano Hermitte (1):
      hfs: validate catalog CNIDs before instantiating inodes

David Strahan (1):
      scsi: smartpqi: Add new PCI device-ids

David Woodhouse (3):
      KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration
      KVM: x86/xen: Take kvm->srcu in __kvm_xen_has_interrupt()
      tun: Require CAP_NET_ADMIN to attach to an ownerless device

Deepanshu Kartikey (2):
      udf: avoid recursive s_alloc_mutex deadlock when freeing AED blocks
      media: imon: fix use-after-free in display_close via dev_dbg

Denis V. Lunev (1):
      virtio_balloon: warn on failed buffer add in tell_host()

Dev Jain (1):
      mm/migrate: use huge_ptep_get() in remove_migration_pte()

Devansh Soni (1):
      staging: rtl8723bs: fix missing unregister_netdev on sdio_alloc_irq failure

Devin Wittmayer (1):
      wifi: mt76: mt76x02: report rx FCS errors to mac80211

Diego Oliva (2):
      smb: client: fix use-after-free infoleak via the readdir resume name
      smb: client: fix OOB last_entry pointer from unbounded LastNameOffset

Dio Zhang (1):
      drm/panel: panel-edp: Adjust T8 timing for AUO B116XAK01.6 and B140XTK02.4

Dmitry Antipov (1):
      HID: roccat: fix locking in roccat_connect() and roccat_disconnect()

Dmitry Osipenko (1):
      clk: tegra: support 48MHz clock for pll_p_out1

Dmitry Torokhov (1):
      mfd: ipaq-micro: Fix out-of-bounds stack read in ipaq_micro_str

Dmytro Moroziuk (1):
      ALSA: hda/conexant: Add mute LED quirk for HP ProBook 440 G5

Dominik Maier (1):
      smb: client: fix slab-out-of-bounds write in id_mode_to_cifs_acl()

Donggeun Yoo (1):
      tracing: Fix NULL dereference when copying keys for a field variable

Eckhart Mohr (1):
      ALSA: hda/realtek: Add quirk for ASRock NUC BOX-358H

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Limit mic boost on Positivo N15RPE-S

Eliot Courtney (1):
      rust: bitmap: restrict bitmap length to at most i32::MAX

Emmanuel Grumbach (5):
      wifi: iwlwifi: mld: validate D3_END notif size
      wifi: iwlwifi: mld: reset the driver state upon firmware recovery
      wifi: iwlwifi: mvm: reset the smart fifo state upon FW stop
      wifi: iwlwifi: mld: validate wake packet crypto overhead
      wifi: iwlwifi: mvm: ignore sync frames when sync is disabled

Eric Dumazet (3):
      gre: fix ERSPAN o_flags race/corruption in xmit and fill_info
      nvme-tcp: delay nvme_tcp_reclassify_socket()
      vlan: restore HW VLAN tag insertion with reorder_hdr off

Eric Huang (1):
      drm/amdkfd: add sanity check in svm_range_is_valid

Eric Sandeen (1):
      xfs: validate rc_domain in xchk_rtrefcount_mergeable

Esteban Urrutia (1):
      iommu/arm-smmu-qcom: Add SM8450 MDSS compatible

Even Xu (2):
      HID: Intel-thc-hid: Intel-quickspi: Fix buffer overflow
      HID: Intel-thc-hid: Intel-quicki2c: Fix buffer overflow

Ewan D. Milne (1):
      scsi: devinfo: Add BLIST_SKIP_IO_HINTS for EMC Symmetrix

Fan Wu (6):
      media: au0828: fix use-after-free in bulk_timeout timer on disconnect
      ASoC: amd: ps: fix snd_acp63_remove() teardown ordering
      media: imx-jpeg: cancel timeout worker when streaming stops
      media: marvell: mcam: stop DMA and cancel s_bh_work before freeing DMA buffers
      media: s5p-mfc: use timer_shutdown_sync() for the self-rearming watchdog
      scsi: dc395x: sync the waiting_timer before freeing the host

Fang Xieyan (1):
      kcov: ignore an out-of-range comparison count in write_comp_data()

Farhan Ali (1):
      PCI: Avoid saving config space state if inaccessible

Federico Valentín Andrade (1):
      ALSA: usb-audio: Skip mixer creation on M-Audio Venom

Felix Fietkau (5):
      wifi: mt76: mt7615: fix NULL deref in mt7615_mac_set_rates
      wifi: mt76: set the EOSP bit in the QoS header of the last released frame
      wifi: mt76: mt7603: fix U-APSD service period termination
      wifi: mt76: mt7603: restore hardware PS buffering after a service period
      wifi: mt76: mt7603: file buffered frames under the TID reported to mac80211

Feng Tang (1):
      selftests: net: reuseport_bpf_numa: consider cpuless numa node

Fernando Fernandez Mancera (1):
      netfilter: tproxy: use DEBUG_NET_WARN_ON_ONCE for protocol fallbacks

Filipe Manana (1):
      btrfs: fix memory barrier order in reloc_root_is_dead()

Florian Westphal (6):
      netfilter: disable payload mangling in userns
      netfilter: nfnetlink_queue: restrict writes to network header
      netfilter: nftables: restrict linklayer and network header writes
      netfilter: nftables: restrict checkum update offset
      netfilter: nft_payload: restrict checksum offsets to known values
      netfilter: nf_tables: fix netdev hook allocation memleak with dormant tables

Frank Zhang (1):
      rust: rcpufreq_dt: add module alias

Fredric Cover (1):
      smb: client: fix early procfs exposure race

Fu Hao (1):
      ALSA: hda: Add support for Hygon family 18h model 5h HD-Audio

Gabor Tanz (1):
      HID: quirks: Always poll the Anne Pro 2 with product ID a292

Gabriel Prostitis (1):
      USB: gadget: inode: fix mm lifetime handling

Gael Blivet (5):
      ksmbd: fix durable handle v2 default timeout units (60 -> 60000)
      ksmbd: fix off-by-one rejecting minimal COPYCHUNK query-limits request
      ksmbd: skip fallocate for SMB2_CREATE_ALLOCATION_SIZE on a stream handle
      ksmbd: report actual xattr value length in stream enumeration
      ksmbd: fix AsyncId zeroed before use in smb2_lock() cancel response

Gangliang Xie (2):
      drm/amdgpu: add buf length check
      drm/amdgpu: add check for xcp id

Garrett Blackmon (1):
      ALSA: hda/realtek: Fix speakers on ASUS ROG Zephyrus G14 GA403UM

Gary Guo (2):
      ata: ata_generic: Don't store pci_device_id
      rust: cfi: disable function merging if CFI is enabled

Geetha sowjanya (1):
      perf: marvell: Cancel CN10K DDR PMU hrtimer on device remove

Geliang Tang (1):
      nvme-tcp: look up host_iface in the current netns

Genjian Zhang (1):
      md/raid5: complete discard bios while reshape is active

Gilles Risch (1):
      drm/radeon: fix internal display on iMac11, 1 (RV770/DCE3.1)

Giorgi Kobakhia (2):
      udf: fix return value for non-recorded-allocated extents in udf_map_block()
      ksmbd: fix overflow in dacloffset bounds check in build_sec_desc()

Greg Kroah-Hartman (1):
      Linux 6.18.61

Gregory CLEMENT (1):
      MIPS: Fix HOTPLUG_PARALLEL dependency

Griffin Kroah-Hartman (2):
      nfc: mrvl: spi: Unregister dev on allocation fail
      nfc: nxp-nci: Add remove on IRQ error

Guanghui Feng (1):
      iommu/vt-d: Fix CACHE_TAG_NESTING_DEVTLB polluting shared variables in flush loop

Guangshuo Li (1):
      RDMA/irdma: avoid use-after-free in icrdma_remove

Guenter Roeck (2):
      hwmon: (lm90) Rely on subsystem locking
      hwmon: (asus_rog_ryujin) Rely on subsystem locking

Guopeng Zhang (1):
      fs/namespace: notify pollers of legacy propagation changes

Gustavo Evgucci (1):
      Bluetooth: btusb: Add USB ID 13d3:3625 for MediaTek MT7922

Günther Noack (1):
      landlock: Fix superblock use-after-free in release_inode()

Haikun Zhou (1):
      drm/panel-edp: Support MB116AS01'3 edp panel

Hans Verkuil (5):
      media: em28xx: dev_info->pr_info since dev has been freed
      media: em28xx: requeue buffers if start_streaming fails
      media: em28xx: use vb2_video_unregister_device
      media: cec: tegra_cec: don't break off msg on NACK
      media: cec/core: drop cec_post_state_event call

Haoxiang Li (4):
      ASoC: hdac_hdmi: Fix resource cleanup on probe failure
      tty: serial: pch_uart: add check for pci_get_slot()
      usb: fsl_qe_udc: check qe_alloc_request() failure in ch9getstatus()
      iwlwifi: dvm: add missing cleaup for on error path

Harald Freudenberger (4):
      s390/crypto: Fix return code handling at skcipher_walk_done in PAES algorithms
      s390/crypto: Fix use of mutex in atomic context in PAES
      s390/crypto: Fix handling of EBUSY in PAES when req is pushed to crypto engine
      s390/zcrypt: Fix out-of-bounds ptr advance in cca_query_crypto_facility()

Hari Mishal (5):
      nvme: bound ns descriptor header and body to identify buffer
      nvme: clamp FDP nruhsd to allocated RUH status descriptor count
      virtio_console: take a kref in find_port_by_vq() to fix port UAF
      nvmet: passthru: fix OOB reads when parsing ns id descriptor list
      drm/amd/display: guard dc_sink dereferences in MST mode validation

Hazem Mohamed Abuelfotoh (1):
      Revert "net: Convert proto_ops bind() callbacks to use sockaddr_unsized"

Heiko Carstens (6):
      s390/mm: Add missing mm check to do_secure_storage_access()
      s390/mm: Fix handling of vmalloc area in do_secure_storage_access()
      s390/extable: Fix mvcos instruction decoding
      s390/kprobes: Prevent kprobes on instructions with exception table entry
      s390/probes: Fix wrong opcode for cgrb fixup
      s390/signal: Fix incorrect return address in signal frame

Heiko Schocher (1):
      drm/panel: simple: Add Kyocera tcg070wvlq panel

Helge Deller (1):
      fbcon: Fix KASAN slab-out-of-bounds Read in fbcon_prepare_logo

Henry Hu (1):
      ksmbd: fix invalid pointer dereference when get_inode_acl() fails

Henry Martin (1):
      smb: client: fix use-after-free in cifs_ses_add_channel()

Hernan Ganzo (1):
      ALSA: hda/realtek: Limit internal mic boost on HP Pavilion 15 (103c:2164)

Hungyu Lin (1):
      ovl: reserve space for the casefolded name terminator

Håkon Bugge (1):
      net/rds: hold the socket while an rds_mr references it

Ian Abbott (11):
      comedi: ni_atmio16d: Add sanity check to interrupt handler
      comedi: ni_at_a2150: Fix sanity check in interrupt handler
      comedi: pcm818: Fix sanity check in interrupt handler
      comedi: quatech_daqp_cs: Fix sanity check in interrupt handler
      comedi: das6402: Add sanity check to interrupt handler
      comedi: dt2811: Fix sanity check in interrupt handler
      comedi: pcm711: Fix sanity check in interrupt handler
      comedi: aio_iiro_16: Add sanity check to interrupt handler
      comedi: pcmmio: Add sanity check to interrupt handler
      comedi: pcm816: Fix sanity check in interrupt handler
      comedi: pcmuio: Add sanity check to interrupt handler

Ian Bridges (3):
      ksmbd: fix session reference leak on compounded SESSION_SETUP
      ksmbd: fix out-of-bounds read when padding the final compound response
      ksmbd: fix use-after-free after a failed durable reconnect

Ido Schimmel (1):
      ipv6: udp: Create exceptions before socket matching

Igor Paunovic (1):
      accel/rocket: search every core slot when looking up a scheduler

Igor Putko (1):
      serial: core: shut down initialized port on removal

Ilan Peer (1):
      wifi: iwlwifi: mld: Do not cleanup FW state when the device is dead

Ilya Maximets (1):
      net/sched: act_ct: remove 'add_helper' dead code

Imre Kaloz (1):
      mm/slab: sample slab_state once in kmem_cache_destroy()

Israel Téllez García (1):
      libbpf: Fix ring buffer consumer loop on 32-bit position wrap

Iva Kasprzaková (1):
      Bluetooth: fix BT dependency for submodules

Jack Yu (1):
      ASoC: rt712-sdca: Pull high JD2 to prevent from entering TV mode

Jaidheer Sirigineedi (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Pavilion 15-eg3xxx (103c:8bfd)

Jakub Gawlik (1):
      ALSA: hda/realtek: Add micmute LED quirk for Acer Swift SFG16-72

Jamal Hadi Salim (3):
      net/sched: cls_bpf: accept dev-bound programs on shared blocks
      net/sched: sch_teql: fix slaves_lock IRQ deadlock
      net/sched: act_ife: do not consume the inner header on egress

James Kim (1):
      rapidio: mport_cdev: fix use-after-free in mport_mm_close()

Jan Kara (1):
      udf: Fix bh leak for unallocated space entries

Jan Koester (1):
      ksmbd: ignore network devices of other namespaces

Janne Grunau (1):
      nvmem: core: Fix OOB read for bit offsets of more than one byte

Jasper Firth (1):
      ASoC: Intel: bytcr_rt5651: Add quirk for Chuwi Hi8 with generic DMI strings

Jay Vadayath (1):
      udf: bound lengthAllocDescs from unallocated space entry

Jean Delvare (1):
      EDAC/mc: Really fix error path ordering in edac_mc_alloc()

Jeff Layton (5):
      nfsd: dedup nfs4_client_to_reclaim inserts
      nfsd: use test_and_clear_bit for somebody_reclaimed to prevent lost update
      NFSD: cap the number of listeners accepted in listener_set
      NFSD: validate transport name in listener_set before serv creation
      SUNRPC: keep the first error in svc_register()

Jenson Johnathon Reggentin (1):
      docs: block: fix dead http link in blk-mq.rst

Jerome Brunet (1):
      clk: sunxi-ng: fix ccu probe clock unregister on error

Jesse Zhang (3):
      drm/amdgpu/mes_v12_0: use mes schedule pipe for legacy queues on unified MES
      drm/amdgpu/gfx12: set KMD_QUEUE for kernel gfx queues
      drm/amdgpu/gfx11: set KMD_QUEUE for kernel gfx queues

Jia Zhu (1):
      NFSv4: pin the superblock for active state owners

Jiakai Xu (1):
      RISC-V: KVM: Fix double-free of sdata in kvm_pmu_clear_snapshot_area()

Jiale Yao (16):
      HID: zydacron: validate key report length
      HID: cougar: reject short special-key reports
      HID: cp2112: validate response report lengths
      HID: elo: reject short touchscreen reports
      HID: logitech-dj: validate unnumbered keyboard reports
      HID: mcp2200: validate READ_ALL response length
      HID: mcp2221: validate response report length
      HID: prodikeys: validate fixed-format MIDI reports
      HID: pxrc: reject short input reports
      HID: roccat: isku: reject short button reports
      HID: roccat: koneplus: reject short button reports
      HID: roccat: konepure: reject short button reports
      HID: roccat: kovaplus: reject short button reports
      HID: roccat: pyra: reject short button reports
      HID: roccat: ryos: reject short special reports
      HID: roccat: savu: reject short special reports

Jiaming Zhang (2):
      hfsplus: validate extent record length before writing it back
      ocfs2: fix chunk number of the first chunk in a local quota file

Jiawen Liu (6):
      spi: bcm-qspi: return error from failed controller suspend
      spi: bcm63xx: return error from failed controller suspend
      spi: bcm63xx-hsspi: return error from failed controller suspend
      spi: fsl-dspi: clean up after failed suspend and resume
      spi: nxp-fspi: disable runtime PM on probe failures
      spi: bcmbca-hsspi: return error from failed controller suspend

Jiawen Wu (1):
      net: libwx: disable TX VLAN offload for packets with >2 VLAN tags

Jiaxing Hu (1):
      iommu/rockchip: Clear stale page faults before enabling stall

Jiayuan Chen (1):
      netfilter: ebtables: bound num_counters like nentries in do_replace()

Jimmy Zuber (2):
      fuse: zero the partial EOF page when extending a file
      NFS: Fix stale negative cache on failed nfs_mkdir()

Jingyi Wang (2):
      remoteproc: qcom: Check subdev start status in rproc_stop()
      remoteproc: core: cancel crash_handler work in rproc_add() error path

Jinhui Guo (1):
      net: usb: cdc_ether: add quirk for AMI BMC stale link events

Jinqian Yang (1):
      virtio_ring: fix infinite loop in virtnet_poll_cleantx when device is broken

Joe Simmons-Talbott (1):
      selftests/cgroup: Adjust cpu test duration based on HZ

Johan Alvarado (1):
      net: stmmac: raise TX completion interrupt at the end of an xmit burst

Johan Hovold (3):
      driver core: take parent lock on deferred probe
      driver core: fix parent lock use-after-free on USB disconnect
      media: usbtv: drop redundant device reference

John Garry (2):
      nvme: handle positive error codes in nuse_show()
      nvme: don't reference NS after unlocking in nvme_ns_head_ctrl_ioctl()

John Johansen (1):
      apparmor: fix auditing of mount binary data

Jonas Karlman (1):
      drm/rockchip: dw_hdmi: Use resume_early pm ops for system suspend

Jonathan Gopel (1):
      thunderbolt: Do not RPM complete unrelated subtrees on unplug

Jori Koolstra (1):
      pps: change pps_gen_class to a const struct

Jose Villaseñor Montfort (1):
      HID: input: read battery capacity from its actual report offset

Josef Bacik (3):
      driver core: Limit the messages on a refused uevent
      mm/hugetlb: fix use-after-free of a new anon folio
      io_uring/io-wq: no new workers once the exit has begun

Joseph Qi (2):
      ocfs2/dlm: hold the lookup reference across convert AST enqueue
      ksmbd: fix breaking_cnt leak on early return in oplock_break()

Junhao He (1):
      ACPI: APEI: Handle repeated SEA error storms

Junzhe Yu (1):
      ext4: guard against NULL s_group_info in ext4_get_group_info

Jurison Murati (2):
      media: i2c: ov8865: Drop the runtime PM usage count on stream failure
      media: i2c: ov8865: Program the sensor on stream start

Jérémy Jean (2):
      nfsd: preflight SEQUENCE replies before accepting a slot
      SUNRPC: fix oversized GSS proxy token copy

K Prateek Nayak (1):
      arm64/runtime-const: Use aarch64_insn_patch_text_nosync() for patching

KIM MinWoo (1):
      ALSA: hda/realtek: Add quirk for Lenovo ThinkBook 16p Gen 3 ARH (21EK)

Kaho Jiang (1):
      net: ipv4: add zero check for snd_cwnd_clamp

Kameron Carr (1):
      Drivers: hv: vmbus: Bounds check the shared ring buffer indices

Karl Mehltretter (4):
      tpm: atmel: depend on X86
      ARM: 9524/1: mm: align hugetlb mappings to the huge page size
      ksmbd: use u8 for SMB2 oplock level values
      klist: avoid accesses after waking klist_remove()

Kate Hsuan (1):
      ACPI: battery: Sanitise model_number by dropping unprintable characters

Kemeng Shi (1):
      irqdomain: Plug leak in irq_domain_alloc_irqs_locked() error path

Keqiang Duan (1):
      KVM: x86: Clear hardware HLT state when userspace makes a vCPU not-halted

Kevin Cheng (1):
      KVM: VMX: Synthesize nested EPT violation GVA_IS_VALID/GVA_TRANSLATED bits

Kevin Wang (1):
      drm/amd/pm: fix gpu metrics energy accumulator for smu 13.0.0/13.0.7

Konstantin Komarov (3):
      ntfs3: fix info-leak in ntfs_rename()
      fs/ntfs3: load ATTR_BITMAP run extents from $MFT extension records
      fs/ntfs3: Fix memory leak in indx_find_sort()

Krish Gulati (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Victus 15-fb2xxx

Kryštof Černý (1):
      w1: ds2482: add OF device match table

Kuan-Wei Chiu (2):
      riscv, bpf: Add support for BPF_SDIV and BPF_SMOD in RV32 JIT
      riscv, bpf: Add support for BPF_MOVSX in RV32 JIT

Kuninori Morimoto (1):
      ASoC: codec: max98926: fixup invert setup mask

Kuniyuki Iwashima (1):
      tcp: Fix potential UAF in reqsk_timer_handler().

Kyle Zeng (4):
      udf: validate extent partition references in udf_current_aext()
      fs/ntfs3: reserve NUL byte when converting UTF-16 names
      io_uring/io-wq: save worker type before dropping its reference
      io_uring: defer foreign io-wq enqueues to task_work

Lachlan Hodges (1):
      wifi: cfg80211: include cf1 offset when sending chandef

Laxman Acharya (1):
      Bluetooth: hci_event: fix out-of-bounds read in LE PA report reassembly

Lee Jones (5):
      HID: wacom: Use hdev->product in wacom_setup_touch_input_capabilities
      HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration
      HID: wacom: Fix Use-After-Free in wacom_intuos_pad
      HID: wacom: Fix Use-After-Free in wacom_bamboo_pad
      HID: wacom: Redesign shared sibling data lifecycle

Li Jun (2):
      spi: loongson: pm: add .freeze .poweroff .thaw .restore
      tpm: tpm_tis_spi: fix nodef CR50 tpm_tis_spi_resume is null

Li Qiang (2):
      Bluetooth: bfusb: validate received block boundaries
      Bluetooth: hci_bcsp: validate received packet lengths

Li RongQing (1):
      x86/ioperm: Prevent NULL dereference on theoretical missing IO bitmap

Lijo Lazar (6):
      drm/amdgpu: Add checks to vbios fetch through ATRM
      drm/amdgpu: Validate ATPX buffer length before use
      drm/amdgpu: Fix kobject cleanup in xcp sysfs
      drm/amdgpu: Validate ATIF buffer length before use
      drm/amd/pm: validate vega10 profile mode inputs
      drm/amdgpu: Guard reads in pcie state readout

Loc Nguyen (1):
      KVM: x86: Request event processing for exception VM-Exits

Logan Gunthorpe (2):
      PCI: switchtec: Add Microchip PCI1008 device ID
      PCI: switchtec: Add Microchip PCI1008 to NTB DMA alias quirk

Lorenzo Pieralisi (2):
      dt-bindings: interrupt-controller: gicv5: Relax IRS properties constraints
      irqchip/gic-v5: Fix standalone IRSes OF probe

Lorenzo Stoakes (ARM) (1):
      HID: picoLCD: check for fb_deferred_io_init() error

Luca Castaldini (1):
      ALSA: hda/realtek: Add mute LED support for HP Pavilion 15-eh2xxx

Lucas Martins Alves (1):
      usb: musb: host: clear stale RX interrupt on three-strikes error

Lucas Stach (2):
      drm/etnaviv: check all modules for idle after reset
      drm/etnaviv: check MMUv2 status after reset

Luis Banha (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Pavilion 15-ec1xxx

Luxiao Xu (1):
      smb: client: fix buffer overflow in SMB2_tcon()

Mahmoud Nagy Adam (1):
      selftests: ublk: install test_common.sh and trace/ scripts

Manikanta Pubbisetty (1):
      wifi: ath10k: trigger hardware recovery upon rx failures

Marcos Paulo Medeiros (1):
      ACPI: video: force native backlight on Acer Nitro AN515-46

Marek Szyprowski (1):
      mmc: dw_mmc: stop and complete DMA also in STATE_DATA_BUSY state

Mariano Baragiola (1):
      wifi: wilc1000: validate monitor transmit frame headers

Mario Limonciello (1):
      platform/x86/amd: hfi: Fix a use-after-free when unloading the driver

Mario Peter (1):
      driver core: take parent lock in async device attach

Mark Brown (1):
      regmap: irq: Free the irqdomain we create

Mathias Nyman (1):
      xhci: include all root port children in recovery prevention on link error

Matt Turner (1):
      alpha: run the remote RTC access in a worker, not an IPI callback

Matthew Auld (1):
      drm/xe/display: skip FORCE_WC and vm_bound check for external dma-bufs

Matthew Jacob (1):
      drm/amdgpu: Support some Barco AMD based graphics adapters

Matthew Stewart (1):
      drm/amd/display: Fix rounding errors in CalculatePrefetchSchedule

Matus Gajdos (1):
      ALSA: usb-audio: Add native DSD support for Cambridge Audio streamers

Mauricio Orozco (1):
      ALSA: hda/realtek: Add quirk for ASUS VivoBook M515DA/X515DAP

Maurizio Lombardi (1):
      nvme-fc: do not warn on controller removal race

Md Rabbani (1):
      net: stmmac: fix device node reference leaks in stmmac_mtl_setup()

Mehmet Aysel (2):
      ASoC: amd: acp3x-es83xx: Add HVY-WXX9/M1060 DMI quirk
      ASoC: amd: acp-config: Add HVY-WXX9/M1060 DMI quirk

Mehmet Koseoglu (1):
      rust: cpufreq: reject NULL from cpufreq_cpu_get()

Michael Reeves (1):
      regmap: Remove debugfs before cache teardown

Michail Andreas Michalopoulos (1):
      ksmbd: accept share config responses from ksmbd-tools before 3.5.3

Michail Tatas (2):
      USB: misc: uss720: Fix leak in get_1284_register
      ipmi: Fix leak in __ipmi_bmc_register

Michal Pecio (1):
      ALSA: usx2y: Stop clearing urb->hcpriv before submission

Miguel Ojeda (1):
      objtool/rust: add one more `noreturn` Rust function for Rust 1.101.0

Mike Rapoport (Microsoft) (1):
      x86/mm/pat: Fix effective RW computation in lookup_address_in_pgd_attr()

Mike Snitzer (2):
      NFS/localio: fix nfs_local_dio_misaligned tracepoint
      NFS/localio: report the stability a DIO WRITE actually has

Mike Tipton (1):
      pmdomain: qcom: rpmhpd: Skip retention by default

Mikko Perttunen (1):
      gpu: host1x: Wait for timeout worker completion on channel free

Ming Lei (2):
      selftests/ublk: fix Makefile to rebuild on header changes
      selftests: ublk: increase timeout to 150 seconds

Minghao Zhang (1):
      netfilter: conntrack: tcp: use UNACK timeout for non-closing RST packets

Miquel Raynal (1):
      spi: cadence-qspi: Fix status polling with octal DTR chips

Miri Korenblit (2):
      wifi: iwlwifi: support TTL platform device ID
      wifi: iwlwifi: mld: cancel wiphy work before freeing wiphy

Mithil Bavishi (1):
      ARM: OMAP2+: Add CFI type for omap4_finish_suspend

Muhammad Saheed (1):
      Bluetooth: hci_sync: Disable legacy instance's ext adv before setup snapshot

Muhtasham Nawr al-Mahmud (1):
      ALSA: hda/realtek: Fix speakers on ASUS PM3406CHA

Mukesh Ojha (3):
      iommu/qcom: Check pm_runtime_resume_and_get() return in probe
      iommu/qcom: Enable clocks before hardware access in qcom_iommu_ctx_probe()
      iommu/qcom: Publish pgtbl_ops before releasing init_mutex

Muralidhara M K (2):
      platform/x86/amd/hsmp: Validate ACPI UID before parsing socket index
      platform/x86/amd/hsmp: Validate _DSD mailbox sub-package element count

Myeonghun Pak (4):
      media: cx88: Disable PCI device on MPEG initialization failure
      backlight: lm3630a: Cancel delayed work before destroying workqueue
      media: cx23885: unregister DVB bus when SP2 CI setup fails
      power: supply: sbs-battery: disable polling before supply teardown

Namhyung Kim (1):
      tools/lib/api: Fix potential double-free from fdarray__grow()

Namjae Jeon (19):
      ksmbd: wait for negotiation before receiving another PDU
      ksmbd: protect private extended attributes
      ksmbd: preserve access denied status for copychunk
      ksmbd: allow I/O on directory named streams
      ksmbd: reject SMB3.1.1 binding with mismatched cipher
      ksmbd: return buffer too small for short security queries
      ksmbd: handle empty QUERY_ALLOCATED_RANGES output
      ksmbd: honor byte-range locks for zero data
      ksmbd: allow FSCTL_SET_SPARSE without input buffer
      ksmbd: fix SMB2 byte-range lock end offset
      ksmbd: reject blocking compound lock requests
      ksmbd: honor client signing-required in all modes
      ksmbd: notify parent directory leases on child create
      ksmbd: enable TCP keepalive for accepted connections
      ksmbd: handle allocated range queries on dense files
      ksmbd: fix extended session security negotiation for raw NTLMSSP
      ksmbd: validate security descriptor offsets before pointer arithmetic
      ksmbd: prevent share root removal through empty paths
      ksmbd: prevent stale data from being written by SMB2 WRITE requests

Neil Andrews (1):
      ALSA: usb-audio: Rename the Audient iD14 monitor mix volume control

NeilBrown (1):
      nfsd: honour client-provided attributes for NFS4_CREATE_EXCLUSIVE4_1

Ngoc Quy (1):
      fs/proc/task_mmu: pin mm_users in do_pagemap_scan()

Nguyen Quang Le Kien (1):
      usb: gadget: fix refcount underflow in gadgetfs_bind() error path

Nickolai Zeldovich (1):
      resource: report a devm_request_resource() conflict under the lock

Nicolas Escande (1):
      wifi: ath12k: avoid setting 320MHz support on non 6GHz band

Nicolin Chen (2):
      iommu/tegra241-cmdqv: Rate-limit the error ISR's log message
      iommu/arm-smmu-v3: Disable the impl before disabling the SMMU on shutdown

Niklas Cassel (1):
      ata: sata_fsl: Fix use-after-free of host_priv on probe() failure

Niranjana Vishwanathapura (1):
      drm/xe: only resume exec queues that were actually suspended

Nirmoy Das (1):
      iommufd: Fix event queue release use-after-free

Nizar Al-Kabbani (1):
      platform/x86: asus-nb-wmi: map ProArt key (0x8b) to KEY_PROG3

Nícolas F. R. A. Prado (1):
      ALSA: hda: Force resume if acomp notified during system suspend

Oleg Keri (1):
      HID: i2c-hid: add reset quirk for Lenovo Yoga Slim 7x Gen 11 keyboard

Oleg Proshkin (1):
      mfd: axp20x: Preserve other control bits when powering off

Oliver Neukum (1):
      usb: misc: cypress_cy7c63: check result of IO

Osama Abdelkader (1):
      drm/panthor: Fix TOCTOU race between GROUP_REGISTERED check and erase

Pablo Neira Ayuso (6):
      netfilter: nf_tables: call skb_valid_dst() before skb_dst()
      netfilter: nf_conntrack_expect: use conntrack GC to reap expectations
      netfilter: nf_conntrack_expect: add and use nf_ct_expect_related_pair()
      netfilter: ctnetlink: do not expose expectation DEAD flag
      netfilter: nft_meta: add double-tagged vlan and pppoe support
      netfilter: conntrack: always lower timeout for non-closing RST packets

Paolo Bonzini (1):
      KVM: x86/mmu: pass PFERR_GUEST_PAGE/FINAL_MASK to kvm_translate_gpa

Paritosh Potukuchi (1):
      i2c: amd-asf: Validate firmware-reported length

Paulo Alcantara (9):
      smb: client: fix uid/gid override in getattr with posix extensions
      smb: client: fix WSL reparse point uid/gid override
      smb: client: fix fattr leaking on wsl_to_fattr() failure
      smb: client: clear post-EOF pagecache when extending a file via truncate
      smb: client: discard post-EOF pagecache when extending a file via clone range
      smb: client: drain and invalidate before server-side copy/clone
      smb: client: only require read lease for size-extending zero range
      smb: client: require stable pages for signed connections
      smb: client: don't resurrect an exiting tcon from cached dir workers

Pavel Zverev (1):
      Bluetooth: btusb: Add support for 1357:c123 Realtek 8852BE device

Pei Xiao (2):
      ipack: ipoctal: add rwsem to guard against TOCTOU in remove path
      media: cx23885: Fix use-after-free in cx23885_finidev due to race condition

Pengpeng Hou (47):
      gpio: pca9570: Use I2C match data
      media: cec: stm32: return an error when log-address wait times out
      ASoC: sma1303: remove fault-check sysfs group on remove
      spi: qpic-snand: free OOB buffer with ECC context
      ASoC: tlv320aic26: remove keyclick sysfs file
      dmaengine: pl330: remove debugfs file on teardown
      soc: amlogic: meson-clk-measure: remove debugfs tree
      iio: adc: max1241: add missing MODULE_DEVICE_TABLE()
      gpio: sifive: add missing MODULE_DEVICE_TABLE()
      mmc: moxart: report DMA completion timeout
      mmc: sdhci-of-ma35d1: add missing MODULE_DEVICE_TABLE()
      usb: typec: mux: tusb1046: add missing MODULE_DEVICE_TABLE()
      ASoC: codecs: uda1342: Leave cache-only mode before syncing
      ASoC: codecs: max98396: Unwind supplies on resume failure
      media: cec: tegra: add missing MODULE_DEVICE_TABLE()
      pinctrl: sx150x: add missing MODULE_DEVICE_TABLE()
      crypto: keembay - add missing MODULE_DEVICE_TABLE()
      gpio: vf610: add missing MODULE_DEVICE_TABLE()
      media: ivtv: stop VBI start-code scan before short tail
      media: cx18: stop VBI start-code scan before short tail
      wifi: iwlwifi: validate PNVM SKU TLV length
      wifi: iwlwifi: validate UEFI reduced-power SKU TLV length
      uio: sercos3: add missing MODULE_DEVICE_TABLE()
      misc: rp1: clear chained IRQ handlers on teardown
      greybus: manifest: validate string descriptor header
      ACPI: FPDT: validate table and record lengths
      power: supply: cros_pchg: unregister EC notifier
      power: reset: piix4-poweroff: add missing MODULE_DEVICE_TABLE()
      thermal: intel: int340x: clean up RFIM groups on DVFS failure
      wifi: ath11k: validate regulatory capability phy_id
      soc: ixp4xx: qmgr: add missing MODULE_DEVICE_TABLE()
      firmware: imx: scu: manage mailbox channels and global handle
      hsi: omap_ssi: remove debugfs on port creation failure
      clk: imx: imx8qxp: add missing MODULE_DEVICE_TABLE()
      clk: imx: imx8qxp-lpcg: add missing MODULE_DEVICE_TABLE()
      clk: mediatek: mt6735-vdecsys: add missing MODULE_DEVICE_TABLE()
      clk: mediatek: mt6735-vencsys: add missing MODULE_DEVICE_TABLE()
      i2c: qup: Propagate clock enable failures
      soc: mediatek: add missing MODULE_DEVICE_TABLE()
      HID: rmi: check report length before trimming sentinel bytes
      Bluetooth: hci_nokia: validate firmware packet bounds
      fbdev: udlfb: validate vendor descriptor items
      rtc: ab-eoz9: add missing MODULE_DEVICE_TABLE()
      rtc: brcmstb-waketimer: add missing MODULE_DEVICE_TABLE()
      tracing: Use __free() for expr_str() buffer
      tracing: Return ERR_PTR() from expr_str()
      tracing: Bound histogram expression strings with seq_buf

Peter Griffin (1):
      opp: fix use after free in _update_opp_table_clk()

Peter Ujfalusi (1):
      ASoC: SOF: Intel: mtl: Power down DSP if it is left enabled in pre_fw_run()

Peter Zijlstra (1):
      s390/crypto: Replace cond_resched() with msleep(1)

Petr Mladek (1):
      nbcon/reboot: Switch NBCON consoles into the emergency mode in emergency_restart()

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: remove gart_window_lock usage from gmc v12

Ping Cheng (2):
      HID: wacom: Setup SW_MUTE_DEVICE according to the order of input registration
      HID: wacom: Write shared touch initial status only once

Pranjal Shrivastava (1):
      PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs

Prashant Rahul (1):
      wifi: mt76: mt7921: fix memory leak when skb_linearize fails in mcu rx event

Praveen Talari (1):
      opp: Use clk_get_optional() to avoid leaving opp_table->clk as an error pointer

Qing Luo (1):
      sctp: auth: discard auth_chunk when skb_clone fails

Qingtao Cao (1):
      bus: mhi: core: Fix sys error transition latency

Rahul Bukte (1):
      serial: 8250: force synchronous probe for the ISA and PNP drivers

Randolph Sapp (1):
      drm/etnaviv: force flush on power register ops

Randy Dunlap (1):
      fbdev: maxine: fix 64-bit build error

Ratnaker Gautam (1):
      smb: client: validate NT transaction response layout and offsets

Reinhard Speyerer (1):
      net: usb: qmi_wwan: add Rolling Wireless RN947R

Richard Cheng (1):
      sched_ext: sync disable_irq_work in bpf_scx_unreg()

Richard Patel (2):
      genirq: Defer kfree(irqaction) until irq_thread_dtor() finishes
      genirq: Move interrupt thread exit_work object to irqaction

Ridham Khurana (1):
      platform: cznic: turris-omnia-mcu: Add missing MODULE_DEVICE_TABLE()

Rik van Riel (1):
      media: redrat3: fix UAF in probe error path leaving rc device registered

Rituparna Warwatkar (1):
      media: dvb-core: fix feed leak on failed DMX_ADD_PID

Rob Clark (2):
      drm/msm: Move nr_cmds initialization
      drm/msm: Fix barriers accessing ctx vm

Robert Leussler (1):
      rtc: ds1307: fix RX8130 wakeup alarm WADA bit for day-of-month mode

Robin Everaars (1):
      ACPI: button: Add DMI quirk for Razer Blade Pro 17 early 2020 lid switch

Rohinthan P (1):
      media: em28xx: use video_unregister_device for radio_dev

Rongguang Wei (1):
      tap: fix incorrect variable used for USO check in set_offload()

Rosen Penev (5):
      ata: pata_ep93xx: fix PIO fallback when DMA init fails
      nvmem: brcm_nvram: reject empty NVRAM partition
      nvmem: brcm_nvram: fix out-of-bounds access on malformed flash data
      gpio: mvebu: keep resume masks within the irqchip cache
      wifi: ath9k: delete channel-context timers on deinit

Rui Qi (2):
      selftests/ftrace: Force C locale in ftracetest
      riscv: kprobes: Prevent probes in breakpoint handlers

Ruoyu Wang (4):
      drm/radeon: avoid double free in r600 DPM cleanup
      HID: wacom: avoid copying Bluetooth input reports
      memory: stm32_omm: initialize ret in stm32_omm_set_amcr
      ntfs3: initialize err in attr_wof_frame_info

Ryosuke Yasuoka (1):
      drm/virtio: abort virtqueue wait on device removal to avoid hung task

Scott Gauche (1):
      ALSA: hda/realtek: Fix audio after Windows reboot on ASUS Q423SA

Sean Christopherson (12):
      KVM: x86: Fill kvm_run exit fields in common get_nested_state_pages() error paths
      KVM: SVM: Preserve TLB control (i.e. pending TLB flush) on failed VMRUN
      KVM: SVM: Update control fields on #VMEXIT if and only if VMRUN succeeded
      KVM: x86: Tell ->inject_page_fault() whether or a fault came from hardware
      x86/cpuid: Mark CPUID function 0x23 as being indexed
      KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when preparing L2 state
      KVM: Use goto to handle errors during memslot preparation
      KVM: VMX: Disallow using to_vmx() in common VT code
      KVM: x86/mmu: Bug the VM if KVM attempts to walk more levels than the MMU has
      KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with EFER.LMA=1 && CR4.PAE=0
      KVM: x86: Preserve DR6.BLD (Bus Lock Detect) when delivering #DB payload
      KVM: x86: Zero reserved synic flags when delivering message to avoid stack leak

Sean Rhodes (1):
      mmc: rtsx_usb_sdmmc: suppress false CD after init timeout

Sean Young (9):
      media: rc: Ensure that rc_unregister_device() does not free input device
      media: rc: Ensure registered is cleared in error path
      media: rc: Fix race between bpf(BPG_PROG_ATTACH) and device unregister
      media: rc: mce_kbd: Fix inconsistent locking of keylock
      media: rc: Use after free in ir_raw_event_handle()
      media: rc: After rc_unregister_device() timers can be re-armed
      media: rc: Fix use after free in bpf progs
      media: rc: Fix ABBA deadlock by making locks more fine grained
      media: rc: Fix build failure with CONFIG_LIRC disabled

Seiji Adachi (1):
      ASoC: amd: yc: Add Lenovo ThinkPad E16 Gen 2 (21JN) to quirks

Senjin (1):
      fs/ntfs3: fix lseek EINVAL on sparse/compressed files with 64-bit clusters

Seyeong Kim (1):
      RDMA/irdma: Suppress PF reset on HMC error

Shahar Tzarfati (1):
      wifi: mac80211: ibss: read deauth reason_code after frame length check

Shang En Sim (1):
      ALSA: hda/realtek: Enable mute LEDs on HP Spectre x360 16-aa0xxx

Sharath Srinivasan (1):
      net/rds: fix rds_message leak in the rds_send_xmit() drop path

Shiji Yang (1):
      net: ethernet: mtk_wed: increase WED v2 WDMA RESV_BUFF to 0x80

Shivaprasad G Bhat (1):
      scsi: qla2xxx: Handle INTx not connected while passing through

Shuangpeng Bai (1):
      media: gspca: use vb2_video_unregister_device() on disconnect

Simon Glass (1):
      kconfig: abort rather than loop for ever on EOF

Srinivasan Shanmugam (1):
      drm/amdgpu/powerplay: Align get_tonga_state_array() header with prototype

Stefan Binding (1):
      ASoC: cs35l56: Add support for CS35L62 for SoundWire

Stefan Haberland (1):
      s390/dasd: Snapshot intrc before freeing the request block

Stefan Hansson (1):
      wifi: rsi: Fix types to appease CFI

Stefan Metzmacher (1):
      smb: smbdirect: fix buffer length underflow in RDMA transfers

Stuart Hayhurst (1):
      HID: logitech-hidpp: Add support for G502 X Plus USB mouse

Sumanth Korikkar (1):
      s390/cpum_cf: Check session mask before cpu offline

Sumeet Pawnikar (1):
      powercap: intel_rapl: Fix kernel panic during PMU unbind

Sung Byeongchan (1):
      ALSA: pcmtest: handle multiple wraps in random capture fill

Sven Peter (1):
      thunderbolt: Make the DP tunnel activation callback mandatory

Szymon Durawa (1):
      PCI: vmd: Add Nova Lake (NVL) and Dunlow (DNL) Device IDs

Takashi Iwai (3):
      ALSA: hda/intel: Add sanity check for BAR0 size
      ALSA: control: Fix UAF in snd_ctl_elem_add() on card disconnect
      ALSA: emux: Fix UAF of soundfont zones at note-on

Tanmay Shah (1):
      remoteproc: core: Full attach detach during recovery

Tao Cui (1):
      sched_ext/scx_flatcg: expire cached hweights on weight changes

Tarun Noonemunthala (1):
      ALSA: hda/realtek: Add quirk for HP ENVY 13-aq1xxx

Terry Hsiao (1):
      drm/panel-edp: Add BOE NV116WH2-M30, BOE NT116WHM-N21, BOE NV116FH1-M31, BOE NV116FH1-M30

Thomas Huth (2):
      smb: server: Make sure that passkey is not leaked on the heap in user_config.c
      smb: server: Free session data in user_session.c with kfree_sensitive()

Thomas Renninger (1):
      ACPI: sysfs: Properly map BERT and CCEL data to their ACPI tables

Thomas Zimmermann (1):
      drm/sysfb: simpledrm: Validate mmap size against framebuffer size

Théo Lebrun (1):
      mips: select CONFIG_WEAK_REORDERING_BEYOND_LLSC from CONFIG_EYEQ

Tiezhu Yang (1):
      LoongArch: Expand module virtual address space to 2GB

Timur Kristóf (2):
      drm/amd/display: Fix fast updates on DCE 6.x
      drm/amdgpu/uvd3.1: Fix checking whether UVD firmware keyselect was already set

Tom Zanussi (1):
      tracing: Fix fully-qualified variable reference printing in histograms

Tomasz Bojanowski (1):
      ALSA: usb-audio: Add mixer mapping for MSI MAG B850M MORTAR WIFI

Tomasz Pakuła (1):
      HID: universal-pidff: Add support for Turtle Beach VelocityOne Race

Tomer Maimon (4):
      pinctrl: npcm8xx: enable RMII outputs from RMII groups
      pinctrl: npcm8xx: clear pending GPIO events during init
      pinctrl: npcm8xx: fix debounce register selection
      pinctrl: npcm8xx: move GPIO IRQ setup into request_resources

Tonghao Zhang (2):
      net: bonding: use workqueue to make sure peer notify updated in lacp mode
      net: bonding: move bond_should_notify_peers, e.g. into rtnl lock block

Tyrel Datwyler (2):
      scsi: ibmvfc: check for NULL evt in implicit LOGO and target delete path
      scsi: ibmvfc: free ibmvfc_target allocations with mempool_free

Uwe Kleine-König (The Capable Hub) (1):
      regmap: maple: Workaround for another false-positive compiler warning

Vadim Klishko (1):
      HID: i2c-hid: Add a quirk for a Cirque I2C device.

Vasant Hegde (1):
      iommu/amd: Fix missing CMD_COMPLETE_PPR response for invalid PPR requests

Vernon Yang (1):
      mm: khugepaged: fix folio is used after folio_put/unlock()

VeroFess (1):
      smb: server: size directory name conversion buffer correctly

Vincent Liu (1):
      driver core: Check drivers_autoprobe for all added devices

Vlad Kulikov (1):
      ipc: create_ipc_ns: drop mqueue mount on sysctl setup failure

Vladimir Murzin (1):
      usb: mtu3: Fix double dereference in TP_printk

Wahid Khan (1):
      HID: intel-ish-hid: ignore post-init ENUM_DEVICES from firmware

Wei Jie Law (1):
      net: usb: pegasus: do not advance rx_skb->data on dropped frames

Weibin Liu (1):
      spi: spi-pci1xxxx: quiesce DMA engines on transfer timeout

Weigang He (1):
      media: rc: fintek-cir: process a full RX buffer instead of overflowing it

Weiji Wang (1):
      drm/panel-edp: Add BOE NE140QDM-NX2

Weimin Xiong (1):
      vdpa/mlx5: roll back MR update after VQ setup failure

Weiming Shi (1):
      smb: client: stop processing a read response after a receive error

Wenjing Liu (1):
      drm/amd/display: add const qualifiers to watermark params struct

Wentao Liang (3):
      ASoC: audio-graph-card2: Fix use-after-free in audio_graph2_link_c2c()
      drm/msm: Fix vm_bo use-after-free in with_vm_locks()
      nfsd: Fix id-to-name cache entry leak in idtoname_parse()

Will Porter (1):
      ALSA: usb-audio: Add iD14 MkI to monitor-mix volume quirk

William Hansen-Baird (2):
      wifi: rtlwifi: rtl8723be: Remove unnecessary irq save/restore in hw_init()
      wifi: rtlwifi: fix disabling of ASPM for RTL8723BE with AER flooding

William Theesfeld (1):
      clk: zynq: handle kasprintf() failure in periph_clk registration

Xiang Liu (1):
      drm/amd/pm: Guard VBIOS AC timing table walk

Xiang Mei (5):
      fuse: don't BUG when the copy buffer is exhausted
      libceph: bound mon_command ack decode to front len
      media: em28xx: reject audio endpoint with zero packet size
      media: go7007: only set audio_enabled if go7007_snd_init() succeeded
      fbdev: udlfb: don't rebuild the mode list while the framebuffer is in use

Xiaogang Chen (1):
      drm/amdkfd: Guard m->cp_hqd_eop_control setting by q->eop_ring_buffer_size

Xiaoyao Li (4):
      KVM: VMX: Make handle_bus_lock_vmexit() a shared helper
      KVM: VMX: Preserve negative return value in vmx_handle_exit() with bus lock detected
      KVM: TDX: Check if there is valid exit infos based on vp_enter_ret
      KVM: TDX: Enable Notify VM exit

Xie Bo (1):
      RISC-V: KVM: Release unused page after MMU invalidation

Xiong Weimin (1):
      vdpa_sim: hold iommu_lock across dma_unmap passthrough transition

Xiubo Li (2):
      ceph: do not cache negative dentries for snapped directories
      ceph: fix use-after-dereference of NULL ci in __ceph_remove_cap()

Xixin Liu (2):
      nvme-auth: use crypto_memneq for DH-HMAC-CHAP response comparison
      nvme: zns: cap zone report nr_zones by DMA buffer size

Xu Rao (3):
      mmc: block: reject invalid perdev_minors before division
      usb: gadget: u_audio: clean up capture endpoint on feedback failure
      ALSA: hda: Add Lisuan HDMI controller and codec support

YANXIN LI (1):
      ufs: use u64 for directory size in ufs_last_byte

Yang Wang (8):
      drm/amd/pm: Validate Vega hwmgr PowerPlay table bounds
      drm/amd/pm: Validate pp_table header before reading size
      drm/amd/pm: Use uploaded size for legacy custom PPTable
      drm/amd/pm: Validate Tonga PowerPlay state array bounds
      drm/amd/pm: Validate Tonga PPTable subtable bounds
      drm/amd/pm: Validate Vega10 PPTable subtable bounds
      drm/amd/pm: Validate legacy hwmgr PP table offsets
      drm/amd/pm: derive stable PPT limits from PPTable

Yang Wen (1):
      exfat: keep FITRIM within the requested range

Yap Weei Choong (1):
      platform/x86/amd/pmc: Add T14 Gen2 AMD (20XL) to s2idle quirk list

Yaroslav Dudkov (1):
      platform/x86: msi-ec: Add MSI Katana GF76 11UEK EC firmware

Yashraj Ghule (1):
      ALSA: hda/realtek: Fix mute LED for HP Victus 15-fa1xxx (MB 8C3F)

Yehyeong Lee (1):
      nvmet-fc: fix use-after-free in nvmet_fc_ls_create_connection()

YiPeng Chai (1):
      drm/amdgpu: add bounds check to prevent array overflow

Yibo Tan (2):
      fbdev: atmel_lcdfb: Prevent FIFO work after removal
      media: ipu-bridge: Fix use-after-free in IVSC error path

Yichong Chen (5):
      exfat: write moved entry before removing source
      exfat: clean up new entry on add entry failure
      exfat: free new directory cluster if zeroing fails
      io_uring/kbuf: advance head when a pickup empties the buffer ring
      io_uring/net: keep recvmsg buffer select length within MAX_RW_COUNT

Yong-Xuan Wang (1):
      RISC-V: errata: Add SiFive MAL-9092 workaround

Yongjun Gwon (1):
      ksmbd: serialize directory emptiness checks with readdir

Yongqiang Sun (1):
      drm/amdkfd: use node XCC count for v9 CRIU control stack restore

Yosry Ahmed (2):
      KVM: x86: Always initialize EFER reserved bits on vendor initialization
      KVM: SVM: Trigger new ASID allocation in both VMCBs on pCPU switch

Yousef Alhouseen (9):
      net: usb: rtl8150: handle link status read failures
      media: go7007: avoid undefined shifts in MPEG-4 headers
      misc: bcm-vk: validate write size before allocation
      misc: genwqe: handle a first DMA address of zero
      misc: hpilo: validate device queue entries before use
      misc: ibmvmc: release send buffer on write errors
      misc: ibmvmc: reject oversized inbound messages
      media: go7007: s2250: propagate control I/O failures
      HID: hiddev: keep state alive through disconnect unlock

Youth Cao (1):
      HID: i2c-hid: Add i2c-hid-quirk-bad-input-size quirk for 0911:5288 device

Yu Kuai (2):
      md/raid5: reject zero-sector reshape chunks
      md: skip bitmap accounting for empty write ranges

Yuan Chen (1):
      libbpf: Skip bpf_object__probe_loading() when BPF token is in use

YuanZhe Liu (1):
      ALSA: line6: Clear prev_fbuf on capture buffer release

Yuanfu Xie (1):
      ceph: fail readdir when the MDS reply carries no dirfrag

Yuchao Zhang (1):
      xen-blkfront: unbind irq before tearing down ring and shadow requests

Yuhang Zheng (1):
      net/sched: cls_flower: avoid stale mask references after delete

Yuho Choi (1):
      driver core: attribute_container: Unwind device_add() on attr failure

Yun Zhou (3):
      net: mvneta_bm: add suspend/resume support to prevent crash after resume
      block: reject block device inodes with i_rdev == 0 in lookup_bdev()
      ext4: set EXT4_STATE_NO_EXPAND in ext4_evict_inode

Yunpeng Tian (1):
      smb: client: reject SetEA requests that do not fit the request buffer

Yunye Zhao (1):
      md: add cond_resched() to md_do_sync()'s skip path

Yuxiang Lin (1):
      HID: quirks: add ALWAYS_POLL quirk for AULA Mini 60 HE Pro Dongle

Yuyang Huang (1):
      net: prestera: ignore duplicate RIF destruction events

Zeyu Li (1):
      ALSA: hda/realtek: Add ALC235 support for headset mode

Zhang Heng (8):
      ALSA: hda/realtek: Fix headset mic on ASUS Vivobook S14 S5406SA
      ALSA: hda/conexant: Add pin config quirk for Huawei Matebook
      ALSA: hda/realtek: Add quirk for Acer Nitro ANV16-42 headset mic
      ALSA: hda/realtek: Add quirk for Lenovo IdeaPad Slim 3 15ABR8
      ASoC: amd: yc: Add DMI entry for Alienware m18 R1 AMD
      ALSA: hda/realtek: Add quirk for Lenovo ThinkBook G8+
      ALSA: hda/realtek: Add quirk for Acer Nitro AN515-45
      ALSA: hda/realtek: add quirk for Acer Nitro ANV15-51

Zhang Yi (2):
      ext4: check return value of ext4_get_block() in ext4_load_tail_bh()
      ext4: use FGP_WRITEBEGIN for tail block zeroing

ZhangGuoDong (1):
      NFS: Verify symlink inode before caching target

Zhao Dongdong (1):
      Bluetooth: btnxpuart: Fix use-after-free in probe error path

Zhao Li (2):
      wifi: mac80211_hwsim: clear PMSR request state on abort
      wifi: mt76: mt7996: unlink TWT flow if the MCU rejects the agreement

ZhaoJinming (1):
      wifi: ath11k: fix resource leak on error in ext IRQ setup

Zhe Liu (1):
      docs: cgroup-v2: fix stale "io" controller introduction

Zhi-Jun You (1):
      wifi: mt76: wed: fix kernel panic on non-DBDC MT7986

Zhiling Zou (2):
      netfilter: validate L4 headers after userspace packet writes
      SUNRPC: trace an accepted transport before publishing it

Zhiwei Zhang (1):
      RDMA/rxe: Check PDs for memory window binds

Zi Yan (1):
      mm/rmap: don't discard lazyfree THPs at PMD level

Zide Chen (1):
      perf/x86/intel/uncore: Fix PCI PMU cleanup on setup failure

Zihan Xi (1):
      xsk: account ring allocations to memcg

Zijing Yin (1):
      SUNRPC: fix netns use-after-free in write_gssp()

Zikang Gao (1):
      smb: client: do not pass a NULL buf to is_oplock_break()

Zizhen Liu (1):
      net: skbuff: propagate shared-frag marker in skb_zerocopy()

Zizhi Wo (1):
      fat: reject name longer than NAME_MAX in msdos_format_name()

Zongmin Zhou (1):
      RISC-V: KVM: Fix sdata leak and stale snapshot_addr in snapshot_set_shmem

bui duc phuc (1):
      regulator: rt6245: Restore state on enable failure

liulhong617 (1):
      arm64: mm: fix accidental linear mapping of no-map reserved memory

owen kwan (1):
      net/sched: sch_teql: fix use-after-free on lower qdisc drop

renpanpan (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Pavilion 14-dv1001TU

wangdicheng (1):
      ALSA: hda/conexant: Add NULL check for dc_mode_path

이상호 (1):
      romfs: detect hard link cycles

