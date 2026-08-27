Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2747D3CDBA5;
	Thu, 27 Aug 2026 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835421; cv=none; b=LjiUoEZSCQNBLaet0Et5VMfDU3EDnGi87YLBtDXOcsiWMp/WFNsF+KY1TeQwwsC2uZraNvuN1zdaKlAH621QYkEg51EsofTae+rnK38t5DSIxu5GBq1FvpEnHu1xsN7vnXmlEY6QloCNetmI1nF3/LEhk5dbm2GG5M+rsL+YQT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835421; c=relaxed/simple;
	bh=9IqA/KbzrccCn+tjh1EsdNv1HQohQzfg+FPvlG9E4JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E8RpqpqcgmIJso+y3QspkZkw8e7CjYCrpz0HU88iQ6RXIP2QPcCo6hu8IBdsZDpCldP/kh0YtxPXvYaew09PHGtEcTFLrVaYiKPKqRKnfoD4SmLDJE//MyRIZ3ikD+/WuL+yT0qGHELwx7EJ3GoOcrWcgd1NExOAfiivXryPM6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DA0qP1e1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DA0qP1e1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FD41F00A3D;
	Thu, 27 Aug 2026 12:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787835400;
	bh=oyXsisxI2IP3mGw0SesI3sSruwukyrRVN0SIIaC4C/A=;
	h=From:To:Cc:Subject:Date;
	b=DA0qP1e1oGJHSycQOgmhXewS/Qv9Qc56oyP4p7cENTYEn17c/kR03GVNF4axn8Bil
	 gs4Avi7i34uRIiz7eRyxxJwgqfG9Fx7xLhAWQ1W1e+QTenBhT3pl+BjFGYGE5SEpyh
	 47qxrKQGuDQw/0onFKbGgqcpWAIi5jNThIp3s6UI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.267
Date: Thu, 27 Aug 2026 14:56:36 +0200
Message-ID: <2026082737-chaos-crabbing-187d@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.267 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                       |    2 
 arch/arm64/kvm/mmu.c                           |   42 +--
 drivers/gpio/gpio-ml-ioh.c                     |   36 +-
 drivers/hid/hid-core.c                         |   11 
 drivers/hid/hid-hyperv.c                       |   27 +-
 drivers/hid/hid-magicmouse.c                   |   16 +
 drivers/hid/hid-sensor-custom.c                |   17 -
 drivers/input/misc/ims-pcu.c                   |    2 
 drivers/misc/fastrpc.c                         |  110 +++++---
 drivers/net/can/dev/dev.c                      |    2 
 drivers/net/can/slcan.c                        |    1 
 drivers/net/ntb_netdev.c                       |   15 -
 drivers/net/usb/rndis_host.c                   |    6 
 drivers/nfc/fdp/i2c.c                          |   27 ++
 drivers/nfc/microread/microread.c              |   31 ++
 drivers/nfc/pn533/pn533.c                      |    1 
 drivers/nfc/st21nfca/dep.c                     |    3 
 drivers/nvme/target/fc.c                       |    2 
 drivers/nvme/target/tcp.c                      |    5 
 drivers/s390/cio/vfio_ccw_cp.c                 |   22 +
 drivers/s390/cio/vfio_ccw_drv.c                |    7 
 drivers/s390/cio/vfio_ccw_ops.c                |    8 
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c |    3 
 drivers/tty/serial/amba-pl011.c                |    8 
 fs/ext4/xattr.c                                |    7 
 fs/iomap/buffered-io.c                         |   19 +
 fs/ocfs2/xattr.c                               |   18 -
 fs/xfs/libxfs/xfs_attr_leaf.c                  |   14 +
 fs/xfs/xfs_buf_item_recover.c                  |   53 ++--
 fs/xfs/xfs_dquot.c                             |    3 
 include/linux/can/core.h                       |    1 
 include/linux/can/dev.h                        |    1 
 include/linux/can/skb.h                        |    2 
 include/linux/netdevice.h                      |    6 
 include/net/sch_generic.h                      |    1 
 kernel/events/core.c                           |  104 ++++----
 mm/huge_memory.c                               |   46 ++-
 net/bluetooth/rfcomm/core.c                    |   24 +
 net/can/af_can.c                               |   14 -
 net/can/bcm.c                                  |    2 
 net/can/isotp.c                                |  320 +++++++++++++++++--------
 net/can/j1939/socket.c                         |    1 
 net/can/j1939/transport.c                      |    2 
 net/can/raw.c                                  |    7 
 net/ceph/osd_client.c                          |    5 
 net/ipv4/fib_lookup.h                          |    1 
 net/ipv4/fib_semantics.c                       |   69 +++--
 net/ipv4/inet_fragment.c                       |    6 
 net/ipv4/ip_output.c                           |    4 
 net/ipv6/ip6_output.c                          |    2 
 net/nfc/digital_technology.c                   |    2 
 net/nfc/llcp_commands.c                        |   18 +
 net/nfc/llcp_core.c                            |   15 -
 net/nfc/nci/ntf.c                              |    6 
 net/nfc/nci/rsp.c                              |    1 
 net/packet/af_packet.c                         |   65 +++--
 net/sched/sch_api.c                            |    9 
 net/x25/af_x25.c                               |    4 
 net/x25/x25_timer.c                            |   25 +
 net/xfrm/xfrm_state.c                          |    4 
 sound/aoa/codecs/onyx.c                        |  104 +++++---
 sound/aoa/codecs/tas.c                         |  113 +++++---
 sound/aoa/core/gpio-feature.c                  |   20 +
 sound/aoa/core/gpio-pmf.c                      |   26 +-
 sound/aoa/soundbus/i2sbus/pcm.c                |   75 +++--
 tools/lib/bpf/libbpf.c                         |    2 
 66 files changed, 1127 insertions(+), 498 deletions(-)

Abel Vesa (1):
      misc: fastrpc: Rework fastrpc_req_munmap

Aditya Chillara (1):
      perf/core: Fix group leader use-after-free after sibling detach

Ali Ahmet Memis (1):
      Bluetooth: RFCOMM: take rfcomm_mutex for the deferred setup accept

Amit Cohen (1):
      net: ipv4: Publish fib_nlmsg_size()

Baul Lee (2):
      net/x25: fix use-after-free of the socket by its timers
      HID: core: fix OOB read of field->usage in hid_set_field()

Bryam Vargas (1):
      nfc: fdp: bound the device-reported read length and fix an skb leak

David Matlack (1):
      KVM: arm64: Retry fault if vma_lookup() results become invalid

Doruk Tan Ozturk (4):
      nfc: digital: clamp SENSF_RES length to the destination buffer
      nfc: llcp: bound the connect_sn TLV walk to the skb
      nfc: llcp: reject PDUs shorter than the LLCP header
      nfc: st21nfca: validate ATR_REQ length against the received frame

Ekansh Gupta (1):
      misc: fastrpc: Remove buffer from list prior to unmap operation

Eric Farman (2):
      s390/vfio_ccw: Cancel existing workqueues
      s390/vfio_ccw: Free all memory if cp_init() fails

Fan Wu (1):
      serial: amba-pl011: synchronize DMA teardown

Greg Kroah-Hartman (2):
      nvmet-tcp: Do not WARN on remotely-controlled oversized SGL allocations
      Linux 5.10.267

Griffin Kroah-Hartman (1):
      rndis_host: add overflow check in rndis_rx_fixup()

Guanghui Yang (1):
      ext4: clear error before retrying inode xattr space fallback

Haoxiang Li (1):
      HID: sensor: custom: Fix use-after-free in enable_sensor

Hongling Zeng (1):
      xfs: validate attr entry pointer before field access

Ian Bridges (1):
      ocfs2: fix missing metadata reservation for large xattrs

Ibrahim Hashimov (1):
      xfs: bounds-check buffer log item's dirty bitmap

Jann Horn (1):
      HID: core: fix number/pointer type confusion on long items

Jiang HongHui (1):
      nvmet-fc: fix invalid free in LS IOD error path

Joanne Koong (1):
      iomap: adjust read range correctly for non-block-aligned positions

Junjie Cao (1):
      gpio: ml-ioh: use raw_spinlock_t for the register lock

Koichiro Den (1):
      NTB: ntb_netdev: Preserve RX queue depth on allocation failure

Lee Jones (1):
      HID: magicmouse: Prevent out-of-bounds (OOB) read during DOUBLE_REPORT_ID

Linmao Li (1):
      nfc: nci: free destination parameters when closing a connection

Long Li (1):
      xfs: fix ilock leak on error in xfs_dq_get_next_id

Lorenzo Stoakes (ARM) (1):
      mm/huge_memory: fix huge_zero_pfn race

Luxiao Xu (1):
      ipv6: fix use-after-free in ip6_finish_output2()

Matthias Goergens (1):
      ext4: stop retrying saturated xattr cache entries

Michael Bommarito (1):
      HID: hyperv: validate initial device info bounds

Muhammad Bilal (2):
      staging: rtl8723bs: fix OOB read in WMM_param_handler()
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

Samuel Page (1):
      nfc: nci: fix out-of-bounds write in nci_target_auto_activated()

Sasha Levin (2):
      Revert "Input: ims-pcu - fix race condition in reset_device sysfs callback"
      Revert "ALSA: aoa: Use guard() for mutex locks"

Srinivas Kandagatla (1):
      misc: fastrpc: separate fastrpc device from channel context

Weiming Shi (1):
      bpf: reject negative CO-RE accessor indices in bpf_core_parse_spec()

Xiang Mei (Microsoft) (1):
      xfrm: fix sk_dst_cache double-free in xfrm_user_policy()

Xu Rao (1):
      nfc: pn533: purge fragmented skbs during cleanup

Yeoreum Yun (1):
      perf: Fix dangling cgroup pointer in cpuctx

Yong Wang (1):
      ipv4: reject undersized MTUs in ip_do_fragment()

Zhiling Zou (1):
      inet: frags: publish queues before arming timer

Zihan Xi (2):
      ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops
      packet: synchronize pressure clearing with ring reconfiguration

Zijie Huang (1):
      net/sched: reject overly deep qdisc hierarchies

