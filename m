Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA949B1ED;
	Wed,  2 Sep 2026 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352947; cv=none; b=VXrdZBosSd7c/JenCvQnQUIaA2YVP/kFj4TFE7dqDv29Q7Ue+Grn/2vPOBF37M9NUulyKm074216B+qxWx0yx7R/YHddkdaVCx99NwQHpy59ATjLWnnRWSEGcrK9aKIzTzQ3NzB+Z8YVw3MDLOUl2pMiI8FuOSQV248C2fMXNW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352947; c=relaxed/simple;
	bh=rxEX1JaPfdMoFlK3BMXGbhz7Z9d8J8U1/ndsP5cMT0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G2PUd91BHj9DXsRYQJUvMsD562VRGqak2PFBSEAclwFkOp878yhA0sWfdkVGZZwq/7ynI1feCxq/fN3ZWCzdVy9TcKozlWQDqqtsj8JdTaMGwcPpC+k6eqSEvPOAPGbt9kl+Ay8dy7jJKIK4VifVLShnZXFK68D4tKnkRiU8VYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sW22mrhx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sW22mrhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5352D1F00A3A;
	Wed,  2 Sep 2026 12:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788352944;
	bh=UHxWELkrfthFslX8GDS7rsV3UZBhRorlhRCnPRcBUNg=;
	h=From:To:Cc:Subject:Date;
	b=sW22mrhxNPhCKOZfLKTj6beBc5/FW4q4T/+EAaaQ5j//ikYb28dJmTz3bo6j6+d1S
	 ssW17K0jYpqKwzSEOZzmxNWc8vvALy22iNGhC3sowYh4jAPHej4Vl5a6+4HxZAYSxN
	 k6AI6M36LRSIsgNYV+rsActQdHa3BBxNue2hT960=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.156
Date: Wed,  2 Sep 2026 14:42:15 +0200
Message-ID: <2026090216-eagle-skyrocket-95af@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.156 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/filesystems/fscrypt.rst                    |    4 
 Makefile                                                 |    2 
 arch/arm64/kvm/arm.c                                     |    6 
 arch/powerpc/perf/hv-gpci.c                              |   24 -
 arch/riscv/kernel/compat_signal.c                        |    2 
 arch/riscv/kernel/ptrace.c                               |    4 
 arch/s390/kvm/vsie.c                                     |    1 
 arch/x86/include/asm/cpufeatures.h                       |    4 
 arch/x86/kernel/cpu/amd.c                                |   28 +
 arch/x86/kvm/mmu/page_track.c                            |   32 +
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
 drivers/crypto/starfive/jh7110-rsa.c                     |    1 
 drivers/fpga/dfl-fme-perf.c                              |    2 
 drivers/hid/hid-ft260.c                                  |   41 ++
 drivers/hid/hid-magicmouse.c                             |   44 ++
 drivers/hid/hid-nintendo.c                               |   13 
 drivers/hid/hid-uclogic-core.c                           |   12 
 drivers/hid/usbhid/hid-pidff.c                           |   21 -
 drivers/infiniband/sw/rxe/rxe_qp.c                       |    3 
 drivers/isdn/hardware/mISDN/hfcpci.c                     |   12 
 drivers/media/platform/samsung/exynos4-is/fimc-is-regs.c |    1 
 drivers/net/ethernet/ibm/ibmvnic.c                       |   30 +
 drivers/nvme/host/constants.c                            |    2 
 drivers/nvme/host/core.c                                 |   32 -
 drivers/nvme/host/fabrics.c                              |    8 
 drivers/nvme/host/fault_inject.c                         |    2 
 drivers/nvme/host/fc.c                                   |    8 
 drivers/nvme/host/multipath.c                            |    2 
 drivers/nvme/host/nvme.h                                 |    4 
 drivers/nvme/host/pr.c                                   |   10 
 drivers/nvme/target/admin-cmd.c                          |   24 -
 drivers/nvme/target/core.c                               |   46 +-
 drivers/nvme/target/discovery.c                          |   14 
 drivers/nvme/target/fabrics-cmd-auth.c                   |   16 
 drivers/nvme/target/fabrics-cmd.c                        |   36 +-
 drivers/nvme/target/io-cmd-bdev.c                        |   12 
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
 fs/ext4/ext4.h                                           |    2 
 fs/ext4/extents.c                                        |   55 +--
 fs/ext4/fast_commit.c                                    |   35 +-
 fs/ext4/ialloc.c                                         |    4 
 fs/ext4/mballoc.c                                        |    4 
 fs/fuse/dir.c                                            |    9 
 fs/fuse/file.c                                           |    4 
 fs/jfs/inode.c                                           |    2 
 fs/jfs/jfs_discard.c                                     |    3 
 fs/jfs/jfs_extent.c                                      |   10 
 fs/nilfs2/ioctl.c                                        |  261 ++++++---------
 fs/smb/server/smb2pdu.c                                  |    6 
 fs/smb/server/vfs_cache.c                                |  179 +++++++++-
 fs/smb/server/vfs_cache.h                                |    4 
 fs/xfs/scrub/trace.h                                     |   12 
 include/linux/nvme.h                                     |   16 
 include/net/sch_generic.h                                |    1 
 include/target/target_core_fabric.h                      |    2 
 io_uring/io-wq.c                                         |    9 
 kernel/bpf/offload.c                                     |   10 
 kernel/bpf/verifier.c                                    |    5 
 kernel/events/core.c                                     |   10 
 mm/swapfile.c                                            |    7 
 net/bluetooth/hci_sync.c                                 |   48 ++
 net/bridge/br_multicast.c                                |    4 
 net/can/j1939/j1939-priv.h                               |    1 
 net/can/j1939/main.c                                     |    5 
 net/can/j1939/socket.c                                   |   55 +++
 net/core/dev.c                                           |    6 
 net/core/filter.c                                        |    1 
 net/ipv6/ah6.c                                           |   29 +
 net/ipv6/seg6_local.c                                    |    7 
 net/nfc/nci/ntf.c                                        |   26 +
 net/sched/sch_generic.c                                  |    2 
 net/smc/smc_clc.c                                        |   67 ++-
 net/smc/smc_core.c                                       |   27 -
 net/smc/smc_pnet.c                                       |   43 +-
 net/tls/tls_device.c                                     |    3 
 net/xfrm/espintcp.c                                      |    9 
 net/xfrm/xfrm_user.c                                     |    2 
 security/selinux/ss/conditional.c                        |   12 
 sound/soc/codecs/nau8821.c                               |   13 
 sound/usb/card.c                                         |   14 
 sound/usb/midi.c                                         |    2 
 107 files changed, 1137 insertions(+), 850 deletions(-)

Aboorva Devarajan (1):
      powerpc/hv-gpci: fix preempt count leak in sysfs show paths

Aleksandr Nogikh (1):
      usb: usbtest: disable dynamic ID support

Asim Viladi Oglu Manizada (1):
      xfrm: ah6: validate routing header segments_left

Baokun Li (3):
      ext4: make some fast commit functions reuse extents path
      fuse: fix invalidate lock leak on setattr writeback failure
      fuse: fix invalidate lock leak on open O_TRUNC DAX failure

Bartosz Golaszewski (1):
      crypto: qce - Remove unsafe/deprecated algorithms

Baul Lee (1):
      HID: pidff: fix OOB write when hid->inputs is empty

Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Add X86_FEATURE_ZEN5

Bryam Vargas (1):
      nfc: nci: add data_len bound checks to activation parameter extractors

Chengfeng Ye (1):
      Bluetooth: hci_sync: Fix accept list UAF during suspend

Christian Borntraeger (1):
      KVM: s390: vsie: zero stale crypto bits

Christopher Kodama (1):
      HID: magicmouse: re-enable multitouch after reset-resume

Cristian Ciocaltea (2):
      ASoC: nau8821: Cancel delayed work on component remove
      ASoC: nau8821: Cancel pending work before suspend

DaeMyung Kang (1):
      ksmbd: harden file lifetime during session teardown

Darrick J. Wong (1):
      xfs: remove file_path tracepoint data

Dylan Wolff (1):
      jfs: Fix null-ptr-deref in jfs_ioc_trim

Eric Biggers (2):
      ext4: don't enable DAX on new encrypted files
      mm/swap: reject swapon() on filesystem-level encrypted files

Eric Dumazet (1):
      net/sched: Fix mirred deadlock on device recursion

Greg Kroah-Hartman (1):
      Linux 6.6.156

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

Jia Jie Ho (1):
      crypto: starfive - Do not free stack buffer

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

Johannes Berg (1):
      net/sched: initialize noop_qdisc owner

Jose Villaseñor Montfort (1):
      HID: magicmouse: prevent unbounded recursion in magicmouse_raw_event()

Kemeng Shi (1):
      ext4: make state in ext4_mb_mark_bb to be bool

Kuniyuki Iwashima (4):
      smc: Fix use-after-free in __pnet_find_base_ndev().
      smc: Use __sk_dst_get() and dst_dev_rcu() in in smc_clc_prfx_set().
      smc: Use __sk_dst_get() and dst_dev_rcu() in smc_clc_prfx_match().
      smc: Use __sk_dst_get() and dst_dev_rcu() in smc_vlan_by_tcpsk().

Kyle Zeng (2):
      perf: Reject exited events as group leaders
      ipv6: seg6: clear IPv4 control block on IPIP decapsulation

Lucas De Marchi (2):
      xhci: dbgtty: Fix unregister on tty_register_driver() failure
      xhci: dbgtty: Fix unregister on tty_alloc_driver() failure

Mario Limonciello (1):
      x86/CPU/AMD: Add more models to X86_FEATURE_ZEN5

Marouane El Moufid (1):
      ALSA: usb-audio: fix OOB write in snd_usbmidi_novation_output()

Md Sadre Alam (1):
      crypto: qce - fix CCM AAD buffer underallocation

Michael Neuling (1):
      riscv: Fix register corruption from uninitialized cregs on error

Michael Zaidman (1):
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

Peiyang He (1):
      RDMA/rxe: Fix OOB in free_rd_atomic_resources()

Perry Yuan (1):
      x86/CPU/AMD: Add models 0x60-0x6f to the Zen5 range

Pratik Vishwakarma (1):
      x86/CPU/AMD: Carve out a Zen5 models range

Ralf Lici (1):
      Revert "usb: phy: fsl-usb: Fix use-after-free in delayed work during device removal"

Raman Varabets (1):
      HID: ft260: fix stack-use-after-return write in I2C read race

Ryusuke Konishi (2):
      nilfs2: correct return value kernel-doc descriptions for ioctl functions
      nilfs2: reject invalid block index in GC ioctl

Sabrina Dubroca (1):
      xfrm: espintcp: fix UAF during close

Sasha Levin (1):
      Revert "PM: sleep: Use complete() in device_pm_sleep_init()"

Sebastian Andrzej Siewior (1):
      bpf: Remove tst_run from lwt_seg6local_prog_ops.

Semih Baskan (1):
      usb: xhci: Handle USB3 port events when there is one roothub

Shuangpeng Bai (2):
      usb: gadget: f_tcm: keep port count until LUN teardown completes
      USB: c67x00: fix use-after-free in c67x00_add_iso_urb()

Stephen Smalley (1):
      selinux: switch two allocations to use kzalloc_objs()

Tao Lyu (1):
      bpf: Ensure reg is PTR_TO_STACK in process_iter_arg

Tetsuo Handa (3):
      can: j1939: implement NETDEV_UNREGISTER notification handler
      can: j1939: add missing calls in NETDEV_UNREGISTER notification handler
      can: j1939: make j1939_sk_bind() fail if device is no longer registered

Thorsten Blum (2):
      crypto: atmel-tdes - use scatterlist length before DMA mapping
      crypto: mxs-dcp - fix source scatterlist length access

Tomasz Pakuła (2):
      HID: pidff: Support device error response from PID_BLOCK_LOAD
      HID: pidff: clang-format pass

Vasiliy Kovalev (2):
      jfs: add check read-only before truncation in jfs_truncate_nolock()
      jfs: add check read-only before txBeginAnon() call

Vishnu Razdan (1):
      io_uring/io-wq: fix worker accounting when canceling creation callbacks

Vladimir Riabchun (1):
      mISDN: hfcpci: Fix warning when deleting uninitialized timer

Weiwen Hu (3):
      nvme: rename nvme_sc_to_pr_err to nvme_status_to_pr_err
      nvme: fix status magic numbers
      nvme: rename CDR/MORE/DNR to NVME_STATUS_*

Wenkuan Wang (1):
      x86/CPU/AMD: Add models 0x10-0x1f to the Zen5 range

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

