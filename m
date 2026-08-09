Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2455323ABB9;
	Sun,  9 Aug 2026 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786300574; cv=none; b=NReCdopT/WOrhaHpw05YO/43o/njx5mTYRxtyjWUSvz3ubTSeMWS1kUUAAdwXjYCXAVCi+aVImb8Bok00NFUh1kn1Eo0cQqNwJdFBffnfvNuXKIQcNKLfui0c6v1brCRg1Bw9bjJSq8AoX1FgYR5/UyrTMgFZBzdJJ92aKQ8Ljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786300574; c=relaxed/simple;
	bh=yXhfwCmEwZfxmoZPM0hhFs0GILxtxp2laYbr8LcNGhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oYJBiYatTFUae6Zy1gRnnBpkBCKSL2fbZIAY+LKWLv8IPgOT4Sd46uWVbfLtTtBwXHXOyItg+pkWTh0rmG8zsDxf5JG4z7l/bbFfkxHw6bmo24qIRogtfJBZLRQoTo7lSGSo+eJvtka0tW8yEHniJ4UmIOQN7Hi+ye7W/8kzu7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wxAzUAAG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wxAzUAAG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2071F000E9;
	Sun,  9 Aug 2026 18:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786300571;
	bh=RDfaX0EQoKTZCdhPKp+oFa5hkHFF/2Ka7oXPiAgwGPo=;
	h=From:To:Cc:Subject:Date;
	b=wxAzUAAGQwGl93TaC5xhGFby1sBlaPV93X6Ajonfd12lOxYPWVv1sd0ZDmXsPOsiJ
	 fmR5kUS8fMwjXbbfuyCS58wib2uRktzae/3BlZfBEsjaHoUK8oPnUTfLlqLs3wIgUM
	 MC8Xt2BIEkmO0HrlyWl57yDTdPfoYAgJd4whOYoI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.151
Date: Sun,  9 Aug 2026 20:34:37 +0200
Message-ID: <2026080938-tried-nickname-7dae@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.151 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                      |    2 
 arch/powerpc/boot/simpleboot.c                                |    2 
 arch/powerpc/boot/treeboot-akebono.c                          |    2 
 arch/powerpc/boot/treeboot-currituck.c                        |    2 
 arch/powerpc/platforms/ps3/mm.c                               |    1 
 arch/s390/kvm/pci.c                                           |   28 
 arch/um/drivers/vector_kern.c                                 |    3 
 arch/x86/kvm/svm/avic.c                                       |    8 
 drivers/accel/qaic/qaic_control.c                             |    2 
 drivers/ata/ahci.h                                            |   17 
 drivers/ata/ahci_brcm.c                                       |    3 
 drivers/ata/ahci_ceva.c                                       |   24 
 drivers/ata/libahci.c                                         |    1 
 drivers/ata/libahci_platform.c                                |   38 
 drivers/ata/libata-eh.c                                       |    8 
 drivers/ata/sata_mv.c                                         |    2 
 drivers/block/ublk_drv.c                                      |    9 
 drivers/bluetooth/btintel.c                                   |    3 
 drivers/bluetooth/btmtk.c                                     |   50 
 drivers/cpufreq/ia64-acpi-cpufreq.c                           |    4 
 drivers/cpufreq/powernow-k8.c                                 |    1 
 drivers/dma/idxd/cdev.c                                       |    4 
 drivers/dma/sun6i-dma.c                                       |   11 
 drivers/firmware/stratix10-svc.c                              |   10 
 drivers/gpio/gpio-pca953x.c                                   |   15 
 drivers/gpio/gpio-pch.c                                       |   28 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                       |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c                   |   30 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                       |   12 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                      |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_events.c                       |   23 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c        |    2 
 drivers/gpu/drm/armada/armada_fbdev.c                         |   12 
 drivers/gpu/drm/display/drm_dp_helper.c                       |   12 
 drivers/gpu/drm/drm_fb_helper.c                               |   41 
 drivers/gpu/drm/drm_fbdev_dma.c                               |   12 
 drivers/gpu/drm/drm_fbdev_generic.c                           |   12 
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c                     |    9 
 drivers/gpu/drm/gma500/fbdev.c                                |   13 
 drivers/gpu/drm/i915/display/intel_display_core.h             |    3 
 drivers/gpu/drm/i915/display/intel_display_device.c           |    3 
 drivers/gpu/drm/i915/display/intel_display_types.h            |   40 
 drivers/gpu/drm/i915/display/intel_fbc.c                      |    9 
 drivers/gpu/drm/i915/display/intel_fbdev.c                    |    9 
 drivers/gpu/drm/i915/display/intel_hdcp.c                     |  266 +--
 drivers/gpu/drm/i915/display/intel_vrr.c                      |   10 
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c               |    7 
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c                       |    6 
 drivers/gpu/drm/msm/msm_fbdev.c                               |    9 
 drivers/gpu/drm/omapdrm/omap_fbdev.c                          |    9 
 drivers/gpu/drm/radeon/radeon_fbdev.c                         |   13 
 drivers/gpu/drm/renesas/Kconfig                               |    1 
 drivers/gpu/drm/renesas/Makefile                              |    1 
 drivers/gpu/drm/renesas/rcar-du/Kconfig                       |    8 
 drivers/gpu/drm/renesas/rcar-du/Makefile                      |    2 
 drivers/gpu/drm/renesas/rcar-du/rzg2l_mipi_dsi.c              |  816 ----------
 drivers/gpu/drm/renesas/rcar-du/rzg2l_mipi_dsi_regs.h         |  151 -
 drivers/gpu/drm/renesas/rz-du/Kconfig                         |    8 
 drivers/gpu/drm/renesas/rz-du/Makefile                        |    3 
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c                |  816 ++++++++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi_regs.h           |  151 +
 drivers/gpu/drm/tegra/fbdev.c                                 |   18 
 drivers/gpu/drm/vc4/vc4_irq.c                                 |    2 
 drivers/gpu/drm/vc4/vc4_validate.c                            |   29 
 drivers/gpu/drm/vmwgfx/ttm_object.c                           |    7 
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c                          |   39 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                       |   20 
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c                      |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c                        |   13 
 drivers/hid/hid-logitech-dj.c                                 |   28 
 drivers/hwmon/adt7470.c                                       |  129 +
 drivers/hwmon/lm90.c                                          |    4 
 drivers/hwmon/nct6775-core.c                                  |   20 
 drivers/hwmon/npcm750-pwm-fan.c                               |   11 
 drivers/hwmon/nzxt-smart2.c                                   |    2 
 drivers/hwmon/pmbus/pmbus_core.c                              |    7 
 drivers/i2c/busses/i2c-amd-mp2-plat.c                         |    4 
 drivers/i2c/busses/i2c-imx.c                                  |    9 
 drivers/i2c/busses/i2c-jz4780.c                               |    5 
 drivers/iommu/iommu-sva.c                                     |    6 
 drivers/media/i2c/imx219.c                                    |  668 ++++----
 drivers/media/v4l2-core/v4l2-async.c                          |    8 
 drivers/media/v4l2-core/v4l2-fwnode.c                         |    6 
 drivers/net/can/c_can/c_can_main.c                            |    8 
 drivers/net/can/ctucanfd/ctucanfd_base.c                      |   14 
 drivers/net/can/ctucanfd/ctucanfd_pci.c                       |    3 
 drivers/net/can/dev/skb.c                                     |    2 
 drivers/net/can/softing/softing_fw.c                          |   46 
 drivers/net/can/usb/ems_usb.c                                 |   43 
 drivers/net/can/usb/etas_es58x/es58x_core.c                   |    1 
 drivers/net/can/usb/gs_usb.c                                  |    4 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c             |    1 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c              |   13 
 drivers/net/can/usb/peak_usb/pcan_usb_core.c                  |    1 
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c                    |   40 
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c                   |   20 
 drivers/net/dsa/mt7530.c                                      |   58 
 drivers/net/ethernet/google/gve/gve.h                         |    3 
 drivers/net/ethernet/google/gve/gve_main.c                    |    3 
 drivers/net/ethernet/google/gve/gve_rx_dqo.c                  |   33 
 drivers/net/ethernet/intel/e1000/e1000_main.c                 |    2 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                  |   10 
 drivers/net/ethernet/intel/ice/ice_main.c                     |   10 
 drivers/net/ethernet/intel/igbvf/netdev.c                     |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c          |    2 
 drivers/net/ethernet/nvidia/forcedeth.c                       |    4 
 drivers/net/ethernet/qlogic/qede/qede_main.c                  |   44 
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c               |   14 
 drivers/net/phy/phylink.c                                     |   29 
 drivers/net/vrf.c                                             |    2 
 drivers/net/vxlan/vxlan_core.c                                |   15 
 drivers/net/wireless/ath/ath6kl/txrx.c                        |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c     |   16 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h        |    6 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c       |    4 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c       |   46 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c       |    6 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c       |   14 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h       |    1 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c        |    3 
 drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h |    2 
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c          |    2 
 drivers/phy/xilinx/phy-zynqmp.c                               |  130 -
 drivers/pinctrl/Kconfig                                       |    2 
 drivers/pinctrl/devicetree.c                                  |    4 
 drivers/pinctrl/pinctrl-amd.c                                 |    3 
 drivers/pinctrl/qcom/pinctrl-sc8280xp.c                       |   21 
 drivers/power/supply/bq25890_charger.c                        |    2 
 drivers/s390/block/dasd_eckd.c                                |   11 
 drivers/s390/block/dasd_ioctl.c                               |    2 
 drivers/s390/crypto/zcrypt_api.c                              |    2 
 drivers/s390/crypto/zcrypt_ccamisc.c                          |    6 
 drivers/s390/net/qeth_core_main.c                             |    3 
 drivers/s390/scsi/zfcp_aux.c                                  |    1 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                        |   10 
 drivers/scsi/libiscsi.c                                       |    2 
 drivers/scsi/libiscsi_tcp.c                                   |    8 
 drivers/scsi/libsas/sas_init.c                                |   37 
 drivers/scsi/scsi_debug.c                                     |    8 
 drivers/soc/qcom/ice.c                                        |   17 
 drivers/spi/spi-cadence.c                                     |  129 +
 drivers/spi/spi-qcom-qspi.c                                   |    3 
 drivers/target/target_core_iblock.c                           |    6 
 drivers/target/target_core_transport.c                        |   12 
 drivers/thunderbolt/xdomain.c                                 |   40 
 drivers/ufs/core/ufshcd.c                                     |    6 
 drivers/usb/gadget/function/f_tcm.c                           |  192 ++
 drivers/usb/gadget/function/tcm.h                             |   13 
 drivers/usb/musb/omap2430.c                                   |   25 
 drivers/usb/typec/ucsi/ucsi.c                                 |  115 -
 drivers/usb/typec/ucsi/ucsi.h                                 |    1 
 fs/binfmt_misc.c                                              |    4 
 fs/btrfs/zoned.c                                              |    6 
 fs/ceph/acl.c                                                 |    6 
 fs/ceph/addr.c                                                |  279 +--
 fs/ceph/caps.c                                                |  710 +++++---
 fs/ceph/crypto.c                                              |   39 
 fs/ceph/debugfs.c                                             |    6 
 fs/ceph/dir.c                                                 |  225 +-
 fs/ceph/export.c                                              |   39 
 fs/ceph/file.c                                                |  245 +--
 fs/ceph/inode.c                                               |  485 +++--
 fs/ceph/ioctl.c                                               |   13 
 fs/ceph/locks.c                                               |   57 
 fs/ceph/mds_client.c                                          |  554 +++---
 fs/ceph/mdsmap.c                                              |   24 
 fs/ceph/metric.c                                              |    5 
 fs/ceph/quota.c                                               |   29 
 fs/ceph/snap.c                                                |  174 +-
 fs/ceph/super.c                                               |   70 
 fs/ceph/super.h                                               |    6 
 fs/ceph/xattr.c                                               |   96 -
 fs/erofs/Kconfig                                              |   14 
 fs/erofs/decompressor_lzma.c                                  |    3 
 fs/smb/client/cifssmb.c                                       |   12 
 fs/smb/server/vfs_cache.c                                     |    6 
 include/drm/drm_fb_helper.h                                   |   12 
 include/linux/can/core.h                                      |    1 
 include/linux/can/skb.h                                       |    2 
 include/linux/ceph/ceph_debug.h                               |   38 
 include/linux/dma/qcom_bam_dma.h                              |   21 
 include/linux/libata.h                                        |    2 
 include/linux/mmc/sdio_ids.h                                  |    2 
 include/linux/netfilter/nf_conntrack_sip.h                    |    2 
 include/linux/sched.h                                         |    1 
 include/linux/sysctl.h                                        |    2 
 include/linux/thunderbolt.h                                   |    3 
 include/media/v4l2-async.h                                    |    8 
 include/net/ip_vs.h                                           |   45 
 include/net/neighbour.h                                       |    8 
 include/net/netfilter/nf_conntrack_expect.h                   |    5 
 include/net/netfilter/nf_tables.h                             |    2 
 include/scsi/libsas.h                                         |    1 
 init/init_task.c                                              |    1 
 ipc/ipc_sysctl.c                                              |    2 
 ipc/mq_sysctl.c                                               |    2 
 kernel/audit.c                                                |   11 
 kernel/auditfilter.c                                          |    6 
 kernel/trace/trace_events.c                                   |    4 
 kernel/trace/trace_events_filter.c                            |    3 
 kernel/trace/trace_mmiotrace.c                                |    1 
 kernel/trace/trace_probe.c                                    |    6 
 kernel/ucount.c                                               |    2 
 lib/assoc_array.c                                             |    3 
 lib/rhashtable.c                                              |    1 
 mm/huge_memory.c                                              |   16 
 mm/hugetlb.c                                                  |   12 
 mm/mm_init.c                                                  |   15 
 mm/page_reporting.c                                           |    6 
 mm/percpu-km.c                                                |    2 
 net/ax25/sysctl_net_ax25.c                                    |    2 
 net/bluetooth/hci_conn.c                                      |   14 
 net/bluetooth/hci_sync.c                                      |    6 
 net/bluetooth/hidp/core.c                                     |   30 
 net/bluetooth/iso.c                                           |    3 
 net/bluetooth/l2cap_core.c                                    |    5 
 net/bluetooth/mgmt.c                                          |   84 -
 net/bridge/br_mrp.c                                           |    2 
 net/bridge/br_multicast.c                                     |    1 
 net/bridge/br_netfilter_hooks.c                               |    8 
 net/can/af_can.c                                              |   14 
 net/can/bcm.c                                                 |    2 
 net/can/isotp.c                                               |  333 ++--
 net/can/j1939/bus.c                                           |    2 
 net/can/j1939/j1939-priv.h                                    |    3 
 net/can/j1939/main.c                                          |    8 
 net/can/j1939/socket.c                                        |    1 
 net/can/j1939/transport.c                                     |    6 
 net/can/raw.c                                                 |    7 
 net/core/lwt_bpf.c                                            |    4 
 net/core/sysctl_net_core.c                                    |    2 
 net/ieee802154/6lowpan/reassembly.c                           |    2 
 net/ipv4/devinet.c                                            |    2 
 net/ipv4/ip_fragment.c                                        |    2 
 net/ipv4/route.c                                              |    4 
 net/ipv4/sysctl_net_ipv4.c                                    |    2 
 net/ipv4/xfrm4_policy.c                                       |    2 
 net/ipv6/addrconf.c                                           |    2 
 net/ipv6/fib6_rules.c                                         |    1 
 net/ipv6/ip6_fib.c                                            |   17 
 net/ipv6/ip6_output.c                                         |    2 
 net/ipv6/ndisc.c                                              |    2 
 net/ipv6/netfilter/nf_conntrack_reasm.c                       |    2 
 net/ipv6/reassembly.c                                         |    2 
 net/ipv6/sysctl_net_ipv6.c                                    |    6 
 net/ipv6/xfrm6_policy.c                                       |    2 
 net/mac80211/s1g.c                                            |    4 
 net/mpls/af_mpls.c                                            |    5 
 net/mptcp/ctrl.c                                              |    2 
 net/mptcp/pm.c                                                |    9 
 net/mptcp/pm_netlink.c                                        |   29 
 net/mptcp/pm_userspace.c                                      |   87 -
 net/mptcp/protocol.h                                          |    6 
 net/netfilter/ipset/ip_set_hash_gen.h                         |    2 
 net/netfilter/ipvs/ip_vs_app.c                                |    4 
 net/netfilter/ipvs/ip_vs_conn.c                               |    3 
 net/netfilter/ipvs/ip_vs_core.c                               |  180 +-
 net/netfilter/ipvs/ip_vs_proto_sctp.c                         |   19 
 net/netfilter/ipvs/ip_vs_proto_tcp.c                          |   48 
 net/netfilter/ipvs/ip_vs_proto_udp.c                          |   54 
 net/netfilter/ipvs/ip_vs_xmit.c                               |   42 
 net/netfilter/nf_conntrack_broadcast.c                        |    1 
 net/netfilter/nf_conntrack_core.c                             |    7 
 net/netfilter/nf_conntrack_expect.c                           |    1 
 net/netfilter/nf_conntrack_h323_main.c                        |   12 
 net/netfilter/nf_conntrack_helper.c                           |    5 
 net/netfilter/nf_conntrack_netlink.c                          |   18 
 net/netfilter/nf_conntrack_sip.c                              |    4 
 net/netfilter/nf_conntrack_standalone.c                       |    2 
 net/netfilter/nf_log.c                                        |    2 
 net/netfilter/nf_nat_sip.c                                    |    2 
 net/netfilter/nf_tables_api.c                                 |   10 
 net/netfilter/nft_payload.c                                   |   12 
 net/netfilter/nft_set_pipapo.c                                |   11 
 net/netfilter/xt_hashlimit.c                                  |   16 
 net/openvswitch/actions.c                                     |   12 
 net/openvswitch/meter.c                                       |   33 
 net/rds/ib.c                                                  |    4 
 net/rds/ib_cm.c                                               |    4 
 net/rds/tcp.c                                                 |   14 
 net/rxrpc/ar-internal.h                                       |    1 
 net/rxrpc/call_accept.c                                       |    1 
 net/rxrpc/peer_object.c                                       |   12 
 net/sctp/associola.c                                          |    3 
 net/sctp/protocol.c                                           |   21 
 net/sctp/sm_make_chunk.c                                      |   17 
 net/sctp/sysctl.c                                             |   11 
 net/smc/smc_core.c                                            |    2 
 net/smc/smc_sysctl.c                                          |    2 
 net/tipc/socket.c                                             |    2 
 net/unix/sysctl_net_unix.c                                    |    2 
 net/xfrm/xfrm_sysctl.c                                        |    2 
 security/keys/keyring.c                                       |   14 
 sound/core/pcm_native.c                                       |    7 
 sound/core/ump.c                                              |    1 
 sound/pci/hda/patch_hdmi.c                                    |   48 
 sound/pci/lx6464es/lx6464es.c                                 |    5 
 sound/pci/lx6464es/lx_core.c                                  |    5 
 sound/soc/codecs/max98090.c                                   |    5 
 sound/soc/codecs/max98095.c                                   |    5 
 sound/soc/codecs/tas2562.c                                    |   30 
 sound/usb/6fire/chip.c                                        |    4 
 sound/usb/endpoint.c                                          |   14 
 sound/usb/midi.c                                              |    2 
 sound/usb/midi2.c                                             |    4 
 tools/testing/selftests/clone3/clone3_set_tid.c               |    2 
 tools/testing/selftests/mm/mlock-random-test.c                |    2 
 307 files changed, 5935 insertions(+), 4096 deletions(-)

Aaron Ma (1):
      ice: wait for reset completion in ice_resume()

Abdun Nihaal (2):
      cpufreq: powernow-k8: Fix possible memory leak in powernowk8_cpu_init()
      can: kvaser_usb: kvaser_usb_hydra_get_busparams(): fix memory leak in kvaser_usb_hydra_get_busparams()

Alexander Kaplan (1):
      drm/dp: Read the PCON max FRL bandwidth only for HDMI DFPs

Andrei Kuchynski (2):
      usb: typec: ucsi: Fix race condition and ordering in port unregistration
      usb: typec: ucsi: Correct teardown ordering in ucsi_init() error path

Asim Viladi Oglu Manizada (1):
      sctp: prevent peer transport count overflow

Aswin Karuvally (1):
      s390/qeth: Check CAP_NET_ADMIN for private ioctls

Avi Weiss (4):
      can: ctucanfd: use self-test mode for PRESUME_ACK
      can: ctucanfd: unmap BAR0 using base address
      can: ctucanfd: handle bus error interrupts
      can: ctucanfd: mark error-active controller status valid

Baul Lee (3):
      ALSA: ump: fix double free of out_cvts on rawmidi error
      ALSA: usb-audio: fix use-after-free in ump_to_endpoint()
      ALSA: usb-audio: fix OOB write in snd_usbmidi_akai_output()

Benjamin Block (1):
      scsi: zfcp: Fix memory leak during adapter release by destroying gid_pn_req

Benjamin Boortz (2):
      pinctrl: microchip-sgpio: add missing select REGMAP_MMIO
      pinctrl: bm1880: add missing select GENERIC_PINCONF

Benjamin Tissoires (1):
      HID: logitech-dj: fix wrong detection of bad DJ_SHORT output report

Biju Das (1):
      drm: renesas: rzg2l_mipi_dsi: Increase reset deassertion delay

Candice Li (1):
      drm/amdgpu: restore UMD profile pstate after runtime resume

Cen Zhang (1):
      usb: gadget: f_tcm: synchronize delayed set_alt with teardown

Cen Zhang (Microsoft) (1):
      rhashtable: clear stale iter->p on table restart

Charles Vosburgh (1):
      sctp: validate Adaptation Indication parameter length

Chenguang Zhao (3):
      forcedeth: fix UAF of txrx_stats in nv_remove
      net: sxgbe: free TX rings on RX allocation failure
      net: sxgbe: check descriptor ring allocation failures

Chris Gellermann (2):
      selftests/mm: fix potential wild pointer access of getline due to missing init
      selftests/clone3: fix wild pointer access of getline due to missing init

Christian Brauner (1):
      binfmt_misc: reject a flag character as the field delimiter

Christian Marangi (1):
      net: phylink: put link_gpio if phylink_create fails

Damien Le Moal (2):
      ahci: Introduce ahci_ignore_port() helper
      ata: libahci_platform: Do not set mask_port_map when not needed

Daniel Golle (1):
      net: dsa: mt7530: error out on failed reads in MT7531 PHY polling

Daniel Hodges (1):
      wifi: ath6kl: fix use-after-free in aggr_reset_state()

David Corvaglia (1):
      net: bridge: mrp: fix Option TLV length in MRP_Test frames

David Francis (1):
      drm/amdkfd: Handle invalid event type in CRIU event restore

David Howells (1):
      rxrpc: Fix irq-disabled in local_bh_enable()

David Lee (1):
      netfilter: ipset: do not update comments from kernel-side hash adds

Dawei Feng (3):
      smb: client: fix buffer leaks in SMB1 read and write
      e1000: fix memory leak in e1000_probe()
      ice: fix memory leak in ice_lbtest_prepare_rings()

Denis V. Lunev (1):
      qede: sync udp_tunnel ports outside qede_lock in the recovery path

Diogo Ivo (1):
      usb: typec: ucsi: Only enable supported notifications

Eddie Phillips (1):
      gve: fix Rx queue stall on alloc failure

Eric Dumazet (5):
      net: do not send ICMP/NDISC Redirects when peer allocation fails
      vxlan: re-fetch eth header after route_shortcircuit()
      vxlan: unclone skb head before modifying eth header in route_shortcircuit()
      vxlan: use neigh_ha_snapshot() in route_shortcircuit()
      vxlan: use pskb_network_may_pull() in route_shortcircuit()

Fan Wu (1):
      wifi: brcmfmac: drain bus_reset work on device removal

Farhan Ali (3):
      KVM: s390: pci: Reject adapter interrupt forwarding if already enabled
      KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
      KVM: s390: pci: Validate AIBV and AISB before pinning guest pages

Frank Scheiner (1):
      Revert "ia64: Make acpi_cpufreq_cpu_exit return void"

Gang Ba (1):
      drm/amdkfd: Fix missing authorization check in KFD_IOC_DBG_TRAP_DISABLE

Geliang Tang (4):
      mptcp: pm: avoid code duplication to lookup endp
      mptcp: add mptcp_userspace_pm_lookup_addr helper
      mptcp: pm: use addr entry for get_local_id
      mptcp: pm: userspace: fix use-after-free in get_local_id

Gokul Sivakumar (1):
      wifi: brcmfmac: fix 43752 SDIO FWVID incorrectly labelled as Cypress (CYW)

Greg Kroah-Hartman (2):
      Bluetooth: btmtk: Fix short read errors in btmtk_usb_uhw_reg_read()
      Linux 6.6.151

Gregory Price (1):
      mm/vmstat: fold stranded per-cpu node stats when a node comes online

Guangshuo Li (3):
      scsi: ufs: core: Cancel RTC work in active-active suspend
      can: etas_es58x: es58x_read_bulk_callback(): fix RX buffer leak on URB resubmit failure
      usb: musb: omap2430: Do not put borrowed of_node in probe

Guenter Roeck (5):
      hwmon: (nct6775-core) Fix number of temperature registers for NCT6116
      hwmon: (lm90) Only report alarms if driver is ready
      hwmon: (nzxt-smart2) DMA-align output buffer
      hwmon: (nct6775-core) Prevent access to unsupported weight registers
      hwmon: (pmbus) Fix return value from pmbus_update_byte_data()

H. Nikolaus Schaller (1):
      i2c: jz4780: Cache host clock rate at probe to prevent CCF prepare_lock deadlock

Haidar Lee (2):
      ASoC: tas2562: fix DVC coefficient write order
      ASoC: tas2562: fix broken entries in the volume lookup table

Harald Freudenberger (1):
      s390/zcrypt: Fix wrong domain value verification with EP11 CPRBs

Harkirat Gill (1):
      drm/amdgpu: cap GTT size to physical RAM on APUs

Harshal Dev (1):
      soc: qcom: ice: Allow explicit votes on 'iface' clock for ICE

Holger Dengler (2):
      s390/zcrypt: Validate length for CCA AES cipher key requests
      s390/zcrypt: Validate length for CCA ECC private key requests

Hongling Zeng (1):
      dmaengine: sun6i-dma: Fix reclaim descriptors while terminating DMA

Hongyan Xu (1):
      hwmon: (npcm750-pwm-fan): stop fan timer on device detach

HyeongJun An (3):
      scsi: libiscsi: Fix stale-data leak into the SCSI sense buffer
      scsi: libiscsi_tcp: Bound SCSI Response data segment to the connection buffer
      HID: logitech-dj: Fix maxfield check in DJ short report validation

Ibrahim Hashimov (1):
      scsi: scsi_debug: Fix REPORT ZONES alloc_len underflow OOB write

Ilia Gavrilov (1):
      rds: Fix inet6_addr_lst NULL dereference when IPv6 is disabled

Ilya Maximets (3):
      net: openvswitch: fix potential UAF on meter attach failure
      net: openvswitch: fix skb leak on flow key update failure during recirculation
      net: openvswitch: fix skb leak on flow key update failure during ct

Jai Luthra (1):
      media: i2c: imx219: Rename VTS to FRM_LENGTH

James Gao (1):
      can: peak_usb: add bounds check for USB channel index

Jan Höppner (1):
      s390/dasd: Fix potential NULL pointer dereference

Jani Nikula (4):
      drm/i915/vrr: require valid min/max vfreq for VRR
      drm/i915/hdcp: migrate away from kdev_to_i915() in bind/unbind
      drm/i915/hdcp: require monotonically increasing seq_num_v
      drm/i915/hdcp: check streams[] bounds before overflow

Jiale Yao (1):
      Bluetooth: L2CAP: fix UAF in l2cap_le_connect_rsp

Johan Hovold (1):
      usb: musb: omap2430: clean up probe error handling

Johannes Thumshirn (1):
      btrfs: zoned: fix deadlock between metadata writeback and transaction commit

Jose Maria Casanova Crespo (1):
      drm/vc4: Supply the overflow slot size in BPOS, not the whole bin BO size

Josua Mayer (1):
      ata: libahci_platform: support non-consecutive port numbers

Julian Anastasov (3):
      ipvs: fix the checksum validations
      ipvs: fix places with wrong packet offsets
      ipvs: do not mangle ICMP replies for non-first fragments

Jun Guo (2):
      spi: spi-cadence: supports transmission with bits_per_word of 16 and 32
      spi: spi-cadence: enable SPI_CONTROLLER_MUST_TX

Junjie Cao (1):
      gpio: pch: use raw_spinlock_t for the register lock

Kai Vehmanen (1):
      ALSA: hda: codecs: hdmi: disable keep-alive before audio format change

Karl Mehltretter (1):
      pinctrl: devicetree: don't free uninitialized dev_name on error path

Kent Overstreet (1):
      sched: Add task_struct->faults_disabled_mapping

Kiryl Shutsemau (Meta) (2):
      mm/hugetlb: fix swap entry corruption when clearing uffd-wp at fork()
      mm/huge_memory: unlock i_mmap_rwsem before releasing after-split folios

Konrad Dybcio (1):
      pinctrl: qcom: sc8280xp: Add missing wakeup entries for GPIO143/151

Lad Prabhakar (1):
      drm: renesas: Move RZ/G2L MIPI DSI driver to rz-du

Laurent Pinchart (5):
      media: i2c: imx219: Access height from active format in imx219_set_ctrl
      media: i2c: imx219: Don't store the current mode in the imx219 structure
      media: i2c: imx219: Drop IMX219_VTS_* macros
      media: i2c: imx219: Group functions by purpose
      media: i2c: imx219: Calculate crop rectangle dynamically

Lee Jones (2):
      HID: logitech-dj: Standardise hid_report_enum variable nomenclature
      HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT related user initiated OOB write

Leon Romanovsky (1):
      scsi: target: Clear cmd_cnt when initial counter enrollment fails

LiangCheng Wang (1):
      wifi: brcmfmac: set F2 blocksize to 256 for BCM43752

Liem (2):
      i2c: imx: Fix slave registration race and error handling
      i2c: imx: Cancel hrtimer before clearing slave pointer

Link Lin (1):
      mm/page_reporting: use system_freezable_wq to fix UAF during suspend

Lorenzo Bianconi (1):
      netfilter: br_netfilter: Reallocate headroom if necessary in neigh_hh_bridge()

Lucas Martins Alves (1):
      can: c_can: c_can_chip_config(): keep controller in init mode until bittiming is configured

Luiz Angelo Daros de Luca (8):
      hwmon: (adt7470) Fix fans stuck in manual mode on I2C errors
      hwmon: (adt7470) Fix cache updated before hardware write on I2C error
      hwmon: (adt7470) Fix busy-loop and I2C flooding in update thread
      hwmon: (adt7470) Fix temperature alarm logic in hwmon_temp_read()
      hwmon: (adt7470) Fix swapped PWM3 and PWM4 auto mode masks
      hwmon: (adt7470) Use cached PWM frequency value
      hwmon: (adt7470) Fix divide-by-zero TOCTOU crash in fan speed read
      hwmon: (adt7470) Fix PWM auto temp state array and bounds check

Luxiao Xu (1):
      audit: fix potential use-after-free in audit_del_rule()

Maoyi Xie (1):
      can: peak_usb: peak_usb_start(): fix double free of transfer buffer on URB submit error

Marc Kleine-Budde (1):
      can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on skb allocation failure

Mario Limonciello (1):
      pinctrl-amd: Don't clear S4 wake bits at probe

Masami Hiramatsu (Google) (3):
      tracing/mmiotrace: Reset dropped_count in mmio_reset_data()
      tracing: Check return value of __register_event() in trace_module_add_events()
      tracing/filters: Fix false positive match in regex_match_full()

Matt Vollrath (2):
      ata: libata-eh: Increase STANDBY IMMEDIATE timeout
      igbvf: Fix leak in TX DMA error cleanup

Maíra Canal (1):
      drm/vc4: Zero the tile state data array before each BIN job

Md Sadre Alam (1):
      dmaengine: qcom: bam_dma: Fix command element mask field for BAM v1.6.0+

Michael Bommarito (6):
      thunderbolt: Prevent XDomain delayed work use-after-free on disconnect
      keys: fix out-of-bounds read in keyring_get_key_chunk()
      keys: make keyring key-chunk byte order agree with keyring_diff_objects()
      assoc_array: trim the final shortcut word using the current chunk end
      erofs: cap LZMA stream pool size
      um: vector: fix use-after-free in vector_mmsg_rx()

Mike Looijmans (1):
      phy-zynqmp: Postpone getting clock rate until actually needed

Ming Lei (1):
      ublk: reset kernel-owned dev_info fields in ublk_ctrl_add_dev()

Minhong He (1):
      can: isotp: check register_netdevice_notifier() error in module init

Mirela Rabulea (1):
      media: v4l2-fwnode: Fix subdev owner overwritten in v4l2_async_register_subdev_sensor()

Muhammad Bilal (1):
      accel/qaic: use sizeof(*trans_hdr) for transaction length check

Myeonghun Pak (2):
      i2c: amd-mp2: Unregister callback on adapter add failure
      drm/mediatek: ovl_adaptor: balance component registrations

Namjae Jeon (2):
      ksmbd: return success for deferred final close
      ksmbd: fix use-after-free in __close_file_table_ids()

Nava kishore Manne (3):
      phy: zynqmp: fix L0_TM_DISABLE_SCRAMBLE_ENCODER mask
      phy: zynqmp: use read-modify-write for SERDES scrambler bypass
      phy: zynqmp: keep SERDES scrambler and 8b/10b enabled for USB

Niklas Cassel (1):
      ata: ahci: Make ahci_ignore_port() handle empty mask_port_map

Norbert Szetei (1):
      ALSA: pcm: wake linked drain waiters on unlink

Oleksij Rempel (1):
      can: j1939: transport: j1939_session_fresh_new(): initialize receive buffer

Oliver Hartkopp (2):
      can: use skb hash instead of private variable in headroom
      can: isotp: fix timer drain order, wakeup handling and tx_gen ordering

Pablo Neira Ayuso (3):
      netfilter: nf_conntrack_expect: restore helper propagation via expectation
      netfilter: xt_hashlimit: validate hashtable supports XT_HASHLIMIT_RATE_MATCH
      netfilter: nf_tables: clone set on flush only

Pauli Virtanen (5):
      Bluetooth: ISO: clear iso_data always when detaching conn from hcon
      Bluetooth: ISO: fix timeout vs sync_timeout typo in check_bcast_qos
      Bluetooth: hci_sync: make hci_cmd_sync_run_once return -EEXIST if exists
      Bluetooth: hci_conn: hold conn reference in abort_conn_sync()
      Bluetooth: hci_sync: fix hci_conn_del() use in hci_le_create_conn_sync

Pengfei Zhang (1):
      ipv6: fib6: fix NULL deref in fib6_walk_continue() on multi-batch dump

Pengpeng Hou (5):
      can: ems_usb: validate CPC message lengths
      can: kvaser_usb_leaf: kvaser_usb_leaf_wait_cmd(): validate received command extents
      can: softing: fw_parse(): validate firmware record spans
      can: peak_usb: validate uCAN receive record lengths
      can: ctucanfd: add missing MODULE_DEVICE_TABLE()

Radhey Shyam Pandey (3):
      ata: ahci_ceva: fix error paths in ceva_ahci_platform_enable_resources()
      phy: zynqmp: fix clock error handling in xpsgtr_phy_init()
      phy: zynqmp: fix runtime PM leak on probe allocation failure

Raushan Patel (1):
      tracing/probes: Reject $arg0 in meta argument expansion

Rosen Penev (1):
      ata: sata_mv: accept 1 or 2 resources in platform probe

Ruoyu Wang (1):
      drm/mediatek: Check CRTC state before freeing

Sakari Ailus (2):
      media: imx219: Fix maximum frame length in lines
      media: v4l: async: Set owner for async sub-devices

Sangho Lee (2):
      Bluetooth: HIDP: reject frames without a transaction header
      Bluetooth: HIDP: validate numbered report payloads

Sean Christopherson (1):
      KVM: SVM: Update x2APIC MSR intercepts if AVIC is inhibited while L2 is active

Sergey Senozhatsky (1):
      usb: typec: ucsi: split connector lock classes

Sonali Pradhan (2):
      ALSA: usb-audio: Fix DMA buffer out-of-bounds write when fill_max is set
      ALSA: usb-audio: Clamp frame size in implicit-feedback mode

Srikanth Boyapally (1):
      spi: spi-cadence: Move TX FIFO full busy-wait into FIFO

Stefan Haberland (1):
      s390/dasd: Fix undersized format-check buffer

Suman Ghosh (1):
      octeontx2-pf: Set correct sequence for carrier off and tx queue stop

Suraj Kandpal (1):
      drm/i915/hdcp: Move to using intel_display in intel_hdcp

Takashi Iwai (1):
      ALSA: 6fire: Fix UAF at error handling during probe

TanZheng (1):
      scsi: target: iblock: Fix wrong PR ops NULL check for PREEMPT/RELEASE

Tetsuo Handa (1):
      can: j1939: use netdevice_tracker for j1939_{priv,session,ecu} tracking

Thomas Weißschuh (1):
      sysctl: treewide: constify ctl_table_header::ctl_table_arg

Thomas Zimmermann (3):
      drm/fb-helper: Allocate and release fb_info in single place
      drm/tegra: fbdev: Remove offset into framebuffer memory
      drm/tegra: fbdev: Do not assign to struct drm_fb_helper.info

Thorsten Blum (4):
      powerpc/boot: Fix simpleboot CPU node lookup check
      powerpc/boot: Fix treeboot-currituck CPU node lookup check
      powerpc/boot: Fix treeboot-akebono CPU node lookup check
      powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()

Timur Kristóf (1):
      drm/amdgpu: Respect placement requirements in amdgpu_gtt_mgr functions

Tze Yee Ng (1):
      firmware: stratix10-svc: fix memory leaks and list corruption bugs

Uday Khare (2):
      ASoC: max98095: fix missing IS_ERR() before PTR_ERR() on mclk lookup
      ASoC: max98090: fix missing IS_ERR() before PTR_ERR() on mclk lookup

Vijaya Krishna Nivarthi (1):
      spi: qcom-qspi: Correct max DMA length to avoid 64K boundary failure

Ville Syrjälä (2):
      drm/i915/vrr: Check HAS_VRR() first in intel_vrr_is_capable()
      drm/i915/fbc: Extract intel_fbc_has_fences()

Vincent Jardin (1):
      hwmon: (pmbus/core) notify on the hwmon device, not the i2c client

Vladimir Marioukhine (1):
      drm/amdkfd: fix QID bit leak in pqm_create_queue()

Wei Yang (1):
      iommu/sva: move x86 disable check before allocation

WenTao Liang (1):
      ceph: fix refcount leak in ceph_readdir()

William Palacek (1):
      drm/amdkfd: hold event_mutex while checkpointing CRIU events

Xiang Mei (2):
      netfilter: nf_conntrack_sip: widen NAT rewrite delta to s32 in sip_help_tcp()
      rds: tcp: hold the RCU lock across ipv6_chk_addr() in rds_tcp_laddr_check()

Xiang Mei (Microsoft) (1):
      netfilter: nft_payload: fix mask build for partial field offload

Xiangfeng Cai (1):
      mm/hugetlb: fix list corruption in allocate_file_region_entries()

Xingui Yang (1):
      scsi: libsas: Fix HA resume deadlock and hisi_sas disk-wake race

Xiubo Li (2):
      libceph: add doutc and *_client debug macros support
      ceph: print cluster fsid and client global_id in all debug logs

Xu Rao (2):
      ALSA: lx6464es: fix period byte count for 16-bit streams
      power: supply: bq25890: fix the -10 C NTC lookup entry

Xuanqiang Luo (2):
      bpf: lwt: Fix dst reference leak on reroute failure
      net/smc: fix socket use-after-free during link group termination

Yehyeong Lee (1):
      net: mpls: initialize rtm_tos in mpls_getroute()

Yuho Choi (1):
      dmaengine: idxd: fix fdev setup failure cleanup in idxd_cdev_open()

Yuxiang Yang (1):
      sctp: reject stale cookies with mismatched verification tags

Zack Rusin (7):
      drm/vmwgfx: fix guest_memory_dirty bitfield clobbered as size
      drm/vmwgfx: reject DX_BIND_QUERY without a DX context
      drm/vmwgfx: drop dma_buf reference on foreign-fd prime import
      drm/vmwgfx: validate DRAW_PRIMITIVES header size before division
      drm/vmwgfx: bound DMA command body size against suffix pointer
      drm/vmwgfx: use check_add_overflow for shader size+offset bound
      drm/vmwgfx: validate external BO copy bounds for both stride paths

Zhan Xusheng (1):
      audit: fix potential integer overflow in audit_log_n_string()

Zhao Li (2):
      wifi: mac80211: validate individual TWT params before driver setup
      wifi: mwifiex: use the subframe length when parsing A-MSDU TDLS frames

Zhiling Zou (5):
      ipvs: do not propagate one-packet flag to synced conns
      net: bridge: stop fast-leave after deleting a port group
      net: ipv6: clear suppressed fib6 rule result
      sctp: avoid auth_enable sysctl UAF during netns teardown
      sctp: close UDP tunnel sockets during netns teardown

Zi Yan (1):
      mm/percpu-km: fix bitmap overflow and accounting in pcpu_create_chunk()

Zihan Xi (3):
      Bluetooth: mgmt: fix pending command UAF in EIR updates
      Bluetooth: mgmt: fix UAF in pair command cancellation
      tipc: avoid use-after-free in poll trace queue dumps

Zijun Hu (1):
      Bluetooth: btintel: Validate length before parsing diagnostics TLV

bui duc phuc (1):
      gpio: pca953x: fix cache_only and IRQ state on restore_context() failure

