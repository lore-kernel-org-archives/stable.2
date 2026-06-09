Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9B43F9F2B;
	Tue,  9 Jun 2026 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002366; cv=none; b=ePiXaDz5GqP4OBDpBJ1RgkbUBR7Oo5s3pfErTA3YWE1O5NAxNDMfcZ9u4oalDZmX62IxCoSoVXaqHJhMJzusvY8viv/xUDQI22slqdyUBrjloeuOAUr4vxqQI/i7FnMHob3evawY2mHWI4NXUG+96iqRA7pVOFb4wGU8WS+6pCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002366; c=relaxed/simple;
	bh=sUHOXjzuZkTVZ0nsGG2+er5axGgOxri0N88URIylccM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jt//eDlvV0uVisVfNXx77DeVWyLyZ1S4/ESGYmFTVh5Ex542WKv1wNUqpPr1Iqin01Rn1ajWSVTuJs6nV6ecRh4IIBbkFOT+dVdl2h13I/0KY6NWUgZrlXFVZutZLR5FTEQf3wHr8JGX3Agjzb06ZriPsxUzekldPG7O6qjkh+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bnOvyJwW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bnOvyJwW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FD01F00893;
	Tue,  9 Jun 2026 10:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781002363;
	bh=nNDZ19y25Av+qVraoYc/zW5e5r1waBJ4VlhfoWtoERc=;
	h=From:To:Cc:Subject:Date;
	b=bnOvyJwW3FAEQQZTlJQ6Z3Iw2QAl2W+fpbOq7ElrXCo0ZFK8YsP7UxmyxpTp/Y/95
	 nS8SkBhc1xnH/0mfZ6hCQYlTbOsihTuvRzIJcikniCEAhu0j+dBISl+I0RyWna+m8q
	 Z//bhJdPpz6R9++PnLj64UcSifTPSgxbYM1zz+tg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.93
Date: Tue,  9 Jun 2026 12:51:41 +0200
Message-ID: <2026060942-heaviness-luckily-b0d4@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.93 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/netlink/specs/handshake.yaml               |    8 
 Makefile                                                 |    2 
 arch/alpha/include/asm/Kbuild                            |    1 
 arch/arc/include/asm/Kbuild                              |    1 
 arch/arm/include/asm/Kbuild                              |    1 
 arch/arm64/include/asm/debug-monitors.h                  |   34 --
 arch/arm64/include/asm/esr.h                             |    5 
 arch/arm64/include/asm/exception.h                       |   14 
 arch/arm64/include/asm/io.h                              |   24 +
 arch/arm64/include/asm/kgdb.h                            |   12 
 arch/arm64/include/asm/kprobes.h                         |    8 
 arch/arm64/include/asm/ring_buffer.h                     |   10 
 arch/arm64/include/asm/system_misc.h                     |    4 
 arch/arm64/include/asm/tlb.h                             |    2 
 arch/arm64/include/asm/traps.h                           |    6 
 arch/arm64/include/asm/uprobes.h                         |   11 
 arch/arm64/kernel/acpi.c                                 |    2 
 arch/arm64/kernel/debug-monitors.c                       |  242 +++++----------
 arch/arm64/kernel/entry-common.c                         |  148 ++++++++-
 arch/arm64/kernel/hw_breakpoint.c                        |   60 +--
 arch/arm64/kernel/kgdb.c                                 |   39 --
 arch/arm64/kernel/probes/kprobes.c                       |   31 -
 arch/arm64/kernel/probes/kprobes_trampoline.S            |    2 
 arch/arm64/kernel/probes/uprobes.c                       |   24 -
 arch/arm64/kernel/traps.c                                |   80 ----
 arch/arm64/kvm/pmu-emul.c                                |    4 
 arch/arm64/kvm/vgic/vgic-its.c                           |    6 
 arch/arm64/mm/fault.c                                    |   75 ----
 arch/arm64/mm/ioremap.c                                  |    7 
 arch/csky/include/asm/Kbuild                             |    1 
 arch/hexagon/include/asm/Kbuild                          |    1 
 arch/loongarch/include/asm/Kbuild                        |    1 
 arch/m68k/include/asm/Kbuild                             |    1 
 arch/microblaze/include/asm/Kbuild                       |    1 
 arch/mips/dec/platform.c                                 |  109 ++++++
 arch/mips/include/asm/Kbuild                             |    1 
 arch/nios2/include/asm/Kbuild                            |    1 
 arch/openrisc/include/asm/Kbuild                         |    1 
 arch/parisc/include/asm/Kbuild                           |    1 
 arch/powerpc/include/asm/Kbuild                          |    1 
 arch/riscv/include/asm/Kbuild                            |    1 
 arch/riscv/include/asm/syscall_wrapper.h                 |    4 
 arch/s390/include/asm/Kbuild                             |    1 
 arch/sh/include/asm/Kbuild                               |    1 
 arch/sparc/include/asm/Kbuild                            |    1 
 arch/um/include/asm/Kbuild                               |    1 
 arch/x86/include/asm/Kbuild                              |    1 
 arch/x86/include/asm/text-patching.h                     |    2 
 arch/x86/kernel/Makefile                                 |   16 
 arch/x86/kernel/alternative.c                            |    6 
 arch/x86/kernel/callthunks.c                             |    6 
 arch/x86/kernel/ftrace.c                                 |    7 
 arch/x86/kvm/svm/avic.c                                  |   35 +-
 arch/x86/kvm/svm/sev.c                                   |   68 ++--
 arch/x86/mm/Makefile                                     |    2 
 arch/xtensa/include/asm/Kbuild                           |    1 
 drivers/accel/ivpu/ivpu_debugfs.c                        |    2 
 drivers/auxdisplay/line-display.c                        |    2 
 drivers/bluetooth/btusb.c                                |    8 
 drivers/bluetooth/hci_qca.c                              |   38 +-
 drivers/comedi/drivers/comedi_test.c                     |    5 
 drivers/counter/counter-core.c                           |    3 
 drivers/gpio/gpio-mxc.c                                  |    2 
 drivers/gpio/gpio-rockchip.c                             |    6 
 drivers/gpio/gpio-virtuser.c                             |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                 |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    |    8 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                     |    3 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c               |    4 
 drivers/gpu/drm/bridge/sil-sii8620.c                     |    1 
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c                |  113 ++++++-
 drivers/gpu/drm/i915/display/intel_display_types.h       |    1 
 drivers/gpu/drm/i915/display/intel_dpcd.h                |   15 
 drivers/gpu/drm/i915/display/intel_psr.c                 |   34 ++
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c                  |   28 -
 drivers/gpu/drm/v3d/v3d_sched.c                          |   16 
 drivers/gpu/drm/v3d/v3d_submit.c                         |   22 +
 drivers/hid/bpf/hid_bpf_dispatch.c                       |    6 
 drivers/hid/hid-core.c                                   |   62 +++
 drivers/hid/hid-gfrm.c                                   |    4 
 drivers/hid/hid-ids.h                                    |    1 
 drivers/hid/hid-logitech-hidpp.c                         |    2 
 drivers/hid/hid-multitouch.c                             |    2 
 drivers/hid/hid-picolcd_cir.c                            |    1 
 drivers/hid/hid-primax.c                                 |    2 
 drivers/hid/hid-quirks.c                                 |    1 
 drivers/hid/hid-vivaldi-common.c                         |    2 
 drivers/hid/i2c-hid/i2c-hid-core.c                       |    7 
 drivers/hid/usbhid/hid-core.c                            |   11 
 drivers/hid/wacom_sys.c                                  |   19 -
 drivers/hid/wacom_wac.h                                  |    1 
 drivers/hwmon/pmbus/adm1266.c                            |   52 ++-
 drivers/iio/adc/mt6359-auxadc.c                          |    1 
 drivers/iio/adc/npcm_adc.c                               |   25 -
 drivers/iio/adc/viperboard_adc.c                         |    4 
 drivers/iio/adc/xilinx-xadc-core.c                       |   11 
 drivers/iio/buffer/industrialio-hw-consumer.c            |    4 
 drivers/iio/chemical/scd30_core.c                        |   65 +---
 drivers/iio/common/ssp_sensors/ssp_dev.c                 |    1 
 drivers/iio/dac/ad5686.c                                 |   16 
 drivers/iio/dac/ad5686.h                                 |    1 
 drivers/iio/dac/max5821.c                                |    9 
 drivers/iio/gyro/adis16260.c                             |    3 
 drivers/iio/gyro/itg3200_buffer.c                        |    2 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c           |    2 
 drivers/iio/industrialio-buffer.c                        |    1 
 drivers/iio/light/cm3323.c                               |    5 
 drivers/iio/magnetometer/st_magn_core.c                  |   13 
 drivers/iio/temperature/tsys01.c                         |    2 
 drivers/input/joystick/xpad.c                            |   14 
 drivers/input/misc/ims-pcu.c                             |    2 
 drivers/input/mouse/elan_i2c_core.c                      |    5 
 drivers/input/mouse/synaptics.c                          |    1 
 drivers/input/touchscreen/atmel_mxt_ts.c                 |    2 
 drivers/input/touchscreen/usbtouchscreen.c               |    5 
 drivers/iommu/io-pgtable-arm-v7s.c                       |   18 -
 drivers/iommu/iommu.c                                    |   25 +
 drivers/md/bcache/super.c                                |    3 
 drivers/media/cec/core/cec-core.c                        |    2 
 drivers/media/common/siano/smsir.c                       |    1 
 drivers/media/i2c/ir-kbd-i2c.c                           |    2 
 drivers/media/pci/bt8xx/bttv-input.c                     |    3 
 drivers/media/pci/cx23885/cx23885-input.c                |    1 
 drivers/media/pci/cx88/cx88-input.c                      |    3 
 drivers/media/pci/dm1105/dm1105.c                        |    1 
 drivers/media/pci/mantis/mantis_input.c                  |    1 
 drivers/media/pci/saa7134/saa7134-input.c                |    1 
 drivers/media/pci/smipcie/smipcie-ir.c                   |    1 
 drivers/media/pci/ttpci/budget-ci.c                      |    1 
 drivers/media/rc/ati_remote.c                            |    6 
 drivers/media/rc/ene_ir.c                                |    2 
 drivers/media/rc/fintek-cir.c                            |    3 
 drivers/media/rc/igorplugusb.c                           |    3 
 drivers/media/rc/iguanair.c                              |    1 
 drivers/media/rc/img-ir/img-ir-hw.c                      |    3 
 drivers/media/rc/img-ir/img-ir-raw.c                     |    3 
 drivers/media/rc/imon.c                                  |    3 
 drivers/media/rc/ir-hix5hd2.c                            |    2 
 drivers/media/rc/ir_toy.c                                |    1 
 drivers/media/rc/ite-cir.c                               |    2 
 drivers/media/rc/mceusb.c                                |    1 
 drivers/media/rc/rc-ir-raw.c                             |    5 
 drivers/media/rc/rc-loopback.c                           |    1 
 drivers/media/rc/rc-main.c                               |    6 
 drivers/media/rc/redrat3.c                               |    4 
 drivers/media/rc/st_rc.c                                 |    2 
 drivers/media/rc/streamzap.c                             |    7 
 drivers/media/rc/sunxi-cir.c                             |    1 
 drivers/media/rc/ttusbir.c                               |    4 
 drivers/media/rc/winbond-cir.c                           |    2 
 drivers/media/rc/xbox_remote.c                           |    5 
 drivers/media/usb/au0828/au0828-input.c                  |    1 
 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c              |    1 
 drivers/media/usb/dvb-usb/dvb-usb-remote.c               |    6 
 drivers/media/usb/em28xx/em28xx-input.c                  |    1 
 drivers/net/bonding/bond_main.c                          |    6 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c            |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c |    2 
 drivers/net/ethernet/microsoft/mana/mana_en.c            |   70 ++--
 drivers/net/ethernet/ti/cpsw_new.c                       |    4 
 drivers/net/macsec.c                                     |    3 
 drivers/net/phy/mscc/mscc.h                              |    8 
 drivers/net/phy/mscc/mscc_main.c                         |   23 -
 drivers/net/tun.c                                        |    5 
 drivers/net/vxlan/vxlan_core.c                           |    4 
 drivers/net/wireguard/send.c                             |   20 -
 drivers/nfc/nxp-nci/i2c.c                                |   21 +
 drivers/nvme/host/tcp.c                                  |    2 
 drivers/parport/share.c                                  |   11 
 drivers/platform/x86/intel/vsec.c                        |   36 +-
 drivers/s390/cio/chsc.c                                  |    4 
 drivers/s390/cio/chsc_sch.c                              |   20 -
 drivers/s390/cio/scm.c                                   |    2 
 drivers/scsi/fcoe/fcoe_ctlr.c                            |    2 
 drivers/scsi/scsi_lib.c                                  |   27 +
 drivers/scsi/scsi_transport_fc.c                         |   77 ++--
 drivers/staging/greybus/hid.c                            |    2 
 drivers/staging/media/av7110/av7110_ir.c                 |    1 
 drivers/target/iscsi/iscsi_target.c                      |    6 
 drivers/target/iscsi/iscsi_target_auth.c                 |   19 +
 drivers/target/iscsi/iscsi_target_nego.c                 |    7 
 drivers/target/iscsi/iscsi_target_parameters.c           |   62 ++-
 drivers/target/iscsi/iscsi_target_parameters.h           |    2 
 drivers/thunderbolt/property.c                           |   32 +
 drivers/tty/serdev/core.c                                |   21 +
 drivers/tty/serial/altera_jtaguart.c                     |    7 
 drivers/tty/serial/dz.c                                  |  171 +++++-----
 drivers/tty/serial/fsl_lpuart.c                          |   15 
 drivers/tty/serial/pch_uart.c                            |   19 -
 drivers/tty/serial/qcom_geni_serial.c                    |   16 
 drivers/tty/serial/samsung_tty.c                         |    8 
 drivers/tty/serial/sh-sci.c                              |    2 
 drivers/tty/serial/zs.c                                  |  226 +++++---------
 drivers/tty/serial/zs.h                                  |    1 
 drivers/usb/cdns3/cdns3-gadget.c                         |   12 
 drivers/usb/cdns3/cdns3-plat.c                           |   11 
 drivers/usb/chipidea/core.c                              |   16 
 drivers/usb/class/cdc-acm.c                              |    2 
 drivers/usb/class/cdc-acm.h                              |    2 
 drivers/usb/class/usbtmc.c                               |   14 
 drivers/usb/core/config.c                                |    9 
 drivers/usb/core/hcd.c                                   |    4 
 drivers/usb/core/quirks.c                                |    4 
 drivers/usb/dwc2/hcd.c                                   |    4 
 drivers/usb/dwc3/dwc3-xilinx.c                           |   26 -
 drivers/usb/gadget/composite.c                           |    5 
 drivers/usb/gadget/function/f_fs.c                       |   26 +
 drivers/usb/gadget/function/f_hid.c                      |    3 
 drivers/usb/gadget/function/f_uvc.c                      |   28 +
 drivers/usb/gadget/udc/dummy_hcd.c                       |    4 
 drivers/usb/gadget/udc/net2280.c                         |    4 
 drivers/usb/host/xhci-tegra.c                            |   79 ++--
 drivers/usb/musb/omap2430.c                              |    3 
 drivers/usb/serial/belkin_sa.c                           |    3 
 drivers/usb/serial/cypress_m8.c                          |   20 +
 drivers/usb/serial/digi_acceleport.c                     |   23 +
 drivers/usb/serial/keyspan.c                             |    4 
 drivers/usb/serial/mct_u232.c                            |    5 
 drivers/usb/serial/mxuport.c                             |    8 
 drivers/usb/serial/omninet.c                             |    9 
 drivers/usb/serial/option.c                              |    9 
 drivers/usb/serial/safe_serial.c                         |   11 
 drivers/usb/storage/unusual_uas.h                        |    7 
 drivers/usb/typec/altmodes/displayport.c                 |    2 
 drivers/usb/typec/tcpm/tcpci_maxim_core.c                |    9 
 drivers/usb/typec/tcpm/tcpm.c                            |  117 ++++---
 drivers/usb/typec/tcpm/wcove.c                           |   13 
 drivers/usb/typec/ucsi/displayport.c                     |    4 
 drivers/usb/typec/ucsi/ucsi.c                            |   24 +
 drivers/usb/typec/ucsi/ucsi_ccg.c                        |    5 
 drivers/usb/usbip/vudc_dev.c                             |    1 
 drivers/usb/usbip/vudc_transfer.c                        |    3 
 fs/fcntl.c                                               |    1 
 fs/file_table.c                                          |    1 
 fs/hpfs/alloc.c                                          |    2 
 fs/hugetlbfs/inode.c                                     |    5 
 fs/notify/fanotify/fanotify.c                            |    1 
 fs/notify/fanotify/fanotify_user.c                       |    1 
 fs/overlayfs/copy_up.c                                   |    1 
 fs/proc/base.c                                           |    1 
 fs/smb/server/smbacl.c                                   |    8 
 include/asm-generic/ring_buffer.h                        |   13 
 include/drm/display/drm_dp.h                             |    1 
 include/kunit/test.h                                     |    1 
 include/linux/compat.h                                   |    4 
 include/linux/compiler-clang.h                           |    6 
 include/linux/compiler_attributes.h                      |   11 
 include/linux/compiler_types.h                           |    4 
 include/linux/hid.h                                      |   17 -
 include/linux/hid_bpf.h                                  |   14 
 include/linux/memfd.h                                    |   23 -
 include/linux/mm.h                                       |   55 ---
 include/linux/netdevice_xmit.h                           |   10 
 include/linux/parport.h                                  |    1 
 include/linux/serdev.h                                   |    1 
 include/linux/skbuff.h                                   |    2 
 include/linux/syscalls.h                                 |    4 
 include/media/rc-core.h                                  |    2 
 include/net/inet_frag.h                                  |   18 -
 include/net/ipv6_frag.h                                  |    9 
 include/net/xfrm.h                                       |    3 
 io_uring/io_uring.c                                      |    1 
 ipc/util.c                                               |    2 
 kernel/bpf/bpf_inode_storage.c                           |    1 
 kernel/bpf/bpf_task_storage.c                            |    1 
 kernel/bpf/token.c                                       |    1 
 kernel/events/core.c                                     |   16 
 kernel/exit.c                                            |    1 
 kernel/module/dups.c                                     |    1 
 kernel/module/kmod.c                                     |    1 
 kernel/trace/ring_buffer.c                               |   22 +
 kernel/umh.c                                             |    1 
 lib/debugobjects.c                                       |    2 
 lib/kunit/executor.c                                     |   19 -
 lib/kunit/test.c                                         |    1 
 mm/damon/sysfs-schemes.c                                 |    8 
 mm/memfd.c                                               |   56 +++
 mm/memory.c                                              |    2 
 mm/mmap.c                                                |   12 
 mm/page_alloc.c                                          |    1 
 mm/shmem.c                                               |    6 
 net/batman-adv/bat_iv_ogm.c                              |   82 ++++-
 net/batman-adv/bat_v_ogm.c                               |   59 ++-
 net/batman-adv/bridge_loop_avoidance.c                   |   57 ++-
 net/batman-adv/soft-interface.c                          |    1 
 net/batman-adv/tp_meter.c                                |   67 ++--
 net/batman-adv/translation-table.c                       |   57 ++-
 net/batman-adv/tvlv.c                                    |   28 +
 net/batman-adv/tvlv.h                                    |    2 
 net/batman-adv/types.h                                   |   42 ++
 net/bluetooth/6lowpan.c                                  |    2 
 net/bluetooth/hci_sync.c                                 |   12 
 net/bluetooth/hidp/core.c                                |   23 +
 net/bluetooth/iso.c                                      |   12 
 net/bluetooth/l2cap_core.c                               |   41 ++
 net/bluetooth/l2cap_sock.c                               |   16 
 net/bridge/netfilter/ebtables.c                          |   30 +
 net/core/filter.c                                        |    2 
 net/core/skbuff.c                                        |   45 ++
 net/ethtool/cmis.h                                       |   19 -
 net/ethtool/cmis_cdb.c                                   |   89 ++++-
 net/ethtool/cmis_fw_update.c                             |  152 +++++++--
 net/ethtool/coalesce.c                                   |    6 
 net/ethtool/eeprom.c                                     |   10 
 net/ethtool/linkstate.c                                  |    6 
 net/ethtool/module.c                                     |   26 -
 net/ethtool/netlink.c                                    |    4 
 net/ethtool/netlink.h                                    |    4 
 net/ethtool/pse-pd.c                                     |   10 
 net/ethtool/rss.c                                        |    3 
 net/ethtool/strset.c                                     |    2 
 net/handshake/genl.c                                     |    3 
 net/handshake/genl.h                                     |    1 
 net/handshake/handshake-test.c                           |    2 
 net/handshake/handshake.h                                |    6 
 net/handshake/netlink.c                                  |   22 -
 net/handshake/request.c                                  |   64 ++-
 net/handshake/tlshd.c                                    |    6 
 net/hsr/hsr_forward.c                                    |    4 
 net/hsr/hsr_framereg.c                                   |    6 
 net/ipv4/ah4.c                                           |    2 
 net/ipv4/esp4.c                                          |    4 
 net/ipv4/inet_fragment.c                                 |   51 ++-
 net/ipv4/ip_fragment.c                                   |   18 -
 net/ipv4/ip_tunnel_core.c                                |   22 -
 net/ipv4/sysctl_net_ipv4.c                               |    2 
 net/ipv6/ah6.c                                           |    2 
 net/ipv6/datagram.c                                      |   54 ++-
 net/ipv6/esp6.c                                          |    4 
 net/ipv6/exthdrs.c                                       |    6 
 net/ipv6/ip6_vti.c                                       |   23 -
 net/ipv6/route.c                                         |    5 
 net/iucv/af_iucv.c                                       |   20 -
 net/key/af_key.c                                         |    6 
 net/l2tp/l2tp_core.c                                     |   11 
 net/mctp/device.c                                        |    1 
 net/mctp/neigh.c                                         |    1 
 net/mctp/route.c                                         |    1 
 net/mptcp/pm.c                                           |   40 ++
 net/mptcp/pm_netlink.c                                   |   16 
 net/mptcp/protocol.c                                     |   92 +++--
 net/mptcp/protocol.h                                     |    3 
 net/mptcp/subflow.c                                      |    8 
 net/netfilter/nf_conntrack_proto_tcp.c                   |    3 
 net/netfilter/nf_synproxy_core.c                         |    2 
 net/netfilter/xt_cpu.c                                   |    2 
 net/netlink/af_netlink.c                                 |   11 
 net/nfc/hci/core.c                                       |   10 
 net/nfc/llcp_core.c                                      |   11 
 net/nfc/llcp_sock.c                                      |    2 
 net/nfc/nci/hci.c                                        |   10 
 net/rxrpc/ar-internal.h                                  |   12 
 net/rxrpc/call_event.c                                   |   27 -
 net/rxrpc/call_object.c                                  |    2 
 net/rxrpc/conn_event.c                                   |   32 -
 net/rxrpc/insecure.c                                     |    8 
 net/rxrpc/recvmsg.c                                      |   68 +++-
 net/rxrpc/rxkad.c                                        |  115 ++-----
 net/sched/act_mirred.c                                   |   83 +++--
 net/sched/cls_fw.c                                       |    6 
 net/sched/sch_netem.c                                    |   47 --
 net/sched/sch_sfb.c                                      |    2 
 net/sctp/socket.c                                        |    2 
 net/smc/af_smc.c                                         |    4 
 net/vmw_vsock/af_vsock.c                                 |   49 +--
 net/vmw_vsock/hyperv_transport.c                         |    9 
 net/vmw_vsock/virtio_transport_common.c                  |   14 
 net/vmw_vsock/vmci_transport.c                           |    8 
 net/xfrm/xfrm_input.c                                    |   16 
 net/xfrm/xfrm_policy.c                                   |   17 -
 net/xfrm/xfrm_state.c                                    |   23 +
 net/xfrm/xfrm_user.c                                     |    5 
 security/apparmor/domain.c                               |    1 
 sound/core/oss/pcm_oss.c                                 |   18 -
 sound/firewire/motu/motu-register-dsp-message-parser.c   |   14 
 sound/soc/codecs/simple-mux.c                            |    2 
 sound/soc/intel/boards/bytcht_es8316.c                   |   29 +
 sound/soc/qcom/qdsp6/q6asm-dai.c                         |   43 +-
 sound/usb/mixer_scarlett2.c                              |   38 ++
 tools/testing/cxl/test/cxl.c                             |  105 ++----
 tools/testing/selftests/mm/hmm-tests.c                   |   50 +++
 tools/testing/selftests/net/mptcp/mptcp_connect.sh       |    6 
 tools/testing/selftests/net/mptcp/mptcp_lib.sh           |   10 
 383 files changed, 3929 insertions(+), 2242 deletions(-)

Abdurrahman Hussain (3):
      hwmon: (pmbus/adm1266) serialize sequencer_state debugfs read with pmbus_lock
      hwmon: (pmbus/adm1266) serialize NVMEM blackbox read with pmbus_lock
      hwmon: (pmbus/adm1266) serialize GPIO PMBus accesses with pmbus_lock

Ada Couprie Diaz (14):
      arm64: debug: clean up single_step_handler logic
      arm64: refactor aarch32_break_handler()
      arm64: debug: call software breakpoint handlers statically
      arm64: debug: call step handlers statically
      arm64: debug: remove break/step handler registration infrastructure
      arm64: entry: Add entry and exit functions for debug exceptions
      arm64: debug: split hardware breakpoint exception entry
      arm64: debug: refactor reinstall_suspended_bps()
      arm64: debug: split single stepping exception entry
      arm64: debug: split hardware watchpoint exception entry
      arm64: debug: split brk64 exception entry
      arm64: debug: split bkpt32 exception entry
      arm64: debug: remove debug exception registration infrastructure
      arm64: debug: always unmask interrupts in el0_softstp()

Advait Dhamorikar (1):
      iio: magnetometer: st_magn: fix default DRDY pin selection for LIS2MDL

Al Viro (1):
      remove pointless includes of <linux/fdtable.h>

Aldo Conte (1):
      iio: light: cm3323: fix reg_conf not being initialized correctly

Aleksandr Nogikh (1):
      x86/kexec: Disable KCOV instrumentation after load_segments()

Alexander Stein (1):
      gpio: mxc: fix irq_high handling

Alexandra Winter (1):
      net/smc: Do not re-initialize smc hashtables

Alexandru Hossu (1):
      scsi: target: iscsi: Validate CHAP_R length before base64 decode

Alexis Lothoré (eBPF Foundation) (1):
      x86/ftrace: Relocate %rip-relative percpu refs in dynamic trampolines

Ali Ganiyev (1):
      ksmbd: OOB read regression in smb_check_perm_dacl() ACE-walk loops

Alistair Popple (1):
      mm/memory: fix spurious warning when unmapping device-private/exclusive pages

Antoniu Miclaus (2):
      iio: gyro: adis16260: fix division by zero in write_raw
      iio: chemical: scd30: fix division by zero in write_raw

Arnd Bergmann (1):
      iommu, debugobjects: avoid gcc-16.1 section mismatch warnings

Ashutosh Desai (1):
      nfc: hci: fix out-of-bounds read in HCP header parsing

Ben Hutchings (1):
      parport: Fix race between port and client registration

Benjamin Tissoires (2):
      HID: pass the buffer size to hid_report_raw_event
      HID: core: introduce hid_safe_input_report()

Benoît Monin (1):
      iio: buffer: Fix DMA fence leak in iio_buffer_enqueue_dmabuf()

Berkant Koc (2):
      drm/hyperv: validate resolution_count and fix WIN8 fallback
      drm/hyperv: validate VMBus packet size in receive callback

Björn Töpel (1):
      net: Avoid checksumming unreadable skb tail on trim

Breno Leitao (1):
      net/iucv: fix locking in .getsockopt

Brian Gerst (1):
      x86/boot: Disable stack protector for early boot code

Carl Lee (1):
      nfc: nxp-nci: i2c: use rising-edge IRQ on ACPI systems

Chris Mason (1):
      netfilter: synproxy: refresh tcphdr after skb_ensure_writable

Christofer Jonason (1):
      iio: adc: xilinx-xadc: Fix sequencer mode in postdisable for dual mux

Chuck Lever (5):
      net/handshake: Use spin_lock_bh for hn_lock
      nvme-tcp: store negative errno in queue->tls_err
      net/handshake: Pass negative errno through handshake_complete()
      net/handshake: Take a long-lived file reference at submit
      net/handshake: Drain pending requests at net namespace exit

Cássio Gabriel (5):
      ALSA: pcm: oss: Fix setup list UAF on proc write error
      ASoC: Intel: bytcht_es8316: Fix MCLK leak on init errors
      ASoC: codecs: simple-mux: Fix enum control bounds check
      ALSA: scarlett2: Allow flash writes ending at segment boundary
      ALSA: firewire-motu: Protect register DSP event queue positions

Dan Carpenter (3):
      accel/ivpu: prevent uninitialized data bug in debugfs
      gpio: virtuser: Fix uninitialized data bug in gpio_virtuser_direction_do_write()
      usb: dwc2: Fix use after free in debug code

Danielle Ratson (2):
      net: ethtool: Add new parameters and a function to support EPL
      net: ethtool: Add support for writing firmware blocks using EPL payload

David Ahern (1):
      xfrm: Check for underflow in xfrm_state_mtu

David Carlier (2):
      iio: adc: npcm: fix unbalanced clk_disable_unprepare()
      iio: gyro: itg3200: fix i2c read into the wrong stack location

David Francis (1):
      drm/amdkfd: Check for pdd drm file first in CRIU restore path

David Howells (2):
      rxrpc: Fix DATA decrypt vs splice() by copying data to buffer in recvmsg
      rxrpc: Fix RESPONSE packet verification to extract skb to a linear buffer

David Jeffery (1):
      scsi: core: Run queues for all non-SDEV_DEL devices from scsi_run_host_queues

Davide Caratti (1):
      net/sched: cls_fw: fix NULL dereference of "old" filters before change()

Dawei Feng (1):
      octeontx2-pf: avoid double free of pool->stack on AQ init failure

Dipayaan Roy (1):
      net: mana: Add NULL guards in teardown path to prevent panic on attach failure

Dmitriy Zharov (1):
      Input: xpad - add support for ASUS ROG RAIKIRI II

Dmitry Torokhov (3):
      Input: xpad - fix out-of-bounds access for Share button
      Input: elan_i2c - validate firmware size before use
      Input: atmel_mxt_ts - fix boundary check in mxt_prepare_cfg_mem

Doruk Tan Ozturk (1):
      Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync

Eric Dumazet (5):
      ipv4: free net->ipv4.sysctl_local_reserved_ports after unregister_net_sysctl_table()
      tunnels: load network headers after skb_cow() in iptunnel_pmtud_build_icmp[v6]()
      vxlan: do not reuse cached ip_hdr() value after skb_tunnel_check_pmtu()
      tunnels: do not assume transport header in iptunnel_pmtud_check_icmp()
      net/sched: act_mirred: add loop detection

Eric Huang (2):
      drm/amdkfd: fix NULL pointer bug in svm_range_set_attr
      drm/amdkfd: fix a vulnerability of integer overflow in kfd debugger

Felix Gu (1):
      iio: buffer: hw-consumer: fix use-after-free in error path

Florian Schmaus (1):
      kunit: fix use-after-free in debugfs when using kunit.filter

Florian Westphal (2):
      netfilter: xt_cpu: prefer raw_smp_processor_id
      netfilter: ebtables: fix OOB read in compat_mtw_from_user

Geoffrey D. Bennett (2):
      ALSA: scarlett2: Fix 2i2 Gen 4 direct monitor gain on firmware 2417
      ALSA: scarlett2: Return ENOSPC for out-of-bounds flash writes

Greg Kroah-Hartman (11):
      Input: usbtouchscreen - clamp NEXIO data_len/x_len to URB buffer size
      iio: imu: st_lsm6dsx: fix stack leak in tagged FIFO buffer
      usb: typec: ucsi: ccg: reject firmware images without a ':' record header
      usb: typec: tcpm: validate VDO count in Discover Identity ACK handlers
      usb: typec: tcpm: bound altmode_desc[] per iteration in svdm_consume_modes()
      usb: typec: ucsi: displayport: NAK DP_CMD_CONFIGURE without a payload VDO
      usb: typec: altmodes/displayport: validate count before reading Status Update VDO
      usb: typec: wcove: don't write past struct pd_message in wcove_read_rx_buffer()
      usb: typec: tcpm/tcpci_maxim: validate header NDO against RX_BYTE_CNT
      usb: typec: ucsi: validate connector number in ucsi_connector_change()
      Linux 6.12.93

Guangshuo Li (3):
      counter: Fix refcount leak in counter_alloc() error path
      usb: gadget: net2280: Fix double free in probe error path
      usb: gadget: f_hid: fix device reference leak in hidg_alloc()

Hamza Mahfooz (1):
      netfilter: conntrack: tcp: do not force CLOSE on invalid-seq RST without direction check

Heitor Alves de Siqueira (3):
      Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close
      usb: usbtmc: check URB actual_length for interrupt-IN notifications
      usb: usbtmc: reject interrupt endpoints with small wMaxPacketSize

Henri A (1):
      media: rc: igorplugusb: fix control request setup packet

Hongling Zeng (1):
      serial: sh-sci: fix memory region release in error path

Horatiu Vultur (1):
      phy: mscc: Use PHY_ID_MATCH_EXACT for VSC8584, VSC8582, VSC8575, VSC856X

Hyunwoo Kim (1):
      KVM: arm64: vgic-its: Drop the translation cache reference only for the erased entry

Ian Abbott (2):
      comedi: comedi_test: fix check for valid scan_begin_src in waveform_ai_cmdtest()
      comedi: comedi_test: Fix limiting of convert_arg in waveform_ai_cmdtest()

Ido Schimmel (1):
      ethtool: cmis_cdb: Fix incorrect read / write length extension

Ilya Maximets (2):
      net: netlink: fix sending unassigned nsid after assigned one
      net: netlink: don't set nsid on local notifications

Ingo Molnar (1):
      x86/alternatives: Rename 'apply_relocation()' to 'text_poke_apply_relocation()'

Jakub Kicinski (16):
      ethtool: rss: fix hkey leak when indir_size is 0
      ethtool: module: avoid leaking a netdev ref on module flash errors
      ethtool: module: check fw_flash_in_progress under rtnl_lock
      ethtool: module: fix cleanup if socket used for flashing multiple devices
      ethtool: cmis: require exact CDB reply length
      ethtool: cmis: fix u16-to-u8 truncation of msleep_pre_rpl
      ethtool: cmis: validate start_cmd_payload_size from module
      ethtool: cmis: validate fw->size against start_cmd_payload_size
      ethtool: coalesce: cap profile updates at NET_DIM_PARAMS_NUM_PROFILES
      ethtool: linkstate: fix unbalanced ethnl_ops_complete() on PHY lookup error
      ethtool: pse-pd: fix missing ethnl_ops_complete()
      ethtool: strset: fix header attribute index in ethnl_req_get_phydev()
      ethtool: eeprom: add missing ethnl_ops_begin() / _complete() during fallback
      ethtool: eeprom: add more safeties to EEPROM Netlink fallback
      inet: frags: add inet_frag_queue_flush()
      inet: frags: flush pending skbs in fqdir_pre_exit()

Jamal Hadi Salim (4):
      net/sched: Revert "net/sched: Restrict conditions for adding duplicating netems to qdisc tree"
      net/sched: fix packet loop on netem when duplicate is on
      net: Introduce skb tc depth field to track packet loops
      net/sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop

Jan Volckaert (1):
      USB: serial: option: add MeiG SRM813Q

Janusz Krzysztofik (1):
      drm/i915: Fix potential UAF in TTM object purge

Jason A. Donenfeld (1):
      wireguard: send: append trailer after expanding head

Jeremy Erazo (1):
      usb: gadget: composite: fix integer underflow in WebUSB GET_URL handling

Jeremy Kerr (1):
      net: mctp: ensure our nlmsg responses are initialised

Jiayuan Chen (2):
      ipv6: fix possible infinite loop in rt6_fill_node()
      ipv6: fix possible infinite loop in fib6_select_path()

Jingguo Tan (1):
      xfrm: esp: restore combined single-frag length gate

Johan Hovold (7):
      USB: serial: safe_serial: fix memory corruption with small endpoint
      USB: serial: omninet: fix memory corruption with small endpoint
      USB: serial: keyspan: fix missing indat transfer sanity check
      USB: serial: mxuport: fix memory corruption with small endpoint
      USB: serial: mct_u232: fix missing interrupt-in transfer sanity check
      USB: serial: cypress_m8: fix memory corruption with small endpoint
      USB: serial: digi_acceleport: fix memory corruption with small endpoints

Jonathan Cameron (1):
      iio: chemical: scd30: Use guard(mutex) to allow early returns

Jose Ignacio Tornos Martinez (1):
      ice: fix VF queue configuration with low MTU values

Jouni Högander (3):
      drm/i915/psr: Add defininitions for INTEL_WA_REGISTER_CAPS DPCD register
      drm/i915/psr: Read Intel DPCD workaround register
      drm/i915/psr: Apply Intel DPCD workaround when SDP on prior line used

Junrui Luo (1):
      macsec: fix replay protection at XPN lower-PN wrap

Justin Iurman (1):
      ipv6: exthdrs: refresh nh pointer after ipv6_hop_jumbo()

Kai Aizen (1):
      usb: gadget: uvc: hold opts->lock across XU walks in uvc_function_bind

Kevin Hao (1):
      net: cpsw_new: Fix potential unregister of netdev that has not been registered yet

Kito Xu (veritas501) (1):
      net/sched: act_mirred: Fix blockcast recursion bypass leading to stack overflow

Kuniyuki Iwashima (1):
      ip6: vti: Use ip6_tnl.net in vti6_changelink().

Lee Jones (3):
      nfc: llcp: Fix use-after-free in llcp_sock_release()
      nfc: llcp: Fix use-after-free race in nfc_llcp_recv_cc()
      HID: wacom: Fix OOB write in wacom_hid_set_device_mode()

Li Ming (1):
      cxl/test: Update mock dev array before calling platform_device_add()

Li Xiasong (1):
      mptcp: pm: fix ADD_ADDR timer infinite retry on option space insufficient

Linpu Yu (1):
      ipc: limit next_id allocation to the valid ID range

Liu Ye (1):
      mm/memfd: fix spelling and grammatical issues

Lorenzo Stoakes (1):
      mm: perform all memfd seal checks in a single place

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp

Luka Gejak (1):
      net: hsr: fix potential OOB access in supervision frame handling

Lukas Wunner (1):
      platform/x86/intel/vsec: Fix enable_cnt imbalance on PCIe error recovery

Maciej W. Rozycki (7):
      serial: zs: Fix swapped RI/DSR modem line transition counting
      serial: dz: Fix bootconsole message clobbering at chip reset
      serial: dz: Fix bootconsole handover lockup
      serial: dz: Convert to use a platform device
      serial: zs: Fix bootconsole handover lockup
      serial: zs: Switch to using channel reset
      serial: zs: Convert to use a platform device

Maoyi Xie (2):
      ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().
      xfrm: route MIGRATE notifications to caller's netns

Marco Scardovi (1):
      gpio: rockchip: convert bank->clk to devm_clk_get_enabled()

Masami Hiramatsu (Google) (1):
      ring-buffer: Flush and stop persistent ring buffer on panic

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: drop nanoseconds width specifier

Maíra Canal (2):
      drm/v3d: Fix use-after-free of CPU job query arrays on error path
      drm/v3d: Release indirect CSD GEM reference on CPU job free

Michael Bommarito (13):
      l2tp: use refcount_inc_not_zero in l2tp_session_get_by_ifname
      xfrm: ah: use skb_to_full_sk in async output callbacks
      usbip: vudc: Fix use after free bug in vudc_remove due to race condition
      usb: gadget: f_fs: copy only received bytes on short ep0 read
      usb: gadget: f_fs: serialize DMABUF cancel against request completion
      thunderbolt: property: Reject u32 wrap in tb_property_entry_valid()
      thunderbolt: property: Reject dir_len < 4 to prevent size_t underflow
      scsi: fcoe: Reject FIP descriptors with zero fip_dlen in CVL walker
      scsi: scsi_transport_fc: Widen FPIN pname walker counter to u32
      scsi: target: iscsi: Bound iscsi_encode_text_output() appends to rsp_buf
      net: hsr: defer node table free until after RCU readers
      thunderbolt: property: Cap recursion depth in __tb_property_parse_dir()
      scsi: target: iscsi: Fix CRC overread and double-free in iscsit_handle_text_cmd()

Michael Roth (1):
      KVM: SEV: Require in-GHCB scratch area if GHCB v2+ is in use

Michal Pecio (2):
      usb: core: Fix up Interrupt IN endpoints with bogus wBytesPerInterval
      usb: core: Fix SuperSpeed root hub wMaxPacketSize

Mikhail Gavrilov (1):
      mm/page_alloc: clear page->private in free_pages_prepare()

Mikulas Patocka (1):
      hpfs: fix a crash if hpfs_map_dnode_bitmap fails

Mingzhe Zou (1):
      bcache: fix uninitialized closure object

Minh Nguyen (1):
      net: skbuff: fix missing zerocopy reference in pskb_carve helpers

Mostafa Saleh (1):
      arm64: Introduce esr_is_ubsan_brk()

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

Nicolás Bazaes (1):
      Input: synaptics - add LEN2058 to SMBus passlist for ThinkPad E490

Oliver Hartkopp (1):
      bonding: refuse to enslave CAN devices

Oliver Neukum (1):
      media: rc: ttusbir: fix inverted error logic

Paolo Abeni (4):
      mptcp: cleanup fallback dummy mapping generation
      mptcp: reset rcv wnd on disconnect
      mptcp: introduce the mptcp_init_skb helper
      mptcp: handle first subflow closing consistently

Pavel Begunkov (1):
      net: skbuff: fix pskb_carve leaking zcopy pages

Peter Chen (2):
      usb: cdns3: plat: fix leaked usb2_phy initialization on usb3_phy acquisition failure
      usb: cdns3: plat: fix unbalanced pm_runtime_forbid() call permanently leaks the runtime PM usage counter across bind/unbind cycles

Peter Oberparleiter (1):
      s390/cio: Restore GFP_DMA for CHSC allocation

Prasanna S (1):
      serial: qcom-geni: fix UART_RX_PAR_EN bit position

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

Rahul Chandelkar (1):
      ipv6: rpl: fix hdrlen overflow in ipv6_rpl_srh_decompress()

Rodrigo Alencar (3):
      iio: dac: ad5686: fix input raw value check
      iio: dac: ad5686: acquire lock when doing powerdown control
      iio: dac: ad5686: fix ref bit initialization for single-channel parts

Salah Triki (4):
      iio: dac: max5821: fix return value check in powerdown sync
      iio: adc: mt6359: fix unchecked return value in mt6358_read_imp
      iio: adc: viperboard: Fix error handling in vprbrd_iio_read_raw
      iio: temperature: tsys01: fix broken PROM checksum validation

Sam Burkels (1):
      usb: storage: Add quirks for PNY Elite Portable SSD

Sanjay Chitroda (1):
      iio: ssp_sensors: cancel delayed work_refresh on remove

Sean Christopherson (7):
      KVM: SVM: Flush the current TLB when transitioning from xAVIC => x2AVIC
      KVM: SEV: Use the size of the PSC header as the minimum size for PSC requests
      KVM: SEV: WARN if KVM attempts to setup scratch area with min_len==0
      KVM: SEV: Compute the correct max length of the in-GHCB scratch area
      KVM: SEV: Check PSC request indices against the actual size of the buffer
      KVM: SEV: Use READ_ONCE() when reading entries/indices from PSC buffer
      KVM: SEV: Don't explicitly pass PSC buffer to snp_begin_psc()

Sean Young (1):
      media: rc: fix race between unregister and urb/irq callbacks

Sebastian Andrzej Siewior (1):
      net/sched: act_mirred: Move the recursion counter struct netdev_xmit

Sebastian Reichel (1):
      usb: typec: tcpm: improve handling of DISCOVER_MODES failures

SeongJae Park (1):
      mm/damon/sysfs-schemes: delete tried region in regions_rmdirs()

Seungjin Bae (1):
      usb: gadget: dummy_hcd: Reject hub port requests for non-existent ports

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

Sven Eckelmann (12):
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
      batman-adv: tt: prevent TVLV entry number overflow

Thomas Fourier (1):
      Input: ims-pcu - fix usb_free_coherent() size in ims_pcu_buffers_free()

Timur Kristóf (1):
      drm/amd/pm/si: Disregard vblank time when no displays are connected

Tudor Ambarus (1):
      tty: serial: samsung: Remove redundant port lock acquisition in rx helpers

Tushar Dave (1):
      iommu: Skip PASID validation for devices without PASID capability

Usama Arif (1):
      xfrm: move policy_bydst RCU sync from per-netns .exit to .pre_exit

Uwe Kleine-König (2):
      serdev: Provide a bustype shutdown function
      Bluetooth: hci_qca: Migrate to serdev specific shutdown function

Vicki Pfau (1):
      HID: core: Add printk_ratelimited variants to hid_warn() etc

Victor Nogueira (1):
      net/sched: act_mirred: Fix return code in early mirred redirect error paths

Victor Nogueria (1):
      net/sched: sch_sfb: Replace direct dequeue call with peek and qdisc_dequeue_peeked

Viken Dadhaniya (1):
      serial: qcom_geni: fix kfifo underflow when flush precedes DMA completion IRQ

Wanquan Zhong (1):
      USB: serial: option: add missing RSVD(5) flag for Rolling RW135R-GL

Wei-Cheng Chen (1):
      xhci: tegra: Fix ghost USB device on dual-role port unplug

Weiming Shi (2):
      tun: free page on short-frame rejection in tun_xdp_one()
      tun: free page on build_skb failure in tun_xdp_one()

Wentao Guan (1):
      USB: cdc-acm: Fix bit overlap and move quirk definitions to header

Wentao Liang (1):
      usb: musb: omap2430: Fix use-after-free in omap2430_probe()

Will Deacon (2):
      arm64: io: Rename ioremap_prot() to __ioremap_prot()
      arm64: io: Extract user memory type in ioremap_prot()

Xu Yang (1):
      usb: chipidea: core: convert ci_role_switch to local variable

Yeoreum Yun (1):
      perf: Fix dangling cgroup pointer in cpuctx

Yongchao Wu (1):
      usb: cdns3: gadget: fix request skipping after clearing halt

Yuqi Xu (1):
      bpf: sockmap: fix tail fragment offset in bpf_msg_push_data

Zeng Heng (1):
      arm64: tlb: Flush walk cache when unsharing PMD tables

Zhang Cen (2):
      USB: serial: belkin_sa: validate interrupt status length
      USB: serial: cypress_m8: validate interrupt packet headers

Zhao Dongdong (1):
      Bluetooth: 6lowpan: check skb_clone() return value in send_mcast_pkt()

Zhaoyang Yu (1):
      tty: serial: pch_uart: add check for dma_alloc_coherent()

Zhengchuan Liang (2):
      ipv6: exthdrs: refresh nh after handling HAO option
      xfrm: input: hold netns during deferred transport reinjection

Zhenghang Xiao (2):
      Bluetooth: l2cap: clear chan->ident on ECRED reconfiguration success
      sctp: fix race between sctp_wait_for_connect and peeloff

Ziyu Zhang (1):
      vsock: keep poll shutdown state consistent

hlleng (1):
      HID: quirks: Add ALWAYS_POLL quirk for SIGMACHIP USB mouse

