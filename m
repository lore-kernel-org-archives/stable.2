Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD6949C4D1;
	Wed,  2 Sep 2026 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353028; cv=none; b=NbZIN1fVidw4X6rDm6RmdVhwn5E5/lbv8xyocaNA9jKlU1/IEgkal2dL+VYErUj3Lv+pKN5bC9/UZcH/Bg9UNJSFxfzBBZnkp5xUWQMi1UUSmYC1iDP6sY8XaGiQLSmBeqSYMxZLjWqv+E2HEaYfJpAWl1NEOK2qsurNsjbW48M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353028; c=relaxed/simple;
	bh=fMiuY/ZmwJVfUUZ8zNL/PplF1zt4YdfaIZX9rFHy90o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KBY5kN+lX1csk7bKUmGaStl6oHSZEc96WD7GG6TAOqBexr/qykwwaoYCPs5rf970L7nwzJ34qT1cJ85hNdbK96Jr2BEvqhc/l7GKRSWgkW+euNrWaLDiPW05cOlMiMaZM3flP3csI91Eejlw2DOLBsf7g+Pu+G0BOmG0miniXrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bZDNJXFs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bZDNJXFs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E6A1F000E9;
	Wed,  2 Sep 2026 12:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788353025;
	bh=RFIsdc4GilL0V/CvdqJoThlCVjTtqtGWqa2By/cUVjA=;
	h=From:To:Cc:Subject:Date;
	b=bZDNJXFstjEv6gdfJPX6UKL4NMlfbamU9x8UIC9Xb8cvVqQkffhwmVtlyoyuFAKCN
	 7UMKzPhljZ3N/H2yE6nA41Dms69G6rnaFXpX8UBTE40unr7OhjEnmaKgmzJjYNREi9
	 1MAEmS/P5C7TfJ0liF0joTDqAQK5OBXPq7Ku2gPU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.108
Date: Wed,  2 Sep 2026 14:43:39 +0200
Message-ID: <2026090240-tricycle-broadways-7c91@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.108 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/filesystems/fscrypt.rst                    |    4 
 Makefile                                                 |    2 
 arch/arm64/kvm/arm.c                                     |    6 
 arch/powerpc/perf/hv-gpci.c                              |   24 
 arch/riscv/kernel/compat_signal.c                        |    2 
 arch/riscv/kernel/ptrace.c                               |    4 
 arch/s390/kvm/vsie.c                                     |    1 
 arch/x86/kernel/cpu/amd.c                                |    1 
 arch/x86/kvm/mmu/page_track.c                            |   32 +
 drivers/accessibility/speakup/main.c                     |    1 
 drivers/base/power/main.c                                |    6 
 drivers/crypto/Kconfig                                   |    1 
 drivers/crypto/atmel-tdes.c                              |    5 
 drivers/crypto/mxs-dcp.c                                 |    2 
 drivers/crypto/qce/aead.c                                |   58 --
 drivers/crypto/qce/common.c                              |   55 --
 drivers/crypto/qce/common.h                              |   16 
 drivers/crypto/qce/regs-v5.h                             |    4 
 drivers/crypto/qce/sha.c                                 |   30 -
 drivers/crypto/qce/sha.h                                 |    1 
 drivers/crypto/qce/skcipher.c                            |   97 ---
 drivers/crypto/qcom-rng.c                                |  156 +-----
 drivers/fpga/dfl-fme-perf.c                              |    2 
 drivers/hid/hid-asus.c                                   |   52 --
 drivers/hid/hid-ft260.c                                  |   41 +
 drivers/hid/hid-magicmouse.c                             |   25 -
 drivers/hid/hid-uclogic-core.c                           |   12 
 drivers/hid/uhid.c                                       |    8 
 drivers/hid/usbhid/hid-pidff.c                           |  106 ++--
 drivers/infiniband/sw/rxe/rxe_qp.c                       |   18 
 drivers/isdn/hardware/mISDN/hfcpci.c                     |   12 
 drivers/media/platform/samsung/exynos4-is/fimc-is-regs.c |    1 
 drivers/net/ethernet/ibm/ibmvnic.c                       |   30 -
 drivers/net/gtp.c                                        |   21 
 drivers/net/veth.c                                       |    3 
 drivers/net/vxlan/vxlan_core.c                           |    9 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c          |    4 
 drivers/nvme/host/tcp.c                                  |    8 
 drivers/target/target_core_fabric_configfs.c             |    8 
 drivers/usb/c67x00/c67x00-sched.c                        |    4 
 drivers/usb/core/devio.c                                 |    2 
 drivers/usb/core/hub.c                                   |    7 
 drivers/usb/gadget/function/f_tcm.c                      |    2 
 drivers/usb/host/xhci-dbgtty.c                           |   15 
 drivers/usb/host/xhci-ring.c                             |    2 
 drivers/usb/misc/usbtest.c                               |    1 
 drivers/usb/serial/option.c                              |   20 
 drivers/usb/serial/spcp8x5.c                             |   13 
 fs/exfat/nls.c                                           |    1 
 fs/ext4/crypto.c                                         |   40 -
 fs/ext4/ialloc.c                                         |    4 
 fs/fuse/dir.c                                            |    9 
 fs/fuse/file.c                                           |    4 
 fs/jfs/inode.c                                           |    2 
 fs/jfs/jfs_discard.c                                     |    3 
 fs/jfs/jfs_extent.c                                      |   10 
 fs/nilfs2/ioctl.c                                        |  253 ++++------
 fs/smb/server/smb2pdu.c                                  |    6 
 fs/smb/server/vfs_cache.c                                |  179 ++++++-
 fs/smb/server/vfs_cache.h                                |    4 
 include/linux/skbuff.h                                   |   24 
 include/target/target_core_fabric.h                      |    2 
 io_uring/io-wq.c                                         |    9 
 kernel/bpf/offload.c                                     |   10 
 kernel/events/core.c                                     |   10 
 kernel/trace/ring_buffer.c                               |    2 
 mm/swapfile.c                                            |    7 
 net/batman-adv/tvlv.c                                    |    5 
 net/bluetooth/hci_sync.c                                 |   48 +
 net/bridge/br_multicast.c                                |    4 
 net/can/j1939/j1939-priv.h                               |    1 
 net/can/j1939/main.c                                     |    5 
 net/can/j1939/socket.c                                   |   55 ++
 net/ipv4/tcp_ao.c                                        |   19 
 net/ipv6/ah6.c                                           |   29 -
 net/ipv6/seg6_local.c                                    |    7 
 net/netfilter/nf_tables_api.c                            |   36 -
 net/nfc/nci/ntf.c                                        |   26 -
 net/smc/smc_clc.c                                        |   67 +-
 net/smc/smc_core.c                                       |   27 -
 net/smc/smc_pnet.c                                       |   43 -
 net/tls/tls_device.c                                     |    3 
 net/xfrm/espintcp.c                                      |    9 
 net/xfrm/xfrm_nat_keepalive.c                            |   53 +-
 net/xfrm/xfrm_user.c                                     |    2 
 security/selinux/include/security.h                      |    1 
 security/selinux/ss/avtab.c                              |   43 +
 security/selinux/ss/avtab.h                              |   21 
 security/selinux/ss/conditional.c                        |   47 -
 security/selinux/ss/conditional.h                        |    6 
 security/selinux/ss/constraint.h                         |    1 
 security/selinux/ss/ebitmap.c                            |    4 
 security/selinux/ss/ebitmap.h                            |    5 
 security/selinux/ss/mls.c                                |    6 
 security/selinux/ss/policydb.c                           |  375 ++++++++++-----
 security/selinux/ss/policydb.h                           |   51 +-
 security/selinux/ss/services.c                           |    8 
 sound/soc/codecs/nau8821.c                               |   13 
 sound/usb/card.c                                         |   14 
 sound/usb/midi.c                                         |    2 
 100 files changed, 1483 insertions(+), 1066 deletions(-)

Aboorva Devarajan (1):
      powerpc/hv-gpci: fix preempt count leak in sysfs show paths

Aleksandr Nogikh (1):
      usb: usbtest: disable dynamic ID support

Ankit Khushwaha (1):
      ring buffer: Propagate __rb_map_vma return value to caller

Antheas Kapenekakis (1):
      HID: asus: simplify RGB init sequence

Asim Viladi Oglu Manizada (1):
      xfrm: ah6: validate routing header segments_left

Baokun Li (2):
      fuse: fix invalidate lock leak on setattr writeback failure
      fuse: fix invalidate lock leak on open O_TRUNC DAX failure

Bartosz Golaszewski (1):
      crypto: qce - Remove unsafe/deprecated algorithms

Baul Lee (1):
      HID: pidff: fix OOB write when hid->inputs is empty

Bryam Vargas (3):
      selinux: reject a permission value exceeding the class permission count
      selinux: require a class's permission values to cover its permission count
      nfc: nci: add data_len bound checks to activation parameter extractors

Carlos Llamas (1):
      HID: uhid: convert to hid_safe_input_report()

Chengfeng Ye (1):
      Bluetooth: hci_sync: Fix accept list UAF during suspend

Christian Borntraeger (1):
      KVM: s390: vsie: zero stale crypto bits

Christian Göttsche (5):
      selinux: use known type instead of void pointer
      selinux: avoid unnecessary indirection in struct level_datum
      selinux: make more use of str_read() when loading the policy
      selinux: use u16 for security classes
      selinux: more strict policy parsing

Cristian Ciocaltea (2):
      ASoC: nau8821: Cancel delayed work on component remove
      ASoC: nau8821: Cancel pending work before suspend

DaeMyung Kang (1):
      ksmbd: harden file lifetime during session teardown

Devin Wittmayer (1):
      wifi: mt76: mt7925: ensure tx headroom in usb_sdio_tx_prepare_skb

Dmitry Bogdanov (1):
      nvme-tcp: fix usage of page_frag_cache

Dylan Wolff (1):
      jfs: Fix null-ptr-deref in jfs_ioc_trim

Eric Biggers (5):
      ext4: don't enable DAX on new encrypted files
      mm/swap: reject swapon() on filesystem-level encrypted files
      crypto: qcom-rng - Enable clock in hwrng case
      crypto: qcom-rng - Allow zero as a random number
      crypto: qcom-rng - Remove crypto_rng interface

Fourie Zhang (1):
      netfilter: nf_tables: don't queue packet path object notifications

Greg Kroah-Hartman (1):
      Linux 6.12.108

Griffin Kroah-Hartman (3):
      fpga: dfl: fme: add error handling
      usb: core: Add lock to usb_wakeup_notification()
      usb: core: Strengthen error handling in hub_hub_status()

Haoxiang Li (1):
      accessibility: speakup: unregister tty ldisc on later init failures

Hyunwoo Kim (1):
      net/tcp-ao: fix use-after-free of current_key on reconnect to another peer

Ibrahim Hashimov (2):
      RDMA/rxe: Fix responder UAF on IB_QP_MAX_DEST_RD_ATOMIC modify_qp
      HID: uclogic: fix use-after-free of inrange_timer on remove

Jann Horn (1):
      HID: asus: fix missing hid_is_usb() check

Jesper Dangaard Brouer (1):
      veth: fix OOB txq access in veth_poll() with asymmetric queue counts

Jiale Yao (1):
      USB: serial: option: fix slab OOB read in interrupt URB callback

Jiayuan Chen (2):
      bpf: Fix use-after-free in offloaded map/prog info fill
      tls: device: fix out-of-bounds write in tls_append_frag()

Jinu Kim (1):
      KVM: x86/mmu: Check write tracking in all address spaces

Johan Hovold (1):
      USB: serial: spcp8x5: drop broken carrier detect support

Jose Villaseñor Montfort (1):
      HID: magicmouse: prevent unbounded recursion in magicmouse_raw_event()

Kuniyuki Iwashima (4):
      smc: Fix use-after-free in __pnet_find_base_ndev().
      smc: Use __sk_dst_get() and dst_dev_rcu() in in smc_clc_prfx_set().
      smc: Use __sk_dst_get() and dst_dev_rcu() in smc_clc_prfx_match().
      smc: Use __sk_dst_get() and dst_dev_rcu() in smc_vlan_by_tcpsk().

Kyle Zeng (4):
      perf: Reject exited events as group leaders
      ipv6: seg6: clear IPv4 control block on IPIP decapsulation
      batman-adv: reject unrepresentable multicast TVLV offsets
      vxlan: keep the last remote linked during FDB flush

Lucas De Marchi (2):
      xhci: dbgtty: Fix unregister on tty_register_driver() failure
      xhci: dbgtty: Fix unregister on tty_alloc_driver() failure

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

Pratik Vishwakarma (1):
      x86/CPU/AMD: Carve out a Zen5 models range

Qing Ming (2):
      gtp: serialize PDP context updates
      tcp: fix AO info use-after-free in tcp_ao_connect_init()

Raman Varabets (1):
      HID: ft260: fix stack-use-after-return write in I2C read race

Rastislav Szabo (1):
      net/tcp: fix TCP-AO key deletion in VRFs

Ryusuke Konishi (2):
      nilfs2: correct return value kernel-doc descriptions for ioctl functions
      nilfs2: reject invalid block index in GC ioctl

Sabrina Dubroca (1):
      xfrm: espintcp: fix UAF during close

Sasha Levin (1):
      Revert "PM: sleep: Use complete() in device_pm_sleep_init()"

Semih Baskan (1):
      usb: xhci: Handle USB3 port events when there is one roothub

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

Tomasz Pakuła (3):
      HID: pidff: Rework pidff_set_time() to fix warnings
      HID: pidff: Use ARRAY_SIZE macro instead of sizeof
      HID: pidff: clang-format pass

Vasiliy Kovalev (2):
      jfs: add check read-only before truncation in jfs_truncate_nolock()
      jfs: add check read-only before txBeginAnon() call

Vishnu Razdan (1):
      io_uring/io-wq: fix worker accounting when canceling creation callbacks

Vladimir Riabchun (1):
      mISDN: hfcpci: Fix warning when deleting uninitialized timer

Wentao Liang (1):
      media: platform: exynos4-is: Add hardware sync wait to fimc_is_hw_change_mode()

Will Porter (1):
      ALSA: usb-audio: Complete cleanup after system-resume errors

Zhiling Zou (1):
      xfrm: drop ESP-in-TCP packets with no ingress device

Zihan Xi (3):
      xfrm: avoid lock inversion in nat keepalive work
      xfrm: fix xfrm_state_construct() auth-trunc leak
      xfrm: bound nat keepalive state collection

Zijun Hu (1):
      Bluetooth: hci_sync: Use bt_dev_err() to log error message in hci_update_event_filter_sync()

