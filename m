Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D4D46D2A3;
	Mon, 21 Sep 2026 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997489; cv=none; b=ce5nJyv+px+eXIoh7f2QqUAXI+d9sqT3SLsnKU9JXnf+iQzADP7rmOspgyexWIQJC99criwVhhITR+J6bUyttWrE3gbKNVt8tWHLiWmTCzHy8JH22HGvGEjO0oT0uP7I9WQQeisvf0FCHgDujP/MIa07CoYdDVG+S0OEtnm54Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997489; c=relaxed/simple;
	bh=b+UwMgAIHHN3KoKbfOivfRUiV0YZze6WqjR2kR9jZfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FO5oENa/uRzQmMRvhhGq0KZRw3hjxtwHUZb8GEmDBTIDoeyJZlTeCn5f8eqHW7cyboHVQjpAZZUN+tXfF7013Y6m1Q2DEy3jwn+sbPJYscnUX8SIbeDJle+YW1y1HOK9COlO/DuhYQplHYrPZAwPS9MMVwDJCFUMSwOO1qBHyRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EHI776N5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EHI776N5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979B01F00898;
	Mon, 21 Sep 2026 13:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789997475;
	bh=WTwpXPDgI5BvEEI71lMnhFCqHbH6Bpw/Alf/2lBt8EE=;
	h=From:To:Cc:Subject:Date;
	b=EHI776N58m7ErA3sCzTm+76qKmgFgLOAnIaCW4UqzuugFVh8qK3r+3xmxSsai3ds0
	 +/SOn6EYE6Kl7gYPF6X/yYwbmOHHpMwumob3PmRdztLp42DJTXnr3CwaUubgCWMVq/
	 p1Cp8jt4+l+XxMSSDy+gIPBisHXj8k+FhHuu73kk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.53
Date: Mon, 21 Sep 2026 15:30:43 +0200
Message-ID: <2026092143-improvise-union-4557@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.53 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-fs-erofs                                  |    6 
 Documentation/hwmon/gpd-fan.rst                                           |    2 
 Documentation/hwmon/hwmon-kernel-api.rst                                  |   15 
 Documentation/netlink/specs/rt-link.yaml                                  |    2 
 Documentation/networking/net_cachelines/inet_connection_sock.rst          |    2 
 Documentation/scheduler/sched-ext.rst                                     |    2 
 MAINTAINERS                                                               |    1 
 Makefile                                                                  |    2 
 arch/arm/boot/dts/nvidia/tegra30-asus-tf600t.dts                          |    6 
 arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts                              |   13 
 arch/arm/mach-ux500/cpu-db8500.c                                          |    6 
 arch/arm/mm/fault.c                                                       |   12 
 arch/arm64/boot/dts/qcom/lemans.dtsi                                      |    8 
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts                              |   18 
 arch/arm64/boot/dts/qcom/sar2130p.dtsi                                    |    8 
 arch/arm64/boot/dts/qcom/sc7280.dtsi                                      |    8 
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                                     |   16 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                                      |   64 -
 arch/arm64/boot/dts/qcom/sm6150.dtsi                                      |    4 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                                      |    8 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                                      |   12 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                                      |    8 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                                      |    8 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                                      |    8 
 arch/arm64/boot/dts/qcom/sm8650.dtsi                                      |    8 
 arch/arm64/boot/dts/qcom/sm8750.dtsi                                      |    4 
 arch/arm64/include/asm/daifflags.h                                        |   10 
 arch/arm64/include/asm/fixmap.h                                           |    6 
 arch/arm64/include/asm/kprobes.h                                          |    6 
 arch/arm64/kernel/irq.c                                                   |   29 
 arch/arm64/kernel/machine_kexec.c                                         |    3 
 arch/arm64/kernel/probes/kprobes.c                                        |   23 
 arch/arm64/tools/sysreg                                                   |    4 
 arch/mips/kernel/cps-vec.S                                                |    6 
 arch/powerpc/kernel/eeh_driver.c                                          |    2 
 arch/powerpc/kernel/setup-common.c                                        |    8 
 arch/powerpc/kexec/file_load_64.c                                         |    4 
 arch/powerpc/kvm/book3s_hv.c                                              |    4 
 arch/powerpc/platforms/powernv/pci-ioda.c                                 |    6 
 arch/powerpc/platforms/ps3/repository.c                                   |    5 
 arch/powerpc/platforms/pseries/kexec.c                                    |   13 
 arch/powerpc/platforms/pseries/rtas-fadump.c                              |   80 -
 arch/powerpc/platforms/pseries/rtas-fadump.h                              |    6 
 arch/riscv/kernel/irq.c                                                   |   22 
 arch/riscv/kernel/process.c                                               |    4 
 arch/s390/boot/ipl_parm.c                                                 |   26 
 arch/s390/boot/physmem_info.c                                             |    2 
 arch/s390/crypto/aes_s390.c                                               |   87 -
 arch/s390/crypto/paes_s390.c                                              |   19 
 arch/s390/crypto/phmac_s390.c                                             |   36 
 arch/s390/kernel/diag/diag324.c                                           |    3 
 arch/s390/kernel/ipl.c                                                    |   12 
 arch/s390/kernel/vtime.c                                                  |   25 
 arch/sparc/Kconfig                                                        |    1 
 arch/sparc/kernel/uprobes.c                                               |    1 
 arch/x86/crypto/aria-aesni-avx2-asm_64.S                                  |    6 
 arch/x86/crypto/aria-gfni-avx512-asm_64.S                                 |    3 
 arch/x86/events/intel/core.c                                              |   33 
 arch/x86/events/intel/ds.c                                                |  186 ++-
 arch/x86/events/intel/uncore_discovery.c                                  |   33 
 arch/x86/events/perf_event.h                                              |    3 
 arch/x86/include/asm/pgtable.h                                            |    2 
 arch/x86/include/asm/topology.h                                           |    3 
 arch/x86/kernel/alternative.c                                             |  111 +
 arch/x86/kernel/amd_node.c                                                |   25 
 arch/x86/kernel/cpu/microcode/amd.c                                       |   12 
 arch/x86/kernel/itmt.c                                                    |    8 
 arch/x86/mm/pat/set_memory.c                                              |  147 +-
 block/blk-cgroup.c                                                        |   13 
 crypto/Makefile                                                           |    5 
 drivers/accel/amdxdna/amdxdna_ctx.h                                       |    2 
 drivers/accel/ivpu/ivpu_fw_log.c                                          |   87 -
 drivers/accel/ivpu/ivpu_gem.h                                             |   14 
 drivers/accel/ivpu/ivpu_ipc.c                                             |    7 
 drivers/accel/qaic/qaic_control.c                                         |   46 
 drivers/acpi/acpi_apd.c                                                   |    7 
 drivers/acpi/acpica/dsmethod.c                                            |   43 
 drivers/acpi/acpica/evhandler.c                                           |   11 
 drivers/acpi/acpica/exconfig.c                                            |   26 
 drivers/acpi/acpica/exoparg3.c                                            |    2 
 drivers/acpi/acpica/nsnames.c                                             |    6 
 drivers/acpi/acpica/nsprepkg.c                                            |    7 
 drivers/acpi/acpica/nsxfname.c                                            |    4 
 drivers/acpi/acpica/psargs.c                                              |  134 ++
 drivers/acpi/acpica/psloop.c                                              |   30 
 drivers/acpi/acpica/psparse.c                                             |   14 
 drivers/acpi/acpica/utcopy.c                                              |   10 
 drivers/acpi/acpica/utresrc.c                                             |   30 
 drivers/acpi/pci_root.c                                                   |    4 
 drivers/acpi/scan.c                                                       |    1 
 drivers/ata/ahci.c                                                        |   22 
 drivers/ata/libata-core.c                                                 |   10 
 drivers/ata/libata-pmp.c                                                  |    7 
 drivers/base/core.c                                                       |   13 
 drivers/base/dd.c                                                         |   10 
 drivers/block/sunvdc.c                                                    |   17 
 drivers/bluetooth/btintel.c                                               |   39 
 drivers/bluetooth/btintel_pcie.c                                          |   22 
 drivers/bluetooth/btmtk.c                                                 |   11 
 drivers/bluetooth/btmtk.h                                                 |    1 
 drivers/bluetooth/btqcomsmd.c                                             |    6 
 drivers/bluetooth/btrtl.c                                                 |   21 
 drivers/bluetooth/btusb.c                                                 |   45 
 drivers/bluetooth/hci_mrvl.c                                              |    3 
 drivers/bus/fsl-mc/fsl-mc-bus.c                                           |   46 
 drivers/bus/mhi/host/pci_generic.c                                        |    3 
 drivers/char/ipmi/ipmi_si_platform.c                                      |    5 
 drivers/char/nvram.c                                                      |   16 
 drivers/char/virtio_console.c                                             |   21 
 drivers/clk/clk-axi-clkgen.c                                              |    5 
 drivers/clk/keystone/sci-clk.c                                            |    8 
 drivers/clk/qcom/clk-rpmh.c                                               |    8 
 drivers/clk/renesas/renesas-cpg-mssr.c                                    |    3 
 drivers/clk/samsung/clk-exynos850.c                                       |    5 
 drivers/clk/samsung/clk-exynos990.c                                       |  307 ++---
 drivers/clk/socfpga/clk-agilex.c                                          |    2 
 drivers/clk/ux500/clk-prcmu.c                                             |   20 
 drivers/clk/ux500/u8500_of_clk.c                                          |    2 
 drivers/cpufreq/cpufreq.c                                                 |    6 
 drivers/cpuidle/cpuidle-ux500.c                                           |    6 
 drivers/crypto/atmel-ecc.c                                                |    3 
 drivers/crypto/atmel-sha204a.c                                            |    3 
 drivers/crypto/ccp/sev-dev.c                                              |    2 
 drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c                               |   25 
 drivers/crypto/omap-des.c                                                 |   26 
 drivers/cxl/core/region.c                                                 |    3 
 drivers/dibs/dibs_main.c                                                  |   25 
 drivers/dma/altera-msgdma.c                                               |   24 
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c                            |   11 
 drivers/edac/altera_edac.c                                                |  115 +-
 drivers/edac/altera_edac.h                                                |    1 
 drivers/edac/amd64_edac.c                                                 |    2 
 drivers/edac/edac_device_sysfs.c                                          |   11 
 drivers/edac/igen6_edac.c                                                 |   27 
 drivers/firmware/arm_scmi/base.c                                          |   15 
 drivers/firmware/arm_scmi/sensors.c                                       |   10 
 drivers/firmware/stratix10-svc.c                                          |    4 
 drivers/gpio/gpio-ath79.c                                                 |   57 
 drivers/gpio/gpio-dwapb.c                                                 |   17 
 drivers/gpio/gpio-pisosr.c                                                |    4 
 drivers/gpio/gpio-usbio.c                                                 |    1 
 drivers/gpu/drm/adp/Kconfig                                               |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                                |   23 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                                |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c                              |   24 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c                                  |   20 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                   |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c                                 |   26 
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c                            |   95 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c                                   |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                                   |   26 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h                                   |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c                                    |   22 
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c                                   |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                                   |   34 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h                                   |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                                   |   59 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h                                   |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c                            |   34 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                                  |   29 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h                                  |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c                                 |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c                                 |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c                                   |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c                                   |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                                    |   11 
 drivers/gpu/drm/amd/amdgpu/atom.c                                         |   11 
 drivers/gpu/drm/amd/amdgpu/atom.h                                         |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                     |    2 
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
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c                               |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                         |   12 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c                     |    7 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c                 |   20 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c                 |    3 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                  |   22 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c             |    1 
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c                    |    8 
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c                 |   12 
 drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c             |    2 
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                                       |    6 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                                        |    8 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                                |   31 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                          |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c                      |    4 
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c                           |    6 
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c                           |   14 
 drivers/gpu/drm/arm/malidp_drv.c                                          |   22 
 drivers/gpu/drm/bridge/tc358768.c                                         |   17 
 drivers/gpu/drm/bridge/ti-sn65dsi83.c                                     |    3 
 drivers/gpu/drm/display/drm_dp_helper.c                                   |    2 
 drivers/gpu/drm/drm_exec.c                                                |   13 
 drivers/gpu/drm/drm_gem.c                                                 |   10 
 drivers/gpu/drm/drm_pagemap.c                                             |   10 
 drivers/gpu/drm/drm_panic_qr.rs                                           |    4 
 drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c                                |   21 
 drivers/gpu/drm/gud/gud_drv.c                                             |    3 
 drivers/gpu/drm/i915/i915_query.c                                         |    4 
 drivers/gpu/drm/imagination/pvr_context.c                                 |   30 
 drivers/gpu/drm/imagination/pvr_queue.c                                   |    7 
 drivers/gpu/drm/logicvc/Kconfig                                           |    1 
 drivers/gpu/drm/mediatek/mtk_dsi.c                                        |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c                         |    1 
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c                      |  110 +
 drivers/gpu/drm/panel/Kconfig                                             |   11 
 drivers/gpu/drm/panel/panel-edp.c                                         |   13 
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c                          |    2 
 drivers/gpu/drm/panel/panel-simple.c                                      |   28 
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c                              |   14 
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c                              |   16 
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h                              |    2 
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c                            |   18 
 drivers/gpu/drm/rockchip/Kconfig                                          |    3 
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c                           |    7 
 drivers/gpu/drm/scheduler/tests/mock_scheduler.c                          |   11 
 drivers/gpu/drm/tiny/cirrus-qemu.c                                        |    3 
 drivers/gpu/drm/ttm/ttm_bo.c                                              |   53 
 drivers/gpu/drm/ttm/ttm_bo_util.c                                         |   47 
 drivers/gpu/drm/ttm/ttm_bo_vm.c                                           |   12 
 drivers/gpu/drm/ttm/ttm_pool.c                                            |   37 
 drivers/gpu/drm/ttm/ttm_resource.c                                        |    6 
 drivers/gpu/drm/vc4/vc4_hvs.c                                             |    2 
 drivers/gpu/drm/vc4/vc4_v3d.c                                             |    2 
 drivers/gpu/drm/virtio/virtgpu_display.c                                  |    2 
 drivers/gpu/drm/virtio/virtgpu_drv.h                                      |   20 
 drivers/gpu/drm/virtio/virtgpu_object.c                                   |    2 
 drivers/gpu/drm/virtio/virtgpu_vq.c                                       |    6 
 drivers/gpu/drm/xe/instructions/xe_gpu_commands.h                         |    1 
 drivers/gpu/drm/xe/regs/xe_i2c_regs.h                                     |    2 
 drivers/gpu/drm/xe/xe_devcoredump.c                                       |    6 
 drivers/gpu/drm/xe/xe_guc_ct.c                                            |   38 
 drivers/gpu/drm/xe/xe_i2c.c                                               |   61 +
 drivers/gpu/drm/xe/xe_i2c.h                                               |    1 
 drivers/gpu/drm/xe/xe_oa.c                                                |    6 
 drivers/gpu/drm/xe/xe_ring_ops.c                                          |   16 
 drivers/gpu/host1x/bus.c                                                  |    4 
 drivers/hid/bpf/progs/Huion__Inspiroy-Frego-M.bpf.c                       |   87 +
 drivers/hid/hid-logitech-hidpp.c                                          |    1 
 drivers/hid/hid-multitouch.c                                              |  147 ++
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
 drivers/hwmon/hwmon.c                                                     |   21 
 drivers/hwmon/ina2xx.c                                                    |  183 ++-
 drivers/hwmon/ltc4282.c                                                   |    2 
 drivers/hwmon/nct6694-hwmon.c                                             |   35 
 drivers/hwmon/pmbus/lm25066.c                                             |   54 
 drivers/hwmon/pmbus/pmbus_core.c                                          |    4 
 drivers/hwmon/raspberrypi-hwmon.c                                         |   12 
 drivers/hwmon/sht4x.c                                                     |   44 
 drivers/hwtracing/coresight/coresight-core.c                              |   29 
 drivers/hwtracing/coresight/coresight-etm-perf.c                          |  114 +
 drivers/hwtracing/coresight/coresight-platform.c                          |   12 
 drivers/hwtracing/coresight/coresight-priv.h                              |    1 
 drivers/i2c/busses/i2c-designware-common.c                                |    2 
 drivers/i2c/busses/i2c-designware-core.h                                  |   85 -
 drivers/i2c/busses/i2c-designware-master.c                                |    2 
 drivers/i2c/busses/i2c-designware-slave.c                                 |    2 
 drivers/i2c/i2c-core-smbus.c                                              |   12 
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c                                  |    4 
 drivers/i3c/master/mipi-i3c-hci/cmd_v2.c                                  |    4 
 drivers/i3c/master/svc-i3c-master.c                                       |    9 
 drivers/iio/accel/mma8452.c                                               |   19 
 drivers/iio/adc/qcom-spmi-iadc.c                                          |   18 
 drivers/iio/adc/rtq6056.c                                                 |   10 
 drivers/iio/light/stk3310.c                                               |   76 +
 drivers/infiniband/core/counters.c                                        |   10 
 drivers/infiniband/core/umem.c                                            |   18 
 drivers/infiniband/hw/bnxt_re/debugfs.c                                   |    2 
 drivers/infiniband/hw/bnxt_re/main.c                                      |    2 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                                  |    2 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                                 |   11 
 drivers/infiniband/hw/bnxt_re/qplib_res.h                                 |    2 
 drivers/infiniband/hw/irdma/hw.c                                          |    7 
 drivers/infiniband/hw/irdma/main.h                                        |    3 
 drivers/infiniband/hw/irdma/utils.c                                       |   14 
 drivers/infiniband/hw/mlx5/cq.c                                           |    3 
 drivers/infiniband/hw/mlx5/main.c                                         |   11 
 drivers/infiniband/hw/mlx5/mr.c                                           |    4 
 drivers/infiniband/hw/mlx5/odp.c                                          |    3 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                                    |   12 
 drivers/iommu/amd/init.c                                                  |   25 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                               |    4 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                                |    9 
 drivers/iommu/riscv/iommu.c                                               |    7 
 drivers/iommu/riscv/iommu.h                                               |    2 
 drivers/iommu/rockchip-iommu.c                                            |    8 
 drivers/iommu/s390-iommu.c                                                |    2 
 drivers/irqchip/irq-gic-v3-its.c                                          |    1 
 drivers/irqchip/irq-gic-v5.c                                              |   19 
 drivers/leds/leds-pca9532.c                                               |    8 
 drivers/leds/leds-st1202.c                                                |   10 
 drivers/leds/trigger/ledtrig-gpio.c                                       |    3 
 drivers/leds/uleds.c                                                      |   11 
 drivers/mailbox/imx-mailbox.c                                             |   64 -
 drivers/mailbox/mailbox.c                                                 |    6 
 drivers/md/dm-raid.c                                                      |    6 
 drivers/md/md.h                                                           |    2 
 drivers/md/raid10.c                                                       |    5 
 drivers/md/raid5.c                                                        |   42 
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c                          |    4 
 drivers/media/i2c/mt9p031.c                                               |    6 
 drivers/media/i2c/video-i2c.c                                             |    2 
 drivers/media/pci/dm1105/dm1105.c                                         |    7 
 drivers/media/platform/chips-media/wave5/wave5-helper.c                   |    4 
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c                  |   59 -
 drivers/media/platform/chips-media/wave5/wave5-vpuapi.c                   |   11 
 drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h                |    1 
 drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c |    5 
 drivers/media/platform/microchip/microchip-sama7g5-isc.c                  |    7 
 drivers/media/platform/qcom/camss/camss-csiphy.c                          |   10 
 drivers/media/platform/qcom/camss/camss-vfe-340.c                         |   84 -
 drivers/media/platform/qcom/iris/iris_platform_common.h                   |   10 
 drivers/media/platform/qcom/iris/iris_platform_gen2.c                     |    8 
 drivers/media/platform/qcom/iris/iris_platform_sm8250.c                   |    2 
 drivers/media/platform/qcom/iris/iris_resources.c                         |   15 
 drivers/media/platform/qcom/venus/pm_helpers.c                            |    7 
 drivers/media/platform/renesas/rcar-csi2.c                                |    6 
 drivers/media/platform/samsung/s3c-camif/camif-core.c                     |    7 
 drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c                   |    6 
 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c           |   57 
 drivers/media/rc/imon.c                                                   |    4 
 drivers/media/rc/mceusb.c                                                 |    2 
 drivers/media/usb/as102/as102_usb_drv.c                                   |   73 -
 drivers/media/usb/dvb-usb-v2/mxl111sf.c                                   |   12 
 drivers/media/usb/em28xx/em28xx-video.c                                   |    4 
 drivers/media/usb/gspca/jl2005bcd.c                                       |    7 
 drivers/media/v4l2-core/v4l2-common.c                                     |   13 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                                 |   32 
 drivers/media/v4l2-core/v4l2-h264.c                                       |    3 
 drivers/mfd/ab8500-core.c                                                 |    2 
 drivers/mfd/db8500-prcmu.c                                                |    6 
 drivers/mfd/rsmu_i2c.c                                                    |    2 
 drivers/mfd/rsmu_spi.c                                                    |    2 
 drivers/mfd/tps65219.c                                                    |   14 
 drivers/misc/amd-sbi/rmi-core.c                                           |    4 
 drivers/mmc/core/queue.c                                                  |    8 
 drivers/mmc/host/davinci_mmc.c                                            |   16 
 drivers/mmc/host/renesas_sdhi_internal_dmac.c                             |    2 
 drivers/net/bonding/bond_alb.c                                            |   32 
 drivers/net/bonding/bond_main.c                                           |    4 
 drivers/net/dsa/bcm_sf2_cfp.c                                             |    2 
 drivers/net/dsa/lantiq/lantiq_gswip.h                                     |    2 
 drivers/net/dsa/mt7530-mmio.c                                             |    1 
 drivers/net/dsa/mt7530.c                                                  |   68 +
 drivers/net/dsa/mt7530.h                                                  |    1 
 drivers/net/dsa/mv88e6xxx/chip.c                                          |   23 
 drivers/net/dsa/qca/qca8k-8xxx.c                                          |   22 
 drivers/net/dsa/qca/qca8k.h                                               |    1 
 drivers/net/dsa/realtek/rtl8365mb.c                                       |   14 
 drivers/net/dsa/sja1105/sja1105_flower.c                                  |    4 
 drivers/net/ethernet/airoha/airoha_eth.c                                  |   14 
 drivers/net/ethernet/airoha/airoha_eth.h                                  |    4 
 drivers/net/ethernet/allwinner/sun4i-emac.c                               |    2 
 drivers/net/ethernet/amd/au1000_eth.c                                     |    3 
 drivers/net/ethernet/amd/pds_core/core.c                                  |    4 
 drivers/net/ethernet/amd/pds_core/fw.c                                    |   10 
 drivers/net/ethernet/amd/pds_core/main.c                                  |   10 
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c                                  |    3 
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c                          |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                 |   86 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                                 |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c                         |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                         |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c                           |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c                             |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h                             |  129 --
 drivers/net/ethernet/cadence/macb.h                                       |    2 
 drivers/net/ethernet/cadence/macb_main.c                                  |   54 
 drivers/net/ethernet/cadence/macb_ptp.c                                   |   11 
 drivers/net/ethernet/cavium/thunder/nicvf_main.c                          |    8 
 drivers/net/ethernet/cortina/gemini.c                                     |   77 -
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c                       |   69 -
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                   |   12 
 drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c                         |    4 
 drivers/net/ethernet/ibm/emac/core.c                                      |    8 
 drivers/net/ethernet/ibm/emac/mal.c                                       |    6 
 drivers/net/ethernet/intel/e1000e/ethtool.c                               |   19 
 drivers/net/ethernet/intel/ice/ice_common.c                               |    9 
 drivers/net/ethernet/intel/ice/ice_sched.c                                |    4 
 drivers/net/ethernet/intel/ice/ice_trace.h                                |   64 -
 drivers/net/ethernet/intel/ice/ice_txrx.c                                 |   20 
 drivers/net/ethernet/intel/ice/ice_type.h                                 |    2 
 drivers/net/ethernet/intel/idpf/idpf.h                                    |   70 -
 drivers/net/ethernet/intel/idpf/idpf_dev.c                                |   16 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                                |   78 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                               |  327 +++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.h                               |   14 
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c                             |   16 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c                           |  204 +--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h                           |   26 
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c                           |   10 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                           |   33 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c                   |   10 
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c                          |   60 -
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                               |   62 -
 drivers/net/ethernet/mediatek/mtk_eth_soc.h                               |    4 
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig                           |    2 
 drivers/net/ethernet/mellanox/mlx5/core/devlink.h                         |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en/port.c                         |   15 
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c                          |   27 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c                    |    7 
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c                        |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c                      |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c                          |   52 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.h                          |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c                        |   51 
 drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c                |   74 +
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c                       |    2 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                         |   14 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                         |    1 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c                |   14 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads_termtbl.c        |    7 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                         |   19 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                            |    3 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c                |   12 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c              |    3 
 drivers/net/ethernet/mellanox/mlx5/core/vport.c                           |    8 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c                        |   34 
 drivers/net/ethernet/micrel/ks8842.c                                      |    4 
 drivers/net/ethernet/micrel/ks8851_common.c                               |   10 
 drivers/net/ethernet/micrel/ks8851_spi.c                                  |    4 
 drivers/net/ethernet/micrel/ksz884x.c                                     |    4 
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c                     |   20 
 drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c                       |    5 
 drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c                  |   18 
 drivers/net/ethernet/microsoft/mana/mana_bpf.c                            |    1 
 drivers/net/ethernet/microsoft/mana/mana_en.c                             |   30 
 drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c                      |   19 
 drivers/net/ethernet/oa_tc6.c                                             |  512 +++++---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c                          |   13 
 drivers/net/ethernet/realtek/rtase/rtase.h                                |    4 
 drivers/net/ethernet/realtek/rtase/rtase_main.c                           |    3 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h                            |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                         |  107 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c                          |    1 
 drivers/net/ethernet/ti/cpsw_new.c                                        |    4 
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c                            |    1 
 drivers/net/gtp.c                                                         |    5 
 drivers/net/ieee802154/cc2520.c                                           |    5 
 drivers/net/ieee802154/mac802154_hwsim.c                                  |   10 
 drivers/net/mctp/mctp-i3c.c                                               |    9 
 drivers/net/net_failover.c                                                |    2 
 drivers/net/netconsole.c                                                  |    2 
 drivers/net/phy/dp83867.c                                                 |    3 
 drivers/net/phy/dp83td510.c                                               |    3 
 drivers/net/phy/mediatek/mtk-ge.c                                         |   29 
 drivers/net/phy/motorcomm.c                                               |   41 
 drivers/net/phy/sfp.c                                                     |    2 
 drivers/net/ppp/ppp_async.c                                               |   89 -
 drivers/net/ppp/ppp_synctty.c                                             |   97 -
 drivers/net/usb/cx82310_eth.c                                             |    1 
 drivers/net/usb/hso.c                                                     |    2 
 drivers/net/usb/pegasus.c                                                 |   54 
 drivers/net/usb/pegasus.h                                                 |    3 
 drivers/net/usb/qmi_wwan.c                                                |    2 
 drivers/net/vxlan/vxlan_core.c                                            |   13 
 drivers/net/vxlan/vxlan_mdb.c                                             |    8 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                   |   50 
 drivers/net/wireless/ath/ath11k/mhi.c                                     |    4 
 drivers/net/wireless/ath/ath11k/pci.c                                     |    8 
 drivers/net/wireless/ath/ath12k/mac.c                                     |   87 +
 drivers/net/wireless/ath/ath9k/hif_usb.c                                  |   12 
 drivers/net/wireless/ath/ath9k/hif_usb.h                                  |    2 
 drivers/net/wireless/ath/ath9k/hw.c                                       |   33 
 drivers/net/wireless/ath/ath9k/hw.h                                       |    3 
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c                            |    4 
 drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c                            |    3 
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c                              |    5 
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h                         |   48 
 drivers/net/wireless/intel/iwlwifi/iwl-config.h                           |    4 
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                              |   13 
 drivers/net/wireless/intel/iwlwifi/iwl-io.c                               |   18 
 drivers/net/wireless/intel/iwlwifi/iwl-io.h                               |    4 
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h                             |    7 
 drivers/net/wireless/intel/iwlwifi/mld/ap.c                               |   25 
 drivers/net/wireless/intel/iwlwifi/mld/ap.h                               |    6 
 drivers/net/wireless/intel/iwlwifi/mld/d3.c                               |    7 
 drivers/net/wireless/intel/iwlwifi/mld/iface.c                            |   18 
 drivers/net/wireless/intel/iwlwifi/mld/iface.h                            |    3 
 drivers/net/wireless/intel/iwlwifi/mld/link.c                             |   17 
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c                         |   12 
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c                              |   13 
 drivers/net/wireless/intel/iwlwifi/mld/mld.c                              |   10 
 drivers/net/wireless/intel/iwlwifi/mld/notif.c                            |    6 
 drivers/net/wireless/intel/iwlwifi/mld/power.c                            |  177 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/binding.c                          |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                               |   19 
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c                         |   25 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                         |   19 
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h                              |   10 
 drivers/net/wireless/intel/iwlwifi/mvm/power.c                            |   14 
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c                               |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                             |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c                       |    8 
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                               |   45 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                             |    5 
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c                       |    9 
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c                    |   28 
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
 drivers/net/wireless/realtek/rtw89/core.c                                 |   10 
 drivers/net/wireless/realtek/rtw89/mac_be.c                               |    4 
 drivers/net/wireless/realtek/rtw89/pci.c                                  |   16 
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c                            |    3 
 drivers/net/wireless/rsi/rsi_91x_hal.c                                    |    8 
 drivers/net/wireless/rsi/rsi_91x_mgmt.c                                   |    6 
 drivers/net/wireless/virtual/mac80211_hwsim.c                             |    6 
 drivers/net/wwan/t7xx/t7xx_pci.c                                          |    3 
 drivers/nvme/host/core.c                                                  |   44 
 drivers/nvme/host/fc.c                                                    |    7 
 drivers/nvme/host/rdma.c                                                  |   18 
 drivers/nvme/host/tcp.c                                                   |    5 
 drivers/nvme/target/rdma.c                                                |   15 
 drivers/of/base.c                                                         |   43 
 drivers/of/dynamic.c                                                      |   20 
 drivers/of/property.c                                                     |   27 
 drivers/of/unittest.c                                                     |   32 
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
 drivers/pci/proc.c                                                        |   79 -
 drivers/pci/quirks.c                                                      |    5 
 drivers/pci/switch/switchtec.c                                            |   16 
 drivers/perf/riscv_pmu_legacy.c                                           |    5 
 drivers/perf/riscv_pmu_sbi.c                                              |   98 +
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c                                 |    2 
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c                             |   13 
 drivers/pinctrl/mediatek/pinctrl-paris.c                                  |    8 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                                   |   41 
 drivers/pinctrl/renesas/pinctrl-rzv2m.c                                   |    4 
 drivers/platform/chrome/cros_ec_sensorhub.c                               |    6 
 drivers/platform/chrome/cros_ec_sysfs.c                                   |    5 
 drivers/platform/x86/dell/dell-laptop.c                                   |    9 
 drivers/platform/x86/intel/hid.c                                          |    7 
 drivers/platform/x86/msi-ec.c                                             |    1 
 drivers/platform/x86/sel3350-platform.c                                   |  136 +-
 drivers/powercap/intel_rapl_common.c                                      |    3 
 drivers/ptp/ptp_ocp.c                                                     |    1 
 drivers/pwm/pwm-mediatek.c                                                |    2 
 drivers/ras/amd/atl/core.c                                                |    1 
 drivers/regulator/core.c                                                  |  163 +-
 drivers/regulator/da9121-regulator.c                                      |   18 
 drivers/regulator/db8500-prcmu.c                                          |   12 
 drivers/rtc/rtc-aspeed.c                                                  |    1 
 drivers/rtc/rtc-bq32k.c                                                   |    9 
 drivers/rtc/rtc-cmos.c                                                    |   13 
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
 drivers/scsi/qla2xxx/qla_bsg.c                                            |   47 
 drivers/scsi/qla2xxx/qla_def.h                                            |    2 
 drivers/scsi/qla2xxx/qla_fw.h                                             |    4 
 drivers/scsi/qla2xxx/qla_init.c                                           |   14 
 drivers/scsi/qla2xxx/qla_iocb.c                                           |   23 
 drivers/scsi/qla2xxx/qla_isr.c                                            |   33 
 drivers/scsi/qla2xxx/qla_mbx.c                                            |    6 
 drivers/scsi/qla2xxx/qla_mid.c                                            |   49 
 drivers/scsi/qla2xxx/qla_nvme.c                                           |   10 
 drivers/scsi/qla2xxx/qla_os.c                                             |   15 
 drivers/scsi/scsi_error.c                                                 |    2 
 drivers/soc/tegra/fuse/fuse-tegra.c                                       |   14 
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
 drivers/spi/spi-tegra210-quad.c                                           |   29 
 drivers/spi/spi-xilinx.c                                                  |    6 
 drivers/spi/spi.c                                                         |    9 
 drivers/staging/fbtft/fbtft-core.c                                        |    9 
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c                                 |    2 
 drivers/target/iscsi/iscsi_target.c                                       |    4 
 drivers/tee/optee/call.c                                                  |    3 
 drivers/thermal/db8500_thermal.c                                          |   10 
 drivers/thermal/qcom/tsens.c                                              |  111 +
 drivers/thermal/qcom/tsens.h                                              |    1 
 drivers/thermal/tegra/soctherm.c                                          |    6 
 drivers/thermal/thermal_sysfs.c                                           |   12 
 drivers/thunderbolt/icm.c                                                 |   10 
 drivers/thunderbolt/path.c                                                |   31 
 drivers/thunderbolt/switch.c                                              |    6 
 drivers/thunderbolt/tb.c                                                  |    9 
 drivers/thunderbolt/tb.h                                                  |    1 
 drivers/thunderbolt/tb_regs.h                                             |   16 
 drivers/thunderbolt/tunnel.c                                              |   35 
 drivers/thunderbolt/usb4.c                                                |   35 
 drivers/thunderbolt/xdomain.c                                             |   49 
 drivers/tty/serial/8250/8250_core.c                                       |    2 
 drivers/tty/serial/8250/8250_port.c                                       |    9 
 drivers/usb/atm/xusbatm.c                                                 |    6 
 drivers/usb/class/cdc-acm.c                                               |    6 
 drivers/usb/class/usbtmc.c                                                |    2 
 drivers/usb/core/hcd.c                                                    |   14 
 drivers/usb/gadget/udc/aspeed_udc.c                                       |    7 
 drivers/usb/gadget/udc/core.c                                             |    7 
 drivers/usb/gadget/udc/goku_udc.c                                         |    3 
 drivers/usb/host/Kconfig                                                  |    2 
 drivers/usb/host/xhci-dbgcap.c                                            |    5 
 drivers/usb/host/xhci-mem.c                                               |    6 
 drivers/usb/host/xhci-ring.c                                              |    9 
 drivers/usb/host/xhci.c                                                   |    4 
 drivers/usb/host/xhci.h                                                   |    2 
 drivers/usb/serial/spcp8x5.c                                              |    6 
 drivers/usb/usbip/vhci_sysfs.c                                            |   52 
 drivers/vdpa/ifcvf/ifcvf_main.c                                           |   14 
 drivers/vdpa/octeon_ep/octep_vdpa_main.c                                  |    6 
 drivers/vdpa/solidrun/snet_main.c                                         |    6 
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c                                      |    3 
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c                                      |    7 
 drivers/vhost/scsi.c                                                      |    3 
 drivers/vhost/vdpa.c                                                      |   88 +
 drivers/video/fbdev/core/fbcon.c                                          |    9 
 drivers/video/fbdev/pm2fb.c                                               |    1 
 drivers/video/fbdev/vfb.c                                                 |   11 
 drivers/virt/acrn/irqfd.c                                                 |   71 -
 drivers/virtio/virtio.c                                                   |    2 
 drivers/virtio/virtio_input.c                                             |    9 
 drivers/virtio/virtio_mmio.c                                              |   16 
 drivers/virtio/virtio_pci_common.c                                        |    4 
 drivers/watchdog/db8500_wdt.c                                             |   22 
 drivers/watchdog/imx7ulp_wdt.c                                            |   10 
 drivers/watchdog/lenovo_se10_wdt.c                                        |   82 +
 drivers/watchdog/msc313e_wdt.c                                            |   74 +
 drivers/watchdog/sunxi_wdt.c                                              |   45 
 drivers/watchdog/watchdog_hrtimer_pretimeout.c                            |    1 
 drivers/xen/gntalloc.c                                                    |   13 
 drivers/xen/xen-front-pgdir-shbuf.c                                       |   12 
 fs/9p/vfs_dir.c                                                           |   14 
 fs/affs/affs.h                                                            |    5 
 fs/affs/super.c                                                           |    6 
 fs/afs/addr_list.c                                                        |    5 
 fs/afs/dir_edit.c                                                         |    9 
 fs/afs/dir_search.c                                                       |   11 
 fs/afs/fs_probe.c                                                         |    1 
 fs/afs/internal.h                                                         |    8 
 fs/afs/server.c                                                           |    1 
 fs/autofs/inode.c                                                         |    4 
 fs/befs/linuxvfs.c                                                        |    3 
 fs/bfs/inode.c                                                            |    3 
 fs/btrfs/disk-io.c                                                        |   11 
 fs/btrfs/inode.c                                                          |    6 
 fs/btrfs/ioctl.c                                                          |   11 
 fs/btrfs/raid-stripe-tree.c                                               |   25 
 fs/btrfs/raid-stripe-tree.h                                               |    1 
 fs/btrfs/relocation.c                                                     |   47 
 fs/btrfs/scrub.c                                                          |   24 
 fs/btrfs/send.c                                                           |    2 
 fs/btrfs/super.c                                                          |    2 
 fs/btrfs/transaction.c                                                    |   13 
 fs/btrfs/tree-checker.c                                                   |   41 
 fs/btrfs/volumes.c                                                        |   10 
 fs/btrfs/zoned.c                                                          |   13 
 fs/btrfs/zstd.c                                                           |   11 
 fs/cachefiles/namei.c                                                     |    1 
 fs/cachefiles/xattr.c                                                     |   16 
 fs/configfs/dir.c                                                         |   25 
 fs/configfs/symlink.c                                                     |   24 
 fs/dlm/memory.c                                                           |    4 
 fs/erofs/data.c                                                           |    2 
 fs/erofs/decompressor.c                                                   |   55 
 fs/erofs/decompressor_lzma.c                                              |   18 
 fs/erofs/internal.h                                                       |    6 
 fs/erofs/sysfs.c                                                          |    4 
 fs/erofs/zdata.c                                                          |   18 
 fs/exec.c                                                                 |   22 
 fs/exfat/nls.c                                                            |   19 
 fs/f2fs/debug.c                                                           |    4 
 fs/f2fs/f2fs.h                                                            |   29 
 fs/f2fs/file.c                                                            |   18 
 fs/f2fs/gc.c                                                              |   51 
 fs/f2fs/gc.h                                                              |   27 
 fs/f2fs/inline.c                                                          |    7 
 fs/f2fs/recovery.c                                                        |   33 
 fs/f2fs/segment.c                                                         |   56 
 fs/f2fs/segment.h                                                         |    6 
 fs/f2fs/super.c                                                           |    4 
 fs/f2fs/sysfs.c                                                           |   18 
 fs/freevxfs/vxfs_bmap.c                                                   |    3 
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
 fs/netfs/direct_write.c                                                   |   31 
 fs/netfs/internal.h                                                       |   12 
 fs/netfs/read_retry.c                                                     |    7 
 fs/netfs/write_issue.c                                                    |    2 
 fs/netfs/write_retry.c                                                    |    7 
 fs/nfs/nfs42proc.c                                                        |   15 
 fs/ntfs3/dir.c                                                            |    4 
 fs/ntfs3/fslog.c                                                          |   26 
 fs/ntfs3/index.c                                                          |   41 
 fs/ntfs3/super.c                                                          |    8 
 fs/ntfs3/xattr.c                                                          |    4 
 fs/omfs/inode.c                                                           |    6 
 fs/qnx4/inode.c                                                           |    3 
 fs/smb/client/cached_dir.c                                                |    2 
 fs/smb/client/cifs_fs_sb.h                                                |    8 
 fs/smb/client/cifs_ioctl.h                                                |    2 
 fs/smb/client/cifs_unicode.c                                              |    4 
 fs/smb/client/cifsacl.c                                                   |  105 +
 fs/smb/client/cifsfs.c                                                    |   66 -
 fs/smb/client/cifsglob.h                                                  |   10 
 fs/smb/client/cifspdu.h                                                   |    8 
 fs/smb/client/cifssmb.c                                                   |    8 
 fs/smb/client/connect.c                                                   |   70 -
 fs/smb/client/dfs_cache.c                                                 |    2 
 fs/smb/client/dir.c                                                       |   16 
 fs/smb/client/file.c                                                      |   37 
 fs/smb/client/fs_context.c                                                |  110 -
 fs/smb/client/inode.c                                                     |   80 -
 fs/smb/client/ioctl.c                                                     |    2 
 fs/smb/client/link.c                                                      |    6 
 fs/smb/client/misc.c                                                      |   36 
 fs/smb/client/readdir.c                                                   |   25 
 fs/smb/client/reparse.c                                                   |   27 
 fs/smb/client/reparse.h                                                   |    4 
 fs/smb/client/smb1ops.c                                                   |    6 
 fs/smb/client/smb2file.c                                                  |    2 
 fs/smb/client/smb2misc.c                                                  |    4 
 fs/smb/client/smb2ops.c                                                   |  198 ++-
 fs/smb/client/smb2pdu.c                                                   |    4 
 fs/smb/client/smb2pdu.h                                                   |   24 
 fs/smb/client/transport.c                                                 |   11 
 fs/smb/client/xattr.c                                                     |    6 
 fs/smb/common/smb2pdu.h                                                   |   29 
 fs/smb/server/mgmt/share_config.c                                         |   38 
 fs/smb/server/mgmt/user_session.c                                         |   25 
 fs/smb/server/misc.c                                                      |   14 
 fs/smb/server/oplock.c                                                    |  166 ++
 fs/smb/server/oplock.h                                                    |    2 
 fs/smb/server/server.c                                                    |    6 
 fs/smb/server/smb2misc.c                                                  |    9 
 fs/smb/server/smb2pdu.c                                                   |  277 ++--
 fs/smb/server/smb2pdu.h                                                   |   20 
 fs/smb/server/smbacl.c                                                    |   88 -
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
 fs/xfs/libxfs/xfs_rtrefcount_btree.c                                      |    7 
 fs/xfs/libxfs/xfs_rtrmap_btree.c                                          |    6 
 fs/xfs/scrub/agheader.c                                                   |    7 
 fs/xfs/scrub/agheader_repair.c                                            |   39 
 fs/xfs/scrub/alloc_repair.c                                               |   18 
 fs/xfs/scrub/bmap.c                                                       |    2 
 fs/xfs/scrub/dir_repair.c                                                 |   10 
 fs/xfs/scrub/dirtree.c                                                    |   31 
 fs/xfs/scrub/dirtree_repair.c                                             |    2 
 fs/xfs/scrub/findparent.c                                                 |   54 
 fs/xfs/scrub/ialloc.c                                                     |    4 
 fs/xfs/scrub/metapath.c                                                   |    4 
 fs/xfs/scrub/quota_repair.c                                               |   14 
 fs/xfs/scrub/quotacheck.c                                                 |    4 
 fs/xfs/scrub/reap.c                                                       |    6 
 fs/xfs/scrub/refcount.c                                                   |    8 
 fs/xfs/scrub/rgsuper.c                                                    |    6 
 fs/xfs/scrub/rtrefcount.c                                                 |   82 +
 fs/xfs/scrub/rtsummary_repair.c                                           |    3 
 fs/xfs/scrub/scrub.c                                                      |    3 
 fs/xfs/scrub/stats.c                                                      |   61 -
 fs/xfs/scrub/stats.h                                                      |    4 
 fs/xfs/scrub/symlink_repair.c                                             |    2 
 fs/xfs/scrub/trace.h                                                      |   35 
 fs/xfs/xfs_buf.c                                                          |    2 
 fs/xfs/xfs_exchmaps_item.c                                                |   19 
 fs/xfs/xfs_exchrange.c                                                    |   12 
 include/linux/adi-axi-common.h                                            |    2 
 include/linux/bio.h                                                       |   14 
 include/linux/bitfield.h                                                  |    2 
 include/linux/bnxt/ulp.h                                                  |  129 ++
 include/linux/bpf.h                                                       |    1 
 include/linux/bpf_verifier.h                                              |   12 
 include/linux/designware_i2c.h                                            |  107 +
 include/linux/device.h                                                    |    9 
 include/linux/firmware/intel/stratix10-smc.h                              |   18 
 include/linux/igmp.h                                                      |    7 
 include/linux/kcsan-checks.h                                              |    6 
 include/linux/mailbox_controller.h                                        |    2 
 include/linux/mfd/db8500-prcmu.h                                          |  252 ++++
 include/linux/mfd/dbx500-prcmu.h                                          |  575 ----------
 include/linux/mmap_lock.h                                                 |    2 
 include/linux/ns_common.h                                                 |    7 
 include/linux/nsproxy.h                                                   |    2 
 include/linux/oa_tc6.h                                                    |   50 
 include/linux/perf/riscv_pmu.h                                            |    2 
 include/linux/platform_data/cros_ec_proto.h                               |    2 
 include/linux/rbtree_augmented.h                                          |   35 
 include/linux/sched.h                                                     |    2 
 include/linux/sched/signal.h                                              |    5 
 include/linux/skbuff.h                                                    |    5 
 include/linux/switchtec.h                                                 |    1 
 include/linux/thunderbolt.h                                               |    2 
 include/media/v4l2-hevc.h                                                 |   41 
 include/net/cfg80211.h                                                    |    2 
 include/net/cfg802154.h                                                   |    1 
 include/net/devlink.h                                                     |   10 
 include/net/if_inet6.h                                                    |    2 
 include/net/inet_connection_sock.h                                        |   20 
 include/net/ip.h                                                          |    3 
 include/net/ip6_route.h                                                   |    2 
 include/net/ip_fib.h                                                      |    5 
 include/net/netdev_lock.h                                                 |    6 
 include/net/netfilter/nf_conntrack_timeout.h                              |   27 
 include/net/sch_generic.h                                                 |    2 
 include/net/sock.h                                                        |    9 
 include/net/tcp.h                                                         |    3 
 include/rdma/ib_umem.h                                                    |   15 
 include/sound/tas2781.h                                                   |    4 
 include/trace/events/cachefiles.h                                         |   19 
 include/trace/events/icmp.h                                               |   13 
 include/uapi/drm/amdgpu_drm.h                                             |    2 
 include/uapi/linux/landlock.h                                             |   37 
 include/uapi/sound/intel/avs/tokens.h                                     |    6 
 init/main.c                                                               |   36 
 io_uring/net.c                                                            |   51 
 io_uring/rw.c                                                             |   25 
 kernel/bpf/bpf_iter.c                                                     |    2 
 kernel/bpf/btf.c                                                          |   27 
 kernel/bpf/cgroup.c                                                       |    1 
 kernel/bpf/disasm.c                                                       |    5 
 kernel/bpf/log.c                                                          |    4 
 kernel/bpf/stackmap.c                                                     |    2 
 kernel/bpf/verifier.c                                                     |  245 +++-
 kernel/cgroup/cgroup.c                                                    |    6 
 kernel/events/core.c                                                      |    7 
 kernel/events/ring_buffer.c                                               |    9 
 kernel/exit.c                                                             |   11 
 kernel/fork.c                                                             |    2 
 kernel/irq/manage.c                                                       |   37 
 kernel/irq/proc.c                                                         |    7 
 kernel/locking/lockdep.c                                                  |   50 
 kernel/nsproxy.c                                                          |    2 
 kernel/printk/nbcon.c                                                     |    2 
 kernel/rcu/tasks.h                                                        |    3 
 kernel/reboot.c                                                           |   19 
 kernel/sched/core.c                                                       |   33 
 kernel/sched/deadline.c                                                   |   18 
 kernel/sched/fair.c                                                       |   29 
 kernel/sched/rt.c                                                         |   15 
 kernel/signal.c                                                           |   12 
 kernel/time/clockevents.c                                                 |   33 
 kernel/time/tick-broadcast.c                                              |   36 
 kernel/time/tick-internal.h                                               |    2 
 kernel/trace/Makefile                                                     |    5 
 kernel/trace/bpf_trace.c                                                  |   11 
 kernel/trace/ring_buffer.c                                                |   21 
 kernel/trace/trace.c                                                      |   68 +
 kernel/trace/trace.h                                                      |  125 --
 kernel/trace/trace_eprobe.c                                               |   19 
 kernel/trace/trace_event_perf.c                                           |   12 
 kernel/trace/trace_events.c                                               |    2 
 kernel/trace/trace_events_hist.c                                          |  209 +--
 kernel/trace/trace_events_trigger.c                                       |  344 ++---
 kernel/trace/trace_events_user.c                                          |   26 
 kernel/trace/trace_functions_graph.c                                      |    3 
 kernel/trace/trace_probe.c                                                |   48 
 kernel/trace/trace_probe.h                                                |    2 
 kernel/workqueue.c                                                        |    3 
 mm/damon/core.c                                                           |   13 
 net/9p/client.c                                                           |    2 
 net/appletalk/aarp.c                                                      |    5 
 net/bluetooth/hci_core.c                                                  |    4 
 net/bluetooth/hci_sysfs.c                                                 |   17 
 net/bluetooth/iso.c                                                       |   31 
 net/bluetooth/l2cap_core.c                                                |   38 
 net/bluetooth/msft.c                                                      |    2 
 net/bluetooth/rfcomm/core.c                                               |    5 
 net/bridge/br_arp_nd_proxy.c                                              |   16 
 net/bridge/br_cfm.c                                                       |   11 
 net/bridge/br_device.c                                                    |    3 
 net/bridge/br_fdb.c                                                       |    7 
 net/bridge/br_input.c                                                     |   37 
 net/bridge/br_mrp.c                                                       |   13 
 net/bridge/br_multicast.c                                                 |   11 
 net/bridge/br_private.h                                                   |   26 
 net/core/dev.c                                                            |   89 -
 net/core/drop_monitor.c                                                   |   18 
 net/core/filter.c                                                         |   17 
 net/core/gro_cells.c                                                      |    2 
 net/core/rtnetlink.c                                                      |    7 
 net/core/skbuff.c                                                         |    7 
 net/devlink/port.c                                                        |    2 
 net/devlink/resource.c                                                    |  157 ++
 net/dsa/tag_brcm.c                                                        |    1 
 net/ethtool/cmis_cdb.c                                                    |    3 
 net/ethtool/cmis_fw_update.c                                              |    8 
 net/ethtool/module.c                                                      |    2 
 net/hsr/hsr_forward.c                                                     |    2 
 net/hsr/hsr_netlink.c                                                     |    9 
 net/hsr/hsr_slave.c                                                       |   11 
 net/ieee802154/6lowpan/core.c                                             |    2 
 net/ipv4/fib_rules.c                                                      |    4 
 net/ipv4/fib_trie.c                                                       |    4 
 net/ipv4/fou_core.c                                                       |    2 
 net/ipv4/igmp.c                                                           |  210 ++-
 net/ipv4/inet_connection_sock.c                                           |   12 
 net/ipv4/inet_diag.c                                                      |    8 
 net/ipv4/inet_fragment.c                                                  |    6 
 net/ipv4/ip_output.c                                                      |    1 
 net/ipv4/ip_tunnel_core.c                                                 |    6 
 net/ipv4/ipmr.c                                                           |    3 
 net/ipv4/ipmr_base.c                                                      |    2 
 net/ipv4/nexthop.c                                                        |    2 
 net/ipv4/tcp.c                                                            |   14 
 net/ipv4/tcp_ipv4.c                                                       |    8 
 net/ipv4/tcp_offload.c                                                    |   22 
 net/ipv4/tcp_output.c                                                     |    4 
 net/ipv4/tcp_timer.c                                                      |   29 
 net/ipv4/udp.c                                                            |    4 
 net/ipv6/addrconf.c                                                       |   10 
 net/ipv6/af_inet6.c                                                       |    2 
 net/ipv6/exthdrs.c                                                        |    4 
 net/ipv6/ip6_fib.c                                                        |    4 
 net/ipv6/ip6_flowlabel.c                                                  |   19 
 net/ipv6/ip6_gre.c                                                        |    6 
 net/ipv6/ip6_output.c                                                     |    2 
 net/ipv6/ip6mr.c                                                          |    2 
 net/ipv6/mcast.c                                                          |  116 +-
 net/ipv6/netfilter/ip6_tables.c                                           |    5 
 net/ipv6/route.c                                                          |    9 
 net/ipv6/tcp_ipv6.c                                                       |    8 
 net/ipv6/tcpv6_offload.c                                                  |   15 
 net/l2tp/l2tp_debugfs.c                                                   |    4 
 net/l2tp/l2tp_ppp.c                                                       |   56 
 net/mac80211/cfg.c                                                        |    9 
 net/mac80211/chan.c                                                       |   10 
 net/mac80211/ibss.c                                                       |    9 
 net/mac80211/ieee80211_i.h                                                |    9 
 net/mac80211/link.c                                                       |   30 
 net/mac80211/mlme.c                                                       |   97 +
 net/mac80211/parse.c                                                      |    4 
 net/mac80211/status.c                                                     |    9 
 net/mac80211/tx.c                                                         |    2 
 net/mac80211/util.c                                                       |    6 
 net/mac802154/ieee802154_i.h                                              |    8 
 net/mac802154/iface.c                                                     |    6 
 net/mac802154/main.c                                                      |    1 
 net/mac802154/rx.c                                                        |  120 +-
 net/mac802154/scan.c                                                      |   10 
 net/mptcp/options.c                                                       |    7 
 net/mptcp/pm.c                                                            |   45 
 net/mptcp/pm_kernel.c                                                     |    8 
 net/mptcp/pm_userspace.c                                                  |   18 
 net/mptcp/protocol.c                                                      |   70 -
 net/mptcp/protocol.h                                                      |   15 
 net/mptcp/subflow.c                                                       |   12 
 net/mptcp/syncookies.c                                                    |    5 
 net/netfilter/ipset/ip_set_hash_gen.h                                     |   13 
 net/netfilter/ipvs/ip_vs_sync.c                                           |   20 
 net/netfilter/nf_conntrack_core.c                                         |    6 
 net/netfilter/nf_conntrack_expect.c                                       |    3 
 net/netfilter/nf_conntrack_netlink.c                                      |   13 
 net/netfilter/nf_conntrack_proto_tcp.c                                    |   10 
 net/netfilter/nf_conntrack_sip.c                                          |    2 
 net/netfilter/nf_conntrack_timeout.c                                      |   27 
 net/netfilter/nf_log_syslog.c                                             |    6 
 net/netfilter/nfnetlink_cttimeout.c                                       |  114 -
 net/netfilter/nfnetlink_log.c                                             |   28 
 net/netfilter/nft_ct.c                                                    |    7 
 net/netfilter/xt_CT.c                                                     |    2 
 net/netlabel/netlabel_unlabeled.c                                         |    2 
 net/netlink/genetlink.c                                                   |   21 
 net/openvswitch/flow.c                                                    |    4 
 net/openvswitch/flow_table.c                                              |    4 
 net/packet/af_packet.c                                                    |    5 
 net/phonet/pn_dev.c                                                       |   30 
 net/psp/psp_main.c                                                        |    9 
 net/qrtr/af_qrtr.c                                                        |    4 
 net/rds/af_rds.c                                                          |   63 -
 net/rds/connection.c                                                      |  102 +
 net/rds/ib_cm.c                                                           |   25 
 net/rds/ib_recv.c                                                         |    9 
 net/rds/message.c                                                         |    4 
 net/rds/send.c                                                            |   16 
 net/rds/tcp.c                                                             |  164 ++
 net/rds/tcp_listen.c                                                      |    6 
 net/sched/act_api.c                                                       |   46 
 net/sched/act_csum.c                                                      |    8 
 net/sched/cls_api.c                                                       |    8 
 net/sched/cls_route.c                                                     |   76 -
 net/sched/cls_u32.c                                                       |   32 
 net/sched/sch_api.c                                                       |    2 
 net/sched/sch_drr.c                                                       |   13 
 net/sched/sch_dualpi2.c                                                   |   10 
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
 net/wireless/mlme.c                                                       |  101 +
 net/wireless/nl80211.c                                                    |   13 
 net/wireless/scan.c                                                       |    6 
 net/wireless/wext-sme.c                                                   |    9 
 rust/bindings/lib.rs                                                      |    4 
 rust/uapi/lib.rs                                                          |    4 
 scripts/mksysmap                                                          |    4 
 scripts/mod/modpost.c                                                     |   11 
 scripts/sorttable.c                                                       |    2 
 security/apparmor/match.c                                                 |   22 
 security/integrity/digsig_asymmetric.c                                    |    4 
 security/integrity/ima/ima_appraise.c                                     |    5 
 security/landlock/access.h                                                |   35 
 security/landlock/audit.c                                                 |   81 -
 security/landlock/audit.h                                                 |    3 
 security/landlock/domain.c                                                |   44 
 security/landlock/domain.h                                                |    3 
 security/landlock/fs.c                                                    |  353 ++----
 security/landlock/net.c                                                   |    9 
 security/landlock/ruleset.c                                               |   91 -
 security/landlock/ruleset.h                                               |    6 
 sound/core/pcm_native.c                                                   |   35 
 sound/core/seq/oss/seq_oss_rw.c                                           |    3 
 sound/core/seq/seq_prioq.c                                                |   14 
 sound/core/ump.c                                                          |    4 
 sound/drivers/dummy.c                                                     |    2 
 sound/hda/codecs/Kconfig                                                  |    1 
 sound/hda/codecs/ca0132.c                                                 |  111 +
 sound/hda/codecs/conexant.c                                               |   12 
 sound/hda/codecs/realtek/alc269.c                                         |   40 
 sound/hda/codecs/realtek/alc882.c                                         |   22 
 sound/hda/codecs/side-codecs/Kconfig                                      |    2 
 sound/hda/codecs/side-codecs/cs35l41_hda_property.c                       |    2 
 sound/hda/codecs/side-codecs/cs35l56_hda.c                                |   30 
 sound/hda/common/codec.c                                                  |    4 
 sound/hda/core/device.c                                                   |    5 
 sound/isa/es18xx.c                                                        |    4 
 sound/pci/ctxfi/cthw20k2.c                                                |    1 
 sound/pci/ice1712/ice1724.c                                               |   19 
 sound/soc/amd/renoir/acp3x-pdm-dma.c                                      |    2 
 sound/soc/amd/yc/acp6x-mach.c                                             |   21 
 sound/soc/amd/yc/acp6x-pdm-dma.c                                          |    2 
 sound/soc/bcm/bcm63xx-i2s-whistler.c                                      |    1 
 sound/soc/codecs/ab8500-codec.c                                           |  537 ++++-----
 sound/soc/codecs/mt6351.c                                                 |    1 
 sound/soc/codecs/pcm3168a.c                                               |   21 
 sound/soc/codecs/rk3328_codec.c                                           |   54 
 sound/soc/codecs/rt5645.c                                                 |    4 
 sound/soc/codecs/rt712-sdca.c                                             |   11 
 sound/soc/fsl/fsl-asoc-card.c                                             |    8 
 sound/soc/fsl/fsl_micfil.c                                                |   21 
 sound/soc/intel/atom/sst/sst_pci.c                                        |    1 
 sound/soc/intel/avs/core.c                                                |   11 
 sound/soc/intel/avs/debugfs.c                                             |   12 
 sound/soc/intel/avs/path.c                                                |   24 
 sound/soc/intel/avs/pcm.c                                                 |   34 
 sound/soc/intel/avs/topology.c                                            |  162 ++
 sound/soc/intel/avs/topology.h                                            |   13 
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
 sound/soc/ux500/ux500_msp_dai.c                                           |  189 +--
 sound/soc/ux500/ux500_msp_dai.h                                           |   14 
 sound/soc/ux500/ux500_msp_i2s.c                                           |  264 +++-
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
 sound/usb/usx2y/us122l.c                                                  |    7 
 sound/usb/usx2y/usbusx2y.c                                                |   49 
 sound/usb/usx2y/usbusx2y.h                                                |    4 
 tools/bootconfig/main.c                                                   |   13 
 tools/bpf/bpftool/Makefile                                                |    6 
 tools/build/feature/test-bpf.c                                            |    2 
 tools/include/nolibc/crt.h                                                |    2 
 tools/lib/bpf/bpf.c                                                       |    2 
 tools/lib/bpf/gen_loader.c                                                |    2 
 tools/net/sunrpc/xdrgen/templates/C/union/declaration/close.j2            |    4 
 tools/perf/util/powerpc-vpadtl.c                                          |    2 
 tools/perf/util/symbol.c                                                  |   11 
 tools/sched_ext/scx_central.bpf.c                                         |    6 
 tools/sched_ext/scx_flatcg.bpf.c                                          |   14 
 tools/sched_ext/scx_simple.bpf.c                                          |    6 
 tools/testing/selftests/alsa/mixer-test.c                                 |    4 
 tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c                         |    8 
 tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c                         |    8 
 tools/testing/selftests/bpf/progs/test_bpf_nf.c                           |    8 
 tools/testing/selftests/bpf/progs/test_global_func3.c                     |   18 
 tools/testing/selftests/cgroup/test_kmem.c                                |    2 
 tools/testing/selftests/net/fib_nexthops.sh                               |   28 
 tools/testing/selftests/net/mptcp/mptcp_connect.c                         |    4 
 tools/testing/selftests/net/pmtu.sh                                       |    2 
 tools/testing/selftests/net/test_vxlan_mdb.sh                             |    6 
 tools/testing/selftests/powerpc/tm/tm.h                                   |    8 
 tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c                  |    6 
 1202 files changed, 16618 insertions(+), 8788 deletions(-)

Aamir Ahmed (1):
      net: hinic: fix mailbox segment buffer overflow

Aaron Kling (1):
      spi: tegra210-quad: Allocate DMA memory for DMA engine

Abd-Alrhman Masalkhi (1):
      md/raid10: fix writes_pending and barrier reference leaks on discard failures

Aditya Kumar Singh (1):
      wifi: ath12k: Prevent incorrect vif chanctx switch when handling multi-radio contexts

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

Ahmed Naseef (1):
      net: dsa: mt7530: add EN7528 support

Ai Chao (1):
      ALSA: usb-audio: Add quirk flags for SC13A

Akashdeep Kaur (1):
      mfd: tps65219: Make poweroff handler conditional on system-power-controller

Akiva Goldberger (1):
      net/mlx5: LAG, use local tracker to update active ports

Al Viro (1):
      configfs_depend_prep(): pass configfs_dirent instead of dentry

Alan Borzeszkowski (2):
      thunderbolt: Don't create multiple DMA tunnels on firmware connection manager
      thunderbolt: Improve multi-display DisplayPort tunnel allocation

Albert Esteve (1):
      drm/panel/tdo-tl070wsh30: Use refcounted allocation in place of devm_kzalloc()

Aleksandr Nogikh (1):
      Bluetooth: hci_core: Fix race condition during device registration

Aleksei Sviridkin (2):
      net: dsa: mt7530: populate lpi_interfaces to fix EEE support
      net: ethernet: mtk_eth_soc: populate lpi_interfaces to fix EEE support

Alessandro Baldi (1):
      media: imon: Add iMON VFD HID OEM v1.2 key mappings

Alessandro Schino (1):
      ntfs3: fix out-of-bounds read in ntfs_dir_emit() and hdr_find_e()

Alex Deucher (3):
      drm/amdgpu: add a helper to calculate ring distance
      drm/amdgpu: reorder IB schedule sequence
      drm/amdgpu: plumb timedout fence through to force completion

Alexander Koskovich (1):
      clk: qcom: clk-rpmh: Make all VRMs optional

Alexandra Winter (3):
      dibs: Remove reset of static vars in dibs_init()
      dibs: Unregister dibs_class after error
      s390/ism: folio_put() after error

Alexandre Courbot (1):
      scripts: modpost: detect and report truncated buf_printf() output

Alexey Klimov (1):
      clk: samsung: exynos850: mark APM I3C clocks as critical

Ali Ahmet Memis (4):
      ufs: do not treat unreadable directory blocks as empty
      hwmon: (nct6694) do not expose enable on DTIN temperature channels
      ufs: create the root dentry after loading cylinder metadata
      ufs: validate cylinder group metadata before caching it

Alice Mikityanska (4):
      net/sched: act_csum: don't mangle UDP tunnel GSO packets
      net: ipv4: Fix UDP length overflow with PMTU discover and big MTU
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

Anand Jain (1):
      btrfs: use on-disk uuid for s_uuid in temp_fsid mounts

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

Andy Shevchenko (3):
      smb: client: transport: Fix debug printing in __release_mid()
      thermal: sysfs: switch to use scnprintf() to suppress truncation warning
      idpf: Fix kernel-doc descriptions to avoid warnings

Anna Maniscalco (1):
      iommu: arm-smmu-qcom: Ensure smmu is powered up in set_ttbr0_cfg

Antonin Godard (1):
      Documentation: hwmon: replace full-width colon by a standard ASCII colon

Anuj Gupta (1):
      xfs: release alleged child inode on metapath unlink error

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

Arun T (1):
      gpio: usbio: Add ACPI device-id for NVL platforms

Asad Kamal (1):
      drm/amd/pm: bound pp_dpm_set_pp_table() memcpy

Atish Patra (1):
      crypto: ccp - Fix possible deadlock in SEV init failure path

Aurelien DESBRIERES (1):
      RDMA/rtrs-srv: Fix integer underflow in process_read and process_write

Avi Weiss (1):
      btrfs: send: fix lost error return value in will_overwrite_ref()

Avinash Bhatt (2):
      wifi: iwlwifi: Transition to basic uAPSD with MAC_PM_POWER_TABLE API VER_3
      wifi: iwlwifi: mld: keep healthy link on EMLSR missed beacon exit

Avraham Stern (1):
      wifi: iwlwifi: mld: call iwl_mld_free_ap_early_key() for AP only

Baojun Xu (1):
      ASoC: tas2781: Update default register address to TAS2563

Bard Liao (2):
      ASoC: Intel: sof_sdw: append dai type to dai link name unconditionally
      soundwire: only handle alert events when the peripheral is attached

Baul Lee (1):
      vxlan: mdb: Fix use-after-free in vxlan_mdb_remote_src_del()

Ben Maurer (1):
      btrfs: use lockless read in nr_cached_objects shrinker callback

Ben Reed (1):
      PCI: switchtec: Add Gen6 Device IDs

Benjamin Leggett (1):
      drm/virtio: use the DMA API for resource backing on Xen

Benjamin Marzinski (1):
      dm-raid: only requeue bios when dm is suspending

Biju Das (1):
      drm: renesas: rzg2l_mipi_dsi: Fix deassert/assert of CMN_RSTB signal

Binglei Wang (1):
      erofs: add missing buf->off in erofs_bread()

Bjoern Doebel (4):
      smb: client: avoid leaking refcount in cifs_queue_oplock_break()
      smb: client: avoid leaking refcount when cifs_sb_tlink() fails
      smb: client: fix heap overflow in DACL owner/group rewrite
      smb: client: fail DACL rewrite when the new DACL exceeds 64K

Bjorn Helgaas (1):
      PCI: Wait for device readiness after D3hot -> D0uninitialized transition

Bob Zhou (1):
      drm/amdgpu: avoid force-completing uninitialized UVD rings

Boris Brezillon (1):
      drm/gem: Consider GEM object reclaimable if shrinking fails

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Move the no-revision fixup to get_patch_level()

Brajesh Gupta (2):
      drm/imagination: Don't timeout job if its fence has been signaled
      drm/imagination: Populate FW common context ID before passing to the FW

Brandon Brnich (2):
      media: chips-media: wave5: Fix Reports from Kernel Lock Validator
      media: chips-media: wave5: Release m2m_ctx after Instance Removed from List

Breno Leitao (2):
      netconsole: take target_cleanup_list_lock in drop_netconsole_target()
      arm64: trans_pgd: clone only the linear map that exists at runtime

Brodie Abrew (1):
      platform/x86: sel3350-platform: Retain LED state on load and unload

Candice Li (5):
      drm/amdgpu: cap ATOM command table nesting depth
      drm/amdgpu: validate and share PSP fw_pri_buf copies via psp_copy_fw
      drm/amdgpu: Bound GPIO I2C table entry count from VBIOS
      drm/amdgpu/pm: fix SmartShift bias sysfs store PM refcount on parse error
      drm/amdgpu: validate RAS EEPROM tbl_size before record count

Carolina Jubran (4):
      net/mlx5e: Fix ETS zero BW reporting when one TC holds 100%
      net/mlx5e: Fix use-after-free race in sample_restore_put()
      net/mlx5e: Keep HW timestamp stats monotonic across reconfiguration
      net/mlx5e: Move representor vnic reporter to eswitch devlink port

Ce Sun (1):
      drm/amdgpu: avoid integer overflow in VA range check

Cen Zhang (Microsoft) (2):
      tipc: fix integer overflow in tipc_recvmsg() and tipc_recvstream()
      reboot: fix cad_pid use-after-free race

Cezary Rojewski (9):
      ASoC: Intel: catpt: Complete coredump handling
      ASoC: codecs: pcm3168a: Prevent regulator double-disable in S4
      ASoC: codecs: pcm3168a: Drop CONFIG_PM-conditional preproc directive
      ASoC: Intel: avs: Clean up the bus when fetching ML caps fails
      ASoC: Intel: avs: Do not ignore -ENOENT when loading a topology
      ASoC: Intel: avs: Fix unbalanced module reference count
      ASoC: Intel: avs: Allow the topology to carry NHLT data
      ASoC: Intel: avs: Honor NHLT override when setting up a path
      ASoC: Intel: avs: Refactor and fix init_config access

Chao Yu (3):
      f2fs: embed f2fs_gc_kthread in f2fs_sb_info
      f2fs: fix to reclaim space in f2fs_allocate_pinning_section()
      Revert: "f2fs: check in-memory block bitmap"

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

Chen-Yu Tsai (3):
      pinctrl: mediatek: paris: bypass pinctrl GPIO layer in set GPIO direction
      pinctrl: mediatek: common-v1: bypass pinctrl GPIO layer in set GPIO direction
      drm/panel-edp: Add AUO B133HAN06.6 and BOE NV133FHM-N4F V8.0

ChenXiaoSong (1):
      smb/client: zero-initialize stack-allocated cifs_open_info_data

Cheng-Yang Chou (1):
      sched_ext: Update demo schedulers and selftests to use scx_bpf_task_set_dsq_vtime()

Chengfeng Ye (3):
      netfilter: nf_log: unregister loggers before per-net teardown
      afs: Clear stale peer app data after address list changes
      netfilter: cttimeout: prevent UAF during module unload

Chenguang Zhao (3):
      RDMA/mlx5: Use QP port when decoding responder CQEs
      netlabel: fix IPv6 unlabeled address add error handling
      net: txgbe: fix phylink leak on AML init failure

Chih-Kang Chang (1):
      wifi: rtw89: suspend DIG when remain-on-channel

Chris Aherin (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga 7 16IAP7

Chris Lu (2):
      Bluetooth: btusb: MT7922: Add VID/PID 0e8d/223c
      Bluetooth: btusb: MT7925: Add VID/PID 0e8d/8c38

Christian Brauner (2):
      ns: add __ns_ref_read()
      ns: rename to exit_nsproxy_namespaces()

Christian Marangi (2):
      usb: host: add ARCH_AIROHA in XHCI MTK dependency
      net: ethernet: mtk_eth_soc: fix supported_interface set after phylink_create

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

Chuck Lever (3):
      xprtrdma: Add request-pool slack for delayed recycling
      tls: Flush backlog before waiting for a new record
      xdrgen: Fix union declarations

Ciprian Regus (3):
      net: ethernet: oa_tc6: Handle the OA TC6 SPI protected mode
      net: ethernet: oa_tc6: Export standard defined registers
      net: ethernet: oa_tc6: Add the OA_TC6_ prefix to standard registers

Claudiu Beznea (1):
      pinctrl: renesas: rzv2m: Use -ENOTSUPP instead of -EOPNOTSUPP

Colin Ian King (1):
      OPP: of: Fix potential multiplication overflow when calculating freq

Cong Nguyen (2):
      hwmon: (gpio-fan) take fan_data->lock in gpio_fan_shutdown()
      hwmon: (applesmc) fix key backlight workqueue leak on register failure

Corentin Labbe (1):
      wifi: ralink: RT2X00: init EEPROM properly

Cris (1):
      Bluetooth: btusb: Add support for TP-Link TL-UB250

Cyrill Gorcunov (1):
      RDMA/irdma: Fix typo in SQ completions generation

Cássio Gabriel (7):
      ALSA: usb-audio: Propagate write errors in generic mixer put callbacks
      ALSA: ice1724: Fix blocking open for independent surround PCMs
      ALSA: usx2y: Drain pending US-428 pipe-4 output commands
      ALSA: seq: Remove arbitrary prioq insertion limit
      ASoC: codecs: rk3328: Use managed GPIO and clock helpers
      ALSA: seq: oss: Reject reads that cannot fit the next event
      ASoC: topology: Check PCM and DAI name strings before use

Daeho Jeong (1):
      f2fs: accurately adjust free_sections during free_segment_range

Daehyeon Ko (1):
      exit: hold a reference to thread_pid across proc_flush_pid

Dai Ngo (1):
      NFS: fix eof updates after NFSv4.2 fallocate/zero-range

Dan Carpenter (1):
      drm/virtio: Fix a NULL vs ERR_PTR() bug in virtio_gpu_user_framebuffer_create()

Daniel Borkmann (2):
      libbpf: Also reset {insn,data}_cur on realloc failure
      bpf: Reject redirect helpers without a bpf_net_context

Daniel C. Ribeiro (1):
      ALSA: usb-audio: Add FIXED_RATE quirk for JBL Quantum650 Wireless

Daniel Lezcano (1):
      thermal/drivers/tegra/soctherma: Switch to devm cooling device registration

Danielle Ratson (1):
      bridge: Do not suppress ARP probes and DAD NS unconditionally

Dapeng Mi (3):
      perf/x86/intel/ds: Factor out PEBS group processing code to functions
      perf/x86/intel: Correct pt_regs->flags update for PEBS path
      perf/x86/intel: Prevent drain_pebs() reentry

Dario Binacchi (1):
      drm/panel: simple: Add AM-1280800W8TZQW-T00H

Darrick J. Wong (36):
      xfs: use the rtgroup extent count to find rtrefcount gaps
      xfs: truncate quota file correctly when repairing quota file
      xfs: strengthen the "is cow staging" helpers in scrub
      xfs: snapshot scrub stats when rendering them
      xfs: snapshot old AGFL before rewriting it
      xfs: signal inode btree xref error if get_rec returns an error
      xfs: reset parent pointer args before each dir tree unlink repair
      xfs: report nonexistent parents as a filesystem corruption
      xfs: report healthy filesystem events in scrub stats
      xfs: preserve owner on in-memory btree creation
      xfs: make the rtsummary repair fix the file size too
      xfs: log the tempip after we convert it to extents format
      xfs: fix xfs_rtrmapbt_mem_cursor for non-rmap filesystems
      xfs: fix unit conversions in per_binval computation
      xfs: fix the rtrmap and rtrefcount _maxlevels_ondisk functions
      xfs: fix short ifork reaping computation in xreap_bmapi_binval
      xfs: fix rtrmap cross-referencing elision logic
      xfs: fix rtrefcount btree block counting in scrub
      xfs: fix replaying dirent removals into the temporary directory
      xfs: fix parent rec lookup initialization in xrep_metapath_unlink
      xfs: fix name string recording in slowpath pptr tracepoints
      xfs: fix bnobt repair space reservation disposal failure
      xfs: fix backwards skipping logic in xrep_quota_block
      xfs: fix backwards mergeability logic in refcount scrubber
      xfs: don't spin forever on zero-length dirents when salvaging them
      xfs: don't modify file attributes or poke fsnotify for dry runs
      xfs: don't leak new_bp if xfs_btree_bload_drop_buf fails
      xfs: don't leak dqacct if rhashtable insertion fails
      xfs: destroy seen inode bitmap when we fail to add a dirpath
      xfs: cross-reference the rtgroup superblock extent, not block
      xfs: count escaped corruption errors in scrub stats
      xfs: compute dquot checksum after resetting dd_lsn in repair
      xfs: bail out on bitmap errors in xrep_agfl_fill
      xfs: advance the findparent inode scan cursor while holding ILOCK
      xfs: actually recover intended file sizes in xfs_xmi_item_recover_intent
      xfs: actually check internal-rtdev fields in the superblock

Dave Carey (3):
      HID: multitouch: Fix Yoga Book 9 14IAH10 touchscreen misclassification
      USB: cdc-acm: start bulk-IN polling when ALWAYS_POLL_CTRL is set
      HID: multitouch: Honor ContactCount for Yoga Book 9 to suppress ghost contacts

Dave Chen (1):
      btrfs: only account delalloc bytes for regular file inodes in btrfs_getattr()

Dave Penkler (1):
      gpib: Suppress setting END on error from NI_USB dongle

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

David Howells (11):
      cachefiles: Fix double fput
      netfs: Fix decision whether to disallow write-streaming due to fscache use
      netfs: Fix barriering when walking subrequest list
      netfs: Fix unbuffered/DIO write partial transfer error return
      netfs: Fix error vs transferred passed to ->ki_complete()
      netfs: Fix i_size update for partial transfer
      netfs: Fix subreq ref leak
      cachefiles: Fix potential UAF/KASAN warning
      afs: Fix missing kunmap in afs_dir_search_bucket()
      afs: Fix double-unmap of directory block
      afs: Fix incorrect free in candidate cleanup in afs_lookup_server()

David Laight (1):
      tipc: Dont send random pad bytes in RESET/ACTIVATE messages

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

Denzeel Oliva (1):
      clk: samsung: exynos990: Fix PERIC0/1 USI clock types

Devin Wittmayer (1):
      wifi: mt76: mt7925: add Netgear A8500 USB device ID

Dian-Syuan Yang (3):
      wifi: rtw89: disable HTC field in AP mode
      wifi: rtw89: disable CSI STBC for VHT 160MHz
      wifi: rtw89: pci: enable LTR based on pcie control register

Diego Oliva (1):
      smb: client: reject short READ responses in CIFSSMBRead()

Dinh Nguyen (1):
      EDAC/altera: Use parent device for devres in altr_portb_setup()

Dmitry Baryshkov (2):
      drm/panel: jadard-jd9365da-h3: set prepare_prev_first
      media: iris: turn platform data into constants

Dominik Kaszewski (1):
      drm/amd/display: Fix DPMS using partially updated pipe context

Dong Chenchen (1):
      net: iptunnel: fix stale transport header during tunnel decapsulation

Donggeun Yoo (13):
      net: phy: dp83867: handle the active-high LED polarity mode
      tracing: Fix memory corruption from the histogram stacktrace modifier
      tracing: Fix memory corruption from a "STACKTRACE" histogram key
      tracing: Free histogram the var ref when its initialization fails
      tracing: Free histogram var refs regardless of how often they are referenced
      tracing: Free histogram the field rejected for a bad modifier
      tracing: Let histogram values keep the percent and graph modifiers
      tracing: Keep the entry count when the histogram stats allocation fails
      function_graph: Use the saved entry's size when reprinting it
      net: phy: dp83td510: handle the active-high LED polarity mode
      tracing: Set the trace clock before registering the histogram trigger
      tracing: Take the reference before publishing the named histogram trigger
      tracing: Undo the registration when enabling the histogram trigger fails

Douglas Anderson (1):
      driver core: Replace dev->can_match with dev_can_match()

Eduard Zingerman (3):
      bpf: reject BPF_PSEUDO_FUNC reference to the main program
      bpf: share several utility functions as internal API
      bpf: Don't predict JMP32 pointer vs zero comparisons

Edward Adam Davis (2):
      netfs: break unbuffered write when netfs_alloc_subrequest() fails
      ALSA: caiaq: Decoupling ep1_in_urb in caiaq dev

Eelco Chaudron (1):
      openvswitch: fix wrong flag value in get_ipv6_ext_hdrs()

Emil Tsalapatis (1):
      bpf: Only enforce 8 frame call stack limit for all-static stacks

Emmanuel Grumbach (15):
      wifi: iwlwifi: fix the access to CNVR TOP registers
      wifi: iwlwifi: mld: honor BSS_CHANGED_BEACON_ENABLED
      wifi: iwlwifi: add support for AX231
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

Eric Biggers (2):
      crypto: x86/aria - add missing vzeroupper in AVX2 code
      crypto: x86/aria - add missing vzeroupper in AVX-512 code

Eric Dumazet (20):
      net: bridge: remove stale rcu_barrier() in br_multicast_dev_del()
      net/sched: sch_drr: make cl->quantum lockless
      drop_monitor: perform u64_stats updates under IRQ-disabled section
      drop_monitor: fix size calculations for 64-bit attributes
      l2tp: fix tunnel and session refcount leak on seq_file release
      net: icmp: avoid invalid transport header access in icmp_send tracepoint
      tcp: use GFP_ATOMIC in tcp_send_active_reset()
      igmp: convert struct ip_sf_list to RCU
      ipv6: mcast: fix RCU list diversion in ip6_mc_del1_src()
      ipv6: mcast: use copy-on-write RCU updates in ip6_mc_source()
      ip6_gre: check tunnel info before xmit in ip6gre_tunnel_xmit
      ipv6: sr: restore network header before routing and forwarding
      bonding: alb: fix uninitialized transport header access in alb_determine_nd()
      locking/lockdep: Invalidate stale class_cache entries for zapped classes
      bonding: do not clear curr_active_slave prematurely when releasing all slaves
      bonding: use skb_cow_head() in bond_do_alb_xmit() and rlb_arp_xmit()
      vxlan: initialize _md in vxlan_xmit_one()
      tcp: rename icsk_timeout() to tcp_timeout_expires()
      tcp: introduce icsk->icsk_keepalive_timer
      tcp: remove icsk->icsk_retransmit_timer

Eric Sandeen (1):
      xfs: fix reclaimed page accounting in xfs_buf_free

Erni Sri Satya Vennela (1):
      net: mana: hardening: Reject zero max_num_queues from MANA_QUERY_VPORT_CONFIG

Esben Haabendal (1):
      drm/bridge: ti-sn65dsi83: Fix error handling in sn65dsi83_reset_work()

Ethan Nelson-Moore (1):
      ASoC: ti: omap3pandora: update board check to use DT compatible

Evelyn Ali (1):
      ALSA: hda/realtek: ALC882: Fixup for Clevo P775TM1

Evgenii Burenchev (1):
      vdpa/ifcvf: handle dev_set_name() failure in ifcvf_vdpa_dev_add()

Ezio Galeazzi (1):
      ALSA: hda/ca0132: add QUIRK_GENERIC path for Gigabyte GA-Z170X-Gaming G1

FAN YE (1):
      btrfs: zstd: fix lost wakeup when waiting for a workspace

Faicker Mo (1):
      net: net_failover: Fix the deadlock in net_failover_slave_name_change()

Fan Wu (2):
      ieee802154: cc2520: fix FIFOP work use-after-free
      hwmon: (gpio-fan) Fix use-after-free in alarm work

Fangyu Yu (1):
      iommu/riscv: Add command queue lock

Farhad Alemi (1):
      freevxfs: don't BUG() on unknown typed-extent type

Fernando Fernandez Mancera (1):
      ipv6: addrconf: fix temp address generation after prefix deprecation

Filipe Manana (2):
      btrfs: fix use-after-free on reloc root after error in insert_dirty_subvol()
      btrfs: fix reloc root cleanup in merge_reloc_roots()

Florian Eckert (1):
      PCI: intel-gw: Enable clock before PHY init

Florian Westphal (4):
      netfilter: nf_conntrack_expect: zero at allocation time
      netfilter: nfnetlink_log: wait for rcu grace period before freeing pernet state
      netfilter: nfnetlink_log: cope with concurrent instance destruction
      netfilter: ip6_tables: set F_PROTO when proto value is nonzero

Fourie Zhang (1):
      net: mpls: clear inner_protocol when the last label is popped

Fredric Cover (1):
      smb: client: fix races in cifsd thread creation

Furst Blumier (1):
      ALSA: hda/realtek: Add quirk for HP 255 15.6 inch G9 Notebook PC

Gabriel Krisman Bertazi (2):
      io_uring/net: let io_recv_buf_select return the length of the buffer region
      io_uring/net: don't overconsume buffers when using MSG_TRUNC

Galen Hassen (1):
      ALSA: hda/conexant: Add pin config quirk for Lenovo IdeaPad Slim 5 16AKP10

Gang Yan (1):
      selftests: mptcp: fix an UAF in mptcp_connect.c

Gangliang Xie (1):
      drm/amdgpu: add first record offset check

Gao Xiang (2):
      erofs: disable LZ4 rolling decompression for now
      erofs: separate plain and compressed filesystems formally

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

Gil Fine (4):
      thunderbolt: Avoid reserved fields in path config space for USB4 routers
      thunderbolt: Verify PCIe adapter in detect state before tunnel setup
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
      Linux 6.18.53

Greg Marsden (1):
      net/rds: fix tcp stream corruption with large pages

Gregor Herburger (1):
      drm/vc4: hvs/v3d: Fix null dereference in unbind

Griffin Kroah-Hartman (1):
      misc: amd-sbi: Add null check for devm_kasprintf()

Guanghui Yang (2):
      btrfs: detach failed sprout device from transaction update list
      btrfs: restore active device pointers after failed sprout

Guangshuo Li (2):
      net: cpsw_new: unregister devlink on port registration failure
      net: lan966x: restore RX state on reload failure

Guenter Roeck (7):
      hwmon: (corsair-psu) Fix linear11 calculation
      Documentation/hwmon: Document hwmon_notify_event()
      hwmon: Fix potential UAF in pec_store
      hwmon: (ina2xx) Rely on subsystem locking
      hwmon: (sht4x) Rely on subsystem locking
      hwmon: (sht4x) Fix return value from heater_enable_store()
      hwmon: (sht4x) Add missing locks

Gustavo Kenji Mendonça Kaneko (2):
      drm/arm/malidp: use clk_bulk API in runtime PM resume and suspend
      drm/arm/komeda: fix error handling for clk_prepare_enable() and callers

Günther Noack (4):
      landlock: Clarify documentation for the IOCTL access right
      landlock: Add access_mask_subset() helper
      landlock: Transpose the layer masks data structure
      landlock: Use mem_is_zero() in is_layer_masks_allowed()

HW He (1):
      net: gro: Fix nesting of TCP GSO SKBs in skb_gro_receive_list()

Hans Zhang (5):
      PCI: iproc: Protect root bus removal with rescan lock
      PCI: altera: Protect root bus removal with rescan lock
      PCI: rockchip: Protect root bus removal with rescan lock
      PCI: mediatek: Protect root bus removal with rescan lock
      PCI: plda: Protect root bus removal with rescan lock

Haotian Zhang (1):
      media: v4l2-h264: Fix memcmp() size in B1 reference list comparison

Haoxiang Li (4):
      media: em28xx-video: fix missing res_free() on init_usb_xfer failure
      net: thunderx: fix PTP device ref leak in nicvf_probe()
      net: microchip: sparx5: clean up PSFP resources on flower setup failure
      fbdev: pm2fb: unwind WC setup on probe failure

Harald Freudenberger (8):
      s390/crypto: Fix skcipher_walk return code handling in aes_s390
      s390/crypto: Fix use of mutex in atomic context
      s390/crypto: Fix missing scrub of temp buffers with AES ctr and gcm algorithm
      s390/crypto: Fix missing cra_flags in paes_s390
      s390/crypto: Fix handling of EBUSY in PHMAC when req is pushed to crypto engine
      s390/crypto: Fix missing scrub of temp buffers with PAES algorithm
      s390/crypto: Fix wrong return code to engine in asynch callbacks
      s390/crypto: Map EBUSY to EIO when key conversion fails repeatedly

Hardik Garg (1):
      Drivers: hv: vmbus: add VTL2 redirect connection ID

Harry Wentland (1):
      dm/amdgpu: fix malformed link_settings debugfs output

Heikki Krogerus (2):
      i2c: designware: Global register definitions
      drm/xe/i2c: Keep the i2c controller always enabled

Heiko Carstens (3):
      s390/zcore: Removed unused variables
      s390/vtime: Use __this_cpu_read() / get rid of READ_ONCE()
      s390/time: Use jiffies instead of jiffies_64

Henrique Carvalho (1):
      smb: client: fix UBSAN array-index-out-of-bounds in smb2_copychunk_range

Henry Martin (3):
      sctp: fix soft lockup from unpadded ASCONF-ACK parameter iteration
      tracing/probes: Fix use-after-free on field name/type of events with multiple probes
      tracing/user_events: Don't destroy fields when event removal fails

Herve Codina (1):
      driver core: Avoid warning when removing a device while its supplier is unbinding

Hirokazu Honda (1):
      tee: optee: Allow MT_NORMAL_TAGGED shared memory

Hongfu Li (1):
      selftests/cgroup: Fix cg_run_in_subcgroups ignoring arg parameter

Hrvoje Nuic (1):
      Bluetooth: btusb: Add Mercusys MA530 for Realtek RTL8761BUV

Hui Su (3):
      staging: fbtft: make dirty_lock IRQ-safe
      sched: Account cgroup CPU time to the execution context
      sched/core: Call wq_worker_tick() for the execution context

Huiwen He (6):
      smb/client: flush dirty data before punching a hole
      smb/client: validate new EOF for insert range
      smb/client: validate new EOF for zero range
      smb/client: mark file sparse before emulating insert range
      smb/client: fix data corruption in emulated insert range
      smb/client: fix integer truncation in collapse range

Hungyu Lin (1):
      media: qcom: iris: fix runtime PM reference leaks

HyeongJun An (4):
      ASoC: meson: aiu: Validate written enum values
      ALSA: dummy: Report a change when one capture switch channel moves
      selftests/alsa: Fix the step check for INTEGER controls
      ALSA: hda: Report a change when only the channel status bytes move

Håkon Bugge (1):
      net/rds: acquire the fastpath locks in rds_conn_shutdown()

Ibrahim Hashimov (2):
      wifi: mac80211_hwsim: reject undersized HWSIM_ATTR_TX_INFO
      mac802154: fix use-after-free of sdata via queued RX frames

Ido Schimmel (3):
      bridge: Add missing READ_ONCE() annotations around FDB destination port
      nexthop: Initialize extack in remove_nh_grp_entry()
      tunnels: Drop stale dst when building an ICMP error for PMTUD

Igor Paunovic (2):
      drm/rockchip: dw_dp: Select DRM_BRIDGE_CONNECTOR
      drm/rockchip: rk3066_hdmi: Add missing Kconfig selects

Ilya Bakoulin (1):
      drm/amd/display: Avoid DPMS-on for phantom stream

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

Jackson Lee (1):
      media: chips-media: wave5: Add timeout while stop_streaming

Jacob Keller (1):
      ice: add missing xa_destroy for sched_node_ids

Jacob Moroni (1):
      RDMA/irdma: Replace waitqueue and flag with completion

Jad Keskes (1):
      EDAC/device_sysfs: Use kstrtouint() for poll_msec to prevent truncation

Jakub Kicinski (9):
      psp: validate IPv4 header fields in psp_dev_rcv()
      net: ethtool: cmis_cdb: hold instance lock for ops locked devices
      tls: reject the combination of TLS and sockmap
      net: dsa: bcm_sf2: bound the CFP rule dump by the caller's buffer size
      eth: nfp: bound the ntuple rule dump by the caller's buffer size
      eth: nfp: drop the replaced rule from the list when reprogramming fails
      net: dsa: mv88e6xxx: bound the policy rule dump by the caller's buffer size
      eth: ice: don't dereference pointers from TP_printk()
      Reapply "bnxt_en: bring back rtnl_lock() in the bnxt_open() path"

Jamal Hadi Salim (10):
      net/sched: cls_u32: fix duplicate handle when node ID pool is exhausted
      net: cap tx_queue_len at S16_MAX to prevent oversized ring allocations
      net: reject oversized tx_queue_len at netlink parse time
      net/sched: fq_pie: clamp quantum in change path
      net/sched: sfq: clamp quantum in change path
      net/sched: hhf: clamp quantum in change and init paths
      net/sched: dualpi2: clamp psched_mtu at all call sites
      net/sched: pie: clamp psched_mtu in pie_drop_early
      net/sched: drr: clamp quantum in change class
      net/sched: ets: clamp quantum in parse and fallback paths

James C. Owens (1):
      btrfs: scrub: report the failing sector's address, not the stripe base

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

Jared Kangas (4):
      hwmon: (ina2xx) Acquire hwmon_lock in shunt_resistor_show()
      hwmon: (ina2xx) Parameterize ina2xx_data in ina226_alert_read()
      hwmon: (ina2xx) Replace masks with enum in alert functions
      hwmon: (ina2xx) Decouple in0 and curr1 alarms

Jason Andryuk (2):
      x86/amd_node: Avoid divide by zero on virtualized systems
      x86/amd_node: Fix potential NULL pointer dereference

Jason Gunthorpe (4):
      RDMA/umem: Be careful about boundary conditions in ib_umem_find_best_pgsz()
      RDMA/umem: Make ib_umem_is_contiguous() safe on 32 bit
      RDMA/mlx5: Create ODP EQ for non-pinned dmabuf MRs
      iommu/riscv: Disable SADE

Jason Winter (1):
      net: usb: cx82310_eth: drop URB after 0xffff reboot sentinel to prevent partial_data heap overflow

Javier Achirica (1):
      bus: mhi: host: pci_generic: Round up nr_irqs to power of two

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

Jeffin Philip (1):
      fs: autofs: fix memory leak in autofs_fill_super()

Jens Axboe (1):
      io_uring/rw: end write accounting from ->ki_complete

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

Jiayuan Chen (5):
      rds: annotate data-race around rs_seen_congestion
      bpf: Fix REG INVARIANTS VIOLATION on speculative pointer arithmetic
      bpf: Fix NULL-ptr-deref when showing a void BTF type
      bpf: Fix NULL-ptr-deref in btf_var_show()
      selftests/bpf: Fix flaky bpf_nf test when random NAT port is 0

Jie Gan (1):
      coresight: platform: defer connection counter increment until alloc succeeds

Jie Wang (2):
      gfs2: fix quota init duplicate scan
      gfs2: move quota_init qc iterator increment

Jijie Shao (1):
      net: hns3: improve the unused_tuple parameter setting

Jingbo Xu (1):
      erofs: add sysfs feature entry for xattr prefixes

Jiri Kosina (1):
      HID: hidpp: fix potential UAF in hidpp_connect_event()

Jiri Olsa (1):
      bpf: Guard __get_user acesss with access_ok for uprobe_multi data

Jisheng Zhang (1):
      spi: dw: fix wrong RX_SAMPLE_DLY setting after resume

Joas Antonio dos Santos (1):
      netfilter: nf_conntrack_sip: fix OOB read in sip_skip_whitespace()

Joe Damato (6):
      bnxt: fix head underflow on XDP head-grow
      bnxt_en: Only restore LRO if the device supports TPA
      bnxt_en: Don't free the live ring's TPA state on queue restart failure
      bnxt_en: Propagate RX ring init failures in bnxt_init_nic()
      bnxt_en: Propagate TPA buffer allocation failures in bnxt_queue_mem_alloc()
      bnxt_en: Handle buffer allocation failure in bnxt_rx_ring_reset()

Johan Hovold (1):
      net: hso: fix TIOCMIWAIT race

Johannes Berg (12):
      wifi: nl80211: reject beacons with bad HE operation
      wifi: nl80211: check link is beaconing for color change
      wifi: mac80211: always allow transmitting null-data on TXQs
      wifi: mac80211: use chandef in ieee80211_get_sta_bw()
      wifi: mac80211: explicitly disable FTM responder on AP stop
      wifi: iwlwifi: pcie: fix ACPI DSM check
      wifi: iwlwifi: pcie: add two LNL PCI IDs
      wifi: mac80211: clarify beacon parsing with MBSSID/EMA
      wifi: mac80211: unify link STA removal in vif link removal
      wifi: cfg80211: harden cfg80211_defragment_element()
      wifi: iwlwifi: mld: don't WARN on WoWLAN suspend w/o netdetect
      wifi: iwlwifi: mvm: fix P2P-Device binding handling

Johannes Thumshirn (1):
      btrfs: zoned: finish active block group cleanup if call_zone_finish() fails

John Hubbard (1):
      rust: allow `clippy::as_underscore` in the generated bindings

John Ogness (1):
      printk/nbcon: Change nbcon_irq_work to IRQ_WORK_LAZY

John Stultz (1):
      sched: Make class_schedulers avoid pushing current, and get rid of proxy_tag_curr()

Johny Lin (1):
      ALSA: hda: cs35l41: imply SERIAL_MULTI_INSTANTIATE

Joonwon Kang (1):
      mailbox: Make mbox_send_message() return error code when tx fails

Jori Koolstra (1):
      dibs: change dibs_class to a const struct

Joris Vaisvila (1):
      net: ethernet: mtk_eth_soc: avoid writing to ESW registers on MT7628

Jose Ignacio Tornos Martinez (3):
      net: wwan: t7xx: Add delay between MD and SAP suspend
      PCI: Avoid FLR for MediaTek MT7925 WiFi
      PCI: Avoid SBR for Qualcomm WCN6855/WCN7850 WiFi, SDX62/SDX65 modems

Joshua Hay (1):
      idpf: account for VLAN header when parsing RSC packet header

Jozsef Kadlecsik (1):
      netfilter: ipset: mark the rcu locked areas properly

Justin Chen (2):
      net: bcmasp: clear txcb->last before writing each descriptor
      net: bcmasp: fix tx_spb_ring_full() checking same slot cnt times

Justin Lai (1):
      rtase: Fix flow control configuration

Jérôme de Bretagne (1):
      drm/panel-edp: Add LG LP129WT232166 panel

Kalpan Jani (1):
      mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0

Kamal Wadhwa (1):
      regulator: core: clamp voltage constraints before applying apply_uV

Kamlesh Chhetty (1):
      ALSA: hda: Add Lenovo Legion 7i 16IAX7 17AA3874 quirk

KangNing Liao (1):
      btrfs: protect sb_write_pointer() with invalidate lock

Karl Mehltretter (8):
      tracing: Disable KCOV instrumentation for trace_irqsoff.o
      iommu/amd: Do not reallocate GA log buffers on resume
      virtio: fix use-after-free in unregister_virtio_device()
      virtio_input: stop callbacks before unregistering input device
      drm/adp: Drop the select of the nonexistent CONFIG_DRM_KMS_DMA_HELPER
      drm/logicvc: Drop the select of the nonexistent CONFIG_DRM_KMS_DMA_HELPER
      netfs: Fix uninitialized return value in netfs_unbuffered_write()
      smb: client: pin DFS superblock in iterator callback

Kartik Rajput (1):
      soc/tegra: fuse: Register nvmem lookups at probe

Kazuki Hanai (1):
      ALSA: us122l: Prevent write upgrades for read mappings

Ken Lin (1):
      media: platform: cros-ec: Add Kulnex and Moxoe to the match table

Kevin Hao (2):
      net: macb: Replace open-coded implementation with napi_schedule()
      net: macb: Use netif_napi_add_tx() instead of netif_napi_add() for TX NAPI

Kevin Tung (1):
      iio: adc: rtq6056: add i2c_device_id support

Kiran K (4):
      Bluetooth: btintel_pcie: Add 50 ms delay before MAC init on BlazarIW
      Bluetooth: btintel_pcie: Clear automask on spurious interrupts
      Bluetooth: btintel_pcie: validate packet_len before skb_put_data
      Bluetooth: btintel_pcie: fix tx_handle bounds off-by-one

Koba Ko (1):
      cxl/region: Validate partition index before array access

Kory Maincent (1):
      hwmon: (adt7462) Add of_match_table to support devicetree

Krystian Kaniewski (1):
      Bluetooth: hci_sysfs: Fix NULL pointer dereference in device_del()

Krzysztof Wilczyński (3):
      PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()
      PCI/proc: Fix race between pci_proc_init() and pci_bus_add_device()
      PCI/sysfs: Use kstrtobool() to parse the ROM attribute input

Kumar Kartikeya Dwivedi (11):
      bpf: Mark signal tracepoint siginfo arguments as scalar
      bpf: Reject tail calls directly from callback frames
      bpf: Reject resilient lock operations in rbtree callbacks
      bpf: Mark sched_process_wait argument as nullable
      bpf: Track verifier instruction stats for each subprogram
      bpf: Check ancestor frames for rbtree callbacks
      bpf: Mark bpf_btf_find_by_name_kind() as sleepable
      bpf: Mark faultable stack helpers as sleepable
      bpf: Reject legacy packet loads from callbacks
      bpf: Require MEM_PERCPU for percpu kptr stores
      bpf: Reject non-scalar bpf_loop iteration counts

Kumar Meiyappan (2):
      scsi: pm8001: Reject firmware update in fatal error state
      scsi: pm8001: Reject non-fatal dump when controller is crashed

Kuniyuki Iwashima (7):
      ipv4: fib: Don't dump dying fib_info in fib_leaf_notify().
      af_unix: Unlink scc_entry in unix_del_edge().
      af_packet: Don't cast tpacket_hdr.tp_len to int in tpacket_parse_header().
      net: Remove conflicting altnames for dying netns in __dev_change_net_namespace().
      af_unix: Update last skb marker in manage_oob().
      af_unix: Return immediately when manage_oob() returns NULL for 0-length buffer.
      net/sched: cls_api: Don't replay RTM_GETCHAIN in tc_ctl_chain().

Kyle Zeng (2):
      ipvs: fix reversed sequence option serialization
      ipvs: reject invalid states in connection template sync records

Lad Prabhakar (4):
      pinctrl: renesas: rzg2l: Handle RZ/V2H(P) IOLH configuration in PM cache
      pinctrl: renesas: rzg2l: Add SR register cache for PM suspend/resume
      mmc: renesas_sdhi: Add OF entry for RZ/G2N SoC
      mmc: renesas_sdhi: Add OF entry for RZ/G2E SoC

Lama Kayal (1):
      net/mlx5: E-Switch, prevent mc_list repopulation during vport disable

Laxman Acharya Padhya (4):
      wifi: mt76: mt7921: validate CLC firmware records
      wifi: mt76: mt7921: skip unknown CLC firmware records
      Bluetooth: btintel: validate version TLV value lengths
      Bluetooth: btintel: bound firmware ID by TLV length

Leo Yan (4):
      coresight: perf: Retrieve path and source from event data
      coresight: Disable source helpers in coresight_disable_path()
      bpftool: Pass host flags to bootstrap libbpf
      perf/core: Skip empty AUX records with only format flags

Leonardo Bras (1):
      arm64/daifflags: Make local_daif_*() helpers __always_inline

Leonardo Costa (1):
      drm/bridge: tc358768: Enforce input bus flags via atomic_check

Li Qiang (1):
      cifs: validate idmap key payload length

Li RongQing (2):
      RDMA/mlx5: Fix state and counter desync on loopback enable failure
      iommu/amd: Add NUMA node affinity for IOMMU log buffers

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

Linus Walleij (21):
      wifi: ath9k: Obtain system GPIOS from descriptors
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

Lizhi Hou (1):
      accel/amdxdna: Remove __counted_by from struct amdxdna_cmd_chain

Loic Poulain (1):
      media: qcom: camss: vfe-340: Proper client handling

Long Li (2):
      net: mana: Clear RDMA teardown and suspend state in mana_rdma_probe()
      net: mana: restore the XDP program pointer when pre-allocation fails

Lorenzo Bianconi (5):
      net: airoha: Reserve RX headroom to avoid skb reallocation
      net: airoha: enable RX_DONE interrupt for RX queue 31
      net: stmmac: reconfigure RX packet parser table in stmmac_hw_setup() after reset
      net: stmmac: initialize ptp_lock at probe time
      net: stmmac: fix TX descriptor availability check for TSO traffic

Lorenzo Stoakes (ARM) (5):
      scripts/mksysmap: drop the MODULE_INFO() symbols from kallsyms
      scripts/mksysmap: fix escape of '$' in the __pi_ pattern
      x86/mm/pat: Acquire init_mm write lock on collapse to avoid UAF
      x86/mm/pat: Acquire init_mm read lock on attribute changes to avoid UAF
      x86/mm/pat: Allocate split page tables as kernel page tables

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

Lukas Wunner (2):
      PCI: Stop setting cached power state to 'unknown' on unbind
      crypto: ecc - Unbreak the build on arm with CONFIG_KASAN_STACK=y

MD Danish Anwar (1):
      net: hsr: enable promiscuous mode on interlink port with fwd offload

Madhavender Singh (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Laptop 14s-dr1xxx

Magdalena Schulfer (2):
      accel/ivpu: Validate full buffer range in ivpu_to_cpu_addr
      accel/ivpu: Validate firmware log buffer metadata

Manuel Fombuena (1):
      leds: st1202: Validate pattern input before stopping the sequence

Manuel Lauss (1):
      serial: 8250_port: recognize UPIO_AU

Maoyi Xie (3):
      usb: gadget: aspeed_udc: avoid past-the-end iterator in dequeue
      rds: filter RDS_INFO_* getsockopt by caller's netns
      hsr: broadcast netlink notifications in the device's net namespace

Marcel Kłos (1):
      ALSA: hda/realtek: Add quirk for HP EliteBook 830 G8 (8AB8) to enable mute LEDs

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

Mario Limonciello (1):
      x86/itmt: Don't make ITMT enablement depend on debugfs

Mark Pearson (2):
      watchdog: lenovo_se10_wdt: Add support for SE10 Gen 2 platform
      watchdog: lenovo_se10_wdt: Fix use-after-free and resource leak risk

Markus Lindner (1):
      ALSA: usb-audio: Add dB map quirk for Razer Barracuda X 2.4

Martin Karsten (1):
      net: napi: Skip last poll when arming gro timer in busy poll

Masami Hiramatsu (Google) (4):
      tracing: Add boot-time backup of persistent ring buffer
      tracing: Fix to avoid creating trace instances with duplicate names
      tools/bootconfig: Fix integer overflow and truncation in size checks
      bootconfig: Fix integer overflow in initrd size check

Mathias Nyman (1):
      xhci: Prevent queuing new commands if xhci is inaccessible

Matthew Brost (2):
      drm/pagemap: dma-unmap pages before handling migration errors
      drm/ttm: Drop tt->restore after successful restore

Matthew Bystrin (1):
      mfd: rsmu: Add 8a34002 support

Matthieu Baerts (NGI0) (4):
      mptcp: options: handle MPC data + csum reqd + no csum
      mptcp: subflow: no need to copy thmac during ulp_clone
      mptcp: syncookies: remember the request backup flag
      mptcp: pm: reset retrans_time when ADD_ADDR entry is reused

Maurizio Lombardi (2):
      nvme-core: align fabrics_q teardown with admin_q in nvme_free_ctrl
      scsi: target: iscsi: Fix hang for aborted WRITE_PENDING commands

Max Chou (1):
      Bluetooth: btrtl: Add the support for RTL8761CUV

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

Michal Wajdeczko (1):
      drm/xe/guc: Add support for NO_RESPONSE_BUSY in CTB

Mieczyslaw Nalewaj (1):
      net: dsa: realtek: rtl8365mb: add support for RTL8367SB

Miguel Ojeda (2):
      rust: allow `unknown_lints` in generated bindings for Rust < 1.88
      drm/panic: clean new `clippy::needless_range_loop` lint for Rust 1.100.0

Mika Westerberg (5):
      thunderbolt: Don't disable lane adapter if XDomain lane bonding isn't possible
      thunderbolt: Release request if tb_cfg_request() fails in __tb_xdomain_response()
      thunderbolt: Keep XDomain reference during the lifetime of a service
      thunderbolt: Keep the domain reference while processing hotplug
      thunderbolt: Set tb->root_switch to NULL when domain is stopped

Mike Rapoport (Microsoft) (1):
      x86/mm/pat: Don't gate cpa_lock on debug_pagealloc_enabled()

Milan P. Gandhi (2):
      scsi: mpi3mr: Fix NULL pointer dereference in mpi3mr_sas_port_add()
      scsi: mpi3mr: Fix target device refcount leak in mpi3mr_sas_port_add()

Minhong He (1):
      phonet: check register_netdevice_notifier() error in phonet_device_init()

Miri Korenblit (3):
      wifi: mac80211: avoid out-of-bounds access in monitor
      wifi: mac80211: don't call ieee80211_handle_reconfig_failure when not needed
      wifi: iwlwifi: mld: purge async notifications upon nic error

Mohamed Khalfella (2):
      nvme-fc: Do not cancel requests in io target before it is initialized
      nvme: remove stale namespaces by NSID range during scan

Moritz Baron (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14IRH8

Moritz Tanner (1):
      fs: don't return -EINVAL for successful nested thaw

Moshe Shemesh (2):
      net/mlx5: Relax capability check for eswitch query paths
      net/mlx5: Switch vport HCA cap helpers to kvzalloc

Mostafa Saleh (1):
      irqchip/gic-v4: Don't advertise VLPIs if no ITS is probed

Myeonghun Pak (1):
      idpf: disable DIM work before freeing q_vectors

Nagamani PV (1):
      s390/qeth: allow bridgeport queries despite OS_MISMATCH

Naman Gulati (1):
      ipv6: null-check fib6_node before accessing in __ip6_del_rt_siblings()

Namjae Jeon (20):
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
      ksmbd: don't hold ci->m_lock while waiting for a lease break ack

Nathan Chancellor (1):
      scripts/sorttable: Mark long_size as __maybe_unused

Nazim Amirul (1):
      net: stmmac: xgmac2: disable RBUE in default RX interrupt mask

Nicolai Buchwitz (2):
      net: macb: destroy the phylink instance on the probe error path
      net: macb: put the "mdio" child node reference on success

Nikhil Chatterjee (1):
      HID: bpf: Add Huion Inspiroy Frego M button quirk

Nikhil Gurudasani (1):
      erofs: preserve LZMA decoders on resize failure

Nikhil P. Rao (4):
      pds_core: quiesce DMA before freeing resources
      ionic: use netif_txq_maybe_stop() in ionic_tx()
      pds_core: fix cmd_regs access racing BAR unmap on reset
      pds_core: don't release PCI regions for VFs on reset

Niklas Cassel (3):
      ata: libata-core: Disable LPM on some WD drives
      ata: libata-core: Disable LPM on WD Green 2.5 480GB
      ata: libata-core: Disable LPM on WDC WD141KFGX-68FH9N0

Niklas Neronin (1):
      usb: xhci: remove legacy 'num_trbs_free' tracking

Niklas Schnelle (1):
      iommu/s390: Fix NULL dereference in iova_to_phys() with ZPCI_TABLE_TYPE_RFX

Nikolay Aleksandrov (1):
      net: bridge: mcast: properly convert mglist to rcu

Nikolay Metchev (1):
      platform/x86: intel-hid: Add HP ProBook x360 440 G1 to button_array_table

Nilesh Javali (14):
      scsi: qla2xxx: Zero dport diagnostics buffer to avoid info leak
      scsi: qla2xxx: Null out freed pointers in qla2x00_mem_alloc() error path
      scsi: qla2xxx: Fix queue teardown NULL dma_free and bitmap locking
      scsi: qla2xxx: Fix use-after-free of qpair work on queue teardown
      scsi: qla2xxx: Bound VP index against VP_CTRL IOCB bitmap size
      scsi: qla2xxx: Fix 64G link speed reporting in get_data_rate
      scsi: qla2xxx: Skip vport under deletion in report ID acquisition
      scsi: qla2xxx: Use ring-slot helpers in __qla2x00_alloc_iocbs
      scsi: qla2xxx: Use memset_io() to clear QLAFX00 request ring slot
      scsi: qla2xxx: Fix soft lockup polling continuation IOCB signature
      scsi: qla2xxx: Clamp max_npiv_vports to VP_CTRL bitmap capacity
      scsi: qla2xxx: Unlink NVMe unsol ctx before freeing on LS reject error
      scsi: qla2xxx: Serialize NVMe unsol ctx list with a per-fcport lock
      scsi: qla2xxx: Validate BSG request_len before reading vendor_cmd[]

Ning Ding (1):
      bpf: Reject untrusted allocated-object pointers

Norbert Szetei (2):
      net: openvswitch: fix use-after-free of the flow table mask array
      landlock: Fix use-after-free of the source's parent directory

Nuno Sá (1):
      clk: clk-axi-clkgen: Add support versal timings

Nuoqi Gui (1):
      bpf: Mask pseudo pointer values in verifier logs

Oliver Neukum (1):
      usb: core: hcd: fix possible deadlock in rh control transfers

Or Har-Toov (3):
      devlink: Refactor resource functions to be generic
      devlink: Add port-level resource registration infrastructure
      net/mlx5: Register SF resource on PF port representor

Osama Abdelkader (3):
      arm64: panic from init_IRQ if IRQ handler stacks cannot be allocated
      mmc: davinci: fix mmc_add_host order in probe
      riscv: panic if IRQ handler stacks cannot be allocated

Ovidiu Bunea (1):
      drm/amd/display: Find link encoder for flexible DIG mapping cases

Pablo Neira Ayuso (1):
      netfilter: cttimeout: detach dataplane timeout policy and repurpose refcount

Pagadala Yesu Anjaneyulu (2):
      wifi: iwlwifi: mld: disallow puncturing in US/CA for WH
      wifi: mac80211: ibss: wait for in-flight TX on disconnect

Pali Rohár (2):
      cifs: Fix support for creating SFU socket
      cifs: Fix support for creating SFU fifo

Panagiotis Petrakopoulos (1):
      wifi: rtw88: Add NULL check for chip->edcca_th in rtw_fw_adaptivity_result()

Paolo Abeni (7):
      mptcp: remove unneeded READ_ONCE() annotation
      mptcp: do not reschedule the RTX timer for fallback sockets
      mptcp: prevent race between disconnect() and rtx
      mptcp: move the stale logic out of retrans scheduler
      mptcp: avoid unneeded actions on subflow reset
      mptcp: close race between scheduler and state change
      mptcp: fix bad accounting in __mptcp_subflow_push_pending()

Parth Pancholi (1):
      drm/bridge: tc358768: Set pre_enable_prev_first for reverse order

Paul Cercueil (1):
      media: v4l2-common: Always register clock with device-specific name

Paul Chaignon (2):
      bpf: Print breakdown of insns processed by subprogs
      bpf: Report maximum combined stack depth

Pauli Virtanen (4):
      Bluetooth: ISO: fix malformed ISO_END/CONT handling
      Bluetooth: L2CAP: fix chan mode for LE_CONN_REQ + EXT_FLOWCTL pchan
      Bluetooth: L2CAP: fix out-of-bounds write in l2cap_ecred_connect
      Bluetooth: L2CAP: clear FLAG_DEFER_SETUP only for same PID/PSM

Paulo Alcantara (5):
      smb: client: fix one-byte OOB read in smb2_parse_native_symlink()
      smb: client: fix file type corruption in cifs_reparse_point_to_fattr()
      smb: client: fix file type corruption in posix_reparse_to_fattr()
      smb: client: fix file type corruption in wsl_to_fattr()
      smb: client: use atomic_t for mnt_cifs_flags

Pavan Chebbi (1):
      fwctl/bnxt_en: Move common definitions to include/linux/bnxt/

Pavan Kumar Linga (2):
      idpf: introduce local idpf structure to store virtchnl queue chunks
      idpf: introduce idpf_q_vec_rsrc struct and move vector resources to it

Pedro Falcato (1):
      x86/alternatives: Exclude text poking against change_page_attr()

Pengpeng Hou (12):
      soundwire: validate DT compatible before parsing it
      genirq/proc: Size interrupt directory names for 10-digit interrupt numbers
      drivers/of: validate live-tree string properties before string use
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

Peter Zijlstra (2):
      perf: Fix addr_filter_ranges lifetime
      x86/mm: Fix and document DEBUG_PAGEALLOC

Pierre Barre (2):
      9p: invalidate readdir buffer on seek
      9p: use kvzalloc for readdir buffer

Ping-Ke Shih (2):
      wifi: rtw89: phy: check length before parsing PHY status IE
      wifi: rtw89: 8851bu: add Mercusys MA60XNB (2c4e:0128)

Piotr Kubik (1):
      leds: trigger: gpio: Use GPIOD_FLAGS_BIT_NONEXCLUSIVE

Pooja Katiyar (1):
      thunderbolt: Don't access path config space on Lane 1 adapters in tb_switch_reset_host()

Potin Lai (1):
      hwmon: (pmbus/lm25066) Fix PMBus coefficients for LM5064/5066/5066i

Praveen Talari (1):
      spi: core: Abort active target transfer on controller suspend

Prike Liang (1):
      drm/amdgpu: skip gfx switch_power_profile during GPU reset

Priyansh Jain (1):
      thermal/drivers/qcom/tsens: Atomic temperature read with hardware-guided retries

Pu Hu (1):
      arm64: kprobes: Allow reentering kprobes while single-stepping

Qiang Liu (3):
      ksmbd: fix sd_ndr.data memory leak in ksmbd_vfs_set_sd_xattr
      ksmbd: fix n.data memory leak in ksmbd_vfs_set_dos_attrib_xattr
      ksmbd: Fix acl.sd_buf memory leak and invalid sd_size error handling

Qing Luo (1):
      mptcp: pm: userspace: fix address ID overflow

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

Qu Wenruo (3):
      btrfs: fix the possible bioc_list memory leak during error
      btrfs: return proper negative error code for update_raid_extent_item()
      btrfs: do not force reloc root creation during qgroup_account_snapshot()

Raf Dickson (1):
      vsock: use sk_acceptq_is_full() helper in all transports

Rafael J. Wysocki (1):
      rtc: cmos: Use platform_get_irq_optional() in cmos_platform_probe()

Ralph Boehme (2):
      smb: client: refactor ACL setting control flow in id_mode_to_cifs_acl()
      smb/client: fix security flag calculation when setting security descriptors

Ranjani Vaidyanathan (1):
      watchdog: imx7ulp_wdt: Keep WDOG running until A55 enters WFI on i.MX94

Ratheesh Kannoth (2):
      octeontx2-pf: reset HTB scheduler topology before freeing queues
      octeontx2-af: fix PF/CGX debugfs PCI bus lookup

Ravindra (1):
      Bluetooth: btusb: Add support for Intel Lizard Peak 2 (0x8087:0x0040)

Ricardo Neri (1):
      x86/topology: Add missing struct declaration and attribute dependency

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

Rohit Sinha (1):
      ALSA: hda/realtek - Add quirk for HP Victus 15-fa0xxx (MB 8A50)

Roman Li (1):
      drm/amd/display: Set gpuvm min page size to 4K on dcn35/36

Roman Prucha (1):
      ALSA: ctxfi: Fix CA20K2 S/PDIF passthrough

Rong Zhang (2):
      Bluetooth: btmtk: Disable remote wakeup for MT7922/MT7925
      Bluetooth: btrtl: Don't leak return code when parsing firmware format v2

Rosen Penev (8):
      mips: cps: Assemble jr.hb with an R2 ISA level
      net: ibm: emac: Reserve VLAN header in MJS limit
      net: ibm: emac: fix unchecked platform_get_irq return value
      ipmi: si: Use platform_get_irq_optional() to retrieve interrupt
      netfilter: nf_conntrack: use get_unaligned_be32() in tcp_sack()
      net: ibm: emac: mal: fix potential system hang in mal_remove()
      sparc64: uprobes: add missing break
      sparc: Disable compat support with LLD

Rounak Das (1):
      EDAC/altera: Use ECC manager compatible to select A10/S10 IRQ layout

Rudi Heitbaum (1):
      ASoC: rt5645: Perform the initial jack detect at probe

Runyu Xiao (5):
      ipv6: use READ_ONCE() for bindv6only default in inet6_create()
      net: au1000: move free_irq out of the close-time spinlocked section
      ASoC: sti: initialize IRQ lock before requesting IRQ
      cpufreq: initialize policy rwsem before sysfs publication
      net: macb: initialize PTP state before registering clock

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

Sajal Gupta (1):
      drm/gud: validate GUD_ROTATION_0 is present in supported rotations

Samson Tam (1):
      drm/amd/display: Check for sharpening case when calculating max vtaps for scaler

Samuel Holland (1):
      Revert "riscv: Reset pmm when PR_TAGGED_ADDR_ENABLE is not set"

Samuel Moelius (2):
      Bluetooth: L2CAP: validate connectionless PSM length
      f2fs: validate inline dentry name lengths before conversion

Sang-Heon Jeon (1):
      media: remove conditional return with no effect

Sanjay Chitroda (1):
      iio: accel: mma8452: switch to non-devm request_threaded_irq()

Sascha Bischoff (2):
      irqchip/gic-v5: Immediately exec priority drop following activate
      irqchip/gic-v5: Preserve ICC_CR0_EL1 state

Sasha Levin (14):
      Revert "arm64: dts: qcom: qcs6490-rb3gen2: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: lemans: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: talos: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sm8750: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sm8650: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sm8550: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sm8450: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sm8350: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sm8250: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sm8150: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sdm845: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sc8180x: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sar2130p: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: kodiak: Fix the PCIe iommu-map entries"

Satyajit Roy (3):
      drm/amd/display: Rebuild InfoFrames on output color space changes
      drm/amd/display: Propagate HDMI RGB quantization selectability
      drm/amd/display: Honor Broadcast RGB for BT.2020 RGB output

Sebastian Andrzej Siewior (4):
      mailbox: imx: Use devm_pm_runtime_enable()
      mailbox: imx: Add a channel shutdown field
      mailbox: imx: use devm_of_platform_populate()
      ring-buffer: Acquire the lock with irqsave in rb_wake_up_waiters()

Seiji Nishikawa (1):
      sched/rt,dl: Skip migrate-disabled tasks when picking a push candidate

Selvamani Rajagopal (5):
      net: ethernet: oa_tc6: Interrupt is active low, level triggered.
      net: ethernet: oa_tc6: Protect skb pointer used by two different kernel instances
      net: ethernet: oa_tc6: Improve the error recovery
      net: ethernet: oa_tc6: Disable tx queues on fatal error
      net: ethernet: oa_tc6: Fix for the wrong data type

Selvin Xavier (1):
      RDMA/bnxt_re: Proper rollback if the ioremap fails

Seungwon Bae (1):
      vxlan: reject dynamic fdb entries that reference a nexthop id

Shahar Shitrit (2):
      net/mlx5e: Fix missing FEC mode mapping for RS_544_514_INTERLEAVED_QUAD
      net/mlx5e: Fix setting RS FEC after remapping

Shawn Lin (1):
      mmc: core: Add validation for host-provided max_segs

Shay Drory (2):
      net/mlx5e: Verify unique vhca_id count instead of range
      net/mlx5: E-Switch, align disable sequence with switchdev-to-legacy transition

Shengjiu Wang (1):
      ASoC: fsl-asoc-card: reduce WM8904 PLL ratio to meet frequency limit

Shiji Yang (1):
      pwm: mediatek: set mt7628 pwm45_fixup flag to false

Shivang Upadhyay (1):
      ppc/fadump: invoke kmsg_dump in fadump panic path

Shivaprasad G Bhat (2):
      powerpc/eeh: Fix recursive locking on devices without EEH sensitive driver
      powerpc: pci-ioda: Fix the stale irq chip reference

Shiwu Zhang (1):
      drm/amdgpu: fix buffer overflow during vBIOS update

Shixiong Ou (1):
      drm/sched: Create a fake device for KUnit tests

Shuangpeng Bai (1):
      btrfs: fix transaction use-after-free in raid stripe insertion

Shubham Chakraborty (1):
      hwmon: (raspberrypi) Fix delayed-work teardown race

Shubham Nayak (1):
      ALSA: hda/realtek: Add quirk for HP Victus 16-e0xxx (88EE) to enable mute LED

Sicong Huang (1):
      virt: acrn: Fix irqfd use-after-free during eventfd shutdown

Siew Chin Lim (1):
      firmware: stratix10-svc: change get provision data to async SMC call

Simon Xue (1):
      iommu/rockchip: disable fetch dte time limit

Slawomir Stepien (1):
      drm/cirrus-qemu: Validate BAR0 size during probe

Soheil Hassas Yeganeh (1):
      x86/cfi: Fix FineIBT hash offset in cfi_get_func_hash()

Sophie D (1):
      drm/gud: Add RCade Display Adapter VID/PID pair

Srinivas Kandagatla (1):
      ASoC: qcom: q6apm: return error code to consumers on failures

Srinivasan Shanmugam (2):
      drm/amdgpu: Fix missing unwind in amdgpu_ib_schedule() error path
      drm/amdgpu: Make amdgpu_vm_flush() non-failing in submission path

Stanley Chu (1):
      i3c: master: svc: Prevent IRQ storm from false SLVSTART on NPCM845

Stanley.Yang (1):
      drm/amdgpu: harden FRU PIA parsing with bounded helpers

Stefan Berger (1):
      integrity: Check for NULL returned by asymmetric_key_public_key

Stepan Ionichev (4):
      mmc: davinci: avoid NULL deref of host->data in IRQ handler
      usb: gadget: goku_udc: avoid NULL deref of dev->driver in INT_USBRESET log
      tty: serial: 8250: protect against NULL uart->port.dev in register
      iio: adc: qcom-spmi-iadc: balance enable_irq_wake() on driver unbind

Steven Rostedt (2):
      tracing: Remove get_trigger_ops() and add count_func() from trigger ops
      tracing: Merge struct event_trigger_ops into struct event_command

Stian Halseth (1):
      sunvdc: unmap LDC cookies when the descriptor send fails

Sudeep Holla (2):
      firmware: arm_scmi: Validate SENSOR_UPDATE payload size
      firmware: arm_scmi: Validate BASE_ERROR_EVENT payload size

Sumanth Korikkar (1):
      s390/diag324: Preserve -EBUSY return code

Sumeet Pawnikar (1):
      powercap: intel_rapl: Fix memory leak in rapl_add_package_cpuslocked()

Sun Jian (1):
      init/main: read bootconfig header with get_unaligned_le32()

Sunday Clement (1):
      drm/amdkfd: Fix OOB memory exposure in get_wave_state()

Sunil Goutham (1):
      octeontx2-af: Fix limiting SRIOV VF count logic

Sunil Khatri (3):
      drm/amdgpu/userq: pin mqd and fw object bo to avoid eviction
      drm/amdgpu: use atomic operation to achieve lockless serialization
      drm/drm_exec: fix up contended obj when num_objects is 0

Svyatoslav Ryhel (1):
      ARM: tegra: tf600t: Invert accelerometer calibration matrix

Takashi Iwai (2):
      ALSA: hda/realtek: Add quirk for HP Pavilion x360
      ALSA: caiaq: Fix potential double-free at error path

Tao Cui (2):
      RDMA/counter: Fix num_counters leak on bind_qp failure in alloc_and_bind()
      blk-cgroup: fix leaks and online flag on radix_tree_insert failure

Taylor Bates (1):
      mlxsw: spectrum_ptp: Fix napi_gro_receive() call from GC workqueue context

Terry Hsiao (3):
      drm/panel-edp: Add CSW PNB601LS1-2 and LGD LP116WHA-SPB1
      drm/panel-edp: Add AUO B140XTN07.5, AUO B140HAK03.5, AUO B116XTN02.3, AUO B140XTK02.4, AUO B140HAN07.7
      drm/panel-edp: Add BOE NT140WHM-N4T, BOE NT140WHM-T05, BOE NV140FHM-N40

Thadeu Lima de Souza Cascardo (1):
      drm/ttm: Fix bo resource use-after-free

Thibault Ferrante (1):
      selftests/powerpc/tm: Fix tcheck() reading uninitialised CR value

Thiyagarajan Pandiyan (1):
      wifi: nl80211: Increase ie_len size to prevent truncated IEs in new peer notifications

Thomas Gleixner (2):
      genirq/manage: Make NMI cleanup RT safe
      tick/broadcast: Plug clockevents replacement race

Thomas Hellström (1):
      drm/xe: Flush LSC untyped L1 dataport cache after rcs/ccs batches

Thomas Lin (1):
      spi: dw-mmio: Add ACPI ID LECA0002 for LECARC SoCs

Thomas Richter (1):
      perf/core: Allow list_del during perf_event_overflow()

Thomas Weißschuh (2):
      tools/nolibc: avoid call to wcslen() in _start_c() inserted by clang
      tracing: Restore :mod: trailer after parsing in ftrace_set_clr_event()

Thorsten Blum (7):
      crypto: omap - add omap_des_unregister_algs helper
      crypto: atmel-ecc - add support for atecc608b
      crypto: atmel-sha204a - remove sysfs group before hwrng
      powerpc/kexec_file: Use inclusive range checks in add_usable_mem()
      powerpc/kexec_file: Use inclusive range checks for excluded memory
      powerpc/ps3: Fix repository.c build failure
      drm/i915: Fix memory leak in query_perf_config_list()

Théo Lebrun (2):
      net: macb: rename bp->sgmii_phy field to bp->phy
      net: macb: unify device pointer naming convention

Tianchu Chen (1):
      ASoC: sprd: validate compress buffer sizes against fixed allocations

Tianze Shao (1):
      ASoC: rt712-sdca: reset codec at io_init to fix silent headphone

Tiezhu Yang (1):
      libbpf: Add __NR_bpf definition for LoongArch

Timur Kristóf (2):
      drm/amdgpu: Use system unbound workqueue for soft IH ring
      drm/amd/pm/si: Don't schedule thermal work when queue isn't initialized

Timur Tabi (2):
      drm/nouveau/gsp: add SEC2 to GA100 chip table
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

Tvrtko Ursulin (1):
      drm/ttm: Tidy usage of local variables a little bit

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

Uwe Küchler (1):
      ALSA: usb-audio: Add quirk for Novation Mininova

Vadim Fedorenko (2):
      spi: xilinx: let transfers timeout in case of no IRQ
      ptp: ocp: add shutdown callback

Vaibhav Jain (1):
      powerpc/pseries: Ensure vpa,slb_shadow & dtl are unregistered during crash

Vamsi Attunuru (1):
      vdpa/octeon_ep: Use 4 bytes for mailbox signature

Vasant Hegde (1):
      iommu/amd: Fix premature break in init_iommu_one() again

Vasileios Almpanis (2):
      configfs: pin the symlink target's dirent instead of chasing ->ci_dentry
      configfs: unhash the dentry before dropping the item in rmdir

Vasily Gorbik (4):
      s390/ipl: Fix NULL deref in kdump without re-IPL parm block
      s390/ipl: Fix NULL deref in dump_reipl without re-IPL parm block
      s390/boot: Fix physical memory search range
      s390/boot: Avoid IPL parameter append past command line

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

Vincent Guittot (2):
      sched/eevdf: Fix augmented max_slice
      sched/eevdf: Fix rb augmented with multi fields

Vineeth Karumanchi (1):
      net: macb: fix NULL pointer dereference on unbind with fixed-link

Vineeth Vijayan (1):
      s390/cio: Purge based on the cdev's online status

Vishal Moola (Oracle) (1):
      x86/mm/pat: Convert split_large_page() to use ptdescs

Vishnu Razdan (1):
      hwmon: (pmbus) Clear generic status alarms with CLEAR_FAULTS

Viswajith Murali (1):
      octeontx2-af: mcs: Clear stale X2P calibration state before calibration

Vladislav Karmanov (1):
      net: phy: mediatek-ge: disable EEE on the MT7530 PHY

Vlatko Kosturjak (1):
      ppp_async: drop the errored frame instead of resetting its headroom

Wang Yan (1):
      perf powerpc-vpadtl: Fix raw_size of DTL samples

Wang YuWei (1):
      spi: dw-dma: Wait for controller idle before completing Tx

Wanwu Li (2):
      sched_ext: Fix timer pinning and return value in scx_central
      sched_ext: Fix vtime delta loss in scx_flatcg cgroup migration

Wei Qisen (1):
      net: sfp: add quirk for OEM 2.5G optical modules

Wei Zhang (1):
      wifi: ath11k: cancel SSR work items during PCI shutdown

Weiming Shi (7):
      ACPICA: Fix NULL pointer dereference in acpi_ns_custom_package()
      btrfs: tree-checker: validate INODE_REF's namelen
      net/sched: defer qdisc freeing after failed creation
      net: dsa: tag_brcm: legacy FCS: request needed tailroom
      fbdev: vfb: defer cleanup until the last reference
      i2c: smbus: reject oversized block transfers in the common path
      net: appletalk: fix NULL pointer dereference in aarp_send_ddp()

Wenjie Qi (3):
      f2fs: validate MOVE_RANGE destination size
      f2fs: limit recovery filename logging to stored length
      f2fs: reject setattr size changes on large folio files

Wentao Guan (1):
      iommu/arm-smmu-v3: Disable implementations during devm teardown

Wentao Liang (1):
      net: qrtr: fix node refcount leak on ctrl packet alloc failure

Wesley Cheng (1):
      phy: qcom: m31-eusb2: Make USB repeater optional

Xiang Liu (2):
      drm/amd/ras: Fix CPER ring debugfs read overflow
      drm/amd/ras: reset CPER ring on corrupt entry size

Xiaogang Chen (2):
      drm/amdkfd: Let driver decide buffer size at AMDKFD_IOC_GET_DMABUF_INFO ioctl
      drm/amdkfd: check find_first_zero_bit before __set_bit on kfd->doorbell_bitmap

Xie Yuanbin (1):
      ARM: 9484/1: enable interrupts when unhandled user faults are triggered

Xin Long (2):
      sctp: fix err_chunk memory leaks in INIT handling
      sctp: fix a TOCTOU race in SCTP_CMD_TIMER_START

XingWang Xiang (2):
      net: mctp: i3c: serialize probe with bus removal
      genetlink: pin family module during policy dump

Xiong Weimin (4):
      virtio_input: reset device if input_register_device() fails
      virtio_mmio: disable IRQ wake before free_irq
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

Yael Chemla (1):
      net/mlx5: E-Switch: fix use-after-free in mlx5_eswitch_termtbl_put

Yao Sang (1):
      nvme: refresh multipath head zoned limits from path limits

Yazen Ghannam (2):
      RAS/AMD/ATL, EDAC/amd64: Only load ATL when needed
      x86/amd_node: Fix PCI device reference counting in amd_smn_init()

Yehyeong Lee (1):
      net: drop_monitor: fix info leak in NET_DM_ATTR_PAYLOAD

Yevgeny Kliteynik (2):
      net/mlx5: HWS, Check if device is down while polling for completion
      net/mlx5: HWS, Handle destroying table that has a miss table

YiPeng Chai (1):
      drm/amdgpu: check and drop invalid bad page records

Yicong Hui (1):
      net/micrel: Fix typos in micrel driver code comments

Yilin Zhang (2):
      ALSA: pcm: Serialize PCM mmap with buffer reallocation to fix page UAF
      inet: frags: invalidate queues before flushing them

Yogesh Mohan Marimuthu (1):
      drm/amdgpu/userq: fix struct drm_amdgpu_info_device padding for 32bit compile

Yongqiang Sun (2):
      drm/amdkfd: fix SMI event cross-process information leak
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

Yudi Yang (1):
      drm/rockchip: analogix_dp: fix unchecked bound endpoint name length

Yuho Choi (1):
      sctp: Unwind address notifier registration on failure

Yung-Tse Cheng (1):
      virtio-fs: avoid double-free on failed queue setup

Yunxiang Li (1):
      drm/amdgpu/ras: add ras_suspend callback and use it for cp_ecc_error_irq

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

Zhanjun Dong (1):
      drm/xe: Fix null pointer dereference in devcoredump cleanup

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

Zhiling Zou (3):
      net: bridge: use option bits for CFM/MRP frame handlers
      ieee802154: 6lowpan: fix NULL dereference in lowpan_newlink
      ipv6: flowlabel: cap duplicate leases per socket

Zhongqiu Han (1):
      cpufreq: zero-initialize policy cpumask before sysfs publication

Zide Chen (1):
      perf/x86/intel/uncore: Guard against invalid box control address

Zihan Xi (3):
      ipv6: fix fib6 walker UAF on seq stop
      ipv4: fib: bound automatic table ID allocation
      ipmr: account multicast table and route memory

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

liuxixin (1):
      nvme: validate FDP configuration descriptor sizes

liyouhong (1):
      ata: ahci: fail probe if BAR too small for claimed ports

shayderrr (1):
      host1x: bus: Fix missing ops null check in error teardown

wangdicheng (2):
      ASoC: amd: renoir: fix disable_pdm_interrupts() to clear mask bits
      ASoC: amd: yc: fix memory leak in acp6x_pdm_dma_close()

Ștefan Ghețu (1):
      ASoC: fsl_micfil: balance mclk enable/disable

