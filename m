Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7985048A2C5;
	Wed, 19 Aug 2026 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158363; cv=none; b=AJbiDMFM5jUKZOetcDeHwg0e0TlKmvi/NISLELCTqeAwfybujijRDcNM7L4TBzbaBsM4MIMb9GN/ahILnZNLXhH5vDolTd3k+fX7CVjM8MapWsTrllggjvFBXyHrys+zT8JlfF9kaTuvKr0+KU8d02x9CkUAc4M1rpwsyQY44VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158363; c=relaxed/simple;
	bh=Tgto+vv2kz/e5jiOKAUg1oZOmGsnkk0qKhbqheVCrMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l8ollhR+gxB5NOHDo9PeF5z+Zf5f5Mr9JDvZWPLONEj2po1UCJWBidsAE73/c6bbLfiN8uqN6G6QEWmI0MUK12cQqpjDUkxC6d//ayikvCk+RKiDLe/m8jHXjk+3w0rUX3TLqxTjDIf+hfOHlI+1yrYZOxwXQlRy2vWm1pP9K4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1v/BQlEQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1v/BQlEQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E849D1F00A3D;
	Wed, 19 Aug 2026 16:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787158360;
	bh=we6H3ibRKu3VBLK2ceZQ1kdf1TA0Nx11FRis+tvboiI=;
	h=From:To:Cc:Subject:Date;
	b=1v/BQlEQzz2kvteI8J0sSSwBqweMYfKuIXfGeYKsbBG+LRRGNTk8RTRXVRrotXiIH
	 EkLlb8xPOaqE5b5c8Ogyd2WvhkvYpQ4Ti3Ha+gpNmZRu7mnzbAj76kry9d7PSsFvHa
	 uhFLKSWAhJX6jIwyg58d668EXf59i8+iSCFmIfiA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.152
Date: Wed, 19 Aug 2026 18:52:07 +0200
Message-ID: <2026081908-empirical-reoccur-9c01@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.152 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml |   16 
 Documentation/driver-api/driver-model/devres.rst                        |    1 
 Makefile                                                                |    2 
 arch/arm/boot/dts/broadcom/bcm-ns.dtsi                                  |    2 
 arch/arm/mach-npcm/platsmp.c                                            |    2 
 arch/s390/kvm/pci.c                                                     |   86 +-
 arch/s390/kvm/pci.h                                                     |    2 
 arch/x86/kvm/mmu/mmu.c                                                  |    3 
 drivers/ata/pata_sl82c105.c                                             |    4 
 drivers/counter/microchip-tcb-capture.c                                 |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                              |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                 |   35 
 drivers/gpu/drm/bridge/parade-ps8640.c                                  |   27 
 drivers/hwmon/ads7828.c                                                 |   11 
 drivers/hwmon/corsair-psu.c                                             |    4 
 drivers/hwmon/nzxt-smart2.c                                             |    6 
 drivers/hwmon/pmbus/lm25066.c                                           |   19 
 drivers/input/evdev.c                                                   |   27 
 drivers/misc/fastrpc.c                                                  |   19 
 drivers/misc/mei/client.c                                               |   25 
 drivers/net/bonding/bond_alb.c                                          |   10 
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c                        |   51 +
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h                        |    1 
 drivers/net/ethernet/aquantia/atlantic/aq_vec.c                         |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                               |   12 
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                               |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c                           |    7 
 drivers/net/ethernet/freescale/fec_main.c                               |   11 
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c                           |    1 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c                    |    6 
 drivers/net/ethernet/marvell/prestera/prestera_pci.c                    |    3 
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c                |   16 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h                    |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                         |    4 
 drivers/net/thunderbolt/main.c                                          |   33 
 drivers/net/usb/ax88179_178a.c                                          |    4 
 drivers/net/veth.c                                                      |   22 
 drivers/net/vxlan/vxlan_core.c                                          |    2 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                                 |    4 
 drivers/ptp/ptp_ocp.c                                                   |    4 
 drivers/regulator/devres.c                                              |   59 +
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
 drivers/tty/serial/8250/8250_dma.c                                      |   12 
 drivers/tty/vt/keyboard.c                                               |    5 
 drivers/tty/vt/vt_ioctl.c                                               |    2 
 drivers/usb/atm/cxacru.c                                                |    2 
 drivers/usb/cdns3/cdnsp-gadget.c                                        |    4 
 drivers/usb/gadget/function/f_ncm.c                                     |    2 
 drivers/vhost/vdpa.c                                                    |    9 
 drivers/vhost/vhost.c                                                   |    8 
 drivers/video/fbdev/core/bitblit.c                                      |    9 
 fs/btrfs/inode.c                                                        |    1 
 fs/crypto/fscrypt_private.h                                             |   32 
 fs/crypto/keyring.c                                                     |  212 ++---
 fs/crypto/policy.c                                                      |    2 
 fs/namespace.c                                                          |    5 
 fs/nfs/nfs4proc.c                                                       |    5 
 fs/overlayfs/super.c                                                    |    3 
 fs/smb/client/sess.c                                                    |    2 
 fs/tracefs/event_inode.c                                                |    4 
 include/linux/netdevice.h                                               |   11 
 include/linux/netfilter/ipset/ip_set.h                                  |    2 
 include/linux/regulator/consumer.h                                      |    7 
 include/linux/tcp.h                                                     |    9 
 include/net/act_api.h                                                   |   19 
 include/net/addrconf.h                                                  |    4 
 include/net/ip_vs.h                                                     |   41 -
 include/net/pkt_cls.h                                                   |   18 
 include/net/route.h                                                     |    2 
 include/net/sch_generic.h                                               |    4 
 include/net/tcp.h                                                       |   58 -
 include/net/tcp_ao.h                                                    |   90 ++
 include/uapi/linux/tcp.h                                                |    2 
 kernel/bpf/verifier.c                                                   |   15 
 kernel/futex/core.c                                                     |   82 +-
 kernel/sched/psi.c                                                      |    6 
 kernel/trace/ring_buffer.c                                              |    2 
 kernel/trace/trace_events.c                                             |    2 
 lib/.gitignore                                                          |    2 
 lib/Makefile                                                            |   34 
 lib/test_fortify/.gitignore                                             |    2 
 lib/test_fortify/Makefile                                               |   29 
 net/atm/common.c                                                        |   14 
 net/bridge/br_mrp.c                                                     |    6 
 net/bridge/netfilter/ebt_nflog.c                                        |   17 
 net/bridge/netfilter/nf_conntrack_bridge.c                              |    1 
 net/core/dev.c                                                          |   13 
 net/core/sock.c                                                         |    1 
 net/core/xdp.c                                                          |    2 
 net/devlink/dev.c                                                       |    1 
 net/ipv4/Kconfig                                                        |   17 
 net/ipv4/Makefile                                                       |    1 
 net/ipv4/fib_semantics.c                                                |  101 +-
 net/ipv4/inet_connection_sock.c                                         |   20 
 net/ipv4/route.c                                                        |   29 
 net/ipv4/tcp.c                                                          |  145 ---
 net/ipv4/tcp_bpf.c                                                      |    2 
 net/ipv4/tcp_input.c                                                    |    2 
 net/ipv4/tcp_ipv4.c                                                     |  386 ++++++----
 net/ipv4/tcp_minisocks.c                                                |   21 
 net/ipv4/tcp_sigpool.c                                                  |  357 +++++++++
 net/ipv4/udp_offload.c                                                  |    4 
 net/ipv6/ip6_tunnel.c                                                   |    3 
 net/ipv6/route.c                                                        |    8 
 net/ipv6/tcp_ipv6.c                                                     |   60 -
 net/mac802154/scan.c                                                    |    4 
 net/ncsi/ncsi-netlink.c                                                 |    4 
 net/netfilter/ipset/ip_set_bitmap_gen.h                                 |    4 
 net/netfilter/ipset/ip_set_core.c                                       |    6 
 net/netfilter/ipset/ip_set_hash_gen.h                                   |    2 
 net/netfilter/ipset/ip_set_list_set.c                                   |    4 
 net/netfilter/ipvs/ip_vs_conn.c                                         |   41 -
 net/netfilter/ipvs/ip_vs_core.c                                         |   68 -
 net/netfilter/ipvs/ip_vs_ctl.c                                          |   77 +
 net/netfilter/ipvs/ip_vs_est.c                                          |   10 
 net/netfilter/ipvs/ip_vs_lc.c                                           |    4 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                                   |    4 
 net/netfilter/ipvs/ip_vs_proto_tcp.c                                    |    2 
 net/netfilter/ipvs/ip_vs_sync.c                                         |    7 
 net/netfilter/ipvs/ip_vs_xmit.c                                         |    2 
 net/netfilter/nf_conntrack_proto.c                                      |    6 
 net/netfilter/nf_conntrack_proto_sctp.c                                 |   12 
 net/netfilter/nf_conntrack_proto_tcp.c                                  |  132 ++-
 net/openvswitch/datapath.c                                              |   29 
 net/openvswitch/flow.c                                                  |   11 
 net/packet/af_packet.c                                                  |   72 +
 net/sched/act_ct.c                                                      |   29 
 net/sched/act_gact.c                                                    |    5 
 net/sched/act_police.c                                                  |    6 
 net/sched/cls_api.c                                                     |   47 +
 net/sched/cls_bpf.c                                                     |    2 
 net/sched/cls_flower.c                                                  |    2 
 net/sched/cls_matchall.c                                                |    2 
 net/sched/cls_route.c                                                   |   35 
 net/sched/cls_u32.c                                                     |    4 
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
 scripts/remove-stale-files                                              |    2 
 security/integrity/ima/ima_appraise.c                                   |    9 
 sound/usb/endpoint.c                                                    |    6 
 sound/usb/midi2.c                                                       |    9 
 sound/usb/usx2y/usX2Yhwdep.c                                            |    2 
 sound/usb/usx2y/usx2yhwdeppcm.c                                         |    2 
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c                 |   21 
 tools/testing/selftests/bpf/test_maps.c                                 |   13 
 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc     |   16 
 165 files changed, 2373 insertions(+), 1026 deletions(-)

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

Asbjørn Sloth Tønnesen (3):
      net: sched: cls_api: add skip_sw counter
      net: sched: cls_api: add filter counter
      net: sched: make skip_sw actually skip software

Babanpreet Singh (1):
      counter: microchip-tcb-capture: Fix DT channel validation

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

Christian Brauner (1):
      ovl: don't warn when the mount is completed from another user namespace

Claudiu Beznea (1):
      pinctrl: renesas: rzg2l: Use -ENOTSUPP instead of -EOPNOTSUPP

Cunhao Lu (1):
      serial: 8250_dma: Clear stale RX state on shutdown

Daming Li (1):
      net: smc: fix splice entry lifetime imbalance in smc_rx_splice

Dan Carpenter (1):
      net/tcp_sigpool: Fix some off by one bugs

David Lechner (2):
      regulator: devres: add API for reference voltage supplies
      regulator: devres: fix devm_regulator_get_enable_read_voltage() return

Dmitry Antipov (1):
      btrfs: fix memory leak in btrfs_do_encoded_write()

Dmitry Safonov (3):
      net/tcp: Prepare tcp_md5sig_pool for TCP-AO
      net/tcp: Add TCP-AO config and structures
      net/tcp_sigpool: Use kref_get_unless_zero()

Dmitry Torokhov (2):
      Input: evdev - sanitize event type index when fetching event masks
      Input: evdev - fix information leak in evdev_pass_values()

Doruk Tan Ozturk (1):
      net/packet: reset the MAC header on the packet-socket transmit path

Eddie Lin (1):
      misc: fastrpc: fix memory leak in fastrpc_channel_ctx_free

Ekansh Gupta (1):
      misc: fastrpc: Remove buffer from list prior to unmap operation

Eric Biggers (1):
      fscrypt: Replace mk_users keyring with simple list

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
      Linux 6.6.152

Guenter Roeck (1):
      hwmon: (pmbus/lm25066) Fix PMBus coefficient calculations

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

Jianbo Liu (1):
      net: sched: cls_api: fix slab-use-after-free in fl_dump_key

Jiawen Liu (1):
      net: hisilicon: hix5hd2_gmac: remove redundant NAPI delete

Jiayuan Chen (1):
      tcp: fix TFO max_qlen accounting across reuseport migration

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

Keno Fischer (1):
      futex: Prevent robust futex exit race some more

Kyle Zeng (2):
      ipvs: clear IPv4 options after rebasing tunnel ICMP errors
      ipv6: prevent in6_dev_get() from resurrecting inet6_dev

Larisa Grigore (1):
      spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers

Lincoln Wallace (1):
      ima: fix out-of-bounds read in xattr_verify()

Mahanta Jambigi (1):
      net/smc: fix qentry overwrite for CONFIRM_LINK and ADD_LINK_CONT in smc_llc_event_handler()

Mariano Baragiola (1):
      staging: rtl8723bs: validate monitor transmit frame lengths

Martin Kaiser (1):
      selftests/ftrace: refactor eprobes test to fix argument checks

Masahiro Yamada (1):
      fortify: refactor test_fortify Makefile to fix some build problems

Matthew Rosato (1):
      KVM: s390: pci: Fix aisb calculation

Maximilian Immanuel Brandtner (1):
      tls: don't abort the connection on signal-interrupted sends

Mehmet Fide (1):
      net: fec: do not release NULL pages when RX buffer allocation fails

Michael Chan (2):
      bnxt_en: Do not set EOP on RX AGG BDs on 5760X chips
      bnxt_en: Disable EOP for TPA on all chips to prevent data corruption

Michael Guralnik (1):
      net/mlx5: fw_tracer, return NULL on create error

Michael Wu (1):
      tracing: Fix race between update_event_fields and, event_define_fields

Michal Luczaj (2):
      selftests/bpf: Fail unbound UDP on sockmap update
      selftests/bpf: Adapt sockmap update error handling

Muhammad Bilal (2):
      staging: rtl8723bs: fix OOB read in rtw_get_wpa_ie()
      staging: rtl8723bs: fix OOB read in WMM_param_handler()

Nathan Chancellor (1):
      fortify: Disable -Wstringop-overread in tests

Nathan Gao (1):
      tcp: do not change rcv_ssthresh in tcp_measure_rcv_mss()

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

Rik van Riel (1):
      fbdev: bitblit: bound-check glyph index in bit_cursor()

Rob Herring (1):
      hwmon: (lm25066) Use i2c_get_match_data()

Rosen Penev (1):
      ARM: dts: BCM5301X: fix PCIe controller 2 second interrupt

Sean Christopherson (1):
      KVM: x86/mmu: WARN and clear role.invalid when creating a child shadow page

Sergey V. Frolov (1):
      net: octeontx2-pf: Fix UB in shift operation

Shay Drory (1):
      net/mlx5e: TC, Check if flow is PEER before acquiring devcom lock

Shuangpeng Bai (2):
      smb: client: Fix use-after-free in cifs_try_adding_channels()
      eventfs: Fix use-after-free in eventfs_remove_rec()

Sidraya Jayagond (1):
      net/smc: fix TOCTOU race between smc_listen_out() and listener close

Sonali Pradhan (1):
      usb: gadget: f_ncm: Use unsigned int for ndp_index

Sun Jian (1):
      veth: fix skb length accounting after XDP frag adjustment

Takashi Iwai (1):
      ALSA: usb: Fix UAF at delayed release of MIDI2 EPs

Tejun Heo (1):
      sched/psi: Shut down rtpoll_timer in psi_cgroup_free()

Toke Høiland-Jørgensen (1):
      net/sched: sch_cake: drop WARN_ON(1) for malformed packets in ACK filter

Weiming Shi (2):
      vsock/virtio: read virtqueues under worker locks
      vsock/virtio: avoid refilling the RX queue after teardown

Wilken Gottwalt (1):
      hwmon: (corsair-psu) fix possible out-of-bounds access on missing string termination

Xiang Mei (Microsoft) (2):
      bonding: alb: re-check primary_is_promisc under RTNL in bond_alb_monitor
      bpf: tcp: fix double sock release on batch realloc

Xin Long (2):
      net: sched: refine software bypass handling in tc_run
      sctp: clear control chunk transport if it is being removed

Xu Rao (2):
      thunderbolt: icm: Preserve USB4 proxy data-valid bit
      scsi: scsi_debug: Negate wrapped memcmp() result

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

