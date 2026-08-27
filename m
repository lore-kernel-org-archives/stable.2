Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D93A44E651;
	Thu, 27 Aug 2026 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835458; cv=none; b=CCKtjahPJ1iR4LQyxsW363/X6XGfKUu99SJl+QHXl8bNaPFxMTAqwIRtTyWSigBaW4WIHI07EbZPQCLWOHaB63INxLZyiNWzi9wcUYoEN1iEJ2T0Rpa7qkozeZIuxCRqkr5lVrU7vSkkamImAGraaavCGGHJ95/cPzvIX/OPNns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835458; c=relaxed/simple;
	bh=emV+Wj0wzIcBY4Rk1CMW2bc2H7NSxl5QNUKuQzWJErE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KtAyCV8hfAQyns0RdFCKx+8ifGIkgWVxeIb+BUhn/+un0z9Op39+7xp6nc+w4XhxyMw5TiMDhTvqOSKaVFdpGbtH+wfPmURU8a1F/wLlMGhtCKde4C2y3MCexhSP1aYFsvCLmHl4Yzp+XJ7xniF6e12vZIhV4a1HrFIhW7B2lng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yAH/QNVy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yAH/QNVy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B88F1F00ACF;
	Thu, 27 Aug 2026 12:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787835436;
	bh=kQ4sFS8n7JmeyXEuxU8yyYbzjI4m4gpMa0meWWHzVUs=;
	h=From:To:Cc:Subject:Date;
	b=yAH/QNVywsx6n1c51G9DofAoYMp/W+R4d1WvN29qBKikai0KIjL9BpQZJpJ/X2NCY
	 oKBJVXD1jHa74GjY/N7IyFIUp7O+2nVfWaoE4DIMPsK5NQEduVtMfanoj2Z1U9WQhn
	 m5/v1CRSrfHLrZakTHhFuPGfbBVyiYyDpSJNTmAs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.154
Date: Thu, 27 Aug 2026 14:57:05 +0200
Message-ID: <2026082706-monstrous-wrench-bcd5@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.154 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                           |    2 
 drivers/block/null_blk/zoned.c                                     |   10 
 drivers/gpio/gpio-ml-ioh.c                                         |   36 -
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                                |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                         |  100 ++++
 drivers/gpu/drm/amd/amdgpu/nv.c                                    |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                  |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c          |    2 
 drivers/gpu/drm/amd/display/dc/basics/dc_common.c                  |    3 
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c              |   34 -
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                  |    4 
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h                       |    4 
 drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c            |    3 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c        |    3 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c |    3 
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h                        |    6 
 drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c      |    4 
 drivers/hid/hid-core.c                                             |   11 
 drivers/hid/hid-hyperv.c                                           |   27 +
 drivers/hid/hid-input.c                                            |    3 
 drivers/hid/hid-magicmouse.c                                       |   45 +-
 drivers/hid/hid-nintendo.c                                         |    7 
 drivers/hid/hid-sensor-custom.c                                    |   17 
 drivers/input/keyboard/atkbd.c                                     |   23 -
 drivers/input/mouse/byd.c                                          |    2 
 drivers/net/ntb_netdev.c                                           |   15 
 drivers/net/usb/rndis_host.c                                       |    6 
 drivers/nfc/fdp/i2c.c                                              |   27 +
 drivers/nfc/microread/microread.c                                  |   31 +
 drivers/nfc/pn533/pn533.c                                          |    1 
 drivers/nfc/st21nfca/dep.c                                         |    3 
 drivers/nvme/target/fabrics-cmd-auth.c                             |    2 
 drivers/nvme/target/fc.c                                           |    2 
 drivers/nvme/target/tcp.c                                          |    5 
 drivers/pci/controller/pci-host-generic.c                          |   11 
 drivers/pci/ecam.c                                                 |   13 
 drivers/s390/cio/vfio_ccw_chp.c                                    |   26 -
 drivers/s390/cio/vfio_ccw_cp.c                                     |   43 +
 drivers/s390/cio/vfio_ccw_cp.h                                     |    2 
 drivers/s390/cio/vfio_ccw_drv.c                                    |    6 
 drivers/s390/cio/vfio_ccw_ops.c                                    |    4 
 drivers/s390/cio/vfio_ccw_private.h                                |    4 
 drivers/tty/serial/amba-pl011.c                                    |    8 
 drivers/tty/serial/qcom_geni_serial.c                              |   51 +-
 drivers/tty/serial/sc16is7xx.c                                     |  222 +++++-----
 fs/ext4/xattr.c                                                    |    7 
 fs/ocfs2/xattr.c                                                   |   18 
 fs/xfs/libxfs/xfs_attr_leaf.c                                      |   14 
 fs/xfs/libxfs/xfs_log_recover.h                                    |    4 
 fs/xfs/xfs_attr_item.c                                             |   24 -
 fs/xfs/xfs_bmap_item.c                                             |   18 
 fs/xfs/xfs_buf_item.c                                              |    8 
 fs/xfs/xfs_buf_item.h                                              |    2 
 fs/xfs/xfs_buf_item_recover.c                                      |   95 ++--
 fs/xfs/xfs_dquot_item_recover.c                                    |   20 
 fs/xfs/xfs_extfree_item.c                                          |   43 +
 fs/xfs/xfs_icreate_item.c                                          |    2 
 fs/xfs/xfs_inode_item.c                                            |    6 
 fs/xfs/xfs_inode_item.h                                            |    4 
 fs/xfs/xfs_inode_item_recover.c                                    |   26 -
 fs/xfs/xfs_log_recover.c                                           |   16 
 fs/xfs/xfs_refcount_item.c                                         |   16 
 fs/xfs/xfs_rmap_item.c                                             |   16 
 fs/xfs/xfs_trans.h                                                 |    1 
 include/linux/pci-ecam.h                                           |    3 
 include/linux/sched.h                                              |    8 
 include/net/inet_frag.h                                            |    6 
 include/net/ipv6_frag.h                                            |    5 
 kernel/events/core.c                                               |  161 ++-----
 kernel/kcov.c                                                      |   90 ++--
 lib/Kconfig.debug                                                  |    5 
 net/bluetooth/hci_event.c                                          |    8 
 net/bluetooth/hci_sync.c                                           |  133 ++++-
 net/bluetooth/rfcomm/core.c                                        |   24 -
 net/ceph/osd_client.c                                              |    5 
 net/core/gro.c                                                     |    7 
 net/ieee802154/6lowpan/reassembly.c                                |   27 -
 net/ipv4/inet_fragment.c                                           |   33 -
 net/ipv4/ip_fragment.c                                             |   48 --
 net/ipv4/ip_output.c                                               |    4 
 net/ipv6/ip6_output.c                                              |    2 
 net/ipv6/ndisc.c                                                   |    8 
 net/ipv6/netfilter/nf_conntrack_reasm.c                            |   27 -
 net/ipv6/reassembly.c                                              |   29 -
 net/mptcp/pm_netlink.c                                             |    9 
 net/mptcp/pm_userspace.c                                           |    7 
 net/mptcp/protocol.c                                               |    9 
 net/mptcp/protocol.h                                               |    7 
 net/nfc/digital_technology.c                                       |    2 
 net/nfc/llcp_commands.c                                            |   18 
 net/nfc/llcp_core.c                                                |   15 
 net/nfc/nci/ntf.c                                                  |   10 
 net/nfc/nci/rsp.c                                                  |    1 
 net/xfrm/xfrm_state.c                                              |    4 
 sound/drivers/dummy.c                                              |    6 
 sound/soc/codecs/lpass-tx-macro.c                                  |    4 
 sound/soc/sof/ipc3-pcm.c                                           |   13 
 sound/soc/sof/ipc3-topology.c                                      |   20 
 sound/soc/sof/ipc4-pcm.c                                           |   35 +
 sound/soc/sof/ipc4-topology.c                                      |   18 
 sound/soc/sof/pcm.c                                                |  157 ++++---
 sound/soc/sof/sof-audio.c                                          |   36 -
 sound/soc/sof/sof-audio.h                                          |   17 
 103 files changed, 1372 insertions(+), 830 deletions(-)

Aditya Chillara (1):
      perf/core: Fix group leader use-after-free after sibling detach

Ali Ahmet Memis (1):
      Bluetooth: RFCOMM: take rfcomm_mutex for the deferred setup accept

Andrei Fed (1):
      HID: magicmouse: fix battery reporting for Bluetooth Magic Trackpad USB-C

Baul Lee (1):
      HID: core: fix OOB read of field->usage in hid_set_field()

Bryam Vargas (2):
      nfc: fdp: bound the device-reported read length and fix an skb leak
      nvmet-auth: zero the AUTH_RECEIVE response buffer

Chengfeng Ye (2):
      Bluetooth: hci_sync: Fix advertising data UAFs
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

Eric Dumazet (6):
      inet: frags: add inet_frag_putn() helper
      ipv4: frags: remove ipq_put()
      inet: frags: change inet_frag_kill() to defer refcount updates
      inet: frags: save a pair of atomic operations in reassembly
      ndisc: ndisc_send_redirect() cleanup
      net: gro: properly validate BIG TCP aggregation criteria

Eric Farman (4):
      s390/vfio_ccw: Free all memory if cp_init() fails
      s390/vfio_ccw: Ensure first IDAW remains constant
      s390/vfio_ccw: Calculate idal length based on idaw type
      s390/vfio_ccw: Implement a crw lock

Fan Wu (1):
      serial: amba-pl011: synchronize DMA teardown

Greg Kroah-Hartman (2):
      nvmet-tcp: Do not WARN on remotely-controlled oversized SGL allocations
      Linux 6.6.154

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

Ilya Bakoulin (1):
      drm/amd/display: Fix BT2020 YCbCr limited/full range input

Jan Sebastian Götte (1):
      serial: qcom-geni: fix TX DMA buffer flush

Jann Horn (1):
      HID: core: fix number/pointer type confusion on long items

Jiang HongHui (1):
      nvmet-fc: fix invalid free in LS IOD error path

Jose Villaseñor Montfort (1):
      HID: magicmouse: do not keep a stale msc->input if no input is claimed

Junjie Cao (1):
      gpio: ml-ioh: use raw_spinlock_t for the register lock

Kenneth Feng (1):
      drm/amd/amdgpu: disable ASPM in some situations

Koichiro Den (1):
      NTB: ntb_netdev: Preserve RX queue depth on allocation failure

Kuninori Morimoto (1):
      ASoC: sof: pcm: use snd_pcm_direction_name()

Laxman Acharya Padhya (1):
      Bluetooth: hci_event: validate LE Set CIG Parameters response

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

Michael Bommarito (1):
      HID: hyperv: validate initial device info bounds

Muhammad Bilal (1):
      nfc: llcp: fix OOB read and u8 offset wrap in TLV parsers

Nathan Lucas (1):
      drm/amd/display: fix BT.2020 YCbCr limited output CSC matrix

Pavitra Jha (1):
      libceph: fix OOB read in decode_watchers() via missing bounds check

Pengpeng Hou (1):
      nfc: microread: validate target discovery payload lengths

Peter Ujfalusi (4):
      ASoC: SOF: Relocate and rework functionality for PCM stream freeing
      ASoC: SOF: pcm: Move period/buffer configuration print after platform open
      ASoC: SOF: pcm: Add snd_sof_pcm specific wrappers for dev_dbg() and dev_err()
      ASoC: SOF: ipc4-pcm: Continue the pipeline trigger in case of IPC timeout

Peter Zijlstra (1):
      perf: Unify perf_event_free_task() / perf_event_exit_task_context()

Qing Luo (1):
      mptcp: pm: fix data race in add_addr timer callback

Rik van Riel (1):
      null_blk: fix UBSAN shift-out-of-bounds when zone_size is 0 or overflows

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

Yang Wang (1):
      drm/amdgpu: check ASPM on the dGPU host link

Yong Wang (1):
      ipv4: reject undersized MTUs in ip_do_fragment()

Zhiling Zou (1):
      inet: frags: publish queues before arming timer

