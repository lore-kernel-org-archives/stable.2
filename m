Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FC63F8EA1;
	Tue,  9 Jun 2026 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002379; cv=none; b=lWkrOro/FOYqaeUWZFG1dvIfy5aD97+41T/XjJkL9jjcE7DYTTf6sMBlkqy01h8N84T20Ue195tphSt/DzSbgy3EBm92MA234x1EQ2EiH4dCVx5rewdzmW4cciEIcWdMiGlySFev5wmO+LgfrPpLF+pojbIcTHtbSTxXPfIvjpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002379; c=relaxed/simple;
	bh=gOfY+dra1snBn/uhq4yPTPmPP2fAOsGrFgMYPbYs084=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=azzJr/54s2hIsn2ggAHn5QnTvVKy2lcOsHVmjSNsdWGuiYgUsELMOEARYpmO2IoZzmbaPmtAGxRgYi6JAoyt/vRyNQWIRUBMZ+4IXzzP3O1vMadimlOc/tLxr7fKSD4dx5T4KNjvHIvFksFDXqwbt0UMrmcmU9rJi/fV9HNC5+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fq6ouNiD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fq6ouNiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A5A1F00898;
	Tue,  9 Jun 2026 10:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781002374;
	bh=VvUZbgk8vOq3PzfZsNdYiTDYKdOnmQ/PT9D+JCMuimE=;
	h=From:To:Cc:Subject:Date;
	b=fq6ouNiDiynbTPaXL0PwL+WPsn8ZrRapZIeGeoseJlTOWa8pfSfngWy9VV/Ba4tnF
	 mipxRuHtp0IG2xCjRvo2qIl1VUrsagiXggAflchHqDIzWf0R33+qN4QI7Ibt3SqQ2R
	 EmqU8BOdP/tl/KrRcIAp/tn/q0uPe7wHPZ/sejwI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.35
Date: Tue,  9 Jun 2026 12:51:48 +0200
Message-ID: <2026060949-banish-fox-9ba4@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.35 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/netlink/genetlink-c.yaml                        |    9 
 Documentation/netlink/genetlink-legacy.yaml                   |    9 
 Documentation/netlink/genetlink.yaml                          |    9 
 Documentation/netlink/netlink-raw.yaml                        |    9 
 Documentation/netlink/specs/handshake.yaml                    |    8 
 Makefile                                                      |    2 
 arch/arm64/include/asm/tlb.h                                  |    2 
 arch/arm64/kvm/nested.c                                       |   33 -
 arch/arm64/kvm/pmu-emul.c                                     |    4 
 arch/arm64/kvm/vgic/vgic-its.c                                |    6 
 arch/mips/dec/platform.c                                      |  109 ++++
 arch/riscv/include/asm/syscall_wrapper.h                      |    4 
 arch/x86/kernel/cpu/cpuid-deps.c                              |    1 
 arch/x86/kernel/fpu/signal.c                                  |   11 
 arch/x86/kernel/ftrace.c                                      |    7 
 arch/x86/kvm/svm/avic.c                                       |   35 +
 arch/x86/kvm/svm/sev.c                                        |   76 ++-
 drivers/accel/rocket/rocket_gem.c                             |   17 
 drivers/android/binder/allocation.rs                          |    8 
 drivers/android/binder/process.rs                             |    7 
 drivers/android/binder/transaction.rs                         |   11 
 drivers/auxdisplay/line-display.c                             |    2 
 drivers/bluetooth/btusb.c                                     |    8 
 drivers/bluetooth/hci_qca.c                                   |   42 -
 drivers/comedi/drivers/comedi_test.c                          |    5 
 drivers/counter/counter-core.c                                |    3 
 drivers/cpufreq/intel_pstate.c                                |   13 
 drivers/gpio/gpio-adnp.c                                      |    4 
 drivers/gpio/gpio-mxc.c                                       |    2 
 drivers/gpio/gpio-rockchip.c                                  |   23 -
 drivers/gpio/gpio-virtuser.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c                       |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c                       |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                        |    7 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                      |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c         |    8 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                          |    3 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                    |    4 
 drivers/gpu/drm/bridge/sil-sii8620.c                          |    1 
 drivers/gpu/drm/drm_gem.c                                     |    2 
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c                     |  113 ++++-
 drivers/gpu/drm/i915/display/intel_display_core.h             |    1 
 drivers/gpu/drm/i915/display/intel_display_irq.c              |    8 
 drivers/gpu/drm/i915/display/intel_display_types.h            |    3 
 drivers/gpu/drm/i915/display/intel_dpcd.h                     |   15 
 drivers/gpu/drm/i915/display/intel_psr.c                      |   60 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c                       |   28 -
 drivers/gpu/drm/xe/xe_guc_ads.c                               |    5 
 drivers/hid/hid-ids.h                                         |    1 
 drivers/hid/hid-picolcd_cir.c                                 |    1 
 drivers/hid/hid-quirks.c                                      |    1 
 drivers/hid/wacom_sys.c                                       |   13 
 drivers/hid/wacom_wac.h                                       |    1 
 drivers/hwmon/pmbus/adm1266.c                                 |    7 
 drivers/hwmon/pmbus/pmbus.h                                   |    5 
 drivers/hwmon/pmbus/pmbus_core.c                              |    8 
 drivers/i2c/busses/i2c-davinci.c                              |    2 
 drivers/iio/adc/ad4695.c                                      |   23 -
 drivers/iio/adc/mt6359-auxadc.c                               |    1 
 drivers/iio/adc/npcm_adc.c                                    |   25 -
 drivers/iio/adc/viperboard_adc.c                              |    4 
 drivers/iio/adc/xilinx-xadc-core.c                            |   11 
 drivers/iio/buffer/industrialio-hw-consumer.c                 |    4 
 drivers/iio/chemical/mhz19b.c                                 |   17 
 drivers/iio/chemical/scd30_core.c                             |    2 
 drivers/iio/common/ssp_sensors/ssp_dev.c                      |    1 
 drivers/iio/dac/ad3530r.c                                     |   54 +-
 drivers/iio/dac/ad5686.c                                      |   56 +-
 drivers/iio/dac/ad5686.h                                      |    1 
 drivers/iio/dac/max5821.c                                     |    9 
 drivers/iio/gyro/adis16260.c                                  |    3 
 drivers/iio/gyro/itg3200_buffer.c                             |    2 
 drivers/iio/imu/adis16550.c                                   |    2 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c                |    2 
 drivers/iio/industrialio-buffer.c                             |    1 
 drivers/iio/inkern.c                                          |    6 
 drivers/iio/light/cm3323.c                                    |    5 
 drivers/iio/light/veml6070.c                                  |   14 
 drivers/iio/magnetometer/st_magn_core.c                       |   13 
 drivers/iio/pressure/bmp280-core.c                            |    2 
 drivers/iio/temperature/tsys01.c                              |    2 
 drivers/input/joystick/xpad.c                                 |   14 
 drivers/input/misc/ims-pcu.c                                  |    2 
 drivers/input/mouse/elan_i2c_core.c                           |    5 
 drivers/input/mouse/synaptics.c                               |    1 
 drivers/input/touchscreen/atmel_mxt_ts.c                      |    2 
 drivers/input/touchscreen/usbtouchscreen.c                    |    5 
 drivers/iommu/io-pgtable-arm-v7s.c                            |   18 
 drivers/mailbox/mailbox.c                                     |   15 
 drivers/mailbox/tegra-hsp.c                                   |    2 
 drivers/md/bcache/super.c                                     |    3 
 drivers/media/cec/core/cec-core.c                             |    2 
 drivers/media/common/siano/smsir.c                            |    1 
 drivers/media/i2c/ir-kbd-i2c.c                                |    2 
 drivers/media/pci/bt8xx/bttv-input.c                          |    3 
 drivers/media/pci/cx23885/cx23885-input.c                     |    1 
 drivers/media/pci/cx88/cx88-input.c                           |    3 
 drivers/media/pci/dm1105/dm1105.c                             |    1 
 drivers/media/pci/mantis/mantis_input.c                       |    1 
 drivers/media/pci/saa7134/saa7134-input.c                     |    1 
 drivers/media/pci/smipcie/smipcie-ir.c                        |    1 
 drivers/media/pci/ttpci/budget-ci.c                           |    1 
 drivers/media/rc/ati_remote.c                                 |    6 
 drivers/media/rc/ene_ir.c                                     |    2 
 drivers/media/rc/fintek-cir.c                                 |    3 
 drivers/media/rc/igorplugusb.c                                |    3 
 drivers/media/rc/iguanair.c                                   |    1 
 drivers/media/rc/img-ir/img-ir-hw.c                           |    3 
 drivers/media/rc/img-ir/img-ir-raw.c                          |    3 
 drivers/media/rc/imon.c                                       |    3 
 drivers/media/rc/ir-hix5hd2.c                                 |    2 
 drivers/media/rc/ir_toy.c                                     |    1 
 drivers/media/rc/ite-cir.c                                    |    2 
 drivers/media/rc/mceusb.c                                     |    1 
 drivers/media/rc/rc-ir-raw.c                                  |    5 
 drivers/media/rc/rc-loopback.c                                |    1 
 drivers/media/rc/rc-main.c                                    |    6 
 drivers/media/rc/redrat3.c                                    |    4 
 drivers/media/rc/st_rc.c                                      |    2 
 drivers/media/rc/streamzap.c                                  |    7 
 drivers/media/rc/sunxi-cir.c                                  |    1 
 drivers/media/rc/ttusbir.c                                    |    4 
 drivers/media/rc/winbond-cir.c                                |    2 
 drivers/media/rc/xbox_remote.c                                |    5 
 drivers/media/usb/au0828/au0828-input.c                       |    1 
 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c                   |    1 
 drivers/media/usb/dvb-usb/dvb-usb-remote.c                    |    6 
 drivers/media/usb/em28xx/em28xx-input.c                       |    1 
 drivers/misc/rp1/rp1_pci.c                                    |    1 
 drivers/net/bonding/bond_main.c                               |    6 
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c             |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c      |    2 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c |    4 
 drivers/net/ethernet/microsoft/mana/mana_en.c                 |   76 ++-
 drivers/net/macsec.c                                          |    3 
 drivers/net/phy/micrel.c                                      |   15 
 drivers/net/phy/mscc/mscc.h                                   |    8 
 drivers/net/phy/mscc/mscc_main.c                              |   23 -
 drivers/net/team/team_core.c                                  |   51 +-
 drivers/net/team/team_mode_loadbalance.c                      |    4 
 drivers/net/tun.c                                             |    5 
 drivers/net/vxlan/vxlan_core.c                                |    4 
 drivers/net/wireguard/send.c                                  |   20 
 drivers/nfc/nxp-nci/i2c.c                                     |   21 
 drivers/nvme/host/tcp.c                                       |    2 
 drivers/parport/share.c                                       |   11 
 drivers/platform/x86/intel/vsec.c                             |   91 ++--
 drivers/s390/cio/chsc.c                                       |    4 
 drivers/s390/cio/chsc_sch.c                                   |   20 
 drivers/s390/cio/scm.c                                        |    2 
 drivers/scsi/fcoe/fcoe_ctlr.c                                 |    2 
 drivers/scsi/scsi_lib.c                                       |   27 +
 drivers/scsi/scsi_transport_fc.c                              |   77 +--
 drivers/spi/spi-mem.c                                         |   15 
 drivers/staging/media/av7110/av7110_ir.c                      |    1 
 drivers/target/iscsi/iscsi_target.c                           |    5 
 drivers/target/iscsi/iscsi_target_auth.c                      |   19 
 drivers/target/iscsi/iscsi_target_nego.c                      |    7 
 drivers/target/iscsi/iscsi_target_parameters.c                |   62 ++
 drivers/target/iscsi/iscsi_target_parameters.h                |    2 
 drivers/thunderbolt/property.c                                |   32 +
 drivers/tty/serdev/core.c                                     |   21 
 drivers/tty/serial/8250/8250_dw.c                             |    2 
 drivers/tty/serial/8250/8250_port.c                           |    7 
 drivers/tty/serial/altera_jtaguart.c                          |    7 
 drivers/tty/serial/dz.c                                       |  171 +++----
 drivers/tty/serial/fsl_lpuart.c                               |   15 
 drivers/tty/serial/pch_uart.c                                 |   19 
 drivers/tty/serial/qcom_geni_serial.c                         |   16 
 drivers/tty/serial/samsung_tty.c                              |    8 
 drivers/tty/serial/sh-sci.c                                   |    2 
 drivers/tty/serial/zs.c                                       |  226 +++-------
 drivers/tty/serial/zs.h                                       |    1 
 drivers/usb/cdns3/cdns3-gadget.c                              |   12 
 drivers/usb/cdns3/cdns3-plat.c                                |   11 
 drivers/usb/chipidea/core.c                                   |   16 
 drivers/usb/class/cdc-acm.c                                   |    2 
 drivers/usb/class/cdc-acm.h                                   |    2 
 drivers/usb/class/usbtmc.c                                    |   14 
 drivers/usb/core/config.c                                     |    9 
 drivers/usb/core/hcd.c                                        |    4 
 drivers/usb/core/quirks.c                                     |    4 
 drivers/usb/dwc2/hcd.c                                        |    4 
 drivers/usb/dwc3/dwc3-xilinx.c                                |   27 -
 drivers/usb/gadget/composite.c                                |    5 
 drivers/usb/gadget/function/f_fs.c                            |   26 +
 drivers/usb/gadget/function/f_hid.c                           |    3 
 drivers/usb/gadget/function/f_uvc.c                           |   28 -
 drivers/usb/gadget/udc/dummy_hcd.c                            |    4 
 drivers/usb/gadget/udc/net2280.c                              |    4 
 drivers/usb/host/xhci-tegra.c                                 |   79 +--
 drivers/usb/musb/omap2430.c                                   |    3 
 drivers/usb/serial/belkin_sa.c                                |    3 
 drivers/usb/serial/cypress_m8.c                               |   20 
 drivers/usb/serial/digi_acceleport.c                          |   23 -
 drivers/usb/serial/keyspan.c                                  |    4 
 drivers/usb/serial/mct_u232.c                                 |   26 -
 drivers/usb/serial/mxuport.c                                  |    8 
 drivers/usb/serial/omninet.c                                  |    9 
 drivers/usb/serial/option.c                                   |    9 
 drivers/usb/serial/safe_serial.c                              |   11 
 drivers/usb/storage/unusual_uas.h                             |    7 
 drivers/usb/typec/altmodes/displayport.c                      |    2 
 drivers/usb/typec/tcpm/tcpci_maxim_core.c                     |    9 
 drivers/usb/typec/tcpm/tcpm.c                                 |  117 +++--
 drivers/usb/typec/tcpm/wcove.c                                |   13 
 drivers/usb/typec/tipd/core.c                                 |    1 
 drivers/usb/typec/ucsi/displayport.c                          |    4 
 drivers/usb/typec/ucsi/ucsi.c                                 |   24 -
 drivers/usb/typec/ucsi/ucsi_ccg.c                             |    5 
 drivers/usb/usbip/vudc_dev.c                                  |    1 
 drivers/usb/usbip/vudc_transfer.c                             |    3 
 fs/hpfs/alloc.c                                               |    2 
 fs/smb/client/cifsacl.c                                       |  116 +++--
 fs/smb/client/smb2pdu.c                                       |    2 
 fs/smb/server/smb2pdu.c                                       |   11 
 fs/smb/server/smbacl.c                                        |    8 
 include/kunit/test.h                                          |    1 
 include/linux/compat.h                                        |    4 
 include/linux/compiler-clang.h                                |    6 
 include/linux/compiler_attributes.h                           |   11 
 include/linux/compiler_types.h                                |    4 
 include/linux/hid.h                                           |    2 
 include/linux/if_team.h                                       |    3 
 include/linux/intel_vsec.h                                    |    4 
 include/linux/mailbox_controller.h                            |    3 
 include/linux/parport.h                                       |    1 
 include/linux/serdev.h                                        |    1 
 include/linux/serial_core.h                                   |   12 
 include/linux/syscalls.h                                      |    4 
 include/media/rc-core.h                                       |    2 
 include/net/netfilter/nf_tables.h                             |    7 
 include/net/xfrm.h                                            |    3 
 ipc/util.c                                                    |    2 
 lib/debugobjects.c                                            |    2 
 lib/kunit/executor.c                                          |   19 
 lib/kunit/test.c                                              |    1 
 mm/damon/sysfs-schemes.c                                      |    8 
 mm/memcontrol.c                                               |    6 
 mm/memfd.c                                                    |   12 
 mm/rmap.c                                                     |    2 
 mm/slab_common.c                                              |    2 
 mm/slub.c                                                     |    1 
 net/bluetooth/6lowpan.c                                       |    2 
 net/bluetooth/hci_conn.c                                      |    4 
 net/bluetooth/hci_sync.c                                      |   16 
 net/bluetooth/hidp/core.c                                     |   23 -
 net/bluetooth/iso.c                                           |   12 
 net/bluetooth/l2cap_core.c                                    |   41 +
 net/bluetooth/l2cap_sock.c                                    |   16 
 net/bridge/br_netlink.c                                       |   17 
 net/bridge/br_switchdev.c                                     |    1 
 net/bridge/br_sysfs_if.c                                      |   30 -
 net/bridge/netfilter/ebtables.c                               |   30 +
 net/core/devmem.c                                             |   11 
 net/core/filter.c                                             |    2 
 net/core/skbuff.c                                             |   45 +
 net/ethtool/cmis.h                                            |    4 
 net/ethtool/cmis_cdb.c                                        |    9 
 net/ethtool/cmis_fw_update.c                                  |   44 +
 net/ethtool/coalesce.c                                        |    6 
 net/ethtool/eeprom.c                                          |   10 
 net/ethtool/linkstate.c                                       |    6 
 net/ethtool/module.c                                          |   41 +
 net/ethtool/netlink.c                                         |    4 
 net/ethtool/netlink.h                                         |    4 
 net/ethtool/pse-pd.c                                          |   10 
 net/ethtool/rss.c                                             |   37 +
 net/ethtool/strset.c                                          |    2 
 net/ethtool/tsconfig.c                                        |   15 
 net/ethtool/tsinfo.c                                          |   19 
 net/handshake/genl.c                                          |    3 
 net/handshake/genl.h                                          |    1 
 net/handshake/handshake-test.c                                |    2 
 net/handshake/handshake.h                                     |    4 
 net/handshake/netlink.c                                       |    6 
 net/handshake/request.c                                       |   16 
 net/handshake/tlshd.c                                         |    6 
 net/hsr/hsr_forward.c                                         |    4 
 net/ipv4/ah4.c                                                |    2 
 net/ipv4/esp4.c                                               |    4 
 net/ipv4/ip_tunnel_core.c                                     |   22 
 net/ipv4/sysctl_net_ipv4.c                                    |    2 
 net/ipv6/ah6.c                                                |    2 
 net/ipv6/datagram.c                                           |   54 ++
 net/ipv6/esp6.c                                               |    4 
 net/ipv6/exthdrs.c                                            |    6 
 net/ipv6/ip6_vti.c                                            |   23 -
 net/ipv6/route.c                                              |    5 
 net/iucv/af_iucv.c                                            |   20 
 net/key/af_key.c                                              |    6 
 net/l2tp/l2tp_core.c                                          |   11 
 net/mctp/device.c                                             |    1 
 net/mctp/neigh.c                                              |    1 
 net/mctp/route.c                                              |    1 
 net/mptcp/fastopen.c                                          |    4 
 net/mptcp/mib.c                                               |    1 
 net/mptcp/mib.h                                               |    1 
 net/mptcp/protocol.c                                          |   65 ++
 net/mptcp/protocol.h                                          |   31 +
 net/mptcp/subflow.c                                           |    8 
 net/netfilter/nf_conntrack_proto_tcp.c                        |    3 
 net/netfilter/nf_synproxy_core.c                              |    2 
 net/netfilter/nft_bitwise.c                                   |   18 
 net/netfilter/nft_byteorder.c                                 |   13 
 net/netfilter/xt_cpu.c                                        |    2 
 net/netlink/af_netlink.c                                      |   11 
 net/nfc/hci/core.c                                            |   10 
 net/nfc/llcp_core.c                                           |   11 
 net/nfc/llcp_sock.c                                           |    2 
 net/nfc/nci/hci.c                                             |   10 
 net/rxrpc/ar-internal.h                                       |   14 
 net/rxrpc/call_event.c                                        |   22 
 net/rxrpc/call_object.c                                       |    2 
 net/rxrpc/conn_event.c                                        |   32 -
 net/rxrpc/insecure.c                                          |    8 
 net/rxrpc/recvmsg.c                                           |   68 ++-
 net/rxrpc/rxgk.c                                              |  147 ++----
 net/rxrpc/rxgk_app.c                                          |   46 --
 net/rxrpc/rxgk_common.h                                       |   66 +-
 net/rxrpc/rxkad.c                                             |  115 +----
 net/sched/cls_fw.c                                            |    6 
 net/sched/sch_netem.c                                         |   40 -
 net/sched/sch_sfb.c                                           |    2 
 net/sctp/socket.c                                             |    2 
 net/smc/af_smc.c                                              |    4 
 net/vmw_vsock/af_vsock.c                                      |   49 +-
 net/vmw_vsock/hyperv_transport.c                              |    9 
 net/vmw_vsock/virtio_transport_common.c                       |   26 -
 net/vmw_vsock/vmci_transport.c                                |    8 
 net/xfrm/xfrm_input.c                                         |   16 
 net/xfrm/xfrm_ipcomp.c                                        |   12 
 net/xfrm/xfrm_iptfs.c                                         |   29 +
 net/xfrm/xfrm_policy.c                                        |   17 
 net/xfrm/xfrm_state.c                                         |   23 -
 net/xfrm/xfrm_user.c                                          |    5 
 sound/core/oss/pcm_oss.c                                      |   18 
 sound/firewire/motu/motu-register-dsp-message-parser.c        |   11 
 sound/hda/codecs/realtek/alc269.c                             |    1 
 sound/soc/codecs/simple-mux.c                                 |    2 
 sound/soc/intel/boards/bytcht_es8316.c                        |   29 +
 sound/soc/qcom/qdsp6/q6asm-dai.c                              |   43 +
 sound/usb/mixer_scarlett2.c                                   |   33 +
 tools/bootconfig/main.c                                       |    4 
 tools/net/ynl/pyynl/ynl_gen_c.py                              |   31 +
 tools/testing/cxl/test/cxl.c                                  |  105 +---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh            |    6 
 tools/testing/selftests/net/mptcp/mptcp_lib.sh                |   10 
 348 files changed, 3346 insertions(+), 1734 deletions(-)

Abdurrahman Hussain (2):
      hwmon: (pmbus/adm1266) serialize sequencer_state debugfs read with pmbus_lock
      hwmon: (pmbus/adm1266) serialize GPIO PMBus accesses with pmbus_lock

Advait Dhamorikar (1):
      iio: magnetometer: st_magn: fix default DRDY pin selection for LIS2MDL

Aldo Conte (1):
      iio: light: cm3323: fix reg_conf not being initialized correctly

Alexander Stein (1):
      gpio: mxc: fix irq_high handling

Alexandra Winter (1):
      net/smc: Do not re-initialize smc hashtables

Alexandre Ghiti (1):
      mm: memcontrol: propagate NMI slab stats to memcg vmstats

Alexandru Hossu (1):
      scsi: target: iscsi: Validate CHAP_R length before base64 decode

Alexis Lothoré (eBPF Foundation) (1):
      x86/ftrace: Relocate %rip-relative percpu refs in dynamic trampolines

Ali Ganiyev (1):
      ksmbd: OOB read regression in smb_check_perm_dacl() ACE-walk loops

Alice Ryhl (1):
      rust_binder: avoid calling pending_oneway_finished() on TF_UPDATE_TXN

Andrei Vagin (1):
      Revert "x86/fpu: Refine and simplify the magic number check during signal return"

Antoniu Miclaus (2):
      iio: gyro: adis16260: fix division by zero in write_raw
      iio: chemical: scd30: fix division by zero in write_raw

Arnd Bergmann (1):
      iommu, debugobjects: avoid gcc-16.1 section mismatch warnings

Ashutosh Desai (1):
      nfc: hci: fix out-of-bounds read in HCP header parsing

Balasubramani Vivekanandan (1):
      drm/xe: Restore IDLEDLY regiter on engine reset

Bartosz Golaszewski (1):
      gpio: adnp: fix flow control regression caused by scoped_guard()

Ben Hutchings (1):
      parport: Fix race between port and client registration

Benoît Monin (1):
      iio: buffer: Fix DMA fence leak in iio_buffer_enqueue_dmabuf()

Berkant Koc (2):
      drm/hyperv: validate resolution_count and fix WIN8 fallback
      drm/hyperv: validate VMBus packet size in receive callback

Björn Töpel (1):
      net: Avoid checksumming unreadable skb tail on trim

Breno Leitao (1):
      net/iucv: fix locking in .getsockopt

Carl Lee (1):
      nfc: nxp-nci: i2c: use rising-edge IRQ on ACPI systems

Chaitanya Sabnis (1):
      i2c: davinci: fix division by zero on missing clock-frequency

Chris Mason (1):
      netfilter: synproxy: refresh tcphdr after skb_ensure_writable

Christian König (1):
      drm/amdgpu: fix calling VM invalidation in amdgpu_hmm_invalidate_gfx

Christofer Jonason (1):
      iio: adc: xilinx-xadc: Fix sequencer mode in postdisable for dual mux

Chuck Lever (3):
      net/handshake: Use spin_lock_bh for hn_lock
      nvme-tcp: store negative errno in queue->tls_err
      net/handshake: Pass negative errno through handshake_complete()

Cássio Gabriel (4):
      ALSA: pcm: oss: Fix setup list UAF on proc write error
      ASoC: Intel: bytcht_es8316: Fix MCLK leak on init errors
      ASoC: codecs: simple-mux: Fix enum control bounds check
      ALSA: firewire-motu: Protect register DSP event queue positions

Dan Carpenter (3):
      gpio: virtuser: Fix uninitialized data bug in gpio_virtuser_direction_do_write()
      usb: dwc2: Fix use after free in debug code
      usb: typec: tipd: Fix error code in tps6598x_probe()

David Ahern (1):
      xfrm: Check for underflow in xfrm_state_mtu

David Carlier (3):
      iio: adc: npcm: fix unbalanced clk_disable_unprepare()
      iio: gyro: itg3200: fix i2c read into the wrong stack location
      net: devmem: reject dma-buf bind with non-page-aligned size or SG length

David E. Box (2):
      platform/x86/intel/vsec: Refactor base_addr handling
      platform/x86/intel/vsec: Make driver_data info const

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

Dev Jain (1):
      mm/rmap: initialize nr_pages to 1 at loop start in try_to_unmap_one

Dhabaleshwar Das (1):
      accel/rocket: fix UAF via dangling GEM handle in create_bo

Dipayaan Roy (2):
      net: mana: Add NULL guards in teardown path to prevent panic on attach failure
      net: mana: Skip redundant detach on already-detached port

Dmitriy Zharov (1):
      Input: xpad - add support for ASUS ROG RAIKIRI II

Dmitry Torokhov (3):
      Input: xpad - fix out-of-bounds access for Share button
      Input: elan_i2c - validate firmware size before use
      Input: atmel_mxt_ts - fix boundary check in mxt_prepare_cfg_mem

Doruk Tan Ozturk (1):
      Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync

Eric Dumazet (4):
      ipv4: free net->ipv4.sysctl_local_reserved_ports after unregister_net_sysctl_table()
      tunnels: load network headers after skb_cow() in iptunnel_pmtud_build_icmp[v6]()
      vxlan: do not reuse cached ip_hdr() value after skb_tunnel_check_pmtu()
      tunnels: do not assume transport header in iptunnel_pmtud_check_icmp()

Eric Huang (2):
      drm/amdkfd: fix NULL pointer bug in svm_range_set_attr
      drm/amdkfd: fix a vulnerability of integer overflow in kfd debugger

Felix Gu (2):
      iio: light: veml6070: Fix resource leak in probe error path
      iio: buffer: hw-consumer: fix use-after-free in error path

Fernando Fernandez Mancera (1):
      netfilter: nf_tables: fix dst corruption in same register operation

Florian Schmaus (1):
      kunit: fix use-after-free in debugfs when using kunit.filter

Florian Westphal (2):
      netfilter: xt_cpu: prefer raw_smp_processor_id
      netfilter: ebtables: fix OOB read in compat_mtw_from_user

Geoffrey D. Bennett (1):
      ALSA: scarlett2: Fix 2i2 Gen 4 direct monitor gain on firmware 2417

Greg Kroah-Hartman (13):
      Input: usbtouchscreen - clamp NEXIO data_len/x_len to URB buffer size
      iio: imu: st_lsm6dsx: fix stack leak in tagged FIFO buffer
      iio: imu: adis16550: fix stack leak in trigger handler
      iio: pressure: bmp280: fix stack leak in bmp580 trigger handler
      usb: typec: ucsi: ccg: reject firmware images without a ':' record header
      usb: typec: tcpm: validate VDO count in Discover Identity ACK handlers
      usb: typec: tcpm: bound altmode_desc[] per iteration in svdm_consume_modes()
      usb: typec: ucsi: displayport: NAK DP_CMD_CONFIGURE without a payload VDO
      usb: typec: altmodes/displayport: validate count before reading Status Update VDO
      usb: typec: wcove: don't write past struct pd_message in wcove_read_rx_buffer()
      usb: typec: tcpm/tcpci_maxim: validate header NDO against RX_BYTE_CNT
      usb: typec: ucsi: validate connector number in ucsi_connector_change()
      Linux 6.18.35

Guangshuo Li (3):
      counter: Fix refcount leak in counter_alloc() error path
      usb: gadget: net2280: Fix double free in probe error path
      usb: gadget: f_hid: fix device reference leak in hidg_alloc()

Guenter Roeck (1):
      hwmon: (pmbus) Add support for guarded PMBus lock

Hamza Mahfooz (1):
      netfilter: conntrack: tcp: do not force CLOSE on invalid-seq RST without direction check

Heitor Alves de Siqueira (4):
      Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close
      Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync()
      usb: usbtmc: check URB actual_length for interrupt-IN notifications
      usb: usbtmc: reject interrupt endpoints with small wMaxPacketSize

Henri A (1):
      media: rc: igorplugusb: fix control request setup packet

Herbert Xu (1):
      xfrm: ipcomp: Free destination pages on acomp errors

Hongling Zeng (1):
      serial: sh-sci: fix memory region release in error path

Hongtao Lee (1):
      tools/bootconfig: Fix buf leaks in apply_xbc

Horatiu Vultur (1):
      phy: mscc: Use PHY_ID_MATCH_EXACT for VSC8584, VSC8582, VSC8575, VSC856X

Hyunwoo Kim (2):
      KVM: arm64: vgic-its: Drop the translation cache reference only for the erased entry
      KVM: arm64: Reassign nested_mmus array behind mmu_lock

Ian Abbott (2):
      comedi: comedi_test: fix check for valid scan_begin_src in waveform_ai_cmdtest()
      comedi: comedi_test: Fix limiting of convert_arg in waveform_ai_cmdtest()

Ido Schimmel (2):
      bridge: Fix sleep in atomic context in netlink path
      bridge: Fix sleep in atomic context in sysfs path

Ilya Maximets (2):
      net: netlink: fix sending unassigned nsid after assigned one
      net: netlink: don't set nsid on local notifications

Jacques Nilo (3):
      serial: core: introduce guard(uart_port_lock_check_sysrq_irqsave)
      serial: 8250: dispatch SysRq character in serial8250_handle_irq()
      serial: 8250_dw: dispatch SysRq character in dw8250_handle_irq()

Jakub Kicinski (26):
      ethtool: rss: avoid modifying the RSS context response
      ethtool: rss: add missing errno on RSS context delete
      ethtool: rss: fix falsely ignoring indir table updates
      ethtool: rss: fix indir_table and hkey leak on get_rxfh failure
      ethtool: rss: fix hkey leak when indir_size is 0
      ethtool: rss: avoid device context leak on reply-build failure
      ethtool: module: call ethnl_ops_complete() on module flash errors
      ethtool: module: avoid leaking a netdev ref on module flash errors
      ethtool: module: avoid racy updates to dev->ethtool bitfield
      ethtool: module: check fw_flash_in_progress under rtnl_lock
      ethtool: module: fix cleanup if socket used for flashing multiple devices
      ethtool: cmis: require exact CDB reply length
      ethtool: cmis: fix u16-to-u8 truncation of msleep_pre_rpl
      ethtool: cmis: validate start_cmd_payload_size from module
      ethtool: cmis: validate fw->size against start_cmd_payload_size
      ethtool: coalesce: cap profile updates at NET_DIM_PARAMS_NUM_PROFILES
      ethtool: tsconfig: fix reply error handling
      ethtool: linkstate: fix unbalanced ethnl_ops_complete() on PHY lookup error
      ethtool: pse-pd: fix missing ethnl_ops_complete()
      ethtool: tsconfig: fix missing ethnl_ops_complete()
      ethtool: tsinfo: fix uninitialized stats on the by-PHC path
      ethtool: tsinfo: don't pass ERR_PTR to genlmsg_cancel on prepare failure
      ethtool: strset: fix header attribute index in ethnl_req_get_phydev()
      ethtool: eeprom: add missing ethnl_ops_begin() / _complete() during fallback
      ethtool: eeprom: add more safeties to EEPROM Netlink fallback
      tools: ynl: add scope qualifier for definitions

Jamal Hadi Salim (1):
      net/sched: Revert "net/sched: Restrict conditions for adding duplicating netems to qdisc tree"

Jan Volckaert (1):
      USB: serial: option: add MeiG SRM813Q

Janusz Krzysztofik (1):
      drm/i915: Fix potential UAF in TTM object purge

Jason A. Donenfeld (1):
      wireguard: send: append trailer after expanding head

Jassi Brar (1):
      mailbox: Fix NULL message support in mbox_send_message()

Jeremy Erazo (1):
      usb: gadget: composite: fix integer underflow in WebUSB GET_URL handling

Jeremy Kerr (1):
      net: mctp: ensure our nlmsg responses are initialised

Jiayuan Chen (2):
      ipv6: fix possible infinite loop in rt6_fill_node()
      ipv6: fix possible infinite loop in fib6_select_path()

Jijie Shao (1):
      net: hibmcge: disable Relaxed Ordering to fix RX packet corruption

Jingguo Tan (2):
      vsock/virtio: bind uarg before filling zerocopy skb
      xfrm: esp: restore combined single-frag length gate

Johan Hovold (8):
      USB: serial: safe_serial: fix memory corruption with small endpoint
      USB: serial: omninet: fix memory corruption with small endpoint
      USB: serial: keyspan: fix missing indat transfer sanity check
      USB: serial: mxuport: fix memory corruption with small endpoint
      USB: serial: mct_u232: fix missing interrupt-in transfer sanity check
      USB: serial: cypress_m8: fix memory corruption with small endpoint
      USB: serial: digi_acceleport: fix memory corruption with small endpoints
      USB: serial: mct_u232: fix memory corruption with small endpoint

Jouni Högander (5):
      drm/i915/psr: Add defininitions for INTEL_WA_REGISTER_CAPS DPCD register
      drm/i915/psr: Read Intel DPCD workaround register
      drm/i915/psr: Apply Intel DPCD workaround when SDP on prior line used
      drm/i915/psr: Block DC states on vblank enable when Panel Replay supported
      drm/i915/psr: Use DC_OFF wake reference to block DC6 on vblank enable

Junrui Luo (1):
      macsec: fix replay protection at XPN lower-PN wrap

Justin Iurman (1):
      ipv6: exthdrs: refresh nh pointer after ipv6_hop_jumbo()

Kai Aizen (1):
      usb: gadget: uvc: hold opts->lock across XU walks in uvc_function_bind

Kim Seer Paller (1):
      iio: dac: ad3530r: Fix AD3531/AD3531R powerdown mode strings

Kuniyuki Iwashima (1):
      ip6: vti: Use ip6_tnl.net in vti6_changelink().

Lee Jones (3):
      nfc: llcp: Fix use-after-free in llcp_sock_release()
      nfc: llcp: Fix use-after-free race in nfc_llcp_recv_cc()
      HID: wacom: Fix OOB write in wacom_hid_set_device_mode()

Li Ming (1):
      cxl/test: Update mock dev array before calling platform_device_add()

Linpu Yu (1):
      ipc: limit next_id allocation to the valid ID range

Liu Kai (1):
      HID: remove duplicate hid_warn_ratelimited definition

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

Marc Harvey (2):
      net: team: Remove unused team_mode_op, port_enabled
      net: team: Rename port_disabled team mode op to port_tx_disabled

Marco Scardovi (2):
      gpio: rockchip: convert bank->clk to devm_clk_get_enabled()
      gpio: rockchip: teardown bugs and resource leaks

Matthew Maurer (1):
      rust_binder: Avoid holding lock when dropping delivered_death

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: drop nanoseconds width specifier

Michael Bommarito (14):
      smb: client: validate the whole DACL before rewriting it in cifsacl
      l2tp: use refcount_inc_not_zero in l2tp_session_get_by_ifname
      xfrm: ah: use skb_to_full_sk in async output callbacks
      usbip: vudc: Fix use after free bug in vudc_remove due to race condition
      usb: gadget: f_fs: copy only received bytes on short ep0 read
      usb: gadget: f_fs: serialize DMABUF cancel against request completion
      thunderbolt: property: Reject u32 wrap in tb_property_entry_valid()
      thunderbolt: property: Reject dir_len < 4 to prevent size_t underflow
      scsi: fcoe: Reject FIP descriptors with zero fip_dlen in CVL walker
      scsi: scsi_transport_fc: Widen FPIN pname walker counter to u32
      scsi: target: iscsi: Fix CRC overread and double-free in iscsit_handle_text_cmd()
      scsi: target: iscsi: Bound iscsi_encode_text_output() appends to rsp_buf
      drm/amdgpu: fix lock leak on ENOMEM in AMDGPU_GEM_OP_GET_MAPPING_INFO
      thunderbolt: property: Cap recursion depth in __tb_property_parse_dir()

Michael Roth (1):
      KVM: SEV: Require in-GHCB scratch area if GHCB v2+ is in use

Michal Pecio (2):
      usb: core: Fix up Interrupt IN endpoints with bogus wBytesPerInterval
      usb: core: Fix SuperSpeed root hub wMaxPacketSize

Mikulas Patocka (1):
      hpfs: fix a crash if hpfs_map_dnode_bitmap fails

Mingzhe Zou (1):
      bcache: fix uninitialized closure object

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

Nathan Chancellor (1):
      Disable -Wattribute-alias for clang-23 and newer

Nicolás Bazaes (1):
      Input: synaptics - add LEN2058 to SMBus passlist for ThinkPad E490

Oliver Hartkopp (1):
      bonding: refuse to enslave CAN devices

Oliver Neukum (1):
      media: rc: ttusbir: fix inverted error logic

Paolo Abeni (4):
      mptcp: handle first subflow closing consistently
      mptcp: borrow forward memory from subflow
      mptcp: cleanup fallback dummy mapping generation
      mptcp: reset rcv wnd on disconnect

Pavel Begunkov (1):
      net: skbuff: fix pskb_carve leaking zcopy pages

Pavitra Jha (1):
      Bluetooth: hci_conn: Fix memory leak in hci_le_big_terminate()

Pengpeng Hou (1):
      iio: chemical: mhz19b: reject oversized serial replies

Peter Chen (2):
      usb: cdns3: plat: fix leaked usb2_phy initialization on usb3_phy acquisition failure
      usb: cdns3: plat: fix unbalanced pm_runtime_forbid() call permanently leaks the runtime PM usage counter across bind/unbind cycles

Peter Oberparleiter (1):
      s390/cio: Restore GFP_DMA for CHSC allocation

Prasanna S (1):
      serial: qcom-geni: fix UART_RX_PAR_EN bit position

Prathamesh Deshpande (1):
      net/mlx5: HWS: Reject unsupported remove-header action

Pratyush Yadav (Google) (1):
      memfd: deny writeable mappings when implying SEAL_WRITE

Qbeliw Tanaka (1):
      Input: xpad - add "Nova 2 Lite" from GameSir

Qi Tang (1):
      ipv6: validate extension header length before copying to cmsg

Qiang Ma (1):
      KVM: arm64: PMU: Preserve AArch32 counter low bits

Qing Wang (1):
      mm/slub: hold cpus_read_lock around flush_rcu_sheaves_on_cache()

Radhey Shyam Pandey (1):
      usb: dwc3: xilinx: fix error handling in zynqmp init error paths

Radu Sabau (1):
      iio: adc: ad4695: Fix call ordering in offload buffer postenable

Rafael J. Wysocki (2):
      cpufreq: intel_pstate: Add and use hybrid_get_cpu_type()
      cpufreq: intel_pstate: Use correct scaling factor on Raptor Lake-E

Rahul Chandelkar (1):
      ipv6: rpl: fix hdrlen overflow in ipv6_rpl_srh_decompress()

Robert Marko (1):
      net: phy: micrel: fix LAN8814 QSGMII soft reset

Rodrigo Alencar (4):
      iio: dac: ad5686: fix ref bit initialization for single-channel parts
      iio: dac: ad5686: fix input raw value check
      iio: dac: ad5686: acquire lock when doing powerdown control
      iio: dac: ad5686: fix powerdown control on dual-channel devices

Salah Triki (4):
      iio: dac: max5821: fix return value check in powerdown sync
      iio: adc: mt6359: fix unchecked return value in mt6358_read_imp
      iio: adc: viperboard: Fix error handling in vprbrd_iio_read_raw
      iio: temperature: tsys01: fix broken PROM checksum validation

Sam Burkels (1):
      usb: storage: Add quirks for PNY Elite Portable SSD

Sanjay Chitroda (1):
      iio: ssp_sensors: cancel delayed work_refresh on remove

Santhosh Kumar K (1):
      spi: spi-mem: avoid mutating op template in spi_mem_supports_op()

Sean Christopherson (8):
      KVM: SVM: Flush the current TLB when transitioning from xAVIC => x2AVIC
      KVM: SEV: Ignore Port I/O requests of length '0'
      KVM: SEV: Use the size of the PSC header as the minimum size for PSC requests
      KVM: SEV: WARN if KVM attempts to setup scratch area with min_len==0
      KVM: SEV: Compute the correct max length of the in-GHCB scratch area
      KVM: SEV: Check PSC request indices against the actual size of the buffer
      KVM: SEV: Use READ_ONCE() when reading entries/indices from PSC buffer
      KVM: SEV: Don't explicitly pass PSC buffer to snp_begin_psc()

Sean Shen (1):
      ksmbd: fix FSCTL permission bypass by adding a permission check for FSCTL_SET_SPARSE

Sean Young (1):
      media: rc: fix race between unregister and urb/irq callbacks

Sebastian Reichel (1):
      usb: typec: tcpm: improve handling of DISCOVER_MODES failures

SeongJae Park (1):
      mm/damon/sysfs-schemes: delete tried region in regions_rmdirs()

Seungjin Bae (1):
      usb: gadget: dummy_hcd: Reject hub port requests for non-existent ports

Shaomin Chen (1):
      xfrm: iptfs: reset runtime state when cloning SAs

Shardul Bankar (1):
      mptcp: do not drop partial packets

Shitalkumar Gandhi (1):
      serial: fsl_lpuart: fix rx buffer and DMA map leaks in start_rx_dma

Shuai Zhang (3):
      Bluetooth: btusb: Allow firmware re-download when version matches
      Bluetooth: hci_qca: Use 100 ms SSR delay for rampatch and NVM loading
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

Steve French (1):
      smb: client: fix uninitialized variable in smb2_writev_callback

Svyatoslav Ryhel (1):
      iio: Fix iio_multiply_value use in iio_read_channel_processed_scale

Thomas Fourier (1):
      Input: ims-pcu - fix usb_free_coherent() size in ims_pcu_buffers_free()

Timur Kristóf (1):
      drm/amd/pm/si: Disregard vblank time when no displays are connected

Tom Lendacky (1):
      x86/mm: Disable broadcast TLB flush when PCID is disabled

Tudor Ambarus (1):
      tty: serial: samsung: Remove redundant port lock acquisition in rx helpers

Usama Arif (1):
      xfrm: move policy_bydst RCU sync from per-netns .exit to .pre_exit

Uwe Kleine-König (2):
      serdev: Provide a bustype shutdown function
      Bluetooth: hci_qca: Migrate to serdev specific shutdown function

Victor Nogueria (1):
      net/sched: sch_sfb: Replace direct dequeue call with peek and qdisc_dequeue_peeked

Viken Dadhaniya (1):
      serial: qcom_geni: fix kfifo underflow when flush precedes DMA completion IRQ

Wanquan Zhong (1):
      USB: serial: option: add missing RSVD(5) flag for Rolling RW135R-GL

Wei-Cheng Chen (1):
      xhci: tegra: Fix ghost USB device on dual-role port unplug

Weiming Shi (3):
      tun: free page on short-frame rejection in tun_xdp_one()
      tun: free page on build_skb failure in tun_xdp_one()
      net: team: fix NULL pointer dereference in team_xmit during mode change

Wentao Guan (1):
      USB: cdc-acm: Fix bit overlap and move quirk definitions to header

Wentao Liang (1):
      usb: musb: omap2430: Fix use-after-free in omap2430_probe()

Xiaolei Wang (1):
      misc: rp1: Send IACK on IRQ activate to fix kdump/kexec

Xu Yang (1):
      usb: chipidea: core: convert ci_role_switch to local variable

Yongchao Wu (1):
      usb: cdns3: gadget: fix request skipping after clearing halt

Yuqi Xu (1):
      bpf: sockmap: fix tail fragment offset in bpf_msg_push_data

Zeng Heng (1):
      arm64: tlb: Flush walk cache when unsharing PMD tables

Zhang Cen (2):
      USB: serial: belkin_sa: validate interrupt status length
      USB: serial: cypress_m8: validate interrupt packet headers

Zhang Heng (1):
      ALSA: hda/realtek: Fix speaker output on ASUS ROG Strix G615LP

Zhao Dongdong (1):
      Bluetooth: 6lowpan: check skb_clone() return value in send_mcast_pkt()

Zhaoyang Yu (1):
      tty: serial: pch_uart: add check for dma_alloc_coherent()

Zhengchuan Liang (2):
      ipv6: exthdrs: refresh nh after handling HAO option
      xfrm: input: hold netns during deferred transport reinjection

Zhenghang Xiao (3):
      Bluetooth: l2cap: clear chan->ident on ECRED reconfiguration success
      sctp: fix race between sctp_wait_for_connect and peeloff
      drm/gem: fix race between change_handle and handle_delete

Ziyi Guo (1):
      drm/amdgpu: check num_entries in GEM_OP GET_MAPPING_INFO

Ziyu Zhang (1):
      vsock: keep poll shutdown state consistent

hlleng (1):
      HID: quirks: Add ALWAYS_POLL quirk for SIGMACHIP USB mouse

