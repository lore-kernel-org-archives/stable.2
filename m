Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FD8518130;
	Thu, 15 Oct 2026 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060685; cv=none; b=SFIPFdWlPASykrs4xTtqn5dvpbL7p5juaAFrBQfw2hcLzMBgfgSNPsfzRT5kDGzsLDDBuAM6lw6ZBoFE3h8+baiRJnylb/GdB3JGSUMb38Ouchc5v889znOyZimEovs6VXjSsGXbz+ohNLYXJXUydKV04oi8+xjplHbLK7GEY4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060685; c=relaxed/simple;
	bh=iQw4UC/g51TqWMZFF+Z898u04CZ6DQG38ZvRKzwRdPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Erpoe+1XbQY5KZjSmhHhhxNwByZrB8+8X3uC0R/iAjaCu6GFMyibzwQy50H3ASK3U/ah3e3NEM51LaZxA53Emhc2yWV8TMB+mFTaUt4BxY7ZGNLj2zoAaPIdn3NyiyKORR28897i/25fZAXVbQRY1iFBXU7TDQbH780Df6+Rqvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XY8lV/Jv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XY8lV/Jv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BA21F000C7;
	Thu, 15 Oct 2026 10:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792060682;
	bh=i/hLH/+rm7+WpIljpotDllrR14CkZSk03D6jKTAefPY=;
	h=From:To:Cc:Subject:Date;
	b=XY8lV/JvGLZ9qaynq26GWCUxpeR4URES+CWefoY2+yuwjZYrCSTl1C9E2X3dH7qna
	 1PTRBsIQ7b85P3fk2dnqKmSwRp9Fff62bWhKi7RFsZYDc/G5fGQO7udlZ9RW9MvEUT
	 BcehrPhcSOBvcghgfxOcSYOeJ0kaqjz6KmhyV/GI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.2.11
Date: Thu, 15 Oct 2026 12:37:55 +0200
Message-ID: <2026101556-negate-tackle-1db4@gregkh>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.2.11 kernel.

All users of the 7.2 kernel series must upgrade.

The updated 7.2.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.2.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/networking/strparser.rst                         |    2 
 Makefile                                                       |    2 
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi                 |   19 
 arch/arm64/include/asm/el2_setup.h                             |    5 
 arch/arm64/kernel/Makefile                                     |    3 
 arch/riscv/Kconfig                                             |    5 
 arch/riscv/Kconfig.errata                                      |    1 
 arch/riscv/include/asm/futex.h                                 |    2 
 arch/riscv/include/asm/scs.h                                   |   17 
 arch/riscv/include/asm/vector.h                                |    8 
 arch/riscv/include/uapi/asm/vendor/mips.h                      |    4 
 arch/riscv/kernel/entry.S                                      |    2 
 arch/riscv/kernel/patch.c                                      |    2 
 arch/riscv/kernel/ptrace.c                                     |    8 
 arch/riscv/lib/strnlen.S                                       |   20 
 arch/riscv/mm/extable.c                                        |    4 
 arch/um/drivers/vector_transports.c                            |    1 
 arch/x86/include/asm/cpufeatures.h                             |    3 
 arch/x86/include/asm/tlb.h                                     |    6 
 arch/x86/kernel/cpu/amd.c                                      |    4 
 drivers/android/binder/node.rs                                 |   20 
 drivers/android/binder/node/wrapper.rs                         |   34 +
 drivers/ata/libata-scsi.c                                      |   13 
 drivers/block/zloop.c                                          |   31 -
 drivers/bluetooth/btintel_pcie.c                               |   17 
 drivers/clk/qcom/gcc-eliza.c                                   |    6 
 drivers/clk/qcom/gcc-kaanapali.c                               |    6 
 drivers/clk/qcom/gpucc-glymur.c                                |    2 
 drivers/clk/qcom/gpucc-kaanapali.c                             |    2 
 drivers/edac/amd64_edac.c                                      |    4 
 drivers/gpio/gpio-exar.c                                       |    2 
 drivers/gpio/gpio-mpsse.c                                      |   24 
 drivers/gpio/gpio-xilinx.c                                     |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                     |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                    |   77 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                        |   17 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                        |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c                      |   13 
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c                     |    9 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c          |   32 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                          |    7 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |   26 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c        |   20 
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c                        |    5 
 drivers/gpu/drm/bridge/th1520-dw-hdmi.c                        |    8 
 drivers/gpu/drm/display/drm_dp_helper.c                        |    4 
 drivers/gpu/drm/drm_bridge.c                                   |    8 
 drivers/gpu/drm/drm_fb_helper.c                                |    6 
 drivers/gpu/drm/gud/gud_pipe.c                                 |    1 
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c                 |    2 
 drivers/gpu/drm/i915/gt/intel_rps.c                            |    3 
 drivers/gpu/drm/imagination/pvr_mmu.c                          |   25 
 drivers/gpu/drm/imagination/pvr_vm.c                           |    8 
 drivers/gpu/drm/panthor/panthor_sched.c                        |    3 
 drivers/gpu/drm/vc4/vc4_bo.c                                   |    5 
 drivers/gpu/drm/vc4/vc4_drv.c                                  |    5 
 drivers/gpu/drm/vc4/vc4_drv.h                                  |    2 
 drivers/gpu/drm/vc4/vc4_gem.c                                  |    8 
 drivers/gpu/drm/vc4/vc4_irq.c                                  |   24 
 drivers/gpu/drm/vc4/vc4_v3d.c                                  |   65 +-
 drivers/gpu/drm/vc4/vc4_validate.c                             |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c                   |   26 -
 drivers/gpu/drm/xe/display/xe_fb_pin.c                         |    6 
 drivers/gpu/drm/xe/xe_bo.c                                     |  139 ++++-
 drivers/gpu/drm/xe/xe_bo.h                                     |    2 
 drivers/gpu/drm/xe/xe_i2c.c                                    |    5 
 drivers/gpu/drm/xe/xe_lrc.c                                    |   38 -
 drivers/gpu/drm/xe/xe_mmio.c                                   |    5 
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c                        |   16 
 drivers/hid/hid-steam.c                                        |  246 ++++-----
 drivers/input/joystick/xpad.c                                  |    4 
 drivers/input/misc/ati_remote2.c                               |   12 
 drivers/iommu/dma-iommu.c                                      |    4 
 drivers/md/dm-crypt.c                                          |    7 
 drivers/md/dm-integrity.c                                      |    4 
 drivers/md/dm-ioctl.c                                          |   14 
 drivers/md/dm-snap.c                                           |   14 
 drivers/memstick/core/memstick.c                               |    8 
 drivers/memstick/host/rtsx_usb_ms.c                            |   31 -
 drivers/mmc/host/cavium-octeon.c                               |    5 
 drivers/mmc/host/cavium-thunderx.c                             |    5 
 drivers/mmc/host/mtk-sd.c                                      |    1 
 drivers/mmc/host/sdhci-sprd.c                                  |    4 
 drivers/net/amt.c                                              |   48 -
 drivers/net/bareudp.c                                          |    3 
 drivers/net/bonding/bond_main.c                                |    8 
 drivers/net/can/dev/skb.c                                      |    4 
 drivers/net/can/usb/f81604.c                                   |    2 
 drivers/net/can/vxcan.c                                        |    3 
 drivers/net/dsa/microchip/ksz_common.h                         |    2 
 drivers/net/ethernet/airoha/airoha_eth.c                       |   32 +
 drivers/net/ethernet/airoha/airoha_eth.h                       |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                      |  189 ++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                      |    1 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c             |   11 
 drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c |    4 
 drivers/net/ethernet/google/gve/gve_main.c                     |    8 
 drivers/net/ethernet/google/gve/gve_rx_dqo.c                   |   13 
 drivers/net/ethernet/ibm/ibmveth.c                             |   22 
 drivers/net/ethernet/intel/e1000e/netdev.c                     |    7 
 drivers/net/ethernet/intel/iavf/iavf.h                         |   11 
 drivers/net/ethernet/intel/iavf/iavf_main.c                    |   85 ++-
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c                |   99 +++
 drivers/net/ethernet/intel/ice/devlink/port.c                  |    2 
 drivers/net/ethernet/intel/ice/ice_eswitch.c                   |    2 
 drivers/net/ethernet/intel/ice/ice_txrx.c                      |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c            |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                |   13 
 drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c        |   20 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c              |   79 ++-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c                |   24 
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h                 |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c             |   10 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c          |    9 
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c             |   28 -
 drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c     |    1 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c              |   15 
 drivers/net/ethernet/xilinx/xilinx_axienet.h                   |    7 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c              |   51 +-
 drivers/net/pfcp.c                                             |    7 
 drivers/net/team/team_core.c                                   |   16 
 drivers/net/team/team_mode_broadcast.c                         |    2 
 drivers/net/tun.c                                              |   23 
 drivers/net/usb/ax88179_178a.c                                 |    6 
 drivers/net/veth.c                                             |    1 
 drivers/net/virtio_net.c                                       |    2 
 drivers/net/wireguard/noise.c                                  |    7 
 drivers/net/wireguard/queueing.h                               |    2 
 drivers/net/wireless/ath/ath12k/core.c                         |   33 -
 drivers/net/wireless/ath/ath12k/core.h                         |    3 
 drivers/net/wireless/ath/ath12k/hif.h                          |    9 
 drivers/net/wireless/ath/ath12k/pci.c                          |    8 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c        |   27 -
 drivers/net/wireless/marvell/libertas/tx.c                     |    7 
 drivers/net/wireless/mediatek/mt76/mt76.h                      |   10 
 drivers/net/wireless/mediatek/mt76/mt7603/init.c               |    1 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h           |    1 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c               |    6 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c               |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c                |    3 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c               |   12 
 drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c           |  128 +++--
 drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h           |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/init.c               |    3 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c               |   10 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                |    3 
 drivers/net/wireless/mediatek/mt76/tx.c                        |   89 +++
 drivers/net/xen-netfront.c                                     |    4 
 drivers/nvme/target/core.c                                     |    2 
 drivers/nvme/target/pr.c                                       |    4 
 drivers/pmdomain/imx/imx8m-blk-ctrl.c                          |   15 
 drivers/pmdomain/rockchip/pm-domains.c                         |   20 
 drivers/power/sequencing/pwrseq-pcie-m2.c                      |    2 
 drivers/ptp/ptp_ocp.c                                          |    2 
 drivers/regulator/ltc3676.c                                    |   15 
 drivers/regulator/of_regulator.c                               |   24 
 drivers/regulator/tps6594-regulator.c                          |    6 
 drivers/scsi/ch.c                                              |   29 -
 drivers/scsi/qedi/qedi_main.c                                  |    3 
 drivers/spi/spi-nxp-fspi.c                                     |   22 
 drivers/spi/spi-sg2044-nor.c                                   |   56 +-
 drivers/tee/optee/ffa_abi.c                                    |   38 +
 drivers/tee/optee/optee_msg.h                                  |    4 
 drivers/tee/optee/smc_abi.c                                    |   17 
 drivers/tee/tee_shm.c                                          |    4 
 drivers/ufs/core/ufs-mcq.c                                     |   30 -
 drivers/ufs/core/ufshcd.c                                      |   53 +-
 drivers/ufs/host/ufs-mediatek.c                                |   18 
 fs/btrfs/inode.c                                               |    7 
 fs/btrfs/ioctl.c                                               |   31 -
 fs/btrfs/scrub.c                                               |    4 
 fs/btrfs/xattr.c                                               |   15 
 fs/dcache.c                                                    |    4 
 fs/fcntl.c                                                     |    3 
 fs/fs_context.c                                                |    4 
 fs/inode.c                                                     |   23 
 fs/mount.h                                                     |    6 
 fs/namei.c                                                     |   29 +
 fs/namespace.c                                                 |  254 +++++++---
 fs/nullfs.c                                                    |    4 
 fs/pnode.c                                                     |  108 +++-
 fs/verity/fsverity_private.h                                   |   15 
 fs/verity/open.c                                               |   13 
 fs/xfs/libxfs/xfs_exchmaps.c                                   |  103 ----
 fs/xfs/libxfs/xfs_log_format.h                                 |    4 
 fs/xfs/xfs_bmap_util.c                                         |   15 
 fs/xfs/xfs_exchrange.c                                         |   51 +-
 include/linux/can/core.h                                       |    3 
 include/linux/can/skb.h                                        |    4 
 include/linux/io_uring_types.h                                 |    2 
 include/linux/mount.h                                          |    2 
 include/linux/nsproxy.h                                        |    1 
 include/linux/nvme.h                                           |    4 
 include/linux/sched/ext.h                                      |    1 
 include/linux/virtio_net.h                                     |   60 --
 include/net/amt.h                                              |    4 
 include/net/bluetooth/rfcomm.h                                 |    1 
 include/net/can.h                                              |    2 
 include/net/cfg80211.h                                         |    1 
 include/net/ip.h                                               |    7 
 include/net/mac80211.h                                         |   14 
 include/net/strparser.h                                        |   10 
 io_uring/io_uring.c                                            |   13 
 io_uring/kbuf.c                                                |    6 
 io_uring/memmap.c                                              |   45 +
 io_uring/memmap.h                                              |    2 
 io_uring/net.c                                                 |    4 
 io_uring/register.c                                            |   21 
 io_uring/zcrx.c                                                |    2 
 kernel/cgroup/cpuset.c                                         |   40 +
 kernel/dma/swiotlb.c                                           |    6 
 kernel/fork.c                                                  |    3 
 kernel/nsproxy.c                                               |    2 
 kernel/sched/ext/ext.c                                         |   25 
 kernel/sched/ext/internal.h                                    |    5 
 kernel/sched/sched.h                                           |    1 
 kernel/workqueue.c                                             |    2 
 lib/dim/dim.c                                                  |   10 
 mm/mremap.c                                                    |   70 ++
 mm/pgtable-generic.c                                           |   20 
 mm/vma.c                                                       |   21 
 mm/vma.h                                                       |    7 
 net/bluetooth/hci_core.c                                       |    4 
 net/bluetooth/hci_sock.c                                       |    2 
 net/bluetooth/hci_sync.c                                       |   10 
 net/bluetooth/iso.c                                            |   52 +-
 net/bluetooth/mgmt.c                                           |    2 
 net/bluetooth/rfcomm/core.c                                    |  134 +++--
 net/bluetooth/rfcomm/sock.c                                    |    5 
 net/bluetooth/rfcomm/tty.c                                     |    2 
 net/bluetooth/sco.c                                            |   87 ++-
 net/bridge/br_multicast.c                                      |   23 
 net/bridge/netfilter/nf_conntrack_bridge.c                     |   10 
 net/can/af_can.c                                               |   47 +
 net/can/gw.c                                                   |    3 
 net/can/isotp.c                                                |   16 
 net/can/raw.c                                                  |   10 
 net/core/dev.c                                                 |   11 
 net/core/flow_dissector.c                                      |   11 
 net/core/skbuff.c                                              |    6 
 net/devlink/core.c                                             |   10 
 net/ipv4/cipso_ipv4.c                                          |    8 
 net/ipv4/fib_semantics.c                                       |    3 
 net/ipv4/fib_trie.c                                            |    2 
 net/ipv4/ip_output.c                                           |   10 
 net/ipv4/route.c                                               |    5 
 net/ipv4/tcp.c                                                 |    2 
 net/ipv4/udp.c                                                 |   11 
 net/ipv6/ip6_gre.c                                             |    7 
 net/ipv6/route.c                                               |    4 
 net/ipv6/udp.c                                                 |   13 
 net/mac80211/debugfs.c                                         |   13 
 net/mac80211/ieee80211_i.h                                     |    2 
 net/mac80211/main.c                                            |    1 
 net/mac80211/sta_info.c                                        |   17 
 net/mac80211/sta_info.h                                        |    3 
 net/mac80211/status.c                                          |    5 
 net/mac80211/tx.c                                              |   70 +-
 net/netfilter/nfnetlink_queue.c                                |    7 
 net/netfilter/xt_CHECKSUM.c                                    |    6 
 net/openvswitch/actions.c                                      |    7 
 net/openvswitch/datapath.c                                     |    8 
 net/packet/af_packet.c                                         |   28 -
 net/sched/cls_route.c                                          |    6 
 net/sched/em_text.c                                            |    3 
 net/sctp/socket.c                                              |    6 
 net/smc/af_smc.c                                               |    7 
 net/strparser/strparser.c                                      |    6 
 net/tipc/node.c                                                |   10 
 net/tipc/topsrv.c                                              |   80 ++-
 net/vmw_vsock/af_vsock.c                                       |    2 
 net/vmw_vsock/virtio_transport_common.c                        |    4 
 net/xfrm/xfrm_output.c                                         |   16 
 security/keys/key.c                                            |    6 
 security/keys/persistent.c                                     |   55 +-
 security/selinux/avc.c                                         |    5 
 security/selinux/hooks.c                                       |    9 
 sound/hda/codecs/side-codecs/tas2781_hda.c                     |   18 
 sound/pci/ctxfi/ctdaio.c                                       |    6 
 sound/soc/amd/yc/acp6x-mach.c                                  |    7 
 sound/soc/codecs/adau1372.c                                    |   18 
 sound/soc/samsung/i2s.c                                        |    8 
 sound/soc/sdw_utils/soc_sdw_utils.c                            |   35 +
 tools/testing/selftests/mm/hugetlb-mmap.c                      |    4 
 tools/testing/vma/tests/vma.c                                  |    4 
 285 files changed, 3402 insertions(+), 1600 deletions(-)

Aaron Ma (1):
      wifi: mt76: mt7925: restore the legacy BSS after MLO teardown

Abhishek Ojha (1):
      regulator: ltc3676: don't read the write-only HRST and CLIRQ registers

Adrian Betschart (1):
      drm/amd/display: Don't replace a sink mode that shares the native totals

Ahmed Abdelhaleem Ahmed (1):
      scsi: ch: Do not keep references to data transfer element devices

Alan Previn (1):
      drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep maximums

Aldo Ariel Panzardo (1):
      Bluetooth: SCO: serialise sco_conn lifetime against sco_recv_scodata()

Alex Deucher (1):
      drm/amdgpu: make Mac FB workaround generic

Alexey Charkov (2):
      power: sequencing: pcie-m2: Fix leaking array from of_regulator_bulk_get_all()
      regulator: of: fill in supply names in of_regulator_bulk_get_all()

Ali Ahmet Memis (1):
      io_uring/memmap: account the pages a compound region really uses

Alice Ryhl (1):
      rust_binder: reschedule node refcount update on thread exit

Alvin Šipraga (2):
      ASoC: adau1372: allow sleepy powerdown GPIOs
      ASoC: adau1372: fix invalid default state of output ASRC and DAC muxes

Aurelien Jarno (1):
      riscv: vector: Fix output operands in context save

Ben Cressey (2):
      dm-crypt: reject the lmk IV mode with AEAD ciphers
      dm-integrity: fix buffer overflow in inline mode with large tag size

Bihaan Sen (1):
      Input: xpad - add support for 8BitDo Pro 2 Wired Controller for Xbox

Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Fix AMD TLBI Erratum #1718

Bryan Fraschetti (1):
      ice: Restore Ordered MMIO Writes for Tx Doorbells

Carlos Llamas (1):
      selftests/mm: cleanup -Wformat issues in hugetlb-mmap

Chen Pei (1):
      riscv: ptrace: reject CFI regset access when extensions are absent

Chengfeng Ye (6):
      tipc: hold a reference to nodes found by link name
      net/smc: protect clcsock lifetime in smc_getname
      Bluetooth: hci_sock: Serialize dead-device detachment
      Bluetooth: hci_sync: Fix command skb lifetime during scan setup
      Bluetooth: ISO: Reject concurrent BIS listener setup
      Bluetooth: ISO: Serialize concurrent connect calls

Christian Brauner (29):
      mount: keep a copied mount unbindable
      fs: don't silently unmount busy mounts
      namespace: reset the old parent's ->overmount in mnt_change_mountpoint()
      statmount: read the parent of an unmounted mount under mount_lock
      namespace: don't inherit MNT_UMOUNT in clone_mnt()
      namespace: don't copy an unmounted mount tree
      fs: refuse fspick() on internal superblocks
      namespace: check the target before walking it in do_mount_setattr()
      namespace: queue a mount only once for mount notifications
      namespace: check a submount for references right before unmounting it
      namespace: check a recursive bind mount for mount namespace loops
      namespace: keep covered mounts covered in OPEN_TREE_NAMESPACE
      namespace: look at the topmost mount for a mount namespace file
      namespace: don't reconfigure internal superblocks via remount and umount
      namespace: remove the fsnotify marks of a mount namespace in process context
      namespace: check the mounts before reading their parents in pivot_root()
      dcache: don't put a mountpoint on a dentry that's being removed
      unshare: don't drop active namespace references that were never taken
      namespace: don't let a pseudo dentry become the root of a mount
      namespace: unhash a dentry before detaching the mounts on it
      namei: don't reveal overmounted entries in refwalk
      fcntl: refuse F_SET_RW_HINT on an immutable inode
      namespace: refuse an automount below a mount that is in no namespace
      nullfs: don't update the access time
      namespace: never expire a locked mount
      namespace: handle mount locking for automounts correctly
      namespace: keep the lock on a mount that a propagated copy is moved beneath
      mount: refuse MOVE_MOUNT_SET_GROUP on an unbindable mount
      fs: don't let a migrating task hide its reference from do_umount()

Christian Göttsche (1):
      selinux: fix data race on AVC latest_notif

Cristian Ciocaltea (2):
      drm/bridge: Fix unlocked list_del in drm_bridge_add()
      drm/bridge: Fix unlocked list access in drm_bridge_attach()

Cristian Papa (1):
      wifi: mt76: mt7603: initialize global station WCID

Daehyeon Ko (9):
      ipv4: stop PMTU walk when nexthop group shrinks
      ipv4: stop exception dump when nexthop group shrinks
      ipv4: stop route notification sizing when nexthop group shrinks
      ipv4: do not warn on route notification size race
      ipv6: do not warn on route notification size race
      cipso: adjust cached option offsets when removing CIPSO
      vsock/virtio: account only unread bytes in read_skb()
      tcp: reject net_iov in zerocopy receive mapping hints
      ip6_gre: remove obsolete ERSPAN PMTU update

Daniel Machon (1):
      net: sparx5: free the matchall entry on destroy

Darrick J. Wong (1):
      xfs: fix exchange-range-to-eof file size exchange

Denis V. Lunev (1):
      openvswitch: fix soft lockup in the netlink flow dump

Devin Wittmayer (2):
      wifi: mt76: mt7925: don't put the band auto marker in TGID
      wifi: mt76: mt792x: pick the SAR table layout from the table itself

Eric Biggers (1):
      fsverity: RCU-delay the freeing of struct fsverity_info

Eric Dumazet (4):
      bnxt_en: fix DMA mapping length for padded small packets
      flow_dissector: avoid u16 truncation of skb->len when computing thoff
      net: always dissect GSO packets in __virtio_net_hdr_to_skb()
      flow_dissector: avoid u16 truncation of hlen in bpf_flow_dissect()

Eugene Gvozdetsky (1):
      io_uring/register: don't exempt disabled rings from task restrictions

Fan Wu (3):
      gpio: mpsse: fix race when arming the IRQ poll worker
      drm/vc4: drain the hangcheck timer and works on V3D unbind
      drm/xe/i2c: cancel the client work on remove

Felix Fietkau (7):
      wifi: mt76: mt7996: program a link again if the driver holds it
      wifi: mt76: mt7996: take over connection monitoring
      wifi: mac80211: add AQL support for multicast packets
      wifi: mac80211: add ieee80211_txq_aql_pending()
      wifi: mt76: add PS buffering support for HW-managed TIM drivers
      wifi: mt76: account non-AQL frames per peer rather than per link
      wifi: mt76: use ALTX queue for packets to disassociated stations

Felix Gu (2):
      drm/bridge: th1520-dw-hdmi: Fix error check on dw_hdmi_probe() return value
      drm/bridge: th1520-dw-hdmi: Fix remove() callback

Fernando Fernandez Mancera (1):
      net: openvswitch: validate transport header presence in set_ipv6_addr

Filipe Manana (2):
      btrfs: fix xattr replace when multiple xattrs are packed in the same item
      btrfs: fix lost error return value in btrfs_listxattr()

Fredrik Nyberg (1):
      net: usb: ax88179_178a: fix rx frame length for non-last packets

Fuad Tabba (1):
      arm64/boot: Don't set PMUv3p9 FGT2 bits without PMUv3

Georgiy Osokin (1):
      tee: shm: reject zero-sized allocations in tee_dyn_shm_alloc_helper()

Greg Kroah-Hartman (1):
      Linux 7.2.11

Guangshuo Li (3):
      mmc: cavium-octeon: destroy slot platform devices on remove
      mmc: cavium-thunderx: destroy slot platform devices on remove
      mmc: sdhci-sprd: disable runtime PM on remove

Guixin Liu (1):
      nvmet: return Invalid Field for invalid NSIDs feature 82h

Gyeyoung Baek (2):
      drm/imagination: Size page table preallocation by device address
      drm/imagination: Fix reference and vm_bo handling in remap()

Haibo Chen (1):
      spi: spi-nxp-fspi: exit stop mode before waiting for DLL lock

Haishuang Yan (3):
      devlink: fix devlink_rel reference leak when notify work is pending
      pfcp: make sure the SEID is linear before reading it
      bareudp: set the inner protocol to the protocol of the packet

Han Gao (2):
      spi: sg2044-nor: Return transfer errors
      spi: sg2044-nor: Honor SPI clock limits

Haojie Li (1):
      drm/amdkfd: fix dma_buf reference leak in get_dmabuf_info

Haotian Zhang (1):
      Input: ati_remote2 - fix type confusion in device attribute handlers

Harin Lee (1):
      ALSA: ctxfi: Fix memory leakage when clearing DAO input mappers

Hengyu Liang (2):
      ata: libata-scsi: do not lose CHECK CONDITION for failed ATAPI commands
      io_uring: do not charge the SQ/CQ rings to RLIMIT_MEMLOCK

Hui Peng (1):
      sctp: copy zeroed stats to user in sctp_getsockopt_pr_streamstatus() when !streamoute

Iaroslav Voitovych (1):
      Bluetooth: MGMT: Fix status of pending commands flushed on power off

Ido Schimmel (3):
      ipv6: Fix redirect exception creation for UDP/RAW sockets
      ipv4: udp: Create exceptions before socket matching
      ipv6: udp: Create exceptions before socket matching

Ilia Gavrilov (1):
      vsock: Fix memory leak in vmci_transport_recv_dgram_cb()

Jakub Kicinski (3):
      bonding: fix the program leak when XDP is replaced
      net: make dev_xdp_sb_prog_count() see programs attached through a link
      Revert "net: stmmac: propagate PTP addend and system time programming errors"

Jamal Hadi Salim (1):
      net/sched: em_text: reject unterminated algo before autoload

Jason A. Donenfeld (1):
      wireguard: noise: reject response consumption after intermediate initiation

Jens Axboe (1):
      io_uring/kbuf: don't charge provided buffer rings to RLIMIT_MEMLOCK

Jerome Tollet (2):
      net/mlx5e: Prevent stale XSK buffer release on refill retry
      net/mlx5e: Prevent stale XSK buffer release on MPWQE refill retry

Jesse Zhang (2):
      drm/amdgpu/userq: only accept doorbell BOs as queue doorbell
      drm/amdgpu/userq: return the memdup_user() error for the user MQD

Ji-Ze Hong (Peter Hong) (1):
      usb: f81604: fix struct f81604_int_data size mismatch

Johannes Berg (1):
      Revert "wifi: libertas: reject short monitor TX frames"

Jose Ignacio Tornos Martinez (1):
      iavf: send MAC change request synchronously

Josef Bacik (2):
      xen/netfront: don't leak the skb when xennet_fill_frags() fails
      net: skbuff: don't leave stale bytes in skb_copy_and_csum_bits()

Joshua Washington (3):
      gve: fix napi_disable deadlock when attempting to disable XSK pools
      gve: fix XSK buffer leak when rings are stopped
      gve: fix XSK buffer leak on error descriptor

Junjie Cao (1):
      wifi: mt76: mt792x: treat 0xff ACPI SAR entries as no limit

Justin Chen (1):
      net: bcmgenet: if UMAC was suspended in SW_RESET, restore it to SW_RESET

Karl Bonde Torp (1):
      nvme: fix swapped ZRASF zone state values for full and read only

Karl Mehltretter (3):
      arm64: irq: exclude the softirq stack switch from KCOV
      keys: finalize persistent keyring timeout after link attempt
      riscv: fix load_unaligned_zeropad() fixup for RV32

Krzysztof Furman (1):
      Input: xpad - add support for Corsair Novablade Pro

Krzysztof Karas (2):
      drm/i915/gem: Prevent overstepping exec array boundary
      drm/i915/gt: Unmask interrupts only when ACTIVE is true

Kuba Piecuch (2):
      sched_ext: Generate qseq from a per-task counter
      sched_ext: Call ops.dequeue() when a task arrives on a remote local DSQ

Leo Li (2):
      drm/amd/display: Fix direct scanout alpha on some DRM_FORMATs
      drm/amd/display: disable self-refresh on tearing flips

Leo Yu-Chi Liang (1):
      riscv: fix NR_CPUS range leaking 64-bit default onto 32-bit builds

Leto Liu (刘涛) (1):
      net: airoha: Add retry mechanism to airoha_qdma_set_trtcm_param()

Li RongQing (1):
      net/mlx5e: Order ICOSQ cc update after CQ doorbell

Lorenzo Bianconi (1):
      net: stmmac: propagate PTP addend and system time programming errors

Lorenzo Stoakes (ARM) (2):
      mm/mremap: fix locked_vm leak by splitting VMA for MREMAP_DONTUNMAP
      mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP self-merge

Lu Huang (1):
      wifi: mt76: mt7996: fix uninitialized buf read in mt7996_variant_fem_init()

Luca Weiss (2):
      clk: qcom: gcc-eliza: Fix always-enabling PCIE_RSCC clocks
      clk: qcom: gcc-kaanapali: Fix always-enabling PCIE_RSCC clocks

Ma Xinmeng (1):
      dm-snap: reject the transient exception store for snapshot-merge

Mahantesh Salimath (1):
      tee: optee: ffa: support shared memory offsets on large-page kernels

Mallesh Koujalagi (1):
      drm/xe/sysctrl: Fix mailbox header handling

Marek Szyprowski (2):
      swiotlb: fix default_swiotlb_limit() for non-growable default pool
      ASoC: samsung: i2s: enable op_clk in probe to balance runtime PM

Matthew Wilcox (Oracle) (1):
      fs: Free any excess xarray nodes in clear_inode()

Maxim Skokov (1):
      Bluetooth: RFCOMM: free the skb when the DLC has no owner

Maíra Canal (4):
      drm/vc4: Free the BO cache size list on teardown
      drm/vc4: Use kvmalloc_objs() for the BO cache size list
      drm/vc4: Disable the V3D interrupt across runtime suspend
      drm/vc4: Fix binner slot allocation failing on an idle GPU

Michael Chan (2):
      bnxt_en: Add bnxt_clear_bars() helper
      bnxt_en: Fix driver init in kdump kernel

Michael Garland (1):
      ASoC: amd: yc: Add DMI quirk for Acer Aspire Go 15 (AG15-21P)

Michael S. Tsirkin (1):
      ipv4: validate checksum_start before completing checksum

Michele Dionisio (1):
      wifi: brcmfmac: fix P2P device removal race in brcmf_detach()

Mikhail Gavrilov (3):
      mm: don't schedule deferred kernel page table freeing while booting
      Bluetooth: RFCOMM: connect the session socket without rfcomm_mutex
      drm/amdgpu: copy debugfs register data outside the GRBM/SRBM locks

Mikulas Patocka (1):
      dm: fix reading free memory in do_resume

Ming Qian (1):
      pmdomain: imx8m-blk-ctrl: Serialize power on/off across sibling domains

Mingming Cao (2):
      ibmveth: h_free logical LAN on open-fail after register
      ibmveth: fix TX LTB and filter unwind on open-fail

Mohamed Yassine Jebabli (1):
      ALSA: hda/tas2781: Accept V1 calibration data without CRC

Myeonghun Pak (1):
      drm/aspeed: Balance the display clock enable on teardown

Naomi Chu (1):
      scsi: ufs: core: Hold a clock reference across the probe

Natasha Klaus (1):
      io_uring/net: populate CONNECT filter fields for 24-byte sockaddr_in6

Nguyen Ngoc Thang (2):
      memstick: rtsx_usb_ms: complete requests after eject instead of dropping them
      drm/fb-helper: defer setup when fbdev_probe() fails, not just on -EAGAIN

Nicolas Cavallari (1):
      wifi: mt76: mt7915: disable rx napi when removing device

Norbert Szetei (1):
      xfs: stop exchanging reflink flags when exchanging mappings

Oleg Keri (1):
      drm/dp: don't mark the AUX backlight enabled when enabling failed

Oliver Hartkopp (1):
      can: fix unique skb identifier regression under RPS

Omar Ramadan (1):
      amt: send the relay's General Query directly from the receive path

Or Har-Toov (2):
      net/mlx5: Lag, split aggregate speed into oper and max helpers
      Revert "net/mlx5: E-Switch, preserve max tx speed on vport state modification"

Osama Abdelkader (1):
      drm/panthor: validate userspace queue count against initialized firmware slot count

Ovidiu Panait (2):
      net: stmmac: Do not advertise S-VLAN stripping when it is disabled
      net: stmmac: Disable S-Tag processing on dwmac4

Palla Raghunath (2):
      dm ioctl: don't let data_start run past the buffer
      Bluetooth: RFCOMM: Fix NULL tty_dev dereference in rfcomm_dev_shutdown

Pavan Chebbi (1):
      bnxt_en: Re-write the BARs following any type of PCIe errors

Pavankumar Kondeti (1):
      workqueue: Fix NULL current_pwq deref in chained work check

Peng Fan (1):
      iommu/dma: skip swiotlb bounce for DMA_ATTR_MMIO in iommu_dma_map_phys

Pengpeng Hou (1):
      scsi: ufs: mediatek: Handle mPHY power-on failures

Petr Machata (1):
      mlxsw: spectrum_flower: Fix port range register leak in tmplt_create()

Quchaosheng (1):
      net/packet: guard the ll header push in packet_rcv_spkt()

Quentin Freimanis (1):
      net: sparx5: start the TOD counters on non-PTP lan969x variants

Raj Ojha (1):
      memstick: core: wait for request completion before freeing card

Ramses de Norre (1):
      wireguard: queueing: preserve tstamp_type when encapsulating packet

Ravindra (1):
      Bluetooth: btintel_pcie: fix TX descriptor bounds check

Richard Fitzgerald (1):
      ASoC: sdw_utils: Switch CS35L56/57/62/63 to use OT25 DAI

Ridham Khurana (2):
      gpio: xilinx: fix runtime PM leak on request error path
      regulator: tps6594-regulator: Fix n_linear_ranges for TPS65224 BUCK2-4

Runyu Xiao (2):
      scsi: qedi: Initialize callback state before registration
      Bluetooth: btintel_pcie: use managed IRQ teardown

Sabrina Dubroca (1):
      strparser: make sure __strp_recv isn't running before tearing down the parser

Sai Teja Aluvala (1):
      Bluetooth: btintel_pcie: Add shared HW reset for clean start

Sajal Gupta (1):
      drm/gud: don't keep a connector without a CRTC as connector_state

Saleel Kudchadker (1):
      drm/amdkfd: align SDMA doorbell base for shader doorbell writes

Sang-Hoon Choi (3):
      gpio: exar: initialize the ID before registering its cleanup
      cxgb4/ch_ktls: disable softirqs around tid_list erases
      nvmet: use the local P2P device on metadata allocation failure

Sebastien Royen (1):
      net: dsa: microchip: fix KSZ8765 fiber detection

Shao Mingyin (1):
      riscv: lib: Fix ZBB strnlen wrap-around regression on huge counts

Shao-Fu Chen (1):
      optee: register TEE devices only once fully initialized

Shashank Mohan Jain (1):
      lib/dim: fix 32-bit overflow in dim_calc_stats() rates

Shawn Lin (3):
      pmdomain: rockchip: don't ignore clock lookup errors on attach
      pmdomain: rockchip: fix clock leak on domain probe failure
      pmdomain: rockchip: propagate subdomain add errors

Shin'ichiro Kawasaki (1):
      zloop: zero out only the unread tail of short reads

Stanley Jhu (2):
      scsi: ufs: core: Avoid unsafe MMIO reads in ufshcd_mcq_compl_all_cqes_lock()
      scsi: ufs: core: Decouple CQ sweep from request iterator in MCQ

Stefan Binding (1):
      ASoC: sdw_utils: Add codec info for CS35L62

Stephen Smalley (1):
      selinux: preserve NATIVE_LABELS on already-initialized sb in set_mnt_opts

Suraj Gupta (1):
      net: xilinx: axienet: Free outstanding DMA buffers on dmaengine stop

Taniya Das (2):
      clk: qcom: gpucc-glymur: Mark the GPU CX GDSC as votable
      clk: qcom: gpucc-kaanapali: Mark the GPU CX GDSC as votable

Tao Gong (1):
      wifi: mt76: mt7996: fix struct mt7996_mcu_wed_rro_ba_delete_event layout

Thomas Hellström (2):
      drm/xe: Fix shrinker accounting double-subtraction on nested external pins
      drm/xe: Fix stale pinned_link entry when fb-pin performs the final unpin

Tianyi Gao (1):
      veth: fix peer NETDEV_XDP_ACT_NDO_XMIT after GRO is toggled while down

Tony Nguyen (1):
      e1000e: add system to disable K1 list

Tristan Madani (1):
      ice: fix metadata_dst refcount handling on representor teardown

Troy Mitchell (1):
      riscv: vector: Fix data pointer constraints in context save/restore

Tvrtko Ursulin (1):
      drm/xe: Do not emit Wa_16010904313 twice

Vadim Fedorenko (1):
      ptp: ocp: fix PCIe delay estimation calculation

Vicki Pfau (4):
      HID: steam: Fully unregister controller when hidraw is opened
      HID: steam: Rearrange teardown sequence
      HID: steam: Refactor registration
      HID: steam: Clean up locking

Victor Nogueira (1):
      net/sched: cls_route: reject change with no routing attribute

Vincent Jardin (3):
      arm64: dts: lx2160a: fix incorrect pinmux
      arm64: dts: lx2160a: fix IIC1 pinmux submask rejected by pinctrl-single
      arm64: dts: lx2160a: fix the iic5 spi3 pinmux offset and value

Vishal Badole (1):
      EDAC/amd64: Mask UMC chip select to the four implemented selects

Vitaly Prosyak (1):
      drm/amdgpu: serialize vblank counter reads against GPU reset

Waiman Long (3):
      cgroup/cpuset: Handle cpu hotplug race in guarantee_active_cpus()
      cgroup/cpuset: Don't access cpuset_cgrp_subsys.root in is_in_v2_mode()
      cgroup/cpuset: Call is_in_v2_mode() after acquiring cpuset_mutex in cpuset_handle_hotplug()

Wei-Jie Hung (1):
      riscv: patch: fix handling of bpf-jit execmem addresses

Weiming Shi (2):
      net: team: stop reusing skb after queue override
      net: team: free skb when broadcast has no txable port

Wentao Liang (2):
      btrfs: scrub: fix local_root reference leak in scrub_print_warning_inode()
      drm/vc4: Fix firmware reference leak in vc4_drm_bind()

Willem de Bruijn (1):
      net/packet: call packet_parse_headers after virtio_net_hdr_to_skb

Xuanqiang Luo (1):
      ice: fix use-after-free in dynamic port cleanup

Yang Xiuwei (4):
      btrfs: always return -EIOCBQUEUED after btrfs_uring_read_extent_endio
      btrfs: free iov when btrfs_uring_read_extent() fails
      btrfs: unlock inode and extent in caller when io_uring read extent fails
      btrfs: don't stash io_uring encoded data across -EAGAIN

Yibo Tan (1):
      mmc: mtk-sd: Cancel request timeout work on remove

Yingying Tang (1):
      Revert "wifi: ath12k: add panic handler"

Yuqi Xu (1):
      tipc: destroy topsrv workqueues before closing connections

Zack Rusin (1):
      drm/vmwgfx: validate pitch coming from userspace

Zixuan Chai (1):
      net: bridge: avoid recursive multicast port cleanup

Ziyi Guo (2):
      riscv: entry: gate shadow call stack reload on sstatus.SPP, not tp
      riscv: futex: untag the user pointer before the atomic access

Zongmin Zhou (3):
      riscv: errata: select RISCV_ALTERNATIVE_EARLY for THEAD GHOSTWRITE
      riscv: hwprobe: use _BITULL() rather than BIT() in MIPS vendor uapi header
      riscv: ptrace: Zero-initialize regset buffers before copyin

zjamg (1):
      can: dev: init_can_skb(): restore skb header initialization

성병찬 (1):
      KEYS: Fix add_key() race with keyring restriction

