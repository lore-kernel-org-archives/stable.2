Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59AA49551D;
	Wed,  2 Sep 2026 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352894; cv=none; b=ilIaOlY6W41rDI0Ox8cL8nY8P9PC+kgVF7R0t03vZ7frnT2YTp/SkDtQLHjKUfWSdAifC576yzVH4+a0Yb8EFLi37uFQDIJUhli8V1xZkJJ08MPIr6N9tXWaBTuydgVsZXUEn6FBVd7j9zYphmtuA/IT/KLfwBNlSDD9OK+pQ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352894; c=relaxed/simple;
	bh=OiGfxjw2QCYrhewS/WUM3K8dBPQOgdNBuzMQPsQ9dSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HGCrAVXovzc9+ymVeTWJZjaYSPR2AQ6JurQgdOa+nw8MXDNVnRDf0s07Wbn6g/ktLOG65EE2pYEOEtcyCnF1Wd8ZOTFD621yTKd7sF8jvJW5V3qHu8F0vCe6T1Eg1ATM3duGjhjFnwwrBPXnQ2Yqrnivxq9mn5pZKq0vFglYRGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VwJI1G3K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VwJI1G3K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358381F00A3A;
	Wed,  2 Sep 2026 12:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788352892;
	bh=Z/62Zz025xxhgrTLpx3oH4HmOf2/ZmyCXOSlgC+PCiE=;
	h=From:To:Cc:Subject:Date;
	b=VwJI1G3KorRB4r+FHKqQXZEv4z7iZhZq1toj0s0ju3lnzLNOLV1BheL3v4VSXDfuB
	 Htl86zShA9wTXSUe7FdG10mMfhvfdfxNqSjUMM+7W86MGXcfgw95tlYgOuv2zUlhax
	 8WT03rutV257JX4W6vI5BxCq4V/4fjA1WOX0/ab0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.269
Date: Wed,  2 Sep 2026 14:41:25 +0200
Message-ID: <2026090226-cornbread-subsiding-eb84@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.269 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/filesystems/fscrypt.rst        |    4 +
 Makefile                                     |    2 
 arch/arm64/kvm/arm.c                         |    6 +
 arch/s390/kvm/vsie.c                         |    1 
 drivers/accessibility/speakup/main.c         |    1 
 drivers/base/power/main.c                    |    6 -
 drivers/crypto/atmel-tdes.c                  |    5 -
 drivers/crypto/mxs-dcp.c                     |    2 
 drivers/fpga/dfl-fme-perf.c                  |    2 
 drivers/hid/hid-input.c                      |   17 +++-
 drivers/hid/hid-magicmouse.c                 |   10 ++
 drivers/infiniband/sw/rxe/rxe_qp.c           |    3 
 drivers/mtd/maps/vmu-flash.c                 |    8 +-
 drivers/nvme/target/tcp.c                    |   13 +++
 drivers/target/target_core_fabric_configfs.c |    8 ++
 drivers/usb/c67x00/c67x00-sched.c            |    4 -
 drivers/usb/core/devio.c                     |    2 
 drivers/usb/core/hub.c                       |    7 +-
 drivers/usb/gadget/function/f_tcm.c          |    2 
 drivers/usb/misc/usbtest.c                   |    1 
 drivers/usb/serial/option.c                  |   20 ++++-
 drivers/usb/serial/spcp8x5.c                 |   13 ---
 fs/cifs/smb2ops.c                            |    4 -
 fs/ext4/fast_commit.c                        |   10 ++
 fs/ext4/ialloc.c                             |    4 +
 fs/ext4/super.c                              |   40 +++++------
 fs/jfs/inode.c                               |    2 
 fs/jfs/jfs_extent.c                          |   10 ++
 fs/nilfs2/ioctl.c                            |   21 +++++-
 include/linux/hid.h                          |    1 
 include/linux/inetdevice.h                   |    5 +
 include/linux/sched.h                        |    8 ++
 include/target/target_core_fabric.h          |    2 
 io_uring/io-wq.c                             |    9 +-
 kernel/bpf/offload.c                         |   10 +-
 kernel/kcov.c                                |   93 +++++++++++++--------------
 lib/Kconfig.debug                            |    5 -
 mm/swapfile.c                                |    7 ++
 net/core/filter.c                            |    1 
 net/ipv4/igmp.c                              |   14 ++--
 net/ipv6/ah6.c                               |   29 +++++---
 net/ipv6/mcast.c                             |    8 +-
 net/ipv6/seg6_local.c                        |    7 ++
 net/netfilter/ipvs/ip_vs_xmit.c              |    6 -
 net/nfc/nci/ntf.c                            |   32 +++++++--
 net/xfrm/espintcp.c                          |    9 ++
 net/xfrm/xfrm_user.c                         |    2 
 security/selinux/ss/conditional.c            |   12 +--
 sound/usb/midi.c                             |    2 
 49 files changed, 325 insertions(+), 165 deletions(-)

Aleksandr Nogikh (1):
      usb: usbtest: disable dynamic ID support

Asim Viladi Oglu Manizada (1):
      xfrm: ah6: validate routing header segments_left

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
      Linux 5.10.269

Griffin Kroah-Hartman (3):
      fpga: dfl: fme: add error handling
      usb: core: Add lock to usb_wakeup_notification()
      usb: core: Strengthen error handling in hub_hub_status()

Guanghui Yang (1):
      ext4: propagate errors from fast commit range replay

Haoxiang Li (1):
      accessibility: speakup: unregister tty ldisc on later init failures

Ibrahim Hashimov (1):
      nvmet-tcp: bound SGL data length before allocating command buffers

Ido Schimmel (1):
      ipv6: mcast: Fix use-after-free when processing MLD queries

Jiale Yao (1):
      USB: serial: option: fix slab OOB read in interrupt URB callback

Jiayuan Chen (1):
      bpf: Fix use-after-free in offloaded map/prog info fill

Johan Hovold (1):
      USB: serial: spcp8x5: drop broken carrier detect support

Jose Villaseñor Montfort (2):
      HID: magicmouse: do not keep a stale msc->input if no input is claimed
      HID: input: read battery capacity from its actual report offset

Kyle Zeng (1):
      ipv6: seg6: clear IPv4 control block on IPIP decapsulation

Marouane El Moufid (1):
      ALSA: usb-audio: fix OOB write in snd_usbmidi_novation_output()

Miguel Peñaranda (1):
      usb: usbfs: fix use-after-free of usb_device in usbdev_release()

Oliver Upton (1):
      KVM: arm64: Prevent access to vCPU events before init

Peiyang He (1):
      RDMA/rxe: Fix OOB in free_rd_atomic_resources()

Ryusuke Konishi (1):
      nilfs2: reject invalid block index in GC ioctl

Sabrina Dubroca (1):
      xfrm: espintcp: fix UAF during close

Samuel Page (1):
      nfc: nci: fix uninit-value in the RF discover/activated NTF handlers

Sasha Levin (3):
      Revert "PM: sleep: Use complete() in device_pm_sleep_init()"
      Revert "mtd: maps: vmu-flash: fix fault in unaligned fixup"
      Revert "smb: client: use kvzalloc() for megabyte buffer in simple fallocate"

Sebastian Andrzej Siewior (1):
      bpf: Remove tst_run from lwt_seg6local_prog_ops.

Shuangpeng Bai (2):
      usb: gadget: f_tcm: keep port count until LUN teardown completes
      USB: c67x00: fix use-after-free in c67x00_add_iso_urb()

Stephen Smalley (1):
      selinux: switch two allocations to use kzalloc_objs()

Tetsuo Handa (1):
      kcov: fix data corruption and race conditions on PREEMPT_RT

Thorsten Blum (2):
      crypto: atmel-tdes - use scatterlist length before DMA mapping
      crypto: mxs-dcp - fix source scatterlist length access

Vasiliy Kovalev (2):
      jfs: add check read-only before truncation in jfs_truncate_nolock()
      jfs: add check read-only before txBeginAnon() call

Vishnu Razdan (1):
      io_uring/io-wq: fix worker accounting when canceling creation callbacks

Zhiling Zou (1):
      xfrm: drop ESP-in-TCP packets with no ingress device

Zihan Xi (1):
      xfrm: fix xfrm_state_construct() auth-trunc leak

