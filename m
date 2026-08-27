Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8867377A9B;
	Thu, 27 Aug 2026 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835438; cv=none; b=JhL6OZNcrq5rgf0xNJt5gvRV8J0wFuB4ZVmcJxLS7g94q2xdaKVBV5iXTLrvcDxYZTqCZ7b1liC+sCM4GAruEj9OQ/nXEBcx9gNYXAjI+7LuXxS3dn4aaAkIHrW/P2OEDRk2nahPIi6HkezPUv+0uIwtVEQJO5HDU1yhB6hzxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835438; c=relaxed/simple;
	bh=3eflTVs6YPICD4lSFYFIgUNCEw4+20HCVpILSYNVOc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YsX9RQi+H/41rXiZXPb42ytjPxQXFMroyUw34GjfZaMf9qwzstgASI19TsbZKbmqcVe2DFFD/nMsAc/yczHnk41ZHEGdLkp5V/eqEQaXF7j+mvir+ZjBaNysLKHDG3xBMtTMTuSwxDnkqbKjq0rK94ykvmmKwK/51udGYY0p6G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E6opocok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E6opocok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4941F00A3A;
	Thu, 27 Aug 2026 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787835409;
	bh=bM9eL4Y0tjOXBrPKgYydDg88Bgcc40RlPON42y/bnY8=;
	h=From:To:Cc:Subject:Date;
	b=E6opocokOXyUcRReF9UZxauw/CWORDF0zPx745X7f2Ck27Rkc1zD1TEbBWxXWL8ek
	 yj0Aj9bouG45+ehpC1OPJ/RaNSnFwWqm+JD/8GvT4hVz3YglSiOucrNvTFDwcPnJw8
	 bD0LWWnQV3mM6CyaOuIicbSkslwHNXGeZDD+XERM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.218
Date: Thu, 27 Aug 2026 14:56:42 +0200
Message-ID: <2026082743-unhappily-famine-cfe4@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.218 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                   |    2 
 arch/arm64/kvm/mmu.c                       |   10 
 arch/mips/kvm/mmu.c                        |   12 -
 arch/powerpc/include/asm/kvm_book3s_64.h   |    2 
 arch/powerpc/kvm/book3s_64_mmu_host.c      |    4 
 arch/powerpc/kvm/book3s_64_mmu_hv.c        |    4 
 arch/powerpc/kvm/book3s_64_mmu_radix.c     |    6 
 arch/powerpc/kvm/book3s_64_vio_hv.c        |    2 
 arch/powerpc/kvm/book3s_hv_nested.c        |    2 
 arch/powerpc/kvm/book3s_hv_rm_mmu.c        |    8 
 arch/powerpc/kvm/e500_mmu_host.c           |    4 
 arch/x86/kvm/mmu/mmu.c                     |  189 +++++++++++++----
 arch/x86/kvm/mmu/paging_tmpl.h             |   13 -
 drivers/block/null_blk/zoned.c             |   10 
 drivers/gpio/gpio-ml-ioh.c                 |   36 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   50 ++++
 drivers/hid/hid-core.c                     |   11 
 drivers/hid/hid-hyperv.c                   |   27 ++
 drivers/hid/hid-magicmouse.c               |   26 ++
 drivers/hid/hid-sensor-custom.c            |   17 -
 drivers/input/keyboard/atkbd.c             |   23 +-
 drivers/misc/fastrpc.c                     |  110 ++++++---
 drivers/net/can/dev/skb.c                  |    2 
 drivers/net/can/slcan.c                    |    1 
 drivers/net/ntb_netdev.c                   |   15 -
 drivers/net/usb/rndis_host.c               |    6 
 drivers/nfc/fdp/i2c.c                      |   27 ++
 drivers/nfc/microread/microread.c          |   31 ++
 drivers/nfc/pn533/pn533.c                  |    1 
 drivers/nfc/st21nfca/dep.c                 |    3 
 drivers/nvme/target/fc.c                   |    2 
 drivers/nvme/target/tcp.c                  |    5 
 drivers/pci/controller/pci-host-generic.c  |   11 
 drivers/pci/ecam.c                         |   13 +
 drivers/s390/cio/vfio_ccw_async.c          |   16 +
 drivers/s390/cio/vfio_ccw_chp.c            |   31 ++
 drivers/s390/cio/vfio_ccw_cp.c             |   31 ++
 drivers/s390/cio/vfio_ccw_drv.c            |   14 +
 drivers/s390/cio/vfio_ccw_ops.c            |   15 -
 drivers/s390/cio/vfio_ccw_private.h        |    7 
 drivers/tty/serial/amba-pl011.c            |    8 
 fs/ext4/xattr.c                            |    7 
 fs/iomap/buffered-io.c                     |   19 +
 fs/ocfs2/xattr.c                           |   18 +
 fs/xfs/libxfs/xfs_attr_leaf.c              |   14 +
 fs/xfs/xfs_buf_item_recover.c              |   53 +++-
 include/linux/can/core.h                   |    1 
 include/linux/can/skb.h                    |    3 
 include/linux/kvm_host.h                   |   60 ++---
 include/linux/netdevice.h                  |    6 
 include/linux/pci-ecam.h                   |    3 
 include/net/sch_generic.h                  |    1 
 kernel/events/core.c                       |  121 +++++-----
 mm/huge_memory.c                           |   46 ++--
 net/bluetooth/rfcomm/core.c                |   24 +-
 net/can/af_can.c                           |   14 -
 net/can/bcm.c                              |    2 
 net/can/isotp.c                            |  320 ++++++++++++++++++++---------
 net/can/j1939/socket.c                     |    1 
 net/can/j1939/transport.c                  |    2 
 net/can/raw.c                              |    7 
 net/ceph/osd_client.c                      |    5 
 net/ipv4/inet_fragment.c                   |    6 
 net/ipv4/ip_output.c                       |    4 
 net/ipv6/ip6_output.c                      |    2 
 net/mptcp/options.c                        |   57 +++++
 net/mptcp/pm_netlink.c                     |   39 +--
 net/mptcp/protocol.h                       |    1 
 net/nfc/digital_technology.c               |    2 
 net/nfc/llcp_commands.c                    |   18 +
 net/nfc/llcp_core.c                        |   15 -
 net/nfc/nci/ntf.c                          |   10 
 net/nfc/nci/rsp.c                          |    1 
 net/packet/af_packet.c                     |   65 +++--
 net/sched/sch_api.c                        |    9 
 net/xfrm/xfrm_state.c                      |    4 
 sound/aoa/codecs/onyx.c                    |  104 ++++++---
 sound/aoa/codecs/tas.c                     |  113 ++++++----
 sound/aoa/core/gpio-feature.c              |   20 +
 sound/aoa/core/gpio-pmf.c                  |   26 +-
 sound/aoa/soundbus/i2sbus/pcm.c            |   75 ++++--
 sound/drivers/dummy.c                      |    6 
 sound/soc/codecs/lpass-tx-macro.c          |    4 
 virt/kvm/kvm_main.c                        |   49 ++--
 84 files changed, 1532 insertions(+), 632 deletions(-)

Abel Vesa (1):
      misc: fastrpc: Rework fastrpc_req_munmap

Aditya Chillara (1):
      perf/core: Fix group leader use-after-free after sibling detach

Ali Ahmet Memis (1):
      Bluetooth: RFCOMM: take rfcomm_mutex for the deferred setup accept

Baul Lee (1):
      HID: core: fix OOB read of field->usage in hid_set_field()

Bryam Vargas (1):
      nfc: fdp: bound the device-reported read length and fix an skb leak

Chao Peng (1):
      KVM: Rename mmu_notifier_* to mmu_invalidate_*

Cryolitia PukNgae (1):
      Input: atkbd - skip deactivate for HONOR FMB-P's internal keyboard

David Matlack (2):
      KVM: x86/mmu: Split out TDP MMU page fault handling
      KVM: x86/mmu: Rename __direct_map() to direct_map()

Dawid Wróbel (1):
      ASoC: codecs: lpass-tx-macro: Fix enum kcontrol accesses

Donglin Lyu (1):
      Input: atkbd - skip deactivate for HONOR ZQC-P

Doruk Tan Ozturk (4):
      nfc: digital: clamp SENSF_RES length to the destination buffer
      nfc: llcp: bound the connect_sn TLV walk to the skb
      nfc: llcp: reject PDUs shorter than the LLCP header
      nfc: st21nfca: validate ATR_REQ length against the received frame

Ekansh Gupta (1):
      misc: fastrpc: Remove buffer from list prior to unmap operation

Eric Farman (5):
      s390/vfio_ccw: Cancel existing workqueues
      s390/vfio_ccw: Ensure index for read/write regions are within range
      s390/vfio_ccw: Selectively expand io_mutex
      s390/vfio_ccw: Implement a crw lock
      s390/vfio_ccw: Free all memory if cp_init() fails

Fan Wu (1):
      serial: amba-pl011: synchronize DMA teardown

Greg Kroah-Hartman (2):
      nvmet-tcp: Do not WARN on remotely-controlled oversized SGL allocations
      Linux 5.15.218

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

Jose Villaseñor Montfort (1):
      HID: magicmouse: do not keep a stale msc->input if no input is claimed

Junjie Cao (1):
      gpio: ml-ioh: use raw_spinlock_t for the register lock

Koichiro Den (1):
      NTB: ntb_netdev: Preserve RX queue depth on allocation failure

Lee Jones (1):
      HID: magicmouse: Prevent out-of-bounds (OOB) read during DOUBLE_REPORT_ID

Linmao Li (1):
      nfc: nci: free destination parameters when closing a connection

Lorenzo Stoakes (ARM) (1):
      mm/huge_memory: fix huge_zero_pfn race

Luxiao Xu (1):
      ipv6: fix use-after-free in ip6_finish_output2()

Matthias Goergens (1):
      ext4: stop retrying saturated xattr cache entries

Matthieu Baerts (NGI0) (4):
      mptcp: avoid combining some incoming suboptions
      mptcp: pm: ADD_ADDR rtx: allow ID 0
      mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
      mptcp: pm: ADD_ADDR rtx: free sk if last

Michael Bommarito (1):
      HID: hyperv: validate initial device info bounds

Muhammad Bilal (1):
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

Qing Luo (1):
      mptcp: pm: fix data race in add_addr timer callback

Rik van Riel (1):
      null_blk: fix UBSAN shift-out-of-bounds when zone_size is 0 or overflows

Samuel Page (2):
      nfc: nci: fix out-of-bounds write in nci_target_auto_activated()
      nfc: nci: fix uninit-value in the RF discover/activated NTF handlers

Sasha Levin (1):
      Revert "ALSA: aoa: Use guard() for mutex locks"

Sean Christopherson (6):
      KVM: x86/mmu: Retry page fault if root is invalidated by memslot update
      KVM: x86/mmu: Directly "destroy" PTE list when recycling rmaps
      KVM: x86/mmu: Rename pte_list_{destroy,remove}() to show they zap SPTEs
      KVM: x86/mmu: Document the "rules" for using host_pfn_mapping_level()
      KVM: x86: Check for invalid/obsolete root *after* making MMU pages available
      KVM: x86: Retry page fault if MMU reload is pending and root has no sp

Srinivas Kandagatla (1):
      misc: fastrpc: separate fastrpc device from channel context

Steffen Persvold (1):
      PCI: host-generic: Fix NULL pointer dereference on 32-bit CAM systems

Takashi Iwai (1):
      ALSA: dummy: Check card index validity at probe

Xiang Mei (Microsoft) (1):
      xfrm: fix sk_dst_cache double-free in xfrm_user_policy()

Xu Rao (1):
      nfc: pn533: purge fragmented skbs during cleanup

Yang Wang (1):
      drm/amdgpu: check ASPM on the dGPU host link

Yeoreum Yun (2):
      perf/core: Fix child_total_time_enabled accounting bug at task exit
      perf: Fix dangling cgroup pointer in cpuctx

Yong Wang (1):
      ipv4: reject undersized MTUs in ip_do_fragment()

Zhiling Zou (1):
      inet: frags: publish queues before arming timer

Zihan Xi (1):
      packet: synchronize pressure clearing with ring reconfiguration

Zijie Huang (1):
      net/sched: reject overly deep qdisc hierarchies

