Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B0C3128AB;
	Mon, 21 Sep 2026 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997500; cv=none; b=MYCYIwWmAJYFXcMzL+X/k0gGOJXwTb0Sb7S8EqgY7RFbV8+KaR8WJz1m41gvHG2wz/Y8iLLPVVhVZV6tHW5fDZrIHz2qg2KgcsMj+PvIYc/UIgEm6ld9Mnm1dsSTgXL4z6j8VrVQ+gdz9U7o+pf68yGbcgVJukNtvNL3ywiQp10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997500; c=relaxed/simple;
	bh=j/ig3VLIdvtszWji2aKUJFyz7PPZrdQ689ptgYxuGcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ei1NSFE9nP0FXdnfD62RL6wakPPC3K7E5ZR89cHRzFTTgo/MbKzf+PD+SUADCTPXhaYe1VDiIT/v9uyOvatJzquKAmCMbXIIc/0eAy+mgtaYzREKt5h/9fb2gL2TMJDUSgjPvszQnG4weVcDW4LNPx9MoF5AOsivSMvZz73ucmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hwBNS2Yb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hwBNS2Yb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08591F00898;
	Mon, 21 Sep 2026 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789997494;
	bh=43AtMJyG/KY8JdYxffZ7mwhoTkg14TSz6WlYyLrlAhk=;
	h=From:To:Cc:Subject:Date;
	b=hwBNS2YbRjiO8N6x1AmYm67hUxbay/m4dUWCcBFt2C1fR616G9b5kem5nBJ9isl5G
	 J2W0tejZ1yk8GBjLe9uS380+xaSdWkpJ+88MOwV3I9XvrskpaXg8SobiWqeFiV4d4X
	 +U/FkyH9ljHqozdi13mS5A9f9tr5sbKom9x/kFYk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.2.7
Date: Mon, 21 Sep 2026 15:30:55 +0200
Message-ID: <2026092156-striking-debunk-47ae@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.2.7 kernel.

All users of the 7.2 kernel series must upgrade.

The updated 7.2.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.2.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-fs-erofs                                  |    2 
 Documentation/admin-guide/kernel-parameters.txt                           |   37 
 Documentation/hwmon/gpd-fan.rst                                           |    2 
 Documentation/hwmon/hwmon-kernel-api.rst                                  |   15 
 Documentation/netlink/specs/rt-link.yaml                                  |    2 
 Documentation/scheduler/sched-ext.rst                                     |    2 
 MAINTAINERS                                                               |    1 
 Makefile                                                                  |    2 
 arch/arm/mach-ux500/cpu-db8500.c                                          |    6 
 arch/arm64/kernel/machine_kexec.c                                         |    3 
 arch/arm64/tools/sysreg                                                   |    4 
 arch/powerpc/include/asm/entry-common.h                                   |   14 
 arch/powerpc/kernel/eeh_driver.c                                          |    2 
 arch/powerpc/kernel/interrupt.c                                           |    2 
 arch/powerpc/kexec/file_load_64.c                                         |    4 
 arch/powerpc/kvm/book3s_hv.c                                              |    4 
 arch/powerpc/platforms/powernv/pci-ioda.c                                 |    6 
 arch/powerpc/platforms/ps3/repository.c                                   |    5 
 arch/riscv/kernel/process.c                                               |    4 
 arch/riscv/kernel/sys_hwprobe.c                                           |    5 
 arch/s390/boot/ipl_parm.c                                                 |   26 
 arch/s390/boot/physmem_info.c                                             |    2 
 arch/s390/crypto/aes_s390.c                                               |   87 -
 arch/s390/crypto/paes_s390.c                                              |   19 
 arch/s390/crypto/phmac_s390.c                                             |   36 
 arch/s390/include/asm/pai.h                                               |    1 
 arch/s390/kernel/debug.c                                                  |    6 
 arch/s390/kernel/diag/diag324.c                                           |    3 
 arch/s390/kernel/ipl.c                                                    |   12 
 arch/s390/kernel/perf_pai.c                                               |  198 ++
 arch/s390/kernel/vtime.c                                                  |    6 
 arch/x86/crypto/aria-aesni-avx2-asm_64.S                                  |    6 
 arch/x86/crypto/aria-gfni-avx512-asm_64.S                                 |    3 
 arch/x86/events/intel/core.c                                              |   33 
 arch/x86/events/intel/ds.c                                                |   18 
 arch/x86/events/perf_event.h                                              |    3 
 arch/x86/include/asm/pgtable.h                                            |    2 
 arch/x86/kernel/alternative.c                                             |  111 +
 arch/x86/kernel/amd_node.c                                                |   25 
 arch/x86/kernel/cpu/mce/amd.c                                             |    2 
 arch/x86/kernel/itmt.c                                                    |    8 
 arch/x86/mm/pat/set_memory.c                                              |  148 +-
 block/bio.c                                                               |    9 
 drivers/accel/amdxdna/aie2_message.c                                      |    2 
 drivers/accel/amdxdna/amdxdna_ctx.c                                       |    4 
 drivers/accel/amdxdna/amdxdna_ctx.h                                       |    2 
 drivers/accel/amdxdna/amdxdna_gem.c                                       |   13 
 drivers/accel/ethosu/ethosu_device.h                                      |    1 
 drivers/accel/ethosu/ethosu_drv.c                                         |    3 
 drivers/accel/ethosu/ethosu_gem.c                                         |   11 
 drivers/accel/ethosu/ethosu_job.c                                         |   16 
 drivers/accel/ivpu/ivpu_fw_log.c                                          |   87 -
 drivers/accel/ivpu/ivpu_gem.h                                             |   14 
 drivers/accel/ivpu/ivpu_ipc.c                                             |    7 
 drivers/accel/qaic/qaic_control.c                                         |   46 
 drivers/block/sunvdc.c                                                    |   17 
 drivers/block/ublk_drv.c                                                  |    1 
 drivers/bluetooth/btintel.c                                               |   39 
 drivers/bluetooth/btintel_pcie.c                                          |    9 
 drivers/bluetooth/btmtk.c                                                 |   11 
 drivers/bluetooth/btmtk.h                                                 |    1 
 drivers/bluetooth/btqcomsmd.c                                             |    6 
 drivers/bluetooth/btrtl.c                                                 |    5 
 drivers/bluetooth/btusb.c                                                 |  105 +
 drivers/bluetooth/hci_mrvl.c                                              |    3 
 drivers/char/virtio_console.c                                             |   21 
 drivers/clk/ux500/clk-prcmu.c                                             |   20 
 drivers/clk/ux500/u8500_of_clk.c                                          |    2 
 drivers/cpufreq/cpufreq.c                                                 |    6 
 drivers/cpuidle/cpuidle-ux500.c                                           |    6 
 drivers/dibs/dibs_main.c                                                  |   10 
 drivers/edac/altera_edac.c                                                |   10 
 drivers/edac/amd64_edac.c                                                 |    2 
 drivers/edac/edac_device_sysfs.c                                          |   11 
 drivers/edac/igen6_edac.c                                                 |   66 
 drivers/gpu/drm/adp/Kconfig                                               |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                   |   20 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                         |   14 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c                 |   20 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c                 |    1 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                  |    3 
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                                       |    6 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c                      |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                      |    4 
 drivers/gpu/drm/bridge/tc358768.c                                         |   15 
 drivers/gpu/drm/bridge/ti-sn65dsi83.c                                     |    6 
 drivers/gpu/drm/drm_exec.c                                                |   13 
 drivers/gpu/drm/drm_pagemap.c                                             |  130 +
 drivers/gpu/drm/drm_panic_qr.rs                                           |    4 
 drivers/gpu/drm/gud/gud_drv.c                                             |    2 
 drivers/gpu/drm/i915/display/intel_cdclk.c                                |   10 
 drivers/gpu/drm/i915/display/intel_display_types.h                        |    2 
 drivers/gpu/drm/i915/display/intel_dp.c                                   |   44 
 drivers/gpu/drm/i915/display/intel_dp_mst.c                               |    4 
 drivers/gpu/drm/i915/i915_query.c                                         |    4 
 drivers/gpu/drm/logicvc/Kconfig                                           |    1 
 drivers/gpu/drm/rockchip/Kconfig                                          |    3 
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c                           |    7 
 drivers/gpu/drm/scheduler/tests/mock_scheduler.c                          |   11 
 drivers/gpu/drm/tiny/cirrus-qemu.c                                        |    3 
 drivers/gpu/drm/virtio/virtgpu_display.c                                  |    2 
 drivers/gpu/drm/virtio/virtgpu_drv.h                                      |   20 
 drivers/gpu/drm/virtio/virtgpu_object.c                                   |    2 
 drivers/gpu/drm/virtio/virtgpu_vq.c                                       |    6 
 drivers/gpu/drm/xe/Makefile                                               |    4 
 drivers/gpu/drm/xe/instructions/xe_gpu_commands.h                         |    1 
 drivers/gpu/drm/xe/regs/xe_i2c_regs.h                                     |    2 
 drivers/gpu/drm/xe/xe_amc.c                                               |  197 ++
 drivers/gpu/drm/xe/xe_amc.h                                               |   25 
 drivers/gpu/drm/xe/xe_i2c.c                                               |  128 -
 drivers/gpu/drm/xe/xe_i2c.h                                               |   13 
 drivers/gpu/drm/xe/xe_oa.c                                                |    6 
 drivers/gpu/drm/xe/xe_pagefault.c                                         |   10 
 drivers/gpu/drm/xe/xe_pagefault_types.h                                   |    3 
 drivers/gpu/drm/xe/xe_ring_ops.c                                          |   11 
 drivers/hwmon/applesmc.c                                                  |    7 
 drivers/hwmon/aspeed-pwm-tacho.c                                          |    4 
 drivers/hwmon/asus_rog_ryujin.c                                           |  105 +
 drivers/hwmon/chipcap2.c                                                  |    9 
 drivers/hwmon/corsair-cpro.c                                              |   24 
 drivers/hwmon/gpio-fan.c                                                  |   13 
 drivers/hwmon/hwmon.c                                                     |   21 
 drivers/hwmon/ina2xx.c                                                    |  163 +-
 drivers/hwmon/ltc4282.c                                                   |    2 
 drivers/hwmon/mcp9982.c                                                   |    2 
 drivers/hwmon/nct6694-hwmon.c                                             |   35 
 drivers/hwmon/pmbus/pmbus_core.c                                          |    4 
 drivers/hwmon/sht4x.c                                                     |    8 
 drivers/hwmon/yogafan.c                                                   |    2 
 drivers/i2c/busses/i2c-designware-common.c                                |    2 
 drivers/i2c/busses/i2c-designware-core.h                                  |   85 -
 drivers/i2c/busses/i2c-designware-master.c                                |    2 
 drivers/i2c/busses/i2c-designware-slave.c                                 |    2 
 drivers/iommu/amd/init.c                                                  |   16 
 drivers/iommu/amd/nested.c                                                |    7 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                               |    4 
 drivers/iommu/riscv/iommu.c                                               |  117 +
 drivers/iommu/riscv/iommu.h                                               |    2 
 drivers/iommu/s390-iommu.c                                                |    2 
 drivers/irqchip/irq-gic-v5.c                                              |    6 
 drivers/leds/leds-st1202.c                                                |   10 
 drivers/media/i2c/mt9p031.c                                               |    6 
 drivers/media/pci/intel/ipu-bridge.c                                      |   24 
 drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c |    5 
 drivers/media/platform/microchip/microchip-sama7g5-isc.c                  |    7 
 drivers/media/platform/qcom/iris/iris_resources.c                         |   15 
 drivers/media/platform/qcom/venus/pm_helpers.c                            |    7 
 drivers/media/platform/renesas/rcar-csi2.c                                |    6 
 drivers/media/platform/rockchip/rkvdec/rkvdec-hevc-common.c               |   14 
 drivers/media/platform/rockchip/rkvdec/rkvdec-hevc.c                      |    7 
 drivers/media/platform/rockchip/rkvdec/rkvdec-vdpu381-hevc.c              |    2 
 drivers/media/platform/samsung/s3c-camif/camif-core.c                     |    7 
 drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c                   |    6 
 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c           |   57 
 drivers/media/usb/as102/as102_usb_drv.c                                   |   73 -
 drivers/media/usb/dvb-usb-v2/mxl111sf.c                                   |   12 
 drivers/media/usb/gspca/jl2005bcd.c                                       |    7 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                                 |   32 
 drivers/media/v4l2-core/v4l2-h264.c                                       |    3 
 drivers/mfd/ab8500-core.c                                                 |    2 
 drivers/mfd/db8500-prcmu.c                                                |    6 
 drivers/misc/amd-sbi/rmi-core.c                                           |    4 
 drivers/net/bonding/bond_alb.c                                            |   34 
 drivers/net/bonding/bond_main.c                                           |   18 
 drivers/net/bonding/bond_options.c                                        |    4 
 drivers/net/dsa/bcm_sf2_cfp.c                                             |    2 
 drivers/net/dsa/lantiq/lantiq_gswip.h                                     |    2 
 drivers/net/dsa/mt7530-mmio.c                                             |    1 
 drivers/net/dsa/mt7530.c                                                  |   68 
 drivers/net/dsa/mt7530.h                                                  |    1 
 drivers/net/dsa/mv88e6xxx/chip.c                                          |   16 
 drivers/net/ethernet/airoha/airoha_eth.h                                  |    2 
 drivers/net/ethernet/allwinner/sun4i-emac.c                               |    2 
 drivers/net/ethernet/amd/pds_core/fw.c                                    |   10 
 drivers/net/ethernet/amd/pds_core/main.c                                  |   10 
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c                                  |    3 
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c                          |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                 |   99 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                                 |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c                             |   21 
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h                             |    6 
 drivers/net/ethernet/cadence/macb.h                                       |   23 
 drivers/net/ethernet/cadence/macb_main.c                                  |  677 +++++----
 drivers/net/ethernet/cadence/macb_pci.c                                   |   46 
 drivers/net/ethernet/cadence/macb_ptp.c                                   |   23 
 drivers/net/ethernet/cortina/gemini.c                                     |   77 -
 drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c                         |    4 
 drivers/net/ethernet/intel/ice/ice_common.c                               |    9 
 drivers/net/ethernet/intel/ice/ice_sched.c                                |    4 
 drivers/net/ethernet/intel/ice/ice_trace.h                                |   64 
 drivers/net/ethernet/intel/ice/ice_type.h                                 |    2 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                               |   34 
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c                           |   10 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                           |   33 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c                   |   10 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c                       |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c                          |   60 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                               |   18 
 drivers/net/ethernet/mediatek/mtk_eth_soc.h                               |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en/port.c                         |   15 
 drivers/net/ethernet/mellanox/mlx5/core/en/port.h                         |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c                    |    7 
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c                        |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c                      |   13 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c                          |   52 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.h                          |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c                        |   51 
 drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c                |   37 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                         |    8 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                         |    1 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads_termtbl.c        |    7 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                         |   19 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c                        |   34 
 drivers/net/ethernet/micrel/ks8851_common.c                               |    8 
 drivers/net/ethernet/microsoft/mana/mana_bpf.c                            |    1 
 drivers/net/ethernet/microsoft/mana/mana_en.c                             |   24 
 drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c                      |   19 
 drivers/net/ethernet/oa_tc6.c                                             |  434 ++++--
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c                          |   13 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                         |   93 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c                          |    1 
 drivers/net/gtp.c                                                         |    5 
 drivers/net/ieee802154/cc2520.c                                           |    5 
 drivers/net/ieee802154/mac802154_hwsim.c                                  |   10 
 drivers/net/mctp/mctp-i3c.c                                               |    9 
 drivers/net/net_failover.c                                                |    2 
 drivers/net/phy/dp83867.c                                                 |    3 
 drivers/net/phy/dp83td510.c                                               |    3 
 drivers/net/phy/mediatek/mtk-ge.c                                         |   29 
 drivers/net/phy/phylink.c                                                 |    2 
 drivers/net/ppp/ppp_async.c                                               |   89 -
 drivers/net/ppp/ppp_synctty.c                                             |   97 -
 drivers/net/usb/cx82310_eth.c                                             |    1 
 drivers/net/usb/hso.c                                                     |    2 
 drivers/net/usb/pegasus.c                                                 |   54 
 drivers/net/usb/pegasus.h                                                 |    3 
 drivers/net/vxlan/vxlan_core.c                                            |   13 
 drivers/net/vxlan/vxlan_mdb.c                                             |    8 
 drivers/net/wireless/ath/ath9k/hif_usb.c                                  |   12 
 drivers/net/wireless/ath/ath9k/hif_usb.h                                  |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                           |   33 
 drivers/nvme/host/core.c                                                  |   77 -
 drivers/nvme/host/nvme.h                                                  |   16 
 drivers/nvme/host/rdma.c                                                  |   18 
 drivers/nvme/host/sysfs.c                                                 |    2 
 drivers/nvme/host/tcp.c                                                   |    5 
 drivers/nvme/host/zns.c                                                   |    4 
 drivers/nvme/target/configfs.c                                            |    4 
 drivers/nvme/target/core.c                                                |    2 
 drivers/nvme/target/pr.c                                                  |    2 
 drivers/nvme/target/rdma.c                                                |   15 
 drivers/opp/of.c                                                          |    2 
 drivers/perf/riscv_pmu_legacy.c                                           |    5 
 drivers/perf/riscv_pmu_sbi.c                                              |   98 -
 drivers/platform/x86/asus-laptop.c                                        |    4 
 drivers/platform/x86/hp/hp-wmi.c                                          |  129 +
 drivers/platform/x86/x86-android-tablets/core.c                           |   12 
 drivers/ras/amd/atl/core.c                                                |    1 
 drivers/regulator/db8500-prcmu.c                                          |   12 
 drivers/regulator/pf1550-regulator.c                                      |   82 -
 drivers/s390/net/ism_drv.c                                                |    4 
 drivers/s390/net/qeth_l2.h                                                |    3 
 drivers/s390/net/qeth_l2_main.c                                           |   26 
 drivers/s390/net/qeth_l2_sys.c                                            |    7 
 drivers/scsi/mpi3mr/mpi3mr_transport.c                                    |    8 
 drivers/scsi/mpt3sas/mpt3sas_base.c                                       |    5 
 drivers/scsi/qla2xxx/qla_bsg.c                                            |   49 
 drivers/scsi/qla2xxx/qla_def.h                                            |    2 
 drivers/scsi/qla2xxx/qla_fw.h                                             |    4 
 drivers/scsi/qla2xxx/qla_init.c                                           |   14 
 drivers/scsi/qla2xxx/qla_iocb.c                                           |   23 
 drivers/scsi/qla2xxx/qla_isr.c                                            |   33 
 drivers/scsi/qla2xxx/qla_mbx.c                                            |    6 
 drivers/scsi/qla2xxx/qla_mid.c                                            |   49 
 drivers/scsi/qla2xxx/qla_nvme.c                                           |   10 
 drivers/scsi/qla2xxx/qla_os.c                                             |   15 
 drivers/staging/fbtft/fbtft-core.c                                        |    9 
 drivers/target/iscsi/iscsi_target.c                                       |    4 
 drivers/thermal/db8500_thermal.c                                          |   10 
 drivers/thermal/thermal_sysfs.c                                           |   12 
 drivers/ufs/host/ufshcd-pci.c                                             |   59 
 drivers/usb/atm/xusbatm.c                                                 |    6 
 drivers/usb/class/usbtmc.c                                                |    2 
 drivers/usb/serial/spcp8x5.c                                              |    6 
 drivers/vdpa/ifcvf/ifcvf_main.c                                           |    3 
 drivers/vdpa/solidrun/snet_main.c                                         |    6 
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c                                      |    3 
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c                                      |    7 
 drivers/vdpa/vdpa_user/vduse_dev.c                                        |   10 
 drivers/vhost/net.c                                                       |    2 
 drivers/vhost/vdpa.c                                                      |   88 -
 drivers/vhost/vhost.c                                                     |   57 
 drivers/vhost/vhost.h                                                     |    1 
 drivers/vhost/vsock.c                                                     |    2 
 drivers/video/fbdev/vfb.c                                                 |   11 
 drivers/virtio/virtio.c                                                   |    2 
 drivers/virtio/virtio_input.c                                             |    9 
 drivers/virtio/virtio_mmio.c                                              |   16 
 drivers/virtio/virtio_pci_common.c                                        |    4 
 drivers/virtio/virtio_ring.c                                              |   38 
 drivers/watchdog/db8500_wdt.c                                             |   22 
 drivers/watchdog/msc313e_wdt.c                                            |   74 -
 drivers/watchdog/sunxi_wdt.c                                              |   45 
 drivers/watchdog/watchdog_hrtimer_pretimeout.c                            |    1 
 fs/afs/addr_list.c                                                        |    5 
 fs/afs/dir_edit.c                                                         |    9 
 fs/afs/dir_search.c                                                       |   11 
 fs/afs/fs_probe.c                                                         |    1 
 fs/afs/internal.h                                                         |    8 
 fs/afs/server.c                                                           |    1 
 fs/autofs/inode.c                                                         |    4 
 fs/btrfs/inode.c                                                          |    3 
 fs/btrfs/raid-stripe-tree.c                                               |   25 
 fs/btrfs/raid-stripe-tree.h                                               |    1 
 fs/btrfs/scrub.c                                                          |   24 
 fs/btrfs/send.c                                                           |    2 
 fs/btrfs/transaction.c                                                    |   13 
 fs/btrfs/tree-log.c                                                       |   16 
 fs/btrfs/volumes.c                                                        |    4 
 fs/btrfs/zoned.c                                                          |   11 
 fs/btrfs/zstd.c                                                           |   11 
 fs/cachefiles/xattr.c                                                     |   16 
 fs/configfs/dir.c                                                         |    9 
 fs/configfs/symlink.c                                                     |   24 
 fs/erofs/data.c                                                           |    2 
 fs/erofs/decompressor.c                                                   |   55 
 fs/erofs/decompressor_lzma.c                                              |   18 
 fs/erofs/internal.h                                                       |    6 
 fs/erofs/sysfs.c                                                          |    2 
 fs/erofs/xattr.c                                                          |    9 
 fs/erofs/zdata.c                                                          |   18 
 fs/exec.c                                                                 |   22 
 fs/f2fs/f2fs.h                                                            |    2 
 fs/f2fs/gc.c                                                              |   52 
 fs/f2fs/segment.c                                                         |    4 
 fs/netfs/buffered_read.c                                                  |  164 +-
 fs/netfs/direct_write.c                                                   |   31 
 fs/netfs/internal.h                                                       |    3 
 fs/netfs/misc.c                                                           |   19 
 fs/netfs/objects.c                                                        |   32 
 fs/netfs/read_collect.c                                                   |  128 +
 fs/netfs/read_pgpriv2.c                                                   |   15 
 fs/netfs/read_retry.c                                                     |   13 
 fs/netfs/read_single.c                                                    |    2 
 fs/netfs/rolling_buffer.c                                                 |   81 -
 fs/netfs/write_issue.c                                                    |    2 
 fs/ntfs/attrib.c                                                          |   10 
 fs/ntfs/ea.c                                                              |   14 
 fs/ntfs/lcnalloc.c                                                        |    9 
 fs/ntfs/mft.c                                                             |    4 
 fs/ntfs/reparse.c                                                         |    7 
 fs/ntfs/super.c                                                           |   11 
 fs/overlayfs/super.c                                                      |    2 
 fs/smb/client/cifsacl.c                                                   |   95 -
 fs/smb/client/cifssmb.c                                                   |   26 
 fs/smb/client/file.c                                                      |   22 
 fs/smb/client/inode.c                                                     |   17 
 fs/smb/client/misc.c                                                      |   24 
 fs/smb/client/readdir.c                                                   |   17 
 fs/smb/client/reparse.c                                                   |   33 
 fs/smb/client/smb2ops.c                                                   |  188 ++
 fs/smb/client/trace.h                                                     |    1 
 fs/smb/client/transport.c                                                 |   11 
 fs/smb/server/connection.c                                                |   25 
 fs/smb/server/ksmbd_work.h                                                |    2 
 fs/smb/server/mgmt/user_session.c                                         |   13 
 fs/smb/server/mgmt/user_session.h                                         |    1 
 fs/smb/server/smb2pdu.c                                                   |   47 
 fs/smb/server/smbacl.c                                                    |   67 
 fs/smb/server/transport_tcp.c                                             |   36 
 fs/smb/server/vfs_cache.c                                                 |   17 
 fs/smb/server/vfs_cache.h                                                 |    1 
 fs/super.c                                                                |    9 
 fs/ufs/cylinder.c                                                         |   10 
 fs/ufs/dir.c                                                              |    2 
 fs/ufs/super.c                                                            |   17 
 fs/xfs/libxfs/xfs_btree_mem.c                                             |    2 
 fs/xfs/libxfs/xfs_btree_staging.c                                         |    4 
 fs/xfs/libxfs/xfs_da_btree.c                                              |    2 
 fs/xfs/libxfs/xfs_da_btree.h                                              |    2 
 fs/xfs/libxfs/xfs_defer.c                                                 |    2 
 fs/xfs/libxfs/xfs_exchmaps.c                                              |   10 
 fs/xfs/libxfs/xfs_parent.c                                                |   12 
 fs/xfs/libxfs/xfs_rtrefcount_btree.c                                      |    7 
 fs/xfs/libxfs/xfs_rtrmap_btree.c                                          |    6 
 fs/xfs/scrub/agheader.c                                                   |    7 
 fs/xfs/scrub/agheader_repair.c                                            |   39 
 fs/xfs/scrub/alloc_repair.c                                               |   18 
 fs/xfs/scrub/attr_repair.c                                                |    2 
 fs/xfs/scrub/bmap.c                                                       |    2 
 fs/xfs/scrub/dir_repair.c                                                 |   31 
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
 fs/xfs/scrub/rtrefcount.c                                                 |   82 -
 fs/xfs/scrub/rtsummary_repair.c                                           |    3 
 fs/xfs/scrub/scrub.c                                                      |    3 
 fs/xfs/scrub/stats.c                                                      |   61 
 fs/xfs/scrub/stats.h                                                      |    4 
 fs/xfs/scrub/symlink_repair.c                                             |    2 
 fs/xfs/scrub/tempfile.c                                                   |   29 
 fs/xfs/scrub/trace.h                                                      |   35 
 fs/xfs/xfs_buf.c                                                          |    2 
 fs/xfs/xfs_exchmaps_item.c                                                |   19 
 fs/xfs/xfs_exchrange.c                                                    |   12 
 fs/xfs/xfs_healthmon.c                                                    |   30 
 fs/xfs/xfs_verify_media.c                                                 |   24 
 include/drm/drm_pagemap.h                                                 |    8 
 include/linux/bpf.h                                                       |    3 
 include/linux/bpf_verifier.h                                              |   21 
 include/linux/designware_i2c.h                                            |  107 +
 include/linux/dma-fence-array.h                                           |    1 
 include/linux/dma-fence-chain.h                                           |    9 
 include/linux/igmp.h                                                      |    7 
 include/linux/mfd/db8500-prcmu.h                                          |  252 +++
 include/linux/mfd/dbx500-prcmu.h                                          |  575 --------
 include/linux/mmap_lock.h                                                 |    2 
 include/linux/netfs.h                                                     |    5 
 include/linux/oa_tc6.h                                                    |   50 
 include/linux/perf/riscv_pmu.h                                            |    2 
 include/linux/rbtree_augmented.h                                          |   35 
 include/linux/ring_buffer.h                                               |   24 
 include/linux/rolling_buffer.h                                            |    6 
 include/linux/sched.h                                                     |    2 
 include/linux/sched/signal.h                                              |    5 
 include/linux/skbuff.h                                                    |    5 
 include/media/v4l2-hevc.h                                                 |   41 
 include/net/cfg802154.h                                                   |    1 
 include/net/if_inet6.h                                                    |    2 
 include/net/ip.h                                                          |    3 
 include/net/ip6_route.h                                                   |    2 
 include/net/sch_generic.h                                                 |    2 
 include/net/tcp.h                                                         |    3 
 include/trace/events/cachefiles.h                                         |   19 
 include/trace/events/icmp.h                                               |   13 
 include/trace/events/netfs.h                                              |   30 
 include/uapi/drm/amdgpu_drm.h                                             |    2 
 init/main.c                                                               |   27 
 io_uring/net.c                                                            |   51 
 io_uring/rw.c                                                             |   29 
 kernel/bpf/arraymap.c                                                     |    5 
 kernel/bpf/backtrack.c                                                    |   62 
 kernel/bpf/bpf_iter.c                                                     |    2 
 kernel/bpf/btf.c                                                          |   27 
 kernel/bpf/cfg.c                                                          |    3 
 kernel/bpf/fixups.c                                                       |    7 
 kernel/bpf/hashtab.c                                                      |   29 
 kernel/bpf/local_storage.c                                                |    5 
 kernel/bpf/stackmap.c                                                     |    2 
 kernel/bpf/states.c                                                       |   11 
 kernel/bpf/syscall.c                                                      |    2 
 kernel/bpf/verifier.c                                                     |  263 +++
 kernel/cgroup/cpuset.c                                                    |   39 
 kernel/events/core.c                                                      |    4 
 kernel/events/ring_buffer.c                                               |    9 
 kernel/exit.c                                                             |    9 
 kernel/fork.c                                                             |    7 
 kernel/locking/lockdep.c                                                  |   50 
 kernel/nstree.c                                                           |   10 
 kernel/printk/nbcon.c                                                     |    4 
 kernel/printk/printk.c                                                    |    2 
 kernel/reboot.c                                                           |   19 
 kernel/sched/core.c                                                       |   19 
 kernel/sched/deadline.c                                                   |    4 
 kernel/sched/ext/ext.c                                                    |   21 
 kernel/sched/fair.c                                                       |   18 
 kernel/sched/rt.c                                                         |    4 
 kernel/signal.c                                                           |   12 
 kernel/time/clockevents.c                                                 |   33 
 kernel/time/hrtimer.c                                                     |   15 
 kernel/time/tick-broadcast.c                                              |   36 
 kernel/time/tick-internal.h                                               |    2 
 kernel/trace/ftrace.c                                                     |    2 
 kernel/trace/ring_buffer.c                                                |  226 ++-
 kernel/trace/ring_buffer_benchmark.c                                      |    6 
 kernel/trace/trace.c                                                      |  150 +-
 kernel/trace/trace.h                                                      |   11 
 kernel/trace/trace_events.c                                               |    2 
 kernel/trace/trace_events_hist.c                                          |   86 -
 kernel/trace/trace_events_trigger.c                                       |    4 
 kernel/trace/trace_events_user.c                                          |   26 
 kernel/trace/trace_functions_graph.c                                      |    3 
 kernel/trace/trace_probe.c                                                |   48 
 kernel/trace/trace_probe.h                                                |    2 
 kernel/trace/trace_remote.c                                               |    6 
 kernel/workqueue.c                                                        |    3 
 lib/iov_iter.c                                                            |   18 
 mm/slub.c                                                                 |   20 
 net/bluetooth/hci_core.c                                                  |    4 
 net/bluetooth/hci_sysfs.c                                                 |   17 
 net/bluetooth/l2cap_core.c                                                |   33 
 net/bluetooth/msft.c                                                      |    2 
 net/bridge/br_cfm.c                                                       |   11 
 net/bridge/br_device.c                                                    |    1 
 net/bridge/br_input.c                                                     |   35 
 net/bridge/br_mrp.c                                                       |   13 
 net/bridge/br_multicast.c                                                 |    9 
 net/bridge/br_private.h                                                   |   26 
 net/core/dev.c                                                            |   27 
 net/core/gro_cells.c                                                      |    2 
 net/core/rtnetlink.c                                                      |    7 
 net/core/skbuff.c                                                         |    7 
 net/dsa/tag_brcm.c                                                        |    1 
 net/hsr/hsr_slave.c                                                       |   11 
 net/ieee802154/6lowpan/core.c                                             |    2 
 net/ipv4/fib_rules.c                                                      |    4 
 net/ipv4/igmp.c                                                           |  210 +--
 net/ipv4/inet_fragment.c                                                  |    6 
 net/ipv4/ip_output.c                                                      |    1 
 net/ipv4/ip_tunnel_core.c                                                 |    6 
 net/ipv4/ipmr.c                                                           |    3 
 net/ipv4/ipmr_base.c                                                      |    2 
 net/ipv4/nexthop.c                                                        |    2 
 net/ipv4/tcp.c                                                            |   14 
 net/ipv4/tcp_offload.c                                                    |   22 
 net/ipv4/tcp_output.c                                                     |    4 
 net/ipv4/tcp_timer.c                                                      |    6 
 net/ipv4/udp.c                                                            |    4 
 net/ipv6/exthdrs.c                                                        |    4 
 net/ipv6/ip6_fib.c                                                        |    4 
 net/ipv6/ip6_flowlabel.c                                                  |   19 
 net/ipv6/ip6_gre.c                                                        |    6 
 net/ipv6/ip6_output.c                                                     |    2 
 net/ipv6/ip6mr.c                                                          |    2 
 net/ipv6/mcast.c                                                          |  148 +-
 net/ipv6/netfilter/ip6_tables.c                                           |    5 
 net/ipv6/route.c                                                          |    9 
 net/ipv6/tcpv6_offload.c                                                  |   15 
 net/mac802154/ieee802154_i.h                                              |    8 
 net/mac802154/iface.c                                                     |    6 
 net/mac802154/main.c                                                      |    1 
 net/mac802154/rx.c                                                        |  120 +
 net/mac802154/scan.c                                                      |   10 
 net/mptcp/options.c                                                       |    8 
 net/mptcp/pm.c                                                            |   45 
 net/mptcp/pm_kernel.c                                                     |    8 
 net/mptcp/pm_userspace.c                                                  |   18 
 net/mptcp/protocol.c                                                      |   43 
 net/mptcp/protocol.h                                                      |   13 
 net/mptcp/subflow.c                                                       |   12 
 net/mptcp/syncookies.c                                                    |    5 
 net/netfilter/ipvs/ip_vs_sync.c                                           |   20 
 net/netfilter/nf_conntrack_netlink.c                                      |    2 
 net/netfilter/nf_conntrack_sip.c                                          |    2 
 net/netfilter/nf_log_syslog.c                                             |    2 
 net/netfilter/nfnetlink_cttimeout.c                                       |    2 
 net/netfilter/nfnetlink_log.c                                             |   15 
 net/netlink/genetlink.c                                                   |   21 
 net/openvswitch/flow.c                                                    |    4 
 net/openvswitch/flow_table.c                                              |    4 
 net/packet/af_packet.c                                                    |    5 
 net/rds/connection.c                                                      |   89 +
 net/rds/ib_recv.c                                                         |    9 
 net/rds/message.c                                                         |    4 
 net/rds/send.c                                                            |   14 
 net/rds/tcp.c                                                             |  101 +
 net/rds/tcp_listen.c                                                      |    6 
 net/sched/act_api.c                                                       |   46 
 net/sched/cls_api.c                                                       |    2 
 net/sched/cls_route.c                                                     |   76 -
 net/sched/cls_u32.c                                                       |   32 
 net/sched/sch_api.c                                                       |    2 
 net/sched/sch_drr.c                                                       |    3 
 net/sched/sch_dualpi2.c                                                   |   10 
 net/sched/sch_ets.c                                                       |   12 
 net/sched/sch_fq_pie.c                                                    |    3 
 net/sched/sch_generic.c                                                   |   20 
 net/sched/sch_hhf.c                                                       |    8 
 net/sched/sch_pie.c                                                       |    2 
 net/sched/sch_sfq.c                                                       |    7 
 net/sctp/sm_make_chunk.c                                                  |   14 
 net/sctp/sm_sideeffect.c                                                  |   11 
 net/tipc/link.c                                                           |    6 
 net/tipc/name_table.c                                                     |   30 
 net/unix/af_unix.c                                                        |   12 
 rust/bindings/lib.rs                                                      |    4 
 rust/kernel/num.rs                                                        |    9 
 rust/pin-init/src/lib.rs                                                  |    8 
 rust/uapi/lib.rs                                                          |    4 
 samples/rust/rust_print_main.rs                                           |    8 
 scripts/livepatch/init.c                                                  |    2 
 scripts/mksysmap                                                          |    4 
 scripts/sorttable.c                                                       |    2 
 security/landlock/fs.c                                                    |   18 
 sound/core/pcm_native.c                                                   |   35 
 sound/core/ump.c                                                          |    4 
 sound/drivers/dummy.c                                                     |    2 
 sound/hda/common/codec.c                                                  |    4 
 sound/hda/core/device.c                                                   |    5 
 sound/pci/ctxfi/cthw20k2.c                                                |    1 
 sound/soc/amd/acp-da7219-max98357a.c                                      |   23 
 sound/soc/amd/renoir/acp3x-pdm-dma.c                                      |    2 
 sound/soc/amd/yc/acp6x-pdm-dma.c                                          |    2 
 sound/soc/bcm/bcm63xx-i2s-whistler.c                                      |    1 
 sound/soc/codecs/ab8500-codec.c                                           |  684 +++-------
 sound/soc/codecs/cs35l56-i2c.c                                            |   10 
 sound/soc/codecs/cs35l56-sdw.c                                            |    6 
 sound/soc/codecs/cs35l56-spi.c                                            |   10 
 sound/soc/codecs/cs35l56.c                                                |  124 +
 sound/soc/codecs/cs35l56.h                                                |    4 
 sound/soc/codecs/mt6351.c                                                 |    1 
 sound/soc/fsl/fsl_micfil.c                                                |   21 
 sound/soc/intel/atom/sst/sst_pci.c                                        |    1 
 sound/soc/intel/avs/core.c                                                |   11 
 sound/soc/intel/avs/debugfs.c                                             |   12 
 sound/soc/intel/avs/path.c                                                |   11 
 sound/soc/intel/avs/pcm.c                                                 |   34 
 sound/soc/intel/avs/topology.c                                            |   49 
 sound/soc/intel/avs/topology.h                                            |    5 
 sound/soc/sprd/sprd-pcm-compress.c                                        |   15 
 sound/soc/sti/uniperif_reader.c                                           |    4 
 sound/soc/ux500/ux500_msp_dai.c                                           |  189 +-
 sound/soc/ux500/ux500_msp_dai.h                                           |   14 
 sound/soc/ux500/ux500_msp_i2s.c                                           |  264 ++-
 sound/soc/ux500/ux500_msp_i2s.h                                           |   12 
 sound/usb/caiaq/audio.c                                                   |   10 
 sound/usb/caiaq/device.c                                                  |   36 
 sound/usb/caiaq/device.h                                                  |    4 
 sound/usb/caiaq/midi.c                                                    |    6 
 sound/usb/usx2y/us122l.c                                                  |    7 
 sound/usb/usx2y/usbusx2y.c                                                |   10 
 sound/usb/usx2y/usbusx2y.h                                                |    4 
 tools/bootconfig/main.c                                                   |   13 
 tools/objtool/klp-checksum.c                                              |   21 
 tools/perf/util/powerpc-vpadtl.c                                          |    2 
 tools/perf/util/symbol.c                                                  |   11 
 tools/sched_ext/scx_central.bpf.c                                         |    6 
 tools/sched_ext/scx_flatcg.bpf.c                                          |    2 
 tools/testing/selftests/alsa/mixer-test.c                                 |    4 
 tools/testing/selftests/bpf/progs/test_bpf_nf.c                           |    8 
 tools/testing/selftests/bpf/progs/verifier_subprog_precision.c            |   12 
 tools/testing/selftests/cgroup/test_core.c                                |    2 
 tools/testing/selftests/cgroup/test_cpu.c                                 |    2 
 tools/testing/selftests/cgroup/test_cpuset.c                              |    2 
 tools/testing/selftests/cgroup/test_cpuset_prs.sh                         |    6 
 tools/testing/selftests/cgroup/test_freezer.c                             |    2 
 tools/testing/selftests/cgroup/test_kill.c                                |    2 
 tools/testing/selftests/cgroup/test_kmem.c                                |    4 
 tools/testing/selftests/cgroup/test_memcontrol.c                          |    2 
 tools/testing/selftests/cgroup/test_pids.c                                |    2 
 tools/testing/selftests/cgroup/test_zswap.c                               |    2 
 tools/testing/selftests/net/fib_nexthops.sh                               |   28 
 tools/testing/selftests/net/mptcp/mptcp_connect.c                         |    4 
 tools/testing/selftests/net/mptcp/mptcp_lib.sh                            |   26 
 tools/testing/selftests/net/pmtu.sh                                       |    2 
 tools/testing/selftests/net/test_vxlan_mdb.sh                             |    6 
 tools/testing/selftests/powerpc/tm/tm.h                                   |    8 
 tools/testing/selftests/ublk/Makefile                                     |    2 
 655 files changed, 9919 insertions(+), 5501 deletions(-)

Aamir Ahmed (1):
      net: hinic: fix mailbox segment buffer overflow

Aboorva Devarajan (1):
      powerpc/entry: Fix double accounting of user time on interrupt entry

Adrian Hunter (1):
      perf symbol: Do not use debug file as the binary type

Ahmed Naseef (1):
      net: dsa: mt7530: add EN7528 support

Akiva Goldberger (1):
      net/mlx5: LAG, use local tracker to update active ports

Aleksandr Nogikh (1):
      Bluetooth: hci_core: Fix race condition during device registration

Aleksei Sviridkin (5):
      net: macb: zero the link settings taprio reads back
      net: macb: reject an unknown link speed in the taprio setup
      net: phylink: initialise link_state before a forced major config
      net: dsa: mt7530: populate lpi_interfaces to fix EEE support
      net: ethernet: mtk_eth_soc: populate lpi_interfaces to fix EEE support

Alexander Graf (1):
      virtio_ring: fix stale descriptor flags after a failed packed add

Alexandra Winter (2):
      dibs: Unregister dibs_class after error
      s390/ism: folio_put() after error

Ali Ahmet Memis (4):
      ufs: do not treat unreadable directory blocks as empty
      hwmon: (nct6694) do not expose enable on DTIN temperature channels
      ufs: create the root dentry after loading cylinder metadata
      ufs: validate cylinder group metadata before caching it

Ali Ahmet Memiş (1):
      tracing: Don't dereference trace_event_file in deferred trigger free

Alice Mikityanska (3):
      net: ipv4: Fix UDP length overflow with PMTU discover and big MTU
      net: ipv6: Fix UDP length overflow with PMTU discover and big MTU
      net: ipv6: Clamp to IP6_MAX_MTU in ip6_dst_mtu_maybe_forward

Allison Henderson (5):
      net/rds: use wq_has_sleeper() in release_in_xmit()
      net/rds: use clear_bit_unlock() in release_refill()
      net/rds: clear cp_flags bits individually in rds_conn_path_reset()
      net/rds: acquire RDS_IN_XMIT in rds_tcp_reset_callbacks()
      net/rds: don't let rds_conn_shutdown() consume a concurrent drop

Andrea Parri (1):
      hrtimer: Use hard expiry when updating timers on the same base

Andrew Stellman (1):
      virtio-pci: return IRQ_HANDLED after non-zero ISR

Andy Chiu (1):
      riscv: hwprobe: initialize pair->value in hwprobe_one_pair()

Andy Shevchenko (2):
      smb: client: transport: Fix debug printing in __release_mid()
      thermal: sysfs: switch to use scnprintf() to suppress truncation warning

Antonin Godard (1):
      Documentation: hwmon: replace full-width colon by a standard ASCII colon

Anuj Gupta (1):
      xfs: release alleged child inode on metapath unlink error

Aohan Mei (1):
      smb: client: reject userspace cifs.idmap descriptions

Arda Doğu Ari (1):
      platform/x86: hp-wmi: Fix board_params typo for 8DD6 board

Arie Miller (3):
      hwmon: (asus_rog_ryujin) Add per-device configuration
      hwmon: (asus_rog_ryujin) Validate HID report lengths
      hwmon: (asus_rog_ryujin) Synchronize HID command and report handling

Armin Wolf (1):
      platform/x86: asus-laptop: Fix ACPI event handling

Arunpravin Paneer Selvam (1):
      drm/amdgpu: skip the VMID 0 flush for VRAM

Arvind Yadav (2):
      drm/pagemap: Prevent double migration of device pages
      drm/pagemap: Reset migration page count on eviction retry

Avi Weiss (1):
      btrfs: send: fix lost error return value in will_overwrite_ref()

Baolin Liu (9):
      ntfs: return DT_UNKNOWN on inode lookup failure in readdir
      ntfs: propagate reparse index insertion failure
      ntfs: return -ERANGE for undersized xattr buffer
      ntfs: preserve error code in ntfs_resident_attr_record_add()
      ntfs: return real error from ntfs_non_resident_attr_record_add()
      ntfs: fix kmap_local leak in write_mft_record_nolock() error paths
      ntfs: only count successfully cleared runs when freeing clusters
      ntfs: skip free cluster decrement when rollback fails
      ntfs: leave HasEA flag untouched on setxattr failure

Baul Lee (1):
      vxlan: mdb: Fix use-after-free in vxlan_mdb_remote_src_del()

Benjamin Leggett (1):
      drm/virtio: use the DMA API for resource backing on Xen

Binglei Wang (1):
      erofs: add missing buf->off in erofs_bread()

Bjoern Doebel (4):
      smb: client: fail DACL rewrite when the new DACL exceeds 64K
      smb: client: avoid leaking refcount in cifs_queue_oplock_break()
      smb: client: avoid leaking refcount when cifs_sb_tlink() fails
      smb: client: fix heap overflow in DACL owner/group rewrite

Breno Leitao (1):
      arm64: trans_pgd: clone only the linear map that exists at runtime

Carolina Jubran (4):
      net/mlx5e: Fix ETS zero BW reporting when one TC holds 100%
      net/mlx5e: Fix use-after-free race in sample_restore_put()
      net/mlx5e: Keep HW timestamp stats monotonic across reconfiguration
      net/mlx5e: Move representor vnic reporter to eswitch devlink port

Cen Zhang (Microsoft) (1):
      reboot: fix cad_pid use-after-free race

Cezary Rojewski (4):
      ASoC: Intel: avs: Clean up the bus when fetching ML caps fails
      ASoC: Intel: avs: Do not ignore -ENOENT when loading a topology
      ASoC: Intel: avs: Fix unbalanced module reference count
      ASoC: Intel: avs: Refactor and fix init_config access

Chaitanya Kumar Borah (1):
      drm/i915/dp_mst: Remove duplicate intel_pfit_compute_config() call

Chao Yu (2):
      f2fs: fix to shrink gc_lock coverage in f2fs_gc_range()
      f2fs: fix to reset all pinned status during fggc

ChenXiaoSong (1):
      smb/server: cancel async requests when closing connection

Chengfeng Ye (3):
      netfilter: cttimeout: prevent UAF during module unload
      netfilter: nf_log: unregister loggers before per-net teardown
      afs: Clear stale peer app data after address list changes

Chengyu Zhu (1):
      erofs: delimit inode_share cache key components

Ciprian Regus (3):
      net: ethernet: oa_tc6: Handle the OA TC6 SPI protected mode
      net: ethernet: oa_tc6: Export standard defined registers
      net: ethernet: oa_tc6: Add the OA_TC6_ prefix to standard registers

Colin Ian King (1):
      OPP: of: Fix potential multiplication overflow when calculating freq

Cong Nguyen (2):
      hwmon: (gpio-fan) take fan_data->lock in gpio_fan_shutdown()
      hwmon: (applesmc) fix key backlight workqueue leak on register failure

Daeho Jeong (1):
      f2fs: accurately adjust free_sections during free_segment_range

Daehyeon Ko (1):
      exit: hold a reference to thread_pid across proc_flush_pid

Dan Carpenter (1):
      drm/virtio: Fix a NULL vs ERR_PTR() bug in virtio_gpu_user_framebuffer_create()

Dapeng Mi (2):
      perf/x86/intel: Correct pt_regs->flags update for PEBS path
      perf/x86/intel: Prevent drain_pebs() reentry

Darrick J. Wong (43):
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
      xfs: lock the healthmon when inserting unmount event
      xfs: fix xfs_rtrmapbt_mem_cursor for non-rmap filesystems
      xfs: fix unit conversions in per_binval computation
      xfs: fix under-reservation of blocks when repairing sf directories
      xfs: fix the rtrmap and rtrefcount _maxlevels_ondisk functions
      xfs: fix short ifork reaping computation in xreap_bmapi_binval
      xfs: fix rtrmap cross-referencing elision logic
      xfs: fix rtrefcount btree block counting in scrub
      xfs: fix replaying dirent removals into the temporary directory
      xfs: fix parent rec lookup initialization in xrep_metapath_unlink
      xfs: fix name string recording in slowpath pptr tracepoints
      xfs: fix media verification ioctl for internal rt volumes
      xfs: fix bnobt repair space reservation disposal failure
      xfs: fix backwards skipping logic in xrep_quota_block
      xfs: fix backwards mergeability logic in refcount scrubber
      xfs: don't stash removename operations with unknown ftype
      xfs: don't spin forever on zero-length dirents when salvaging them
      xfs: don't modify file attributes or poke fsnotify for dry runs
      xfs: don't leak new_bp if xfs_btree_bload_drop_buf fails
      xfs: don't leak dqacct if rhashtable insertion fails
      xfs: destroy seen inode bitmap when we fail to add a dirpath
      xfs: cross-reference the rtgroup superblock extent, not block
      xfs: count escaped corruption errors in scrub stats
      xfs: compute dquot checksum after resetting dd_lsn in repair
      xfs: check healthmon outbuffer space correctly
      xfs: bump lost_prev_errors if we lose even the healthmon lost event
      xfs: bail out on bitmap errors in xrep_agfl_fill
      xfs: always set xfs_healthmon::first_event when inserting at front of list
      xfs: advance the findparent inode scan cursor while holding ILOCK
      xfs: actually recover intended file sizes in xfs_xmi_item_recover_intent
      xfs: actually check internal-rtdev fields in the superblock

David Arcari (1):
      watchdog: fix hrtimer start when pretimeout is zero

David Carlier (2):
      ring-buffer: Check resize_disabled before publishing the new subbuf order
      ieee802154: hwsim: serialize pib updates to fix double-free

David Howells (12):
      netfs: Fix unbuffered/DIO write partial transfer error return
      netfs: Fix error vs transferred passed to ->ki_complete()
      netfs: Fix i_size update for partial transfer
      netfs: Fix subreq ref leak
      netfs: Fix readahead synchronisation issues by loading all folios upfront
      netfs: Mark folios with COPY_TO_CACHE whilst issuing subreqs
      netfs: Fix read progress reporting
      cachefiles: Fix potential UAF/KASAN warning
      block: Fix start and length check added to iov_iter_extract_bvecs()
      afs: Fix missing kunmap in afs_dir_search_bucket()
      afs: Fix double-unmap of directory block
      afs: Fix incorrect free in candidate cleanup in afs_lookup_server()

David Laight (1):
      tipc: Dont send random pad bytes in RESET/ACTIVATE messages

Dawid Osuchowski (1):
      accel/ivpu: Limit firmware log name prints to field size

Dennis Tighe (3):
      ntfs: do not mark the volume clean in sync_fs when errors were recorded
      ntfs: bound $AttrDef table walk to the loaded table size
      ntfs: reject invalid sectors_per_cluster in the boot sector

Diego Oliva (2):
      smb: client: reject short READ responses in CIFSSMBRead()
      smb: client: reject out-of-bounds DataOffset in CIFSSMBRead()

Dinh Nguyen (1):
      EDAC/altera: Use parent device for devres in altr_portb_setup()

Dmitry Torokhov (1):
      platform/x86: x86-android-tablets: hold device reference for secondary fwnode teardown

Dong Chenchen (1):
      net: iptunnel: fix stale transport header during tunnel decapsulation

Donggeun Yoo (14):
      regulator: pf1550: fix which regulator is notified
      net: phy: dp83867: handle the active-high LED polarity mode
      tracing: Fix memory corruption from the histogram stacktrace modifier
      tracing: Set the trace clock before registering the histogram trigger
      tracing: Fix memory corruption from a "STACKTRACE" histogram key
      tracing: Free histogram the var ref when its initialization fails
      tracing: Free histogram var refs regardless of how often they are referenced
      tracing: Free histogram the field rejected for a bad modifier
      tracing: Let histogram values keep the percent and graph modifiers
      tracing: Keep the entry count when the histogram stats allocation fails
      tracing: Take the reference before publishing the named histogram trigger
      tracing: Undo the registration when enabling the histogram trigger fails
      function_graph: Use the saved entry's size when reprinting it
      net: phy: dp83td510: handle the active-high LED polarity mode

Eduard Zingerman (13):
      bpf: check_cond_jmp_op(): properly infer if register is null
      bpf: don't downgrade half-dead scalar zero spills to STACK_ZERO
      bpf: backtrack_insn(): Handle ld_{abs,ind} subprog exit edge
      bpf: backtracking shouldn't clear outer frame R1-R5 for callbacks
      bpf: reject BPF_PSEUDO_FUNC reference to the main program
      bpf: zero extend the result of an arena 32-bit cmpxchg
      bpf: don't rewrite bpf_fastcall patterns entered by a jump
      bpf: Don't infer non-NULL from a pointer with an unbounded offset
      bpf: Don't resurrect a scalar id dropped by collect_linked_regs()
      bpf: Don't predict JMP32 pointer vs zero comparisons
      bpf: Mark the zero register precise for a register-form NULL check
      bpf: mark a NULL call argument precise
      bpf: propagate mark_chain_precision() errors out of loop_flag_is_zero()

Edward Adam Davis (2):
      netfs: break unbuffered write when netfs_alloc_subrequest() fails
      ALSA: caiaq: Decoupling ep1_in_urb in caiaq dev

Eelco Chaudron (1):
      openvswitch: fix wrong flag value in get_ipv6_ext_hdrs()

Eric Biggers (2):
      crypto: x86/aria - add missing vzeroupper in AVX2 code
      crypto: x86/aria - add missing vzeroupper in AVX-512 code

Eric Dumazet (16):
      net: icmp: avoid invalid transport header access in icmp_send tracepoint
      tcp: use GFP_ATOMIC in tcp_send_active_reset()
      igmp: convert struct ip_sf_list to RCU
      ipv6: mcast: fix RCU list diversion in ip6_mc_del1_src()
      ipv6: mcast: use copy-on-write RCU updates in ip6_mc_source()
      ipv6: mcast: fix delay calculation in igmp6_join_group()
      ipv6: mcast: use rcu_assign_pointer() for __rcu list updates
      ipv6: mcast: use jiffies_delta_to_clock_t() in igmp6_mc_seq_show()
      ip6_gre: check tunnel info before xmit in ip6gre_tunnel_xmit
      ipv6: sr: restore network header before routing and forwarding
      net: bonding: annotate lockless writes with WRITE_ONCE()
      bonding: alb: fix uninitialized transport header access in alb_determine_nd()
      locking/lockdep: Invalidate stale class_cache entries for zapped classes
      bonding: do not clear curr_active_slave prematurely when releasing all slaves
      bonding: use skb_cow_head() in bond_do_alb_xmit() and rlb_arp_xmit()
      vxlan: initialize _md in vxlan_xmit_one()

Eric Sandeen (1):
      xfs: fix reclaimed page accounting in xfs_buf_free

Esben Haabendal (1):
      drm/bridge: ti-sn65dsi83: Fix error handling in sn65dsi83_reset_work()

Ethan Nelson-Moore (1):
      ata: pata_legacy: remove documentation for removed module parameters

FAN YE (1):
      btrfs: zstd: fix lost wakeup when waiting for a workspace

Faicker Mo (1):
      net: net_failover: Fix the deadlock in net_failover_slave_name_change()

Fan Wu (3):
      ieee802154: cc2520: fix FIFOP work use-after-free
      hwmon: (gpio-fan) Fix use-after-free in alarm work
      smb: client: fix cifsFileInfo reference leak in deferred close

Fangyu Yu (3):
      iommu/riscv: Add command queue lock
      iommu/riscv: Serialize command queue publishing
      iommu/riscv: Avoid waiting on failed command enqueue

Fangzhi Zuo (1):
      drm/amd/display: Exit IPS before connector detection on resume

Filipe Manana (1):
      btrfs: fix unnecessary transaction commit fallback from btrfs_log_all_parents()

Florian Westphal (2):
      netfilter: nfnetlink_log: cope with concurrent instance destruction
      netfilter: ip6_tables: set F_PROTO when proto value is nonzero

Fourie Zhang (1):
      net: mpls: clear inner_protocol when the last label is popped

Gabriel Krisman Bertazi (2):
      io_uring/net: let io_recv_buf_select return the length of the buffer region
      io_uring/net: don't overconsume buffers when using MSG_TRUNC

Gang Yan (1):
      selftests: mptcp: fix an UAF in mptcp_connect.c

Gao Xiang (1):
      erofs: disable LZ4 rolling decompression for now

Gary Guo (7):
      rust: pin-init: use irrefutable pattern for `stack_pin_init`
      wifi: ath9k_htc: don't store usb_device_id
      media: as102: do not rely on id table address comparison
      usb: serial: spcp8x5: don't store usb_device_id
      net: usb: pegasus: don't rely on id table pointer arithmetic
      usb: xusbatm: don't rely on id table pointer arithmetic
      usb: usbtmc: don't store usb_device_id

Geert Uytterhoeven (1):
      hwmon: (ltc4282) Make sure clk_init_data is fully initialized

Gerd Rausch (1):
      net/rds: tcp: don't force RDS_CONN_RESETTING over a concurrent shutdown

Gongwei Li (1):
      Bluetooth: hci_mrvl: Fix wrong return value check of wait_on_bit_timeout()

Greg Kroah-Hartman (1):
      Linux 7.2.7

Greg Marsden (1):
      net/rds: fix tcp stream corruption with large pages

Griffin Kroah-Hartman (1):
      misc: amd-sbi: Add null check for devm_kasprintf()

Guanghui Yang (2):
      btrfs: detach failed sprout device from transaction update list
      btrfs: restore active device pointers after failed sprout

Guenter Roeck (4):
      Documentation/hwmon: Document hwmon_notify_event()
      hwmon: Fix potential UAF in pec_store
      hwmon: (sht4x) Add missing locks
      hwmon: (sht4x) Fix return value from heater_enable_store()

Guopeng Zhang (2):
      selftests/cgroup: Drop invalid boot isolation comparison
      cgroup/cpuset: Preserve boot-isolated CPUs on partition release

HW He (1):
      net: gro: Fix nesting of TCP GSO SKBs in skb_gro_receive_list()

Hans de Goede (1):
      platform/x86: x86-android-tablets: fix gpio_secondary_fwnode_init() not working

Haotian Zhang (1):
      media: v4l2-h264: Fix memcmp() size in B1 reference list comparison

Harald Freudenberger (8):
      s390/crypto: Fix skcipher_walk return code handling in aes_s390
      s390/crypto: Fix use of mutex in atomic context
      s390/crypto: Fix missing scrub of temp buffers with AES ctr and gcm algorithm
      s390/crypto: Fix missing cra_flags in paes_s390
      s390/crypto: Fix handling of EBUSY in PHMAC when req is pushed to crypto engine
      s390/crypto: Fix missing scrub of temp buffers with PAES algorithm
      s390/crypto: Fix wrong return code to engine in asynch callbacks
      s390/crypto: Map EBUSY to EIO when key conversion fails repeatedly

Harry Wentland (1):
      dm/amdgpu: fix malformed link_settings debugfs output

Harry Yoo (Meta) (1):
      mm/slab: take n->list_lock in __slab_try_return_freelist() to avoid race

Heikki Krogerus (2):
      i2c: designware: Global register definitions
      drm/xe/i2c: Fix the interrupt handling

Heiko Carstens (2):
      s390/time: Use jiffies instead of jiffies_64
      s390/pai: Reduce excessive debug feature size

Hemanth Selam (2):
      selftests/cgroup: set the test plan after the setup checks
      iommu/amd: Fix ineffective error check in nested domain allocation

Henry Martin (3):
      sctp: fix soft lockup from unpadded ASCONF-ACK parameter iteration
      tracing/probes: Fix use-after-free on field name/type of events with multiple probes
      tracing/user_events: Don't destroy fields when event removal fails

Hongfu Li (1):
      selftests/cgroup: Fix cg_run_in_subcgroups ignoring arg parameter

Hui Su (5):
      bpf: Fix BPF_F_CPU validation for sparse CPU IDs
      bpf: Fix percpu map update indexing with sparse CPU IDs
      staging: fbtft: make dirty_lock IRQ-safe
      sched: Account cgroup CPU time to the execution context
      sched/core: Call wq_worker_tick() for the execution context

Huiwen He (7):
      smb/client: validate new EOF for insert range
      smb/client: validate new EOF for zero range
      smb/client: mark file sparse before emulating insert range
      smb/client: fix data corruption in emulated insert range
      smb/client: fix integer truncation in collapse range
      smb/client: fix stale page cache in insert/collapse range
      smb/client: invalidate fscache for fallocate range operations

Hungyu Lin (1):
      media: qcom: iris: fix runtime PM reference leaks

HyeongJun An (3):
      ALSA: dummy: Report a change when one capture switch channel moves
      selftests/alsa: Fix the step check for INTEGER controls
      ALSA: hda: Report a change when only the channel status bytes move

Håkon Bugge (1):
      net/rds: acquire the fastpath locks in rds_conn_shutdown()

Ibrahim Hashimov (1):
      mac802154: fix use-after-free of sdata via queued RX frames

Ido Schimmel (2):
      nexthop: Initialize extack in remove_nh_grp_entry()
      tunnels: Drop stale dst when building an ICMP error for PMTUD

Igor Paunovic (2):
      drm/rockchip: dw_dp: Select DRM_BRIDGE_CONNECTOR
      drm/rockchip: rk3066_hdmi: Add missing Kconfig selects

Ilya Maximets (1):
      netfilter: report NLM_F_DUMP_FILTERED when all is filtered out

Ivan Hu (1):
      Bluetooth: btmtk: Declare MT7920 (MT7961 1a) Bluetooth firmware

Ivy Lopez (1):
      scsi: mpt3sas: Avoid out-of-bounds cpumask_of_node() call in _base_assign_reply_queues()

Jacob Keller (1):
      ice: add missing xa_destroy for sched_node_ids

Jad Keskes (1):
      EDAC/device_sysfs: Use kstrtouint() for poll_msec to prevent truncation

Jakub Kicinski (5):
      net: dsa: bcm_sf2: bound the CFP rule dump by the caller's buffer size
      eth: nfp: bound the ntuple rule dump by the caller's buffer size
      eth: nfp: drop the replaced rule from the list when reprogramming fails
      net: dsa: mv88e6xxx: bound the policy rule dump by the caller's buffer size
      eth: ice: don't dereference pointers from TP_printk()

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

Jann Horn (1):
      exec: do_close_on_exec() before taking exec_update_lock

Jared Kangas (4):
      hwmon: (ina2xx) Acquire hwmon_lock in shunt_resistor_show()
      hwmon: (ina2xx) Parameterize ina2xx_data in ina226_alert_read()
      hwmon: (ina2xx) Replace masks with enum in alert functions
      hwmon: (ina2xx) Decouple in0 and curr1 alarms

Jasjeet Rangi (1):
      x86/MCE/AMD: Fix inverted interrupt enablement during storm handling

Jason Andryuk (2):
      x86/amd_node: Avoid divide by zero on virtualized systems
      x86/amd_node: Fix potential NULL pointer dereference

Jason Winter (1):
      net: usb: cx82310_eth: drop URB after 0xffff reboot sentinel to prevent partial_data heap overflow

Javier Carrasco (1):
      hwmon: (chipcap2) fix channels in humidity alarm notifications

Javier Tia (2):
      xfs: initialise error in xfs_defer_finish_one()
      xfs: initialise args->total for parent pointer updates

Jeffin Philip (1):
      fs: autofs: fix memory leak in autofs_fill_super()

Jens Axboe (1):
      io_uring/rw: end write accounting from ->ki_complete

Jia Jia (4):
      virtio_console: do not free control-out buffers on remove
      vhost/vdpa: reject VRING_NUM larger than device max
      vduse: validate virtqueue alignment
      vhost: invalidate vring access on IOTLB transitions

Jiacheng Xu (1):
      workqueue: reject watchdog thresholds that overflow jiffies

Jiajia Liu (2):
      Bluetooth: btusb: mediatek: Fix leaked runtime PM reference in reset
      Bluetooth: btusb: Fix leaked runtime PM reference in btusb_reset

Jiayuan Chen (5):
      bpf: Fix REG INVARIANTS VIOLATION on speculative pointer arithmetic
      bpf: Reject key-less BTF for hash maps
      bpf: Fix NULL-ptr-deref when showing a void BTF type
      bpf: Fix NULL-ptr-deref in btf_var_show()
      selftests/bpf: Fix flaky bpf_nf test when random NAT port is 0

Jingbo Xu (1):
      erofs: add sysfs feature entry for xattr prefixes

Joas Antonio dos Santos (1):
      netfilter: nf_conntrack_sip: fix OOB read in sip_skip_whitespace()

Joe Damato (7):
      bnxt_en: Only restore LRO if the device supports TPA
      bnxt_en: Don't free the live ring's TPA state on queue restart failure
      bnxt_en: Handle buffer allocation failure in bnxt_rx_ring_reset()
      bnxt_en: Propagate RX ring init failures in bnxt_init_nic()
      bnxt_en: Propagate TPA buffer allocation failures in bnxt_queue_mem_alloc()
      bnxt_en: Bound SW TPA IDs to prevent crashes
      bnxt_en: Prevent queue stop with deferred completions

Johan Hovold (1):
      net: hso: fix TIOCMIWAIT race

Johannes Thumshirn (1):
      btrfs: zoned: finish active block group cleanup if call_zone_finish() fails

John Hubbard (1):
      rust: allow `clippy::as_underscore` in the generated bindings

John Ogness (1):
      printk/nbcon: Change nbcon_irq_work to IRQ_WORK_LAZY

Josh Poimboeuf (1):
      objtool/klp: Fix checksums for constant pool references

Joshua Hay (1):
      idpf: account for VLAN header when parsing RSC packet header

Justin Chen (2):
      net: bcmasp: clear txcb->last before writing each descriptor
      net: bcmasp: fix tx_spb_ring_full() checking same slot cnt times

Jérémy Jean (1):
      ftrace: fork: Initialize function graph state before copy_exec_state()

Kalpan Jani (1):
      mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0

Kanchan Joshi (2):
      nvme: set ns->head in nvme_alloc_ns_head
      nvme: fix racy access to FDP placement id array

Karl Mehltretter (8):
      iommu/amd: Do not reallocate GA log buffers on resume
      virtio: fix use-after-free in unregister_virtio_device()
      virtio_input: stop callbacks before unregistering input device
      drm/adp: Drop the select of the nonexistent CONFIG_DRM_KMS_DMA_HELPER
      drm/logicvc: Drop the select of the nonexistent CONFIG_DRM_KMS_DMA_HELPER
      tracing: Fix ring_buffer_read_page_size() kernel-doc
      netfs: Fix uninitialized return value in netfs_unbuffered_write()
      smb: client: pin DFS superblock in iterator callback

Kazuki Hanai (1):
      ALSA: us122l: Prevent write upgrades for read mappings

Keith Busch (1):
      block: save page offset gaps in cloned bio

Kevin Wang (1):
      drm/amd/pm: fix gpu metrics energy accumulator for smu 13.0.0/13.0.7

Kiran K (3):
      Bluetooth: btintel_pcie: Clear automask on spurious interrupts
      Bluetooth: btintel_pcie: validate packet_len before skb_put_data
      Bluetooth: btintel_pcie: fix tx_handle bounds off-by-one

Kiran Kumar K (1):
      octeontx2-af: fix CN20K default MCAM rule removal on port cleanup

Krystian Kaniewski (1):
      Bluetooth: hci_sysfs: Fix NULL pointer dereference in device_del()

Kumar Kartikeya Dwivedi (14):
      bpf: Mark signal tracepoint siginfo arguments as scalar
      bpf: Reject tail calls directly from callback frames
      bpf: Reject resilient lock operations in rbtree callbacks
      bpf: Mark sched_process_wait argument as nullable
      bpf: Mark syscall helpers as sleepable
      bpf: Track verifier instruction stats for each subprogram
      bpf: Check ancestor frames for rbtree callbacks
      bpf: Mark bpf_btf_find_by_name_kind() as sleepable
      bpf: Mark faultable stack helpers as sleepable
      bpf: Reject legacy packet loads from callbacks
      bpf: Require MEM_PERCPU for percpu kptr stores
      bpf: Mark NULL kptr stores precise
      bpf: Preserve inner map identity in callback frames
      bpf: Reject non-scalar bpf_loop iteration counts

Kuniyuki Iwashima (5):
      af_packet: Don't cast tpacket_hdr.tp_len to int in tpacket_parse_header().
      net: Remove conflicting altnames for dying netns in __dev_change_net_namespace().
      af_unix: Update last skb marker in manage_oob().
      af_unix: Return immediately when manage_oob() returns NULL for 0-length buffer.
      net/sched: cls_api: Don't replay RTM_GETCHAIN in tc_ctl_chain().

Kyle Zeng (2):
      ipvs: fix reversed sequence option serialization
      ipvs: reject invalid states in connection template sync records

Lama Kayal (1):
      net/mlx5: E-Switch, prevent mc_list repopulation during vport disable

Laxman Acharya Padhya (4):
      wifi: mt76: mt7921: validate CLC firmware records
      wifi: mt76: mt7921: skip unknown CLC firmware records
      Bluetooth: btintel: validate version TLV value lengths
      Bluetooth: btintel: bound firmware ID by TLV length

Leo Yan (1):
      perf/core: Skip empty AUX records with only format flags

Leon Hwang (1):
      ftrace: Use rcu_assign_pointer() for tmp_ops filter hash

Leonardo Costa (1):
      drm/bridge: tc358768: Enforce input bus flags via atomic_check

Li Youhong (1):
      net: sun4i-emac: fix missing of_node_put() for phy_node

Liang Luo (1):
      sched_ext: Fix nonexistent field in sched-ext.rst example

Lin Jiapeng (1):
      xfs: fix exchange-range reflink flag clearing issue with INO1_WRITTEN

Linfeng Sun (3):
      vdpa_sim_blk: reject out-of-range sector starts
      vdpa_sim_net: check TX pull result before RX copy
      vduse: return compat ioctl results directly

Linmao Li (2):
      hwmon: (corsair-cpro) Create debugfs entries after hwmon registration
      hwmon: (corsair-cpro) Remove debugfs entries when probe fails

Linus Walleij (21):
      ASoC: ab8500: Reset the audio block before configuring it
      ASoC: ab8500: Repair the DAPM capture graph
      ASoC: ab8500: Correct digital interface format setup
      ASoC: ab8500: Validate and program TDM slots correctly
      ASoC: ab8500: Remove the nonfunctional sidetone apply control
      ASoC: ab8500: Skip missing DMIC GPIOs on AB8505
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
      net: ethernet: cortina: Count RX drops once per frame
      net: ethernet: cortina: Count RX descriptors for freeq refill

Lizhi Hou (2):
      accel/amdxdna: Remove __counted_by from struct amdxdna_cmd_chain
      accel/amdxdna: Disable device buffer exporting

Long Li (2):
      net: mana: Clear RDMA teardown and suspend state in mana_rdma_probe()
      net: mana: restore the XDP program pointer when pre-allocation fails

Lorenzo Bianconi (5):
      net: stmmac: fix dma mapping leak in stmmac_tso_xmit()
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

Lu Yao (1):
      drm/xe/oa: Remove sysfs entry on idr_alloc failure in xe_oa_add_config_ioctl()

Luiz Augusto von Dentz (1):
      Bluetooth: btusb: Fix UAF of btusb_data by rx_work

MD Danish Anwar (1):
      net: hsr: enable promiscuous mode on interlink port with fwd offload

Magdalena Schulfer (2):
      accel/ivpu: Validate full buffer range in ivpu_to_cpu_addr
      accel/ivpu: Validate firmware log buffer metadata

Mahmoud Nagy Adam (1):
      selftests: ublk: install test_common.sh and trace/ scripts

Manuel Fombuena (1):
      leds: st1202: Validate pattern input before stopping the sequence

Marek Vasut (1):
      net: ks8851: Fix receiver error in 100BASE-TX mode following software power-down

Mario Limonciello (1):
      x86/itmt: Don't make ITMT enablement depend on debugfs

Masami Hiramatsu (Google) (3):
      tracing: Fix to avoid creating trace instances with duplicate names
      tools/bootconfig: Fix integer overflow and truncation in size checks
      bootconfig: Fix integer overflow in initrd size check

Matthieu Baerts (NGI0) (7):
      mptcp: options: handle MPC data + csum reqd + no csum
      mptcp: subflow: no need to copy thmac during ulp_clone
      mptcp: syncookies: remember the request backup flag
      mptcp: options: fix uninit-value in mptcp_write_data_fin
      selftests: mptcp: lib: dump nstat for the right test
      selftests: mptcp: lib: get counters for the right test
      mptcp: pm: reset retrans_time when ADD_ADDR entry is reused

Maurizio Lombardi (1):
      scsi: target: iscsi: Fix hang for aborted WRITE_PENDING commands

Mehmet Koseoglu (1):
      rust: samples: add missing newlines in rust_print_main

Michael Bommarito (8):
      media: hevc: add bounded tile-count helpers
      media: verisilicon: hantro: bound G2 HEVC tile loop to the buffer capacity
      media: rkvdec: bound HEVC tile loops and PPS id to the array capacity
      media: mediatek: vcodec: bound AV1 tile-start copy to the array capacity
      media: verisilicon: rockchip: guard VPU981 AV1 divisor and tile buffer
      media: verisilicon: rockchip: reject AV1 frames exceeding the tile capacity
      media: v4l2-ctrls: validate HEVC tile counts
      media: v4l2-ctrls: validate AV1 tile counts

Miguel Ojeda (2):
      rust: allow `unknown_lints` in generated bindings for Rust < 1.88
      drm/panic: clean new `clippy::needless_range_loop` lint for Rust 1.100.0

Mike Rapoport (Microsoft) (1):
      x86/mm/pat: Don't gate cpa_lock on debug_pagealloc_enabled()

Mikhail Zaslonko (1):
      s390/debug: Fix NULL pointer dereference in debug_set_level()

Miklos Szeredi (1):
      ovl: return EINVAL instead of EIO in case of mismatched user_ns

Milan P. Gandhi (2):
      scsi: mpi3mr: Fix NULL pointer dereference in mpi3mr_sas_port_add()
      scsi: mpi3mr: Fix target device refcount leak in mpi3mr_sas_port_add()

Mitul Golani (1):
      drm/i915/dp: Gate UHBR SST SDP splitting on sink capability

Mohamed Khalfella (3):
      nvme: remove stale namespaces by NSID range during scan
      nvme: print namespace IDs as unsigned 32bit value
      nvmet: print namespace IDs as unsigned 32bit value

Moritz Tanner (1):
      fs: don't return -EINVAL for successful nested thaw

Mukesh Kumar Chaurasiya (IBM) (1):
      powerpc/entry: Fix irq_soft_mask corruption on replayed interrupt exit

Myeonghun Pak (1):
      idpf: disable DIM work before freeing q_vectors

Nagamani PV (1):
      s390/qeth: allow bridgeport queries despite OS_MISMATCH

Naman Gulati (1):
      ipv6: null-check fib6_node before accessing in __ip6_del_rt_siblings()

Namjae Jeon (5):
      ksmbd: safely drain sessions during logoff
      ksmbd: propagate DACL parsing errors
      ksmbd: rate limit unmapped SID errors
      ksmbd: fix listener task lifetime on netdev events
      ksmbd: fix sparc build with atomic work state

Nathan Chancellor (1):
      scripts/sorttable: Mark long_size as __maybe_unused

Nicolai Buchwitz (3):
      net: macb: exclude software FCS from TX byte statistics
      net: macb: destroy the phylink instance on the probe error path
      net: macb: put the "mdio" child node reference on success

Nikhil Gurudasani (2):
      erofs: preserve LZMA decoders on resize failure
      hwmon: (mcp9982) Propagate one-shot polling errors

Nikhil P. Rao (3):
      ionic: use netif_txq_maybe_stop() in ionic_tx()
      pds_core: fix cmd_regs access racing BAR unmap on reset
      pds_core: don't release PCI regions for VFs on reset

Niklas Schnelle (1):
      iommu/s390: Fix NULL dereference in iova_to_phys() with ZPCI_TABLE_TYPE_RFX

Nikolay Aleksandrov (1):
      net: bridge: mcast: properly convert mglist to rcu

Nilay Shroff (1):
      nvme: add context annotations for nvme_subsystem::lock

Nilesh Javali (13):
      scsi: qla2xxx: Fix queue teardown NULL dma_free and bitmap locking
      scsi: qla2xxx: Fix use-after-free of qpair work on queue teardown
      scsi: qla2xxx: Bound VP index against VP_CTRL IOCB bitmap size
      scsi: qla2xxx: Use ring-slot helpers in __qla2x00_alloc_iocbs
      scsi: qla2xxx: Use memset_io() to clear QLAFX00 request ring slot
      scsi: qla2xxx: Null out freed pointers in qla2x00_mem_alloc() error path
      scsi: qla2xxx: Fix 64G link speed reporting in get_data_rate
      scsi: qla2xxx: Skip vport under deletion in report ID acquisition
      scsi: qla2xxx: Fix soft lockup polling continuation IOCB signature
      scsi: qla2xxx: Clamp max_npiv_vports to VP_CTRL bitmap capacity
      scsi: qla2xxx: Validate BSG request_len before reading vendor_cmd[]
      scsi: qla2xxx: Unlink NVMe unsol ctx before freeing on LS reject error
      scsi: qla2xxx: Serialize NVMe unsol ctx list with a per-fcport lock

Ning Ding (2):
      bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
      bpf: Reject untrusted allocated-object pointers

Norbert Szetei (3):
      nstree: check listing permission before taking a namespace reference
      net: openvswitch: fix use-after-free of the flow table mask array
      landlock: Fix use-after-free of the source's parent directory

Nuoqi Gui (1):
      bpf: Cancel special fields when recycling rhtab elements

Paolo Abeni (7):
      mptcp: remove unneeded READ_ONCE() annotation
      mptcp: do not reschedule the RTX timer for fallback sockets
      mptcp: prevent race between disconnect() and rtx
      mptcp: move the stale logic out of retrans scheduler
      mptcp: avoid unneeded actions on subflow reset
      mptcp: close race between scheduler and state change
      mptcp: fix bad accounting in __mptcp_subflow_push_pending()

Pauli Virtanen (3):
      Bluetooth: L2CAP: fix chan mode for LE_CONN_REQ + EXT_FLOWCTL pchan
      Bluetooth: L2CAP: fix out-of-bounds write in l2cap_ecred_connect
      Bluetooth: L2CAP: clear FLAG_DEFER_SETUP only for same PID/PSM

Paulo Alcantara (8):
      smb: client: honor forceuid/forcegid when mapping SIDs to uid/gid
      smb: client: fix WSL reparse point uid/gid override
      smb: client: fix uid/gid override in getattr with posix extensions
      smb: client: fix one-byte OOB read in smb2_parse_native_symlink()
      smb: client: fix file type corruption in cifs_reparse_point_to_fattr()
      smb: client: fix file type corruption in posix_reparse_to_fattr()
      smb: client: fix file type corruption in wsl_to_fattr()
      smb: client: avoid using uninitialized SIDs in cifs_posix_to_fattr()

Pedro Falcato (1):
      x86/alternatives: Exclude text poking against change_page_attr()

Pengpeng Hou (1):
      hwmon: (aspeed-pwm-tacho) Propagate reset deassert errors

Peter Zijlstra (1):
      x86/mm: Fix and document DEBUG_PAGEALLOC

Prike Liang (1):
      drm/amdgpu: skip gfx switch_power_profile during GPU reset

Qing Luo (1):
      mptcp: pm: userspace: fix address ID overflow

Qingfang Deng (3):
      ppp: ppp_async: simplify tty disc_data access
      ppp: ppp_synctty: simplify tty disc_data access
      ppp_synctty: ensure a writeable skb header

Qingyu Zhang (1):
      ALSA: ump: do not touch legacy_rmidi before it exists

Qiuxu Zhuo (4):
      EDAC/igen6: Fix interleave boundary condition
      EDAC/igen6: Fix channel selection hash
      EDAC/igen6: Fix channel address decode for non-hash mode
      EDAC/igen6: Fix Raptor Lake-P logged error address

Qu Wenruo (3):
      btrfs: fix the possible bioc_list memory leak during error
      btrfs: return proper negative error code for update_raid_extent_item()
      btrfs: do not force reloc root creation during qgroup_account_snapshot()

Radhey Kalra (1):
      platform/x86: hp-wmi: Introduce board-specific feature data

Randy Dunlap (1):
      dma-buf: fix some kernel-doc warnings

Ratheesh Kannoth (2):
      octeontx2-pf: reset HTB scheduler topology before freeing queues
      octeontx2-af: fix PF/CGX debugfs PCI bus lookup

Richard Fitzgerald (3):
      ASoC: cs35l56: Request IRQ in cs35l56_common_probe()
      ASoC: cs35l56: Fix probe deadlock waiting for SoundWire enumeration
      ASoC: cs35l56: Fix race between kexec and snd_soc_register_component()

Ritesh Harjani (IBM) (2):
      powerpc: Don't drop _TIF_RESTOREALL on syscall restart
      powerpc: Do not restore KUAP in arch_exit_to_user_mode_prepare()

Rob Herring (Arm) (5):
      accel: ethosu: Fix ethosu_job_open() return value
      accel: ethosu: Drop IRQF_SHARED flag
      accel: ethosu: Ensure cmd stream ends with a stop op
      accel: ethosu: Ensure SRAM size is 0 on mapping failure
      accel: ethosu: Ensure SRAM region size matches job

Roman Prucha (1):
      ALSA: ctxfi: Fix CA20K2 S/PDIF passthrough

Rong Zhang (2):
      Bluetooth: Properly disable remote wakeup for MT7922/MT7925 on Ryzen platform
      Bluetooth: btrtl: Don't leak return code when parsing firmware format v2

Runyu Xiao (3):
      ASoC: sti: initialize IRQ lock before requesting IRQ
      cpufreq: initialize policy rwsem before sysfs publication
      net: macb: initialize PTP state before registering clock

Sahil Chandna (1):
      net: mana: Reserve extra CQ slot for the fence completion CQE

Sajal Gupta (1):
      drm/gud: validate GUD_ROTATION_0 is present in supported rotations

Samuel Holland (1):
      Revert "riscv: Reset pmm when PR_TAGGED_ADDR_ENABLE is not set"

Sang-Heon Jeon (1):
      media: remove conditional return with no effect

Sascha Bischoff (1):
      irqchip/gic-v5: Preserve ICC_CR0_EL1 state

Satyajit Roy (3):
      drm/amd/display: Rebuild InfoFrames on output color space changes
      drm/amd/display: Propagate HDMI RGB quantization selectability
      drm/amd/display: Honor Broadcast RGB for BT.2020 RGB output

Sebastian Andrzej Siewior (1):
      ring-buffer: Acquire the lock with irqsave in rb_wake_up_waiters()

Seiji Nishikawa (1):
      sched/rt,dl: Skip migrate-disabled tasks when picking a push candidate

Selvamani Rajagopal (4):
      net: ethernet: oa_tc6: Protect skb pointer used by two different kernel instances
      net: ethernet: oa_tc6: Improve the error recovery
      net: ethernet: oa_tc6: Disable tx queues on fatal error
      net: ethernet: oa_tc6: Fix for the wrong data type

Sergey Zagursky (1):
      media: ipu-bridge: do not use the CVS device lookup for IVSC

Seungwon Bae (1):
      vxlan: reject dynamic fdb entries that reference a nexthop id

Shahar Shitrit (3):
      net/mlx5e: Fix missing FEC mode mapping for RS_544_514_INTERLEAVED_QUAD
      net/mlx5e: Fix setting RS FEC after remapping
      net/mlx5e: Fix reporting support for all RS FEC variants

Shivaprasad G Bhat (2):
      powerpc/eeh: Fix recursive locking on devices without EEH sensitive driver
      powerpc: pci-ioda: Fix the stale irq chip reference

Shixiong Ou (1):
      drm/sched: Create a fake device for KUnit tests

Shuangpeng Bai (1):
      btrfs: fix transaction use-after-free in raid stripe insertion

Shubhang Kaushik (Ampere) (1):
      sched/core: Skip rq->avg_idle update without a valid idle_stamp

Slawomir Stepien (1):
      drm/cirrus-qemu: Validate BAR0 size during probe

Soheil Hassas Yeganeh (1):
      x86/cfi: Fix FineIBT hash offset in cfi_get_func_hash()

Steven Rostedt (3):
      ring-buffer: Add checking nr_subbufs to persistent ring buffer validation
      tracing: Fix comment in tracing_buffers_splice_read()
      tracing: Take trace_array reference when opening a tracer options file

Stian Halseth (1):
      sunvdc: unmap LDC cookies when the descriptor send fails

Sumanth Korikkar (1):
      s390/diag324: Preserve -EBUSY return code

Sunil Goutham (1):
      octeontx2-af: Fix limiting SRIOV VF count logic

Sunil Khatri (1):
      drm/drm_exec: fix up contended obj when num_objects is 0

Taimuraz Kaitmazov (3):
      accel/amdxdna: reject a command chain that carries no commands
      accel/amdxdna: put the chained BO when its mapping fails
      accel/amdxdna: refuse to flush an imported BO

Takashi Iwai (1):
      ALSA: caiaq: Fix potential double-free at error path

Taylor Bates (1):
      mlxsw: spectrum_ptp: Fix napi_gro_receive() call from GC workqueue context

Tejun Heo (1):
      sched_ext: Fix spurious aborts in scx_bpf_dsq_move() on ownership change races

Tetsuo Handa (1):
      printk: Don't WARN on kthread_run failure.

Thibault Ferrante (1):
      selftests/powerpc/tm: Fix tcheck() reading uninitialised CR value

Thomas Gleixner (1):
      tick/broadcast: Plug clockevents replacement race

Thomas Hellström (1):
      drm/xe: Flush LSC untyped L1 dataport cache after rcs/ccs batches

Thomas Richter (4):
      perf/core: Allow list_del during perf_event_overflow()
      s390/pai: Use PAI PMU index as parameter replacing event
      s390/pai: Move locking to event init and delete
      s390/pai: Support CPU hotplug for PMU PAI

Thomas Weißschuh (1):
      tracing: Restore :mod: trailer after parsing in ftrace_set_clr_event()

Thorsten Blum (4):
      powerpc/kexec_file: Use inclusive range checks in add_usable_mem()
      powerpc/kexec_file: Use inclusive range checks for excluded memory
      powerpc/ps3: Fix repository.c build failure
      drm/i915: Fix memory leak in query_perf_config_list()

Théo Lebrun (1):
      net: macb: unify device pointer naming convention

Tianchu Chen (1):
      ASoC: sprd: validate compress buffer sizes against fixed allocations

Tomeu Vizoso (1):
      accel: ethosu: Don't read the U65 rounding mode as a storage mode

Tristan Madani (2):
      ALSA: usbusx2y: fix in04_last array size mismatch with in04_buf
      ALSA: usbusx2y: validate URB actual_length in interrupt callback

Tung Nguyen (1):
      tipc: fix NULL deref in tipc_named_node_up() on empty publication list

Tzung-Bi Shih (7):
      watchdog: msc313e: Fix NULL pointer dereference in PM callbacks
      watchdog: msc313e: Avoid division by zero
      watchdog: msc313e: Fix clock leak and spurious timer in settimeout()
      watchdog: msc313e: Enable clock before accessing hardware registers
      watchdog: msc313e: Fix spurious reset on suspend
      watchdog: msc313e: Fix undefined behavior
      watchdog: msc313e: Sync timeout value if WDT was running at boot

Varun Gupta (1):
      drm/xe: Guard page-fault worker with runtime PM check

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

Vernon Yang (1):
      x86/mm: Fix user-space data loss with MADV_FREE and THP

Victor Nogueira (6):
      net/sched: act_api: budget all shared attributes in notify skbs
      net/sched: act_api: size the RTM_GETACTION reply from the actions
      net/sched: act_api: fix skb sizing and action leak on reoffload delete
      net/sched: cls_route: free emptied bucket on filter move
      net/sched: cls_route: Reject handle aliasing
      net/sched: cls_route: Fix in-place replace

Ville Syrjälä (2):
      drm/i915/cdclk: Fix dg2_power_well_count() return type
      drm/i915/cdclk: Avoid spurious cdclk sanitization on PTL+

Vincent Donnefort (5):
      ring-buffer: Remove ring_buffer_per_cpu::mapped
      tracing: Fix subbuf resize races with trace_pipe_raw readers
      ring-buffer: Cap static ring buffer nr_pages
      tracing/remotes: Account for ring buffer page header in size calculation
      tracing/remotes: Catch nr_page_va overflow in ring_buffer_desc sizing

Vincent Guittot (2):
      sched/eevdf: Fix augmented max_slice
      sched/eevdf: Fix rb augmented with multi fields

Vineeth Karumanchi (1):
      net: macb: fix NULL pointer dereference on unbind with fixed-link

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

Wanwu Li (2):
      sched_ext: Fix timer pinning and return value in scx_central
      sched_ext: Fix vtime delta loss in scx_flatcg cgroup migration

Weiming Shi (3):
      net/sched: defer qdisc freeing after failed creation
      net: dsa: tag_brcm: legacy FCS: request needed tailroom
      fbdev: vfb: defer cleanup until the last reference

Wentao Guan (2):
      iommu/arm-smmu-v3: Disable implementations during devm teardown
      ntfs: treat any nonzero dio zero-range return as an error

Xin Long (1):
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

Xu Rao (2):
      ALSA: hda: restore MFG widget enumeration after core split
      Bluetooth: btqcomsmd: destroy RPMsg endpoints before freeing hci_dev

Xuanqiang Luo (2):
      raw: annotate disconnect-side IPv4 match writers
      net/sched: act_api: release all action references on NEWACTION failure

Yael Chemla (1):
      net/mlx5: E-Switch: fix use-after-free in mlx5_eswitch_termtbl_put

Yafang Shao (1):
      klp-build: Fix wrong index in funcs cleanup error path

Yang Xiuwei (1):
      ublk: clear force_abort in ublk_queue_reset_io_flags()

Yazen Ghannam (2):
      RAS/AMD/ATL, EDAC/amd64: Only load ATL when needed
      x86/amd_node: Fix PCI device reference counting in amd_smn_init()

Yilin Zhang (2):
      ALSA: pcm: Serialize PCM mmap with buffer reallocation to fix page UAF
      inet: frags: invalidate queues before flushing them

Yogesh Mohan Marimuthu (1):
      drm/amdgpu/userq: fix struct drm_amdgpu_info_device padding for 32bit compile

Yorick Rommers (1):
      ASoC: amd: acp-da7219-max98357a: don't bind on Raven/Picasso boards

Younes Akhouayri (1):
      rust: num: seal Integer

Youssef Samir (1):
      accel/qaic: Address potential out-of-bounds read in resp_worker()

Yu Zhang (2):
      vhost-vdpa: don't install the eventfd_ctx_fdget() error in config_ctx
      vhost-vdpa: protect config_ctx from being freed under the config callback

Yuan Chen (1):
      bpf: Preserve special fields in recycled rhtab elements

Yudi Yang (1):
      drm/rockchip: analogix_dp: fix unchecked bound endpoint name length

Zhiling Zou (3):
      net: bridge: use option bits for CFM/MRP frame handlers
      ieee802154: 6lowpan: fix NULL dereference in lowpan_newlink
      ipv6: flowlabel: cap duplicate leases per socket

Zhongqiu Han (1):
      cpufreq: zero-initialize policy cpumask before sysfs publication

Zihan Xi (3):
      ipv6: fix fib6 walker UAF on seq stop
      ipmr: account multicast table and route memory
      ipv4: fib: bound automatic table ID allocation

bui duc phuc (1):
      ASoC: codecs: ab8500: Use guard() for mutex locks

hanzhijian (1):
      hwmon: (yogafan) fix non-kernel-doc comment

hpp.iscas (3):
      ASoC: bcm: bcm63xx: Publish the OF module aliases
      ASoC: Intel: SST: Publish the PCI module aliases
      ASoC: mt6351: Publish the OF module alias

leixiang (1):
      KVM: PPC: Book3S HV: Set irqfd->producer only on success

sangram kumar yerra (2):
      scsi: ufs: ufs-pci: Add support for Intel UFS 4.0 HS-Gear5
      scsi: ufs: ufs-pci: Add MCQ support for Intel UFS 4.0 controllers

wangdicheng (2):
      ASoC: amd: renoir: fix disable_pdm_interrupts() to clear mask bits
      ASoC: amd: yc: fix memory leak in acp6x_pdm_dma_close()

Ștefan Ghețu (1):
      ASoC: fsl_micfil: balance mclk enable/disable

