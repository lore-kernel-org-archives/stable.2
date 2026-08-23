Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58600350298;
	Sun, 23 Aug 2026 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787489089; cv=none; b=TF1jNmOHrPfa5/uZtXhSNQzsHniFn1x1Aike7GhkiX9SyvlkS5EqIJw/lMfq1M91LxUZY31le3H1dnUojcvbzElrOskC6mp66ErpeH0jKIG0KvNqaorZnDcOy5Vjs7y2Rw3H2LdY5gK6vHAyqAPymCGwNVMi/jYCOHvEt/tSTFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787489089; c=relaxed/simple;
	bh=5uTzffAM7FY7XL/XkqqUbQLKbqoyUWVpl5oGIlZl28s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DpsMQLw5fjb3cWczXI/IysCxDnHMMrVcI9ZPnI6O+p391QGGg4GjX5Q4UnmPQ6ZdBMtx8HYmvmQJEyDOq/CeFI6VZvlVBW32FNrYB9GXgA8+UEy1hnUu18blWjpy81GyQWuW8f+pUum8XMmMo2UmN40VGLawDD6mVn7g8J+aRzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oq7rpjNP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oq7rpjNP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D641F000E9;
	Sun, 23 Aug 2026 12:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787489086;
	bh=ccs+jtYxc7vO0fdYBhqnipBZtoNhl3Oh6CCChcskN5w=;
	h=From:To:Cc:Subject:Date;
	b=oq7rpjNP7L5H6h3niHyvAySbiz4erI9uaio002r+kN97UGehvGB1kiSTsxVdeEP1M
	 jIdLt+jtWPKDNs4H82w6zAbSF/PptT6LWKV8HXKvnRCT2pocMR5WzjvjFv5rNvqJ1k
	 xfaCYJMRt0Bb4dYwdPJ8Q5DHq+lQrxh0D6KRRD5Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.217
Date: Sun, 23 Aug 2026 14:43:04 +0200
Message-ID: <2026082305-overhead-jubilance-ef6e@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.217 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                  |    2 
 arch/arm64/boot/dts/nvidia/tegra194.dtsi                  |    2 
 arch/openrisc/include/asm/processor.h                     |    2 
 arch/openrisc/kernel/signal.c                             |    5 
 arch/powerpc/platforms/pseries/lparcfg.c                  |    2 
 arch/powerpc/platforms/pseries/pci.c                      |    2 
 arch/x86/kernel/cpu/resctrl/rdtgroup.c                    |   12 
 crypto/ccm.c                                              |    2 
 drivers/char/tpm/tpm_tis_core.c                           |   38 
 drivers/crypto/qce/core.c                                 |    2 
 drivers/dma-buf/dma-resv.c                                |   10 
 drivers/dma-buf/udmabuf.c                                 |   21 
 drivers/dma/dw-edma/dw-edma-core.c                        |   90 -
 drivers/dma/dw-edma/dw-edma-core.h                        |   33 
 drivers/dma/dw-edma/dw-edma-pcie.c                        |   83 
 drivers/dma/dw-edma/dw-edma-v0-core.c                     |   38 
 drivers/dma/dw-edma/dw-edma-v0-core.h                     |    4 
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c                  |   18 
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h                  |    8 
 drivers/fpga/dfl-afu-main.c                               |    3 
 drivers/gpio/gpio-mvebu.c                                 |    4 
 drivers/gpio/gpio-pxa.c                                   |    4 
 drivers/gpio/gpio-rockchip.c                              |    4 
 drivers/gpio/gpio-tegra.c                                 |   18 
 drivers/gpio/gpio-vf610.c                                 |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c          |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c                   |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                   |   17 
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c                   |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                    |    4 
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                     |   26 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                      |    2 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                        |   14 
 drivers/gpu/drm/drm_connector.c                           |   12 
 drivers/gpu/drm/drm_dp_mst_topology.c                     |   32 
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c              |    2 
 drivers/gpu/drm/i915/display/intel_hdcp.c                 |   12 
 drivers/gpu/drm/i915/display/intel_vrr.c                  |    4 
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c            |    4 
 drivers/gpu/drm/i915/i915_vma.c                           |    2 
 drivers/gpu/drm/lima/lima_gem.c                           |    2 
 drivers/gpu/drm/msm/msm_gem_submit.c                      |    2 
 drivers/gpu/drm/nouveau/nouveau_fence.c                   |    2 
 drivers/gpu/drm/qxl/qxl_release.c                         |    2 
 drivers/gpu/drm/radeon/radeon_kms.c                       |    1 
 drivers/gpu/drm/radeon/radeon_vm.c                        |    2 
 drivers/gpu/drm/tegra/fb.c                                |    8 
 drivers/gpu/drm/ttm/ttm_bo.c                              |    4 
 drivers/gpu/drm/ttm/ttm_execbuf_util.c                    |    4 
 drivers/gpu/drm/vc4/vc4_gem.c                             |    2 
 drivers/gpu/drm/vgem/vgem_fence.c                         |    2 
 drivers/gpu/drm/virtio/virtgpu_drv.h                      |    1 
 drivers/gpu/drm/virtio/virtgpu_gem.c                      |   28 
 drivers/gpu/drm/virtio/virtgpu_plane.c                    |   10 
 drivers/gpu/drm/virtio/virtgpu_vq.c                       |    9 
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c                   |    4 
 drivers/i2c/busses/i2c-bcm-iproc.c                        |   11 
 drivers/i2c/busses/i2c-davinci.c                          |    4 
 drivers/i2c/busses/i2c-imx.c                              |  135 +
 drivers/input/joystick/iforce/iforce-packets.c            |   11 
 drivers/input/joystick/iforce/iforce-usb.c                |    3 
 drivers/input/joystick/psxpad-spi.c                       |    1 
 drivers/input/keyboard/atkbd.c                            |    8 
 drivers/input/misc/ims-pcu.c                              |    5 
 drivers/input/mouse/focaltech.c                           |    2 
 drivers/input/rmi4/rmi_f54.c                              |   43 
 drivers/input/rmi4/rmi_f55.c                              |    4 
 drivers/input/touchscreen/mms114.c                        |   21 
 drivers/input/touchscreen/sur40.c                         |   23 
 drivers/iommu/amd/iommu.c                                 |    3 
 drivers/md/dm-integrity.c                                 |    4 
 drivers/md/dm-verity-target.c                             |   12 
 drivers/md/dm-verity.h                                    |    2 
 drivers/media/i2c/imx219.c                                |   47 
 drivers/media/platform/aspeed-video.c                     |    1 
 drivers/media/platform/marvell-ccic/cafe-driver.c         |    1 
 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c     |    5 
 drivers/media/v4l2-core/v4l2-async.c                      |    8 
 drivers/media/v4l2-core/v4l2-fwnode.c                     |    6 
 drivers/mmc/host/omap_hsmmc.c                             |    2 
 drivers/mmc/host/sdhci.c                                  |   16 
 drivers/mmc/host/sdhci.h                                  |    2 
 drivers/mmc/host/vub300.c                                 |   36 
 drivers/mtd/maps/vmu-flash.c                              |    8 
 drivers/mtd/spi-nor/swp.c                                 |   30 
 drivers/net/can/usb/Kconfig                               |   15 
 drivers/net/can/usb/Makefile                              |    2 
 drivers/net/can/usb/esd_usb.c                             | 1173 ++++++++++++++
 drivers/net/can/usb/esd_usb2.c                            | 1170 -------------
 drivers/net/can/usb/gs_usb.c                              |    2 
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c          |   25 
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h          |    1 
 drivers/net/ethernet/aquantia/atlantic/aq_vec.c           |    2 
 drivers/net/ethernet/intel/ice/ice_ethtool.c              |   10 
 drivers/net/ethernet/intel/ice/ice_main.c                 |   10 
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c          |   48 
 drivers/net/ethernet/intel/igc/igc_main.c                 |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c           |   14 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h           |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c     |   18 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c      |   14 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c      |    8 
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c            |   92 +
 drivers/net/ethernet/microsoft/mana/mana_en.c             |   13 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                  |    2 
 drivers/net/ipa/ipa_smp2p.c                               |   30 
 drivers/net/thunderbolt.c                                 |    8 
 drivers/net/wan/ixp4xx_hss.c                              |    4 
 drivers/net/wireless/ath/ath6kl/txrx.c                    |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c |   16 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h    |    6 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c   |   45 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c   |    6 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   |    8 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h   |    1 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c    |    3 
 drivers/net/wireless/marvell/libertas_tf/main.c           |    2 
 drivers/pinctrl/bcm/pinctrl-bcm2835.c                     |    4 
 drivers/pinctrl/cirrus/pinctrl-lochnagar.c                |    2 
 drivers/pinctrl/core.c                                    |   15 
 drivers/pinctrl/intel/pinctrl-cherryview.c                |    4 
 drivers/pinctrl/intel/pinctrl-intel.c                     |    4 
 drivers/pinctrl/intel/pinctrl-lynxpoint.c                 |    4 
 drivers/pinctrl/mediatek/pinctrl-moore.c                  |    4 
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c             |    4 
 drivers/pinctrl/mediatek/pinctrl-paris.c                  |    4 
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c                 |    4 
 drivers/pinctrl/pinctrl-as3722.c                          |    4 
 drivers/pinctrl/pinctrl-axp209.c                          |    2 
 drivers/pinctrl/pinctrl-ingenic.c                         |   11 
 drivers/pinctrl/pinctrl-ocelot.c                          |    4 
 drivers/pinctrl/pinctrl-rk805.c                           |    4 
 drivers/pinctrl/pinctrl-st.c                              |    4 
 drivers/pinctrl/renesas/gpio.c                            |    4 
 drivers/pinctrl/stm32/pinctrl-stm32.c                     |    4 
 drivers/pinctrl/sunxi/pinctrl-sunxi.c                     |    4 
 drivers/pinctrl/vt8500/pinctrl-wmt.c                      |    4 
 drivers/remoteproc/qcom_common.c                          |   31 
 drivers/remoteproc/qcom_common.h                          |    5 
 drivers/remoteproc/qcom_q6v5_pas.c                        |   20 
 drivers/s390/cio/vfio_ccw_cp.c                            |   17 
 drivers/s390/net/qeth_core_main.c                         |    3 
 drivers/s390/net/qeth_l3_main.c                           |    5 
 drivers/scsi/lpfc/lpfc_init.c                             |    3 
 drivers/scsi/scsi_debug.c                                 |   27 
 drivers/scsi/sd.h                                         |   27 
 drivers/scsi/sd_zbc.c                                     |  126 +
 drivers/thunderbolt/domain.c                              |   36 
 drivers/thunderbolt/icm.c                                 |    5 
 drivers/thunderbolt/nhi.c                                 |    6 
 drivers/thunderbolt/nvm.c                                 |    4 
 drivers/thunderbolt/property.c                            |   38 
 drivers/thunderbolt/switch.c                              |   20 
 drivers/thunderbolt/tb.c                                  |   58 
 drivers/thunderbolt/tb.h                                  |    2 
 drivers/thunderbolt/xdomain.c                             |   94 -
 drivers/tty/serial/8250/8250_mid.c                        |    6 
 drivers/tty/serial/max310x.c                              |   20 
 drivers/tty/serial/sc16is7xx.c                            |  192 +-
 drivers/usb/gadget/function/f_tcm.c                       |  192 +-
 drivers/usb/gadget/function/tcm.h                         |   13 
 drivers/vdpa/vdpa_user/iova_domain.c                      |   91 -
 drivers/vdpa/vdpa_user/iova_domain.h                      |   13 
 drivers/vdpa/vdpa_user/vduse_dev.c                        |   16 
 drivers/video/fbdev/core/bitblit.c                        |  122 -
 drivers/video/fbdev/core/fbcon.c                          |  413 ++--
 drivers/video/fbdev/core/fbcon.h                          |    6 
 drivers/video/fbdev/core/fbcon_ccw.c                      |  146 -
 drivers/video/fbdev/core/fbcon_cw.c                       |  146 -
 drivers/video/fbdev/core/fbcon_rotate.c                   |   44 
 drivers/video/fbdev/core/fbcon_rotate.h                   |    6 
 drivers/video/fbdev/core/fbcon_ud.c                       |  162 -
 drivers/video/fbdev/core/softcursor.c                     |   18 
 drivers/video/fbdev/core/tileblit.c                       |   28 
 fs/9p/vfs_inode.c                                         |    9 
 fs/binfmt_elf.c                                           |    4 
 fs/binfmt_elf_fdpic.c                                     |    4 
 fs/binfmt_misc.c                                          |   14 
 fs/ceph/acl.c                                             |    6 
 fs/ceph/addr.c                                            |   20 
 fs/ceph/cache.c                                           |    2 
 fs/ceph/caps.c                                            |   53 
 fs/ceph/dir.c                                             |   20 
 fs/ceph/export.c                                          |   10 
 fs/ceph/file.c                                            |   42 
 fs/ceph/inode.c                                           |   14 
 fs/ceph/ioctl.c                                           |    8 
 fs/ceph/mds_client.c                                      |   11 
 fs/ceph/mds_client.h                                      |    2 
 fs/ceph/mdsmap.c                                          |    2 
 fs/ceph/metric.c                                          |    5 
 fs/ceph/snap.c                                            |    2 
 fs/ceph/super.c                                           |   22 
 fs/ceph/super.h                                           |   14 
 fs/ceph/xattr.c                                           |   12 
 fs/cifs/smb2ops.c                                         |    4 
 fs/crypto/policy.c                                        |    2 
 fs/exec.c                                                 |    6 
 fs/f2fs/data.c                                            |    2 
 fs/ksmbd/auth.c                                           |    4 
 fs/ksmbd/connection.c                                     |   23 
 fs/ksmbd/connection.h                                     |    5 
 fs/ksmbd/oplock.c                                         |    8 
 fs/ksmbd/smb2pdu.c                                        |  102 -
 fs/ksmbd/smb2pdu.h                                        |    9 
 fs/ksmbd/smb_common.c                                     |   43 
 fs/ksmbd/smb_common.h                                     |    9 
 fs/namei.c                                                |   43 
 fs/ntfs3/fsntfs.c                                         |   20 
 fs/ntfs3/index.c                                          |   44 
 fs/ntfs3/ntfs_fs.h                                        |    2 
 fs/overlayfs/copy_up.c                                    |   14 
 fs/super.c                                                |   19 
 fs/xfs/libxfs/xfs_sb.c                                    |    4 
 fs/xfs/xfs_dquot.c                                        |    3 
 include/drm/drm_connector.h                               |    6 
 include/drm/drm_displayid.h                               |    2 
 include/linux/audit.h                                     |   18 
 include/linux/bootconfig.h                                |    3 
 include/linux/bpf_lsm.h                                   |    4 
 include/linux/ceph/ceph_debug.h                           |   38 
 include/linux/dma-resv.h                                  |    2 
 include/linux/dma/edma.h                                  |   50 
 include/linux/firmware.h                                  |    3 
 include/linux/fs.h                                        |   33 
 include/linux/ip.h                                        |   21 
 include/linux/jiffies.h                                   |   13 
 include/linux/lsm_hooks.h                                 |    1 
 include/linux/mmc/sdio_ids.h                              |    2 
 include/linux/namei.h                                     |    1 
 include/linux/pinctrl/consumer.h                          |   13 
 include/linux/thunderbolt.h                               |    3 
 include/media/v4l2-async.h                                |    8 
 include/net/dst.h                                         |   24 
 include/net/inet6_hashtables.h                            |    2 
 include/net/inet_hashtables.h                             |    2 
 include/net/ip.h                                          |   11 
 include/net/ip_tunnels.h                                  |    3 
 include/net/ip_vs.h                                       |    7 
 include/net/lwtunnel.h                                    |    8 
 include/net/netfilter/nf_queue.h                          |    1 
 include/net/route.h                                       |    5 
 include/uapi/linux/ip_vs.h                                |    6 
 init/main.c                                               |   39 
 kernel/audit.c                                            |    2 
 kernel/audit.h                                            |   32 
 kernel/audit_fsnotify.c                                   |   39 
 kernel/audit_tree.c                                       |    2 
 kernel/audit_watch.c                                      |   42 
 kernel/auditfilter.c                                      |   17 
 kernel/auditsc.c                                          |    6 
 kernel/bpf/bpf_inode_storage.c                            |   10 
 kernel/fork.c                                             |   21 
 kernel/locking/spinlock_rt.c                              |   27 
 kernel/sched/psi.c                                        |    6 
 kernel/taskstats.c                                        |   67 
 kernel/trace/ftrace.c                                     |   21 
 kernel/trace/ring_buffer.c                                |   23 
 lib/bootconfig.c                                          |   65 
 lib/compat_audit.c                                        |   12 
 mm/madvise.c                                              |    3 
 mm/memory_hotplug.c                                       |   15 
 mm/mincore.c                                              |    3 
 mm/pagewalk.c                                             |    8 
 mm/ptdump.c                                               |    7 
 net/bluetooth/hci_event.c                                 |    2 
 net/ceph/cls_lock_client.c                                |   21 
 net/ceph/decode.c                                         |   18 
 net/ceph/osdmap.c                                         |    9 
 net/core/dst.c                                            |    8 
 net/core/pktgen.c                                         |   43 
 net/core/sock.c                                           |    6 
 net/ipv4/icmp.c                                           |   24 
 net/ipv4/igmp.c                                           |    2 
 net/ipv4/ip_fragment.c                                    |    2 
 net/ipv4/ip_output.c                                      |    4 
 net/ipv4/ip_tunnel_core.c                                 |   35 
 net/ipv4/ip_vti.c                                         |    4 
 net/ipv4/ipip.c                                           |   41 
 net/ipv4/netfilter.c                                      |    4 
 net/ipv4/route.c                                          |   10 
 net/ipv4/tcp_fastopen.c                                   |    4 
 net/ipv4/tcp_ipv4.c                                       |    8 
 net/ipv4/tcp_metrics.c                                    |    8 
 net/ipv4/xfrm4_output.c                                   |    2 
 net/ipv6/ip6_tunnel.c                                     |   40 
 net/ipv6/sit.c                                            |   38 
 net/ipv6/tcp_ipv6.c                                       |   10 
 net/mptcp/options.c                                       |    8 
 net/mptcp/pm_netlink.c                                    |    4 
 net/mptcp/protocol.c                                      |  119 -
 net/mptcp/protocol.h                                      |   29 
 net/mptcp/sockopt.c                                       |   24 
 net/mptcp/subflow.c                                       |   17 
 net/netfilter/ipset/ip_set_core.c                         |   19 
 net/netfilter/ipset/ip_set_list_set.c                     |    7 
 net/netfilter/ipvs/ip_vs_conn.c                           |    4 
 net/netfilter/ipvs/ip_vs_core.c                           |    6 
 net/netfilter/ipvs/ip_vs_ctl.c                            |    4 
 net/netfilter/ipvs/ip_vs_dh.c                             |    4 
 net/netfilter/ipvs/ip_vs_lblc.c                           |    2 
 net/netfilter/ipvs/ip_vs_lblcr.c                          |    8 
 net/netfilter/nf_conntrack_sip.c                          |   10 
 net/netfilter/nf_flow_table_core.c                        |    7 
 net/netfilter/nf_queue.c                                  |   14 
 net/netfilter/nf_tables_offload.c                         |    2 
 net/netfilter/nfnetlink_queue.c                           |    3 
 net/netfilter/nft_set_pipapo.c                            |  254 +--
 net/netfilter/nft_set_pipapo.h                            |    8 
 net/openvswitch/conntrack.c                               |   39 
 net/packet/af_packet.c                                    |    7 
 net/rxrpc/call_accept.c                                   |   27 
 net/sched/act_ct.c                                        |   41 
 net/sched/sch_api.c                                       |   24 
 net/sched/sch_cake.c                                      |    2 
 net/sched/sch_taprio.c                                    |   12 
 net/sctp/protocol.c                                       |   20 
 net/sctp/sysctl.c                                         |    9 
 net/smc/af_smc.c                                          |    3 
 net/smc/smc_rx.c                                          |   12 
 net/smc/smc_tx.c                                          |   17 
 net/tipc/socket.c                                         |    6 
 net/x25/af_x25.c                                          |    4 
 net/x25/x25_timer.c                                       |   25 
 net/xfrm/espintcp.c                                       |   32 
 security/apparmor/include/net.h                           |    6 
 security/apparmor/lsm.c                                   |   38 
 security/bpf/hooks.c                                      |    3 
 security/security.c                                       |  530 +++---
 security/selinux/hooks.c                                  |   91 -
 security/selinux/include/objsec.h                         |    5 
 security/selinux/netlabel.c                               |   23 
 security/selinux/ss/policydb.c                            |   31 
 security/selinux/ss/services.c                            |    4 
 security/smack/smack.h                                    |    5 
 security/smack/smack_lsm.c                                |   66 
 security/smack/smack_netfilter.c                          |    8 
 sound/core/seq/seq_timer.c                                |   13 
 sound/hda/hdac_regmap.c                                   |    4 
 sound/pci/hda/patch_conexant.c                            |    3 
 sound/soc/codecs/cs4265.c                                 |    4 
 sound/soc/codecs/lpass-wsa-macro.c                        |    8 
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c                |   12 
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c                |  118 -
 sound/soc/xilinx/xlnx_formatter_pcm.c                     |   10 
 345 files changed, 5736 insertions(+), 3943 deletions(-)

Aaron Ma (1):
      ice: wait for reset completion in ice_resume()

Abdun Nihaal (1):
      scsi: lpfc: Fix memory leak in lpfc_sli4_driver_resource_setup()

Alan Borzeszkowski (1):
      thunderbolt: Update property.c function documentation

Aldo Ariel Panzardo (1):
      net/sched: serialize qdisc_rtab_list against concurrent get/put

Alexey Velichayshiy (1):
      netfilter: nf_tables_offload: suppress WARN_ON_ONCE for ENOMEM in abort path

Ali Ahmet Memis (1):
      openrisc: signal: do not restore privileged SR bits on sigreturn

Amir Goldstein (2):
      fsnotify: opt-in for permission events at file open time
      fs: don't block write during exec on pre-content watched files

Andy Shevchenko (2):
      serial: 8250_mid: Remove unneeded test for ->setup() presence
      libceph: Amend checking to fix `make W=1` build breakage

AngeloGioacchino Del Regno (3):
      ASoC: mediatek: mt8192-afe-pcm: Convert to devm_pm_runtime_enable()
      ASoC: mediatek: mt8192-afe-pcm: Simplify with dev_err_probe()
      ASoC: mediatek: Use common mtk_afe_pcm_platform with common probe cb

Ashutosh Desai (3):
      drm/dp/mst: fix buffer overflows in sideband chunk accumulation
      drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply parsers
      drm/dp/mst: fix OOB reads on 2-byte fields in sideband reply parsers

Bart Van Assche (2):
      scsi: sd: sd_zbc: Improve source code documentation
      scsi: sd: sd_zbc: Introduce struct zoned_disk_info

Bartosz Golaszewski (1):
      treewide: rename pinctrl_gpio_direction_output_new()

Baul Lee (1):
      net/x25: fix use-after-free of the socket by its timers

Breno Leitao (3):
      9p: skip nlink update in cacheless mode to fix WARN_ON
      bootconfig: move xbc_snprint_cmdline() to lib/bootconfig.c
      bootconfig: fix NULL-pointer arithmetic in xbc_snprint_cmdline()

Bryam Vargas (7):
      selinux: require every boolean value to be defined
      selinux: reject a class permission count below its inherited common
      selinux: do not cancel a policy conversion that never started
      Input: synaptics-rmi4 - bound the F54 report size to the allocated buffer
      Input: mms114 - reject an oversized device packet size
      net/sched: sch_taprio: Replace direct dequeue call with peek and qdisc_dequeue_peeked
      drm/virtio: bound EDID block reads to the response buffer

Candice Li (1):
      drm/amdgpu: validate GEM_CREATE domain combinations

Casey Schaufler (1):
      lsm: infrastructure management of the sock security

Cen Zhang (1):
      usb: gadget: f_tcm: synchronize delayed set_alt with teardown

Chao Yu (1):
      f2fs: fix UAF issue in f2fs_merge_page_bio()

ChenXiaoSong (2):
      smb/server: fix minimum SMB1 PDU size
      smb/server: fix minimum SMB2 PDU size

Chengfeng Ye (1):
      net: pktgen: fix proc entry use-after-free

Chenguang Zhao (1):
      mptcp: decrement subflows counter on failed passive join

Christian Brauner (3):
      super: fix emergency thaw deadlock on frozen block devices
      binfmt_misc: restore write access when removing an entry
      binfmt_misc: use exe_file_deny_write_access() for the interpreter clone

Christian König (1):
      dma-buf/drivers: make reserving a shared slot mandatory v4

Christoph Hellwig (1):
      xfs: check v5 superblock features early

Christophe JAILLET (1):
      thunderbolt: Remove usage of the deprecated ida_simple_xx() API

Cássio Gabriel (2):
      ASoC: mediatek: mt8183: Check runtime resume during probe
      ASoC: mediatek: mt8192: Check runtime resume during probe

Damien Le Moal (3):
      scsi: sd: sd_zbc: Use logical blocks as unit when querying zones
      scsi: sd: sd_zbc: Return early in sd_zbc_check_zoned_characteristics()
      scsi: scsi_debug: Rename zone type constants

Daming Li (1):
      net: smc: fix splice entry lifetime imbalance in smc_rx_splice

Daniel Hodges (1):
      wifi: ath6kl: fix use-after-free in aggr_reset_state()

David Carlier (2):
      media: aspeed: fix missing of_reserved_mem_device_release() on probe failure
      igc: remove napi_synchronize() in igc_down()

David Plowman (1):
      media: i2c: imx219: Correct the minimum vblanking value

David Rosca (4):
      drm/amdgpu: Reject UVD message with invalid number of h265 refs
      drm/amdgpu: Reject UVD message with dimensions above 4096
      drm/amdgpu: Implement insert_end for VCE 3
      drm/amdgpu: Fix UVD decode image min size calculation

Dawei Feng (2):
      octeontx2-pf: fix SQB pointer leak on init failure
      ice: fix memory leak in ice_lbtest_prepare_rings()

Dawid Osuchowski (1):
      ice: fix VF interrupts cleanup

Dawid Wróbel (1):
      ASoC: codecs: lpass-wsa-macro: Fix enum kcontrol accesses

Deepanshu Kartikey (1):
      drm/virtio: use uninterruptible resv lock for plane updates

Dexuan Cui (1):
      net: mana: Validate the packet length reported by the NIC

Dmitry Osipenko (2):
      drm/virtio: Return proper error codes instead of -1
      drm/virtio: Unlock reservations on dma_resv_reserve_fences() error

Dmitry Torokhov (9):
      Input: synaptics-rmi4 - fix F55 transmitter electrode count typo
      Input: synaptics-rmi4 - zero report size on F54 work error
      Input: synaptics-rmi4 - block s_input when F54 queue is busy
      Input: synaptics-rmi4 - propagate F54 worker errors to V4L2 queue
      Input: sur40 - fix input device registration ordering
      Input: sur40 - fix V4L error path cleanup
      Input: mms114 - fix touch indexing for MMS134S and MMS136
      firmware_loader: introduce __free() cleanup hanler
      Input: ims-pcu - fix firmware leak in async update

Easwar Hariharan (2):
      jiffies: Define secs_to_jiffies()
      jiffies: Cast to unsigned long in secs_to_jiffies() conversion

Eric Dumazet (6):
      tcp: convert to dev_net_rcu()
      net: dst: annotate data-races around dst->input
      net: dst: annotate data-races around dst->output
      net: dst: add four helpers to annotate data-races around dst->dev
      ipv4: adopt dst_dev, skb_dst_dev and skb_dst_dev_net[_rcu]
      af_packet: Don't send zero-byte data in tpacket_snd().

Eric Farman (1):
      s390/vfio_ccw: Fix out of bounds check on CCW array

Eugenio Pérez (2):
      vduse: remove unused vaddr parameter of vduse_domain_free_coherent
      vduse: take out allocations from vduse_dev_alloc_coherent

Fan Wu (2):
      can: esd_usb: kill anchored URBs before freeing netdevs
      wifi: brcmfmac: drain bus_reset work on device removal

Florian Fuchs (1):
      mtd: maps: vmu-flash: fix fault in unaligned fixup

Florian Westphal (10):
      netfilter: nft_set_pipapo: use GFP_KERNEL for insertions
      netfilter: nft_set_pipapo: move prove_locking helper around
      netfilter: nf_conntrack_sip: remove net variable shadowing
      netfilter: nft_set_pipapo: make pipapo_clone helper return NULL
      netfilter: nft_set_pipapo: prepare walk function for on-demand clone
      netfilter: nft_set_pipapo: merge deactivate helper into caller
      netfilter: nft_set_pipapo: prepare pipapo_get helper for on-demand clone
      netfilter: nft_set_pipapo: move cloning of match info to insert/removal path
      netfilter: nft_set_pipapo: don't leak bad clone into future transaction
      netfilter: ipset: fix list type element drift bug

Frank Jungclaus (1):
      can/esd_usb2: Rename esd_usb2.c to esd_usb.c

Frank Li (3):
      dmaengine: dw-edma: Remove unused irq field in struct dw_edma_chip
      dmaengine: dw-edma: Detach the private data and chip info structures
      dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and ABORT_INT_MASK

Fredric Cover (1):
      smb: client: use kvzalloc() for megabyte buffer in simple fallocate

Fullway Wang (1):
      media: mtk-vcodec: potential null pointer deference in SCP

Geetha sowjanya (1):
      octeontx2-af: Fix APR entry mapping based on APR_LMT_CFG

George Wilson (2):
      powerpc/pseries: pci - logic bug
      powerpc/pseries: lparcfg - fix kbuf[] underflow

Gokul Sivakumar (1):
      wifi: brcmfmac: fix 43752 SDIO FWVID incorrectly labelled as Cypress (CYW)

Greg Kroah-Hartman (1):
      Linux 5.15.217

Gregory Price (1):
      mm/vmstat: fold stranded per-cpu node stats when a node comes online

Guangguan Wang (1):
      net/smc: rdma write inline if qp has sufficient inline space

Guangshuo Li (3):
      drm/radeon: fix autosuspend cleanup during teardown
      mmc: vub300: fix use-after-free on probe failure
      media: marvell-cam: fix missing pci_disable_device() on remove

Haibo Chen (1):
      mmc: sdhci: make tuning_err a signed int

Haoxiang Li (3):
      i2c: davinci: Unregister cpufreq notifier on probe failure
      net: ixp4xx_hss: fix duplicate HDLC netdev allocation
      net: ipa: fix SMEM state handle leaks in SMP2P init

Haoze Xie (1):
      netfilter: nf_queue: pin bridge device while NFQUEUE holds fake dst

Herbert Xu (1):
      crypto: ccm - Set rfc4309 maxauthsize from child

Hidayath Khan (1):
      s390/qeth: validate user buffer length in SNMP and ARP query ioctls

Hugo Villeneuve (4):
      serial: max310x: replace bare use of 'unsigned' with 'unsigned int' (checkpatch)
      serial: sc16is7xx: remove obsolete out_thread label
      serial: sc16is7xx: fix regression with GPIO configuration
      serial: sc16is7xx: implement gpio get_direction() callback

Hyunjung Ko (1):
      net/sched: act_ct: fix sk_buff leak when the header checks reject a packet

Ibrahim Hashimov (2):
      ksmbd: fix integer overflow in set_file_allocation_info()
      scsi: scsi_debug: Fix REPORT ZONES alloc_len underflow OOB write

Ilpo Järvinen (1):
      serial: sc16is7xx: Fill in rs485_supported

Jai Luthra (1):
      media: i2c: imx219: Rename VTS to FRM_LENGTH

James Montgomery (1):
      ksmbd: defer destroy_previous_session() until after NTLM authentication

Jani Nikula (4):
      drm/displayid: fix Tiled Display Topology ID size
      drm/i915/vrr: require valid min/max vfreq for VRR
      drm/i915/hdcp: check streams[] bounds before overflow
      drm/i915/hdcp: require monotonically increasing seq_num_v

Jann Horn (1):
      bpf,fork: wipe ->bpf_storage before bailouts that access it

Jarkko Sakkinen (1):
      tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()

Jason Gunthorpe (1):
      udmabuf: Do not create malformed scatterlists

Jason Wang (1):
      VDUSE: avoid leaking information to userspace

Jeff Layton (1):
      audit: widen ino fields to u64

Jiacheng Yu (1):
      fbcon: Use correct type for vc_resize() return value

Jiangshan Yi (1):
      serial: 8250_mid: Fix NULL function pointer dereference on DNV/ICX-D/SNR platforms

Jiasheng Jiang (1):
      media: mediatek: vcodec: Fix a resource leak related to the scp device in FW initialization

Johan Hovold (2):
      mmc: vub300: fix use-after-free on disconnect
      mmc: vub300: rename probe error labels

Jon Hunter (1):
      arm64: tegra: Add EL2 virtual timer interrupt for Tegra194

Jonas Gorski (1):
      i2c: iproc: reset bus after timeout if START_BUSY is stuck

Josh Poimboeuf (1):
      ftrace: Fix off-by-one fentry site disable in ftrace_free_mem()

Junrui Luo (1):
      octeontx2-af: cn10k: restrict VF LMTLINE sharing to its own PF

Jérémy Jean (1):
      netfilter: flowtable: publish GC-visible tuple last

Kefu Chai (1):
      libceph: tolerate addrvecs with multiple entries of the same type

Konstantin Komarov (1):
      fs/ntfs3: Undo critial modificatins to keep directory consistency

Laurent Pinchart (1):
      media: i2c: imx219: Drop IMX219_VTS_* macros

Li Daming (1):
      rxrpc: serialize kernel accept preallocation with socket teardown

Li Xiasong (1):
      tipc: restrict socket queue dumps in enqueue tracepoints

LiangCheng Wang (1):
      wifi: brcmfmac: set F2 blocksize to 256 for BCM43752

Liem (1):
      i2c: imx: Fix slave registration race and error handling

Linmao Li (1):
      Input: psxpad-spi - set driver data before use

Liu Jian (1):
      net: Add helper function to parse netlink msg of ip_tunnel_encap

Long Li (1):
      xfs: fix ilock leak on error in xfs_dq_get_next_id

Lorenzo Stoakes (ARM) (1):
      mm/ptdump: always stabilise against page table freeing using init_mm

Maoyi Xie (4):
      net: thunderbolt: Fix frags[] overflow by bounding frame_count
      net: ipip: require CAP_NET_ADMIN in the device netns for changelink
      net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink
      wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()

Marc Kleine-Budde (1):
      can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on skb allocation failure

Matt Bobrowski (1):
      bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF LSM is uninitialized

Matthieu Baerts (NGI0) (1):
      mptcp: options: reset DSS fields in case of unexpected size

Max Kellermann (2):
      ceph: avoid fs reclaim while using current->journal_info
      ceph: fix hanging __ceph_get_caps() with stale mds_wanted

Michael Bommarito (2):
      ntfs3: validate split-point offset in indx_insert_into_buffer
      thunderbolt: Prevent XDomain delayed work use-after-free on disconnect

Michael Walle (1):
      mtd: spi-nor: Fix spi_nor_try_unlock_all()

Mika Westerberg (3):
      thunderbolt: Keep XDomain reference during the lifetime of a service
      thunderbolt: Remove service debugfs entries during unregister
      thunderbolt: Remove XDomain from the bus without holding tb->lock

Mikhail Gavrilov (1):
      dma-buf/udmabuf: skip redundant cpu sync to fix cacheline EEXIST warning

Mikulas Patocka (2):
      dm-integrity: don't increment hash_offset twice
      dm-verity: make error counter atomic

Miquel Raynal (1):
      mtd: spi-nor: swp: Improve locking user experience

Mirela Rabulea (1):
      media: v4l2-fwnode: Fix subdev owner overwritten in v4l2_async_register_subdev_sensor()

Mukesh Ojha (2):
      remoteproc: qcom: replace kstrdup with kstrndup
      remoteproc: qcom: fix sparse warnings

Myeonghun Pak (1):
      mmc: sdhci: unmap the bounce buffer before device release

Namjae Jeon (4):
      ksmbd: rename smb2_get_msg to smb_get_msg
      ksmbd: validate minimum PDU size for transform requests
      ksmbd: conn lock to serialize smb2 negotiate
      ksmbd: reject repeated SMB2 NEGOTIATE requests

NeilBrown (1):
      VFS/audit: introduce kern_path_parent() for audit

Norbert Szetei (1):
      ALSA: seq: close a re-opened queue timer in the destructor

Oleg Nesterov (1):
      taskstats: fill_stats_for_tgid: use for_each_thread()

Ondrej Mosnacek (1):
      lsm: use default hook return value in call_int_hook()

Pablo Neira Ayuso (1):
      netfilter: nf_conntrack_sip: validate skb_dst() before accessing it

Paolo Abeni (2):
      mptcp: cleanup MPJ subflow list handling
      mptcp: fix subflow accounting on close

Pavel Skripkin (1):
      fs/ntfs3: Make ntfs_update_mftmirr return void

Pavitra Jha (2):
      libceph: fix multiple unsafe decodes in decode_locker()
      libceph: fix two unsafe bare decodes in decode_lockers()

Pedro Falcato (1):
      mm: do file ownership checks with the proper mount idmap

Pengpeng Hou (1):
      Input: iforce - validate input packet lengths

Peter Seiderer (1):
      net: pktgen: fix code style (WARNING: Block comments)

Peter Ujfalusi (1):
      ASoC: cs4265: sort the register default table

Petr Machata (1):
      mlxsw: spectrum: On port enslavement to a LAG, join upper's bridges

Raphael Zimmer (1):
      libceph: Avoid using invalid osd indices from primary_temp

Rasmus Villemoes (1):
      bootconfig: do not put quotes on cmdline items unless necessary

Reinette Chatre (1):
      fs/resctrl: Fix double-add of pseudo-locked region's RMID to free list

Ricardo Robaina (2):
      audit: use 'unsigned int' instead of 'unsigned'
      audit: fix recursive locking deadlock in audit_dupe_exe()

Richard Davies (1):
      Input: focaltech - fix array out-of-bounds in focaltech_process_rel_packet

Robert Mader (1):
      udmabuf: Ensure to perform cache synchronisation in begin_cpu_udmabuf()

Rosen Penev (1):
      ASoC: xilinx: formatter_pcm: pass aud_drv_data to irq handlers

Runyu Xiao (3):
      octeontx2-pf: clear stale mailbox IRQ state before request_irq()
      octeontx2-vf: clear stale mailbox IRQ state before request_irq()
      gpio: tegra: do not call pinctrl for GPIO direction

Sabrina Dubroca (1):
      espintcp: use sk_msg_free_partial to fix partial send

Sakari Ailus (2):
      media: imx219: Fix maximum frame length in lines
      media: v4l: async: Set owner for async sub-devices

Sebastian Alba Vives (1):
      fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()

Sheng Zhao (1):
      vduse: Use fixed 4KB bounce pages for non-4KB page size

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw-nuss: Fix port_id extraction from SRC TAG

Souvik Banerjee (1):
      ovl: use linked upper dentry in copy-up tmpfile

Stefan Eichenberger (1):
      i2c: imx: separate atomic, dma and non-dma use case

Steven Rostedt (1):
      ring-buffer: Remove jump to out label in ring_buffer_swap_cpu()

Subbaraya Sundeep (1):
      octeontx2: Annotate mmio regions as __iomem

Tang Bin (1):
      ASoC: mediatek: mt8192-afe-pcm: Simplify probe() with local dev variable

Tapio Reijonen (1):
      serial: max310x: implement gpio_chip::get_direction()

Tejun Heo (1):
      sched/psi: Shut down rtpoll_timer in psi_cgroup_free()

Tengda Wu (2):
      ftrace: Add global mutex to serialize trace_parser access
      ring-buffer: Use current_context for safe per-CPU buffer swap

Thomas Gleixner (1):
      locking/rt: Fix the incorrect RCU protection in rt_spin_unlock()

Thomas Zimmermann (2):
      fbcon: Rename struct fbcon_ops to struct fbcon_par
      drm/tegra: fbdev: Remove offset into framebuffer memory

Thorsten Blum (1):
      crypto: qce - fix error path in devm_qce_register_algs

Timur Kristóf (1):
      drm/amdgpu: Fix amdgpu_bo_move() when old_mem and new_mem are both GTT

Tomasz Moń (1):
      sc16is7xx: Properly resume TX after stop

Tristan Madani (1):
      selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()

Vincent Jardin (1):
      i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)

Vladimir Oltean (1):
      net/sched: taprio: avoid calling child->ops->dequeue(child) twice

Wasim Nazir (1):
      remoteproc: qcom: Fix leak when custom dump_segments addition fails

Wei Fang (1):
      net: packet: fix wrong transport_header when sending VLAN-tagged frame

Weinan Liu (1):
      iommu/amd: Don't split flush for amd_iommu_domain_flush_all()

Wentao Liang (1):
      mlxsw: fix refcount leak in mlxsw_sp_port_lag_join()

Wolfram Sang (1):
      i2c: bcm-iproc: remove printout on handled timeouts

Xiang Mei (2):
      net/smc: reject CHID-0 ACCEPT that matches an empty ism_dev slot
      libceph: bound pg_{temp,upmap,upmap_items} length to CEPH_PG_MAX_SIZE

Xiang Mei (Microsoft) (1):
      netfilter: ipset: fix refcount race between list:set GC and swap

Xin Long (4):
      net: add a couple of helpers for iph tot_len
      openvswitch: use skb_ip_totlen in conntrack
      net: sched: use skb_ip_totlen and iph_totlen
      openvswitch: move key and ovs_cb update out of handle_fragments

Xiubo Li (3):
      libceph: add doutc and *_client debug macros support
      ceph: rename _to_client() to _to_fs_client()
      ceph: print cluster fsid and client global_id in all debug logs

Xu Rao (1):
      ALSA: hda: Fix cached processing coefficient verbs

Yang Wang (1):
      drm/amd/pm: fix torn gpu metrics reads

Yangyu Chen (1):
      net: atlantic: free stranded TX buffers on ring deinit

Yiming Zhu (1):
      ceph: fix MDS random selection readiness predicate

Yiyang Chen (1):
      taskstats: retain dead thread stats in TGID queries

Yizhou Zhao (1):
      ipvs: separate destination availability state

Yogesh Lal (1):
      remoteproc: qcom: pas: Adjust the phys addr wrt the mem region

Zack Rusin (1):
      drm/vmwgfx: Reserve fence slots on buffer objects in cotables

Zhan Xusheng (2):
      fscrypt: use the mount idmap for the owner check in fscrypt_ioctl_set_policy()
      mmc: omap_hsmmc: fix busy_timeout overflow in ns conversion on 32-bit

Zhang Heng (1):
      ALSA: hda: conexant: Remove mic bias threshold override

Zhefu Zhang (1):
      Input: atkbd - skip deactivate for Xiaomi Book Pro 14's internal keyboard

Zhiling Zou (1):
      sctp: avoid auth_enable sysctl UAF during netns teardown

Zihan Xi (1):
      net/sched: act_ct: preserve tc_skb_cb across defragmentation

