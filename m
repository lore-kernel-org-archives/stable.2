Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAEA3CA497;
	Sun, 23 Aug 2026 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787489099; cv=none; b=SKr6G6kZLjRCDrRzp3x6zC3+aJbas0f+Otj9zWLl+S/WUCFko4SvKJbLhnSH4x8XIK+mTpign54kj7jWaaiR3DGygycsuyOGg6HQAXSbvhRU6hpaNY732QNpkJok8DcTPEFyPSJO8oTkX1rrDbFU1t7da3GZFAELe6UuqMGcFGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787489099; c=relaxed/simple;
	bh=S2xcbqOQanp53GLnFRNN6TSbiQIqm2HDmWRQ2QruCVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rOuW6q6u4lpoWvW0VBovIGus0E894wtZ8eAb9NT9PnK524/bwE16KQKX5vt+gCRB5gfzVpKrzCiF0OOJj2EZ13qlC2BcLxvCocyoIDPk0KMjCIlnhU2U/D03QCEBdSkpZKPPAlK9Wx5UU961G/P/6X3EKkUknJT0bTUzeND03FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CzcuzhpC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CzcuzhpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F9D1F00A3A;
	Sun, 23 Aug 2026 12:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787489097;
	bh=6wFLNx1hkPiYRVwXvOv+zdVTJr2RX6jIXGFkaTi95Bo=;
	h=From:To:Cc:Subject:Date;
	b=CzcuzhpCEQGNPb50QgZ4seOXAIL8ieuGaqIJ6U1dF/yhHYgXzbm9dEwdIga9DQjDx
	 GFVHz7A6oiR2JmV/QP98PXzESJKj/UOBUMWK3TDaCKFl2c8amRTKx8CFfOoA7WoYON
	 lXKHsCT/YCxf4kOC5j3YKjAPRIlyUud3zm4I+dOg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.266
Date: Sun, 23 Aug 2026 14:43:12 +0200
Message-ID: <2026082312-bribe-scalping-3ef9@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.266 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                  |    2 
 arch/arm64/boot/dts/nvidia/tegra194.dtsi                  |    2 
 arch/arm64/kvm/arm.c                                      |    2 
 arch/mips/kvm/mips.c                                      |    2 
 arch/openrisc/include/asm/processor.h                     |    2 
 arch/openrisc/kernel/signal.c                             |    5 
 arch/powerpc/kvm/powerpc.c                                |    2 
 arch/powerpc/platforms/pseries/lparcfg.c                  |    2 
 arch/powerpc/platforms/pseries/pci.c                      |    2 
 arch/s390/kvm/kvm-s390.c                                  |    2 
 arch/x86/include/asm/kvm_host.h                           |    3 
 arch/x86/kernel/cpu/resctrl/rdtgroup.c                    |   12 
 arch/x86/kvm/lapic.c                                      |   41 -
 arch/x86/kvm/lapic.h                                      |    3 
 arch/x86/kvm/svm/avic.c                                   |    4 
 arch/x86/kvm/svm/svm.h                                    |    2 
 arch/x86/kvm/vmx/vmx.c                                    |    9 
 arch/x86/kvm/x86.c                                        |   19 
 crypto/ccm.c                                              |    2 
 drivers/base/property.c                                   |   29 
 drivers/char/tpm/tpm_tis_core.c                           |   38 -
 drivers/crypto/qce/core.c                                 |    2 
 drivers/dma-buf/dma-resv.c                                |    8 
 drivers/dma-buf/udmabuf.c                                 |   21 
 drivers/dma/dw-edma/dw-edma-core.c                        |   77 +-
 drivers/dma/dw-edma/dw-edma-core.h                        |   20 
 drivers/dma/dw-edma/dw-edma-pcie.c                        |  180 +++-
 drivers/dma/dw-edma/dw-edma-v0-core.c                     |   76 +-
 drivers/fpga/dfl-afu-main.c                               |    3 
 drivers/gpio/gpio-tegra.c                                 |   18 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c          |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c                   |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c                   |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                    |    2 
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                     |   26 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                        |   14 
 drivers/gpu/drm/drm_connector.c                           |   12 
 drivers/gpu/drm/drm_dp_mst_topology.c                     |   32 
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c              |    2 
 drivers/gpu/drm/i915/display/intel_hdcp.c                 |    7 
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
 drivers/gpu/drm/virtio/virtgpu_gem.c                      |   17 
 drivers/gpu/drm/virtio/virtgpu_plane.c                    |    5 
 drivers/gpu/drm/virtio/virtgpu_vq.c                       |    9 
 drivers/hwmon/npcm750-pwm-fan.c                           |   11 
 drivers/i2c/busses/i2c-bcm-iproc.c                        |   11 
 drivers/i2c/busses/i2c-davinci.c                          |    4 
 drivers/i2c/busses/i2c-imx.c                              |  126 ++-
 drivers/i2c/i2c-core-base.c                               |    2 
 drivers/i2c/i2c-core-smbus.c                              |   15 
 drivers/i2c/i2c-smbus.c                                   |    5 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                    |    5 
 drivers/input/joystick/iforce/iforce-packets.c            |   11 
 drivers/input/joystick/iforce/iforce-usb.c                |    3 
 drivers/input/joystick/psxpad-spi.c                       |    1 
 drivers/input/keyboard/atkbd.c                            |    8 
 drivers/input/misc/ims-pcu.c                              |    7 
 drivers/input/mouse/focaltech.c                           |    2 
 drivers/input/rmi4/rmi_f54.c                              |   43 -
 drivers/input/rmi4/rmi_f55.c                              |    4 
 drivers/input/touchscreen/mms114.c                        |    6 
 drivers/input/touchscreen/sur40.c                         |   23 
 drivers/md/dm-integrity.c                                 |    4 
 drivers/md/dm-verity-target.c                             |   12 
 drivers/md/dm-verity.h                                    |    2 
 drivers/media/i2c/imx219.c                                |   47 -
 drivers/media/platform/aspeed-video.c                     |    1 
 drivers/media/platform/marvell-ccic/cafe-driver.c         |    1 
 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c     |    5 
 drivers/media/v4l2-core/v4l2-async.c                      |    8 
 drivers/media/v4l2-core/v4l2-fwnode.c                     |    7 
 drivers/mmc/host/omap_hsmmc.c                             |    2 
 drivers/mmc/host/sdhci.c                                  |   16 
 drivers/mmc/host/sdhci.h                                  |    2 
 drivers/mmc/host/vub300.c                                 |   36 
 drivers/mtd/maps/vmu-flash.c                              |    8 
 drivers/mtd/spi-nor/Makefile                              |    2 
 drivers/mtd/spi-nor/core.c                                |  406 -----------
 drivers/mtd/spi-nor/core.h                                |    5 
 drivers/mtd/spi-nor/intel.c                               |   16 
 drivers/mtd/spi-nor/sst.c                                 |   30 
 drivers/mtd/spi-nor/swp.c                                 |  426 +++++++++++
 drivers/net/can/usb/gs_usb.c                              |    2 
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c          |   25 
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h          |    1 
 drivers/net/ethernet/aquantia/atlantic/aq_vec.c           |    2 
 drivers/net/ethernet/intel/ice/ice_ethtool.c              |   10 
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c          |   48 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c      |   13 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c      |    8 
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c            |  109 ++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h            |    4 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c     |   31 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                  |  139 ++-
 drivers/net/ethernet/ti/am65-cpsw-nuss.h                  |    4 
 drivers/net/ipa/ipa_smp2p.c                               |   30 
 drivers/net/thunderbolt.c                                 |    8 
 drivers/net/wireless/ath/ath6kl/txrx.c                    |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c |   13 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h    |    6 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c   |   45 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c   |    6 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   |    6 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h   |    1 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c    |    3 
 drivers/net/wireless/marvell/libertas_tf/main.c           |    2 
 drivers/pci/pci.c                                         |   30 
 drivers/s390/cio/vfio_ccw_cp.c                            |   17 
 drivers/s390/net/qeth_core_main.c                         |    3 
 drivers/s390/net/qeth_l3_main.c                           |    5 
 drivers/scsi/lpfc/lpfc_init.c                             |    3 
 drivers/scsi/scsi_debug.c                                 |   27 
 drivers/scsi/sd.h                                         |    5 
 drivers/scsi/sd_zbc.c                                     |   79 +-
 drivers/target/target_core_fabric_lib.c                   |  144 +++
 drivers/target/target_core_internal.h                     |    5 
 drivers/target/target_core_pr.c                           |   54 -
 drivers/thunderbolt/domain.c                              |   30 
 drivers/thunderbolt/icm.c                                 |    5 
 drivers/thunderbolt/switch.c                              |   14 
 drivers/thunderbolt/tb.c                                  |   58 -
 drivers/thunderbolt/tb.h                                  |    2 
 drivers/thunderbolt/xdomain.c                             |   71 +
 drivers/tty/serial/8250/8250_mid.c                        |    6 
 drivers/tty/serial/max310x.c                              |   20 
 drivers/tty/serial/sc16is7xx.c                            |  192 ++++-
 drivers/usb/gadget/function/f_tcm.c                       |  192 ++++-
 drivers/usb/gadget/function/tcm.h                         |   13 
 drivers/usb/gadget/udc/bdc/bdc_core.c                     |   20 
 drivers/usb/gadget/udc/bdc/bdc_udc.c                      |    7 
 drivers/usb/serial/keyspan_pda.c                          |  463 ++++++------
 fs/9p/vfs_inode.c                                         |    9 
 fs/binfmt_elf.c                                           |    4 
 fs/binfmt_elf_fdpic.c                                     |    4 
 fs/binfmt_misc.c                                          |   14 
 fs/ceph/addr.c                                            |   24 
 fs/ceph/cache.c                                           |    2 
 fs/ceph/caps.c                                            |   53 -
 fs/ceph/dir.c                                             |   20 
 fs/ceph/export.c                                          |   10 
 fs/ceph/file.c                                            |   33 
 fs/ceph/inode.c                                           |   20 
 fs/ceph/ioctl.c                                           |    8 
 fs/ceph/mds_client.c                                      |   11 
 fs/ceph/mds_client.h                                      |    2 
 fs/ceph/mdsmap.c                                          |    2 
 fs/ceph/super.c                                           |   22 
 fs/ceph/super.h                                           |    8 
 fs/ceph/xattr.c                                           |    8 
 fs/cifs/smb2ops.c                                         |    4 
 fs/exec.c                                                 |    6 
 fs/f2fs/data.c                                            |    2 
 fs/jbd2/journal.c                                         |   10 
 fs/namei.c                                                |   42 +
 fs/overlayfs/copy_up.c                                    |   14 
 fs/super.c                                                |   19 
 fs/xfs/libxfs/xfs_sb.c                                    |    4 
 include/drm/drm_connector.h                               |    6 
 include/drm/drm_displayid.h                               |    2 
 include/linux/audit.h                                     |   18 
 include/linux/bootconfig.h                                |    3 
 include/linux/bpf_lsm.h                                   |    4 
 include/linux/ceph/ceph_debug.h                           |   38 +
 include/linux/dma-resv.h                                  |    2 
 include/linux/dma/edma.h                                  |    2 
 include/linux/firmware.h                                  |    3 
 include/linux/fs.h                                        |   28 
 include/linux/i2c-smbus.h                                 |    6 
 include/linux/jbd2.h                                      |    9 
 include/linux/kvm_host.h                                  |    1 
 include/linux/lsm_hooks.h                                 |    1 
 include/linux/namei.h                                     |    1 
 include/linux/pci.h                                       |    1 
 include/linux/property.h                                  |    1 
 include/linux/skbuff.h                                    |    2 
 include/linux/thunderbolt.h                               |    3 
 include/media/v4l2-async.h                                |    9 
 include/net/act_api.h                                     |   20 
 include/net/ip_tunnels.h                                  |    3 
 include/net/ip_vs.h                                       |    7 
 include/trace/events/rxrpc.h                              |    2 
 include/uapi/linux/ip_vs.h                                |    6 
 init/main.c                                               |   39 -
 kernel/audit.c                                            |    2 
 kernel/audit.h                                            |   32 
 kernel/audit_fsnotify.c                                   |   39 -
 kernel/audit_tree.c                                       |    2 
 kernel/audit_watch.c                                      |   42 -
 kernel/auditfilter.c                                      |   17 
 kernel/auditsc.c                                          |    6 
 kernel/bpf/bpf_inode_storage.c                            |   10 
 kernel/sched/psi.c                                        |    6 
 kernel/taskstats.c                                        |   67 -
 kernel/trace/ftrace.c                                     |   21 
 kernel/trace/ring_buffer.c                                |   23 
 lib/bootconfig.c                                          |   65 +
 lib/compat_audit.c                                        |   12 
 mm/memory_hotplug.c                                       |   15 
 mm/pagewalk.c                                             |    8 
 mm/ptdump.c                                               |    7 
 net/9p/client.c                                           |    2 
 net/bluetooth/hidp/core.c                                 |   25 
 net/ceph/cls_lock_client.c                                |   21 
 net/ceph/osdmap.c                                         |    9 
 net/core/pktgen.c                                         |   43 -
 net/core/skbuff.c                                         |   28 
 net/ipv4/ip_tunnel_core.c                                 |   35 
 net/ipv4/ipip.c                                           |   41 -
 net/ipv6/ip6_tunnel.c                                     |   40 -
 net/ipv6/sit.c                                            |   38 -
 net/mptcp/options.c                                       |   21 
 net/mptcp/protocol.c                                      |    4 
 net/mptcp/protocol.h                                      |   14 
 net/mptcp/subflow.c                                       |   12 
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
 net/netfilter/nf_tables_offload.c                         |    2 
 net/packet/af_packet.c                                    |    7 
 net/rxrpc/call_accept.c                                   |   28 
 net/rxrpc/call_object.c                                   |   27 
 net/rxrpc/recvmsg.c                                       |   23 
 net/sched/act_gact.c                                      |    5 
 net/sched/act_police.c                                    |    6 
 net/sched/sch_api.c                                       |   24 
 net/sched/sch_taprio.c                                    |   12 
 net/sctp/protocol.c                                       |   20 
 net/sctp/sysctl.c                                         |    9 
 net/smc/af_smc.c                                          |    3 
 net/smc/smc_rx.c                                          |   12 
 net/smc/smc_tx.c                                          |   17 
 net/tipc/socket.c                                         |    6 
 net/xfrm/espintcp.c                                       |   32 
 security/apparmor/include/net.h                           |    6 
 security/apparmor/lsm.c                                   |   38 -
 security/bpf/hooks.c                                      |    3 
 security/security.c                                       |  506 ++++++++------
 security/selinux/hooks.c                                  |   91 +-
 security/selinux/include/objsec.h                         |    5 
 security/selinux/netlabel.c                               |   23 
 security/selinux/ss/policydb.c                            |   31 
 security/selinux/ss/services.c                            |    4 
 security/smack/smack.h                                    |    5 
 security/smack/smack_lsm.c                                |   66 -
 security/smack/smack_netfilter.c                          |    8 
 sound/core/seq/seq_timer.c                                |   13 
 sound/hda/hdac_regmap.c                                   |    4 
 sound/soc/codecs/cs4265.c                                 |    4 
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c                |   12 
 sound/soc/xilinx/xlnx_formatter_pcm.c                     |   10 
 sound/usb/usx2y/usX2Yhwdep.c                              |   10 
 sound/usb/usx2y/usbus428ctldefs.h                         |    2 
 sound/usb/usx2y/usbusx2y.c                                |    2 
 sound/usb/usx2y/usx2yhwdeppcm.c                           |   15 
 virt/kvm/kvm_main.c                                       |    3 
 274 files changed, 4173 insertions(+), 2363 deletions(-)

Abdun Nihaal (1):
      scsi: lpfc: Fix memory leak in lpfc_sli4_driver_resource_setup()

Akhil R (2):
      device property: Add fwnode_irq_get_byname
      i2c: smbus: Use device_*() functions instead of of_*()

Aldo Ariel Panzardo (1):
      net/sched: serialize qdisc_rtab_list against concurrent get/put

Alexey Velichayshiy (1):
      netfilter: nf_tables_offload: suppress WARN_ON_ONCE for ENOMEM in abort path

Ali Ahmet Memis (1):
      openrisc: signal: do not restore privileged SR bits on sigreturn

Amir Goldstein (2):
      fsnotify: opt-in for permission events at file open time
      fs: don't block write during exec on pre-content watched files

Andy Shevchenko (3):
      serial: 8250_mid: Remove unneeded test for ->setup() presence
      libceph: Amend checking to fix `make W=1` build breakage
      i2c: smbus: Check for parent device before dereference

Ashutosh Desai (3):
      drm/dp/mst: fix buffer overflows in sideband chunk accumulation
      drm/dp/mst: fix OOB reads on 2-byte fields in sideband reply parsers
      drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply parsers

Bart Van Assche (1):
      scsi: sd: sd_zbc: Improve source code documentation

Baul Lee (1):
      ALSA: usx2y: bound the hwdep mmap fault offset

Breno Leitao (3):
      9p: skip nlink update in cacheless mode to fix WARN_ON
      bootconfig: move xbc_snprint_cmdline() to lib/bootconfig.c
      bootconfig: fix NULL-pointer arithmetic in xbc_snprint_cmdline()

Bryam Vargas (8):
      selinux: require every boolean value to be defined
      selinux: reject a class permission count below its inherited common
      selinux: do not cancel a policy conversion that never started
      Input: synaptics-rmi4 - bound the F54 report size to the allocated buffer
      Input: mms114 - reject an oversized device packet size
      scsi: target: Bound PR-OUT TransportID parsing to the received buffer
      net/sched: sch_taprio: Replace direct dequeue call with peek and qdisc_dequeue_peeked
      drm/virtio: bound EDID block reads to the response buffer

Candice Li (1):
      drm/amdgpu: validate GEM_CREATE domain combinations

Casey Schaufler (1):
      lsm: infrastructure management of the sock security

Cen Zhang (1):
      usb: gadget: f_tcm: synchronize delayed set_alt with teardown

Chaitanya Kulkarni (1):
      scsi: target: core: pr: Initialize arrays at declaration time

Chao Yu (1):
      f2fs: fix UAF issue in f2fs_merge_page_bio()

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

Chunfeng Yun (1):
      usb: gadget: bdc: fix checkpatch.pl spacing error

Cássio Gabriel (1):
      ASoC: mediatek: mt8183: Check runtime resume during probe

Damien Le Moal (3):
      scsi: sd: sd_zbc: Use logical blocks as unit when querying zones
      scsi: sd: sd_zbc: Return early in sd_zbc_check_zoned_characteristics()
      scsi: scsi_debug: Rename zone type constants

Daming Li (1):
      net: smc: fix splice entry lifetime imbalance in smc_rx_splice

Daniel Hodges (1):
      wifi: ath6kl: fix use-after-free in aggr_reset_state()

David Carlier (1):
      media: aspeed: fix missing of_reserved_mem_device_release() on probe failure

David Howells (3):
      rxrpc: Fix recv-recv race of completed call
      rxrpc: Fix notification vs call-release vs recvmsg
      rxrpc: Fix socket notification race

David Matlack (1):
      KVM: Introduce vcpu->wants_to_run

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

Deepanshu Kartikey (1):
      drm/virtio: use uninterruptible resv lock for plane updates

Dmitry Osipenko (1):
      drm/virtio: Return proper error codes instead of -1

Dmitry Torokhov (9):
      Input: synaptics-rmi4 - fix F55 transmitter electrode count typo
      Input: synaptics-rmi4 - zero report size on F54 work error
      Input: synaptics-rmi4 - block s_input when F54 queue is busy
      Input: synaptics-rmi4 - propagate F54 worker errors to V4L2 queue
      Input: sur40 - fix input device registration ordering
      Input: sur40 - fix V4L error path cleanup
      Input: ims-pcu - fix race condition in reset_device sysfs callback
      firmware_loader: introduce __free() cleanup hanler
      Input: ims-pcu - fix firmware leak in async update

Eric Dumazet (1):
      af_packet: Don't send zero-byte data in tpacket_snd().

Eric Farman (1):
      s390/vfio_ccw: Fix out of bounds check on CCW array

Fan Wu (2):
      usb: gadget: udc: bdc: free IRQ and drain func_wake_notify before teardown
      wifi: brcmfmac: drain bus_reset work on device removal

Florian Fuchs (1):
      mtd: maps: vmu-flash: fix fault in unaligned fixup

Florian Westphal (2):
      netfilter: nf_conntrack_sip: remove net variable shadowing
      netfilter: ipset: fix list type element drift bug

Frank Li (2):
      dmaengine: dw-edma: Remove unused irq field in struct dw_edma_chip
      dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and ABORT_INT_MASK

Fredric Cover (1):
      smb: client: use kvzalloc() for megabyte buffer in simple fallocate

Fullway Wang (1):
      media: mtk-vcodec: potential null pointer deference in SCP

George Wilson (2):
      powerpc/pseries: pci - logic bug
      powerpc/pseries: lparcfg - fix kbuf[] underflow

Greg Kroah-Hartman (1):
      Linux 5.10.266

Gregory Price (1):
      mm/vmstat: fold stranded per-cpu node stats when a node comes online

Grygorii Strashko (3):
      net: ethernet: ti: am65-cpsw: move ale selection in pdata
      net: ethernet: ti: am65-cpsw: move free desc queue mode selection in pdata
      net: ethernet: ti: am65-cpsw: add multi port support in mac-only mode

Guangguan Wang (1):
      net/smc: rdma write inline if qp has sufficient inline space

Guangshuo Li (3):
      drm/radeon: fix autosuspend cleanup during teardown
      mmc: vub300: fix use-after-free on probe failure
      media: marvell-cam: fix missing pci_disable_device() on remove

Gustavo Pimentel (2):
      PCI: Add pci_find_vsec_capability() to find a specific VSEC
      dmaengine: dw-edma: Improve the linked list and data blocks definition

Haibo Chen (1):
      mmc: sdhci: make tuning_err a signed int

Haoxiang Li (2):
      i2c: davinci: Unregister cpufreq notifier on probe failure
      net: ipa: fix SMEM state handle leaks in SMP2P init

Harshad Shirwadkar (1):
      jbd2: add a helper to find out number of fast commit blocks

Herbert Xu (1):
      crypto: ccm - Set rfc4309 maxauthsize from child

Hidayath Khan (1):
      s390/qeth: validate user buffer length in SNMP and ARP query ioctls

Hongyan Xu (1):
      hwmon: (npcm750-pwm-fan): stop fan timer on device detach

Hugo Villeneuve (4):
      serial: max310x: replace bare use of 'unsigned' with 'unsigned int' (checkpatch)
      serial: sc16is7xx: remove obsolete out_thread label
      serial: sc16is7xx: fix regression with GPIO configuration
      serial: sc16is7xx: implement gpio get_direction() callback

Hyunjung Ko (1):
      net/sched: act_gact, act_police: range check the fallback control action

Ibrahim Hashimov (1):
      scsi: scsi_debug: Fix REPORT ZONES alloc_len underflow OOB write

Ido Schimmel (1):
      mlxsw: spectrum: Apply RIF configuration when joining a LAG

Ilpo Järvinen (1):
      serial: sc16is7xx: Fill in rs485_supported

Jai Luthra (1):
      media: i2c: imx219: Rename VTS to FRM_LENGTH

Jani Nikula (2):
      drm/displayid: fix Tiled Display Topology ID size
      drm/i915/hdcp: require monotonically increasing seq_num_v

Jarkko Sakkinen (1):
      tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()

Jason Gunthorpe (1):
      udmabuf: Do not create malformed scatterlists

Jeff Layton (1):
      audit: widen ino fields to u64

Jiangshan Yi (1):
      serial: 8250_mid: Fix NULL function pointer dereference on DNV/ICX-D/SNR platforms

Jiasheng Jiang (1):
      media: mediatek: vcodec: Fix a resource leak related to the scp device in FW initialization

Johan Hovold (8):
      mmc: vub300: fix use-after-free on disconnect
      mmc: vub300: rename probe error labels
      USB: serial: keyspan_pda: refactor write-room handling
      USB: serial: keyspan_pda: fix write implementation
      USB: serial: keyspan_pda: add write-fifo support
      USB: serial: keyspan_pda: clean up comments and whitespace
      USB: serial: keyspan_pda: fix data loss on receive throttling
      USB: serial: keyspan_pda: fix information leak

Jon Hunter (1):
      arm64: tegra: Add EL2 virtual timer interrupt for Tegra194

Jonas Gorski (1):
      i2c: iproc: reset bus after timeout if START_BUSY is stuck

Josh Poimboeuf (1):
      ftrace: Fix off-by-one fentry site disable in ftrace_free_mem()

Junrui Luo (1):
      jbd2: fix integer underflow in jbd2_journal_initialize_fast_commit()

Jérémy Jean (1):
      netfilter: flowtable: publish GC-visible tuple last

Laurent Pinchart (1):
      media: i2c: imx219: Drop IMX219_VTS_* macros

Li Daming (1):
      rxrpc: serialize kernel accept preallocation with socket teardown

Li Xiasong (1):
      tipc: restrict socket queue dumps in enqueue tracepoints

Linmao Li (1):
      Input: psxpad-spi - set driver data before use

Liu Jian (1):
      net: Add helper function to parse netlink msg of ip_tunnel_encap

Lorenzo Stoakes (ARM) (1):
      mm/ptdump: always stabilise against page table freeing using init_mm

Luiz Augusto von Dentz (1):
      skbuff: introduce skb_pull_data

Maoyi Xie (4):
      net: thunderbolt: Fix frags[] overflow by bounding frame_count
      wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()
      net: ipip: require CAP_NET_ADMIN in the device netns for changelink
      net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink

Marc Kleine-Budde (1):
      can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on skb allocation failure

Matt Bobrowski (1):
      bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF LSM is uninitialized

Matthieu Baerts (NGI0) (1):
      mptcp: options: reset DSS fields in case of unexpected size

Maurizio Lombardi (1):
      scsi: target: core: Generate correct identifiers for PR OUT transport IDs

Max Kellermann (2):
      ceph: avoid fs reclaim while using current->journal_info
      ceph: fix hanging __ceph_get_caps() with stale mds_wanted

Michael Bommarito (2):
      thunderbolt: Prevent XDomain delayed work use-after-free on disconnect
      mptcp: only set DATA_FIN when a mapping is present

Michael Walle (3):
      mtd: spi-nor: sst: remove global protection flag
      mtd: spi-nor: intel: remove global protection flag
      mtd: spi-nor: Fix spi_nor_try_unlock_all()

Mika Westerberg (2):
      thunderbolt: Keep XDomain reference during the lifetime of a service
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

Myeonghun Pak (1):
      mmc: sdhci: unmap the bounce buffer before device release

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

Paolo Abeni (1):
      mptcp: fix subflow accounting on close

Pavitra Jha (2):
      libceph: fix multiple unsafe decodes in decode_locker()
      libceph: fix two unsafe bare decodes in decode_lockers()

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

Sangho Lee (1):
      Bluetooth: HIDP: reject frames without a transaction header

Sean Christopherson (3):
      KVM: x86: Drop @vcpu parameter from kvm_x86_ops.hwapic_isr_update()
      KVM: x86: Check for in-kernel xAPIC when querying APICv for directed yield
      KVM: x86: Move "apicv_active" into "struct kvm_lapic"

Sebastian Alba Vives (1):
      fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()

Shiming Cheng (1):
      net: gro: fix double aggregation of flush-marked skbs

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

Takashi Iwai (1):
      ALSA: usx2y: Fix potential leaks of uninitialized memory

Tapio Reijonen (1):
      serial: max310x: implement gpio_chip::get_direction()

Tejun Heo (1):
      sched/psi: Shut down rtpoll_timer in psi_cgroup_free()

Tengda Wu (2):
      ftrace: Add global mutex to serialize trace_parser access
      ring-buffer: Use current_context for safe per-CPU buffer swap

Thomas Zimmermann (1):
      drm/tegra: fbdev: Remove offset into framebuffer memory

Thorsten Blum (1):
      crypto: qce - fix error path in devm_qce_register_algs

Tomasz Moń (1):
      sc16is7xx: Properly resume TX after stop

Tristan Madani (1):
      selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()

Tudor Ambarus (1):
      mtd: spi-nor: Move Software Write Protection logic out of the core

Vasiliy Kovalev (1):
      net/9p: fix infinite loop in p9_client_rpc on fatal signal

Venkatesh Srinivas (1):
      KVM: x86: Only reset TSC Deadline Timer in apic_timer_expired on KVM_RUN

Vincent Jardin (1):
      i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)

Vladimir Oltean (1):
      net/sched: taprio: avoid calling child->ops->dequeue(child) twice

Wei Fang (1):
      net: packet: fix wrong transport_header when sending VLAN-tagged frame

Wentao Liang (1):
      mlxsw: fix refcount leak in mlxsw_sp_port_lag_join()

Wolfram Sang (1):
      i2c: bcm-iproc: remove printout on handled timeouts

Xiang Mei (2):
      net/smc: reject CHID-0 ACCEPT that matches an empty ism_dev slot
      libceph: bound pg_{temp,upmap,upmap_items} length to CEPH_PG_MAX_SIZE

Xiang Mei (Microsoft) (1):
      netfilter: ipset: fix refcount race between list:set GC and swap

Xiubo Li (2):
      libceph: add doutc and *_client debug macros support
      ceph: rename _to_client() to _to_fs_client()

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

Zhan Xusheng (1):
      mmc: omap_hsmmc: fix busy_timeout overflow in ns conversion on 32-bit

Zhang Changzhong (1):
      net: ethernet: ti: am65-cpsw: fix error handling in am65_cpsw_nuss_probe()

Zhefu Zhang (1):
      Input: atkbd - skip deactivate for Xiaomi Book Pro 14's internal keyboard

Zhenhao Wan (1):
      RDMA/rtrs-srv: Bound RDMA-Write length to chunk size in rdma_write_sg

Zhiling Zou (1):
      sctp: avoid auth_enable sysctl UAF during netns teardown

