Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE683A5E93;
	Sat,  4 Jul 2026 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783166368; cv=none; b=Ny2G8G9DHYqz1XRmgcK5FUUt/Ci1jGsnNoZanXSO9hpBasx4Dcvq2dDrC7borlB1Y5PmwmsWcAmNfgy1hI8zTI5s6gX1reJk0wVuhIWuJse9BdD4uuYlB2B47yTp/9eCGlKcPVcUTJ0u9rzVlY8MYs3qryfHO9EoS+FJuSHSz+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783166368; c=relaxed/simple;
	bh=P6w04/LKulIY5PlA4VcbKySNL/arSLYkeoJZHpdq070=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T2009Fy18s+aPOZYHZx2GhmuNCXgWSv1Zg7hNOiTQzcs68HUtT+pYJ/1UHg/ueiO2x1nB64cN37+O/wF2xWP9iXBHuc7q0OlEW2IeEg4u6Xy/rNlSZhvuw6wOpxXHd00O4A8ScIRKdMJKNPxTmsslmx5l2EQutjgRuJXXHWFJbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SXSow2L5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SXSow2L5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3E11F00A3F;
	Sat,  4 Jul 2026 11:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783166365;
	bh=jieYc+Qh1Xipf4bthIOnpOMt7yuWRMO7rpZSt8EbU+I=;
	h=From:To:Cc:Subject:Date;
	b=SXSow2L5f+MiuUMk7cWvUQTWdICEt6BPvglbedlx5cPFF93h5PYAYhfdZEmbRWE8a
	 HGawpP8wEo8sAIWCubXRXP5LcndRKIOIduEUYB9QI5ROwZRzlcVlBrA7T6Z355udxH
	 7Ep0XScZw7/GKNkrxIv+7gyIYT1Jd4q4nulr+fzQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.1.3
Date: Sat,  4 Jul 2026 13:59:22 +0200
Message-ID: <2026070423-yearbook-stool-79fd@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.1.3 kernel.

All users of the 7.1 kernel series must upgrade.

The updated 7.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                |   29 ++-
 arch/arm64/kvm/mmu.c                                    |    5 
 arch/loongarch/kernel/smp.c                             |    1 
 arch/mips/dec/prom/console.c                            |    7 
 arch/mips/kernel/smp.c                                  |    2 
 arch/riscv/include/asm/cacheflush.h                     |   25 +--
 arch/riscv/include/asm/kfence.h                         |    7 
 arch/riscv/kernel/entry.S                               |    6 
 arch/x86/kvm/hyperv.c                                   |    5 
 arch/x86/kvm/mmu/mmu.c                                  |   28 ++-
 arch/x86/kvm/svm/sev.c                                  |    1 
 block/bdev.c                                            |    5 
 block/blk-cgroup.c                                      |   21 +-
 drivers/crypto/intel/qat/qat_common/adf_accel_devices.h |    5 
 drivers/crypto/nx/nx.c                                  |    6 
 drivers/crypto/nx/nx.h                                  |    2 
 drivers/dma/idxd/registers.h                            |    3 
 drivers/fpga/of-fpga-region.c                           |    3 
 drivers/i2c/i2c-core-base.c                             |    8 -
 drivers/irqchip/irq-imgpdc.c                            |    6 
 drivers/net/wan/hdlc_ppp.c                              |   15 +-
 drivers/net/wireless/ath/ath11k/dp.c                    |    1 
 drivers/net/wireless/intel/iwlwifi/mld/agg.c            |    9 +
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c            |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c            |    2 
 drivers/net/wireless/mediatek/mt76/mac80211.c           |   15 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c         |    1 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c        |    3 
 drivers/net/wireless/realtek/rtl8xxxu/8188e.c           |    1 
 drivers/net/wireless/realtek/rtl8xxxu/8188f.c           |    1 
 drivers/net/wireless/realtek/rtl8xxxu/8192c.c           |    1 
 drivers/net/wireless/realtek/rtl8xxxu/8192e.c           |    1 
 drivers/net/wireless/realtek/rtl8xxxu/8192f.c           |    1 
 drivers/net/wireless/realtek/rtl8xxxu/8710b.c           |    1 
 drivers/net/wireless/realtek/rtl8xxxu/8723a.c           |    1 
 drivers/net/wireless/realtek/rtl8xxxu/8723b.c           |    1 
 drivers/net/wireless/realtek/rtl8xxxu/core.c            |   64 ++++++++
 drivers/net/wireless/realtek/rtl8xxxu/regs.h            |    2 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h        |    7 
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h    |    2 
 drivers/net/wireless/realtek/rtw88/tx.c                 |    7 
 drivers/net/wireless/realtek/rtw88/usb.c                |   13 +
 drivers/ntb/hw/epf/ntb_hw_epf.c                         |    3 
 drivers/pci/p2pdma.c                                    |   10 +
 drivers/power/reset/linkstation-poweroff.c              |    2 
 drivers/power/sequencing/core.c                         |   14 +
 drivers/rpmsg/rpmsg_char.c                              |   15 +-
 drivers/video/fbdev/core/fbcon.c                        |    7 
 drivers/video/fbdev/core/fbmem.c                        |   12 +
 drivers/video/fbdev/core/fbsysfs.c                      |   10 +
 drivers/video/fbdev/core/modedb.c                       |    5 
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c          |    9 +
 fs/crypto/fscrypt_private.h                             |   52 ++++---
 fs/crypto/inline_crypt.c                                |    8 -
 fs/crypto/keyring.c                                     |   23 +--
 fs/crypto/keysetup.c                                    |  118 ++++++++++------
 fs/exfat/dir.c                                          |    4 
 fs/f2fs/acl.c                                           |   18 ++
 fs/f2fs/checkpoint.c                                    |   14 +
 fs/f2fs/data.c                                          |   49 ++++--
 fs/f2fs/extent_cache.c                                  |   19 --
 fs/f2fs/f2fs.h                                          |    1 
 fs/f2fs/file.c                                          |   11 +
 fs/f2fs/gc.c                                            |   56 +++++--
 fs/f2fs/inode.c                                         |   26 ++-
 fs/f2fs/node.c                                          |    8 -
 fs/gfs2/super.c                                         |    1 
 fs/nfs/client.c                                         |    1 
 fs/nfs/flexfilelayout/flexfilelayout.c                  |    4 
 fs/nfs/nfs4proc.c                                       |    5 
 fs/nfs/pnfs.c                                           |    2 
 fs/nfs/pnfs_nfs.c                                       |    4 
 fs/nfsd/nfs2acl.c                                       |   17 +-
 fs/nfsd/nfs3acl.c                                       |   17 +-
 fs/nfsd/nfs4layouts.c                                   |   12 -
 fs/nfsd/nfs4proc.c                                      |   19 +-
 fs/nfsd/nfs4recover.c                                   |    3 
 fs/nfsd/nfs4state.c                                     |    1 
 fs/nfsd/nfs4xdr.c                                       |    3 
 fs/nfsd/vfs.c                                           |    6 
 fs/ntfs/file.c                                          |   17 +-
 fs/ntfs/super.c                                         |   19 +-
 fs/ntfs/volume.h                                        |    2 
 fs/ntfs3/xattr.c                                        |   12 +
 fs/ocfs2/suballoc.c                                     |   22 ++
 fs/smb/server/smbacl.c                                  |    4 
 fs/userfaultfd.c                                        |    2 
 include/keys/request_key_auth-type.h                    |    2 
 include/linux/blkdev.h                                  |   16 --
 include/linux/err.h                                     |   12 -
 include/linux/f2fs_fs.h                                 |    1 
 include/linux/kvm_host.h                                |    7 
 include/linux/mm.h                                      |   39 +++++
 include/linux/pci_ids.h                                 |    8 +
 include/linux/skmsg.h                                   |   15 +-
 include/linux/userfaultfd_k.h                           |    4 
 include/net/rtnetlink.h                                 |    2 
 kernel/bpf/cgroup.c                                     |    2 
 kernel/fork.c                                           |    1 
 kernel/sched/core.c                                     |   27 ++-
 net/9p/client.c                                         |    3 
 net/batman-adv/bat_iv_ogm.c                             |   11 +
 net/batman-adv/bat_v.c                                  |    1 
 net/batman-adv/bat_v_ogm.c                              |   23 ++-
 net/batman-adv/bridge_loop_avoidance.c                  |   28 +--
 net/batman-adv/distributed-arp-table.c                  |   12 +
 net/batman-adv/fragmentation.c                          |   22 ++
 net/batman-adv/fragmentation.h                          |    3 
 net/batman-adv/hard-interface.c                         |   28 ---
 net/batman-adv/netlink.c                                |    8 -
 net/batman-adv/routing.c                                |   73 +++++++++
 net/batman-adv/tp_meter.c                               |  113 ++++++++++-----
 net/batman-adv/translation-table.c                      |   12 +
 net/batman-adv/tvlv.c                                   |   69 ++++++++-
 net/batman-adv/types.h                                  |   21 +-
 net/core/filter.c                                       |   27 +++
 net/core/rtnetlink.c                                    |    8 +
 net/core/skmsg.c                                        |    2 
 net/ipv4/ip_gre.c                                       |    6 
 net/ipv4/ip_output.c                                    |    7 
 net/ipv4/tcp_ao.c                                       |    4 
 net/ipv6/ip6_output.c                                   |    9 -
 net/mac802154/llsec.c                                   |   14 +
 net/tipc/crypto.c                                       |    9 +
 net/tls/tls_sw.c                                        |    4 
 security/apparmor/include/policy_unpack.h               |   19 ++
 security/apparmor/lsm.c                                 |   16 ++
 security/apparmor/net.c                                 |    2 
 security/apparmor/policy.c                              |    8 -
 security/keys/internal.h                                |    2 
 security/keys/keyctl.c                                  |   24 ++-
 security/keys/keyctl_pkey.c                             |    9 +
 security/keys/request_key_auth.c                        |   33 ++++
 virt/kvm/eventfd.c                                      |   12 -
 134 files changed, 1323 insertions(+), 448 deletions(-)

Ard Biesheuvel (1):
      KVM: arm64: Omit tag sync on stage-2 mappings of the zero page

Arnd Bergmann (1):
      err.h: use __always_inline on all error pointer helpers

Ashutosh Desai (1):
      KVM: SVM: Fix page overflow in sev_dbg_crypt() for ENCRYPT path

Bitterblue Smith (2):
      wifi: rtl8xxxu: Detect the maximum supported channel width
      wifi: rtlwifi: rtl8821ae: Fix C2H bit location in RX descriptor

Bryam Vargas (2):
      apparmor: mediate the implicit connect of TCP fast open sendmsg
      f2fs: bound i_inline_xattr_size for non-inline-xattr inodes

Chao Yu (2):
      f2fs: fix to do sanity check on f2fs_get_node_folio_ra()
      f2fs: atomic: fix UAF issue on f2fs_inode_info.atomic_inode

Chris Mason (1):
      nfsd: release layout stid on setlease failure

Dawei Feng (1):
      bpf: use kvfree() for replaced sysctl write buffer

Denis Arefev (1):
      block: Avoid mounting the bdev pseudo-filesystem in userspace

Dominik Woźniak (1):
      nfsd: check get_user() return when reading princhashlen

Doruk Tan Ozturk (2):
      mac802154: llsec: add skb_cow_data() before in-place crypto
      tipc: fix slab-use-after-free Read in tipc_aead_decrypt_done

ElXreno (1):
      wifi: mt76: mt7925: don't disable AP BSS when removing TDLS peer

Eric Biggers (1):
      fscrypt: Fix key setup in edge case with multiple data unit sizes

Fan Wu (1):
      hdlc_ppp: sync per-proto timers before freeing hdlc state

Greg Kroah-Hartman (1):
      Linux 7.1.3

Guannan Wang (1):
      NFSD: Fix SECINFO_NO_NAME decode error cleanup

HanQuan (1):
      net/tcp-ao: fix use-after-free of key in del_async path

Hem Parekh (1):
      ksmbd: fix out-of-bounds read in smb_check_perm_dacl()

Hongling Zeng (1):
      fbdev: omap2: fix use-after-free in omapfb_mmap

Huacai Chen (1):
      LoongArch: Report dying CPU to RCU in stop_this_cpu()

Hyunchul Lee (1):
      ntfs: serialize volume label accesses

Hyunwoo Kim (1):
      KVM: x86: hyper-v: Bound the bank index when querying sparse banks

Ian Bridges (2):
      fbdev: fix use-after-free in store_modes()
      fbdev: Fix fb_new_modelist to prevent null-ptr-deref in fb_videomode_to_var

Igor Raits (1):
      NFSv4: clear exception state on successful mkdir retry

Jarkko Sakkinen (1):
      KEYS: fix overflow in keyctl_pkey_params_get_2()

Jeff Layton (6):
      nfsd: fix posix_acl leak on SETACL decode failure
      nfsd: fix inverted cp_ttl check in async copy reaper
      nfsd: fix posix_acl leak and ignored error in nfsd4_create_file
      nfsd: fix dead ACL conflict guard in nfsd4_create
      nfsd: avoid leaking pre-allocated openowner on unconfirmed retry race
      nfsd: reset write verifier on deferred writeback errors

Jiajia Liu (1):
      wifi: mt76: add wcid publish check in mt76_sta_add

Johan Hovold (1):
      i2c: core: fix adapter registration race

John Johansen (1):
      apparmor: advertise the tcp fast open fix is applied

Jonas Jelonek (1):
      MIPS: smp: report dying CPU to RCU in stop_this_cpu()

Jose Ignacio Tornos Martinez (1):
      wifi: ath11k: fix warning when unbinding

Junjie Cao (2):
      wifi: iwlwifi: mvm: fix race condition in PTP removal
      wifi: iwlwifi: mld: fix race condition in PTP removal

Junrui Luo (1):
      wifi: iwlwifi: mld: validate sta_mask before ffs() in BA session handlers

Kiryl Shutsemau (Meta) (1):
      userfaultfd: build __VMA_UFFD_FLAGS from config-gated masks

Koichiro Den (1):
      NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD and CONFIG share BAR

Konstantin Khorenko (1):
      gcov: use atomic counter updates to fix concurrent access crashes

Konstantin Komarov (1):
      ntfs3: reject direct userspace writes to reserved $LX* xattrs

Luka Gejak (2):
      wifi: rtw88: increase TX report timeout to fix race condition
      wifi: rtw88: usb: fix memory leaks on USB write failures

Lukas Wunner (1):
      PCI/P2PDMA: Add Intel QAT, DSA, IAA devices to whitelist

Maciej W. Rozycki (1):
      MIPS: DEC: Prevent initial console buffer from landing in XKPHYS

Maoyi Xie (1):
      net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink

Markus Elfring (1):
      NFS: Prevent resource leak in nfs_alloc_server()

Michael Bommarito (3):
      exfat: fix potential use-after-free in exfat_find_dir_entry()
      NFSv4/flexfiles: reject zero filehandle version count
      NFSv4/pNFS: reject zero-length r_addr in nfs4_decode_mp_ds_addr

Michal Koutný (1):
      blk-cgroup: fix UAF in __blkcg_rstat_flush()

Mike Rapoport (Microsoft) (1):
      userfaultfd: ensure mremap_userfaultfd_fail() releases mmap_changing

Mikhail Lobanov (1):
      f2fs: read COW data with the original inode during atomic write

Mingyu Wang (1):
      fbdev: fbcon: fix out-of-bounds read in err_out of fbcon_do_set_font()

Paolo Bonzini (1):
      KVM: x86: Fix shadow paging use-after-free due to unexpected role

Qingshuang Fu (1):
      irqchip/imgpdc: Fix resource leak, add missing chained handler cleanup on remove

Rik van Riel (1):
      sched/mmcid: Fix OOB clear_bit when CID is MM_CID_UNSET in fixup path

Ruslan Valiyev (1):
      apparmor: fix use-after-free in rawdata dedup loop

Sam James (1):
      crypto: nx - fix nx_crypto_ctx_exit argument

Sean Christopherson (2):
      KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level
      KVM: Replace guest-triggerable BUG_ON() in ioeventfd datamatch with get_unaligned()

Shaomin Chen (1):
      keys: Pin request_key_auth payload in instantiate paths

Steffen Persvold (1):
      fbdev: modedb: Fix misaligned fields in the 1920x1080-60 mode

Sunmin Jeong (1):
      f2fs: fix to round down start offset of fallocate for pin file

Sven Eckelmann (26):
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
      batman-adv: gw: don't deselect gateway with active hardif
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

Tristan Madani (1):
      gfs2: fix use-after-free in gfs2_qd_dealloc

Tuo Li (1):
      fbdev: modedb: fix a possible UAF in fb_find_mode()

Usama Arif (2):
      kernel/fork: clear PF_BLOCK_TS in copy_process()
      block: invalidate cached plug timestamp after task switch

Vivian Wang (2):
      riscv: mm: Extract helper mark_new_valid_map()
      riscv: kfence: Call mark_new_valid_map() for kfence_unprotect()

Wenjie Qi (6):
      f2fs: fix missing read bio submission on large folio error
      f2fs: pass correct iostat type for single node writes
      f2fs: reject setattr size changes on large folio files
      f2fs: validate orphan inode entry count
      f2fs: validate compress cache inode only when enabled
      f2fs: keep atomic write retry from zeroing original data

Wentao Liang (4):
      pwrseq: core: fix use-after-free in pwrseq_debugfs_seq_next()
      pNFS: Fix use-after-free in pnfs_update_layout()
      fpga: region: fix use-after-free in child_regions_with_firmware()
      power: reset: linkstation-poweroff: fix use-after-free in the linkstation_poweroff_init()

Wongi Lee (2):
      ipv6: account for fraggap on the paged allocation path
      ipv4: account for fraggap on the paged allocation path

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

Zhaoyang Huang (1):
      Revert "f2fs: remove non-uptodate folio from the page cache in move_data_block"

