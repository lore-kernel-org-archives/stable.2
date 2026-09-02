Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE23D4963BA;
	Wed,  2 Sep 2026 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353050; cv=none; b=m+Rr4xLrhDIdMvF13CJv+41x6SRwx2fs9fpMzT7sdxRivtDHt5+BHBS1ja0X25YtRcBFUW37v2owJ0owdmUDq9cSAYb3alobwcCKEtxi00WTFC8Eid8Z2Qo4A09NUX2W9OeZBTI5HXwIUOC4D+pT4nCFC1qQluzZgD2pr0bqKCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353050; c=relaxed/simple;
	bh=r6dx4nhXwrCxI9LiTslAIBB/S77Ek/vRbcPGfGGHWUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TZHLFrXO6gYRbRklaUcmaSYvMui47cM6zlKZ9Na39Bi7NEiXzVJgVdpKRUh9xsdmrHAfwsJ6Fq5CEjS56xrcTbLYQyIN0+89+S00lmkaOZ9vMjhVRZyAyeS0rbT+c3yvFHaRUZPHwMlKsKqvpQ+l3XgTZsoSKjGB2opoW1TNVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZmWgsBiJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZmWgsBiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC0F1F00A3A;
	Wed,  2 Sep 2026 12:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788353048;
	bh=SC0GYPlro9s+3EhqkrleD4GftFB6MdEsL1tGX4rhSVA=;
	h=From:To:Cc:Subject:Date;
	b=ZmWgsBiJhIynhe6PSB7BJo0+KeSo2vO2s4IZh1tc6k1tgsjIws1mZ2noRbFiwljjg
	 6Iy2e5n1ekpe//EmTjyYZ5TQqmvid6JNWdB2Pnq80+qk6G1B6P0x5AYLPtXqzn/d28
	 9/akGCm68c1ap7NKNcULTWlJjOBDbZNVlC75UzNo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.2.3
Date: Wed,  2 Sep 2026 14:43:56 +0200
Message-ID: <2026090256-starlight-pope-8a2a@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.2.3 kernel.

All users of the 7.2 kernel series must upgrade.

The updated 7.2.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.2.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/filesystems/fscrypt.rst                    |    4 
 Makefile                                                 |    2 
 arch/s390/kvm/vsie.c                                     |    1 
 arch/x86/kvm/svm/sev.c                                   |   99 ++++++--
 arch/x86/kvm/svm/svm.c                                   |    8 
 arch/x86/kvm/svm/svm.h                                   |   13 -
 crypto/krb5/krb5_api.c                                   |    8 
 drivers/accessibility/speakup/main.c                     |    1 
 drivers/crypto/Kconfig                                   |    1 
 drivers/crypto/allwinner/Kconfig                         |   16 -
 drivers/crypto/allwinner/sun8i-ce/Makefile               |    1 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c        |   63 -----
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c        |  159 -------------
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h             |   29 --
 drivers/crypto/allwinner/sun8i-ss/Makefile               |    1 
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c        |   45 ---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c        |  177 ---------------
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h             |   23 -
 drivers/crypto/atmel-tdes.c                              |    5 
 drivers/crypto/intel/iaa/iaa_crypto_main.c               |  111 +++++----
 drivers/crypto/intel/iaa/iaa_crypto_stats.c              |    9 
 drivers/crypto/intel/iaa/iaa_crypto_stats.h              |    2 
 drivers/crypto/mxs-dcp.c                                 |    2 
 drivers/crypto/qce/aead.c                                |   58 ----
 drivers/crypto/qce/common.c                              |   55 +---
 drivers/crypto/qce/common.h                              |   16 -
 drivers/crypto/qce/regs-v5.h                             |    4 
 drivers/crypto/qce/sha.c                                 |   30 --
 drivers/crypto/qce/sha.h                                 |    1 
 drivers/crypto/qce/skcipher.c                            |   97 --------
 drivers/crypto/qcom-rng.c                                |  156 ++-----------
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c      |    3 
 drivers/fpga/dfl-fme-perf.c                              |    2 
 drivers/infiniband/sw/rxe/rxe_qp.c                       |   18 +
 drivers/net/gtp.c                                        |   21 +
 drivers/net/vxlan/vxlan_core.c                           |    9 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c          |    4 
 drivers/nvme/host/tcp.c                                  |    8 
 drivers/target/target_core_fabric_configfs.c             |    8 
 drivers/usb/c67x00/c67x00-sched.c                        |    4 
 drivers/usb/core/devio.c                                 |    2 
 drivers/usb/core/hub.c                                   |    7 
 drivers/usb/gadget/function/f_tcm.c                      |    2 
 drivers/usb/host/xhci-dbgtty.c                           |   15 -
 drivers/usb/host/xhci-ring.c                             |   20 +
 drivers/usb/host/xhci.c                                  |   11 
 drivers/usb/misc/usbtest.c                               |    1 
 drivers/usb/serial/option.c                              |   20 +
 drivers/usb/serial/spcp8x5.c                             |   13 -
 fs/fuse/dev.c                                            |   41 +--
 fs/fuse/dev_uring.c                                      |   20 -
 fs/fuse/dir.c                                            |    9 
 fs/fuse/file.c                                           |    4 
 include/kunit/run-in-irq-context.h                       |   10 
 include/linux/skbuff.h                                   |   24 ++
 include/net/ip.h                                         |   25 ++
 include/net/ip6_route.h                                  |   37 +++
 include/net/tcp.h                                        |    5 
 include/target/target_core_fabric.h                      |    2 
 mm/swapfile.c                                            |    7 
 net/8021q/vlan_dev.c                                     |   39 ---
 net/batman-adv/tvlv.c                                    |    5 
 net/bridge/br_multicast.c                                |    4 
 net/ipv4/route.c                                         |    4 
 net/ipv4/tcp_ao.c                                        |   19 +
 net/ipv4/tcp_ipv4.c                                      |    2 
 net/ipv4/tcp_minisocks.c                                 |    2 
 net/ipv4/tcp_output.c                                    |    6 
 net/ipv6/ah6.c                                           |   29 +-
 net/ipv6/route.c                                         |    2 
 net/ipv6/seg6_local.c                                    |    7 
 net/ipv6/tcp_ipv6.c                                      |    2 
 net/netfilter/nf_tables_api.c                            |   36 +--
 net/netfilter/nft_set_pipapo_avx2.c                      |   17 -
 net/packet/af_packet.c                                   |   96 +++++++-
 net/tls/tls_device.c                                     |    3 
 net/xfrm/espintcp.c                                      |    9 
 net/xfrm/xfrm_nat_keepalive.c                            |   53 +++-
 net/xfrm/xfrm_user.c                                     |    2 
 sound/usb/card.c                                         |   14 -
 sound/usb/midi.c                                         |    2 
 sound/usb/quirks-table.h                                 |   10 
 tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c |   14 +
 83 files changed, 746 insertions(+), 1180 deletions(-)

Aleksandr Nogikh (1):
      usb: usbtest: disable dynamic ID support

Asim Viladi Oglu Manizada (1):
      xfrm: ah6: validate routing header segments_left

Baokun Li (2):
      fuse: fix invalidate lock leak on setattr writeback failure
      fuse: fix invalidate lock leak on open O_TRUNC DAX failure

Bartosz Golaszewski (1):
      crypto: qce - Remove unsafe/deprecated algorithms

Breno Leitao (1):
      usb: xhci: bail out of setup if the controller is inaccessible

Bryam Vargas (1):
      crypto: virtio - bound the akcipher result length

Christian Borntraeger (1):
      KVM: s390: vsie: zero stale crypto bits

Devin Wittmayer (1):
      wifi: mt76: mt7925: ensure tx headroom in usb_sdio_tx_prepare_skb

Dmitry Bogdanov (1):
      nvme-tcp: fix usage of page_frag_cache

Eric Biggers (8):
      netfilter: nft_set_pipapo_avx2: add missing vzeroupper
      mm/swap: reject swapon() on filesystem-level encrypted files
      kunit: irq: Continue increasing hrtimer interval for longer
      crypto: qcom-rng - Enable clock in hwrng case
      crypto: qcom-rng - Remove crypto_rng interface
      crypto: qcom-rng - Allow zero as a random number
      crypto: sun8i-ce - Remove crypto_rng interface
      crypto: sun8i-ss - Remove crypto_rng interface

Eric Dumazet (1):
      vlan: fix skb_under_panic and races when toggling HW VLAN offload

Fourie Zhang (1):
      netfilter: nf_tables: don't queue packet path object notifications

Giovanni Cabiddu (1):
      crypto: iaa - fall back to software for multi-entry scatterlists

Greg Kroah-Hartman (1):
      Linux 7.2.3

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

Jiale Yao (1):
      USB: serial: option: fix slab OOB read in interrupt URB callback

Jiayuan Chen (3):
      selftests/bpf: Fix test_maps sockmap failure
      tls: device: fix out-of-bounds write in tls_append_frag()
      net: advertise TCP MSS from the configured MTU, not the learned PMTU

Joanne Koong (2):
      fuse: fix missing barrier when checking io-uring readiness
      fuse: publish io-uring queues with release semantics

Johan Hovold (1):
      USB: serial: spcp8x5: drop broken carrier detect support

Kyle Zeng (4):
      net/packet: defer vmalloc TX_RING free until skbs finish
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

Michal Pecio (1):
      usb: xhci: Handle bogus TRB pointers in Missed Service Error events

Miguel Peñaranda (1):
      usb: usbfs: fix use-after-free of usb_device in usbdev_release()

Miklos Szeredi (1):
      fuse: fix race between interrupt and resend

Norbert Szetei (1):
      net: bridge: mcast: fix use-after-free of a master VLAN's multicast context

Pankaj Gupta (1):
      KVM: SEV: Drop FOLL_WRITE for encrypted region registration

Peiyang He (1):
      RDMA/rxe: Fix OOB in free_rd_atomic_resources()

Qing Ming (2):
      gtp: serialize PDP context updates
      tcp: fix AO info use-after-free in tcp_ao_connect_init()

Rastislav Szabo (1):
      net/tcp: fix TCP-AO key deletion in VRFs

Rochan Avlur (1):
      fuse: wait for FR_FINISHED on abort_on_kill to prevent use-after-free

Sabrina Dubroca (1):
      xfrm: espintcp: fix UAF during close

Sean Christopherson (5):
      KVM: SEV: Allocate full pages for {DE,EN}CRYPT ops on SNP-enabled hosts
      KVM: SEV: Track the GPA of the guest-controlled VMSA used for SNP guests
      KVM: SEV: Extract loading of guest-provided VMSA to a separate helper
      KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if VMSA is unusable
      KVM: SEV: Wire up kvm_x86_ops.gmem_xxx() if and only if CONFIG_KVM_AMD_SEV=y

Semih Baskan (1):
      usb: xhci: Handle USB3 port events when there is one roothub

Shuangpeng Bai (2):
      usb: gadget: f_tcm: keep port count until LUN teardown completes
      USB: c67x00: fix use-after-free in c67x00_add_iso_urb()

Thorsten Blum (2):
      crypto: atmel-tdes - use scatterlist length before DMA mapping
      crypto: mxs-dcp - fix source scatterlist length access

Trevor Vorhees (1):
      ALSA: usb-audio: Fix sample rates for PreSonus AudioBox USB

Will Porter (1):
      ALSA: usb-audio: Complete cleanup after system-resume errors

Yong Wang (1):
      tcp: clamp route advmss to TCP_MIN_MSS

Zhiling Zou (1):
      xfrm: drop ESP-in-TCP packets with no ingress device

Zihan Xi (3):
      xfrm: avoid lock inversion in nat keepalive work
      xfrm: fix xfrm_state_construct() auth-trunc leak
      xfrm: bound nat keepalive state collection

