Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5017A3D75C9;
	Sun, 23 Aug 2026 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787489111; cv=none; b=Cp2Pl2wHY4yvrRwKPGBrytr+qc5mj1YcoEN1hFRaHKuk8nA64FNjtCY7du7KwRozPu4NqjNVavzRlNirHrMG/xNOjOypy4SHuXit3evnNxcG9M6CvZWTZAz7fFYvEcuwwHURfpkpL5Rb1dW7A536Lk5G95uBI2w6vA23bcGIp3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787489111; c=relaxed/simple;
	bh=wpP0JX3lrwQa0kCraHwnc4Dg/MYwsHeFNgDsnPEl3tA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gw/sM/iOuTF6os+h5IevEnal2GPVoo1+hFN/C45HPZLo9euo1KrdnFsfwqbINofhg+Mf+zO6lHAX2KJa7DKyiT++pfpu8HH3IGtwCTiKR06hCNoddqkVRlfT03Lnug3ydv+s73quW2KCLTClNFV42Ro9Wlzx56sY91itHAIDUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bO7kv3Av; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bO7kv3Av"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345BC1F00A3E;
	Sun, 23 Aug 2026 12:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787489107;
	bh=CvrWaD2/WO9hDwk8Pzt8ssoIY4J2ugNIhAfwveVnzks=;
	h=From:To:Cc:Subject:Date;
	b=bO7kv3AvwpwTx8nU3GCuJwdIXCxNY6itzk3NdNANo9WVbhQ5sbG5rXPjX2aCQU7Z9
	 Vg16rcpExbeMYJVBaIJnbtAocRQ3ZaZeO1tHescVw82VPIT4KV+yq4nLAlrMzpdUR1
	 tdixbs+FttGDxvCgksTHOiV13Cr7a3CXKpygkZR8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.184
Date: Sun, 23 Aug 2026 14:43:18 +0200
Message-ID: <2026082319-prowess-overhand-63a4@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.184 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
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
 arch/riscv/include/asm/pgtable-32.h                       |    3 
 arch/riscv/include/asm/pgtable.h                          |    1 
 arch/riscv/kvm/vcpu.c                                     |    2 
 arch/riscv/mm/init.c                                      |   11 
 arch/s390/include/asm/cpu_mcf.h                           |  112 ---
 arch/s390/kernel/Makefile                                 |    2 
 arch/s390/kernel/perf_cpum_cf.c                           |  272 ++++++++-
 arch/s390/kernel/perf_cpum_cf_common.c                    |  233 -------
 arch/s390/kernel/perf_pai_ext.c                           |    2 
 arch/s390/kvm/kvm-s390.c                                  |    2 
 arch/s390/kvm/pci.c                                       |   86 ++
 arch/s390/kvm/pci.h                                       |    2 
 arch/x86/kernel/cpu/resctrl/rdtgroup.c                    |   12 
 arch/x86/kvm/lapic.c                                      |    2 
 arch/x86/kvm/svm/sev.c                                    |   34 -
 arch/x86/kvm/svm/svm.h                                    |    1 
 arch/x86/kvm/x86.c                                        |    4 
 block/genhd.c                                             |   12 
 crypto/ccm.c                                              |    2 
 drivers/ata/libata-core.c                                 |   18 
 drivers/ata/libata-scsi.c                                 |    2 
 drivers/ata/libata.h                                      |    9 
 drivers/bluetooth/btmrvl_main.c                           |    9 
 drivers/bluetooth/btrsi.c                                 |    1 
 drivers/bluetooth/btsdio.c                                |    8 
 drivers/bluetooth/btusb.c                                 |    5 
 drivers/bluetooth/hci_ldisc.c                             |    6 
 drivers/bluetooth/hci_serdev.c                            |    5 
 drivers/bluetooth/hci_uart.h                              |    1 
 drivers/bluetooth/hci_vhci.c                              |   10 
 drivers/bluetooth/virtio_bt.c                             |    2 
 drivers/char/ipmi/ipmi_msghandler.c                       |    8 
 drivers/crypto/qce/core.c                                 |    2 
 drivers/dma-buf/udmabuf.c                                 |   21 
 drivers/fpga/dfl-afu-main.c                               |    3 
 drivers/gpio/gpio-mt7621.c                                |    2 
 drivers/gpio/gpio-mvebu.c                                 |    4 
 drivers/gpio/gpio-pxa.c                                   |    4 
 drivers/gpio/gpio-tegra.c                                 |   18 
 drivers/gpio/gpio-vf610.c                                 |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                    |   30 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c                   |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c               |   30 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c                   |   11 
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                     |   26 
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                       |   27 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                        |   16 
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h                   |    6 
 drivers/gpu/drm/bridge/cdns-dsi.c                         |   11 
 drivers/gpu/drm/drm_connector.c                           |   12 
 drivers/gpu/drm/i915/display/intel_display_core.h         |    3 
 drivers/gpu/drm/i915/display/intel_hdcp.c                 |   22 
 drivers/gpu/drm/i915/display/intel_vrr.c                  |   10 
 drivers/gpu/drm/i915/i915_driver.c                        |    3 
 drivers/gpu/drm/radeon/radeon_kms.c                       |    1 
 drivers/gpu/drm/tegra/fb.c                                |    8 
 drivers/i2c/busses/i2c-bcm-iproc.c                        |   11 
 drivers/i2c/busses/i2c-davinci.c                          |    4 
 drivers/i2c/busses/i2c-imx.c                              |  126 ++--
 drivers/infiniband/sw/siw/siw_qp_tx.c                     |   17 
 drivers/input/joystick/iforce/iforce-packets.c            |   11 
 drivers/input/joystick/iforce/iforce-usb.c                |    3 
 drivers/input/joystick/psxpad-spi.c                       |    1 
 drivers/input/keyboard/atkbd.c                            |    8 
 drivers/input/misc/ims-pcu.c                              |    5 
 drivers/input/mouse/focaltech.c                           |    2 
 drivers/input/rmi4/rmi_f54.c                              |   43 +
 drivers/input/rmi4/rmi_f55.c                              |    4 
 drivers/input/touchscreen/mms114.c                        |   21 
 drivers/input/touchscreen/sur40.c                         |   23 
 drivers/iommu/amd/iommu.c                                 |    3 
 drivers/md/dm-bufio.c                                     |    9 
 drivers/md/dm-cache-metadata.c                            |    6 
 drivers/md/dm-cache-policy-internal.h                     |    3 
 drivers/md/dm-cache-policy-smq.c                          |    2 
 drivers/md/dm-cache-target.c                              |   12 
 drivers/md/dm-crypt.c                                     |   20 
 drivers/md/dm-era-target.c                                |   10 
 drivers/md/dm-flakey.c                                    |    4 
 drivers/md/dm-integrity.c                                 |  182 +++---
 drivers/md/dm-io.c                                        |   27 
 drivers/md/dm-ioctl.c                                     |   18 
 drivers/md/dm-kcopyd.c                                    |    2 
 drivers/md/dm-log.c                                       |    6 
 drivers/md/dm-mpath.c                                     |    3 
 drivers/md/dm-rq.c                                        |    2 
 drivers/md/dm-snap-persistent.c                           |   23 
 drivers/md/dm-snap.c                                      |   10 
 drivers/md/dm-stats.c                                     |   22 
 drivers/md/dm-stripe.c                                    |   10 
 drivers/md/dm-sysfs.c                                     |    1 
 drivers/md/dm-table.c                                     |    3 
 drivers/md/dm-thin-metadata.c                             |    5 
 drivers/md/dm-thin.c                                      |    5 
 drivers/md/dm-verity-target.c                             |   24 
 drivers/md/dm-verity.h                                    |    2 
 drivers/md/dm-writecache.c                                |   54 +
 drivers/md/persistent-data/dm-array.c                     |    4 
 drivers/md/persistent-data/dm-bitset.c                    |    1 
 drivers/md/persistent-data/dm-block-manager.c             |    7 
 drivers/md/persistent-data/dm-btree-internal.h            |    1 
 drivers/md/persistent-data/dm-btree-remove.c              |    5 
 drivers/md/persistent-data/dm-btree-spine.c               |    6 
 drivers/md/persistent-data/dm-btree.c                     |   10 
 drivers/md/persistent-data/dm-space-map-common.c          |    6 
 drivers/md/persistent-data/dm-space-map-disk.c            |   12 
 drivers/md/persistent-data/dm-space-map-metadata.c        |    3 
 drivers/md/persistent-data/dm-transaction-manager.c       |    1 
 drivers/media/i2c/imx219.c                                |   47 -
 drivers/misc/mei/bus.c                                    |   16 
 drivers/mmc/host/omap_hsmmc.c                             |    2 
 drivers/mmc/host/sdhci.c                                  |   16 
 drivers/mmc/host/sdhci.h                                  |    2 
 drivers/mmc/host/vub300.c                                 |   36 -
 drivers/mtd/maps/vmu-flash.c                              |    8 
 drivers/net/bonding/bond_main.c                           |    2 
 drivers/net/can/rcar/rcar_canfd.c                         |  177 +++--
 drivers/net/can/usb/gs_usb.c                              |    4 
 drivers/net/ethernet/cadence/macb_main.c                  |   22 
 drivers/net/ethernet/intel/ice/ice_ethtool.c              |   10 
 drivers/net/ethernet/intel/ice/ice_vf_lib.c               |   27 
 drivers/net/ethernet/intel/ice/ice_vf_lib_private.h       |    1 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c             |   21 
 drivers/net/ethernet/intel/igc/igc_main.c                 |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c           |   14 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h           |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c     |    9 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c      |   14 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c      |   13 
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c            |   92 +++
 drivers/net/ethernet/microsoft/mana/mana_en.c             |   13 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                  |    2 
 drivers/net/ipa/ipa_smp2p.c                               |   30 -
 drivers/net/ipvlan/ipvlan_main.c                          |    4 
 drivers/net/macvlan.c                                     |    4 
 drivers/net/thunderbolt.c                                 |    8 
 drivers/net/veth.c                                        |   78 +-
 drivers/net/wireless/ath/ath6kl/txrx.c                    |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c |   16 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h    |    6 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c   |   45 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c   |    6 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   |    8 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h   |    1 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c    |    3 
 drivers/net/wireless/marvell/libertas_tf/main.c           |    2 
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
 drivers/pinctrl/vt8500/pinctrl-wmt.c                      |    4 
 drivers/remoteproc/qcom_common.c                          |   31 -
 drivers/remoteproc/qcom_common.h                          |    5 
 drivers/remoteproc/qcom_q6v5_pas.c                        |   20 
 drivers/s390/cio/vfio_ccw_async.c                         |   16 
 drivers/s390/cio/vfio_ccw_chp.c                           |   15 
 drivers/s390/cio/vfio_ccw_cp.c                            |   17 
 drivers/s390/cio/vfio_ccw_ops.c                           |    7 
 drivers/s390/net/qeth_core_main.c                         |    3 
 drivers/s390/net/qeth_l3_main.c                           |    5 
 drivers/soc/imx/imx8m-blk-ctrl.c                          |   27 
 drivers/thunderbolt/xdomain.c                             |   40 +
 drivers/tty/serial/max310x.c                              |   20 
 drivers/usb/gadget/function/f_tcm.c                       |  192 +++++-
 drivers/usb/gadget/function/tcm.h                         |   13 
 drivers/usb/musb/omap2430.c                               |   25 
 drivers/usb/typec/ucsi/ucsi.c                             |   95 ++-
 drivers/usb/typec/ucsi/ucsi.h                             |    1 
 drivers/vdpa/vdpa_user/iova_domain.c                      |  163 +++--
 drivers/vdpa/vdpa_user/iova_domain.h                      |   13 
 drivers/vdpa/vdpa_user/vduse_dev.c                        |   16 
 drivers/video/fbdev/core/bitblit.c                        |  124 ++--
 drivers/video/fbdev/core/fbcon.c                          |  420 ++++++--------
 drivers/video/fbdev/core/fbcon.h                          |    6 
 drivers/video/fbdev/core/fbcon_ccw.c                      |  148 ++--
 drivers/video/fbdev/core/fbcon_cw.c                       |  148 ++--
 drivers/video/fbdev/core/fbcon_rotate.c                   |   44 -
 drivers/video/fbdev/core/fbcon_rotate.h                   |    6 
 drivers/video/fbdev/core/fbcon_ud.c                       |  164 ++---
 drivers/video/fbdev/core/softcursor.c                     |   18 
 drivers/video/fbdev/core/tileblit.c                       |   28 
 fs/9p/vfs_inode.c                                         |    9 
 fs/binfmt_elf.c                                           |    4 
 fs/binfmt_elf_fdpic.c                                     |    4 
 fs/binfmt_misc.c                                          |   14 
 fs/ceph/addr.c                                            |   20 
 fs/ceph/cache.c                                           |    2 
 fs/ceph/caps.c                                            |   70 +-
 fs/ceph/debugfs.c                                         |    4 
 fs/ceph/dir.c                                             |   24 
 fs/ceph/export.c                                          |   10 
 fs/ceph/file.c                                            |   35 -
 fs/ceph/inode.c                                           |   14 
 fs/ceph/ioctl.c                                           |    8 
 fs/ceph/mds_client.c                                      |   51 +
 fs/ceph/mds_client.h                                      |    5 
 fs/ceph/mdsmap.c                                          |    5 
 fs/ceph/snap.c                                            |   18 
 fs/ceph/super.c                                           |   22 
 fs/ceph/super.h                                           |   13 
 fs/ceph/xattr.c                                           |   12 
 fs/crypto/policy.c                                        |    2 
 fs/erofs/Kconfig                                          |   15 
 fs/erofs/decompressor_lzma.c                              |    3 
 fs/erofs/fscache.c                                        |   44 -
 fs/erofs/internal.h                                       |   87 +-
 fs/exec.c                                                 |    6 
 fs/f2fs/data.c                                            |    2 
 fs/namei.c                                                |   43 +
 fs/ntfs3/index.c                                          |   44 +
 fs/overlayfs/copy_up.c                                    |   12 
 fs/smb/server/auth.c                                      |    4 
 fs/smb/server/connection.c                                |   23 
 fs/smb/server/connection.h                                |    5 
 fs/smb/server/oplock.c                                    |    8 
 fs/smb/server/smb2pdu.c                                   |   78 +-
 fs/smb/server/smb2pdu.h                                   |    9 
 fs/smb/server/smb_common.c                                |   43 +
 fs/smb/server/smb_common.h                                |   15 
 fs/smb/server/smbacl.c                                    |   27 
 fs/super.c                                                |   19 
 fs/xfs/libxfs/xfs_sb.c                                    |    4 
 fs/xfs/xfs_dquot.c                                        |    3 
 fs/xfs/xfs_dquot_item_recover.c                           |    2 
 include/drm/drm_connector.h                               |    6 
 include/drm/drm_displayid.h                               |    2 
 include/linux/audit.h                                     |    6 
 include/linux/audit_arch.h                                |   12 
 include/linux/bootconfig.h                                |    3 
 include/linux/bpf_lsm.h                                   |    4 
 include/linux/ceph/ceph_debug.h                           |   38 +
 include/linux/ceph/mdsmap.h                               |    5 
 include/linux/firmware.h                                  |    3 
 include/linux/fs.h                                        |   33 +
 include/linux/kvm_host.h                                  |    1 
 include/linux/lsm_hooks.h                                 |    1 
 include/linux/mm.h                                        |   12 
 include/linux/mmc/sdio_ids.h                              |    2 
 include/linux/namei.h                                     |    1 
 include/linux/overflow.h                                  |   68 ++
 include/linux/pinctrl/consumer.h                          |   13 
 include/linux/sched/user.h                                |    2 
 include/linux/thunderbolt.h                               |    3 
 include/linux/vfio_pci_core.h                             |   13 
 include/net/bluetooth/hci.h                               |  114 ---
 include/net/bluetooth/hci_core.h                          |   48 -
 include/net/bluetooth/hci_sync.h                          |    4 
 include/net/gro.h                                         |    1 
 include/net/ip_vs.h                                       |    7 
 include/net/netfilter/nf_tables.h                         |   11 
 include/net/netfilter/nft_fib.h                           |    4 
 include/net/netfilter/nft_meta.h                          |    3 
 include/net/netfilter/nft_reject.h                        |    3 
 include/uapi/linux/ip_vs.h                                |    6 
 include/uapi/linux/netfilter/nf_tables.h                  |   10 
 include/uapi/linux/virtio_bt.h                            |    1 
 init/main.c                                               |   39 -
 kernel/audit.c                                            |    2 
 kernel/audit.h                                            |   32 -
 kernel/audit_fsnotify.c                                   |   39 -
 kernel/audit_tree.c                                       |    2 
 kernel/audit_watch.c                                      |   42 -
 kernel/auditfilter.c                                      |   17 
 kernel/auditsc.c                                          |    6 
 kernel/bpf/bpf_inode_storage.c                            |    9 
 kernel/fork.c                                             |   20 
 kernel/locking/spinlock_rt.c                              |   27 
 kernel/taskstats.c                                        |   67 +-
 kernel/trace/ftrace.c                                     |    6 
 kernel/trace/ring_buffer.c                                |   23 
 kernel/trace/trace_osnoise.c                              |    4 
 kernel/trace/trace_probe.c                                |    2 
 kernel/user.c                                             |    1 
 lib/bootconfig.c                                          |   65 ++
 lib/compat_audit.c                                        |   12 
 mm/huge_memory.c                                          |   43 -
 mm/internal.h                                             |    4 
 mm/madvise.c                                              |    3 
 mm/migrate_device.c                                       |   42 -
 mm/mincore.c                                              |    3 
 mm/mm_init.c                                              |  150 +++++
 mm/page_alloc.c                                           |  160 -----
 mm/pagewalk.c                                             |   10 
 mm/sparse-vmemmap.c                                       |    3 
 mm/vmalloc.c                                              |   69 ++
 net/bluetooth/hci_conn.c                                  |   24 
 net/bluetooth/hci_core.c                                  |  145 ----
 net/bluetooth/hci_event.c                                 |  150 -----
 net/bluetooth/hci_sock.c                                  |   11 
 net/bluetooth/hci_sync.c                                  |  365 +++++-------
 net/bluetooth/l2cap_core.c                                |   21 
 net/bluetooth/mgmt.c                                      |  367 ++++++------
 net/bluetooth/mgmt_util.c                                 |   47 -
 net/bluetooth/mgmt_util.h                                 |    8 
 net/bridge/netfilter/nft_reject_bridge.c                  |    3 
 net/ceph/cls_lock_client.c                                |   21 
 net/ceph/decode.c                                         |   18 
 net/ceph/osdmap.c                                         |    9 
 net/core/gro.c                                            |   31 +
 net/core/pktgen.c                                         |   43 -
 net/ipv4/netfilter/nft_dup_ipv4.c                         |    4 
 net/ipv4/tcp_bpf.c                                        |   21 
 net/ipv4/udp_offload.c                                    |   29 
 net/ipv6/ip6_tunnel.c                                     |    3 
 net/ipv6/netfilter/nft_dup_ipv6.c                         |    4 
 net/mptcp/options.c                                       |    8 
 net/mptcp/pm.c                                            |    9 
 net/mptcp/pm_netlink.c                                    |   29 
 net/mptcp/pm_userspace.c                                  |   87 +-
 net/mptcp/protocol.h                                      |    6 
 net/netfilter/ipset/ip_set_bitmap_gen.h                   |    2 
 net/netfilter/ipset/ip_set_core.c                         |   19 
 net/netfilter/ipset/ip_set_list_set.c                     |   10 
 net/netfilter/ipvs/ip_vs_conn.c                           |    4 
 net/netfilter/ipvs/ip_vs_core.c                           |    6 
 net/netfilter/ipvs/ip_vs_ctl.c                            |    4 
 net/netfilter/ipvs/ip_vs_dh.c                             |    4 
 net/netfilter/ipvs/ip_vs_lblc.c                           |    2 
 net/netfilter/ipvs/ip_vs_lblcr.c                          |    8 
 net/netfilter/nf_conntrack_proto.c                        |    6 
 net/netfilter/nf_conntrack_proto_sctp.c                   |   48 -
 net/netfilter/nf_conntrack_proto_tcp.c                    |  132 ++--
 net/netfilter/nf_conntrack_sip.c                          |   10 
 net/netfilter/nf_flow_table_core.c                        |    7 
 net/netfilter/nf_tables_api.c                             |    6 
 net/netfilter/nf_tables_offload.c                         |    2 
 net/netfilter/nft_bitwise.c                               |   38 -
 net/netfilter/nft_byteorder.c                             |    2 
 net/netfilter/nft_cmp.c                                   |    6 
 net/netfilter/nft_compat.c                                |    6 
 net/netfilter/nft_ct.c                                    |    2 
 net/netfilter/nft_dup_netdev.c                            |    2 
 net/netfilter/nft_dynset.c                                |    4 
 net/netfilter/nft_exthdr.c                                |    2 
 net/netfilter/nft_fib.c                                   |    3 
 net/netfilter/nft_flow_offload.c                          |    3 
 net/netfilter/nft_fwd_netdev.c                            |    9 
 net/netfilter/nft_hash.c                                  |    2 
 net/netfilter/nft_immediate.c                             |    3 
 net/netfilter/nft_lookup.c                                |    5 
 net/netfilter/nft_masq.c                                  |    7 
 net/netfilter/nft_meta.c                                  |    8 
 net/netfilter/nft_nat.c                                   |   11 
 net/netfilter/nft_objref.c                                |   41 +
 net/netfilter/nft_osf.c                                   |    3 
 net/netfilter/nft_payload.c                               |    2 
 net/netfilter/nft_queue.c                                 |    5 
 net/netfilter/nft_range.c                                 |    2 
 net/netfilter/nft_redir.c                                 |    7 
 net/netfilter/nft_reject.c                                |    3 
 net/netfilter/nft_reject_inet.c                           |    3 
 net/netfilter/nft_reject_netdev.c                         |    3 
 net/netfilter/nft_rt.c                                    |    3 
 net/netfilter/nft_set_pipapo.c                            |  253 +++++---
 net/netfilter/nft_set_pipapo.h                            |    8 
 net/netfilter/nft_socket.c                                |    3 
 net/netfilter/nft_synproxy.c                              |    3 
 net/netfilter/nft_tproxy.c                                |    7 
 net/netfilter/nft_xfrm.c                                  |    3 
 net/openvswitch/conntrack.c                               |   39 -
 net/packet/af_packet.c                                    |    7 
 net/rxrpc/call_accept.c                                   |   27 
 net/sched/act_ct.c                                        |   41 +
 net/sched/cls_u32.c                                       |    3 
 net/sched/sch_api.c                                       |   24 
 net/sched/sch_cake.c                                      |    2 
 net/sched/sch_taprio.c                                    |   12 
 net/sctp/protocol.c                                       |   20 
 net/sctp/sysctl.c                                         |    9 
 net/smc/smc_tx.c                                          |    6 
 net/tipc/socket.c                                         |    6 
 net/tls/tls_device.c                                      |    4 
 net/tls/tls_sw.c                                          |    5 
 net/x25/af_x25.c                                          |    4 
 net/x25/x25_timer.c                                       |   25 
 net/xfrm/espintcp.c                                       |   42 -
 security/apparmor/include/net.h                           |    6 
 security/apparmor/lsm.c                                   |   38 -
 security/apparmor/net.c                                   |    2 
 security/bpf/hooks.c                                      |    3 
 security/security.c                                       |   47 +
 security/selinux/hooks.c                                  |   95 +--
 security/selinux/include/objsec.h                         |    5 
 security/selinux/netlabel.c                               |   23 
 security/selinux/ss/policydb.c                            |   31 +
 security/selinux/ss/services.c                            |    4 
 security/smack/smack.h                                    |    5 
 security/smack/smack_lsm.c                                |   70 +-
 security/smack/smack_netfilter.c                          |    4 
 sound/hda/hdac_regmap.c                                   |    4 
 sound/pci/hda/patch_conexant.c                            |    3 
 sound/pci/hda/patch_hdmi.c                                |   48 +
 sound/soc/codecs/cs35l41-lib.c                            |    2 
 sound/soc/codecs/cs4265.c                                 |    4 
 sound/soc/codecs/lpass-wsa-macro.c                        |    8 
 sound/soc/fsl/fsl_sai.c                                   |   29 
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c                |   12 
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c                |  118 +--
 sound/soc/sof/ipc3-control.c                              |   34 -
 sound/soc/xilinx/xlnx_formatter_pcm.c                     |   10 
 tools/testing/selftests/net/mptcp/mptcp_join.sh           |    4 
 virt/kvm/kvm_main.c                                       |    3 
 424 files changed, 5759 insertions(+), 4185 deletions(-)

Aldo Ariel Panzardo (1):
      net/sched: serialize qdisc_rtab_list against concurrent get/put

Alex Williamson (1):
      vfio/pci: Fix racy bitfields and tighten struct layout

Alexander Usyskin (1):
      mei: bus: access mei_device under device_lock on cleanup

Alexandre Ghiti (1):
      riscv: Don't use PGD entries for the linear mapping

Alexey Velichayshiy (1):
      netfilter: nf_tables_offload: suppress WARN_ON_ONCE for ENOMEM in abort path

Ali Ahmet Memis (1):
      openrisc: signal: do not restore privileged SR bits on sigreturn

Amir Goldstein (2):
      fsnotify: opt-in for permission events at file open time
      fs: don't block write during exec on pre-content watched files

Andrei Kuchynski (2):
      usb: typec: ucsi: Fix race condition and ordering in port unregistration
      usb: typec: ucsi: Correct teardown ordering in ucsi_init() error path

Andy Shevchenko (1):
      libceph: Amend checking to fix `make W=1` build breakage

Aneesh Kumar K.V (1):
      mm/vmemmap/devdax: fix kernel crash when probing devdax devices

AngeloGioacchino Del Regno (3):
      ASoC: mediatek: mt8192-afe-pcm: Convert to devm_pm_runtime_enable()
      ASoC: mediatek: mt8192-afe-pcm: Simplify with dev_err_probe()
      ASoC: mediatek: Use common mtk_afe_pcm_platform with common probe cb

Bartosz Golaszewski (1):
      treewide: rename pinctrl_gpio_direction_input_new()

Baul Lee (1):
      net/x25: fix use-after-free of the socket by its timers

Biju Das (1):
      can: rcar_canfd: Use devm_clk_get_optional() for RAM clk

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
      ata: libata-core: Reject an invalid concurrent positioning ranges count

Candice Li (1):
      drm/amdgpu: validate GEM_CREATE domain combinations

Casey Schaufler (1):
      lsm: infrastructure management of the sock security

Cen Zhang (1):
      usb: gadget: f_tcm: synchronize delayed set_alt with teardown

Chancel Liu (1):
      ASoC: fsl_sai: Fix spurious BCLK on resume by clearing BYP

Chao Shi (1):
      block: stop the timeout timer when releasing a never added disk

Chao Yu (1):
      f2fs: fix UAF issue in f2fs_merge_page_bio()

ChenXiaoSong (3):
      smb/server: rename include guard in smb_common.h
      smb/server: fix minimum SMB1 PDU size
      smb/server: fix minimum SMB2 PDU size

Chengfeng Ye (2):
      Bluetooth: hci_sync: Fix advertising data UAFs
      net: pktgen: fix proc entry use-after-free

Christian Brauner (3):
      super: fix emergency thaw deadlock on frozen block devices
      binfmt_misc: restore write access when removing an entry
      binfmt_misc: use exe_file_deny_write_access() for the interpreter clone

Christoph Hellwig (1):
      xfs: check v5 superblock features early

Christophe JAILLET (1):
      Bluetooth: Remove usage of the deprecated ida_simple_xx() API

Chuck Lever (1):
      net/tls: Fail tls_sw_splice_read() after a failed async decrypt

Crystal Wood (1):
      tracing/osnoise: Call synchronize_rcu() when unregistering

Cássio Gabriel (2):
      ASoC: mediatek: mt8183: Check runtime resume during probe
      ASoC: mediatek: mt8192: Check runtime resume during probe

Daniel Hodges (1):
      wifi: ath6kl: fix use-after-free in aggr_reset_state()

David Carlier (1):
      igc: remove napi_synchronize() in igc_down()

David Hildenbrand (1):
      mm/migrate_device: page_remove_rmap() -> folio_remove_rmap_pte()

David Howells (4):
      tcp_bpf: Inline do_tcp_sendpages as it's now a wrapper around tcp_sendmsg
      espintcp: Inline do_tcp_sendpages()
      siw: Inline do_tcp_sendpages()
      tcp_bpf, smc, tls, espintcp, siw: Reduce MSG_SENDPAGE_NOTLAST usage

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

Dawid Wróbel (1):
      ASoC: codecs: lpass-wsa-macro: Fix enum kcontrol accesses

Dexuan Cui (1):
      net: mana: Validate the packet length reported by the NIC

Diogo Ivo (1):
      usb: typec: ucsi: Only enable supported notifications

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

Dr. David Alan Gilbert (1):
      Bluetooth: MGMT: Remove unused mgmt_pending_find_data

Edward Adam Davis (1):
      Bluetooth: hci_sock: Prevent race in socket write iter and sock bind

Eric Dumazet (3):
      ipvlan: inherit needed_headroom and needed_tailroom from phy_dev
      macvlan: inherit needed_headroom and needed_tailroom from lowerdev
      af_packet: Don't send zero-byte data in tpacket_snd().

Eric Farman (2):
      s390/vfio_ccw: Ensure index for read/write regions are within range
      s390/vfio_ccw: Fix out of bounds check on CCW array

Eugenio Pérez (2):
      vduse: remove unused vaddr parameter of vduse_domain_free_coherent
      vduse: take out allocations from vduse_dev_alloc_coherent

Fan Wu (1):
      wifi: brcmfmac: drain bus_reset work on device removal

Farhan Ali (3):
      KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
      KVM: s390: pci: Fix missing error codes and memory unaccounting
      KVM: s390: pci: Fix resource leak on IRQ registration failure

Felix Fietkau (1):
      net: move skb_gro_receive_list from udp to core

Fernando Fernandez Mancera (1):
      netfilter: nft_objref: validate objref and objrefmap expressions

Ferry Meng (1):
      ksmbd: fix SID memory leak in set_posix_acl_entries_dacl() on overflow

Florian Fuchs (1):
      mtd: maps: vmu-flash: fix fault in unaligned fixup

Florian Westphal (14):
      netfilter: nft_set_pipapo: use GFP_KERNEL for insertions
      netfilter: nft_set_pipapo: move prove_locking helper around
      netfilter: nft_set_pipapo: make pipapo_clone helper return NULL
      netfilter: nft_set_pipapo: prepare walk function for on-demand clone
      netfilter: nft_set_pipapo: merge deactivate helper into caller
      netfilter: nft_set_pipapo: prepare pipapo_get helper for on-demand clone
      netfilter: nft_set_pipapo: move cloning of match info to insert/removal path
      netfilter: nft_set_pipapo: don't leak bad clone into future transaction
      netfilter: nf_conntrack_sip: remove net variable shadowing
      netfilter: nf_tables: pass context structure to nft_parse_register_load
      netfilter: nf_tables: drop unused 3rd argument from validate callback ops
      netfilter: conntrack: sctp: use nf log infrastructure for invalid packets
      netfilter: ipset: fix list type element drift bug
      netfilter: ipset: let destroy callbacks adjust ext mem size

Gang Yan (1):
      selftests: mptcp: join: mark tests with data corruption as failed

Gao Xiang (2):
      erofs: tidy up internal.h
      erofs: fix EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS on some UP platforms

Geert Uytterhoeven (2):
      can: rcar_canfd: Invert reset assert order
      can: rcar_canfd: Extract rcar_canfd_global_{,de}init()

Geliang Tang (4):
      mptcp: pm: avoid code duplication to lookup endp
      mptcp: add mptcp_userspace_pm_lookup_addr helper
      mptcp: pm: use addr entry for get_local_id
      mptcp: pm: userspace: fix use-after-free in get_local_id

George Wilson (2):
      powerpc/pseries: pci - logic bug
      powerpc/pseries: lparcfg - fix kbuf[] underflow

Gokul Sivakumar (1):
      wifi: brcmfmac: fix 43752 SDIO FWVID incorrectly labelled as Cypress (CYW)

Greg Kroah-Hartman (1):
      Linux 6.1.184

Gregory Price (1):
      mm/vmstat: fold stranded per-cpu node stats when a node comes online

Guangshuo Li (3):
      drm/radeon: fix autosuspend cleanup during teardown
      mmc: vub300: fix use-after-free on probe failure
      usb: musb: omap2430: Do not put borrowed of_node in probe

Gustavo A. R. Silva (1):
      Bluetooth: hci_conn, hci_sync: Use __counted_by() to avoid -Wfamnae warnings

Haibo Chen (1):
      mmc: sdhci: make tuning_err a signed int

Haofeng Li (1):
      ksmbd: validate num_subauth when copying ACE in set_ntacl_dacl

Haoxiang Li (2):
      i2c: davinci: Unregister cpufreq notifier on probe failure
      net: ipa: fix SMEM state handle leaks in SMP2P init

Heinz Mauelshagen (4):
      dm: fix trailing statements
      dm crypt: correct 'foo*' to 'foo *'
      dm: add missing empty lines
      dm: remove unnecessary braces from single statement blocks

Herbert Xu (1):
      crypto: ccm - Set rfc4309 maxauthsize from child

Hidayath Khan (1):
      s390/qeth: validate user buffer length in SNMP and ARP query ioctls

Hugo Villeneuve (1):
      serial: max310x: replace bare use of 'unsigned' with 'unsigned int' (checkpatch)

Hyunjung Ko (1):
      net/sched: act_ct: fix sk_buff leak when the header checks reject a packet

Jai Luthra (1):
      media: i2c: imx219: Rename VTS to FRM_LENGTH

Jani Nikula (4):
      drm/displayid: fix Tiled Display Topology ID size
      drm/i915/vrr: require valid min/max vfreq for VRR
      drm/i915/hdcp: require monotonically increasing seq_num_v
      drm/i915/hdcp: check streams[] bounds before overflow

Jann Horn (1):
      bpf,fork: wipe ->bpf_storage before bailouts that access it

Jason Gunthorpe (2):
      kernel/user: Allow user_struct::locked_vm to be usable for iommufd
      udmabuf: Do not create malformed scatterlists

Jason Wang (1):
      VDUSE: avoid leaking information to userspace

Jeff Layton (1):
      audit: widen ino fields to u64

Jeremy Sowden (1):
      netfilter: bitwise: rename some boolean operation functions

Jiacheng Yu (1):
      fbcon: Use correct type for vc_resize() return value

Jingbo Xu (1):
      erofs: maintain cookies of share domain in self-contained list

Johan Hovold (3):
      mmc: vub300: fix use-after-free on disconnect
      mmc: vub300: rename probe error labels
      usb: musb: omap2430: clean up probe error handling

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

Kai Vehmanen (1):
      ALSA: hda: codecs: hdmi: disable keep-alive before audio format change

Kees Cook (1):
      overflow: Change DEFINE_FLEX to take __counted_by member

Kefeng Wang (1):
      mm: migrate_device: fix pte_pfn/pte_dirty called on non-present PTE

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

Linmao Li (1):
      Input: psxpad-spi - set driver data before use

Long Li (2):
      xfs: fix ilock leak on error in xfs_dq_get_next_id
      xfs: don't swallow dquot recovery verification errors

Lorenzo Stoakes (ARM) (2):
      mm/vmalloc: acquire init_mm lock on huge vmap to avoid ptdump UAF
      mm/huge_memory: fix huge_zero_pfn race

Luiz Augusto von Dentz (6):
      Bluetooth: HCI: Remove HCI_AMP support
      Bluetooth: hci_sync: Introduce hci_cmd_sync_run/hci_cmd_sync_run_once
      Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT
      Bluetooth: MGMT: Protect mgmt_pending list with its own lock
      Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1
      Bluetooth: hci_sync: Fix not using correct handle

Maoyi Xie (3):
      net: thunderbolt: Fix frags[] overflow by bounding frame_count
      wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()
      net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink

Marc Kleine-Budde (1):
      can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on skb allocation failure

Matt Bobrowski (1):
      bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF LSM is uninitialized

Matt Fleming (1):
      veth: convert frag_list skbs before running XDP

Matthew Rosato (1):
      KVM: s390: pci: Fix aisb calculation

Matthieu Baerts (NGI0) (1):
      mptcp: options: reset DSS fields in case of unexpected size

Max Kellermann (2):
      ceph: avoid fs reclaim while using current->journal_info
      ceph: fix hanging __ceph_get_caps() with stale mds_wanted

Michael Bommarito (3):
      ntfs3: validate split-point offset in indx_insert_into_buffer
      thunderbolt: Prevent XDomain delayed work use-after-free on disconnect
      erofs: cap LZMA stream pool size

Mike Rapoport (IBM) (1):
      mm: move most of core MM initialization to mm/mm_init.c

Mikhail Gavrilov (1):
      dma-buf/udmabuf: skip redundant cpu sync to fix cacheline EEXIST warning

Mikulas Patocka (3):
      dm-verity: avoid double increment of &use_bh_wq_enabled
      dm-integrity: don't increment hash_offset twice
      dm-verity: make error counter atomic

Muchun Song (1):
      mm/mm_init: fix uninitialized struct pages for ZONE_DEVICE

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

Oleg Nesterov (1):
      taskstats: fill_stats_for_tgid: use for_each_thread()

Pablo Neira Ayuso (1):
      netfilter: nf_conntrack_sip: validate skb_dst() before accessing it

Palmer Dabbelt (1):
      RISC-V: Provide pgtable_l5_enabled on rv32

Paolo Bonzini (1):
      KVM: SVM: Serialize accesses to the owner and mirror list with separate lock

Pauli Virtanen (2):
      Bluetooth: hci_sync: call destroy in hci_cmd_sync_run if immediate
      Bluetooth: mgmt: fix locking in unpair_device/disconnect_sync

Pavitra Jha (2):
      libceph: fix multiple unsafe decodes in decode_locker()
      libceph: fix two unsafe bare decodes in decode_lockers()

Pedro Falcato (2):
      mm: do file ownership checks with the proper mount idmap
      RDMA/siw: Fix the sendmsg byte count in siw_tcp_sendpages

Peng Fan (1):
      pmdomain: imx: Fix i.MX8MP power notifier

Pengpeng Hou (1):
      Input: iforce - validate input packet lengths

Peter Seiderer (1):
      net: pktgen: fix code style (WARNING: Block comments)

Peter Ujfalusi (3):
      ASoC: cs4265: sort the register default table
      ASoC: cs35l41: sort the register default table
      ASoC: SOF: ipc3-control: Fix heap overflow in bytes_ext put/get

Petr Machata (1):
      mlxsw: spectrum: On port enslavement to a LAG, join upper's bridges

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: move debug_vm handling to amdgpu_cs_parser_fini

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

Sakari Ailus (1):
      media: imx219: Fix maximum frame length in lines

Sebastian Alba Vives (1):
      fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()

Sergey Senozhatsky (1):
      usb: typec: ucsi: split connector lock classes

Sergio Paracuellos (1):
      gpio: mt7621: avoid corruption of shared interrupt trigger state

Sheng Zhao (1):
      vduse: Use fixed 4KB bounce pages for non-4KB page size

Shiming Cheng (1):
      net: gro: fix double aggregation of flush-marked skbs

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw-nuss: Fix port_id extraction from SRC TAG

Souvik Banerjee (1):
      ovl: use linked upper dentry in copy-up tmpfile

Stanislav Fomichev (1):
      veth: Introduce veth_xdp_buff wrapper for xdp_buff

Stefan Eichenberger (1):
      i2c: imx: separate atomic, dma and non-dma use case

Steven Rostedt (1):
      ring-buffer: Remove jump to out label in ring_buffer_swap_cpu()

Subbaraya Sundeep (1):
      octeontx2: Annotate mmio regions as __iomem

Sumanth Korikkar (1):
      s390/perf_cpum_cf: Add missing array_index_nospec() to __hw_perf_event_init()

Sun Jian (1):
      veth: fix skb length accounting after XDP frag adjustment

Suraj Kandpal (1):
      drm/i915/hdcp: Move to using intel_display in intel_hdcp

Tang Bin (1):
      ASoC: mediatek: mt8192-afe-pcm: Simplify probe() with local dev variable

Tapio Reijonen (1):
      serial: max310x: implement gpio_chip::get_direction()

Tengda Wu (1):
      ring-buffer: Use current_context for safe per-CPU buffer swap

Thomas Gleixner (1):
      locking/rt: Fix the incorrect RCU protection in rt_spin_unlock()

Thomas Richter (4):
      s390/cpum_cf: move cpum_cf_ctrset_size()
      s390/cpum_cf: move stccm_avail()
      s390/cpum_cf: remove in-kernel counting facility interface
      s390/cpum_cf: merge source files for CPU Measurement counter facility

Thomas Zimmermann (2):
      fbcon: Rename struct fbcon_ops to struct fbcon_par
      drm/tegra: fbdev: Remove offset into framebuffer memory

Thorsten Blum (1):
      crypto: qce - fix error path in devm_qce_register_algs

Théo Lebrun (1):
      net: macb: drop in-flight Tx SKBs on close

Timur Kristóf (1):
      drm/amdgpu: Respect placement requirements in amdgpu_gtt_mgr functions

Tristan Madani (1):
      selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()

Tu Nguyen (1):
      can: rcar_canfd: change the initializing flow for clocks and resets

Uladzislau Rezki (Sony) (1):
      tracing: Rename kvfree_rcu() to kvfree_rcu_mightsleep()

Venkatesh Srinivas (1):
      KVM: x86: Only reset TSC Deadline Timer in apic_timer_expired on KVM_RUN

Ville Syrjälä (1):
      drm/i915/vrr: Check HAS_VRR() first in intel_vrr_is_capable()

Vincent Jardin (1):
      i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)

Vitor Soares (1):
      drm/bridge: cdns-dsi: Replace deprecated UNIVERSAL_DEV_PM_OPS()

Vladimir Oltean (1):
      net/sched: taprio: avoid calling child->ops->dequeue(child) twice

Wasim Nazir (1):
      remoteproc: qcom: Fix leak when custom dump_segments addition fails

Wei Fang (1):
      net: packet: fix wrong transport_header when sending VLAN-tagged frame

Weinan Liu (1):
      iommu/amd: Don't split flush for amd_iommu_domain_flush_all()

Wentao Guan (1):
      ksmbd: restore DACL size on check_add_overflow() to avoid malformed ACL

Wentao Liang (2):
      mlxsw: fix refcount leak in mlxsw_sp_port_lag_join()
      ipmi: fix refcount leak in i_ipmi_request()

Wolfram Sang (1):
      i2c: bcm-iproc: remove printout on handled timeouts

Xiang Mei (2):
      net: bonding: fix use-after-free in bond_xmit_broadcast()
      libceph: bound pg_{temp,upmap,upmap_items} length to CEPH_PG_MAX_SIZE

Xiang Mei (Microsoft) (1):
      netfilter: ipset: fix refcount race between list:set GC and swap

Xin Long (3):
      openvswitch: use skb_ip_totlen in conntrack
      net: sched: use skb_ip_totlen and iph_totlen
      openvswitch: move key and ovs_cb update out of handle_fragments

Xiubo Li (3):
      libceph: add doutc and *_client debug macros support
      ceph: pass the mdsc to several helpers
      ceph: rename _to_client() to _to_fs_client()

Xu Rao (1):
      ALSA: hda: Fix cached processing coefficient verbs

Yang Wang (2):
      drm/amd/pm: fix torn gpu metrics reads
      drm/amd/pm: fix pptable use-after-free

Yiming Zhu (1):
      ceph: fix MDS random selection readiness predicate

Yiyang Chen (1):
      taskstats: retain dead thread stats in TGID queries

Yizhou Zhao (1):
      ipvs: separate destination availability state

Yogesh Lal (1):
      remoteproc: qcom: pas: Adjust the phys addr wrt the mem region

Yue Haibing (1):
      netfilter: nf_tables: Remove unused nft_reduce_is_readonly()

Zhan Xusheng (2):
      fscrypt: use the mount idmap for the owner check in fscrypt_ioctl_set_policy()
      mmc: omap_hsmmc: fix busy_timeout overflow in ns conversion on 32-bit

Zhang Changzhong (1):
      net/sched: cls_u32: skip hash tables in u32_bind_class()

Zhang Heng (1):
      ALSA: hda: conexant: Remove mic bias threshold override

Zhefu Zhang (1):
      Input: atkbd - skip deactivate for Xiaomi Book Pro 14's internal keyboard

Zhiling Zou (1):
      sctp: avoid auth_enable sysctl UAF during netns teardown

Zihan Xi (4):
      net/sched: act_ct: preserve tc_skb_cb across defragmentation
      Bluetooth: mgmt: fix UAF in pair command cancellation
      netfilter: nf_conntrack: defer invalid log until after unlock
      Bluetooth: mgmt: fix pending command UAF in EIR updates

