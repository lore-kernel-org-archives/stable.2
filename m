Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B1A3803E1;
	Fri, 19 Jun 2026 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781870400; cv=none; b=ALHic1mS15NL7rhZS/HxW4MKmMgD+WJOkuriMwznlzEo0QXR3ULpU/byis7ElvGv0g2JcZljslCmFJRCuXBB2gRB34gT9NzY78YQk+NtO/AyDqbo/uFirKsGCcwcpjI7O3jvdrk+A7yG1qUrZqf6SkOmZQwusmJb2H1ESgdwNrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781870400; c=relaxed/simple;
	bh=UWZ8D3KZ7XfTAP6RPkvJ5GTBH0o4BoRtw1q1J8HFjRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oRplSrxLPLbOHCnwO4LridAur/0F47dBqFtNNtlb6e/nrPMurplsrmgPjTv8iz2Vw8Hm5u/RDzh7t2MTtzQiJmsluk7aD5Y53DyNOmz/XY50JjJUWtSCHs98umzFSzAHZOLirJ8KOGxo6p8EmpdF2+2UTB3L8OQPUFGY7s+u2UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dF6lBMzS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dF6lBMzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B581F00A3A;
	Fri, 19 Jun 2026 11:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781870397;
	bh=g4N3eVUv26bvM5Ut7nWCQKbrydi42GUoU9j1mmoqI4s=;
	h=From:To:Cc:Subject:Date;
	b=dF6lBMzSItXFEgU0Zqt2pwKjvb4nCUdkEgZRu+pjScymJ7zaphFyYiN9LOWFmHSIK
	 SriyIQreJUo2j/vEKnMMYLbzwOazkN49MOmfUJbDsWFboLCcXXOuyRKzL/gtiZX+r1
	 gatNtZUUgVUW8roRlnr4+9+VEJlU7rRBzAiAocVY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.210
Date: Fri, 19 Jun 2026 13:58:42 +0200
Message-ID: <2026061943-earthling-unused-3e5a@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.210 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arm64/silicon-errata.rst                    |   46 ++
 Makefile                                                  |    2 
 arch/arm/include/asm/io.h                                 |   15 
 arch/arm/mach-socfpga/platsmp.c                           |    1 
 arch/arm64/Kconfig                                        |   50 +++
 arch/arm64/include/asm/cputype.h                          |    6 
 arch/arm64/include/asm/kvm_mmu.h                          |    4 
 arch/arm64/include/asm/tlb.h                              |    2 
 arch/arm64/include/asm/tlbflush.h                         |   55 ++-
 arch/arm64/kernel/cpu_errata.c                            |   34 ++
 arch/arm64/kernel/sys_compat.c                            |    2 
 arch/arm64/kvm/hyp/nvhe/tlb.c                             |   41 --
 arch/arm64/kvm/hyp/vhe/tlb.c                              |   19 -
 arch/arm64/mm/mmu.c                                       |   36 +-
 arch/x86/kernel/cpu/amd.c                                 |   18 -
 arch/x86/kernel/cpu/microcode/intel.c                     |    4 
 block/blk-cgroup.c                                        |   32 +-
 crypto/testmgr.c                                          |    4 
 drivers/base/power/domain.c                               |   10 
 drivers/block/drbd/drbd_main.c                            |    2 
 drivers/block/drbd/drbd_receiver.c                        |    2 
 drivers/block/loop.c                                      |   14 
 drivers/block/nbd.c                                       |   10 
 drivers/bluetooth/btusb.c                                 |    8 
 drivers/bluetooth/hci_qca.c                               |   33 +-
 drivers/char/random.c                                     |    4 
 drivers/comedi/drivers/comedi_test.c                      |    5 
 drivers/crypto/caam/caamalg_qi2.c                         |    4 
 drivers/crypto/caam/caamhash.c                            |    4 
 drivers/dma/idxd/init.c                                   |    1 
 drivers/dma/idxd/sysfs.c                                  |    1 
 drivers/fsi/fsi-sbefifo.c                                 |    6 
 drivers/gpio/gpio-rockchip.c                              |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |    5 
 drivers/gpu/drm/amd/display/dc/basics/vector.c            |    4 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c        |   54 ++-
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c       |    3 
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c                 |  136 ++++++--
 drivers/gpu/drm/i915/display/intel_display_types.h        |    1 
 drivers/gpu/drm/i915/display/intel_dpcd.h                 |   15 
 drivers/gpu/drm/i915/display/intel_psr.c                  |   34 ++
 drivers/gpu/drm/i915/gem/i915_gem_phys.c                  |   19 -
 drivers/gpu/drm/imx/dcss/dcss-scaler.c                    |    3 
 drivers/gpu/drm/vc4/vc4_validate_shaders.c                |   13 
 drivers/hid/hid-core.c                                    |   29 +
 drivers/hid/hid-gfrm.c                                    |    4 
 drivers/hid/hid-logitech-hidpp.c                          |    2 
 drivers/hid/hid-multitouch.c                              |    2 
 drivers/hid/hid-primax.c                                  |    2 
 drivers/hid/hid-vivaldi.c                                 |    2 
 drivers/hid/wacom_sys.c                                   |   19 -
 drivers/hid/wacom_wac.h                                   |    1 
 drivers/i2c/busses/i2c-qcom-cci.c                         |    2 
 drivers/i2c/busses/i2c-stm32f7.c                          |    6 
 drivers/i2c/busses/i2c-tegra.c                            |   53 +--
 drivers/i2c/i2c-dev.c                                     |    9 
 drivers/iio/adc/viperboard_adc.c                          |    4 
 drivers/iio/adc/xilinx-xadc-core.c                        |   11 
 drivers/iio/buffer/industrialio-hw-consumer.c             |    4 
 drivers/iio/chemical/scd30_core.c                         |   65 +---
 drivers/iio/common/ssp_sensors/ssp_dev.c                  |    1 
 drivers/iio/dac/ad5686.c                                  |    8 
 drivers/iio/dac/ad5686.h                                  |    1 
 drivers/iio/dac/max5821.c                                 |    9 
 drivers/iio/gyro/adis16260.c                              |    3 
 drivers/iio/gyro/itg3200_buffer.c                         |    2 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c            |    2 
 drivers/iio/light/cm3323.c                                |    5 
 drivers/iio/magnetometer/st_magn_core.c                   |   13 
 drivers/iio/temperature/tsys01.c                          |    2 
 drivers/infiniband/core/Makefile                          |    2 
 drivers/infiniband/core/iter.c                            |   43 ++
 drivers/infiniband/core/verbs.c                           |   38 --
 drivers/infiniband/hw/bnxt_re/qplib_res.c                 |    2 
 drivers/infiniband/hw/cxgb4/mem.c                         |    2 
 drivers/infiniband/hw/efa/efa_verbs.c                     |    2 
 drivers/infiniband/hw/hns/hns_roce_alloc.c                |    2 
 drivers/infiniband/hw/irdma/main.h                        |    2 
 drivers/infiniband/hw/mlx4/mr.c                           |    1 
 drivers/infiniband/hw/mlx5/mem.c                          |    1 
 drivers/infiniband/hw/mlx5/mr.c                           |    1 
 drivers/infiniband/hw/mthca/mthca_provider.c              |    2 
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c               |    2 
 drivers/infiniband/hw/qedr/verbs.c                        |    2 
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h                 |    2 
 drivers/infiniband/sw/rxe/rxe_srq.c                       |    3 
 drivers/infiniband/ulp/isert/ib_isert.c                   |    6 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                    |    2 
 drivers/infiniband/ulp/srp/ib_srp.c                       |   30 +
 drivers/input/keyboard/atkbd.c                            |   15 
 drivers/input/misc/ims-pcu.c                              |    2 
 drivers/input/mouse/elan_i2c_core.c                       |    5 
 drivers/input/mouse/synaptics.c                           |    1 
 drivers/input/touchscreen/atmel_mxt_ts.c                  |    2 
 drivers/input/touchscreen/usbtouchscreen.c                |    5 
 drivers/iommu/io-pgtable-arm-v7s.c                        |   18 -
 drivers/isdn/mISDN/l1oip_core.c                           |    2 
 drivers/md/dm-cache-policy-smq.c                          |   12 
 drivers/media/rc/igorplugusb.c                            |   19 -
 drivers/media/rc/ttusbir.c                                |   13 
 drivers/misc/fastrpc.c                                    |   77 +++--
 drivers/misc/vmw_vmci/vmci_queue_pair.c                   |    6 
 drivers/mmc/core/mmc.c                                    |    4 
 drivers/mmc/host/renesas_sdhi_internal_dmac.c             |    1 
 drivers/mmc/host/sdhci-of-dwcmshc.c                       |   17 -
 drivers/mmc/host/sdhci.c                                  |    1 
 drivers/mtd/spi-nor/sst.c                                 |   13 
 drivers/net/bonding/bond_main.c                           |   10 
 drivers/net/can/usb/ucan.c                                |    6 
 drivers/net/ethernet/amd/pcnet32.c                        |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                 |    2 
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c          |    2 
 drivers/net/ethernet/marvell/mv643xx_eth.c                |    2 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c           |   75 +++-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c           |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c  |    2 
 drivers/net/ethernet/microchip/lan743x_main.c             |   32 ++
 drivers/net/ethernet/microchip/lan743x_main.h             |    1 
 drivers/net/ethernet/qlogic/qed/qed_cxt.c                 |   26 -
 drivers/net/ethernet/ti/cpsw_new.c                        |    4 
 drivers/net/hyperv/netvsc.c                               |   19 -
 drivers/net/macsec.c                                      |    3 
 drivers/net/phy/mscc/mscc.h                               |    9 
 drivers/net/phy/mscc/mscc_main.c                          |   38 --
 drivers/net/ppp/ppp_generic.c                             |    2 
 drivers/net/tap.c                                         |    2 
 drivers/net/tun.c                                         |    5 
 drivers/net/vxlan/vxlan_core.c                            |    4 
 drivers/net/wireguard/send.c                              |   20 -
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c |    6 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   |    4 
 drivers/net/wireless/marvell/mwifiex/init.c               |    2 
 drivers/net/wireless/realtek/rtw88/pci.c                  |    3 
 drivers/nfc/nxp-nci/i2c.c                                 |   21 +
 drivers/nvme/host/tcp.c                                   |    4 
 drivers/nvme/target/io-cmd-file.c                         |    4 
 drivers/nvme/target/tcp.c                                 |    2 
 drivers/parport/share.c                                   |   11 
 drivers/phy/tegra/xusb-tegra186.c                         |   38 +-
 drivers/phy/tegra/xusb.h                                  |    1 
 drivers/scsi/fcoe/fcoe_ctlr.c                             |    2 
 drivers/scsi/scsi_transport_fc.c                          |   77 ++---
 drivers/scsi/sg.c                                         |    2 
 drivers/slimbus/qcom-ngd-ctrl.c                           |    3 
 drivers/spi/spi-lantiq-ssc.c                              |    8 
 drivers/spi/spi-qup.c                                     |  165 +++++-----
 drivers/spi/spi-st-ssc4.c                                 |    8 
 drivers/spi/spi-sun4i.c                                   |   10 
 drivers/spi/spi-sun6i.c                                   |    9 
 drivers/spi/spi-synquacer.c                               |    8 
 drivers/spi/spi-tegra114.c                                |    8 
 drivers/spi/spi-tegra20-sflash.c                          |    8 
 drivers/spi/spi-ti-qspi.c                                 |   15 
 drivers/spi/spi-topcliff-pch.c                            |   11 
 drivers/spi/spi-uniphier.c                                |    8 
 drivers/spi/spi-zynq-qspi.c                               |   15 
 drivers/staging/greybus/hid.c                             |    2 
 drivers/target/iscsi/iscsi_target.c                       |    6 
 drivers/target/iscsi/iscsi_target_nego.c                  |    7 
 drivers/target/iscsi/iscsi_target_parameters.c            |   62 +++-
 drivers/target/iscsi/iscsi_target_parameters.h            |    2 
 drivers/target/iscsi/iscsi_target_util.c                  |    4 
 drivers/target/target_core_file.c                         |    2 
 drivers/tee/optee/supp.c                                  |  107 ++++--
 drivers/thermal/thermal_core.c                            |    7 
 drivers/thunderbolt/property.c                            |   38 +-
 drivers/thunderbolt/xdomain.c                             |    6 
 drivers/tty/serial/altera_jtaguart.c                      |   18 -
 drivers/tty/serial/dz.c                                   |   58 ++-
 drivers/tty/serial/fsl_lpuart.c                           |   15 
 drivers/tty/serial/pch_uart.c                             |   19 -
 drivers/tty/serial/qcom_geni_serial.c                     |   77 ++---
 drivers/tty/serial/samsung_tty.c                          |   88 ++---
 drivers/tty/serial/sh-sci.c                               |    2 
 drivers/tty/serial/zs.c                                   |   40 --
 drivers/tty/serial/zs.h                                   |    2 
 drivers/usb/cdns3/cdns3-gadget.c                          |   12 
 drivers/usb/cdns3/cdns3-plat.c                            |   11 
 drivers/usb/chipidea/core.c                               |   16 -
 drivers/usb/class/usbtmc.c                                |   14 
 drivers/usb/core/config.c                                 |    9 
 drivers/usb/core/hcd.c                                    |    4 
 drivers/usb/core/quirks.c                                 |    4 
 drivers/usb/dwc2/hcd.c                                    |    4 
 drivers/usb/dwc3/core.c                                   |   12 
 drivers/usb/dwc3/dwc3-xilinx.c                            |   20 -
 drivers/usb/gadget/function/f_fs.c                        |    2 
 drivers/usb/gadget/function/f_hid.c                       |   20 -
 drivers/usb/gadget/udc/dummy_hcd.c                        |    4 
 drivers/usb/gadget/udc/net2280.c                          |    4 
 drivers/usb/host/xhci-tegra.c                             |   78 ++---
 drivers/usb/serial/belkin_sa.c                            |    3 
 drivers/usb/serial/cypress_m8.c                           |   20 +
 drivers/usb/serial/digi_acceleport.c                      |   23 +
 drivers/usb/serial/io_ti.c                                |   11 
 drivers/usb/serial/keyspan.c                              |    4 
 drivers/usb/serial/kl5kusb105.c                           |    4 
 drivers/usb/serial/mct_u232.c                             |   26 +
 drivers/usb/serial/mxuport.c                              |    8 
 drivers/usb/serial/omninet.c                              |    9 
 drivers/usb/serial/option.c                               |   12 
 drivers/usb/serial/safe_serial.c                          |   11 
 drivers/usb/storage/unusual_uas.h                         |    7 
 drivers/usb/typec/altmodes/displayport.c                  |    2 
 drivers/usb/typec/tcpm/tcpm.c                             |    2 
 drivers/usb/typec/tcpm/wcove.c                            |   13 
 drivers/usb/typec/ucsi/displayport.c                      |    4 
 drivers/usb/typec/ucsi/ucsi.c                             |    7 
 drivers/usb/typec/ucsi/ucsi_ccg.c                         |    5 
 drivers/usb/usbip/usbip_common.c                          |    2 
 drivers/usb/usbip/vudc_dev.c                              |    1 
 drivers/usb/usbip/vudc_transfer.c                         |    3 
 drivers/vhost/net.c                                       |    6 
 drivers/vhost/scsi.c                                      |   10 
 drivers/vhost/vhost.c                                     |    6 
 drivers/vhost/vringh.c                                    |    4 
 drivers/vhost/vsock.c                                     |    4 
 drivers/video/fbdev/core/fb_defio.c                       |  152 ++++++++-
 drivers/video/fbdev/core/fbcon_rotate.c                   |    5 
 drivers/video/fbdev/vt8500lcdfb.c                         |    2 
 drivers/xen/pvcalls-back.c                                |    8 
 fs/9p/vfs_addr.c                                          |    4 
 fs/9p/vfs_dir.c                                           |    2 
 fs/9p/xattr.c                                             |    4 
 fs/afs/cmservice.c                                        |    2 
 fs/afs/dir.c                                              |    2 
 fs/afs/file.c                                             |    4 
 fs/afs/internal.h                                         |    4 
 fs/afs/rxrpc.c                                            |   10 
 fs/afs/write.c                                            |    4 
 fs/aio.c                                                  |    4 
 fs/btrfs/inode.c                                          |    2 
 fs/btrfs/ioctl.c                                          |    5 
 fs/ceph/addr.c                                            |    2 
 fs/ceph/dir.c                                             |    6 
 fs/ceph/file.c                                            |    4 
 fs/cifs/cifsacl.c                                         |  129 +++++++-
 fs/cifs/connect.c                                         |    6 
 fs/cifs/file.c                                            |    4 
 fs/cifs/ioctl.c                                           |    2 
 fs/cifs/netlink.c                                         |    6 
 fs/cifs/smb2ops.c                                         |   10 
 fs/cifs/smb2transport.c                                   |   36 +-
 fs/cifs/smbdirect.c                                       |    4 
 fs/cifs/transport.c                                       |    6 
 fs/erofs/decompressor.c                                   |    1 
 fs/erofs/dir.c                                            |   30 +
 fs/ext4/extents.c                                         |   15 
 fs/f2fs/data.c                                            |    4 
 fs/f2fs/f2fs.h                                            |    5 
 fs/f2fs/inline.c                                          |   13 
 fs/f2fs/segment.c                                         |    6 
 fs/f2fs/super.c                                           |   20 +
 fs/fcntl.c                                                |    8 
 fs/fuse/dev.c                                             |    9 
 fs/fuse/ioctl.c                                           |    4 
 fs/hfsplus/bfind.c                                        |   51 +++
 fs/hfsplus/catalog.c                                      |    4 
 fs/hfsplus/dir.c                                          |    2 
 fs/hfsplus/hfsplus_fs.h                                   |    9 
 fs/hfsplus/super.c                                        |    6 
 fs/hpfs/alloc.c                                           |    2 
 fs/ksmbd/auth.c                                           |    4 
 fs/ksmbd/smb2pdu.c                                        |    5 
 fs/ksmbd/smbacl.c                                         |   17 -
 fs/ksmbd/transport_tcp.c                                  |    4 
 fs/nfsd/nfs4xdr.c                                         |    9 
 fs/nfsd/nfsctl.c                                          |    9 
 fs/nfsd/state.h                                           |   17 -
 fs/nfsd/stats.c                                           |    4 
 fs/nfsd/stats.h                                           |    2 
 fs/nfsd/vfs.c                                             |    4 
 fs/ntfs3/xattr.c                                          |    1 
 fs/ocfs2/cluster/tcp.c                                    |    2 
 fs/orangefs/inode.c                                       |    8 
 fs/read_write.c                                           |   12 
 fs/seq_file.c                                             |    2 
 fs/splice.c                                               |   10 
 fs/udf/super.c                                            |    4 
 include/drm/drm_dp_helper.h                               |    1 
 include/drm/drm_fourcc.h                                  |    5 
 include/linux/compat.h                                    |    4 
 include/linux/compiler-clang.h                            |   28 +
 include/linux/compiler_attributes.h                       |   11 
 include/linux/compiler_types.h                            |    4 
 include/linux/fb.h                                        |    4 
 include/linux/hid.h                                       |   15 
 include/linux/parport.h                                   |    1 
 include/linux/printk.h                                    |   13 
 include/linux/randomize_kstack.h                          |   44 ++
 include/linux/sched.h                                     |    4 
 include/linux/syscalls.h                                  |    4 
 include/linux/uio.h                                       |    3 
 include/net/act_api.h                                     |    1 
 include/net/bluetooth/bluetooth.h                         |    3 
 include/net/bluetooth/l2cap.h                             |    1 
 include/net/genetlink.h                                   |    9 
 include/net/ip_vs.h                                       |    3 
 include/net/mctp.h                                        |    3 
 include/net/sock.h                                        |    1 
 include/net/xfrm.h                                        |    3 
 include/rdma/ib_umem.h                                    |   36 --
 include/rdma/ib_verbs.h                                   |   48 ---
 include/rdma/iter.h                                       |   88 +++++
 init/main.c                                               |    1 
 io_uring/io_uring.c                                       |    2 
 ipc/shm.c                                                 |   10 
 ipc/util.c                                                |    2 
 kernel/fork.c                                             |    2 
 kernel/pid.c                                              |    8 
 kernel/sched/core.c                                       |    2 
 kernel/sched/rt.c                                         |    2 
 kernel/sched/sched.h                                      |    2 
 kernel/signal.c                                           |    1 
 kernel/time/time.c                                        |    2 
 kernel/trace/trace_probe.c                                |    6 
 kernel/trace/trace_probe.h                                |    4 
 kernel/tracepoint.c                                       |    2 
 lib/debugobjects.c                                        |    2 
 lib/mpi/mpicoder.c                                        |    2 
 mm/damon/vaddr.c                                          |    4 
 mm/huge_memory.c                                          |    2 
 mm/hugetlb.c                                              |    1 
 mm/madvise.c                                              |    2 
 mm/page_io.c                                              |    2 
 mm/process_vm_access.c                                    |    2 
 net/6lowpan/iphc.c                                        |    4 
 net/802/garp.c                                            |    2 
 net/802/mrp.c                                             |    9 
 net/9p/client.c                                           |    2 
 net/batman-adv/bat_iv_ogm.c                               |   82 ++++-
 net/batman-adv/bat_v_ogm.c                                |   59 ++-
 net/batman-adv/bridge_loop_avoidance.c                    |   57 ++-
 net/batman-adv/main.c                                     |    1 
 net/batman-adv/soft-interface.c                           |    1 
 net/batman-adv/tp_meter.c                                 |  215 +++++++++-----
 net/batman-adv/tp_meter.h                                 |    1 
 net/batman-adv/translation-table.c                        |   35 +-
 net/batman-adv/tvlv.c                                     |   28 +
 net/batman-adv/tvlv.h                                     |    2 
 net/batman-adv/types.h                                    |   57 ++-
 net/bluetooth/6lowpan.c                                   |    4 
 net/bluetooth/a2mp.c                                      |    2 
 net/bluetooth/af_bluetooth.c                              |  142 +++++++--
 net/bluetooth/bnep/core.c                                 |   50 ++-
 net/bluetooth/bnep/sock.c                                 |   10 
 net/bluetooth/hci_event.c                                 |   18 -
 net/bluetooth/hci_sock.c                                  |   10 
 net/bluetooth/hci_sysfs.c                                 |    6 
 net/bluetooth/hidp/core.c                                 |   23 +
 net/bluetooth/hidp/sock.c                                 |   10 
 net/bluetooth/l2cap_core.c                                |   87 +++++
 net/bluetooth/l2cap_sock.c                                |   86 +++--
 net/bluetooth/mgmt.c                                      |   21 -
 net/bluetooth/rfcomm/core.c                               |   67 +++-
 net/bluetooth/rfcomm/sock.c                               |   48 ++-
 net/bluetooth/sco.c                                       |   19 -
 net/bluetooth/smp.c                                       |    2 
 net/bridge/br_arp_nd_proxy.c                              |    8 
 net/bridge/br_fdb.c                                       |   28 +
 net/bridge/netfilter/ebt_snat.c                           |    3 
 net/bridge/netfilter/ebtables.c                           |   30 +
 net/ceph/messenger_v1.c                                   |    4 
 net/ceph/messenger_v2.c                                   |   14 
 net/compat.c                                              |    2 
 net/core/drop_monitor.c                                   |    2 
 net/core/filter.c                                         |   17 -
 net/core/skbuff.c                                         |   10 
 net/ethtool/eeprom.c                                      |    5 
 net/hsr/hsr_framereg.c                                    |    6 
 net/ieee802154/6lowpan/tx.c                               |    5 
 net/ipv4/ah4.c                                            |   31 +-
 net/ipv4/esp4.c                                           |    4 
 net/ipv4/ip_options.c                                     |    4 
 net/ipv4/ip_tunnel_core.c                                 |   22 -
 net/ipv4/netfilter/arp_tables.c                           |   15 
 net/ipv4/netfilter/ip_tables.c                            |   15 
 net/ipv4/netfilter/nft_fib_ipv4.c                         |    2 
 net/ipv4/sysctl_net_ipv4.c                                |    2 
 net/ipv4/tcp.c                                            |    4 
 net/ipv4/tcp_ipv4.c                                       |    5 
 net/ipv6/addrconf.c                                       |   47 +--
 net/ipv6/ah6.c                                            |   29 +
 net/ipv6/datagram.c                                       |   54 ++-
 net/ipv6/esp6.c                                           |    4 
 net/ipv6/exthdrs.c                                        |   28 +
 net/ipv6/ioam6.c                                          |   12 
 net/ipv6/ip6_input.c                                      |    2 
 net/ipv6/ip6_vti.c                                        |   25 +
 net/ipv6/mcast.c                                          |   22 -
 net/ipv6/ndisc.c                                          |   12 
 net/ipv6/netfilter/ip6_tables.c                           |   15 
 net/ipv6/netfilter/ip6t_eui64.c                           |    7 
 net/ipv6/netfilter/nft_fib_ipv6.c                         |    2 
 net/ipv6/seg6_hmac.c                                      |    8 
 net/ipv6/sit.c                                            |    1 
 net/ipv6/tcp_ipv6.c                                       |    5 
 net/iucv/af_iucv.c                                        |   20 -
 net/key/af_key.c                                          |    6 
 net/mctp/device.c                                         |    1 
 net/mctp/neigh.c                                          |    1 
 net/mctp/route.c                                          |    9 
 net/mptcp/options.c                                       |   29 +
 net/mptcp/pm.c                                            |   34 +-
 net/mptcp/pm_netlink.c                                    |   31 +-
 net/mptcp/protocol.c                                      |   26 +
 net/mptcp/sockopt.c                                       |    8 
 net/netfilter/ipset/ip_set_bitmap_ipmac.c                 |    5 
 net/netfilter/ipset/ip_set_hash_ipmac.c                   |    9 
 net/netfilter/ipset/ip_set_hash_mac.c                     |    5 
 net/netfilter/ipvs/ip_vs_ctl.c                            |   13 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                     |   18 -
 net/netfilter/ipvs/ip_vs_proto_tcp.c                      |   21 -
 net/netfilter/ipvs/ip_vs_proto_udp.c                      |   20 -
 net/netfilter/ipvs/ip_vs_sched.c                          |   14 
 net/netfilter/ipvs/ip_vs_sync.c                           |    2 
 net/netfilter/nf_conntrack_irc.c                          |    4 
 net/netfilter/nf_conntrack_proto_tcp.c                    |    3 
 net/netfilter/nf_log_syslog.c                             |   12 
 net/netfilter/nf_synproxy_core.c                          |   26 +
 net/netfilter/nft_exthdr.c                                |    3 
 net/netfilter/nft_fib.c                                   |    6 
 net/netfilter/nft_tunnel.c                                |    2 
 net/netfilter/xt_NFQUEUE.c                                |    2 
 net/netfilter/xt_cpu.c                                    |    2 
 net/netfilter/xt_mac.c                                    |    4 
 net/netlabel/netlabel_unlabeled.c                         |   30 -
 net/netlink/af_netlink.c                                  |   11 
 net/netlink/genetlink.c                                   |    4 
 net/nfc/hci/core.c                                        |   10 
 net/nfc/llcp_core.c                                       |   11 
 net/nfc/llcp_sock.c                                       |    2 
 net/nfc/nci/hci.c                                         |   10 
 net/openvswitch/datapath.c                                |    1 
 net/packet/af_packet.c                                    |   25 -
 net/psample/psample.c                                     |    2 
 net/qrtr/af_qrtr.c                                        |    4 
 net/qrtr/ns.c                                             |  180 ++++-------
 net/rds/ib_cm.c                                           |    1 
 net/rds/ib_send.c                                         |    2 
 net/rds/info.c                                            |    2 
 net/sched/act_api.c                                       |    7 
 net/sched/cls_fw.c                                        |    6 
 net/sched/sch_sfb.c                                       |    2 
 net/sctp/diag.c                                           |   17 -
 net/sctp/input.c                                          |    8 
 net/sctp/sm_statefuns.c                                   |    6 
 net/sctp/socket.c                                         |    2 
 net/sctp/stream.c                                         |    6 
 net/smc/af_smc.c                                          |    4 
 net/smc/smc_clc.c                                         |    6 
 net/socket.c                                              |   23 -
 net/sunrpc/socklib.c                                      |    6 
 net/sunrpc/svcsock.c                                      |    4 
 net/sunrpc/xprtsock.c                                     |    6 
 net/tipc/topsrv.c                                         |    2 
 net/tls/tls_device.c                                      |    4 
 net/vmw_vsock/vmci_transport.c                            |    4 
 net/xfrm/espintcp.c                                       |    6 
 net/xfrm/xfrm_input.c                                     |   16 -
 net/xfrm/xfrm_policy.c                                    |   15 
 net/xfrm/xfrm_state.c                                     |   35 +-
 net/xfrm/xfrm_user.c                                      |    5 
 security/apparmor/policy_unpack.c                         |   27 -
 security/keys/keyctl.c                                    |    4 
 security/selinux/hooks.c                                  |    3 
 sound/aoa/codecs/onyx.c                                   |  104 ++----
 sound/aoa/codecs/tas.c                                    |  113 ++-----
 sound/aoa/core/gpio-feature.c                             |   20 -
 sound/aoa/core/gpio-pmf.c                                 |   26 -
 sound/aoa/soundbus/i2sbus/core.c                          |    3 
 sound/aoa/soundbus/i2sbus/pcm.c                           |  143 ++++-----
 sound/core/misc.c                                         |   14 
 sound/core/timer.c                                        |    1 
 sound/drivers/aloop.c                                     |   40 +-
 sound/pci/hda/patch_hdmi.c                                |    1 
 sound/soc/codecs/simple-mux.c                             |    2 
 sound/soc/intel/boards/bytcht_es8316.c                    |   29 +
 sound/soc/qcom/qdsp6/q6asm-dai.c                          |   43 +-
 tools/testing/selftests/net/forwarding/lib.sh             |   56 +++
 tools/testing/selftests/net/mptcp/mptcp_connect.sh        |    6 
 481 files changed, 4821 insertions(+), 2534 deletions(-)

Aaron Erhardt (1):
      ALSA: hda/hdmi: Add quirk for TUXEDO IBS14G6

Adrian Korwel (2):
      USB: serial: io_ti: fix heap overflow in get_manuf_info()
      USB: serial: io_ti: fix heap overflow in build_i2c_fw_hdr()

Adrian Moreno (1):
      net: openvswitch: fix possible kfree_skb of ERR_PTR

Advait Dhamorikar (1):
      iio: magnetometer: st_magn: fix default DRDY pin selection for LIS2MDL

Akhil R (1):
      i2c: tegra: Fix NOIRQ suspend/resume

Al Viro (1):
      use less confusing names for iov_iter direction initializers

Aldo Conte (1):
      iio: light: cm3323: fix reg_conf not being initialized correctly

Aleksandr Nogikh (1):
      signal: clear JOBCTL_PENDING_MASK for caller in zap_other_threads()

Alexander A. Klimov (1):
      drm/vc4: fix krealloc() memory leak

Alexandra Winter (1):
      net/smc: Do not re-initialize smc hashtables

Ali Ganiyev (1):
      ksmbd: OOB read regression in smb_check_perm_dacl() ACE-walk loops

Amirreza Zarrabi (1):
      tee: optee: prevent use-after-free when the client exits before the supplicant

Amit Sunil Dhamne (1):
      usb: typec: tcpm: reset internal port states on soft reset AMS

Anandu Krishnan E (1):
      misc: fastrpc: fix use-after-free of fastrpc_user in workqueue context

Anshuman Khandual (1):
      arm64/mm: Enable batched TLB flush in unmap_hotplug_range()

Anton Leontev (1):
      hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf

Antoniu Miclaus (2):
      iio: gyro: adis16260: fix division by zero in write_raw
      iio: chemical: scd30: fix division by zero in write_raw

Arnd Bergmann (1):
      iommu, debugobjects: avoid gcc-16.1 section mismatch warnings

Ashutosh Desai (1):
      nfc: hci: fix out-of-bounds read in HCP header parsing

Bartosz Golaszewski (3):
      net: mv643xx: fix OF node refcount
      tty: serial: qcom-geni-serial: remove unused symbols
      tty: serial: qcom-geni-serial: align #define values

Ben Hutchings (4):
      Revert "RDMA/rxe: Fix double free in rxe_srq_from_init"
      parport: Fix race between port and client registration
      fbdev: vt8500lcdfb: Fix dma_free_coherent() cpu_addr parameter
      apparmor: validate default DFA states are in bounds

Benjamin Tissoires (1):
      HID: pass the buffer size to hid_report_raw_event

Berkant Koc (2):
      drm/hyperv: validate VMBus packet size in receive callback
      drm/hyperv: validate resolution_count and fix WIN8 fallback

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

Carl Lee (1):
      nfc: nxp-nci: i2c: use rising-edge IRQ on ACPI systems

Carlos Eduardo Gallo Filho (1):
      drm: Remove plane hsub/vsub alignment requirement for core helpers

Chao Yu (2):
      f2fs: fix to do sanity check on dcc->discard_cmd_cnt conditionally
      f2fs: fix false alarm of lockdep on cp_global_sem lock

Chenguang Zhao (1):
      netlabel: validate unlabeled address and mask attribute lengths

Chris Mason (1):
      netfilter: synproxy: refresh tcphdr after skb_ensure_writable

Christian Brauner (1):
      pidfd: refuse access to tasks that have started exiting harder

Christian Göttsche (1):
      selinux: enable genfscon labeling for securityfs

Christofer Jonason (1):
      iio: adc: xilinx-xadc: Fix sequencer mode in postdisable for dual mux

Christophe JAILLET (1):
      qed: Use the bitmap API to simplify some functions

Cryolitia PukNgae (1):
      Input: atkbd - skip deactivate for HONOR BCC-N's internal keyboard

Cássio Gabriel (4):
      ASoC: Intel: bytcht_es8316: Fix MCLK leak on init errors
      ASoC: codecs: simple-mux: Fix enum control bounds check
      ALSA: aoa: i2sbus: clear stale prepared state
      ALSA: aloop: Fix peer runtime UAF during format-change stop

DaeMyung Kang (1):
      smb: server: fix max_connections off-by-one in tcp accept path

Dan Carpenter (1):
      usb: dwc2: Fix use after free in debug code

Daniel Hodges (1):
      wifi: mwifiex: fix use-after-free in mwifiex_adapter_cleanup()

David Ahern (1):
      xfrm: Check for underflow in xfrm_state_mtu

David Carlier (2):
      iio: gyro: itg3200: fix i2c read into the wrong stack location
      tracepoint: balance regfunc() on func_add() failure in tracepoint_add_func()

David Thompson (1):
      net: lan743x: permit VLAN-tagged packets up to configured MTU

Davide Caratti (1):
      net/sched: cls_fw: fix NULL dereference of "old" filters before change()

Davide Ornaghi (1):
      netfilter: nft_fib: fix stale stack leak via the OIFNAME register

Dawei Feng (2):
      qed: fix double free in qed_cxt_tables_alloc()
      octeontx2-pf: avoid double free of pool->stack on AQ init failure

Deepanshu Kartikey (1):
      hfsplus: fix uninit-value by validating catalog record size

Dmitry Torokhov (2):
      Input: elan_i2c - validate firmware size before use
      Input: atmel_mxt_ts - fix boundary check in mxt_prepare_cfg_mem

Dudu Lu (1):
      Bluetooth: bnep: fix incorrect length parsing in bnep_rx_frame() extension handling

Duoming Zhou (1):
      wifi: brcmfmac: fix use-after-free when rescheduling brcmf_btcoex_info work

Edward Lo (1):
      fs/ntfs3: Return error for inconsistent extended attributes

Eric Biggers (4):
      net/tcp-md5: Fix MAC comparison to be constant-time
      net: ipv4: stop checking crypto_ahash_alignmask
      net: ipv6: stop checking crypto_ahash_alignmask
      ksmbd: Compare MACs in constant time

Eric Dumazet (8):
      ipv4: free net->ipv4.sysctl_local_reserved_ports after unregister_net_sysctl_table()
      tunnels: load network headers after skb_cow() in iptunnel_pmtud_build_icmp[v6]()
      vxlan: do not reuse cached ip_hdr() value after skb_tunnel_check_pmtu()
      tunnels: do not assume transport header in iptunnel_pmtud_check_icmp()
      ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
      ieee802154: 6lowpan: only accept IPv6 packets in lowpan_xmit()
      ip6_vti: fix incorrect tunnel matching in vti6_tnl_lookup()
      ipv6/addrconf: annotate data-races around devconf fields (II)

Fedor Pchelkin (1):
      wifi: rtw88: check for PCI upstream bridge existence

Felix Gu (1):
      iio: buffer: hw-consumer: fix use-after-free in error path

Fernando Fernandez Mancera (2):
      netfilter: xt_NFQUEUE: prefer raw_smp_processor_id
      netfilter: synproxy: add mutex to guard hook reference counting

Filipe Manana (1):
      btrfs: fix missing last_unlink_trans update when removing a directory

Florian Westphal (4):
      netfilter: xt_cpu: prefer raw_smp_processor_id
      netfilter: ebtables: fix OOB read in compat_mtw_from_user
      netfilter: conntrack_irc: fix possible out-of-bounds read
      netfilter: nft_exthdr: fix register tracking for F_PRESENT flag

Gao Xiang (1):
      erofs: fix the out-of-bounds nameoff handling for trailing dirents

Greg Kroah-Hartman (7):
      Input: usbtouchscreen - clamp NEXIO data_len/x_len to URB buffer size
      iio: imu: st_lsm6dsx: fix stack leak in tagged FIFO buffer
      usb: typec: ucsi: ccg: reject firmware images without a ':' record header
      usb: typec: ucsi: displayport: NAK DP_CMD_CONFIGURE without a payload VDO
      usb: typec: altmodes/displayport: validate count before reading Status Update VDO
      usb: typec: wcove: don't write past struct pd_message in wcove_read_rx_buffer()
      Linux 5.15.210

Guangshuo Li (3):
      usb: gadget: net2280: Fix double free in probe error path
      dm cache policy smq: check allocation under invalidate lock
      usb: gadget: f_hid: fix device reference leak in hidg_alloc()

Guillermo Rodríguez (1):
      i2c: stm32f7: fix timing computation ignoring i2c-analog-filter

Hamza Mahfooz (1):
      netfilter: conntrack: tcp: do not force CLOSE on invalid-seq RST without direction check

Harini Katakam (1):
      phy: mscc: Use PHY_ID_MATCH_VENDOR to minimize PHY ID table

Harry Wentland (5):
      drm/amd/display: Reject gpio_bitshift >= 32 in bios_parser_get_gpio_pin_info()
      drm/amd/display: Clamp HDMI HDCP2 rx_id_list read to buffer size
      drm/amd/display: Clamp VBIOS HDMI retimer register count to array size
      drm/amd/display: Fix NULL deref and buffer over-read in SDP debugfs
      drm/amd/display: Use krealloc_array() in dal_vector_reserve()

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

Ian Abbott (2):
      comedi: comedi_test: fix check for valid scan_begin_src in waveform_ai_cmdtest()
      comedi: comedi_test: Fix limiting of convert_arg in waveform_ai_cmdtest()

Ido Schimmel (2):
      ipv6: mcast: Fix use-after-free when processing MLD queries
      genetlink: Use internal flags for multicast groups

Ilya Maximets (2):
      net: netlink: fix sending unassigned nsid after assigned one
      net: netlink: don't set nsid on local notifications

Jack Wu (1):
      USB: serial: option: add usb-id for Dell Wireless DW5826e-m

Jakub Kicinski (1):
      ethtool: eeprom: add more safeties to EEPROM Netlink fallback

Jamal Hadi Salim (1):
      net/sched: act_api: use RCU with deferred freeing for action lifecycle

Jan Volckaert (1):
      USB: serial: option: add MeiG SRM813Q

Jann Horn (1):
      fuse: reject fuse_notify() pagecache ops on directories

Jason A. Donenfeld (1):
      wireguard: send: append trailer after expanding head

Jason Gunthorpe (1):
      RDMA/umem: Fix truncation for block sizes >= 4G

Jeff Layton (2):
      nfsd: don't ignore the return code of svc_proc_register()
      nfsd: fix heap overflow in NFSv4.0 LOCK replay cache

Jeremy Kerr (1):
      net: mctp: ensure our nlmsg responses are initialised

Jiasheng Jiang (1):
      RDMA/rxe: Fix double free in rxe_srq_from_init

Jiexun Wang (2):
      Bluetooth: serialize accept_q access
      batman-adv: stop tp_meter sessions during mesh teardown

Jimmy Hon (1):
      rtw88: 8821ce: Disable PCIe ASPM L1 for 8821CE using chip ID

Jingguo Tan (1):
      xfrm: esp: restore combined single-frag length gate

Jisheng Zhang (1):
      mmc: sdhci: add signal voltage switch in sdhci_resume_host

Johan Hovold (21):
      USB: serial: safe_serial: fix memory corruption with small endpoint
      USB: serial: omninet: fix memory corruption with small endpoint
      USB: serial: keyspan: fix missing indat transfer sanity check
      USB: serial: mxuport: fix memory corruption with small endpoint
      USB: serial: mct_u232: fix missing interrupt-in transfer sanity check
      USB: serial: cypress_m8: fix memory corruption with small endpoint
      USB: serial: digi_acceleport: fix memory corruption with small endpoints
      USB: serial: mct_u232: fix memory corruption with small endpoint
      can: ucan: fix devres lifetime
      spi: syncuacer: fix controller deregistration
      spi: sun4i: fix controller deregistration
      spi: ti-qspi: fix controller deregistration
      spi: zynq-qspi: fix controller deregistration
      spi: sun6i: fix controller deregistration
      spi: tegra114: fix controller deregistration
      spi: tegra20-sflash: fix controller deregistration
      spi: uniphier: fix controller deregistration
      spi: topcliff-pch: fix controller deregistration
      spi: st-ssc4: fix controller deregistration
      spi: lantiq-ssc: fix controller deregistration
      spi: qup: fix error pointer deref after DMA setup failure

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

Julia Lawall (1):
      can: ucan: fix typos in comments

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

Kamal Dasu (1):
      mmc: core: Fix host controller programming for fixed driver type

Karl Mehltretter (1):
      ARM: 9474/1: io: avoid KASAN instrumentation of raw halfword I/O

Kevin Hao (1):
      net: cpsw_new: Fix potential unregister of netdev that has not been registered yet

Kuniyuki Iwashima (2):
      ip6: vti: Use ip6_tnl.net in vti6_changelink().
      bpf: Free reuseport cBPF prog after RCU grace period.

Kyle Meyer (1):
      bnxt_en: Fix NULL pointer dereference

Kyle Zeng (3):
      ipv6: sit: reload inner IPv6 header after GSO offloads
      net: guard timestamp cmsgs to real error queue skbs
      netfilter: x_tables: avoid leaking percpu counter pointers

Lad Prabhakar (2):
      mmc: renesas_sdhi: Add OF entry for RZ/G2H SoC
      serial: altera_jtaguart: Use platform_get_irq_optional() to get the interrupt

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

Longxuan Yu (1):
      io_uring/poll: fix signed comparison in io_poll_get_ownership()

Lorenzo Bianconi (1):
      net: mvpp2: Add metadata support for xdp mode

Luiz Augusto von Dentz (5):
      Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
      Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2
      Bluetooth: Consolidate code around sk_alloc into a helper function
      Bluetooth: Init sk_peer_* on bt_sock_alloc
      Bluetooth: MGMT: Fix backward compatibility with userspace

Lukas Wunner (1):
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

Marc Zyngier (1):
      KVM: arm64: Remove VPIPT I-cache handling

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

Matthieu Baerts (NGI0) (5):
      mptcp: sockopt: check timestamping ret value
      mptcp: pm: prio: skip closed subflows
      mptcp: pm: ADD_ADDR rtx: fix potential data-race
      mptcp: pm: ADD_ADDR rtx: resched blocked ADD_ADDR quicker
      selftests: mptcp: drop nanoseconds width specifier

Max Kellermann (1):
      ceph: only d_add() negative dentries when they are unhashed

Michael Bommarito (28):
      xfrm: ah: use skb_to_full_sk in async output callbacks
      usbip: vudc: Fix use after free bug in vudc_remove due to race condition
      usb: gadget: f_fs: copy only received bytes on short ep0 read
      thunderbolt: property: Reject u32 wrap in tb_property_entry_valid()
      thunderbolt: property: Reject dir_len < 4 to prevent size_t underflow
      scsi: fcoe: Reject FIP descriptors with zero fip_dlen in CVL walker
      scsi: scsi_transport_fc: Widen FPIN pname walker counter to u32
      sctp: fix uninit-value in __sctp_rcv_asconf_lookup()
      Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
      RDMA/srp: bound SRP_RSP sense copy by the received length
      IB/isert: Reject login PDUs shorter than ISER_HEADERS_LEN
      thunderbolt: Reject zero-length property entries in validator
      thunderbolt: Bound root directory content to block size
      thunderbolt: Clamp XDomain response data copy to allocation size
      thunderbolt: Limit XDomain response copy to actual frame size
      smb: server: fix active_num_conn leak on transport allocation failure
      smb: client: require a full NFS mode SID before reading mode bits
      smb: client: fix OOB read in smb2_ioctl_query_info QUERY_INFO path
      ksmbd: require minimum ACE size in smb_check_perm_dacl()
      smb: client: validate the whole DACL before rewriting it in cifsacl
      xfrm: ah: account for ESN high bits in async callbacks
      smb: client: validate dacloffset before building DACL pointers
      smb: client: require net admin for CIFS SWN netlink
      Bluetooth: MGMT: validate Add Extended Advertising Data length
      net: hsr: defer node table free until after RCU readers
      thunderbolt: property: Cap recursion depth in __tb_property_parse_dir()
      scsi: target: iscsi: Bound iscsi_encode_text_output() appends to rsp_buf
      scsi: target: iscsi: Fix CRC overread and double-free in iscsit_handle_text_cmd()

Michael Kelley (1):
      drm/hyperv: Remove support for Hyper-V 2008 and 2008R2/Win7

Michal Kosiorek (1):
      xfrm: defensively unhash xfrm_state lists in __xfrm_state_delete

Michal Pecio (2):
      usb: core: Fix up Interrupt IN endpoints with bogus wBytesPerInterval
      usb: core: Fix SuperSpeed root hub wMaxPacketSize

Mikulas Patocka (1):
      hpfs: fix a crash if hpfs_map_dnode_bitmap fails

Mingyu Wang (3):
      i2c: dev: prevent integer overflow in I2C_TIMEOUT ioctl
      net: qrtr: fix refcount saturation and potential UAF in qrtr_port_remove
      fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync signaling

Minh Nguyen (1):
      net: skbuff: fix missing zerocopy reference in pskb_carve helpers

Muhammad Bilal (1):
      Bluetooth: HIDP: fix missing length checks in hidp_input_report()

Myeonghun Pak (1):
      serial: altera_jtaguart: handle uart_add_one_port() failures

Myrrh Periwinkle (1):
      usb: typec: ucsi: Check if power role change actually happened before handling

Nathan Chancellor (3):
      HID: core: Fix size_t specifier in hid_report_raw_event()
      compiler-clang.h: Add __diag infrastructure for clang
      Disable -Wattribute-alias for clang-23 and newer

Naveen Kumar Chaudhary (1):
      time: Fix off-by-one in settimeofday() usec validation

Nicolás Bazaes (1):
      Input: synaptics - add LEN2058 to SMBus passlist for ThinkPad E490

Oliver Hartkopp (1):
      bonding: refuse to enslave CAN devices

Oliver Neukum (3):
      media: rc: ttusbir: respect DMA coherency rules
      media: rc: igorplugusb: heed coherency rules
      media: rc: ttusbir: fix inverted error logic

Oscar Maes (1):
      pcnet32: stop holding device spin lock during napi_complete_done

Paolo Abeni (2):
      mptcp: fix retransmission loop when csum is enabled
      mptcp: close TOCTOU race while computing rcv_wnd

Pengpeng Hou (1):
      net/ipv6: ioam6: prevent schema length wraparound in trace fill

Peter Chen (2):
      usb: cdns3: plat: fix unbalanced pm_runtime_forbid() call permanently leaks the runtime PM usage counter across bind/unbind cycles
      usb: cdns3: plat: fix leaked usb2_phy initialization on usb3_phy acquisition failure

Petr Machata (1):
      selftests: forwarding: lib: Add helpers for checksum handling

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

Rodrigo Alencar (2):
      iio: dac: ad5686: fix input raw value check
      iio: dac: ad5686: fix ref bit initialization for single-channel parts

Ryan Roberts (1):
      randomize_kstack: Maintain kstack_offset per task

Safa Karakuş (1):
      Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()

Salah Triki (3):
      iio: dac: max5821: fix return value check in powerdown sync
      iio: adc: viperboard: Fix error handling in vprbrd_iio_read_raw
      iio: temperature: tsys01: fix broken PROM checksum validation

Sam Burkels (1):
      usb: storage: Add quirks for PNY Elite Portable SSD

Sam Daly (1):
      octeontx2-af: CGX: add bounds check to cgx_speed_mbps index

Sang-Heon Jeon (1):
      mm/hugetlb_cma: round up per_node before logging it

Sanghyun Park (1):
      xfrm: policy: fix use-after-free on inexact bin in xfrm_policy_bysel_ctx()

Sanjaikumar V S (1):
      mtd: spi-nor: sst: Fix write enable before AAI sequence

Sanjay Chitroda (1):
      iio: ssp_sensors: cancel delayed work_refresh on remove

Selvarasu Ganesan (1):
      usb: dwc3: Move GUID programming after PHY initialization

Seohyeon Maeng (1):
      udf: fix partition descriptor append bookkeeping

SeongJae Park (1):
      mm/damon/ops-common: call folio_test_lru() after folio_get()

SeungJu Cheon (1):
      Bluetooth: RFCOMM: validate skb length in MCC handlers

Seungjin Bae (1):
      usb: gadget: dummy_hcd: Reject hub port requests for non-existent ports

Shanker Donthineni (2):
      arm64: cputype: Add NVIDIA Olympus definitions
      arm64: errata: Mitigate TLBI errata on NVIDIA Olympus CPU

Shardul Bankar (1):
      mptcp: do not drop partial packets

Shawn Lin (1):
      mmc: sdhci-of-dwcmshc: Disable clock before DLL configuration

Shitalkumar Gandhi (1):
      serial: fsl_lpuart: fix rx buffer and DMA map leaks in start_rx_dma

Shuai Zhang (2):
      Bluetooth: btusb: Allow firmware re-download when version matches
      Bluetooth: hci_qca: Convert timeout from jiffies to ms

Shuvam Pandey (1):
      Bluetooth: hci_event: fix potential UAF in SSP passkey handlers

Siwei Zhang (2):
      Bluetooth: L2CAP: fix chan ref leak in l2cap_chan_timeout() on !conn
      Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()

Srinivas Kandagatla (3):
      ASoC: qcom: q6asm-dai: fix error handling in prepare and set_params
      ASoC: qcom: q6asm-dai: close stream only when running
      ASoC: qcom: q6asm-dai: do not set stream state in event and trigger callbacks

Stefan Metzmacher (1):
      smb: client: fix smbdirect_recv_io leak in smbd_negotiate() error path

Stephen J. Fuhry (1):
      USB: quirks: add NO_LPM for Lenovo ThinkPad USB-C Dock Gen2 hub controllers

Steven Rostedt (1):
      tracing/probes: Limit size of event probe to 3K

Suraj Kandpal (1):
      drm/dp: Add eDP 1.5 bit definition

Sven Eckelmann (13):
      batman-adv: v: stop OGMv2 on disabled interface
      batman-adv: tvlv: abort OGM send on tvlv append failure
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

Takashi Iwai (3):
      ALSA: timer: Fix UAF at snd_timer_user_params()
      ALSA: aoa: Use guard() for mutex locks
      ALSA: core: Fix potential data race at fasync handling

Tejas Bharambe (1):
      ext4: validate p_idx bounds in ext4_ext_correct_indexes

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

Tristan Madani (1):
      netfilter: nft_tunnel: fix use-after-free on object destroy

Tudor Ambarus (2):
      tty: serial: samsung: use u32 for register interactions
      tty: serial: samsung: Remove redundant port lock acquisition in rx helpers

Ulf Hansson (1):
      pmdomain: core: Fix detach procedure for virtual devices in genpd

Uwe Kleine-König (2):
      spi: spi-ti-qspi: Convert to platform remove callback returning void
      spi: topcliff-pch: Convert to platform remove callback returning void

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

Wanquan Zhong (1):
      USB: serial: option: add missing RSVD(5) flag for Rolling RW135R-GL

Wayne Chang (2):
      phy: tegra: xusb: Disable trk clk when not in use
      phy: tegra: xusb: Fix per-pad high-speed termination calibration

Wei-Cheng Chen (1):
      xhci: tegra: Fix ghost USB device on dual-role port unplug

Weiming Shi (4):
      tun: free page on short-frame rejection in tun_xdp_one()
      tap: free page on error paths in tap_get_user_xdp()
      tun: free page on build_skb failure in tun_xdp_one()
      net/rds: fix NULL deref in rds_ib_send_cqe_handler() on masked atomic completion

Will Deacon (1):
      arm64: errata: Mitigate TLBI errata on Microsoft Azure Cobalt 100 CPU

Wyatt Feng (2):
      xfrm: espintcp: do not reuse an in-progress partial send
      sctp: stream: fully roll back denied add-stream state

Xiang Mei (1):
      netfilter: nf_log: validate MAC header was set before dumping it

Xin Long (1):
      sctp: purge outqueue on stale COOKIE-ECHO handling

Xu Yang (1):
      usb: chipidea: core: convert ci_role_switch to local variable

Yang Yingliang (1):
      spi: qup: switch to use modern name

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

Yongpeng Yang (2):
      f2fs: fix UAF caused by decrementing sbi->nr_pages[] in f2fs_write_end_io()
      f2fs: fix incorrect file address mapping when inline inode is unwritten

Yuan Zhaoming (1):
      net: mctp: fix don't require received header reserved bits to be zero

Yuho Choi (1):
      ARM: socfpga: Fix OF node refcount leak in SMP setup

Yuqi Xu (2):
      bpf: sockmap: fix tail fragment offset in bpf_msg_push_data
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
      ipv6: exthdrs: refresh nh after handling HAO option
      xfrm: input: hold netns during deferred transport reinjection
      net: bridge: use a stable FDB dst snapshot in RCU readers
      netfilter: require Ethernet MAC header before using eth_hdr()

Zhenghang Xiao (2):
      Bluetooth: l2cap: clear chan->ident on ECRED reconfiguration success
      sctp: fix race between sctp_wait_for_connect and peeloff

Zilin Guan (1):
      hfsplus: fix held lock freed on hfsplus_fill_super()

