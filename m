Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFFE49483F;
	Wed,  2 Sep 2026 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353048; cv=none; b=UJrl02tTB3R4MNrQNq3P1oUllGKLWPrxn5FaChqDY7UjGYZ0JgVuOpLhUp+J+MbBYo7G2rnyip5rCwcxw/g4Y1JltWJ4te9AwwdbOsQq1deq1KjU/n3DA2Z2PPKEA/NuSXOekVjjshxfoiqOf1fcBwIgyPmNh/5NDPOydcVzKG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353048; c=relaxed/simple;
	bh=YIpSN1iZKhnsbT7CWElk+qUWADd/kqv2lbKR8BN1WRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fBZh/DqLUkocGbv9W6J7VDnZyKOZ+ZG39AttrQkwOWXNlODxigBYa6F1uYLMoU4YEHcULROPJq29KQm5//LqyNnjrodHPcPEuaRC7lLfGc/cZuTbYXgM2Vqr3LlQCwEAmG6TQZORtqWrJIy2OpOTcy/kj4wiwsfdm4mE1JY3qGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JEBCnqXF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JEBCnqXF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347061F000E9;
	Wed,  2 Sep 2026 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788353045;
	bh=pGF1MklELjUuuvyf7piUsC/COvDy62eByxFss+L2Evk=;
	h=From:To:Cc:Subject:Date;
	b=JEBCnqXFdDoArXGt9ojdgyzB7AuhgG9pTtlUZNFMuZzaMH8Tevb3uXylHValJyjv5
	 +Jzmra+VmPl4T6CbZEf1xHdtggbpF7fRad9rqOhlfd7uHxKgbXza2pIKBiyBtH+AqC
	 1rAil1E1iia6oNfBj4GcP7MeQdTiyt0IGZENl9J0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.49
Date: Wed,  2 Sep 2026 14:43:49 +0200
Message-ID: <2026090250-negligent-spouse-d63b@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.49 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/filesystems/fscrypt.rst               |    4 
 Makefile                                            |    2 
 arch/powerpc/perf/hv-gpci.c                         |   24 +
 arch/riscv/kernel/compat_signal.c                   |    2 
 arch/riscv/kernel/ptrace.c                          |    4 
 arch/s390/kvm/vsie.c                                |    1 
 arch/x86/kernel/cpu/amd.c                           |    1 
 arch/x86/kvm/mmu/page_track.c                       |   32 ++
 arch/x86/kvm/svm/sev.c                              |   76 +++--
 arch/x86/kvm/svm/svm.c                              |    8 
 arch/x86/kvm/svm/svm.h                              |   13 -
 crypto/krb5/krb5_api.c                              |    8 
 drivers/accessibility/speakup/main.c                |    1 
 drivers/crypto/Kconfig                              |    1 
 drivers/crypto/atmel-tdes.c                         |    5 
 drivers/crypto/mxs-dcp.c                            |    2 
 drivers/crypto/qce/aead.c                           |   58 ----
 drivers/crypto/qce/common.c                         |   55 ----
 drivers/crypto/qce/common.h                         |   16 -
 drivers/crypto/qce/regs-v5.h                        |    4 
 drivers/crypto/qce/sha.c                            |   30 --
 drivers/crypto/qce/sha.h                            |    1 
 drivers/crypto/qce/skcipher.c                       |   97 -------
 drivers/crypto/qcom-rng.c                           |  156 +-----------
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c |    3 
 drivers/fpga/dfl-fme-perf.c                         |    2 
 drivers/gpu/drm/xe/xe_bo.h                          |   14 +
 drivers/gpu/drm/xe/xe_guc_ads.c                     |   92 ++++---
 drivers/gpu/drm/xe/xe_guc_ads_types.h               |    5 
 drivers/hid/hid-asus.c                              |   52 +---
 drivers/hid/hid-ft260.c                             |   41 ++-
 drivers/hid/hid-magicmouse.c                        |   25 +
 drivers/infiniband/sw/rxe/rxe_qp.c                  |   18 +
 drivers/net/gtp.c                                   |   21 +
 drivers/net/veth.c                                  |    3 
 drivers/net/vxlan/vxlan_core.c                      |    9 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c     |    4 
 drivers/nvme/host/tcp.c                             |    8 
 drivers/target/target_core_fabric_configfs.c        |    8 
 drivers/usb/c67x00/c67x00-sched.c                   |    4 
 drivers/usb/core/devio.c                            |    2 
 drivers/usb/core/hub.c                              |    7 
 drivers/usb/gadget/function/f_tcm.c                 |    2 
 drivers/usb/host/xhci-dbgtty.c                      |   15 -
 drivers/usb/host/xhci-ring.c                        |   20 +
 drivers/usb/misc/usbtest.c                          |    1 
 drivers/usb/serial/option.c                         |   20 +
 drivers/usb/serial/spcp8x5.c                        |   13 -
 fs/fuse/dir.c                                       |    9 
 fs/fuse/file.c                                      |    4 
 fs/smb/server/smb2pdu.c                             |    6 
 fs/smb/server/vfs_cache.c                           |  179 ++++++++++++--
 fs/smb/server/vfs_cache.h                           |    4 
 include/kunit/run-in-irq-context.h                  |   10 
 include/linux/io_uring_types.h                      |    8 
 include/linux/skbuff.h                              |   24 +
 include/target/target_core_fabric.h                 |    2 
 io_uring/eventfd.c                                  |    8 
 io_uring/eventfd.h                                  |    2 
 io_uring/futex.c                                    |   21 +
 io_uring/io_uring.c                                 |    7 
 io_uring/poll.c                                     |   23 -
 io_uring/rsrc.c                                     |   31 --
 io_uring/waitid.c                                   |    2 
 kernel/bpf/offload.c                                |   10 
 mm/swapfile.c                                       |    7 
 net/batman-adv/tvlv.c                               |    5 
 net/bridge/br_multicast.c                           |    4 
 net/ipv4/tcp_ao.c                                   |   19 +
 net/ipv6/ah6.c                                      |   29 +-
 net/ipv6/seg6_local.c                               |    7 
 net/netfilter/nf_tables_api.c                       |   36 +-
 net/netfilter/nft_set_pipapo_avx2.c                 |   17 -
 net/tls/tls_device.c                                |    3 
 net/xfrm/espintcp.c                                 |    9 
 net/xfrm/xfrm_nat_keepalive.c                       |   53 +++-
 net/xfrm/xfrm_user.c                                |    2 
 security/selinux/include/security.h                 |    1 
 security/selinux/ss/avtab.c                         |   35 ++
 security/selinux/ss/avtab.h                         |   13 +
 security/selinux/ss/conditional.c                   |   25 -
 security/selinux/ss/constraint.h                    |    1 
 security/selinux/ss/policydb.c                      |  254 ++++++++++++++++----
 security/selinux/ss/policydb.h                      |   31 +-
 security/selinux/ss/services.c                      |    8 
 sound/soc/codecs/nau8821.c                          |   13 +
 sound/usb/card.c                                    |   14 -
 sound/usb/midi.c                                    |    2 
 88 files changed, 1154 insertions(+), 774 deletions(-)

Aboorva Devarajan (1):
      powerpc/hv-gpci: fix preempt count leak in sysfs show paths

Aleksandr Nogikh (1):
      usb: usbtest: disable dynamic ID support

Antheas Kapenekakis (1):
      HID: asus: simplify RGB init sequence

Asim Viladi Oglu Manizada (1):
      xfrm: ah6: validate routing header segments_left

Baokun Li (2):
      fuse: fix invalidate lock leak on setattr writeback failure
      fuse: fix invalidate lock leak on open O_TRUNC DAX failure

Bartosz Golaszewski (1):
      crypto: qce - Remove unsafe/deprecated algorithms

Bryam Vargas (3):
      selinux: reject a permission value exceeding the class permission count
      selinux: require a class's permission values to cover its permission count
      crypto: virtio - bound the akcipher result length

Caleb Sander Mateos (1):
      io_uring: simplify IORING_SETUP_DEFER_TASKRUN && !SQPOLL check

Christian Borntraeger (1):
      KVM: s390: vsie: zero stale crypto bits

Christian Göttsche (2):
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

Eric Biggers (6):
      netfilter: nft_set_pipapo_avx2: add missing vzeroupper
      mm/swap: reject swapon() on filesystem-level encrypted files
      kunit: irq: Continue increasing hrtimer interval for longer
      crypto: qcom-rng - Enable clock in hwrng case
      crypto: qcom-rng - Remove crypto_rng interface
      crypto: qcom-rng - Allow zero as a random number

Fourie Zhang (1):
      netfilter: nf_tables: don't queue packet path object notifications

Greg Kroah-Hartman (1):
      Linux 6.18.49

Griffin Kroah-Hartman (3):
      fpga: dfl: fme: add error handling
      usb: core: Add lock to usb_wakeup_notification()
      usb: core: Strengthen error handling in hub_hub_status()

Haoxiang Li (1):
      accessibility: speakup: unregister tty ldisc on later init failures

Hyunwoo Kim (1):
      net/tcp-ao: fix use-after-free of current_key on reconnect to another peer

Ibrahim Hashimov (1):
      RDMA/rxe: Fix responder UAF on IB_QP_MAX_DEST_RD_ATOMIC modify_qp

Jan Sebastian Götte (1):
      crypto: krb5 - use kfree_sensitive() for derived key buffers

Jann Horn (1):
      HID: asus: fix missing hid_is_usb() check

Jens Axboe (2):
      io_uring/futex: only mark private futex waits as inflight
      io_uring: defer eventfd signaling when queued from a wakeup handler

Jesper Dangaard Brouer (1):
      veth: fix OOB txq access in veth_poll() with asymmetric queue counts

Jia Yao (3):
      drm/xe/guc_ads: allocate UM queues in a separate BO
      drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
      drm/xe/guc_ads: use uncached mapping for UM queue BO

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

Kyle Zeng (3):
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

Michal Pecio (1):
      usb: xhci: Handle bogus TRB pointers in Missed Service Error events

Miguel Peñaranda (1):
      usb: usbfs: fix use-after-free of usb_device in usbdev_release()

Norbert Szetei (1):
      net: bridge: mcast: fix use-after-free of a master VLAN's multicast context

Pankaj Gupta (1):
      KVM: SEV: Drop FOLL_WRITE for encrypted region registration

Pavel Begunkov (1):
      io_uring/rsrc: improve regbuf iov validation

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

Sabrina Dubroca (1):
      xfrm: espintcp: fix UAF during close

Sean Christopherson (4):
      KVM: SEV: Track the GPA of the guest-controlled VMSA used for SNP guests
      KVM: SEV: Extract loading of guest-provided VMSA to a separate helper
      KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if VMSA is unusable
      KVM: SEV: Wire up kvm_x86_ops.gmem_xxx() if and only if CONFIG_KVM_AMD_SEV=y

Semih Baskan (1):
      usb: xhci: Handle USB3 port events when there is one roothub

Shuangpeng Bai (2):
      usb: gadget: f_tcm: keep port count until LUN teardown completes
      USB: c67x00: fix use-after-free in c67x00_add_iso_urb()

Stephen Smalley (1):
      selinux: switch two allocations to use kzalloc_objs()

Thorsten Blum (2):
      crypto: atmel-tdes - use scatterlist length before DMA mapping
      crypto: mxs-dcp - fix source scatterlist length access

Wentao Guan (1):
      Revert "selinux: reject a permission value exceeding the class permission count"

Will Porter (1):
      ALSA: usb-audio: Complete cleanup after system-resume errors

Zhiling Zou (1):
      xfrm: drop ESP-in-TCP packets with no ingress device

Zihan Xi (3):
      xfrm: avoid lock inversion in nat keepalive work
      xfrm: fix xfrm_state_construct() auth-trunc leak
      xfrm: bound nat keepalive state collection

