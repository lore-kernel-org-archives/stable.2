Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA343D75A9;
	Sun, 23 Aug 2026 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787489204; cv=none; b=FVuPVnkdPTbLZs+tpHCkwLgYggq/oK14KrowXJSGm8s9jM/BGBpCey9IQLVP9Td7DBlEv/UOZQ7rm21u+oCl11QX9I4jLhD9Xdqvls4p248ZLpIUoAvon3CQZsMIauf/l1/XsalmYgrjlGhRfQemduYxD8Vs5Q3WEKTtOQwFtPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787489204; c=relaxed/simple;
	bh=u0vC/aGoAl/G4Sv+FhsWtaOlEKptnsWqp1pGHatKKXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FLDbzy2tVSf9gBQl4s9Wp2P1w64GTJMu/kHkpXAz6hNg3QwFyCge4JvF6m08Td8TBTuQygNU7pbpg26mQaml03EO5EV/NDFamXtwS33rjjRQ5Io985DyTpz1b/B3EG+ST/zoQQYtyAgnvWXh6BNjn9X5NlYseUM2jUW9Pe99nNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C7JJdBoa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C7JJdBoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42091F000E9;
	Sun, 23 Aug 2026 12:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787489200;
	bh=v3ohHenrrtVyUZUW0HuKCYxf+h3hw+HcDYePP+Gfrnw=;
	h=From:To:Cc:Subject:Date;
	b=C7JJdBoav+kc7QDWcMrLZq8kjakGT0Qt0ysXiosX88iWMXeXwF3aCf0e+jcyJhx94
	 TMewIaCWvr6+vUMXa5V/yJuW2nAANo7bMHd2v1uLYvwqXp/vmJxgoKYKSKsQSdin/S
	 jO8CGf6jZfrilRcCFFc0Ohvzday8PrHPzmE++SuE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.105
Date: Sun, 23 Aug 2026 14:44:58 +0200
Message-ID: <2026082359-absently-emission-682a@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.105 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                    |    2 
 arch/arm64/boot/dts/nvidia/tegra194.dtsi                    |    2 
 arch/loongarch/mm/pageattr.c                                |    2 
 arch/m68k/Kconfig.cpu                                       |    4 
 arch/openrisc/include/asm/processor.h                       |    2 
 arch/openrisc/kernel/dma.c                                  |    4 
 arch/openrisc/kernel/signal.c                               |    5 
 arch/powerpc/platforms/pseries/lparcfg.c                    |    2 
 arch/powerpc/platforms/pseries/pci.c                        |    2 
 arch/riscv/mm/pageattr.c                                    |    8 
 arch/x86/kernel/cpu/mce/amd.c                               |    4 
 arch/x86/kernel/cpu/mce/core.c                              |   21 -
 arch/x86/kvm/svm/sev.c                                      |   49 ++-
 arch/x86/kvm/svm/svm.h                                      |    1 
 arch/x86/kvm/x86.c                                          |   13 
 block/genhd.c                                               |   12 
 crypto/ccm.c                                                |    2 
 drivers/ata/libata-eh.c                                     |   29 --
 drivers/ata/libata-scsi.c                                   |  117 +++++++-
 drivers/ata/libata.h                                        |    3 
 drivers/crypto/ccp/sp-dev.c                                 |   14 +
 drivers/crypto/qce/core.c                                   |    2 
 drivers/crypto/starfive/jh7110-aes.c                        |    2 
 drivers/crypto/tegra/tegra-se-aes.c                         |   22 -
 drivers/gpio/gpio-sloppy-logic-analyzer.c                   |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                      |   63 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                  |   50 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c                 |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c                     |   24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                  |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                     |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c                     |   85 +-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                      |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h                      |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                      |    5 
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c                    |   42 +--
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                       |   26 +
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c       |   31 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c          |    7 
 drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c    |    7 
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                         |   36 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                          |   26 -
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h                     |    6 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c            |    5 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                   |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c        |  102 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                      |   58 ----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h                      |   14 -
 drivers/gpu/drm/display/drm_hdmi_state_helper.c             |    3 
 drivers/gpu/drm/panthor/panthor_fw.c                        |    3 
 drivers/gpu/drm/radeon/radeon_kms.c                         |    1 
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c                       |   10 
 drivers/gpu/drm/xe/xe_lrc.c                                 |    7 
 drivers/gpu/drm/xe/xe_oa.c                                  |    4 
 drivers/input/joystick/iforce/iforce-packets.c              |   11 
 drivers/input/joystick/iforce/iforce-usb.c                  |    3 
 drivers/input/joystick/psxpad-spi.c                         |    1 
 drivers/input/joystick/xpad.c                               |    2 
 drivers/input/keyboard/atkbd.c                              |    8 
 drivers/input/misc/cs40l50-vibra.c                          |   10 
 drivers/input/mouse/focaltech.c                             |    2 
 drivers/input/rmi4/rmi_f54.c                                |   43 ++-
 drivers/input/rmi4/rmi_f55.c                                |    4 
 drivers/input/touchscreen/hynitron_cstxxx.c                 |   13 
 drivers/input/touchscreen/sur40.c                           |   23 -
 drivers/iommu/iommufd/device.c                              |    2 
 drivers/mmc/host/atmel-mci.c                                |    2 
 drivers/mmc/host/omap_hsmmc.c                               |    2 
 drivers/mmc/host/sdhci.c                                    |   16 +
 drivers/mmc/host/sdhci.h                                    |    2 
 drivers/mtd/ubi/attach.c                                    |    4 
 drivers/mtd/ubi/fastmap-wl.c                                |    8 
 drivers/mtd/ubi/io.c                                        |   10 
 drivers/mtd/ubi/ubi.h                                       |   12 
 drivers/net/can/rcar/rcar_canfd.c                           |   28 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c                 |   27 +
 drivers/net/ethernet/intel/ice/ice_vf_lib_private.h         |    1 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c               |   21 +
 drivers/net/ethernet/intel/igc/igc_main.c                   |    9 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                 |   16 +
 drivers/net/ethernet/microsoft/mana/mana_en.c               |    4 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                    |    2 
 drivers/net/ipvlan/ipvlan_main.c                            |    4 
 drivers/net/macvlan.c                                       |    4 
 drivers/net/tap.c                                           |   24 +
 drivers/net/veth.c                                          |    2 
 drivers/net/vrf.c                                           |   49 +--
 drivers/net/vxlan/vxlan_core.c                              |   34 +-
 drivers/net/vxlan/vxlan_mdb.c                               |    4 
 drivers/pmdomain/arm/scmi_perf_domain.c                     |    2 
 drivers/s390/cio/vfio_ccw_async.c                           |   16 +
 drivers/s390/cio/vfio_ccw_chp.c                             |   31 +-
 drivers/s390/cio/vfio_ccw_cp.c                              |   74 ++++-
 drivers/s390/cio/vfio_ccw_cp.h                              |   10 
 drivers/s390/cio/vfio_ccw_drv.c                             |   21 +
 drivers/s390/cio/vfio_ccw_fsm.c                             |    8 
 drivers/s390/cio/vfio_ccw_ops.c                             |   39 ++
 drivers/s390/cio/vfio_ccw_private.h                         |   10 
 drivers/s390/net/qeth_core_main.c                           |    3 
 drivers/s390/net/qeth_l3_main.c                             |    5 
 drivers/video/fbdev/core/fb_io_fops.c                       |    8 
 fs/binfmt_elf.c                                             |    4 
 fs/binfmt_elf_fdpic.c                                       |    4 
 fs/binfmt_misc.c                                            |   46 +--
 fs/btrfs/block-group.c                                      |   61 ++--
 fs/btrfs/block-group.h                                      |    3 
 fs/btrfs/extent-tree.c                                      |    6 
 fs/btrfs/messages.h                                         |    7 
 fs/btrfs/space-info.c                                       |    2 
 fs/btrfs/transaction.c                                      |    5 
 fs/btrfs/zoned.c                                            |    5 
 fs/btrfs/zoned.h                                            |    6 
 fs/ceph/addr.c                                              |  164 +++++-------
 fs/ceph/caps.c                                              |   17 +
 fs/ceph/file.c                                              |    9 
 fs/ceph/mds_client.c                                        |   11 
 fs/ceph/mds_client.h                                        |    1 
 fs/ceph/mdsmap.c                                            |    2 
 fs/erofs/Kconfig                                            |    3 
 fs/eventpoll.c                                              |   17 +
 fs/exec.c                                                   |    8 
 fs/f2fs/data.c                                              |    2 
 fs/notify/fanotify/Kconfig                                  |    1 
 fs/notify/fsnotify.c                                        |   38 ++
 fs/open.c                                                   |   12 
 fs/smb/client/cifsfs.c                                      |   22 +
 fs/smb/client/cifsglob.h                                    |   27 -
 fs/smb/client/cifssmb.c                                     |    6 
 fs/smb/client/connect.c                                     |    2 
 fs/smb/client/inode.c                                       |    2 
 fs/smb/client/smb2ops.c                                     |   18 -
 fs/smb/client/transport.c                                   |    8 
 fs/smb/common/cifsglob.h                                    |   36 ++
 fs/smb/server/auth.c                                        |    4 
 fs/smb/server/connection.c                                  |   23 +
 fs/smb/server/connection.h                                  |    5 
 fs/smb/server/oplock.c                                      |    8 
 fs/smb/server/smb2misc.c                                    |    2 
 fs/smb/server/smb2ops.c                                     |   32 +-
 fs/smb/server/smb2pdu.c                                     |   88 +++---
 fs/smb/server/smb2pdu.h                                     |    9 
 fs/smb/server/smb_common.c                                  |   43 ++-
 fs/smb/server/smb_common.h                                  |   43 ---
 fs/super.c                                                  |  133 +++++----
 fs/xfs/libxfs/xfs_exchmaps.c                                |   10 
 fs/xfs/libxfs/xfs_sb.c                                      |    4 
 fs/xfs/scrub/agheader_repair.c                              |  120 +++++++-
 fs/xfs/scrub/alloc.c                                        |    5 
 fs/xfs/scrub/attr_repair.c                                  |    3 
 fs/xfs/scrub/bmap.c                                         |    5 
 fs/xfs/scrub/dirtree_repair.c                               |   22 +
 fs/xfs/scrub/nlinks.c                                       |   13 
 fs/xfs/scrub/nlinks_repair.c                                |    7 
 fs/xfs/scrub/parent.c                                       |    2 
 fs/xfs/scrub/tempfile.c                                     |    1 
 fs/xfs/scrub/trace.h                                        |    2 
 fs/xfs/xfs_dquot.c                                          |    3 
 fs/xfs/xfs_dquot_item_recover.c                             |    2 
 include/linux/fs.h                                          |   77 +++++
 include/linux/fsnotify.h                                    |   39 +-
 include/linux/libata.h                                      |    2 
 include/linux/netdevice.h                                   |   45 +++
 include/linux/pagewalk.h                                    |    7 
 include/linux/psp-sev.h                                     |    9 
 include/linux/tcp.h                                         |    4 
 include/linux/userfaultfd_k.h                               |    6 
 include/net/ip_tunnels.h                                    |   30 +-
 include/net/ip_vs.h                                         |    7 
 include/net/tcp.h                                           |   58 ++--
 include/uapi/linux/ip_vs.h                                  |    6 
 kernel/bpf/verifier.c                                       |   51 +--
 kernel/events/core.c                                        |  159 ++++-------
 kernel/fork.c                                               |   12 
 kernel/trace/ftrace.c                                       |    9 
 kernel/trace/ring_buffer.c                                  |  124 +++------
 mm/damon/paddr.c                                            |   15 +
 mm/hugetlb_vmemmap.c                                        |    2 
 mm/internal.h                                               |    6 
 mm/khugepaged.c                                             |   35 +-
 mm/pagewalk.c                                               |   89 ++++--
 mm/ptdump.c                                                 |   10 
 mm/vmalloc.c                                                |   60 +++-
 net/ceph/cls_lock_client.c                                  |   21 +
 net/ceph/decode.c                                           |   18 -
 net/ceph/osdmap.c                                           |    9 
 net/core/dev.c                                              |   14 +
 net/core/pktgen.c                                           |   43 +--
 net/ipv4/bpf_tcp_ca.c                                       |    2 
 net/ipv4/tcp.c                                              |    4 
 net/ipv4/tcp_dctcp.h                                        |    2 
 net/ipv4/tcp_input.c                                        |   62 +++-
 net/ipv4/tcp_minisocks.c                                    |   12 
 net/ipv4/tcp_output.c                                       |    6 
 net/ipv4/tcp_timer.c                                        |    4 
 net/mptcp/fastopen.c                                        |    7 
 net/mptcp/options.c                                         |   67 ++++
 net/mptcp/protocol.h                                        |    1 
 net/netfilter/ipset/ip_set_bitmap_gen.h                     |    2 
 net/netfilter/ipset/ip_set_core.c                           |   19 -
 net/netfilter/ipset/ip_set_list_set.c                       |   10 
 net/netfilter/ipvs/ip_vs_conn.c                             |    4 
 net/netfilter/ipvs/ip_vs_core.c                             |    6 
 net/netfilter/ipvs/ip_vs_ctl.c                              |    4 
 net/netfilter/ipvs/ip_vs_dh.c                               |    4 
 net/netfilter/ipvs/ip_vs_lblc.c                             |    2 
 net/netfilter/ipvs/ip_vs_lblcr.c                            |    8 
 net/netfilter/nf_flow_table_core.c                          |    7 
 net/netfilter/nf_tables_offload.c                           |    2 
 net/packet/af_packet.c                                      |    7 
 net/sched/act_api.c                                         |   10 
 net/sched/cls_bpf.c                                         |   18 +
 net/sched/cls_u32.c                                         |    3 
 net/sched/sch_api.c                                         |   24 +
 net/tls/tls_sw.c                                            |    5 
 net/x25/af_x25.c                                            |    4 
 net/x25/x25_timer.c                                         |   25 +
 security/security.c                                         |    9 
 security/selinux/ss/policydb.c                              |   31 ++
 security/selinux/ss/services.c                              |   28 +-
 sound/pci/hda/patch_realtek.c                               |    1 
 sound/soc/codecs/cs35l41-lib.c                              |    2 
 sound/soc/codecs/cs35l45-tables.c                           |   32 +-
 sound/soc/codecs/cs4265.c                                   |    4 
 sound/soc/codecs/lpass-wsa-macro.c                          |    8 
 sound/soc/codecs/tas2562.c                                  |    9 
 sound/soc/intel/common/sof-function-topology-lib.c          |    7 
 sound/soc/sof/ipc4-topology.c                               |   33 ++
 sound/soc/sof/sof-audio.c                                   |    9 
 sound/soc/xilinx/xlnx_formatter_pcm.c                       |   10 
 tools/testing/selftests/bpf/progs/verifier_linked_scalars.c |  112 ++++++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh             |    4 
 231 files changed, 2838 insertions(+), 1502 deletions(-)

Aditya Chillara (1):
      perf/core: Fix group leader use-after-free after sibling detach

Ajrat Makhmutov (1):
      ALSA: hda/realtek: Enable headset mic on F+ FLAPTOP r

Aldo Ariel Panzardo (1):
      net/sched: serialize qdisc_rtab_list against concurrent get/put

Alexey Velichayshiy (1):
      netfilter: nf_tables_offload: suppress WARN_ON_ONCE for ENOMEM in abort path

Ali Ahmet Memis (1):
      openrisc: signal: do not restore privileged SR bits on sigreturn

Amir Goldstein (2):
      fsnotify: opt-in for permission events at file open time
      fs: don't block write during exec on pre-content watched files

Andy Shevchenko (1):
      libceph: Amend checking to fix `make W=1` build breakage

Asad Kamal (2):
      drm/amdgpu: fix aperture iounmap skipped on device removal
      drm/amd/pm: Use same metric table for APU

Bard Liao (1):
      ASoC: SOF: topology: Use acpi mach from the machine driver

Baul Lee (1):
      net/x25: fix use-after-free of the socket by its timers

Breno Leitao (1):
      x86/mce: Set up the polling timer before CMCI discovery

Bryam Vargas (5):
      selinux: require every boolean value to be defined
      selinux: reject a class permission count below its inherited common
      selinux: do not cancel a policy conversion that never started
      selinux: reject an unclaimed class value in security_get_classes()
      Input: synaptics-rmi4 - bound the F54 report size to the allocated buffer

Candice Li (2):
      drm/amdgpu: reject oversized IBs with per-ring packet limits
      drm/amdgpu: validate GEM_CREATE domain combinations

Cengiz Can (1):
      gpio: sloppy-logic-analyzer: fix use-after-free via debugfs trigger on unbind

Chao Shi (1):
      block: stop the timeout timer when releasing a never added disk

Chao Yu (1):
      f2fs: fix UAF issue in f2fs_merge_page_bio()

Chen Changcheng (1):
      fs/super: fix emergency thaw double-unlock of s_umount

ChenXiaoSong (3):
      smb/server: rename include guard in smb_common.h
      smb/server: fix minimum SMB1 PDU size
      smb/server: fix minimum SMB2 PDU size

Cheng Ming Lin (1):
      mtd: ubi: skip programming unused bits in ubi headers

Chengfeng Ye (1):
      net: pktgen: fix proc entry use-after-free

Chia-Yu Chang (1):
      tcp: reorganize tcp_sock_write_txrx group for variables later

Christian Brauner (8):
      super: remove pointless s_root checks
      super: skip dying superblocks early
      super: use a common iterator (Part 1)
      super: use common iterator (Part 2)
      super: fix emergency thaw deadlock on frozen block devices
      binfmt_misc: don't leak the user namespace when the mount fails
      binfmt_misc: restore write access when removing an entry
      binfmt_misc: use exe_file_deny_write_access() for the interpreter clone

Christoph Hellwig (1):
      xfs: check v5 superblock features early

Chuck Lever (1):
      net/tls: Fail tls_sw_splice_read() after a failed async decrypt

Damien Le Moal (1):
      ata: libata-scsi: terminate deferred commands on time out

Daniel Borkmann (4):
      bpf: Fix linked reg delta tracking when src_reg == dst_reg
      bpf: Clear delta when clearing reg id for non-{add,sub} ops
      selftests/bpf: Add tests for delta tracking when src_reg == dst_reg
      selftests/bpf: Add tests for stale delta leaking through id reassignment

Daniel Golle (1):
      net: ethernet: mtk_eth_soc: improve support for named interrupts

Darrick J. Wong (15):
      xfs: zero i_nlink before repair puts inode on unlinked list
      xfs: only check mergeability of bnobt records
      xfs: don't double-lock when deleting a self-referential directory
      xfs: set the prev pointer when reinserting an inode on the unlinked list
      xfs: pass runtime errors from xrep_iunlink_mark_ondisk_rec up to callers
      xfs: nlink scrub must take IOLOCK before determining ILOCK state
      xfs: load next_agino from the correct xfarray in xrep_iunlink_relink_prev
      xfs: don't zap the attr fork on repair when there are queued pptr updates
      xfs: don't walk off the end of a null sc->sa.agi_bp in AGI repair
      xfs: fix allocated inodes that show up in the unlinked list
      xfs: fix another iunlink infinite loop bug in online fsck
      xfs: don't return EFSCORRUPTED when scrubbing corrupt parent pointers
      xfs: avoid UAF on sc->tempip in xrep_tempfile_create
      xfs: check xfarray iteration errors when committing unlinked inode lists
      fs: unlock the superblock during iterate_supers_type

David Carlier (1):
      igc: remove napi_synchronize() in igc_down()

David Rosca (6):
      drm/amdgpu: Reject UVD message with invalid number of h265 refs
      drm/amdgpu: Reject UVD message with dimensions above 4096
      drm/amdgpu: Implement insert_end for VCE 3
      drm/amdgpu: Fix UVD min buffer sizes
      drm/amdgpu: Fix UVD dpb min size calculation for H264
      drm/amdgpu: Fix UVD decode image min size calculation

David Sterba (1):
      btrfs: add debug build only WARN

Dawid Osuchowski (1):
      ice: fix VF interrupts cleanup

Dawid Wróbel (1):
      ASoC: codecs: lpass-wsa-macro: Fix enum kcontrol accesses

Dmitry Torokhov (6):
      Input: synaptics-rmi4 - fix F55 transmitter electrode count typo
      Input: synaptics-rmi4 - zero report size on F54 work error
      Input: synaptics-rmi4 - block s_input when F54 queue is busy
      Input: synaptics-rmi4 - propagate F54 worker errors to V4L2 queue
      Input: sur40 - fix input device registration ordering
      Input: sur40 - fix V4L error path cleanup

Dongli Zhang (1):
      net: tap: set skb->dev before parsing virtio net header in tap_get_user_xdp()

Eric Dumazet (5):
      vxlan: use pskb_network_may_pull() for transmit path header pulls
      ipvlan: inherit needed_headroom and needed_tailroom from phy_dev
      macvlan: inherit needed_headroom and needed_tailroom from lowerdev
      af_packet: Don't send zero-byte data in tpacket_snd().
      ip_tunnel: adapt iptunnel_xmit_stats() to NETDEV_PCPU_STAT_DSTATS

Eric Farman (10):
      s390/vfio_ccw: Free all memory if cp_init() fails
      s390/vfio_ccw: Limit the number of channel program segments
      s390/vfio_ccw: Cancel existing workqueues
      s390/vfio_ccw: Ensure index for read/write regions are within range
      s390/vfio_ccw: Ensure first IDAW remains constant
      s390/vfio_ccw: Fix out of bounds check on CCW array
      s390/vfio_ccw: Move cp cleanup out of not operational
      s390/vfio_ccw: Selectively expand io_mutex
      s390/vfio_ccw: Calculate idal length based on idaw type
      s390/vfio_ccw: Implement a crw lock

Erni Sri Satya Vennela (1):
      net: mana: Fix EQ leak in mana_remove on NULL port

Filipe Manana (1):
      btrfs: remove fs_info argument from btrfs_zoned_activate_one_bg()

Florian Westphal (2):
      netfilter: ipset: fix list type element drift bug
      netfilter: ipset: let destroy callbacks adjust ext mem size

Frank Sorenson (1):
      cifs: add fscache_resize_cookie() to cifs_setsize()

Frank Wunderlich (1):
      net: ethernet: mtk_eth_soc: only use legacy mode on missing IRQ name

Gang Yan (1):
      selftests: mptcp: join: mark tests with data corruption as failed

Gao Xiang (1):
      erofs: fix EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS on some UP platforms

George Wilson (2):
      powerpc/pseries: pci - logic bug
      powerpc/pseries: lparcfg - fix kbuf[] underflow

Greg Kroah-Hartman (1):
      Linux 6.12.105

Guanghui Yang (1):
      btrfs: zoned: fix missing chunk metadata reservation

Guangshuo Li (1):
      drm/radeon: fix autosuspend cleanup during teardown

Guidong Han (1):
      eventpoll: pin files while checking reverse paths

Guillaume Nault (2):
      vrf: Make pcpu_dstats update functions available to other modules.
      vxlan: Handle stats using NETDEV_PCPU_STAT_DSTATS.

Haibo Chen (1):
      mmc: sdhci: make tuning_err a signed int

Herbert Xu (1):
      crypto: ccm - Set rfc4309 maxauthsize from child

Hidayath Khan (1):
      s390/qeth: validate user buffer length in SNMP and ARP query ioctls

HyeongJun An (1):
      Input: cs40l50-vibra - validate custom data from user space

Ilpo Järvinen (2):
      tcp: Pass flags to __tcp_send_ack
      tcp: fast path functions later

Jamal Hadi Salim (2):
      net/sched: act_api: fix TOCTOU NULL deref on a->goto_chain
      net/sched: cls_bpf: reject dev-bound programs bound to a different device

Jianing Li (1):
      Input: hynitron_cstxxx - validate touch count and finger IDs

Jiayuan Chen (1):
      tcp: fix icsk_ack.ato bitfield overflow

John Harrison (1):
      drm/connector/hdmi: Fix out of bounds memory read

Jon Hunter (1):
      arm64: tegra: Add EL2 virtual timer interrupt for Tegra194

Jonas Köppeler (1):
      veth: fix queue index used to wake the peer txq in veth_poll

Josh Poimboeuf (1):
      ftrace: Fix off-by-one fentry site disable in ftrace_free_mem()

Junrui Luo (1):
      drm/amdgpu: disallow multiple FENCE chunks in one submit

Jérémy Jean (1):
      netfilter: flowtable: publish GC-visible tuple last

Kefu Chai (1):
      libceph: tolerate addrvecs with multiple entries of the same type

Kyohei Kadota (1):
      Input: xpad - add support for ZENAIM LEVERLESS

Lance Yang (1):
      mm/khugepaged: guard is_zero_pfn() calls with pte_present()

Leon Hwang (1):
      ftrace: Protect direct_functions in ftrace_find_rec_direct

Lijo Lazar (1):
      drm/amd/pm: Use macro to initialize metrics table

Lin Jiapeng (1):
      xfs: fix exchange-range reflink flag clearing issue with INO1_WRITTEN

Linmao Li (2):
      Input: psxpad-spi - set driver data before use
      drm/xe/oa: Fix sync entry leak on OA config emit failure

Liyuan Pang (1):
      ubi: fastmap: fix ubi->fm memory leak

Long Li (2):
      xfs: fix ilock leak on error in xfs_dq_get_next_id
      xfs: don't swallow dquot recovery verification errors

Lorenzo Stoakes (1):
      mm/pagewalk: split walk_page_range_novma() into kernel/user parts

Lorenzo Stoakes (ARM) (2):
      mm/vmalloc: acquire init_mm lock on huge vmap to avoid ptdump UAF
      mm/ptdump: always stabilise against page table freeing using init_mm

Mark Brown (1):
      ASoC: tas2562: Validate values for volume writes

Matthew Brost (1):
      drm/xe: Order ring writes before ring tail updates

Matthew Wilcox (Oracle) (4):
      ceph: Remove ceph_writepage()
      ceph: Use a folio in ceph_page_mkwrite()
      ceph: Convert ceph_find_incompatible() to take a folio
      ceph: Convert writepage_nounlock() to write_folio_nounlock()

Matthieu Baerts (NGI0) (2):
      mptcp: avoid combining some incoming suboptions
      mptcp: options: reset DSS fields in case of unexpected size

Max Kellermann (3):
      ceph: avoid fs reclaim while using current->journal_info
      ceph: fix hanging __ceph_get_caps() with stale mds_wanted
      include/linux/fs.h: add inode_lock_killable()

Mike Rapoport (Microsoft) (1):
      userfaultfd: prevent registration of special VMAs

Mingyu Wang (1):
      fbdev: core: Fix pointer desynchronization in fb_io_read()

Myeonghun Pak (1):
      mmc: sdhci: unmap the bounce buffer before device release

Namjae Jeon (4):
      ksmbd: rename smb2_get_msg to smb_get_msg
      ksmbd: validate minimum PDU size for transform requests
      ksmbd: conn lock to serialize smb2 negotiate
      ksmbd: reject repeated SMB2 NEGOTIATE requests

Naohiro Aota (1):
      btrfs: add space_info argument to btrfs_chunk_alloc()

Nathan Lucas (2):
      drm/amd/display: fix BT.2020 YCbCr limited output CSC matrix
      drm/amd/display: fix BT.2020 YCbCr output CSC matrices for DCE

Osama Abdelkader (1):
      drm/panthor: skip zero-sized firmware sections

Paolo Abeni (1):
      net: harmonize tstats and dstats

Paolo Bonzini (1):
      KVM: SVM: Serialize accesses to the owner and mirror list with separate lock

Paulo Alcantara (1):
      smb: client: fix race with fallocate(2) and AIO+DIO

Pavitra Jha (2):
      libceph: fix multiple unsafe decodes in decode_locker()
      libceph: fix two unsafe bare decodes in decode_lockers()

Pei Xiao (1):
      mmc: atmel-mci: Fix use-after-free in atmci_remove due to race condition

Peiyang He (1):
      iommufd: Fix wrong hwpt passed to iommufd_auto_response_faults on replace

Pengpeng Hou (1):
      Input: iforce - validate input packet lengths

Peter Seiderer (1):
      net: pktgen: fix code style (WARNING: Block comments)

Peter Ujfalusi (5):
      ASoC: SOF: sof-audio: Fix error path in sof_widget_setup_unlocked()
      ASoC: cs4265: sort the register default table
      ASoC: cs35l45: sort the register default table
      ASoC: cs35l41: sort the register default table
      ASoC: SOF: ipc4-topology: Refresh copier IPC payload before widget setup

Peter Zijlstra (1):
      perf: Unify perf_event_free_task() / perf_event_exit_task_context()

Philipp David (1):
      igc: fix netdev not re-attached after resume if interface is down

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: move debug_vm handling to amdgpu_cs_parser_fini

Praveen Talari (1):
      pmdomain: arm: Fix -EINVAL from scmi_pd_set_perf_state() on state 0

Qiang Ma (1):
      xfs: clear zapped attr fork state when bmap repair finds no attr fork

Qiang Yu (1):
      drm/amdgpu: read TRUNCATE_COORD_MODE on gfx12

Raphael Zimmer (1):
      libceph: Avoid using invalid osd indices from primary_temp

Richard Davies (1):
      Input: focaltech - fix array out-of-bounds in focaltech_process_rel_packet

Rosen Penev (1):
      ASoC: xilinx: formatter_pcm: pass aud_drv_data to irq handlers

SJ Park (1):
      mm/damon: adjust isolated pages stat for DAMOS_MIGRATE_{HOT,COLD}

Sean Christopherson (2):
      crypto: ccp: Add external API interface for PSP module initialization
      KVM: SVM: Ensure PSP module is initialized if KVM module is built-in

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw-nuss: Fix port_id extraction from SRC TAG

Song Liu (1):
      fsnotify, lsm: Decouple fsnotify from lsm

Steven Rostedt (4):
      ring-buffer: Simplify functions with __free(kfree) to free allocations
      ring-buffer: Simplify ring_buffer_read_page() with guard()
      ring-buffer: Make ring_buffer_{un}map() simpler with guard(mutex)
      ring-buffer: Remove jump to out label in ring_buffer_swap_cpu()

Tengda Wu (1):
      ring-buffer: Use current_context for safe per-CPU buffer swap

Thorsten Blum (2):
      crypto: starfive - use scatterlist length before DMA mapping
      crypto: qce - fix error path in devm_qce_register_algs

Tu Nguyen (1):
      can: rcar_canfd: change the initializing flow for clocks and resets

Uwe Kleine-König (1):
      m68k: Define NR_CPUS to 1

Vincent Donnefort (2):
      ring-buffer: Initialise reader page order in rb_allocate_cpu_buffer()
      ring-buffer: Prevent resizing of persistent ring buffer

Vladislav Dronov (1):
      crypto: tegra - fix rctx->cryptlen calculation in tegra_gcm_do_one_req()

Wei Fang (1):
      net: packet: fix wrong transport_header when sending VLAN-tagged frame

Weiming Shi (1):
      KVM: x86: Cancel delayed I/O APIC EOI handling before destroying vCPUs

Wentao Liang (1):
      ceph: fix writeback_count leak in write_folio_nounlock()

Wyatt Feng (1):
      mptcp: fastopen: only mark MPTFO subflows with SYN data

Xiang Mei (1):
      libceph: bound pg_{temp,upmap,upmap_items} length to CEPH_PG_MAX_SIZE

Xiang Mei (Microsoft) (1):
      netfilter: ipset: fix refcount race between list:set GC and swap

Yang Wang (5):
      drm/amdgpu: fix nbif 6.3.1 l1 low power not functional
      drm/amdgpu: check ASPM on the dGPU host link
      drm/amd/pm: fix torn gpu metrics reads
      drm/amd/pm: adjust the visibility of pp_table sysfs node
      drm/amd/pm: fix pptable use-after-free

Yazen Ghannam (2):
      x86/mce: Remove __mcheck_cpu_init_early()
      x86/mce: Set CR4.MCE last during init

Yiming Zhu (1):
      ceph: fix MDS random selection readiness predicate

Yizhou Zhao (1):
      ipvs: separate destination availability state

Yunxiang Li (1):
      drm/amdgpu: remove unused function parameter

Yuxiang Yang (1):
      tcp: challenge ACK for non-exact RST in SYN-RECEIVED

Zack Rusin (1):
      drm/vmwgfx: take fman->lock around fence list mutation in fifo_down

Zhan Xusheng (1):
      mmc: omap_hsmmc: fix busy_timeout overflow in ns conversion on 32-bit

Zhang Changzhong (1):
      net/sched: cls_u32: skip hash tables in u32_bind_class()

ZhangGuoDong (2):
      smb: move smb_version_values to common/smbglob.h
      smb: move get_rfc1002_len() to common/smbglob.h

Zhefu Zhang (1):
      Input: atkbd - skip deactivate for Xiaomi Book Pro 14's internal keyboard

liyouhong (1):
      mm/damon/ops-common: putback folios on invalid migrate nid

