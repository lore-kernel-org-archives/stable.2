Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222673A75A3;
	Sat,  4 Jul 2026 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783166338; cv=none; b=pecanrarhMwaFpd2n154rFN/6twcAt43p3rVkTCPa9VJ9LPyK8lUverXL7Iq+Y0jAWKob/OVRt9SB53mL6fpDRnhTL1nTnbGNUyEw7rvCsS8mUO6vHlNeBpU8itttID1HJKRSNmJHdRc+aSZRNfbUo/GXzfvK96HzLz9vsiI10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783166338; c=relaxed/simple;
	bh=63aV3pEDO1ymepE5wGzM8hzG9owYTkfihOaXZ44xrWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YbR7ag2qqaOBB1w5U28Hz2rrIjGFKc9rSO3KO/XkueOUC1hpNPbxNI+sLTjK6FuW/wwTsS33A8wvYCxuqznDBAlg0QPRM6OcOsaHbCertojYmQNqsqj701teSAvHTqLt0abf823wn5b18KgRw1rvajmf+Prl7pr31J5fONMbC7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PFbczkAJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PFbczkAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1BE1F00A3D;
	Sat,  4 Jul 2026 11:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783166335;
	bh=mQC20uwGRYI+lP/QSEMPyDJKJpG8R3cmfPtlnvZT5l0=;
	h=From:To:Cc:Subject:Date;
	b=PFbczkAJqes8Spi3MjTOodksM9zvkrWDBIyVrPmC0wFQNX6Z6LXRTESaX+BWvcOnG
	 xUrD89scLBMmaX2fgL03qZwtqp291iku9mHpFxkbn1bzmWafBNES4Vng3l8atBwpt5
	 sjqld8+LJoQSLzI9CdVOfPve/J2CDi8eCYzxID+Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.177
Date: Sat,  4 Jul 2026 13:58:55 +0200
Message-ID: <2026070455-slum-matrix-749c@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.177 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/userspace-api/ioctl/ioctl-number.rst         |  463 ++++++-------
 Makefile                                                   |    2 
 arch/arm/mm/alignment.c                                    |    4 
 arch/arm/mm/fault.c                                        |   94 ++
 arch/mips/dec/prom/console.c                               |    7 
 arch/x86/include/asm/kvm-x86-ops.h                         |    1 
 arch/x86/include/asm/kvm_host.h                            |    1 
 arch/x86/kvm/mmu/mmu.c                                     |   28 
 arch/x86/kvm/svm/sev.c                                     |    1 
 arch/x86/kvm/vmx/nested.c                                  |   45 +
 arch/x86/kvm/vmx/posted_intr.h                             |   10 
 arch/x86/kvm/vmx/vmenter.S                                 |    2 
 arch/x86/kvm/vmx/vmx.c                                     |   21 
 arch/x86/kvm/vmx/vmx_ops.h                                 |   18 
 arch/x86/kvm/x86.c                                         |   10 
 drivers/char/agp/amd64-agp.c                               |    2 
 drivers/crypto/qat/qat_common/adf_cfg_common.h             |   32 
 drivers/crypto/qat/qat_common/adf_cfg_user.h               |   38 -
 drivers/crypto/qat/qat_common/adf_common_drv.h             |    3 
 drivers/crypto/qat/qat_common/adf_ctl_drv.c                |  425 -----------
 drivers/crypto/qat/qat_common/adf_dev_mgr.c                |   70 -
 drivers/fpga/of-fpga-region.c                              |    3 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c          |   15 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c         |   27 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h   |    5 
 drivers/gpu/drm/v3d/v3d_drv.h                              |    8 
 drivers/gpu/drm/v3d/v3d_gem.c                              |    5 
 drivers/gpu/drm/v3d/v3d_irq.c                              |   24 
 drivers/gpu/drm/v3d/v3d_sched.c                            |   36 -
 drivers/hv/hv_kvp.c                                        |   25 
 drivers/hv/vmbus_drv.c                                     |   29 
 drivers/i2c/i2c-stub.c                                     |    5 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                   |    2 
 drivers/irqchip/irq-imgpdc.c                               |    6 
 drivers/media/test-drivers/vidtv/vidtv_mux.c               |    8 
 drivers/misc/fastrpc.c                                     |    7 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c         |    8 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h         |    1 
 drivers/net/wan/hdlc_ppp.c                                 |   15 
 drivers/net/wireless/ath/ath11k/dp.c                       |    1 
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c            |    1 
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h       |    2 
 drivers/ntb/hw/epf/ntb_hw_epf.c                            |    3 
 drivers/power/reset/linkstation-poweroff.c                 |    2 
 drivers/regulator/core.c                                   |   10 
 drivers/rpmsg/rpmsg_char.c                                 |    8 
 drivers/tty/serial/8250/8250_dw.c                          |    4 
 drivers/tty/vt/vc_screen.c                                 |    2 
 drivers/video/fbdev/core/fbmem.c                           |   12 
 drivers/video/fbdev/core/modedb.c                          |    2 
 fs/dlm/lockspace.c                                         |    2 
 fs/exfat/dir.c                                             |    4 
 fs/ext4/inline.c                                           |    8 
 fs/f2fs/acl.c                                              |   18 
 fs/f2fs/file.c                                             |    9 
 fs/f2fs/inode.c                                            |    9 
 fs/fuse/dev.c                                              |   23 
 fs/fuse/file.c                                             |    8 
 fs/nfs/pnfs.c                                              |    2 
 fs/nfs/pnfs_nfs.c                                          |    4 
 fs/nfsd/nfs2acl.c                                          |   17 
 fs/nfsd/nfs3acl.c                                          |   17 
 fs/nfsd/nfs4recover.c                                      |    3 
 fs/nfsd/nfs4xdr.c                                          |    3 
 fs/ntfs3/xattr.c                                           |   12 
 fs/ocfs2/suballoc.c                                        |   22 
 fs/smb/server/smb2pdu.c                                    |    5 
 fs/smb/server/smbacl.c                                     |    4 
 include/keys/request_key_auth-type.h                       |    2 
 include/linux/kvm_host.h                                   |    7 
 include/linux/lockdep.h                                    |   14 
 include/linux/lockdep_types.h                              |    1 
 include/linux/ring_buffer.h                                |    4 
 include/linux/skmsg.h                                      |   15 
 include/net/netfilter/nf_tables.h                          |    6 
 include/net/phonet/pn_dev.h                                |    2 
 include/net/tc_act/tc_pedit.h                              |    1 
 kernel/bpf/cgroup.c                                        |    2 
 kernel/locking/lockdep.c                                   |   28 
 kernel/locking/rtmutex.c                                   |    3 
 kernel/locking/rtmutex_api.c                               |    2 
 kernel/trace/ring_buffer.c                                 |   67 -
 kernel/trace/trace.c                                       |   14 
 kernel/trace/trace_kdb.c                                   |    8 
 lib/debugobjects.c                                         |   57 +
 mm/vmscan.c                                                |   13 
 net/9p/client.c                                            |    3 
 net/batman-adv/bat_iv_ogm.c                                |   11 
 net/batman-adv/bat_v.c                                     |    1 
 net/batman-adv/bat_v_ogm.c                                 |   23 
 net/batman-adv/bridge_loop_avoidance.c                     |   28 
 net/batman-adv/distributed-arp-table.c                     |   12 
 net/batman-adv/fragmentation.c                             |   22 
 net/batman-adv/fragmentation.h                             |    3 
 net/batman-adv/netlink.c                                   |    8 
 net/batman-adv/routing.c                                   |   64 +
 net/batman-adv/tp_meter.c                                  |  113 ++-
 net/batman-adv/translation-table.c                         |   32 
 net/batman-adv/tvlv.c                                      |   69 +
 net/batman-adv/types.h                                     |   21 
 net/core/filter.c                                          |   27 
 net/core/skmsg.c                                           |   16 
 net/ipv4/tcp.c                                             |    4 
 net/ipv4/tcp_bpf.c                                         |    2 
 net/ipv4/tcp_input.c                                       |   14 
 net/ipv4/tcp_minisocks.c                                   |    2 
 net/ipv4/udp.c                                             |    2 
 net/ipv4/udp_bpf.c                                         |    2 
 net/ipv6/ip6_output.c                                      |    4 
 net/ipv6/ip6_vti.c                                         |    1 
 net/mac802154/llsec.c                                      |   14 
 net/mptcp/pm_userspace.c                                   |   13 
 net/mptcp/protocol.c                                       |    4 
 net/netfilter/nf_tables_api.c                              |   74 +-
 net/netfilter/nft_set_rbtree.c                             |   43 +
 net/phonet/pn_dev.c                                        |   12 
 net/phonet/pn_netlink.c                                    |   23 
 net/sched/act_pedit.c                                      |  101 +-
 net/tipc/crypto.c                                          |    9 
 net/tls/tls_sw.c                                           |    4 
 net/unix/af_unix.c                                         |   11 
 security/apparmor/include/policy_unpack.h                  |   19 
 security/apparmor/lsm.c                                    |   16 
 security/apparmor/policy.c                                 |    8 
 security/keys/internal.h                                   |    2 
 security/keys/keyctl.c                                     |   24 
 security/keys/keyctl_pkey.c                                |    9 
 security/keys/request_key_auth.c                           |   33 
 tools/perf/bench/find-bit-bench.c                          |    8 
 tools/perf/util/block-range.c                              |    6 
 tools/testing/selftests/bpf/bench.h                        |    9 
 tools/testing/selftests/bpf/prog_tests/empty_skb.c         |   25 
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c |    8 
 tools/testing/selftests/bpf/prog_tests/perf_link.c         |   15 
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c       |  154 ++--
 tools/testing/selftests/bpf/prog_tests/test_tunnel.c       |   71 -
 tools/testing/selftests/bpf/prog_tests/xdp_bonding.c       |   40 -
 tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c   |   30 
 tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c      |   41 -
 tools/testing/selftests/bpf/test_progs.h                   |   15 
 tools/testing/selftests/bpf/testing_helpers.h              |   10 
 tools/testing/selftests/ptp/testptp.c                      |   19 
 142 files changed, 1796 insertions(+), 1527 deletions(-)

Abel Vesa (1):
      misc: fastrpc: Add dma_mask to fastrpc_channel_ctx

André Draszik (1):
      regulator: core: fix locking in regulator_resolve_supply() error path

Ashutosh Desai (1):
      KVM: SVM: Fix page overflow in sev_dbg_crypt() for ENCRYPT path

Bagas Sanjaya (1):
      Documentation: ioctl-number: Extend "Include File" column width

Bitterblue Smith (1):
      wifi: rtlwifi: rtl8821ae: Fix C2H bit location in RX descriptor

Bjoern Doebel (1):
      ring-buffer: Remove ring_buffer_read_prepare_sync()

Bryam Vargas (1):
      apparmor: mediate the implicit connect of TCP fast open sendmsg

Davidlohr Bueso (1):
      locking/rtmutex: Skip remove_waiter() when waiter is not enqueued

Dawei Feng (1):
      bpf: use kvfree() for replaced sysctl write buffer

Deepak Kumar Singh (1):
      rpmsg: char: Add lock to avoid race when rpmsg device is released

Dexuan Cui (1):
      Drivers: hv: vmbus: Improve the logic of reserving fb_mmio on Gen2 VMs

Dominik Woźniak (1):
      nfsd: check get_user() return when reading princhashlen

Doruk Tan Ozturk (2):
      mac802154: llsec: add skb_cow_data() before in-place crypto
      tipc: fix slab-use-after-free Read in tipc_aead_decrypt_done

Eric Dumazet (2):
      ip6_vti: set netns_immutable on the fallback device.
      net: annotate data-races around sk->sk_{data_ready,write_space}

Fan Wu (1):
      hdlc_ppp: sync per-proto timers before freeing hdlc state

Florian Westphal (2):
      netfilter: nf_tables: always increment set element count
      netfilter: nf_tables: always walk all pending catchall elements

Gil Portnoy (1):
      ksmbd: reject non-VALID session in compound request branch

Giovanni Cabiddu (1):
      crypto: qat - remove unused character device and IOCTLs

Greg Kroah-Hartman (1):
      Linux 6.1.177

Guannan Wang (1):
      NFSD: Fix SECINFO_NO_NAME decode error cleanup

Hangbin Liu (1):
      selftests/bpf: move SYS() macro into the test_progs.h

Harry Wentland (1):
      drm/amd/display: Bound VBIOS record-chain walk loops

Helen Koike (1):
      debugobjects: Do not fill_pool() if pi_blocked_on

Hem Parekh (1):
      ksmbd: fix out-of-bounds read in smb_check_perm_dacl()

Herbert Xu (1):
      crypto: qat - Return pointer directly in adf_ctl_alloc_resources

Ian Bridges (1):
      fbdev: Fix fb_new_modelist to prevent null-ptr-deref in fb_videomode_to_var

Ian Rogers (2):
      perf bench: Avoid NDEBUG warning
      perf block-range: Move debug code behind ifndef NDEBUG

Ihor Solodrai (1):
      selftests/bpf: Check for timeout in perf_link test

Jann Horn (1):
      fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios

Jarkko Sakkinen (1):
      KEYS: fix overflow in keyctl_pkey_params_get_2()

Jeff Layton (1):
      nfsd: fix posix_acl leak on SETACL decode failure

Jiexun Wang (1):
      af_unix: Reject SIOCATMARK on non-stream sockets

Jiri Olsa (1):
      selftests/bpf: Move get_time_ns to testing_helpers.h

Joanne Koong (1):
      fuse: re-lock request before replacing page cache folio

Jose Ignacio Tornos Martinez (1):
      wifi: ath11k: fix warning when unbinding

Koichiro Den (1):
      NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD and CONFIG share BAR

Konstantin Komarov (1):
      ntfs3: reject direct userspace writes to reserved $LX* xattrs

Kuniyuki Iwashima (2):
      phonet: Pass ifindex to fill_addr().
      phonet: Pass net and ifindex to phonet_address_notify().

Lord Ulf Henrik Holmberg (1):
      RDMA/bnxt_re: zero shared page before exposing to userspace

Maciej W. Rozycki (1):
      MIPS: DEC: Prevent initial console buffer from landing in XKPHYS

Maíra Canal (2):
      drm/v3d: Store the active job inside the queue's state
      drm/v3d: Skip CSD when it has zeroed workgroups

Michael Bommarito (2):
      exfat: fix potential use-after-free in exfat_find_dir_entry()
      NFSv4/pNFS: reject zero-length r_addr in nfs4_decode_mp_ds_addr

Miklos Szeredi (1):
      virtiofs: fix UAF on submount umount

Mingyu Wang (1):
      agp/amd64: Fix broken error propagation in agp_amd64_probe()

Mukesh Ojha (1):
      misc: fastrpc: Fix NULL pointer dereference in rpmsg callback

Pablo Neira Ayuso (2):
      netfilter: nf_tables: fix set size with rbtree backend
      netfilter: nf_tables: unconditionally bump set->nelems before insertion

Paolo Abeni (1):
      mptcp: fix missing wakeups in edge scenarios

Paolo Bonzini (1):
      KVM: x86: Fix shadow paging use-after-free due to unexpected role

Pedro Tammela (3):
      net/sched: act_pedit: check static offsets a priori
      net/sched: act_pedit: rate limit datapath messages
      net/sched: act_pedit: free pedit keys on bail from offset check

Peter Zijlstra (1):
      debugobjects,locking: Annotate debug_object_fill_pool() wait type violation

Petr Machata (1):
      Revert "ptp: add testptp mask test"

Qingshuang Fu (1):
      irqchip/imgpdc: Fix resource leak, add missing chained handler cleanup on remove

Rajat Gupta (1):
      net/sched: fix pedit partial COW leading to page cache corruption

Ruslan Valiyev (2):
      media: vidtv: fix NULL pointer dereference in vidtv_mux_push_si
      apparmor: fix use-after-free in rawdata dedup loop

Russell King (Oracle) (4):
      ARM: group is_permission_fault() with is_translation_fault()
      ARM: allow __do_kernel_fault() to report execution of memory faults
      ARM: fix hash_name() fault
      ARM: fix branch predictor hardening

Santosh Kalluri (1):
      net: phonet: free phonet_device after RCU grace period

Sean Christopherson (5):
      KVM: VMX: Make vmread_error_trampoline() uncallable from C code
      KVM: nVMX: Add a helper to get highest pending from Posted Interrupt vector
      KVM: nVMX: Check for pending posted interrupts when looking for nested events
      KVM: nVMX: Fold requested virtual interrupt check into has_nested_events()
      KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level

Sebastian Andrzej Siewior (2):
      debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING
      debugobjects: Use LD_WAIT_CONFIG instead of LD_WAIT_SLEEP

Shaomin Chen (1):
      keys: Pin request_key_auth payload in instantiate paths

Steffen Persvold (1):
      fbdev: modedb: Fix misaligned fields in the 1920x1080-60 mode

Stepan Ionichev (1):
      serial: 8250_dw: unregister 8250 port if clk_notifier_register() fails

Sunmin Jeong (1):
      f2fs: fix to round down start offset of fallocate for pin file

Sven Eckelmann (26):
      batman-adv: tt: prevent TVLV entry number overflow
      batman-adv: tp_meter: keep unacked list in ascending ordered
      batman-adv: tp_meter: initialize dup_acks explicitly
      batman-adv: tp_meter: initialize dec_cwnd explicitly
      batman-adv: tp_meter: avoid window underflow
      batman-adv: tp_meter: avoid divide-by-zero for dec_cwnd
      batman-adv: tp_meter: fix fast recovery precondition
      batman-adv: tp_meter: handle seqno wrap-around for fast recovery detection
      batman-adv: tp_meter: add only finished tp_vars to lists
      batman-adv: bla: annotate lasttime access with READ/WRITE_ONCE
      batman-adv: prevent ELP transmission interval underflow
      batman-adv: tp_meter: initialize last_recv_time during init
      batman-adv: ensure bcast is writable before modifying TTL
      batman-adv: fix (m|b)cast csum after decrementing TTL
      batman-adv: frag: ensure fragment is writable before modifying TTL
      batman-adv: frag: avoid underflow of TTL
      batman-adv: v: prevent OGM aggregation on disabled hardif
      batman-adv: tp_meter: restrict number of unacked list entries
      batman-adv: tp_meter: annotate last_recv_time access with READ/WRITE_ONCE
      batman-adv: tp_meter: prevent parallel modifications of last_recv
      batman-adv: tp_meter: handle overlapping packets
      batman-adv: tt: don't merge change entries with different VIDs
      batman-adv: tt: track roam count per VID
      batman-adv: dat: prevent false sharing between VLANs
      batman-adv: tvlv: enforce 2-byte alignment
      batman-adv: tvlv: avoid race of cifsnotfound handler state

Tao Cui (1):
      mptcp: pm: fix extra_subflows underflow on userspace PM subflow creation

Thadeu Lima de Souza Cascardo (1):
      dlm: prevent NPD when writing a positive value to event_done

Thorsten Blum (2):
      hv: utils: handle and propagate errors in kvp_register
      crypto: qat - Replace kzalloc() + copy_from_user() with memdup_user()

Waiman Long (1):
      debugobjects: Dont call fill_pool() in early boot hardirq context

Weiming Shi (2):
      i2c: stub: Reject I2C block transfers with invalid length
      net: qualcomm: rmnet: fix endpoint use-after-free in rmnet_dellink()

Wenjie Qi (1):
      f2fs: validate compress cache inode only when enabled

Wentao Liang (3):
      pNFS: Fix use-after-free in pnfs_update_layout()
      fpga: region: fix use-after-free in child_regions_with_firmware()
      power: reset: linkstation-poweroff: fix use-after-free in the linkstation_poweroff_init()

Wongi Lee (1):
      ipv6: account for fraggap on the paged allocation path

Yi Yang (1):
      vc_screen: fix null-ptr-deref in vcs_notifier() during concurrent vcs_write

Yiming Qian (1):
      net: skmsg: preserve sg.copy across SG transforms

Yizhou Zhao (1):
      9p: avoid putting oldfid in p9_client_walk() error path

Yu Zhao (1):
      mm/mglru: skip special VMAs in lru_gen_look_around()

Yuto Ohnuki (1):
      ext4: add bounds check for inline data length in ext4_read_inline_page

Zenm Chen (1):
      wifi: mt76: mt76x2u: Add support for ELECOM WDC-867SU3S

Zhang Cen (2):
      f2fs: validate ACL entry sizes in f2fs_acl_from_disk()
      ocfs2: reject oversized group bitmap descriptors

