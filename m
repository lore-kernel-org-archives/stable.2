Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C404B3A83B1;
	Sat,  4 Jul 2026 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783166354; cv=none; b=UOmpbcD1ikLrtrvSQVVb+twtwTy+kYEuOKhF+p7cXuRbFYvrsYPm9SYQOhocJNNnmy/9w0BipOvZ+YeANTOFs2pRzUTY9arK8+6scwOKo29E47xXjGxbX117/C5afyRYS0UHu5dsL6+pyBEcv1Cq48hN4numNuZWUCYGwFV3Ivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783166354; c=relaxed/simple;
	bh=bYBPB8AMqRp0llRUFBFhtfAVvz1FpOIhVYLnnj+/+r4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NwEoDA0DLeIApIK426n0Gp7l9g5ZGcz8twWLirjcrJRMz2l6Q0jmIovV1gq66UPQNxp4kt4ntWvYJZlH4HevA0QDr61InfTRZ6A7DIjiRhzajxVBAvNSqvQEKoxXlNuJinVJelO4llRiZPpjtoBZtSCy5ct1E2J4Hs6RSG9U6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UxHG0eBR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UxHG0eBR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFAE1F00A3D;
	Sat,  4 Jul 2026 11:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783166351;
	bh=E7aUoYgQqp376Jz9+b36Ankplf8ibs7yYnGPueLDM44=;
	h=From:To:Cc:Subject:Date;
	b=UxHG0eBRl3uyKETJl0w+NDUVH6LB+F4xaA9TrlVqIi89TKdDtQlBy2N1LbubWSTeJ
	 UFJI3ATLiMVBTWhr7kku0HTrPzKcRo66BXSByGLf5tIpMuZD70VpI5UV6c+mdTorCC
	 tnNwM+CRoG9HH2KWlxnwUpmoCBkRLmfVncYYiWRI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.144
Date: Sat,  4 Jul 2026 13:59:11 +0200
Message-ID: <2026070411-headpiece-marathon-458e@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.144 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/userspace-api/ioctl/ioctl-number.rst             |  463 ++--
 Makefile                                                       |    2 
 arch/arm/mm/alignment.c                                        |    4 
 arch/arm/mm/fault.c                                            |   94 
 arch/arm64/Kconfig                                             |    1 
 arch/mips/dec/prom/console.c                                   |    7 
 arch/x86/kvm/hyperv.c                                          |    5 
 arch/x86/kvm/mmu/mmu.c                                         |   28 
 arch/x86/kvm/svm/sev.c                                         |    1 
 arch/x86/kvm/vmx/vmx.c                                         |    4 
 arch/x86/kvm/x86.c                                             |    7 
 block/blk-cgroup.c                                             |   21 
 drivers/base/memory.c                                          |    3 
 drivers/bluetooth/btmtk.c                                      |   15 
 drivers/char/agp/amd64-agp.c                                   |    2 
 drivers/crypto/intel/qat/qat_common/adf_cfg_common.h           |   32 
 drivers/crypto/intel/qat/qat_common/adf_cfg_user.h             |   38 
 drivers/crypto/intel/qat/qat_common/adf_common_drv.h           |    3 
 drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c              |  413 ---
 drivers/crypto/intel/qat/qat_common/adf_dev_mgr.c              |   70 
 drivers/fpga/of-fpga-region.c                                  |    3 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c              |   15 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c             |   27 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h       |    5 
 drivers/gpu/drm/v3d/v3d_drv.h                                  |    8 
 drivers/gpu/drm/v3d/v3d_gem.c                                  |    5 
 drivers/gpu/drm/v3d/v3d_irq.c                                  |   24 
 drivers/gpu/drm/v3d/v3d_sched.c                                |   36 
 drivers/hv/hv_kvp.c                                            |   25 
 drivers/hv/vmbus_drv.c                                         |   29 
 drivers/i2c/i2c-stub.c                                         |    5 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                       |    2 
 drivers/irqchip/irq-imgpdc.c                                   |    6 
 drivers/media/test-drivers/vidtv/vidtv_mux.c                   |    8 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c             |    8 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h             |    1 
 drivers/net/wan/hdlc_ppp.c                                     |   15 
 drivers/net/wireless/ath/ath11k/dp.c                           |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c                   |    2 
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c                |    1 
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h           |    2 
 drivers/net/wireless/realtek/rtw88/tx.c                        |    7 
 drivers/net/wireless/realtek/rtw88/usb.c                       |   13 
 drivers/ntb/hw/epf/ntb_hw_epf.c                                |    3 
 drivers/nvme/target/tcp.c                                      |   29 
 drivers/power/reset/linkstation-poweroff.c                     |    2 
 drivers/regulator/core.c                                       |   10 
 drivers/rpmsg/rpmsg_char.c                                     |   15 
 drivers/slimbus/qcom-ngd-ctrl.c                                |   39 
 drivers/tty/serial/8250/8250_dw.c                              |    4 
 drivers/tty/serial/qcom_geni_serial.c                          |    9 
 drivers/tty/vt/vc_screen.c                                     |    2 
 drivers/video/fbdev/core/fbmem.c                               |   12 
 drivers/video/fbdev/core/fbsysfs.c                             |   10 
 drivers/video/fbdev/core/modedb.c                              |    5 
 fs/dlm/lockspace.c                                             |    2 
 fs/eventpoll.c                                                 |  142 -
 fs/exfat/dir.c                                                 |    4 
 fs/f2fs/acl.c                                                  |   18 
 fs/f2fs/data.c                                                 |   16 
 fs/f2fs/extent_cache.c                                         |   19 
 fs/f2fs/file.c                                                 |    9 
 fs/f2fs/inode.c                                                |    9 
 fs/file_table.c                                                |   46 
 fs/fuse/dev.c                                                  |   23 
 fs/fuse/file.c                                                 |    8 
 fs/gfs2/super.c                                                |    1 
 fs/internal.h                                                  |    3 
 fs/nfs/client.c                                                |    1 
 fs/nfs/pnfs.c                                                  |    2 
 fs/nfs/pnfs_nfs.c                                              |    4 
 fs/nfsd/nfs2acl.c                                              |   17 
 fs/nfsd/nfs3acl.c                                              |   17 
 fs/nfsd/nfs4recover.c                                          |    3 
 fs/nfsd/nfs4xdr.c                                              |    3 
 fs/ntfs3/xattr.c                                               |   12 
 fs/ocfs2/suballoc.c                                            |   22 
 fs/open.c                                                      |    7 
 fs/overlayfs/file.c                                            |    8 
 fs/smb/server/smb2pdu.c                                        |    5 
 fs/smb/server/smbacl.c                                         |    4 
 include/keys/request_key_auth-type.h                           |    2 
 include/linux/bpf_verifier.h                                   |    4 
 include/linux/err.h                                            |   12 
 include/linux/file.h                                           |    2 
 include/linux/fs.h                                             |   15 
 include/linux/kvm_host.h                                       |    7 
 include/linux/lsm_audit.h                                      |    2 
 include/linux/lsm_hook_defs.h                                  |    5 
 include/linux/lsm_hooks.h                                      |    1 
 include/linux/ring_buffer.h                                    |    4 
 include/linux/security.h                                       |   22 
 include/linux/skmsg.h                                          |   15 
 include/net/phonet/pn_dev.h                                    |    2 
 include/net/tc_act/tc_pedit.h                                  |    1 
 kernel/bpf/cgroup.c                                            |    2 
 kernel/bpf/verifier.c                                          |  364 ++-
 kernel/locking/rtmutex.c                                       |    3 
 kernel/locking/rtmutex_api.c                                   |    2 
 kernel/trace/bpf_trace.c                                       |    4 
 kernel/trace/ftrace.c                                          |   68 
 kernel/trace/ring_buffer.c                                     |   67 
 kernel/trace/trace.c                                           |   14 
 kernel/trace/trace_kdb.c                                       |    8 
 lib/debugobjects.c                                             |   56 
 net/9p/client.c                                                |    3 
 net/batman-adv/bat_iv_ogm.c                                    |   11 
 net/batman-adv/bat_v.c                                         |    1 
 net/batman-adv/bat_v_ogm.c                                     |   23 
 net/batman-adv/bridge_loop_avoidance.c                         |   28 
 net/batman-adv/distributed-arp-table.c                         |   12 
 net/batman-adv/fragmentation.c                                 |   22 
 net/batman-adv/fragmentation.h                                 |    3 
 net/batman-adv/netlink.c                                       |    8 
 net/batman-adv/routing.c                                       |   64 
 net/batman-adv/tp_meter.c                                      |  113 -
 net/batman-adv/translation-table.c                             |   32 
 net/batman-adv/tvlv.c                                          |   69 
 net/batman-adv/types.h                                         |   21 
 net/core/filter.c                                              |   27 
 net/core/skmsg.c                                               |    2 
 net/ipv4/ip_output.c                                           |   20 
 net/ipv6/ip6_output.c                                          |   22 
 net/ipv6/ip6_vti.c                                             |    1 
 net/mac802154/llsec.c                                          |   14 
 net/mptcp/pm_userspace.c                                       |   13 
 net/netfilter/nf_tables_api.c                                  |    2 
 net/phonet/pn_dev.c                                            |   12 
 net/phonet/pn_netlink.c                                        |   23 
 net/rxrpc/input.c                                              |   13 
 net/sched/act_pedit.c                                          |   77 
 net/tipc/crypto.c                                              |    9 
 net/tls/tls_sw.c                                               |    4 
 net/unix/af_unix.c                                             |    3 
 net/unix/garbage.c                                             |    2 
 scripts/link-vmlinux.sh                                        |    4 
 scripts/sorttable.c                                            | 1119 +++++++++-
 scripts/sorttable.h                                            |  500 ----
 security/apparmor/include/policy_unpack.h                      |   19 
 security/apparmor/lsm.c                                        |   16 
 security/apparmor/policy.c                                     |    8 
 security/keys/internal.h                                       |    2 
 security/keys/keyctl.c                                         |   24 
 security/keys/keyctl_pkey.c                                    |    9 
 security/keys/request_key_auth.c                               |   33 
 security/security.c                                            |  110 
 security/selinux/hooks.c                                       |  242 +-
 security/selinux/include/objsec.h                              |   11 
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c     |   34 
 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c     |   25 
 tools/testing/selftests/bpf/progs/verifier_scalar_ids.c        |  253 +-
 tools/testing/selftests/bpf/progs/verifier_spill_fill.c        |    4 
 tools/testing/selftests/bpf/progs/verifier_subprog_precision.c |    2 
 tools/testing/selftests/bpf/verifier/precise.c                 |    4 
 tools/testing/selftests/ptp/testptp.c                          |   19 
 155 files changed, 3589 insertions(+), 2191 deletions(-)

Amir Goldstein (1):
      fs: prepare for adding LSM blob to backing_file

André Draszik (1):
      regulator: core: fix locking in regulator_resolve_supply() error path

Arnd Bergmann (1):
      err.h: use __always_inline on all error pointer helpers

Ashutosh Desai (1):
      KVM: SVM: Fix page overflow in sev_dbg_crypt() for ENCRYPT path

Bagas Sanjaya (1):
      Documentation: ioctl-number: Extend "Include File" column width

Bitterblue Smith (1):
      wifi: rtlwifi: rtl8821ae: Fix C2H bit location in RX descriptor

Bjoern Doebel (1):
      ring-buffer: Remove ring_buffer_read_prepare_sync()

Bjorn Andersson (2):
      slimbus: qcom-ngd-ctrl: Fix up platform_driver registration
      slimbus: qcom-ngd-ctrl: Balance pm_runtime enablement for NGD

Bryam Vargas (1):
      apparmor: mediate the implicit connect of TCP fast open sendmsg

Chaitanya Kulkarni (1):
      nvmet-tcp: fix race between ICReq handling and queue teardown

Christian Brauner (8):
      file: add fput() cleanup helper
      eventpoll: use hlist_is_singular_node() in __ep_remove()
      eventpoll: split __ep_remove()
      eventpoll: kill __ep_remove()
      eventpoll: drop vestigial __ prefix from ep_remove_{file,epi}()
      eventpoll: rename ep_remove_safe() back to ep_remove()
      eventpoll: move epi_fget() up
      eventpoll: fix ep_remove struct eventpoll / struct file UAF

David Howells (1):
      rxrpc: Fix the ACK parser to extract the SACK table for parsing

Davidlohr Bueso (1):
      locking/rtmutex: Skip remove_waiter() when waiter is not enqueued

Dawei Feng (1):
      bpf: use kvfree() for replaced sysctl write buffer

Dexuan Cui (1):
      Drivers: hv: vmbus: Improve the logic of reserving fb_mmio on Gen2 VMs

Dominik Woźniak (1):
      nfsd: check get_user() return when reading princhashlen

Dongli Zhang (1):
      KVM: VMX: Update SVI during runtime APICv activation

Doruk Tan Ozturk (2):
      mac802154: llsec: add skb_cow_data() before in-place crypto
      tipc: fix slab-use-after-free Read in tipc_aead_decrypt_done

Eduard Zingerman (4):
      bpf: Track equal scalars history on per-instruction level
      bpf: Remove mark_precise_scalar_ids()
      selftests/bpf: Tests for per-insn sync_linked_regs() precision tracking
      selftests/bpf: Update comments find_equal_scalars->sync_linked_regs

Eric Dumazet (2):
      ip6_vti: set netns_immutable on the fallback device.
      inet: add indirect call wrapper for getfrag() calls

Fan Wu (1):
      hdlc_ppp: sync per-proto timers before freeing hdlc state

Florian Westphal (1):
      netfilter: nf_tables: always walk all pending catchall elements

Georgi Djakov (1):
      drivers/base/memory: set mem->altmap after successful device registration

Gil Portnoy (1):
      ksmbd: reject non-VALID session in compound request branch

Giovanni Cabiddu (1):
      crypto: qat - remove unused character device and IOCTLs

Greg Kroah-Hartman (1):
      Linux 6.6.144

Guannan Wang (1):
      NFSD: Fix SECINFO_NO_NAME decode error cleanup

Guenter Roeck (1):
      ftrace: Do not over-allocate ftrace memory

Harry Wentland (1):
      drm/amd/display: Bound VBIOS record-chain walk loops

Helen Koike (1):
      debugobjects: Do not fill_pool() if pi_blocked_on

Hem Parekh (1):
      ksmbd: fix out-of-bounds read in smb_check_perm_dacl()

Herbert Xu (1):
      crypto: qat - Return pointer directly in adf_ctl_alloc_resources

Hyunwoo Kim (1):
      KVM: x86: hyper-v: Bound the bank index when querying sparse banks

Ian Bridges (2):
      fbdev: fix use-after-free in store_modes()
      fbdev: Fix fb_new_modelist to prevent null-ptr-deref in fb_videomode_to_var

Jann Horn (1):
      fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios

Jarkko Sakkinen (1):
      KEYS: fix overflow in keyctl_pkey_params_get_2()

Jeff Layton (1):
      nfsd: fix posix_acl leak on SETACL decode failure

Jiexun Wang (1):
      af_unix: Reject SIOCATMARK on non-stream sockets

Joanne Koong (1):
      fuse: re-lock request before replacing page cache folio

Jose Ignacio Tornos Martinez (1):
      wifi: ath11k: fix warning when unbinding

Junjie Cao (1):
      wifi: iwlwifi: mvm: fix race condition in PTP removal

Koichiro Den (1):
      NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD and CONFIG share BAR

Konstantin Komarov (1):
      ntfs3: reject direct userspace writes to reserved $LX* xattrs

Kuniyuki Iwashima (3):
      phonet: Pass ifindex to fill_addr().
      phonet: Pass net and ifindex to phonet_address_notify().
      af_unix: Set gc_in_progress to true in unix_gc().

Lord Ulf Henrik Holmberg (1):
      RDMA/bnxt_re: zero shared page before exposing to userspace

Luka Gejak (2):
      wifi: rtw88: increase TX report timeout to fix race condition
      wifi: rtw88: usb: fix memory leaks on USB write failures

Maciej W. Rozycki (1):
      MIPS: DEC: Prevent initial console buffer from landing in XKPHYS

Markus Elfring (1):
      NFS: Prevent resource leak in nfs_alloc_server()

Maíra Canal (2):
      drm/v3d: Store the active job inside the queue's state
      drm/v3d: Skip CSD when it has zeroed workgroups

Michael Bommarito (2):
      exfat: fix potential use-after-free in exfat_find_dir_entry()
      NFSv4/pNFS: reject zero-length r_addr in nfs4_decode_mp_ds_addr

Michal Koutný (1):
      blk-cgroup: fix UAF in __blkcg_rstat_flush()

Miklos Szeredi (1):
      virtiofs: fix UAF on submount umount

Mingyu Wang (1):
      agp/amd64: Fix broken error propagation in agp_amd64_probe()

Paolo Bonzini (1):
      KVM: x86: Fix shadow paging use-after-free due to unexpected role

Paul Moore (2):
      lsm: add backing_file LSM hooks
      selinux: fix overlayfs mmap() and mprotect() access checks

Pauli Virtanen (1):
      Bluetooth: btmtk: accept too short WMT FUNC_CTRL events

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

Sean Christopherson (1):
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

Steven Rostedt (25):
      scripts/sorttable: Remove unused macro defines
      scripts/sorttable: Remove unused write functions
      scripts/sorttable: Remove unneeded Elf_Rel
      scripts/sorttable: Have the ORC code use the _r() functions to read
      scripts/sorttable: Make compare_extable() into two functions
      scripts/sorttable: Convert Elf_Ehdr to union
      scripts/sorttable: Replace Elf_Shdr Macro with a union
      scripts/sorttable: Convert Elf_Sym MACRO over to a union
      scripts/sorttable: Add helper functions for Elf_Ehdr
      scripts/sorttable: Add helper functions for Elf_Shdr
      scripts/sorttable: Add helper functions for Elf_Sym
      scripts/sorttable: Use uint64_t for mcount sorting
      scripts/sorttable: Move code from sorttable.h into sorttable.c
      scripts/sorttable: Get start/stop_mcount_loc from ELF file directly
      scripts/sorttable: Use a structure of function pointers for elf helpers
      arm64: scripts/sorttable: Implement sorting mcount_loc at boot for arm64
      scripts/sorttable: Have mcount rela sort use direct values
      scripts/sorttable: Always use an array for the mcount_loc sorting
      scripts/sorttable: Zero out weak functions in mcount_loc table
      ftrace: Update the mcount_loc check of skipped entries
      ftrace: Have ftrace pages output reflect freed pages
      ftrace: Test mcount_loc addr before calling ftrace_call_addr()
      ftrace: Check against is_kernel_text() instead of kaslr_offset()
      scripts/sorttable: Use normal sort if theres no relocs in the mcount section
      scripts/sorttable: Allow matches to functions before function entry

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

Tristan Madani (2):
      Bluetooth: btmtk: validate WMT event SKB length before struct access
      gfs2: fix use-after-free in gfs2_qd_dealloc

Tuo Li (1):
      fbdev: modedb: fix a possible UAF in fb_find_mode()

Varun R Mallya (2):
      bpf: Reject sleepable kprobe_multi programs at attach time
      selftests/bpf: Add test to ensure kprobe_multi is not sleepable

Vasily Gorbik (1):
      scripts/sorttable: Fix endianness handling in build-time mcount sort

Viken Dadhaniya (1):
      serial: qcom_geni: Fix RX DMA stall when SE_DMA_RX_LEN_IN is zero

Waiman Long (1):
      debugobjects: Dont call fill_pool() in early boot hardirq context

Weiming Shi (2):
      i2c: stub: Reject I2C block transfers with invalid length
      net: qualcomm: rmnet: fix endpoint use-after-free in rmnet_dellink()

Wenjie Qi (2):
      f2fs: validate compress cache inode only when enabled
      f2fs: keep atomic write retry from zeroing original data

Wentao Liang (3):
      pNFS: Fix use-after-free in pnfs_update_layout()
      fpga: region: fix use-after-free in child_regions_with_firmware()
      power: reset: linkstation-poweroff: fix use-after-free in the linkstation_poweroff_init()

Wongi Lee (2):
      ipv6: account for fraggap on the paged allocation path
      ipv4: account for fraggap on the paged allocation path

Yi Yang (1):
      vc_screen: fix null-ptr-deref in vcs_notifier() during concurrent vcs_write

Yiming Qian (1):
      net: skmsg: preserve sg.copy across SG transforms

Yizhou Zhao (1):
      9p: avoid putting oldfid in p9_client_walk() error path

Yongpeng Yang (1):
      f2fs: fix incorrect FI_NO_EXTENT handling in __destroy_extent_node()

Yuho Choi (1):
      rpmsg: char: Fix use-after-free on probe error path

Zenm Chen (1):
      wifi: mt76: mt76x2u: Add support for ELECOM WDC-867SU3S

Zhang Cen (2):
      f2fs: validate ACL entry sizes in f2fs_acl_from_disk()
      ocfs2: reject oversized group bitmap descriptors

