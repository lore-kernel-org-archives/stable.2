Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3E7368291;
	Thu, 27 Aug 2026 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835472; cv=none; b=fgRAsFfqS/XjSZraBQb1+TM+XT59xbuGBb7t1krsKBeaTHs3i+BUksMe3S+qCtOCQwGAn+Q/iQvjP5AJ4xqWMKDvnd+5SEyFfwAKA/c18qEBVYZqU+M+HqCvUhSV/s6V78PSxc845tlT0QyeWEssqnZRtYEQvFfxTg3n0wWZrh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835472; c=relaxed/simple;
	bh=06XpGWrDTRgWeunQhaSngbG+MQN8f0fWzCcpAM/ZtWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=buP1K7vuPSsxO37zlsZzgBOSBGVN0i+6BjT4mXd0CxLnQp9iConyepgeymGyCuiyuBuWtfJsHYoYZBHsiC2XdoMdSCSzozjk6toLJNcooP6SiUk2B2uoBjqfYlrqVCb2y85ahqwmbug3YzxNUkvXKpS58b9x2LLnLTfIi9pLHRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qs944ism; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qs944ism"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9F21F000E9;
	Thu, 27 Aug 2026 12:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787835447;
	bh=ND3bwqV6V1QJVmYNM6skr+RqFnNZdt8Tbi9stZRDL9Y=;
	h=From:To:Cc:Subject:Date;
	b=qs944ismpyItG8vqaPHXJ1ib2KD0JCbvj2OOaHZT6wYJTqga+9KFIzoQC0UKtMlUl
	 Or31ez/1YZ6f9ujH88cPnF0EsOEyyy7LkCJUHaIFUFNZEcSWt3Un+ZrNOnVVu0C6Ro
	 rbEJtV3xkz1ozEW+hEAzD6kYQp3XU+Aoez7Glip0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.47
Date: Thu, 27 Aug 2026 14:57:12 +0200
Message-ID: <2026082713-uncover-devotion-6767@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.47 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                         |    2 
 drivers/block/null_blk/zoned.c                   |   10 +
 drivers/bluetooth/hci_aml.c                      |   18 +++
 drivers/dma/fsl-edma-main.c                      |    2 
 drivers/gpu/drm/xe/display/xe_fb_pin.c           |   32 +-----
 drivers/hid/hid-core.c                           |   11 +-
 drivers/hid/hid-hyperv.c                         |   27 ++++-
 drivers/hid/hid-input.c                          |    3 
 drivers/hid/hid-magicmouse.c                     |   64 +++++++++++-
 drivers/hid/hid-nintendo.c                       |   22 ++--
 drivers/hid/hid-sensor-custom.c                  |   17 +--
 drivers/hid/hid-uclogic-core.c                   |   12 ++
 drivers/hid/usbhid/hid-pidff.c                   |   13 +-
 drivers/input/keyboard/atkbd.c                   |   23 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c      |    2 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h      |    1 
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c   |   15 ++
 drivers/iommu/iommufd/ioas.c                     |    4 
 drivers/mailbox/mailbox-mchp-ipc-sbi.c           |    2 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c  |   17 ++-
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c |    7 +
 drivers/net/usb/rndis_host.c                     |    6 -
 drivers/nfc/fdp/i2c.c                            |   27 +++++
 drivers/nfc/microread/microread.c                |   31 +++++
 drivers/nfc/pn533/pn533.c                        |    1 
 drivers/nfc/st21nfca/dep.c                       |    3 
 drivers/nvme/target/admin-cmd.c                  |    2 
 drivers/nvme/target/fabrics-cmd-auth.c           |    2 
 drivers/nvme/target/fc.c                         |    2 
 drivers/nvme/target/pci-epf.c                    |   10 +
 drivers/nvme/target/tcp.c                        |   18 +++
 drivers/pci/controller/pci-host-generic.c        |   11 --
 drivers/pci/ecam.c                               |   13 ++
 drivers/ptp/ptp_vmclock.c                        |    6 +
 drivers/tty/serial/sc16is7xx.c                   |   40 +++----
 fs/exec.c                                        |    8 +
 fs/ext4/crypto.c                                 |   40 +++----
 fs/ext4/fast_commit.c                            |   16 ++-
 fs/ext4/ialloc.c                                 |    4 
 fs/ext4/inode.c                                  |   11 +-
 fs/ext4/super.c                                  |    2 
 fs/ext4/xattr.c                                  |    7 -
 fs/nilfs2/ioctl.c                                |   20 +++
 fs/ocfs2/xattr.c                                 |   18 ++-
 fs/xfs/libxfs/xfs_attr_leaf.c                    |   14 ++
 fs/xfs/scrub/agheader.c                          |   96 +++++++++++++-----
 fs/xfs/scrub/agheader_repair.c                   |   17 ++-
 fs/xfs/scrub/bmap.c                              |    8 -
 fs/xfs/scrub/common.c                            |   10 -
 fs/xfs/scrub/common.h                            |    2 
 fs/xfs/scrub/dir.c                               |    2 
 fs/xfs/scrub/dirtree.c                           |    4 
 fs/xfs/scrub/metapath.c                          |    6 -
 fs/xfs/scrub/nlinks.c                            |   12 +-
 fs/xfs/scrub/parent.c                            |    6 -
 fs/xfs/scrub/rtbitmap.c                          |   12 +-
 fs/xfs/scrub/rtsummary.c                         |   12 +-
 include/linux/futex.h                            |    2 
 include/linux/pci-ecam.h                         |    3 
 include/linux/sched.h                            |    8 +
 include/linux/wait.h                             |    1 
 include/linux/wait_bit.h                         |    1 
 io_uring/futex.c                                 |   11 ++
 io_uring/futex.h                                 |    1 
 io_uring/io-wq.c                                 |    9 +
 io_uring/opdef.c                                 |    2 
 io_uring/rsrc.c                                  |    2 
 io_uring/uring_cmd.c                             |    8 -
 kernel/futex/core.c                              |  116 ++++++++++++++--------
 kernel/futex/futex.h                             |    9 +
 kernel/futex/pi.c                                |  121 +++++++++++++++++------
 kernel/kcov.c                                    |   90 ++++++++---------
 kernel/sched/wait.c                              |   15 ++
 kernel/sched/wait_bit.c                          |   14 ++
 lib/Kconfig.debug                                |    5 
 net/bluetooth/hci_event.c                        |    8 +
 net/bluetooth/hci_sync.c                         |   46 +++++++-
 net/bluetooth/iso.c                              |   32 ++++--
 net/bluetooth/mgmt.c                             |    8 +
 net/bluetooth/rfcomm/core.c                      |   24 +++-
 net/ceph/osd_client.c                            |    5 
 net/core/gro.c                                   |    7 -
 net/ipv4/ip_output.c                             |    4 
 net/ipv6/ip6_output.c                            |    2 
 net/mptcp/options.c                              |    2 
 net/mptcp/pm.c                                   |   74 +++++++-------
 net/mptcp/pm_kernel.c                            |   22 ++--
 net/mptcp/pm_userspace.c                         |   10 +
 net/mptcp/protocol.h                             |   25 ++--
 net/mptcp/subflow.c                              |    4 
 net/nfc/digital_technology.c                     |    2 
 net/nfc/llcp_commands.c                          |   18 +++
 net/nfc/llcp_core.c                              |   15 ++
 net/nfc/nci/ntf.c                                |   36 +++++-
 net/nfc/nci/rsp.c                                |    1 
 net/xfrm/xfrm_state.c                            |    4 
 sound/drivers/dummy.c                            |    6 +
 sound/soc/codecs/lpass-tx-macro.c                |    4 
 sound/usb/fcp.c                                  |   38 +++----
 sound/usb/mixer.c                                |    6 +
 sound/usb/mixer.h                                |    2 
 sound/usb/mixer_scarlett2.c                      |   98 +++++++++++-------
 102 files changed, 1235 insertions(+), 489 deletions(-)

Abdifatah Suruur (1):
      ptp: vmclock: prevent read-only mappings from becoming writable

Ali Ahmet Memis (5):
      Bluetooth: RFCOMM: take rfcomm_mutex for the deferred setup accept
      io_uring/rsrc: fix folio size overflow in io_vec_fill_bvec()
      Bluetooth: ISO: do not force BT_LISTEN after a failed BIG sync
      Bluetooth: ISO: zero the sockaddr before returning it in getname
      Bluetooth: MGMT: reject HCI_CMD_SYNC params_len above 255

Anand Khoje (1):
      net/ionic: avoid OOB TX partner lookup for hwstamp RXQ

Andrei Fed (1):
      HID: magicmouse: fix battery reporting for Bluetooth Magic Trackpad USB-C

Baul Lee (2):
      HID: core: fix OOB read of field->usage in hid_set_field()
      HID: pidff: fix OOB write when hid->inputs is empty

Bryam Vargas (3):
      nfc: fdp: bound the device-reported read length and fix an skb leak
      nfc: nci: add data_len bound checks to activation parameter extractors
      nvmet-auth: zero the AUTH_RECEIVE response buffer

Chengfeng Ye (2):
      Bluetooth: hci_event: fix LE list UAF on reset
      Bluetooth: hci_sync: Fix accept list UAF during suspend

Christoph Hellwig (1):
      xfs: add a xchk_ip_set_corrupt helper

Christopher Kodama (1):
      HID: magicmouse: re-enable multitouch after reset-resume

Cryolitia PukNgae (1):
      Input: atkbd - skip deactivate for HONOR FMB-P's internal keyboard

Darrick J. Wong (3):
      xfs: rtsummary scrub should treat rtbitmap corruption errors as an xref error
      xfs: hoist per-bucket unlinked list check to helper
      xfs: don't livelock in scrub on a circular unlinked list

Dawid Wróbel (1):
      ASoC: codecs: lpass-tx-macro: Fix enum kcontrol accesses

Donglin Lyu (1):
      Input: atkbd - skip deactivate for HONOR ZQC-P

Doruk Tan Ozturk (4):
      nfc: digital: clamp SENSF_RES length to the destination buffer
      nfc: llcp: bound the connect_sn TLV walk to the skb
      nfc: llcp: reject PDUs shorter than the LLCP header
      nfc: st21nfca: validate ATR_REQ length against the received frame

Eric Biggers (1):
      ext4: don't enable DAX on new encrypted files

Eric Dumazet (1):
      net: gro: properly validate BIG TCP aggregation criteria

Felix Hoffmann (1):
      futex: Avoid private hash use-after-free on final put

Geoffrey D. Bennett (2):
      ALSA: FCP: Use a private URB for the notification endpoint
      ALSA: scarlett2: Use a private URB for the notification endpoint

Greg Kroah-Hartman (2):
      nvmet-tcp: Do not WARN on remotely-controlled oversized SGL allocations
      Linux 6.18.47

Griffin Kroah-Hartman (3):
      rndis_host: add overflow check in rndis_rx_fixup()
      mailbox: mchp-ipc-sbi: Add null check for devm_kasprintf()
      dmaengine: fsl-edma: Add error handling for devm_kasprintf

Guanghui Yang (2):
      ext4: clear error before retrying inode xattr space fallback
      ext4: propagate errors from fast commit range replay

Guixin Liu (1):
      nvmet: fix NULL pointer dereference in nvmet_execute_identify_nslist()

Haoxiang Li (1):
      HID: sensor: custom: Fix use-after-free in enable_sensor

Hongling Zeng (1):
      xfs: validate attr entry pointer before field access

Hugo Villeneuve (2):
      serial: sc16is7xx: rename EFR mutex with generic name
      serial: sc16is7xx: use guards for simple mutex locks

Hyunwoo Kim (1):
      futex: Fix race on the initial mm->futex.phash.ref allocation

Ian Bridges (1):
      ocfs2: fix missing metadata reservation for large xattrs

Ibrahim Hashimov (3):
      nvmet-tcp: bound SGL data length before allocating command buffers
      HID: nintendo: fix out-of-bounds read in joycon_ctlr_read_handler()
      HID: uclogic: fix use-after-free of inrange_timer on remove

Jann Horn (1):
      HID: core: fix number/pointer type confusion on long items

Jens Axboe (2):
      io_uring/futex: don't mark futex wake requests as inflight
      io_uring/uring_cmd: don't skip completion for a synchronous multishot cmd

Jia Zhu (1):
      ext4: avoid tail write_begin walk for uptodate folios

Jiang HongHui (1):
      nvmet-fc: fix invalid free in LS IOD error path

Jiangshan Yi (2):
      HID: nintendo: register input device after capabilities are set
      HID: nintendo: stop device IO before hid_hw_stop on probe failure

Jiazi Liu (1):
      ext4: fix incorrect function call when initializing s_resgid

Jose Villaseñor Montfort (1):
      HID: magicmouse: do not keep a stale msc->input if no input is claimed

Kyle Zeng (1):
      futex/pi: Reject cross-mm private futex owners

Laxman Acharya Padhya (2):
      Bluetooth: hci_event: validate LE Set CIG Parameters response
      Bluetooth: hci_aml: validate firmware segment lengths

Lee Jones (1):
      HID: magicmouse: Prevent out-of-bounds (OOB) read during DOUBLE_REPORT_ID

Linmao Li (1):
      nfc: nci: free destination parameters when closing a connection

Luca Fresi (1):
      serial: sc16is7xx: enable THRI before filling TX FIFO

Luxiao Xu (1):
      ipv6: fix use-after-free in ip6_finish_output2()

Maarten Lankhorst (1):
      drm/xe: Fix DPT allocation paths.

Matthias Goergens (1):
      ext4: stop retrying saturated xattr cache entries

Matthieu Baerts (NGI0) (3):
      mptcp: pm: use for_each_subflow helper
      mptcp: pm: rename add_entry structure to add_addr
      mptcp: pm: uniform announced addresses helpers

Michael Bommarito (1):
      HID: hyperv: validate initial device info bounds

Muhammad Bilal (1):
      nfc: llcp: fix OOB read and u8 offset wrap in TLV parsers

Pavitra Jha (1):
      libceph: fix OOB read in decode_watchers() via missing bounds check

Peiyang He (1):
      iommu/iommufd: Fix NULL pointer deref in iommufd_ioas_change_process when racing with iopt_map_file_pages

Pengpeng Hou (1):
      nfc: microread: validate target discovery payload lengths

Peter Zijlstra (1):
      futex: Fix might_sleep() warning in futex_pivot_pending()

Rik van Riel (1):
      null_blk: fix UBSAN shift-out-of-bounds when zone_size is 0 or overflows

Ryusuke Konishi (1):
      nilfs2: reject invalid block index in GC ioctl

Samuel Page (2):
      nfc: nci: fix out-of-bounds write in nci_target_auto_activated()
      nfc: nci: fix uninit-value in the RF discover/activated NTF handlers

Shameer Kolothum (1):
      iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on teardown

Shardul Bankar (1):
      mptcp: pm: fix memory leak from alloc-during-teardown race

Shin'ichiro Kawasaki (1):
      nvmet: pci-epf: fix use-after-free in nvmet_pci_epf_exec_iod_work()

Steffen Persvold (1):
      PCI: host-generic: Fix NULL pointer dereference on 32-bit CAM systems

Takashi Iwai (1):
      ALSA: dummy: Check card index validity at probe

Tetsuo Handa (1):
      kcov: fix data corruption and race conditions on PREEMPT_RT

Thomas Gleixner (2):
      futex: Sanitize and document task_struct::futex::state transitions
      futex/pi: Plug private futex exec() race

Vishnu Razdan (1):
      io_uring/io-wq: fix worker accounting when canceling creation callbacks

Woraphat Khiaodaeng (1):
      io_uring/cmd: fix iovec leak when the async cmd is not recycled

Xiang Mei (Microsoft) (1):
      xfrm: fix sk_dst_cache double-free in xfrm_user_policy()

Xu Rao (1):
      nfc: pn533: purge fragmented skbs during cleanup

Yifei Gao (1):
      nvmet: pci-epf: put CQ ref on create_cq mapping failure

Yong Wang (1):
      ipv4: reject undersized MTUs in ip_do_fragment()

