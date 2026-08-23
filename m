Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70203C4544;
	Sun, 23 Aug 2026 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787489133; cv=none; b=kq5tyPG/80NEDfisdRkUXAAcQx8phenkez8e/RAGIUPuLtoGsEHGf24LirckdyTBz7mQ1qtpRPQNeoGfReFSwUnibGIi6VX0nFfw2oW61FEhviVFV34SSTuWmawnYPB+AionX2KdtRfi0ydZYrpsRzndqRiHjW752Et9KYAz8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787489133; c=relaxed/simple;
	bh=wvIkqlTCFjfCk2KJe4/6hi+0TQw/V00bAU33iqpE8q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XvtlzR+TYWVtEHNlPM2GbukiBL7hEZ88ID8wBd/j7mlFleI07ig6pfR8KBJjroQ/UUSsyldTbPedaL1k99mbgbrqubPzUq0Ma+I7MWz6vdpVg+Jmrpc/6l1vfD1Ulfdhik5mQebK5dEslJwvyVbzg8bEhxxCzSA32nWXKds6s8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sESsRv21; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sESsRv21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB671F000E9;
	Sun, 23 Aug 2026 12:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787489131;
	bh=MxRhoTcqJNmUcaSe6+XXtiVli+y4Er/qOTzPyjGtEp8=;
	h=From:To:Cc:Subject:Date;
	b=sESsRv21ZJ2i1SHCPMdb1u+oQ+ws0yBYJ3Uzty2rLyh+V7GEmoxPBwKR3cvJf1CFs
	 L0g4BFdjthny4S/+/WQP2aBk1thjWWxa06XbymbV7OITAQPrRWxc2kIxh5/IV/bOUw
	 wUkdMgEdDvwKStmCxfOjVVaCXFjuAlx+jPa63mps=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.153
Date: Sun, 23 Aug 2026 14:43:50 +0200
Message-ID: <2026082350-scratch-gallantly-e9b7@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.153 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                            |    2 
 arch/arm/Kconfig                                    |    1 
 arch/arm64/boot/dts/nvidia/tegra194.dtsi            |    2 
 arch/m68k/Kconfig                                   |    7 -
 arch/m68k/Kconfig.cpu                               |   16 +++
 arch/m68k/kernel/Makefile                           |    2 
 arch/m68k/kernel/dma.c                              |    2 
 arch/openrisc/include/asm/processor.h               |    2 
 arch/openrisc/kernel/dma.c                          |    4 
 arch/openrisc/kernel/signal.c                       |    5 -
 arch/parisc/Kconfig                                 |    1 
 arch/powerpc/platforms/pseries/lparcfg.c            |    2 
 arch/powerpc/platforms/pseries/pci.c                |    2 
 arch/riscv/include/asm/pgtable-32.h                 |    3 
 arch/riscv/include/asm/pgtable.h                    |    1 
 arch/riscv/mm/init.c                                |    2 
 arch/riscv/mm/pageattr.c                            |    8 -
 arch/x86/kvm/svm/sev.c                              |   34 +++++--
 arch/x86/kvm/svm/svm.h                              |    1 
 block/genhd.c                                       |   12 +-
 crypto/ccm.c                                        |    2 
 drivers/crypto/qce/core.c                           |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c              |   34 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c             |   21 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c             |   10 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c             |   85 ++++---------------
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c               |   26 +++++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                 |   27 +++++-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                  |   16 ---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h             |    6 -
 drivers/gpu/drm/radeon/radeon_kms.c                 |    1 
 drivers/i2c/busses/i2c-bcm-iproc.c                  |   11 ++
 drivers/input/joystick/iforce/iforce-packets.c      |   11 ++
 drivers/input/joystick/iforce/iforce-usb.c          |    3 
 drivers/input/joystick/psxpad-spi.c                 |    1 
 drivers/input/joystick/xpad.c                       |    2 
 drivers/input/keyboard/atkbd.c                      |    8 +
 drivers/input/mouse/focaltech.c                     |    2 
 drivers/input/rmi4/rmi_f54.c                        |   43 +++++++--
 drivers/input/rmi4/rmi_f55.c                        |    4 
 drivers/input/touchscreen/hynitron_cstxxx.c         |   13 ++
 drivers/input/touchscreen/sur40.c                   |   23 ++---
 drivers/mmc/host/omap_hsmmc.c                       |    2 
 drivers/mmc/host/sdhci.c                            |   16 +++
 drivers/mmc/host/sdhci.h                            |    2 
 drivers/net/can/rcar/rcar_canfd.c                   |   28 +++---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c         |   27 ++++++
 drivers/net/ethernet/intel/ice/ice_vf_lib_private.h |    1 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c       |   21 ++++
 drivers/net/ethernet/intel/igc/igc_main.c           |    1 
 drivers/net/ethernet/microsoft/mana/mana_en.c       |    4 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c            |    2 
 drivers/net/ipvlan/ipvlan_main.c                    |    4 
 drivers/net/macvlan.c                               |    4 
 drivers/net/veth.c                                  |    4 
 drivers/net/vrf.c                                   |   49 +++--------
 drivers/net/vxlan/vxlan_core.c                      |   45 ++++------
 drivers/net/vxlan/vxlan_mdb.c                       |    4 
 drivers/s390/cio/vfio_ccw_async.c                   |   16 +++
 drivers/s390/cio/vfio_ccw_chp.c                     |   17 +++
 drivers/s390/cio/vfio_ccw_cp.c                      |   31 ++++---
 drivers/s390/cio/vfio_ccw_cp.h                      |    8 +
 drivers/s390/cio/vfio_ccw_drv.c                     |   15 ++-
 drivers/s390/cio/vfio_ccw_fsm.c                     |    8 +
 drivers/s390/cio/vfio_ccw_ops.c                     |   35 +++++++
 drivers/s390/cio/vfio_ccw_private.h                 |    6 +
 drivers/s390/net/qeth_core_main.c                   |    3 
 drivers/s390/net/qeth_l3_main.c                     |    5 +
 drivers/video/fbdev/core/fb_io_fops.c               |    8 +
 fs/binfmt_elf.c                                     |    4 
 fs/binfmt_elf_fdpic.c                               |    4 
 fs/binfmt_misc.c                                    |   14 ++-
 fs/btrfs/block-group.c                              |   61 ++++++++-----
 fs/btrfs/block-group.h                              |    3 
 fs/btrfs/extent-tree.c                              |    6 -
 fs/btrfs/messages.h                                 |    7 +
 fs/btrfs/space-info.c                               |    2 
 fs/btrfs/transaction.c                              |    5 -
 fs/btrfs/zoned.c                                    |    5 -
 fs/btrfs/zoned.h                                    |    6 -
 fs/ceph/addr.c                                      |   54 +++---------
 fs/ceph/caps.c                                      |   17 +++
 fs/ceph/file.c                                      |    9 +-
 fs/ceph/mds_client.c                                |   11 ++
 fs/ceph/mds_client.h                                |    2 
 fs/ceph/mdsmap.c                                    |    2 
 fs/erofs/Kconfig                                    |    3 
 fs/exec.c                                           |    6 -
 fs/f2fs/data.c                                      |    2 
 fs/iomap/buffered-io.c                              |   42 +++++----
 fs/smb/client/cifsglob.h                            |   27 ------
 fs/smb/client/cifssmb.c                             |    6 -
 fs/smb/client/connect.c                             |    2 
 fs/smb/client/transport.c                           |    8 -
 fs/smb/common/cifsglob.h                            |   36 ++++++++
 fs/smb/server/auth.c                                |    4 
 fs/smb/server/connection.c                          |   23 +++--
 fs/smb/server/connection.h                          |    5 +
 fs/smb/server/oplock.c                              |    8 -
 fs/smb/server/smb2misc.c                            |    2 
 fs/smb/server/smb2ops.c                             |   32 +++----
 fs/smb/server/smb2pdu.c                             |   88 +++++++++-----------
 fs/smb/server/smb2pdu.h                             |    9 --
 fs/smb/server/smb_common.c                          |   43 +++++++--
 fs/smb/server/smb_common.h                          |   43 ++-------
 fs/super.c                                          |   22 +++--
 fs/userfaultfd.c                                    |   20 ++--
 fs/xfs/libxfs/xfs_sb.c                              |    4 
 fs/xfs/scrub/alloc.c                                |    5 -
 fs/xfs/xfs_dquot.c                                  |    3 
 fs/xfs/xfs_dquot_item_recover.c                     |    2 
 include/asm-generic/pgtable_uffd.h                  |   17 +++
 include/linux/fs.h                                  |   12 ++
 include/linux/mm_inline.h                           |    7 -
 include/linux/mmap_lock.h                           |    4 
 include/linux/netdevice.h                           |   52 ++++++++++-
 include/linux/pagewalk.h                            |    7 -
 include/linux/userfaultfd_k.h                       |   19 ----
 include/net/dropreason-core.h                       |   21 ++++
 include/net/gro.h                                   |    1 
 include/net/ip_vs.h                                 |    7 +
 include/net/pkt_cls.h                               |   16 +++
 include/net/pkt_sched.h                             |    3 
 include/net/sch_generic.h                           |    2 
 include/net/tcp.h                                   |   58 ++++++-------
 include/uapi/linux/ip_vs.h                          |    6 -
 kernel/dma/Kconfig                                  |    9 ++
 kernel/dma/direct.c                                 |   12 --
 kernel/fork.c                                       |   12 +-
 kernel/trace/ftrace.c                               |    9 +-
 kernel/trace/ring_buffer.c                          |   23 ++---
 mm/huge_memory.c                                    |   43 ++++++---
 mm/internal.h                                       |    7 +
 mm/migrate_device.c                                 |    5 -
 mm/pagewalk.c                                       |   82 ++++++++++++++++--
 mm/ptdump.c                                         |   10 ++
 mm/userfaultfd.c                                    |   26 +++++
 mm/vmalloc.c                                        |   49 +++++++++--
 net/ceph/cls_lock_client.c                          |   21 +++-
 net/ceph/decode.c                                   |   18 ++--
 net/ceph/osdmap.c                                   |    9 +-
 net/core/dev.c                                      |   29 +++++-
 net/core/gro.c                                      |   31 +++++++
 net/core/pktgen.c                                   |   43 +++++----
 net/ipv4/bpf_tcp_ca.c                               |    2 
 net/ipv4/tcp_dctcp.h                                |    2 
 net/ipv4/tcp_input.c                                |   56 +++++++++---
 net/ipv4/tcp_minisocks.c                            |   12 ++
 net/ipv4/tcp_output.c                               |    6 -
 net/ipv4/udp_offload.c                              |   29 ------
 net/mptcp/fastopen.c                                |    7 -
 net/mptcp/options.c                                 |   67 ++++++++++++++-
 net/mptcp/protocol.h                                |    1 
 net/netfilter/ipset/ip_set_bitmap_gen.h             |    2 
 net/netfilter/ipset/ip_set_core.c                   |   19 ++--
 net/netfilter/ipset/ip_set_list_set.c               |   10 +-
 net/netfilter/ipvs/ip_vs_conn.c                     |    4 
 net/netfilter/ipvs/ip_vs_core.c                     |    6 -
 net/netfilter/ipvs/ip_vs_ctl.c                      |    4 
 net/netfilter/ipvs/ip_vs_dh.c                       |    4 
 net/netfilter/ipvs/ip_vs_lblc.c                     |    2 
 net/netfilter/ipvs/ip_vs_lblcr.c                    |    8 -
 net/netfilter/nf_flow_table_core.c                  |    7 -
 net/netfilter/nf_tables_offload.c                   |    2 
 net/packet/af_packet.c                              |   27 ++----
 net/sched/act_api.c                                 |   13 +-
 net/sched/cls_api.c                                 |   32 +++++--
 net/sched/cls_bpf.c                                 |   18 +++-
 net/sched/cls_u32.c                                 |    3 
 net/sched/sch_api.c                                 |   24 ++++-
 net/tls/tls_sw.c                                    |    5 +
 net/x25/af_x25.c                                    |    4 
 net/x25/x25_timer.c                                 |   25 +++--
 security/selinux/ss/policydb.c                      |   31 +++++++
 security/selinux/ss/services.c                      |   28 +++++-
 sound/soc/codecs/cs35l41-lib.c                      |    2 
 sound/soc/codecs/cs35l45-tables.c                   |   32 +++----
 sound/soc/codecs/cs4265.c                           |    4 
 sound/soc/codecs/lpass-wsa-macro.c                  |    8 -
 sound/soc/codecs/tas2562.c                          |    9 +-
 sound/soc/fsl/fsl_sai.c                             |   29 +++++-
 sound/soc/sof/sof-audio.c                           |    9 --
 sound/soc/xilinx/xlnx_formatter_pcm.c               |   10 --
 tools/testing/selftests/net/mptcp/mptcp_join.sh     |    4 
 184 files changed, 1786 insertions(+), 934 deletions(-)

Aldo Ariel Panzardo (1):
      net/sched: serialize qdisc_rtab_list against concurrent get/put

Alexey Velichayshiy (1):
      netfilter: nf_tables_offload: suppress WARN_ON_ONCE for ENOMEM in abort path

Ali Ahmet Memis (1):
      openrisc: signal: do not restore privileged SR bits on sigreturn

Amir Goldstein (1):
      fs: don't block write during exec on pre-content watched files

Andy Shevchenko (1):
      libceph: Amend checking to fix `make W=1` build breakage

Asad Kamal (1):
      drm/amdgpu: fix aperture iounmap skipped on device removal

Baul Lee (1):
      net/x25: fix use-after-free of the socket by its timers

Breno Leitao (1):
      vxlan: Do not alloc tstats manually

Bryam Vargas (5):
      selinux: require every boolean value to be defined
      selinux: reject a class permission count below its inherited common
      selinux: do not cancel a policy conversion that never started
      selinux: reject an unclaimed class value in security_get_classes()
      Input: synaptics-rmi4 - bound the F54 report size to the allocated buffer

Candice Li (1):
      drm/amdgpu: validate GEM_CREATE domain combinations

Chancel Liu (1):
      ASoC: fsl_sai: Fix spurious BCLK on resume by clearing BYP

Chao Shi (1):
      block: stop the timeout timer when releasing a never added disk

Chao Yu (1):
      f2fs: fix UAF issue in f2fs_merge_page_bio()

ChenXiaoSong (3):
      smb/server: rename include guard in smb_common.h
      smb/server: fix minimum SMB1 PDU size
      smb/server: fix minimum SMB2 PDU size

Chengfeng Ye (1):
      net: pktgen: fix proc entry use-after-free

Christian Brauner (3):
      super: fix emergency thaw deadlock on frozen block devices
      binfmt_misc: restore write access when removing an entry
      binfmt_misc: use exe_file_deny_write_access() for the interpreter clone

Christoph Hellwig (3):
      xfs: check v5 superblock features early
      dma-direct: add a CONFIG_ARCH_HAS_DMA_ALLOC symbol
      m68k: use the coherent DMA code for coldfire without data cache

Chuck Lever (1):
      net/tls: Fail tls_sw_splice_read() after a failed async decrypt

Chunyan Zhang (1):
      mm: userfaultfd: add pgtable_supports_uffd_wp()

Daniel Borkmann (2):
      net, sched: Make tc-related drop reason more flexible
      net, sched: Add tcf_set_drop_reason for {__,}tcf_classify

Darrick J. Wong (1):
      xfs: only check mergeability of bnobt records

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

Eric Dumazet (4):
      vxlan: use pskb_network_may_pull() for transmit path header pulls
      ipvlan: inherit needed_headroom and needed_tailroom from phy_dev
      macvlan: inherit needed_headroom and needed_tailroom from lowerdev
      af_packet: Don't send zero-byte data in tpacket_snd().

Eric Farman (6):
      s390/vfio_ccw: Limit the number of channel program segments
      s390/vfio_ccw: Cancel existing workqueues
      s390/vfio_ccw: Ensure index for read/write regions are within range
      s390/vfio_ccw: Fix out of bounds check on CCW array
      s390/vfio_ccw: Move cp cleanup out of not operational
      s390/vfio_ccw: Selectively expand io_mutex

Erni Sri Satya Vennela (1):
      net: mana: Fix EQ leak in mana_remove on NULL port

Felix Fietkau (1):
      net: move skb_gro_receive_list from udp to core

Filipe Manana (1):
      btrfs: remove fs_info argument from btrfs_zoned_activate_one_bg()

Florian Westphal (2):
      netfilter: ipset: fix list type element drift bug
      netfilter: ipset: let destroy callbacks adjust ext mem size

Gang Yan (1):
      selftests: mptcp: join: mark tests with data corruption as failed

Gao Xiang (1):
      erofs: fix EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS on some UP platforms

George Wilson (2):
      powerpc/pseries: pci - logic bug
      powerpc/pseries: lparcfg - fix kbuf[] underflow

Greg Kroah-Hartman (1):
      Linux 6.6.153

Guanghui Yang (1):
      btrfs: zoned: fix missing chunk metadata reservation

Guangshuo Li (1):
      drm/radeon: fix autosuspend cleanup during teardown

Guillaume Nault (2):
      vrf: Make pcpu_dstats update functions available to other modules.
      vxlan: Handle stats using NETDEV_PCPU_STAT_DSTATS.

Haibo Chen (1):
      mmc: sdhci: make tuning_err a signed int

Herbert Xu (1):
      crypto: ccm - Set rfc4309 maxauthsize from child

Hidayath Khan (1):
      s390/qeth: validate user buffer length in SNMP and ARP query ioctls

Ilpo Järvinen (2):
      tcp: Pass flags to __tcp_send_ack
      tcp: fast path functions later

Jamal Hadi Salim (3):
      net, sched: Fix SKB_NOT_DROPPED_YET splat under debug config
      net/sched: act_api: fix TOCTOU NULL deref on a->goto_chain
      net/sched: cls_bpf: reject dev-bound programs bound to a different device

Jeremy Kerr (1):
      net: core,vrf: Change pcpu_dstat fields to u64_stats_t

Jianing Li (1):
      Input: hynitron_cstxxx - validate touch count and finger IDs

Jon Hunter (1):
      arm64: tegra: Add EL2 virtual timer interrupt for Tegra194

Jonas Gorski (1):
      i2c: iproc: reset bus after timeout if START_BUSY is stuck

Josh Poimboeuf (1):
      ftrace: Fix off-by-one fentry site disable in ftrace_free_mem()

Junrui Luo (1):
      drm/amdgpu: disallow multiple FENCE chunks in one submit

Jérémy Jean (1):
      netfilter: flowtable: publish GC-visible tuple last

Kefeng Wang (1):
      mm: migrate_device: fix pte_pfn/pte_dirty called on non-present PTE

Kefu Chai (1):
      libceph: tolerate addrvecs with multiple entries of the same type

Kyohei Kadota (1):
      Input: xpad - add support for ZENAIM LEVERLESS

Leon Hwang (1):
      ftrace: Protect direct_functions in ftrace_find_rec_direct

Linmao Li (1):
      Input: psxpad-spi - set driver data before use

Long Li (2):
      xfs: fix ilock leak on error in xfs_dq_get_next_id
      xfs: don't swallow dquot recovery verification errors

Lorenzo Stoakes (1):
      mm/pagewalk: split walk_page_range_novma() into kernel/user parts

Lorenzo Stoakes (ARM) (3):
      mm/vmalloc: acquire init_mm lock on huge vmap to avoid ptdump UAF
      mm/ptdump: always stabilise against page table freeing using init_mm
      mm/huge_memory: fix huge_zero_pfn race

Mark Brown (1):
      ASoC: tas2562: Validate values for volume writes

Matt Fleming (1):
      veth: convert frag_list skbs before running XDP

Matthew Wilcox (Oracle) (3):
      ceph: Remove ceph_writepage()
      ceph: Use a folio in ceph_page_mkwrite()
      iomap: hold state_lock over call to ifs_set_range_uptodate()

Matthieu Baerts (NGI0) (2):
      mptcp: avoid combining some incoming suboptions
      mptcp: options: reset DSS fields in case of unexpected size

Max Kellermann (2):
      ceph: avoid fs reclaim while using current->journal_info
      ceph: fix hanging __ceph_get_caps() with stale mds_wanted

Mike Rapoport (Microsoft) (2):
      userfaultfd: move vma_can_userfault out of line
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

Palmer Dabbelt (1):
      RISC-V: Provide pgtable_l5_enabled on rv32

Paolo Abeni (1):
      net: harmonize tstats and dstats

Paolo Bonzini (1):
      KVM: SVM: Serialize accesses to the owner and mirror list with separate lock

Pavitra Jha (2):
      libceph: fix multiple unsafe decodes in decode_locker()
      libceph: fix two unsafe bare decodes in decode_lockers()

Pengpeng Hou (1):
      Input: iforce - validate input packet lengths

Peter Seiderer (1):
      net: pktgen: fix code style (WARNING: Block comments)

Peter Ujfalusi (4):
      ASoC: SOF: sof-audio: Fix error path in sof_widget_setup_unlocked()
      ASoC: cs4265: sort the register default table
      ASoC: cs35l45: sort the register default table
      ASoC: cs35l41: sort the register default table

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: move debug_vm handling to amdgpu_cs_parser_fini

Raphael Zimmer (1):
      libceph: Avoid using invalid osd indices from primary_temp

Richard Davies (1):
      Input: focaltech - fix array out-of-bounds in focaltech_process_rel_packet

Rosen Penev (1):
      ASoC: xilinx: formatter_pcm: pass aud_drv_data to irq handlers

Shiming Cheng (1):
      net: gro: fix double aggregation of flush-marked skbs

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw-nuss: Fix port_id extraction from SRC TAG

Steven Rostedt (1):
      ring-buffer: Remove jump to out label in ring_buffer_swap_cpu()

Tengda Wu (1):
      ring-buffer: Use current_context for safe per-CPU buffer swap

Thorsten Blum (1):
      crypto: qce - fix error path in devm_qce_register_algs

Tu Nguyen (1):
      can: rcar_canfd: change the initializing flow for clocks and resets

Uwe Kleine-König (1):
      m68k: Define NR_CPUS to 1

Victor Nogueira (2):
      net: sched: Move drop_reason to struct tc_skb_cb
      net: sched: Add initial TC error skb drop reasons

Wei Fang (1):
      net: packet: fix wrong transport_header when sending VLAN-tagged frame

Wolfram Sang (1):
      i2c: bcm-iproc: remove printout on handled timeouts

Wyatt Feng (1):
      mptcp: fastopen: only mark MPTFO subflows with SYN data

Xiang Mei (1):
      libceph: bound pg_{temp,upmap,upmap_items} length to CEPH_PG_MAX_SIZE

Xiang Mei (Microsoft) (1):
      netfilter: ipset: fix refcount race between list:set GC and swap

Yan Zhai (1):
      packet: add a generic drop reason for receive

Yang Wang (2):
      drm/amd/pm: fix torn gpu metrics reads
      drm/amd/pm: fix pptable use-after-free

Yiming Zhu (1):
      ceph: fix MDS random selection readiness predicate

Yizhou Zhao (1):
      ipvs: separate destination availability state

Yuxiang Yang (1):
      tcp: challenge ACK for non-exact RST in SYN-RECEIVED

Zhan Xusheng (1):
      mmc: omap_hsmmc: fix busy_timeout overflow in ns conversion on 32-bit

Zhang Changzhong (1):
      net/sched: cls_u32: skip hash tables in u32_bind_class()

Zhang Yi (1):
      iomap: fix out-of-bounds bitmap_set() with zero-length range

ZhangGuoDong (2):
      smb: move smb_version_values to common/smbglob.h
      smb: move get_rfc1002_len() to common/smbglob.h

Zhefu Zhang (1):
      Input: atkbd - skip deactivate for Xiaomi Book Pro 14's internal keyboard

