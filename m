Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE70F4921BB;
	Wed,  2 Sep 2026 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352937; cv=none; b=C/GprCJQrJ15ZedKiFq5PK6wQPvbfWxA0iRrzIf5iH2vrUNwGZ7rVBzVaCpFvLXNJBSekpppGd18Ja24+aYIxFNk9rAgrrR4XwP/2BqKmMR32CzrUp4zfVKtmv2p/iQasluGcvZ5ElpH/wb6RTD48b3jN3uD7cxH694+A0WAkWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352937; c=relaxed/simple;
	bh=39tIru79M9NDRx1GF8XBe61t8uziF+/R/hf/vDiF32s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t3rkaPP1lPtUX5vooQF3NmAASChBHVj20E8ZHnQPPvgfq/KLfx27BHphQElEQq9llbPF0PeNHIn67wwUBEvluFOrO5CLdOOLm22Ig4lZSqZpvxdFCkbGTys5mq7xQSrEQXuDIWAoCL3CT+jpvBKs7ccj6Na1aq/XYCBihsg5FZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dBFXftvY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dBFXftvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA5A1F000E9;
	Wed,  2 Sep 2026 12:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788352935;
	bh=EsuKzEmJzA1Quh82ZLKjl3pqxpLFdQg88qkAnZQytGA=;
	h=From:To:Cc:Subject:Date;
	b=dBFXftvY5SjTn/5+8o0/ySGOTKE7UAjahpU4ma4UYY9zZI0waQIndkShmss5adKAR
	 BkH7w8553At2J7PiAfw5jMedaopR1kWluc0hd8eKlY/wLNq+UGVWUfJC+umSOH19X9
	 tostIOcvajAhjnljCVd6yJOfQ2OQR80YuVCn9Drw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.187
Date: Wed,  2 Sep 2026 14:42:09 +0200
Message-ID: <2026090210-paving-refute-7138@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.187 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/filesystems/fscrypt.rst                    |    4 
 Makefile                                                 |    2 
 arch/arm64/kvm/arm.c                                     |    6 
 arch/riscv/kernel/compat_signal.c                        |    2 
 arch/riscv/kernel/ptrace.c                               |    4 
 arch/s390/kvm/vsie.c                                     |    1 
 arch/x86/kvm/mmu/page_track.c                            |   28 +
 block/blk-core.c                                         |    2 
 drivers/accessibility/speakup/main.c                     |    1 
 drivers/base/power/main.c                                |    6 
 drivers/crypto/atmel-tdes.c                              |    5 
 drivers/crypto/mxs-dcp.c                                 |    2 
 drivers/crypto/qce/aead.c                                |   58 ---
 drivers/crypto/qce/common.c                              |   55 ---
 drivers/crypto/qce/common.h                              |   16 
 drivers/crypto/qce/regs-v5.h                             |    4 
 drivers/crypto/qce/sha.c                                 |   30 -
 drivers/crypto/qce/sha.h                                 |    1 
 drivers/crypto/qce/skcipher.c                            |   97 -----
 drivers/fpga/dfl-fme-perf.c                              |    2 
 drivers/gpu/drm/nouveau/dispnv50/disp.c                  |    4 
 drivers/hid/hid-ft260.c                                  |  157 +++++++--
 drivers/hid/hid-input.c                                  |    3 
 drivers/hid/hid-magicmouse.c                             |   63 +++
 drivers/hid/hid-nintendo.c                               |   13 
 drivers/hid/hid-uclogic-core.c                           |   12 
 drivers/infiniband/sw/rxe/rxe_qp.c                       |    3 
 drivers/isdn/hardware/mISDN/hfcpci.c                     |   12 
 drivers/media/platform/samsung/exynos4-is/fimc-is-regs.c |    1 
 drivers/mtd/maps/vmu-flash.c                             |    8 
 drivers/net/ethernet/ibm/ibmvnic.c                       |   30 +
 drivers/net/wireless/ath/ath11k/hw.c                     |    2 
 drivers/nvme/host/core.c                                 |   18 -
 drivers/nvme/host/fabrics.c                              |    8 
 drivers/nvme/host/fault_inject.c                         |    2 
 drivers/nvme/host/fc.c                                   |    8 
 drivers/nvme/target/admin-cmd.c                          |   22 -
 drivers/nvme/target/core.c                               |   46 +-
 drivers/nvme/target/discovery.c                          |   14 
 drivers/nvme/target/fabrics-cmd-auth.c                   |   16 
 drivers/nvme/target/fabrics-cmd.c                        |   36 +-
 drivers/nvme/target/io-cmd-bdev.c                        |   12 
 drivers/nvme/target/nvmet.h                              |    2 
 drivers/nvme/target/passthru.c                           |   10 
 drivers/nvme/target/rdma.c                               |   10 
 drivers/nvme/target/tcp.c                                |   17 
 drivers/nvme/target/zns.c                                |   30 -
 drivers/target/target_core_fabric_configfs.c             |    8 
 drivers/usb/c67x00/c67x00-sched.c                        |    4 
 drivers/usb/core/devio.c                                 |    2 
 drivers/usb/core/hub.c                                   |    7 
 drivers/usb/gadget/function/f_tcm.c                      |    2 
 drivers/usb/host/xhci-dbgtty.c                           |   15 
 drivers/usb/host/xhci-ring.c                             |    2 
 drivers/usb/misc/usbtest.c                               |    1 
 drivers/usb/phy/phy-fsl-usb.c                            |    1 
 drivers/usb/serial/option.c                              |   20 -
 drivers/usb/serial/spcp8x5.c                             |   13 
 fs/exfat/nls.c                                           |    1 
 fs/ext4/crypto.c                                         |   40 +-
 fs/ext4/fast_commit.c                                    |   10 
 fs/ext4/ialloc.c                                         |    4 
 fs/fuse/dir.c                                            |    9 
 fs/fuse/file.c                                           |    4 
 fs/jfs/inode.c                                           |    2 
 fs/jfs/jfs_discard.c                                     |    3 
 fs/jfs/jfs_extent.c                                      |   10 
 fs/nilfs2/ioctl.c                                        |  261 ++++++---------
 fs/smb/client/smb2ops.c                                  |    4 
 include/linux/inetdevice.h                               |    5 
 include/linux/nvme.h                                     |    6 
 include/net/bluetooth/hci_core.h                         |   15 
 include/target/target_core_fabric.h                      |    2 
 io_uring/io-wq.c                                         |    9 
 kernel/bpf/offload.c                                     |   10 
 mm/swapfile.c                                            |    7 
 net/bluetooth/hci_conn.c                                 |    3 
 net/bluetooth/hci_event.c                                |   46 +-
 net/bluetooth/hci_sync.c                                 |   48 ++
 net/bridge/br_multicast.c                                |    4 
 net/can/j1939/j1939-priv.h                               |    1 
 net/can/j1939/main.c                                     |    5 
 net/can/j1939/socket.c                                   |   55 +++
 net/core/filter.c                                        |    1 
 net/ipv4/icmp.c                                          |   14 
 net/ipv4/igmp.c                                          |   14 
 net/ipv6/ah6.c                                           |   29 +
 net/ipv6/icmp.c                                          |    3 
 net/ipv6/seg6_local.c                                    |    7 
 net/mptcp/pm_netlink.c                                   |    3 
 net/mptcp/pm_userspace.c                                 |   10 
 net/mptcp/protocol.c                                     |    5 
 net/mptcp/protocol.h                                     |    7 
 net/netfilter/ipvs/ip_vs_xmit.c                          |    6 
 net/nfc/nci/ntf.c                                        |   26 +
 net/smc/smc_clc.c                                        |   67 ++-
 net/smc/smc_core.c                                       |   27 -
 net/smc/smc_pnet.c                                       |   43 +-
 net/tls/tls_device.c                                     |    3 
 net/xfrm/espintcp.c                                      |    9 
 net/xfrm/xfrm_user.c                                     |    2 
 security/selinux/ss/conditional.c                        |   12 
 sound/soc/codecs/nau8821.c                               |   13 
 sound/soc/tegra/tegra_pcm.c                              |    3 
 sound/usb/card.c                                         |   14 
 sound/usb/midi.c                                         |    2 
 106 files changed, 1032 insertions(+), 812 deletions(-)

Aleksandr Nogikh (1):
      usb: usbtest: disable dynamic ID support

Andrei Fed (1):
      HID: magicmouse: fix battery reporting for Bluetooth Magic Trackpad USB-C

Asim Viladi Oglu Manizada (1):
      xfrm: ah6: validate routing header segments_left

Baokun Li (2):
      fuse: fix invalidate lock leak on setattr writeback failure
      fuse: fix invalidate lock leak on open O_TRUNC DAX failure

Bartosz Golaszewski (1):
      crypto: qce - Remove unsafe/deprecated algorithms

Ben Skeggs (1):
      drm/nouveau/kms/nv50-: init hpd_irq_lock for PIOR DP

Bryam Vargas (1):
      nfc: nci: add data_len bound checks to activation parameter extractors

Chengfeng Ye (1):
      Bluetooth: hci_sync: Fix accept list UAF during suspend

Christian Borntraeger (1):
      KVM: s390: vsie: zero stale crypto bits

Christoph Hellwig (1):
      block: make bio_check_eod work for zero sized devices

Christopher Kodama (1):
      HID: magicmouse: re-enable multitouch after reset-resume

Cristian Ciocaltea (2):
      ASoC: nau8821: Cancel delayed work on component remove
      ASoC: nau8821: Cancel pending work before suspend

Dylan Wolff (1):
      jfs: Fix null-ptr-deref in jfs_ioc_trim

Eric Biggers (2):
      ext4: don't enable DAX on new encrypted files
      mm/swap: reject swapon() on filesystem-level encrypted files

Eric Dumazet (2):
      inet: RAW sockets using IPPROTO_RAW MUST drop incoming ICMP
      ipv4: igmp: Fix potential UAF in igmp_gq_start_timer()

Florian Westphal (1):
      ipvs: reload ip header after head reallocation

Greg Kroah-Hartman (1):
      Linux 6.1.187

Griffin Kroah-Hartman (3):
      fpga: dfl: fme: add error handling
      usb: core: Add lock to usb_wakeup_notification()
      usb: core: Strengthen error handling in hub_hub_status()

Guanghui Yang (1):
      ext4: propagate errors from fast commit range replay

Haoxiang Li (1):
      accessibility: speakup: unregister tty ldisc on later init failures

Ibrahim Hashimov (2):
      nvmet-tcp: bound SGL data length before allocating command buffers
      HID: uclogic: fix use-after-free of inrange_timer on remove

Jiale Yao (1):
      USB: serial: option: fix slab OOB read in interrupt URB callback

Jiangshan Yi (1):
      HID: nintendo: stop device IO before hid_hw_stop on probe failure

Jiayuan Chen (2):
      bpf: Fix use-after-free in offloaded map/prog info fill
      tls: device: fix out-of-bounds write in tls_append_frag()

Jinu Kim (1):
      KVM: x86/mmu: Check write tracking in all address spaces

Johan Hovold (1):
      USB: serial: spcp8x5: drop broken carrier detect support

Jon Hunter (1):
      ASoC: tegra: Fix Master Volume Control

Jose Villaseñor Montfort (1):
      HID: magicmouse: prevent unbounded recursion in magicmouse_raw_event()

Kuniyuki Iwashima (4):
      smc: Fix use-after-free in __pnet_find_base_ndev().
      smc: Use __sk_dst_get() and dst_dev_rcu() in in smc_clc_prfx_set().
      smc: Use __sk_dst_get() and dst_dev_rcu() in smc_clc_prfx_match().
      smc: Use __sk_dst_get() and dst_dev_rcu() in smc_vlan_by_tcpsk().

Kyle Zeng (1):
      ipv6: seg6: clear IPv4 control block on IPIP decapsulation

Laxman Acharya Padhya (1):
      Bluetooth: hci_event: validate LE Set CIG Parameters response

Lucas De Marchi (2):
      xhci: dbgtty: Fix unregister on tty_register_driver() failure
      xhci: dbgtty: Fix unregister on tty_alloc_driver() failure

Luiz Augusto von Dentz (2):
      Bluetooth: hci_conn: Fix not matching by CIS ID
      Bluetooth: hci_core: Fix hci_conn_hash_lookup_cis

Marouane El Moufid (1):
      ALSA: usb-audio: fix OOB write in snd_usbmidi_novation_output()

Md Sadre Alam (1):
      crypto: qce - fix CCM AAD buffer underallocation

Michael Neuling (1):
      riscv: Fix register corruption from uninitialized cregs on error

Michael Zaidman (6):
      HID: ft260: improve i2c write performance
      HID: ft260: improve i2c large reads performance
      HID: ft260: skip unexpected HID input reports
      HID: ft260: wake up device from power saving mode
      HID: ft260: missed NACK from busy device
      HID: ft260: validate i2c input report length

Miguel Peñaranda (1):
      usb: usbfs: fix use-after-free of usb_device in usbdev_release()

Namjae Jeon (1):
      exfat: fix double free in delayed_free

Nick Child (1):
      ibmvnic: Use kernel helpers for hex dumps

Norbert Szetei (1):
      net: bridge: mcast: fix use-after-free of a master VLAN's multicast context

Oliver Upton (1):
      KVM: arm64: Prevent access to vCPU events before init

Pauli Virtanen (2):
      Bluetooth: ISO: use correct CIS order in Set CIG Parameters event
      Bluetooth: hci_event: fix Set CIG Parameters error status handling

Peiyang He (1):
      RDMA/rxe: Fix OOB in free_rd_atomic_resources()

Ralf Lici (1):
      Revert "usb: phy: fsl-usb: Fix use-after-free in delayed work during device removal"

Raman Varabets (1):
      HID: ft260: fix stack-use-after-return write in I2C read race

Ryusuke Konishi (2):
      nilfs2: correct return value kernel-doc descriptions for ioctl functions
      nilfs2: reject invalid block index in GC ioctl

Sabrina Dubroca (1):
      xfrm: espintcp: fix UAF during close

Sasha Levin (3):
      Revert "PM: sleep: Use complete() in device_pm_sleep_init()"
      Revert "mtd: maps: vmu-flash: fix fault in unaligned fixup"
      Revert "smb: client: use kvzalloc() for megabyte buffer in simple fallocate"

Sebastian Andrzej Siewior (1):
      bpf: Remove tst_run from lwt_seg6local_prog_ops.

Semih Baskan (1):
      usb: xhci: Handle USB3 port events when there is one roothub

Shardul Bankar (1):
      mptcp: pm: fix memory leak from alloc-during-teardown race

Shuangpeng Bai (2):
      usb: gadget: f_tcm: keep port count until LUN teardown completes
      USB: c67x00: fix use-after-free in c67x00_add_iso_urb()

Stephen Smalley (1):
      selinux: switch two allocations to use kzalloc_objs()

Tetsuo Handa (3):
      can: j1939: implement NETDEV_UNREGISTER notification handler
      can: j1939: add missing calls in NETDEV_UNREGISTER notification handler
      can: j1939: make j1939_sk_bind() fail if device is no longer registered

Thorsten Blum (2):
      crypto: atmel-tdes - use scatterlist length before DMA mapping
      crypto: mxs-dcp - fix source scatterlist length access

Vasiliy Kovalev (2):
      jfs: add check read-only before truncation in jfs_truncate_nolock()
      jfs: add check read-only before txBeginAnon() call

Vishnu Razdan (1):
      io_uring/io-wq: fix worker accounting when canceling creation callbacks

Vladimir Riabchun (1):
      mISDN: hfcpci: Fix warning when deleting uninitialized timer

Weiwen Hu (1):
      nvme: rename CDR/MORE/DNR to NVME_STATUS_*

Wentao Liang (1):
      media: platform: exynos4-is: Add hardware sync wait to fimc_is_hw_change_mode()

Will Porter (1):
      ALSA: usb-audio: Complete cleanup after system-resume errors

Zhiling Zou (1):
      xfrm: drop ESP-in-TCP packets with no ingress device

Zihan Xi (1):
      xfrm: fix xfrm_state_construct() auth-trunc leak

Zijun Hu (1):
      Bluetooth: hci_sync: Use bt_dev_err() to log error message in hci_update_event_filter_sync()

Ziyang Huang (1):
      wifi: ath11k: Add missing hw_ops->get_ring_selector() for IPQ5018

