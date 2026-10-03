Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B4F41F360;
	Sat,  3 Oct 2026 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791024872; cv=none; b=mV7ExbC0iQIGj9kh3t20kePWuJsXLi9MwFxuTtNJ/yeNpnTHGKtaZNirRf0+RADKwIkAlXq8/wiBX0ZGHvpgi1vgTrjTGZIaum7Z3whmJRMuj5lKaKE7gvC8wJlsBQvbUt6YGn94MvFkW/ti/8ytV1sHzNN9EFtI3jP89uMKaJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791024872; c=relaxed/simple;
	bh=2cc30QYS6wV0podHhowG5Odfju9xXgBLchjZq8beUjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ErAGXUaj0luGVW5i4+iCSNqfXZKB3D7iKQMiNerRnvoic0OclCelVw/oYTN6LM0nJmKz1rRoSWIYtJdojpR0Z2yXlMALIslruld4WbLolHrG46TdO6g2MGQhYnXRcoCQskcikJsczJko42q96+zDBkKCVbysydWY6Hx8NzXuJfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Cd6KKHZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Cd6KKHZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E761F0089D;
	Sat,  3 Oct 2026 10:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791024856;
	bh=fvL1OY4epIzLTxsTVCZZjRWX3S2qqaH/9Ae7cxTka+0=;
	h=From:To:Cc:Subject:Date;
	b=0Cd6KKHZruKTdSE+JiT8L2pE1Ar7q1RwCaSGnJ3twT1peLQqF8dDPSaZ9InS69PCd
	 kYpiM0gwj/gSvai68dXtCXREEems+i2ZuCiK6RNO2vRgMAYKzOK8c/xgJribWazptE
	 4dJ7RzDSLJe4SqdnYIoJowXheQZQ5NyhW9PJ6auw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.55
Date: Sat,  3 Oct 2026 12:54:11 +0200
Message-ID: <2026100312-fragrant-powdered-87bf@gregkh>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.55 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arch/arm64/booting.rst                                   |    1 
 Documentation/arch/s390/pci.rst                                        |  152 ++-
 Makefile                                                               |    2 
 arch/arm64/include/asm/el2_setup.h                                     |    9 
 arch/arm64/include/asm/io.h                                            |    3 
 arch/arm64/include/asm/kvm_pkvm.h                                      |   10 
 arch/arm64/kernel/cpu_errata.c                                         |   15 
 arch/arm64/kvm/arm.c                                                   |    4 
 arch/arm64/kvm/emulate-nested.c                                        |    2 
 arch/arm64/kvm/hyp/nvhe/pkvm.c                                         |   38 
 arch/arm64/kvm/hyp/nvhe/setup.c                                        |   10 
 arch/arm64/kvm/hyp/nvhe/sys_regs.c                                     |    5 
 arch/arm64/kvm/hypercalls.c                                            |    3 
 arch/arm64/kvm/mmu.c                                                   |   15 
 arch/arm64/kvm/nested.c                                                |   15 
 arch/arm64/kvm/sys_regs.c                                              |    1 
 arch/arm64/kvm/vgic/vgic-its.c                                         |   43 -
 arch/arm64/net/bpf_jit_comp.c                                          |    2 
 arch/mips/net/bpf_jit_comp32.c                                         |    2 
 arch/mips/net/bpf_jit_comp64.c                                         |    3 
 arch/parisc/include/asm/thread_info.h                                  |    2 
 arch/riscv/kvm/aia_imsic.c                                             |   11 
 arch/riscv/kvm/mmu.c                                                   |    2 
 arch/riscv/kvm/nacl.c                                                  |   20 
 arch/riscv/kvm/vcpu_exit.c                                             |    2 
 arch/riscv/kvm/vcpu_pmu.c                                              |   33 
 arch/riscv/kvm/vcpu_sbi_hsm.c                                          |    4 
 arch/riscv/kvm/vcpu_timer.c                                            |    5 
 arch/s390/crypto/hmac_s390.c                                           |    5 
 arch/s390/include/asm/debug.h                                          |    8 
 arch/s390/kernel/debug.c                                               |   15 
 arch/s390/kernel/uv.c                                                  |    8 
 arch/s390/kvm/interrupt.c                                              |   70 -
 arch/s390/pci/pci_event.c                                              |    7 
 arch/s390/pci/pci_report.c                                             |   32 
 arch/s390/pci/pci_report.h                                             |    4 
 arch/x86/boot/startup/sev-startup.c                                    |    3 
 arch/x86/coco/sev/Makefile                                             |    2 
 arch/x86/coco/sev/core.c                                               |  388 ----------
 arch/x86/coco/sev/internal.h                                           |  119 +++
 arch/x86/coco/sev/noinstr.c                                            |    7 
 arch/x86/coco/sev/svsm.c                                               |  362 +++++++++
 arch/x86/coco/sev/vc-handle.c                                          |    3 
 arch/x86/events/intel/core.c                                           |   79 +-
 arch/x86/events/intel/ds.c                                             |   36 
 arch/x86/include/asm/sev-internal.h                                    |   87 --
 arch/x86/kernel/cpu/mce/core.c                                         |   27 
 arch/x86/kvm/pmu.c                                                     |    8 
 arch/x86/kvm/svm/sev.c                                                 |   18 
 arch/x86/kvm/vmx/pmu_intel.c                                           |    3 
 arch/x86/pci/fixup.c                                                   |   99 ++
 drivers/ata/libata-scsi.c                                              |   10 
 drivers/bluetooth/btintel_pcie.c                                       |   16 
 drivers/bluetooth/btnxpuart.c                                          |    8 
 drivers/dpll/dpll_netlink.c                                            |    3 
 drivers/gpio/gpio-arizona.c                                            |    8 
 drivers/gpio/gpio-tps65219.c                                           |   12 
 drivers/gpio/gpio-zynq.c                                               |   10 
 drivers/gpio/gpiolib-cdev.c                                            |   32 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                               |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                            |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                             |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                                 |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                      |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h                      |   12 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c                 |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c              |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c                  |   62 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h                  |   28 
 drivers/gpu/drm/amd/display/dc/dml/Makefile                            |    6 
 drivers/gpu/drm/bridge/samsung-dsim.c                                  |    2 
 drivers/gpu/drm/clients/drm_fbdev_client.c                             |   28 
 drivers/gpu/drm/clients/drm_log.c                                      |    4 
 drivers/gpu/drm/drm_client_event.c                                     |   20 
 drivers/gpu/drm/drm_fb_helper.c                                        |   24 
 drivers/gpu/drm/drm_file.c                                             |    2 
 drivers/gpu/drm/drm_modeset_helper.c                                   |    6 
 drivers/gpu/drm/i915/display/intel_cursor.c                            |    7 
 drivers/gpu/drm/i915/display/intel_display_types.h                     |    2 
 drivers/gpu/drm/i915/display/intel_dp_mst.c                            |   24 
 drivers/gpu/drm/i915/display/intel_dp_mst.h                            |    2 
 drivers/gpu/drm/i915/display/intel_link_bw.c                           |    3 
 drivers/gpu/drm/i915/display/intel_psr.c                               |   26 
 drivers/gpu/drm/i915/display/intel_quirks.c                            |   37 
 drivers/gpu/drm/i915/display/intel_quirks.h                            |    2 
 drivers/gpu/drm/i915/display/skl_universal_plane.c                     |    9 
 drivers/gpu/drm/i915/gem/i915_gem_object.c                             |    2 
 drivers/gpu/drm/i915/i915_driver.c                                     |    6 
 drivers/gpu/drm/imagination/pvr_free_list.c                            |   15 
 drivers/gpu/drm/imagination/pvr_mmu.c                                  |   19 
 drivers/gpu/drm/imagination/pvr_mmu.h                                  |    2 
 drivers/gpu/drm/imagination/pvr_vm.c                                   |    4 
 drivers/gpu/drm/nouveau/nouveau_bo.c                                   |    3 
 drivers/gpu/drm/nouveau/nouveau_connector.c                            |    5 
 drivers/gpu/drm/nouveau/nouveau_display.c                              |    4 
 drivers/gpu/drm/nouveau/nouveau_drm.c                                  |    5 
 drivers/gpu/drm/nouveau/nouveau_gem.c                                  |    2 
 drivers/gpu/drm/nouveau/nouveau_sched.c                                |    2 
 drivers/gpu/drm/nouveau/nouveau_sched.h                                |    1 
 drivers/gpu/drm/nouveau/nouveau_uvmm.c                                 |   13 
 drivers/gpu/drm/nouveau/nvif/vmm.c                                     |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c                       |    3 
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c                         |   23 
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c                       |    2 
 drivers/gpu/drm/radeon/radeon_device.c                                 |    4 
 drivers/gpu/drm/virtio/virtgpu_drv.h                                   |    5 
 drivers/gpu/drm/virtio/virtgpu_gem.c                                   |    2 
 drivers/gpu/drm/virtio/virtgpu_ioctl.c                                 |   49 +
 drivers/gpu/drm/virtio/virtgpu_prime.c                                 |    2 
 drivers/gpu/drm/virtio/virtgpu_submit.c                                |   11 
 drivers/gpu/drm/virtio/virtgpu_vq.c                                    |   46 +
 drivers/gpu/drm/virtio/virtgpu_vram.c                                  |   17 
 drivers/gpu/drm/xe/display/xe_display.c                                |    6 
 drivers/gpu/drm/xe/xe_bo.c                                             |    7 
 drivers/gpu/drm/xe/xe_bo.h                                             |   19 
 drivers/gpu/drm/xe/xe_hw_engine.c                                      |   27 
 drivers/gpu/drm/xe/xe_vm.c                                             |   21 
 drivers/hid/amd-sfh-hid/amd_sfh_common.h                               |    4 
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c                                 |   10 
 drivers/hid/bpf/hid_bpf_dispatch.c                                     |   12 
 drivers/hid/hid-alps.c                                                 |   31 
 drivers/hid/hid-ids.h                                                  |    3 
 drivers/hid/hid-multitouch.c                                           |   29 
 drivers/hid/hid-quirks.c                                               |    3 
 drivers/hid/wacom_sys.c                                                |    5 
 drivers/i2c/busses/i2c-qcom-geni.c                                     |   38 
 drivers/net/bonding/bond_main.c                                        |    2 
 drivers/net/dsa/mt7530-mdio.c                                          |   20 
 drivers/net/dsa/mt7530.c                                               |    3 
 drivers/net/ethernet/airoha/airoha_npu.c                               |   18 
 drivers/net/ethernet/amazon/ena/ena_netdev.c                           |    2 
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c                        |    3 
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c                        |    3 
 drivers/net/ethernet/atheros/atlx/atl1.c                               |    3 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                         |   34 
 drivers/net/ethernet/broadcom/tg3.c                                    |   15 
 drivers/net/ethernet/brocade/bna/bnad.c                                |   24 
 drivers/net/ethernet/cadence/macb_main.c                               |   14 
 drivers/net/ethernet/freescale/fman/fman.c                             |    1 
 drivers/net/ethernet/google/gve/gve.h                                  |   12 
 drivers/net/ethernet/google/gve/gve_adminq.c                           |   12 
 drivers/net/ethernet/google/gve/gve_desc_dqo.h                         |    5 
 drivers/net/ethernet/google/gve/gve_ethtool.c                          |   99 +-
 drivers/net/ethernet/google/gve/gve_main.c                             |   93 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c                           |   71 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c                      |    3 
 drivers/net/ethernet/marvell/octeontx2/af/common.h                     |   45 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c                |  104 --
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                            |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c                |   45 -
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c                     |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c            |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c              |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                      |    1 
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c                   |   15 
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h                   |    2 
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c                   |    5 
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h                            |    5 
 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c                        |   48 +
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c                        |   13 
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c                             |   74 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h                             |    2 
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c                            |   18 
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c                           |    4 
 drivers/net/ethernet/netronome/nfp/crypto/ipsec.c                      |    3 
 drivers/net/ethernet/spacemit/k1_emac.c                                |    3 
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c                         |    5 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c                     |    4 
 drivers/net/ethernet/stmicro/stmmac/hwif.h                             |    2 
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c                        |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                      |    1 
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c                 |  109 ++
 drivers/net/ethernet/ti/netcp_core.c                                   |    2 
 drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c                        |   13 
 drivers/net/macsec.c                                                   |   84 +-
 drivers/net/ovpn/netlink.c                                             |  108 ++
 drivers/net/ovpn/peer.c                                                |  121 ++-
 drivers/net/ovpn/peer.h                                                |   25 
 drivers/net/ovpn/udp.c                                                 |  193 ++++
 drivers/net/pcs/pcs-rzn1-miic.c                                        |    3 
 drivers/net/pcs/pcs-xpcs.c                                             |    4 
 drivers/net/phy/micrel.c                                               |    1 
 drivers/net/phy/phylink.c                                              |   20 
 drivers/net/usb/catc.c                                                 |   15 
 drivers/net/usb/cdc_mbim.c                                             |    5 
 drivers/net/usb/lan78xx.c                                              |    2 
 drivers/net/usb/sr9700.c                                               |    3 
 drivers/net/veth.c                                                     |    2 
 drivers/net/virtio_net.c                                               |    9 
 drivers/net/vrf.c                                                      |    2 
 drivers/net/vxlan/vxlan_core.c                                         |    6 
 drivers/nfc/microread/microread.c                                      |    6 
 drivers/nfc/nfcmrvl/fw_dnld.c                                          |   11 
 drivers/nfc/pn533/pn533.c                                              |   14 
 drivers/nfc/pn533/pn533.h                                              |    4 
 drivers/nfc/pn533/usb.c                                                |    4 
 drivers/nfc/pn544/pn544.c                                              |    7 
 drivers/nfc/port100.c                                                  |    7 
 drivers/nfc/st21nfca/core.c                                            |   12 
 drivers/nfc/st21nfca/i2c.c                                             |   29 
 drivers/nfc/trf7970a.c                                                 |    4 
 drivers/nfc/virtual_ncidev.c                                           |    3 
 drivers/pci/of_property.c                                              |   11 
 drivers/pci/setup-bus.c                                                |   23 
 drivers/pinctrl/meson/pinctrl-meson-s4.c                               |    2 
 drivers/pinctrl/pinctrl-single.c                                       |    3 
 drivers/pinctrl/sunxi/pinctrl-sun55i-a523-r.c                          |    2 
 drivers/pinctrl/sunxi/pinctrl-sun55i-a523.c                            |    2 
 drivers/pinctrl/sunxi/pinctrl-sunxi.c                                  |   82 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.h                                  |    9 
 drivers/remoteproc/qcom_q6v5_adsp.c                                    |    8 
 drivers/s390/cio/chp.c                                                 |    3 
 drivers/s390/cio/cio.c                                                 |   11 
 drivers/s390/cio/cio.h                                                 |    5 
 drivers/s390/cio/cmf.c                                                 |    2 
 drivers/s390/cio/device.c                                              |    9 
 drivers/s390/cio/device_fsm.c                                          |    3 
 drivers/s390/cio/device_ops.c                                          |   23 
 drivers/s390/cio/vfio_ccw_fsm.c                                        |    2 
 drivers/s390/crypto/vfio_ap_ops.c                                      |   18 
 drivers/scsi/libiscsi_tcp.c                                            |    3 
 drivers/scsi/megaraid/megaraid_sas_base.c                              |    4 
 drivers/scsi/sd_zbc.c                                                  |    8 
 drivers/thermal/gov_step_wise.c                                        |   10 
 fs/autofs/inode.c                                                      |    4 
 fs/bpf_fs_kfuncs.c                                                     |    4 
 fs/erofs/fscache.c                                                     |    2 
 fs/fs-writeback.c                                                      |   25 
 fs/hfsplus/super.c                                                     |    1 
 fs/inode.c                                                             |   11 
 fs/kernfs/mount.c                                                      |    4 
 fs/ntfs3/inode.c                                                       |    7 
 fs/ocfs2/namei.c                                                       |    9 
 fs/ocfs2/xattr.c                                                       |   13 
 fs/ocfs2/xattr.h                                                       |    8 
 fs/smb/client/cached_dir.c                                             |   32 
 fs/smb/client/smb2inode.c                                              |    4 
 fs/smb/client/smb2ops.c                                                |   28 
 fs/smb/client/smb2pdu.c                                                |   51 +
 fs/squashfs/xz_wrapper.c                                               |    6 
 fs/super.c                                                             |   43 -
 fs/xfs/libxfs/xfs_metafile.c                                           |    8 
 fs/xfs/libxfs/xfs_rtrefcount_btree.c                                   |    4 
 fs/xfs/scrub/dir_repair.c                                              |   19 
 fs/xfs/scrub/health.c                                                  |    6 
 fs/xfs/scrub/inode.c                                                   |    2 
 fs/xfs/scrub/inode_repair.c                                            |    2 
 fs/xfs/scrub/orphanage.c                                               |    6 
 fs/xfs/scrub/repair.c                                                  |   19 
 fs/xfs/scrub/scrub.h                                                   |    2 
 fs/xfs/scrub/trace.h                                                   |   12 
 fs/xfs/xfs_dquot.c                                                     |    8 
 fs/xfs/xfs_exchrange.c                                                 |   13 
 fs/xfs/xfs_icache.c                                                    |    2 
 fs/xfs/xfs_log_recover.c                                               |   13 
 fs/xfs/xfs_refcount_item.c                                             |    8 
 fs/xfs/xfs_rmap_item.c                                                 |    8 
 include/drm/drm_client.h                                               |   22 
 include/drm/drm_client_event.h                                         |   12 
 include/drm/drm_fb_helper.h                                            |    8 
 include/linux/bpf_mem_alloc.h                                          |    6 
 include/linux/if_vlan.h                                                |    3 
 include/linux/rculist.h                                                |   29 
 include/linux/skbuff.h                                                 |   24 
 include/net/gue.h                                                      |   19 
 include/net/ip6_route.h                                                |    4 
 include/net/netfilter/nf_conntrack.h                                   |    5 
 include/net/nfc/hci.h                                                  |    2 
 include/net/nfc/nfc.h                                                  |    3 
 include/net/rose.h                                                     |   28 
 include/net/tcp.h                                                      |    4 
 kernel/bpf/btf.c                                                       |  136 ++-
 kernel/bpf/crypto.c                                                    |    5 
 kernel/bpf/hashtab.c                                                   |  114 ++
 kernel/bpf/memalloc.c                                                  |  106 +-
 kernel/bpf/offload.c                                                   |    2 
 kernel/bpf/syscall.c                                                   |    5 
 kernel/cgroup/cpuset.c                                                 |   53 -
 kernel/cgroup/pids.c                                                   |    5 
 kernel/events/core.c                                                   |   17 
 kernel/sched/core.c                                                    |    2 
 kernel/sched/ext.c                                                     |    7 
 kernel/workqueue.c                                                     |    2 
 mm/backing-dev.c                                                       |    5 
 mm/damon/core.c                                                        |   24 
 mm/damon/vaddr.c                                                       |   21 
 mm/hugetlb.c                                                           |   41 -
 mm/rmap.c                                                              |   23 
 mm/vma.c                                                               |    8 
 net/8021q/vlan_dev.c                                                   |    5 
 net/bluetooth/bnep/core.c                                              |   17 
 net/bluetooth/bnep/netdev.c                                            |    8 
 net/bluetooth/hci_conn.c                                               |   14 
 net/bluetooth/hci_sock.c                                               |   20 
 net/bluetooth/iso.c                                                    |    7 
 net/bluetooth/l2cap_core.c                                             |   10 
 net/bluetooth/mgmt.c                                                   |   27 
 net/bluetooth/rfcomm/core.c                                            |    3 
 net/bluetooth/rfcomm/sock.c                                            |    6 
 net/bluetooth/smp.c                                                    |   17 
 net/bridge/br_mdb.c                                                    |    2 
 net/bridge/br_stp_bpdu.c                                               |    5 
 net/core/dev.c                                                         |    2 
 net/core/filter.c                                                      |   46 -
 net/core/skbuff.c                                                      |    9 
 net/core/skmsg.c                                                       |    4 
 net/core/sock_map.c                                                    |    1 
 net/ipv4/arp.c                                                         |    1 
 net/ipv4/fib_semantics.c                                               |   13 
 net/ipv4/fou_core.c                                                    |    4 
 net/ipv4/inet_connection_sock.c                                        |    3 
 net/ipv4/ip_gre.c                                                      |   12 
 net/ipv4/ipconfig.c                                                    |   92 +-
 net/ipv4/tcp_output.c                                                  |    3 
 net/ipv4/udp.c                                                         |   42 -
 net/ipv6/exthdrs_core.c                                                |    3 
 net/ipv6/ip6_fib.c                                                     |    2 
 net/ipv6/ip6_gre.c                                                     |    2 
 net/ipv6/netfilter/ip6t_rpfilter.c                                     |    2 
 net/ipv6/netfilter/ip6t_rt.c                                           |   11 
 net/ipv6/route.c                                                       |   12 
 net/ipv6/seg6.c                                                        |    4 
 net/llc/llc_c_ac.c                                                     |    2 
 net/llc/llc_s_ac.c                                                     |    4 
 net/llc/llc_sap.c                                                      |    8 
 net/mctp/route.c                                                       |    2 
 net/mptcp/protocol.c                                                   |    2 
 net/netfilter/ipvs/ip_vs_core.c                                        |    6 
 net/netfilter/nf_conntrack_netlink.c                                   |    3 
 net/netfilter/nf_flow_table_offload.c                                  |    7 
 net/netfilter/nf_tables_api.c                                          |   18 
 net/netfilter/nfnetlink_queue.c                                        |    8 
 net/netfilter/nft_synproxy.c                                           |    3 
 net/netlink/genetlink.c                                                |    8 
 net/nfc/core.c                                                         |   15 
 net/nfc/digital_dep.c                                                  |    8 
 net/nfc/llcp.h                                                         |    1 
 net/nfc/llcp_commands.c                                                |    2 
 net/nfc/llcp_core.c                                                    |  175 +++-
 net/nfc/llcp_sock.c                                                    |   65 +
 net/nfc/nci/core.c                                                     |   10 
 net/nfc/netlink.c                                                      |    7 
 net/nfc/nfc.h                                                          |    3 
 net/openvswitch/conntrack.c                                            |   37 
 net/packet/af_packet.c                                                 |  104 +-
 net/rds/ib_frmr.c                                                      |   11 
 net/rose/rose_in.c                                                     |   13 
 net/rose/rose_link.c                                                   |    5 
 net/rose/rose_route.c                                                  |   81 +-
 net/sched/act_api.c                                                    |    2 
 net/sched/act_ct.c                                                     |   41 -
 net/sched/act_gate.c                                                   |   30 
 net/sched/cls_u32.c                                                    |   12 
 net/sched/em_text.c                                                    |    2 
 net/sched/sch_hfsc.c                                                   |   22 
 net/sched/sch_teql.c                                                   |    7 
 net/sctp/associola.c                                                   |   15 
 net/sctp/input.c                                                       |    7 
 net/sctp/sm_sideeffect.c                                               |   37 
 net/sctp/sm_statefuns.c                                                |    2 
 net/smc/smc_core.c                                                     |    2 
 net/smc/smc_ib.c                                                       |   10 
 net/tipc/group.c                                                       |    4 
 net/tipc/monitor.c                                                     |    3 
 net/tls/tls_sw.c                                                       |    6 
 net/xdp/xskmap.c                                                       |    2 
 rust/kernel/net/phy.rs                                                 |   38 
 security/ipe/eval.c                                                    |   12 
 security/ipe/eval.h                                                    |    2 
 security/ipe/fs.c                                                      |    8 
 security/ipe/hooks.c                                                   |   22 
 security/ipe/policy_fs.c                                               |    3 
 sound/hda/codecs/realtek/alc269.c                                      |    9 
 tools/lib/bpf/libbpf.c                                                 |    7 
 tools/lib/bpf/relo_core.c                                              |   58 -
 tools/testing/selftests/bpf/prog_tests/linked_list.c                   |    4 
 tools/testing/selftests/cgroup/test_cpuset_prs.sh                      |    2 
 tools/testing/selftests/cgroup/test_memcontrol.c                       |    2 
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc |    2 
 tools/testing/selftests/nci/nci_dev.c                                  |   45 -
 virt/kvm/kvm_main.c                                                    |   30 
 382 files changed, 4951 insertions(+), 2271 deletions(-)

Aamir Ahmed (2):
      net: usb: catc: bound the RX packet length in catc_rx_done()
      nfc: llcp: drop truncated I/RR/RNR PDUs in nfc_llcp_recv_hdlc()

Abhishek Ojha (1):
      net: phy: micrel: Advance register data pointer in write loop

Aldo Ariel Panzardo (8):
      nfc: llcp: Fix list corruption / refcount desync in nfc_llcp_recv_dm()
      Bluetooth: hci_conn: fix CIS hold ownership on reuse
      Bluetooth: hci_sock: validate event length before filtering
      Bluetooth: hci_sock: reject out-of-range OCF values
      Bluetooth: ISO: balance the parent hold in hci_bind_bis()
      Bluetooth: ISO: release unused CIS holds after channel attach
      Bluetooth: L2CAP: validate frame length before control and FCS access
      Bluetooth: mgmt: fix race in read_unconf_index_list()

Aleksei Sviridkin (3):
      net: dsa: mt7530: fix NULL dereference on unbind of MT7531 and MT7621
      net: dsa: mt7530: leave the MDIO IRQ mappings to regmap-irq
      net: phylink: record the PHY only once bringup cannot fail

Alexander Duyck (3):
      eth: fbnic: reset num_napi when the napi vectors are freed
      eth: fbnic: Set AW_FLUSH_MODE alongside AW_FLUSH when flushing the mailbox
      eth: fbnic: Handle FW mailbox completions flagged with an error

Andre Przywara (1):
      pinctrl: sunxi: A523: fix voltage withstand encoding

Andrea Parri (2):
      bpf: fs/xattr: don't assume the inode is locked in path_unlink/path_rmdir
      net/mlx5e: fix swapped IPv6 IPsec policy masks

Angel J (1):
      PCI: of_property: Omit bus properties without a subordinate bus

Ankit Garg (6):
      gve: Consolidate and persist ethtool ring changes
      gve: Use extack to log xdp config verification errors
      gve: Allow ethtool to configure rx_buf_len
      gve: Advertise NETIF_F_GRO_HW instead of NETIF_F_LRO
      gve: Enable hw-gro by default if device supported
      gve: add support for UDP GSO for DQO format

Ankit Nautiyal (1):
      drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion Plus 14-ew1

Anthony Krowiak (1):
      s390/vfio-ap: fix KVM GISC and page leak when queue removed from host config

Aohan Mei (2):
      sctp: discard the rest of the packet on a stale-cookie error
      netfilter: nf_tables: skip expired catchall elements on insert and delete

Bart Van Assche (1):
      scsi: megaraid_sas: Protect megasas_get_ctrl_info() in megasas_resume()

Bartosz Golaszewski (1):
      gpio: cdev: fix kernel stack leak to user-space in error path

Bastien Nocera (1):
      HID: hid-alps: Use pm_ptr instead of #ifdef CONFIG_PM

Benjamin Leggett (1):
      drm/virtio: sync shmem backing on guest-bound transfers

Benjamin Tissoires (1):
      HID: bpf: fix __hid_bpf_hw_check_params report length

Bernard Ladenthin (1):
      net/sched: fix potential stack infoleak in em_text_dump()

Bernard Pidoux (4):
      rose: keep the route needed for routing loop detection
      rose: guard rose_transmit_link() against a NULL neighbour
      rose: use timer_shutdown_sync() for t0timer teardown
      rose: don't warn on stray CALL_ACCEPTED/CLEAR_CONFIRMATION in state 3

Bernardo Soares (2):
      net/mlx5: Bridge, don't fail switchdev events of sibling eswitch ports
      net/mlx5: Bridge, don't fail unlink of untracked/unsupported peer ports

Björn Töpel (3):
      eth: fbnic: Fix payload page pool error cleanup
      eth: fbnic: Handle maximum standalone channels
      eth: fbnic: Avoid rounding zero ring sizes

Borislav Petkov (AMD) (3):
      x86/sev: Move the internal header
      x86/sev: Add internal header guards
      x86/sev: Carve out the SVSM code into a separate compilation unit

Brajesh Gupta (2):
      drm/imagination: Propagate map failures correctly from pvr_mmu_map_sgl()
      drm/imagination: Fix page count for page table for map() interface

Chaithanya Lagisetty (1):
      selftests: nci: Fix uninitialized family ID on missing attribute

Chen Changcheng (2):
      HID: alps: fix use-after-free on input2 registration failure
      HID: alps: unregister DualPoint Stick input device on remove

Chris Gellermann (2):
      selftests/nci: Fix out-of-bounds store on thread join
      nfc: virtual_ncidev: Add missing ioctl compat handler

Christian Brauner (2):
      fs/ntfs3: use d_instantiate_new() in ntfs_create_inode() and murder syzbot's "WARNING in do_new_mount" saga
      super: make iterate_supers_type() deletion-safe

Christian König (1):
      drm/i915: fix incorrect RCU teardown order

Christiano Amora (1):
      Bluetooth: SMP: reject Security Request over BR/EDR

Chunfeng Song (1):
      rust: net: phy: fix off-by-one bit positions in device status accessors

Claudio Imbrenda (1):
      KVM: s390: Fix IRQ injection with SIGP Stop and Store Status

Coia Prant (2):
      net: pcs: xpcs: fix clock reference leak on xpcs_init_clks failure
      net: ethernet: stmmac: dwmac-rk: fix bulk clock leak when the PHY clock fails

Cong Nguyen (1):
      nfc: llcp: fix sdreq TLV list leak on parse/alloc/send failure

Dairui Zhang (1):
      af_packet: fix integer overflow in prb_calc_retire_blk_tmo()

Dan Carpenter (1):
      drm/nouveau/clk: fix list cursor use after loop in nvkm_clk_ustate_update

Daniel Borkmann (1):
      bpf: Fix bpf_skb_change_tail wrt csum partial skbs

Dapeng Mi (4):
      perf/x86/intel: Update event constraints and cache_extra_regsfor ADL
      perf/x86/intel: Fix GRT PEBS load/store direction for latency events, to fix sample classification
      perf/x86/intel: Update event constraints and cache_extra_regsfor LNL
      perf/x86/intel: Remove incorrect LionCove PEBS data-source constraints

Darrick J. Wong (15):
      xfs: don't stash removename operations with unknown ftype
      xfs: don't assert when XFS_SCRUB_TYPE_HEALTHY scans return corruption
      xfs: fix attr fork block count checks in xrep_inode_blockcounts
      xfs: release orphanage dir inode if chown fails
      xfs: use correct jiffies comparison function in xchk_maybe_relax
      xfs: check padding field in xfs_ioc_commit_range
      xfs: don't call xfs_exchange_range_finish for a dry run
      xfs: use the correct reservations for rtrmap/refcount recovery
      xfs: check di_forkoff correctly in scrub
      xfs: fix rtgroup repair estimations
      xfs: fix wild memcpy access when formatting ondisk rtrefcount btree roots
      xfs: call xfs_dquot_set_prealloc_limits if we installed default rtb limits
      xfs: don't let hidden_space go negative in xfs_metafile_resv_init
      xfs: fix blockgc group quota scanning when usrquota isn't enforced
      xfs: fix cursor and pointer handling when recovering iunlink buckets

David Ballesteros (1):
      KVM: Ensure memory attributes xarray nodes are accounted to the caller's memcg

David Carlier (1):
      arm64: errata: match the target implementation CPU's own MIDR

David Dai (1):
      bonding: crypto offload enabled, non-offload slave failover, rekey failed

Deepanshu Kartikey (1):
      nfc: pn533: fix OOB read in pn533_acr122_is_rx_frame_valid()

Dmitry Osipenko (1):
      Revert "drm/virtio: Allow importing prime buffers when 3D is enabled"

Donggeun Yoo (1):
      bpf, arm64: set up the frame pointer for the exception callback

Dongliang Qin (1):
      rds: ib: Clear the sg list when mapping an MR fails

Doruk Tan Ozturk (1):
      nfc: port100: reject frames whose declared length exceeds the received data

Eddie Phillips (1):
      gve: fix TX drop when GSO MSS is too small for hw

Emil Tsalapatis (2):
      bpf: Fix bounds check for skb-backed dynptrs
      bpf: Fix bpf_sock context code generation

Eric Dumazet (7):
      gve: DQO: fix header length used by gve_can_send_tso() for UDP GSO
      gve: DQO: reject TSO packets with an out of range MSS
      llc: fix skb UAF and leaks on llc_mac_hdr_init() failure
      bridge: check llc_mac_hdr_init() return value in br_send_bpdu()
      net/sched: sch_teql: fix shadowed err in __teql_resolve()
      vlan: ensure sufficient headroom in vlan_dev_hard_header()
      tipc: reject invalid and unexpected GRP_ACK_MSG to prevent bc_ackers underflow

Eva Kurchatova (1):
      selftests: cgroup: give the O_TMPFILE open in get_temp_fd() a mode

Fan Wu (2):
      ipe: fix use-after-free when auditing a newly loaded policy
      ipe: protect the dm-verity root hash with RCU

Florian Fainelli (5):
      net: bcmgenet: fix 64-bit RTNL stats reading in ethtool on 32-bit systems
      net: bcmgenet: initialize u64 stats seq counter for all queues
      net: bcmgenet: do not skip WoL power up on GENET V1
      net: bcmgenet: validate Ethernet address in bcmgenet_set_mac_addr
      net: bcmgenet: mask DMA_TIMEOUT_MASK when reading DMA_RING0_TIMEOUT

Florian Westphal (1):
      netfilter: nfnetlink_queue: hold nfnl mutex in event notifier

Fourie Zhang (1):
      net: bridge: mdb: restart port group walk after deletion

Francesco Magazzu (1):
      drm/nouveau/clk: don't clobber reclock status when restoring volt/fan

Fuad Tabba (9):
      KVM: arm64: vgic-its: Free the caches when GITS_BASER changes
      KVM: arm64: vgic-its: Skip unreachable devices instead of failing the save
      KVM: arm64: Validate the SVE vector length in pkvm_vcpu_init_sve()
      KVM: arm64: Do not clear VM-wide SVE feature on vCPU init failure
      KVM: arm64: Fix MTE flag initialization for protected VMs
      KVM: arm64: Include VM type when checking VM capabilities in pKVM
      KVM: arm64: Derive GUEST_HAS_SVE from the SVE feature bit at EL2
      arm64/boot: Disable trapping of PMZR_EL0 writes to EL2
      KVM: arm64: Transfer the hyp stack pages out of the host stage-2

Gajdos Tamás (3):
      net: atl1: fix soft lockup on out-of-range cmb_tpd_next_to_clean read
      net: atl1c: fix soft lockup on out-of-range tpd_cons read
      net: atl1e: fix soft lockup on out-of-range hw_next_to_clean read

Geliang Tang (1):
      bpf, sockmap: Fix self-redirect copied_seq double-counting

Ginger Li (1):
      tipc: Fix a data race on mon->peer_cnt in mon_timeout()

Giuseppe Ranieri (1):
      drm/nouveau/disp: don't reject HDMI config on cards without SCDC

Greg Kroah-Hartman (2):
      Revert "rust: net: phy: fix off-by-one bit positions in device status accessors"
      Linux 6.18.55

Guangshuo Li (3):
      drm/nouveau: fix autosuspend cleanup during teardown
      net: ena: fix PHC cleanup on probe failure
      net: ena: fix MMIO read buffer leak on probe failure

Guopeng Zhang (1):
      cgroup/pids: Restore pids.events notifications in local mode

Haseeb Malik (1):
      macsec: initialize SecY before registering the netdevice

Helge Deller (1):
      parisc: Increase kernel stack size to 32kb

Heyang Tan (1):
      octeontx2-af: use seq_file for rsrc_alloc debugfs

Holger Dengler (1):
      crypto: s390/hmac - Generate intermediate CV for API partial block handling

Hui Peng (8):
      Bluetooth: bnep: fix out-of-bounds reads on short RX/TX frames and control fallthrough
      Bluetooth: RFCOMM: Reject short EA=0 frames in rfcomm_recv_frame()
      autofs: fix sbi->pipe file reference leak in autofs_kill_sb()
      fou: reject omitted FOU_ATTR_IPPROTO on FOU_ENCAP_DIRECT
      ipv6: sr: enforce exact attribute length for SEG6_ATTR_DST
      mctp: route: iterate socket tag list in mctp_lookup_prealloc_tag()
      Bluetooth: RFCOMM: fix NULL dereference of dlc->session in RFCOMM_CONNINFO
      cgroup/cpuset: Return PERR_NOCPUS in remote_partition_enable() on subpartitions_cpus conflict

Ido Schimmel (1):
      vrf: Stop corrupting skb->csum when capturing CHECKSUM_COMPLETE packets

Ilya Maximets (5):
      net: openvswitch: conntrack: avoid modifying shared unconfirmed ct entry
      net: openvswitch: conntrack: remove 'add_helper' dead code
      net: openvswitch: conntrack: fix helper UAF due to extensions realloc
      net/sched: act_ct: fix helper UAF due to extensions realloc
      net/sched: act_ct: avoid modifying shared unconfirmed ct entry

Ilya Titov (1):
      pinctrl: sunxi: keep a shadow copy of the data register output latches

Imre Deak (2):
      drm/i915/dp_mst: Fix configuring FEC for a disconnected stream
      drm/i915/dp_mst: Fix configuring TUs for a disconnected stream

Ivan Delalande (1):
      tg3: use random MAC address when tg3_get_device_address fails

Ivan Lipski (1):
      drm/amd/display: Bump frame warning limit for clang builds of dml

Ivan Vecera (1):
      dpll: use exact lookup for reference sync pin id

Jaewook You (1):
      mm/hugetlb: preserve mremap address delta when skipping page tables

Jakub Kicinski (3):
      genetlink: report the real command id for dump-only ops in policy dumps
      veth: manage XDP program pointers during channel resize
      net: tls: fix silent data drop under pipe back-pressure

Jamal Hadi Salim (2):
      net/sched: cls_u32: fix manual hash table handle IDR aliasing
      net/sched: sch_hfsc: bound the classify inner-filter walk with a drift budget

Jiakai Xu (1):
      RISC-V: KVM: Fix null pointer dereference in kvm_riscv_aia_imsic_rw_attr()

Jiayuan Chen (5):
      bpf: Fix divide-by-zero in btf_struct_walk()
      bpf: Fix out-of-bounds read of sk_protocol in bpf_sock_destroy()
      tcp: Skip cond_resched() in inet_csk_listen_stop() under BPF context
      bpf: Fix out-of-bounds read of rtt_min in sock_ops
      bpf: Reject key-less BTF for hash maps

Jim Mattson (1):
      KVM: x86/pmu: Move Intel PMU global MSRs to intel_is_valid_msr()

Jinjiang Tu (1):
      mm/rmap: fix missing barrier between anon_vma init and vma->anon_vma publish

Johan Almbladh (2):
      bpf: Fix immediate JMP JEQ/JNE on MIPS32
      bpf: Fix BSWAP 32 and 16 on MIPS64

Jonghyuk Kim(MalHyuk) (1):
      drm/nouveau: RCU-free the scheduler-containing nouveau_sched

Jose Fernandez (Anthropic) (1):
      bpf: Avoid soft lockup in __htab_map_lookup_and_delete_batch()

Josef Bacik (1):
      writeback: report a Tasks-RCU quiescent state per cgwb drain pass

Joseph Qi (1):
      ocfs2: make ocfs2_calc_xattr_init() return void

Jouni Högander (3):
      drm/i915/psr: Disable Panel Replay on Dell XPS 14 DA14260 as a quirk
      drm/i915/psr: Fixes for Dell XPS DA14260 quirk
      drm/i915/psr: Disable PSR2 on Xiaomi Book Pro 14 2026 as a quirk

Julian Anastasov (1):
      ipvs: revalidate ihl before icmp_send

Julian Sun (1):
      fs: avoid repeated scans in evict_inodes()

Junjie Cao (1):
      HID: quirks: add ALWAYS_POLL quirk for SDINNOVATION gaming keyboard

Junrui Luo (4):
      drm/virtio: fix object leak when drm_gem_handle_create() fails
      drm/virtio: fix object leak in virtio_gpu_resource_create_ioctl()
      drm/virtio: fix object leaks in virtio_gpu_resource_create_blob_ioctl()
      drm/virtio: release the GEM object on virtio_gpu_vram_create() errors

Jérémy Jean (2):
      netfilter: flowtable: publish HW_DEAD after worker is done
      net: gue: reject invalid REMCSUM offsets

Karl Mehltretter (7):
      KVM: arm64: Return -EINVAL for an empty SMCCC filter range at base 0
      s390/pci/docs: Fix sriov_numvfs attribute name
      netfilter: nft_synproxy: use the family-aware checksum helper
      gpio: tps65219: Fix GPIO input value reads
      gpio: tps65219: Use the variant-specific direction callback
      gpio: tps65219: Fix TPS65214 GPIO direction programming
      KVM: arm64: Fix AArch32 DBGBXVR<n> handling

Kumar Kartikeya Dwivedi (4):
      bpf: Register dtor for freeing special fields
      bpf: Restrict CO-RE poisoning to relocatable instructions
      libbpf: Reject truncated ldimm64 CO-RE relocations
      bpf: Bound ownership depth through local kptrs and graph roots

Kuniyuki Iwashima (3):
      ip6_gre: Call ip6erspan_tunnel_unlink_md() in ip6erspan_changelink().
      ipv6: Prevent rt6_insert_exception() for dying fib6_info.
      ipv6: Fix dst leak for uncached routes.

Kyle Hendry (1):
      net: pcs: rzn1-miic: Fix config array initialization

Lee Jones (2):
      Bluetooth: mgmt: Dequeue pending mesh_send_sync entries on cancel
      nfc: llcp: Fix race condition in accept_queue lifecycle

Lei Zhu (1):
      selftests: nci: Correct pthread_create return value check

Leo Li (1):
      drm/amd/display: Atomize IRQ register read/modify/write ops

Li Youhong (1):
      drm/bridge: samsung-dsim: fix TE GPIO lifetime for host attach

Liew Rui Yan (1):
      mm/damon/core: fix unconditionally skip last region

Linkui Xiao (1):
      ipv4: fib: fix data-race and stale genid check around nh->nh_saddr

Liz Fong-Jones (1):
      PCI: Fix BAR resize for devices on a root bus

Longlong Xia (1):
      mm/hugetlb: do not dissolve gigantic pages without runtime support

Lorenzo Bianconi (2):
      net: ethernet: mtk_eth_soc: unregister net_devices in case of probe failure
      net: stmmac: clear stale buf->page after recycling on skb build failure

Lorenzo Stoakes (1):
      mm/rmap: allocate anon_vma_chain objects unlocked when possible

Lorenzo Stoakes (ARM) (2):
      KVM: arm64: Fix spurious warning for benign stage 2 teardown race
      KVM: arm64: nv: Fix null ptr deref on nested wp/unmap, teardown race

Lovekesh Solanki (1):
      HID: multitouch: Add report ID mismatch quirk for ASUS ROG Z13 Folio

Luxiao Xu (2):
      netfilter: ip6t_rt: fix zero-address non-strict match out-of-bounds read
      nfc: fix use-after-free in nfc_get_local_general_bytes

Manaf Meethalavalappu Pallikunhi (1):
      thermal: gov_step_wise: Fix stale mitigation vote with non-zero lower bounds

Marc Zyngier (1):
      KVM: arm64: vgic-v3: Fix GICv3 trapping in protected mode

Mario Limonciello (1):
      x86/PCI: Disable enhanced atomics on AMD NBIO 7.7 and 7.11

Mark Amirkan (1):
      mptcp: return sk_wait_data() errors from recvmsg()

Mark Brown (1):
      KVM: arm64: Fix FGT mapping for HFGITR_EL2.nGCSEPP

Masami Hiramatsu (Google) (1):
      x86/mce: Fix hardware debug register corruption on task migration

Matthew Auld (1):
      drm/xe/vm: nuke PTs only after unlinking contested VMAs

Matthew Brost (1):
      drm/xe: Keep walking on SVM eviction failure

Matthias Goergens (1):
      ata: libata-scsi: bound the ATA passthru sense descriptor writes

Maxime Chevallier (5):
      net: stmmac: selftests: Support running selftests on DSA conduits
      net: stmmac: selftests: Check the dev->features for S-TAG offload testing
      net: stmmac: selftests: Capture all packets for vlan checks
      net: stmmac: dwmac4: Use the correct bufzise when the len is exactly 8K
      net: stmmac: selftests: Account for alignment shift on dwmac1000 for Jumbo test

Melody Wang (1):
      x86/sev: Make vTPM SVSM calls preemption-safe

Mike Marciniszyn (Meta) (1):
      eth fbnic: Add debugfs hooks for firmware mailbox

Mikhail Zaslonko (2):
      s390/debug: Do not register views for failed static debug areas
      s390/debug: Fix NULL pointer dereference in debug_info_copy()

Ming Wang (1):
      net: usb: cdc_mbim: add MeiG Smart SRM821 to ZLP whitelist

Mohsin Bashir (1):
      eth: fbnic: Reuse RX mailbox pages

Mostafa Saleh (1):
      remoteproc: qcom_q6v5_adsp: Fix iommu_unmap() usage

Muhammad Bilal (1):
      net: spacemit: clear TX descriptor on fragment mapping failure

Myeonghun Pak (6):
      tg3: clean up PHYLIB resources on probe failure
      bna: prevent IOC timer rearm during teardown
      net: airoha: npu: cancel wdt_work after releasing the WDT IRQ
      nfc: trf7970a: power down on startup RX gain failure
      pinctrl: single: free the IRQ on domain creation failure
      RISC-V: KVM: Synchronize hrtimer callback during teardown

Naman Gulati (1):
      netfilter: ctnetlink: fix suspicious RCU usage in expect_iter_name

Namhyung Kim (1):
      perf/core: Fix a refcount leak in attach_perf_ctx_data()

Nemesa Garg (1):
      drm/i915/psr: Clear stale sel fetch enable bits on sel fetch disable

Nguyen Ngoc Thang (1):
      net/sched: act_ct: don't WARN on benign flow_offload_alloc() failure

Nicolai Buchwitz (1):
      net: bcmgenet: stop Tx NAPI before disabling the queues

Niklas Schnelle (5):
      docs: s390/pci: Improve and update PCI documentation
      s390/pci: Fix leak of struct pci_dev reference in zpci_report_status()
      s390/pci: Fix missing device lock in zpci_report_status()
      s390/pci: Report SCLP status on error events when no pdev is associated
      s390/pci: Don't report recovery success on skipped recovery

Nikunj A Dadhania (1):
      x86/sev: Remove redundant ghcbs_initialized checks around __sev_{get,put}_ghcb()

Norbert Szetei (2):
      net: xps: reject an out of range traffic class
      ipv6: do not let ipv6_find_hdr() return an offset past the packet end

Oscar Priego Verdugo (1):
      HID: elecom: fix bus type for M-XGL20DLBK

Pablo Neira Ayuso (2):
      rculist: add list_splice_rcu() for private lists
      netfilter: nf_tables: join hook list via splice_list_rcu() in commit phase

Patrick Lu (Anthropic) (1):
      writeback: bound cleanup_offline_cgwb() rescans by rotating scanned inodes

Pavankumar Kondeti (1):
      workqueue: Fix NULL current_pwq deref in flush dependency check

Peiyang He (5):
      drm/nouveau/uvmm: fix UAF in nouveau_uvmm_sm when BO is in TTM_PL_SYSTEM
      drm/nouveau: fix double-free in nvif_vmm_dtor
      drm/nouveau: don't bump pin count on failed re-pin in nouveau_bo_pin_locked()
      drm/virtio: fix memory leak of fence event on execbuffer failure
      drm/virtio: fix NULL pointer dereference on fence allocation failure

Pengpeng Hou (5):
      net: usb: sr9700: include receive overhead in the length check
      nfc: nfcmrvl: validate helper command length before pull
      nfc: st21nfca: validate received frame size
      nfc: st21nfca: validate ISO15693 inventory length
      drm/imagination: clamp freelist reconstruction requests

Peter Oberparleiter (1):
      s390/cmf: Fix virtual vs physical address confusion

Pu Lehui (1):
      bpf: Fix UAF due to concurrent consumption of ttrace lists in alloc_bulk

Puranjay Mohan (2):
      perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()
      perf/core: Run sched_task() for PMUs with only CPU-wide events

Ralf Lici (11):
      ovpn: preserve IPv6 scope id for netlink peer endpoints
      ovpn: skip UDP source validation for unspecified addresses
      ovpn: track UDP socket route key for peer dst cache
      ovpn: validate peer state before caching UDP dst
      ovpn: replace bind when learning local endpoint
      ovpn: replace bind when clearing stale local source
      ovpn: always unhash old VPN addresses before rehashing
      ovpn: reject duplicate peer VPN addresses
      ovpn: reject multipeer peers without VPN addresses
      ovpn: reject invalid peer VPN addresses
      net/mlx5e: advertise MACsec offload only when supported

Ran Hongyun (1):
      squashfs: Add dictionary size range check to prevent shift-out-of-bounds

Ratheesh Kannoth (1):
      octeontx2-af: Fix memory scaling limitation in SR-IOV mode

Ravindra (1):
      Bluetooth: btintel_pcie: validate device-supplied DMA indices

Ridham Khurana (1):
      gpio: zynq: fix runtime PM leak on request error path

SJ Park (1):
      mm/damon/vaddr: avoid hw-driven pte updates during damon_hugetlb_mkold()

Sang-Hoon Choi (1):
      nfp: hold IPsec RX state under the XArray lock

Sanghyun Park (1):
      vxlan: use one headroom snapshot for neighbour replies

Sean Anderson (1):
      pinctrl: meson: Fix typo in s4 group name

Sean Christopherson (6):
      perf/x86/intel: Ensure KVM guest PEBS path doesn't set unwanted PERF_GLOBAL_CTRL bits
      perf/x86/intel: Don't write PEBS_ENABLED on host<=>guest xfers if CPU has PEBS isolation, to fix stuck PEBS_ENABLED
      perf/x86/intel: Don't pointlessly context switch DS_AREA (and PEBS config) if PEBS is unused
      perf/x86/intel: Make @data a mandatory param for intel_guest_get_msrs()
      KVM: SEV: Free have_run_cpus during VM destruction even if VM is no longer SEV
      KVM: SEV: Do cache maintenance on the source VM during intra-host migration

Sean Rhodes (2):
      ALSA: hda/realtek: Limit Star Labs internal mic boost
      ALSA: hda/realtek: Add StarFighter HDA SSID

SeungJu Cheon (3):
      RISC-V: KVM: Preserve firmware counter value across stop/start
      RISC-V: KVM: Report snapshot write failure to the guest
      RISC-V: KVM: Fix perf-backed counter accounting across stop and read

Shardul Bankar (3):
      udp: relocate a connected socket in the 4-tuple hash table on re-connect
      udp: remove a disconnected socket from the 4-tuple hash table
      hfsplus: avoid double unload_nls() on mount failure

Shay Drory (1):
      net/mlx5: devcom, Base component size on linked devices

Shihuang Liu (1):
      net: skbuff: fix pull-bound underflow in skb_checksum_setup_ipv6()

Sidraya Jayagond (1):
      net/smc: fix UAF on lgr list traversal in smcr_port_err()

Slawomir Stepien (1):
      HID: amd_sfh: Validate PCI BAR size before mapping

Steffen Eiden (2):
      s390/uv: Fix loop condition in uv_find_secrets
      s390/uv: Prevent potential out-of-bounds read

Sven Schnelle (1):
      selftests/ftrace: Fix unique symbol check in kprobe_non_uniq_symbol.tc

Szymon Acedański (1):
      drm/xe: Limit sg segment size to PAGE_SIZE on Xen PV

Tan Chi (1):
      RISC-V: KVM: Fix HSM hart status error propagation

Tangudu Tilak Tirumalesh (1):
      drm/xe: harden adjust_idledly() against divide-by-zero and overflow

Tejun Heo (1):
      sched_ext: Derive SCX_RQ_IN_WAKEUP from the core enqueue flags

Thomas Zimmermann (2):
      drm/client: Remove holds_console_lock parameter from suspend/resume
      drm/client: Pass force parameter to client restore

Thorsten Blum (1):
      net: ipconfig: Remove outdated comment and indent code block

Théo Lebrun (1):
      net: macb: fix dma_alloc_coherent() leak on macb_alloc() error paths

Usama Arif (1):
      mm/hugetlb: create hstate_is_gigantic_no_runtime helper

Victor Nogueira (1):
      net/sched: act_gate: budget the per-entry list in get_fill_size

Viken Dadhaniya (1):
      i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL

Vineeth Vijayan (4):
      s390/cio: Fix cio_update_schib() to not cache invalid schib
      s390/cio: Check pmcw.dnv before pmcw.ena in I/O entry points
      s390/cio: Guard PMCW field accesses with dnv check
      s390/cio: Fix NULL pointer dereference in ccw_device_get_util_str()

Waiman Long (2):
      cgroup/cpuset: Move up prstate_housekeeping_conflict() helper
      cgroup/cpuset: Ensure domain isolated CPUs stay in root or isolated partition

Wei Jie LAW (1):
      HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()

Weiming Shi (5):
      bpf: Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL
      bpf: Skip unsettled links in link iterator
      bpf: Reject dev-bound-only programs on other devices
      net/sched: reject IDR error pointers when deleting actions
      netfilter: ip6t_rpfilter: reject routes without inet6_dev

Wentao Liang (13):
      fsl/fman: Fix clk reference leak in read_dts_node()
      gpio: arizona: Fix runtime PM leak in arizona_gpio_direction_out()
      drm/amd/display: Fix dc stream excess put in dm_update_crtc_state()
      drm/amdgpu: Fix last_update fence leak in amdgpu_vm_init()
      drm/amdgpu: Fix runtime PM leak in amdgpu_debugfs_test_ib_show()
      drm/amdgpu: Fix vmid_wait fence leak in amdgpu_ring_init()
      drm/nouveau: Fix bridge reference leak in nv1a_ram_new()
      drm/nouveau: Fix gem reference leak in validate_init()
      drm/nouveau: Fix runtime PM leak in nouveau_connector_detect()
      net/mlx5: Fix rev_entry reference leak in mlx5_tc_ct_shared_counter_get()
      net: hisilicon: hns_dsaf_mac: fix mdio device leak in hns_mac_register_phy()
      net: usb: lan78xx: Fix URB reference leak in lan78xx_submit_deferred_urbs()
      drm/amdgpu: Fix acpi device leak in amdgpu_acpi_enumerate_xcc()

Wenwu Hou (1):
      erofs: fix large folio race in erofs_fscache_req_complete

Willem de Bruijn (3):
      virtio_net: copy zerocopy frags in start_xmit without NAPI
      tcp: prevent collapsing skbs across boundary in rtx queue
      packet: use ubuf_info completion for TX_RING packets

Xiang Mei (1):
      vlan: require the MAC header to be present in __vlan_insert_inner_tag()

Xie Bo (2):
      RISC-V: KVM: Propagate interrupted G-stage faults
      RISC-V: KVM: Serialize IMSIC attributes with vCPU migration

Xin Long (1):
      sctp: hold asoc or transport before mod_timer() in timer handlers

Xuanqiang Luo (1):
      ip_gre: Reject enabling collect metadata through changelink

Yehyeong Lee (1):
      scsi: libiscsi_tcp: Check the data direction of a Data-In PDU

Yilin Zhang (1):
      tcp: fix use-after-free of retransmit_skb_hint in tcp_send_synack()

Yiqi Sun (1):
      sctp: avoid livelock while updating retransmit path

Yuqi Xu (2):
      bpf: Check params size before reading reserved fields
      net: ipconfig: bound DHCP option construction

ZHOU Jiaxiang (1):
      scsi: sd_zbc: Reject disks with too many zones

Zeng Chi (1):
      KVM: Don't treat reserved xarray entries as having memory attributes

Zeng Heng (1):
      arm64: io: Reject non-user protection in ioremap_prot()

Zhan Xusheng (1):
      sched/core: Account PSI IRQ time to the execution context, not the scheduling context

Zhang Yunfei (1):
      net: txgbe: fix FDIR filter restore for VF rules

Zhao Gongyi (1):
      bpf, sockmap: Reject max_entries > INT_MAX in sock_map_alloc

Zhiling Zou (1):
      xsk: Use a 32-bit compare in xsk_map_gen_lookup

Zihan Xi (4):
      smb: client: fix create context out-of-bounds reads
      smb: client: clean up failed cached directory opens
      smb: client: preserve create-context parsing errors
      smb: client: validate POSIX create context length

Zijie Huang (1):
      net: arp: terminate device name before lookup

Zijun Hu (1):
      Bluetooth: btnxpuart: Fix skb leak in nxp_process_fw_dump()

Zixuan Chai (1):
      llc: reserve device headroom for allocated frames

Zongmin Zhou (1):
      KVM: riscv: Fix NACL hfence entry update order

bui duc phuc (1):
      net: ethernet: ti: netcp: fix pm_runtime usage counter leak on error

shechenglong (1):
      drm/client: fix restore of partially initialized client

Ömer Mete Kaya (3):
      nfc: llcp: fix -ENOMEM on connect with zero-length service name
      nfc: llcp: fix WKS SAP hijacking via prefix match in nfc_llcp_wks_sap()
      nfc: llcp: fix slab-out-of-bounds reads when logging service names

