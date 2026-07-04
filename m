Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85A416F27F;
	Sat,  4 Jul 2026 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783166318; cv=none; b=cni1pChyRXN8mKV5G6nfx42E3axGf1CUuo3j/Xqo7PzAoe5q8b02FWGHdimFLjsqmkqOXH3UasgQJuQh/G5kLeo7QYfAJmNM+pM/HakSrVvanA1jjuaH94wlfyCf+DzxsOf/oyy7Bd7IHWubDW3EO5Gxl9+x3H57ilz3gZ0c7Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783166318; c=relaxed/simple;
	bh=sitz6U+UJAywgWtiO0IIhN1cuegXN+uk/u+Di6qf/wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hBkj1DWSBHmTiTj4FWi5zq14jif4ORwK9voU8P9v7h1+hu5GBXFcHY6T2mAvapxPVHEyELR5Q8sh7nJNVTeDQ9PWKlT+UXKnFpE25X+Xd9elZaoCU818Cb0vAwCq5KRpTT1wb3gIgyge8nkZ30dMHx/VUPDlNN0GsiOEWvzL1rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yd5JdMed; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yd5JdMed"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E259C1F000E9;
	Sat,  4 Jul 2026 11:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783166316;
	bh=QiEJzTHHZKNmrk/cNcHyrQgFNuXm5xSDg3NuB4nU8Zg=;
	h=From:To:Cc:Subject:Date;
	b=yd5JdMedlkDEVl4dj0zfKPbHtppqVxJxRcy7HsL3ARhi7MGJmI+vps5UwU6rDUlvT
	 9jGTDiwtVu7V2SwRLjlHtSKdm4IXQRzTOlpF/0yvwGTHunl/OOuIRZ63LTtKBHCbS0
	 NDbjX+6u1GfxMaBPcRtZNpmdqeIpGys7lz2Mv5DY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.211
Date: Sat,  4 Jul 2026 13:58:44 +0200
Message-ID: <2026070445-passage-bulb-de51@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.211 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/userspace-api/ioctl/ioctl-number.rst                            |  447 ++++------
 Makefile                                                                      |    2 
 arch/mips/dec/prom/console.c                                                  |    7 
 arch/x86/kvm/mmu/mmu.c                                                        |   19 
 arch/x86/kvm/svm/sev.c                                                        |    1 
 crypto/af_alg.c                                                               |    2 
 drivers/char/agp/amd64-agp.c                                                  |    2 
 drivers/crypto/qat/qat_common/adf_cfg_common.h                                |   32 
 drivers/crypto/qat/qat_common/adf_cfg_user.h                                  |   38 
 drivers/crypto/qat/qat_common/adf_common_drv.h                                |    3 
 drivers/crypto/qat/qat_common/adf_ctl_drv.c                                   |  421 ---------
 drivers/crypto/qat/qat_common/adf_dev_mgr.c                                   |   70 -
 drivers/fpga/of-fpga-region.c                                                 |    3 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c                             |   15 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c                            |   15 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h                      |    5 
 drivers/gpu/drm/v3d/v3d_drv.h                                                 |    8 
 drivers/gpu/drm/v3d/v3d_gem.c                                                 |    5 
 drivers/gpu/drm/v3d/v3d_irq.c                                                 |   24 
 drivers/gpu/drm/v3d/v3d_sched.c                                               |   36 
 drivers/hv/hv_kvp.c                                                           |   25 
 drivers/hv/vmbus_drv.c                                                        |   56 -
 drivers/i2c/i2c-stub.c                                                        |    5 
 drivers/iio/light/bh1780.c                                                    |    4 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                      |    2 
 drivers/irqchip/irq-imgpdc.c                                                  |    6 
 drivers/media/test-drivers/vidtv/vidtv_mux.c                                  |    8 
 drivers/misc/fastrpc.c                                                        |    7 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c                            |    8 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h                            |    1 
 drivers/net/wan/hdlc_ppp.c                                                    |   15 
 drivers/net/wireless/ath/ath11k/dp.c                                          |    1 
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c                               |    1 
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h                          |    2 
 drivers/power/reset/linkstation-poweroff.c                                    |    2 
 drivers/regulator/core.c                                                      |   10 
 drivers/tty/vt/vc_screen.c                                                    |    2 
 drivers/usb/host/xhci-mem.c                                                   |    2 
 drivers/vfio/vfio_iommu_type1.c                                               |    2 
 drivers/video/fbdev/core/fbmem.c                                              |   12 
 drivers/video/fbdev/core/modedb.c                                             |    2 
 fs/dlm/lockspace.c                                                            |    2 
 fs/exfat/dir.c                                                                |    4 
 fs/ext4/inline.c                                                              |    8 
 fs/f2fs/acl.c                                                                 |   18 
 fs/fuse/dev.c                                                                 |   23 
 fs/fuse/file.c                                                                |    8 
 fs/ksmbd/smb2pdu.c                                                            |    5 
 fs/nfs/pnfs.c                                                                 |    2 
 fs/nfs/pnfs_nfs.c                                                             |    4 
 fs/nfsd/nfs2acl.c                                                             |   17 
 fs/nfsd/nfs3acl.c                                                             |   17 
 fs/nfsd/nfs4recover.c                                                         |    3 
 fs/nfsd/nfs4xdr.c                                                             |    3 
 fs/ntfs3/xattr.c                                                              |   12 
 fs/ocfs2/suballoc.c                                                           |   22 
 include/keys/request_key_auth-type.h                                          |    2 
 include/linux/kvm_host.h                                                      |    7 
 include/linux/ring_buffer.h                                                   |    4 
 include/net/phonet/pn_dev.h                                                   |    2 
 include/net/tc_act/tc_pedit.h                                                 |    1 
 kernel/bpf/cgroup.c                                                           |    2 
 kernel/trace/ring_buffer.c                                                    |   72 -
 kernel/trace/trace.c                                                          |   14 
 kernel/trace/trace_kdb.c                                                      |    8 
 net/batman-adv/bat_iv_ogm.c                                                   |   11 
 net/batman-adv/bat_v.c                                                        |    1 
 net/batman-adv/bat_v_ogm.c                                                    |   23 
 net/batman-adv/bridge_loop_avoidance.c                                        |   28 
 net/batman-adv/distributed-arp-table.c                                        |   12 
 net/batman-adv/fragmentation.c                                                |   22 
 net/batman-adv/fragmentation.h                                                |    3 
 net/batman-adv/netlink.c                                                      |    8 
 net/batman-adv/routing.c                                                      |   64 +
 net/batman-adv/tp_meter.c                                                     |  113 +-
 net/batman-adv/translation-table.c                                            |   40 
 net/batman-adv/tvlv.c                                                         |   69 +
 net/batman-adv/types.h                                                        |   21 
 net/ipv6/ip6_vti.c                                                            |    1 
 net/mac802154/llsec.c                                                         |   14 
 net/mptcp/protocol.c                                                          |    4 
 net/phonet/pn_dev.c                                                           |   12 
 net/phonet/pn_netlink.c                                                       |   23 
 net/sched/act_pedit.c                                                         |  101 +-
 net/tipc/crypto.c                                                             |    9 
 net/unix/af_unix.c                                                            |    3 
 security/keys/internal.h                                                      |    2 
 security/keys/keyctl.c                                                        |   24 
 security/keys/keyctl_pkey.c                                                   |    9 
 security/keys/request_key_auth.c                                              |   33 
 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c |    2 
 tools/testing/selftests/ptp/testptp.c                                         |   79 -
 92 files changed, 1100 insertions(+), 1219 deletions(-)

Abel Vesa (1):
      misc: fastrpc: Add dma_mask to fastrpc_channel_ctx

André Draszik (1):
      regulator: core: fix locking in regulator_resolve_supply() error path

Antoniu Miclaus (1):
      iio: light: bh1780: fix PM runtime leak on error path

Ashutosh Desai (1):
      KVM: SVM: Fix page overflow in sev_dbg_crypt() for ENCRYPT path

Bagas Sanjaya (1):
      Documentation: ioctl-number: Extend "Include File" column width

Bitterblue Smith (1):
      wifi: rtlwifi: rtl8821ae: Fix C2H bit location in RX descriptor

Bjoern Doebel (1):
      ring-buffer: Remove ring_buffer_read_prepare_sync()

Dawei Feng (1):
      bpf: use kvfree() for replaced sysctl write buffer

Dexuan Cui (1):
      Drivers: hv: vmbus: Improve the logic of reserving fb_mmio on Gen2 VMs

Dominik Woźniak (1):
      nfsd: check get_user() return when reading princhashlen

Doruk Tan Ozturk (2):
      mac802154: llsec: add skb_cow_data() before in-place crypto
      tipc: fix slab-use-after-free Read in tipc_aead_decrypt_done

Eric Dumazet (1):
      ip6_vti: set netns_immutable on the fallback device.

Fan Wu (1):
      hdlc_ppp: sync per-proto timers before freeing hdlc state

Gil Portnoy (1):
      ksmbd: reject non-VALID session in compound request branch

Giovanni Cabiddu (1):
      crypto: qat - remove unused character device and IOCTLs

Greg Kroah-Hartman (1):
      Linux 5.15.211

Guannan Wang (1):
      NFSD: Fix SECINFO_NO_NAME decode error cleanup

Harry Wentland (1):
      drm/amd/display: Bound VBIOS record-chain walk loops

Herbert Xu (2):
      crypto: af_alg - Set merge to zero early in af_alg_sendmsg
      crypto: qat - Return pointer directly in adf_ctl_alloc_resources

Ian Bridges (1):
      fbdev: Fix fb_new_modelist to prevent null-ptr-deref in fb_videomode_to_var

Jann Horn (1):
      fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios

Jarkko Sakkinen (1):
      KEYS: fix overflow in keyctl_pkey_params_get_2()

Jeff Layton (1):
      nfsd: fix posix_acl leak on SETACL decode failure

Jiacheng Shi (1):
      vfio/iommu_type1: replace kfree with kvfree

Jiexun Wang (1):
      af_unix: Reject SIOCATMARK on non-stream sockets

Joanne Koong (1):
      fuse: re-lock request before replacing page cache folio

Jose Ignacio Tornos Martinez (1):
      wifi: ath11k: fix warning when unbinding

Konstantin Komarov (1):
      ntfs3: reject direct userspace writes to reserved $LX* xattrs

Kuniyuki Iwashima (2):
      phonet: Pass ifindex to fill_addr().
      phonet: Pass net and ifindex to phonet_address_notify().

Lord Ulf Henrik Holmberg (1):
      RDMA/bnxt_re: zero shared page before exposing to userspace

Maciej W. Rozycki (1):
      MIPS: DEC: Prevent initial console buffer from landing in XKPHYS

Mathias Nyman (1):
      xhci: fix memory leak regression when freeing xhci vdev devices depth first

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

Paolo Abeni (1):
      mptcp: fix missing wakeups in edge scenarios

Pedro Tammela (3):
      net/sched: act_pedit: check static offsets a priori
      net/sched: act_pedit: rate limit datapath messages
      net/sched: act_pedit: free pedit keys on bail from offset check

Petr Machata (2):
      Revert "selftest/ptp: update ptp selftest to exercise the gettimex options"
      Revert "ptp: add testptp mask test"

Qingshuang Fu (1):
      irqchip/imgpdc: Fix resource leak, add missing chained handler cleanup on remove

Rajat Gupta (1):
      net/sched: fix pedit partial COW leading to page cache corruption

Ruslan Valiyev (1):
      media: vidtv: fix NULL pointer dereference in vidtv_mux_push_si

Santosh Kalluri (1):
      net: phonet: free phonet_device after RCU grace period

Sean Christopherson (1):
      KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level

Shaomin Chen (1):
      keys: Pin request_key_auth payload in instantiate paths

Steffen Persvold (1):
      fbdev: modedb: Fix misaligned fields in the 1920x1080-60 mode

Sven Eckelmann (27):
      batman-adv: tt: reject oversized local TVLV buffers
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

Thadeu Lima de Souza Cascardo (1):
      dlm: prevent NPD when writing a positive value to event_done

Thorsten Blum (2):
      hv: utils: handle and propagate errors in kvp_register
      crypto: qat - Replace kzalloc() + copy_from_user() with memdup_user()

Weiming Shi (2):
      i2c: stub: Reject I2C block transfers with invalid length
      net: qualcomm: rmnet: fix endpoint use-after-free in rmnet_dellink()

Wentao Liang (3):
      pNFS: Fix use-after-free in pnfs_update_layout()
      fpga: region: fix use-after-free in child_regions_with_firmware()
      power: reset: linkstation-poweroff: fix use-after-free in the linkstation_poweroff_init()

Yi Yang (1):
      vc_screen: fix null-ptr-deref in vcs_notifier() during concurrent vcs_write

Yijia Wang (1):
      kselftest/arm64: signal: Skip SVE signal test if not enough VLs supported

Yuto Ohnuki (1):
      ext4: add bounds check for inline data length in ext4_read_inline_page

Zenm Chen (1):
      wifi: mt76: mt76x2u: Add support for ELECOM WDC-867SU3S

Zhang Cen (2):
      f2fs: validate ACL entry sizes in f2fs_acl_from_disk()
      ocfs2: reject oversized group bitmap descriptors

