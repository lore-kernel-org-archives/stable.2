Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C73815FD;
	Fri, 19 Jun 2026 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781870425; cv=none; b=PyxrGidWxby9Swa4om+BOeblte8OqYslouy7gH0tn1cFAAG7Yx386ExR7OFg+MNh4DhA32g83+oDaFefzIrUQCeA+OFhsYHPlRSgeFrmL3cP1ywwaGRiQTdyOx99+sdf5pYnaTp2RPk9xMivVqDWVJaGaFROi93dieFN12yODuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781870425; c=relaxed/simple;
	bh=VzdoM7Ek1QFJjISE0k+gGfEkYPPabDhZE1gw/fGcbn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NrF0SKHUyGHXDHDNyum/I+HVvvgz+mHjGQblwBEshDtfFjWUNkOknu9iAppOAyEnU2J2YSYQWTHtdp9Ks3/JV4GOU3RT89bt5sEeG+ZyTpB4Mr+BrSEQzxKAD+N7hSGBkybxCoScMd2a1ZBCLuNeqiiJFJpaWJ8WyeQE0t7O2vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kzM9bF1p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kzM9bF1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98CE1F000E9;
	Fri, 19 Jun 2026 12:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781870421;
	bh=IJ4LgRN8CqzRr2hOS0kIhZk05fsiLGz7SBKwoCjtesw=;
	h=From:To:Cc:Subject:Date;
	b=kzM9bF1pf8LLiynFO4Y7SmRUZN+Kd+kjLiQIicvJKS5r+6QUXt1fFb0R0Axo8dk2K
	 +8jFi0x2qJbK0t+HuweopsoqGPu8H0LTkuW9z5AxjU3HfF17qxlEAwJLPMpdBQ+RNT
	 3qvAo8JRBwErPHFwefZUiIR9ooWgHB44NSQ80j64=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.176
Date: Fri, 19 Jun 2026 13:58:50 +0200
Message-ID: <2026061951-rival-agenda-1228@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.176 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arm64/silicon-errata.rst                            |   46 +
 Makefile                                                          |    2 
 arch/arm/include/asm/io.h                                         |   15 
 arch/arm/kernel/entry-armv.S                                      |    2 
 arch/arm/mach-socfpga/platsmp.c                                   |    1 
 arch/arm64/Kconfig                                                |   50 ++
 arch/arm64/include/asm/cputype.h                                  |    6 
 arch/arm64/include/asm/kvm_mmu.h                                  |    4 
 arch/arm64/include/asm/tlb.h                                      |    2 
 arch/arm64/include/asm/tlbflush.h                                 |   52 +-
 arch/arm64/kernel/cpu_errata.c                                    |   34 +
 arch/arm64/kernel/sys_compat.c                                    |    2 
 arch/arm64/kvm/arm.c                                              |    5 
 arch/arm64/kvm/hyp/nvhe/tlb.c                                     |   41 -
 arch/arm64/kvm/hyp/pgtable.c                                      |    2 
 arch/arm64/kvm/hyp/vhe/tlb.c                                      |   19 
 arch/arm64/mm/mmu.c                                               |   36 -
 arch/loongarch/kernel/syscall.c                                   |    3 
 arch/x86/kernel/cpu/amd.c                                         |   18 
 block/blk-cgroup.c                                                |   32 -
 drivers/auxdisplay/line-display.c                                 |    2 
 drivers/base/power/domain.c                                       |   10 
 drivers/bluetooth/btusb.c                                         |    8 
 drivers/bluetooth/hci_qca.c                                       |   33 -
 drivers/char/ipmi/ipmi_msghandler.c                               |    2 
 drivers/char/ipmi/ipmi_ssif.c                                     |   42 -
 drivers/comedi/drivers/comedi_test.c                              |    5 
 drivers/counter/counter-core.c                                    |    3 
 drivers/crypto/caam/caamalg_qi2.c                                 |    4 
 drivers/crypto/caam/caamhash.c                                    |    4 
 drivers/dma/idxd/init.c                                           |    1 
 drivers/dma/idxd/sysfs.c                                          |    1 
 drivers/gpio/gpio-rockchip.c                                      |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                            |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                          |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                              |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c         |    5 
 drivers/gpu/drm/amd/display/dc/basics/vector.c                    |    4 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c                |   54 +-
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c               |    3 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                        |    4 
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c                         |  113 ++++
 drivers/gpu/drm/i915/display/intel_display_types.h                |    1 
 drivers/gpu/drm/i915/display/intel_dpcd.h                         |   15 
 drivers/gpu/drm/i915/display/intel_psr.c                          |   34 +
 drivers/gpu/drm/i915/gem/i915_gem_phys.c                          |   19 
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c                           |   28 -
 drivers/gpu/drm/imx/dcss/dcss-scaler.c                            |    3 
 drivers/gpu/drm/v3d/v3d_gem.c                                     |    5 
 drivers/gpu/drm/vc4/vc4_validate_shaders.c                        |   13 
 drivers/hid/hid-core.c                                            |   33 +
 drivers/hid/hid-gfrm.c                                            |    4 
 drivers/hid/hid-ids.h                                             |    1 
 drivers/hid/hid-logitech-hidpp.c                                  |    2 
 drivers/hid/hid-multitouch.c                                      |    2 
 drivers/hid/hid-primax.c                                          |    2 
 drivers/hid/hid-quirks.c                                          |    1 
 drivers/hid/hid-vivaldi-common.c                                  |    2 
 drivers/hid/wacom_sys.c                                           |   19 
 drivers/hid/wacom_wac.h                                           |    1 
 drivers/hwmon/pmbus/adm1266.c                                     |   54 ++
 drivers/i2c/busses/i2c-qcom-cci.c                                 |    2 
 drivers/i2c/busses/i2c-stm32f7.c                                  |    6 
 drivers/i2c/busses/i2c-tegra.c                                    |   53 +-
 drivers/i2c/i2c-dev.c                                             |    9 
 drivers/iio/adc/bcm_iproc_adc.c                                   |    4 
 drivers/iio/adc/lpc32xx_adc.c                                     |    4 
 drivers/iio/adc/npcm_adc.c                                        |   31 -
 drivers/iio/adc/spear_adc.c                                       |    4 
 drivers/iio/adc/viperboard_adc.c                                  |    4 
 drivers/iio/adc/xilinx-xadc-core.c                                |   11 
 drivers/iio/buffer/industrialio-hw-consumer.c                     |    4 
 drivers/iio/chemical/scd30_core.c                                 |   65 +-
 drivers/iio/common/ssp_sensors/ssp_dev.c                          |    1 
 drivers/iio/dac/ad5686.c                                          |   16 
 drivers/iio/dac/ad5686.h                                          |    1 
 drivers/iio/dac/max5821.c                                         |    9 
 drivers/iio/gyro/adis16260.c                                      |    3 
 drivers/iio/gyro/itg3200_buffer.c                                 |    2 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c                    |    2 
 drivers/iio/light/cm3323.c                                        |    5 
 drivers/iio/magnetometer/st_magn_core.c                           |   13 
 drivers/iio/temperature/tsys01.c                                  |    2 
 drivers/infiniband/core/Makefile                                  |    2 
 drivers/infiniband/core/iter.c                                    |   43 +
 drivers/infiniband/core/verbs.c                                   |   38 -
 drivers/infiniband/hw/bnxt_re/qplib_res.c                         |    2 
 drivers/infiniband/hw/cxgb4/mem.c                                 |    2 
 drivers/infiniband/hw/efa/efa_verbs.c                             |    2 
 drivers/infiniband/hw/erdma/erdma_verbs.c                         |    2 
 drivers/infiniband/hw/hns/hns_roce_alloc.c                        |    2 
 drivers/infiniband/hw/irdma/main.h                                |    2 
 drivers/infiniband/hw/mlx4/mr.c                                   |    1 
 drivers/infiniband/hw/mlx5/mem.c                                  |    1 
 drivers/infiniband/hw/mlx5/umr.c                                  |    1 
 drivers/infiniband/hw/mthca/mthca_provider.c                      |    2 
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c                       |    2 
 drivers/infiniband/hw/qedr/verbs.c                                |    2 
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h                         |    2 
 drivers/infiniband/sw/rxe/rxe_qp.c                                |    4 
 drivers/infiniband/sw/rxe/rxe_srq.c                               |    3 
 drivers/infiniband/ulp/isert/ib_isert.c                           |    6 
 drivers/infiniband/ulp/srp/ib_srp.c                               |   30 +
 drivers/input/keyboard/atkbd.c                                    |   15 
 drivers/input/misc/ims-pcu.c                                      |    2 
 drivers/input/mouse/elan_i2c_core.c                               |    5 
 drivers/input/mouse/synaptics.c                                   |    1 
 drivers/input/touchscreen/atmel_mxt_ts.c                          |    2 
 drivers/input/touchscreen/usbtouchscreen.c                        |    5 
 drivers/iommu/io-pgtable-arm-v7s.c                                |   18 
 drivers/md/dm-cache-policy-smq.c                                  |   12 
 drivers/media/rc/igorplugusb.c                                    |   18 
 drivers/media/rc/ttusbir.c                                        |   13 
 drivers/misc/fastrpc.c                                            |  102 ++--
 drivers/mmc/core/mmc.c                                            |    4 
 drivers/mmc/host/litex_mmc.c                                      |   20 
 drivers/mmc/host/renesas_sdhi_internal_dmac.c                     |    1 
 drivers/mmc/host/sdhci.c                                          |    1 
 drivers/mtd/spi-nor/core.c                                        |    1 
 drivers/mtd/spi-nor/debugfs.c                                     |    4 
 drivers/net/bonding/bond_main.c                                   |   19 
 drivers/net/bonding/bond_options.c                                |    2 
 drivers/net/ethernet/amd/pcnet32.c                                |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                         |    2 
 drivers/net/ethernet/freescale/fec_main.c                         |    3 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c                     |    2 
 drivers/net/ethernet/marvell/mv643xx_eth.c                        |    2 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                   |   75 ++-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                   |   13 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                   |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                   |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c               |   32 -
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c            |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c          |    2 
 drivers/net/ethernet/mellanox/mlx4/cq.c                           |    9 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                     |    6 
 drivers/net/ethernet/microchip/lan743x_main.c                     |   32 +
 drivers/net/ethernet/microchip/lan743x_main.h                     |    1 
 drivers/net/ethernet/microsoft/mana/mana_en.c                     |   70 +--
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c                  |    2 
 drivers/net/ethernet/stmicro/stmmac/common.h                      |    2 
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c                   |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                 |   47 +-
 drivers/net/ethernet/ti/cpsw_new.c                                |    4 
 drivers/net/hyperv/netvsc.c                                       |   19 
 drivers/net/macsec.c                                              |    3 
 drivers/net/phy/mscc/mscc.h                                       |    9 
 drivers/net/phy/mscc/mscc_main.c                                  |   38 -
 drivers/net/tap.c                                                 |    2 
 drivers/net/tun.c                                                 |    5 
 drivers/net/usb/r8152.c                                           |  224 ++++++++-
 drivers/net/vxlan/vxlan_core.c                                    |    4 
 drivers/net/vxlan/vxlan_vnifilter.c                               |    5 
 drivers/net/wireguard/send.c                                      |   20 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c           |    4 
 drivers/net/wireless/marvell/mwifiex/init.c                       |    2 
 drivers/net/wwan/t7xx/t7xx_modem_ops.c                            |   17 
 drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c                        |   18 
 drivers/net/wwan/t7xx/t7xx_port_proxy.h                           |    2 
 drivers/nfc/nxp-nci/i2c.c                                         |   21 
 drivers/parport/share.c                                           |   11 
 drivers/phy/tegra/xusb-tegra186.c                                 |   38 +
 drivers/phy/tegra/xusb.h                                          |    1 
 drivers/platform/x86/intel/vsec.c                                 |   77 ++-
 drivers/platform/x86/intel/vsec.h                                 |    2 
 drivers/ptp/ptp_vclock.c                                          |   14 
 drivers/scsi/fcoe/fcoe_ctlr.c                                     |    2 
 drivers/scsi/scsi_transport_fc.c                                  |   77 +--
 drivers/slimbus/qcom-ngd-ctrl.c                                   |    5 
 drivers/spi/spi-amd.c                                             |    2 
 drivers/spi/spi-cavium-thunderx.c                                 |    2 
 drivers/spi/spi-falcon.c                                          |    2 
 drivers/spi/spi-imx.c                                             |    8 
 drivers/spi/spi-lantiq-ssc.c                                      |    8 
 drivers/spi/spi-lp8841-rtc.c                                      |    2 
 drivers/spi/spi-microchip-core-qspi.c                             |   47 --
 drivers/spi/spi-mxs.c                                             |    2 
 drivers/spi/spi-omap-uwire.c                                      |    2 
 drivers/spi/spi-pic32-sqi.c                                       |    2 
 drivers/spi/spi-qcom-qspi.c                                       |    2 
 drivers/spi/spi-qup.c                                             |  169 +++----
 drivers/spi/spi-rockchip-sfc.c                                    |    2 
 drivers/spi/spi-s3c64xx.c                                         |   44 -
 drivers/spi/spi-sprd-adi.c                                        |    2 
 drivers/spi/spi-st-ssc4.c                                         |   76 +--
 drivers/spi/spi-sun4i.c                                           |   84 +--
 drivers/spi/spi-sun6i.c                                           |    9 
 drivers/spi/spi-synquacer.c                                       |   92 ++-
 drivers/spi/spi-tegra114.c                                        |    8 
 drivers/spi/spi-tegra20-sflash.c                                  |    8 
 drivers/spi/spi-ti-qspi.c                                         |   97 ++--
 drivers/spi/spi-topcliff-pch.c                                    |    6 
 drivers/spi/spi-uniphier.c                                        |  216 ++++-----
 drivers/spi/spi-xcomm.c                                           |    2 
 drivers/spi/spi-zynq-qspi.c                                       |   89 +--
 drivers/spi/spi-zynqmp-gqspi.c                                    |    4 
 drivers/spi/spi.c                                                 |   61 +-
 drivers/staging/greybus/hid.c                                     |    2 
 drivers/target/iscsi/iscsi_target.c                               |    6 
 drivers/target/iscsi/iscsi_target_auth.c                          |   19 
 drivers/target/iscsi/iscsi_target_nego.c                          |    7 
 drivers/target/iscsi/iscsi_target_parameters.c                    |   62 ++
 drivers/target/iscsi/iscsi_target_parameters.h                    |    2 
 drivers/tee/optee/supp.c                                          |  107 +++-
 drivers/thermal/thermal_core.c                                    |    7 
 drivers/thunderbolt/property.c                                    |   38 +
 drivers/thunderbolt/xdomain.c                                     |   14 
 drivers/tty/serial/altera_jtaguart.c                              |    7 
 drivers/tty/serial/dz.c                                           |   57 +-
 drivers/tty/serial/fsl_lpuart.c                                   |   15 
 drivers/tty/serial/pch_uart.c                                     |   19 
 drivers/tty/serial/qcom_geni_serial.c                             |   77 +--
 drivers/tty/serial/samsung_tty.c                                  |  130 ++---
 drivers/tty/serial/sh-sci.c                                       |    2 
 drivers/tty/serial/zs.c                                           |   40 -
 drivers/tty/serial/zs.h                                           |    2 
 drivers/usb/cdns3/cdns3-gadget.c                                  |   12 
 drivers/usb/cdns3/cdns3-plat.c                                    |   11 
 drivers/usb/chipidea/core.c                                       |   16 
 drivers/usb/class/cdc-acm.c                                       |    2 
 drivers/usb/class/cdc-acm.h                                       |    2 
 drivers/usb/class/usbtmc.c                                        |   14 
 drivers/usb/core/config.c                                         |    9 
 drivers/usb/core/hcd.c                                            |    4 
 drivers/usb/core/quirks.c                                         |    4 
 drivers/usb/dwc2/hcd.c                                            |    4 
 drivers/usb/dwc3/core.c                                           |   12 
 drivers/usb/dwc3/dwc3-xilinx.c                                    |   26 -
 drivers/usb/gadget/function/f_fs.c                                |    2 
 drivers/usb/gadget/function/f_hid.c                               |   20 
 drivers/usb/gadget/function/f_ncm.c                               |   35 +
 drivers/usb/gadget/function/u_ether.c                             |   28 +
 drivers/usb/gadget/function/u_ether.h                             |   26 +
 drivers/usb/gadget/function/u_ncm.h                               |    2 
 drivers/usb/gadget/udc/dummy_hcd.c                                |    4 
 drivers/usb/gadget/udc/net2280.c                                  |    4 
 drivers/usb/host/xhci-tegra.c                                     |   78 +--
 drivers/usb/musb/omap2430.c                                       |    3 
 drivers/usb/serial/belkin_sa.c                                    |    3 
 drivers/usb/serial/cypress_m8.c                                   |   20 
 drivers/usb/serial/digi_acceleport.c                              |   23 
 drivers/usb/serial/io_ti.c                                        |   11 
 drivers/usb/serial/keyspan.c                                      |    4 
 drivers/usb/serial/kl5kusb105.c                                   |    4 
 drivers/usb/serial/mct_u232.c                                     |   26 -
 drivers/usb/serial/mxuport.c                                      |    8 
 drivers/usb/serial/omninet.c                                      |    9 
 drivers/usb/serial/option.c                                       |   12 
 drivers/usb/serial/safe_serial.c                                  |   11 
 drivers/usb/storage/unusual_uas.h                                 |    7 
 drivers/usb/typec/altmodes/displayport.c                          |    2 
 drivers/usb/typec/tcpm/tcpm.c                                     |    2 
 drivers/usb/typec/tcpm/wcove.c                                    |   13 
 drivers/usb/typec/ucsi/displayport.c                              |    4 
 drivers/usb/typec/ucsi/ucsi.c                                     |   24 -
 drivers/usb/typec/ucsi/ucsi_ccg.c                                 |    5 
 drivers/usb/usbip/vudc_dev.c                                      |    1 
 drivers/usb/usbip/vudc_transfer.c                                 |    3 
 drivers/video/fbdev/core/fb_defio.c                               |  164 ++++++-
 drivers/video/fbdev/core/fbcon_rotate.c                           |    5 
 drivers/video/fbdev/vt8500lcdfb.c                                 |    2 
 fs/btrfs/inode.c                                                  |    2 
 fs/btrfs/ioctl.c                                                  |    5 
 fs/btrfs/space-info.c                                             |    8 
 fs/btrfs/sysfs.c                                                  |    5 
 fs/btrfs/sysfs.h                                                  |    3 
 fs/ceph/dir.c                                                     |    6 
 fs/erofs/decompressor.c                                           |    1 
 fs/f2fs/data.c                                                    |    4 
 fs/f2fs/f2fs.h                                                    |    5 
 fs/f2fs/inline.c                                                  |   13 
 fs/f2fs/node.c                                                    |    4 
 fs/f2fs/segment.c                                                 |   10 
 fs/f2fs/super.c                                                   |   29 -
 fs/fcntl.c                                                        |    8 
 fs/fuse/dev.c                                                     |    9 
 fs/hfsplus/bfind.c                                                |   51 ++
 fs/hfsplus/catalog.c                                              |    4 
 fs/hfsplus/dir.c                                                  |    2 
 fs/hfsplus/hfsplus_fs.h                                           |    9 
 fs/hfsplus/super.c                                                |    6 
 fs/hpfs/alloc.c                                                   |    2 
 fs/iomap/buffered-io.c                                            |    4 
 fs/ntfs3/xattr.c                                                  |    1 
 fs/smb/client/cifsacl.c                                           |  128 ++++-
 fs/smb/client/ioctl.c                                             |    2 
 fs/smb/client/netlink.c                                           |    6 
 fs/smb/client/smb2transport.c                                     |   32 +
 fs/smb/server/smb2pdu.c                                           |   11 
 fs/smb/server/smbacl.c                                            |   17 
 fs/udf/super.c                                                    |    4 
 fs/xfs/xfs_buf.c                                                  |    1 
 include/drm/display/drm_dp.h                                      |    1 
 include/drm/drm_fourcc.h                                          |    5 
 include/linux/compat.h                                            |    4 
 include/linux/compiler-clang.h                                    |    6 
 include/linux/compiler_attributes.h                               |   11 
 include/linux/compiler_types.h                                    |    4 
 include/linux/damon.h                                             |    2 
 include/linux/fb.h                                                |    4 
 include/linux/hid.h                                               |   15 
 include/linux/hugetlb.h                                           |   14 
 include/linux/mm.h                                                |    5 
 include/linux/parport.h                                           |    1 
 include/linux/printk.h                                            |   13 
 include/linux/syscalls.h                                          |    4 
 include/net/act_api.h                                             |    1 
 include/net/bluetooth/bluetooth.h                                 |    1 
 include/net/bluetooth/l2cap.h                                     |    1 
 include/net/bonding.h                                             |    1 
 include/net/genetlink.h                                           |    9 
 include/net/ip_vs.h                                               |    3 
 include/net/mctp.h                                                |    3 
 include/net/netfilter/nf_conntrack_core.h                         |    5 
 include/net/netfilter/nf_conntrack_helper.h                       |    1 
 include/net/sock.h                                                |    1 
 include/net/xfrm.h                                                |    3 
 include/rdma/ib_umem.h                                            |   36 -
 include/rdma/ib_verbs.h                                           |   48 --
 include/rdma/iter.h                                               |   88 +++
 ipc/shm.c                                                         |   10 
 ipc/util.c                                                        |    2 
 kernel/cgroup/cpuset.c                                            |    8 
 kernel/pid.c                                                      |    8 
 kernel/sched/core.c                                               |    2 
 kernel/sched/rt.c                                                 |    2 
 kernel/sched/sched.h                                              |    2 
 kernel/signal.c                                                   |    1 
 kernel/time/time.c                                                |    2 
 kernel/trace/trace_probe.c                                        |    6 
 kernel/trace/trace_probe.h                                        |    4 
 kernel/tracepoint.c                                               |    2 
 lib/debugobjects.c                                                |    2 
 lib/mpi/mpicoder.c                                                |    2 
 lib/test_hmm.c                                                    |   86 ++-
 mm/damon/core.c                                                   |   37 +
 mm/damon/lru_sort.c                                               |   84 ++-
 mm/damon/ops-common.c                                             |    4 
 mm/damon/reclaim.c                                                |   84 ++-
 mm/gup.c                                                          |    2 
 mm/huge_memory.c                                                  |    2 
 mm/hugetlb.c                                                      |  113 +++-
 mm/memory-failure.c                                               |   94 ++--
 mm/memory.c                                                       |    2 
 mm/memory_hotplug.c                                               |    2 
 mm/mempolicy.c                                                    |    2 
 mm/migrate.c                                                      |   18 
 mm/page_alloc.c                                                   |    1 
 net/6lowpan/iphc.c                                                |    4 
 net/802/garp.c                                                    |    2 
 net/802/mrp.c                                                     |    9 
 net/batman-adv/bat_iv_ogm.c                                       |   82 ++-
 net/batman-adv/bat_v_ogm.c                                        |   59 +-
 net/batman-adv/bridge_loop_avoidance.c                            |   57 +-
 net/batman-adv/main.c                                             |    1 
 net/batman-adv/soft-interface.c                                   |    1 
 net/batman-adv/tp_meter.c                                         |  215 ++++++---
 net/batman-adv/tp_meter.h                                         |    1 
 net/batman-adv/translation-table.c                                |   43 +
 net/batman-adv/tvlv.c                                             |   28 -
 net/batman-adv/tvlv.h                                             |    2 
 net/batman-adv/types.h                                            |   57 +-
 net/bluetooth/6lowpan.c                                           |    2 
 net/bluetooth/af_bluetooth.c                                      |  111 +++-
 net/bluetooth/bnep/core.c                                         |   50 +-
 net/bluetooth/hci_sync.c                                          |    5 
 net/bluetooth/hci_sysfs.c                                         |    6 
 net/bluetooth/hidp/core.c                                         |   23 
 net/bluetooth/hidp/sock.c                                         |   10 
 net/bluetooth/iso.c                                               |   12 
 net/bluetooth/l2cap_core.c                                        |   87 +++
 net/bluetooth/l2cap_sock.c                                        |   35 -
 net/bluetooth/mgmt.c                                              |   17 
 net/bluetooth/rfcomm/core.c                                       |   67 ++
 net/bluetooth/rfcomm/sock.c                                       |   26 -
 net/bridge/br_arp_nd_proxy.c                                      |    8 
 net/bridge/br_fdb.c                                               |   28 -
 net/bridge/netfilter/ebt_snat.c                                   |    3 
 net/bridge/netfilter/ebtables.c                                   |   30 +
 net/core/drop_monitor.c                                           |    2 
 net/core/filter.c                                                 |   17 
 net/core/gro.c                                                    |    3 
 net/core/skbuff.c                                                 |   20 
 net/core/sock.c                                                   |   13 
 net/ethtool/eeprom.c                                              |    5 
 net/hsr/hsr_forward.c                                             |    4 
 net/hsr/hsr_framereg.c                                            |    6 
 net/ieee802154/6lowpan/tx.c                                       |    5 
 net/ipv4/ah4.c                                                    |   31 -
 net/ipv4/esp4.c                                                   |    4 
 net/ipv4/ip_options.c                                             |    4 
 net/ipv4/ip_tunnel_core.c                                         |   22 
 net/ipv4/netfilter/arp_tables.c                                   |   15 
 net/ipv4/netfilter/ip_tables.c                                    |   15 
 net/ipv4/netfilter/nf_nat_h323.c                                  |    2 
 net/ipv4/netfilter/nft_fib_ipv4.c                                 |    2 
 net/ipv4/sysctl_net_ipv4.c                                        |    2 
 net/ipv4/udp.c                                                    |    8 
 net/ipv6/ah6.c                                                    |   29 -
 net/ipv6/datagram.c                                               |   54 +-
 net/ipv6/esp6.c                                                   |    4 
 net/ipv6/exthdrs.c                                                |   21 
 net/ipv6/ip6_vti.c                                                |   25 -
 net/ipv6/mcast.c                                                  |    8 
 net/ipv6/netfilter/ip6_tables.c                                   |   15 
 net/ipv6/netfilter/ip6t_eui64.c                                   |    7 
 net/ipv6/netfilter/nft_fib_ipv6.c                                 |    2 
 net/ipv6/route.c                                                  |    5 
 net/ipv6/sit.c                                                    |    1 
 net/iucv/af_iucv.c                                                |   20 
 net/key/af_key.c                                                  |    6 
 net/mac80211/mlme.c                                               |    4 
 net/mctp/device.c                                                 |    1 
 net/mctp/neigh.c                                                  |    1 
 net/mctp/route.c                                                  |    9 
 net/mptcp/options.c                                               |   43 +
 net/mptcp/pm.c                                                    |   34 +
 net/mptcp/pm_netlink.c                                            |   45 +
 net/mptcp/protocol.c                                              |   29 +
 net/mptcp/sockopt.c                                               |    8 
 net/netfilter/ipset/ip_set_bitmap_ipmac.c                         |    5 
 net/netfilter/ipset/ip_set_hash_ipmac.c                           |    9 
 net/netfilter/ipset/ip_set_hash_mac.c                             |    5 
 net/netfilter/ipvs/ip_vs_ctl.c                                    |   13 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                             |   18 
 net/netfilter/ipvs/ip_vs_proto_tcp.c                              |   21 
 net/netfilter/ipvs/ip_vs_proto_udp.c                              |   20 
 net/netfilter/ipvs/ip_vs_sched.c                                  |   14 
 net/netfilter/nf_conntrack_ecache.c                               |    2 
 net/netfilter/nf_conntrack_expect.c                               |   10 
 net/netfilter/nf_conntrack_helper.c                               |   19 
 net/netfilter/nf_conntrack_irc.c                                  |    4 
 net/netfilter/nf_conntrack_netlink.c                              |   28 -
 net/netfilter/nf_conntrack_proto_tcp.c                            |    3 
 net/netfilter/nf_log_syslog.c                                     |   12 
 net/netfilter/nf_nat_core.c                                       |    2 
 net/netfilter/nf_nat_sip.c                                        |    1 
 net/netfilter/nf_synproxy_core.c                                  |   26 -
 net/netfilter/nf_tables_api.c                                     |   41 +
 net/netfilter/nft_exthdr.c                                        |    3 
 net/netfilter/nft_fib.c                                           |    6 
 net/netfilter/nft_set_bitmap.c                                    |    4 
 net/netfilter/nft_set_hash.c                                      |    8 
 net/netfilter/nft_set_pipapo.c                                    |    5 
 net/netfilter/nft_set_rbtree.c                                    |    4 
 net/netfilter/nft_tunnel.c                                        |    2 
 net/netfilter/xt_NFQUEUE.c                                        |    2 
 net/netfilter/xt_cpu.c                                            |    2 
 net/netfilter/xt_mac.c                                            |    4 
 net/netlabel/netlabel_unlabeled.c                                 |   30 -
 net/netlink/af_netlink.c                                          |   11 
 net/netlink/genetlink.c                                           |    4 
 net/nfc/hci/core.c                                                |   10 
 net/nfc/llcp_core.c                                               |   11 
 net/nfc/llcp_sock.c                                               |    2 
 net/nfc/nci/hci.c                                                 |   10 
 net/openvswitch/datapath.c                                        |    1 
 net/packet/af_packet.c                                            |   74 +--
 net/packet/diag.c                                                 |    6 
 net/packet/internal.h                                             |    8 
 net/psample/psample.c                                             |    2 
 net/qrtr/af_qrtr.c                                                |    4 
 net/qrtr/ns.c                                                     |  180 ++-----
 net/rds/ib_cm.c                                                   |    1 
 net/rds/ib_send.c                                                 |    2 
 net/rds/info.c                                                    |    2 
 net/sched/act_api.c                                               |    7 
 net/sched/cls_fw.c                                                |    6 
 net/sched/sch_sfb.c                                               |    2 
 net/sctp/diag.c                                                   |   17 
 net/sctp/input.c                                                  |    8 
 net/sctp/sm_statefuns.c                                           |    6 
 net/sctp/socket.c                                                 |    2 
 net/sctp/stream.c                                                 |    6 
 net/smc/af_smc.c                                                  |   21 
 net/socket.c                                                      |   11 
 net/vmw_vsock/vmci_transport.c                                    |    4 
 net/wireless/nl80211.c                                            |    3 
 net/xfrm/espintcp.c                                               |    4 
 net/xfrm/xfrm_input.c                                             |   16 
 net/xfrm/xfrm_policy.c                                            |   15 
 net/xfrm/xfrm_state.c                                             |   35 +
 net/xfrm/xfrm_user.c                                              |    5 
 security/apparmor/policy_unpack.c                                 |   27 -
 sound/aoa/codecs/onyx.c                                           |  104 +---
 sound/aoa/codecs/tas.c                                            |  113 +---
 sound/aoa/core/gpio-feature.c                                     |   20 
 sound/aoa/core/gpio-pmf.c                                         |   26 -
 sound/aoa/soundbus/i2sbus/core.c                                  |    3 
 sound/aoa/soundbus/i2sbus/pcm.c                                   |  143 +++---
 sound/core/pcm_native.c                                           |    7 
 sound/core/timer.c                                                |    1 
 sound/firewire/motu/motu-register-dsp-message-parser.c            |   14 
 sound/pci/hda/patch_hdmi.c                                        |    1 
 sound/soc/codecs/simple-mux.c                                     |    2 
 sound/soc/codecs/wm_adsp.c                                        |    3 
 sound/soc/intel/boards/bytcht_es8316.c                            |   29 +
 sound/soc/qcom/qdsp6/q6asm-dai.c                                  |   43 -
 tools/bootconfig/main.c                                           |   25 -
 tools/perf/Makefile.config                                        |    1 
 tools/perf/util/Build                                             |   32 +
 tools/perf/util/expr.y                                            |    4 
 tools/perf/util/parse-events.y                                    |    3 
 tools/perf/util/pmu.y                                             |    3 
 tools/scripts/utilities.mak                                       |   20 
 tools/testing/selftests/bpf/DENYLIST.s390x                        |    1 
 tools/testing/selftests/bpf/Makefile                              |    2 
 tools/testing/selftests/bpf/prog_tests/align.c                    |   18 
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c                   |   12 
 tools/testing/selftests/bpf/prog_tests/empty_skb.c                |   12 
 tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c |   87 ---
 tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c      |   73 ---
 tools/testing/selftests/bpf/prog_tests/test_global_funcs.c        |  131 +----
 tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c             |    6 
 tools/testing/selftests/bpf/progs/bpf_misc.h                      |    5 
 tools/testing/selftests/bpf/progs/test_global_func1.c             |    6 
 tools/testing/selftests/bpf/progs/test_global_func10.c            |    1 
 tools/testing/selftests/bpf/progs/test_global_func11.c            |    4 
 tools/testing/selftests/bpf/progs/test_global_func12.c            |    4 
 tools/testing/selftests/bpf/progs/test_global_func13.c            |    4 
 tools/testing/selftests/bpf/progs/test_global_func14.c            |    4 
 tools/testing/selftests/bpf/progs/test_global_func15.c            |    4 
 tools/testing/selftests/bpf/progs/test_global_func16.c            |    4 
 tools/testing/selftests/bpf/progs/test_global_func17.c            |    5 
 tools/testing/selftests/bpf/progs/test_global_func2.c             |   43 +
 tools/testing/selftests/bpf/progs/test_global_func3.c             |   10 
 tools/testing/selftests/bpf/progs/test_global_func4.c             |   55 ++
 tools/testing/selftests/bpf/progs/test_global_func5.c             |    4 
 tools/testing/selftests/bpf/progs/test_global_func6.c             |    4 
 tools/testing/selftests/bpf/progs/test_global_func7.c             |    4 
 tools/testing/selftests/bpf/progs/test_global_func8.c             |    4 
 tools/testing/selftests/bpf/progs/test_global_func9.c             |    4 
 tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c |   37 -
 tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c      |    7 
 tools/testing/selftests/bpf/test_loader.c                         |  233 ++++++++++
 tools/testing/selftests/bpf/test_progs.h                          |   33 +
 tools/testing/selftests/bpf/trace_helpers.c                       |   82 +++
 tools/testing/selftests/bpf/trace_helpers.h                       |    5 
 tools/testing/selftests/bpf/verifier/int_ptr.c                    |    6 
 tools/testing/selftests/net/forwarding/lib.sh                     |   56 ++
 tools/testing/selftests/net/mptcp/mptcp_connect.sh                |    6 
 tools/testing/selftests/ptp/testptp.c                             |   62 --
 tools/testing/selftests/vm/hmm-tests.c                            |   50 ++
 543 files changed, 6637 insertions(+), 3646 deletions(-)

Aaron Erhardt (1):
      ALSA: hda/hdmi: Add quirk for TUXEDO IBS14G6

Abdurrahman Hussain (3):
      hwmon: (pmbus/adm1266) serialize GPIO PMBus accesses with pmbus_lock
      hwmon: (pmbus/adm1266) serialize sequencer_state debugfs read with pmbus_lock
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

Aleksandr Nogikh (1):
      signal: clear JOBCTL_PENDING_MASK for caller in zap_other_threads()

Alexander A. Klimov (1):
      drm/vc4: fix krealloc() memory leak

Alexandra Winter (1):
      net/smc: Do not re-initialize smc hashtables

Alexandru Hossu (1):
      scsi: target: iscsi: Validate CHAP_R length before base64 decode

Ali Ganiyev (1):
      ksmbd: OOB read regression in smb_check_perm_dacl() ACE-walk loops

Alistair Popple (2):
      lib: test_hmm: evict device pages on file close to avoid use-after-free
      mm/memory: fix spurious warning when unmapping device-private/exclusive pages

Amirreza Zarrabi (1):
      tee: optee: prevent use-after-free when the client exits before the supplicant

Amit Sunil Dhamne (1):
      usb: typec: tcpm: reset internal port states on soft reset AMS

Anandu Krishnan E (1):
      misc: fastrpc: fix use-after-free of fastrpc_user in workqueue context

Andi Shyti (1):
      spi: s3c64xx: Use devm_clk_get_enabled()

Andrii Nakryiko (3):
      selftests/bpf: add generic BPF program tester-loader
      selftests/bpf: Convert test_global_funcs test to test_loader framework
      selftests/bpf: enhance align selftest's expected log matching

Andy Roulin (2):
      vxlan: vnifilter: send notification on VNI add
      vxlan: vnifilter: fix spurious notification on VNI update

Andy Shevchenko (1):
      spi: Convert to SPI_CONTROLLER_HALF_DUPLEX

Anshuman Khandual (1):
      arm64/mm: Enable batched TLB flush in unmap_hotplug_range()

Anton Leontev (1):
      hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf

Antoniu Miclaus (2):
      iio: gyro: adis16260: fix division by zero in write_raw
      iio: chemical: scd30: fix division by zero in write_raw

Arnaldo Carvalho de Melo (2):
      tools build: Add 3-component logical version comparators
      perf build: Remove -Wno-unused-but-set-variable from the flex flags when building with clang < 13.0.0

Arnd Bergmann (1):
      iommu, debugobjects: avoid gcc-16.1 section mismatch warnings

Ashutosh Desai (2):
      nfc: hci: fix out-of-bounds read in HCP header parsing
      drm/v3d: Reject empty multisync extension to prevent infinite loop

Bartosz Golaszewski (4):
      net: mv643xx: fix OF node refcount
      slimbus: qcom-ngd-ctrl: fix OF node refcount
      tty: serial: qcom-geni-serial: remove unused symbols
      tty: serial: qcom-geni-serial: align #define values

Ben Hutchings (5):
      Revert "RDMA/rxe: Fix double free in rxe_srq_from_init"
      parport: Fix race between port and client registration
      fbdev: vt8500lcdfb: Fix dma_free_coherent() cpu_addr parameter
      apparmor: validate default DFA states are in bounds
      bootconfig: Fix negative seeks on 32-bit with LFS enabled

Benjamin Tissoires (1):
      HID: pass the buffer size to hid_report_raw_event

Berkant Koc (2):
      drm/hyperv: validate resolution_count and fix WIN8 fallback
      drm/hyperv: validate VMBus packet size in receive callback

Bharath Reddy (1):
      Bluetooth: fix memory leak in error path of hci_alloc_dev()

Bingquan Chen (1):
      net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()

Bjorn Andersson (1):
      slimbus: qcom-ngd-ctrl: Avoid ABBA on tx_lock/ctrl->lock

Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Move the Zen3 BTC_NO detection to the Zen3 init function

Breno Leitao (2):
      net/iucv: fix locking in .getsockopt
      rds: mark snapshot pages dirty in rds_info_getsockopt()

Brian Foster (1):
      iomap: don't revert iov_iter on partially completed buffered writes

Carl Lee (1):
      nfc: nxp-nci: i2c: use rising-edge IRQ on ACPI systems

Carlos Eduardo Gallo Filho (1):
      drm: Remove plane hsub/vsub alignment requirement for core helpers

Chao Yu (2):
      f2fs: fix to do sanity check on dcc->discard_cmd_cnt conditionally
      f2fs: fix false alarm of lockdep on cp_global_sem lock

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

Corey Minyard (4):
      ipmi:ssif: Fix a shutdown race
      ipmi:ssif: Clean up kthread on errors
      ipmi:ssif: Remove unnecessary indention
      ipmi:ssif: NULL thread on error

Cryolitia PukNgae (1):
      Input: atkbd - skip deactivate for HONOR BCC-N's internal keyboard

Cássio Gabriel (4):
      ASoC: Intel: bytcht_es8316: Fix MCLK leak on init errors
      ASoC: codecs: simple-mux: Fix enum control bounds check
      ALSA: aoa: i2sbus: clear stale prepared state
      ALSA: firewire-motu: Protect register DSP event queue positions

Dan Carpenter (1):
      usb: dwc2: Fix use after free in debug code

Daniel Borkmann (1):
      selftests/bpf: Fix ARG_PTR_TO_LONG {half-,}uninitialized test

Daniel Hodges (1):
      wifi: mwifiex: fix use-after-free in mwifiex_adapter_cleanup()

David Ahern (1):
      xfrm: Check for underflow in xfrm_state_mtu

David Carlier (3):
      iio: gyro: itg3200: fix i2c read into the wrong stack location
      tracepoint: balance regfunc() on func_add() failure in tracepoint_add_func()
      iio: adc: npcm: fix unbalanced clk_disable_unprepare()

David E. Box (3):
      platform/x86/intel/vsec: Add private data for per-device data
      platform/x86/intel/vsec: Create wrapper to walk PCI config space
      platform/x86/intel/vsec: Make driver_data info const

David Francis (1):
      drm/amdkfd: Check for pdd drm file first in CRIU restore path

David Hildenbrand (3):
      mm/hugetlb: rename isolate_hugetlb() to folio_isolate_hugetlb()
      mm/migrate: don't call folio_putback_active_hugetlb() on dst hugetlb folio
      mm/hugetlb: rename folio_putback_active_hugetlb() to folio_putback_hugetlb()

David Thompson (1):
      net: lan743x: permit VLAN-tagged packets up to configured MTU

Davide Caratti (1):
      net/sched: cls_fw: fix NULL dereference of "old" filters before change()

Davide Ornaghi (1):
      netfilter: nft_fib: fix stale stack leak via the OIFNAME register

Dawei Feng (2):
      octeontx2-af: fix memory leak in rvu_setup_hw_resources()
      octeontx2-pf: avoid double free of pool->stack on AQ init failure

Deepanshu Kartikey (1):
      hfsplus: fix uninit-value by validating catalog record size

Dipayaan Roy (1):
      net: mana: Add NULL guards in teardown path to prevent panic on attach failure

Dmitry Torokhov (2):
      Input: elan_i2c - validate firmware size before use
      Input: atmel_mxt_ts - fix boundary check in mxt_prepare_cfg_mem

Douglas Anderson (2):
      r8152: Block future register access if register access fails
      r8152: Hold the rtnl_lock for all of reset

Dudu Lu (1):
      Bluetooth: bnep: fix incorrect length parsing in bnep_rx_frame() extension handling

Edward Lo (1):
      fs/ntfs3: Return error for inconsistent extended attributes

Eric Biggers (2):
      net: ipv4: stop checking crypto_ahash_alignmask
      net: ipv6: stop checking crypto_ahash_alignmask

Eric Dumazet (12):
      ipv4: free net->ipv4.sysctl_local_reserved_ports after unregister_net_sysctl_table()
      tunnels: load network headers after skb_cow() in iptunnel_pmtud_build_icmp[v6]()
      vxlan: do not reuse cached ip_hdr() value after skb_tunnel_check_pmtu()
      tunnels: do not assume transport header in iptunnel_pmtud_check_icmp()
      net/packet: convert po->tp_tx_has_off to an atomic flag
      net/packet: convert po->tp_loss to an atomic flag
      net/packet: convert po->has_vnet_hdr to an atomic flag
      net/packet: convert po->running to an atomic flag
      ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
      ieee802154: 6lowpan: only accept IPv6 packets in lowpan_xmit()
      tcp: restrict SO_ATTACH_FILTER to priv users
      ip6_vti: fix incorrect tunnel matching in vti6_tnl_lookup()

Eric Huang (1):
      drm/amdkfd: fix NULL pointer bug in svm_range_set_attr

Felix Gu (1):
      iio: buffer: hw-consumer: fix use-after-free in error path

Fernando Fernandez Mancera (2):
      netfilter: xt_NFQUEUE: prefer raw_smp_processor_id
      netfilter: synproxy: add mutex to guard hook reference counting

Filipe Manana (2):
      btrfs: remove fs_info argument from btrfs_sysfs_add_space_info_type()
      btrfs: fix missing last_unlink_trans update when removing a directory

Florian Westphal (4):
      netfilter: xt_cpu: prefer raw_smp_processor_id
      netfilter: ebtables: fix OOB read in compat_mtw_from_user
      netfilter: conntrack_irc: fix possible out-of-bounds read
      netfilter: nft_exthdr: fix register tracking for F_PRESENT flag

Gil Portnoy (1):
      ksmbd: fix use-after-free of a deferred file_lock on double SMB2_CANCEL

Greg Kroah-Hartman (9):
      Input: usbtouchscreen - clamp NEXIO data_len/x_len to URB buffer size
      iio: imu: st_lsm6dsx: fix stack leak in tagged FIFO buffer
      usb: typec: ucsi: ccg: reject firmware images without a ':' record header
      usb: typec: ucsi: displayport: NAK DP_CMD_CONFIGURE without a payload VDO
      usb: typec: altmodes/displayport: validate count before reading Status Update VDO
      usb: typec: wcove: don't write past struct pd_message in wcove_read_rx_buffer()
      usb: typec: ucsi: validate connector number in ucsi_connector_change()
      LoongArch: Add spectre boundry for syscall dispatch table
      Linux 6.1.176

Guangshuo Li (5):
      counter: Fix refcount leak in counter_alloc() error path
      usb: gadget: net2280: Fix double free in probe error path
      dm cache policy smq: check allocation under invalidate lock
      btrfs: fix double free in create_space_info_sub_group() error path
      usb: gadget: f_hid: fix device reference leak in hidg_alloc()

Guillermo Rodríguez (1):
      i2c: stm32f7: fix timing computation ignoring i2c-analog-filter

Guopeng Zhang (1):
      cgroup/cpuset: Reset DL migration state on can_attach() failure

Hamza Mahfooz (1):
      netfilter: conntrack: tcp: do not force CLOSE on invalid-seq RST without direction check

Haoxiang Li (1):
      xfs: fix a resource leak in xfs_alloc_buftarg()

Harini Katakam (1):
      phy: mscc: Use PHY_ID_MATCH_VENDOR to minimize PHY ID table

Harry Wentland (5):
      drm/amd/display: Reject gpio_bitshift >= 32 in bios_parser_get_gpio_pin_info()
      drm/amd/display: Clamp HDMI HDCP2 rx_id_list read to buffer size
      drm/amd/display: Clamp VBIOS HDMI retimer register count to array size
      drm/amd/display: Fix NULL deref and buffer over-read in SDP debugfs
      drm/amd/display: Use krealloc_array() in dal_vector_reserve()

Hayes Wang (1):
      r8152: reduce the control transfer of rtl8152_get_version()

Heitor Alves de Siqueira (2):
      usb: usbtmc: check URB actual_length for interrupt-IN notifications
      usb: usbtmc: reject interrupt endpoints with small wMaxPacketSize

Henri A (1):
      media: rc: igorplugusb: fix control request setup packet

Hongling Zeng (1):
      serial: sh-sci: fix memory region release in error path

Hongtao Lee (1):
      tools/bootconfig: Fix buf leaks in apply_xbc

Horatiu Vultur (1):
      phy: mscc: Use PHY_ID_MATCH_EXACT for VSC8584, VSC8582, VSC8575, VSC856X

HyeongJun An (1):
      USB: serial: kl5kusb105: fix bulk-out buffer overflow

Ian Abbott (2):
      comedi: comedi_test: fix check for valid scan_begin_src in waveform_ai_cmdtest()
      comedi: comedi_test: Fix limiting of convert_arg in waveform_ai_cmdtest()

Ian Rogers (3):
      perf build: Conditionally define NDEBUG
      perf parse-events: Make YYDEBUG dependent on doing a debug build
      perf build: Disable fewer bison warnings

Ido Schimmel (2):
      ipv6: mcast: Fix use-after-free when processing MLD queries
      genetlink: Use internal flags for multicast groups

Ilya Maximets (2):
      net: netlink: fix sending unassigned nsid after assigned one
      net: netlink: don't set nsid on local notifications

Inochi Amaoto (2):
      mmc: litex_mmc: Use DIV_ROUND_UP for more accurate clock calculation
      mmc: litex_mmc: Set mandatory idle clocks before CMD0

Jack Wu (1):
      USB: serial: option: add usb-id for Dell Wireless DW5826e-m

Jakub Kicinski (1):
      ethtool: eeprom: add more safeties to EEPROM Netlink fallback

Jamal Hadi Salim (1):
      net/sched: act_api: use RCU with deferred freeing for action lifecycle

Jan Volckaert (1):
      USB: serial: option: add MeiG SRM813Q

Jane Chu (1):
      mm/memory-failure: fix missing ->mf_stats count in hugetlb poison

Jann Horn (1):
      fuse: reject fuse_notify() pagecache ops on directories

Janusz Krzysztofik (1):
      drm/i915: Fix potential UAF in TTM object purge

Jason A. Donenfeld (1):
      wireguard: send: append trailer after expanding head

Jason Gunthorpe (1):
      RDMA/umem: Fix truncation for block sizes >= 4G

Jeremy Kerr (1):
      net: mctp: ensure our nlmsg responses are initialised

Ji'an Zhou (1):
      ALSA: PCM: Fix wait queue list corruption in snd_pcm_drain() on linked streams

Jiasheng Jiang (1):
      RDMA/rxe: Fix double free in rxe_srq_from_init

Jiayuan Chen (3):
      ipv6: fix possible infinite loop in rt6_fill_node()
      ipv6: fix possible infinite loop in fib6_select_path()
      bpf/bonding: reject vlan+srcmac xmit_hash_policy change when XDP is loaded

Jiazi Li (1):
      f2fs: use kfree() instead of kvfree() to free some memory

Jiexun Wang (2):
      Bluetooth: serialize accept_q access
      batman-adv: stop tp_meter sessions during mesh teardown

Jingguo Tan (1):
      xfrm: esp: restore combined single-frag length gate

Jiri Olsa (1):
      selftests/bpf: Add read_build_id function

Jisheng Zhang (1):
      mmc: sdhci: add signal voltage switch in sdhci_resume_host

Johan Hovold (23):
      USB: serial: safe_serial: fix memory corruption with small endpoint
      USB: serial: omninet: fix memory corruption with small endpoint
      USB: serial: keyspan: fix missing indat transfer sanity check
      USB: serial: mxuport: fix memory corruption with small endpoint
      USB: serial: mct_u232: fix missing interrupt-in transfer sanity check
      USB: serial: digi_acceleport: fix memory corruption with small endpoints
      USB: serial: cypress_m8: fix memory corruption with small endpoint
      USB: serial: mct_u232: fix memory corruption with small endpoint
      spi: imx: fix use-after-free on unbind
      spi: fix resource leaks on device setup failure
      spi: syncuacer: fix controller deregistration
      spi: sun4i: fix controller deregistration
      spi: ti-qspi: fix controller deregistration
      spi: zynq-qspi: fix controller deregistration
      spi: sun6i: fix controller deregistration
      spi: s3c64xx: fix NULL-deref on driver unbind
      spi: tegra114: fix controller deregistration
      spi: tegra20-sflash: fix controller deregistration
      spi: uniphier: fix controller deregistration
      spi: microchip-core-qspi: fix controller deregistration
      spi: st-ssc4: fix controller deregistration
      spi: lantiq-ssc: fix controller deregistration
      spi: qup: fix error pointer deref after DMA setup failure

Johannes Berg (1):
      wifi: mac80211: remove station if connection prep fails

John Keeping (1):
      usb: gadget: f_hid: tidy error handling in hidg_alloc

Jonathan Cameron (1):
      iio: chemical: scd30: Use guard(mutex) to allow early returns

Joonas Lahtinen (1):
      drm/i915/gem: Fix phys BO pread/pwrite with offset

Jose Ignacio Tornos Martinez (1):
      ice: fix VF queue configuration with low MTU values

Joseph Salisbury (1):
      sched: Use u64 for bandwidth ratio calculations

Jouni Högander (3):
      drm/i915/psr: Add defininitions for INTEL_WA_REGISTER_CAPS DPCD register
      drm/i915/psr: Read Intel DPCD workaround register
      drm/i915/psr: Apply Intel DPCD workaround when SDP on prior line used

Julian Anastasov (2):
      ipvs: clear the svc scheduler ptr early on edit
      ipvs: skip ipv6 extension headers for csum checks

Junrui Luo (3):
      macsec: fix replay protection at XPN lower-PN wrap
      misc: fastrpc: fix DMA address corruption due to find_vma misuse
      erofs: fix unsigned underflow in z_erofs_lz4_handle_overlap()

Justin Iurman (2):
      ipv6: exthdrs: refresh nh pointer after ipv6_hop_jumbo()
      ipv6: ioam: add NULL check for idev in ipv6_hop_ioam()

Justin Stitt (1):
      octeontx2-af: replace deprecated strncpy with strscpy

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

Kuniyuki Iwashima (3):
      ip6: vti: Use ip6_tnl.net in vti6_changelink().
      bpf: Free reuseport cBPF prog after RCU grace period.
      net: Annotate sk->sk_write_space() for UDP SOCKMAP.

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

Li Zetao (1):
      spi: microchip-core-qspi: Use helper function devm_clk_get_enabled()

Linpu Yu (1):
      ipc: limit next_id allocation to the valid ID range

Lorenzo Bianconi (1):
      net: mvpp2: Add metadata support for xdp mode

Lorenzo Stoakes (1):
      mm/hugetlb: avoid false positive lockdep assertion

Luiz Augusto von Dentz (3):
      Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
      Bluetooth: MGMT: Fix backward compatibility with userspace
      Bluetooth: Init sk_peer_* on bt_sock_alloc

Luka Gejak (1):
      net: hsr: fix potential OOB access in supervision frame handling

Lukas Wunner (2):
      platform/x86/intel/vsec: Fix enable_cnt imbalance on PCIe error recovery
      lib/crypto: mpi: Fix integer underflow in mpi_read_raw_from_sgl()

Maciej W. Rozycki (5):
      serial: zs: Fix swapped RI/DSR modem line transition counting
      serial: dz: Fix bootconsole message clobbering at chip reset
      serial: zs: Fix bootconsole handover lockup
      serial: zs: Switch to using channel reset
      serial: dz: Fix bootconsole handover lockup

Manivannan Sadhasivam (3):
      net: qrtr: ns: Limit the maximum number of lookups
      net: qrtr: ns: Free the node during ctrl_cmd_bye()
      net: qrtr: ns: Limit the total number of nodes

Maoyi Xie (2):
      ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().
      xfrm: route MIGRATE notifications to caller's netns

Marc Zyngier (2):
      KVM: arm64: Remove VPIPT I-cache handling
      KVM: arm64: Wake-up from WFI when iqrchip is in userspace

Marco Scardovi (1):
      gpio: rockchip: convert bank->clk to devm_clk_get_enabled()

Marek Szyprowski (1):
      wifi: brcmfmac: Fix potential use-after-free issue when stopping watchdog task

Mark Rutland (5):
      arm64: tlb: Allow XZR argument to TLBI ops
      arm64: tlb: Optimize ARM64_WORKAROUND_REPEAT_TLBI
      arm64: cputype: Add C1-Ultra definitions
      arm64: cputype: Add C1-Premium definitions
      arm64: errata: Mitigate TLBI errata on various Arm CPUs

Martin KaFai Lau (1):
      selftests/bpf: S/iptables/iptables-legacy/ in the bpf_nf and xdp_synproxy test

Masami Hiramatsu (Google) (1):
      tools/bootconfig: Cleanup bootconfig footer size calculations

Matthieu Baerts (NGI0) (8):
      mptcp: sockopt: check timestamping ret value
      mptcp: fastclose msk when linger time is 0
      mptcp: pm: prio: skip closed subflows
      mptcp: pm: kernel: correctly retransmit ADD_ADDR ID 0
      mptcp: pm: ADD_ADDR rtx: allow ID 0
      mptcp: pm: ADD_ADDR rtx: fix potential data-race
      mptcp: pm: ADD_ADDR rtx: resched blocked ADD_ADDR quicker
      selftests: mptcp: drop nanoseconds width specifier

Max Kellermann (1):
      ceph: only d_add() negative dentries when they are unhashed

Michael Bommarito (25):
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
      ksmbd: require minimum ACE size in smb_check_perm_dacl()
      smb: client: validate the whole DACL before rewriting it in cifsacl
      xfrm: ah: account for ESN high bits in async callbacks
      smb: client: validate dacloffset before building DACL pointers
      smb: client: require net admin for CIFS SWN netlink
      net: hsr: defer node table free until after RCU readers
      thunderbolt: property: Cap recursion depth in __tb_property_parse_dir()
      scsi: target: iscsi: Fix CRC overread and double-free in iscsit_handle_text_cmd()

Michal Kosiorek (1):
      xfrm: defensively unhash xfrm_state lists in __xfrm_state_delete

Michal Pecio (2):
      usb: core: Fix up Interrupt IN endpoints with bogus wBytesPerInterval
      usb: core: Fix SuperSpeed root hub wMaxPacketSize

Mikhail Gavrilov (1):
      mm/page_alloc: clear page->private in free_pages_prepare()

Mikulas Patocka (1):
      hpfs: fix a crash if hpfs_map_dnode_bitmap fails

Mingyu Wang (3):
      i2c: dev: prevent integer overflow in I2C_TIMEOUT ioctl
      net: qrtr: fix refcount saturation and potential UAF in qrtr_port_remove
      fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync signaling

Minh Nguyen (1):
      net: skbuff: fix missing zerocopy reference in pskb_carve helpers

Muhammad Bilal (3):
      Bluetooth: HIDP: fix missing length checks in hidp_input_report()
      Bluetooth: ISO: fix UAF in iso_recv_frame
      Bluetooth: ISO: serialize iso_sock_clear_timer with socket lock

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

Oliver Neukum (3):
      media: rc: ttusbir: respect DMA coherency rules
      media: rc: igorplugusb: heed coherency rules
      media: rc: ttusbir: fix inverted error logic

Oscar Maes (1):
      pcnet32: stop holding device spin lock during napi_complete_done

Pablo Neira Ayuso (2):
      netfilter: nf_tables: restore set elements when delete set fails
      netfilter: ctnetlink: ensure safe access to master conntrack

Paolo Abeni (4):
      mptcp: fix retransmission loop when csum is enabled
      mptcp: close TOCTOU race while computing rcv_wnd
      mptcp: allow subflow rcv wnd to shrink
      mptcp: reset rcv wnd on disconnect

Paul Chaignon (3):
      Revert "selftests/bpf: Workaround strict bpf_lsm return value check."
      Revert "selftests/bpf: Add tests for _opts variants of bpf_*_get_fd_by_id()"
      Revert "selftests/bpf: Add a cgroup prog bpf_get_ns_current_pid_tgid() test"

Pavel Begunkov (1):
      net: skbuff: fix pskb_carve leaking zcopy pages

Pavitra Jha (1):
      net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler

Pei Xiao (2):
      spi: zynq-qspi: Simplify clock handling with devm_clk_get_enabled()
      spi: uniphier: Simplify clock handling with devm_clk_get_enabled()

Peter Chen (2):
      usb: cdns3: plat: fix unbalanced pm_runtime_forbid() call permanently leaks the runtime PM usage counter across bind/unbind cycles
      usb: cdns3: plat: fix leaked usb2_phy initialization on usb3_phy acquisition failure

Petr Machata (2):
      selftests: forwarding: lib: Add helpers for checksum handling
      Revert "selftest/ptp: update ptp selftest to exercise the gettimex options"

Piyush Sachdeva (1):
      smb: client: Use FullSessionKey for AES-256 encryption key derivation

Prasanna S (1):
      serial: qcom-geni: fix UART_RX_PAR_EN bit position

Qi Tang (1):
      ipv6: validate extension header length before copying to cmsg

Radhey Shyam Pandey (1):
      usb: dwc3: xilinx: fix error handling in zynqmp init error paths

Raf Dickson (1):
      vsock/vmci: fix sk_ack_backlog leak on failed handshake

Rafael J. Wysocki (1):
      thermal: core: Fix thermal zone governor cleanup issues

Rahul Chandelkar (1):
      ipv6: rpl: fix hdrlen overflow in ipv6_rpl_srh_decompress()

Randy Dunlap (1):
      RDMA/umem: fix kernel-doc warnings

Richard Fitzgerald (1):
      ASoC: wm_adsp: Fix NULL dereference when removing firmware controls

Rodrigo Alencar (3):
      iio: dac: ad5686: fix input raw value check
      iio: dac: ad5686: acquire lock when doing powerdown control
      iio: dac: ad5686: fix ref bit initialization for single-channel parts

Ruan Jinjie (2):
      spi: spi-zynq: Do not check for 0 return after calling platform_get_irq()
      iio: adc: fix the return value handle for platform_get_irq()

Rui Qi (1):
      ipmi: Fix rcu_read_unlock to srcu_read_unlock in handle_read_event_rsp

Russell King (Oracle) (2):
      net: stmmac: avoid shadowing global buf_sz
      net: stmmac: rename STMMAC_GET_ENTRY() -> STMMAC_NEXT_ENTRY()

Sabrina Dubroca (1):
      net: gro: don't merge zcopy skbs

Saket Kumar Bhaskar (1):
      selftests/bpf: Fix bpf_nf selftest failure

Salah Triki (3):
      iio: dac: max5821: fix return value check in powerdown sync
      iio: adc: viperboard: Fix error handling in vprbrd_iio_read_raw
      iio: temperature: tsys01: fix broken PROM checksum validation

Sam Burkels (1):
      usb: storage: Add quirks for PNY Elite Portable SSD

Sam Daly (1):
      octeontx2-af: CGX: add bounds check to cgx_speed_mbps index

Sam Edwards (1):
      net: stmmac: Prevent NULL deref when RX memory exhausted

Sang-Heon Jeon (1):
      mm/hugetlb_cma: round up per_node before logging it

Sanghyun Park (1):
      xfrm: policy: fix use-after-free on inexact bin in xfrm_policy_bysel_ctx()

Sanjay Chitroda (1):
      iio: ssp_sensors: cancel delayed work_refresh on remove

Sechang Lim (1):
      udp: clear skb->dev before running a sockmap verdict

Selvarasu Ganesan (1):
      usb: dwc3: Move GUID programming after PHY initialization

Seohyeon Maeng (1):
      udf: fix partition descriptor append bookkeeping

SeongJae Park (6):
      mm/damon/ops-common: call folio_test_lru() after folio_get()
      mm/damon/core: use time_in_range_open() for damos quota window start
      mm/damon/core: disallow time-quota setting zero esz
      mm/damon/core: implement damon_kdamond_pid()
      mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
      mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values

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

Stanislav Fomichev (1):
      selftests/bpf: Update bpf_clone_redirect expected return code

Stepan Ionichev (1):
      auxdisplay: line-display: fix OOB read on zero-length message_store()

Stephen J. Fuhry (1):
      USB: quirks: add NO_LPM for Lenovo ThinkPad USB-C Dock Gen2 hub controllers

Steven Rostedt (1):
      tracing/probes: Limit size of event probe to 3K

Suraj Kandpal (1):
      drm/dp: Add eDP 1.5 bit definition

Sven Eckelmann (14):
      batman-adv: v: stop OGMv2 on disabled interface
      batman-adv: tvlv: abort OGM send on tvlv append failure
      batman-adv: tt: reject oversized local TVLV buffers
      batman-adv: bla: avoid NULL-ptr deref for claim via dropped interface
      batman-adv: tvlv: reject oversized TVLV packets
      batman-adv: iv: recover OGM scheduling after forward packet error
      batman-adv: tp_meter: directly shut down timer on cleanup
      batman-adv: tt: fix TOCTOU race for reported vlans
      batman-adv: tt: avoid empty VLAN responses
      batman-adv: bla: avoid double decrement of bla.num_requests
      batman-adv: tp_meter: fix tp_num leak on kmalloc failure
      batman-adv: tp_meter: fix tp_vars reference leak in receiver shutdown
      batman-adv: tp_meter: fix race condition in send error reporting
      batman-adv: tp_meter: avoid role confusion in tp_list

Takashi Iwai (2):
      ALSA: timer: Fix UAF at snd_timer_user_params()
      ALSA: aoa: Use guard() for mutex locks

Tapio Reijonen (1):
      net: fec: fix pinctrl default state restore order on resume

Tejun Heo (1):
      blk-cgroup: Fix NULL deref caused by blkg_policy_data being installed before init

Thomas Fourier (1):
      Input: ims-pcu - fix usb_free_coherent() size in ims_pcu_buffers_free()

Thomas Gleixner (1):
      serial: samsung_tty: Use port lock wrappers

Thomas Zimmermann (2):
      fbdev: defio: Disconnect deferred I/O from the lifetime of struct fb_info
      fbcon: Avoid OOB font access if console rotation fails

Thorsten Blum (3):
      ALSA: aoa: Skip devices with no codecs in i2sbus_resume()
      printk: add print_hex_dump_devel()
      crypto: caam - guard HMAC key hex dumps in hash_digest_key

Til Kaiser (4):
      net: mvpp2: sync RX data at the hardware packet offset
      net: mvpp2: limit XDP frame size to the RX buffer
      net: mvpp2: refill RX buffers before XDP or skb use
      net: mvpp2: build skb from XDP-adjusted data on XDP_PASS

Timur Kristóf (1):
      drm/amd/pm/si: Disregard vblank time when no displays are connected

Tristan Madani (1):
      netfilter: nft_tunnel: fix use-after-free on object destroy

Tudor Ambarus (3):
      mtd: spi-nor: debugfs: fix out-of-bounds read in spi_nor_params_show()
      tty: serial: samsung: use u32 for register interactions
      tty: serial: samsung: Remove redundant port lock acquisition in rx helpers

Ulf Hansson (1):
      pmdomain: core: Fix detach procedure for virtual devices in genpd

Uwe Kleine-König (9):
      spi: imx: Convert to platform remove callback returning void
      spi: synquacer: Convert to platform remove callback returning void
      spi: sun4i: Convert to platform remove callback returning void
      spi: spi-ti-qspi: Convert to platform remove callback returning void
      spi: zynq-qspi: Convert to platform remove callback returning void
      spi: uniphier: Convert to platform remove callback returning void
      spi: microchip-core-qspi: Convert to platform remove callback returning void
      spi: topcliff-pch: Convert to platform remove callback returning void
      iio: adc: npcm: Convert to platform remove callback returning void

Vicki Pfau (1):
      HID: core: Add printk_ratelimited variants to hid_warn() etc

Victor Nogueria (1):
      net/sched: sch_sfb: Replace direct dequeue call with peek and qdisc_dequeue_peeked

Vignesh Viswanathan (1):
      net: qrtr: ns: Change servers radix tree to xarray

Vinicius Costa Gomes (1):
      dmaengine: idxd: Fix not releasing workqueue on .release()

Vladimir Zapolskiy (1):
      i2c: qcom-cci: Fix NULL pointer dereference in cci_remove()

Vladislav Nikolaev (1):
      RDMA/rxe: Complete the rxe_cleanup_task backport

Wanquan Zhong (1):
      USB: serial: option: add missing RSVD(5) flag for Rolling RW135R-GL

Wayne Chang (2):
      phy: tegra: xusb: Disable trk clk when not in use
      phy: tegra: xusb: Fix per-pad high-speed termination calibration

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

Wentao Liang (1):
      usb: musb: omap2430: Fix use-after-free in omap2430_probe()

Will Deacon (1):
      arm64: errata: Mitigate TLBI errata on Microsoft Azure Cobalt 100 CPU

Wupeng Ma (1):
      mm/memory-failure: fix hugetlb_lock AA deadlock in get_huge_page_for_hwpoison

Wyatt Feng (2):
      xfrm: espintcp: do not reuse an in-progress partial send
      sctp: stream: fully roll back denied add-stream state

Xiang Mei (1):
      netfilter: nf_log: validate MAC header was set before dumping it

Xin Long (1):
      sctp: purge outqueue on stale COOKIE-ECHO handling

Xu Yang (1):
      usb: chipidea: core: convert ci_role_switch to local variable

Yang Yingliang (7):
      spi: synquacer: switch to use modern name
      spi: sun4i: switch to use modern name
      spi: spi-ti-qspi: switch to use modern name
      spi: zynq-qspi: switch to use modern name
      spi: uniphier: switch to use modern name
      spi: st-ssc4: switch to use modern name
      spi: qup: switch to use modern name

Yao Sang (1):
      net/mlx4: avoid GCC 10 __bad_copy_from() false positive

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

Yochai Eisenrich (1):
      btrfs: fix btrfs_ioctl_space_info() slot_count TOCTOU which can lead to info-leak

Yongchao Wu (1):
      usb: cdns3: gadget: fix request skipping after clearing halt

Yonghong Song (1):
      bpf: Fix a few selftest failures due to llvm18 change

Yongpeng Yang (2):
      f2fs: fix UAF caused by decrementing sbi->nr_pages[] in f2fs_write_end_io()
      f2fs: fix incorrect file address mapping when inline inode is unwritten

Yuan Zhaoming (1):
      net: mctp: fix don't require received header reserved bits to be zero

Yuho Choi (1):
      ARM: socfpga: Fix OF node refcount leak in SMP setup

Yuqi Xu (4):
      bpf: sockmap: fix tail fragment offset in bpf_msg_push_data
      Bluetooth: hci_sync: reject oversized Broadcast Announcement prepend
      wifi: nl80211: reject oversized EMA RNR lists
      net: rds: clear i_sends on setup unwind

Zeng Heng (2):
      mtd: spi-nor: core: fix implicit declaration warning
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
      ipv6: exthdrs: refresh nh after handling HAO option
      xfrm: input: hold netns during deferred transport reinjection
      net: bridge: use a stable FDB dst snapshot in RCU readers
      netfilter: require Ethernet MAC header before using eth_hdr()

Zhenghang Xiao (3):
      Bluetooth: l2cap: clear chan->ident on ECRED reconfiguration success
      sctp: fix race between sctp_wait_for_connect and peeloff
      misc: fastrpc: fix use-after-free race in fastrpc_map_create

Zilin Guan (1):
      hfsplus: fix held lock freed on hfsplus_fill_super()

hlleng (1):
      HID: quirks: Add ALWAYS_POLL quirk for SIGMACHIP USB mouse

