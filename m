Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D2D339870;
	Fri, 19 Jun 2026 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781871037; cv=none; b=PY57FZvpz9+h7c/W9MsFfeDAyQJUSPctUWBg3KQbipKBOw6dwrlXEF7/ERFPndNL0WEvrivc9X/Ic77u5VtZGEl08lYx4bwqgSAxCqvAnI4luBbqyXtQIfsSd2ES1st/wv1v9XvAmLTYNFwJ2ol6UkC5AR1I74UJVFhm6bbJju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781871037; c=relaxed/simple;
	bh=a1fnLqMhxd5g6bcUNGoK/1cs30A8zRNgmWC6ZdMZa9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FPYVKWgNUtlgoi8ZpLBFGzIE9vi/lnvjlAr3kc2OzTXeKAqkgHX1DtBNEJPWRD0TWWjE/XgHJJGY+VEIC3fzK/fpqIkuwyiHq5g0OLJ+dhACdHcm7N/B4wi8YFx71ax4VmkkXyrzlYB9pgV79H+2ovriXii/wJmkQR73dYeNTz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BOTHl+k5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BOTHl+k5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587821F000E9;
	Fri, 19 Jun 2026 12:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781871035;
	bh=5AxDkzfhsJWVD3yd3v+hDXUcmDl6+H4VbEp6FFTmYEA=;
	h=From:To:Cc:Subject:Date;
	b=BOTHl+k5q1aMA+DPDeQ6j19vnXMLEqt35YeIq/XktXYdqVimgfqnHurZpvBlt3mcv
	 KsB4sQ1Z+GcGAObFhBRq1SnX752XhYT2TAKCSj6Y/B4gUrjDdocoW/oFkEs1AIAE1c
	 zCr+NmXPn+BmFTYR33+rVFtrgLtkkNXcqpK01Q3k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.94
Date: Fri, 19 Jun 2026 14:09:26 +0200
Message-ID: <2026061927-control-spinach-4a06@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.94 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-fs-erofs                                |   25 +-
 Documentation/arch/arm64/silicon-errata.rst                             |   48 +++
 Makefile                                                                |    5 
 arch/arm/include/asm/io.h                                               |   15 +
 arch/arm/kernel/entry-armv.S                                            |    2 
 arch/arm/mach-socfpga/platsmp.c                                         |    1 
 arch/arm/mm/alignment.c                                                 |    6 
 arch/arm/mm/fault.c                                                     |  100 ++++++--
 arch/arm64/Kconfig                                                      |   50 ++++
 arch/arm64/Makefile                                                     |    3 
 arch/arm64/include/asm/cputype.h                                        |    6 
 arch/arm64/include/asm/tlbflush.h                                       |   63 +++--
 arch/arm64/kernel/cpu_errata.c                                          |   34 ++
 arch/arm64/kernel/sys_compat.c                                          |    2 
 arch/arm64/kvm/hyp/nvhe/mm.c                                            |    2 
 arch/arm64/kvm/hyp/nvhe/tlb.c                                           |    8 
 arch/arm64/kvm/hyp/pgtable.c                                            |    2 
 arch/arm64/kvm/hyp/vhe/tlb.c                                            |   10 
 arch/x86/Makefile                                                       |    4 
 arch/x86/Makefile.um                                                    |    8 
 arch/x86/kvm/svm/sev.c                                                  |   27 +-
 arch/x86/kvm/vmx/vmx.c                                                  |    9 
 arch/x86/kvm/x86.c                                                      |    7 
 block/blk-zoned.c                                                       |   32 ++
 drivers/accel/ivpu/ivpu_fw_log.c                                        |    5 
 drivers/accel/ivpu/ivpu_ipc.c                                           |    2 
 drivers/accel/ivpu/ivpu_ms.c                                            |    7 
 drivers/base/bus.c                                                      |   11 
 drivers/block/zram/zram_drv.c                                           |    2 
 drivers/char/ipmi/ipmi_msghandler.c                                     |    2 
 drivers/char/ipmi/ipmi_ssif.c                                           |   29 +-
 drivers/clk/qcom/dispcc-sc8280xp.c                                      |    4 
 drivers/clk/qcom/dispcc-x1e80100.c                                      |    2 
 drivers/clk/samsung/clk-gs101.c                                         |    2 
 drivers/gpio/gpio-mvebu.c                                               |    4 
 drivers/gpio/gpio-zynq.c                                                |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                  |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c                   |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c                        |   49 +++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c               |    5 
 drivers/gpu/drm/amd/display/dc/basics/vector.c                          |    4 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c                       |   15 -
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c                      |   81 ++++--
 drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h                |    5 
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c                      |   10 
 drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c                |   10 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c                     |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c                    |   32 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                    |   32 +-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c                    |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c                    |    1 
 drivers/gpu/drm/i915/gem/i915_gem_phys.c                                |   19 +
 drivers/gpu/drm/imx/dcss/dcss-scaler.c                                  |    3 
 drivers/gpu/drm/v3d/v3d_sched.c                                         |    3 
 drivers/gpu/drm/vc4/vc4_validate_shaders.c                              |   13 -
 drivers/gpu/drm/virtio/virtgpu_drv.c                                    |    5 
 drivers/gpu/drm/virtio/virtgpu_submit.c                                 |    4 
 drivers/gpu/drm/xe/xe_guc_submit.c                                      |    2 
 drivers/gpu/drm/xe/xe_range_fence.c                                     |    2 
 drivers/i2c/busses/i2c-qcom-cci.c                                       |    2 
 drivers/i2c/busses/i2c-stm32f7.c                                        |    6 
 drivers/i2c/busses/i2c-tegra.c                                          |   53 ++--
 drivers/i2c/i2c-dev.c                                                   |    9 
 drivers/infiniband/core/Makefile                                        |    2 
 drivers/infiniband/core/iter.c                                          |   43 +++
 drivers/infiniband/core/umem.c                                          |   16 +
 drivers/infiniband/core/umem_dmabuf.c                                   |   77 ++++--
 drivers/infiniband/core/verbs.c                                         |   38 ---
 drivers/infiniband/hw/bnxt_re/qplib_res.c                               |    2 
 drivers/infiniband/hw/cxgb4/mem.c                                       |    2 
 drivers/infiniband/hw/efa/efa_verbs.c                                   |    2 
 drivers/infiniband/hw/erdma/erdma_verbs.c                               |    2 
 drivers/infiniband/hw/hns/hns_roce_alloc.c                              |    2 
 drivers/infiniband/hw/hns/hns_roce_mr.c                                 |    4 
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
 drivers/mailbox/mailbox.c                                               |   15 -
 drivers/mailbox/tegra-hsp.c                                             |    2 
 drivers/md/dm-cache-policy-smq.c                                        |   12 
 drivers/misc/fastrpc.c                                                  |  107 +++++---
 drivers/mmc/core/mmc.c                                                  |    4 
 drivers/mmc/host/dw_mmc-rockchip.c                                      |   17 +
 drivers/mmc/host/litex_mmc.c                                            |   20 +
 drivers/mmc/host/renesas_sdhi_internal_dmac.c                           |    1 
 drivers/mmc/host/sdhci.c                                                |    1 
 drivers/net/bonding/bond_main.c                                         |    4 
 drivers/net/ethernet/amd/pcnet32.c                                      |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                               |    2 
 drivers/net/ethernet/freescale/fec_main.c                               |    3 
 drivers/net/ethernet/ibm/emac/core.c                                    |    9 
 drivers/net/ethernet/marvell/mv643xx_eth.c                              |    2 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                         |   75 +++---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                         |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                         |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c                     |   36 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c                  |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                    |    2 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                             |    2 
 drivers/net/ethernet/mellanox/mlx4/cq.c                                 |    9 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                           |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c                        |   10 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                       |   13 -
 drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c                  |    5 
 drivers/net/ethernet/mellanox/mlx5/core/vport.c                         |   72 ++++-
 drivers/net/ethernet/microchip/lan743x_main.c                           |   32 ++
 drivers/net/ethernet/microchip/lan743x_main.h                           |    1 
 drivers/net/ethernet/realtek/rtase/rtase_main.c                         |    7 
 drivers/net/hyperv/netvsc.c                                             |   19 +
 drivers/net/phy/micrel.c                                                |   15 -
 drivers/net/phy/phy_device.c                                            |    6 
 drivers/net/tap.c                                                       |    2 
 drivers/net/usb/r8152.c                                                 |    7 
 drivers/net/vxlan/vxlan_vnifilter.c                                     |    5 
 drivers/nvmem/core.c                                                    |   12 
 drivers/nvmem/layouts/onie-tlv.c                                        |    3 
 drivers/pinctrl/pinctrl-mcp23s08_spi.c                                  |    5 
 drivers/pmdomain/imx/gpc.c                                              |    2 
 drivers/ptp/ptp_vclock.c                                                |   14 -
 drivers/slimbus/qcom-ngd-ctrl.c                                         |  122 ++++++----
 drivers/soc/qcom/ice.c                                                  |   40 ++-
 drivers/spi/spi-cadence-quadspi.c                                       |    5 
 drivers/tee/optee/supp.c                                                |  107 ++++++--
 drivers/tee/tee_shm.c                                                   |    2 
 drivers/thunderbolt/property.c                                          |    6 
 drivers/thunderbolt/xdomain.c                                           |   14 -
 drivers/usb/serial/io_ti.c                                              |   11 
 drivers/usb/serial/kl5kusb105.c                                         |    4 
 drivers/usb/serial/mct_u232.c                                           |   21 -
 drivers/usb/serial/option.c                                             |    3 
 fs/erofs/internal.h                                                     |    7 
 fs/erofs/super.c                                                        |    3 
 fs/erofs/sysfs.c                                                        |   19 +
 fs/erofs/zdata.c                                                        |   36 +-
 fs/fcntl.c                                                              |    8 
 fs/fs-writeback.c                                                       |  101 +++++---
 fs/fuse/dev.c                                                           |    9 
 fs/iomap/buffered-io.c                                                  |    4 
 fs/qnx6/dir.c                                                           |    8 
 fs/smb/server/oplock.c                                                  |   15 -
 fs/smb/server/smb2pdu.c                                                 |   11 
 include/linux/backing-dev-defs.h                                        |    4 
 include/linux/hugetlb.h                                                 |    8 
 include/linux/ieee80211.h                                               |   18 -
 include/linux/kexec.h                                                   |    3 
 include/linux/mailbox_controller.h                                      |    3 
 include/linux/mlx5/vport.h                                              |    4 
 include/linux/mm.h                                                      |    8 
 include/linux/writeback.h                                               |    2 
 include/net/act_api.h                                                   |    1 
 include/net/bluetooth/hci_core.h                                        |    9 
 include/net/bluetooth/hci_sync.h                                        |    4 
 include/net/bluetooth/l2cap.h                                           |    1 
 include/net/ip.h                                                        |    8 
 include/net/ip_vs.h                                                     |    3 
 include/net/netfilter/nf_conntrack_core.h                               |    5 
 include/net/netfilter/nf_conntrack_helper.h                             |    1 
 include/net/secure_seq.h                                                |   45 +++
 include/net/sock.h                                                      |    1 
 include/net/tc_act/tc_pedit.h                                           |    2 
 include/net/tcp.h                                                       |    6 
 include/rdma/ib_umem.h                                                  |   48 +--
 include/rdma/ib_verbs.h                                                 |   48 ---
 include/rdma/iter.h                                                     |   88 +++++++
 io_uring/io_uring.c                                                     |    2 
 io_uring/kbuf.c                                                         |    1 
 io_uring/net.c                                                          |    3 
 ipc/shm.c                                                               |   10 
 kernel/dma/debug.c                                                      |    2 
 kernel/kexec_file.c                                                     |   33 ++
 kernel/pid.c                                                            |    8 
 kernel/sched/ext.c                                                      |    9 
 kernel/signal.c                                                         |    1 
 kernel/time/time.c                                                      |    2 
 kernel/time/timer_migration.c                                           |    8 
 kernel/trace/trace_probe.c                                              |    2 
 mm/backing-dev.c                                                        |    5 
 mm/damon/ops-common.c                                                   |    4 
 mm/huge_memory.c                                                        |    2 
 mm/hugetlb.c                                                            |   70 +++--
 mm/memory-failure.c                                                     |   19 -
 net/6lowpan/iphc.c                                                      |    4 
 net/802/garp.c                                                          |    2 
 net/802/mrp.c                                                           |    9 
 net/bluetooth/bnep/core.c                                               |   50 ++--
 net/bluetooth/hci_conn.c                                                |   31 +-
 net/bluetooth/hci_core.c                                                |   16 +
 net/bluetooth/hci_sync.c                                                |   25 +-
 net/bluetooth/hci_sysfs.c                                               |    6 
 net/bluetooth/iso.c                                                     |   71 ++++-
 net/bluetooth/l2cap_core.c                                              |   46 +++
 net/bluetooth/mgmt.c                                                    |   17 -
 net/bluetooth/rfcomm/core.c                                             |   67 ++++-
 net/bluetooth/rfcomm/sock.c                                             |   26 +-
 net/bridge/netfilter/ebt_dnat.c                                         |    4 
 net/bridge/netfilter/ebt_redirect.c                                     |   16 -
 net/bridge/netfilter/ebt_snat.c                                         |    3 
 net/core/filter.c                                                       |   15 -
 net/core/gro.c                                                          |    5 
 net/core/netdev-genl.c                                                  |    4 
 net/core/secure_seq.c                                                   |   80 ++----
 net/core/skbuff.c                                                       |    6 
 net/core/sock.c                                                         |   13 -
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
 net/ipv4/syncookies.c                                                   |   19 -
 net/ipv4/tcp.c                                                          |   44 +--
 net/ipv4/tcp_fastopen.c                                                 |    2 
 net/ipv4/tcp_input.c                                                    |   22 +
 net/ipv4/tcp_ipv4.c                                                     |   84 +++---
 net/ipv4/tcp_minisocks.c                                                |   11 
 net/ipv4/tcp_output.c                                                   |   12 
 net/ipv4/tcp_timer.c                                                    |    4 
 net/ipv4/udp.c                                                          |    8 
 net/ipv4/xfrm4_input.c                                                  |    5 
 net/ipv6/addrconf.c                                                     |    6 
 net/ipv6/ip6_vti.c                                                      |    2 
 net/ipv6/mcast.c                                                        |    8 
 net/ipv6/netfilter/ip6_tables.c                                         |   15 -
 net/ipv6/netfilter/ip6t_eui64.c                                         |    7 
 net/ipv6/netfilter/nft_fib_ipv6.c                                       |    2 
 net/ipv6/sit.c                                                          |    1 
 net/ipv6/syncookies.c                                                   |   11 
 net/ipv6/tcp_ipv6.c                                                     |   37 +--
 net/ipv6/xfrm6_input.c                                                  |    5 
 net/l2tp/l2tp_ppp.c                                                     |   82 ++++--
 net/mac80211/tx.c                                                       |    4 
 net/mptcp/options.c                                                     |   73 ++---
 net/mptcp/pm.c                                                          |   15 -
 net/mptcp/pm_userspace.c                                                |   13 -
 net/mptcp/protocol.c                                                    |   10 
 net/mptcp/protocol.h                                                    |    7 
 net/mptcp/sockopt.c                                                     |    8 
 net/netfilter/ipset/ip_set_bitmap_ipmac.c                               |    5 
 net/netfilter/ipset/ip_set_hash_ipmac.c                                 |    9 
 net/netfilter/ipset/ip_set_hash_mac.c                                   |    5 
 net/netfilter/ipvs/ip_vs_ctl.c                                          |   13 -
 net/netfilter/ipvs/ip_vs_proto_sctp.c                                   |   18 -
 net/netfilter/ipvs/ip_vs_proto_tcp.c                                    |   21 -
 net/netfilter/ipvs/ip_vs_proto_udp.c                                    |   20 -
 net/netfilter/ipvs/ip_vs_sched.c                                        |   14 -
 net/netfilter/nf_conntrack_ecache.c                                     |    2 
 net/netfilter/nf_conntrack_expect.c                                     |   10 
 net/netfilter/nf_conntrack_helper.c                                     |   19 +
 net/netfilter/nf_conntrack_irc.c                                        |    4 
 net/netfilter/nf_conntrack_netlink.c                                    |   28 +-
 net/netfilter/nf_log_syslog.c                                           |   12 
 net/netfilter/nf_nat_core.c                                             |    2 
 net/netfilter/nf_nat_sip.c                                              |    1 
 net/netfilter/nf_synproxy_core.c                                        |   24 +
 net/netfilter/nfnetlink_log.c                                           |   23 +
 net/netfilter/nfnetlink_queue.c                                         |   64 ++++-
 net/netfilter/nft_ct.c                                                  |    8 
 net/netfilter/nft_ct_fast.c                                             |    2 
 net/netfilter/nft_exthdr.c                                              |    3 
 net/netfilter/nft_fib.c                                                 |    6 
 net/netfilter/nft_tunnel.c                                              |    2 
 net/netfilter/xt_NFQUEUE.c                                              |    2 
 net/netfilter/xt_mac.c                                                  |    4 
 net/netlabel/netlabel_unlabeled.c                                       |   30 --
 net/openvswitch/datapath.c                                              |    1 
 net/qrtr/af_qrtr.c                                                      |    4 
 net/rds/ib_cm.c                                                         |    1 
 net/rds/ib_send.c                                                       |    2 
 net/rds/info.c                                                          |    2 
 net/sched/act_api.c                                                     |    7 
 net/sched/act_pedit.c                                                   |   97 ++++---
 net/sctp/diag.c                                                         |   17 -
 net/sctp/input.c                                                        |    8 
 net/sctp/sm_statefuns.c                                                 |    6 
 net/sctp/stream.c                                                       |    6 
 net/smc/af_smc.c                                                        |   17 -
 net/socket.c                                                            |   11 
 net/vmw_vsock/virtio_transport_common.c                                 |   11 
 net/vmw_vsock/vmci_transport.c                                          |    4 
 net/wireless/nl80211.c                                                  |    3 
 net/xfrm/espintcp.c                                                     |    4 
 net/xfrm/xfrm_input.c                                                   |   25 +-
 net/xfrm/xfrm_policy.c                                                  |   13 -
 scripts/Makefile.compiler                                               |    2 
 scripts/generate_rust_target.rs                                         |    8 
 security/integrity/ima/ima_kexec.c                                      |   46 ++-
 sound/core/pcm_native.c                                                 |    7 
 sound/core/seq/seq_dummy.c                                              |   15 -
 sound/core/timer.c                                                      |   17 -
 sound/soc/codecs/wm_adsp.c                                              |    3 
 sound/soc/fsl/fsl_sai.c                                                 |    2 
 tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc |    2 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                         |    4 
 tools/testing/selftests/ptp/testptp.c                                   |   62 -----
 tools/verification/rv/src/in_kernel.c                                   |    2 
 virt/kvm/kvm_main.c                                                     |    3 
 312 files changed, 3057 insertions(+), 1609 deletions(-)

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

Arpith Kalaginanavoor (1):
      fs/qnx6: fix pointer arithmetic in directory iteration

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

Brian Foster (1):
      iomap: don't revert iov_iter on partially completed buffered writes

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

Christian König (1):
      drm/amdgpu: restart the CS if some parts of the VM are still invalidated

Chunhai Guo (1):
      erofs: add sysfs node to drop internal caches

Clément Léger (1):
      io_uring/net: inherit IORING_CQE_F_BUF_MORE across bundle recv retries

Corey Minyard (2):
      ipmi:ssif: Remove unnecessary indention
      ipmi:ssif: NULL thread on error

Cryolitia PukNgae (1):
      Input: atkbd - skip deactivate for HONOR BCC-N's internal keyboard

Cunlong Li (1):
      zram: fix use-after-free in zram_bvec_write_partial()

Damien Le Moal (1):
      block: fix handling of dead zone write plugs

David Carlier (1):
      mm/hugetlb: restore reservation on error in hugetlb folio copy paths

David Thompson (1):
      net: lan743x: permit VLAN-tagged packets up to configured MTU

Davide Ornaghi (1):
      netfilter: nft_fib: fix stale stack leak via the OIFNAME register

Dawei Feng (1):
      octeontx2-af: fix memory leak in rvu_setup_hw_resources()

Deepanshu Kartikey (1):
      wifi: mac80211: limit injected antenna index in ieee80211_parse_tx_radiotap

Dmitry Osipenko (1):
      drm/virtio: Fix driver removal with disabled KMS

Dongli Zhang (1):
      KVM: VMX: Update SVI during runtime APICv activation

Dragos Tatulea (2):
      net/mlx5: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list
      net/mlx5e: xsk: Fix DMA and xdp_frame leak on XDP_TX xmit failure

Dudu Lu (1):
      Bluetooth: bnep: fix incorrect length parsing in bnep_rx_frame() extension handling

Eric Dumazet (9):
      ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
      net_sched: act_pedit: use RCU in tcf_pedit_dump()
      ieee802154: 6lowpan: only accept IPv6 packets in lowpan_xmit()
      tcp: restrict SO_ATTACH_FILTER to priv users
      ip6_vti: fix incorrect tunnel matching in vti6_tnl_lookup()
      vsock/virtio: fix potential unbounded skb queue
      net: introduce EXPORT_IPV6_MOD() and EXPORT_IPV6_MOD_GPL()
      tcp: use EXPORT_IPV6_MOD[_GPL]()
      tcp: secure_seq: add back ports to TS offset

Fernando Fernandez Mancera (2):
      netfilter: xt_NFQUEUE: prefer raw_smp_processor_id
      netfilter: synproxy: add mutex to guard hook reference counting

Florian Westphal (3):
      netfilter: conntrack_irc: fix possible out-of-bounds read
      netfilter: revalidate bridge ports
      netfilter: nft_exthdr: fix register tracking for F_PRESENT flag

Fushuai Wang (1):
      net/mlx5: Use effective affinity mask for IRQ selection

Gabriele Monaco (1):
      tools/rv: Fix cleanup after failed trace setup

Gao Xiang (2):
      erofs: tidy up synchronous decompression
      erofs: fix use-after-free on sbi->sync_decompress

Geetha sowjanya (1):
      octeontx2-pf: Fix NDC sync operation errors

Georgiy Osokin (1):
      tee: shm: fix shm leak in register_shm_helper()

Gil Portnoy (2):
      ksmbd: fix NULL-deref of opinfo->conn in oplock/lease break notifiers
      ksmbd: fix use-after-free of a deferred file_lock on double SMB2_CANCEL

Greg Kroah-Hartman (1):
      Linux 6.12.94

Guangshuo Li (1):
      dm cache policy smq: check allocation under invalidate lock

Guillermo Rodríguez (1):
      i2c: stm32f7: fix timing computation ignoring i2c-analog-filter

HanQuan (1):
      net: add pskb_may_pull() to skb_gro_receive_list()

Hans de Goede (1):
      clk: qcom: x1e80100-dispcc: Stop disp_cc_mdss_mdp_clk_src from getting parked

Harry Wentland (6):
      drm/amd/display: Reject gpio_bitshift >= 32 in bios_parser_get_gpio_pin_info()
      drm/amd/display: Bound VBIOS record-chain walk loops
      drm/amd/display: Clamp HDMI HDCP2 rx_id_list read to buffer size
      drm/amd/display: Clamp VBIOS HDMI retimer register count to array size
      drm/amd/display: Fix NULL deref and buffer over-read in SDP debugfs
      drm/amd/display: Use krealloc_array() in dal_vector_reserve()

Heiko Stuebner (1):
      mmc: dw_mmc-rockchip: Add missing private data for very old controllers

HyeongJun An (1):
      USB: serial: kl5kusb105: fix bulk-out buffer overflow

Hyunwoo Kim (1):
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

Jan Kara (2):
      writeback: Avoid contention on wb->list_lock when switching inodes
      writeback: Fix use after free in inode_switch_wbs_work_fn()

Jann Horn (1):
      fuse: reject fuse_notify() pagecache ops on directories

Jason Gunthorpe (2):
      RDMA: During rereg_mr ensure that REREG_ACCESS is compatible
      RDMA/umem: Fix truncation for block sizes >= 4G

Jassi Brar (1):
      mailbox: Fix NULL message support in mbox_send_message()

Jens Axboe (1):
      io_uring/kbuf: don't truncate end buffer for bundles

Ji'an Zhou (1):
      ALSA: PCM: Fix wait queue list corruption in snd_pcm_drain() on linked streams

Jianbo Liu (1):
      xfrm: hold device only for the asynchronous decryption

Jiayuan Chen (1):
      netfilter: nft_ct: bail out on template ct in get eval

Jisheng Zhang (1):
      mmc: sdhci: add signal voltage switch in sdhci_resume_host

Johan Hovold (3):
      USB: serial: mct_u232: fix memory corruption with small endpoint
      spi: cadence-quadspi: fix unclocked access on unbind
      driver core: reject devices with unregistered buses

Johannes Berg (1):
      wifi: remove zero-length arrays

Joonas Lahtinen (1):
      drm/i915/gem: Fix phys BO pread/pwrite with offset

Judith Mendez (1):
      pinctrl: mcp23s08: Initialize mcp->dev and mcp->addr before regmap init

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

Li RongQing (1):
      dma-debug: fix physical address retrieval in debug_dma_sync_sg_for_device

Lorenzo Bianconi (2):
      net: ethernet: mtk_eth_soc: Fix use-after-free in metadata dst teardown
      net: mvpp2: Add metadata support for xdp mode

Lorenzo Stoakes (1):
      mm/hugetlb: avoid false positive lockdep assertion

Luiz Augusto von Dentz (3):
      Bluetooth: ISO: Fix not releasing hdev reference on iso_conn_big_sync
      Bluetooth: ISO: Fix not using bc_sid as advertisement SID
      Bluetooth: MGMT: Fix backward compatibility with userspace

Manivannan Sadhasivam (2):
      soc: qcom: ice: Return -ENODEV if the ICE platform device is not found
      soc: qcom: ice: Fix race between qcom_ice_probe() and of_qcom_ice_get()

Mark Bloch (1):
      devlink: Release nested relation on devlink free

Mark Rutland (5):
      arm64: tlb: Allow XZR argument to TLBI ops
      arm64: tlb: Optimize ARM64_WORKAROUND_REPEAT_TLBI
      arm64: cputype: Add C1-Ultra definitions
      arm64: cputype: Add C1-Premium definitions
      arm64: errata: Mitigate TLBI errata on various Arm CPUs

Masami Hiramatsu (Google) (1):
      tracing/probes: Point the error offset correctly for eprobe argument error

Matthieu Baerts (NGI0) (2):
      mptcp: sockopt: check timestamping ret value
      mptcp: add-addr: always drop other suboptions

Maxime Chevallier (1):
      net: phy: clean the sfp upstream if phy probing fails

Maíra Canal (1):
      drm/v3d: Fix vaddr leak when indirect CSD has zeroed workgroups

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

Miguel Ojeda (1):
      rust: x86: support Rust >= 1.98.0 target spec

Mingyu Wang (3):
      i2c: dev: prevent integer overflow in I2C_TIMEOUT ioctl
      net: qrtr: fix refcount saturation and potential UAF in qrtr_port_remove
      fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync signaling

Muhammad Bilal (1):
      drm/amdkfd: fix NULL dereference in get_queue_ids()

Mukesh Ojha (1):
      misc: fastrpc: Fix NULL pointer dereference in rpmsg callback

Naveen Kumar Chaudhary (1):
      time: Fix off-by-one in settimeofday() usec validation

Nicolò Coccia (1):
      net/smc: fix sleep-inside-lock in __smc_setsockopt() causing local DoS

Nikolay Kuratov (1):
      net/mlx5: Reorder completion before putting command entry in cmd_work_handler

Nithin Dabilpuram (1):
      octeontx2-af: npc: Fix CPT channel mask in npc_install_flow

Oscar Maes (1):
      pcnet32: stop holding device spin lock during napi_complete_done

Pablo Neira Ayuso (1):
      netfilter: ctnetlink: ensure safe access to master conntrack

Paolo Abeni (4):
      mptcp: fix retransmission loop when csum is enabled
      mptcp: close TOCTOU race while computing rcv_wnd
      mptcp: allow subflow rcv wnd to shrink
      mptcp: fix missing wakeups in edge scenarios

Pengyu Luo (1):
      clk: qcom: dispcc-sc8280xp: Don't park mdp_clk_src at registration time

Petr Machata (1):
      Revert "selftest/ptp: update ptp selftest to exercise the gettimex options"

Priya Hosur (1):
      drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in set_soft_freq_limited_range

Qi Tang (1):
      xfrm: hold dev ref until after transport_finish NF_HOOK

Raf Dickson (1):
      vsock/vmci: fix sk_ack_backlog leak on failed handshake

Rajat Gupta (1):
      net/sched: fix pedit partial COW leading to page cache corruption

Randy Dunlap (1):
      RDMA/umem: fix kernel-doc warnings

Richard Fitzgerald (1):
      ASoC: wm_adsp: Fix NULL dereference when removing firmware controls

Robert Marko (1):
      net: phy: micrel: fix LAN8814 QSGMII soft reset

Rosen Penev (1):
      net: ibm: emac: Fix use-after-free during device removal

Rui Qi (1):
      ipmi: Fix rcu_read_unlock to srcu_read_unlock in handle_read_event_rsp

Ruoyu Wang (1):
      gpio: zynq: fix runtime PM leak on remove

Russell King (Oracle) (4):
      ARM: group is_permission_fault() with is_translation_fault()
      ARM: allow __do_kernel_fault() to report execution of memory faults
      ARM: fix hash_name() fault
      ARM: fix branch predictor hardening

Sanghyun Park (1):
      xfrm: policy: fix use-after-free on inexact bin in xfrm_policy_bysel_ctx()

Sean Christopherson (2):
      KVM: Don't WARN if memory is dirtied without a vCPU when the VM is dying
      KVM: SEV: Decouple the need to sync the GHCB SA from the need to free the SA

Sechang Lim (1):
      udp: clear skb->dev before running a sockmap verdict

SeongJae Park (1):
      mm/damon/ops-common: call folio_test_lru() after folio_get()

SeungJu Cheon (2):
      Bluetooth: RFCOMM: validate skb length in MCC handlers
      Bluetooth: ISO: Fix data-race on iso_pi fields in hci_get_route calls

Shanker Donthineni (2):
      arm64: cputype: Add NVIDIA Olympus definitions
      arm64: errata: Mitigate TLBI errata on NVIDIA Olympus CPU

Stefano Garzarella (2):
      vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
      vsock/virtio: fix skb overhead overflow on 32-bit builds

Steven Chen (2):
      ima: kexec: skip IMA segment validation after kexec soft reboot
      ima: kexec: move IMA log copy from kexec load to execute

Suman Ghosh (1):
      octeontx2-af: Fix initialization of mcam's entry2target_pffunc field

Takashi Iwai (2):
      ALSA: timer: Forcibly close timer instances at closing
      ALSA: timer: Fix UAF at snd_timer_user_params()

Tangudu Tilak Tirumalesh (1):
      drm/xe: Clear pending_disable before signaling suspend fence

Tao Cui (2):
      selftests: mptcp: add test for extra_subflows underflow on userspace PM
      mptcp: pm: fix extra_subflows underflow on userspace PM subflow creation

Tapio Reijonen (1):
      net: fec: fix pinctrl default state restore order on resume

Tejun Heo (1):
      sched_ext: Don't warn on NULL cgrp_moving_from in scx_cgroup_move_task()

Til Kaiser (4):
      net: mvpp2: sync RX data at the hardware packet offset
      net: mvpp2: limit XDP frame size to the RX buffer
      net: mvpp2: refill RX buffers before XDP or skb use
      net: mvpp2: build skb from XDP-adjusted data on XDP_PASS

Tristan Madani (1):
      netfilter: nft_tunnel: fix use-after-free on object destroy

Vladimir Zapolskiy (1):
      i2c: qcom-cci: Fix NULL pointer dereference in cci_remove()

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

Xiang Mei (1):
      netfilter: nf_log: validate MAC header was set before dumping it

Xin Long (1):
      sctp: purge outqueue on stale COOKIE-ECHO handling

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

Yin Tirui (1):
      mm/huge_memory: update file PMD counter before folio_put()

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

Zhang Cen (3):
      Bluetooth: RFCOMM: hold listener socket in rfcomm_connect_ind()
      Bluetooth: MGMT: validate advertising TLV before type checks
      Bluetooth: bnep: reject short frames before parsing

Zhao Zhang (1):
      sctp: diag: reject stale associations in dump_one path

ZhaoJinming (1):
      net: bonding: fix NULL pointer dereference in bond_do_ioctl()

Zhengchuan Liang (1):
      netfilter: require Ethernet MAC header before using eth_hdr()

Zhenghang Xiao (1):
      misc: fastrpc: fix use-after-free race in fastrpc_map_create

