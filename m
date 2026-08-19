Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE8A411A09;
	Wed, 19 Aug 2026 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158377; cv=none; b=ffStRgB+uLdFp4c00QjjEhpUuXfWvtWw1bHu4k1cG+Q3sZYITQBwzCMaLXkiGyqKSMpy+DXg7I5KuGFbSj7fHqDq075x58AK+OGDA8iGVYSMpjB/ps6NeQlGdzfSrzhB0sqNHI4pJD49RuBbXRvCqe1wtQwUeYKk+wRRoPZB4w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158377; c=relaxed/simple;
	bh=Fq9uo6iT83nsG4tMerNUi7nma0710wKSYYN0w03Qoz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tOOe9bo4bi5eRsn4+zmYFi+3PX15n7vPltKncHhN4bQ1i/ROPm9QOs0EpjKX623RZUMzIcm10U6YvL21aM69TP+ctnrWlZ6jFLygaseCFCfImmnkw3rB2Ty/dgosZ1QDIAVUN+mml3VIxHDypWoKlWXUM+3xYaX0BpBDH9yJPXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DMSDPB9m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DMSDPB9m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1F61F00A3A;
	Wed, 19 Aug 2026 16:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787158373;
	bh=Q8UTe9YLe7MHz2mihM2GAccGcfNN6Irpdvzb0kEyk4g=;
	h=From:To:Cc:Subject:Date;
	b=DMSDPB9mjonM/+kTZEwwGIb8koGz55s+tnDwIwmubTChTp15z7U19/BcFtQuzaUez
	 ApRGBHv10vcC0uzpKSTosg11zBo2ILGioT4zKJTqYpFtZEfy30z7ybpBQLpy4L2oG7
	 Q4UbdZ0yVP2qK99EY27oQjJptvL20UBHO2TnOPWQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.104
Date: Wed, 19 Aug 2026 18:52:16 +0200
Message-ID: <2026081916-radiance-plenty-88b6@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.104 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml |   16 
 MAINTAINERS                                                             |    5 
 Makefile                                                                |    2 
 arch/arm/boot/dts/broadcom/bcm-ns.dtsi                                  |    2 
 arch/arm/mach-npcm/platsmp.c                                            |    2 
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi                               |    2 
 arch/s390/kvm/pci.c                                                     |   86 ++
 arch/s390/kvm/pci.h                                                     |    2 
 arch/x86/kvm/mmu/mmu.c                                                  |    3 
 arch/x86/kvm/svm/sev.c                                                  |   12 
 block/blk-mq.c                                                          |   38 -
 drivers/ata/pata_sl82c105.c                                             |    4 
 drivers/counter/microchip-tcb-capture.c                                 |    4 
 drivers/crypto/ccp/sev-dev.c                                            |   17 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                              |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                 |   35 -
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c               |   24 
 drivers/gpu/drm/bridge/parade-ps8640.c                                  |   27 
 drivers/hwmon/ads7828.c                                                 |   11 
 drivers/hwmon/corsair-psu.c                                             |    4 
 drivers/hwmon/ltc4282.c                                                 |   20 
 drivers/hwmon/nzxt-smart2.c                                             |    6 
 drivers/hwmon/pmbus/lm25066.c                                           |    5 
 drivers/input/evdev.c                                                   |   27 
 drivers/misc/fastrpc.c                                                  |   19 
 drivers/misc/mei/client.c                                               |   25 
 drivers/mtd/nand/spi/core.c                                             |   74 ++
 drivers/net/bonding/bond_alb.c                                          |   10 
 drivers/net/ethernet/amd/pds_core/core.h                                |    1 
 drivers/net/ethernet/amd/pds_core/main.c                                |   14 
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c                        |   51 +
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h                        |    1 
 drivers/net/ethernet/aquantia/atlantic/aq_vec.c                         |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                               |   50 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                               |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c                           |    7 
 drivers/net/ethernet/cisco/enic/enic_main.c                             |    5 
 drivers/net/ethernet/freescale/fec_main.c                               |   11 
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c                           |    1 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                 |    6 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c                    |    6 
 drivers/net/ethernet/marvell/prestera/prestera_pci.c                    |    3 
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c                |   16 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h                    |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                         |    4 
 drivers/net/thunderbolt/main.c                                          |   33 -
 drivers/net/usb/ax88179_178a.c                                          |    4 
 drivers/net/usb/ipheth.c                                                |   11 
 drivers/net/veth.c                                                      |   22 
 drivers/net/vxlan/vxlan_core.c                                          |    2 
 drivers/nvmem/core.c                                                    |   24 
 drivers/nvmem/internals.h                                               |    2 
 drivers/nvmem/layouts.c                                                 |   11 
 drivers/nvmem/layouts/Makefile                                          |    1 
 drivers/nvmem/layouts/fixed-layout.c                                    |   58 ++
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                                 |    4 
 drivers/ptp/ptp_ocp.c                                                   |    4 
 drivers/s390/crypto/zcrypt_ccamisc.c                                    |   20 
 drivers/scsi/scsi_debug.c                                               |    4 
 drivers/spi/spi-fsl-dspi.c                                              |   13 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c                          |    3 
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c                           |    2 
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c                          |    3 
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c                       |    4 
 drivers/thermal/thermal_hwmon.c                                         |    3 
 drivers/thunderbolt/eeprom.c                                            |    9 
 drivers/thunderbolt/icm.c                                               |    2 
 drivers/thunderbolt/tb.c                                                |    2 
 drivers/tty/serial/8250/8250_dma.c                                      |   12 
 drivers/tty/serial/qcom_geni_serial.c                                   |   43 -
 drivers/tty/vt/keyboard.c                                               |    5 
 drivers/tty/vt/vt_ioctl.c                                               |    2 
 drivers/usb/atm/cxacru.c                                                |    2 
 drivers/usb/cdns3/cdnsp-gadget.c                                        |    4 
 drivers/usb/gadget/function/f_ncm.c                                     |    2 
 drivers/vdpa/mlx5/core/mr.c                                             |    3 
 drivers/vhost/vdpa.c                                                    |    9 
 drivers/vhost/vhost.c                                                   |    8 
 drivers/video/fbdev/core/bitblit.c                                      |    9 
 drivers/watchdog/bd96801_wdt.c                                          |    5 
 fs/binfmt_misc.c                                                        |    3 
 fs/btrfs/inode.c                                                        |    1 
 fs/crypto/policy.c                                                      |    2 
 fs/namespace.c                                                          |    5 
 fs/nfs/nfs4proc.c                                                       |    5 
 fs/overlayfs/super.c                                                    |    3 
 fs/smb/client/sess.c                                                    |    2 
 fs/tracefs/event_inode.c                                                |    4 
 fs/verity/measure.c                                                     |   15 
 include/linux/netdevice.h                                               |   11 
 include/linux/netfilter/ipset/ip_set.h                                  |    2 
 include/linux/nvmem-provider.h                                          |    6 
 include/linux/psp-sev.h                                                 |    3 
 include/net/act_api.h                                                   |   19 
 include/net/addrconf.h                                                  |    4 
 include/net/ip_vs.h                                                     |   41 -
 include/net/route.h                                                     |    2 
 include/net/sch_generic.h                                               |    1 
 kernel/bpf/verifier.c                                                   |   15 
 kernel/futex/core.c                                                     |   85 ++
 kernel/sched/psi.c                                                      |    6 
 kernel/trace/ring_buffer.c                                              |    4 
 kernel/trace/trace_events.c                                             |    2 
 lib/fortify_kunit.c                                                     |  139 ++--
 mm/huge_memory.c                                                        |   43 +
 mm/swapfile.c                                                           |    2 
 mm/vmscan.c                                                             |   25 
 net/atm/common.c                                                        |   14 
 net/bridge/br_mrp.c                                                     |    6 
 net/bridge/netfilter/ebt_nflog.c                                        |   17 
 net/bridge/netfilter/nf_conntrack_bridge.c                              |    1 
 net/core/dev.c                                                          |   10 
 net/core/sock.c                                                         |    1 
 net/core/xdp.c                                                          |    2 
 net/devlink/dev.c                                                       |    1 
 net/ipv4/fib_semantics.c                                                |  101 ++-
 net/ipv4/inet_connection_sock.c                                         |   20 
 net/ipv4/route.c                                                        |   29 +
 net/ipv4/tcp_bpf.c                                                      |    2 
 net/ipv4/tcp_input.c                                                    |    2 
 net/ipv4/tcp_ipv4.c                                                     |  289 +++++++---
 net/ipv4/udp_offload.c                                                  |    4 
 net/ipv6/ip6_tunnel.c                                                   |    3 
 net/ipv6/route.c                                                        |    8 
 net/mac802154/scan.c                                                    |    4 
 net/ncsi/ncsi-netlink.c                                                 |    4 
 net/netfilter/ipset/ip_set_bitmap_gen.h                                 |    4 
 net/netfilter/ipset/ip_set_core.c                                       |    6 
 net/netfilter/ipset/ip_set_hash_gen.h                                   |    2 
 net/netfilter/ipset/ip_set_list_set.c                                   |    4 
 net/netfilter/ipvs/ip_vs_conn.c                                         |   41 -
 net/netfilter/ipvs/ip_vs_core.c                                         |   68 +-
 net/netfilter/ipvs/ip_vs_ctl.c                                          |   77 ++
 net/netfilter/ipvs/ip_vs_est.c                                          |   10 
 net/netfilter/ipvs/ip_vs_lc.c                                           |    4 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                                   |    4 
 net/netfilter/ipvs/ip_vs_proto_tcp.c                                    |    2 
 net/netfilter/ipvs/ip_vs_sync.c                                         |    7 
 net/netfilter/ipvs/ip_vs_xmit.c                                         |    2 
 net/netfilter/nf_conntrack_proto.c                                      |    6 
 net/netfilter/nf_conntrack_proto_sctp.c                                 |   12 
 net/netfilter/nf_conntrack_proto_tcp.c                                  |  132 +++-
 net/openvswitch/datapath.c                                              |   29 -
 net/openvswitch/flow.c                                                  |   11 
 net/packet/af_packet.c                                                  |   72 +-
 net/sched/act_ct.c                                                      |   29 -
 net/sched/act_gact.c                                                    |    5 
 net/sched/act_police.c                                                  |    6 
 net/sched/cls_api.c                                                     |   17 
 net/sched/cls_route.c                                                   |   35 -
 net/sched/sch_api.c                                                     |    9 
 net/sched/sch_cake.c                                                    |    1 
 net/sctp/associola.c                                                    |   11 
 net/sctp/outqueue.c                                                     |    1 
 net/sctp/sm_make_chunk.c                                                |    3 
 net/sctp/sm_statefuns.c                                                 |    6 
 net/smc/af_smc.c                                                        |    3 
 net/smc/smc_llc.c                                                       |    3 
 net/smc/smc_rx.c                                                        |   19 
 net/tipc/node.c                                                         |   15 
 net/tls/tls_sw.c                                                        |   16 
 net/vmw_vsock/virtio_transport.c                                        |   14 
 net/xdp/xdp_umem.c                                                      |    2 
 security/integrity/ima/ima_appraise.c                                   |    9 
 security/integrity/ima/ima_main.c                                       |   39 +
 sound/usb/endpoint.c                                                    |    6 
 sound/usb/midi2.c                                                       |    9 
 sound/usb/usx2y/usX2Yhwdep.c                                            |    2 
 sound/usb/usx2y/usx2yhwdeppcm.c                                         |    2 
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c                  |    6 
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c                 |   21 
 tools/testing/selftests/bpf/test_maps.c                                 |   13 
 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc     |   16 
 173 files changed, 1920 insertions(+), 868 deletions(-)

Ahmad Byagowi (1):
      ptp: ocp: Fix board ID over-read

Al Viro (1):
      mount: honour SB_NOUSER in the new mount API

Aleksandr Nogikh (1):
      usb: atm: cxacru: properly kill rcv_urb on error in cxacru_cm()

Alexander Usyskin (1):
      mei: pull kvfree out of spinlock

Anandu Krishnan E (1):
      misc: fastrpc: fix channel ctx ref leak when session alloc fails

Anna Schumaker (1):
      NFS: Pin the 'struct nfs_server' during a FREE_STATEID call

Asad Kamal (1):
      Revert "drm/amdgpu: fix aperture mapping leak"

Ashish Kalra (3):
      crypto: ccp - Add new SEV/SNP platform shutdown API
      KVM: SVM: Add support to initialize SEV/SNP functionality in KVM
      crypto: ccp - Abort doing SEV INIT if SNP INIT fails

Babanpreet Singh (1):
      counter: microchip-tcb-capture: Fix DT channel validation

Bart Van Assche (1):
      block: Reorder the request allocation code in blk_mq_submit_bio()

Baul Lee (5):
      ALSA: usb-audio: fix OOB write on Type II inbound URBs
      net: bridge: mrp: fix uninitialised bytes on the wire
      ALSA: usx2y: bound the hwdep mmap fault offset
      vxlan: do not arm the ageing timer on a device that is down
      sctp: keep chunk->transport in step with the list it is queued on

Bryam Vargas (1):
      thunderbolt: Bound the DROM dual link port number before indexing sw->ports

Cen Zhang (Microsoft) (1):
      net/openvswitch: check Ethernet header length in key_extract()

Chengfeng Ye (3):
      netfilter: ebt_nflog: pin the NFLOG backend
      ipv4: fix use-after-free in fib_nhc_update_mtu()
      bpf, sockmap: Fix sk_redir use-after-free in send verdict

Christian Borntraeger (1):
      vdpa/mlx5: Fix buffer length in create_direct_keys()

Christian Brauner (2):
      ovl: don't warn when the mount is completed from another user namespace
      binfmt_misc: don't warn when the mount is completed from another user namespace

Claudiu Beznea (1):
      pinctrl: renesas: rzg2l: Use -ENOTSUPP instead of -EOPNOTSUPP

Cunhao Lu (1):
      serial: 8250_dma: Clear stale RX state on shutdown

Daming Li (1):
      net: smc: fix splice entry lifetime imbalance in smc_rx_splice

Daniel Drake (1):
      arm64: dts: broadcom: bcm2712: Remove non-functional EL2 virtual timer

Dmitry Antipov (1):
      btrfs: fix memory leak in btrfs_do_encoded_write()

Dmitry Torokhov (2):
      Input: evdev - sanitize event type index when fetching event masks
      Input: evdev - fix information leak in evdev_pass_values()

Doruk Tan Ozturk (2):
      net: usb: ipheth: fix carrier_work UAF on disconnect
      net/packet: reset the MAC header on the packet-socket transmit path

Eddie Lin (1):
      misc: fastrpc: fix memory leak in fastrpc_channel_ctx_free

Ekansh Gupta (1):
      misc: fastrpc: Remove buffer from list prior to unmap operation

Eric Biggers (2):
      fsverity: Fix bpf_get_fsverity_digest() dynptr assumptions
      fsverity: Fix silent truncation in bpf_get_fsverity_digest()

Eric Dumazet (2):
      net: remove WARN_ON_ONCE() from sk_mc_loop()
      net/atm: fix slab-out-of-bounds read in vcc_setsockopt()

Fan XinRan (1):
      net: thunderbolt: Tear down DMA paths before stopping the rings

Fan Ye (1):
      Revert "net: thunderbolt: Enable end-to-end flow control also in transmit"

Farhan Ali (3):
      KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
      KVM: s390: pci: Fix missing error codes and memory unaccounting
      KVM: s390: pci: Fix resource leak on IRQ registration failure

Greg Kroah-Hartman (1):
      Linux 6.12.104

Guenter Roeck (4):
      hwmon: (pmbus/lm25066) Fix PMBus coefficient calculations
      hwmon: (ltc4282) Avoid overflow in maximum power calculation
      hwmon: (ltc4282) Clamp negative current limits
      hwmon: (ltc4282) Fix parsing adi,current-limit-sense-microvolt

Guillaume Morin (1):
      swapfile: call cond_resched() before locking si->lock

Harald Freudenberger (1):
      s390/zcrypt: Fix missing mem scrub at clear key import in cca_clr2cipherkey()

Harshal Dev (1):
      dt-bindings: crypto: qcom,ice: Fix missing power-domain and iface clk

Henry Martin (1):
      net/ncsi: fix heap OOB read in NCSI_CMD_SEND_CMD payload length

Hongyan Xu (1):
      ata: pata_sl82c105: fix bridge revision use-after-free

Hui Su (1):
      ring-buffer: Fix crash passing ERR_PTR to kthread_stop()

Hyunjung Ko (2):
      net/sched: act_ct: fix sk_buff leak when the header checks reject a packet
      net/sched: act_gact, act_police: range check the fallback control action

Jamal Hadi Salim (2):
      net/sched: cls_route: fix fastmap use-after-free on filter
      net/sched: cls_api: Always acquire rtnl_lock when destroying locked classifiers

Jan Sebastian Götte (1):
      serial: qcom-geni: fix TX DMA buffer flush

Jiawen Liu (1):
      net: hisilicon: hix5hd2_gmac: remove redundant NAPI delete

Jiayuan Chen (1):
      tcp: fix TFO max_qlen accounting across reuseport migration

Jijie Shao (1):
      net: hns3: fix speed configuration residue after driver reload

Jordan Rife (5):
      bpf: tcp: Make mem flags configurable through bpf_iter_tcp_realloc_batch
      bpf: tcp: Make sure iter->batch always contains a full bucket snapshot
      bpf: tcp: Get rid of st_bucket_done
      bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch items
      bpf: tcp: Avoid socket skips and repeats during iteration

Jose Fernandez (Anthropic) (1):
      bpf: tcp: Fix use-after-free in bpf_iter_tcp_established_batch()

Joshua Rogers (2):
      vt: add permission check for KDSKBMETA ioctl
      vt: stabilize tty reference in kbd_keycode with tty_port_tty_get

Jozsef Kadlecsik (1):
      netfilter: ipset: switch ext_size to atomic64_t

Julian Anastasov (4):
      ipvs: avoid out-of-bounds write in ip_vs_nat_icmp
      ipvs: return the csum validation for forward hook
      ipvs: add totalconns for dest
      ipvs: properly update the overload flag on dest edit

Jun Yang (2):
      vhost: reset the vring metadata cache on vring reconfiguration
      tipc: read le->link under the node lock in tipc_node_link_down()

Junrui Luo (1):
      misc: fastrpc: take fl->lock when moving mmaps on interrupted invoke

Keegan Freyhof (1):
      bnxt_en: Fix PTP PPS setting bug

Kees Cook (2):
      kunit/fortify: Replace "volatile" with OPTIMIZER_HIDE_VAR()
      kunit/fortify: Add back "volatile" for sizeof() constants

Keith Busch (2):
      blk-mq: pop cached request if it is usable
      blk-mq: reinsert cached request to the list

Keno Fischer (1):
      futex: Prevent robust futex exit race some more

Kyle Zeng (2):
      ipvs: clear IPv4 options after rebasing tunnel ICMP errors
      ipv6: prevent in6_dev_get() from resurrecting inet6_dev

Larisa Grigore (1):
      spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers

Lincoln Wallace (1):
      ima: fix out-of-bounds read in xattr_verify()

Lorenzo Stoakes (ARM) (1):
      mm/huge_memory: fix huge_zero_pfn race

Mahanta Jambigi (1):
      net/smc: fix qentry overwrite for CONFIRM_LINK and ADD_LINK_CONT in smc_llc_event_handler()

Mariano Baragiola (1):
      staging: rtl8723bs: validate monitor transmit frame lengths

Martin Kaiser (1):
      selftests/ftrace: refactor eprobes test to fix argument checks

Mathieu Dubois-Briand (1):
      nvmem: layouts: Add fixed-layout driver

Matthew Rosato (1):
      KVM: s390: pci: Fix aisb calculation

Matti Vaittinen (1):
      watchdog: bd96801_wdt: Fix timeout for enabled WDG

Maximilian Immanuel Brandtner (1):
      tls: don't abort the connection on signal-interrupted sends

Mehmet Fide (1):
      net: fec: do not release NULL pages when RX buffer allocation fails

Michael Guralnik (1):
      net/mlx5: fw_tracer, return NULL on create error

Michael Roth (1):
      crypto: ccp - Fix checks for SNP_VLEK_LOAD input buffer length

Michael Wu (1):
      tracing: Fix race between update_event_fields and, event_define_fields

Michal Luczaj (3):
      selftests/bpf: Fail unbound UDP on sockmap update
      selftests/bpf: Ensure UDP sockets are bound
      selftests/bpf: Adapt sockmap update error handling

Mikhail Kshevetskiy (3):
      mtd: spinand: fix direct mapping creation sizes
      mtd: spinand: try a regular dirmap if creating a dirmap for continuous reading fails
      mtd: spinand: repeat reading in regular mode if continuous reading fails

Mimi Zohar (1):
      ima: Instantiate file_truncate and path_truncate hooks

Muhammad Bilal (2):
      staging: rtl8723bs: fix OOB read in rtw_get_wpa_ie()
      staging: rtl8723bs: fix OOB read in WMM_param_handler()

Nathan Gao (1):
      tcp: do not change rcv_ssthresh in tcp_measure_rcv_mss()

Nikhil P. Rao (2):
      pds_core: keep the health thread stopped during reset
      pds_core: cancel pending PCI reset work on AER recovery

Or Har-Toov (1):
      devlink: fix net namespace reference leak in reload

Panagiotis Petrakopoulos (1):
      staging: rtl8723bs: fix missing shared-key auth challenge length check

Pawel Laszczak (1):
      usb: cdnsp: fix incorrect endian conversions for APB timeout register

Pengpeng Hou (2):
      drm/bridge: ps8640: propagate AUX transfer register errors
      net: prestera: validate firmware header length

Qihang Tang (3):
      packet: use consistent hard_header_len in non-ring send paths
      packet: use consistent hard_header_len in TX_RING send path
      net: remove CAP_SYS_RAWIO zero-padding in dev_validate_header

Qing Luo (1):
      sctp: fix addip_serial increment on ASCONF_ACK allocation failure

Qing Ming (1):
      sctp: clear new_transport when removing a peer

Qingshuang Fu (2):
      hwmon: (nzxt-smart2) Check return value of init_device() in probe
      hwmon: (ads7828) Fix external VREF regulator handling

Rafael J. Wysocki (1):
      Revert "thermal/drivers/hwmon: Cleanup coding style a bit"

Ray Wu (2):
      drm/amd/display: Add AV mute wait frames to dce110_set_avmute
      drm/amd/display: Check for tg ops in dce110_set_avmute

Rik van Riel (1):
      fbdev: bitblit: bound-check glyph index in bit_cursor()

Rosen Penev (1):
      ARM: dts: BCM5301X: fix PCIe controller 2 second interrupt

Satish Kharat (1):
      enic: fix tx_hang_reset use-after-free on device removal

Sean Christopherson (1):
      KVM: x86/mmu: WARN and clear role.invalid when creating a child shadow page

Sergey V. Frolov (1):
      net: octeontx2-pf: Fix UB in shift operation

Shay Drory (1):
      net/mlx5e: TC, Check if flow is PEER before acquiring devcom lock

Shravya KN (3):
      bnxt_en: Move RSS table fill outside __bnxt_hwrm_vnic_set_rss()
      bnxt_en: Determine and store default RX ring in vnic structure
      bnxt_en: Refresh VNIC default ring on queue restart if needed

Shuangpeng Bai (2):
      smb: client: Fix use-after-free in cifs_try_adding_channels()
      eventfs: Fix use-after-free in eventfs_remove_rec()

Sidraya Jayagond (1):
      net/smc: fix TOCTOU race between smc_listen_out() and listener close

Sonali Pradhan (1):
      usb: gadget: f_ncm: Use unsigned int for ndp_index

Stanislav Fomichev (1):
      xsk: require at least 16 bytes of TX metadata

Sun Jian (2):
      net: fix skb length accounting after generic XDP frag adjustment
      veth: fix skb length accounting after XDP frag adjustment

Takashi Iwai (1):
      ALSA: usb: Fix UAF at delayed release of MIDI2 EPs

Tejun Heo (1):
      sched/psi: Shut down rtpoll_timer in psi_cgroup_free()

Toke Høiland-Jørgensen (1):
      net/sched: sch_cake: drop WARN_ON(1) for malformed packets in ACK filter

Vincent Donnefort (1):
      ring-buffer: Prevent subbuf order change when resizing is disabled

Weiming Shi (2):
      vsock/virtio: read virtqueues under worker locks
      vsock/virtio: avoid refilling the RX queue after teardown

Wilken Gottwalt (1):
      hwmon: (corsair-psu) fix possible out-of-bounds access on missing string termination

Xiang Mei (Microsoft) (2):
      bonding: alb: re-check primary_is_promisc under RTNL in bond_alb_monitor
      bpf: tcp: fix double sock release on batch realloc

Xin Long (1):
      sctp: clear control chunk transport if it is being removed

Xu Rao (3):
      thunderbolt: icm: Preserve USB4 proxy data-valid bit
      scsi: scsi_debug: Negate wrapped memcmp() result
      thunderbolt: Fix bandwidth group reservation indexing

Xuanqiang Luo (1):
      udp: fix potential use-after-free in tunnel segmentation

Yangyu Chen (2):
      net: atlantic: free stranded TX buffers on ring deinit
      net: atlantic: free RX pages of consumed but not refilled buffers

Yi Cong (1):
      net: usb: ax88179_178a: fix skb leak in ax88179_tx_fixup()

Yiyang Chen (1):
      bpf: Preserve pointer state for commuted arithmetic

Yousef Alhouseen (1):
      vhost/vdpa: reject overflowing PA map page counts on 32-bit

Yuejie Shi (1):
      ipv6: fix Route Information option length validation

Yuho Choi (1):
      ARM: npcm: Fix OF node refcount leaks in SMP setup

Yuxiang Yang (1):
      sctp: fix use-after-free of cached ASCONF chunk

Zeng Jingxiang (1):
      mm/vmscan: wake up flushers conditionally to avoid cgroup OOM

Zhan Xusheng (1):
      fscrypt: use the mount idmap for the owner check in fscrypt_ioctl_set_policy()

Zhiling Zou (5):
      ipvs: stop estimator after disabled calc phase
      net: openvswitch: reallocate update replies for mismatched IDs
      netfilter: bridge: release template ct on non-IP path
      xdp: reject clones that overrun skb_shared_info tailroom
      ip6_tunnel: clear skb2->cb[] in ip6ip6_err()

Zihan Xi (4):
      packet: synchronize pressure clearing with ring reconfiguration
      mac802154: fix netdev use-after-free in beacon worker
      ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops
      netfilter: nf_conntrack: defer invalid log until after unlock

Zijie Huang (1):
      net/sched: reject overly deep qdisc hierarchies

chanyoung (1):
      tls: don't leave a full plaintext sk_msg ring unpushed

