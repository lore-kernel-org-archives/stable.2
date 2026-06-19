Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4B2367283;
	Fri, 19 Jun 2026 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781871062; cv=none; b=KRU/bjqoSRUxHRwBMkI2lD1/wfDY79YWIkbXwGLt8OHQqUObrnKJgxS9+faVvTrADt5sIecl0ldKrs9txE8qJ5ENePSCUCvKUwNkJ8tABFJx2kWXu/PQ/n9SA1MNjrIxMSeIsNZ6H+8yjiWk06Zklf+gjEbqR1+DeiAA1f/g+vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781871062; c=relaxed/simple;
	bh=CMc63Vvnm6RT7+mzfOJmVbxJHghlvQ2KiWy/v/F6QAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ru62ZrbrfosIxbCgbKIyOqBW0DE9USCrqbx+BLRxWqPnLrEqLfWTIwNjcRjYDcfr3UGhce/ysHY8ADMF6nukK9EKJpPGSkP5YXt6OB4IhqpalANe7jK8FiKOda7JifgQFh2xvt6BbOWs97SAUYPub7lgUWtPuytSmb9MDohqYLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JojEs0M3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JojEs0M3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4C91F00A3D;
	Fri, 19 Jun 2026 12:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781871058;
	bh=pqQ5zkm24eK6zvOsdUbfs/N/KgJ4o43F+v64Qctsiis=;
	h=From:To:Cc:Subject:Date;
	b=JojEs0M3lOlpqyAl0+moCBWNtxQ/h2wkDpcuFJGnejZM6JSBsMwsnLjgH01hB/3F5
	 tCi8MNtObI/1Eq2TCfBJCj/2h6SWw3LnyTQVVp1Grm+OAEbnGwlvn+iaPAHL32fJ91
	 0zeBFTC43FUalXCbXqx0fLn0N6gIzBv+Vi4SengU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.143
Date: Fri, 19 Jun 2026 14:09:49 +0200
Message-ID: <2026061950-nearness-prevail-3ed9@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.143 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arch/arm64/silicon-errata.rst                             |   48 ++
 Makefile                                                                |    2 
 arch/arm/include/asm/io.h                                               |   15 
 arch/arm/kernel/entry-armv.S                                            |    2 
 arch/arm/mach-socfpga/platsmp.c                                         |    1 
 arch/arm64/Kconfig                                                      |   50 ++
 arch/arm64/include/asm/cputype.h                                        |    6 
 arch/arm64/include/asm/io.h                                             |   25 -
 arch/arm64/include/asm/kvm_mmu.h                                        |    5 
 arch/arm64/include/asm/tlb.h                                            |    2 
 arch/arm64/include/asm/tlbflush.h                                       |   64 +-
 arch/arm64/kernel/acpi.c                                                |    2 
 arch/arm64/kernel/cpu_errata.c                                          |   34 +
 arch/arm64/kernel/sys_compat.c                                          |    2 
 arch/arm64/kvm/hyp/nvhe/mm.c                                            |    2 
 arch/arm64/kvm/hyp/nvhe/pkvm.c                                          |    2 
 arch/arm64/kvm/hyp/nvhe/tlb.c                                           |   69 ---
 arch/arm64/kvm/hyp/pgtable.c                                            |    2 
 arch/arm64/kvm/hyp/vhe/tlb.c                                            |   21 
 arch/arm64/kvm/pmu-emul.c                                               |    4 
 arch/arm64/mm/ioremap.c                                                 |    8 
 arch/mips/dec/platform.c                                                |  109 ++++
 arch/x86/kernel/Makefile                                                |   14 
 arch/x86/kernel/cpu/amd.c                                               |   33 -
 arch/x86/kernel/setup.c                                                 |    6 
 arch/x86/kvm/svm/avic.c                                                 |   35 +
 arch/x86/mm/Makefile                                                    |    2 
 drivers/auxdisplay/line-display.c                                       |    2 
 drivers/base/bus.c                                                      |   11 
 drivers/block/zram/zram_drv.c                                           |    2 
 drivers/bluetooth/btusb.c                                               |    8 
 drivers/bluetooth/hci_qca.c                                             |   38 -
 drivers/char/ipmi/ipmi_msghandler.c                                     |    2 
 drivers/char/ipmi/ipmi_ssif.c                                           |   29 -
 drivers/clk/qcom/dispcc-sc8280xp.c                                      |    4 
 drivers/comedi/drivers/comedi_test.c                                    |    5 
 drivers/counter/counter-core.c                                          |    3 
 drivers/gpio/gpio-mvebu.c                                               |    4 
 drivers/gpio/gpio-mxc.c                                                 |    2 
 drivers/gpio/gpio-rockchip.c                                            |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                  |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c                   |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c                        |   49 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                    |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c               |    5 
 drivers/gpu/drm/amd/display/dc/basics/vector.c                          |    4 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c                      |   54 +-
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c                     |    3 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                              |    4 
 drivers/gpu/drm/bridge/sil-sii8620.c                                    |    1 
 drivers/gpu/drm/drm_fb_helper.c                                         |   12 
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c                               |  113 ++++-
 drivers/gpu/drm/i915/display/intel_display_types.h                      |    1 
 drivers/gpu/drm/i915/display/intel_dpcd.h                               |   15 
 drivers/gpu/drm/i915/display/intel_psr.c                                |   34 +
 drivers/gpu/drm/i915/gem/i915_gem_phys.c                                |   19 
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c                                 |   28 -
 drivers/gpu/drm/imx/dcss/dcss-scaler.c                                  |    3 
 drivers/gpu/drm/vc4/vc4_validate_shaders.c                              |   13 
 drivers/gpu/drm/virtio/virtgpu_drv.c                                    |    5 
 drivers/gpu/drm/virtio/virtgpu_submit.c                                 |    4 
 drivers/hid/bpf/hid_bpf_dispatch.c                                      |    3 
 drivers/hid/hid-core.c                                                  |   35 +
 drivers/hid/hid-gfrm.c                                                  |    4 
 drivers/hid/hid-ids.h                                                   |    1 
 drivers/hid/hid-logitech-hidpp.c                                        |    2 
 drivers/hid/hid-multitouch.c                                            |    2 
 drivers/hid/hid-picolcd_cir.c                                           |    1 
 drivers/hid/hid-primax.c                                                |    2 
 drivers/hid/hid-quirks.c                                                |    1 
 drivers/hid/hid-vivaldi-common.c                                        |    2 
 drivers/hid/wacom_sys.c                                                 |   19 
 drivers/hid/wacom_wac.h                                                 |    1 
 drivers/hwmon/pmbus/adm1266.c                                           |   47 +-
 drivers/hwmon/pmbus/pmbus_core.c                                        |  117 ++++-
 drivers/i2c/busses/i2c-qcom-cci.c                                       |    2 
 drivers/i2c/busses/i2c-stm32f7.c                                        |    6 
 drivers/i2c/busses/i2c-tegra.c                                          |   53 +-
 drivers/i2c/i2c-dev.c                                                   |    9 
 drivers/iio/adc/npcm_adc.c                                              |   31 -
 drivers/iio/adc/viperboard_adc.c                                        |    4 
 drivers/iio/adc/xilinx-xadc-core.c                                      |   11 
 drivers/iio/buffer/industrialio-hw-consumer.c                           |    4 
 drivers/iio/chemical/scd30_core.c                                       |   65 +-
 drivers/iio/common/ssp_sensors/ssp_dev.c                                |    1 
 drivers/iio/dac/ad5686.c                                                |   16 
 drivers/iio/dac/ad5686.h                                                |    1 
 drivers/iio/dac/max5821.c                                               |    9 
 drivers/iio/gyro/adis16260.c                                            |    3 
 drivers/iio/gyro/itg3200_buffer.c                                       |    2 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c                          |    2 
 drivers/iio/light/cm3323.c                                              |    5 
 drivers/iio/magnetometer/st_magn_core.c                                 |   13 
 drivers/iio/temperature/tsys01.c                                        |    2 
 drivers/infiniband/core/Makefile                                        |    2 
 drivers/infiniband/core/iter.c                                          |   43 +
 drivers/infiniband/core/umem.c                                          |   16 
 drivers/infiniband/core/verbs.c                                         |   38 -
 drivers/infiniband/hw/bnxt_re/qplib_res.c                               |    2 
 drivers/infiniband/hw/cxgb4/mem.c                                       |    2 
 drivers/infiniband/hw/efa/efa_verbs.c                                   |    2 
 drivers/infiniband/hw/erdma/erdma_verbs.c                               |    2 
 drivers/infiniband/hw/hns/hns_roce_alloc.c                              |    2 
 drivers/infiniband/hw/hns/hns_roce_mr.c                                 |    4 
 drivers/infiniband/hw/irdma/main.h                                      |    2 
 drivers/infiniband/hw/irdma/verbs.c                                     |    4 
 drivers/infiniband/hw/mana/mana_ib.h                                    |    2 
 drivers/infiniband/hw/mlx4/mr.c                                         |    5 
 drivers/infiniband/hw/mlx5/mem.c                                        |    1 
 drivers/infiniband/hw/mlx5/mr.c                                         |    4 
 drivers/infiniband/hw/mlx5/umr.c                                        |    1 
 drivers/infiniband/hw/mthca/mthca_provider.c                            |    2 
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c                             |    2 
 drivers/infiniband/hw/qedr/verbs.c                                      |    2 
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h                               |    2 
 drivers/infiniband/sw/rxe/rxe_qp.c                                      |    7 
 drivers/infiniband/sw/rxe/rxe_verbs.c                                   |    5 
 drivers/infiniband/ulp/isert/ib_isert.c                                 |    6 
 drivers/infiniband/ulp/srp/ib_srp.c                                     |   30 +
 drivers/input/joystick/xpad.c                                           |   14 
 drivers/input/keyboard/atkbd.c                                          |   15 
 drivers/input/misc/ims-pcu.c                                            |    2 
 drivers/input/mouse/elan_i2c_core.c                                     |    5 
 drivers/input/mouse/synaptics.c                                         |    1 
 drivers/input/touchscreen/atmel_mxt_ts.c                                |    2 
 drivers/input/touchscreen/usbtouchscreen.c                              |    5 
 drivers/iommu/io-pgtable-arm-v7s.c                                      |   18 
 drivers/md/bcache/super.c                                               |    3 
 drivers/md/dm-cache-policy-smq.c                                        |   12 
 drivers/media/cec/core/cec-core.c                                       |    2 
 drivers/media/common/siano/smsir.c                                      |    1 
 drivers/media/i2c/ir-kbd-i2c.c                                          |    2 
 drivers/media/pci/bt8xx/bttv-input.c                                    |    3 
 drivers/media/pci/cx23885/cx23885-input.c                               |    1 
 drivers/media/pci/cx88/cx88-input.c                                     |    3 
 drivers/media/pci/dm1105/dm1105.c                                       |    1 
 drivers/media/pci/mantis/mantis_input.c                                 |    1 
 drivers/media/pci/saa7134/saa7134-input.c                               |    1 
 drivers/media/pci/smipcie/smipcie-ir.c                                  |    1 
 drivers/media/pci/ttpci/budget-ci.c                                     |    1 
 drivers/media/rc/ati_remote.c                                           |    6 
 drivers/media/rc/ene_ir.c                                               |    2 
 drivers/media/rc/fintek-cir.c                                           |    3 
 drivers/media/rc/igorplugusb.c                                          |    3 
 drivers/media/rc/iguanair.c                                             |    1 
 drivers/media/rc/img-ir/img-ir-hw.c                                     |    3 
 drivers/media/rc/img-ir/img-ir-raw.c                                    |    3 
 drivers/media/rc/imon.c                                                 |    3 
 drivers/media/rc/ir-hix5hd2.c                                           |    2 
 drivers/media/rc/ir_toy.c                                               |    1 
 drivers/media/rc/ite-cir.c                                              |    2 
 drivers/media/rc/mceusb.c                                               |    1 
 drivers/media/rc/rc-ir-raw.c                                            |    5 
 drivers/media/rc/rc-loopback.c                                          |    1 
 drivers/media/rc/rc-main.c                                              |    6 
 drivers/media/rc/redrat3.c                                              |    4 
 drivers/media/rc/st_rc.c                                                |    2 
 drivers/media/rc/streamzap.c                                            |    7 
 drivers/media/rc/sunxi-cir.c                                            |    1 
 drivers/media/rc/ttusbir.c                                              |    4 
 drivers/media/rc/winbond-cir.c                                          |    2 
 drivers/media/rc/xbox_remote.c                                          |    5 
 drivers/media/usb/au0828/au0828-input.c                                 |    1 
 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c                             |    1 
 drivers/media/usb/dvb-usb/dvb-usb-remote.c                              |    6 
 drivers/media/usb/em28xx/em28xx-input.c                                 |    1 
 drivers/misc/fastrpc.c                                                  |  107 +++-
 drivers/mmc/core/mmc.c                                                  |    4 
 drivers/mmc/host/litex_mmc.c                                            |   20 
 drivers/mmc/host/renesas_sdhi_internal_dmac.c                           |    1 
 drivers/mmc/host/sdhci.c                                                |    1 
 drivers/net/bonding/bond_main.c                                         |   12 
 drivers/net/ethernet/amd/pcnet32.c                                      |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                               |    2 
 drivers/net/ethernet/freescale/fec_main.c                               |    3 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c                           |    2 
 drivers/net/ethernet/marvell/mv643xx_eth.c                              |    2 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                         |   75 ++-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                         |   13 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                         |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                         |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c                     |   32 -
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c                  |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c                |    2 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                             |    2 
 drivers/net/ethernet/mellanox/mlx4/cq.c                                 |    9 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                           |    6 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                       |   13 
 drivers/net/ethernet/mellanox/mlx5/core/vport.c                         |   72 ++-
 drivers/net/ethernet/microchip/lan743x_main.c                           |   32 +
 drivers/net/ethernet/microchip/lan743x_main.h                           |    1 
 drivers/net/ethernet/microsoft/mana/mana_en.c                           |   70 +--
 drivers/net/ethernet/ti/cpsw_new.c                                      |    4 
 drivers/net/hyperv/netvsc.c                                             |   19 
 drivers/net/macsec.c                                                    |    3 
 drivers/net/phy/mscc/mscc.h                                             |    8 
 drivers/net/phy/mscc/mscc_main.c                                        |   23 -
 drivers/net/phy/phy_device.c                                            |    6 
 drivers/net/tap.c                                                       |    2 
 drivers/net/tun.c                                                       |    5 
 drivers/net/usb/r8152.c                                                 |    7 
 drivers/net/vxlan/vxlan_core.c                                          |    4 
 drivers/net/vxlan/vxlan_vnifilter.c                                     |    5 
 drivers/net/wireguard/send.c                                            |   20 
 drivers/nfc/nxp-nci/i2c.c                                               |   21 
 drivers/nvmem/layouts/onie-tlv.c                                        |    3 
 drivers/of/kexec.c                                                      |   15 
 drivers/parport/share.c                                                 |   11 
 drivers/platform/x86/intel/vsec.c                                       |   34 -
 drivers/ptp/ptp_vclock.c                                                |   14 
 drivers/scsi/fcoe/fcoe_ctlr.c                                           |    2 
 drivers/scsi/scsi_lib.c                                                 |   27 +
 drivers/scsi/scsi_transport_fc.c                                        |   77 +--
 drivers/slimbus/qcom-ngd-ctrl.c                                         |    5 
 drivers/soc/qcom/ice.c                                                  |   36 +
 drivers/soc/tegra/pmc.c                                                 |  104 +++-
 drivers/staging/greybus/hid.c                                           |    2 
 drivers/staging/media/av7110/av7110_ir.c                                |    1 
 drivers/target/iscsi/iscsi_target.c                                     |    6 
 drivers/target/iscsi/iscsi_target_auth.c                                |   19 
 drivers/target/iscsi/iscsi_target_nego.c                                |    7 
 drivers/target/iscsi/iscsi_target_parameters.c                          |   62 ++
 drivers/target/iscsi/iscsi_target_parameters.h                          |    2 
 drivers/tee/optee/supp.c                                                |  107 +++-
 drivers/thunderbolt/property.c                                          |   38 +
 drivers/thunderbolt/xdomain.c                                           |   14 
 drivers/tty/serdev/core.c                                               |   23 -
 drivers/tty/serial/altera_jtaguart.c                                    |    7 
 drivers/tty/serial/dz.c                                                 |  171 +++----
 drivers/tty/serial/fsl_lpuart.c                                         |   15 
 drivers/tty/serial/pch_uart.c                                           |   19 
 drivers/tty/serial/qcom_geni_serial.c                                   |   17 
 drivers/tty/serial/samsung_tty.c                                        |  129 ++---
 drivers/tty/serial/sh-sci.c                                             |    2 
 drivers/tty/serial/zs.c                                                 |  226 +++-------
 drivers/tty/serial/zs.h                                                 |    1 
 drivers/usb/cdns3/cdns3-gadget.c                                        |   12 
 drivers/usb/cdns3/cdns3-plat.c                                          |   11 
 drivers/usb/chipidea/core.c                                             |   16 
 drivers/usb/class/cdc-acm.c                                             |    2 
 drivers/usb/class/cdc-acm.h                                             |    2 
 drivers/usb/class/usbtmc.c                                              |   14 
 drivers/usb/core/config.c                                               |    9 
 drivers/usb/core/hcd.c                                                  |    4 
 drivers/usb/core/quirks.c                                               |    4 
 drivers/usb/dwc2/hcd.c                                                  |    4 
 drivers/usb/dwc3/dwc3-xilinx.c                                          |   26 -
 drivers/usb/gadget/composite.c                                          |    5 
 drivers/usb/gadget/function/f_fs.c                                      |    2 
 drivers/usb/gadget/function/f_hid.c                                     |    3 
 drivers/usb/gadget/function/f_ncm.c                                     |   35 +
 drivers/usb/gadget/function/f_uvc.c                                     |   26 -
 drivers/usb/gadget/function/u_ether.c                                   |   28 +
 drivers/usb/gadget/function/u_ether.h                                   |   26 +
 drivers/usb/gadget/function/u_ncm.h                                     |    2 
 drivers/usb/gadget/udc/dummy_hcd.c                                      |    4 
 drivers/usb/gadget/udc/net2280.c                                        |    4 
 drivers/usb/host/xhci-tegra.c                                           |   79 +--
 drivers/usb/musb/omap2430.c                                             |    3 
 drivers/usb/serial/belkin_sa.c                                          |    3 
 drivers/usb/serial/cypress_m8.c                                         |   20 
 drivers/usb/serial/digi_acceleport.c                                    |   23 -
 drivers/usb/serial/io_ti.c                                              |   11 
 drivers/usb/serial/keyspan.c                                            |    4 
 drivers/usb/serial/kl5kusb105.c                                         |    4 
 drivers/usb/serial/mct_u232.c                                           |   26 -
 drivers/usb/serial/mxuport.c                                            |    8 
 drivers/usb/serial/omninet.c                                            |    9 
 drivers/usb/serial/option.c                                             |   12 
 drivers/usb/serial/safe_serial.c                                        |   11 
 drivers/usb/storage/unusual_uas.h                                       |    7 
 drivers/usb/typec/altmodes/displayport.c                                |    2 
 drivers/usb/typec/tcpm/tcpci_maxim_core.c                               |    9 
 drivers/usb/typec/tcpm/wcove.c                                          |   13 
 drivers/usb/typec/ucsi/displayport.c                                    |    4 
 drivers/usb/typec/ucsi/ucsi.c                                           |   24 -
 drivers/usb/typec/ucsi/ucsi_ccg.c                                       |    5 
 drivers/usb/usbip/vudc_dev.c                                            |    1 
 drivers/usb/usbip/vudc_transfer.c                                       |    3 
 drivers/video/fbdev/Kconfig                                             |    1 
 drivers/video/fbdev/core/fbcon.c                                        |    9 
 drivers/video/fbdev/vt8500lcdfb.c                                       |    4 
 fs/fcntl.c                                                              |    8 
 fs/fuse/dev.c                                                           |    9 
 fs/hpfs/alloc.c                                                         |    2 
 fs/iomap/buffered-io.c                                                  |    4 
 fs/smb/client/netlink.c                                                 |    6 
 fs/smb/server/oplock.c                                                  |   15 
 fs/smb/server/smb2pdu.c                                                 |  143 ++++--
 fs/smb/server/smbacl.c                                                  |   51 ++
 fs/smb/server/smbacl.h                                                  |    2 
 include/drm/display/drm_dp.h                                            |    1 
 include/drm/drm_fourcc.h                                                |    5 
 include/linux/compat.h                                                  |    4 
 include/linux/compiler-clang.h                                          |    6 
 include/linux/compiler_attributes.h                                     |   11 
 include/linux/compiler_types.h                                          |    4 
 include/linux/hid.h                                                     |   15 
 include/linux/hid_bpf.h                                                 |    4 
 include/linux/hugetlb.h                                                 |   16 
 include/linux/ima.h                                                     |    1 
 include/linux/mlx5/vport.h                                              |    4 
 include/linux/mm.h                                                      |    8 
 include/linux/parport.h                                                 |    1 
 include/linux/serdev.h                                                  |    1 
 include/linux/syscalls.h                                                |    4 
 include/media/rc-core.h                                                 |    2 
 include/net/act_api.h                                                   |    1 
 include/net/bluetooth/l2cap.h                                           |    1 
 include/net/genetlink.h                                                 |    9 
 include/net/inet_frag.h                                                 |   18 
 include/net/ip_vs.h                                                     |    3 
 include/net/ipv6_frag.h                                                 |    9 
 include/net/netfilter/nf_conntrack_core.h                               |    5 
 include/net/netfilter/nf_conntrack_helper.h                             |    1 
 include/net/netfilter/nf_tables.h                                       |    7 
 include/net/sock.h                                                      |    1 
 include/net/xfrm.h                                                      |    3 
 include/rdma/ib_umem.h                                                  |   44 -
 include/rdma/ib_verbs.h                                                 |   48 --
 include/rdma/iter.h                                                     |   88 +++
 include/uapi/linux/netfilter/nf_tables.h                                |   18 
 ipc/shm.c                                                               |   10 
 ipc/util.c                                                              |    2 
 kernel/cgroup/cpuset.c                                                  |    8 
 kernel/events/core.c                                                    |   16 
 kernel/pid.c                                                            |    8 
 kernel/signal.c                                                         |    1 
 kernel/time/time.c                                                      |    2 
 kernel/trace/trace_probe.c                                              |    2 
 lib/debugobjects.c                                                      |    2 
 mm/damon/ops-common.c                                                   |    4 
 mm/damon/sysfs-schemes.c                                                |    8 
 mm/gup.c                                                                |    2 
 mm/huge_memory.c                                                        |    2 
 mm/hugetlb.c                                                            |  118 +++--
 mm/memfd.c                                                              |   12 
 mm/memory-failure.c                                                     |   96 ++--
 mm/memory.c                                                             |    2 
 mm/memory_hotplug.c                                                     |    2 
 mm/mempolicy.c                                                          |    2 
 mm/migrate.c                                                            |   18 
 mm/page_alloc.c                                                         |    1 
 net/6lowpan/iphc.c                                                      |    4 
 net/802/garp.c                                                          |    2 
 net/802/mrp.c                                                           |    9 
 net/batman-adv/bat_iv_ogm.c                                             |   82 ++-
 net/batman-adv/bat_v_ogm.c                                              |   59 +-
 net/batman-adv/bridge_loop_avoidance.c                                  |   57 +-
 net/batman-adv/soft-interface.c                                         |    1 
 net/batman-adv/tp_meter.c                                               |   67 +-
 net/batman-adv/translation-table.c                                      |   43 +
 net/batman-adv/tvlv.c                                                   |   28 -
 net/batman-adv/tvlv.h                                                   |    2 
 net/batman-adv/types.h                                                  |   42 +
 net/bluetooth/6lowpan.c                                                 |    2 
 net/bluetooth/bnep/core.c                                               |   50 +-
 net/bluetooth/hci_conn.c                                                |    8 
 net/bluetooth/hci_sync.c                                                |    9 
 net/bluetooth/hci_sysfs.c                                               |    6 
 net/bluetooth/hidp/core.c                                               |   23 -
 net/bluetooth/iso.c                                                     |   12 
 net/bluetooth/l2cap_core.c                                              |   87 +++
 net/bluetooth/l2cap_sock.c                                              |   16 
 net/bluetooth/mgmt.c                                                    |   17 
 net/bluetooth/rfcomm/core.c                                             |   67 ++
 net/bluetooth/rfcomm/sock.c                                             |   26 -
 net/bridge/netfilter/ebt_snat.c                                         |    3 
 net/bridge/netfilter/ebtables.c                                         |   30 +
 net/core/drop_monitor.c                                                 |    2 
 net/core/filter.c                                                       |   17 
 net/core/skbuff.c                                                       |   20 
 net/core/sock.c                                                         |   13 
 net/ethtool/eeprom.c                                                    |   10 
 net/hsr/hsr_forward.c                                                   |    4 
 net/hsr/hsr_framereg.c                                                  |   10 
 net/ieee802154/6lowpan/tx.c                                             |    5 
 net/ipv4/ah4.c                                                          |    2 
 net/ipv4/esp4.c                                                         |    4 
 net/ipv4/inet_fragment.c                                                |   54 ++
 net/ipv4/ip_fragment.c                                                  |   21 
 net/ipv4/ip_options.c                                                   |    4 
 net/ipv4/ip_tunnel_core.c                                               |   22 
 net/ipv4/netfilter/arp_tables.c                                         |   15 
 net/ipv4/netfilter/ip_tables.c                                          |   15 
 net/ipv4/netfilter/nf_nat_h323.c                                        |    2 
 net/ipv4/netfilter/nft_fib_ipv4.c                                       |    2 
 net/ipv4/sysctl_net_ipv4.c                                              |    2 
 net/ipv4/udp.c                                                          |    8 
 net/ipv6/addrconf.c                                                     |   53 +-
 net/ipv6/ah6.c                                                          |    2 
 net/ipv6/datagram.c                                                     |   54 ++
 net/ipv6/esp6.c                                                         |    4 
 net/ipv6/exthdrs.c                                                      |   35 +
 net/ipv6/ioam6.c                                                        |    8 
 net/ipv6/ip6_input.c                                                    |    2 
 net/ipv6/ip6_vti.c                                                      |   25 -
 net/ipv6/mcast.c                                                        |   22 
 net/ipv6/ndisc.c                                                        |   18 
 net/ipv6/netfilter/ip6_tables.c                                         |   15 
 net/ipv6/netfilter/ip6t_eui64.c                                         |    7 
 net/ipv6/netfilter/nft_fib_ipv6.c                                       |    2 
 net/ipv6/route.c                                                        |    5 
 net/ipv6/seg6_hmac.c                                                    |    8 
 net/ipv6/sit.c                                                          |    1 
 net/iucv/af_iucv.c                                                      |   20 
 net/key/af_key.c                                                        |   58 +-
 net/mctp/device.c                                                       |    1 
 net/mctp/neigh.c                                                        |    1 
 net/mctp/route.c                                                        |    1 
 net/mptcp/options.c                                                     |   73 +--
 net/mptcp/pm.c                                                          |   49 +-
 net/mptcp/pm_netlink.c                                                  |   18 
 net/mptcp/protocol.c                                                    |  102 +++-
 net/mptcp/protocol.h                                                    |   17 
 net/mptcp/sockopt.c                                                     |    8 
 net/mptcp/subflow.c                                                     |   20 
 net/netfilter/ipset/ip_set_bitmap_ipmac.c                               |    5 
 net/netfilter/ipset/ip_set_hash_ipmac.c                                 |    9 
 net/netfilter/ipset/ip_set_hash_mac.c                                   |    5 
 net/netfilter/ipvs/ip_vs_ctl.c                                          |   13 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                                   |   18 
 net/netfilter/ipvs/ip_vs_proto_tcp.c                                    |   21 
 net/netfilter/ipvs/ip_vs_proto_udp.c                                    |   20 
 net/netfilter/ipvs/ip_vs_sched.c                                        |   14 
 net/netfilter/nf_conntrack_ecache.c                                     |    2 
 net/netfilter/nf_conntrack_expect.c                                     |   10 
 net/netfilter/nf_conntrack_helper.c                                     |   19 
 net/netfilter/nf_conntrack_irc.c                                        |    4 
 net/netfilter/nf_conntrack_netlink.c                                    |   28 -
 net/netfilter/nf_conntrack_proto_tcp.c                                  |    3 
 net/netfilter/nf_log_syslog.c                                           |   12 
 net/netfilter/nf_nat_core.c                                             |    2 
 net/netfilter/nf_nat_sip.c                                              |    1 
 net/netfilter/nf_synproxy_core.c                                        |   26 -
 net/netfilter/nft_bitwise.c                                             |  184 ++++++--
 net/netfilter/nft_byteorder.c                                           |   13 
 net/netfilter/nft_ct.c                                                  |    8 
 net/netfilter/nft_ct_fast.c                                             |    2 
 net/netfilter/nft_exthdr.c                                              |    3 
 net/netfilter/nft_fib.c                                                 |    6 
 net/netfilter/nft_tunnel.c                                              |    2 
 net/netfilter/xt_NFQUEUE.c                                              |    2 
 net/netfilter/xt_cpu.c                                                  |    2 
 net/netfilter/xt_mac.c                                                  |    4 
 net/netlabel/netlabel_unlabeled.c                                       |   30 -
 net/netlink/af_netlink.c                                                |   11 
 net/netlink/genetlink.c                                                 |    4 
 net/nfc/hci/core.c                                                      |   10 
 net/nfc/llcp_core.c                                                     |   11 
 net/nfc/llcp_sock.c                                                     |    2 
 net/nfc/nci/hci.c                                                       |   10 
 net/openvswitch/datapath.c                                              |    1 
 net/psample/psample.c                                                   |    2 
 net/qrtr/af_qrtr.c                                                      |    4 
 net/rds/ib_cm.c                                                         |    1 
 net/rds/ib_send.c                                                       |    2 
 net/rds/info.c                                                          |    2 
 net/rxrpc/ar-internal.h                                                 |   12 
 net/rxrpc/call_event.c                                                  |   27 -
 net/rxrpc/call_object.c                                                 |    2 
 net/rxrpc/conn_event.c                                                  |   32 -
 net/rxrpc/insecure.c                                                    |    8 
 net/rxrpc/recvmsg.c                                                     |   68 ++-
 net/rxrpc/rxkad.c                                                       |  115 +----
 net/sched/act_api.c                                                     |    7 
 net/sched/cls_fw.c                                                      |    6 
 net/sched/sch_sfb.c                                                     |    2 
 net/sctp/diag.c                                                         |   17 
 net/sctp/input.c                                                        |    8 
 net/sctp/sm_statefuns.c                                                 |    6 
 net/sctp/socket.c                                                       |    2 
 net/sctp/stream.c                                                       |    6 
 net/smc/af_smc.c                                                        |   21 
 net/socket.c                                                            |   11 
 net/unix/af_unix.c                                                      |   38 -
 net/vmw_vsock/af_vsock.c                                                |   49 +-
 net/vmw_vsock/hyperv_transport.c                                        |    9 
 net/vmw_vsock/virtio_transport_common.c                                 |   14 
 net/vmw_vsock/vmci_transport.c                                          |   12 
 net/wireless/nl80211.c                                                  |    3 
 net/xfrm/espintcp.c                                                     |    4 
 net/xfrm/xfrm_input.c                                                   |   16 
 net/xfrm/xfrm_policy.c                                                  |   15 
 net/xfrm/xfrm_state.c                                                   |   23 -
 net/xfrm/xfrm_user.c                                                    |    5 
 security/integrity/ima/ima_kexec.c                                      |   35 +
 security/landlock/errata/abi-1.h                                        |   16 
 security/landlock/fs.c                                                  |   40 +
 sound/core/pcm_native.c                                                 |    7 
 sound/core/timer.c                                                      |    1 
 sound/firewire/motu/motu-register-dsp-message-parser.c                  |   14 
 sound/pci/hda/patch_hdmi.c                                              |    1 
 sound/soc/codecs/simple-mux.c                                           |    2 
 sound/soc/codecs/wm_adsp.c                                              |    3 
 sound/soc/fsl/fsl_sai.c                                                 |    2 
 sound/soc/intel/boards/bytcht_es8316.c                                  |   29 +
 sound/soc/qcom/qdsp6/q6asm-dai.c                                        |   43 +
 tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc |    2 
 tools/testing/selftests/mm/hmm-tests.c                                  |   50 ++
 tools/testing/selftests/net/mptcp/mptcp_connect.sh                      |    6 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                         |    4 
 tools/testing/selftests/ptp/testptp.c                                   |   62 --
 tools/verification/rv/src/in_kernel.c                                   |    2 
 virt/kvm/kvm_main.c                                                     |    3 
 506 files changed, 5434 insertions(+), 2724 deletions(-)

Aaron Erhardt (1):
      ALSA: hda/hdmi: Add quirk for TUXEDO IBS14G6

Abdurrahman Hussain (2):
      hwmon: (pmbus/adm1266) serialize GPIO PMBus accesses with pmbus_lock
      hwmon: (pmbus/adm1266) serialize NVMEM blackbox read with pmbus_lock

Adrian Korwel (2):
      USB: serial: io_ti: fix heap overflow in get_manuf_info()
      USB: serial: io_ti: fix heap overflow in build_i2c_fw_hdr()

Adrian Moreno (1):
      net: openvswitch: fix possible kfree_skb of ERR_PTR

Advait Dhamorikar (1):
      iio: magnetometer: st_magn: fix default DRDY pin selection for LIS2MDL

Akhil R (1):
      i2c: tegra: Fix NOIRQ suspend/resume

Aldo Conte (1):
      iio: light: cm3323: fix reg_conf not being initialized correctly

Aleksandr Nogikh (2):
      x86/kexec: Disable KCOV instrumentation after load_segments()
      signal: clear JOBCTL_PENDING_MASK for caller in zap_other_threads()

Alexander A. Klimov (1):
      drm/vc4: fix krealloc() memory leak

Alexander Stein (1):
      gpio: mxc: fix irq_high handling

Alexandra Winter (1):
      net/smc: Do not re-initialize smc hashtables

Alexandru Hossu (1):
      scsi: target: iscsi: Validate CHAP_R length before base64 decode

Ali Ganiyev (1):
      ksmbd: OOB read regression in smb_check_perm_dacl() ACE-walk loops

Alistair Popple (1):
      mm/memory: fix spurious warning when unmapping device-private/exclusive pages

Amirreza Zarrabi (1):
      tee: optee: prevent use-after-free when the client exits before the supplicant

Anandu Krishnan E (1):
      misc: fastrpc: fix use-after-free of fastrpc_user in workqueue context

Andre Heider (1):
      nvmem: layouts: onie-tlv: fix hang on unknown types

Andrew Martin (1):
      drm/amdkfd: Fix buffer overflow in SDMA queue checkpoint/restore on GFX11

Andy Roulin (2):
      vxlan: vnifilter: send notification on VNI add
      vxlan: vnifilter: fix spurious notification on VNI update

Anton Leontev (1):
      hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf

Antoniu Miclaus (2):
      iio: gyro: adis16260: fix division by zero in write_raw
      iio: chemical: scd30: fix division by zero in write_raw

Arnd Bergmann (1):
      iommu, debugobjects: avoid gcc-16.1 section mismatch warnings

Ashutosh Desai (1):
      nfc: hci: fix out-of-bounds read in HCP header parsing

Asim Viladi Oglu Manizada (1):
      ksmbd: fix OOB write in QUERY_INFO for compound requests

Bartosz Golaszewski (2):
      net: mv643xx: fix OF node refcount
      slimbus: qcom-ngd-ctrl: fix OF node refcount

Ben Hutchings (1):
      parport: Fix race between port and client registration

Benjamin Tissoires (1):
      HID: pass the buffer size to hid_report_raw_event

Berkant Koc (2):
      drm/hyperv: validate resolution_count and fix WIN8 fallback
      drm/hyperv: validate VMBus packet size in receive callback

Bharath Reddy (1):
      Bluetooth: fix memory leak in error path of hci_alloc_dev()

Bjorn Andersson (1):
      slimbus: qcom-ngd-ctrl: Avoid ABBA on tx_lock/ctrl->lock

Borislav Petkov (AMD) (3):
      x86/CPU/AMD: Move the Zen3 BTC_NO detection to the Zen3 init function
      x86/CPU/AMD: Call the spectral chicken in the Zen2 init function
      x86/CPU/AMD: Rename init_amd_zn() to init_amd_zen_common()

Breno Leitao (2):
      net/iucv: fix locking in .getsockopt
      rds: mark snapshot pages dirty in rds_info_getsockopt()

Brian Foster (1):
      iomap: don't revert iov_iter on partially completed buffered writes

Carl Lee (1):
      nfc: nxp-nci: i2c: use rising-edge IRQ on ACPI systems

Carlos Eduardo Gallo Filho (1):
      drm: Remove plane hsub/vsub alignment requirement for core helpers

Chancel Liu (1):
      ASoC: fsl_sai: Fix 32 slots TDM broken by integer shift UB in xMR write

Chenguang Zhao (1):
      netlabel: validate unlabeled address and mask attribute lengths

Chih Kai Hsu (1):
      r8152: handle the return value of usb_reset_device()

Chris Mason (1):
      netfilter: synproxy: refresh tcphdr after skb_ensure_writable

Christian Brauner (1):
      pidfd: refuse access to tasks that have started exiting harder

Christian König (1):
      drm/amdgpu: restart the CS if some parts of the VM are still invalidated

Christofer Jonason (1):
      iio: adc: xilinx-xadc: Fix sequencer mode in postdisable for dual mux

Corey Minyard (2):
      ipmi:ssif: Remove unnecessary indention
      ipmi:ssif: NULL thread on error

Cryolitia PukNgae (1):
      Input: atkbd - skip deactivate for HONOR BCC-N's internal keyboard

Cunlong Li (1):
      zram: fix use-after-free in zram_bvec_write_partial()

Cássio Gabriel (3):
      ASoC: Intel: bytcht_es8316: Fix MCLK leak on init errors
      ASoC: codecs: simple-mux: Fix enum control bounds check
      ALSA: firewire-motu: Protect register DSP event queue positions

Dan Carpenter (1):
      usb: dwc2: Fix use after free in debug code

David Ahern (1):
      xfrm: Check for underflow in xfrm_state_mtu

David Carlier (3):
      iio: gyro: itg3200: fix i2c read into the wrong stack location
      mm/hugetlb: restore reservation on error in hugetlb folio copy paths
      iio: adc: npcm: fix unbalanced clk_disable_unprepare()

David Francis (1):
      drm/amdkfd: Check for pdd drm file first in CRIU restore path

David Hildenbrand (3):
      mm/hugetlb: rename isolate_hugetlb() to folio_isolate_hugetlb()
      mm/migrate: don't call folio_putback_active_hugetlb() on dst hugetlb folio
      mm/hugetlb: rename folio_putback_active_hugetlb() to folio_putback_hugetlb()

David Howells (2):
      rxrpc: Fix DATA decrypt vs splice() by copying data to buffer in recvmsg
      rxrpc: Fix RESPONSE packet verification to extract skb to a linear buffer

David Jeffery (1):
      scsi: core: Run queues for all non-SDEV_DEL devices from scsi_run_host_queues

David Thompson (1):
      net: lan743x: permit VLAN-tagged packets up to configured MTU

Davide Caratti (1):
      net/sched: cls_fw: fix NULL dereference of "old" filters before change()

Davide Ornaghi (1):
      netfilter: nft_fib: fix stale stack leak via the OIFNAME register

Dawei Feng (2):
      octeontx2-af: fix memory leak in rvu_setup_hw_resources()
      octeontx2-pf: avoid double free of pool->stack on AQ init failure

Dipayaan Roy (1):
      net: mana: Add NULL guards in teardown path to prevent panic on attach failure

Dmitriy Zharov (1):
      Input: xpad - add support for ASUS ROG RAIKIRI II

Dmitry Osipenko (1):
      drm/virtio: Fix driver removal with disabled KMS

Dmitry Torokhov (3):
      Input: xpad - fix out-of-bounds access for Share button
      Input: elan_i2c - validate firmware size before use
      Input: atmel_mxt_ts - fix boundary check in mxt_prepare_cfg_mem

Doruk Tan Ozturk (1):
      Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync

Dragos Tatulea (1):
      net/mlx5: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list

Dudu Lu (1):
      Bluetooth: bnep: fix incorrect length parsing in bnep_rx_frame() extension handling

Eric Dumazet (9):
      ipv4: free net->ipv4.sysctl_local_reserved_ports after unregister_net_sysctl_table()
      tunnels: load network headers after skb_cow() in iptunnel_pmtud_build_icmp[v6]()
      vxlan: do not reuse cached ip_hdr() value after skb_tunnel_check_pmtu()
      tunnels: do not assume transport header in iptunnel_pmtud_check_icmp()
      ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
      ieee802154: 6lowpan: only accept IPv6 packets in lowpan_xmit()
      tcp: restrict SO_ATTACH_FILTER to priv users
      ip6_vti: fix incorrect tunnel matching in vti6_tnl_lookup()
      ipv6/addrconf: annotate data-races around devconf fields (II)

Eric Huang (2):
      drm/amdkfd: fix NULL pointer bug in svm_range_set_attr
      drm/amdkfd: fix a vulnerability of integer overflow in kfd debugger

Felix Gu (1):
      iio: buffer: hw-consumer: fix use-after-free in error path

Fernando Fernandez Mancera (3):
      netfilter: nf_tables: fix dst corruption in same register operation
      netfilter: xt_NFQUEUE: prefer raw_smp_processor_id
      netfilter: synproxy: add mutex to guard hook reference counting

Florian Westphal (4):
      netfilter: xt_cpu: prefer raw_smp_processor_id
      netfilter: ebtables: fix OOB read in compat_mtw_from_user
      netfilter: conntrack_irc: fix possible out-of-bounds read
      netfilter: nft_exthdr: fix register tracking for F_PRESENT flag

Gabriele Monaco (1):
      tools/rv: Fix cleanup after failed trace setup

Gil Portnoy (2):
      ksmbd: fix NULL-deref of opinfo->conn in oplock/lease break notifiers
      ksmbd: fix use-after-free of a deferred file_lock on double SMB2_CANCEL

Greg Kroah-Hartman (9):
      Input: usbtouchscreen - clamp NEXIO data_len/x_len to URB buffer size
      iio: imu: st_lsm6dsx: fix stack leak in tagged FIFO buffer
      usb: typec: ucsi: ccg: reject firmware images without a ':' record header
      usb: typec: ucsi: displayport: NAK DP_CMD_CONFIGURE without a payload VDO
      usb: typec: altmodes/displayport: validate count before reading Status Update VDO
      usb: typec: wcove: don't write past struct pd_message in wcove_read_rx_buffer()
      usb: typec: tcpm/tcpci_maxim: validate header NDO against RX_BYTE_CNT
      usb: typec: ucsi: validate connector number in ucsi_connector_change()
      Linux 6.6.143

Guangshuo Li (4):
      counter: Fix refcount leak in counter_alloc() error path
      usb: gadget: net2280: Fix double free in probe error path
      usb: gadget: f_hid: fix device reference leak in hidg_alloc()
      dm cache policy smq: check allocation under invalidate lock

Guenter Roeck (1):
      hwmon: (pmbus/core) Protect regulator operations with mutex

Guillermo Rodríguez (1):
      i2c: stm32f7: fix timing computation ignoring i2c-analog-filter

Guopeng Zhang (1):
      cgroup/cpuset: Reset DL migration state on can_attach() failure

Hamza Mahfooz (1):
      netfilter: conntrack: tcp: do not force CLOSE on invalid-seq RST without direction check

Harry Wentland (5):
      drm/amd/display: Reject gpio_bitshift >= 32 in bios_parser_get_gpio_pin_info()
      drm/amd/display: Clamp HDMI HDCP2 rx_id_list read to buffer size
      drm/amd/display: Clamp VBIOS HDMI retimer register count to array size
      drm/amd/display: Fix NULL deref and buffer over-read in SDP debugfs
      drm/amd/display: Use krealloc_array() in dal_vector_reserve()

Harshit Mogalapalli (3):
      ima: verify the previous kernel's IMA buffer lies in addressable RAM
      of/kexec: refactor ima_get_kexec_buffer() to use ima_validate_range()
      x86/kexec: add a sanity check on previous kernel's ima kexec buffer

Heitor Alves de Siqueira (2):
      usb: usbtmc: check URB actual_length for interrupt-IN notifications
      usb: usbtmc: reject interrupt endpoints with small wMaxPacketSize

Henri A (1):
      media: rc: igorplugusb: fix control request setup packet

Hongling Zeng (1):
      serial: sh-sci: fix memory region release in error path

Horatiu Vultur (1):
      phy: mscc: Use PHY_ID_MATCH_EXACT for VSC8584, VSC8582, VSC8575, VSC856X

HyeongJun An (1):
      USB: serial: kl5kusb105: fix bulk-out buffer overflow

Hyunwoo Kim (1):
      inet: frags: fix use-after-free caused by the fqdir_pre_exit() flush

Ian Abbott (2):
      comedi: comedi_test: fix check for valid scan_begin_src in waveform_ai_cmdtest()
      comedi: comedi_test: Fix limiting of convert_arg in waveform_ai_cmdtest()

Ido Schimmel (3):
      ipv6: mcast: Fix use-after-free when processing MLD queries
      ipv6: Fix a potential NPD in cleanup_prefix_route()
      genetlink: Use internal flags for multicast groups

Ilya Maximets (2):
      net: netlink: fix sending unassigned nsid after assigned one
      net: netlink: don't set nsid on local notifications

Inochi Amaoto (2):
      mmc: litex_mmc: Use DIV_ROUND_UP for more accurate clock calculation
      mmc: litex_mmc: Set mandatory idle clocks before CMD0

Jack Wu (1):
      USB: serial: option: add usb-id for Dell Wireless DW5826e-m

Jakub Kicinski (4):
      ethtool: eeprom: add missing ethnl_ops_begin() / _complete() during fallback
      ethtool: eeprom: add more safeties to EEPROM Netlink fallback
      inet: frags: add inet_frag_queue_flush()
      inet: frags: flush pending skbs in fqdir_pre_exit()

Jamal Hadi Salim (1):
      net/sched: act_api: use RCU with deferred freeing for action lifecycle

Jan Volckaert (1):
      USB: serial: option: add MeiG SRM813Q

Jane Chu (1):
      mm/memory-failure: fix missing ->mf_stats count in hugetlb poison

Jann Horn (2):
      fuse: reject fuse_notify() pagecache ops on directories
      af_unix: Fix UAF read of tail->len in unix_stream_data_wait()

Janusz Krzysztofik (1):
      drm/i915: Fix potential UAF in TTM object purge

Jason A. Donenfeld (1):
      wireguard: send: append trailer after expanding head

Jason Gunthorpe (2):
      RDMA: During rereg_mr ensure that REREG_ACCESS is compatible
      RDMA/umem: Fix truncation for block sizes >= 4G

Jeremy Erazo (1):
      usb: gadget: composite: fix integer underflow in WebUSB GET_URL handling

Jeremy Kerr (1):
      net: mctp: ensure our nlmsg responses are initialised

Jeremy Sowden (2):
      netfilter: bitwise: rename some boolean operation functions
      netfilter: bitwise: add support for doing AND, OR and XOR directly

Ji'an Zhou (1):
      ALSA: PCM: Fix wait queue list corruption in snd_pcm_drain() on linked streams

Jiayuan Chen (3):
      ipv6: fix possible infinite loop in rt6_fill_node()
      ipv6: fix possible infinite loop in fib6_select_path()
      netfilter: nft_ct: bail out on template ct in get eval

Jingguo Tan (1):
      xfrm: esp: restore combined single-frag length gate

Jisheng Zhang (1):
      mmc: sdhci: add signal voltage switch in sdhci_resume_host

Johan Hovold (9):
      USB: serial: safe_serial: fix memory corruption with small endpoint
      USB: serial: omninet: fix memory corruption with small endpoint
      USB: serial: keyspan: fix missing indat transfer sanity check
      USB: serial: mxuport: fix memory corruption with small endpoint
      USB: serial: mct_u232: fix missing interrupt-in transfer sanity check
      USB: serial: cypress_m8: fix memory corruption with small endpoint
      USB: serial: digi_acceleport: fix memory corruption with small endpoints
      USB: serial: mct_u232: fix memory corruption with small endpoint
      driver core: reject devices with unregistered buses

Jonathan Cameron (1):
      iio: chemical: scd30: Use guard(mutex) to allow early returns

Joonas Lahtinen (1):
      drm/i915/gem: Fix phys BO pread/pwrite with offset

Jose Ignacio Tornos Martinez (1):
      ice: fix VF queue configuration with low MTU values

Jouni Högander (3):
      drm/i915/psr: Add defininitions for INTEL_WA_REGISTER_CAPS DPCD register
      drm/i915/psr: Read Intel DPCD workaround register
      drm/i915/psr: Apply Intel DPCD workaround when SDP on prior line used

Julian Anastasov (2):
      ipvs: clear the svc scheduler ptr early on edit
      ipvs: skip ipv6 extension headers for csum checks

Junrui Luo (2):
      macsec: fix replay protection at XPN lower-PN wrap
      misc: fastrpc: fix DMA address corruption due to find_vma misuse

Justin Iurman (2):
      ipv6: exthdrs: refresh nh pointer after ipv6_hop_jumbo()
      ipv6: ioam: add NULL check for idev in ipv6_hop_ioam()

Justin Stitt (1):
      octeontx2-af: replace deprecated strncpy with strscpy

Kai Aizen (1):
      usb: gadget: uvc: hold opts->lock across XU walks in uvc_function_bind

Kamal Dasu (1):
      mmc: core: Fix host controller programming for fixed driver type

Karl Mehltretter (2):
      ARM: 9474/1: io: avoid KASAN instrumentation of raw halfword I/O
      ARM: 9475/1: entry: use byte load for KASAN VMAP stack shadow

Kevin Hao (1):
      net: cpsw_new: Fix potential unregister of netdev that has not been registered yet

Kuen-Han Tsai (2):
      usb: gadget: f_ncm: Fix net_device lifecycle with device_move
      usb: gadget: u_ether: Fix NULL pointer deref in eth_get_drvinfo

Kuniyuki Iwashima (5):
      ip6: vti: Use ip6_tnl.net in vti6_changelink().
      bpf: Free reuseport cBPF prog after RCU grace period.
      net: Annotate sk->sk_write_space() for UDP SOCKMAP.
      hsr: Remove WARN_ONCE() in hsr_addr_is_self().
      af_unix: Cache state->msg in unix_stream_read_generic().

Kurt Kanzenbach (1):
      ptp: vclock: Switch from RCU to SRCU

Kyle Meyer (1):
      bnxt_en: Fix NULL pointer dereference

Kyle Zeng (3):
      ipv6: sit: reload inner IPv6 header after GSO offloads
      net: guard timestamp cmsgs to real error queue skbs
      netfilter: x_tables: avoid leaking percpu counter pointers

Lad Prabhakar (1):
      mmc: renesas_sdhi: Add OF entry for RZ/G2H SoC

Lee Jones (3):
      nfc: llcp: Fix use-after-free in llcp_sock_release()
      nfc: llcp: Fix use-after-free race in nfc_llcp_recv_cc()
      HID: wacom: Fix OOB write in wacom_hid_set_device_mode()

Leon Romanovsky (1):
      RDMA: Move DMA block iterator logic into dedicated files

Li Xiasong (1):
      mptcp: pm: fix ADD_ADDR timer infinite retry on option space insufficient

Linpu Yu (1):
      ipc: limit next_id allocation to the valid ID range

Lorenzo Bianconi (2):
      net: ethernet: mtk_eth_soc: Fix use-after-free in metadata dst teardown
      net: mvpp2: Add metadata support for xdp mode

Lorenzo Stoakes (1):
      mm/hugetlb: avoid false positive lockdep assertion

Luiz Augusto von Dentz (2):
      Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
      Bluetooth: MGMT: Fix backward compatibility with userspace

Luka Gejak (1):
      net: hsr: fix potential OOB access in supervision frame handling

Lukas Wunner (1):
      platform/x86/intel/vsec: Fix enable_cnt imbalance on PCIe error recovery

Maciej W. Rozycki (7):
      serial: zs: Fix swapped RI/DSR modem line transition counting
      serial: dz: Fix bootconsole message clobbering at chip reset
      serial: zs: Fix bootconsole handover lockup
      serial: zs: Switch to using channel reset
      serial: dz: Fix bootconsole handover lockup
      serial: dz: Convert to use a platform device
      serial: zs: Convert to use a platform device

Manivannan Sadhasivam (1):
      soc: qcom: ice: Fix race between qcom_ice_probe() and of_qcom_ice_get()

Maoyi Xie (2):
      ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().
      xfrm: route MIGRATE notifications to caller's netns

Marc Zyngier (1):
      KVM: arm64: Remove VPIPT I-cache handling

Marco Scardovi (1):
      gpio: rockchip: convert bank->clk to devm_clk_get_enabled()

Mark Rutland (5):
      arm64: tlb: Allow XZR argument to TLBI ops
      arm64: tlb: Optimize ARM64_WORKAROUND_REPEAT_TLBI
      arm64: cputype: Add C1-Ultra definitions
      arm64: cputype: Add C1-Premium definitions
      arm64: errata: Mitigate TLBI errata on various Arm CPUs

Masami Hiramatsu (Google) (1):
      tracing/probes: Point the error offset correctly for eprobe argument error

Matthieu Baerts (NGI0) (3):
      mptcp: sockopt: check timestamping ret value
      selftests: mptcp: drop nanoseconds width specifier
      mptcp: add-addr: always drop other suboptions

Maxime Chevallier (1):
      net: phy: clean the sfp upstream if phy probing fails

Michael Bommarito (21):
      xfrm: ah: use skb_to_full_sk in async output callbacks
      usbip: vudc: Fix use after free bug in vudc_remove due to race condition
      usb: gadget: f_fs: copy only received bytes on short ep0 read
      thunderbolt: property: Reject u32 wrap in tb_property_entry_valid()
      thunderbolt: property: Reject dir_len < 4 to prevent size_t underflow
      scsi: fcoe: Reject FIP descriptors with zero fip_dlen in CVL walker
      scsi: scsi_transport_fc: Widen FPIN pname walker counter to u32
      scsi: target: iscsi: Bound iscsi_encode_text_output() appends to rsp_buf
      sctp: fix uninit-value in __sctp_rcv_asconf_lookup()
      Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
      RDMA/srp: bound SRP_RSP sense copy by the received length
      IB/isert: Reject login PDUs shorter than ISER_HEADERS_LEN
      thunderbolt: Reject zero-length property entries in validator
      thunderbolt: Bound root directory content to block size
      thunderbolt: Clamp XDomain response data copy to allocation size
      thunderbolt: Validate XDomain request packet size before type cast
      thunderbolt: Limit XDomain response copy to actual frame size
      smb: client: require net admin for CIFS SWN netlink
      net: hsr: defer node table free until after RCU readers
      thunderbolt: property: Cap recursion depth in __tb_property_parse_dir()
      scsi: target: iscsi: Fix CRC overread and double-free in iscsit_handle_text_cmd()

Michal Pecio (2):
      usb: core: Fix up Interrupt IN endpoints with bogus wBytesPerInterval
      usb: core: Fix SuperSpeed root hub wMaxPacketSize

Mickaël Salaün (1):
      landlock: Fix handling of disconnected directories

Mikhail Gavrilov (1):
      mm/page_alloc: clear page->private in free_pages_prepare()

Mikulas Patocka (1):
      hpfs: fix a crash if hpfs_map_dnode_bitmap fails

Mingyu Wang (3):
      i2c: dev: prevent integer overflow in I2C_TIMEOUT ioctl
      net: qrtr: fix refcount saturation and potential UAF in qrtr_port_remove
      fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync signaling

Mingzhe Zou (1):
      bcache: fix uninitialized closure object

Minh Nguyen (1):
      net: skbuff: fix missing zerocopy reference in pskb_carve helpers

Muhammad Bilal (4):
      Bluetooth: HIDP: fix missing length checks in hidp_input_report()
      Bluetooth: ISO: fix UAF in iso_recv_frame
      Bluetooth: ISO: serialize iso_sock_clear_timer with socket lock
      drm/amdkfd: fix NULL dereference in get_queue_ids()

Mukesh Ojha (1):
      misc: fastrpc: Fix NULL pointer dereference in rpmsg callback

Myeonghun Pak (1):
      serial: altera_jtaguart: handle uart_add_one_port() failures

Myrrh Periwinkle (2):
      usb: typec: ucsi: Check if power role change actually happened before handling
      usb: typec: ucsi: Don't update power_supply on power role change if not connected

Nathan Chancellor (2):
      HID: core: Fix size_t specifier in hid_report_raw_event()
      Disable -Wattribute-alias for clang-23 and newer

Naveen Kumar Chaudhary (1):
      time: Fix off-by-one in settimeofday() usec validation

Nicolás Bazaes (1):
      Input: synaptics - add LEN2058 to SMBus passlist for ThinkPad E490

Nicolò Coccia (1):
      net/smc: fix sleep-inside-lock in __smc_setsockopt() causing local DoS

Nikolay Kuratov (1):
      net/mlx5: Reorder completion before putting command entry in cmd_work_handler

Nithin Dabilpuram (1):
      octeontx2-af: npc: Fix CPT channel mask in npc_install_flow

Oliver Hartkopp (1):
      bonding: refuse to enslave CAN devices

Oliver Neukum (1):
      media: rc: ttusbir: fix inverted error logic

Oscar Maes (1):
      pcnet32: stop holding device spin lock during napi_complete_done

Pablo Neira Ayuso (1):
      netfilter: ctnetlink: ensure safe access to master conntrack

Paolo Abeni (9):
      mptcp: fix retransmission loop when csum is enabled
      mptcp: close TOCTOU race while computing rcv_wnd
      mptcp: allow subflow rcv wnd to shrink
      mptcp: use plain bool instead of custom binary enum
      mptcp: cleanup fallback dummy mapping generation
      mptcp: reset rcv wnd on disconnect
      mptcp: introduce the mptcp_init_skb helper
      mptcp: handle first subflow closing consistently
      mptcp: fix missing wakeups in edge scenarios

Pauli Virtanen (1):
      Bluetooth: hci_conn: fix potential UAF in set_cig_params_sync

Pavel Begunkov (1):
      net: skbuff: fix pskb_carve leaking zcopy pages

Pengyu Luo (1):
      clk: qcom: dispcc-sc8280xp: Don't park mdp_clk_src at registration time

Peter Chen (2):
      usb: cdns3: plat: fix unbalanced pm_runtime_forbid() call permanently leaks the runtime PM usage counter across bind/unbind cycles
      usb: cdns3: plat: fix leaked usb2_phy initialization on usb3_phy acquisition failure

Petr Machata (1):
      Revert "selftest/ptp: update ptp selftest to exercise the gettimex options"

Prasanna S (1):
      serial: qcom-geni: fix UART_RX_PAR_EN bit position

Prathamesh Shete (1):
      soc/tegra: pmc: Fix unsafe generic_handle_irq() call

Pratyush Yadav (Google) (1):
      memfd: deny writeable mappings when implying SEAL_WRITE

Qbeliw Tanaka (1):
      Input: xpad - add "Nova 2 Lite" from GameSir

Qi Tang (1):
      ipv6: validate extension header length before copying to cmsg

Qiang Ma (1):
      KVM: arm64: PMU: Preserve AArch32 counter low bits

Radhey Shyam Pandey (1):
      usb: dwc3: xilinx: fix error handling in zynqmp init error paths

Raf Dickson (1):
      vsock/vmci: fix sk_ack_backlog leak on failed handshake

Rahul Chandelkar (1):
      ipv6: rpl: fix hdrlen overflow in ipv6_rpl_srh_decompress()

Randy Dunlap (1):
      RDMA/umem: fix kernel-doc warnings

Ricardo B. Marliere (1):
      serdev: make serdev_bus_type const

Richard Fitzgerald (1):
      ASoC: wm_adsp: Fix NULL dereference when removing firmware controls

Rodrigo Alencar (3):
      iio: dac: ad5686: fix input raw value check
      iio: dac: ad5686: acquire lock when doing powerdown control
      iio: dac: ad5686: fix ref bit initialization for single-channel parts

Rui Qi (1):
      ipmi: Fix rcu_read_unlock to srcu_read_unlock in handle_read_event_rsp

Salah Triki (3):
      iio: dac: max5821: fix return value check in powerdown sync
      iio: adc: viperboard: Fix error handling in vprbrd_iio_read_raw
      iio: temperature: tsys01: fix broken PROM checksum validation

Sam Burkels (1):
      usb: storage: Add quirks for PNY Elite Portable SSD

Sam Daly (1):
      octeontx2-af: CGX: add bounds check to cgx_speed_mbps index

Sanghyun Park (1):
      xfrm: policy: fix use-after-free on inexact bin in xfrm_policy_bysel_ctx()

Sanjay Chitroda (1):
      iio: ssp_sensors: cancel delayed work_refresh on remove

Sean Christopherson (2):
      KVM: SVM: Flush the current TLB when transitioning from xAVIC => x2AVIC
      KVM: Don't WARN if memory is dirtied without a vCPU when the VM is dying

Sean Shen (1):
      ksmbd: fix FSCTL permission bypass by adding a permission check for FSCTL_SET_SPARSE

Sean Young (1):
      media: rc: fix race between unregister and urb/irq callbacks

Sechang Lim (1):
      udp: clear skb->dev before running a sockmap verdict

SeongJae Park (2):
      mm/damon/ops-common: call folio_test_lru() after folio_get()
      mm/damon/sysfs-schemes: delete tried region in regions_rmdirs()

SeungJu Cheon (1):
      Bluetooth: RFCOMM: validate skb length in MCC handlers

Seungjin Bae (1):
      usb: gadget: dummy_hcd: Reject hub port requests for non-existent ports

Shanker Donthineni (2):
      arm64: cputype: Add NVIDIA Olympus definitions
      arm64: errata: Mitigate TLBI errata on NVIDIA Olympus CPU

Shardul Bankar (1):
      mptcp: do not drop partial packets

Shitalkumar Gandhi (1):
      serial: fsl_lpuart: fix rx buffer and DMA map leaks in start_rx_dma

Shuai Zhang (2):
      Bluetooth: btusb: Allow firmware re-download when version matches
      Bluetooth: hci_qca: Convert timeout from jiffies to ms

Siwei Zhang (2):
      Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()
      Bluetooth: L2CAP: fix chan ref leak in l2cap_chan_timeout() on !conn

Srinivas Kandagatla (3):
      ASoC: qcom: q6asm-dai: fix error handling in prepare and set_params
      ASoC: qcom: q6asm-dai: close stream only when running
      ASoC: qcom: q6asm-dai: do not set stream state in event and trigger callbacks

Stepan Ionichev (1):
      auxdisplay: line-display: fix OOB read on zero-length message_store()

Stephen J. Fuhry (1):
      USB: quirks: add NO_LPM for Lenovo ThinkPad USB-C Dock Gen2 hub controllers

Suraj Kandpal (1):
      drm/dp: Add eDP 1.5 bit definition

Sven Eckelmann (11):
      batman-adv: v: stop OGMv2 on disabled interface
      batman-adv: tvlv: abort OGM send on tvlv append failure
      batman-adv: tt: reject oversized local TVLV buffers
      batman-adv: bla: avoid NULL-ptr deref for claim via dropped interface
      batman-adv: tvlv: reject oversized TVLV packets
      batman-adv: iv: recover OGM scheduling after forward packet error
      batman-adv: tp_meter: avoid role confusion in tp_list
      batman-adv: tp_meter: directly shut down timer on cleanup
      batman-adv: tt: fix TOCTOU race for reported vlans
      batman-adv: tt: avoid empty VLAN responses
      batman-adv: bla: avoid double decrement of bla.num_requests

Takashi Iwai (1):
      ALSA: timer: Fix UAF at snd_timer_user_params()

Tao Cui (1):
      selftests: mptcp: add test for extra_subflows underflow on userspace PM

Tapio Reijonen (1):
      net: fec: fix pinctrl default state restore order on resume

Thomas Fourier (1):
      Input: ims-pcu - fix usb_free_coherent() size in ims_pcu_buffers_free()

Thomas Gleixner (1):
      serial: samsung_tty: Use port lock wrappers

Thomas Zimmermann (3):
      drm/fbdev-helper: Set and clear VGA switcheroo client from fb_info
      drm, fbcon, vga_switcheroo: Avoid race condition in fbcon setup
      fbdev/vt8500lcdfb: Initialize fb_ops with fbdev macros

Til Kaiser (4):
      net: mvpp2: sync RX data at the hardware packet offset
      net: mvpp2: limit XDP frame size to the RX buffer
      net: mvpp2: refill RX buffers before XDP or skb use
      net: mvpp2: build skb from XDP-adjusted data on XDP_PASS

Timur Kristóf (1):
      drm/amd/pm/si: Disregard vblank time when no displays are connected

Tristan Madani (1):
      netfilter: nft_tunnel: fix use-after-free on object destroy

Tudor Ambarus (2):
      tty: serial: samsung: use u32 for register interactions
      tty: serial: samsung: Remove redundant port lock acquisition in rx helpers

Uwe Kleine-König (3):
      iio: adc: npcm: Convert to platform remove callback returning void
      serdev: Provide a bustype shutdown function
      Bluetooth: hci_qca: Migrate to serdev specific shutdown function

Vicki Pfau (1):
      HID: core: Add printk_ratelimited variants to hid_warn() etc

Victor Nogueria (1):
      net/sched: sch_sfb: Replace direct dequeue call with peek and qdisc_dequeue_peeked

Viken Dadhaniya (1):
      serial: qcom_geni: fix kfifo underflow when flush precedes DMA completion IRQ

Vladimir Zapolskiy (1):
      i2c: qcom-cci: Fix NULL pointer dereference in cci_remove()

Wanquan Zhong (1):
      USB: serial: option: add missing RSVD(5) flag for Rolling RW135R-GL

Wei-Cheng Chen (1):
      xhci: tegra: Fix ghost USB device on dual-role port unplug

Weiming Shi (5):
      tun: free page on short-frame rejection in tun_xdp_one()
      tun: free page on build_skb failure in tun_xdp_one()
      tap: free page on error paths in tap_get_user_xdp()
      net/rds: fix NULL deref in rds_ib_send_cqe_handler() on masked atomic completion
      netfilter: nf_conntrack: destroy stale expectfn expectations on unregister

Wentao Guan (1):
      USB: cdc-acm: Fix bit overlap and move quirk definitions to header

Wentao Liang (2):
      drm/virtio: fix dma_fence refcount leak on error in virtio_gpu_dma_fence_wait()
      usb: musb: omap2430: Fix use-after-free in omap2430_probe()

Will Deacon (3):
      arm64: io: Rename ioremap_prot() to __ioremap_prot()
      arm64: io: Extract user memory type in ioremap_prot()
      arm64: errata: Mitigate TLBI errata on Microsoft Azure Cobalt 100 CPU

Wupeng Ma (1):
      mm/memory-failure: fix hugetlb_lock AA deadlock in get_huge_page_for_hwpoison

Wyatt Feng (2):
      xfrm: espintcp: do not reuse an in-progress partial send
      sctp: stream: fully roll back denied add-stream state

Xiang Mei (2):
      netfilter: nf_log: validate MAC header was set before dumping it
      net: bonding: fix use-after-free in bond_xmit_broadcast()

Xin Long (1):
      sctp: purge outqueue on stale COOKIE-ECHO handling

Xu Yang (1):
      usb: chipidea: core: convert ci_role_switch to local variable

Yao Sang (1):
      net/mlx4: avoid GCC 10 __bad_copy_from() false positive

Yeoreum Yun (1):
      perf: Fix dangling cgroup pointer in cpuctx

Yicong Hui (1):
      drm/imx: Fix three kernel-doc warnings in dcss-scaler.c

Yilin Zhu (1):
      ipc/shm: serialize orphan cleanup with shm_nattch updates

Yiming Qian (1):
      netfilter: bridge: make ebt_snat ARP rewrite writable

Yin Tirui (1):
      mm/huge_memory: update file PMD counter before folio_put()

Yizhou Zhao (3):
      6lowpan: fix off-by-one in multicast context address compression
      net: garp: fix unsigned integer underflow in garp_pdu_parse_attr
      net/802/mrp: fix vector attribute parsing in mrp_pdu_parse_vecattr

Yongchao Wu (1):
      usb: cdns3: gadget: fix request skipping after clearing halt

Yuho Choi (1):
      ARM: socfpga: Fix OF node refcount leak in SMP setup

Yun Zhou (1):
      gpio: mvebu: fix NULL pointer dereference in suspend/resume

Yuqi Xu (4):
      bpf: sockmap: fix tail fragment offset in bpf_msg_push_data
      Bluetooth: hci_sync: reject oversized Broadcast Announcement prepend
      wifi: nl80211: reject oversized EMA RNR lists
      net: rds: clear i_sends on setup unwind

Zeng Heng (1):
      arm64: tlb: Flush walk cache when unsharing PMD tables

Zeyu WANG (1):
      Input: atkbd - add DMI quirk for Lenovo Yoga Air 14 (83QK)

Zhang Cen (5):
      USB: serial: belkin_sa: validate interrupt status length
      USB: serial: cypress_m8: validate interrupt packet headers
      Bluetooth: RFCOMM: hold listener socket in rfcomm_connect_ind()
      Bluetooth: MGMT: validate advertising TLV before type checks
      Bluetooth: bnep: reject short frames before parsing

Zhao Dongdong (1):
      Bluetooth: 6lowpan: check skb_clone() return value in send_mcast_pkt()

Zhao Zhang (1):
      sctp: diag: reject stale associations in dump_one path

ZhaoJinming (1):
      net: bonding: fix NULL pointer dereference in bond_do_ioctl()

Zhaoyang Yu (1):
      tty: serial: pch_uart: add check for dma_alloc_coherent()

Zhengchuan Liang (4):
      net: af_key: zero aligned sockaddr tail in PF_KEY exports
      ipv6: exthdrs: refresh nh after handling HAO option
      xfrm: input: hold netns during deferred transport reinjection
      netfilter: require Ethernet MAC header before using eth_hdr()

Zhenghang Xiao (3):
      Bluetooth: l2cap: clear chan->ident on ECRED reconfiguration success
      sctp: fix race between sctp_wait_for_connect and peeloff
      misc: fastrpc: fix use-after-free race in fastrpc_map_create

Zhu Yanjun (1):
      RDMA/rxe: Fix "trying to register non-static key in rxe_qp_do_cleanup" bug

Ziyu Zhang (1):
      vsock: keep poll shutdown state consistent

hlleng (1):
      HID: quirks: Add ALWAYS_POLL quirk for SIGMACHIP USB mouse

