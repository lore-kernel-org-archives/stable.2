Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12DF364933;
	Fri, 19 Jun 2026 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781870387; cv=none; b=BcHhlIWZw8cNIGVsLhKTtwkmtPY48WhEuD5FXHWDhfOlDCu2vQltOhc+cTi+3gRKNcwDaytN61OBQtVI2TbXEmD3QqRAOyaFLt40/kPFjELffMzRuJbgVW1nWy/8XOUge+6Zgd05PZeCla76R+8So+rM4+qsZ+trWjYfvb+f8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781870387; c=relaxed/simple;
	bh=BvFTTljAPTHfQn/gEmj4g/Fiozac3vDTcNWG6ORtPQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cfvNhQPg5FQ4WC1v3bXfgWWptiMWGfUkGcBAfl8ejlIEDV6AHov2i5iSQYGkvQXEmxeVEWUWbf2/r/UqP990uGL+EB2ftARjiPfTSucH2UGsAcBaFzKgVKZRSJ6Vl6BpSbEFOLS946Yyrzkq2d0Q1hh25kr7TM013XDUjOdIwjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nrNkYrzv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nrNkYrzv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916E91F000E9;
	Fri, 19 Jun 2026 11:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781870384;
	bh=2kKtrE6ahlLdmCOWymauDziJTYgANt8b2HAkVInzqik=;
	h=From:To:Cc:Subject:Date;
	b=nrNkYrzvKKMwcnwyp2C6GiP6vmQ/OzdxH6qOaRnep6cZDAX+J4iMFqv9tCtfP7A0B
	 Agp5q2rHZkKgdd6h/pn3LRAv/80sk8QXKbsQPb5eTf59cqkvvjxmkAvqwHRZ0HYDLL
	 BQ48mFnqxSgI95Wn8IKqLCOrAgEyrbi+/53GGR+c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.259
Date: Fri, 19 Jun 2026 13:58:35 +0200
Message-ID: <2026061935-green-chute-b2a1@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.259 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arm64/silicon-errata.rst                    |   48 +
 Makefile                                                  |    2 
 arch/arm/mach-socfpga/platsmp.c                           |    1 
 arch/arm64/Kconfig                                        |   50 +
 arch/arm64/include/asm/cputype.h                          |   10 
 arch/arm64/include/asm/kvm_mmu.h                          |    4 
 arch/arm64/include/asm/tlb.h                              |    2 
 arch/arm64/include/asm/tlbflush.h                         |   55 +
 arch/arm64/kernel/cpu_errata.c                            |   34 -
 arch/arm64/kernel/sys_compat.c                            |    2 
 arch/arm64/kvm/hyp/nvhe/tlb.c                             |   41 -
 arch/arm64/kvm/hyp/vhe/tlb.c                              |   19 
 arch/arm64/mm/mmu.c                                       |   36 -
 arch/x86/kernel/cpu/amd.c                                 |   18 
 arch/x86/kernel/cpu/microcode/intel.c                     |    2 
 crypto/testmgr.c                                          |    4 
 drivers/acpi/power.c                                      |    2 
 drivers/acpi/scan.c                                       |    2 
 drivers/base/power/domain.c                               |   10 
 drivers/block/drbd/drbd_main.c                            |    2 
 drivers/block/drbd/drbd_receiver.c                        |    2 
 drivers/block/loop.c                                      |   14 
 drivers/block/nbd.c                                       |   10 
 drivers/bluetooth/btusb.c                                 |    8 
 drivers/bluetooth/hci_qca.c                               |   33 -
 drivers/char/random.c                                     |    4 
 drivers/crypto/caam/caamalg_qi2.c                         |    4 
 drivers/crypto/caam/caamhash.c                            |    4 
 drivers/fsi/fsi-sbefifo.c                                 |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |    5 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c        |    6 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c       |    3 
 drivers/gpu/drm/i915/gem/i915_gem_phys.c                  |   19 
 drivers/gpu/drm/imx/dcss/dcss-scaler.c                    |    3 
 drivers/gpu/drm/nouveau/nouveau_gem.c                     |    2 
 drivers/hid/hid-core.c                                    |   29 
 drivers/hid/hid-gfrm.c                                    |    4 
 drivers/hid/hid-logitech-hidpp.c                          |    2 
 drivers/hid/hid-multitouch.c                              |    2 
 drivers/hid/hid-primax.c                                  |    2 
 drivers/hid/hid-vivaldi.c                                 |    2 
 drivers/hid/wacom_sys.c                                   |   19 
 drivers/hid/wacom_wac.h                                   |    1 
 drivers/i2c/busses/i2c-qcom-cci.c                         |    2 
 drivers/i2c/busses/i2c-tegra.c                            |   53 -
 drivers/i2c/i2c-dev.c                                     |    9 
 drivers/iio/adc/npcm_adc.c                                |   26 
 drivers/iio/adc/viperboard_adc.c                          |    4 
 drivers/iio/adc/xilinx-xadc-core.c                        |   11 
 drivers/iio/buffer/industrialio-hw-consumer.c             |    4 
 drivers/iio/chemical/scd30_core.c                         |   65 --
 drivers/iio/common/ssp_sensors/ssp_dev.c                  |    1 
 drivers/iio/dac/ad5686.c                                  |    8 
 drivers/iio/dac/ad5686.h                                  |    1 
 drivers/iio/dac/max5821.c                                 |    9 
 drivers/iio/gyro/adis16260.c                              |    3 
 drivers/iio/gyro/itg3200_buffer.c                         |    2 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c            |    2 
 drivers/iio/light/cm3323.c                                |    5 
 drivers/iio/temperature/tsys01.c                          |    2 
 drivers/infiniband/core/Makefile                          |    2 
 drivers/infiniband/core/iter.c                            |   43 +
 drivers/infiniband/core/verbs.c                           |   37 -
 drivers/infiniband/hw/bnxt_re/qplib_res.c                 |    2 
 drivers/infiniband/hw/cxgb4/mem.c                         |    2 
 drivers/infiniband/hw/efa/efa_verbs.c                     |    2 
 drivers/infiniband/hw/hns/hns_roce_alloc.c                |    2 
 drivers/infiniband/hw/i40iw/i40iw_verbs.c                 |    1 
 drivers/infiniband/hw/mlx4/mr.c                           |    1 
 drivers/infiniband/hw/mlx5/mem.c                          |    1 
 drivers/infiniband/hw/mthca/mthca_provider.c              |    2 
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c               |    2 
 drivers/infiniband/hw/qedr/verbs.c                        |    2 
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h                 |    2 
 drivers/infiniband/sw/rxe/rxe_srq.c                       |    3 
 drivers/infiniband/ulp/isert/ib_isert.c                   |    6 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                    |    2 
 drivers/infiniband/ulp/srp/ib_srp.c                       |   30 
 drivers/input/keyboard/atkbd.c                            |   15 
 drivers/input/misc/ims-pcu.c                              |    2 
 drivers/input/mouse/elan_i2c_core.c                       |    5 
 drivers/input/mouse/synaptics.c                           |    1 
 drivers/input/touchscreen/atmel_mxt_ts.c                  |    2 
 drivers/input/touchscreen/usbtouchscreen.c                |    5 
 drivers/iommu/io-pgtable-arm-v7s.c                        |   18 
 drivers/isdn/mISDN/l1oip_core.c                           |    2 
 drivers/md/dm-cache-policy-smq.c                          |   12 
 drivers/md/persistent-data/dm-btree-remove.c              |    8 
 drivers/md/persistent-data/dm-btree.c                     |  451 +++++++++++++-
 drivers/md/persistent-data/dm-transaction-manager.c       |    9 
 drivers/md/persistent-data/dm-transaction-manager.h       |   10 
 drivers/media/rc/igorplugusb.c                            |   19 
 drivers/media/rc/ttusbir.c                                |   13 
 drivers/misc/fastrpc.c                                    |   75 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.c                   |    6 
 drivers/mmc/core/mmc.c                                    |    4 
 drivers/mmc/host/sdhci.c                                  |    1 
 drivers/mtd/spi-nor/sst.c                                 |   13 
 drivers/net/bonding/bond_main.c                           |   11 
 drivers/net/can/usb/ucan.c                                |    6 
 drivers/net/ethernet/amd/pcnet32.c                        |    4 
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c          |    2 
 drivers/net/ethernet/marvell/mv643xx_eth.c                |    2 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c           |    7 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c           |   20 
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h          |    1 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c  |    2 
 drivers/net/ethernet/microchip/lan743x_main.c             |   32 
 drivers/net/ethernet/microchip/lan743x_main.h             |    1 
 drivers/net/ethernet/qlogic/qed/qed_cxt.c                 |   26 
 drivers/net/hyperv/netvsc.c                               |   19 
 drivers/net/macsec.c                                      |    3 
 drivers/net/ppp/ppp_generic.c                             |    2 
 drivers/net/tap.c                                         |    2 
 drivers/net/team/team.c                                   |   23 
 drivers/net/tun.c                                         |    5 
 drivers/net/usb/usbnet.c                                  |    2 
 drivers/net/vxlan/vxlan_core.c                            |    4 
 drivers/net/wireguard/send.c                              |   20 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   |    4 
 drivers/net/wireless/marvell/mwifiex/init.c               |    2 
 drivers/nfc/nxp-nci/i2c.c                                 |   21 
 drivers/nvme/host/tcp.c                                   |    4 
 drivers/nvme/target/io-cmd-file.c                         |    4 
 drivers/nvme/target/tcp.c                                 |    2 
 drivers/parport/share.c                                   |   11 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                  |    2 
 drivers/phy/tegra/xusb-tegra186.c                         |   38 -
 drivers/phy/tegra/xusb.h                                  |    1 
 drivers/scsi/fcoe/fcoe_ctlr.c                             |    2 
 drivers/scsi/sg.c                                         |    2 
 drivers/spi/spi-lantiq-ssc.c                              |    8 
 drivers/spi/spi-meson-spicc.c                             |    2 
 drivers/spi/spi-qup.c                                     |  165 ++---
 drivers/spi/spi-st-ssc4.c                                 |    8 
 drivers/spi/spi-sun4i.c                                   |   10 
 drivers/spi/spi-sun6i.c                                   |   10 
 drivers/spi/spi-synquacer.c                               |    8 
 drivers/spi/spi-tegra114.c                                |    8 
 drivers/spi/spi-tegra20-sflash.c                          |    8 
 drivers/spi/spi-ti-qspi.c                                 |   11 
 drivers/spi/spi-topcliff-pch.c                            |    7 
 drivers/spi/spi-uniphier.c                                |    8 
 drivers/spi/spi-zynq-qspi.c                               |   15 
 drivers/staging/comedi/drivers/comedi_test.c              |    5 
 drivers/staging/greybus/hid.c                             |    2 
 drivers/target/iscsi/iscsi_target.c                       |    6 
 drivers/target/iscsi/iscsi_target_nego.c                  |    7 
 drivers/target/iscsi/iscsi_target_parameters.c            |   62 +
 drivers/target/iscsi/iscsi_target_parameters.h            |    2 
 drivers/target/iscsi/iscsi_target_util.c                  |    4 
 drivers/target/target_core_file.c                         |    2 
 drivers/tee/optee/supp.c                                  |  107 ++-
 drivers/thermal/thermal_core.c                            |    7 
 drivers/thunderbolt/property.c                            |   38 -
 drivers/thunderbolt/xdomain.c                             |    6 
 drivers/tty/serial/altera_jtaguart.c                      |   18 
 drivers/tty/serial/dz.c                                   |   58 +
 drivers/tty/serial/fsl_lpuart.c                           |   15 
 drivers/tty/serial/pch_uart.c                             |   19 
 drivers/tty/serial/qcom_geni_serial.c                     |   77 --
 drivers/tty/serial/samsung_tty.c                          |  103 +--
 drivers/tty/serial/sh-sci.c                               |    2 
 drivers/tty/serial/zs.c                                   |   40 -
 drivers/tty/serial/zs.h                                   |    2 
 drivers/usb/cdns3/gadget.c                                |   12 
 drivers/usb/chipidea/core.c                               |   16 
 drivers/usb/class/usbtmc.c                                |   14 
 drivers/usb/core/config.c                                 |    9 
 drivers/usb/core/hcd.c                                    |    4 
 drivers/usb/core/quirks.c                                 |    4 
 drivers/usb/dwc2/hcd.c                                    |    4 
 drivers/usb/dwc3/core.c                                   |   12 
 drivers/usb/gadget/function/f_hid.c                       |   20 
 drivers/usb/gadget/udc/dummy_hcd.c                        |    4 
 drivers/usb/gadget/udc/net2280.c                          |    4 
 drivers/usb/host/xhci-tegra.c                             |   78 +-
 drivers/usb/serial/belkin_sa.c                            |    3 
 drivers/usb/serial/cypress_m8.c                           |   20 
 drivers/usb/serial/digi_acceleport.c                      |   23 
 drivers/usb/serial/io_ti.c                                |   11 
 drivers/usb/serial/keyspan.c                              |    4 
 drivers/usb/serial/kl5kusb105.c                           |    4 
 drivers/usb/serial/mct_u232.c                             |   26 
 drivers/usb/serial/mxuport.c                              |    8 
 drivers/usb/serial/omninet.c                              |    9 
 drivers/usb/serial/option.c                               |   12 
 drivers/usb/serial/safe_serial.c                          |   11 
 drivers/usb/storage/unusual_uas.h                         |    7 
 drivers/usb/typec/altmodes/displayport.c                  |    2 
 drivers/usb/typec/tcpm/wcove.c                            |   13 
 drivers/usb/typec/ucsi/displayport.c                      |    4 
 drivers/usb/typec/ucsi/ucsi.c                             |   13 
 drivers/usb/typec/ucsi/ucsi_ccg.c                         |    5 
 drivers/usb/usbip/usbip_common.c                          |    2 
 drivers/usb/usbip/vudc_dev.c                              |    1 
 drivers/usb/usbip/vudc_transfer.c                         |    3 
 drivers/vhost/net.c                                       |    6 
 drivers/vhost/scsi.c                                      |   10 
 drivers/vhost/vhost.c                                     |    6 
 drivers/vhost/vringh.c                                    |    4 
 drivers/vhost/vsock.c                                     |    4 
 drivers/video/fbdev/core/fbcon_rotate.c                   |    5 
 drivers/video/fbdev/vt8500lcdfb.c                         |    2 
 drivers/xen/pvcalls-back.c                                |    8 
 fs/9p/vfs_addr.c                                          |    4 
 fs/9p/vfs_dir.c                                           |    2 
 fs/9p/xattr.c                                             |    4 
 fs/afs/cmservice.c                                        |    2 
 fs/afs/internal.h                                         |    4 
 fs/afs/rxrpc.c                                            |   12 
 fs/aio.c                                                  |    4 
 fs/btrfs/inode.c                                          |    2 
 fs/btrfs/ioctl.c                                          |    5 
 fs/ceph/dir.c                                             |    6 
 fs/ceph/file.c                                            |    4 
 fs/cifs/cifsacl.c                                         |    1 
 fs/cifs/connect.c                                         |    6 
 fs/cifs/file.c                                            |    4 
 fs/cifs/smb2ops.c                                         |   10 
 fs/cifs/smb2transport.c                                   |   36 -
 fs/cifs/smbdirect.c                                       |    4 
 fs/cifs/transport.c                                       |    6 
 fs/erofs/dir.c                                            |   30 
 fs/ext4/extents.c                                         |   15 
 fs/f2fs/data.c                                            |    4 
 fs/f2fs/inline.c                                          |   13 
 fs/fcntl.c                                                |    8 
 fs/fuse/dev.c                                             |    9 
 fs/hfsplus/bfind.c                                        |   51 +
 fs/hfsplus/catalog.c                                      |    4 
 fs/hfsplus/dir.c                                          |    2 
 fs/hfsplus/hfsplus_fs.h                                   |    9 
 fs/hfsplus/super.c                                        |    6 
 fs/hpfs/alloc.c                                           |    2 
 fs/nfsd/nfsctl.c                                          |    9 
 fs/nfsd/stats.c                                           |    4 
 fs/nfsd/stats.h                                           |    2 
 fs/nfsd/vfs.c                                             |    4 
 fs/ocfs2/cluster/tcp.c                                    |    2 
 fs/orangefs/inode.c                                       |    6 
 fs/read_write.c                                           |   12 
 fs/seq_file.c                                             |    2 
 fs/splice.c                                               |   10 
 fs/udf/super.c                                            |    4 
 include/linux/compat.h                                    |    4 
 include/linux/compiler-clang.h                            |   28 
 include/linux/compiler_attributes.h                       |   11 
 include/linux/compiler_types.h                            |    4 
 include/linux/hid.h                                       |   15 
 include/linux/parport.h                                   |    1 
 include/linux/printk.h                                    |   13 
 include/linux/syscalls.h                                  |    4 
 include/linux/uio.h                                       |    3 
 include/net/act_api.h                                     |    1 
 include/net/bluetooth/bluetooth.h                         |    3 
 include/net/bluetooth/hci_core.h                          |    2 
 include/net/bluetooth/l2cap.h                             |    1 
 include/net/ip_vs.h                                       |    3 
 include/net/netfilter/nf_queue.h                          |    1 
 include/net/sock.h                                        |    1 
 include/net/xfrm.h                                        |    3 
 include/rdma/ib_umem.h                                    |   23 
 include/rdma/ib_verbs.h                                   |   47 -
 include/rdma/iter.h                                       |   80 ++
 io_uring/io_uring.c                                       |    4 
 ipc/shm.c                                                 |   10 
 ipc/util.c                                                |    2 
 kernel/pid.c                                              |    8 
 kernel/sched/core.c                                       |    2 
 kernel/sched/rt.c                                         |    2 
 kernel/sched/sched.h                                      |    2 
 kernel/signal.c                                           |    1 
 kernel/time/time.c                                        |    2 
 kernel/trace/trace_probe.c                                |    5 
 kernel/trace/trace_probe.h                                |    4 
 kernel/tracepoint.c                                       |    2 
 lib/debugobjects.c                                        |    2 
 lib/mpi/mpicoder.c                                        |    2 
 mm/huge_memory.c                                          |    2 
 mm/hugetlb.c                                              |    1 
 mm/madvise.c                                              |    2 
 mm/page_io.c                                              |    2 
 mm/process_vm_access.c                                    |    2 
 net/6lowpan/iphc.c                                        |    4 
 net/802/garp.c                                            |    2 
 net/802/mrp.c                                             |    9 
 net/9p/client.c                                           |    2 
 net/batman-adv/bat_iv_ogm.c                               |   82 ++
 net/batman-adv/bat_v_ogm.c                                |   59 +
 net/batman-adv/bridge_loop_avoidance.c                    |   63 +
 net/batman-adv/distributed-arp-table.c                    |    3 
 net/batman-adv/gateway_client.c                           |    3 
 net/batman-adv/main.c                                     |    1 
 net/batman-adv/multicast.c                                |    9 
 net/batman-adv/originator.c                               |   12 
 net/batman-adv/soft-interface.c                           |    1 
 net/batman-adv/tp_meter.c                                 |  198 ++++--
 net/batman-adv/tp_meter.h                                 |    1 
 net/batman-adv/translation-table.c                        |   44 -
 net/batman-adv/tvlv.c                                     |   28 
 net/batman-adv/tvlv.h                                     |    2 
 net/batman-adv/types.h                                    |   56 +
 net/bluetooth/6lowpan.c                                   |    4 
 net/bluetooth/a2mp.c                                      |    2 
 net/bluetooth/af_bluetooth.c                              |  142 +++-
 net/bluetooth/bnep/sock.c                                 |   10 
 net/bluetooth/hci_core.c                                  |   34 -
 net/bluetooth/hci_event.c                                 |   18 
 net/bluetooth/hci_sock.c                                  |   10 
 net/bluetooth/hidp/sock.c                                 |   10 
 net/bluetooth/l2cap_core.c                                |   87 ++
 net/bluetooth/l2cap_sock.c                                |   86 +-
 net/bluetooth/mgmt.c                                      |   12 
 net/bluetooth/rfcomm/sock.c                               |   48 +
 net/bluetooth/sco.c                                       |   19 
 net/bluetooth/smp.c                                       |    2 
 net/bridge/br_arp_nd_proxy.c                              |    8 
 net/bridge/br_fdb.c                                       |   28 
 net/bridge/netfilter/ebt_snat.c                           |    3 
 net/bridge/netfilter/ebtables.c                           |   30 
 net/can/raw.c                                             |    8 
 net/core/dev.c                                            |    6 
 net/core/drop_monitor.c                                   |    6 
 net/core/dst.c                                            |    6 
 net/core/filter.c                                         |   17 
 net/core/neighbour.c                                      |   15 
 net/core/page_pool.c                                      |   39 +
 net/core/skbuff.c                                         |   10 
 net/ethtool/netlink.c                                     |    6 
 net/hsr/hsr_framereg.c                                    |    6 
 net/ieee802154/6lowpan/tx.c                               |    5 
 net/ieee802154/nl-phy.c                                   |    3 
 net/ieee802154/nl802154.c                                 |    3 
 net/ieee802154/socket.c                                   |    3 
 net/ipv4/ah4.c                                            |    2 
 net/ipv4/esp4.c                                           |    4 
 net/ipv4/fib_semantics.c                                  |    4 
 net/ipv4/ip_options.c                                     |    4 
 net/ipv4/ip_tunnel_core.c                                 |   22 
 net/ipv4/netfilter/arp_tables.c                           |   15 
 net/ipv4/netfilter/ip_tables.c                            |   15 
 net/ipv4/netfilter/nft_fib_ipv4.c                         |    2 
 net/ipv4/route.c                                          |    3 
 net/ipv4/sysctl_net_ipv4.c                                |    2 
 net/ipv4/tcp.c                                            |    2 
 net/ipv6/addrconf.c                                       |    6 
 net/ipv6/ah6.c                                            |    2 
 net/ipv6/datagram.c                                       |   54 +
 net/ipv6/esp6.c                                           |    4 
 net/ipv6/exthdrs.c                                        |    4 
 net/ipv6/ip6_vti.c                                        |   25 
 net/ipv6/ip6mr.c                                          |    3 
 net/ipv6/netfilter/ip6_tables.c                           |   15 
 net/ipv6/netfilter/nft_fib_ipv6.c                         |    2 
 net/ipv6/route.c                                          |    3 
 net/ipv6/sit.c                                            |    1 
 net/iucv/af_iucv.c                                        |   20 
 net/key/af_key.c                                          |    6 
 net/mac80211/tdls.c                                       |    2 
 net/mptcp/pm_netlink.c                                    |    8 
 net/mptcp/protocol.c                                      |   22 
 net/netfilter/ipvs/ip_vs_ctl.c                            |   13 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                     |   18 
 net/netfilter/ipvs/ip_vs_proto_tcp.c                      |   21 
 net/netfilter/ipvs/ip_vs_proto_udp.c                      |   20 
 net/netfilter/ipvs/ip_vs_sched.c                          |   14 
 net/netfilter/ipvs/ip_vs_sync.c                           |    2 
 net/netfilter/nf_conntrack_irc.c                          |    4 
 net/netfilter/nf_conntrack_proto_tcp.c                    |    3 
 net/netfilter/nf_queue.c                                  |   28 
 net/netfilter/nf_synproxy_core.c                          |   26 
 net/netfilter/nfnetlink_queue.c                           |    2 
 net/netfilter/nft_exthdr.c                                |    3 
 net/netfilter/nft_fib.c                                   |    6 
 net/netfilter/nft_tunnel.c                                |    2 
 net/netfilter/xt_NFQUEUE.c                                |    2 
 net/netfilter/xt_cpu.c                                    |    2 
 net/netlabel/netlabel_unlabeled.c                         |   36 -
 net/netlink/af_netlink.c                                  |   11 
 net/netrom/nr_loopback.c                                  |    3 
 net/netrom/nr_route.c                                     |    3 
 net/nfc/hci/core.c                                        |   10 
 net/nfc/llcp_core.c                                       |   11 
 net/nfc/llcp_sock.c                                       |   12 
 net/nfc/nci/hci.c                                         |   10 
 net/openvswitch/datapath.c                                |    1 
 net/packet/af_packet.c                                    |   40 -
 net/phonet/af_phonet.c                                    |    3 
 net/phonet/pn_dev.c                                       |    6 
 net/phonet/socket.c                                       |    3 
 net/qrtr/af_qrtr.c                                        |    4 
 net/qrtr/ns.c                                             |  180 ++---
 net/rds/ib_cm.c                                           |    1 
 net/rds/ib_send.c                                         |    2 
 net/rds/info.c                                            |    2 
 net/sched/act_api.c                                       |    7 
 net/sched/act_mirred.c                                    |    6 
 net/sched/cls_fw.c                                        |    6 
 net/sched/sch_sfb.c                                       |    2 
 net/sctp/diag.c                                           |   17 
 net/sctp/input.c                                          |    8 
 net/sctp/sm_statefuns.c                                   |    6 
 net/sctp/socket.c                                         |    2 
 net/sctp/stream.c                                         |    6 
 net/smc/af_smc.c                                          |    4 
 net/smc/smc_clc.c                                         |    6 
 net/smc/smc_pnet.c                                        |    3 
 net/socket.c                                              |   23 
 net/sunrpc/socklib.c                                      |    6 
 net/sunrpc/svcsock.c                                      |    4 
 net/sunrpc/xprtsock.c                                     |    6 
 net/tipc/topsrv.c                                         |    2 
 net/tls/tls_device.c                                      |    4 
 net/vmw_vsock/vmci_transport.c                            |    4 
 net/wireless/nl80211.c                                    |   16 
 net/wireless/scan.c                                       |    3 
 net/xfrm/espintcp.c                                       |    6 
 net/xfrm/xfrm_input.c                                     |   16 
 net/xfrm/xfrm_policy.c                                    |   15 
 net/xfrm/xfrm_state.c                                     |   23 
 net/xfrm/xfrm_user.c                                      |    5 
 security/apparmor/policy_unpack.c                         |   27 
 security/keys/keyctl.c                                    |    4 
 sound/aoa/codecs/onyx.c                                   |  104 ---
 sound/aoa/codecs/tas.c                                    |  113 +--
 sound/aoa/core/gpio-feature.c                             |   20 
 sound/aoa/core/gpio-pmf.c                                 |   26 
 sound/aoa/soundbus/i2sbus/core.c                          |    3 
 sound/aoa/soundbus/i2sbus/pcm.c                           |  143 ++--
 sound/core/misc.c                                         |   14 
 sound/core/pcm_native.c                                   |    7 
 sound/core/timer.c                                        |    1 
 sound/drivers/aloop.c                                     |   40 -
 sound/pci/hda/patch_hdmi.c                                |    1 
 sound/soc/intel/boards/bytcht_es8316.c                    |   29 
 sound/soc/qcom/qdsp6/q6asm-dai.c                          |   43 -
 sound/usb/clock.c                                         |    6 
 tools/testing/ktest/ktest.pl                              |  186 ++---
 tools/testing/selftests/net/forwarding/lib.sh             |   56 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh        |    6 
 441 files changed, 4418 insertions(+), 2359 deletions(-)

Aaron Erhardt (1):
      ALSA: hda/hdmi: Add quirk for TUXEDO IBS14G6

Adrian Korwel (2):
      USB: serial: io_ti: fix heap overflow in get_manuf_info()
      USB: serial: io_ti: fix heap overflow in build_i2c_fw_hdr()

Adrian Moreno (1):
      net: openvswitch: fix possible kfree_skb of ERR_PTR

Akhil R (1):
      i2c: tegra: Fix NOIRQ suspend/resume

Al Viro (1):
      use less confusing names for iov_iter direction initializers

Aldo Conte (1):
      iio: light: cm3323: fix reg_conf not being initialized correctly

Aleksandr Nogikh (1):
      signal: clear JOBCTL_PENDING_MASK for caller in zap_other_threads()

Alexandra Winter (1):
      net/smc: Do not re-initialize smc hashtables

Amirreza Zarrabi (1):
      tee: optee: prevent use-after-free when the client exits before the supplicant

Anandu Krishnan E (1):
      misc: fastrpc: fix use-after-free of fastrpc_user in workqueue context

Anshuman Khandual (1):
      arm64/mm: Enable batched TLB flush in unmap_hotplug_range()

Anton Leontev (1):
      hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf

Antoniu Miclaus (2):
      iio: chemical: scd30: fix division by zero in write_raw
      iio: gyro: adis16260: fix division by zero in write_raw

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

Bingquan Chen (1):
      net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()

Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Move the Zen3 BTC_NO detection to the Zen3 init function

Breno Leitao (2):
      net/iucv: fix locking in .getsockopt
      rds: mark snapshot pages dirty in rds_info_getsockopt()

Carl Lee (1):
      nfc: nxp-nci: i2c: use rising-edge IRQ on ACPI systems

Chengfeng Ye (1):
      ALSA: usb-audio: fix null pointer dereference on pointer cs_desc

Chenguang Zhao (1):
      netlabel: validate unlabeled address and mask attribute lengths

Chris Mason (1):
      netfilter: synproxy: refresh tcphdr after skb_ensure_writable

Christian Brauner (1):
      pidfd: refuse access to tasks that have started exiting harder

Christofer Jonason (1):
      iio: adc: xilinx-xadc: Fix sequencer mode in postdisable for dual mux

Christophe JAILLET (1):
      qed: Use the bitmap API to simplify some functions

Cryolitia PukNgae (1):
      Input: atkbd - skip deactivate for HONOR BCC-N's internal keyboard

Cássio Gabriel (3):
      ASoC: Intel: bytcht_es8316: Fix MCLK leak on init errors
      ALSA: aoa: i2sbus: clear stale prepared state
      ALSA: aloop: Fix peer runtime UAF during format-change stop

Dan Carpenter (1):
      usb: dwc2: Fix use after free in debug code

Daniel Hodges (1):
      wifi: mwifiex: fix use-after-free in mwifiex_adapter_cleanup()

David Ahern (1):
      xfrm: Check for underflow in xfrm_state_mtu

David Carlier (3):
      iio: gyro: itg3200: fix i2c read into the wrong stack location
      tracepoint: balance regfunc() on func_add() failure in tracepoint_add_func()
      iio: adc: npcm: fix unbalanced clk_disable_unprepare()

David Thompson (1):
      net: lan743x: permit VLAN-tagged packets up to configured MTU

Davide Caratti (1):
      net/sched: cls_fw: fix NULL dereference of "old" filters before change()

Davide Ornaghi (1):
      netfilter: nft_fib: fix stale stack leak via the OIFNAME register

Dawei Feng (2):
      qed: fix double free in qed_cxt_tables_alloc()
      octeontx2-pf: avoid double free of pool->stack on AQ init failure

Deepanshu Kartikey (2):
      wifi: mac80211: check tdls flag in ieee80211_tdls_oper
      hfsplus: fix uninit-value by validating catalog record size

Dmitry Torokhov (2):
      Input: elan_i2c - validate firmware size before use
      Input: atmel_mxt_ts - fix boundary check in mxt_prepare_cfg_mem

Dong Chenchen (1):
      page_pool: Fix use-after-free in page_pool_recycle_in_ring

Easwar Hariharan (1):
      arm64: Subscribe Microsoft Azure Cobalt 100 to ARM Neoverse N2 errata

Eric Dumazet (8):
      ipv4: free net->ipv4.sysctl_local_reserved_ports after unregister_net_sysctl_table()
      tunnels: load network headers after skb_cow() in iptunnel_pmtud_build_icmp[v6]()
      vxlan: do not reuse cached ip_hdr() value after skb_tunnel_check_pmtu()
      tunnels: do not assume transport header in iptunnel_pmtud_check_icmp()
      ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
      ieee802154: 6lowpan: only accept IPv6 packets in lowpan_xmit()
      bonding: limit BOND_MODE_8023AD to Ethernet devices
      ip6_vti: fix incorrect tunnel matching in vti6_tnl_lookup()

Felix Gu (2):
      iio: buffer: hw-consumer: fix use-after-free in error path
      spi: meson-spicc: Fix double-put in remove path

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

Greg Kroah-Hartman (8):
      Input: usbtouchscreen - clamp NEXIO data_len/x_len to URB buffer size
      iio: imu: st_lsm6dsx: fix stack leak in tagged FIFO buffer
      usb: typec: ucsi: ccg: reject firmware images without a ':' record header
      usb: typec: ucsi: displayport: NAK DP_CMD_CONFIGURE without a payload VDO
      usb: typec: altmodes/displayport: validate count before reading Status Update VDO
      usb: typec: wcove: don't write past struct pd_message in wcove_read_rx_buffer()
      drm/nouveau: fix u32 overflow in pushbuf reloc bounds check
      Linux 5.10.259

Guangshuo Li (4):
      usb: gadget: net2280: Fix double free in probe error path
      dm cache policy smq: check allocation under invalidate lock
      ACPI: scan: Use acpi_dev_put() in object add error paths
      usb: gadget: f_hid: fix device reference leak in hidg_alloc()

Hamza Mahfooz (1):
      netfilter: conntrack: tcp: do not force CLOSE on invalid-seq RST without direction check

Haoze Xie (1):
      netfilter: nf_queue: hold bridge skb->dev while queued

Hariprasad Kelam (1):
      octeontx2-af: Add validation for lmac type

Harry Wentland (3):
      drm/amd/display: Reject gpio_bitshift >= 32 in bios_parser_get_gpio_pin_info()
      drm/amd/display: Clamp HDMI HDCP2 rx_id_list read to buffer size
      drm/amd/display: Fix NULL deref and buffer over-read in SDP debugfs

Heitor Alves de Siqueira (2):
      usb: usbtmc: check URB actual_length for interrupt-IN notifications
      usb: usbtmc: reject interrupt endpoints with small wMaxPacketSize

Henri A (1):
      media: rc: igorplugusb: fix control request setup packet

Hongling Zeng (1):
      serial: sh-sci: fix memory region release in error path

HyeongJun An (1):
      USB: serial: kl5kusb105: fix bulk-out buffer overflow

Ian Abbott (2):
      comedi: comedi_test: fix check for valid scan_begin_src in waveform_ai_cmdtest()
      comedi: comedi_test: Fix limiting of convert_arg in waveform_ai_cmdtest()

Ilya Maximets (2):
      net: netlink: fix sending unassigned nsid after assigned one
      net: netlink: don't set nsid on local notifications

Jack Wu (1):
      USB: serial: option: add usb-id for Dell Wireless DW5826e-m

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

Jeff Layton (1):
      nfsd: don't ignore the return code of svc_proc_register()

Ji'an Zhou (1):
      ALSA: PCM: Fix wait queue list corruption in snd_pcm_drain() on linked streams

Jiasheng Jiang (1):
      RDMA/rxe: Fix double free in rxe_srq_from_init

Jiexun Wang (2):
      batman-adv: stop tp_meter sessions during mesh teardown
      Bluetooth: serialize accept_q access

Jingguo Tan (1):
      xfrm: esp: restore combined single-frag length gate

Jisheng Zhang (1):
      mmc: sdhci: add signal voltage switch in sdhci_resume_host

Joe Thornber (1):
      dm btree: improve btree residency

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
      spi: tegra20-sflash: fix controller deregistration
      spi: tegra114: fix controller deregistration
      spi: uniphier: fix controller deregistration
      spi: topcliff-pch: fix controller deregistration
      spi: st-ssc4: fix controller deregistration
      spi: lantiq-ssc: fix controller deregistration
      spi: qup: fix error pointer deref after DMA setup failure

John 'Warthog9' Hawley (VMware) (1):
      ktest: Fixing indentation to match expected pattern

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

Julia Lawall (1):
      can: ucan: fix typos in comments

Julian Anastasov (2):
      ipvs: clear the svc scheduler ptr early on edit
      ipvs: skip ipv6 extension headers for csum checks

Junrui Luo (1):
      macsec: fix replay protection at XPN lower-PN wrap

Justin Iurman (1):
      ipv6: exthdrs: refresh nh pointer after ipv6_hop_jumbo()

Justin Stitt (1):
      octeontx2-af: replace deprecated strncpy with strscpy

Kamal Dasu (1):
      mmc: core: Fix host controller programming for fixed driver type

Krzysztof Kozlowski (1):
      nfc: llcp: protect nfc_llcp_sock_unlink() calls

Kuniyuki Iwashima (3):
      ip6: vti: Use ip6_tnl.net in vti6_changelink().
      Bluetooth: hci_core: Fix use-after-free in vhci_flush()
      bpf: Free reuseport cBPF prog after RCU grace period.

Kyle Zeng (3):
      ipv6: sit: reload inner IPv6 header after GSO offloads
      net: guard timestamp cmsgs to real error queue skbs
      netfilter: x_tables: avoid leaking percpu counter pointers

Lad Prabhakar (1):
      serial: altera_jtaguart: Use platform_get_irq_optional() to get the interrupt

Lee Jones (3):
      nfc: llcp: Fix use-after-free in llcp_sock_release()
      nfc: llcp: Fix use-after-free race in nfc_llcp_recv_cc()
      HID: wacom: Fix OOB write in wacom_hid_set_device_mode()

Leon Romanovsky (1):
      RDMA: Move DMA block iterator logic into dedicated files

Linpu Yu (1):
      ipc: limit next_id allocation to the valid ID range

Longxuan Yu (1):
      io_uring/poll: fix signed comparison in io_poll_get_ownership()

Luiz Augusto von Dentz (3):
      Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
      Bluetooth: Consolidate code around sk_alloc into a helper function
      Bluetooth: Init sk_peer_* on bt_sock_alloc

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

Marek Szyprowski (1):
      wifi: brcmfmac: Fix potential use-after-free issue when stopping watchdog task

Mark Rutland (5):
      arm64: tlb: Allow XZR argument to TLBI ops
      arm64: tlb: Optimize ARM64_WORKAROUND_REPEAT_TLBI
      arm64: cputype: Add C1-Ultra definitions
      arm64: cputype: Add C1-Premium definitions
      arm64: errata: Mitigate TLBI errata on various Arm CPUs

Matthieu Baerts (NGI0) (2):
      mptcp: pm: ADD_ADDR rtx: fix potential data-race
      selftests: mptcp: drop nanoseconds width specifier

Max Kellermann (1):
      ceph: only d_add() negative dentries when they are unhashed

Michael Bommarito (19):
      xfrm: ah: use skb_to_full_sk in async output callbacks
      usbip: vudc: Fix use after free bug in vudc_remove due to race condition
      thunderbolt: property: Reject u32 wrap in tb_property_entry_valid()
      thunderbolt: property: Reject dir_len < 4 to prevent size_t underflow
      scsi: fcoe: Reject FIP descriptors with zero fip_dlen in CVL walker
      sctp: fix uninit-value in __sctp_rcv_asconf_lookup()
      Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
      RDMA/srp: bound SRP_RSP sense copy by the received length
      IB/isert: Reject login PDUs shorter than ISER_HEADERS_LEN
      thunderbolt: Reject zero-length property entries in validator
      thunderbolt: Bound root directory content to block size
      thunderbolt: Clamp XDomain response data copy to allocation size
      thunderbolt: Limit XDomain response copy to actual frame size
      smb: client: require a full NFS mode SID before reading mode bits
      smb: client: fix OOB read in smb2_ioctl_query_info QUERY_INFO path
      net: hsr: defer node table free until after RCU readers
      scsi: target: iscsi: Bound iscsi_encode_text_output() appends to rsp_buf
      thunderbolt: property: Cap recursion depth in __tb_property_parse_dir()
      scsi: target: iscsi: Fix CRC overread and double-free in iscsit_handle_text_cmd()

Michal Pecio (2):
      usb: core: Fix up Interrupt IN endpoints with bogus wBytesPerInterval
      usb: core: Fix SuperSpeed root hub wMaxPacketSize

Mikulas Patocka (2):
      hpfs: fix a crash if hpfs_map_dnode_bitmap fails
      dm-thin: fix metadata refcount underflow

Mingyu Wang (3):
      i2c: dev: prevent integer overflow in I2C_TIMEOUT ioctl
      net: qrtr: fix refcount saturation and potential UAF in qrtr_port_remove
      fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync signaling

Minh Nguyen (1):
      net: skbuff: fix missing zerocopy reference in pskb_carve helpers

Myeonghun Pak (1):
      serial: altera_jtaguart: handle uart_add_one_port() failures

Myrrh Periwinkle (2):
      usb: typec: ucsi: Check if power role change actually happened before handling
      usb: typec: ucsi: Don't update power_supply on power role change if not connected

Nathan Chancellor (3):
      HID: core: Fix size_t specifier in hid_report_raw_event()
      compiler-clang.h: Add __diag infrastructure for clang
      Disable -Wattribute-alias for clang-23 and newer

Naveen Kumar Chaudhary (1):
      time: Fix off-by-one in settimeofday() usec validation

Nicolás Bazaes (1):
      Input: synaptics - add LEN2058 to SMBus passlist for ThinkPad E490

Nikola Z. Ivanov (1):
      team: Move team device type change at the end of team_port_add

Nobuhiro Iwamatsu (1):
      phy: renesas: rcar-gen3-usb2: Fix the use of msleep during spinlock

Oliver Neukum (3):
      media: rc: ttusbir: respect DMA coherency rules
      media: rc: igorplugusb: heed coherency rules
      media: rc: ttusbir: fix inverted error logic

Oscar Maes (1):
      pcnet32: stop holding device spin lock during napi_complete_done

Pavel Begunkov (1):
      io_uring: prevent opcode speculation

Petr Machata (1):
      selftests: forwarding: lib: Add helpers for checksum handling

Piyush Sachdeva (1):
      smb: client: Use FullSessionKey for AES-256 encryption key derivation

Prasanna S (1):
      serial: qcom-geni: fix UART_RX_PAR_EN bit position

Qi Tang (1):
      ipv6: validate extension header length before copying to cmsg

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

Steven Rostedt (2):
      ktest: Fix the month in the name of the failure directory
      tracing/probes: Limit size of event probe to 3K

Sven Eckelmann (11):
      batman-adv: v: stop OGMv2 on disabled interface
      batman-adv: tvlv: abort OGM send on tvlv append failure
      batman-adv: bla: avoid NULL-ptr deref for claim via dropped interface
      batman-adv: tvlv: reject oversized TVLV packets
      batman-adv: iv: recover OGM scheduling after forward packet error
      batman-adv: tp_meter: fix race condition in send error reporting
      batman-adv: tp_meter: avoid role confusion in tp_list
      batman-adv: tt: fix TOCTOU race for reported vlans
      batman-adv: tt: avoid empty VLAN responses
      batman-adv: bla: avoid double decrement of bla.num_requests
      batman-adv: tp_meter: fix tp_num leak on kmalloc failure

Takashi Iwai (3):
      ALSA: timer: Fix UAF at snd_timer_user_params()
      ALSA: aoa: Use guard() for mutex locks
      ALSA: core: Fix potential data race at fasync handling

Tejas Bharambe (1):
      ext4: validate p_idx bounds in ext4_ext_correct_indexes

Thomas Fourier (1):
      Input: ims-pcu - fix usb_free_coherent() size in ims_pcu_buffers_free()

Thomas Gleixner (1):
      serial: samsung_tty: Use port lock wrappers

Thomas Zimmermann (1):
      fbcon: Avoid OOB font access if console rotation fails

Thorsten Blum (3):
      ALSA: aoa: Skip devices with no codecs in i2sbus_resume()
      printk: add print_hex_dump_devel()
      crypto: caam - guard HMAC key hex dumps in hash_digest_key

Til Kaiser (1):
      net: mvpp2: sync RX data at the hardware packet offset

Tristan Madani (1):
      netfilter: nft_tunnel: fix use-after-free on object destroy

Tudor Ambarus (2):
      tty: serial: samsung: use u32 for register interactions
      tty: serial: samsung: Remove redundant port lock acquisition in rx helpers

Ulf Hansson (1):
      pmdomain: core: Fix detach procedure for virtual devices in genpd

Vicki Pfau (1):
      HID: core: Add printk_ratelimited variants to hid_warn() etc

Victor Nogueria (1):
      net/sched: sch_sfb: Replace direct dequeue call with peek and qdisc_dequeue_peeked

Vignesh Viswanathan (1):
      net: qrtr: ns: Change servers radix tree to xarray

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

Xin Long (1):
      sctp: purge outqueue on stale COOKIE-ECHO handling

Xu Yang (1):
      usb: chipidea: core: convert ci_role_switch to local variable

Yajun Deng (1):
      net: Remove redundant if statements

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

Yuho Choi (1):
      ARM: socfpga: Fix OF node refcount leak in SMP setup

Yuqi Xu (2):
      bpf: sockmap: fix tail fragment offset in bpf_msg_push_data
      net: rds: clear i_sends on setup unwind

Zeng Heng (1):
      arm64: tlb: Flush walk cache when unsharing PMD tables

Zeyu WANG (1):
      Input: atkbd - add DMI quirk for Lenovo Yoga Air 14 (83QK)

Zhang Cen (4):
      USB: serial: belkin_sa: validate interrupt status length
      USB: serial: cypress_m8: validate interrupt packet headers
      Bluetooth: RFCOMM: hold listener socket in rfcomm_connect_ind()
      Bluetooth: MGMT: validate advertising TLV before type checks

Zhao Dongdong (1):
      Bluetooth: 6lowpan: check skb_clone() return value in send_mcast_pkt()

Zhao Zhang (1):
      sctp: diag: reject stale associations in dump_one path

ZhaoJinming (1):
      net: bonding: fix NULL pointer dereference in bond_do_ioctl()

Zhaoyang Yu (1):
      tty: serial: pch_uart: add check for dma_alloc_coherent()

Zhengchuan Liang (2):
      net: bridge: use a stable FDB dst snapshot in RCU readers
      xfrm: input: hold netns during deferred transport reinjection

Zhenghang Xiao (2):
      Bluetooth: l2cap: clear chan->ident on ECRED reconfiguration success
      sctp: fix race between sctp_wait_for_connect and peeloff

Zilin Guan (1):
      hfsplus: fix held lock freed on hfsplus_fill_super()

Zqiang (1):
      usbnet: Fix using smp_processor_id() in preemptible code warnings

