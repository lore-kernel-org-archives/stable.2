Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FB7453A21;
	Thu, 27 Aug 2026 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835487; cv=none; b=Pi/+xzPb02y6nM3p5TIq+RyTVm5mNgIy65Eo3m/TnRCcQLPUXT2WTxQas1g3hPv8HTYhIMoYEfDT0DxQ11kcWQk0hX+Or4VAWGbaLSNBB5ABvJc8hAt711Gjj8LEkrA1YQQnbC89rt7VrlJgkkhACODY0Mff1p8Nj1v1L7i1buE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835487; c=relaxed/simple;
	bh=2Ndsr8GqBDrp9PvE2tRsaQ8q0hrLyrk9STyWO7hYC1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g1VVTERjM7MWAo1trTrzDYoQ/doIjiMe5Qbu4qEMD7jHUCT6xLAKOYrouV00DgNvi9mcBcJzdmHgp13AQhdEngVl9MZPPQDLPEpan1VWUXHTbPprwfu7vn+tON6deJv25C14brN0QU/IJy89q2iy1c+FW+nRw1BB/9ceT8Dx2n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MOS3rdwh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MOS3rdwh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51451F00A3D;
	Thu, 27 Aug 2026 12:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787835464;
	bh=l8NY/vDwt9O2Bk4fBRa3hsoi7TcRd3uJALlYn2QfuB4=;
	h=From:To:Cc:Subject:Date;
	b=MOS3rdwhrcGANikKFGv+0HrLe320FRrzcg9vFgX0vPafnzEjj4cpY+ou9pZYyPPsz
	 tMIZO27iixGuJ50cdYdjA+TFebSjXwlyLbHIqrKqrBexxImtc4FBt59peWFFkOs78C
	 TwEHVcuQhBLK2Y/hw2EvVgvs8cmKiLC5FlJOqmzo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.2.1
Date: Thu, 27 Aug 2026 14:57:40 +0200
Message-ID: <2026082741-suffice-poker-cbc1@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.2.1 kernel.

All users of the 7.2 kernel series must upgrade.

The updated 7.2.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.2.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                         |    2 
 drivers/block/null_blk/zoned.c                   |   10 +
 drivers/bluetooth/hci_aml.c                      |   18 +++
 drivers/dma/fsl-edma-main.c                      |    2 
 drivers/hid/Kconfig                              |    1 
 drivers/hid/hid-asus.c                           |    2 
 drivers/hid/hid-core.c                           |   11 +-
 drivers/hid/hid-ft260.c                          |   25 ++++
 drivers/hid/hid-huawei.c                         |    5 
 drivers/hid/hid-hyperv.c                         |   27 ++++-
 drivers/hid/hid-input.c                          |   20 +++
 drivers/hid/hid-magicmouse.c                     |   73 ++++++++++++-
 drivers/hid/hid-nintendo.c                       |   22 ++--
 drivers/hid/hid-rapoo.c                          |    2 
 drivers/hid/hid-sensor-custom.c                  |   17 +--
 drivers/hid/hid-uclogic-core.c                   |   12 ++
 drivers/hid/usbhid/hid-pidff.c                   |   13 +-
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
 drivers/nvme/target/tcp.c                        |   19 +++
 drivers/pci/controller/pci-host-generic.c        |   11 --
 drivers/pci/ecam.c                               |   13 ++
 drivers/ptp/ptp_vmclock.c                        |    6 +
 fs/exec.c                                        |    7 -
 fs/ext4/crypto.c                                 |   40 +++----
 fs/ext4/fast_commit.c                            |   16 ++-
 fs/ext4/ialloc.c                                 |    4 
 fs/ext4/inode.c                                  |   11 +-
 fs/ext4/super.c                                  |    2 
 fs/ext4/xattr.c                                  |    7 -
 fs/nilfs2/ioctl.c                                |   20 +++
 fs/ocfs2/xattr.c                                 |   18 ++-
 fs/xfs/libxfs/xfs_attr_leaf.c                    |   14 ++
 fs/xfs/xfs_trans.c                               |   16 +--
 include/linux/futex.h                            |    2 
 include/linux/hid.h                              |    2 
 include/linux/io_uring_types.h                   |    8 +
 include/linux/pci-ecam.h                         |    3 
 include/linux/sched.h                            |    8 +
 include/linux/wait.h                             |    1 
 include/linux/wait_bit.h                         |    1 
 io_uring/eventfd.c                               |    8 -
 io_uring/eventfd.h                               |    2 
 io_uring/futex.c                                 |   32 ++++--
 io_uring/futex.h                                 |    1 
 io_uring/io-wq.c                                 |    9 +
 io_uring/io_uring.c                              |    2 
 io_uring/opdef.c                                 |    2 
 io_uring/poll.c                                  |   23 ++--
 io_uring/rsrc.c                                  |    2 
 io_uring/tw.c                                    |    2 
 io_uring/uring_cmd.c                             |    8 -
 io_uring/waitid.c                                |    2 
 kernel/futex/core.c                              |  113 +++++++++++++++------
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
 net/ipv4/ip_output.c                             |    4 
 net/ipv6/ip6_output.c                            |    2 
 net/nfc/digital_technology.c                     |    2 
 net/nfc/llcp_commands.c                          |   18 +++
 net/nfc/llcp_core.c                              |   15 ++
 net/nfc/nci/ntf.c                                |   36 +++++-
 net/nfc/nci/rsp.c                                |    1 
 sound/drivers/dummy.c                            |    6 +
 sound/usb/fcp.c                                  |   38 +++----
 sound/usb/mixer.c                                |    6 +
 sound/usb/mixer.h                                |    2 
 sound/usb/mixer_scarlett2.c                      |   98 +++++++++++-------
 90 files changed, 1074 insertions(+), 346 deletions(-)

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

Christopher Kodama (1):
      HID: magicmouse: re-enable multitouch after reset-resume

Doruk Tan Ozturk (4):
      nfc: digital: clamp SENSF_RES length to the destination buffer
      nfc: llcp: bound the connect_sn TLV walk to the skb
      nfc: llcp: reject PDUs shorter than the LLCP header
      nfc: st21nfca: validate ATR_REQ length against the received frame

Eric Biggers (1):
      ext4: don't enable DAX on new encrypted files

Felix Hoffmann (1):
      futex: Avoid private hash use-after-free on final put

Geoffrey D. Bennett (2):
      ALSA: FCP: Use a private URB for the notification endpoint
      ALSA: scarlett2: Use a private URB for the notification endpoint

Greg Kroah-Hartman (2):
      nvmet-tcp: Do not WARN on remotely-controlled oversized SGL allocations
      Linux 7.2.1

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

Hyunwoo Kim (1):
      futex: Fix race on the initial mm->futex.phash.ref allocation

Ian Bridges (1):
      ocfs2: fix missing metadata reservation for large xattrs

Ibrahim Hashimov (3):
      nvmet-tcp: bound SGL data length before allocating command buffers
      HID: nintendo: fix out-of-bounds read in joycon_ctlr_read_handler()
      HID: uclogic: fix use-after-free of inrange_timer on remove

Jann Horn (4):
      HID: asus: fix missing hid_is_usb() check
      HID: huawei: fix missing hid_is_usb() check
      HID: rapoo: fix missing hid_is_usb() check
      HID: core: fix number/pointer type confusion on long items

Jens Axboe (4):
      io_uring/futex: don't mark futex wake requests as inflight
      io_uring/futex: only mark private futex waits as inflight
      io_uring/uring_cmd: don't skip completion for a synchronous multishot cmd
      io_uring: defer eventfd signaling when queued from a wakeup handler

Jia Zhu (1):
      ext4: avoid tail write_begin walk for uptodate folios

Jiang HongHui (1):
      nvmet-fc: fix invalid free in LS IOD error path

Jiangshan Yi (2):
      HID: nintendo: register input device after capabilities are set
      HID: nintendo: stop device IO before hid_hw_stop on probe failure

Jiazi Liu (1):
      ext4: fix incorrect function call when initializing s_resgid

Jose Villaseñor Montfort (3):
      HID: magicmouse: prevent unbounded recursion in magicmouse_raw_event()
      HID: magicmouse: do not keep a stale msc->input if no input is claimed
      HID: input: read battery capacity from its actual report offset

Kyle Zeng (1):
      futex/pi: Reject cross-mm private futex owners

Laxman Acharya Padhya (2):
      Bluetooth: hci_event: validate LE Set CIG Parameters response
      Bluetooth: hci_aml: validate firmware segment lengths

Linmao Li (1):
      nfc: nci: free destination parameters when closing a connection

Luxiao Xu (1):
      ipv6: fix use-after-free in ip6_finish_output2()

Matthias Goergens (1):
      ext4: stop retrying saturated xattr cache entries

Michael Bommarito (1):
      HID: hyperv: validate initial device info bounds

Muhammad Bilal (1):
      nfc: llcp: fix OOB read and u8 offset wrap in TLV parsers

Peiyang He (1):
      iommu/iommufd: Fix NULL pointer deref in iommufd_ioas_change_process when racing with iopt_map_file_pages

Pengpeng Hou (1):
      nfc: microread: validate target discovery payload lengths

Peter Zijlstra (1):
      futex: Fix might_sleep() warning in futex_pivot_pending()

Raman Varabets (1):
      HID: ft260: fix stack-use-after-return write in I2C read race

Rik van Riel (1):
      null_blk: fix UBSAN shift-out-of-bounds when zone_size is 0 or overflows

Ryusuke Konishi (1):
      nilfs2: reject invalid block index in GC ioctl

Samuel Page (2):
      nfc: nci: fix out-of-bounds write in nci_target_auto_activated()
      nfc: nci: fix uninit-value in the RF discover/activated NTF handlers

Shameer Kolothum (1):
      iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on teardown

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

Xu Rao (1):
      nfc: pn533: purge fragmented skbs during cleanup

Yifei Gao (1):
      nvmet: pci-epf: put CQ ref on create_cq mapping failure

Yong Wang (1):
      ipv4: reject undersized MTUs in ip_do_fragment()

Yun Zhou (1):
      xfs: restore nofs context unconditionally in xfs_trans_roll

