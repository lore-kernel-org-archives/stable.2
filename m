Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561453A59A3;
	Sat,  4 Jul 2026 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783166346; cv=none; b=CSgm1JlQpQwv4RLfp8AJmLloN1YrJ5vrBvKUX0GknpHYXLISJJ4tg5mvJJSBlETmSJFICtoFen8r93/uFMjh1zqJ/SozYomFCpyb6ssQ5gWbE1nyHK0wWcwR0vCW3tKIgZ07yvpnIKXyxePOzYj1eG27DmVhHt7W0MSNlwIxUKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783166346; c=relaxed/simple;
	bh=a4VULz7FgLxys5lxrUxg2XyIkBHMSnJsz8s2oAi/ZMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qpVYgJ5wf41rBGtOwbeSrekglLHxHp7Tg9XLYgipRu3jRN3AnvN0QFynswzKuPWI7saTMPynlMd9K6etAUNnr2+y/IoFe5UgGfr+a1snQFSBM/YPdKioT8BQ/l3lncVP7KscmwMZMDelGv/wDq9jETlE/7iR/RLIqMmAA4uHaxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IGdm0PS/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IGdm0PS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D431F00A3D;
	Sat,  4 Jul 2026 11:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783166343;
	bh=NphxLFfLe7XZ82grh9J/9tl1CR6zMdBhpn1G0QoEZ2g=;
	h=From:To:Cc:Subject:Date;
	b=IGdm0PS/ES7uVETiqQK81YeXFFrihz6kCANbIWt32CGvHCmAQYvDU6LqWZxGyYRsV
	 sLI2Z8P8cTzlTI+WM5s8p6Dg64OflPsOu6FGBh0toxekQaWRP9UiSYzRVgdDPgKwzz
	 Km1LTXOhTEljHIfhV6/Uc8HgUL62NE4ZHjQTm0rs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.95
Date: Sat,  4 Jul 2026 13:59:00 +0200
Message-ID: <2026070401-polygon-mobilize-50fa@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.95 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/networking/bonding.rst                       |   15 
 Documentation/userspace-api/ioctl/ioctl-number.rst         |  485 ++---
 Makefile                                                   |    2 
 arch/arm64/Kconfig                                         |    1 
 arch/loongarch/kernel/smp.c                                |    1 
 arch/mips/dec/prom/console.c                               |    7 
 arch/mips/kernel/smp.c                                     |    2 
 arch/riscv/include/asm/cacheflush.h                        |   25 
 arch/riscv/include/asm/kfence.h                            |    7 
 arch/riscv/kernel/entry.S                                  |    6 
 arch/x86/kvm/hyperv.c                                      |    5 
 arch/x86/kvm/mmu/mmu.c                                     |   28 
 arch/x86/kvm/svm/sev.c                                     |  113 -
 block/bdev.c                                               |    5 
 block/blk-cgroup.c                                         |   21 
 drivers/acpi/scan.c                                        |   41 
 drivers/base/memory.c                                      |    3 
 drivers/char/agp/amd64-agp.c                               |    2 
 drivers/crypto/intel/qat/qat_common/adf_cfg.c              |   10 
 drivers/crypto/intel/qat/qat_common/adf_cfg.h              |    1 
 drivers/crypto/intel/qat/qat_common/adf_cfg_common.h       |   32 
 drivers/crypto/intel/qat/qat_common/adf_cfg_user.h         |   38 
 drivers/crypto/intel/qat/qat_common/adf_common_drv.h       |    3 
 drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c          |  416 ----
 drivers/crypto/intel/qat/qat_common/adf_dev_mgr.c          |   70 
 drivers/fpga/of-fpga-region.c                              |    3 
 drivers/gpio/gpiolib.c                                     |  136 -
 drivers/gpu/drm/v3d/v3d_drv.h                              |    7 
 drivers/gpu/drm/v3d/v3d_gem.c                              |    7 
 drivers/gpu/drm/v3d/v3d_irq.c                              |   62 
 drivers/gpu/drm/v3d/v3d_sched.c                            |   42 
 drivers/gpu/drm/xe/display/xe_display.c                    |   11 
 drivers/hv/hv_kvp.c                                        |   25 
 drivers/hv/vmbus_drv.c                                     |   29 
 drivers/i2c/i2c-core-base.c                                |    8 
 drivers/i2c/i2c-stub.c                                     |    5 
 drivers/iio/adc/ti-ads1298.c                               |    7 
 drivers/iio/light/bh1780.c                                 |    4 
 drivers/iio/light/veml6075.c                               |    8 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                   |    2 
 drivers/irqchip/irq-imgpdc.c                               |    6 
 drivers/media/test-drivers/vidtv/vidtv_mux.c               |    8 
 drivers/mtd/spi-nor/macronix.c                             |   31 
 drivers/net/bonding/bond_3ad.c                             |  131 -
 drivers/net/bonding/bond_main.c                            |   86 
 drivers/net/bonding/bond_netlink.c                         |   37 
 drivers/net/bonding/bond_options.c                         |   71 
 drivers/net/bonding/bond_procfs.c                          |   11 
 drivers/net/bonding/bond_sysfs_slave.c                     |   17 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c         |    8 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h         |    1 
 drivers/net/wan/hdlc_ppp.c                                 |   15 
 drivers/net/wireless/ath/ath11k/dp.c                       |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c               |    2 
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c            |    1 
 drivers/net/wireless/mediatek/mt76/mt7921/init.c           |    7 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c           |   14 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c           |    3 
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h       |    2 
 drivers/net/wireless/realtek/rtw88/tx.c                    |    7 
 drivers/net/wireless/realtek/rtw88/usb.c                   |   13 
 drivers/ntb/hw/epf/ntb_hw_epf.c                            |    3 
 drivers/pci/controller/dwc/pcie-qcom.c                     |   17 
 drivers/power/reset/linkstation-poweroff.c                 |    2 
 drivers/power/sequencing/core.c                            |   14 
 drivers/regulator/core.c                                   |   10 
 drivers/rpmsg/rpmsg_char.c                                 |   15 
 drivers/staging/rtl8723bs/core/rtw_mlme.c                  |   10 
 drivers/tty/serial/8250/8250_dw.c                          |    4 
 drivers/tty/serial/qcom_geni_serial.c                      |    9 
 drivers/tty/vt/vc_screen.c                                 |    2 
 drivers/video/fbdev/core/fbmem.c                           |   12 
 drivers/video/fbdev/core/fbsysfs.c                         |   10 
 drivers/video/fbdev/core/modedb.c                          |    5 
 fs/backing-file.c                                          |   22 
 fs/dlm/lockspace.c                                         |    2 
 fs/eventpoll.c                                             |  142 -
 fs/exfat/dir.c                                             |    4 
 fs/f2fs/acl.c                                              |   18 
 fs/f2fs/data.c                                             |   16 
 fs/f2fs/extent_cache.c                                     |   19 
 fs/f2fs/file.c                                             |    9 
 fs/f2fs/inode.c                                            |    9 
 fs/fhandle.c                                               |   16 
 fs/file_table.c                                            |   40 
 fs/fuse/dev.c                                              |   23 
 fs/fuse/file.c                                             |    8 
 fs/fuse/passthrough.c                                      |    2 
 fs/gfs2/super.c                                            |    1 
 fs/internal.h                                              |    4 
 fs/mount.h                                                 |   10 
 fs/namespace.c                                             |    6 
 fs/nfs/client.c                                            |    1 
 fs/nfs/pnfs.c                                              |    2 
 fs/nfs/pnfs_nfs.c                                          |    4 
 fs/nfsd/nfs2acl.c                                          |   17 
 fs/nfsd/nfs3acl.c                                          |   17 
 fs/nfsd/nfs4recover.c                                      |    3 
 fs/nfsd/nfs4state.c                                        |    1 
 fs/nfsd/nfs4xdr.c                                          |    3 
 fs/nfsd/vfs.c                                              |    6 
 fs/ntfs3/xattr.c                                           |   12 
 fs/ocfs2/suballoc.c                                        |   22 
 fs/overlayfs/dir.c                                         |    2 
 fs/overlayfs/file.c                                        |    3 
 fs/smb/server/smb2pdu.c                                    |    5 
 fs/smb/server/smbacl.c                                     |    4 
 fs/xfs/libxfs/xfs_ag_resv.c                                |    8 
 fs/xfs/libxfs/xfs_alloc.c                                  |    5 
 fs/xfs/libxfs/xfs_attr_leaf.c                              |    2 
 fs/xfs/libxfs/xfs_bmap.c                                   |   17 
 fs/xfs/libxfs/xfs_btree.c                                  |    2 
 fs/xfs/libxfs/xfs_da_btree.c                               |    2 
 fs/xfs/libxfs/xfs_dir2.c                                   |    2 
 fs/xfs/libxfs/xfs_exchmaps.c                               |    4 
 fs/xfs/libxfs/xfs_ialloc.c                                 |    2 
 fs/xfs/libxfs/xfs_inode_buf.c                              |    4 
 fs/xfs/libxfs/xfs_inode_fork.c                             |    3 
 fs/xfs/libxfs/xfs_refcount.c                               |    5 
 fs/xfs/libxfs/xfs_rmap.c                                   |    2 
 fs/xfs/scrub/cow_repair.c                                  |    7 
 fs/xfs/scrub/repair.c                                      |    2 
 fs/xfs/xfs_attr_item.c                                     |    2 
 fs/xfs/xfs_buf.c                                           |    4 
 fs/xfs/xfs_error.c                                         |    5 
 fs/xfs/xfs_error.h                                         |   10 
 fs/xfs/xfs_inode.c                                         |   28 
 fs/xfs/xfs_iomap.c                                         |    2 
 fs/xfs/xfs_log.c                                           |    8 
 fs/xfs/xfs_trans_ail.c                                     |    2 
 include/keys/request_key_auth-type.h                       |    2 
 include/linux/backing-file.h                               |    4 
 include/linux/blkdev.h                                     |   16 
 include/linux/err.h                                        |   12 
 include/linux/fs.h                                         |   19 
 include/linux/kvm_host.h                                   |    7 
 include/linux/lsm_audit.h                                  |    2 
 include/linux/lsm_hook_defs.h                              |    5 
 include/linux/lsm_hooks.h                                  |    1 
 include/linux/security.h                                   |   22 
 include/linux/skmsg.h                                      |   15 
 include/net/bond_3ad.h                                     |    3 
 include/net/bond_options.h                                 |    2 
 include/net/bonding.h                                      |    3 
 include/net/phonet/pn_dev.h                                |    2 
 include/net/rtnetlink.h                                    |    2 
 include/net/sock.h                                         |    2 
 include/net/udp_tunnel.h                                   |   14 
 include/uapi/linux/if_link.h                               |    3 
 io_uring/net.c                                             |   36 
 io_uring/opdef.c                                           |    4 
 kernel/bpf/cgroup.c                                        |    2 
 kernel/fork.c                                              |    1 
 kernel/futex/pi.c                                          |    6 
 kernel/locking/mutex.c                                     |   16 
 kernel/locking/rtmutex.c                                   |   51 
 kernel/locking/rtmutex_api.c                               |   14 
 kernel/locking/rtmutex_common.h                            |    3 
 kernel/locking/rwbase_rt.c                                 |    8 
 kernel/locking/rwsem.c                                     |    4 
 kernel/locking/spinlock_rt.c                               |    5 
 kernel/locking/ww_mutex.h                                  |   30 
 kernel/sched/core.c                                        |   12 
 kernel/trace/bpf_trace.c                                   |    4 
 kernel/trace/ftrace.c                                      |   68 
 lib/debugobjects.c                                         |   56 
 net/9p/client.c                                            |    3 
 net/batman-adv/bat_iv_ogm.c                                |   11 
 net/batman-adv/bat_v.c                                     |    1 
 net/batman-adv/bat_v_ogm.c                                 |   23 
 net/batman-adv/bridge_loop_avoidance.c                     |   28 
 net/batman-adv/distributed-arp-table.c                     |   12 
 net/batman-adv/fragmentation.c                             |   22 
 net/batman-adv/fragmentation.h                             |    3 
 net/batman-adv/netlink.c                                   |    8 
 net/batman-adv/routing.c                                   |   73 
 net/batman-adv/tp_meter.c                                  |  113 -
 net/batman-adv/translation-table.c                         |   12 
 net/batman-adv/tvlv.c                                      |   69 
 net/batman-adv/types.h                                     |   21 
 net/core/filter.c                                          |   27 
 net/core/rtnetlink.c                                       |    8 
 net/core/skbuff.c                                          |   23 
 net/core/skmsg.c                                           |    2 
 net/ipv4/ip_gre.c                                          |    6 
 net/ipv4/ip_output.c                                       |   20 
 net/ipv4/tcp_ao.c                                          |    4 
 net/ipv6/ip6_output.c                                      |   22 
 net/ipv6/ip6_udp_tunnel.c                                  |   15 
 net/ipv6/ip6_vti.c                                         |    1 
 net/mac802154/llsec.c                                      |   14 
 net/phonet/pn_dev.c                                        |   12 
 net/phonet/pn_netlink.c                                    |   23 
 net/rxrpc/input.c                                          |   21 
 net/sctp/ipv6.c                                            |    9 
 net/sctp/protocol.c                                        |    2 
 net/socket.c                                               |    2 
 net/tipc/crypto.c                                          |    9 
 net/tipc/udp_media.c                                       |   10 
 net/tls/tls_sw.c                                           |    4 
 net/unix/garbage.c                                         |    2 
 scripts/link-vmlinux.sh                                    |    4 
 scripts/sorttable.c                                        | 1119 ++++++++++++-
 scripts/sorttable.h                                        |  500 -----
 security/apparmor/include/policy_unpack.h                  |   19 
 security/apparmor/lsm.c                                    |   16 
 security/apparmor/policy.c                                 |    8 
 security/keys/internal.h                                   |    2 
 security/keys/keyctl.c                                     |   24 
 security/keys/keyctl_pkey.c                                |    9 
 security/keys/request_key_auth.c                           |   33 
 security/security.c                                        |  109 +
 security/selinux/hooks.c                                   |  242 ++
 security/selinux/include/objsec.h                          |   11 
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c |   35 
 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c |   25 
 tools/testing/selftests/ptp/testptp.c                      |   62 
 virt/kvm/eventfd.c                                         |   12 
 218 files changed, 3856 insertions(+), 2326 deletions(-)

Amir Goldstein (1):
      fs: constify file ptr in backing_file accessor helpers

André Draszik (1):
      regulator: core: fix locking in regulator_resolve_supply() error path

Andy Shevchenko (2):
      gpiolib: Extract gpiochip_choose_fwnode() for wider use
      gpiolib: Remove redundant assignment of return variable

Antoniu Miclaus (1):
      iio: light: bh1780: fix PM runtime leak on error path

Arnd Bergmann (1):
      err.h: use __always_inline on all error pointer helpers

Ashutosh Desai (1):
      KVM: SVM: Fix page overflow in sev_dbg_crypt() for ENCRYPT path

Bagas Sanjaya (2):
      Documentation: ioctl-number: Fix linuxppc-dev mailto link
      Documentation: ioctl-number: Extend "Include File" column width

Bitterblue Smith (1):
      wifi: rtlwifi: rtl8821ae: Fix C2H bit location in RX descriptor

Bryam Vargas (1):
      apparmor: mediate the implicit connect of TCP fast open sendmsg

Cheng Ming Lin (2):
      mtd: spi-nor: macronix: Add post_sfdp fixups for Quad Input Page Program
      mtd: spi-nor: macronix: add support for mx66{l2, u1}g45g

Christian Brauner (7):
      eventpoll: use hlist_is_singular_node() in __ep_remove()
      eventpoll: split __ep_remove()
      eventpoll: kill __ep_remove()
      eventpoll: drop vestigial __ prefix from ep_remove_{file,epi}()
      eventpoll: rename ep_remove_safe() back to ep_remove()
      eventpoll: move epi_fget() up
      eventpoll: fix ep_remove struct eventpoll / struct file UAF

Christoph Hellwig (1):
      xfs: remove the expr argument to XFS_TEST_ERROR

David Howells (1):
      rxrpc: Fix the ACK parser to extract the SACK table for parsing

Davidlohr Bueso (1):
      locking/rtmutex: Skip remove_waiter() when waiter is not enqueued

Dawei Feng (1):
      bpf: use kvfree() for replaced sysctl write buffer

Denis Arefev (1):
      block: Avoid mounting the bdev pseudo-filesystem in userspace

Dexuan Cui (1):
      Drivers: hv: vmbus: Improve the logic of reserving fb_mmio on Gen2 VMs

Dominik Woźniak (1):
      nfsd: check get_user() return when reading princhashlen

Doruk Tan Ozturk (2):
      mac802154: llsec: add skb_cow_data() before in-place crypto
      tipc: fix slab-use-after-free Read in tipc_aead_decrypt_done

ElXreno (1):
      wifi: mt76: mt7925: don't disable AP BSS when removing TDLS peer

Eric Dumazet (4):
      ip6_vti: set netns_immutable on the fallback device.
      bonding: 3ad: implement proper RCU rules for port->aggregator
      inet: add indirect call wrapper for getfrag() calls
      bonding: annotate data-races arcound churn variables

Fan Wu (1):
      hdlc_ppp: sync per-proto timers before freeing hdlc state

Gabriel Krisman Bertazi (1):
      io_uring/net: Avoid msghdr on op_connect/op_bind async data

Georgi Djakov (1):
      drivers/base/memory: set mem->altmap after successful device registration

Gil Portnoy (1):
      ksmbd: reject non-VALID session in compound request branch

Giovanni Cabiddu (1):
      crypto: qat - remove unused character device and IOCTLs

Greg Kroah-Hartman (1):
      Linux 6.12.95

Guannan Wang (1):
      NFSD: Fix SECINFO_NO_NAME decode error cleanup

Guenter Roeck (1):
      ftrace: Do not over-allocate ftrace memory

HanQuan (1):
      net/tcp-ao: fix use-after-free of key in del_async path

Hangbin Liu (4):
      bonding: add support for per-port LACP actor priority
      bonding: print churn state via netlink
      bonding: fix NULL pointer dereference in actor_port_prio setting
      bonding: do not set usable_slaves for broadcast mode

Helen Koike (1):
      debugobjects: Do not fill_pool() if pi_blocked_on

Hem Parekh (1):
      ksmbd: fix out-of-bounds read in smb_check_perm_dacl()

Herbert Xu (1):
      crypto: qat - Return pointer directly in adf_ctl_alloc_resources

Huacai Chen (1):
      LoongArch: Report dying CPU to RCU in stop_this_cpu()

Hyunwoo Kim (1):
      KVM: x86: hyper-v: Bound the bank index when querying sparse banks

Ian Bridges (2):
      fbdev: fix use-after-free in store_modes()
      fbdev: Fix fb_new_modelist to prevent null-ptr-deref in fb_videomode_to_var

Jani Nikula (1):
      drm/xe/display: fix oops in suspend/shutdown without display

Jann Horn (2):
      fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios
      fhandle: fix UAF due to unlocked ->mnt_ns read in may_decode_fh()

Jarkko Sakkinen (1):
      KEYS: fix overflow in keyctl_pkey_params_get_2()

Jeff Layton (3):
      nfsd: fix posix_acl leak on SETACL decode failure
      nfsd: avoid leaking pre-allocated openowner on unconfirmed retry race
      nfsd: reset write verifier on deferred writeback errors

Joanne Koong (1):
      fuse: re-lock request before replacing page cache folio

Johan Hovold (1):
      i2c: core: fix adapter registration race

John Stultz (1):
      locking: rtmutex: Fix wake_q logic in task_blocks_on_rt_mutex

Jonas Jelonek (1):
      MIPS: smp: report dying CPU to RCU in stop_this_cpu()

Jose Ignacio Tornos Martinez (1):
      wifi: ath11k: fix warning when unbinding

Junjie Cao (1):
      wifi: iwlwifi: mvm: fix race condition in PTP removal

Kevin Berry (1):
      Revert "net: bonding: fix use-after-free in bond_xmit_broadcast()"

Koichiro Den (1):
      NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD and CONFIG share BAR

Konstantin Komarov (1):
      ntfs3: reject direct userspace writes to reserved $LX* xattrs

Kuniyuki Iwashima (3):
      phonet: Pass ifindex to fill_addr().
      phonet: Pass net and ifindex to phonet_address_notify().
      af_unix: Set gc_in_progress to true in unix_gc().

Leon Yen (1):
      wifi: mt76: mt7921: avoid undesired changes of the preset regulatory domain

Lord Ulf Henrik Holmberg (1):
      RDMA/bnxt_re: zero shared page before exposing to userspace

Luka Gejak (2):
      wifi: rtw88: increase TX report timeout to fix race condition
      wifi: rtw88: usb: fix memory leaks on USB write failures

Maciej W. Rozycki (1):
      MIPS: DEC: Prevent initial console buffer from landing in XKPHYS

Maoyi Xie (1):
      net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink

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

Peter Zijlstra (1):
      locking/mutex: Remove wakeups from under mutex::wait_lock

Petr Machata (2):
      Reapply "selftest/ptp: update ptp selftest to exercise the gettimex options"
      net: ipv6: Make udp_tunnel6_xmit_skb() void

Qingshuang Fu (1):
      irqchip/imgpdc: Fix resource leak, add missing chained handler cleanup on remove

Quan Zhou (1):
      wifi: mt76: mt7921: fix a potential scan no APs

Ruslan Valiyev (2):
      media: vidtv: fix NULL pointer dereference in vidtv_mux_push_si
      apparmor: fix use-after-free in rawdata dedup loop

Salman Alghamdi (1):
      staging: rtl8723bs: fix buffer over-read in rtw_update_protection

Sam Daly (2):
      iio: light: veml6075: add bounds check to veml6075_it_ms index
      iio: adc: ti-ads1298: add bounds check to pga_settings index

Santosh Kalluri (1):
      net: phonet: free phonet_device after RCU grace period

Sasha Levin (1):
      Revert "PCI: qcom: Advertise Hotplug Slot Capability with no Command Completion support"

Sean Christopherson (7):
      KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level
      KVM: SEV: Ignore MMIO requests of length '0'
      KVM: SEV: Reject MMIO requests larger than 8 bytes with GHCB v2+
      KVM: SEV: Ignore Port I/O requests of length '0'
      KVM: SEV: Move sev_free_vcpu() down below sev_es_unmap_ghcb()
      KVM: SEV: Unmap and unpin the GHCB as needed on vCPU free
      KVM: Replace guest-triggerable BUG_ON() in ioeventfd datamatch with get_unaligned()

Sean Wang (1):
      wifi: mt76: mt7921: fix potential deadlock in mt7921_roc_abort_sync

Sebastian Andrzej Siewior (3):
      net: Drop the lock in skb_may_tx_timestamp()
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

Sven Eckelmann (25):
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

Tonghao Zhang (2):
      net: bonding: add broadcast_neighbor option for 802.3ad
      net: bonding: update the slave array for broadcast mode

Tristan Madani (1):
      gfs2: fix use-after-free in gfs2_qd_dealloc

Tuo Li (1):
      fbdev: modedb: fix a possible UAF in fb_find_mode()

Tzung-Bi Shih (1):
      gpio: Fix resource leaks on errors in gpiochip_add_data_with_key()

Usama Arif (2):
      kernel/fork: clear PF_BLOCK_TS in copy_process()
      block: invalidate cached plug timestamp after task switch

Varun R Mallya (2):
      bpf: Reject sleepable kprobe_multi programs at attach time
      selftests/bpf: Add test to ensure kprobe_multi is not sleepable

Vasily Gorbik (1):
      scripts/sorttable: Fix endianness handling in build-time mcount sort

Viken Dadhaniya (1):
      serial: qcom_geni: Fix RX DMA stall when SE_DMA_RX_LEN_IN is zero

Vivian Wang (2):
      riscv: mm: Extract helper mark_new_valid_map()
      riscv: kfence: Call mark_new_valid_map() for kfence_unprotect()

Waiman Long (1):
      debugobjects: Dont call fill_pool() in early boot hardirq context

Weiming Shi (2):
      i2c: stub: Reject I2C block transfers with invalid length
      net: qualcomm: rmnet: fix endpoint use-after-free in rmnet_dellink()

Wenjie Qi (2):
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

Xiang Mei (1):
      net: bonding: fix use-after-free in bond_xmit_broadcast()

Xin Long (1):
      sctp: disable BH before calling udp_tunnel_xmit_skb()

Yi Yang (1):
      vc_screen: fix null-ptr-deref in vcs_notifier() during concurrent vcs_write

Yicong Yang (1):
      ACPI: scan: Use async schedule function in acpi_scan_clear_dep_fn()

Yiming Qian (1):
      net: skmsg: preserve sg.copy across SG transforms

Yingjie Gao (1):
      xfs: fix error returns in CoW fork repair

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

