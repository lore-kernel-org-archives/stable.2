Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7AD48BD5B;
	Wed, 19 Aug 2026 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158393; cv=none; b=Okv5DK5pqBTl+mO+u0t2e75J2M3qZquyST/7l4sjNrD9zfpjXdjADb4RzA0NGazsmu8tQYaADZdJZVKUvGlUhVTZcdUFljAp4piHy+SvbprZ/SQp+czkqeUI3lBAqrhLeYE2UPad3AAXIqliVooLNxE3So4zEARoZ5XEGAxWM2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158393; c=relaxed/simple;
	bh=lzFsP1yMMbP9It2DreWyruKgr53j5D/KLN9orjihsIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LuCrs+HdHpt3/KZcfjVMGkgjRJbQOQsG1IBZkHK3Uj1MM7oltlvxRXnm//jJjbYAaYQO9Fwjy8s1nETQxlgi5qp8eHeYdEbf64wgqJi/QdxRyD9COMAtfu7VWRa46IUplmEYTVD8N5iqvc62FpxedEz1k8V1R0ygJfEOlYgkH8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v5g8OfRn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v5g8OfRn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213431F00A3A;
	Wed, 19 Aug 2026 16:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787158389;
	bh=wHu4g3ObIQj0UVTpFvciUkXwWxM1T7kOW/adpkCLPwI=;
	h=From:To:Cc:Subject:Date;
	b=v5g8OfRnp2dsksUPC5NBWQ6XJHXDdwTemPMYRw6NqsEdmRxsLCmghjO3cPWexme8Z
	 QVFcUiAHrv2lQIsTBpnB/I4SVhI9rupKd/Kg39YJlyQ/CHBCWWyhUPli8k/4XDKibQ
	 IPfi2bql3qnjO5Bdo1tbi32Q9rxQCpQcMgdBx5tE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.45
Date: Wed, 19 Aug 2026 18:52:25 +0200
Message-ID: <2026081926-purplish-preview-e01e@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.45 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                         |    9 
 Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml |   16 
 MAINTAINERS                                                             |    5 
 Makefile                                                                |    2 
 arch/arm/boot/dts/broadcom/bcm-ns.dtsi                                  |    2 
 arch/arm/mach-npcm/platsmp.c                                            |    2 
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi                               |    2 
 arch/arm64/boot/dts/qcom/Makefile                                       |    2 
 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi                             |    4 
 arch/arm64/boot/dts/qcom/hamoa-pmics.dtsi                               |  549 
 arch/arm64/boot/dts/qcom/hamoa.dtsi                                     | 9495 ++++++++++
 arch/arm64/boot/dts/qcom/purwa.dtsi                                     |  756 
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts                    |    4 
 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi                       |    9 
 arch/arm64/boot/dts/qcom/x1-crd.dtsi                                    |    2 
 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi                             |    2 
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts                            |    4 
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi             |    4 
 arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts                 |    4 
 arch/arm64/boot/dts/qcom/x1e80100-asus-zenbook-a14.dts                  |   10 
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts                               |    2 
 arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts        |    2 
 arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts                |    2 
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts                   |    4 
 arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts                   |    4 
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts                |    4 
 arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi                |    4 
 arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi                            |  549 
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                               |    4 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                                  | 9495 ----------
 arch/arm64/boot/dts/qcom/x1p42100-asus-zenbook-a14-lcd.dts              |   62 
 arch/arm64/boot/dts/qcom/x1p42100-asus-zenbook-a14.dts                  |  133 
 arch/arm64/boot/dts/qcom/x1p42100-asus-zenbook-a14.dtsi                 |  138 
 arch/arm64/boot/dts/qcom/x1p42100-crd.dts                               |    2 
 arch/arm64/boot/dts/qcom/x1p42100-hp-omnibook-x14.dts                   |    4 
 arch/arm64/boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dts               |    4 
 arch/arm64/boot/dts/qcom/x1p42100.dtsi                                  |  754 
 arch/arm64/include/asm/ptdump.h                                         |    2 
 arch/arm64/mm/mmu.c                                                     |   43 
 arch/arm64/mm/ptdump.c                                                  |   11 
 arch/s390/kvm/pci.c                                                     |   31 
 arch/x86/kernel/cpu/common.c                                            |   10 
 arch/x86/kernel/cpu/mce/core.c                                          |    2 
 arch/x86/kvm/mmu/mmu.c                                                  |    3 
 arch/x86/kvm/svm/sev.c                                                  |   34 
 arch/x86/kvm/svm/svm.h                                                  |    1 
 block/blk-mq.c                                                          |   34 
 drivers/android/binder/process.rs                                       |   12 
 drivers/ata/pata_sl82c105.c                                             |    4 
 drivers/bluetooth/btrtl.c                                               |   13 
 drivers/bluetooth/btusb.c                                               |    2 
 drivers/counter/microchip-tcb-capture.c                                 |    4 
 drivers/dibs/dibs_loopback.c                                            |    1 
 drivers/dibs/dibs_main.c                                                |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                              |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                 |   35 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                       |    6 
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c               |   24 
 drivers/gpu/drm/bridge/parade-ps8640.c                                  |   27 
 drivers/gpu/drm/v3d/v3d_drv.h                                           |    6 
 drivers/gpu/drm/v3d/v3d_sched.c                                         |    9 
 drivers/gpu/drm/xe/xe_uc.c                                              |    7 
 drivers/hwmon/ads7828.c                                                 |   11 
 drivers/hwmon/corsair-psu.c                                             |    4 
 drivers/hwmon/ltc4282.c                                                 |   20 
 drivers/hwmon/nzxt-smart2.c                                             |    6 
 drivers/hwmon/pmbus/lm25066.c                                           |    5 
 drivers/hwmon/pmbus/pmbus_core.c                                        |  338 
 drivers/input/evdev.c                                                   |   27 
 drivers/iommu/intel/iommu.c                                             |   11 
 drivers/misc/fastrpc.c                                                  |   27 
 drivers/misc/mei/client.c                                               |   25 
 drivers/net/bonding/bond_alb.c                                          |   10 
 drivers/net/ethernet/amd/pds_core/core.h                                |    1 
 drivers/net/ethernet/amd/pds_core/main.c                                |   14 
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c                        |   51 
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h                        |    1 
 drivers/net/ethernet/aquantia/atlantic/aq_vec.c                         |    2 
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c                        |    2 
 drivers/net/ethernet/broadcom/bnge/bnge_resc.c                          |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                               |  163 
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                               |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c                           |    7 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                           |    6 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h                           |    2 
 drivers/net/ethernet/cisco/enic/enic_main.c                             |    5 
 drivers/net/ethernet/freescale/fec_main.c                               |   11 
 drivers/net/ethernet/google/gve/gve_main.c                              |    9 
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c                           |    1 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                 |    6 
 drivers/net/ethernet/intel/igc/igc_main.c                               |   10 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c                    |    6 
 drivers/net/ethernet/marvell/prestera/prestera_pci.c                    |    3 
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c                |   16 
 drivers/net/ethernet/mellanox/mlx5/core/en.h                            |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h                    |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c                        |   15 
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h                        |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c                     |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                       |   14 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                         |    4 
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c                            |    8 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                       |   13 
 drivers/net/netdevsim/netdev.c                                          |    7 
 drivers/net/ovpn/main.c                                                 |   64 
 drivers/net/ovpn/netlink.c                                              |    6 
 drivers/net/ovpn/peer.c                                                 |  172 
 drivers/net/ovpn/peer.h                                                 |    1 
 drivers/net/ovpn/socket.c                                               |    9 
 drivers/net/phy/mediatek/mtk.h                                          |    8 
 drivers/net/tap.c                                                       |   24 
 drivers/net/thunderbolt/main.c                                          |   33 
 drivers/net/usb/ax88179_178a.c                                          |    4 
 drivers/net/usb/ipheth.c                                                |   11 
 drivers/net/veth.c                                                      |   22 
 drivers/net/vxlan/vxlan_core.c                                          |    2 
 drivers/nvmem/apple-spmi-nvmem.c                                        |   20 
 drivers/nvmem/core.c                                                    |   24 
 drivers/nvmem/internals.h                                               |    2 
 drivers/nvmem/layouts.c                                                 |   11 
 drivers/nvmem/layouts/Makefile                                          |    1 
 drivers/nvmem/layouts/fixed-layout.c                                    |   58 
 drivers/pinctrl/qcom/pinctrl-ipq8064.c                                  |    8 
 drivers/pinctrl/qcom/pinctrl-msm.h                                      |    5 
 drivers/ptp/ptp_ocp.c                                                   |    4 
 drivers/s390/net/ism_drv.c                                              |   19 
 drivers/scsi/scsi_debug.c                                               |    4 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c                          |    3 
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c                           |    2 
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c                          |    3 
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c                       |    4 
 drivers/thermal/thermal_hwmon.c                                         |    3 
 drivers/thunderbolt/eeprom.c                                            |    9 
 drivers/thunderbolt/icm.c                                               |    2 
 drivers/thunderbolt/tb.c                                                |    2 
 drivers/tty/serial/8250/8250_dma.c                                      |   12 
 drivers/tty/serial/8250/8250_of.c                                       |   38 
 drivers/tty/serial/amba-pl011.c                                         |   68 
 drivers/tty/serial/qcom_geni_serial.c                                   |   43 
 drivers/tty/vt/keyboard.c                                               |    5 
 drivers/tty/vt/vt_ioctl.c                                               |    2 
 drivers/usb/atm/cxacru.c                                                |    2 
 drivers/usb/cdns3/cdnsp-gadget.c                                        |    4 
 drivers/usb/core/config.c                                               |   32 
 drivers/usb/core/quirks.c                                               |    7 
 drivers/usb/gadget/function/f_ncm.c                                     |    2 
 drivers/usb/misc/usbio.c                                                |    2 
 drivers/vdpa/mlx5/core/mr.c                                             |    3 
 drivers/vhost/scsi.c                                                    |   17 
 drivers/vhost/vdpa.c                                                    |    9 
 drivers/vhost/vhost.c                                                   |    8 
 drivers/video/fbdev/core/bitblit.c                                      |    9 
 drivers/watchdog/at91sam9_wdt.c                                         |    4 
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
 fs/xfs/xfs_buf.c                                                        |    2 
 include/linux/dibs.h                                                    |    2 
 include/linux/mmap_lock.h                                               |    1 
 include/linux/netdevice.h                                               |   11 
 include/linux/netfilter/ipset/ip_set.h                                  |    2 
 include/linux/nvmem-provider.h                                          |    6 
 include/linux/psi.h                                                     |    4 
 include/linux/sched.h                                                   |   13 
 include/linux/usb/quirks.h                                              |    3 
 include/net/act_api.h                                                   |   19 
 include/net/addrconf.h                                                  |    4 
 include/net/ip_vs.h                                                     |   41 
 include/net/libeth/xsk.h                                                |    2 
 include/net/netdev_queues.h                                             |   47 
 include/net/netdev_rx_queue.h                                           |    2 
 include/net/netfilter/nf_flow_table.h                                   |    1 
 include/net/page_pool/types.h                                           |    1 
 include/net/route.h                                                     |    2 
 include/net/sch_generic.h                                               |    1 
 include/net/xdp_sock.h                                                  |   45 
 include/net/xdp_sock_drv.h                                              |   77 
 kernel/bpf/verifier.c                                                   |   68 
 kernel/cgroup/cgroup.c                                                  |   23 
 kernel/events/core.c                                                    |   67 
 kernel/futex/core.c                                                     |   85 
 kernel/sched/fair.c                                                     |  148 
 kernel/sched/psi.c                                                      |   75 
 kernel/trace/ring_buffer.c                                              |   13 
 kernel/trace/trace_events.c                                             |    4 
 mm/damon/ops-common.c                                                   |   13 
 mm/damon/paddr.c                                                        |    2 
 mm/damon/vaddr.c                                                        |    3 
 mm/filemap.c                                                            |    6 
 mm/huge_memory.c                                                        |   43 
 mm/pagewalk.c                                                           |   36 
 mm/ptdump.c                                                             |    7 
 mm/vmalloc.c                                                            |   40 
 net/atm/common.c                                                        |   14 
 net/bridge/br_mrp.c                                                     |    6 
 net/bridge/netfilter/ebt_nflog.c                                        |   17 
 net/bridge/netfilter/nf_conntrack_bridge.c                              |    1 
 net/core/datagram.c                                                     |    3 
 net/core/dev.c                                                          |   27 
 net/core/netdev_rx_queue.c                                              |   21 
 net/core/sock.c                                                         |    1 
 net/core/xdp.c                                                          |    2 
 net/devlink/dev.c                                                       |    1 
 net/ipv4/fib_semantics.c                                                |  101 
 net/ipv4/inet_connection_sock.c                                         |   20 
 net/ipv4/inet_fragment.c                                                |   10 
 net/ipv4/route.c                                                        |   29 
 net/ipv4/tcp_bpf.c                                                      |    2 
 net/ipv4/tcp_input.c                                                    |    2 
 net/ipv4/tcp_ipv4.c                                                     |   43 
 net/ipv4/udp_offload.c                                                  |    4 
 net/ipv6/ip6_tunnel.c                                                   |    3 
 net/ipv6/route.c                                                        |    8 
 net/mac802154/scan.c                                                    |    4 
 net/ncsi/ncsi-netlink.c                                                 |    4 
 net/netfilter/ipset/ip_set_bitmap_gen.h                                 |    4 
 net/netfilter/ipset/ip_set_core.c                                       |    6 
 net/netfilter/ipset/ip_set_hash_gen.h                                   |    2 
 net/netfilter/ipset/ip_set_list_set.c                                   |    4 
 net/netfilter/ipvs/ip_vs_conn.c                                         |   41 
 net/netfilter/ipvs/ip_vs_core.c                                         |   68 
 net/netfilter/ipvs/ip_vs_ctl.c                                          |   77 
 net/netfilter/ipvs/ip_vs_est.c                                          |   10 
 net/netfilter/ipvs/ip_vs_lc.c                                           |    4 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                                   |    4 
 net/netfilter/ipvs/ip_vs_proto_tcp.c                                    |    2 
 net/netfilter/ipvs/ip_vs_sync.c                                         |    7 
 net/netfilter/ipvs/ip_vs_xmit.c                                         |    2 
 net/netfilter/nf_conntrack_proto.c                                      |    6 
 net/netfilter/nf_conntrack_proto_sctp.c                                 |   12 
 net/netfilter/nf_conntrack_proto_tcp.c                                  |  132 
 net/netfilter/nf_flow_table_core.c                                      |    1 
 net/netfilter/nf_flow_table_ip.c                                        |   95 
 net/netfilter/nf_flow_table_path.c                                      |    9 
 net/netfilter/nf_tables_api.c                                           |    4 
 net/openvswitch/datapath.c                                              |   29 
 net/openvswitch/flow.c                                                  |   11 
 net/packet/af_packet.c                                                  |   72 
 net/sched/act_ct.c                                                      |   29 
 net/sched/act_gact.c                                                    |    5 
 net/sched/act_police.c                                                  |    6 
 net/sched/cls_api.c                                                     |   17 
 net/sched/cls_route.c                                                   |   35 
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
 net/tls/tls_sw.c                                                        |   18 
 net/vmw_vsock/virtio_transport.c                                        |   14 
 net/x25/af_x25.c                                                        |    4 
 net/x25/x25_timer.c                                                     |   25 
 net/xdp/xdp_umem.c                                                      |    2 
 net/xdp/xsk.c                                                           |   11 
 net/xdp/xsk_buff_pool.c                                                 |    6 
 samples/damon/mtier.c                                                   |    3 
 security/integrity/ima/ima_appraise.c                                   |    9 
 security/integrity/ima/ima_main.c                                       |   39 
 sound/hda/codecs/side-codecs/tas2781_hda_spi.c                          |    3 
 sound/usb/endpoint.c                                                    |    6 
 sound/usb/fcp.c                                                         |   10 
 sound/usb/midi2.c                                                       |    9 
 sound/usb/usx2y/us144mkii_capture.c                                     |    1 
 sound/usb/usx2y/usX2Yhwdep.c                                            |    2 
 sound/usb/usx2y/usx2yhwdeppcm.c                                         |    2 
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c                  |    6 
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c                 |   21 
 tools/testing/selftests/bpf/test_maps.c                                 |   13 
 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc     |   16 
 tools/testing/selftests/net/tls.c                                       |   57 
 tools/testing/selftests/sched_ext/numa.bpf.c                            |   13 
 283 files changed, 14033 insertions(+), 12382 deletions(-)

Aditya Chillara (1):
      perf/core: Fix group leader use-after-free after sibling detach

Aelin Reidel (1):
      nvmem: apple-spmi-nvmem: wrap regmap calls to satisfy CFI

Ahmad Byagowi (1):
      ptp: ocp: Fix board ID over-read

Ahmed Naseef (1):
      net: phy: mediatek: fix TX blink masks using the RX bits

Akhil P Oommen (1):
      arm64: dts: qcom: purwa: Fix GPU IOMMU property

Al Viro (1):
      mount: honour SB_NOUSER in the new mount API

Aleksandr Nogikh (1):
      usb: atm: cxacru: properly kill rcv_urb on error in cxacru_cm()

Aleksandrs Vinarskis (1):
      arm64: dts: qcom: Rework X1-based Asus Zenbook A14's displays

Alex Deucher (1):
      Revert "drm/amd/display: Fix backlight max_brightness to match exported range"

Alexander Usyskin (1):
      mei: pull kvfree out of spinlock

Alexandra Winter (2):
      s390/ism: Fix UAF of sba and ieq during ism_dev_exit()
      net/dibs: Correct freeing of dmb_clientid_arr

Alexej Sidorenko (1):
      Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan

Alice Ryhl (1):
      rust_binder: do not query current thread for all ioctls

Alok Tiwari (1):
      bnge: use int for bnge_fix_rings_count() return value

Anandu Krishnan E (1):
      misc: fastrpc: fix channel ctx ref leak when session alloc fails

Anna Schumaker (1):
      NFS: Pin the 'struct nfs_server' during a FREE_STATEID call

Antonio Quartulli (7):
      ovpn: skip rehash for peers already removed from by_id
      ovpn: rehash peer in by_transp_addr table on CMD_PEER_SET
      ovpn: ensure socket is owned by ovpn before deref sk_user_data
      ovpn: zero-initialize sockaddr before learning a floated endpoint
      ovpn: hash floated peer by transport identity only
      ovpn: disable IPv4 redirects on MP interfaces
      ovpn: ensure TCP vars are initialized first

Asad Kamal (1):
      Revert "drm/amdgpu: fix aperture mapping leak"

Babanpreet Singh (1):
      counter: microchip-tcb-capture: Fix DT channel validation

Baul Lee (8):
      ALSA: usb-audio: fix OOB write on Type II inbound URBs
      net: bridge: mrp: fix uninitialised bytes on the wire
      ALSA: usx2y: bound the hwdep mmap fault offset
      ALSA: FCP: fix OOB write in fcp_meter_ctl_get()
      ALSA: us144mkii: re-anchor capture URBs on resubmission
      net/x25: fix use-after-free of the socket by its timers
      vxlan: do not arm the ageing timer on a device that is down
      sctp: keep chunk->transport in step with the list it is queued on

Bhargava Marreddy (1):
      bnge: Fix resource leak in bnge_init_nic() error path

Bobby Eshleman (1):
      net/mlx5e: fix BQL reset on SQ re-activation

Breno Leitao (1):
      x86/mce: Set up the polling timer before CMCI discovery

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

Cunhao Lu (1):
      serial: 8250_dma: Clear stale RX state on shutdown

Daming Li (1):
      net: smc: fix splice entry lifetime imbalance in smc_rx_splice

Daniel Drake (1):
      arm64: dts: broadcom: bcm2712: Remove non-functional EL2 virtual timer

Dmitry Antipov (1):
      btrfs: fix memory leak in btrfs_do_encoded_write()

Dmitry Baryshkov (3):
      arm64: dts: qcom: rename x1e80100 to hamoa
      arm64: dts: qcom: rename x1p42100 to purwa
      arm64: dts: qcom: sdm850-lenovo-yoga-c630: lower PSCI cluster idle

Dmitry Torokhov (2):
      Input: evdev - sanitize event type index when fetching event masks
      Input: evdev - fix information leak in evdev_pass_values()

Dongli Zhang (1):
      net: tap: set skb->dev before parsing virtio net header in tap_get_user_xdp()

Doruk Tan Ozturk (2):
      net: usb: ipheth: fix carrier_work UAF on disconnect
      net/packet: reset the MAC header on the packet-socket transmit path

Eddie Lin (1):
      misc: fastrpc: fix memory leak in fastrpc_channel_ctx_free

Eduard Zingerman (1):
      bpf: split check_reg_sane_offset() in two parts

Ekansh Gupta (2):
      misc: fastrpc: Fix initial memory allocation for Audio PD memory pool
      misc: fastrpc: Remove buffer from list prior to unmap operation

Eric Biggers (2):
      fsverity: Fix bpf_get_fsverity_digest() dynptr assumptions
      fsverity: Fix silent truncation in bpf_get_fsverity_digest()

Eric Dumazet (3):
      netfilter: nf_flow_table: drop existing skb dst before skb_dst_set_noref()
      net: remove WARN_ON_ONCE() from sk_mc_loop()
      net/atm: fix slab-out-of-bounds read in vcc_setsockopt()

Fan Wu (3):
      serial: amba-pl011: fix indefinite RS485 post-send delay
      serial: amba-pl011: cancel RS485 hrtimers after freeing IRQ
      serial: amba-pl011: synchronize DMA teardown

Fan XinRan (1):
      net: thunderbolt: Tear down DMA paths before stopping the rings

Fan Ye (1):
      Revert "net: thunderbolt: Enable end-to-end flow control also in transmit"

Farhan Ali (1):
      KVM: s390: pci: Fix resource leak on IRQ registration failure

Florian Westphal (1):
      netfilter: nf_tables: avoid softlockup warnings in nft_chain_validate

Greg Kroah-Hartman (1):
      Linux 6.18.45

Guenter Roeck (6):
      hwmon: (pmbus_core) Use guard() for mutex protection
      hwmon: (pmbus) Fix type confusion in notification logic
      hwmon: (pmbus/lm25066) Fix PMBus coefficient calculations
      hwmon: (ltc4282) Avoid overflow in maximum power calculation
      hwmon: (ltc4282) Clamp negative current limits
      hwmon: (ltc4282) Fix parsing adi,current-limit-sense-microvolt

Hans Ulli Kroll (2):
      pinctrl: qcom: ipq806x: mark gpio as a GPIO pin function
      pinctrl: qcom: ipq806x: mark pci reset as a GPIO pin function

Harshal Dev (1):
      dt-bindings: crypto: qcom,ice: Fix missing power-domain and iface clk

Henry Martin (1):
      net/ncsi: fix heap OOB read in NCSI_CMD_SEND_CMD payload length

Hidayath Khan (1):
      dibs: initialise dibs->lock in dibs_dev_alloc()

Hongyan Xu (2):
      ata: pata_sl82c105: fix bridge revision use-after-free
      watchdog: at91sam9_wdt: prevent timer rearm during teardown

Hugh Dickins (1):
      mm/filemap: __filemap_add_folio() restore index before retrying

Hui Su (2):
      ring-buffer: Fix crash passing ERR_PTR to kthread_stop()
      tracing: Fix NULL pointer dereference in module event cache removal

Hyunjung Ko (2):
      net/sched: act_ct: fix sk_buff leak when the header checks reject a packet
      net/sched: act_gact, act_police: range check the fallback control action

Ingo Molnar (1):
      sched/fair: Separate se->vlag from se->vprot

Ishaan Dandekar (1):
      usb: quirks: Add ShanWan gamepad to quirk list

Jakub Kicinski (1):
      net: reduce indent of struct netdev_queue_mgmt_ops members

Jamal Hadi Salim (2):
      net/sched: cls_route: fix fastmap use-after-free on filter
      net/sched: cls_api: Always acquire rtnl_lock when destroying locked classifiers

Jan Sebastian Götte (1):
      serial: qcom-geni: fix TX DMA buffer flush

Jia Jia (1):
      vhost-scsi: reject feature changes after endpoint

Jiangshan Yi (1):
      usb: misc: usbio: check ibuf_len against rxbuf_len in bulk msg

Jiawen Liu (1):
      net: hisilicon: hix5hd2_gmac: remove redundant NAPI delete

Jiayuan Chen (1):
      tcp: fix TFO max_qlen accounting across reuseport migration

Jijie Shao (1):
      net: hns3: fix speed configuration residue after driver reload

Jose Fernandez (Anthropic) (2):
      bpf: tcp: Fix use-after-free in bpf_iter_tcp_established_batch()
      iommu/vt-d: Gather the unmapped range before freeing its page tables

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

Jérémy Jean (1):
      tls: rx: restore msg_iter before TLS 1.3 optimistic retry

Keegan Freyhof (1):
      bnxt_en: Fix PTP PPS setting bug

Keith Busch (2):
      blk-mq: pop cached request if it is usable
      blk-mq: reinsert cached request to the list

Keno Fischer (1):
      futex: Prevent robust futex exit race some more

Kuba Piecuch (1):
      selftests/sched_ext: Handle sleeping task affinity changes in numa test

Kyle Zeng (2):
      ipvs: clear IPv4 options after rebasing tunnel ICMP errors
      ipv6: prevent in6_dev_get() from resurrecting inet6_dev

Lincoln Wallace (1):
      ima: fix out-of-bounds read in xattr_verify()

Linfeng Sun (1):
      vhost-scsi: Validate T10 PI scatterlist counts

Lorenzo Bianconi (1):
      netfilter: always set route tuple out ifindex

Lorenzo Stoakes (ARM) (4):
      mm/vmalloc: acquire init_mm lock on huge vmap to avoid ptdump UAF
      mm/huge_memory: fix huge_zero_pfn race
      arm64: remove redundant concurrent ptdump UAF mitigation
      mm/ptdump: always stabilise against page table freeing using init_mm

Mahanta Jambigi (1):
      net/smc: fix qentry overwrite for CONFIRM_LINK and ADD_LINK_CONT in smc_llc_event_handler()

Marcin Bernatowicz (1):
      drm/xe/uc: Apply RCS/CCS yield policy to SR-IOV VFs

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

Maíra Canal (1):
      drm/v3d: Serialize the scheduler timeout handlers

Mehmet Fide (1):
      net: fec: do not release NULL pages when RX buffer allocation fails

Michael Chan (2):
      bnxt_en: Do not set EOP on RX AGG BDs on 5760X chips
      bnxt_en: Disable EOP for TPA on all chips to prevent data corruption

Michael Guralnik (1):
      net/mlx5: fw_tracer, return NULL on create error

Michael Wu (1):
      tracing: Fix race between update_event_fields and, event_define_fields

Michal Luczaj (3):
      selftests/bpf: Fail unbound UDP on sockmap update
      selftests/bpf: Ensure UDP sockets are bound
      selftests/bpf: Adapt sockmap update error handling

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

Nikhil Solanke (1):
      usb: core: Add quirk for 255-bytes initial config read

Nils Helmig (1):
      Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV

Or Har-Toov (1):
      devlink: fix net namespace reference leak in reload

Pablo Neira Ayuso (2):
      netfilter: flowtable: consolidate xmit path
      netfilter: flowtable: ensure sufficient headroom in xmit path

Panagiotis Petrakopoulos (1):
      staging: rtl8723bs: fix missing shared-key auth challenge length check

Paolo Bonzini (1):
      KVM: SVM: Serialize accesses to the owner and mirror list with separate lock

Pavel Begunkov (5):
      net: add bare bone queue configs
      net: pass queue rx page size from memory provider
      eth: bnxt: store rx buffer size per queue
      eth: bnxt: support qcfg provided rx page size
      net: devmem: prevent net-iov / page mixing

Pawel Laszczak (1):
      usb: cdnsp: fix incorrect endian conversions for APB timeout register

Pengpeng Hou (2):
      drm/bridge: ps8640: propagate AUX transfer register errors
      net: prestera: validate firmware header length

Peter Zijlstra (1):
      sched/fair: Revert 6d71a9c61604 ("sched/fair: Fix EEVDF entity placement bug causing scheduling lag")

Philipp David (1):
      igc: fix netdev not re-attached after resume if interface is down

Qihang Tang (3):
      packet: use consistent hard_header_len in non-ring send paths
      packet: use consistent hard_header_len in TX_RING send path
      net: remove CAP_SYS_RAWIO zero-padding in dev_validate_header

Qing Luo (1):
      sctp: fix addip_serial increment on ASCONF_ACK allocation failure

Qing Ming (1):
      sctp: clear new_transport when removing a peer

Qingfang Deng (1):
      ovpn: fix incorrect use of rcu_access_pointer()

Qingshuang Fu (2):
      hwmon: (nzxt-smart2) Check return value of init_device() in probe
      hwmon: (ads7828) Fix external VREF regulator handling

Rafael J. Wysocki (1):
      Revert "thermal/drivers/hwmon: Cleanup coding style a bit"

Ralf Lici (1):
      ovpn: add missing rtnl_link_ops->get_size callback

Ray Wu (2):
      drm/amd/display: Add AV mute wait frames to dce110_set_avmute
      drm/amd/display: Check for tg ops in dce110_set_avmute

Rik van Riel (2):
      fbdev: bitblit: bound-check glyph index in bit_cursor()
      x86/CPU: Add a tlbi= cmdline switch

Rosen Penev (1):
      ARM: dts: BCM5301X: fix PCIe controller 2 second interrupt

Ryan Wilbur (1):
      serial: 8250_of: clear stuck empty-FIFO RX-timeout on LPC32xx

SJ Park (2):
      samples/damon/mtier: error out for zero quota goal target values
      mm/damon: adjust isolated pages stat for DAMOS_MIGRATE_{HOT,COLD}

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

Stanislav Fomichev (6):
      xsk: require at least 16 bytes of TX metadata
      xsk: pass TX metadata pointer by reference
      xsk: clear metadata pointer when no timestamp is requested
      xsk: validate launch-time metadata size
      xsk: move xsk_tx_metadata_request() to xdp_sock_drv.h
      xsk: validate metadata when processing requests

Stefan Agner (1):
      net: stmmac: resume PHY before hardware setup when opening the interface

Sun Jian (2):
      net: fix skb length accounting after generic XDP frag adjustment
      veth: fix skb length accounting after XDP frag adjustment

Takashi Iwai (1):
      ALSA: usb: Fix UAF at delayed release of MIDI2 EPs

Tejun Heo (2):
      sched/psi: Shut down rtpoll_timer in psi_cgroup_free()
      sched/psi: Create the psimon kthread outside of cgroup_mutex

Tengda Wu (1):
      ring-buffer: Use current_context for safe per-CPU buffer swap

Toke Høiland-Jørgensen (1):
      net/sched: sch_cake: drop WARN_ON(1) for malformed packets in ACK filter

Vincent Donnefort (2):
      ring-buffer: Prevent subbuf order change when resizing is disabled
      ring-buffer: Initialise reader page order in rb_allocate_cpu_buffer()

Weiming Shi (2):
      vsock/virtio: read virtqueues under worker locks
      vsock/virtio: avoid refilling the RX queue after teardown

Wilken Gottwalt (1):
      hwmon: (corsair-psu) fix possible out-of-bounds access on missing string termination

Will Chen (1):
      bnxt: fix memory leak in bnxt_queue_mem_alloc error cases

Xiang Mei (Microsoft) (1):
      bonding: alb: re-check primary_is_promisc under RTNL in bond_alb_monitor

Xin Long (1):
      sctp: clear control chunk transport if it is being removed

Xu Rao (4):
      thunderbolt: icm: Preserve USB4 proxy data-valid bit
      ALSA: hda/tas2781: fix ACPI reference handling
      scsi: scsi_debug: Negate wrapped memcmp() result
      thunderbolt: Fix bandwidth group reservation indexing

Xuanqiang Luo (1):
      udp: fix potential use-after-free in tunnel segmentation

Yangyu Chen (2):
      net: atlantic: free stranded TX buffers on ring deinit
      net: atlantic: free RX pages of consumed but not refilled buffers

Yi Cong (1):
      net: usb: ax88179_178a: fix skb leak in ax88179_tx_fixup()

Yiyang Chen (2):
      bpf: Preserve pointer state for commuted arithmetic
      bpf: Propagate untrusted pointer state in commuted arithmetic

Yousef Alhouseen (1):
      vhost/vdpa: reject overflowing PA map page counts on 32-bit

Yuejie Shi (1):
      ipv6: fix Route Information option length validation

Yuho Choi (1):
      ARM: npcm: Fix OF node refcount leaks in SMP setup

Yun Zhou (1):
      xfs: handle NULL b_addr in xfs_buf_free

Yuxiang Yang (1):
      sctp: fix use-after-free of cached ASCONF chunk

Zhan Xusheng (1):
      fscrypt: use the mount idmap for the owner check in fscrypt_ioctl_set_policy()

Zhiling Zou (6):
      ipvs: stop estimator after disabled calc phase
      net: openvswitch: reallocate update replies for mismatched IDs
      inet: frags: publish queues before arming timer
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

liyouhong (1):
      mm/damon/ops-common: putback folios on invalid migrate nid

