Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4745849CF39;
	Wed,  2 Sep 2026 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352906; cv=none; b=geJAjcrGDze5/+t//mCXARJbDemkF6gnPU3e89lL+mg+Ezj5PXt31pYVP3l83mBdXSIhYiIy8jbMQeO+47zHdtTaABKkZE0mhlV3V7a+DMXf/GAewqJu/sSXNy9xjfy9ClO4mP4kmpIEKyIJLdqJr6VCgGpAmrg3FqvXi9zHzAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352906; c=relaxed/simple;
	bh=yJg7MN6FaMAAN0yvBuxbxEAV+a2Wb5vqR5EoUgIDEbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KA5kQImnuKGbZuexuOOm1ADv0jgaMcZxOtzxikHaNi20yQrxmi05f+/ovhwubdRv1tPJgAuiQrOE9PPdFdOBD5NfVQesUjIruY02N+mO1zXXoQohlfqOVCBQfOo2PbngUc43GH48b0zBTQGMLY/zx1fGmNDojPqLZ3i9mrUPGPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SRgSTjD0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SRgSTjD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509281F00A3A;
	Wed,  2 Sep 2026 12:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788352903;
	bh=kEEvoKDZf6dbNzOx3u3n/noBFWxNveKogAow4Topd4Q=;
	h=From:To:Cc:Subject:Date;
	b=SRgSTjD0fUY0SoIt6YK7RrG27ogv2FWoKk3wzaynNeaExjHO6ylwplUZ/bsVcsYAI
	 i5+nfIJIlhaRU3nEsLMzDADljxuqwAAoXftbK+x4aUoWJsoJl+Y614MKposAyNy5KL
	 E1Ut6QGwGZQ0SkO8wnf5OjCwjtpOt2hPvl0uXl1k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.220
Date: Wed,  2 Sep 2026 14:41:34 +0200
Message-ID: <2026090235-gear-alabaster-a24c@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.220 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/filesystems/fscrypt.rst        |    4 
 Makefile                                     |    2 
 arch/arm64/kvm/arm.c                         |    6 
 arch/s390/kvm/vsie.c                         |    1 
 drivers/accessibility/speakup/main.c         |    1 
 drivers/base/power/main.c                    |    6 
 drivers/crypto/atmel-tdes.c                  |    5 
 drivers/crypto/mxs-dcp.c                     |    2 
 drivers/crypto/qce/aead.c                    |   58 ------
 drivers/crypto/qce/common.c                  |   55 +----
 drivers/crypto/qce/common.h                  |   16 -
 drivers/crypto/qce/regs-v5.h                 |    4 
 drivers/crypto/qce/sha.c                     |   30 ---
 drivers/crypto/qce/sha.h                     |    1 
 drivers/crypto/qce/skcipher.c                |   97 ----------
 drivers/fpga/dfl-fme-perf.c                  |    2 
 drivers/hid/hid-ft260.c                      |  162 +++++++++++++---
 drivers/hid/hid-input.c                      |   17 +
 drivers/hid/hid-magicmouse.c                 |   25 ++
 drivers/hid/hid-uclogic-core.c               |   12 +
 drivers/infiniband/sw/rxe/rxe_qp.c           |    3 
 drivers/mtd/maps/vmu-flash.c                 |    8 
 drivers/nvme/host/core.c                     |   12 -
 drivers/nvme/host/fabrics.c                  |    8 
 drivers/nvme/host/fault_inject.c             |    2 
 drivers/nvme/host/fc.c                       |    8 
 drivers/nvme/target/admin-cmd.c              |   20 +-
 drivers/nvme/target/core.c                   |   42 ++--
 drivers/nvme/target/discovery.c              |   14 -
 drivers/nvme/target/fabrics-cmd.c            |   32 +--
 drivers/nvme/target/io-cmd-bdev.c            |   12 -
 drivers/nvme/target/nvmet.h                  |    2 
 drivers/nvme/target/passthru.c               |   10 -
 drivers/nvme/target/rdma.c                   |   10 -
 drivers/nvme/target/tcp.c                    |   17 +
 drivers/nvme/target/zns.c                    |   30 +--
 drivers/target/target_core_fabric_configfs.c |    8 
 drivers/usb/c67x00/c67x00-sched.c            |    4 
 drivers/usb/core/devio.c                     |    2 
 drivers/usb/core/hub.c                       |    7 
 drivers/usb/gadget/function/f_tcm.c          |    2 
 drivers/usb/host/xhci-dbgtty.c               |   15 +
 drivers/usb/misc/usbtest.c                   |    1 
 drivers/usb/serial/option.c                  |   20 +-
 drivers/usb/serial/spcp8x5.c                 |   13 -
 fs/cifs/smb2ops.c                            |    4 
 fs/ext4/fast_commit.c                        |   10 -
 fs/ext4/ialloc.c                             |    4 
 fs/ext4/super.c                              |   40 ++--
 fs/fuse/dir.c                                |    9 
 fs/fuse/file.c                               |    4 
 fs/jfs/inode.c                               |    2 
 fs/jfs/jfs_extent.c                          |   10 +
 fs/nilfs2/ioctl.c                            |  261 ++++++++++++---------------
 include/linux/hid.h                          |    1 
 include/linux/inetdevice.h                   |    5 
 include/linux/nvme.h                         |    4 
 include/linux/sched.h                        |    8 
 include/target/target_core_fabric.h          |    2 
 io_uring/io-wq.c                             |    9 
 kernel/bpf/offload.c                         |   10 -
 kernel/kcov.c                                |  122 ++++++------
 lib/Kconfig.debug                            |    5 
 mm/swapfile.c                                |    7 
 net/bridge/br_multicast.c                    |    4 
 net/can/j1939/j1939-priv.h                   |    1 
 net/can/j1939/main.c                         |    5 
 net/can/j1939/socket.c                       |   55 +++++
 net/core/filter.c                            |    1 
 net/ipv4/igmp.c                              |   14 -
 net/ipv6/ah6.c                               |   29 +--
 net/ipv6/seg6_local.c                        |    7 
 net/netfilter/ipvs/ip_vs_xmit.c              |    6 
 net/nfc/nci/ntf.c                            |   26 ++
 net/smc/smc_core.c                           |   27 +-
 net/xfrm/espintcp.c                          |    9 
 net/xfrm/xfrm_user.c                         |    2 
 security/selinux/ss/conditional.c            |   12 -
 sound/core/pcm_lib.c                         |   11 -
 sound/core/pcm_native.c                      |   32 ++-
 sound/soc/tegra/tegra_pcm.c                  |    3 
 sound/usb/card.c                             |   14 +
 sound/usb/midi.c                             |    2 
 83 files changed, 841 insertions(+), 744 deletions(-)

Aleksandr Nogikh (1):
      usb: usbtest: disable dynamic ID support

Asim Viladi Oglu Manizada (1):
      xfrm: ah6: validate routing header segments_left

Baokun Li (2):
      fuse: fix invalidate lock leak on setattr writeback failure
      fuse: fix invalidate lock leak on open O_TRUNC DAX failure

Bartosz Golaszewski (1):
      crypto: qce - Remove unsafe/deprecated algorithms

Bryam Vargas (1):
      nfc: nci: add data_len bound checks to activation parameter extractors

Christian Borntraeger (1):
      KVM: s390: vsie: zero stale crypto bits

Eric Biggers (2):
      ext4: don't enable DAX on new encrypted files
      mm/swap: reject swapon() on filesystem-level encrypted files

Eric Dumazet (1):
      ipv4: igmp: Fix potential UAF in igmp_gq_start_timer()

Florian Westphal (1):
      ipvs: reload ip header after head reallocation

Greg Kroah-Hartman (1):
      Linux 5.15.220

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

Ji'an Zhou (1):
      ALSA: PCM: Fix wait queue list corruption in snd_pcm_drain() on linked streams

Jiale Yao (1):
      USB: serial: option: fix slab OOB read in interrupt URB callback

Jiayuan Chen (1):
      bpf: Fix use-after-free in offloaded map/prog info fill

Johan Hovold (1):
      USB: serial: spcp8x5: drop broken carrier detect support

Jon Hunter (1):
      ASoC: tegra: Fix Master Volume Control

Jose Villaseñor Montfort (2):
      HID: magicmouse: prevent unbounded recursion in magicmouse_raw_event()
      HID: input: read battery capacity from its actual report offset

Kuniyuki Iwashima (1):
      smc: Use __sk_dst_get() and dst_dev_rcu() in smc_vlan_by_tcpsk().

Kyle Zeng (1):
      ipv6: seg6: clear IPv4 control block on IPIP decapsulation

Lucas De Marchi (2):
      xhci: dbgtty: Fix unregister on tty_register_driver() failure
      xhci: dbgtty: Fix unregister on tty_alloc_driver() failure

Marouane El Moufid (1):
      ALSA: usb-audio: fix OOB write in snd_usbmidi_novation_output()

Md Sadre Alam (1):
      crypto: qce - fix CCM AAD buffer underallocation

Mehul Rao (1):
      ALSA: pcm: fix use-after-free on linked stream runtime in snd_pcm_drain()

Michael Zaidman (7):
      HID: ft260: fix i2c probing for hwmon devices
      HID: ft260: improve i2c write performance
      HID: ft260: improve i2c large reads performance
      HID: ft260: skip unexpected HID input reports
      HID: ft260: wake up device from power saving mode
      HID: ft260: missed NACK from busy device
      HID: ft260: validate i2c input report length

Miguel Peñaranda (1):
      usb: usbfs: fix use-after-free of usb_device in usbdev_release()

Norbert Szetei (1):
      net: bridge: mcast: fix use-after-free of a master VLAN's multicast context

Oliver Upton (1):
      KVM: arm64: Prevent access to vCPU events before init

Oswald Buddenhagen (1):
      ALSA: pcm: fix wait_time calculations

Peiyang He (1):
      RDMA/rxe: Fix OOB in free_rd_atomic_resources()

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

Sebastian Andrzej Siewior (2):
      bpf: Remove tst_run from lwt_seg6local_prog_ops.
      kcov: replace local_irq_save() with a local_lock_t

Shuangpeng Bai (2):
      usb: gadget: f_tcm: keep port count until LUN teardown completes
      USB: c67x00: fix use-after-free in c67x00_add_iso_urb()

Stephen Smalley (1):
      selinux: switch two allocations to use kzalloc_objs()

Tetsuo Handa (4):
      can: j1939: implement NETDEV_UNREGISTER notification handler
      can: j1939: add missing calls in NETDEV_UNREGISTER notification handler
      can: j1939: make j1939_sk_bind() fail if device is no longer registered
      kcov: fix data corruption and race conditions on PREEMPT_RT

Thorsten Blum (2):
      crypto: atmel-tdes - use scatterlist length before DMA mapping
      crypto: mxs-dcp - fix source scatterlist length access

Vasiliy Kovalev (2):
      jfs: add check read-only before truncation in jfs_truncate_nolock()
      jfs: add check read-only before txBeginAnon() call

Vishnu Razdan (1):
      io_uring/io-wq: fix worker accounting when canceling creation callbacks

Weiwen Hu (1):
      nvme: rename CDR/MORE/DNR to NVME_STATUS_*

Will Porter (1):
      ALSA: usb-audio: Complete cleanup after system-resume errors

Zhiling Zou (1):
      xfrm: drop ESP-in-TCP packets with no ingress device

Zihan Xi (1):
      xfrm: fix xfrm_state_construct() auth-trunc leak

