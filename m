Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD152C11E2;
	Mon,  1 Jun 2026 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330035; cv=none; b=BNlhDKgt+u3CM5Us915uoq3pTO0vuiIVR2lj5VZlLOIgjs4KMKKDuibjpdaYsl16v3IbMs0dZaQ4aF324yeyujXNhGNLN4h5hwFx2+4iahXfqDDU8IMnoMCGprrmfOKLl0E7KcHmUl4ykOwbZyiZeYXnT2jruyi+j7YRWGas8oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330035; c=relaxed/simple;
	bh=fPPogrLPUN2hj9AC/+0PX5Etoac1bqFuh6RND3euexk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bDLEJX6dUtmoOyHfEUuAS2vt5JZyvGcNSC9jg8tnqY7d9QWaw5ZHrSojECAnDLWeCkam3+DZR8x+lab72dqyLNsoa/Tqs6jt1IpJlCDnKpN97f5CPqAvssQkKjZ2rD3IYgf4w31iwRAh7/byPVW7wDTfGtVc8WiJgjjXgUIjKxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WRSHNYUZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WRSHNYUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5DC1F00893;
	Mon,  1 Jun 2026 16:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780330032;
	bh=0S83bEDXCdpNsRPxeSwJJx34rj2KIPGp8ZO/KjETuJs=;
	h=From:To:Cc:Subject:Date;
	b=WRSHNYUZ0qP6WWMqNRWGk1D01P6NvuBpjQTenBfD+HShBqB/0Lg1cfjZtYAxz57Sq
	 b885KAAWEV5ZTyF+zEz6x1NG1mb0pL9cUPjjNT2hCEUZHO1m6tBTxJMVnXza2DnAwh
	 MrZ+BQk03X5E4HdSGp9kbr7OG8tS6g1OuuuDfGBY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.92
Date: Mon,  1 Jun 2026 18:05:50 +0200
Message-ID: <2026060151-ferry-unleash-c980@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.92 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                 |    2 
 arch/arm/boot/dts/renesas/r7s72100-genmai.dts            |    3 
 arch/arm/boot/dts/renesas/r7s72100-rskrza1.dts           |    2 
 arch/arm/mach-versatile/integrator_cp.c                  |   13 
 arch/arm64/Kconfig                                       |    1 
 arch/arm64/include/asm/ftrace.h                          |    1 
 arch/arm64/include/asm/insn.h                            |    2 
 arch/arm64/kvm/arm.c                                     |    4 
 arch/arm64/kvm/vgic/vgic-its.c                           |    4 
 arch/loongarch/kernel/kprobes.c                          |    4 
 arch/loongarch/mm/init.c                                 |    4 
 arch/powerpc/Kconfig.debug                               |    3 
 arch/powerpc/kernel/time.c                               |    6 
 arch/riscv/Kconfig                                       |    2 
 arch/riscv/kernel/mcount.S                               |   24 
 arch/riscv/kvm/vcpu_pmu.c                                |    6 
 arch/riscv/mm/init.c                                     |   25 
 arch/s390/kernel/debug.c                                 |    3 
 arch/x86/include/asm/segment.h                           |    8 
 arch/x86/kernel/ftrace_64.S                              |    5 
 arch/x86/xen/setup.c                                     |    2 
 block/bio-integrity.c                                    |   76 +-
 block/blk-integrity.c                                    |   12 
 block/blk-mq.c                                           |   19 
 drivers/accel/qaic/qaic_data.c                           |   23 
 drivers/ata/libata-core.c                                |    9 
 drivers/ata/libata-eh.c                                  |    8 
 drivers/ata/libata-pmp.c                                 |   18 
 drivers/ata/libata-scsi.c                                |  100 ++-
 drivers/ata/sata_sil24.c                                 |    6 
 drivers/base/memory.c                                    |    8 
 drivers/block/rbd.c                                      |   20 
 drivers/block/ublk_drv.c                                 |    3 
 drivers/bluetooth/btmtk.c                                |    2 
 drivers/bluetooth/hci_ldisc.c                            |   48 +
 drivers/firmware/arm_ffa/bus.c                           |    7 
 drivers/firmware/arm_ffa/driver.c                        |  238 +++++---
 drivers/firmware/efi/efi.c                               |   28 -
 drivers/gpio/gpiolib-cdev.c                              |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c                  |    7 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c       |    9 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c |    9 
 drivers/gpu/drm/amd/display/dc/core/dc.c                 |    6 
 drivers/gpu/drm/bridge/chipone-icn6211.c                 |    4 
 drivers/gpu/drm/bridge/ite-it66121.c                     |    5 
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c |   16 
 drivers/gpu/drm/i915/display/intel_dp.c                  |    2 
 drivers/gpu/drm/imagination/pvr_power.c                  |   11 
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c        |   24 
 drivers/gpu/drm/msm/dsi/dsi_host.c                       |    1 
 drivers/gpu/drm/msm/msm_iommu.c                          |    5 
 drivers/gpu/drm/virtio/virtgpu_drv.h                     |    1 
 drivers/gpu/drm/virtio/virtgpu_gem.c                     |   17 
 drivers/gpu/drm/virtio/virtgpu_plane.c                   |   10 
 drivers/gpu/drm/xe/display/xe_hdcp_gsc.c                 |   12 
 drivers/gpu/drm/xe/xe_gsc.c                              |    5 
 drivers/gpu/drm/xe/xe_gt_sriov_pf_monitor.c              |    6 
 drivers/gpu/drm/xe/xe_gt_sriov_pf_monitor.h              |    2 
 drivers/gpu/drm/xe/xe_gt_sriov_vf.c                      |   24 
 drivers/gpu/drm/xe/xe_gt_sriov_vf.h                      |    6 
 drivers/gpu/drm/xe/xe_oa.c                               |    6 
 drivers/hid/hid-quirks.c                                 |    2 
 drivers/hid/hid-uclogic-core.c                           |    4 
 drivers/hwmon/pmbus/adm1266.c                            |   32 -
 drivers/hwmon/pmbus/pmbus_core.c                         |  117 +++-
 drivers/infiniband/sw/siw/siw_qp_rx.c                    |   15 
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c             |    2 
 drivers/iommu/intel/pasid.c                              |   22 
 drivers/iommu/intel/pasid.h                              |    6 
 drivers/irqchip/irq-ath79-cpu.c                          |    7 
 drivers/net/dsa/mt7530.c                                 |   47 +
 drivers/net/ethernet/amd/pds_core/debugfs.c              |    7 
 drivers/net/ethernet/amd/pds_core/dev.c                  |   11 
 drivers/net/ethernet/amd/pds_core/devlink.c              |    6 
 drivers/net/ethernet/atheros/ag71xx.c                    |    3 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c           |    9 
 drivers/net/ethernet/cirrus/cs89x0.c                     |    2 
 drivers/net/ethernet/cortina/gemini.c                    |   21 
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c             |    4 
 drivers/net/ethernet/intel/ice/ice_main.c                |   10 
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c              |   15 
 drivers/net/ethernet/intel/ice/ice_txrx.c                |    7 
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c        |    1 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c          |    7 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c      |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c |    8 
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c   |    3 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c    |    8 
 drivers/net/ethernet/microsoft/mana/hw_channel.c         |   29 -
 drivers/net/ethernet/qlogic/qed/qed_cxt.c                |    2 
 drivers/net/ifb.c                                        |   11 
 drivers/net/phy/dp83tc811.c                              |    1 
 drivers/net/pse-pd/pse_core.c                            |    2 
 drivers/net/wireless/ath/ath10k/wmi.c                    |   15 
 drivers/net/wireless/ath/ath11k/dp_rx.c                  |    3 
 drivers/net/wireless/ath/ath11k/hal.c                    |   14 
 drivers/net/wireless/ath/ath11k/hal_rx.c                 |    5 
 drivers/net/wireless/ath/ath11k/testmode.c               |    1 
 drivers/net/wireless/ath/ath11k/wmi.c                    |   19 
 drivers/net/wwan/iosm/iosm_ipc_imem.c                    |    2 
 drivers/nvme/host/ioctl.c                                |   17 
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c               |    5 
 drivers/phy/tegra/xusb-tegra186.c                        |   33 -
 drivers/phy/tegra/xusb.h                                 |    1 
 drivers/pinctrl/qcom/pinctrl-sm8150.c                    |    8 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                  |    2 
 drivers/platform/surface/surface_aggregator_registry.c   |    2 
 drivers/platform/x86/adv_swbutton.c                      |    6 
 drivers/platform/x86/hp/hp_accel.c                       |    3 
 drivers/platform/x86/intel/hid.c                         |    6 
 drivers/platform/x86/intel/vbtn.c                        |    6 
 drivers/scsi/isci/host.c                                 |    3 
 drivers/scsi/sd.c                                        |    3 
 drivers/spi/spi-dw-dma.c                                 |    2 
 drivers/spi/spi-ep93xx.c                                 |    2 
 drivers/spi/spi-mtk-snfi.c                               |    2 
 drivers/spi/spi-qup.c                                    |    3 
 drivers/spi/spi-sprd.c                                   |    3 
 drivers/spi/spi-ti-qspi.c                                |    1 
 fs/btrfs/fs.h                                            |    1 
 fs/btrfs/qgroup.c                                        |   31 -
 fs/netfs/buffered_read.c                                 |   14 
 fs/netfs/buffered_write.c                                |  213 ++++---
 fs/netfs/iterator.c                                      |   26 
 fs/netfs/misc.c                                          |    8 
 fs/netfs/read_retry.c                                    |   11 
 fs/netfs/write_issue.c                                   |   39 -
 fs/nfsd/nfs4state.c                                      |    7 
 fs/nsfs.c                                                |    2 
 fs/ntfs3/file.c                                          |   12 
 fs/smb/client/cifs_spnego.c                              |   16 
 fs/smb/client/cifsfs.c                                   |    2 
 fs/smb/client/netlink.c                                  |    6 
 fs/smb/client/smb2ops.c                                  |    4 
 fs/smb/client/smb2transport.c                            |    2 
 fs/smb/server/mgmt/user_session.c                        |    7 
 fs/smb/server/oplock.c                                   |   13 
 fs/smb/server/oplock.h                                   |    1 
 fs/smb/server/smb2pdu.c                                  |    3 
 fs/smb/server/smbacl.c                                   |   78 ++
 fs/smb/server/vfs_cache.c                                |  207 ++++++-
 fs/smb/server/vfs_cache.h                                |   12 
 fs/sysfs/group.c                                         |    2 
 fs/zonefs/super.c                                        |    6 
 include/asm-generic/kprobes.h                            |    2 
 include/linux/arm_ffa.h                                  |    3 
 include/linux/bio-integrity.h                            |    5 
 include/linux/blk-integrity.h                            |    5 
 include/linux/fwnode.h                                   |    1 
 include/linux/libata.h                                   |    7 
 include/linux/sched.h                                    |    1 
 include/net/af_unix.h                                    |    1 
 include/net/bluetooth/bluetooth.h                        |    1 
 include/net/netfilter/nf_queue.h                         |    1 
 include/trace/events/btrfs.h                             |    4 
 include/trace/events/netfs.h                             |    8 
 io_uring/net.c                                           |   26 
 io_uring/waitid.c                                        |    1 
 kernel/cgroup/cpuset.c                                   |    8 
 kernel/irq_work.c                                        |    7 
 kernel/sched/core.c                                      |    2 
 kernel/sched/deadline.c                                  |   19 
 kernel/sched/ext.c                                       |    5 
 kernel/sched/fair.c                                      |   16 
 kernel/sched/sched.h                                     |   37 +
 kernel/trace/ring_buffer.c                               |    8 
 kernel/trace/trace_events_hist.c                         |    6 
 kernel/trace/tracing_map.c                               |   17 
 lib/kunit/Kconfig                                        |    5 
 lib/test_kprobes.c                                       |   29 -
 mm/damon/sysfs-schemes.c                                 |    1 
 mm/memory_hotplug.c                                      |    2 
 net/batman-adv/bridge_loop_avoidance.c                   |   54 +
 net/batman-adv/distributed-arp-table.c                   |    3 
 net/batman-adv/fragmentation.c                           |   58 +-
 net/batman-adv/gateway_client.c                          |    4 
 net/batman-adv/originator.c                              |    4 
 net/batman-adv/tp_meter.c                                |   64 +-
 net/batman-adv/types.h                                   |   17 
 net/bluetooth/af_bluetooth.c                             |   97 ++-
 net/bluetooth/bnep/core.c                                |    2 
 net/bluetooth/iso.c                                      |   14 
 net/bluetooth/l2cap_core.c                               |    2 
 net/bluetooth/l2cap_sock.c                               |   51 +
 net/bluetooth/mgmt.c                                     |    6 
 net/bluetooth/rfcomm/sock.c                              |    9 
 net/bluetooth/sco.c                                      |    9 
 net/bridge/br_mrp_netlink.c                              |    4 
 net/bridge/br_multicast.c                                |   27 
 net/core/gro.c                                           |    3 
 net/core/skmsg.c                                         |    9 
 net/ethtool/bitset.c                                     |    8 
 net/ipv4/inet_connection_sock.c                          |    2 
 net/ipv4/netfilter/arptable_filter.c                     |    2 
 net/ipv4/netfilter/iptable_filter.c                      |    2 
 net/ipv4/netfilter/iptable_mangle.c                      |    2 
 net/ipv4/netfilter/iptable_raw.c                         |    2 
 net/ipv4/netfilter/iptable_security.c                    |    2 
 net/ipv4/raw.c                                           |    2 
 net/ipv4/tcp_ao.c                                        |    3 
 net/ipv6/exthdrs.c                                       |   21 
 net/ipv6/netfilter/ip6t_hbh.c                            |    4 
 net/ipv6/netfilter/ip6table_filter.c                     |    2 
 net/ipv6/netfilter/ip6table_mangle.c                     |    2 
 net/ipv6/netfilter/ip6table_raw.c                        |    2 
 net/ipv6/netfilter/ip6table_security.c                   |    2 
 net/l2tp/l2tp_core.c                                     |    2 
 net/mac80211/mlme.c                                      |    2 
 net/mac80211/parse.c                                     |   71 +-
 net/mptcp/pm_netlink.c                                   |   35 -
 net/mptcp/protocol.c                                     |    3 
 net/netfilter/ipset/ip_set_hash_ipmark.c                 |    6 
 net/netfilter/ipset/ip_set_hash_ipport.c                 |    5 
 net/netfilter/ipset/ip_set_hash_ipportip.c               |    5 
 net/netfilter/ipset/ip_set_hash_ipportnet.c              |    5 
 net/netfilter/nf_queue.c                                 |    4 
 net/netfilter/nfnetlink_queue.c                          |    2 
 net/netfilter/nft_inner.c                                |    1 
 net/phonet/pep.c                                         |   19 
 net/smc/af_smc.c                                         |    3 
 net/smc/smc_tracepoint.h                                 |    2 
 net/tls/tls_sw.c                                         |   46 +
 net/unix/af_unix.c                                       |   13 
 net/unix/garbage.c                                       |   79 +-
 net/vmw_vsock/virtio_transport_common.c                  |   20 
 net/vmw_vsock/vmci_transport.c                           |    2 
 net/wireless/scan.c                                      |    3 
 scripts/package/PKGBUILD                                 |    2 
 security/keys/keyring.c                                  |    1 
 security/landlock/net.c                                  |  118 ++--
 security/lsm_syscalls.c                                  |    9 
 sound/core/pcm_lib.c                                     |    3 
 sound/core/seq/seq_ump_client.c                          |   22 
 sound/pci/asihpi/hpicmn.c                                |    6 
 sound/pci/hda/cs35l41_hda.c                              |    4 
 sound/pci/hda/cs35l56_hda.c                              |    1 
 sound/soc/codecs/cs35l56-sdw.c                           |    3 
 sound/usb/misc/ua101.c                                   |    5 
 sound/usb/mixer_scarlett2.c                              |    2 
 tools/perf/builtin-list.c                                |   13 
 tools/perf/builtin-stat.c                                |    1 
 tools/perf/util/Build                                    |    1 
 tools/perf/util/cgroup.c                                 |   30 -
 tools/perf/util/evsel.c                                  |  291 +++++++++-
 tools/perf/util/evsel.h                                  |   30 +
 tools/perf/util/metricgroup.c                            |    1 
 tools/perf/util/parse-events.c                           |   59 +-
 tools/perf/util/parse-events.h                           |    5 
 tools/perf/util/parse-events.l                           |   11 
 tools/perf/util/parse-events.y                           |   16 
 tools/perf/util/pmu.c                                    |   20 
 tools/perf/util/pmu.h                                    |    2 
 tools/perf/util/pmus.c                                   |    9 
 tools/perf/util/print-events.c                           |   36 +
 tools/perf/util/print-events.h                           |    1 
 tools/perf/util/python.c                                 |   61 --
 tools/perf/util/stat-display.c                           |    6 
 tools/perf/util/stat-shadow.c                            |    1 
 tools/perf/util/tool_pmu.c                               |  417 ---------------
 tools/perf/util/tool_pmu.h                               |   51 -
 tools/testing/selftests/mm/run_vmtests.sh                |    2 
 261 files changed, 2869 insertions(+), 1693 deletions(-)

Abdun Nihaal (1):
      net: wwan: iosm: fix potential memory leaks in ipc_imem_init()

Abdurrahman Hussain (10):
      hwmon: (pmbus/adm1266) widen blackbox-info buffer to I2C_SMBUS_BLOCK_MAX
      hwmon: (pmbus/adm1266) seed timestamp from the real-time clock
      hwmon: (pmbus/adm1266) reject implausible blackbox record_count
      hwmon: (pmbus/adm1266) include PEC byte in pmbus_block_xfer read buffer
      hwmon: (pmbus/adm1266) bounce blackbox records through a protocol-sized buffer
      hwmon: (pmbus/adm1266) cap PDIO scan in get_multiple at ADM1266_PDIO_NR
      hwmon: (pmbus/adm1266) don't clobber GPIO bits before PDIO read in get_multiple
      hwmon: (pmbus/adm1266) register the gpio_chip after pmbus_do_probe()
      hwmon: (pmbus/adm1266) register the nvmem device after pmbus_do_probe()
      hwmon: (pmbus/adm1266) reject short block-read responses in the GPIO accessors

Aditya Garg (1):
      net: mana: validate rx_req_idx to prevent out-of-bounds array access

Alan Liu (1):
      drm/amdgpu/vpe: Force collaborate sync after TRAP

Alessio Belle (1):
      drm/imagination: Synchronize interrupts before suspending the GPU

Andreas Haarmann-Thiemann (1):
      net: ethernet: cortina: Drop half-assembled SKB

Andy Shevchenko (1):
      gpiolib: cdev: use !mem_is_zero() instead of memchr_inv(s, 0, n)

Ankit Nautiyal (1):
      drm/i915/dp: Fix readback for target_rr in Adaptive Sync SDP

Anuj Gupta (1):
      block: modify bio_integrity_map_user to accept iov_iter as argument

Ard Biesheuvel (1):
      efi: Allocate runtime workqueue before ACPI init

Asim Viladi Oglu Manizada (1):
      smb: client: reject userspace cifs.spnego descriptions

Bart Van Assche (1):
      ice: fix locking in ice_dcb_rebuild()

Bartosz Golaszewski (2):
      device property: set fwnode->secondary to NULL in fwnode_init()
      gpio: cdev: check if uAPI v2 config attributes are correctly zeroed

Biju Das (1):
      pinctrl: renesas: rzg2l: Fix incorrect PUPD register offset for high pins during suspend/resume

Boris Burkov (1):
      btrfs: fix squota accounting during enable generation

Caleb Sander Mateos (1):
      block: drop direction param from bio_integrity_copy_user()

Casey Chen (1):
      block: recompute nr_integrity_segments in blk_insert_cloned_request

ChenXiaoSong (1):
      smb/server: promote S_DEL_ON_CLS to S_DEL_PENDING when close

Chenguang Zhao (1):
      ethtool: fix ethnl_bitmap32_not_zero() bit interval semantics

Chuck Lever (2):
      NFSD: Fix infinite loop in layout state revocation
      tls: Preserve sk_err across recvmsg() when data has been copied

Cássio Gabriel (1):
      ALSA: ua101: Reject too-short USB descriptors

DaeMyung Kang (1):
      ksmbd: close durable scavenger races against m_fp_list lookups

Daniel Golle (2):
      net: dsa: mt7530: fix FDB entries not aging out with short timeout
      net: dsa: mt7530: preserve VLAN tags on trapped link-local frames

David Carlier (3):
      Bluetooth: ISO: drop ISO_END frames received without prior ISO_START
      block: don't overwrite bip_vcnt in bio_integrity_copy_user()
      tracing: Avoid NULL return from hist_field_name() on truncation

David Gow (2):
      kunit: config: Enable KUNIT_DEBUGFS by default
      kunit: config: KUNIT_DEBUGFS should depend on DEBUG_FS

David Howells (9):
      netfs: Fix overrun check in netfs_extract_user_iter()
      netfs: Fix netfs_invalidate_folio() to clear dirty bit if all changes gone
      netfs: Defer the emission of trace_netfs_folio()
      netfs: Fix streaming write being overwritten
      netfs: Fix potential deadlock in write-through mode
      netfs: Fix write streaming disablement if fd open O_RDWR
      netfs: Fix early put of sink folio in netfs_read_gaps()
      netfs: Fix partial invalidation of streaming-write folio
      netfs: Fix folio->private handling in netfs_perform_write()

Dawei Feng (1):
      qed: fix double free in qed_cxt_tables_alloc()

Deepanshu Kartikey (1):
      drm/virtio: use uninterruptible resv lock for plane updates

Dmitry Baryshkov (2):
      drm/msm/dsi: don't dump registers past the mapped region
      drm/msm/snapshot: fix dumping of the unaligned regions

Erni Sri Satya Vennela (1):
      net: mana: Fix TOCTOU double-fetch of hwc_msg_id from DMA buffer

Ethan Nelson-Moore (1):
      net: ethernet: cs89x0: remove stale CONFIG_MACH_MX31ADS reference

Felix Gu (1):
      spi: mtk-snfi: Fix resource leak in mtk_snand_read_page_cache()

Feng Yang (1):
      tracing: Fix the bug where bpf_get_stackid returns -EFAULT on the ARM64

Ferry Meng (1):
      ksmbd: fix SID memory leak in set_posix_acl_entries_dacl() on overflow

Filipe Manana (1):
      btrfs: tracepoints: fix sleep while in atomic context in btrfs_sync_file()

Florian Westphal (1):
      netfilter: x_tables: unregister the templates first

Gabor Juhos (1):
      phy: marvell: mvebu-a3700-utmi: fix incorrect USB2_PHY_CTRL register access

Gang Yan (1):
      mptcp: sync the msk->sndbuf at accept() time

Greg Kroah-Hartman (2):
      sysfs: don't remove existing directory on update failure
      Linux 6.12.92

Grzegorz Nitka (2):
      ice: restore PTP Rx timestamp config after ethtool set-channels
      ice: ptp: serialize E825 PHY timer start with PTP lock

Guangshuo Li (1):
      RDMA/rtrs: Fix use-after-free in path file creation cleanup

Guenter Roeck (2):
      hwmon: (pmbus/core) Protect regulator operations with mutex
      ARM: integrator: Fix early initialization

Guo Ren (Alibaba DAMO Academy) (1):
      riscv: mm: Fixup no5lvl failure when vaddr is invalid

Guopeng Zhang (1):
      cgroup/cpuset: Reset DL migration state on can_attach() failure

Gustavo Sousa (1):
      drm/xe/hdcp: Add NULL check for media_gt in intel_hdcp_gsc_check_status()

Haoze Xie (1):
      netfilter: nf_queue: hold bridge skb->dev while queued

Harry Wentland (3):
      drm/amd/display: Fix integer overflow in bios_get_image()
      drm/amd/display: Validate GPIO pin LUT table size before iterating
      drm/amd/display: Validate payload length and link_index in dc_process_dmub_aux_transfer_async

Heechan Kang (1):
      io_uring/waitid: clear waitid info before copying it to userspace

Henrique Carvalho (1):
      smb: client: protect tc_count increment in smb2_find_smb_sess_tcon_unlocked()

Huacai Chen (2):
      sched/deadline: Fix dl_server_stopped()
      LoongArch: Remove unused code to avoid build warning

Ian Rogers (1):
      perf parse-events: Expose/rename config_term_name

Ido Schimmel (1):
      bridge: mcast: Fix a possible use-after-free when removing a bridge port

Ilya Dryomov (1):
      rbd: eliminate a race in lock_dwork draining on unmap

Jakub Kicinski (2):
      net: tls: fix off-by-one in sg_chain entry count for wrapped sk_msg ring
      net: tls: prevent chain-after-chain in plain text SG

Jann Horn (2):
      Bluetooth: bnep: Fix UAF read of dev->name
      af_unix: Fix UAF read of tail->len in unix_stream_data_wait()

Jens Axboe (2):
      io_uring/net: punt IORING_OP_BIND async if it needs file create
      block: make bio_integrity_map_user() static inline

Jeremy Erazo (1):
      smb: client: use data_len for SMB2 READ encrypted folioq copy

Jeremy Laratro (1):
      ksmbd: fix null pointer dereference in compare_guid_key()

Jeroen Massar (1):
      net/mlx5: Do not restore destination-less TC rules

Jiajia Liu (1):
      Bluetooth: btmtk: fix urb->setup_packet leak in error paths

Jianbo Liu (2):
      net/mlx5e: Trigger neighbor resolution for unresolved destinations
      net/mlx5e: Use ip6_dst_lookup instead of ipv6_dst_lookup_flow for MAC init

Jianpeng Chang (1):
      kprobes: skip non-symbol addresses in kprobe_add_ksym_blacklist()

Jiayuan Chen (1):
      irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT

Jiexun Wang (1):
      Bluetooth: serialize accept_q access

Jiri Olsa (1):
      x86/fgraph: Fix return_to_handler regs.rsp value

Johan Hovold (4):
      spi: qup: fix error pointer deref after DMA setup failure
      spi: ep93xx: fix error pointer deref after DMA setup failure
      spi: sprd: fix error pointer deref after DMA setup failure
      spi: ti-qspi: fix use-after-free after DMA setup failure

Johannes Berg (1):
      wifi: mac80211: fix MLE defragmentation

Johannes Thumshirn (1):
      zonefs: handle integer overflow in zonefs_fname_to_fno

John Walker (1):
      wifi: cfg80211: advance loop vars in cfg80211_merge_profile()

Jonas Jelonek (1):
      net: pse-pd: fix sign on -ENOENT check in of_load_pse_pis()

Juergen Gross (1):
      x86/xen: Fix xen_e820_swap_entry_with_ram()

Julian Braha (1):
      powerpc: fix dead default for GUEST_STATE_BUFFER_TEST

Julien Chauveau (1):
      drm/bridge: it66121: acquire reset GPIO in probe

Junyi Liu (1):
      ksmbd: validate SID in parent security descriptor during ACL inheritance

Justin Iurman (2):
      ipv6: ioam: refresh hdr pointer before ioam6_event()
      ipv6: ioam: add NULL check for idev in ipv6_hop_ioam()

Kang Yang (1):
      wifi: ath10k: skip WMI and beacon transmission when device is wedged

Keith Busch (3):
      blk-integrity: remove seed for user mapped buffers
      blk-integrity: use simpler alignment check
      blk-integrity: enable p2p source and destination

Konstantin Komarov (1):
      fs/ntfs3: handle attr_set_size() errors when truncating files

Kuniyuki Iwashima (3):
      af_unix: Give up GC if MSG_PEEK intervened.
      tcp: Fix imbalanced icsk_accept_queue count.
      tcp: Fix out-of-bounds access for twsk in tcp_ao_established_key().

Kyle Farnung (1):
      wifi: ath11k: clear shared SRNG pointer state on restart

Linus Torvalds (1):
      security/keys: fix missed RCU read section on lookup

Linus Walleij (2):
      net: ethernet: cortina: Make RX SKB per-port
      net: ethernet: cortina: Carry over frag counter

Lu Baolu (1):
      iommu/vt-d: Draining PRQ in sva unbind path when FPD bit set

Luiz Capitulino (1):
      selftests/mm: run_vmtests.sh: fix destructive tests invocation

Lukas Bulwahn (2):
      arm64: Kconfig: Remove selecting replaced HAVE_FUNCTION_GRAPH_RETVAL
      HID: quirks: really enable the intended work around for appledisplay

Luxiao Xu (1):
      batman-adv: fix tp_meter counter underflow during shutdown

Marcin Szycik (2):
      ice: fix setting promisc mode while adding VID filter
      ice: fix setting RSS VSI hash for E830

Marek Vasut (2):
      ARM: dts: renesas: genmai: Drop superfluous cells
      ARM: dts: renesas: rskrza1: Drop superfluous cells

Martin Kaiser (1):
      test_kprobes: clear kprobes between test runs

Masami Hiramatsu (Google) (1):
      tracing: Do not call map->ops->elt_free() if elt_alloc() fails

Matthew Leach (1):
      wifi: ath11k: fix peer resolution on rx path when peer_id=0

Matthew Wilcox (Oracle) (2):
      netfs: Fix a few minor bugs in netfs_page_mkwrite()
      netfs: Remove unnecessary references to pages

Matthieu Baerts (NGI0) (3):
      mptcp: pm: ADD_ADDR rtx: allow ID 0
      mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
      mptcp: pm: ADD_ADDR rtx: free sk if last

Matthieu Buffet (1):
      landlock: Fix TCP handling of short AF_UNSPEC addresses

Maulik Shah (1):
      pinctrl: qcom: Fix wakeirq map by removing disconnected irqs for sm8150

Michael Bommarito (12):
      smb: client: require net admin for CIFS SWN netlink
      Bluetooth: L2CAP: ecred_reconfigure: send packed pdu, not stack pointer
      Bluetooth: MGMT: validate Add Extended Advertising Data length
      net: ifb: report ethtool stats over num_tx_queues
      l2tp: use list_del_rcu in l2tp_session_unhash
      ipv4: raw: reject IP_HDRINCL packets with ihl < 5
      ixgbevf: fix use-after-free in VEPA multicast source pruning
      wifi: mac80211: consume only present negotiated TTLM maps
      KVM: arm64: vgic-its: Reject restored DTE with out-of-range num_eventid_bits
      KVM: arm64: vgic: Free private_irqs when init fails after allocation
      scsi: isci: Fix use-after-free in device removal path
      RDMA/siw: Reject MPA FPDU length underflow before signed receive math

Michal Wajdeczko (1):
      drm/xe/vf: Fix signature of print functions

Mike Christie (1):
      scsi: sd: Fix return code handling in sd_spinup_disk()

Mikko Perttunen (1):
      drm/msm: Fix iommu_map_sgtable() return value check and avoid WARN

Ming Lei (1):
      ublk: reject max_sectors smaller than PAGE_SECTORS in parameter validation

Mingyu Wang (1):
      Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths

Minh Nguyen (1):
      vsock/vmci: fix UAF when peer resets connection during handshake

Mohanram Meenakshisundaram (1):
      drm/xe/pf: Fix CFI failure in debugfs access

Muchun Song (2):
      drivers/base/memory: fix memory block reference leak in poison accounting
      mm/memory_hotplug: fix memory block reference leak on remove

Myeonghun Pak (1):
      net: lan966x: avoid unregistering netdev on register failure

Namjae Jeon (1):
      ksmbd: validate owner of durable handle on reconnect

Nan Li (1):
      netfilter: ipset: stop hash:* range iteration at end

Nicolai Buchwitz (1):
      net: bcmgenet: keep RBUF EEE/PM disabled

Nicolas Escande (2):
      wifi: ath11k: fix error path leaks in some WMI WOW calls
      wifi: ath11k: fix error path leak in ath11k_tm_cmd_wmi_ftm()

Nikhil P. Rao (3):
      pds_core: fix error handling in pdsc_devcmd_wait
      pds_core: fix debugfs_lookup dentry leak and error handling
      pds_core: ensure null-termination for firmware version strings

Niklas Cassel (4):
      ata: libata-scsi: improve readability of ata_scsi_qc_issue()
      ata: libata-scsi: do not use the deferred QC feature for ATA_DEFER_PORT
      ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
      ata: libata-scsi: do not needlessly defer commands when using PMP with FBS

Oliver White (1):
      platform/surface: aggregator_registry: omit battery & AC nodes on Surface Laptop 7

Osama Abdelkader (3):
      riscv: kvm: return SBI_ERR_FAILURE for pmu_snapshot_set_shmem() when OOM
      drm/bridge: chipone-icn6211: use devm_drm_bridge_add in i2c probe
      drm/bridge: megachips: remove bridge when irq request fails

Pengpeng Hou (1):
      s390/debug: Reject zero-length input before trimming a newline

Peter Zijlstra (3):
      sched/deadline: Less agressive dl_server handling
      sched/deadline: Fix dl_server getting stuck
      sched/deadline: Fix dl_server behaviour

Peter Zijlstra (Intel) (1):
      sched/deadline: Stop dl_server before CPU goes offline

Petr Machata (1):
      net: bridge: Flush multicast groups when snooping is disabled

Pu Lehui (2):
      riscv: fgraph: Select HAVE_FUNCTION_GRAPH_TRACER depends on HAVE_DYNAMIC_FTRACE_WITH_ARGS
      riscv: fgraph: Fix stack layout to match __arch_ftrace_regs argument of ftrace_return_to_handler

Rafael J. Wysocki (4):
      platform/x86: adv_swbutton: Check ACPI_HANDLE() against NULL
      platform/x86: hp_accel: Check ACPI_COMPANION() against NULL
      platform/x86: intel-hid: Check ACPI_HANDLE() against NULL
      platform/x86: intel-vbtn: Check ACPI_HANDLE() against NULL

Ratheesh Kannoth (1):
      octeontx2-af: npc: Fix allmulticast skip logic for LBK and SDP VFs

Richard Fitzgerald (1):
      ASoC: cs35l56: Fix flushing of IRQ work in cs35l56_sdw_remove()

Robertus Diawan Chris (1):
      ALSA: scarlett2: Add missing error check when initialise Autogain Status

Rosen Penev (2):
      irqchip/ath79-cpu: Remove unused function
      net: ag71xx: check error for platform_get_irq

Ruide Cao (1):
      batman-adv: fix fragment reassembly length accounting

Ruijie Li (1):
      batman-adv: clear current gateway during teardown

Sabrina Dubroca (1):
      net: gro: don't merge zcopy skbs

Safa Karakuş (1):
      Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()

Sam Daly (1):
      octeontx2-af: CGX: add bounds check to cgx_speed_mbps index

Samuele Mariotti (1):
      sched_ext: Fix missing warning in scx_set_task_state() default case

Sasha Levin (7):
      Revert "perf cgroup: Update metric leader in evlist__expand_cgroup"
      Revert "perf tool_pmu: Fix aggregation on duration_time"
      Revert "perf python: Add parse_events function"
      Revert "perf tool_pmu: Factor tool events into their own PMU"
      Revert "x86/vdso: Fix output operand size of RDPID"
      Revert "ice: fix double-free of tx_buf skb"
      Revert "ice: Remove jumbo_remove step from TX path"

Sayali Patil (1):
      powerpc/time: Remove redundant preempt_disable|enable() calls from arch_irq_work_raise()

SeongJae Park (1):
      mm/damon/sysfs-schemes: call missing mem_cgroup_iter_break()

Shuhao Fu (2):
      ALSA: hda: cs35l56: Put ACPI device after setting companion
      ALSA: hda: cs35l41: Put ACPI device on missing physical node

Shuicheng Lin (2):
      drm/xe/gsc: Fix double-free of managed BO in error path
      drm/xe/oa: Fix exec_queue leak on width check in stream open

Stefano Garzarella (1):
      vsock/virtio: reset connection on receiving queue overflow

Stephen Smalley (1):
      lsm: hold cred_guard_mutex for lsm_set_self_attr()

Steven Rostedt (1):
      ring-buffer: Fix reporting of missed events in iterator

Sudeep Holla (9):
      firmware: arm_ffa: Check for NULL FF-A ID table while driver registration
      firmware: arm_ffa: Skip free_pages on RX buffer alloc failure
      firmware: arm_ffa: Fix per-vcpu self notifications handling in workqueue
      firmware: arm_ffa: Unregister the FF-A devices when cleaning up the partitions
      firmware: arm_ffa: Remove unnecessary declaration of ffa_partitions_cleanup()
      firmware: arm_ffa: Allow multiple UUIDs per partition to register SRI callback
      firmware: arm_ffa: Unregister bus notifier on teardown for FF-A v1.0
      firmware: arm_ffa: Align RxTx buffer size before mapping
      firmware: arm_ffa: Fix sched-recv callback partition lookup

Sungwoo Kim (1):
      block: bio-integrity: Fix null-ptr-deref in bio_integrity_map_user()

Sven Eckelmann (9):
      batman-adv: mcast: fix use-after-free in orig_node RCU release
      batman-adv: dat: handle forward allocation error
      batman-adv: frag: disallow unicast fragment in fragment
      batman-adv: bla: fix report_work leak on backbone_gw purge
      batman-adv: tp_meter: avoid use of uninit sender vars
      batman-adv: tp_meter: fix tp_vars reference leak in receiver shutdown
      batman-adv: tp_meter: fix race condition in send error reporting
      batman-adv: tt: fix negative last_changeset_len
      batman-adv: tt: fix negative tt_buff_len

Sven Schuchmann (1):
      net: phy: DP83TC811: add reading of abilities

Takashi Iwai (3):
      ALSA: pcm: Don't setup bogus iov_iter for silencing
      ALSA: asihpi: Fix potential OOB array access at reading cache
      HID: uclogic: Fix regression of input name assignment

Tejun Heo (1):
      sched_ext: Avoid UAF in scx_root_enable_workfn() init failure path

Tiezhu Yang (1):
      LoongArch: kprobes: Fix handling of fatal unrecoverable recursions

Viacheslav Dubeyko (1):
      netfs: fix VM_BUG_ON_FOLIO() issue in netfs_write_begin() call

Viktor Jägersküpper (1):
      kbuild: pacman-pkg: make "rc" releases adhere to pacman versioning scheme

Viresh Kumar (1):
      firmware: arm_ffa: Refactor addition of partition information into XArray

Vladimir Murzin (1):
      arm64: probes: Handle probes on hinted conditional branch instructions

Vladimir Yakovlev (1):
      spi: spi-dw-dma: fix print error log when wait finish transaction

Wayne Chang (1):
      phy: tegra: xusb: Fix per-pad high-speed termination calibration

Xiang Mei (3):
      bridge: mrp: reject zero test interval to avoid OOM panic
      net/smc: avoid NULL deref of conn->lnk in smc_msg_event tracepoint
      net/smc: reject CHID-0 ACCEPT that matches an empty ism_dev slot

Xingwang Xiang (1):
      bpf, skmsg: fix verdict sk_data_ready racing with ktls rx

Yizhou Zhao (1):
      netfilter: nft_inner: Fix IPv6 inner_thoff desync

Zack McKevitt (1):
      accel/qaic: Add overflow check to remap_pfn_range during mmap

Zhang Cen (1):
      ALSA: seq: Serialize UMP output teardown with event_input

Zhengchuan Liang (1):
      netfilter: ip6t_hbh: reject oversized option lists

Zhihao Cheng (2):
      cifs: Fix busy dentry used after unmounting
      nsfs: fix wrong error code returned for pidns ioctls

Zijing Yin (1):
      phonet/pep: disable BH around forwarded sk_receive_skb()

