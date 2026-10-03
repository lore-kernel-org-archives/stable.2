Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC62420469;
	Sat,  3 Oct 2026 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791024893; cv=none; b=KPIgjmrilrfFw3UHh1p7UsKsNj3HPr50sayHgNHTy9k3xXbR92f+eFUCJ3LjQx+MdFpnLY/UBNm98+f88AVfWmm+gbHiA4qOJBH4BPthtTF6/A4hTbu3q3Qj7ROsa8sXxt2EIdJMwGgpkiNu5pbZt6ttW+WgFgXawziRzFrmUE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791024893; c=relaxed/simple;
	bh=RqmHGqJIzRLa4Ug/jVEA0C0WFkFBQhlfeJ3z5XVYP48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zn1IP/PWmiHpQekyBqrhPmhT8Imp865JOPJef10J9XrIkt9B3iVh6CORhbzFiToE9TlMlHtVObSY4J7iBReW6nSIv5NEaQUqRL39GhcQRrR3P53BOA69/fuwiUtdve2MHft/NQWpCzHvM8wYacpN579/UgdZDMJG6eYtxKSypKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CwBBegmF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CwBBegmF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2498A1F008A1;
	Sat,  3 Oct 2026 10:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791024878;
	bh=uYG9QfTgiNoB3ZU9AlA5X6pIntrZ9YleO1+dmYRmcKQ=;
	h=From:To:Cc:Subject:Date;
	b=CwBBegmFZXc0AnuhbHqGOXhuvbKAy2NEznzFO0EcA6Egsb7mjjuJm6zcaNJL/03Q0
	 +802AS6S5tIpyM3/qBGUKAYGTD+iVbiwIN07dgML31G/NtKRryblDXEIYLkxpzKYJB
	 fEco0++lX/KSjliJveJCKemv2GynUBEWwkFHPjNE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.2.9
Date: Sat,  3 Oct 2026 12:54:22 +0200
Message-ID: <2026100323-uncombed-july-abe2@gregkh>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.2.9 kernel.

All users of the 7.2 kernel series must upgrade.

The updated 7.2.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.2.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arch/arm64/booting.rst                                   |    1 
 Documentation/arch/s390/pci.rst                                        |    2 
 Documentation/devicetree/bindings/pinctrl/qcom,nord-tlmm.yaml          |    7 
 Makefile                                                               |    2 
 arch/arm64/include/asm/el2_setup.h                                     |    9 
 arch/arm64/include/asm/io.h                                            |    3 
 arch/arm64/include/asm/kvm_host.h                                      |    2 
 arch/arm64/include/asm/kvm_nested.h                                    |    3 
 arch/arm64/include/asm/kvm_pkvm.h                                      |    3 
 arch/arm64/kernel/cpu_errata.c                                         |   15 
 arch/arm64/kvm/arm.c                                                   |    8 
 arch/arm64/kvm/emulate-nested.c                                        |    2 
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h                          |    1 
 arch/arm64/kvm/hyp/nvhe/mem_protect.c                                  |    8 
 arch/arm64/kvm/hyp/nvhe/pkvm.c                                         |   25 
 arch/arm64/kvm/hyp/nvhe/setup.c                                        |   12 
 arch/arm64/kvm/hypercalls.c                                            |    3 
 arch/arm64/kvm/mmu.c                                                   |   15 
 arch/arm64/kvm/nested.c                                                |  111 ++-
 arch/arm64/kvm/sys_regs.c                                              |    1 
 arch/arm64/kvm/vgic/vgic-its.c                                         |   43 -
 arch/arm64/net/bpf_jit_comp.c                                          |    2 
 arch/mips/net/bpf_jit_comp32.c                                         |    2 
 arch/mips/net/bpf_jit_comp64.c                                         |    3 
 arch/parisc/include/asm/thread_info.h                                  |    2 
 arch/parisc/kernel/setup.c                                             |   12 
 arch/riscv/include/asm/csr.h                                           |   20 
 arch/riscv/kvm/aia_imsic.c                                             |   11 
 arch/riscv/kvm/mmu.c                                                   |   10 
 arch/riscv/kvm/nacl.c                                                  |   20 
 arch/riscv/kvm/vcpu.c                                                  |    3 
 arch/riscv/kvm/vcpu_exit.c                                             |    2 
 arch/riscv/kvm/vcpu_onereg.c                                           |    8 
 arch/riscv/kvm/vcpu_pmu.c                                              |   33 -
 arch/riscv/kvm/vcpu_sbi_hsm.c                                          |    4 
 arch/riscv/kvm/vcpu_timer.c                                            |    5 
 arch/s390/crypto/hmac_s390.c                                           |    5 
 arch/s390/include/asm/debug.h                                          |    8 
 arch/s390/kernel/debug.c                                               |   15 
 arch/s390/kernel/uv.c                                                  |    8 
 arch/s390/kvm/dat.c                                                    |   41 +
 arch/s390/kvm/gaccess.c                                                |   13 
 arch/s390/kvm/gmap.c                                                   |    6 
 arch/s390/kvm/interrupt.c                                              |  147 ++---
 arch/s390/pci/pci_event.c                                              |    7 
 arch/s390/pci/pci_report.c                                             |   32 -
 arch/s390/pci/pci_report.h                                             |    4 
 arch/x86/coco/sev/svsm.c                                               |   10 
 arch/x86/events/amd/brs.c                                              |    9 
 arch/x86/events/amd/lbr.c                                              |   16 
 arch/x86/events/intel/core.c                                           |   80 +-
 arch/x86/events/intel/ds.c                                             |   68 --
 arch/x86/events/intel/lbr.c                                            |   65 +-
 arch/x86/events/perf_event.h                                           |    4 
 arch/x86/include/asm/kvm-x86-nested-ops.h                              |   36 +
 arch/x86/include/asm/kvm_host.h                                        |   22 
 arch/x86/kernel/cpu/mce/core.c                                         |   27 
 arch/x86/kvm/hyperv.c                                                  |    6 
 arch/x86/kvm/irq.h                                                     |    6 
 arch/x86/kvm/mmu.h                                                     |    5 
 arch/x86/kvm/mmu/mmu.c                                                 |  129 +++-
 arch/x86/kvm/mmu/mmu_internal.h                                        |   66 --
 arch/x86/kvm/mmu/paging_tmpl.h                                         |    2 
 arch/x86/kvm/pmu.c                                                     |    8 
 arch/x86/kvm/svm/nested.c                                              |    1 
 arch/x86/kvm/svm/sev.c                                                 |   18 
 arch/x86/kvm/svm/svm.c                                                 |    1 
 arch/x86/kvm/tss.h                                                     |    7 
 arch/x86/kvm/vmx/nested.c                                              |    1 
 arch/x86/kvm/vmx/pmu_intel.c                                           |    3 
 arch/x86/kvm/vmx/vmx.c                                                 |    2 
 arch/x86/kvm/x86.c                                                     |   62 +-
 arch/x86/kvm/x86.h                                                     |    2 
 arch/x86/pci/fixup.c                                                   |   99 +++
 block/blk-zoned.c                                                      |   15 
 drivers/accel/ivpu/ivpu_drv.c                                          |   31 -
 drivers/accel/ivpu/ivpu_drv.h                                          |    7 
 drivers/accel/ivpu/ivpu_hw.c                                           |    4 
 drivers/accel/ivpu/ivpu_ipc.c                                          |    8 
 drivers/accel/ivpu/ivpu_ipc.h                                          |    2 
 drivers/accel/ivpu/ivpu_job.c                                          |   66 +-
 drivers/accel/ivpu/ivpu_job.h                                          |    7 
 drivers/accel/ivpu/ivpu_mmu.c                                          |    1 
 drivers/accel/ivpu/ivpu_pm.c                                           |    1 
 drivers/ata/libata-scsi.c                                              |   10 
 drivers/base/cacheinfo.c                                               |   11 
 drivers/bluetooth/btintel_pcie.c                                       |   16 
 drivers/bluetooth/btnxpuart.c                                          |    8 
 drivers/dpll/dpll_netlink.c                                            |    3 
 drivers/firewire/core-cdev.c                                           |    6 
 drivers/gpio/gpio-arizona.c                                            |    8 
 drivers/gpio/gpio-tps65219.c                                           |   12 
 drivers/gpio/gpio-zynq.c                                               |   10 
 drivers/gpio/gpiolib-cdev.c                                            |   32 -
 drivers/gpio/gpiolib.c                                                 |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                               |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                            |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c                     |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c                              |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h                              |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                                 |    1 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c                                |    3 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c                                |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                               |   71 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                      |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h                      |   12 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c                 |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c              |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c                  |   62 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h                  |   28 
 drivers/gpu/drm/amd/display/dc/dml/Makefile                            |    8 
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile                         |    2 
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c                        |  178 +++---
 drivers/gpu/drm/bridge/samsung-dsim.c                                  |    2 
 drivers/gpu/drm/clients/drm_fbdev_client.c                             |    8 
 drivers/gpu/drm/drm_pagemap.c                                          |   12 
 drivers/gpu/drm/i915/display/intel_cursor.c                            |    7 
 drivers/gpu/drm/i915/display/intel_display_types.h                     |    2 
 drivers/gpu/drm/i915/display/intel_dp_mst.c                            |   24 
 drivers/gpu/drm/i915/display/intel_dp_mst.h                            |    2 
 drivers/gpu/drm/i915/display/intel_link_bw.c                           |    3 
 drivers/gpu/drm/i915/display/intel_psr.c                               |   15 
 drivers/gpu/drm/i915/display/intel_quirks.c                            |    3 
 drivers/gpu/drm/i915/display/skl_universal_plane.c                     |    9 
 drivers/gpu/drm/i915/gem/i915_gem_object.c                             |    2 
 drivers/gpu/drm/imagination/pvr_free_list.c                            |   15 
 drivers/gpu/drm/imagination/pvr_mmu.c                                  |   19 
 drivers/gpu/drm/imagination/pvr_mmu.h                                  |    2 
 drivers/gpu/drm/imagination/pvr_vm.c                                   |    4 
 drivers/gpu/drm/nouveau/nouveau_bo.c                                   |    3 
 drivers/gpu/drm/nouveau/nouveau_connector.c                            |    5 
 drivers/gpu/drm/nouveau/nouveau_dmem.c                                 |    4 
 drivers/gpu/drm/nouveau/nouveau_drm.c                                  |    5 
 drivers/gpu/drm/nouveau/nouveau_gem.c                                  |    2 
 drivers/gpu/drm/nouveau/nouveau_sched.c                                |    2 
 drivers/gpu/drm/nouveau/nouveau_sched.h                                |    1 
 drivers/gpu/drm/nouveau/nouveau_uvmm.c                                 |   13 
 drivers/gpu/drm/nouveau/nvif/vmm.c                                     |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c                       |    3 
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c                         |   23 
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c                       |    2 
 drivers/gpu/drm/virtio/virtgpu_drv.h                                   |    5 
 drivers/gpu/drm/virtio/virtgpu_gem.c                                   |    2 
 drivers/gpu/drm/virtio/virtgpu_ioctl.c                                 |   49 +
 drivers/gpu/drm/virtio/virtgpu_prime.c                                 |    2 
 drivers/gpu/drm/virtio/virtgpu_submit.c                                |   11 
 drivers/gpu/drm/virtio/virtgpu_vq.c                                    |   46 +
 drivers/gpu/drm/virtio/virtgpu_vram.c                                  |   17 
 drivers/gpu/drm/xe/regs/xe_gt_regs.h                                   |    1 
 drivers/gpu/drm/xe/xe_bo.c                                             |    7 
 drivers/gpu/drm/xe/xe_bo.h                                             |   19 
 drivers/gpu/drm/xe/xe_gt_throttle.c                                    |    5 
 drivers/gpu/drm/xe/xe_guc_ads.c                                        |    2 
 drivers/gpu/drm/xe/xe_hw_engine.c                                      |   96 ++-
 drivers/gpu/drm/xe/xe_vm.c                                             |   21 
 drivers/gpu/drm/xe/xe_wa_oob.rules                                     |    2 
 drivers/hid/amd-sfh-hid/amd_sfh_common.h                               |    4 
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c                                 |   10 
 drivers/hid/bpf/hid_bpf_dispatch.c                                     |   12 
 drivers/hid/hid-alps.c                                                 |   25 
 drivers/hid/hid-ids.h                                                  |    3 
 drivers/hid/hid-multitouch.c                                           |   29 
 drivers/hid/hid-oxp.c                                                  |    6 
 drivers/hid/hid-quirks.c                                               |    3 
 drivers/hid/hid-winwing.c                                              |   10 
 drivers/hid/wacom_sys.c                                                |    5 
 drivers/i2c/busses/i2c-qcom-geni.c                                     |  293 +++++-----
 drivers/net/bonding/bond_main.c                                        |    2 
 drivers/net/dsa/mt7530-mdio.c                                          |   20 
 drivers/net/dsa/mt7530.c                                               |    3 
 drivers/net/dsa/mv88e6xxx/chip.c                                       |   68 ++
 drivers/net/ethernet/airoha/airoha_npu.c                               |   18 
 drivers/net/ethernet/amazon/ena/ena_netdev.c                           |    2 
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c                        |    3 
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c                        |    3 
 drivers/net/ethernet/atheros/atlx/atl1.c                               |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                      |    3 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                         |   34 -
 drivers/net/ethernet/broadcom/tg3.c                                    |   15 
 drivers/net/ethernet/brocade/bna/bnad.c                                |   24 
 drivers/net/ethernet/cadence/macb_main.c                               |   14 
 drivers/net/ethernet/freescale/fman/fman.c                             |    1 
 drivers/net/ethernet/google/gve/gve_desc_dqo.h                         |    5 
 drivers/net/ethernet/google/gve/gve_tx_dqo.c                           |   40 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c                      |    3 
 drivers/net/ethernet/ibm/emac/core.c                                   |   16 
 drivers/net/ethernet/marvell/octeontx2/af/common.h                     |   45 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c                |  104 +--
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                            |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c                |   45 +
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c                     |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c            |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c              |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                      |    1 
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c                   |   15 
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h                   |    2 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                      |   44 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c               |    1 
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c                   |    5 
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h                            |    5 
 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c                        |    4 
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c                        |   16 
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c                             |   47 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h                             |    1 
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c                            |   18 
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c                           |   30 -
 drivers/net/ethernet/netronome/nfp/crypto/ipsec.c                      |    3 
 drivers/net/ethernet/spacemit/k1_emac.c                                |    3 
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c                         |    5 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c                     |    4 
 drivers/net/ethernet/stmicro/stmmac/hwif.h                             |    2 
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c                        |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                      |   21 
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c                 |  153 ++++-
 drivers/net/ethernet/ti/netcp_core.c                                   |    2 
 drivers/net/ethernet/wangxun/libwx/wx_hw.c                             |    1 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                            |   65 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h                            |    1 
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c                            |  159 +++--
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h                            |    1 
 drivers/net/ethernet/wangxun/libwx/wx_type.h                           |    2 
 drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c                        |   13 
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c                        |   16 
 drivers/net/macsec.c                                                   |   84 +-
 drivers/net/mdio/mdio-realtek-rtl9300.c                                |    6 
 drivers/net/ovpn/netlink.c                                             |  108 +++
 drivers/net/ovpn/peer.c                                                |  121 +++-
 drivers/net/ovpn/peer.h                                                |   25 
 drivers/net/ovpn/udp.c                                                 |  193 +++++-
 drivers/net/pcs/pcs-rzn1-miic.c                                        |    3 
 drivers/net/pcs/pcs-xpcs.c                                             |    4 
 drivers/net/phy/intel-xway.c                                           |   29 
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
 drivers/perf/arm_brbe.c                                                |    2 
 drivers/pinctrl/meson/pinctrl-meson-s4.c                               |    2 
 drivers/pinctrl/microchip/pinctrl-mpfs-mssio.c                         |    6 
 drivers/pinctrl/pinctrl-generic.c                                      |    4 
 drivers/pinctrl/pinctrl-single.c                                       |    3 
 drivers/pinctrl/qcom/pinctrl-ipq5210.c                                 |    1 
 drivers/pinctrl/qcom/pinctrl-nord.c                                    |   34 -
 drivers/pinctrl/sunxi/pinctrl-sun55i-a523-r.c                          |    2 
 drivers/pinctrl/sunxi/pinctrl-sun55i-a523.c                            |    2 
 drivers/pinctrl/sunxi/pinctrl-sunxi.c                                  |   82 ++
 drivers/pinctrl/sunxi/pinctrl-sunxi.h                                  |    9 
 drivers/pinctrl/tegra/pinctrl-tegra238.c                               |  204 +++---
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
 drivers/ufs/core/ufshcd.c                                              |    6 
 drivers/ufs/host/ufshcd-pltfrm.c                                       |    6 
 fs/autofs/inode.c                                                      |    4 
 fs/bpf_fs_kfuncs.c                                                     |    4 
 fs/fs-writeback.c                                                      |   25 
 fs/inode.c                                                             |   11 
 fs/kernfs/mount.c                                                      |    4 
 fs/netfs/buffered_read.c                                               |   34 -
 fs/netfs/objects.c                                                     |    4 
 fs/netfs/read_collect.c                                                |    5 
 fs/netfs/rolling_buffer.c                                              |    2 
 fs/ntfs3/inode.c                                                       |    7 
 fs/ocfs2/namei.c                                                       |    9 
 fs/ocfs2/xattr.c                                                       |   13 
 fs/ocfs2/xattr.h                                                       |    8 
 fs/overlayfs/overlayfs.h                                               |    4 
 fs/smb/client/cached_dir.c                                             |   32 -
 fs/smb/client/dir.c                                                    |   52 +
 fs/smb/client/smb2inode.c                                              |    6 
 fs/smb/client/smb2misc.c                                               |    9 
 fs/smb/client/smb2ops.c                                                |   28 
 fs/smb/client/smb2pdu.c                                                |   54 +
 fs/smb/client/transport.c                                              |   71 +-
 fs/squashfs/xz_wrapper.c                                               |    6 
 fs/super.c                                                             |  114 +--
 fs/xfs/libxfs/xfs_metafile.c                                           |    8 
 fs/xfs/libxfs/xfs_rtrefcount_btree.c                                   |    4 
 fs/xfs/scrub/dir.c                                                     |    2 
 fs/xfs/scrub/health.c                                                  |    6 
 fs/xfs/scrub/inode.c                                                   |    2 
 fs/xfs/scrub/inode_repair.c                                            |    2 
 fs/xfs/scrub/newbt.c                                                   |    8 
 fs/xfs/scrub/orphanage.c                                               |    6 
 fs/xfs/scrub/repair.c                                                  |   19 
 fs/xfs/scrub/scrub.h                                                   |    2 
 fs/xfs/scrub/trace.h                                                   |   12 
 fs/xfs/xfs_dquot.c                                                     |    8 
 fs/xfs/xfs_exchrange.c                                                 |   13 
 fs/xfs/xfs_healthmon.c                                                 |    4 
 fs/xfs/xfs_icache.c                                                    |    2 
 fs/xfs/xfs_log_recover.c                                               |   13 
 fs/xfs/xfs_qm.c                                                        |   10 
 fs/xfs/xfs_refcount_item.c                                             |    8 
 fs/xfs/xfs_rmap_item.c                                                 |    8 
 include/linux/ethtool.h                                                |    2 
 include/linux/fs/super_types.h                                         |    2 
 include/linux/if_vlan.h                                                |    3 
 include/linux/mempool.h                                                |    7 
 include/linux/mm_types.h                                               |   15 
 include/linux/perf_event.h                                             |   17 
 include/linux/sched.h                                                  |    6 
 include/linux/sched/topology.h                                         |    4 
 include/linux/skbuff.h                                                 |   24 
 include/net/dst.h                                                      |    3 
 include/net/gue.h                                                      |   19 
 include/net/ip6_route.h                                                |    4 
 include/net/netfilter/nf_conntrack.h                                   |    5 
 include/net/nfc/hci.h                                                  |    2 
 include/net/nfc/nfc.h                                                  |    3 
 include/net/tcp.h                                                      |    4 
 kernel/bpf/btf.c                                                       |  136 ++--
 kernel/bpf/core.c                                                      |   21 
 kernel/bpf/crypto.c                                                    |    5 
 kernel/bpf/fixups.c                                                    |   24 
 kernel/bpf/hashtab.c                                                   |   43 +
 kernel/bpf/memalloc.c                                                  |   50 -
 kernel/bpf/offload.c                                                   |    2 
 kernel/bpf/states.c                                                    |    3 
 kernel/bpf/syscall.c                                                   |   15 
 kernel/bpf/verifier.c                                                  |   17 
 kernel/cgroup/cpuset.c                                                 |    3 
 kernel/cgroup/pids.c                                                   |    5 
 kernel/events/core.c                                                   |   17 
 kernel/exit.c                                                          |   11 
 kernel/kprobes.c                                                       |   22 
 kernel/power/hibernate.c                                               |   26 
 kernel/sched/core.c                                                    |    2 
 kernel/sched/ext/ext.c                                                 |    7 
 kernel/sched/fair.c                                                    |  173 ++++-
 kernel/sched/topology.c                                                |   22 
 kernel/trace/fprobe.c                                                  |   15 
 kernel/workqueue.c                                                     |    2 
 mm/backing-dev.c                                                       |    5 
 mm/damon/core.c                                                        |   39 -
 mm/damon/ops-common.c                                                  |    7 
 mm/damon/vaddr.c                                                       |   21 
 mm/hugetlb.c                                                           |   20 
 mm/rmap.c                                                              |    6 
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
 net/core/dev.c                                                         |   49 +
 net/core/dev.h                                                         |    2 
 net/core/dev_ioctl.c                                                   |   25 
 net/core/filter.c                                                      |   46 -
 net/core/skbuff.c                                                      |   21 
 net/core/skmsg.c                                                       |    4 
 net/core/sock_map.c                                                    |    1 
 net/ethtool/common.h                                                   |    2 
 net/ipv4/arp.c                                                         |    1 
 net/ipv4/devinet.c                                                     |    7 
 net/ipv4/fib_semantics.c                                               |   13 
 net/ipv4/fou_core.c                                                    |    4 
 net/ipv4/inet_connection_sock.c                                        |    3 
 net/ipv4/ip_gre.c                                                      |   12 
 net/ipv4/ipconfig.c                                                    |   45 -
 net/ipv4/tcp_output.c                                                  |    3 
 net/ipv4/udp.c                                                         |   42 +
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
 net/netfilter/nf_tables_api.c                                          |   10 
 net/netfilter/nfnetlink_queue.c                                        |    8 
 net/netfilter/nft_synproxy.c                                           |    3 
 net/netlink/genetlink.c                                                |    8 
 net/nfc/core.c                                                         |   15 
 net/nfc/digital_dep.c                                                  |    8 
 net/nfc/llcp.h                                                         |    1 
 net/nfc/llcp_commands.c                                                |    2 
 net/nfc/llcp_core.c                                                    |  175 ++++-
 net/nfc/llcp_sock.c                                                    |   65 +-
 net/nfc/nci/core.c                                                     |   10 
 net/nfc/netlink.c                                                      |    7 
 net/nfc/nfc.h                                                          |    3 
 net/openvswitch/conntrack.c                                            |   37 -
 net/packet/af_packet.c                                                 |  104 ++-
 net/rds/connection.c                                                   |    6 
 net/rds/ib_frmr.c                                                      |   11 
 net/sched/act_api.c                                                    |    2 
 net/sched/act_ct.c                                                     |   41 +
 net/sched/act_gate.c                                                   |   30 -
 net/sched/act_ife.c                                                    |   17 
 net/sched/act_meta_mark.c                                              |    6 
 net/sched/act_meta_skbprio.c                                           |    6 
 net/sched/act_meta_skbtcindex.c                                        |    6 
 net/sched/cls_u32.c                                                    |   12 
 net/sched/em_text.c                                                    |    2 
 net/sched/sch_hfsc.c                                                   |   22 
 net/sched/sch_teql.c                                                   |    7 
 net/sctp/associola.c                                                   |   15 
 net/sctp/input.c                                                       |    7 
 net/sctp/sm_sideeffect.c                                               |   37 -
 net/sctp/sm_statefuns.c                                                |    2 
 net/smc/smc_core.c                                                     |    2 
 net/smc/smc_ib.c                                                       |   10 
 net/tipc/group.c                                                       |    4 
 net/tipc/monitor.c                                                     |    3 
 net/vmw_vsock/af_vsock.c                                               |    3 
 net/xdp/xskmap.c                                                       |    2 
 security/ipe/eval.c                                                    |   12 
 security/ipe/eval.h                                                    |    2 
 security/ipe/fs.c                                                      |    8 
 security/ipe/hooks.c                                                   |   22 
 security/ipe/policy_fs.c                                               |    3 
 security/landlock/access.h                                             |    8 
 sound/hda/codecs/realtek/alc269.c                                      |    9 
 tools/arch/riscv/include/asm/csr.h                                     |   20 
 tools/lib/bpf/libbpf.c                                                 |    7 
 tools/lib/bpf/relo_core.c                                              |   58 +
 tools/testing/selftests/bpf/prog_tests/linked_list.c                   |    4 
 tools/testing/selftests/cgroup/test_cpuset_prs.sh                      |    2 
 tools/testing/selftests/cgroup/test_memcontrol.c                       |    2 
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc |    2 
 tools/testing/selftests/kvm/steal_time.c                               |   30 -
 tools/testing/selftests/nci/nci_dev.c                                  |   45 -
 virt/kvm/kvm_main.c                                                    |   30 -
 471 files changed, 5761 insertions(+), 2577 deletions(-)

Aamir Ahmed (2):
      net: usb: catc: bound the RX packet length in catc_rx_done()
      nfc: llcp: drop truncated I/RR/RNR PDUs in nfc_llcp_recv_hdlc()

Abhishek Ojha (1):
      net: phy: micrel: Advance register data pointer in write loop

Adarsh Das (1):
      smb: client: delete compound mids on send failure before unlock

Aldo Ariel Panzardo (9):
      nfc: llcp: Fix list corruption / refcount desync in nfc_llcp_recv_dm()
      vsock: ignore empty child namespace mode writes
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

Alex Hung (1):
      drm/amd/display: Relax DML frame limit with UBSAN

Alexander Duyck (5):
      net: ethtool: keep rtnl_lock for the ioctl self test
      eth: fbnic: use the Rx queue napi pointer to find the napi vector
      eth: fbnic: reset num_napi when the napi vectors are freed
      eth: fbnic: Set AW_FLUSH_MODE alongside AW_FLUSH when flushing the mailbox
      eth: fbnic: Handle FW mailbox completions flagged with an error

Alexander Sverdlin (1):
      net: phy: intel-xway: workaround 100BASE-TX Link-Up issue

Allison Henderson (1):
      net/rds: size a connection's path set by the transport it ends up with

Amir Goldstein (1):
      ovl: fix UAF in ovl_do_mkdir() debug print

Andre Przywara (1):
      pinctrl: sunxi: A523: fix voltage withstand encoding

Andrea Parri (3):
      bpf: fs/xattr: don't assume the inode is locked in path_unlink/path_rmdir
      kprobes: Fix permanent hang when flushing the kprobe optimizer
      net/mlx5e: fix swapped IPv6 IPsec policy masks

Angel J (1):
      PCI: of_property: Omit bus properties without a subordinate bus

Ankit Nautiyal (1):
      drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion Plus 14-ew1

Anthony Krowiak (1):
      s390/vfio-ap: fix KVM GISC and page leak when queue removed from host config

Aohan Mei (2):
      sctp: discard the rest of the packet on a stale-cookie error
      netfilter: nf_tables: skip expired catchall elements on insert and delete

Arnd Bergmann (1):
      landlock: Work around gcc-16 -Wuninitialized warning

Asad Kamal (1):
      drm/amdkfd: fix use-after-free and multi-container gap in kfd_dev_mapping

Bart Van Assche (1):
      scsi: megaraid_sas: Protect megasas_get_ctrl_info() in megasas_resume()

Bartosz Golaszewski (1):
      gpio: cdev: fix kernel stack leak to user-space in error path

Benjamin Leggett (1):
      drm/virtio: sync shmem backing on guest-bound transfers

Benjamin Tissoires (1):
      HID: bpf: fix __hid_bpf_hw_check_params report length

Bernard Ladenthin (1):
      net/sched: fix potential stack infoleak in em_text_dump()

Bernardo Soares (2):
      net/mlx5: Bridge, don't fail switchdev events of sibling eswitch ports
      net/mlx5: Bridge, don't fail unlink of untracked/unsupported peer ports

Björn Töpel (3):
      eth: fbnic: Fix payload page pool error cleanup
      eth: fbnic: Handle maximum standalone channels
      eth: fbnic: Avoid rounding zero ring sizes

Brajesh Gupta (2):
      drm/imagination: Propagate map failures correctly from pvr_mmu_map_sgl()
      drm/imagination: Fix page count for page table for map() interface

Chaithanya Lagisetty (1):
      selftests: nci: Fix uninitialized family ID on missing attribute

Chen Changcheng (2):
      HID: alps: unregister DualPoint Stick input device on remove
      HID: alps: fix use-after-free on input2 registration failure

Chris Gellermann (2):
      selftests/nci: Fix out-of-bounds store on thread join
      nfc: virtual_ncidev: Add missing ioctl compat handler

Christian Brauner (4):
      fs/ntfs3: use d_instantiate_new() in ntfs_create_inode() and murder syzbot's "WARNING in do_new_mount" saga
      super: convert s_count to refcount_t s_passive
      super: take lock after last reference count
      super: make iterate_supers_type() deletion-safe

Christian König (1):
      drm/i915: fix incorrect RCU teardown order

Christian Lamparter (1):
      net: emac: move setting of netops to fix crash

Christiano Amora (1):
      Bluetooth: SMP: reject Security Request over BR/EDR

Claudio Imbrenda (7):
      KVM: s390: Fix dirty marking in adapter_indicators_set*()
      KVM: s390: Fix _gaccess_shadow_fault()
      KVM: s390: Fix IRQ injection with SIGP Stop and Store Status
      KVM: s390: Add missing srcu in kvm_s390_set_irq_state()
      KVM: s390: Properly handle NULL pointer in dat_cond_set_storage_key()
      KVM: s390: Fix potential races in dat skey functions
      KVM: s390: Fix race in _destroy_pages_crste()

Coia Prant (2):
      net: pcs: xpcs: fix clock reference leak on xpcs_init_clks failure
      net: ethernet: stmmac: dwmac-rk: fix bulk clock leak when the PHY clock fails

Cong Nguyen (1):
      nfc: llcp: fix sdreq TLV list leak on parse/alloc/send failure

Conor Dooley (2):
      pinctrl: mpfs-mssio: fix width of unused bank voltage setting
      pinctrl: mpfs-mssio: use correct regmap function to set bank voltage

Dairui Zhang (1):
      af_packet: fix integer overflow in prb_calc_retire_blk_tmo()

Dan Carpenter (1):
      drm/nouveau/clk: fix list cursor use after loop in nvkm_clk_ustate_update

Daniel Borkmann (1):
      bpf: Fix bpf_skb_change_tail wrt csum partial skbs

Dapeng Mi (8):
      perf/x86/intel: Delete dead NVL PEBS data-source initcall
      perf/x86/intel: Fix CMT PEBS load/store direction for latency events, to fix sample classification
      perf/x86/intel: Fix GRT PEBS load/store direction for latency events, to fix sample classification
      perf/x86/intel: Fix DKT PEBS load/store direction for latency events, to fix sample classification
      perf/x86/intel: Fix Panther Cove PEBS data-source snoop states
      perf/x86/intel: Remove incorrect LionCove PEBS data-source constraints
      perf/x86/intel: Remove incorrect Panther Cove PEBS data-source constraints
      perf/x86/intel: Constrain Panther Cove UOPS_DISPATCHED events to PMCs 0-3

Darrick J. Wong (18):
      xfs: don't assert when XFS_SCRUB_TYPE_HEALTHY scans return corruption
      xfs: fix attr fork block count checks in xrep_inode_blockcounts
      xfs: release orphanage dir inode if chown fails
      xfs: use correct jiffies comparison function in xchk_maybe_relax
      xfs: check padding field in xfs_ioc_commit_range
      xfs: don't call xfs_exchange_range_finish for a dry run
      xfs: only flag zero padding for dir3 data blocks, not dir3 block blocks
      xfs: use the correct reservations for rtrmap/refcount recovery
      xfs: check di_forkoff correctly in scrub
      xfs: fix rtgroup repair estimations
      xfs: fix wild memcpy access when formatting ondisk rtrefcount btree roots
      xfs: call xfs_dquot_set_prealloc_limits if we installed default rtb limits
      xfs: don't let hidden_space go negative in xfs_metafile_resv_init
      xfs: don't let memory failures leak blocks and kill repairs
      xfs: don't merge different file IO error types
      xfs: drop dquot flush lock when we can't find a buffer to flush
      xfs: fix blockgc group quota scanning when usrquota isn't enforced
      xfs: fix cursor and pointer handling when recovering iunlink buckets

Davi Chaves Azevedo (1):
      sched/cache: Refresh LLC capacity across CPU hotplug, to fix capacity underestimation bug

David Ballesteros (1):
      KVM: Ensure memory attributes xarray nodes are accounted to the caller's memcg

David Carlier (2):
      arm64: errata: match the target implementation CPU's own MIDR
      fprobe: Terminate the fgraph_data list when the reservation is not filled

David Dai (1):
      bonding: crypto offload enabled, non-offload slave failover, rekey failed

David Howells (2):
      netfs: Fix netfs_read_gaps() to use separate sink folios
      netfs, afs: Fix symlink reading

Deepanshu Kartikey (1):
      nfc: pn533: fix OOB read in pn533_acr122_is_rx_frame_valid()

Dmitry Osipenko (1):
      Revert "drm/virtio: Allow importing prime buffers when 3D is enabled"

Dominik Kaszewski (1):
      drm/amd/display: Remove sink usage from DPMS

Donggeun Yoo (2):
      bpf, arm64: set up the frame pointer for the exception callback
      bpf: Zero-fill other CPUs when BPF_F_CPU creates a per-cpu hash element

Dongliang Qin (1):
      rds: ib: Clear the sg list when mapping an MR fails

Doruk Tan Ozturk (1):
      nfc: port100: reject frames whose declared length exceeds the received data

Eddie Phillips (1):
      gve: fix TX drop when GSO MSS is too small for hw

Emil Tsalapatis (3):
      bpf: Fix bounds check for skb-backed dynptrs
      bpf: Fix bpf_sock context code generation
      bpf: Reject pkt arguments in mutating subprogs

Eric Dumazet (8):
      net: flush skb_defer_nodes in dev_cpu_dead()
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

Fang Xieyan (1):
      net/sched: act_ife: validate metadata length before decoding

Florian Fainelli (5):
      net: bcmgenet: fix 64-bit RTNL stats reading in ethtool on 32-bit systems
      net: bcmgenet: initialize u64 stats seq counter for all queues
      net: bcmgenet: do not skip WoL power up on GENET V1
      net: bcmgenet: validate Ethernet address in bcmgenet_set_mac_addr
      net: bcmgenet: mask DMA_TIMEOUT_MASK when reading DMA_RING0_TIMEOUT

Florian Schmaus (1):
      PM: hibernate: Freeze kernel threads after image preallocation

Florian Westphal (1):
      netfilter: nfnetlink_queue: hold nfnl mutex in event notifier

Fourie Zhang (1):
      net: bridge: mdb: restart port group walk after deletion

Francesco Magazzu (1):
      drm/nouveau/clk: don't clobber reclock status when restoring volt/fan

Frank Wunderlich (1):
      gpiolib: use of_node_name if line-name is missing

Fuad Tabba (9):
      KVM: arm64: vgic-its: Free the caches when GITS_BASER changes
      KVM: arm64: vgic-its: Skip unreachable devices instead of failing the save
      KVM: arm64: Validate the SVE vector length in pkvm_vcpu_init_sve()
      KVM: arm64: Do not clear VM-wide SVE feature on vCPU init failure
      KVM: arm64: Derive GUEST_HAS_SVE from the SVE feature bit at EL2
      KVM: arm64: Match hyp text by physical address in fix_host_ownership()
      arm64/boot: Disable trapping of PMZR_EL0 writes to EL2
      KVM: arm64: Don't WARN on an unknown VM ioctl in protected mode
      KVM: arm64: Transfer the hyp stack pages out of the host stage-2

Gajdos Tamás (3):
      net: atl1: fix soft lockup on out-of-range cmb_tpd_next_to_clean read
      net: atl1c: fix soft lockup on out-of-range tpd_cons read
      net: atl1e: fix soft lockup on out-of-range hw_next_to_clean read

Geert Uytterhoeven (1):
      scsi: ufs: pltfrm: Add quirk for R-Car S4 lacking lanes-per-direction

Geliang Tang (1):
      bpf, sockmap: Fix self-redirect copied_seq double-counting

Ginger Li (1):
      tipc: Fix a data race on mon->peer_cnt in mon_timeout()

Giuseppe Ranieri (1):
      drm/nouveau/disp: don't reject HDMI config on cards without SCDC

Greg Kroah-Hartman (1):
      Linux 7.2.9

Guangshuo Li (3):
      drm/nouveau: fix autosuspend cleanup during teardown
      net: ena: fix PHC cleanup on probe failure
      net: ena: fix MMIO read buffer leak on probe failure

Guopeng Zhang (1):
      cgroup/pids: Restore pids.events notifications in local mode

Hao Ge (1):
      netfs: Fix missing alloc tagging of direct mempool allocations

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
      cgroup/cpuset: Return PERR_NOCPUS in remote_partition_enable() on subpartitions_cpus conflict
      fou: reject omitted FOU_ATTR_IPPROTO on FOU_ENCAP_DIRECT
      ipv6: sr: enforce exact attribute length for SEG6_ATTR_DST
      mctp: route: iterate socket tag list in mctp_lookup_prealloc_tag()
      Bluetooth: RFCOMM: fix NULL dereference of dlc->session in RFCOMM_CONNINFO

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

Jakub Kicinski (2):
      genetlink: report the real command id for dump-only ops in policy dumps
      veth: manage XDP program pointers during channel resize

Jakub Pawlak (1):
      accel/ivpu: Use separate flag for job timeout

Jamal Hadi Salim (2):
      net/sched: cls_u32: fix manual hash table handle IDR aliasing
      net/sched: sch_hfsc: bound the classify inner-filter walk with a drift budget

Jiawen Wu (2):
      net: wangxun: implement soft quiesce for PCIe error recovery
      net: libwx: fix races in Tx timestamp handling

Jiayuan Chen (4):
      bpf: Fix divide-by-zero in btf_struct_walk()
      bpf: Fix out-of-bounds read of sk_protocol in bpf_sock_destroy()
      tcp: Skip cond_resched() in inet_csk_listen_stop() under BPF context
      bpf: Fix out-of-bounds read of rtt_min in sock_ops

Jim Mattson (1):
      KVM: x86/pmu: Move Intel PMU global MSRs to intel_is_valid_msr()

Jinjiang Tu (1):
      mm/rmap: fix missing barrier between anon_vma init and vma->anon_vma publish

Johan Almbladh (2):
      bpf: Fix immediate JMP JEQ/JNE on MIPS32
      bpf: Fix BSWAP 32 and 16 on MIPS64

Jonas Jelonek (1):
      net: mdio: realtek-rtl9300: fix RTL931x C22 extended page selection

Jonghyuk Kim(MalHyuk) (1):
      drm/nouveau: RCU-free the scheduler-containing nouveau_sched

Jose Fernandez (Anthropic) (1):
      bpf: Avoid soft lockup in __htab_map_lookup_and_delete_batch()

Josef Bacik (1):
      writeback: report a Tasks-RCU quiescent state per cgwb drain pass

Joseph Qi (1):
      ocfs2: make ocfs2_calc_xattr_init() return void

Julian Anastasov (1):
      ipvs: revalidate ihl before icmp_send

Julian Sun (1):
      fs: avoid repeated scans in evict_inodes()

Junjie Cao (1):
      HID: quirks: add ALWAYS_POLL quirk for SDINNOVATION gaming keyboard

Junrui Luo (5):
      drm/virtio: fix object leak when drm_gem_handle_create() fails
      drm/virtio: fix object leak in virtio_gpu_resource_create_ioctl()
      drm/virtio: fix object leaks in virtio_gpu_resource_create_blob_ioctl()
      drm/virtio: release the GEM object on virtio_gpu_vram_create() errors
      drm/nouveau/dmem: pin VRAM for the whole registered range

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

Karol Wachowski (2):
      accel/ivpu: Use threaded IRQ for IPC callback processing
      accel/ivpu: Drop IRQF_ONESHOT to allow IPC IRQ threading on PREEMPT_RT

Kumar Kartikeya Dwivedi (5):
      bpf: Make post-verification instruction rewrites killable
      bpf: Preserve packet pointer class displacement in regsafe()
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

Liew Rui Yan (2):
      mm/damon/core: fix unconditionally skip last region
      mm/damon/core: allow esz to be set to zero

Linkui Xiao (1):
      ipv4: fib: fix data-race and stale genid check around nh->nh_saddr

Liz Fong-Jones (1):
      PCI: Fix BAR resize for devices on a root bus

Longlong Xia (1):
      mm/hugetlb: do not dissolve gigantic pages without runtime support

Lorenzo Bianconi (2):
      net: ethernet: mtk_eth_soc: unregister net_devices in case of probe failure
      net: stmmac: clear stale buf->page after recycling on skb build failure

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

Marc Zyngier (2):
      KVM: arm64: nv: Fix life cycle of the nested_mmus array
      KVM: arm64: nv: Delay freeing of shadow S2 structures until VM destruction

Mario Limonciello (1):
      x86/PCI: Disable enhanced atomics on AMD NBIO 7.7 and 7.11

Mark Amirkan (1):
      mptcp: return sk_wait_data() errors from recvmsg()

Mark Brown (1):
      KVM: arm64: Fix FGT mapping for HFGITR_EL2.nGCSEPP

Masami Hiramatsu (Google) (1):
      x86/mce: Fix hardware debug register corruption on task migration

Masoud Aghasi (1):
      bpf: Fix u32 overflow issue in map batch operations

Matthew Auld (1):
      drm/xe/vm: nuke PTs only after unlinking contested VMAs

Matthew Brost (2):
      drm/pagemap: dma-unmap pages before handling migration errors
      drm/xe: Keep walking on SVM eviction failure

Matthias Goergens (1):
      ata: libata-scsi: bound the ATA passthru sense descriptor writes

Maxime Chevallier (7):
      net: stmmac: selftests: Support running selftests on DSA conduits
      net: stmmac: selftests: Validate EEE based on the actual LPI timer value
      net: stmmac: selftests: Check the dev->features for S-TAG offload testing
      net: stmmac: selftests: Capture all packets for vlan checks
      net: stmmac: dwmac4: Use the correct bufzise when the len is exactly 8K
      net: stmmac: size the RX buffers from the frame length, not the MTU
      net: stmmac: selftests: Account for alignment shift on dwmac1000 for Jumbo test

Melody Wang (1):
      x86/sev: Make vTPM SVSM calls preemption-safe

Mikhail Zaslonko (2):
      s390/debug: Do not register views for failed static debug areas
      s390/debug: Fix NULL pointer dereference in debug_info_copy()

Ming Wang (1):
      net: usb: cdc_mbim: add MeiG Smart SRM821 to ZLP whitelist

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

Namjae Jeon (1):
      smb: client: use finish_no_open() for non-regular inodes

Nathan Gao (1):
      mm/damon/ops-common: use a page-aligned address in damon_ptep_mkold()

Nemesa Garg (1):
      drm/i915/psr: Clear stale sel fetch enable bits on sel fetch disable

Nguyen Ngoc Thang (1):
      net/sched: act_ct: don't WARN on benign flow_offload_alloc() failure

Nicolai Buchwitz (2):
      net: don't require the hwtstamp NDOs when a PHY provides timestamping
      net: bcmgenet: stop Tx NAPI before disabling the queues

Nicolo Giuliani (1):
      net: dsa: mv88e6xxx: 88E6191X and 88E6193X have no PTP

Niklas Schnelle (4):
      s390/pci: Fix leak of struct pci_dev reference in zpci_report_status()
      s390/pci: Fix missing device lock in zpci_report_status()
      s390/pci: Report SCLP status on error events when no pdev is associated
      s390/pci: Don't report recovery success on skipped recovery

Norbert Szetei (2):
      net: xps: reject an out of range traffic class
      ipv6: do not let ipv6_find_hdr() return an offset past the packet end

Oscar Priego Verdugo (1):
      HID: elecom: fix bus type for M-XGL20DLBK

Paolo Bonzini (1):
      KVM: move TSS constants from kvm_host.h to tss.h

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

Prathamesh Shete (1):
      pinctrl: tegra238: Fix register bank for AON pin groups

Praveen Talari (3):
      i2c: qcom-geni: Isolate serial engine setup
      i2c: qcom-geni: Move resource initialization to separate function
      i2c: qcom-geni: Store of_device_id data in driver private struct

Prike Liang (1):
      drm/amdgpu: move userq fence wait out of signalling section

Pu Lehui (1):
      bpf: Fix UAF due to concurrent consumption of ttrace lists in alloc_bulk

Puranjay Mohan (3):
      perf/core: Fill branch entries with a single assignment
      perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()
      perf/core: Run sched_task() for PMUs with only CPU-wide events

Quentin Armitage (1):
      net: allow IFLA_INET_CONF messages when NLA_F_NESTED unset

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

René Onier (1):
      HID: winwing: fix use-after-free in force feedback teardown

Ridham Khurana (1):
      gpio: zynq: fix runtime PM leak on request error path

SJ Park (2):
      mm/damon/vaddr: avoid hw-driven pte updates during damon_hugetlb_mkold()
      mm/damon/core: reset invalid quota->charge_target_from

Sang-Hoon Choi (1):
      nfp: hold IPsec RX state under the XArray lock

Sanghyun Park (1):
      vxlan: use one headroom snapshot for neighbour replies

Sarah Emery (1):
      pinctrl: generic: serialise pinctrl_generic_dt_node_to_map()

Sean Anderson (1):
      pinctrl: meson: Fix typo in s4 group name

Sean Christopherson (11):
      perf/x86/intel: Ensure KVM guest PEBS path doesn't set unwanted PERF_GLOBAL_CTRL bits
      perf/x86/intel: Don't write PEBS_ENABLED on host<=>guest xfers if CPU has PEBS isolation, to fix stuck PEBS_ENABLED
      perf/x86/intel: Don't pointlessly context switch DS_AREA (and PEBS config) if PEBS is unused
      perf/x86/intel: Make @data a mandatory param for intel_guest_get_msrs()
      KVM: SEV: Free have_run_cpus during VM destruction even if VM is no longer SEV
      KVM: SEV: Do cache maintenance on the source VM during intra-host migration
      KVM: x86: Move IRQ-related helper declarations from kvm_host.h => irq.h
      KVM: x86/mmu: Move kvm_arch_async_page_ready() below kvm_tdp_page_fault()
      KVM: x86/mmu: Move kvm_mmu_do_page_fault() from mmu_internal.h => mmu.c
      KVM: x86: Reject nested CAP enablement if nested virtualization is disabled
      KVM: x86: Add static calls for nested virtualization ops

Sean Rhodes (2):
      ALSA: hda/realtek: Limit Star Labs internal mic boost
      ALSA: hda/realtek: Add StarFighter HDA SSID

Sebastian Ott (1):
      KVM: selftests: fix steal_time for arm64 with host page size > 4K

SeungJu Cheon (3):
      RISC-V: KVM: Preserve firmware counter value across stop/start
      RISC-V: KVM: Report snapshot write failure to the guest
      RISC-V: KVM: Fix perf-backed counter accounting across stop and read

Shardul Bankar (2):
      udp: relocate a connected socket in the 4-tuple hash table on re-connect
      udp: remove a disconnected socket from the 4-tuple hash table

Shawn Guo (1):
      pinctrl: qcom: nord: Split QUP1 SE2/SE3 into lane-pair functions

Shay Drory (3):
      net/mlx5: devcom, Base component size on linked devices
      net/mlx5: SD, unload reps on shared FDB create error path
      net/mlx5: LAG, reload IB reps of LAG master before the rest

Shengzhuo Wei (1):
      i2c: qcom-geni: release DMA channels on probe error

Shihuang Liu (1):
      net: skbuff: fix pull-bound underflow in skb_checksum_setup_ipv6()

Siddharth Chintamaneni (1):
      bpf: Allow terminal gotox instructions

Sidraya Jayagond (1):
      net/smc: fix UAF on lgr list traversal in smcr_port_err()

Sk Anirban (1):
      drm/xe/gt_throttle: Report power brake as a throttle reason on CRI

Slawomir Stepien (1):
      HID: amd_sfh: Validate PCI BAR size before mapping

Stanley Jhu (1):
      scsi: ufs: core: Keep internal commands dispatchable during error handling

Steffen Eiden (2):
      s390/uv: Fix loop condition in uv_find_secrets
      s390/uv: Prevent potential out-of-bounds read

Sunil Khatri (3):
      drm/amdgpu/userq: fix double jiffies conversion in hang detect timeout
      drm/amdgpu/vcn4.0.3: fix video_timeout unit mismatch in jpeg reset wait
      drm/amdgpu/vcn5.0.1: fix video_timeout unit mismatch in jpeg reset wait

Sven Schnelle (1):
      selftests/ftrace: Fix unique symbol check in kprobe_non_uniq_symbol.tc

Szymon Acedański (1):
      drm/xe: Limit sg segment size to PAGE_SIZE on Xen PV

Takashi Sakamoto (1):
      firewire: cdev: fix back-transition for iso_resource_auto client resource

Tan Chi (1):
      RISC-V: KVM: Fix HSM hart status error propagation

Tangudu Tilak Tirumalesh (2):
      drm/xe: harden adjust_idledly() against divide-by-zero and overflow
      drm/xe: Add wa_14025941587 to xe2, xe3 and xe3p platforms

Tejun Heo (1):
      sched_ext: Derive SCX_RQ_IN_WAKEUP from the core enqueue flags

Théo Lebrun (1):
      net: macb: fix dma_alloc_coherent() leak on macb_alloc() error paths

Tim Chen (1):
      sched/cache: Decouple sched_cache_group from mm to fix UAF

Tristan Madani (1):
      HID: hid-oxp: use cancel_delayed_work_sync() in remove

Victor Nogueira (1):
      net/sched: act_gate: budget the per-entry list in get_fill_size

Viken Dadhaniya (1):
      i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL

Vineeth Vijayan (4):
      s390/cio: Fix cio_update_schib() to not cache invalid schib
      s390/cio: Check pmcw.dnv before pmcw.ena in I/O entry points
      s390/cio: Guard PMCW field accesses with dnv check
      s390/cio: Fix NULL pointer dereference in ccw_device_get_util_str()

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
      drm/amdgpu: Fix acpi device leak in amdgpu_acpi_enumerate_xcc()
      drm/amdgpu: Fix last_update fence leak in amdgpu_vm_init()
      drm/amdgpu: Fix runtime PM leak in amdgpu_debugfs_test_ib_show()
      drm/amdgpu: Fix vmid_wait fence leak in amdgpu_ring_init()
      drm/nouveau: Fix bridge reference leak in nv1a_ram_new()
      drm/nouveau: Fix gem reference leak in validate_init()
      drm/nouveau: Fix runtime PM leak in nouveau_connector_detect()
      net/mlx5: Fix rev_entry reference leak in mlx5_tc_ct_shared_counter_get()
      net: hisilicon: hns_dsaf_mac: fix mdio device leak in hns_mac_register_phy()
      net: usb: lan78xx: Fix URB reference leak in lan78xx_submit_deferred_urbs()

Willem de Bruijn (3):
      virtio_net: copy zerocopy frags in start_xmit without NAPI
      tcp: prevent collapsing skbs across boundary in rtx queue
      packet: use ubuf_info completion for TX_RING packets

Xiang Mei (1):
      vlan: require the MAC header to be present in __vlan_insert_inner_tag()

Xie Bo (3):
      RISC-V: KVM: Serialize IMSIC attributes with vCPU migration
      RISC-V: KVM: Release unused page after MMU invalidation
      RISC-V: KVM: Propagate interrupted G-stage faults

Xin Long (1):
      sctp: hold asoc or transport before mod_timer() in timer handlers

Xu Yunxiang (1):
      bpf: Reject non-negative offsets in stack_slot_obj_get_spi()

Xuanqiang Luo (1):
      ip_gre: Reject enabling collect metadata through changelink

Yehyeong Lee (1):
      scsi: libiscsi_tcp: Check the data direction of a Data-In PDU

Yicong Yang (1):
      RISC-V: KVM: Fix the conversion between vsip and hvip

Yilin Zhang (1):
      tcp: fix use-after-free of retransmit_skb_hint in tcp_send_synack()

Yiqi Sun (1):
      sctp: avoid livelock while updating retransmit path

Yuqi Xu (2):
      bpf: Check params size before reading reserved fields
      net: ipconfig: bound DHCP option construction

Yuya Kusakabe (1):
      net: ipv6: keep room for the mac header in dst_dev_overhead()

ZHOU Jiaxiang (2):
      scsi: block: Fix zones_cond out-of-bounds write on zone report
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

Zhenghui Hao (1):
      parisc: parse early parameters in setup_arch()

Zhiling Zou (1):
      xsk: Use a 32-bit compare in xsk_map_gen_lookup

Zihan Xi (6):
      smb: client: fix create context out-of-bounds reads
      smb: client: close handle after create-context parsing failure
      smb: client: clean up failed cached directory opens
      smb: client: preserve create-context parsing errors
      smb: client: validate POSIX create context length
      smb: client: close completed creates on compound wait errors

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

hpp.iscas (1):
      pinctrl: qcom: ipq5210: Publish the OF module alias

shechenglong (1):
      drm/client: fix restore of partially initialized client

Ömer Mete Kaya (3):
      nfc: llcp: fix -ENOMEM on connect with zero-length service name
      nfc: llcp: fix WKS SAP hijacking via prefix match in nfc_llcp_wks_sap()
      nfc: llcp: fix slab-out-of-bounds reads when logging service names

