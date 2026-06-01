Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B42C2DB78C;
	Mon,  1 Jun 2026 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330046; cv=none; b=IZ+n2wC/l9X+wlDO8XfAxseClwDXGYq72kZwJI2RRW9HzZJCdGGifnlLaV7AbjnWJCghEMhJB79fQMd3rEllUrEepHoAM7/bu7+oKWX9NTj+wlqWLoh7/JAVnYTH9ab/0LA7lXtYbCiO3WZKXdgQo2Cf/AXwhwAdatwLl/U1GWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330046; c=relaxed/simple;
	bh=EuCSCSffVaiCINzTn9Mlmt+0MGml6cHIb8zye/7Y3fU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VqWkmNBXQ0AWbLc+xlErlzSdqRVK83MBLPPSahbbZ+DZPoA9uriMEzO6PEgysQwO3SpAEGKWwkhUDtwc79aoHzbElQ12JyVHkomkuRL+rmwEErZemwa6FfkbR3luE9Le6V2tGME3c26/d5YyrRHJJsunZsD+PQV4WU1aJeXYg5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DTpCXjFj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DTpCXjFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C811F00893;
	Mon,  1 Jun 2026 16:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780330041;
	bh=kuc4FZ4yqmAZvPjF0/5KDog373Oayoi/C5UT2LCQrWA=;
	h=From:To:Cc:Subject:Date;
	b=DTpCXjFjEgjvB6Gz7YsLThBaP0uvhymyorvU7hC6i8KYtO+8P+8U5Ob6Sv1qmisG9
	 aBiaFHrp+Bj7DteTeBRSrHXvXmBA2Rugr0sSaYbrwt1o20nKd63I83HXROAms8ir2B
	 bEMPdFsrkfRn7TC6i4d57H/qewqM7uB5PGErt4vI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.34
Date: Mon,  1 Jun 2026 18:05:56 +0200
Message-ID: <2026060156-silica-winking-0dae@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.34 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/pm/intel_pstate.rst                  |   11 
 Documentation/crypto/krb5.rst                                  |   17 
 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml |   38 +
 Documentation/gpu/drm-kms-helpers.rst                          |   12 
 Makefile                                                       |    2 
 arch/alpha/include/asm/Kbuild                                  |    1 
 arch/arc/include/asm/Kbuild                                    |    1 
 arch/arm/boot/dts/renesas/r7s72100-genmai.dts                  |    3 
 arch/arm/boot/dts/renesas/r7s72100-rskrza1.dts                 |    2 
 arch/arm/include/asm/Kbuild                                    |    1 
 arch/arm/mach-versatile/integrator_cp.c                        |   13 
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi                      |    9 
 arch/arm64/include/asm/insn.h                                  |    2 
 arch/arm64/include/asm/page.h                                  |    2 
 arch/arm64/include/asm/ring_buffer.h                           |   10 
 arch/arm64/kvm/arm.c                                           |    4 
 arch/arm64/kvm/vgic/vgic-its.c                                 |    4 
 arch/arm64/mm/fault.c                                          |   11 
 arch/csky/include/asm/Kbuild                                   |    1 
 arch/hexagon/include/asm/Kbuild                                |    1 
 arch/loongarch/include/asm/Kbuild                              |    1 
 arch/loongarch/kernel/kprobes.c                                |   14 
 arch/loongarch/mm/init.c                                       |    4 
 arch/m68k/include/asm/Kbuild                                   |    1 
 arch/microblaze/include/asm/Kbuild                             |    1 
 arch/mips/include/asm/Kbuild                                   |    1 
 arch/nios2/include/asm/Kbuild                                  |    1 
 arch/openrisc/include/asm/Kbuild                               |    1 
 arch/parisc/include/asm/Kbuild                                 |    1 
 arch/powerpc/Kconfig.debug                                     |    3 
 arch/powerpc/include/asm/Kbuild                                |    1 
 arch/powerpc/kernel/time.c                                     |    6 
 arch/powerpc/platforms/82xx/km82xx.c                           |    4 
 arch/riscv/errata/mips/errata.c                                |    2 
 arch/riscv/include/asm/Kbuild                                  |    1 
 arch/riscv/kvm/vcpu_pmu.c                                      |   12 
 arch/riscv/mm/init.c                                           |   25 
 arch/s390/include/asm/Kbuild                                   |    1 
 arch/sh/include/asm/Kbuild                                     |    1 
 arch/sparc/include/asm/Kbuild                                  |    1 
 arch/um/include/asm/Kbuild                                     |    1 
 arch/x86/include/asm/Kbuild                                    |    1 
 arch/x86/kernel/cpu/mce/core.c                                 |   33 -
 arch/x86/kvm/svm/avic.c                                        |   12 
 arch/x86/xen/setup.c                                           |    2 
 arch/xtensa/include/asm/Kbuild                                 |    1 
 block/bio-integrity.c                                          |   19 
 block/blk-cgroup.c                                             |    2 
 block/blk-mq.c                                                 |   19 
 crypto/krb5/krb5_api.c                                         |   54 +-
 drivers/accel/qaic/qaic_data.c                                 |   23 
 drivers/ata/libata-core.c                                      |    9 
 drivers/ata/libata-eh.c                                        |    8 
 drivers/ata/libata-pmp.c                                       |   18 
 drivers/ata/libata-scsi.c                                      |  100 ++-
 drivers/ata/sata_sil24.c                                       |    6 
 drivers/base/memory.c                                          |    8 
 drivers/block/rbd.c                                            |   20 
 drivers/block/ublk_drv.c                                       |    3 
 drivers/bluetooth/btintel_pcie.c                               |   20 
 drivers/bluetooth/btintel_pcie.h                               |    3 
 drivers/bluetooth/btmtk.c                                      |    2 
 drivers/bluetooth/hci_ldisc.c                                  |   48 +
 drivers/cxl/core/mbox.c                                        |   11 
 drivers/firmware/arm_ffa/bus.c                                 |    4 
 drivers/firmware/arm_ffa/driver.c                              |  131 +++-
 drivers/firmware/efi/efi.c                                     |   28 -
 drivers/fwctl/pds/main.c                                       |    3 
 drivers/gpio/Kconfig                                           |    1 
 drivers/gpio/gpio-aggregator.c                                 |   47 +
 drivers/gpio/gpiolib-cdev.c                                    |   13 
 drivers/gpu/drm/Makefile                                       |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c                        |    7 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c             |    9 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c       |    9 
 drivers/gpu/drm/amd/display/dc/core/dc.c                       |    6 
 drivers/gpu/drm/bridge/chipone-icn6211.c                       |    4 
 drivers/gpu/drm/bridge/ite-it66121.c                           |    5 
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c       |   16 
 drivers/gpu/drm/drm_atomic_helper.c                            |    2 
 drivers/gpu/drm/drm_vblank.c                                   |  172 ++++++
 drivers/gpu/drm/drm_vblank_helper.c                            |  176 ++++++
 drivers/gpu/drm/i915/display/intel_dp.c                        |    2 
 drivers/gpu/drm/mediatek/mtk_cec.c                             |    2 
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c                        |    2 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                        |    6 
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c                  |    3 
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c              |   24 
 drivers/gpu/drm/msm/dsi/dsi_host.c                             |    1 
 drivers/gpu/drm/msm/msm_gem_shrinker.c                         |   40 -
 drivers/gpu/drm/msm/msm_iommu.c                                |    5 
 drivers/gpu/drm/v3d/v3d_sched.c                                |   16 
 drivers/gpu/drm/v3d/v3d_submit.c                               |   22 
 drivers/gpu/drm/virtio/virtgpu_drv.h                           |    1 
 drivers/gpu/drm/virtio/virtgpu_gem.c                           |   17 
 drivers/gpu/drm/virtio/virtgpu_plane.c                         |   10 
 drivers/gpu/drm/vkms/vkms_crtc.c                               |   83 ---
 drivers/gpu/drm/vkms/vkms_drv.h                                |    2 
 drivers/gpu/drm/xe/display/xe_hdcp_gsc.c                       |   12 
 drivers/gpu/drm/xe/xe_gsc.c                                    |    5 
 drivers/gpu/drm/xe/xe_gt_sriov_pf_monitor.c                    |    6 
 drivers/gpu/drm/xe/xe_gt_sriov_pf_monitor.h                    |    2 
 drivers/gpu/drm/xe/xe_gt_sriov_vf.c                            |   24 
 drivers/gpu/drm/xe/xe_gt_sriov_vf.h                            |    6 
 drivers/gpu/drm/xe/xe_oa.c                                     |    6 
 drivers/hid/hid-quirks.c                                       |    2 
 drivers/hid/hid-uclogic-core.c                                 |    4 
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c   |    4 
 drivers/hwmon/lm90.c                                           |   26 
 drivers/hwmon/pmbus/adm1266.c                                  |   32 -
 drivers/infiniband/hw/mana/main.c                              |    1 
 drivers/infiniband/sw/siw/siw_qp_rx.c                          |   15 
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c                   |    2 
 drivers/iommu/amd/debugfs.c                                    |   43 -
 drivers/irqchip/irq-ath79-cpu.c                                |    7 
 drivers/mfd/bcm2835-pm.c                                       |    1 
 drivers/net/dsa/mt7530.c                                       |   47 +
 drivers/net/ethernet/airoha/airoha_eth.c                       |   10 
 drivers/net/ethernet/amd/pds_core/debugfs.c                    |    7 
 drivers/net/ethernet/amd/pds_core/dev.c                        |   11 
 drivers/net/ethernet/amd/pds_core/devlink.c                    |    6 
 drivers/net/ethernet/atheros/ag71xx.c                          |    3 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                 |    9 
 drivers/net/ethernet/cirrus/cs89x0.c                           |    2 
 drivers/net/ethernet/cortina/gemini.c                          |   21 
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c                   |    4 
 drivers/net/ethernet/intel/ice/ice_main.c                      |   10 
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c                    |   33 -
 drivers/net/ethernet/intel/ice/ice_txrx.c                      |    7 
 drivers/net/ethernet/intel/ice/virt/queues.c                   |    2 
 drivers/net/ethernet/intel/idpf/idpf_ptp.c                     |    4 
 drivers/net/ethernet/intel/igc/igc_tsn.c                       |    9 
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c              |    1 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                |    7 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c            |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c               |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c       |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c       |    7 
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c         |    3 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c          |    8 
 drivers/net/ethernet/microsoft/mana/hw_channel.c               |   29 -
 drivers/net/ethernet/qlogic/qed/qed_cxt.c                      |    2 
 drivers/net/ethernet/ti/icssm/icssm_prueth.c                   |    1 
 drivers/net/ifb.c                                              |   11 
 drivers/net/ovpn/io.c                                          |   12 
 drivers/net/ovpn/main.c                                        |   12 
 drivers/net/ovpn/netlink.c                                     |    8 
 drivers/net/ovpn/peer.c                                        |   23 
 drivers/net/ovpn/peer.h                                        |    1 
 drivers/net/ovpn/stats.h                                       |   16 
 drivers/net/ovpn/tcp.c                                         |   19 
 drivers/net/ovpn/udp.c                                         |    2 
 drivers/net/phy/dp83tc811.c                                    |    1 
 drivers/net/phy/phy-c45.c                                      |    8 
 drivers/net/phy/phy_device.c                                   |    6 
 drivers/net/pse-pd/pse_core.c                                  |    2 
 drivers/net/tap.c                                              |    2 
 drivers/net/wireless/ath/ath10k/wmi.c                          |   15 
 drivers/net/wireless/ath/ath11k/dp_rx.c                        |    3 
 drivers/net/wireless/ath/ath11k/hal.c                          |   14 
 drivers/net/wireless/ath/ath11k/hal_rx.c                       |    5 
 drivers/net/wireless/ath/ath11k/testmode.c                     |    1 
 drivers/net/wireless/ath/ath11k/wmi.c                          |   19 
 drivers/net/wireless/intel/iwlwifi/mld/link.c                  |   13 
 drivers/net/wireless/intel/iwlwifi/mld/tx.c                    |   15 
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c              |   27 -
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c                 |   14 
 drivers/net/wireless/microchip/wilc1000/wlan.c                 |    2 
 drivers/net/wwan/iosm/iosm_ipc_imem.c                          |    2 
 drivers/nvme/host/ioctl.c                                      |    5 
 drivers/nvme/host/pci.c                                        |    6 
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c                     |    5 
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c                        |    1 
 drivers/phy/samsung/phy-exynos5-usbdrd.c                       |    7 
 drivers/phy/tegra/xusb-tegra186.c                              |   33 -
 drivers/phy/tegra/xusb.h                                       |    1 
 drivers/pinctrl/meson/pinctrl-amlogic-a4.c                     |    6 
 drivers/pinctrl/qcom/pinctrl-ipq4019.c                         |    2 
 drivers/pinctrl/qcom/pinctrl-msm.h                             |    5 
 drivers/pinctrl/qcom/pinctrl-qcs615.c                          |    6 
 drivers/pinctrl/qcom/pinctrl-sm8150.c                          |    8 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                        |   23 
 drivers/platform/surface/surface_aggregator_registry.c         |    2 
 drivers/platform/x86/adv_swbutton.c                            |    6 
 drivers/platform/x86/hp/hp_accel.c                             |    3 
 drivers/platform/x86/intel/hid.c                               |    6 
 drivers/platform/x86/intel/vbtn.c                              |    6 
 drivers/regulator/tps65219-regulator.c                         |  135 +++--
 drivers/scsi/isci/host.c                                       |    3 
 drivers/scsi/sd.c                                              |    3 
 drivers/spi/spi-amd.c                                          |    2 
 drivers/spi/spi-dw-dma.c                                       |    2 
 drivers/spi/spi-ep93xx.c                                       |    2 
 drivers/spi/spi-mtk-snfi.c                                     |    2 
 drivers/spi/spi-qup.c                                          |    3 
 drivers/spi/spi-sprd.c                                         |    3 
 drivers/spi/spi-ti-qspi.c                                      |    1 
 drivers/virt/coco/sev-guest/sev-guest.c                        |   10 
 fs/afs/dir.c                                                   |   11 
 fs/btrfs/backref.c                                             |   11 
 fs/btrfs/block-group.c                                         |    3 
 fs/btrfs/ctree.c                                               |   17 
 fs/btrfs/dir-item.c                                            |    3 
 fs/btrfs/extent-tree.c                                         |   55 --
 fs/btrfs/free-space-tree.c                                     |   29 -
 fs/btrfs/fs.h                                                  |    4 
 fs/btrfs/inode-item.c                                          |    3 
 fs/btrfs/inode.c                                               |    7 
 fs/btrfs/ioctl.c                                               |   60 --
 fs/btrfs/print-tree.c                                          |   14 
 fs/btrfs/qgroup.c                                              |  270 +++++-----
 fs/btrfs/relocation.c                                          |    4 
 fs/btrfs/root-tree.c                                           |    4 
 fs/btrfs/send.c                                                |   10 
 fs/btrfs/super.c                                               |   10 
 fs/btrfs/tree-checker.c                                        |   21 
 fs/btrfs/tree-log.c                                            |   42 -
 fs/btrfs/volumes.c                                             |    3 
 fs/btrfs/xattr.c                                               |    3 
 fs/erofs/zdata.c                                               |   15 
 fs/fuse/dir.c                                                  |   20 
 fs/jfs/namei.c                                                 |    2 
 fs/mnt_idmapping.c                                             |    2 
 fs/netfs/buffered_read.c                                       |   64 +-
 fs/netfs/buffered_write.c                                      |  172 ++++--
 fs/netfs/direct_read.c                                         |   42 -
 fs/netfs/internal.h                                            |    3 
 fs/netfs/iterator.c                                            |   26 
 fs/netfs/misc.c                                                |    8 
 fs/netfs/read_collect.c                                        |   13 
 fs/netfs/read_retry.c                                          |   11 
 fs/netfs/read_single.c                                         |   23 
 fs/netfs/write_issue.c                                         |   46 +
 fs/nfsd/nfs4state.c                                            |    7 
 fs/nsfs.c                                                      |    2 
 fs/ntfs3/file.c                                                |   12 
 fs/orangefs/namei.c                                            |    2 
 fs/smb/client/cifs_spnego.c                                    |   16 
 fs/smb/client/cifsfs.c                                         |    2 
 fs/smb/client/netlink.c                                        |    6 
 fs/smb/client/smb2ops.c                                        |    4 
 fs/smb/client/smb2transport.c                                  |    2 
 fs/smb/server/oplock.c                                         |    6 
 fs/smb/server/smb2pdu.c                                        |   15 
 fs/smb/server/smbacl.c                                         |   78 ++
 fs/smb/server/vfs_cache.c                                      |  120 +++-
 fs/sysfs/group.c                                               |    2 
 fs/zonefs/super.c                                              |    6 
 include/asm-generic/kprobes.h                                  |    2 
 include/asm-generic/ring_buffer.h                              |   13 
 include/crypto/krb5.h                                          |    9 
 include/drm/drm_modeset_helper_vtables.h                       |   12 
 include/drm/drm_vblank.h                                       |   32 +
 include/drm/drm_vblank_helper.h                                |   56 ++
 include/linux/cgroup.h                                         |    1 
 include/linux/cleanup.h                                        |    5 
 include/linux/fprobe.h                                         |    5 
 include/linux/fwnode.h                                         |    1 
 include/linux/gfp_types.h                                      |   10 
 include/linux/highmem.h                                        |    7 
 include/linux/libata.h                                         |    7 
 include/linux/netfilter/x_tables.h                             |    3 
 include/linux/netfilter_arp/arp_tables.h                       |    1 
 include/linux/netfilter_ipv4/ip_tables.h                       |    1 
 include/linux/netfilter_ipv6/ip6_tables.h                      |    1 
 include/linux/netfs.h                                          |    2 
 include/linux/soc/airoha/airoha_offload.h                      |    6 
 include/net/bluetooth/bluetooth.h                              |    1 
 include/net/net_shaper.h                                       |    1 
 include/net/netfilter/nf_queue.h                               |    1 
 include/net/tcp.h                                              |    7 
 include/trace/events/btrfs.h                                   |    4 
 include/trace/events/netfs.h                                   |    8 
 include/trace/events/rxrpc.h                                   |    1 
 io_uring/net.c                                                 |   26 
 io_uring/nop.c                                                 |    4 
 io_uring/waitid.c                                              |    1 
 kernel/cgroup/cpuset.c                                         |    8 
 kernel/cgroup/rstat.c                                          |   37 -
 kernel/dma/debug.c                                             |    9 
 kernel/dma/mapping.c                                           |    4 
 kernel/irq_work.c                                              |    7 
 kernel/sched/core.c                                            |  159 ++---
 kernel/sched/ext.c                                             |   44 -
 kernel/sched/sched.h                                           |   33 -
 kernel/sched/syscalls.c                                        |   95 +--
 kernel/trace/bpf_trace.c                                       |    3 
 kernel/trace/fprobe.c                                          |  200 +++++--
 kernel/trace/ring_buffer.c                                     |   30 -
 kernel/trace/trace_events_hist.c                               |    6 
 kernel/trace/tracing_map.c                                     |   17 
 lib/kunit/Kconfig                                              |    5 
 lib/tests/test_kprobes.c                                       |   29 -
 mm/damon/sysfs-schemes.c                                       |    1 
 mm/memcontrol.c                                                |    6 
 mm/memory.c                                                    |   24 
 mm/memory_hotplug.c                                            |    2 
 mm/page_alloc.c                                                |    8 
 net/batman-adv/bat_iv_ogm.c                                    |   82 ++-
 net/batman-adv/bat_v_ogm.c                                     |   59 +-
 net/batman-adv/bridge_loop_avoidance.c                         |  109 ++--
 net/batman-adv/distributed-arp-table.c                         |    3 
 net/batman-adv/fragmentation.c                                 |   58 +-
 net/batman-adv/gateway_client.c                                |    4 
 net/batman-adv/mesh-interface.c                                |    1 
 net/batman-adv/originator.c                                    |    4 
 net/batman-adv/tp_meter.c                                      |  117 ++--
 net/batman-adv/translation-table.c                             |   55 +-
 net/batman-adv/tvlv.c                                          |   28 -
 net/batman-adv/tvlv.h                                          |    2 
 net/batman-adv/types.h                                         |   59 +-
 net/bluetooth/af_bluetooth.c                                   |   97 ++-
 net/bluetooth/bnep/core.c                                      |    2 
 net/bluetooth/iso.c                                            |   14 
 net/bluetooth/l2cap_core.c                                     |    2 
 net/bluetooth/l2cap_sock.c                                     |   51 +
 net/bluetooth/mgmt.c                                           |    6 
 net/bluetooth/rfcomm/sock.c                                    |    9 
 net/bluetooth/sco.c                                            |    9 
 net/bridge/br_mrp_netlink.c                                    |    4 
 net/bridge/br_multicast.c                                      |   27 -
 net/bridge/netfilter/ebtable_broute.c                          |   14 
 net/bridge/netfilter/ebtable_filter.c                          |   14 
 net/bridge/netfilter/ebtable_nat.c                             |   12 
 net/bridge/netfilter/ebtables.c                                |   71 +-
 net/core/dev.c                                                 |   21 
 net/core/gro.c                                                 |    3 
 net/core/skmsg.c                                               |    9 
 net/ethtool/bitset.c                                           |    8 
 net/ethtool/phy.c                                              |   36 +
 net/ipv4/inet_connection_sock.c                                |    2 
 net/ipv4/netfilter/arp_tables.c                                |   18 
 net/ipv4/netfilter/arptable_filter.c                           |   27 -
 net/ipv4/netfilter/ip_tables.c                                 |   18 
 net/ipv4/netfilter/iptable_filter.c                            |   27 -
 net/ipv4/netfilter/iptable_mangle.c                            |   29 -
 net/ipv4/netfilter/iptable_nat.c                               |    6 
 net/ipv4/netfilter/iptable_raw.c                               |   26 
 net/ipv4/netfilter/iptable_security.c                          |   27 -
 net/ipv4/raw.c                                                 |    2 
 net/ipv4/tcp.c                                                 |    3 
 net/ipv4/tcp_ao.c                                              |    3 
 net/ipv4/tcp_input.c                                           |   15 
 net/ipv4/tcp_ipv4.c                                            |    3 
 net/ipv6/exthdrs.c                                             |   21 
 net/ipv6/netfilter/ip6_tables.c                                |   18 
 net/ipv6/netfilter/ip6t_hbh.c                                  |    4 
 net/ipv6/netfilter/ip6table_filter.c                           |   26 
 net/ipv6/netfilter/ip6table_mangle.c                           |   27 -
 net/ipv6/netfilter/ip6table_nat.c                              |    6 
 net/ipv6/netfilter/ip6table_raw.c                              |   24 
 net/ipv6/netfilter/ip6table_security.c                         |   27 -
 net/ipv6/tcp_ipv6.c                                            |    3 
 net/l2tp/l2tp_core.c                                           |    2 
 net/mac80211/mlme.c                                            |    5 
 net/mac80211/parse.c                                           |   71 +-
 net/mptcp/pm.c                                                 |   56 +-
 net/netfilter/ipset/ip_set_hash_ipmark.c                       |    6 
 net/netfilter/ipset/ip_set_hash_ipport.c                       |    5 
 net/netfilter/ipset/ip_set_hash_ipportip.c                     |    5 
 net/netfilter/ipset/ip_set_hash_ipportnet.c                    |    5 
 net/netfilter/nf_queue.c                                       |    4 
 net/netfilter/nfnetlink_queue.c                                |    2 
 net/netfilter/nft_inner.c                                      |    3 
 net/netfilter/x_tables.c                                       |  100 +++
 net/phonet/pep.c                                               |   19 
 net/rxrpc/rxgk.c                                               |   15 
 net/shaper/shaper.c                                            |  220 +++++---
 net/smc/af_smc.c                                               |    3 
 net/smc/smc_tracepoint.h                                       |    2 
 net/tls/tls_sw.c                                               |   46 +
 net/unix/af_unix.c                                             |   11 
 net/vmw_vsock/virtio_transport_common.c                        |  103 +--
 net/vmw_vsock/vmci_transport.c                                 |    2 
 net/wireless/scan.c                                            |    3 
 scripts/gcc-plugins/gcc-common.h                               |    4 
 scripts/package/PKGBUILD                                       |    2 
 security/keys/keyring.c                                        |    1 
 security/lsm_syscalls.c                                        |    9 
 sound/core/pcm_lib.c                                           |    3 
 sound/core/seq/seq_ump_client.c                                |   22 
 sound/hda/codecs/realtek/alc269.c                              |   12 
 sound/hda/codecs/side-codecs/cs35l41_hda.c                     |    4 
 sound/hda/codecs/side-codecs/cs35l56_hda.c                     |    1 
 sound/pci/asihpi/hpicmn.c                                      |    6 
 sound/soc/amd/acp/acp-sdw-legacy-mach.c                        |    2 
 sound/soc/codecs/cs35l56-sdw.c                                 |    3 
 sound/soc/codecs/fs210x.c                                      |    2 
 sound/soc/sdw_utils/soc_sdw_utils.c                            |    4 
 sound/soc/soc-utils.c                                          |    1 
 sound/soc/sof/amd/acp.c                                        |    2 
 sound/usb/misc/ua101.c                                         |    5 
 sound/usb/mixer_scarlett2.c                                    |    9 
 tools/testing/selftests/mm/hmm-tests.c                         |   50 +
 tools/testing/selftests/mm/run_vmtests.sh                      |    2 
 tools/testing/selftests/net/lib/xdp_native.bpf.c               |   55 +-
 tools/testing/selftests/ublk/kublk.c                           |   11 
 397 files changed, 4706 insertions(+), 2334 deletions(-)

Abdun Nihaal (1):
      net: wwan: iosm: fix potential memory leaks in ipc_imem_init()

Abdurrahman Hussain (10):
      hwmon: (pmbus/adm1266) widen blackbox-info buffer to I2C_SMBUS_BLOCK_MAX
      hwmon: (pmbus/adm1266) seed timestamp from the real-time clock
      hwmon: (pmbus/adm1266) reject implausible blackbox record_count
      hwmon: (pmbus/adm1266) include PEC byte in pmbus_block_xfer read buffer
      hwmon: (pmbus/adm1266) bounce blackbox records through a protocol-sized buffer
      hwmon: (pmbus/adm1266) cap PDIO scan in get_multiple at ADM1266_PDIO_NR
      hwmon: (pmbus/adm1266) don't clobber GPIO bits before PDIO read in get_multiple
      hwmon: (pmbus/adm1266) register the gpio_chip after pmbus_do_probe()
      hwmon: (pmbus/adm1266) register the nvmem device after pmbus_do_probe()
      hwmon: (pmbus/adm1266) reject short block-read responses in the GPIO accessors

Aditya Garg (1):
      net: mana: validate rx_req_idx to prevent out-of-bounds array access

Alan Liu (1):
      drm/amdgpu/vpe: Force collaborate sync after TRAP

Alexander A. Klimov (2):
      ASoC: codecs: fs210x: fix possible buffer overflow
      io_uring/nop: pass all errors to userspace

Alexander Sverdlin (1):
      regulator: tps65219: fix irq_data.rdev not being assigned

Alexandru Hossu (1):
      wifi: mac80211: bounds-check link_id in ieee80211_ml_epcs

Alistair Popple (1):
      mm/memory: fix spurious warning when unmapping device-private/exclusive pages

Ally Heev (1):
      powerpc: 82xx: fix uninitialized pointers with free attribute

Andreas Haarmann-Thiemann (1):
      net: ethernet: cortina: Drop half-assembled SKB

Ankit Nautiyal (1):
      drm/i915/dp: Fix readback for target_rr in Adaptive Sync SDP

Antonio Quartulli (1):
      ovpn: fix race between deleting interface and adding new peer

Ard Biesheuvel (1):
      efi: Allocate runtime workqueue before ACPI init

Asim Viladi Oglu Manizada (1):
      smb: client: reject userspace cifs.spnego descriptions

Bart Van Assche (1):
      ice: fix locking in ice_dcb_rebuild()

Bartosz Golaszewski (6):
      device property: set fwnode->secondary to NULL in fwnode_init()
      gpio: cdev: check if uAPI v2 config attributes are correctly zeroed
      gpio: aggregator: fix a potential use-after-free
      gpio: aggregator: stop using dev-sync-probe
      gpio: aggregator: remove the software node when deactivating the aggregator
      gpio: aggregator: lock device when calling device_is_bound()

Biju Das (1):
      pinctrl: renesas: rzg2l: Fix incorrect PUPD register offset for high pins during suspend/resume

Boris Burkov (4):
      btrfs: check squota parent usage on membership change
      btrfs: relax squota parent qgroup deletion rule
      btrfs: check for subvolume before deleting squota qgroup
      btrfs: fix squota accounting during enable generation

Borislav Petkov (AMD) (1):
      x86/mce: Restore MCA polling interval halving

Carlos López (1):
      virt: sev-guest: Explicitly leak pages in unknown state

Casey Chen (1):
      block: recompute nr_integrity_segments in blk_insert_cloned_request

ChenXiaoSong (1):
      smb/server: promote S_DEL_ON_CLS to S_DEL_PENDING when close

Chenguang Zhao (1):
      ethtool: fix ethnl_bitmap32_not_zero() bit interval semantics

Chia-Lin Kao (AceLan) (1):
      nvme-pci: fix use-after-free in nvme_free_host_mem()

Christian Marangi (1):
      net: airoha: Fix NPU RX DMA descriptor bits

Chuck Lever (2):
      NFSD: Fix infinite loop in layout state revocation
      tls: Preserve sk_err across recvmsg() when data has been copied

Cole Leavitt (1):
      wifi: iwlwifi: mld: fix TSO segmentation explosion when AMSDU is disabled

Cunlong Li (1):
      cgroup: rstat: relax NMI guard after switch to try_cmpxchg

Cássio Gabriel (3):
      ALSA: ua101: Reject too-short USB descriptors
      ALSA: scarlett2: Allow flash writes ending at segment boundary
      ASoC: amd: acp-sdw-legacy: check CPU DAI name before logging

DaeMyung Kang (1):
      ksmbd: close durable scavenger races against m_fp_list lookups

Dan Carpenter (1):
      HID: intel-thc-hid: Intel-quickspi: Fix some error codes

Daniel Golle (2):
      net: dsa: mt7530: fix FDB entries not aging out with short timeout
      net: dsa: mt7530: preserve VLAN tags on trapped link-local frames

Daniel J Blueman (1):
      drm/msm: Fix shrinker deadlock

David Carlier (6):
      Bluetooth: ISO: drop ISO_END frames received without prior ISO_START
      net: ethtool: phy: avoid NULL deref when PHY driver is unbound
      block: don't overwrite bip_vcnt in bio_integrity_copy_user()
      ovpn: tcp - use cached peer pointer in ovpn_tcp_close()
      ovpn: respect peer refcount in CMD_NEW_PEER error path
      tracing: Avoid NULL return from hist_field_name() on truncation

David Gow (2):
      kunit: config: Enable KUNIT_DEBUGFS by default
      kunit: config: KUNIT_DEBUGFS should depend on DEBUG_FS

David Hildenbrand (Arm) (2):
      mm: fix __vm_normal_page() to handle missing support for pmd_special()/pud_special()
      mm/page_alloc: fix initialization of tags of the huge zero folio with init_on_free

David Howells (17):
      netfs: Fix cancellation of a DIO and single read subrequests
      netfs: Fix netfs_read_to_pagecache() to pause on subreq failure
      netfs: Fix overrun check in netfs_extract_user_iter()
      netfs: Fix netfs_invalidate_folio() to clear dirty bit if all changes gone
      netfs: Defer the emission of trace_netfs_folio()
      netfs: Fix streaming write being overwritten
      netfs: Fix potential deadlock in write-through mode
      netfs: Fix read-gaps to remove netfs_folio from filled folio
      netfs: Fix write streaming disablement if fd open O_RDWR
      netfs: Fix early put of sink folio in netfs_read_gaps()
      netfs: Fix leak of request in netfs_write_begin() error handling
      netfs: Fix potential UAF in netfs_unlock_abandoned_read_pages()
      netfs: Fix partial invalidation of streaming-write folio
      netfs: Fix folio->private handling in netfs_perform_write()
      netfs: Fix netfs_read_folio() to wait on writeback
      netfs, afs: Fix write skipping in dir/link writepages
      crypto/krb5, rxrpc: Fix lack of pre-decrypt/pre-verify length checks

David Sterba (1):
      btrfs: remaining BTRFS_PATH_AUTO_FREE conversions

Davidlohr Bueso (1):
      cxl/mbox: validate payload size before accessing contents in cxl_payload_from_user_allowed()

Dawei Feng (2):
      qed: fix double free in qed_cxt_tables_alloc()
      octeontx2-pf: fix double free in rvu_rep_rsrc_init()

Deepanshu Kartikey (1):
      drm/virtio: use uninterruptible resv lock for plane updates

Dmitry Baryshkov (4):
      drm/msm/dsi: don't dump registers past the mapped region
      drm/msm/dpu: don't mix devm and drmm functions
      drm/msm/adreno: fix userspace-triggered crash on a2xx-a4xx
      drm/msm/snapshot: fix dumping of the unaligned regions

Dragos Tatulea (1):
      net: napi: Avoid gro timer misfiring at end of busypoll

Eder Zulian (1):
      iommu/amd: Remove latent out-of-bounds access in IOMMU debugfs

Emil Tantilov (1):
      idpf: fix read_dev_clk_lock spinlock init in idpf_ptp_init()

Eric Dumazet (1):
      tcp: fix stale per-CPU tcp_tw_isn leak enabling ISN prediction

Eric Naim (1):
      ALSA: hda/realtek: Use ALC287_FIXUP_TXNW2781_I2C for ASUS Strix Gxx5

Erni Sri Satya Vennela (1):
      net: mana: Fix TOCTOU double-fetch of hwc_msg_id from DMA buffer

Ethan Nelson-Moore (1):
      net: ethernet: cs89x0: remove stale CONFIG_MACH_MX31ADS reference

Felix Gu (1):
      spi: mtk-snfi: Fix resource leak in mtk_snand_read_page_cache()

Ferry Meng (1):
      ksmbd: fix SID memory leak in set_posix_acl_entries_dacl() on overflow

Filipe Manana (3):
      btrfs: tracepoints: fix sleep while in atomic context in btrfs_sync_file()
      btrfs: add macros to facilitate printing of keys
      btrfs: use the key format macros when printing keys

Florian Westphal (8):
      netfilter: x_tables: unregister the templates first
      netfilter: x_tables: add and use xt_unregister_table_pre_exit
      netfilter: x_tables: add and use xtables_unregister_table_exit
      netfilter: ebtables: move to two-stage removal scheme
      netfilter: ebtables: close dangling table module init race
      netfilter: x_tables: close dangling table module init race
      netfilter: bridge: eb_tables: close module init race
      netfilter: nft_inner: release local_lock before re-enabling softirqs

Gabor Juhos (1):
      phy: marvell: mvebu-a3700-utmi: fix incorrect USB2_PHY_CTRL register access

Gao Xiang (1):
      erofs: fix managed cache race for unaligned extents

Greg Kroah-Hartman (2):
      sysfs: don't remove existing directory on update failure
      Linux 6.18.34

Grzegorz Nitka (3):
      ice: restore PTP Rx timestamp config after ethtool set-channels
      ice: ptp: serialize E825 PHY timer start with PTP lock
      ice: ptp: use primary NAC semaphore on E825

Guanghui Feng (1):
      iommu/amd: Fix illegal cap/mmio access in IOMMU debugfs

Guangshuo Li (1):
      RDMA/rtrs: Fix use-after-free in path file creation cleanup

Guenter Roeck (3):
      ARM: integrator: Fix early initialization
      hwmon: (lm90) Stop work before releasing hwmon device
      hwmon: (lm90) Add lock protection to lm90_alert

Guo Ren (Alibaba DAMO Academy) (1):
      riscv: mm: Fixup no5lvl failure when vaddr is invalid

Guopeng Zhang (1):
      cgroup/cpuset: Reset DL migration state on can_attach() failure

Gustavo Sousa (1):
      drm/xe/hdcp: Add NULL check for media_gt in intel_hdcp_gsc_check_status()

Haoze Xie (1):
      netfilter: nf_queue: hold bridge skb->dev while queued

Harry Wentland (3):
      drm/amd/display: Fix integer overflow in bios_get_image()
      drm/amd/display: Validate GPIO pin LUT table size before iterating
      drm/amd/display: Validate payload length and link_index in dc_process_dmub_aux_transfer_async

Heechan Kang (2):
      io_uring/waitid: clear waitid info before copying it to userspace
      fwctl: pds: Validate RPC input size before parsing

Henrique Carvalho (1):
      smb: client: protect tc_count increment in smb2_find_smb_sess_tcon_unlocked()

Hongling Zeng (1):
      fs: Fix return in jfs_mkdir and orangefs_mkdir

Huacai Chen (1):
      LoongArch: Remove unused code to avoid build warning

Ido Schimmel (1):
      bridge: mcast: Fix a possible use-after-free when removing a bridge port

Ilya Dryomov (1):
      rbd: eliminate a race in lock_dwork draining on unmap

Jacob Keller (1):
      ice: fix locking around wait_event_interruptible_locked_irq

Jakub Kicinski (11):
      net: shaper: flip the polarity of the valid flag
      net: shaper: fix trivial ordering issue in net_shaper_commit()
      net: shaper: reject duplicate leaves in GROUP request
      net: shaper: set ret to -ENOMEM when genlmsg_new() fails in group_doit
      net: shaper: fix undersized reply skb allocation in GROUP command
      net: shaper: enforce singleton NETDEV scope with id 0
      net: shaper: reject QUEUE scope handle with missing id
      net: tls: fix off-by-one in sg_chain entry count for wrapped sk_msg ring
      net: tls: prevent chain-after-chain in plain text SG
      net: shaper: annotate the data races
      net: shaper: rework the VALID marking (again)

Jann Horn (2):
      Bluetooth: bnep: Fix UAF read of dev->name
      af_unix: Fix UAF read of tail->len in unix_stream_data_wait()

Jens Axboe (1):
      io_uring/net: punt IORING_OP_BIND async if it needs file create

Jeremy Erazo (1):
      smb: client: use data_len for SMB2 READ encrypted folioq copy

Jeremy Laratro (1):
      ksmbd: fix null pointer dereference in compare_guid_key()

Jeroen Massar (1):
      net/mlx5: Do not restore destination-less TC rules

Jiajia Liu (1):
      Bluetooth: btmtk: fix urb->setup_packet leak in error paths

Jianpeng Chang (2):
      kprobes: skip non-symbol addresses in kprobe_add_ksym_blacklist()
      dma-mapping: move dma_map_resource() sanity check into debug code

Jiayuan Chen (1):
      irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT

Jiexun Wang (1):
      Bluetooth: serialize accept_q access

Johan Hovold (4):
      spi: qup: fix error pointer deref after DMA setup failure
      spi: ep93xx: fix error pointer deref after DMA setup failure
      spi: sprd: fix error pointer deref after DMA setup failure
      spi: ti-qspi: fix use-after-free after DMA setup failure

Johannes Berg (2):
      wifi: iwlwifi: mvm: fix driver-set TX rates on old devices
      wifi: mac80211: fix MLE defragmentation

Johannes Thumshirn (1):
      zonefs: handle integer overflow in zonefs_fname_to_fno

John Walker (1):
      wifi: cfg80211: advance loop vars in cfg80211_merge_profile()

Jonas Jelonek (1):
      net: pse-pd: fix sign on -ENOENT check in of_load_pse_pis()

Jose Ignacio Tornos Martinez (1):
      ice: fix VF queue configuration with low MTU values

Josef Bacik (1):
      btrfs: don't search back for dir inode item in INO_LOOKUP_USER

Juergen Gross (1):
      x86/xen: Fix xen_e820_swap_entry_with_ram()

Julian Braha (1):
      powerpc: fix dead default for GUEST_STATE_BUFFER_TEST

Julien Chauveau (1):
      drm/bridge: it66121: acquire reset GPIO in probe

Junyi Liu (2):
      ksmbd: validate SID in parent security descriptor during ACL inheritance
      ksmbd: fix durable reconnect error path file lifetime

Junyoung Jang (1):
      fs/statmount: fix slab out-of-bounds write in statmount_mnt_idmap

Juri Lelli (1):
      sched/deadline: Fix missing ENQUEUE_REPLENISH during PI de-boosting

Justin Iurman (2):
      ipv6: ioam: refresh hdr pointer before ioam6_event()
      ipv6: ioam: add NULL check for idev in ipv6_hop_ioam()

Kang Yang (1):
      wifi: ath10k: skip WMI and beacon transmission when device is wedged

Kees Cook (1):
      gcc-plugins: Always define CONST_CAST_GIMPLE and CONST_CAST_TREE

Keith Busch (1):
      nvme: fix bio leak on mapping failure

Kiran K (1):
      Bluetooth: btintel_pcie: Fix incorrect MAC access programming

Kohei Enju (2):
      igc: fix potential skb leak in igc_fpe_xmit_smd_frame()
      igc: set tx buffer type for SMD frames

Konstantin Komarov (1):
      fs/ntfs3: handle attr_set_size() errors when truncating files

Krishnamoorthi M (1):
      spi: amd: Set correct bus number in ACPI probe path

Kuniyuki Iwashima (2):
      tcp: Fix imbalanced icsk_accept_queue count.
      tcp: Fix out-of-bounds access for twsk in tcp_ao_established_key().

Kyle Farnung (1):
      wifi: ath11k: clear shared SRNG pointer state on restart

Lad Prabhakar (1):
      pinctrl: renesas: rzg2l: Fix SMT register cache handling

Li Xiasong (1):
      mptcp: pm: fix ADD_ADDR timer infinite retry on option space insufficient

Linus Torvalds (1):
      security/keys: fix missed RCU read section on lookup

Linus Walleij (2):
      net: ethernet: cortina: Make RX SKB per-port
      net: ethernet: cortina: Carry over frag counter

Lorenzo Bianconi (1):
      net: airoha: Disable GDM2 forwarding before configuring GDM2 loopback

Louis-Alexis Eyraud (2):
      drm/mediatek: mtk_cec: Fix non-static global variable
      drm/mediatek: mtk_hdmi_ddc: Fix non-static global variable

Luis Henriques (1):
      fuse: fix uninit-value in fuse_dentry_revalidate()

Luiz Capitulino (1):
      selftests/mm: run_vmtests.sh: fix destructive tests invocation

Lukas Bulwahn (1):
      HID: quirks: really enable the intended work around for appledisplay

Luxiao Xu (1):
      batman-adv: fix tp_meter counter underflow during shutdown

Mac Chiang (2):
      ASoC: sdw_utils: Add quirk to ignore RT712 CODEC_MIC
      ASoC: sdw_utils: Add quirk to ignore RT721 CODEC_MIC

Marcin Szycik (2):
      ice: fix setting promisc mode while adding VID filter
      ice: fix setting RSS VSI hash for E830

Marek Vasut (2):
      ARM: dts: renesas: genmai: Drop superfluous cells
      ARM: dts: renesas: rskrza1: Drop superfluous cells

Mario Limonciello (1):
      ASoC: SOF: amd: Fix error code handling in psp_send_cmd()

Martin Kaiser (1):
      test_kprobes: clear kprobes between test runs

Masami Hiramatsu (Google) (6):
      tracing: fprobe: Remove unused local variable
      tracing/fprobe: Avoid kcalloc() in rcu_read_lock section
      tracing/fprobe: Check the same type fprobe on table as the unregistered one
      ring-buffer: Flush and stop persistent ring buffer on panic
      tracing: Do not call map->ops->elt_free() if elt_alloc() fails
      fprobe: Fix unregister_fprobe() to wait for RCU grace period

Matt Fleming (1):
      net/mlx5e: Fix use-after-free in mlx5e_tx_reporter_timeout_recover

Matthew Leach (1):
      wifi: ath11k: fix peer resolution on rx path when peer_id=0

Maulik Shah (2):
      pinctrl: qcom: Fix GPIO to PDC wake irq map for qcs615
      pinctrl: qcom: Fix wakeirq map by removing disconnected irqs for sm8150

Maíra Canal (2):
      drm/v3d: Fix use-after-free of CPU job query arrays on error path
      drm/v3d: Release indirect CSD GEM reference on CPU job free

Menglong Dong (1):
      tracing: fprobe: use ftrace if CONFIG_DYNAMIC_FTRACE_WITH_ARGS

Michael Bommarito (12):
      smb: client: require net admin for CIFS SWN netlink
      Bluetooth: L2CAP: ecred_reconfigure: send packed pdu, not stack pointer
      Bluetooth: MGMT: validate Add Extended Advertising Data length
      net: ifb: report ethtool stats over num_tx_queues
      l2tp: use list_del_rcu in l2tp_session_unhash
      ipv4: raw: reject IP_HDRINCL packets with ihl < 5
      ixgbevf: fix use-after-free in VEPA multicast source pruning
      wifi: mac80211: consume only present negotiated TTLM maps
      KVM: arm64: vgic-its: Reject restored DTE with out-of-range num_eventid_bits
      KVM: arm64: vgic: Free private_irqs when init fails after allocation
      scsi: isci: Fix use-after-free in device removal path
      RDMA/siw: Reject MPA FPDU length underflow before signed receive math

Michael Neuling (1):
      riscv: errata: Fix bitwise vs logical AND in MIPS errata patching

Michal Wajdeczko (1):
      drm/xe/vf: Fix signature of print functions

Mike Christie (1):
      scsi: sd: Fix return code handling in sd_spinup_disk()

Mikko Perttunen (1):
      drm/msm: Fix iommu_map_sgtable() return value check and avoid WARN

Ming Lei (2):
      ublk: reject max_sectors smaller than PAGE_SECTORS in parameter validation
      selftests: ublk: cap nthreads to kernel's actual nr_hw_queues

Mingyu Wang (1):
      Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths

Minh Nguyen (1):
      vsock/vmci: fix UAF when peer resets connection during handshake

Miri Korenblit (1):
      wifi: iwlwifi: mld: don't dereference a pointer before NULL checking it

Mohanram Meenakshisundaram (1):
      drm/xe/pf: Fix CFI failure in debugfs access

Mohsin Bashir (1):
      net: shaper: Reject reparenting of existing nodes

Muchun Song (2):
      drivers/base/memory: fix memory block reference leak in poison accounting
      mm/memory_hotplug: fix memory block reference leak on remove

Myeonghun Pak (1):
      net: lan966x: avoid unregistering netdev on register failure

Nan Li (1):
      netfilter: ipset: stop hash:* range iteration at end

Nathan Chancellor (1):
      drm/msm: Restore second parameter name in purge() and evict()

Nerijus Bendžiūnas (1):
      net: phy: skip EEE advertisement write when autoneg is disabled

Nicolai Buchwitz (3):
      net: bcmgenet: keep RBUF EEE/PM disabled
      net: phy: honor eee_disabled_modes in phy_support_eee()
      net: phy: honor eee_disabled_modes in phy_advertise_eee_all()

Nicolas Escande (2):
      wifi: ath11k: fix error path leaks in some WMI WOW calls
      wifi: ath11k: fix error path leak in ath11k_tm_cmd_wmi_ftm()

Nikhil P. Rao (3):
      pds_core: fix error handling in pdsc_devcmd_wait
      pds_core: fix debugfs_lookup dentry leak and error handling
      pds_core: ensure null-termination for firmware version strings

Niklas Cassel (4):
      ata: libata-scsi: improve readability of ata_scsi_qc_issue()
      ata: libata-scsi: do not use the deferred QC feature for ATA_DEFER_PORT
      ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
      ata: libata-scsi: do not needlessly defer commands when using PMP with FBS

Nimrod Oren (1):
      selftests: net: Fix checksums in xdp_native

Nitin Rawat (1):
      phy: qcom-qmp-ufs: Fix kaanapali PHY PLL lock failure after SM8650 G4 fix

Oliver White (1):
      platform/surface: aggregator_registry: omit battery & AC nodes on Surface Laptop 7

Osama Abdelkader (4):
      riscv: kvm: return SBI_ERR_FAILURE for pmu_snapshot_set_shmem() when OOM
      riscv: kvm: return SBI_ERR_FAILURE for pmu_event_info() when OOM
      drm/bridge: chipone-icn6211: use devm_drm_bridge_add in i2c probe
      drm/bridge: megachips: remove bridge when irq request fails

Peter Zijlstra (1):
      sched: Employ sched_change guards

Petr Machata (1):
      net: bridge: Flush multicast groups when snooping is disabled

Prathamesh Deshpande (1):
      net/mlx5e: Fix eswitch mode block underflow on IPsec acquire SA

Qing Ming (1):
      cgroup/rstat: validate cpu before css_rstat_cpu() access

Quan Sun (1):
      net: ethtool: fix NULL pointer dereference in phy_reply_size

Rafael J. Wysocki (4):
      platform/x86: adv_swbutton: Check ACPI_HANDLE() against NULL
      platform/x86: hp_accel: Check ACPI_COMPANION() against NULL
      platform/x86: intel-hid: Check ACPI_HANDLE() against NULL
      platform/x86: intel-vbtn: Check ACPI_HANDLE() against NULL

Ralf Lici (1):
      ovpn: disable BHs when updating device stats

Ratheesh Kannoth (1):
      octeontx2-af: npc: Fix allmulticast skip logic for LBK and SDP VFs

Ricardo Neri (1):
      Documentation: intel_pstate: Fix description of asymmetric packing with SMT

Richard Fitzgerald (1):
      ASoC: cs35l56: Fix flushing of IRQ work in cs35l56_sdw_remove()

Robertus Diawan Chris (2):
      ALSA: scarlett2: Add missing error check when initialise Autogain Status
      ASoC: soc-utils: Add missing va_end in snd_soc_ret()

Rosen Penev (2):
      irqchip/ath79-cpu: Remove unused function
      net: ag71xx: check error for platform_get_irq

Ruide Cao (1):
      batman-adv: fix fragment reassembly length accounting

Ruijie Li (1):
      batman-adv: clear current gateway during teardown

Sabrina Dubroca (1):
      net: gro: don't merge zcopy skbs

Safa Karakuş (1):
      Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()

Sam Daly (1):
      octeontx2-af: CGX: add bounds check to cgx_speed_mbps index

Samuele Mariotti (1):
      sched_ext: Fix missing warning in scx_set_task_state() default case

Sasha Levin (2):
      Revert "ice: fix double-free of tx_buf skb"
      Revert "ice: Remove jumbo_remove step from TX path"

Sayali Patil (1):
      powerpc/time: Remove redundant preempt_disable|enable() calls from arch_irq_work_raise()

SeongJae Park (1):
      mm/damon/sysfs-schemes: call missing mem_cgroup_iter_break()

Sheroz Juraev (1):
      wifi: iwlwifi: mld: stop TX during firmware restart

Shiraz Saleem (1):
      RDMA/mana_ib: Report max_msg_sz in mana_ib_query_port

Shitalkumar Gandhi (2):
      net: ti: icssm-prueth: fix eth_ports_node leak in probe
      wifi: wilc1000: fix dma_buffer leak on bus acquire failure

Shuhao Fu (2):
      ALSA: hda: cs35l56: Put ACPI device after setting companion
      ALSA: hda: cs35l41: Put ACPI device on missing physical node

Shuicheng Lin (2):
      drm/xe/gsc: Fix double-free of managed BO in error path
      drm/xe/oa: Fix exec_queue leak on width check in stream open

Stanimir Varbanov (3):
      dt-bindings: soc: bcm: Add bcm2712 compatible
      arm64: dts: broadcom: bcm2712: Add watchdog DT node
      mfd: bcm2835-pm: Add support for BCM2712

Stefano Garzarella (2):
      vsock/virtio: reset connection on receiving queue overflow
      vsock/virtio: fix zerocopy completion for multi-skb sends

Stephen Smalley (1):
      lsm: hold cred_guard_mutex for lsm_set_self_attr()

Steven Rostedt (1):
      ring-buffer: Fix reporting of missed events in iterator

Sudeep Holla (10):
      firmware: arm_ffa: Check for NULL FF-A ID table while driver registration
      firmware: arm_ffa: Skip free_pages on RX buffer alloc failure
      firmware: arm_ffa: Fix per-vcpu self notifications handling in workqueue
      firmware: arm_ffa: Unregister bus notifier on teardown for FF-A v1.0
      firmware: arm_ffa: Bound PARTITION_INFO_GET_REGS copies
      firmware: arm_ffa: Keep framework RX release under lock
      firmware: arm_ffa: Validate framework notification message layout
      firmware: arm_ffa: Align RxTx buffer size before mapping
      firmware: arm_ffa: Snapshot notifier callbacks under lock
      firmware: arm_ffa: Fix sched-recv callback partition lookup

Sungwoo Kim (1):
      block: bio-integrity: Fix null-ptr-deref in bio_integrity_map_user()

Sven Eckelmann (21):
      batman-adv: v: stop OGMv2 on disabled interface
      batman-adv: tvlv: abort OGM send on tvlv append failure
      batman-adv: tvlv: reject oversized TVLV packets
      batman-adv: iv: recover OGM scheduling after forward packet error
      batman-adv: mcast: fix use-after-free in orig_node RCU release
      batman-adv: dat: handle forward allocation error
      batman-adv: frag: disallow unicast fragment in fragment
      batman-adv: bla: fix report_work leak on backbone_gw purge
      batman-adv: bla: avoid double decrement of bla.num_requests
      batman-adv: bla: avoid NULL-ptr deref for claim via dropped interface
      batman-adv: tp_meter: avoid use of uninit sender vars
      batman-adv: tp_meter: directly shut down timer on cleanup
      batman-adv: tp_meter: fix tp_vars reference leak in receiver shutdown
      batman-adv: tp_meter: fix race condition in send error reporting
      batman-adv: tp_meter: avoid role confusion in tp_list
      batman-adv: tt: fix TOCTOU race for reported vlans
      batman-adv: tt: reject oversized local TVLV buffers
      batman-adv: tt: avoid empty VLAN responses
      batman-adv: tt: fix negative last_changeset_len
      batman-adv: tt: fix negative tt_buff_len
      batman-adv: tt: prevent TVLV entry number overflow

Sven Schuchmann (1):
      net: phy: DP83TC811: add reading of abilities

Takashi Iwai (3):
      ALSA: pcm: Don't setup bogus iov_iter for silencing
      ALSA: asihpi: Fix potential OOB array access at reading cache
      HID: uclogic: Fix regression of input name assignment

Tejun Heo (1):
      sched_ext: Avoid UAF in scx_root_enable_workfn() init failure path

Thomas Zimmermann (5):
      drm/vblank: Add vblank timer
      drm/vblank: Add CRTC helpers for simple use cases
      drm/vkms: Convert to DRM's vblank timer
      drm/atomic: Increase timeout in drm_atomic_helper_wait_for_vblanks()
      drm/vblank: Fix kernel docs for vblank timer

Tiezhu Yang (2):
      LoongArch: kprobes: Use larch_insn_text_copy() to patch instructions
      LoongArch: kprobes: Fix handling of fatal unrecoverable recursions

Til Kaiser (1):
      pinctrl: qcom: ipq4019: mark gpio as a GPIO pin function

Tina Zhang (1):
      KVM: SVM: Disable AVIC IPI virtualization on Hygon Family 18h (erratum #1235)

Viacheslav Dubeyko (1):
      netfs: fix VM_BUG_ON_FOLIO() issue in netfs_write_begin() call

Viktor Jägersküpper (1):
      kbuild: pacman-pkg: make "rc" releases adhere to pacman versioning scheme

Vladimir Murzin (1):
      arm64: probes: Handle probes on hinted conditional branch instructions

Vladimir Yakovlev (1):
      spi: spi-dw-dma: fix print error log when wait finish transaction

Wayne Chang (1):
      phy: tegra: xusb: Fix per-pad high-speed termination calibration

Weiming Shi (1):
      tap: fix stack info leak in tap_ioctl() SIOCGIFHWADDR

Xiang Mei (3):
      bridge: mrp: reject zero test interval to avoid OOM panic
      net/smc: avoid NULL deref of conn->lnk in smc_msg_event tracepoint
      net/smc: reject CHID-0 ACCEPT that matches an empty ism_dev slot

Xianwei Zhao (1):
      pinctrl: meson: amlogic-a4: fix deadlock issue

Xingwang Xiang (1):
      bpf, skmsg: fix verdict sk_data_ready racing with ktls rx

Yizhou Zhao (1):
      netfilter: nft_inner: Fix IPv6 inner_thoff desync

Zack McKevitt (1):
      accel/qaic: Add overflow check to remap_pfn_range during mmap

Zhang Cen (1):
      ALSA: seq: Serialize UMP output teardown with event_input

Zhengchuan Liang (1):
      netfilter: ip6t_hbh: reject oversized option lists

Zhihao Cheng (2):
      cifs: Fix busy dentry used after unmounting
      nsfs: fix wrong error code returned for pidns ioctls

Zijing Yin (1):
      phonet/pep: disable BH around forwarded sk_receive_skb()

Łukasz Lebiedziński (1):
      phy: exynos5-usbdrd: fix USB 2.0 HS PHY tuning values for Exynos7870

