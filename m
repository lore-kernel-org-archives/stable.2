Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AFD379C42;
	Fri, 19 Jun 2026 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781871049; cv=none; b=TuPkap4tSd55GdxuHE0h3uHDgaVfdmp2Ezd8Gurnzyz8d2DDarbdvrj+OlMiZ13uWVnnL7IHn9GPbL7TRuzvzNoNYLsvhu2j/q2LdsNHKp7FSF1rOAZyrIum97ZcCo4ve5xBqxsjy+LJ9aRyKSjF708SJVafW6+rKDs+32bf92I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781871049; c=relaxed/simple;
	bh=pdq5whwVlsqbA9/RoeBWcLI0VXNayIWIaFPaTd6kw/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gQHR75oNEuvbxmEW1k96XtwAiEjHdBNjSQ1SzUtSPih7Llmf6xQHhFMUOZklwAWB4z/uoZ/mmjsWSke8YIqJKbQ+nL3YVqxBfsgxjOl2hw1AIG3a3L2beHkQnwRNF93I2OxLoBQ4XgwsbvavzSQ/PWDB9rrADxRPqK5+WYgynxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QcF5aYEO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QcF5aYEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5101F00A3A;
	Fri, 19 Jun 2026 12:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781871047;
	bh=oLf4htMQaXRFzGzVZyux1kSj6LwS68jKzdkMxdlAmcg=;
	h=From:To:Cc:Subject:Date;
	b=QcF5aYEO4SImH1cmcJbvC3jHUn5b3FHB0dFQrwZX1yPuHGJAxbDhz1BniCNaIfprE
	 dJdMJ5+/TvW9FozBy4LPegnrJSrmpXnW/9zJ2rus+Sa/fvjVeIakFer1FeV4Z2UDiT
	 YoVuQRhf8OEgzLZWu83jowIaZKf8TgVNYuJTLuxE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.36
Date: Fri, 19 Jun 2026 14:09:32 +0200
Message-ID: <2026061933-uproar-snarl-100e@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.36 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-fs-erofs                                |   14 -
 Documentation/arch/arm64/silicon-errata.rst                             |   46 +++
 Makefile                                                                |    5 
 arch/arm/Kconfig                                                        |    2 
 arch/arm/boot/dts/microchip/sam9x7.dtsi                                 |    6 
 arch/arm/include/asm/io.h                                               |   15 -
 arch/arm/kernel/entry-armv.S                                            |    2 
 arch/arm/mach-socfpga/platsmp.c                                         |    1 
 arch/arm/mm/alignment.c                                                 |    6 
 arch/arm/mm/fault.c                                                     |  100 +++++--
 arch/arm64/Kconfig                                                      |   38 ++
 arch/arm64/Makefile                                                     |    3 
 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi                             |    7 
 arch/arm64/include/asm/cputype.h                                        |    4 
 arch/arm64/kernel/cpu_errata.c                                          |   34 ++
 arch/arm64/kvm/at.c                                                     |    6 
 arch/arm64/kvm/hyp/include/hyp/switch.h                                 |    2 
 arch/arm64/mm/mmu.c                                                     |    1 
 arch/x86/Makefile                                                       |    4 
 arch/x86/Makefile.um                                                    |    8 
 arch/x86/kvm/svm/sev.c                                                  |   27 +
 arch/x86/kvm/vmx/vmx.c                                                  |    9 
 arch/x86/kvm/x86.c                                                      |    7 
 block/blk-zoned.c                                                       |   32 +-
 drivers/accel/amdxdna/aie2_ctx.c                                        |    3 
 drivers/accel/ivpu/ivpu_fw_log.c                                        |    5 
 drivers/accel/ivpu/ivpu_ipc.c                                           |    2 
 drivers/accel/ivpu/ivpu_ms.c                                            |    7 
 drivers/base/bus.c                                                      |   11 
 drivers/block/zram/zram_drv.c                                           |    2 
 drivers/clk/qcom/dispcc-sc8280xp.c                                      |    4 
 drivers/clk/qcom/dispcc-x1e80100.c                                      |    2 
 drivers/clk/samsung/clk-gs101.c                                         |    2 
 drivers/cpufreq/amd-pstate.h                                            |    1 
 drivers/firmware/samsung/exynos-acpm.c                                  |   13 
 drivers/gpio/gpio-mvebu.c                                               |    4 
 drivers/gpio/gpio-rockchip.c                                            |    4 
 drivers/gpio/gpio-zynq.c                                                |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                                 |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c                                 |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c                   |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c                        |   49 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c               |    5 
 drivers/gpu/drm/amd/display/dc/basics/vector.c                          |    4 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c                       |   15 -
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c                      |   81 +++--
 drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h                |    5 
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h                            |    2 
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c                      |   10 
 drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c                |   10 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c                     |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c                    |   32 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                    |   32 +-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c                    |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c                    |    1 
 drivers/gpu/drm/drm_gem.c                                               |   75 ++---
 drivers/gpu/drm/drm_ioctl.c                                             |    3 
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c                                 |    5 
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c                             |   15 -
 drivers/gpu/drm/i915/display/intel_dp.c                                 |   11 
 drivers/gpu/drm/i915/gem/i915_gem_phys.c                                |   19 +
 drivers/gpu/drm/imx/dcss/dcss-scaler.c                                  |    3 
 drivers/gpu/drm/v3d/v3d_gem.c                                           |    8 
 drivers/gpu/drm/v3d/v3d_perfmon.c                                       |   24 +
 drivers/gpu/drm/v3d/v3d_sched.c                                         |   17 +
 drivers/gpu/drm/vc4/vc4_validate_shaders.c                              |   13 
 drivers/gpu/drm/virtio/virtgpu_drv.c                                    |    5 
 drivers/gpu/drm/virtio/virtgpu_submit.c                                 |    4 
 drivers/gpu/drm/xe/display/xe_display.c                                 |   11 
 drivers/gpu/drm/xe/xe_guc_submit.c                                      |    2 
 drivers/gpu/drm/xe/xe_range_fence.c                                     |    2 
 drivers/hv/channel_mgmt.c                                               |    1 
 drivers/hv/hyperv_vmbus.h                                               |    3 
 drivers/hv/vmbus_drv.c                                                  |   37 ++
 drivers/i2c/busses/i2c-imx-lpi2c.c                                      |   53 ++-
 drivers/i2c/busses/i2c-imx.c                                            |   15 -
 drivers/i2c/busses/i2c-qcom-cci.c                                       |    2 
 drivers/i2c/busses/i2c-stm32f7.c                                        |    6 
 drivers/i2c/busses/i2c-tegra.c                                          |   53 ++-
 drivers/i2c/i2c-dev.c                                                   |    9 
 drivers/infiniband/core/Makefile                                        |    2 
 drivers/infiniband/core/iter.c                                          |   43 +++
 drivers/infiniband/core/ucaps.c                                         |    8 
 drivers/infiniband/core/umem.c                                          |   16 +
 drivers/infiniband/core/umem_dmabuf.c                                   |   77 ++++-
 drivers/infiniband/core/uverbs_std_types_dmah.c                         |    5 
 drivers/infiniband/core/verbs.c                                         |   38 --
 drivers/infiniband/hw/bnxt_re/qplib_res.c                               |    2 
 drivers/infiniband/hw/cxgb4/mem.c                                       |    2 
 drivers/infiniband/hw/efa/efa_verbs.c                                   |    2 
 drivers/infiniband/hw/erdma/erdma_verbs.c                               |    2 
 drivers/infiniband/hw/hns/hns_roce_alloc.c                              |    2 
 drivers/infiniband/hw/hns/hns_roce_mr.c                                 |    4 
 drivers/infiniband/hw/ionic/ionic_ibdev.h                               |    2 
 drivers/infiniband/hw/irdma/main.h                                      |    2 
 drivers/infiniband/hw/irdma/verbs.c                                     |    4 
 drivers/infiniband/hw/mana/mana_ib.h                                    |    2 
 drivers/infiniband/hw/mlx4/mr.c                                         |    5 
 drivers/infiniband/hw/mlx5/mem.c                                        |    1 
 drivers/infiniband/hw/mlx5/mr.c                                         |    4 
 drivers/infiniband/hw/mlx5/umr.c                                        |    1 
 drivers/infiniband/hw/mthca/mthca_provider.c                            |    2 
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c                             |    2 
 drivers/infiniband/hw/qedr/verbs.c                                      |    2 
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h                               |    2 
 drivers/infiniband/sw/rxe/rxe_verbs.c                                   |    5 
 drivers/infiniband/ulp/isert/ib_isert.c                                 |    6 
 drivers/infiniband/ulp/srp/ib_srp.c                                     |   30 +-
 drivers/input/keyboard/atkbd.c                                          |   15 +
 drivers/iommu/dma-iommu.c                                               |   19 -
 drivers/md/dm-cache-policy-smq.c                                        |   12 
 drivers/misc/fastrpc.c                                                  |  107 ++++---
 drivers/mmc/core/mmc.c                                                  |    4 
 drivers/mmc/host/dw_mmc-rockchip.c                                      |   17 +
 drivers/mmc/host/litex_mmc.c                                            |   20 +
 drivers/mmc/host/renesas_sdhi_internal_dmac.c                           |    1 
 drivers/mmc/host/sdhci.c                                                |    1 
 drivers/net/bonding/bond_main.c                                         |    4 
 drivers/net/ethernet/airoha/airoha_eth.c                                |    5 
 drivers/net/ethernet/amazon/ena/ena_com.c                               |    5 
 drivers/net/ethernet/amd/pcnet32.c                                      |    4 
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c                      |   14 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                               |    2 
 drivers/net/ethernet/freescale/fec_main.c                               |    3 
 drivers/net/ethernet/ibm/emac/core.c                                    |    9 
 drivers/net/ethernet/intel/ice/ice_dpll.c                               |    2 
 drivers/net/ethernet/intel/idpf/idpf_ptp.c                              |    2 
 drivers/net/ethernet/marvell/mv643xx_eth.c                              |    2 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                         |   67 ++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                         |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                         |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c                     |   36 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c                  |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                    |    2 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                             |    2 
 drivers/net/ethernet/mellanox/mlx4/cq.c                                 |    9 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                           |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c                        |   10 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                       |   13 
 drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c                  |    5 
 drivers/net/ethernet/mellanox/mlx5/core/vport.c                         |   72 +++--
 drivers/net/ethernet/microchip/lan743x_main.c                           |   32 ++
 drivers/net/ethernet/microchip/lan743x_main.h                           |    1 
 drivers/net/ethernet/realtek/rtase/rtase_main.c                         |    7 
 drivers/net/ethernet/wangxun/libwx/wx_type.h                            |    4 
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c                          |  140 +++++-----
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h                          |    2 
 drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c                      |    5 
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c                         |   12 
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h                         |   13 
 drivers/net/hyperv/netvsc.c                                             |   19 +
 drivers/net/mctp/mctp-usb.c                                             |   28 +-
 drivers/net/phy/phy_device.c                                            |    6 
 drivers/net/phy/sfp.c                                                   |    1 
 drivers/net/tap.c                                                       |    2 
 drivers/net/tun.c                                                       |    1 
 drivers/net/usb/r8152.c                                                 |    7 
 drivers/net/vxlan/vxlan_vnifilter.c                                     |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                            |    6 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                           |   56 ++--
 drivers/nvmem/core.c                                                    |   12 
 drivers/nvmem/layouts/onie-tlv.c                                        |    3 
 drivers/pinctrl/pinctrl-mcp23s08_spi.c                                  |    6 
 drivers/pmdomain/imx/gpc.c                                              |    2 
 drivers/pmdomain/ti/ti_sci_pm_domains.c                                 |    2 
 drivers/ptp/ptp_vclock.c                                                |   14 -
 drivers/slimbus/qcom-ngd-ctrl.c                                         |  122 +++++---
 drivers/soc/qcom/ice.c                                                  |   57 +++-
 drivers/spi/spi-cadence-quadspi.c                                       |    5 
 drivers/spi/spi-rzv2h-rspi.c                                            |    3 
 drivers/staging/rtl8723bs/core/rtw_mlme.c                               |   10 
 drivers/tee/optee/supp.c                                                |  107 +++++--
 drivers/tee/qcomtee/core.c                                              |    6 
 drivers/tee/tee_shm.c                                                   |    2 
 drivers/thunderbolt/property.c                                          |    6 
 drivers/thunderbolt/xdomain.c                                           |   14 -
 drivers/usb/serial/io_ti.c                                              |   11 
 drivers/usb/serial/kl5kusb105.c                                         |    4 
 drivers/usb/serial/option.c                                             |    3 
 fs/erofs/internal.h                                                     |    5 
 fs/erofs/super.c                                                        |    3 
 fs/erofs/sysfs.c                                                        |    2 
 fs/erofs/zdata.c                                                        |   35 --
 fs/fcntl.c                                                              |    8 
 fs/fhandle.c                                                            |   16 +
 fs/fuse/dev.c                                                           |   13 
 fs/mount.h                                                              |   10 
 fs/namespace.c                                                          |    6 
 fs/qnx6/dir.c                                                           |    8 
 fs/smb/server/oplock.c                                                  |   15 -
 fs/smb/server/smb2pdu.c                                                 |   11 
 fs/xfs/scrub/cow_repair.c                                               |   12 
 include/hyperv/hvgdk.h                                                  |   10 
 include/hyperv/hvgdk_mini.h                                             |    1 
 include/hyperv/hvhdk.h                                                  |    1 
 include/linux/cfi.h                                                     |    1 
 include/linux/hugetlb.h                                                 |    8 
 include/linux/hyperv.h                                                  |   72 +++--
 include/linux/mlx5/vport.h                                              |    4 
 include/linux/mm.h                                                      |    8 
 include/linux/tracepoint.h                                              |    8 
 include/net/act_api.h                                                   |    1 
 include/net/bluetooth/l2cap.h                                           |    1 
 include/net/ip_vs.h                                                     |    3 
 include/net/netfilter/nf_conntrack_helper.h                             |    1 
 include/net/sock.h                                                      |    1 
 include/net/tc_act/tc_pedit.h                                           |    1 
 include/rdma/ib_umem.h                                                  |   48 +--
 include/rdma/ib_verbs.h                                                 |   48 ---
 include/rdma/iter.h                                                     |   88 ++++++
 include/uapi/linux/tee.h                                                |    1 
 io_uring/io_uring.c                                                     |    2 
 io_uring/kbuf.c                                                         |    1 
 io_uring/net.c                                                          |    3 
 ipc/shm.c                                                               |   10 
 kernel/dma/debug.c                                                      |    2 
 kernel/dma/direct.c                                                     |    2 
 kernel/futex/requeue.c                                                  |    6 
 kernel/locking/rtmutex.c                                                |    3 
 kernel/locking/rtmutex_api.c                                            |    2 
 kernel/pid.c                                                            |    8 
 kernel/sched/ext.c                                                      |   10 
 kernel/signal.c                                                         |    1 
 kernel/time/time.c                                                      |    2 
 kernel/time/timer_migration.c                                           |    8 
 kernel/trace/trace_probe.c                                              |    2 
 mm/cma.c                                                                |    7 
 mm/cma_debug.c                                                          |    3 
 mm/damon/lru_sort.c                                                     |    4 
 mm/damon/ops-common.c                                                   |    4 
 mm/damon/reclaim.c                                                      |    4 
 mm/huge_memory.c                                                        |    4 
 mm/hugetlb.c                                                            |   69 ++--
 mm/list_lru.c                                                           |   21 -
 mm/memcontrol.c                                                         |    5 
 mm/memory-failure.c                                                     |   19 -
 mm/mincore.c                                                            |   10 
 net/6lowpan/iphc.c                                                      |    4 
 net/802/garp.c                                                          |    2 
 net/802/mrp.c                                                           |    9 
 net/bluetooth/bnep/core.c                                               |   50 ++-
 net/bluetooth/hci_sync.c                                                |    5 
 net/bluetooth/hci_sysfs.c                                               |    6 
 net/bluetooth/iso.c                                                     |   61 +++-
 net/bluetooth/l2cap_core.c                                              |   46 +++
 net/bluetooth/mgmt.c                                                    |   17 -
 net/bluetooth/rfcomm/core.c                                             |   67 +++-
 net/bluetooth/rfcomm/sock.c                                             |   26 +
 net/bluetooth/sco.c                                                     |   20 +
 net/bridge/netfilter/ebt_dnat.c                                         |    4 
 net/bridge/netfilter/ebt_redirect.c                                     |   16 -
 net/bridge/netfilter/ebt_snat.c                                         |    3 
 net/bridge/netfilter/nft_meta_bridge.c                                  |    2 
 net/core/filter.c                                                       |   15 -
 net/core/gro.c                                                          |    5 
 net/core/netdev-genl.c                                                  |    4 
 net/core/skbuff.c                                                       |    6 
 net/core/sock.c                                                         |   13 
 net/devlink/core.c                                                      |    2 
 net/hsr/hsr_framereg.c                                                  |    4 
 net/ieee802154/6lowpan/tx.c                                             |    5 
 net/ipv4/inet_fragment.c                                                |    3 
 net/ipv4/ip_fragment.c                                                  |    3 
 net/ipv4/ip_options.c                                                   |    4 
 net/ipv4/netfilter/arp_tables.c                                         |   15 -
 net/ipv4/netfilter/ip_tables.c                                          |   15 -
 net/ipv4/netfilter/nf_nat_h323.c                                        |    2 
 net/ipv4/netfilter/nft_fib_ipv4.c                                       |    2 
 net/ipv4/udp.c                                                          |    8 
 net/ipv6/addrconf.c                                                     |    6 
 net/ipv6/anycast.c                                                      |   16 -
 net/ipv6/ip6_vti.c                                                      |    3 
 net/ipv6/mcast.c                                                        |    8 
 net/ipv6/netfilter/ip6_tables.c                                         |   15 -
 net/ipv6/netfilter/ip6t_eui64.c                                         |    7 
 net/ipv6/netfilter/nft_fib_ipv6.c                                       |    2 
 net/ipv6/sit.c                                                          |    1 
 net/l2tp/l2tp_ppp.c                                                     |   82 +++--
 net/mac80211/mlme.c                                                     |    9 
 net/mac80211/tests/chan-mode.c                                          |    1 
 net/mac80211/tx.c                                                       |    4 
 net/mptcp/options.c                                                     |   73 ++---
 net/mptcp/pm.c                                                          |   15 -
 net/mptcp/pm_userspace.c                                                |   14 -
 net/mptcp/protocol.c                                                    |    4 
 net/mptcp/protocol.h                                                    |    7 
 net/mptcp/sockopt.c                                                     |   15 -
 net/netfilter/ipset/ip_set_bitmap_ipmac.c                               |    5 
 net/netfilter/ipset/ip_set_hash_ipmac.c                                 |    9 
 net/netfilter/ipset/ip_set_hash_mac.c                                   |    5 
 net/netfilter/ipvs/ip_vs_ctl.c                                          |   13 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                                   |   18 -
 net/netfilter/ipvs/ip_vs_proto_tcp.c                                    |   21 -
 net/netfilter/ipvs/ip_vs_proto_udp.c                                    |   20 -
 net/netfilter/ipvs/ip_vs_sched.c                                        |   14 -
 net/netfilter/nf_conntrack_helper.c                                     |   19 +
 net/netfilter/nf_conntrack_irc.c                                        |    4 
 net/netfilter/nf_log_syslog.c                                           |   12 
 net/netfilter/nf_nat_core.c                                             |    2 
 net/netfilter/nf_nat_sip.c                                              |    1 
 net/netfilter/nf_synproxy_core.c                                        |   24 +
 net/netfilter/nfnetlink_log.c                                           |   23 +
 net/netfilter/nfnetlink_queue.c                                         |   64 ++++
 net/netfilter/nft_ct.c                                                  |    8 
 net/netfilter/nft_ct_fast.c                                             |    2 
 net/netfilter/nft_exthdr.c                                              |    3 
 net/netfilter/nft_fib.c                                                 |    6 
 net/netfilter/nft_tunnel.c                                              |    2 
 net/netfilter/xt_NFQUEUE.c                                              |    2 
 net/netfilter/xt_mac.c                                                  |    4 
 net/netlabel/netlabel_unlabeled.c                                       |   30 --
 net/openvswitch/datapath.c                                              |    1 
 net/phonet/pn_dev.c                                                     |    2 
 net/qrtr/af_qrtr.c                                                      |    4 
 net/rds/ib_cm.c                                                         |    1 
 net/rds/ib_send.c                                                       |    2 
 net/rds/info.c                                                          |    2 
 net/rxrpc/input.c                                                       |   26 +
 net/sched/act_api.c                                                     |    7 
 net/sched/act_pedit.c                                                   |   77 ++---
 net/sctp/bind_addr.c                                                    |   11 
 net/sctp/diag.c                                                         |   17 -
 net/sctp/input.c                                                        |    8 
 net/sctp/sm_make_chunk.c                                                |   12 
 net/sctp/sm_statefuns.c                                                 |    6 
 net/sctp/stream.c                                                       |    6 
 net/smc/af_smc.c                                                        |   17 -
 net/socket.c                                                            |   11 
 net/unix/af_unix.c                                                      |   11 
 net/vmw_vsock/virtio_transport_common.c                                 |   11 
 net/vmw_vsock/vmci_transport.c                                          |    4 
 net/wireless/nl80211.c                                                  |    3 
 net/wireless/scan.c                                                     |    9 
 net/xdp/xsk.c                                                           |   11 
 net/xfrm/espintcp.c                                                     |    4 
 net/xfrm/xfrm_iptfs.c                                                   |   11 
 net/xfrm/xfrm_policy.c                                                  |   13 
 scripts/Makefile.compiler                                               |    2 
 scripts/generate_rust_target.rs                                         |    8 
 sound/core/pcm_native.c                                                 |    7 
 sound/core/seq/seq_dummy.c                                              |   15 -
 sound/core/timer.c                                                      |   17 -
 sound/soc/codecs/wm_adsp.c                                              |    3 
 sound/soc/fsl/fsl_sai.c                                                 |    2 
 sound/soc/sof/amd/acp-ipc.c                                             |    4 
 sound/soc/sof/amd/acp.h                                                 |    2 
 tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc |    2 
 tools/testing/selftests/kselftest_harness.h                             |    1 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                         |    4 
 tools/verification/rv/src/in_kernel.c                                   |   65 ++--
 tools/verification/rvgen/__main__.py                                    |   10 
 tools/verification/rvgen/rvgen/ltl2ba.py                                |    9 
 virt/kvm/kvm_main.c                                                     |    3 
 354 files changed, 3145 insertions(+), 1581 deletions(-)

Adrian Korwel (2):
      USB: serial: io_ti: fix heap overflow in get_manuf_info()
      USB: serial: io_ti: fix heap overflow in build_i2c_fw_hdr()

Adrian Moreno (1):
      net: openvswitch: fix possible kfree_skb of ERR_PTR

Akhil R (1):
      i2c: tegra: Fix NOIRQ suspend/resume

Aleksandr Nogikh (1):
      signal: clear JOBCTL_PENDING_MASK for caller in zap_other_threads()

Alexander A. Klimov (1):
      drm/vc4: fix krealloc() memory leak

Alice Ryhl (2):
      rust: arm64: set uwtable llvm module flag for CONFIG_UNWIND_TABLES
      rust: kasan/kbuild: fix rustc-option when cross-compiling

Alistair Popple (1):
      arm64: mm: call pagetable dtor when freeing hot-removed page tables

Alok Tiwari (1):
      idpf: fix mailbox capability for set device clock time

Amirreza Zarrabi (1):
      tee: optee: prevent use-after-free when the client exits before the supplicant

Amit Matityahu (1):
      timers/migration: Fix livelock in tmigr_handle_remote_up()

Anandu Krishnan E (1):
      misc: fastrpc: fix use-after-free of fastrpc_user in workqueue context

Andre Heider (1):
      nvmem: layouts: onie-tlv: fix hang on unknown types

Andrew Martin (1):
      drm/amdkfd: Fix buffer overflow in SDMA queue checkpoint/restore on GFX11

Andrzej Kacprowski (3):
      accel/ivpu: Add bounds checks for firmware log indices
      accel/ivpu: Add buffer overflow check in MS get_info_ioctl
      accel/ivpu: Fix signed integer truncation in IPC receive

Andy Roulin (2):
      vxlan: vnifilter: send notification on VNI add
      vxlan: vnifilter: fix spurious notification on VNI update

Anton Leontev (1):
      hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf

Arnd Bergmann (1):
      tee: fix tee_ioctl_object_invoke_arg padding

Arpith Kalaginanavoor (1):
      fs/qnx6: fix pointer arithmetic in directory iteration

Arthur Kiyanovski (1):
      net: ena: PHC: Add missing barrier

Bartosz Golaszewski (4):
      net: mv643xx: fix OF node refcount
      nvmem: core: fix use-after-free bugs in error paths
      pmdomain: imx: fix OF node refcount
      slimbus: qcom-ngd-ctrl: fix OF node refcount

Bharath Reddy (1):
      Bluetooth: fix memory leak in error path of hci_alloc_dev()

Bjorn Andersson (7):
      slimbus: qcom-ngd-ctrl: Fix up platform_driver registration
      slimbus: qcom-ngd-ctrl: Fix probe error path ordering
      slimbus: qcom-ngd-ctrl: Register callbacks after creating the ngd
      slimbus: qcom-ngd-ctrl: Initialize controller resources in controller
      slimbus: qcom-ngd-ctrl: Correct PDR and SSR cleanup ownership
      slimbus: qcom-ngd-ctrl: Balance pm_runtime enablement for NGD
      slimbus: qcom-ngd-ctrl: Avoid ABBA on tx_lock/ctrl->lock

Breno Leitao (1):
      rds: mark snapshot pages dirty in rds_info_getsockopt()

Carlos Song (2):
      i2c: imx-lpi2c: fix resource leaks switching to devm_dma_request_chan()
      i2c: imx: fix clock and pinctrl state inconsistency in runtime PM

Chancel Liu (1):
      ASoC: fsl_sai: Fix 32 slots TDM broken by integer shift UB in xMR write

Chenguang Zhao (1):
      netlabel: validate unlabeled address and mask attribute lengths

Chih Kai Hsu (1):
      r8152: handle the return value of usb_reset_device()

Christian A. Ehrhardt (1):
      io_uring/wait: fix min_timeout behavior

Christian Brauner (1):
      pidfd: refuse access to tasks that have started exiting harder

Christian König (2):
      drm/amdgpu: fix waiting for all submissions for userptrs
      drm/amdgpu: restart the CS if some parts of the VM are still invalidated

Clément Léger (1):
      io_uring/net: inherit IORING_CQE_F_BUF_MORE across bundle recv retries

Cryolitia PukNgae (1):
      Input: atkbd - skip deactivate for HONOR BCC-N's internal keyboard

Cunlong Li (1):
      zram: fix use-after-free in zram_bvec_write_partial()

Damien Le Moal (1):
      block: fix handling of dead zone write plugs

David Carlier (1):
      mm/hugetlb: restore reservation on error in hugetlb folio copy paths

David Howells (1):
      rxrpc: Fix the ACK parser to extract the SACK table for parsing

David Thompson (1):
      net: lan743x: permit VLAN-tagged packets up to configured MTU

Davide Ornaghi (2):
      netfilter: nft_meta_bridge: fix stale stack leak via IIFHWADDR register
      netfilter: nft_fib: fix stale stack leak via the OIFNAME register

Davidlohr Bueso (1):
      locking/rtmutex: Skip remove_waiter() when waiter is not enqueued

Dawei Feng (1):
      octeontx2-af: fix memory leak in rvu_setup_hw_resources()

Deepanshu Kartikey (1):
      wifi: mac80211: limit injected antenna index in ieee80211_parse_tx_radiotap

Dexuan Cui (1):
      hyperv: Clean up and fix the guest ID comment in hvgdk.h

Dmitry Osipenko (1):
      drm/virtio: Fix driver removal with disabled KMS

Dongli Zhang (1):
      KVM: VMX: Update SVI during runtime APICv activation

Dragos Tatulea (2):
      net/mlx5: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list
      net/mlx5e: xsk: Fix DMA and xdp_frame leak on XDP_TX xmit failure

Dudu Lu (1):
      Bluetooth: bnep: fix incorrect length parsing in bnep_rx_frame() extension handling

Emmanuel Grumbach (2):
      wifi: iwlwifi: mvm: don't support the reset handshake for old firmwares
      wifi: iwlwifi: pcie: simplify the resume flow if fast resume is not used

Eric Dumazet (6):
      ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
      ieee802154: 6lowpan: only accept IPv6 packets in lowpan_xmit()
      tcp: restrict SO_ATTACH_FILTER to priv users
      ip6_vti: set netns_immutable on the fallback device.
      ip6_vti: fix incorrect tunnel matching in vti6_tnl_lookup()
      vsock/virtio: fix potential unbounded skb queue

Eva Kurchatova (1):
      tracing: Fix CFI violation in probestub being called by tprobes

Fedor Pchelkin (1):
      wifi: fix leak if split 6 GHz scanning fails

Felix Gu (1):
      spi: rzv2h-rspi: Fix SPDR read access width for 16-bit RX

Fernando Fernandez Mancera (2):
      netfilter: xt_NFQUEUE: prefer raw_smp_processor_id
      netfilter: synproxy: add mutex to guard hook reference counting

Florian Westphal (3):
      netfilter: conntrack_irc: fix possible out-of-bounds read
      netfilter: revalidate bridge ports
      netfilter: nft_exthdr: fix register tracking for F_PRESENT flag

Fushuai Wang (1):
      net/mlx5: Use effective affinity mask for IRQ selection

Gabriele Monaco (6):
      tools/rv: Ensure monitor name and desc are NUL-terminated
      tools/rv: Fix substring match bug in monitor name search
      tools/rv: Fix substring match when listing container monitors
      tools/rv: Fix cleanup after failed trace setup
      verification/rvgen: Fix options shared among commands
      verification/rvgen: Fix ltl2k writing True as a literal

Gao Xiang (2):
      erofs: tidy up synchronous decompression
      erofs: fix use-after-free on sbi->sync_decompress

Geetha sowjanya (1):
      octeontx2-pf: Fix NDC sync operation errors

Geliang Tang (1):
      selftests: harness: fix pidfd leak in __wait_for_test

Georgiy Osokin (1):
      tee: shm: fix shm leak in register_shm_helper()

Gil Portnoy (2):
      ksmbd: fix NULL-deref of opinfo->conn in oplock/lease break notifiers
      ksmbd: fix use-after-free of a deferred file_lock on double SMB2_CANCEL

Greg Kroah-Hartman (1):
      Linux 6.18.36

Guangshuo Li (1):
      dm cache policy smq: check allocation under invalidate lock

Guillermo Rodríguez (1):
      i2c: stm32f7: fix timing computation ignoring i2c-analog-filter

HanQuan (1):
      net: add pskb_may_pull() to skb_gro_receive_list()

Hans de Goede (1):
      clk: qcom: x1e80100-dispcc: Stop disp_cc_mdss_mdp_clk_src from getting parked

Harry Wentland (7):
      drm/amd/display: Reject gpio_bitshift >= 32 in bios_parser_get_gpio_pin_info()
      drm/amd/display: Bound VBIOS record-chain walk loops
      drm/amd/display: Clamp HDMI HDCP2 rx_id_list read to buffer size
      drm/amd/display: Clamp VBIOS HDMI retimer register count to array size
      drm/amd/display: Fix NULL deref and buffer over-read in SDP debugfs
      drm/amd/display: Fix out-of-bounds read in dp_get_eq_aux_rd_interval()
      drm/amd/display: Use krealloc_array() in dal_vector_reserve()

Harshal Dev (1):
      soc: qcom: ice: Allow explicit votes on 'iface' clock for ICE

Heiko Stuebner (1):
      mmc: dw_mmc-rockchip: Add missing private data for very old controllers

HyeongJun An (1):
      USB: serial: kl5kusb105: fix bulk-out buffer overflow

Hyunwoo Kim (2):
      KVM: arm64: Take the SRCU lock for page table walks in fault injection and AT emulation
      inet: frags: fix use-after-free caused by the fqdir_pre_exit() flush

Ido Schimmel (2):
      ipv6: mcast: Fix use-after-free when processing MLD queries
      ipv6: Fix a potential NPD in cleanup_prefix_route()

Inochi Amaoto (2):
      mmc: litex_mmc: Use DIV_ROUND_UP for more accurate clock calculation
      mmc: litex_mmc: Set mandatory idle clocks before CMD0

Jack Wu (1):
      USB: serial: option: add usb-id for Dell Wireless DW5826e-m

Jacob Moroni (3):
      RDMA/umem: Add ib_umem_dmabuf_get_pinned_and_lock helper
      RDMA/umem: Move umem dmabuf revoke logic into helper function
      RDMA/umem: Add helpers for umem dmabuf revoke lock

Jakub Kicinski (1):
      netdev: fix double-free in netdev_nl_bind_rx_doit()

Jamal Hadi Salim (1):
      net/sched: act_api: use RCU with deferred freeing for action lifecycle

Jani Nikula (1):
      drm/xe/display: fix oops in suspend/shutdown without display

Jann Horn (3):
      fhandle: fix UAF due to unlocked ->mnt_ns read in may_decode_fh()
      fuse: reject fuse_notify() pagecache ops on directories
      fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios

Jason Gunthorpe (4):
      RDMA/core: Validate the passed in fops for ib_get_ucaps()
      iommu/dma: Do not try to iommu_map a 0 length region in swiotlb
      RDMA: During rereg_mr ensure that REREG_ACCESS is compatible
      RDMA/umem: Fix truncation for block sizes >= 4G

Jason Xing (1):
      xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()

Jens Axboe (1):
      io_uring/kbuf: don't truncate end buffer for bundles

Jeremy Kerr (2):
      net: mctp: usb: fix race between urb completion and rx_retry cancellation
      net: mctp: usb: don't fail mctp_usb_rx_queue on a deferred submission

Ji'an Zhou (2):
      ALSA: PCM: Fix wait queue list corruption in snd_pcm_drain() on linked streams
      futex/requeue: Prevent NULL pointer dereference in remove_waiter() on self-deadlock

Jianyu Li (1):
      af_unix: Fix inq_len update problem in partial read

Jiawen Wu (4):
      net: txgbe: optimize the flow to setup PHY for AML devices
      net: txgbe: support CR modules for AML devices
      net: txgbe: rename the SFP related
      net: txgbe: initialize module info buffer

Jiayuan Chen (2):
      netfilter: nft_ct: bail out on template ct in get eval
      ipv6: anycast: insert aca into global hash under idev->lock

Jisheng Zhang (1):
      mmc: sdhci: add signal voltage switch in sdhci_resume_host

Joey Gouly (1):
      KVM: arm64: Restore POR_EL0 access to host EL0

Johan Hovold (2):
      spi: cadence-quadspi: fix unclocked access on unbind
      driver core: reject devices with unregistered buses

Johannes Berg (1):
      wifi: mac80211: tests: mark HT check strict

Jonas Jelonek (1):
      net: sfp: initialize i2c_block_size at adapter configure time

Joonas Lahtinen (1):
      drm/i915/gem: Fix phys BO pread/pwrite with offset

Judith Mendez (1):
      pinctrl: mcp23s08: Read spi-present-mask as u8 not u32

Julian Anastasov (2):
      ipvs: clear the svc scheduler ptr early on edit
      ipvs: skip ipv6 extension headers for csum checks

Junrui Luo (1):
      misc: fastrpc: fix DMA address corruption due to find_vma misuse

Justin Lai (2):
      rtase: Avoid sleeping in get_stats64()
      rtase: Reset TX subqueue when clearing TX ring

Kamal Dasu (1):
      mmc: core: Fix host controller programming for fixed driver type

Karl Mehltretter (2):
      ARM: 9474/1: io: avoid KASAN instrumentation of raw halfword I/O
      ARM: 9475/1: entry: use byte load for KASAN VMAP stack shadow

Kendall Willis (1):
      pmdomain: ti_sci: add wakeup constraint to parent devices of wakeup source

Kuan-Wei Chiu (1):
      clk: samsung: gs101: Fix missing USI7_USI DIV clock in peric0_clk_regs

Kuniyuki Iwashima (3):
      bpf: Free reuseport cBPF prog after RCU grace period.
      net: Annotate sk->sk_write_space() for UDP SOCKMAP.
      hsr: Remove WARN_ONCE() in hsr_addr_is_self().

Kurt Kanzenbach (1):
      ptp: vclock: Switch from RCU to SRCU

Kyle Meyer (1):
      bnxt_en: Fix NULL pointer dereference

Kyle Zeng (4):
      ALSA: seq: dummy: fix UMP event stack overread
      ipv6: sit: reload inner IPv6 header after GSO offloads
      net: guard timestamp cmsgs to real error queue skbs
      netfilter: x_tables: avoid leaking percpu counter pointers

Lad Prabhakar (1):
      mmc: renesas_sdhi: Add OF entry for RZ/G2H SoC

Lee Jones (1):
      l2tp: pppol2tp: hold reference to session in pppol2tp_ioctl()

Leon Romanovsky (1):
      RDMA: Move DMA block iterator logic into dedicated files

Leorize (1):
      drm/amd/display: add missing CSC entries for BT.2020 for DCE IPs

Li RongQing (2):
      dma-mapping: direct: fix missing mapping for THRU_HOST_BRIDGE segments
      dma-debug: fix physical address retrieval in debug_dma_sync_sg_for_device

Lizhi Hou (1):
      accel/amdxdna: Fix mm_struct reference leak in aie2_populate_range()

Lorenzo Bianconi (2):
      net: airoha: Fix use-after-free in metadata dst teardown
      net: ethernet: mtk_eth_soc: Fix use-after-free in metadata dst teardown

Lorenzo Stoakes (1):
      mm/hugetlb: avoid false positive lockdep assertion

Luiz Augusto von Dentz (2):
      Bluetooth: ISO: Fix not releasing hdev reference on iso_conn_big_sync
      Bluetooth: MGMT: Fix backward compatibility with userspace

Manivannan Sadhasivam (2):
      soc: qcom: ice: Return -ENODEV if the ICE platform device is not found
      soc: qcom: ice: Fix race between qcom_ice_probe() and of_qcom_ice_get()

Marco Scardovi (1):
      gpio: rockchip: fix generic IRQ chip leak on remove

Mark Bloch (1):
      devlink: Release nested relation on devlink free

Mark Rutland (3):
      arm64: cputype: Add C1-Ultra definitions
      arm64: cputype: Add C1-Premium definitions
      arm64: errata: Mitigate TLBI errata on various Arm CPUs

Masami Hiramatsu (Google) (1):
      tracing/probes: Point the error offset correctly for eprobe argument error

Matthieu Baerts (NGI0) (3):
      mptcp: sockopt: check timestamping ret value
      mptcp: sockopt: set sockopt on all subflows
      mptcp: add-addr: always drop other suboptions

Maxime Chevallier (1):
      net: phy: clean the sfp upstream if phy probing fails

Maíra Canal (4):
      drm/v3d: Wait for pending L2T flush before cleaning caches
      drm/v3d: Fix global performance monitor reference counting
      drm/v3d: Fix vaddr leak when indirect CSD has zeroed workgroups
      drm/v3d: Skip CSD when it has zeroed workgroups

Michael Bommarito (9):
      sctp: fix uninit-value in __sctp_rcv_asconf_lookup()
      Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
      RDMA/srp: bound SRP_RSP sense copy by the received length
      IB/isert: Reject login PDUs shorter than ISER_HEADERS_LEN
      thunderbolt: Reject zero-length property entries in validator
      thunderbolt: Bound root directory content to block size
      thunderbolt: Clamp XDomain response data copy to allocation size
      thunderbolt: Validate XDomain request packet size before type cast
      thunderbolt: Limit XDomain response copy to actual frame size

Michael Kelley (2):
      Drivers: hv: vmbus: Provide option to skip VMBus unload on panic
      drm/hyperv: During panic do VMBus unload after frame buffer is flushed

Miguel Ojeda (1):
      rust: x86: support Rust >= 1.98.0 target spec

Mihai Sain (1):
      ARM: dts: microchip: sam9x7: fix GMAC clock configuration

Mingyu Wang (3):
      i2c: dev: prevent integer overflow in I2C_TIMEOUT ioctl
      net: qrtr: fix refcount saturation and potential UAF in qrtr_port_remove
      fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync signaling

Muchun Song (2):
      mm/cma: fix reserved page leak on activation failure
      mm/cma_debug: fix invalid accesses for inactive CMA areas

Muhammad Bilal (1):
      drm/amdkfd: fix NULL dereference in get_queue_ids()

Mukesh Ojha (1):
      misc: fastrpc: Fix NULL pointer dereference in rpmsg callback

Nathan Chancellor (2):
      ARM: Do not select HAVE_RUST when KASAN is enabled
      cfi: Include uaccess.h for get_kernel_nofault()

Naveen Kumar Chaudhary (1):
      time: Fix off-by-one in settimeofday() usec validation

Nicolò Coccia (1):
      net/smc: fix sleep-inside-lock in __smc_setsockopt() causing local DoS

Nikita Zhandarovich (1):
      drm/i915/edp: Check supported link rates DPCD read

Nikolay Kuratov (1):
      net/mlx5: Reorder completion before putting command entry in cmd_work_handler

Nithin Dabilpuram (1):
      octeontx2-af: npc: Fix CPT channel mask in npc_install_flow

Oscar Maes (1):
      pcnet32: stop holding device spin lock during napi_complete_done

Paolo Abeni (3):
      mptcp: fix retransmission loop when csum is enabled
      mptcp: close TOCTOU race while computing rcv_wnd
      mptcp: allow subflow rcv wnd to shrink

Pengyu Luo (1):
      clk: qcom: dispcc-sc8280xp: Don't park mdp_clk_src at registration time

Petr Oros (1):
      ice: fix missing priority callbacks for U.FL DPLL pins

Priya Hosur (1):
      drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in set_soft_freq_limited_range

Raf Dickson (1):
      vsock/vmci: fix sk_ack_backlog leak on failed handshake

Rajat Gupta (1):
      net/sched: fix pedit partial COW leading to page cache corruption

Randy Dunlap (1):
      RDMA/umem: fix kernel-doc warnings

Richard Fitzgerald (1):
      ASoC: wm_adsp: Fix NULL dereference when removing firmware controls

Rio Liu (1):
      wifi: mac80211: skip ieee80211_verify_sta_ht_mcs_support check in non-strict mode

Robertus Diawan Chris (1):
      tee: qcomtee: add missing va_end in early return qcomtee_object_user_init()

Roman Kisel (1):
      Drivers: hv: VMBus protocol version 6.0

Rosen Penev (1):
      net: ibm: emac: Fix use-after-free during device removal

Ruoyu Wang (1):
      gpio: zynq: fix runtime PM leak on remove

Russell King (Oracle) (4):
      ARM: group is_permission_fault() with is_translation_fault()
      ARM: allow __do_kernel_fault() to report execution of memory faults
      ARM: fix hash_name() fault
      ARM: fix branch predictor hardening

Salman Alghamdi (1):
      staging: rtl8723bs: fix buffer over-read in rtw_update_protection

Sanghyun Park (1):
      xfrm: policy: fix use-after-free on inexact bin in xfrm_policy_bysel_ctx()

Santosh Kalluri (1):
      net: phonet: free phonet_device after RCU grace period

Sean Christopherson (2):
      KVM: Don't WARN if memory is dirtied without a vCPU when the VM is dying
      KVM: SEV: Decouple the need to sync the GHCB SA from the need to free the SA

Sechang Lim (1):
      udp: clear skb->dev before running a sockmap verdict

SeongJae Park (3):
      mm/damon/ops-common: call folio_test_lru() after folio_get()
      mm/damon/lru_sort: handle ctx allocation failure
      mm/damon/reclaim: handle ctx allocation failure

SeungJu Cheon (3):
      Bluetooth: RFCOMM: validate skb length in MCC handlers
      Bluetooth: ISO: Fix data-race on iso_pi fields in hci_get_route calls
      Bluetooth: SCO: Fix data-race on sco_pi fields in sco_connect

Shakeel Butt (2):
      memcg: use round-robin victim selection in refill_stock
      mm/list_lru: drain before clearing xarray entry on reparent

Shanker Donthineni (1):
      arm64: errata: Mitigate TLBI errata on NVIDIA Olympus CPU

Simona Vetter (1):
      drm/gem: Try to fix change_handle ioctl, attempt 4

Stefano Garzarella (2):
      vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
      vsock/virtio: fix skb overhead overflow on 32-bit builds

Suman Ghosh (1):
      octeontx2-af: Fix initialization of mcam's entry2target_pffunc field

Takao Sato (1):
      xfrm: iptfs: preserve shared-frag marker in iptfs_consume_frags()

Takashi Iwai (2):
      ALSA: timer: Forcibly close timer instances at closing
      ALSA: timer: Fix UAF at snd_timer_user_params()

Tangudu Tilak Tirumalesh (1):
      drm/xe: Clear pending_disable before signaling suspend fence

Tao Cui (2):
      mptcp: pm: fix extra_subflows underflow on userspace PM subflow creation
      selftests: mptcp: add test for extra_subflows underflow on userspace PM

Tapio Reijonen (1):
      net: fec: fix pinctrl default state restore order on resume

Tejun Heo (1):
      sched_ext: Don't warn on NULL cgrp_moving_from in scx_cgroup_move_task()

Til Kaiser (4):
      net: mvpp2: sync RX data at the hardware packet offset
      net: mvpp2: limit XDP frame size to the RX buffer
      net: mvpp2: refill RX buffers before XDP or skb use
      net: mvpp2: build skb from XDP-adjusted data on XDP_PASS

Tristan Madani (2):
      netfilter: nft_tunnel: fix use-after-free on object destroy
      xfrm: iptfs: fix ABBA deadlock in iptfs_destroy_state()

Tudor Ambarus (1):
      firmware: samsung: acpm: Fix mailbox channel leak on probe error

Usama Arif (1):
      mm/mincore: handle non-swap entries before !CONFIG_SWAP guard

Val Packett (1):
      arm64: dts: qcom: x1-dell-thena: remove i2c20 (battery SMBus) and reserve its pins

Vijendar Mukunda (1):
      ASoC: SOF: amd: fix for ipc flags check

Vikas Gupta (1):
      bnge: fix context mem iteration

Vitaly Prosyak (1):
      drm/amdgpu: set noretry=1 as default for GFX 10.1.x (Navi10/12/14)

Vladimir Zapolskiy (1):
      i2c: qcom-cci: Fix NULL pointer dereference in cci_remove()

Wei Liu (1):
      mshv: add a missing padding field

Weiming Shi (3):
      tap: free page on error paths in tap_get_user_xdp()
      net/rds: fix NULL deref in rds_ib_send_cqe_handler() on masked atomic completion
      netfilter: nf_conntrack: destroy stale expectfn expectations on unregister

Wentao Liang (2):
      drm/xe: fix refcount leak in xe_range_fence_insert()
      drm/virtio: fix dma_fence refcount leak on error in virtio_gpu_dma_fence_wait()

Will Deacon (1):
      arm64: errata: Mitigate TLBI errata on Microsoft Azure Cobalt 100 CPU

Wupeng Ma (1):
      mm/memory-failure: fix hugetlb_lock AA deadlock in get_huge_page_for_hwpoison

Wyatt Feng (2):
      xfrm: espintcp: do not reuse an in-progress partial send
      sctp: stream: fully roll back denied add-stream state

Xiang Mei (2):
      tun: zero the whole vnet header in tun_put_user()
      netfilter: nf_log: validate MAC header was set before dumping it

Xin Long (3):
      sctp: validate cached peer INIT chunk length in COOKIE_ECHO processing
      sctp: purge outqueue on stale COOKIE-ECHO handling
      sctp: validate embedded INIT chunk and address list lengths in cookie

Yang Wang (2):
      drm/amd/pm: fix smu13 power limit default/cap calculation
      drm/amd/pm: mark metrics.energy_accumulator is invalid for smu 14.0.2

Yao Sang (1):
      net/mlx4: avoid GCC 10 __bad_copy_from() false positive

Yicong Hui (1):
      drm/imx: Fix three kernel-doc warnings in dcss-scaler.c

Yilin Zhu (1):
      ipc/shm: serialize orphan cleanup with shm_nattch updates

Yiming Qian (1):
      netfilter: bridge: make ebt_snat ARP rewrite writable

Yin Tirui (2):
      mm/huge_memory: update file PMD counter before folio_put()
      mm/huge_memory: update file PUD counter before folio_put()

Yingjie Gao (2):
      xfs: fix error returns in CoW fork repair
      xfs: fix rtgroup cleanup in CoW fork repair

Yishai Hadas (1):
      RDMA/core: Validate cpu_id against nr_cpu_ids in DMAH alloc

Yizhou Zhao (3):
      6lowpan: fix off-by-one in multicast context address compression
      net: garp: fix unsigned integer underflow in garp_pdu_parse_attr
      net/802/mrp: fix vector attribute parsing in mrp_pdu_parse_vecattr

Yuho Choi (1):
      ARM: socfpga: Fix OF node refcount leak in SMP setup

Yun Zhou (1):
      gpio: mvebu: fix NULL pointer dereference in suspend/resume

Yuqi Xu (3):
      Bluetooth: hci_sync: reject oversized Broadcast Announcement prepend
      wifi: nl80211: reject oversized EMA RNR lists
      net: rds: clear i_sends on setup unwind

Zeyu WANG (1):
      Input: atkbd - add DMI quirk for Lenovo Yoga Air 14 (83QK)

Zhan Xusheng (1):
      cpufreq/amd-pstate: drop stale @epp_cached kdoc

Zhang Cen (3):
      Bluetooth: RFCOMM: hold listener socket in rfcomm_connect_ind()
      Bluetooth: MGMT: validate advertising TLV before type checks
      Bluetooth: bnep: reject short frames before parsing

Zhao Zhang (1):
      sctp: diag: reject stale associations in dump_one path

ZhaoJinming (2):
      net: airoha: Add NULL check for of_reserved_mem_lookup() in airoha_qdma_init_hfwd_queues()
      net: bonding: fix NULL pointer dereference in bond_do_ioctl()

Zhengchuan Liang (1):
      netfilter: require Ethernet MAC header before using eth_hdr()

Zhenghang Xiao (2):
      xfrm: iptfs: fix use-after-free on first_skb in __input_process_payload
      misc: fastrpc: fix use-after-free race in fastrpc_map_create

