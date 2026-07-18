Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413F65733E;
	Sat, 18 Jul 2026 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784386871; cv=none; b=HAxyfc5zFqHYsHG5f5XRUvzSSMDQNAoo7/KYASPKWXmCZEJIzh8z3Q9TCr5zCVzLCAwpBXgENpAshI7g1sl6LYAomRr4Xd6RHUsAhT1e+SwyIlnOSk36Ke//7dYm51ff75JtCyhY+h7tAawaP8zqpck0dO+cBUQssWn1DeGDPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784386871; c=relaxed/simple;
	bh=qy/PE4dYK63SlY81KlC1JqyKQVKqieJ1+7RbI9a9vLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VJNjFoiA061xHw3FpfD3yoWd/umL4RYsTmEhDk9s4IUqQW9JuiGaTAdZlmzAed6UMdNBRwsp+XeVCJuKB3BfTssYdAttk3zF8BSXK5vhrL4E8MqppK/rUhv8VfxT4Bzu9EWHkqt2iybnS44llBj85tgZZVDPq6bwVtU5aY6y1vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yqfzpUzy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yqfzpUzy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0029F1F000E9;
	Sat, 18 Jul 2026 15:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784386868;
	bh=CpOW//N+YmmXgr1ORGTVrrNwWGIDYjXhQFs/dFMB1cs=;
	h=From:To:Cc:Subject:Date;
	b=yqfzpUzyb5s9eMx7JGLClNM+H4ECYD2dJAphZXr+t4Cn3Bp4KbgSBorvtyiSuKsYl
	 T1YYquNyUJFx8MYn3IZk49sZyRkYL7kGl8cKZvwgJGM5nzgSDVXci9yfPOTvWBTlEW
	 qfkhZKk66Tb+2nx5IzZ6bcty/emrJl0IODitXvLU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.96
Date: Sat, 18 Jul 2026 17:00:58 +0200
Message-ID: <2026071859-factoid-neon-8f07@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.96 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/crypto/userspace-if.rst                |   31 -
 Makefile                                             |    5 
 arch/arm64/kernel/entry-fpsimd.S                     |    8 
 arch/arm64/lib/insn.c                                |    2 
 arch/loongarch/include/asm/acpi.h                    |    2 
 arch/loongarch/kernel/acpi.c                         |   28 
 arch/loongarch/kernel/setup.c                        |    2 
 arch/loongarch/pci/acpi.c                            |    2 
 arch/riscv/kernel/entry.S                            |    7 
 arch/x86/kernel/cpu/resctrl/monitor.c                |   47 +
 arch/x86/kvm/svm/svm.c                               |    3 
 arch/x86/kvm/vmx/vmx.c                               |   41 -
 arch/x86/kvm/x86.c                                   |    3 
 block/bdev.c                                         |    8 
 block/blk-sysfs.c                                    |  108 +--
 block/partitions/aix.c                               |    9 
 crypto/af_alg.c                                      |   73 --
 crypto/algif_aead.c                                  |    8 
 crypto/asymmetric_keys/x509_loader.c                 |    2 
 crypto/drbg.c                                        |    4 
 crypto/ecc.c                                         |   31 -
 crypto/pcrypt.c                                      |    4 
 drivers/acpi/cppc_acpi.c                             |   11 
 drivers/acpi/nfit/core.c                             |    3 
 drivers/android/binder.c                             |   19 
 drivers/base/firmware_loader/sysfs_upload.c          |    8 
 drivers/bluetooth/btmtksdio.c                        |    2 
 drivers/bluetooth/btnxpuart.c                        |    6 
 drivers/bluetooth/btusb.c                            |   39 +
 drivers/bluetooth/hci_ldisc.c                        |   14 
 drivers/char/hw_random/jh7110-trng.c                 |   13 
 drivers/char/hw_random/virtio-rng.c                  |   23 
 drivers/clocksource/timer-tegra186.c                 |    3 
 drivers/cpufreq/cpufreq.c                            |    2 
 drivers/cpufreq/intel_pstate.c                       |    6 
 drivers/cpufreq/pcc-cpufreq.c                        |    2 
 drivers/cpufreq/qcom-cpufreq-hw.c                    |    1 
 drivers/crypto/amlogic/amlogic-gxl-core.c            |    2 
 drivers/crypto/caam/caamalg.c                        |   12 
 drivers/crypto/caam/caamalg_qi.c                     |   12 
 drivers/crypto/caam/caamalg_qi2.c                    |   12 
 drivers/crypto/caam/caamhash.c                       |    4 
 drivers/crypto/caam/key_gen.c                        |    4 
 drivers/crypto/ccp/sev-dev.c                         |   37 -
 drivers/crypto/intel/qat/qat_common/adf_aer.c        |    4 
 drivers/crypto/intel/qat/qat_common/adf_init.c       |   16 
 drivers/crypto/intel/qat/qat_common/adf_sriov.c      |   12 
 drivers/crypto/intel/qat/qat_common/qat_asym_algs.c  |   10 
 drivers/crypto/talitos.c                             |  549 +++++++++----------
 drivers/crypto/talitos.h                             |   12 
 drivers/crypto/tegra/tegra-se-main.c                 |    2 
 drivers/dma-buf/udmabuf.c                            |    9 
 drivers/edac/i10nm_base.c                            |   14 
 drivers/gpio/gpio-eic-sprd.c                         |    8 
 drivers/gpio/gpio-rockchip.c                         |   31 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c             |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h              |    6 
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c         |    9 
 drivers/gpu/drm/i915/i915_mm.c                       |    4 
 drivers/hid/hid-goodix-spi.c                         |    3 
 drivers/hid/hid-letsketch.c                          |   36 +
 drivers/hid/hid-lg-g15.c                             |   16 
 drivers/hid/hid-sensor-hub.c                         |   77 ++
 drivers/hid/wacom_sys.c                              |   12 
 drivers/hwtracing/coresight/coresight-etb10.c        |    6 
 drivers/hwtracing/coresight/ultrasoc-smb.c           |    1 
 drivers/i2c/busses/i2c-mpc.c                         |    2 
 drivers/i2c/busses/i2c-stm32f7.c                     |    9 
 drivers/i2c/i2c-core-base.c                          |   81 +-
 drivers/iio/accel/bmc150-accel-core.c                |    2 
 drivers/iio/accel/kxsd9.c                            |    5 
 drivers/iio/adc/lpc32xx_adc.c                        |    4 
 drivers/iio/adc/spear_adc.c                          |    3 
 drivers/iio/adc/ti-ads1119.c                         |    6 
 drivers/iio/adc/ti-ads124s08.c                       |    3 
 drivers/iio/chemical/scd30_core.c                    |   19 
 drivers/iio/common/st_sensors/st_sensors_core.c      |   23 
 drivers/iio/gyro/bmg160_core.c                       |   16 
 drivers/iio/imu/adis_trigger.c                       |    2 
 drivers/iio/imu/bmi160/bmi160_core.c                 |    3 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c    |    4 
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c   |    9 
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h   |    1 
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c     |    4 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c         |   21 
 drivers/iio/industrialio-backend.c                   |    2 
 drivers/iio/industrialio-event.c                     |    5 
 drivers/iio/light/al3010.c                           |    2 
 drivers/iio/light/gp2ap002.c                         |    2 
 drivers/iio/light/opt3001.c                          |    6 
 drivers/iio/light/tsl2591.c                          |    6 
 drivers/iio/light/veml6030.c                         |    8 
 drivers/iio/magnetometer/ak8975.c                    |    1 
 drivers/iio/resolver/ad2s1210.c                      |    2 
 drivers/iio/temperature/Makefile                     |    2 
 drivers/iio/temperature/ltc2983.c                    |    5 
 drivers/infiniband/sw/siw/siw_qp_rx.c                |    9 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c               |    5 
 drivers/input/joystick/iforce/iforce-packets.c       |   18 
 drivers/input/joystick/maplecontrol.c                |    3 
 drivers/input/keyboard/maple_keyb.c                  |    4 
 drivers/input/mouse/elan_i2c_core.c                  |   36 +
 drivers/input/mouse/maplemouse.c                     |    9 
 drivers/input/rmi4/rmi_bus.c                         |    4 
 drivers/input/rmi4/rmi_f30.c                         |    2 
 drivers/input/rmi4/rmi_f3a.c                         |    2 
 drivers/input/touchscreen/goodix.c                   |    3 
 drivers/input/touchscreen/mms114.c                   |   26 
 drivers/input/touchscreen/touchwin.c                 |   15 
 drivers/iommu/amd/iommu.c                            |    3 
 drivers/iommu/iommufd/hw_pagetable.c                 |   11 
 drivers/md/dm-ioctl.c                                |    5 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c |    3 
 drivers/mfd/cros_ec_dev.c                            |    3 
 drivers/net/bonding/bond_main.c                      |    2 
 drivers/net/bonding/bond_netlink.c                   |   16 
 drivers/net/usb/kalmia.c                             |    8 
 drivers/ntb/hw/epf/ntb_hw_epf.c                      |   14 
 drivers/nvme/host/multipath.c                        |    6 
 drivers/nvme/target/discovery.c                      |   23 
 drivers/nvme/target/fabrics-cmd-auth.c               |   15 
 drivers/nvme/target/rdma.c                           |    6 
 drivers/opp/of.c                                     |    3 
 drivers/pci/controller/dwc/pci-imx6.c                |   12 
 drivers/pci/controller/pci-host-common.c             |    4 
 drivers/pci/controller/pci-loongson.c                |   36 +
 drivers/pci/controller/pcie-altera.c                 |    1 
 drivers/pci/quirks.c                                 |   51 -
 drivers/perf/arm-cmn.c                               |   23 
 drivers/platform/x86/intel/hid.c                     |    9 
 drivers/regulator/scmi-regulator.c                   |    4 
 drivers/spi/spi-fsl-lpspi.c                          |   18 
 drivers/staging/media/atomisp/pci/sh_css.c           |    6 
 drivers/staging/media/ipu3/ipu3-css-params.c         |    8 
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c        |   20 
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c       |   23 
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c    |    8 
 drivers/staging/vme_user/vme_fake.c                  |    8 
 drivers/staging/vme_user/vme_tsi148.c                |    8 
 drivers/staging/vme_user/vme_user.c                  |   22 
 drivers/tty/serial/8250/8250_mid.c                   |   13 
 drivers/usb/cdns3/cdnsp-mem.c                        |    2 
 drivers/usb/class/cdc-acm.c                          |    3 
 drivers/usb/common/ulpi.c                            |   23 
 drivers/usb/core/quirks.c                            |    6 
 drivers/usb/dwc3/dwc3-meson-g12a.c                   |   14 
 drivers/usb/dwc3/gadget.c                            |   43 +
 drivers/usb/fotg210/fotg210-hcd.c                    |    6 
 drivers/usb/gadget/composite.c                       |    5 
 drivers/usb/gadget/function/f_fs.c                   |    3 
 drivers/usb/gadget/function/f_printer.c              |    3 
 drivers/usb/gadget/function/rndis.c                  |   20 
 drivers/usb/gadget/udc/core.c                        |   29 -
 drivers/usb/host/ehci-sched.c                        |   11 
 drivers/usb/host/sl811-hcd.c                         |    1 
 drivers/usb/host/xhci.c                              |   11 
 drivers/usb/misc/chaoskey.c                          |    1 
 drivers/usb/misc/idmouse.c                           |   45 -
 drivers/usb/misc/iowarrior.c                         |    4 
 drivers/usb/misc/ldusb.c                             |   38 -
 drivers/usb/misc/legousbtower.c                      |   37 -
 drivers/usb/misc/uss720.c                            |    5 
 drivers/usb/mtu3/mtu3_gadget.c                       |    1 
 drivers/usb/serial/digi_acceleport.c                 |   43 +
 drivers/usb/serial/keyspan_pda.c                     |    2 
 drivers/usb/serial/option.c                          |   16 
 drivers/usb/storage/ene_ub6250.c                     |    3 
 drivers/usb/storage/usb.c                            |    2 
 drivers/usb/typec/anx7411.c                          |    4 
 drivers/usb/typec/class.c                            |    1 
 drivers/usb/typec/tcpm/tcpci_rt1711h.c               |   13 
 drivers/usb/typec/tcpm/tcpm.c                        |    9 
 drivers/usb/typec/ucsi/displayport.c                 |    7 
 drivers/usb/typec/ucsi/ucsi.c                        |   20 
 drivers/usb/typec/ucsi/ucsi.h                        |    1 
 drivers/usb/typec/ucsi/ucsi_acpi.c                   |   10 
 drivers/usb/typec/ucsi/ucsi_ccg.c                    |    2 
 drivers/usb/usbip/vudc.h                             |    1 
 drivers/usb/usbip/vudc_dev.c                         |    4 
 drivers/vfio/debugfs.c                               |    1 
 drivers/vfio/pci/vfio_pci_core.c                     |   37 -
 drivers/vfio/vfio_main.c                             |   11 
 drivers/video/fbdev/core/fbcon.c                     |    7 
 drivers/virtio/virtio_mmio.c                         |   26 
 drivers/virtio/virtio_pci_common.c                   |   10 
 drivers/watchdog/apple_wdt.c                         |    1 
 fs/bcachefs/fs.c                                     |    8 
 fs/btrfs/extent-tree.c                               |   12 
 fs/exfat/dir.c                                       |   13 
 fs/f2fs/checkpoint.c                                 |   14 
 fs/f2fs/data.c                                       |   29 +
 fs/f2fs/f2fs.h                                       |    1 
 fs/f2fs/gc.c                                         |   50 +
 fs/f2fs/inode.c                                      |   30 -
 fs/f2fs/segment.c                                    |    8 
 fs/f2fs/xattr.c                                      |    6 
 fs/fs-writeback.c                                    |   31 +
 fs/fuse/cuse.c                                       |    4 
 fs/fuse/dev.c                                        |   11 
 fs/hfs/bnode.c                                       |    2 
 fs/hfsplus/bnode.c                                   |    2 
 fs/isofs/rock.c                                      |   11 
 fs/nfs/dir.c                                         |    2 
 fs/nfs/flexfilelayout/flexfilelayout.c               |  153 +++--
 fs/nfs/flexfilelayout/flexfilelayout.h               |   27 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c            |   54 -
 fs/nfs/localio.c                                     |    2 
 fs/nfs_common/nfslocalio.c                           |    8 
 fs/nfsd/localio.c                                    |    2 
 fs/nfsd/nfs4layouts.c                                |    4 
 fs/nfsd/nfs4recover.c                                |  118 +---
 fs/nfsd/nfs4state.c                                  |   35 -
 fs/nfsd/nfsctl.c                                     |    4 
 fs/nilfs2/segment.c                                  |   22 
 fs/ntfs3/attrib.c                                    |   14 
 fs/ntfs3/dir.c                                       |    2 
 fs/ntfs3/file.c                                      |   30 -
 fs/ntfs3/frecord.c                                   |   59 +-
 fs/ntfs3/fslog.c                                     |   20 
 fs/ntfs3/inode.c                                     |   10 
 fs/ntfs3/ntfs_fs.h                                   |    4 
 fs/smb/client/cifsacl.c                              |    2 
 fs/smb/client/file.c                                 |    2 
 fs/smb/client/smb2misc.c                             |   52 +
 fs/smb/client/smb2ops.c                              |   18 
 fs/smb/client/smb2pdu.c                              |   22 
 fs/smb/server/smb2pdu.c                              |   95 ++-
 fs/smb/server/vfs.c                                  |   18 
 fs/smb/server/vfs_cache.c                            |    5 
 fs/smb/server/vfs_cache.h                            |    2 
 fs/udf/balloc.c                                      |    5 
 fs/udf/super.c                                       |   11 
 fs/userfaultfd.c                                     |   14 
 fs/xfs/libxfs/xfs_bmap_btree.h                       |    2 
 fs/xfs/libxfs/xfs_defer.c                            |    2 
 fs/xfs/libxfs/xfs_exchmaps.c                         |    2 
 fs/xfs/scrub/dirtree.c                               |   16 
 fs/xfs/scrub/dqiterate.c                             |    2 
 fs/xfs/scrub/inode_repair.c                          |    4 
 fs/xfs/scrub/scrub.h                                 |    6 
 fs/xfs/scrub/xfarray.c                               |    3 
 fs/xfs/xfs_dquot.c                                   |   16 
 fs/xfs/xfs_log_recover.c                             |   15 
 fs/xfs/xfs_qm.c                                      |    5 
 fs/xfs/xfs_reflink.c                                 |   36 +
 include/crypto/drbg.h                                |   18 
 include/linux/damon.h                                |    8 
 include/linux/f2fs_fs.h                              |    1 
 include/linux/fs.h                                   |    5 
 include/linux/fwnode.h                               |    2 
 include/linux/glob.h                                 |    1 
 include/linux/hid-sensor-hub.h                       |   25 
 include/linux/nfslocalio.h                           |    7 
 include/linux/vfio_pci_core.h                        |   15 
 include/net/bonding.h                                |    1 
 init/Kconfig                                         |    1 
 io_uring/io-wq.c                                     |    2 
 kernel/audit.c                                       |   21 
 kernel/bpf/btf.c                                     |    9 
 kernel/bpf/cgroup.c                                  |    2 
 kernel/bpf/devmap.c                                  |    7 
 kernel/events/core.c                                 |   19 
 kernel/locking/rtmutex.c                             |   18 
 kernel/locking/rtmutex_api.c                         |    2 
 kernel/module/decompress.c                           |    2 
 kernel/sched/features.h                              |    8 
 kernel/time/posix-cpu-timers.c                       |    1 
 kernel/trace/trace_events_filter.c                   |    6 
 lib/debugobjects.c                                   |   17 
 lib/glob.c                                           |   31 +
 mm/damon/ops-common.c                                |    1 
 mm/filemap.c                                         |    2 
 mm/khugepaged.c                                      |   39 -
 mm/madvise.c                                         |    3 
 mm/mincore.c                                         |    3 
 mm/mmap.c                                            |    2 
 mm/shrinker.c                                        |   13 
 mm/shrinker_debug.c                                  |   14 
 mm/slub.c                                            |   18 
 mm/swapfile.c                                        |    1 
 mm/vmalloc.c                                         |    1 
 net/6lowpan/nhc.c                                    |    2 
 net/bluetooth/af_bluetooth.c                         |   17 
 net/bluetooth/bnep/core.c                            |   27 
 net/bluetooth/iso.c                                  |   13 
 net/bluetooth/l2cap_core.c                           |   36 -
 net/bluetooth/l2cap_sock.c                           |    4 
 net/bluetooth/mgmt.c                                 |    3 
 net/bridge/netfilter/ebtables.c                      |    9 
 net/core/netpoll.c                                   |    9 
 net/ipv4/igmp.c                                      |    1 
 net/ipv4/sysctl_net_ipv4.c                           |   10 
 net/ipv4/tcp_output.c                                |    4 
 net/ipv6/netfilter/nf_conntrack_reasm.c              |    2 
 net/key/af_key.c                                     |    1 
 net/netfilter/ipset/ip_set_core.c                    |    8 
 net/netfilter/nf_conntrack_netlink.c                 |    2 
 net/netfilter/nfnetlink_log.c                        |   26 
 net/netfilter/nfnetlink_queue.c                      |   16 
 net/netfilter/xt_u32.c                               |   16 
 net/tipc/bcast.c                                     |   22 
 net/tipc/bcast.h                                     |    2 
 net/tipc/node.c                                      |   15 
 security/apparmor/net.c                              |    1 
 sound/core/seq/seq_memory.c                          |    2 
 sound/firewire/isight.c                              |    3 
 sound/isa/gus/gus_pcm.c                              |    2 
 sound/pci/cmipci.c                                   |    6 
 sound/pci/es1938.c                                   |    2 
 sound/pci/ice1712/aureon.c                           |    2 
 sound/pci/ice1712/ice1712.c                          |    8 
 sound/pci/ice1712/ice1724.c                          |    6 
 sound/pci/ymfpci/ymfpci_main.c                       |    6 
 sound/usb/caiaq/input.c                              |    2 
 sound/usb/mixer_quirks.c                             |  101 ++-
 sound/usb/mixer_scarlett.c                           |    4 
 sound/usb/mixer_us16x08.c                            |  127 ++--
 sound/virtio/virtio_kctl.c                           |   50 +
 sound/virtio/virtio_pcm.c                            |    3 
 sound/virtio/virtio_pcm_ops.c                        |    3 
 tools/mm/slabinfo.c                                  |    6 
 tools/perf/trace/beauty/fcntl.c                      |   16 
 tools/testing/selftests/mm/droppable.c               |   46 -
 tools/testing/selftests/mm/pagemap_ioctl.c           |   12 
 tools/usb/usbip/libsrc/usbip_common.c                |    2 
 tools/usb/usbip/libsrc/usbip_device_driver.c         |    4 
 tools/usb/usbip/libsrc/vhci_driver.c                 |    1 
 327 files changed, 3344 insertions(+), 1631 deletions(-)

Abdun Nihaal (1):
      OPP: of: Fix potential memory leak in opp_parse_supplies()

Achkinazi, Igor (1):
      nvme-multipath: set BIO_REMAPPED on bios remapped to per-path namespace disks

Ahsan Atta (3):
      crypto: qat - keep VFs enabled during reset
      crypto: qat - notify fatal error before AER reset preparation
      crypto: qat - protect service table iterations with service_lock

Alan Stern (1):
      USB: chaoskey: Fix slab-use-after-free in chaoskey_release()

Alberto Ruiz (1):
      fuse: fix device node leak in cuse_process_init_reply()

Alex Williamson (4):
      vfio/pci: Latch disable_idle_d3 per device
      vfio/pci: Release the VGA arbiter client on register_device() failure
      vfio/pci: Fix racy bitfields and tighten struct layout
      vfio: Remove device debugfs before releasing devres

Alexandru Hossu (7):
      staging: rtl8723bs: fix heap buffer overflow in rtw_cfg80211_set_wpa_ie()
      staging: rtl8723bs: fix WEP length underflow and OOB read in OnAuth()
      staging: rtl8723bs: fix OOB read in OnAssocRsp() IE loop
      staging: rtl8723bs: fix OOB read in update_beacon_info() IE loop
      staging: rtl8723bs: fix OOB reads in IE loops in issue_assocreq() and join_cmd_hdl()
      staging: rtl8723bs: fix OOB reads in is_ap_in_tkip() IE loop
      staging: rtl8723bs: fix OOB write in HT_caps_handler()

Alexey Nepomnyashih (1):
      xfs: fix unreachable BIGTIME check in dquot flush validation

Alice Ryhl (2):
      rust: Kbuild: set frame-pointer llvm module flag for CONFIG_FRAME_POINTER
      rust: kasan: KASAN+RUST requires clang

Ammar Faizi (1):
      virtio_pci: fix vq info pointer lookup via wrong index

Anastasia Tishchenko (1):
      crypto: ecc - Fix carry overflow in vli multiplication

Andreas Kempe (1):
      iio: imu: st_lsm6dsx: deselect shub page before reading whoami

Andrei Kuchynski (2):
      mfd: cros_ec: Delay dev_set_drvdata() until probe success
      usb: typec: ucsi: Invert DisplayPort role assignment

Andrey Albershteyn (1):
      xfs: fix null pointer dereference in tracepoint

Andrii Kuchmenko (1):
      module: decompress: check return value of module_extend_max_pages()

Andy Shevchenko (3):
      iio: magnetometer: ak8975: Add missed pm_runtime_put_autosuspend() call
      serial: 8250_mid: Disable DMA for selected platforms
      i2c: mpc: Fix timeout calculations

Andy Yan (1):
      usb: typec: tcpm: Fix VDM type for Enter Mode commands

Anthony Yznaga (1):
      mm: fix mmap errno value when MAP_DROPPABLE is not supported

Arnd Bergmann (1):
      staging: media: atomisp: reduce load_primary_binaries() stack usage

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Validate SVID index in svdm_consume_modes()

Baokun Li (1):
      writeback: fix race between cgroup_writeback_umount() and inode_switch_wbs()

Bartosz Golaszewski (1):
      device property: initialize the remaining fields of fwnode_handle in fwnode_init()

Benjamin Coddington (1):
      NFSv4: include MAY_WRITE in open permission mask for O_TRUNC

Biren Pandya (2):
      iio: accel: kxsd9: fix runtime PM imbalance on write_raw() error
      iio: light: gp2ap002: fix runtime PM leak on read error

Breno Leitao (1):
      netpoll: fix a use-after-free on shutdown path

Bryam Vargas (14):
      f2fs: bound i_inline_xattr_size for non-inline-xattr inodes
      iio: accel: bmc150: clamp the device-reported FIFO frame count
      udf: validate VAT header length against the VAT inode size
      udf: validate sparing table length as an entry count, not a byte count
      nvmet: fix pre-auth out-of-bounds heap read in Discovery Get Log Page
      partitions: aix: bound the pp_count scan to the ppe array
      isofs: bound Rock Ridge symlink components to the SL record
      exfat: bound uniname advance in exfat_find_dir_entry()
      Input: synaptics-rmi4 - bound the F3A keymap to the GPIO count
      Input: synaptics-rmi4 - bound the F30 keymap to the GPIO/LED count
      Input: goodix - clamp the device-reported contact count
      Input: iforce - bound the device-reported force-feedback effect index
      Input: touchwin - reset the packet index on every complete packet
      Input: mms114 - reject an oversized device packet size

Carlos Llamas (2):
      binder: fix UAF in binder_thread_release()
      binder: fix UAF in binder_free_transaction()

Carlos Song (2):
      spi: fsl-lpspi: replace dmaengine_terminate_all() with dmaengine_terminate_sync()
      spi: fsl-lpspi: terminate the RX channel on TX prepare failure path

Chao Shi (1):
      block: skip sync_blockdev() on surprise removal in bdev_mark_dead()

Chao Yu (2):
      f2fs: atomic: fix UAF issue on f2fs_inode_info.atomic_inode
      f2fs: fix potential deadlock in gc_merge path of f2fs_balance_fs()

Chi Wang (1):
      audit: Fix data races of skb_queue_len() readers on audit_queue

Chris Mason (1):
      nfsd: release layout stid on setlease failure

Christoph Hellwig (2):
      block: add a store_limit operations for sysfs entries
      block: fix queue freeze vs limits lock order in sysfs store methods

Cássio Gabriel (7):
      ALSA: virtio: Add missing 384 kHz PCM rate mapping
      ALSA: virtio: Validate control metadata from the device
      ALSA: usb-audio: Propagate errors in scarlett_ctl_enum_put()
      ALSA: usb-audio: Propagate US-16x08 write errors in route/mix EQ-switch put callbacks
      ALSA: usb-audio: Roll back quirk control caches on write errors
      ALSA: usb-audio: Update Babyface Pro control caches only after successful writes
      ALSA: usb-audio: Update US-16x08 EQ/comp shadow state after successful writes

Dan Carpenter (2):
      iio: backend: fix uninitialized data in debugfs
      smb/client: Fix error code in smb2_aead_req_alloc()

Daniel Borkmann (1):
      bpf, arm64: Reject out-of-range B.cond targets

Darrick J. Wong (7):
      xfs: fix pointer arithmetic error on 32-bit systems
      xfs: resample the data fork mapping after cycling ILOCK
      xfs: don't wrap around quota ids in dqiterate
      xfs: set xfarray killable sort correctly
      xfs: clamp timestamp nanoseconds correctly
      xfs: fully check the parent handle when it points to the rootdir
      xfs: don't zap bmbt forks if they are MAXLEVELS tall

Darvell Long (1):
      ALSA: usb-audio: avoid kobject path lookup in DualSense match

David Hildenbrand (Arm) (1):
      selftests: mm: fix and speedup "droppable" test

Davide Ornaghi (1):
      ksmbd: fix UAF of struct file_lock in SMB2_LOCK deferred-lock cancellation

Dawei Feng (3):
      crypto: amlogic - avoid double cleanup in meson_crypto_probe()
      bpf: Restore sysctl new-value from 1 to 0
      usb: free iso schedules on failed submit

Deepanshu Kartikey (2):
      fs/ntfs3: fix missing run load for vcn0 in attr_data_get_block_locked()
      nilfs2: reject CLEAN_SEGMENTS ioctl with out-of-range segment numbers

Dmitry Torokhov (5):
      Input: mms114 - fix touch indexing for MMS134S and MMS136
      Input: mms114 - fix multi-touch slot corruption
      Input: maple_keyb - set driver data before registering input device
      Input: maplemouse - set driver data before registering input device
      Input: maplecontrol - set driver data before registering input device

Eric Biggers (4):
      crypto: af_alg - Remove zero-copy support from skcipher and aead
      crypto: drbg - Fix returning success on failure in CTR_DRBG
      crypto: drbg - Fix drbg_max_addtl() on 64-bit kernels
      crypto: drbg - Fix the fips_enabled priority boost

Erich E. Hoover (1):
      USB: quirks: add NO_LPM for the Samsung T5 EVO Portable SSD

Fabio Porcedda (1):
      USB: serial: option: add Telit Cinterion FE990D50 compositions

Fan Wu (1):
      usb: typec: ucsi: ccg: Fix use-after-free of ucsi on remove

Florian Fainelli (1):
      perf trace beauty fcntl: Fix build with older kernel headers

Florian Fuchs (1):
      Input: maplemouse - fix NULL pointer dereference in open()

Florian Westphal (2):
      netfilter: handle unreadable frags
      netfilter: ebtables: module names must be null-terminated

Fushuai Wang (1):
      cpufreq: intel_pstate: Sync policy->cur during CPU offline

Gil Portnoy (6):
      ksmbd: fix use-after-free of a deferred file_lock on SMB2_CLOSE then SMB2_CANCEL
      ksmbd: add permission checks for FSCTL_DUPLICATE_EXTENTS_TO_FILE
      ksmbd: add a permission check for FSCTL_SET_ZERO_DATA
      ksmbd: add a WRITE_DAC/WRITE_OWNER check to SMB2 SET_INFO SECURITY
      ksmbd: enforce FILE_READ_ATTRIBUTES on SMB_FIND_FILE_POSIX_INFORMATION
      ksmbd: add per-handle permission check to FILE_LINK_INFORMATION

Giovanni Cabiddu (1):
      crypto: qat - validate RSA CRT component lengths

Greg Kroah-Hartman (1):
      Linux 6.12.96

Griffin Kroah-Hartman (2):
      usb: gadget: function: rndis: add length check to response query
      usb: gadget: function: rndis: add length check for header

Guangshuo Li (3):
      iio: adc: ti-ads1119: fix PM reference leak in buffer preenable
      cpufreq: qcom-cpufreq-hw: Fix possible double free
      firmware_loader: fix device reference leak in firmware_upload_register()

Guillermo Rodríguez (1):
      i2c: stm32f7: truncate clock period instead of rounding it

Hangbin Liu (1):
      bonding: fix xfrm offload feature setup on active-backup mode

Hao-Qun Huang (2):
      staging: vme_user: fix location monitor leak in fake bridge
      staging: vme_user: fix location monitor leak in tsi148 bridge

Haoxiang Li (4):
      smb: client: Fix next buffer leak in receive_encrypted_standard()
      usb: cdnsp: fix stream context array leak in cdnsp_alloc_stream_info()
      usb: mtu3: unmap request DMA on queue failure
      Input: synaptics-rmi4 - unregister function handlers on physical driver registration failure

Henrique Carvalho (6):
      smb: client: fix query directory replay double-free
      smb: client: fix query_info() replay double-free
      smb: client: fix double-free in SMB2_ioctl() replay
      smb: client: fix change notify replay double-free
      smb: client: fix double-free in SMB2_open() replay
      smb: client: fix double-free in SMB2_close() replay

Herman van Hazendonk (1):
      iio: common: st_sensors: honour channel endianness in read_axis_data

Huacai Chen (1):
      LoongArch: Add PIO for early access before ACPI PCI root register

Huihui Huang (1):
      tracing: Prevent out-of-bounds read in glob matching

HyeongJun An (2):
      platform/x86: intel-hid: Protect ACPI notify handler against recursion
      ALSA: seq: Fix uninitialised heap leak in snd_seq_event_dup()

Janne Grunau (1):
      watchdog: apple: Add "apple,t8103-wdt" compatible

Jared Baldridge (1):
      usb: cdc_acm: Add quirk for Uniden BC125AT scanner

Javier Carrasco (1):
      iio: light: veml6030: fix channel type when pushing events

Jean-Baptiste Maneyrol (2):
      iio: imu: inv_icm42600: fix timestamp clock period by using lower value
      iio: imu: inv_icm42600: fix timestamping by limiting FIFO reading

Jeremy Linton (1):
      ACPI: CPPC: Suppress UBSAN warning caused by field misuse

Ji'an Zhou (1):
      fuse: clear intr_entry in fuse_resend and fuse_remove_pending_req

Jimmy Hu (1):
      usb: gadget: udc: Fix use-after-free in gadget_match_driver

Joanne Koong (1):
      fuse: re-lock request before returning from fuse_ref_folio()

Johan Hovold (19):
      Bluetooth: btusb: fix use-after-free on registration failure
      Bluetooth: btusb: fix use-after-free on marvell probe failure
      Bluetooth: btusb: fix wakeup source leak on probe failure
      virtio-mmio: fix device release warning on module unload
      USB: idmouse: fix use-after-free on disconnect race
      USB: ldusb: fix use-after-free on disconnect race
      USB: iowarrior: fix use-after-free on disconnect
      USB: legousbtower: fix use-after-free on disconnect race
      USB: serial: keyspan_pda: fix information leak
      USB: serial: digi_acceleport: fix broken rx after throttle
      USB: serial: digi_acceleport: fix hard lockup on disconnect
      USB: serial: digi_acceleport: fix write buffer corruption
      USB: ulpi: fix memory leak on registration failure
      i2c: core: fix hang on adapter registration failure
      i2c: core: fix irq domain leak on adapter registration failure
      i2c: core: fix NULL-deref on adapter registration failure
      i2c: core: fix adapter probe deferral loop
      i2c: core: fix adapter debugfs creation
      i2c: core: fix adapter deregistration race

John Johansen (1):
      apparmor: advertise the tcp fast open fix is applied

John Stultz (1):
      locking/rtmutex: Make sure we wake anything on the wake_q when we release the lock->wait_lock

Jonathan Curley (2):
      NFSv4/flexfiles: Remove cred local variable dependency
      NFSv4/flexfiles: Add data structure support for striped layouts

Joshua Crofts (1):
      iio: light: opt3001: fix missing state reset on timeout

Junrui Luo (2):
      vfio: prevent infinite loop in vfio_mig_get_next_state() on blocked arc
      coresight: ultrasoc-smb: Fix OOB write in smb_sync_perf_buffer()

Kartik Rajput (1):
      clocksource/drivers/timer-tegra186: Fix support for multiple watchdog instances

Keshav Verma (1):
      f2fs: fix listxattr handling of corrupted xattr entries

Kiryl Shutsemau (1):
      userfaultfd: gate must_wait writability check on pte_present()

Koichiro Den (2):
      NTB: epf: Avoid calling pci_irq_vector() from hardirq context
      NTB: epf: Fix request_irq() unwind in ntb_epf_init_isr()

Konstantin Komarov (3):
      fs/ntfs3: rename ni_readpage_cmpr into ni_read_folio_cmpr
      fs/ntfs3: fsync files by syncing parent inodes
      fs/ntfs3: zero-fill folios beyond i_valid in ntfs_read_folio()

Krzysztof Karas (1):
      drm/i915: ensure segment offset never exceeds allowed max

Lars-Peter Clausen (1):
      iio: event: Fix event FIFO reset race

Liviu Stan (2):
      iio: temperature: ltc2983: Fix n_wires default bypassing rotation check
      iio: temperature: ltc2983: Fix reinit_completion() called after conversion start

Louis-Alexis Eyraud (1):
      media: mtk-jpeg: cancel workqueue on release for supported platforms only

Lukas Wunner (1):
      X.509: Fix validation of ASN.1 certificate header

Maciej W. Rozycki (1):
      PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining

Madhu M (1):
      usb: typec: ucsi: Pass full DP config payload in SET_NEW_CAM for DP alt mode

Mahesh Vaidya (1):
      PCI: altera: Do not dispose parent IRQ mapping

Manish Khadka (1):
      HID: letsketch: fix UAF on inrange_timer at driver unbind

Maoyi Xie (6):
      ALSA: caiaq: fix out-of-bounds read in the Traktor Kontrol S4 input parser
      ALSA: firewire: isight: bound the sample count to the packet payload
      Bluetooth: btnxpuart: Fix out-of-bounds firmware read in nxp_recv_fw_req_v3()
      HID: lg-g15: cancel pending work on remove to fix a use-after-free
      net: usb: kalmia: bound RX frame length in kalmia_rx_fixup()
      usb: gadget: composite: fix dead empty check in the USB_DT_OTG handler

Marco Scardovi (2):
      gpio: rockchip: teardown bugs and resource leaks
      gpio: rockchip: fix generic IRQ chip leak on remove

Mark Rutland (1):
      arm64: fpsimd: Fix type mismatch in sme_{save,load}_state()

Maxwell Doose (3):
      iio: adc: lpc32xx: Initialize completion before requesting IRQ
      iio: adc: spear: Initialize completion before requesting IRQ
      iio: chemical: scd30: Cleanup initializations and fix sign-extension bug

Michael Bommarito (4):
      NFSv4/flexfiles: reject zero filehandle version count
      hwrng: virtio: clamp device-reported used.len at copy_data()
      udf: validate free block extents against the partition length
      RDMA/siw: bound Read Response placement to the RREAD length

Michael Tautschnig (1):
      staging: vme_user: bound slave read/write to the kern_buf size

Mike Snitzer (2):
      nfsd: add nfsd_file_{get,put} to 'nfs_to' nfsd_localio_operations
      nfs_common: rename functions that invalidate LOCALIO nfs_clients

Mikhail Dmitrichenko (1):
      bcachefs: avoid truncating fiemap extent length

Mikhail Gavrilov (2):
      udmabuf: fix DMA direction mismatch in release_udmabuf()
      dma-buf/udmabuf: skip redundant cpu sync to fix cacheline EEXIST warning

Mikulas Patocka (1):
      dm-ioctl: report an error if a device has no table

Mingyu Wang (1):
      fbdev: fbcon: fix out-of-bounds read in err_out of fbcon_do_set_font()

Muhammad Bilal (2):
      Bluetooth: ISO: avoid NULL deref of conn in iso_conn_big_sync()
      Bluetooth: L2CAP: validate option length before reading conf opt value

Myeonghun Pak (5):
      usb: typec: tcpci_rt1711h: unregister TCPCI port with devres
      HID: wacom: stop hardware after post-start probe failures
      usb: sl811-hcd: disable controller wakeup on remove
      USB: misc: uss720: unregister parport on probe failure
      usb: typec: anx7411: use devm_pm_runtime_enable()

Namjae Jeon (5):
      ksmbd: serialize QUERY_DIRECTORY requests per file
      ksmbd: require source read access for duplicate extents
      ksmbd: run set info with opener credentials
      ksmbd: use opener credentials for delete-on-close
      ksmbd: use opener credentials for ADS I/O

NeilBrown (2):
      nfsd: move name lookup out of nfsd4_list_rec_dir()
      nfsd: change nfs4_client_to_reclaim() to allocate data

Neill Kapron (1):
      usb: gadget: f_fs: Initialize epfile->in early to fix endpoint direction checks

Nicolin Chen (1):
      iommufd: Set upper bounds on cache invalidation entry_num and entry_len

Norbert Manthey (1):
      smb: client: mask server-provided mode to 07777 in modefromsid

Paul Cercueil (1):
      usb: gadget: f_fs: Fix DMA fence leak

Paul Louvel (11):
      crypto: talitos - use dma_sync_single_for_cpu() before reading descriptor header
      crypto: talitos - add chaining of arbitrary number of descriptor for the SEC1
      crypto: talitos - move dma unmapping code in flush_channel() into a standalone dma_unmap_request() function
      crypto: talitos - move dma mapping code in talitos_submit() into a standalone dma_map_request() function
      crypto: talitos - move code in current_desc_hdr() into a standalone function
      crypto: talitos/hash - prepare SEC1 descriptor chaining, remove additional descriptor
      crypto: talitos/hash - use descriptor chaining for SEC1 instead of workqueue
      crypto: talitos/hash - drop workqueue mechanism for SEC1
      crypto: talitos/hash - rename first_desc/last_desc to first_request/last_request
      crypto: talitos/hash - remove useless wrapper
      crypto: talitos/hash - fix SEC2 64k - 1 ahash request limitation

Paul Menzel (1):
      usb: typec: ucsi: cancel pending work on system suspend

Paul Moses (1):
      bpf: Validate BTF repeated field counts before expansion

Pauli Virtanen (1):
      Bluetooth: hci_uart: clear HCI_UART_SENDING when write_work is canceled

Pedro Falcato (2):
      mm/khugepaged: write all dirty file folios when collapsing
      mm: do file ownership checks with the proper mount idmap

Pengpeng Hou (2):
      iio: adc: ti-ads124s08: Return reset GPIO lookup errors
      iio: temperature: Build mlx90635 with CONFIG_MLX90635

Pratham Gupta (1):
      netfilter: ctnetlink: use nf_ct_exp_net() in expectation dump

Qi Zheng (2):
      mm: shrinker: fix shrinker_info teardown race with expansion
      mm: shrinker: fix NULL pointer dereference in debugfs

Qu Wenruo (1):
      btrfs: do not trim a device which is not writeable

Rafael J. Wysocki (1):
      ACPI: NFIT: core: Fix possible NULL pointer dereference

Raghavendra Rao Ananta (1):
      vfio/pci: Use a private flag to prevent power state change with VFs

Ranjan Kumar (1):
      Input: elan_i2c - prevent division by zero and arithmetic underflow

Ratheesh Kannoth (1):
      PCI: host-common: Request bus reassignment when not probe-only

Reinette Chatre (1):
      x86,fs/resctrl: Prevent out-of-bounds access while offlining CPU when SNC enabled

Ricardo Ribalda (1):
      media: staging: ipu3-imgu: Add range check for imgu_css_cfg_acc_stripe

Ricardo Robaina (1):
      audit: fix potential integer overflow in audit_log_n_hex()

Richard Zhu (1):
      PCI: imx6: Fix IMX6SX_GPR12_PCIE_TEST_POWERDOWN handling

Robin Murphy (1):
      perf/arm-cmn: Fix DVM node events

Rodrigo Lugathe da Conceição Alves (1):
      USB: core: add USB_QUIRK_NO_LPM for VIA Labs USB 2.0 hub

Ruijie Li (1):
      crypto: pcrypt - restore callback for non-parallel fallback

Ruipeng Qi (1):
      f2fs: fix potential deadlock in f2fs_balance_fs()

Runyu Xiao (6):
      iio: imu: adis: add IRQF_NO_THREAD to non-FIFO trigger IRQ
      iio: imu: bmi160: add IRQF_NO_THREAD to data-ready trigger IRQ
      usb: dwc3: run gadget disconnect from sleepable suspend context
      coresight: etb10: restore atomic_t for shared reading state
      gpio: eic-sprd: use raw_spinlock_t in the irq startup path
      io_uring/io-wq: re-check IO_WQ_BIT_EXIT for each linked work item

Sam Day (1):
      usbip: vudc: fix NULL deref in vep_dequeue()

Samuel Page (2):
      tipc: fix out-of-bounds read in broadcast Gap ACK blocks
      Bluetooth: MGMT: Fix UAF of hci_conn_params in add_device_complete

Scott Mayhew (1):
      nfsd: fix file change detection in CB_GETATTR

Sean Christopherson (3):
      KVM: VMX: Refresh GUEST_PENDING_DBG_EXCEPTIONS.BS on all injected #DBs
      KVM: x86: Ensure vendor's exit handler runs before fastpath userspace exits
      KVM: VMX: Grab vmcs12 on CR8 interception update iff vCPU is in guest mode

SeongJae Park (1):
      mm/damon/ops-common: handle extreme intervals in damon_hot_score()

Sergey Senozhatsky (1):
      Bluetooth: btmtksdio: fix infinite loop in btmtksdio_txrx_work()

Shakeel Butt (1):
      mm/shrinker: do not hold RCU lock in shrinker_debugfs_count_show()

Shoichiro Miyamoto (2):
      smb: client: restrict implied bcc[0] exemption to responses without data area
      smb: client: reject overlapping data areas in SMB2 responses

Shuangpeng Bai (1):
      usb: typec: class: drop PD lookup reference

Srinivas Pandruvada (1):
      HID: sensor-hub: Add sensor_hub_input_attr_read_values() for multi-byte reads

Stepan Ionichev (4):
      iio: gyro: bmg160: bail out when bandwidth/filter is not in table
      iio: gyro: bmg160: wait full startup time after mode change at probe
      iio: light: tsl2591: return actual error from probe IRQ failure
      iio: resolver: ad2s1210: notify trigger and clear state on fault read error

Steven Rostedt (1):
      sched/rt: Have RT_PUSH_IPI be default off for non PREEMPT_RT

Taeyang Lee (1):
      perf/core: Detach event groups during remove_on_exec

Thomas Gleixner (1):
      debugobjects: Plug race against a concurrent OOM disable

Thorsten Blum (2):
      crypto: caam - use print_hex_dump_devel to guard key hex dumps
      crypto: caam - use print_hex_dump_devel to guard key hex dumps again

Tianchu Chen (2):
      HID: hid-goodix-spi: validate report size to prevent stack buffer overflow
      nvmet-auth: validate reply message payload bounds against transfer length

Tianxiang Chen (1):
      cpufreq: Fix hotplug-suspend race during reboot

Tiezhu Yang (1):
      drm/amd: Fix set but not used warnings

Tristan Madani (1):
      hfs/hfsplus: zero-initialize buffer in hfs_bnode_read

Tycho Andersen (AMD) (3):
      crypto: ccp - Do not initialize SNP for SEV ioctls
      crypto: ccp - Do not initialize SNP for ioctl(SNP_COMMIT)
      crypto: ccp - Do not initialize SNP for ioctl(SNP_VLEK_LOAD)

Uladzislau Rezki (Sony) (1):
      mm/vmalloc: take vmap_purge_lock in shrinker

Vasily Khoruzhick (1):
      EDAC/i10nm: Don't fail probing if ADXL is missing

Vidhu Sarwal (1):
      iio: light: al3010: fix incorrect scale for the highest gain range

Vivian Wang (1):
      riscv: mm: Unconditionally sfence.vma for spurious fault

Vlastimil Babka (SUSE) (1):
      mm/slab: do not limit zeroing to orig_size when only red zoning is enabled

Weiming Shi (1):
      xfs: fail recovery on a committed log item with no regions

Weinan Liu (1):
      iommu/amd: Don't split flush for amd_iommu_domain_flush_all()

WenTao Liang (2):
      posix-cpu-timers: Fix pid refcount leak in do_cpu_nanosleep() error path
      usb: dwc3: meson-g12a: fix refcount leak in dwc3_meson_g12a_resume()

Wenjie Qi (1):
      f2fs: validate orphan inode entry count

Wentao Guan (1):
      perf: Fix dangling cgroup pointer in cpuctx backport

Wentao Liang (4):
      hwrng: jh7110 - fix refcount leak in starfive_trng_read()
      nvme: target: rdma: fix ndev refcount leak on queue connect
      crypto: tegra - fix refcount leak in tegra_se_host1x_submit()
      regulator: scmi: fix of_node refcount leak in scmi_regulator_probe()

Wyatt Feng (1):
      net: ipv4: bound TCP reordering sysctl writes and MTU probe sizes

Xiang Mei (2):
      netfilter: ipset: fix race between dump and ip_set_list resize
      netfilter: ebtables: terminate table name before find_table_lock()

Xu Rao (4):
      smb: client: fix atime clamp check in read completion
      usb: gadget: f_printer: take kref only for successful open
      USB: storage: include US_FL_NO_SAME in quirks mask
      USB: usb-storage: ene_ub6250: restore media-ready check

Xuewen Wang (1):
      tools/mm/slabinfo: Fix trace disable logic inversion

Ye Zhang (1):
      gpio: rockchip: change the GPIO version judgment logic

Yichong Chen (2):
      tools/mm/slabinfo: fix total_objects attribute name
      usbip: tools: support SuperSpeedPlus devices

Yingjie Gao (2):
      xfs: release dquot buffer after dqflush failure
      xfs: fix exchmaps reservation limit check

Yizhou Zhao (1):
      6lowpan: fix NHC entry use-after-free on error path

Yousef Alhouseen (3):
      Bluetooth: bnep: pin L2CAP connection during netdev registration
      Bluetooth: fix UAF in bt_accept_dequeue()
      xfs: use null daddr for unset first bad log block

Yuho Choi (1):
      cpufreq: pcc: fix use-after-free and double free in _OSC evaluation

Yunpeng Tian (1):
      fs/ntfs3: validate Dirty Page Table capacity in log_replay copy_lcns

Yuyang Huang (1):
      ipv4: igmp: remove multicast group from hash table on device destruction

Zenghui Yu (1):
      selftests/mm: pagemap_ioctl: use the correct page size for transact_test()

Zenm Chen (1):
      Bluetooth: btusb: Add USB ID 2c4e:0128 for Mercusys MA60XNB

Zhao Dongdong (5):
      ALSA: ymfpci: check snd_ctl_new1() return value
      ALSA: cmipci: check snd_ctl_new1() return value
      ALSA: es1938: check snd_ctl_new1() return value
      ALSA: gus: check snd_ctl_new1() return value
      ALSA: ice1712: check snd_ctl_new1() return value

Zhao Zhang (2):
      smb: client: fix double-free in SMB2_flush() replay
      bpf: Reject fragmented frames in devmap

Zhenhao Wan (1):
      RDMA/rtrs-srv: Bound RDMA-Write length to chunk size in rdma_write_sg

Zihan Xi (2):
      smb: client: use unaligned reads in parse_posix_ctxt()
      smb: client: harden POSIX SID length parsing

Zijiang Huang (1):
      mm/swap: add cond_resched() in swap_reclaim_full_clusters to prevent softlockup

Zijing Yin (1):
      net: af_key: initialize alg_key_len for IPComp states

Ziyao Li (1):
      PCI: loongson: Override PCIe bridge supported speeds for Loongson-3C6000 series

胡连勤 (1):
      usb: xhci: Fix sleep in atomic context in xhci_free_streams()

