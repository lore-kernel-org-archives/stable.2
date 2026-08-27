Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686434570D1;
	Thu, 27 Aug 2026 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835451; cv=none; b=rvJr5kpaF76LQCiC5LoAjd//2x+CjLt0Jk2d0VuTsMnXmVI+d+hvqoBZXDI50IYzh2dqupOqUa9OJrVRSjhpSILOi1AuEvDD1972xrchOVLrvRz8nTGe3PXCMa+CEKyTJOmrP16dUFRmoDPfk5McFTupROTWLS+v9THKbZtQuHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835451; c=relaxed/simple;
	bh=Vf3z1qfbEome4NwI1SWR0g+Exr9R6/QcYuJPoBiwiNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yl9wtzno8DePqjfKDmhUwClWxasjsEbOo1AaZRXtYzta2nk8V/dwgZbuko50YxhPtqGjaWp/bctqcV1gMpa+Ysr5VIPOET+/uqnGKpa+bne5npUv++2fXkguAkseC1BnhggJJberDvBQLuAze9IAQXHpMsi6eSHTSQ+VJTXxBtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DJLNQrMR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DJLNQrMR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9D11F00ACA;
	Thu, 27 Aug 2026 12:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787835427;
	bh=sSYRnFPk4UwCr/qbuqpyEzHRuvD9HZ4VY5ayMlMBxfM=;
	h=From:To:Cc:Subject:Date;
	b=DJLNQrMRi5BEjjX+8CPQsYxl4pTdIzMsOGk35JDPQTPBDRRG6hDmCeTYrIYzWz+sF
	 Y35XTZnwnicrKmD/aVqlgkomj5uS5tLFiLplxPQUqajfCnz6GDLJ48lR6x05Ull1nB
	 uZ8shoJLsbK1H0qCfuIgZij2pDwBw8Pz6FYtoL7s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.106
Date: Thu, 27 Aug 2026 14:56:56 +0200
Message-ID: <2026082757-moonstone-headphone-2131@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.106 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                         |    2 
 drivers/block/null_blk/zoned.c                   |   10 +-
 drivers/bluetooth/hci_aml.c                      |   18 +++-
 drivers/gpio/gpio-ml-ioh.c                       |   36 ++++----
 drivers/gpu/drm/xe/display/xe_fb_pin.c           |   24 +----
 drivers/hid/hid-core.c                           |   11 ++
 drivers/hid/hid-hyperv.c                         |   27 +++++-
 drivers/hid/hid-input.c                          |    3 
 drivers/hid/hid-magicmouse.c                     |   64 ++++++++++++++-
 drivers/hid/hid-nintendo.c                       |   22 +++--
 drivers/hid/hid-sensor-custom.c                  |   17 ++-
 drivers/hwmon/pmbus/ltc4286.c                    |    2 
 drivers/input/keyboard/atkbd.c                   |   23 ++++-
 drivers/input/mouse/byd.c                        |    2 
 drivers/net/ethernet/google/gve/gve_rx_dqo.c     |    6 +
 drivers/net/ethernet/pensando/ionic/ionic_lif.c  |   17 +++
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c |    7 +
 drivers/net/ntb_netdev.c                         |   15 +--
 drivers/net/usb/rndis_host.c                     |    6 +
 drivers/nfc/fdp/i2c.c                            |   27 ++++++
 drivers/nfc/microread/microread.c                |   31 ++++++-
 drivers/nfc/pn533/pn533.c                        |    1 
 drivers/nfc/st21nfca/dep.c                       |    3 
 drivers/nvme/target/fabrics-cmd-auth.c           |    2 
 drivers/nvme/target/fc.c                         |    2 
 drivers/nvme/target/tcp.c                        |   18 +++-
 drivers/pci/controller/pci-host-generic.c        |   11 --
 drivers/pci/ecam.c                               |   13 +++
 drivers/tty/serial/8250/8250_of.c                |   41 +++++++++
 drivers/tty/serial/amba-pl011.c                  |    8 -
 drivers/tty/serial/sc16is7xx.c                   |   40 ++++-----
 fs/ext4/fast_commit.c                            |   16 ++-
 fs/ext4/xattr.c                                  |    7 +
 fs/netfs/buffered_read.c                         |    4 
 fs/netfs/read_collect.c                          |    2 
 fs/netfs/read_retry.c                            |    2 
 fs/ocfs2/xattr.c                                 |   18 ++--
 fs/xfs/libxfs/xfs_attr_leaf.c                    |   14 +++
 fs/xfs/libxfs/xfs_format.h                       |    4 
 fs/xfs/libxfs/xfs_log_recover.h                  |    4 
 fs/xfs/libxfs/xfs_refcount.c                     |   18 ++--
 fs/xfs/scrub/agheader.c                          |   96 ++++++++++++++++------
 fs/xfs/scrub/agheader_repair.c                   |   17 +++
 fs/xfs/scrub/refcount.c                          |    2 
 fs/xfs/scrub/refcount_repair.c                   |    4 
 fs/xfs/xfs_attr_item.c                           |   32 +++----
 fs/xfs/xfs_bmap_item.c                           |   18 ++--
 fs/xfs/xfs_buf_item.c                            |    8 -
 fs/xfs/xfs_buf_item.h                            |    2 
 fs/xfs/xfs_buf_item_recover.c                    |   95 ++++++++++++++--------
 fs/xfs/xfs_dquot_item_recover.c                  |   20 ++--
 fs/xfs/xfs_exchmaps_item.c                       |    8 -
 fs/xfs/xfs_extfree_item.c                        |   43 +++++-----
 fs/xfs/xfs_icreate_item.c                        |    2 
 fs/xfs/xfs_inode_item.c                          |    6 -
 fs/xfs/xfs_inode_item.h                          |    4 
 fs/xfs/xfs_inode_item_recover.c                  |   26 +++---
 fs/xfs/xfs_log_recover.c                         |   16 +--
 fs/xfs/xfs_refcount_item.c                       |   16 +--
 fs/xfs/xfs_rmap_item.c                           |   16 +--
 fs/xfs/xfs_trans.h                               |    1 
 include/linux/netfs.h                            |    2 
 include/linux/pci-ecam.h                         |    3 
 include/linux/sched.h                            |    8 +
 include/net/inet_frag.h                          |    6 -
 include/net/ipv6_frag.h                          |    5 -
 kernel/kcov.c                                    |   90 +++++++++++----------
 lib/Kconfig.debug                                |    5 -
 net/bluetooth/hci_event.c                        |    8 +
 net/bluetooth/iso.c                              |   30 +++++--
 net/bluetooth/rfcomm/core.c                      |   24 ++++-
 net/ceph/osd_client.c                            |    5 -
 net/core/gro.c                                   |    7 +
 net/ieee802154/6lowpan/reassembly.c              |   27 +++---
 net/ipv4/icmp.c                                  |    6 -
 net/ipv4/inet_fragment.c                         |   33 +++----
 net/ipv4/ip_fragment.c                           |   54 +++++-------
 net/ipv4/ip_output.c                             |    4 
 net/ipv4/ipmr.c                                  |    2 
 net/ipv4/route.c                                 |    4 
 net/ipv6/ip6_output.c                            |    2 
 net/ipv6/ndisc.c                                 |    8 -
 net/ipv6/netfilter/nf_conntrack_reasm.c          |   27 +++---
 net/ipv6/reassembly.c                            |   29 +++---
 net/mptcp/pm_netlink.c                           |    9 +-
 net/mptcp/pm_userspace.c                         |    7 -
 net/mptcp/protocol.c                             |    9 ++
 net/mptcp/protocol.h                             |    7 -
 net/nfc/digital_technology.c                     |    2 
 net/nfc/llcp_commands.c                          |   18 +++-
 net/nfc/llcp_core.c                              |   15 ++-
 net/nfc/nci/ntf.c                                |   10 +-
 net/nfc/nci/rsp.c                                |    1 
 net/xfrm/xfrm_state.c                            |    4 
 sound/drivers/dummy.c                            |    6 +
 sound/soc/codecs/lpass-tx-macro.c                |    4 
 sound/usb/mixer.c                                |    6 +
 sound/usb/mixer.h                                |    2 
 sound/usb/mixer_scarlett2.c                      |   98 ++++++++++++++---------
 99 files changed, 1079 insertions(+), 538 deletions(-)

Ali Ahmet Memis (2):
      Bluetooth: RFCOMM: take rfcomm_mutex for the deferred setup accept
      Bluetooth: ISO: do not force BT_LISTEN after a failed BIG sync

Anand Khoje (1):
      net/ionic: avoid OOB TX partner lookup for hwstamp RXQ

Andrei Fed (1):
      HID: magicmouse: fix battery reporting for Bluetooth Magic Trackpad USB-C

Baul Lee (1):
      HID: core: fix OOB read of field->usage in hid_set_field()

Bryam Vargas (2):
      nfc: fdp: bound the device-reported read length and fix an skb leak
      nvmet-auth: zero the AUTH_RECEIVE response buffer

Chengfeng Ye (1):
      Bluetooth: hci_event: fix LE list UAF on reset

Christoph Hellwig (1):
      xfs: don't use a xfs_log_iovec for ri_buf in log recovery

Christopher Kodama (1):
      HID: magicmouse: re-enable multitouch after reset-resume

Cryolitia PukNgae (1):
      Input: atkbd - skip deactivate for HONOR FMB-P's internal keyboard

Darrick J. Wong (3):
      xfs: namespace the maximum length/refcount symbols
      xfs: hoist per-bucket unlinked list check to helper
      xfs: don't livelock in scrub on a circular unlinked list

David Howells (1):
      netfs: Fix potential UAF in netfs_unlock_abandoned_read_pages()

Dawid Wróbel (1):
      ASoC: codecs: lpass-tx-macro: Fix enum kcontrol accesses

Donglin Lyu (1):
      Input: atkbd - skip deactivate for HONOR ZQC-P

Doruk Tan Ozturk (4):
      nfc: digital: clamp SENSF_RES length to the destination buffer
      nfc: llcp: bound the connect_sn TLV walk to the skb
      nfc: llcp: reject PDUs shorter than the LLCP header
      nfc: st21nfca: validate ATR_REQ length against the received frame

Eric Dumazet (7):
      inet: frags: add inet_frag_putn() helper
      ipv4: frags: remove ipq_put()
      inet: frags: change inet_frag_kill() to defer refcount updates
      inet: frags: save a pair of atomic operations in reassembly
      ndisc: ndisc_send_redirect() cleanup
      ipv4: start using dst_dev_rcu()
      net: gro: properly validate BIG TCP aggregation criteria

Fan Wu (1):
      serial: amba-pl011: synchronize DMA teardown

Geoffrey D. Bennett (1):
      ALSA: scarlett2: Use a private URB for the notification endpoint

Greg Kroah-Hartman (2):
      nvmet-tcp: Do not WARN on remotely-controlled oversized SGL allocations
      Linux 6.12.106

Griffin Kroah-Hartman (1):
      rndis_host: add overflow check in rndis_rx_fixup()

Guanghui Yang (2):
      ext4: clear error before retrying inode xattr space fallback
      ext4: propagate errors from fast commit range replay

Haoxiang Li (1):
      HID: sensor: custom: Fix use-after-free in enable_sensor

Hongling Zeng (1):
      xfs: validate attr entry pointer before field access

Hugo Villeneuve (2):
      serial: sc16is7xx: rename EFR mutex with generic name
      serial: sc16is7xx: use guards for simple mutex locks

Ian Bridges (1):
      ocfs2: fix missing metadata reservation for large xattrs

Ibrahim Hashimov (3):
      xfs: bounds-check buffer log item's dirty bitmap
      nvmet-tcp: bound SGL data length before allocating command buffers
      HID: nintendo: fix out-of-bounds read in joycon_ctlr_read_handler()

Jann Horn (1):
      HID: core: fix number/pointer type confusion on long items

Jiang HongHui (1):
      nvmet-fc: fix invalid free in LS IOD error path

Jiangshan Yi (2):
      HID: nintendo: register input device after capabilities are set
      HID: nintendo: stop device IO before hid_hw_stop on probe failure

Jordan Rhee (1):
      gve: fix zero-length skb frag with header-split

Jose Villaseñor Montfort (1):
      HID: magicmouse: do not keep a stale msc->input if no input is claimed

Junjie Cao (1):
      gpio: ml-ioh: use raw_spinlock_t for the register lock

Koichiro Den (1):
      NTB: ntb_netdev: Preserve RX queue depth on allocation failure

Laxman Acharya Padhya (2):
      Bluetooth: hci_event: validate LE Set CIG Parameters response
      Bluetooth: hci_aml: validate firmware segment lengths

Lee Jones (1):
      HID: magicmouse: Prevent out-of-bounds (OOB) read during DOUBLE_REPORT_ID

Linmao Li (2):
      nfc: nci: free destination parameters when closing a connection
      Input: byd - synchronize timer deletion before freeing private data

Luca Fresi (1):
      serial: sc16is7xx: enable THRI before filling TX FIFO

Luxiao Xu (1):
      ipv6: fix use-after-free in ip6_finish_output2()

Maarten Lankhorst (1):
      drm/xe: Fix DPT allocation paths.

Matthias Goergens (1):
      ext4: stop retrying saturated xattr cache entries

Michael Bommarito (1):
      HID: hyperv: validate initial device info bounds

Muhammad Bilal (1):
      nfc: llcp: fix OOB read and u8 offset wrap in TLV parsers

Nobuhiro Iwamatsu (1):
      hwmon: (ltc4286) Fix symbol namespace of MODULE_IMPORT_NS()

Pavitra Jha (1):
      libceph: fix OOB read in decode_watchers() via missing bounds check

Pengpeng Hou (1):
      nfc: microread: validate target discovery payload lengths

Qing Luo (1):
      mptcp: pm: fix data race in add_addr timer callback

Rik van Riel (1):
      null_blk: fix UBSAN shift-out-of-bounds when zone_size is 0 or overflows

Ryan Wilbur (1):
      serial: 8250_of: clear stuck empty-FIFO RX-timeout on LPC32xx

Samuel Page (2):
      nfc: nci: fix out-of-bounds write in nci_target_auto_activated()
      nfc: nci: fix uninit-value in the RF discover/activated NTF handlers

Shardul Bankar (1):
      mptcp: pm: fix memory leak from alloc-during-teardown race

Steffen Persvold (1):
      PCI: host-generic: Fix NULL pointer dereference on 32-bit CAM systems

Takashi Iwai (1):
      ALSA: dummy: Check card index validity at probe

Tetsuo Handa (1):
      kcov: fix data corruption and race conditions on PREEMPT_RT

Xiang Mei (Microsoft) (1):
      xfrm: fix sk_dst_cache double-free in xfrm_user_policy()

Xu Rao (1):
      nfc: pn533: purge fragmented skbs during cleanup

Yong Wang (1):
      ipv4: reject undersized MTUs in ip_do_fragment()

Zhiling Zou (1):
      inet: frags: publish queues before arming timer

