Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD2D37B021;
	Thu, 27 Aug 2026 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835437; cv=none; b=SJ39/zgqkJ/V5UYdPiRaBhMRbJasah77/vRaHkXIR9+w2lYxB2QByCOR42pA02A1vcTDZv8zXojTO93QhmzvqK408C1QOw21YBYNNgw61X7tNbwx4Kfxi4k8L3unvz8SwJpLptvYq8HPGKApfY3XxTCkjhptsSx/tR4J4XAJ57Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835437; c=relaxed/simple;
	bh=x1tiMiFhmDvvEfs3q8j23Dv5gUCJ2A8ug7nrfARhzno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b4wtfnbBE+C97oxrkSxisg3WZ8d7kqTPKzFd7/hLO6vkx6UfbsW+SYaMfz2FFk95zBAMd2t44lmId7pBfOxHic2aa4grpeMdi8ajh1fQ7A22Q/iEkSjvgYN1pLDOpFEhO4DiP1jmNLn2cZvz/WQIPMIySuQf6q9UoBjQ24zuQzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N1mJLcz/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N1mJLcz/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DEC1F00AC4;
	Thu, 27 Aug 2026 12:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787835420;
	bh=H5DuQOzNgTE7rg21yRFQfOlscwsiRrC+hQDEFXrTqC4=;
	h=From:To:Cc:Subject:Date;
	b=N1mJLcz//5gXB+rqOCcxO4IH5Yts7M0SGIQtBxH/juRpX/WN87oPQV/j5nImN4fF9
	 Hm0IhVUHEk4xFg4k7vE+FMXaywPy3NHzCnAj5q9Vy6//nK1yC57k90QIpIeVauuSd6
	 gISI9S6t8+VIvsTFnSVlgtaC/l5lheSViHzpToIc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.185
Date: Thu, 27 Aug 2026 14:56:48 +0200
Message-ID: <2026082749-result-curdle-9a05@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.185 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                   |    2 
 drivers/block/null_blk/zoned.c             |   10 
 drivers/gpio/gpio-ml-ioh.c                 |   36 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   50 ++++
 drivers/hid/hid-core.c                     |   11 
 drivers/hid/hid-hyperv.c                   |   27 ++
 drivers/hid/hid-magicmouse.c               |   26 ++
 drivers/hid/hid-nintendo.c                 |    7 
 drivers/hid/hid-sensor-custom.c            |   17 -
 drivers/input/keyboard/atkbd.c             |   23 +-
 drivers/input/mouse/byd.c                  |    2 
 drivers/misc/fastrpc.c                     |   64 +++--
 drivers/net/can/dev/skb.c                  |    2 
 drivers/net/ntb_netdev.c                   |   15 -
 drivers/net/usb/rndis_host.c               |    6 
 drivers/nfc/fdp/i2c.c                      |   27 ++
 drivers/nfc/microread/microread.c          |   31 ++
 drivers/nfc/pn533/pn533.c                  |    1 
 drivers/nfc/st21nfca/dep.c                 |    3 
 drivers/nvme/target/fabrics-cmd-auth.c     |    2 
 drivers/nvme/target/fc.c                   |    2 
 drivers/nvme/target/tcp.c                  |    5 
 drivers/pci/controller/pci-host-generic.c  |   11 
 drivers/pci/ecam.c                         |   13 +
 drivers/s390/cio/vfio_ccw_chp.c            |   26 +-
 drivers/s390/cio/vfio_ccw_cp.c             |   30 ++
 drivers/s390/cio/vfio_ccw_drv.c            |   26 ++
 drivers/s390/cio/vfio_ccw_fsm.c            |    8 
 drivers/s390/cio/vfio_ccw_ops.c            |   27 ++
 drivers/s390/cio/vfio_ccw_private.h        |    9 
 drivers/tty/serial/amba-pl011.c            |    8 
 drivers/tty/serial/sc16is7xx.c             |  222 ++++++++++----------
 fs/ext4/xattr.c                            |    7 
 fs/iomap/buffered-io.c                     |   19 +
 fs/ocfs2/xattr.c                           |   18 +
 fs/xfs/libxfs/xfs_attr_leaf.c              |   14 +
 fs/xfs/libxfs/xfs_log_recover.h            |    4 
 fs/xfs/xfs_attr_item.c                     |   24 +-
 fs/xfs/xfs_bmap_item.c                     |   18 -
 fs/xfs/xfs_buf_item.c                      |    8 
 fs/xfs/xfs_buf_item.h                      |    2 
 fs/xfs/xfs_buf_item_recover.c              |   91 +++++---
 fs/xfs/xfs_dquot_item_recover.c            |   20 -
 fs/xfs/xfs_extfree_item.c                  |   43 ++-
 fs/xfs/xfs_icreate_item.c                  |    2 
 fs/xfs/xfs_inode_item.c                    |    6 
 fs/xfs/xfs_inode_item.h                    |    4 
 fs/xfs/xfs_inode_item_recover.c            |   26 +-
 fs/xfs/xfs_log_recover.c                   |   16 -
 fs/xfs/xfs_refcount_item.c                 |   16 -
 fs/xfs/xfs_rmap_item.c                     |   16 -
 fs/xfs/xfs_trans.h                         |    1 
 include/linux/can/core.h                   |    1 
 include/linux/can/skb.h                    |    2 
 include/linux/netdevice.h                  |    6 
 include/linux/pci-ecam.h                   |    3 
 include/linux/sched.h                      |    8 
 include/net/tls.h                          |    3 
 kernel/events/core.c                       |  121 +++++-----
 kernel/kcov.c                              |   90 ++++----
 lib/Kconfig.debug                          |    5 
 net/bluetooth/hci_event.c                  |    2 
 net/bluetooth/rfcomm/core.c                |   24 +-
 net/can/af_can.c                           |   14 -
 net/can/bcm.c                              |    2 
 net/can/isotp.c                            |  320 ++++++++++++++++++++---------
 net/can/j1939/socket.c                     |    1 
 net/can/j1939/transport.c                  |    2 
 net/can/raw.c                              |    7 
 net/ceph/osd_client.c                      |    5 
 net/core/gro.c                             |    3 
 net/ipv4/inet_fragment.c                   |    6 
 net/ipv4/ip_output.c                       |    4 
 net/ipv6/ip6_output.c                      |    2 
 net/ipv6/ndisc.c                           |    8 
 net/mptcp/pm_netlink.c                     |   36 +--
 net/nfc/digital_technology.c               |    2 
 net/nfc/llcp_commands.c                    |   18 +
 net/nfc/llcp_core.c                        |   15 -
 net/nfc/nci/ntf.c                          |   10 
 net/nfc/nci/rsp.c                          |    1 
 net/packet/af_packet.c                     |   79 ++++---
 net/packet/internal.h                      |    2 
 net/tls/tls.h                              |    4 
 net/tls/tls_strp.c                         |   17 -
 net/tls/tls_sw.c                           |    3 
 net/xfrm/xfrm_state.c                      |    4 
 sound/drivers/dummy.c                      |    6 
 sound/soc/codecs/lpass-tx-macro.c          |    4 
 90 files changed, 1280 insertions(+), 668 deletions(-)

Abel Vesa (1):
      misc: fastrpc: Rework fastrpc_req_munmap

Aditya Chillara (1):
      perf/core: Fix group leader use-after-free after sibling detach

Ali Ahmet Memis (1):
      Bluetooth: RFCOMM: take rfcomm_mutex for the deferred setup accept

Baul Lee (1):
      HID: core: fix OOB read of field->usage in hid_set_field()

Bryam Vargas (2):
      nfc: fdp: bound the device-reported read length and fix an skb leak
      nvmet-auth: zero the AUTH_RECEIVE response buffer

Chengfeng Ye (1):
      Bluetooth: hci_event: fix LE list UAF on reset

Christoph Hellwig (1):
      xfs: don't use a xfs_log_iovec for ri_buf in log recovery

Cryolitia PukNgae (1):
      Input: atkbd - skip deactivate for HONOR FMB-P's internal keyboard

Dawid Wróbel (1):
      ASoC: codecs: lpass-tx-macro: Fix enum kcontrol accesses

Donglin Lyu (1):
      Input: atkbd - skip deactivate for HONOR ZQC-P

Doruk Tan Ozturk (4):
      nfc: digital: clamp SENSF_RES length to the destination buffer
      nfc: llcp: bound the connect_sn TLV walk to the skb
      nfc: llcp: reject PDUs shorter than the LLCP header
      nfc: st21nfca: validate ATR_REQ length against the received frame

Ekansh Gupta (1):
      misc: fastrpc: Remove buffer from list prior to unmap operation

Eric Dumazet (3):
      net/packet: convert po->pressure to an atomic flag
      ndisc: ndisc_send_redirect() cleanup
      net: gro: properly validate BIG TCP aggregation criteria

Eric Farman (5):
      s390/vfio_ccw: Cancel existing workqueues
      s390/vfio_ccw: Move cp cleanup out of not operational
      s390/vfio_ccw: Selectively expand io_mutex
      s390/vfio_ccw: Implement a crw lock
      s390/vfio_ccw: Free all memory if cp_init() fails

Fan Wu (1):
      serial: amba-pl011: synchronize DMA teardown

Greg Kroah-Hartman (2):
      nvmet-tcp: Do not WARN on remotely-controlled oversized SGL allocations
      Linux 6.1.185

Griffin Kroah-Hartman (1):
      rndis_host: add overflow check in rndis_rx_fixup()

Guanghui Yang (1):
      ext4: clear error before retrying inode xattr space fallback

Haoxiang Li (1):
      HID: sensor: custom: Fix use-after-free in enable_sensor

Hongling Zeng (1):
      xfs: validate attr entry pointer before field access

Hugo Villeneuve (2):
      serial: sc16is7xx: rename EFR mutex with generic name
      serial: sc16is7xx: use guards for simple mutex locks

Ian Bridges (1):
      ocfs2: fix missing metadata reservation for large xattrs

Ibrahim Hashimov (2):
      xfs: bounds-check buffer log item's dirty bitmap
      HID: nintendo: fix out-of-bounds read in joycon_ctlr_read_handler()

Jakub Kicinski (1):
      tls: handle data disappearing from under the TLS ULP

Jann Horn (1):
      HID: core: fix number/pointer type confusion on long items

Jiang HongHui (1):
      nvmet-fc: fix invalid free in LS IOD error path

Joanne Koong (1):
      iomap: adjust read range correctly for non-block-aligned positions

Jose Villaseñor Montfort (1):
      HID: magicmouse: do not keep a stale msc->input if no input is claimed

Junjie Cao (1):
      gpio: ml-ioh: use raw_spinlock_t for the register lock

Junrui Luo (1):
      drm/amdgpu: disallow multiple FENCE chunks in one submit

Koichiro Den (1):
      NTB: ntb_netdev: Preserve RX queue depth on allocation failure

Lech Perczak (2):
      serial: sc16is7xx: fix copy-paste errors in EFR_SWFLOWx_BIT constants
      serial: sc16is7xx: convert bitmask definitions to use BIT() macro

Lee Jones (1):
      HID: magicmouse: Prevent out-of-bounds (OOB) read during DOUBLE_REPORT_ID

Linmao Li (2):
      nfc: nci: free destination parameters when closing a connection
      Input: byd - synchronize timer deletion before freeing private data

Luca Fresi (1):
      serial: sc16is7xx: enable THRI before filling TX FIFO

Luxiao Xu (1):
      ipv6: fix use-after-free in ip6_finish_output2()

Matthias Goergens (1):
      ext4: stop retrying saturated xattr cache entries

Matthieu Baerts (NGI0) (2):
      mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
      mptcp: pm: ADD_ADDR rtx: free sk if last

Michael Bommarito (1):
      HID: hyperv: validate initial device info bounds

Muhammad Bilal (1):
      nfc: llcp: fix OOB read and u8 offset wrap in TLV parsers

Oliver Hartkopp (2):
      can: use skb hash instead of private variable in headroom
      can: isotp: fix timer drain order, wakeup handling and tx_gen ordering

Pavitra Jha (1):
      libceph: fix OOB read in decode_watchers() via missing bounds check

Pengpeng Hou (1):
      nfc: microread: validate target discovery payload lengths

Peter Zijlstra (1):
      perf: Fix cgroup state vs ERROR

Qihang Tang (2):
      packet: use consistent hard_header_len in non-ring send paths
      packet: use consistent hard_header_len in TX_RING send path

Qing Luo (1):
      mptcp: pm: fix data race in add_addr timer callback

Rik van Riel (1):
      null_blk: fix UBSAN shift-out-of-bounds when zone_size is 0 or overflows

Sabrina Dubroca (1):
      tls: fix lockless read of strp->msg_ready in ->poll

Samuel Page (2):
      nfc: nci: fix out-of-bounds write in nci_target_auto_activated()
      nfc: nci: fix uninit-value in the RF discover/activated NTF handlers

Steffen Persvold (1):
      PCI: host-generic: Fix NULL pointer dereference on 32-bit CAM systems

Sukrut Bellary (1):
      misc: fastrpc: Fix double free of 'buf' in error path

Takashi Iwai (1):
      ALSA: dummy: Check card index validity at probe

Tetsuo Handa (1):
      kcov: fix data corruption and race conditions on PREEMPT_RT

Xiang Mei (Microsoft) (1):
      xfrm: fix sk_dst_cache double-free in xfrm_user_policy()

Xu Rao (1):
      nfc: pn533: purge fragmented skbs during cleanup

Yang Wang (1):
      drm/amdgpu: check ASPM on the dGPU host link

Yeoreum Yun (2):
      perf/core: Fix child_total_time_enabled accounting bug at task exit
      perf: Fix dangling cgroup pointer in cpuctx

Yong Wang (1):
      ipv4: reject undersized MTUs in ip_do_fragment()

Zhiling Zou (1):
      inet: frags: publish queues before arming timer

Zihan Xi (1):
      packet: synchronize pressure clearing with ring reconfiguration

