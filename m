Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365058;
	b=hOlAaaFhADQ9yDHBHFrzQgIea2M4FVWaC19bRQr8Ks/ukDaTf1sPu5ccATChkV7COXSv
	 xelhJqXLOQ/QihsWnaUVFFcLd03Q0A4GyH+oj1WbhxOeTN4v0j4P7qvLu6YEWSWhJ57zG
	 klRUYGIlcy0YWfuojopzWVV2PBvKeQQ14OI0L21jbE+gHaynWom1jZ/RoXyMTCq/0pdlT
	 95tybzUOdGe2t/VtHkM5PqZw9JzrtmBGu0rrCwMETQqk2leIQCxBkELTvOaBWzsqLjR3b
	 77ZzJbwydTl3+C6jptFSTT1jzPzpTIsO4p294ixlSvoQPG/zXHzDxs1JkBV/S057hTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365058;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aK8zPgfuAlAgyWdTjtApvqmzP40ddWeW//50bwFyVJ0=;
	b=mP6F9NJ15hM0SYWuWzVTDz8gZ3V6xEek43rVK6ZcT1EPVp2LLwYVnNVe7l9V76NRk/87
	 iSOakW3T6MSVSIL/8jXeKb4YfRo/H5J+ixl41vxZSK87tvJi6pzCaidbcQekZ63y9FeaU
	 tO/9YMNCXqw6PmMMCUMMJjXS6gaoFs6ZhRCYiY5YHIwAPhn8qR5juqYFbPVLJ/0xTPv1K
	 7cdGjsF0VwYNylMgcZGVC3e88t2TFeklMIGbonD/bcJdcQNow1+K6wUorJZRrbyZtBYmN
	 JlAhgF9bST+IPuJ2aiGwPAobeHLSG/Oe05nrcOPHnzav+yJYkN/XFl1c5ATWWqL/ECA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=px9lipkk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EAC606A31A;
	Fri, 30 Oct 2026 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=px9lipkk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE181F00A16;
	Fri, 30 Oct 2026 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793365056;
	bh=aK8zPgfuAlAgyWdTjtApvqmzP40ddWeW//50bwFyVJ0=;
	h=From:To:Cc:Subject:Date;
	b=px9lipkkLmUETSD8TY55dn9vbL6RweoUY7J599MntJUV60uWw77kTzdLqoDncDyt/
	 O+HxFSD1gJQD4cT7lQ08juXGaCiJeeZi6X6Qttcy0LSdABedqg1xrLZIjoj5HbnbJ6
	 9bcRZmNAIVcF910ss97F7fQzCR7ktad3N5yDtevA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.273
Date: Fri, 30 Oct 2026 13:57:31 +0100
Message-ID: <2026103032-coeditor-escapable-2f14@gregkh>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.273 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arm64/silicon-errata.rst                                  |    2 
 Documentation/networking/strparser.rst                                  |    2 
 Makefile                                                                |    2 
 arch/arm64/Kconfig                                                      |   30 
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts                              |    9 
 arch/arm64/include/asm/cpucaps.h                                        |    2 
 arch/arm64/kernel/cpu_errata.c                                          |   23 
 arch/arm64/kernel/cpufeature.c                                          |    2 
 arch/arm64/kvm/vgic/vgic-its.c                                          |    8 
 arch/arm64/mm/fault.c                                                   |   14 
 arch/nios2/include/asm/checksum.h                                       |    2 
 arch/s390/kvm/guestdbg.c                                                |    2 
 arch/s390/kvm/kvm-s390.c                                                |    4 
 arch/s390/pci/pci_sysfs.c                                               |    3 
 arch/x86/events/intel/core.c                                            |   10 
 arch/x86/events/perf_event.h                                            |    2 
 arch/x86/kvm/mmu/mmu.c                                                  |    4 
 arch/x86/kvm/svm/svm.c                                                  |    3 
 arch/x86/kvm/vmx/nested.c                                               |   18 
 arch/x86/kvm/x86.h                                                      |    4 
 crypto/drbg.c                                                           |   11 
 drivers/base/property.c                                                 |   19 
 drivers/block/loop.c                                                    |   10 
 drivers/block/zram/zram_drv.c                                           |    6 
 drivers/bluetooth/btintel.c                                             |   15 
 drivers/bluetooth/btqcomsmd.c                                           |   10 
 drivers/bluetooth/btusb.c                                               |    2 
 drivers/char/hw_random/stm32-rng.c                                      |   12 
 drivers/dma/dmaengine.c                                                 |   30 
 drivers/edac/amd64_edac.c                                               |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c                                 |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                             |   25 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                                 |   17 
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c                                   |    9 
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c                                  |   25 
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                                   |    2 
 drivers/gpu/drm/amd/amdgpu/vi.c                                         |   21 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                       |    7 
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c                   |    1 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c                     |   10 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c                   |   11 
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c                               |   39 -
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c                                 |    5 
 drivers/gpu/drm/drm_fb_helper.c                                         |    8 
 drivers/gpu/drm/i915/display/intel_csr.c                                |   19 
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c                          |    2 
 drivers/gpu/drm/i915/gt/intel_rps.c                                     |    3 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                                 |    2 
 drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c                                |    2 
 drivers/gpu/drm/msm/dsi/dsi.h                                           |    8 
 drivers/gpu/drm/msm/dsi/dsi_cfg.h                                       |    2 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                      |   46 -
 drivers/gpu/drm/msm/dsi/dsi_manager.c                                   |  107 +-
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c                              |    2 
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c                              |    6 
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_7nm.c                               |    2 
 drivers/gpu/drm/msm/msm_gpu.c                                           |    1 
 drivers/gpu/drm/nouveau/nouveau_bo.c                                    |   49 -
 drivers/gpu/drm/nouveau/nouveau_bo.h                                    |    3 
 drivers/gpu/drm/nouveau/nouveau_chan.c                                  |    2 
 drivers/gpu/drm/nouveau/nouveau_gem.c                                   |   11 
 drivers/gpu/drm/radeon/radeon_bios.c                                    |    6 
 drivers/gpu/drm/vc4/vc4_bo.c                                            |    1 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                                     |   22 
 drivers/hid/hid-alps.c                                                  |   21 
 drivers/hid/hid-core.c                                                  |   26 
 drivers/hid/hid-steam.c                                                 |  211 +++--
 drivers/hid/i2c-hid/i2c-hid-core.c                                      |    5 
 drivers/hid/uhid.c                                                      |    8 
 drivers/hid/usbhid/hid-core.c                                           |   11 
 drivers/hv/connection.c                                                 |    1 
 drivers/hv/vmbus_drv.c                                                  |    1 
 drivers/hwmon/drivetemp.c                                               |   10 
 drivers/hwmon/gpio-fan.c                                                |    8 
 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c                     |   15 
 drivers/i2c/busses/i2c-at91-master.c                                    |    8 
 drivers/i2c/busses/i2c-mxs.c                                            |    5 
 drivers/i2c/busses/i2c-qcom-cci.c                                       |    4 
 drivers/i2c/busses/i2c-wmt.c                                            |    2 
 drivers/i2c/i2c-core-base.c                                             |   14 
 drivers/i3c/master.c                                                    |   20 
 drivers/iio/accel/kxcjk-1013.c                                          |    2 
 drivers/iio/accel/sca3000.c                                             |    2 
 drivers/iio/adc/aspeed_adc.c                                            |    4 
 drivers/iio/adc/max1363.c                                               |    8 
 drivers/iio/adc/sun4i-gpadc-iio.c                                       |   10 
 drivers/iio/gyro/adis16136.c                                            |    2 
 drivers/iio/imu/adis16400.c                                             |    2 
 drivers/iio/imu/adis16480.c                                             |    4 
 drivers/iio/light/gp2ap020a00f.c                                        |    2 
 drivers/iio/proximity/isl29501.c                                        |    2 
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c                       |    4 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                              |    3 
 drivers/input/keyboard/atkbd.c                                          |    8 
 drivers/input/mouse/byd.c                                               |    2 
 drivers/input/mouse/synaptics.c                                         |    7 
 drivers/input/serio/i8042-acpipnpio.h                                   |    9 
 drivers/input/touchscreen/s6sy761.c                                     |   14 
 drivers/iommu/iommu.c                                                   |    3 
 drivers/isdn/capi/capi.c                                                |    8 
 drivers/md/dm-cache-target.c                                            |   59 -
 drivers/md/dm-crypt.c                                                   |   10 
 drivers/md/dm-ebs-target.c                                              |    3 
 drivers/md/dm-integrity.c                                               |    5 
 drivers/md/dm-ioctl.c                                                   |   15 
 drivers/md/dm-snap.c                                                    |   14 
 drivers/md/dm-table.c                                                   |    2 
 drivers/media/pci/saa7164/saa7164-core.c                                |    6 
 drivers/memstick/core/memstick.c                                        |    8 
 drivers/memstick/host/rtsx_usb_ms.c                                     |   31 
 drivers/mmc/host/cavium-octeon.c                                        |    5 
 drivers/mmc/host/cavium-thunderx.c                                      |    5 
 drivers/mmc/host/mtk-sd.c                                               |    1 
 drivers/mmc/host/sdhci-sprd.c                                           |    4 
 drivers/mmc/host/via-sdmmc.c                                            |    4 
 drivers/mtd/devices/block2mtd.c                                         |    2 
 drivers/mtd/nand/raw/cadence-nand-controller.c                          |    6 
 drivers/mtd/nand/raw/vf610_nfc.c                                        |   85 +-
 drivers/mtd/nand/spi/core.c                                             |   21 
 drivers/net/bonding/bond_main.c                                         |   27 
 drivers/net/can/dev/dev.c                                               |    2 
 drivers/net/can/slcan.c                                                 |    1 
 drivers/net/ethernet/amazon/ena/ena_netdev.c                            |    1 
 drivers/net/ethernet/broadcom/bcmsysport.c                              |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                               |   23 
 drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c          |    4 
 drivers/net/ethernet/ibm/ibmveth.c                                      |    7 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                         |    6 
 drivers/net/gtp.c                                                       |   18 
 drivers/net/team/team.c                                                 |   67 +
 drivers/net/team/team_mode_loadbalance.c                                |    4 
 drivers/net/usb/ax88179_178a.c                                          |    6 
 drivers/net/usb/qmi_wwan.c                                              |    1 
 drivers/net/vxlan/vxlan_core.c                                          |   12 
 drivers/net/wireguard/noise.c                                           |    7 
 drivers/net/wireless/ath/ath11k/mac.c                                   |    1 
 drivers/net/wireless/ath/wcn36xx/dxe.c                                  |    2 
 drivers/net/wireless/ath/wcn36xx/smd.c                                  |    4 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c                 |   25 
 drivers/net/wireless/intel/iwlegacy/3945-mac.c                          |    1 
 drivers/net/wireless/intersil/p54/fwio.c                                |   42 -
 drivers/net/wireless/marvell/libertas/tx.c                              |    7 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c                   |   19 
 drivers/net/wireless/st/cw1200/bh.c                                     |    8 
 drivers/net/wireless/st/cw1200/txrx.c                                   |   14 
 drivers/net/wireless/ti/wl12xx/main.c                                   |    9 
 drivers/net/wireless/ti/wl18xx/main.c                                   |    2 
 drivers/net/wireless/ti/wlcore/main.c                                   |   10 
 drivers/net/wireless/ti/wlcore/wlcore.h                                 |    2 
 drivers/net/xen-netfront.c                                              |   16 
 drivers/nvme/host/core.c                                                |    3 
 drivers/nvme/host/multipath.c                                           |    5 
 drivers/nvme/host/tcp.c                                                 |  118 ++-
 drivers/nvme/target/configfs.c                                          |    9 
 drivers/nvme/target/core.c                                              |    2 
 drivers/of/irq.c                                                        |   14 
 drivers/of/overlay.c                                                    |   14 
 drivers/opp/core.c                                                      |    6 
 drivers/pci/pci.c                                                       |   15 
 drivers/pinctrl/sunxi/pinctrl-sunxi.c                                   |  197 +++--
 drivers/pinctrl/sunxi/pinctrl-sunxi.h                                   |  100 --
 drivers/power/supply/bq24257_charger.c                                  |   16 
 drivers/power/supply/ds2780_battery.c                                   |    2 
 drivers/power/supply/max17040_battery.c                                 |   10 
 drivers/power/supply/rt9455_charger.c                                   |   26 
 drivers/power/supply/ucs1002_power.c                                    |    6 
 drivers/regulator/ltc3676.c                                             |   15 
 drivers/rtc/rtc-spear.c                                                 |   11 
 drivers/s390/net/ctcm_mpc.c                                             |    3 
 drivers/scsi/ch.c                                                       |   30 
 drivers/scsi/libiscsi.c                                                 |   14 
 drivers/scsi/qedi/qedi_main.c                                           |    3 
 drivers/scsi/qla2xxx/qla_bsg.c                                          |   41 +
 drivers/scsi/qla2xxx/qla_init.c                                         |   17 
 drivers/scsi/qla2xxx/qla_iocb.c                                         |    4 
 drivers/scsi/qla2xxx/qla_mbx.c                                          |    4 
 drivers/scsi/qla2xxx/qla_mid.c                                          |   33 
 drivers/scsi/qla2xxx/qla_nvme.c                                         |   10 
 drivers/scsi/qla2xxx/qla_os.c                                           |   10 
 drivers/scsi/sd_zbc.c                                                   |   11 
 drivers/scsi/st.c                                                       |   18 
 drivers/soc/rockchip/pm_domains.c                                       |   20 
 drivers/spi/spi-bcm63xx.c                                               |    6 
 drivers/staging/greybus/uart.c                                          |   10 
 drivers/staging/media/zoran/zoran_card.c                                |    2 
 drivers/staging/octeon-usb/octeon-hcd.c                                 |    2 
 drivers/staging/rtl8723bs/core/rtw_mlme.c                               |    5 
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c                           |    4 
 drivers/staging/sm750fb/sm750.c                                         |    2 
 drivers/staging/sm750fb/sm750.h                                         |    2 
 drivers/staging/sm750fb/sm750_accel.c                                   |   10 
 drivers/staging/sm750fb/sm750_accel.h                                   |    4 
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c           |    3 
 drivers/target/iscsi/iscsi_target_configfs.c                            |   26 
 drivers/tee/optee/core.c                                                |   26 
 drivers/thunderbolt/ctl.c                                               |   47 -
 drivers/thunderbolt/xdomain.c                                           |    4 
 drivers/tty/amiserial.c                                                 |    9 
 drivers/tty/serial/kgdboc.c                                             |    9 
 drivers/tty/serial/max3100.c                                            |   15 
 drivers/tty/serial/qcom_geni_serial.c                                   |    5 
 drivers/tty/serial/serial-tegra.c                                       |   18 
 drivers/tty/serial/serial_core.c                                        |   11 
 drivers/tty/serial/vt8500_serial.c                                      |    1 
 drivers/tty/tty_io.c                                                    |   54 -
 drivers/tty/tty_port.c                                                  |   43 -
 drivers/tty/vcc.c                                                       |    5 
 drivers/tty/vt/vc_screen.c                                              |   25 
 drivers/tty/vt/vt.c                                                     |    5 
 drivers/usb/cdns3/cdns3-pci-wrap.c                                      |    5 
 drivers/usb/cdns3/gadget.c                                              |    4 
 drivers/usb/class/cdc-acm.c                                             |   46 -
 drivers/usb/class/cdc-acm.h                                             |    1 
 drivers/usb/core/hub.c                                                  |    7 
 drivers/usb/core/message.c                                              |    8 
 drivers/usb/gadget/function/f_fs.c                                      |   15 
 drivers/usb/gadget/function/f_mass_storage.c                            |    3 
 drivers/usb/gadget/function/f_uac1_legacy.c                             |    6 
 drivers/usb/gadget/udc/aspeed-vhub/core.c                               |    4 
 drivers/usb/gadget/udc/aspeed-vhub/dev.c                                |    2 
 drivers/usb/gadget/udc/aspeed-vhub/hub.c                                |    5 
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h                               |    1 
 drivers/usb/gadget/udc/dummy_hcd.c                                      |    4 
 drivers/usb/host/ohci-da8xx.c                                           |    2 
 drivers/usb/host/ohci-s3c2410.c                                         |    1 
 drivers/usb/host/ohci-spear.c                                           |    4 
 drivers/usb/host/ohci-st.c                                              |    1 
 drivers/usb/host/xhci.c                                                 |   12 
 drivers/usb/serial/bus.c                                                |    6 
 drivers/usb/serial/cp210x.c                                             |    1 
 drivers/usb/serial/generic.c                                            |   10 
 drivers/usb/serial/option.c                                             |   14 
 drivers/usb/serial/quatech2.c                                           |   19 
 drivers/usb/serial/ssu100.c                                             |   18 
 drivers/usb/serial/usb-serial.c                                         |  185 +++-
 drivers/usb/serial/usb_wwan.c                                           |    6 
 drivers/usb/storage/sierra_ms.c                                         |    7 
 drivers/usb/typec/tcpm/tcpm.c                                           |   37 
 drivers/usb/typec/ucsi/displayport.c                                    |    9 
 drivers/usb/typec/ucsi/ucsi.c                                           |   17 
 drivers/usb/typec/ucsi/ucsi_acpi.c                                      |   18 
 drivers/virt/nitro_enclaves/ne_misc_dev.c                               |    1 
 drivers/watchdog/rtd119x_wdt.c                                          |   21 
 fs/autofs/waitq.c                                                       |   25 
 fs/btrfs/scrub.c                                                        |    4 
 fs/ceph/export.c                                                        |   23 
 fs/ceph/mdsmap.c                                                        |    7 
 fs/cifs/cifsacl.c                                                       |   15 
 fs/cifs/cifsfs.c                                                        |   16 
 fs/cifs/cifsglob.h                                                      |    6 
 fs/cifs/connect.c                                                       |    1 
 fs/cifs/dir.c                                                           |   37 
 fs/cifs/inode.c                                                         |   29 
 fs/cifs/link.c                                                          |   15 
 fs/cifs/misc.c                                                          |    7 
 fs/cifs/smb1ops.c                                                       |   21 
 fs/cifs/smb2misc.c                                                      |    9 
 fs/cifs/smb2ops.c                                                       |   81 +-
 fs/cifs/smb2pdu.c                                                       |   79 +-
 fs/cifs/smb2pdu.h                                                       |    6 
 fs/cifs/transport.c                                                     |   70 +
 fs/dcache.c                                                             |    4 
 fs/f2fs/debug.c                                                         |    4 
 fs/f2fs/f2fs.h                                                          |   16 
 fs/f2fs/file.c                                                          |    5 
 fs/f2fs/gc.c                                                            |   30 
 fs/f2fs/gc.h                                                            |   14 
 fs/f2fs/recovery.c                                                      |   33 
 fs/f2fs/super.c                                                         |    4 
 fs/f2fs/sysfs.c                                                         |    8 
 fs/fcntl.c                                                              |    3 
 fs/fsopen.c                                                             |    3 
 fs/fuse/dir.c                                                           |    9 
 fs/fuse/file.c                                                          |    5 
 fs/inode.c                                                              |   15 
 fs/lockd/svcsubs.c                                                      |    2 
 fs/namespace.c                                                          |  115 ++-
 fs/nfsd/netns.h                                                         |    1 
 fs/nfsd/nfs2acl.c                                                       |   17 
 fs/nfsd/nfs4proc.c                                                      |   25 
 fs/nfsd/nfs4state.c                                                     |    3 
 fs/nfsd/vfs.c                                                           |    4 
 fs/notify/mark.c                                                        |   11 
 fs/ocfs2/dir.c                                                          |   71 +
 fs/ocfs2/dlm/dlmcommon.h                                                |    2 
 fs/ocfs2/dlm/dlmdebug.c                                                 |    5 
 fs/ocfs2/dlm/dlmrecovery.c                                              |    2 
 fs/pipe.c                                                               |    6 
 fs/unicode/utf8-core.c                                                  |    9 
 fs/verity/Kconfig                                                       |    3 
 fs/xfs/libxfs/xfs_alloc.c                                               |   61 +
 fs/xfs/libxfs/xfs_bmap.c                                                |    6 
 fs/xfs/libxfs/xfs_btree.c                                               |   10 
 fs/xfs/libxfs/xfs_ialloc.c                                              |   38 
 fs/xfs/libxfs/xfs_rtbitmap.c                                            |   22 
 fs/xfs/libxfs/xfs_sb.c                                                  |   17 
 fs/xfs/xfs_bmap_item.c                                                  |   76 +
 fs/xfs/xfs_buf.c                                                        |   24 
 fs/xfs/xfs_buf.h                                                        |   14 
 fs/xfs/xfs_buf_item.c                                                   |  382 ++++++----
 fs/xfs/xfs_buf_item.h                                                   |    3 
 fs/xfs/xfs_dquot_item.c                                                 |    5 
 fs/xfs/xfs_extfree_item.c                                               |    2 
 fs/xfs/xfs_fsops.c                                                      |    2 
 fs/xfs/xfs_icache.c                                                     |   10 
 fs/xfs/xfs_inode.c                                                      |    9 
 fs/xfs/xfs_inode_item.c                                                 |  162 +++-
 fs/xfs/xfs_inode_item.h                                                 |    1 
 fs/xfs/xfs_log.c                                                        |   50 -
 fs/xfs/xfs_log_cil.c                                                    |   12 
 fs/xfs/xfs_log_priv.h                                                   |    7 
 fs/xfs/xfs_log_recover.c                                                |   17 
 fs/xfs/xfs_qm.c                                                         |    7 
 fs/xfs/xfs_refcount_item.c                                              |   60 -
 fs/xfs/xfs_rmap_item.c                                                  |   75 +
 fs/xfs/xfs_rtalloc.c                                                    |   20 
 fs/xfs/xfs_rtalloc.h                                                    |    4 
 fs/xfs/xfs_symlink.c                                                    |    4 
 fs/xfs/xfs_trace.h                                                      |    4 
 fs/xfs/xfs_trans.c                                                      |    6 
 fs/xfs/xfs_trans.h                                                      |    3 
 fs/xfs/xfs_trans_buf.c                                                  |   16 
 include/linux/can/dev.h                                                 |    1 
 include/linux/can/skb.h                                                 |    2 
 include/linux/device-mapper.h                                           |    5 
 include/linux/devm-helpers.h                                            |   79 ++
 include/linux/dmaengine.h                                               |    7 
 include/linux/fsnotify_backend.h                                        |    1 
 include/linux/ftrace.h                                                  |    5 
 include/linux/futex.h                                                   |   14 
 include/linux/hid.h                                                     |    6 
 include/linux/highmem.h                                                 |    2 
 include/linux/i2c.h                                                     |    1 
 include/linux/if_team.h                                                 |    3 
 include/linux/if_vlan.h                                                 |    3 
 include/linux/key-type.h                                                |    1 
 include/linux/key.h                                                     |    5 
 include/linux/kprobes.h                                                 |    1 
 include/linux/lockd/lockd.h                                             |    2 
 include/linux/mm.h                                                      |    2 
 include/linux/mm_types.h                                                |    4 
 include/linux/mount.h                                                   |    2 
 include/linux/netlink.h                                                 |    3 
 include/linux/property.h                                                |    3 
 include/linux/qcom-geni-se.h                                            |   15 
 include/linux/sched/signal.h                                            |    5 
 include/linux/skbuff.h                                                  |   12 
 include/linux/tty.h                                                     |    2 
 include/linux/tty_driver.h                                              |    5 
 include/linux/unicode.h                                                 |    1 
 include/linux/usb/serial.h                                              |    1 
 include/net/bluetooth/hci_core.h                                        |    4 
 include/net/bluetooth/rfcomm.h                                          |    1 
 include/net/codel_impl.h                                                |    1 
 include/net/net_namespace.h                                             |    4 
 include/net/netfilter/nf_tables.h                                       |   16 
 include/net/netns/xfrm.h                                                |    1 
 include/net/strparser.h                                                 |   10 
 include/net/tcp.h                                                       |    4 
 include/uapi/linux/sched.h                                              |    5 
 io_uring/io_uring.c                                                     |    9 
 kernel/audit_tree.c                                                     |   24 
 kernel/bpf/arraymap.c                                                   |   13 
 kernel/bpf/verifier.c                                                   |    7 
 kernel/events/core.c                                                    |    2 
 kernel/fork.c                                                           |   20 
 kernel/futex/core.c                                                     |   49 -
 kernel/kprobes.c                                                        |   27 
 kernel/params.c                                                         |   59 -
 kernel/ptrace.c                                                         |    3 
 kernel/signal.c                                                         |    8 
 kernel/time/clockevents.c                                               |   33 
 kernel/time/tick-broadcast.c                                            |   34 
 kernel/time/tick-internal.h                                             |    2 
 kernel/trace/ftrace.c                                                   |   72 +
 kernel/trace/ring_buffer.c                                              |    6 
 kernel/trace/trace.h                                                    |    4 
 kernel/trace/trace_events_filter.c                                      |    6 
 kernel/trace/trace_events_hist.c                                        |   48 -
 kernel/trace/trace_functions.c                                          |    2 
 kernel/trace/trace_stack.c                                              |    2 
 kernel/watch_queue.c                                                    |   11 
 kernel/workqueue.c                                                      |    2 
 mm/huge_memory.c                                                        |    3 
 mm/hugetlb.c                                                            |   22 
 mm/ioremap.c                                                            |   45 +
 mm/mmap.c                                                               |   31 
 mm/mremap.c                                                             |   29 
 mm/rmap.c                                                               |    6 
 net/bluetooth/hci_core.c                                                |   12 
 net/bluetooth/hci_debugfs.c                                             |    2 
 net/bluetooth/hci_sock.c                                                |    2 
 net/bluetooth/l2cap_core.c                                              |    7 
 net/bluetooth/l2cap_sock.c                                              |   59 +
 net/bluetooth/mgmt.c                                                    |    9 
 net/bluetooth/rfcomm/core.c                                             |  134 ++-
 net/bluetooth/rfcomm/sock.c                                             |    5 
 net/bluetooth/rfcomm/tty.c                                              |   16 
 net/bridge/br_multicast.c                                               |   36 
 net/can/af_can.c                                                        |    6 
 net/can/bcm.c                                                           |    2 
 net/can/isotp.c                                                         |   11 
 net/can/j1939/socket.c                                                  |    1 
 net/can/j1939/transport.c                                               |    2 
 net/can/raw.c                                                           |    7 
 net/core/filter.c                                                       |    8 
 net/core/flow_dissector.c                                               |   26 
 net/core/net_namespace.c                                                |   19 
 net/core/page_pool.c                                                    |    6 
 net/hsr/hsr_framereg.c                                                  |    4 
 net/ipv4/fib_semantics.c                                                |    2 
 net/ipv4/ipconfig.c                                                     |   92 +-
 net/ipv4/ipmr.c                                                         |    3 
 net/ipv4/ipmr_base.c                                                    |    2 
 net/ipv4/tcp.c                                                          |    4 
 net/ipv4/tcp_bpf.c                                                      |    3 
 net/ipv4/tcp_dctcp.c                                                    |    2 
 net/ipv4/tcp_input.c                                                    |    6 
 net/ipv4/udp.c                                                          |    9 
 net/ipv6/ip6mr.c                                                        |    2 
 net/ipv6/seg6_iptunnel.c                                                |    2 
 net/mac80211/chan.c                                                     |   36 
 net/mac80211/fils_aead.c                                                |    8 
 net/mac80211/mesh_pathtbl.c                                             |   16 
 net/mac80211/mlme.c                                                     |    4 
 net/mac80211/sta_info.c                                                 |    6 
 net/mac80211/tx.c                                                       |    6 
 net/netfilter/ipset/ip_set_bitmap_gen.h                                 |    2 
 net/netfilter/ipvs/ip_vs_conn.c                                         |    3 
 net/netfilter/ipvs/ip_vs_lblc.c                                         |    4 
 net/netfilter/ipvs/ip_vs_lblcr.c                                        |    3 
 net/netfilter/ipvs/ip_vs_sync.c                                         |   33 
 net/netfilter/nf_tables_api.c                                           |   23 
 net/netfilter/nf_tables_core.c                                          |   29 
 net/netfilter/nf_tables_trace.c                                         |   44 -
 net/netfilter/nft_flow_offload.c                                        |    8 
 net/netlink/af_netlink.c                                                |   24 
 net/netlink/genetlink.c                                                 |   28 
 net/openvswitch/actions.c                                               |    7 
 net/openvswitch/conntrack.c                                             |   23 
 net/openvswitch/datapath.c                                              |    8 
 net/packet/af_packet.c                                                  |    6 
 net/rds/rdma_transport.c                                                |   26 
 net/rds/tcp.c                                                           |    9 
 net/sched/act_api.c                                                     |   20 
 net/sched/cls_flower.c                                                  |    5 
 net/sched/cls_u32.c                                                     |   43 -
 net/sched/em_text.c                                                     |    3 
 net/sched/sch_codel.c                                                   |    2 
 net/sched/sch_fq_codel.c                                                |    4 
 net/sctp/inqueue.c                                                      |    6 
 net/sctp/socket.c                                                       |   39 -
 net/smc/af_smc.c                                                        |    7 
 net/smc/smc_core.c                                                      |   14 
 net/strparser/strparser.c                                               |    6 
 net/sunrpc/auth_gss/gss_rpc_xdr.c                                       |   15 
 net/tipc/crypto.c                                                       |   20 
 net/tipc/node.c                                                         |   12 
 net/tipc/topsrv.c                                                       |   80 +-
 net/tls/tls_device.c                                                    |    7 
 net/vmw_vsock/af_vsock.c                                                |   17 
 net/wireless/lib80211_crypt_tkip.c                                      |   13 
 net/wireless/scan.c                                                     |   29 
 net/xfrm/xfrm_policy.c                                                  |   19 
 samples/pidfd/Makefile                                                  |    2 
 security/apparmor/include/label.h                                       |    6 
 security/keys/key.c                                                     |   19 
 security/keys/keyctl.c                                                  |   15 
 security/keys/keyring.c                                                 |  153 ++--
 security/keys/persistent.c                                              |   55 -
 security/keys/process_keys.c                                            |    5 
 security/keys/trusted-keys/trusted_tpm1.c                               |    2 
 security/selinux/avc.c                                                  |    5 
 security/selinux/hooks.c                                                |    9 
 sound/core/seq/seq_clientmgr.c                                          |    1 
 sound/core/seq/seq_compat.c                                             |    2 
 sound/parisc/harmony.c                                                  |   13 
 sound/pci/pcxhr/pcxhr.c                                                 |   61 -
 sound/soc/codecs/cs42l52.c                                              |    2 
 sound/soc/codecs/cs42l56.c                                              |    2 
 sound/soc/codecs/max98371.c                                             |    2 
 sound/soc/codecs/nau8822.c                                              |    4 
 sound/soc/codecs/pcm3168a.c                                             |    2 
 sound/soc/codecs/rt274.c                                                |    4 
 sound/soc/codecs/wm8903.c                                               |    2 
 sound/soc/codecs/wm8978.c                                               |    4 
 sound/soc/samsung/i2s.c                                                 |    8 
 sound/soc/stm/stm32_spdifrx.c                                           |    2 
 sound/usb/caiaq/device.c                                                |    3 
 sound/usb/line6/playback.c                                              |    7 
 sound/usb/misc/ua101.c                                                  |    9 
 tools/gpio/Makefile                                                     |    6 
 tools/perf/tests/bpf.c                                                  |    3 
 tools/perf/util/parse-events.c                                          |    2 
 tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc |   24 
 tools/thermal/tmon/tui.c                                                |    2 
 496 files changed, 5370 insertions(+), 2605 deletions(-)

Abdurrahman Hussain (3):
      of/overlay: put property on deadprops only after changeset add succeeds
      of/overlay: don't leak fragment references when changeset init fails
      of/overlay: don't create "//" paths for fragments targeting the root

Abhishek Ojha (1):
      regulator: ltc3676: don't read the write-only HRST and CLIRQ registers

Adrian Betschart (1):
      drm/amd/display: Don't replace a sink mode that shares the native totals

Adrian Hunter (2):
      i3c: master: Do not treat master device as a duplicate target
      i3c: master: Fix use-after-free of master->this

Adrian Martinez (1):
      KEYS: Fix key_reject_and_link() race with keyring restriction

Ahmed Abdelhaleem Ahmed (1):
      scsi: ch: Do not keep references to data transfer element devices

Alan Stern (1):
      USB: gadget: dummy-hcd: Fix wait for outstanding request completions

Aldo Ariel Panzardo (1):
      Bluetooth: mgmt: fix race in read_unconf_index_list()

Alex Deucher (1):
      drm/amdgpu: make Mac FB workaround generic

Alexandru Hossu (1):
      staging: rtl8723bs: fix OOB read in OnAssocRsp() IE loop

Amirmohammad Eftekhar (1):
      KVM: nVMX: Reset MMU back to the root MMU if loading L2 state fails for !VM-Entry

Amit Pundir (1):
      arm64: dts: qcom: sdm845-db845c: Mark cont splash memory region as reserved

Amit Sunil Dhamne (1):
      usb: typec: tcpm: constrain TCPM_SOURCING_VBUS event handling

Andre Eikmeyer (1):
      drm/amdgpu: reset VI ASIC on MacBookPro15,1

Andrii Nakryiko (1):
      bpf: fix potential 32-bit overflow when accessing ARRAY map element

Andy Shevchenko (4):
      params: Do not go over the limit when getting the string length
      params: Use size_add() for kmalloc()
      params: Sort headers
      params: Fix multi-line comment style

Angel Iglesias (1):
      i2c: core: Introduce i2c_client_get_device_id helper function

Anjali Kulkarni (1):
      netlink: Reverse the patch which removed filtering

Aohan Mei (4):
      smb: client: reject userspace cifs.idmap descriptions
      netfilter: nft_flow_offload: drop flowtable reference on init error path
      net: rds: fix uninitialized trans dereference in CM event handler
      net/sched: cls_flower: validate mask pointer after nla_next()

Arka Mondal (3):
      iio: gyro: adis16136: fix unprotected debugfs reads
      iio: imu: adis16400: fix unprotected debugfs reads
      iio: imu: adis16480: fix unprotected debugfs reads

Arnaldo Carvalho de Melo (1):
      perf test bpf: Address error about non-null argument for epoll_pwait 2nd arg

Asad Kamal (1):
      drm/amd/powerplay: fix VoltageObjectInfo zero-stride loop and OOB read

Aswin Karuvally (1):
      s390/ctcm: Prevent XID null dereference

Avi Weiss (1):
      ASoC: stm32: spdifrx: fix synchronization state check

Baokun Li (2):
      fuse: fix invalidate lock leak on open O_TRUNC DAX failure
      fuse: fix invalidate lock leak on setattr writeback failure

Bart Van Assche (1):
      loop: Fix use-after-free issues

Bastien Nocera (1):
      HID: hid-alps: Use pm_ptr instead of #ifdef CONFIG_PM

Beata Michalska (2):
      arm64: errata: Factor out broken AMU const counter cap
      arm64: errata: Add Cortex-A725 erratum 3821522 workaround

Ben Cressey (3):
      dm-crypt: reject the lmk IV mode with AEAD ciphers
      dm-crypt: fix a tiny race condition in crypt_dec_pending
      dm-integrity: fix infinite loop on discard with large tag size

Bence Csókás (1):
      dmaengine: Add devm_dma_request_chan()

Benjamin Berg (1):
      wifi: cfg80211: avoid double free if updating BSS fails

Benjamin Marzinski (1):
      dm cache: fix issue with background work locking

Benjamin Tissoires (1):
      HID: core: introduce hid_safe_input_report()

Bjoern Doebel (1):
      smb: client: avoid leaking refcount in cifs_queue_oplock_break()

Breno Leitao (1):
      usb: xhci: bail out of setup if the controller is inaccessible

Can Peng (2):
      hwrng: stm32 - Fix runtime PM cleanup on registration failure
      spi: bcm63xx: disable clock on resume failure

Carlo Szelinsky (1):
      USB: serial: option: add Quectel EG060W

Carlos Llamas (1):
      HID: uhid: convert to hid_safe_input_report()

Cen Zhang (5):
      ocfs2/dlm: Protect the recovery list during debugfs reads
      keys: Avoid the owner account dereference in named keyring lookup
      keys: Check the authorization payload in process keyring searches
      keys: Protect the type name while describing a key
      keys: Protect the read method check against type removal

Cen Zhang (Microsoft Security FORGE Labs) (1):
      tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)

Cen Zhang (Microsoft) (1):
      watch_queue: Fix note pool publication race in watch_queue_set_size()

Cezary Rojewski (1):
      ASoC: codecs: rt274: Fix format setting for 44100 rate

Chandrashekar Devegowda (1):
      Bluetooth: btintel: fix buffer over-read in btintel_hw_error()

Chao Yu (1):
      f2fs: embed f2fs_gc_kthread in f2fs_sb_info

Charles Vosburgh (1):
      sctp: validate chunk length in the inqueue parser

Chen Changcheng (1):
      HID: alps: unregister DualPoint Stick input device on remove

Chen Cheng (1):
      dm-integrity: require stable writes for internal hash modes

Chen Ni (1):
      usb: ohci-spear: Remove unnecessary NULL check before clk_disable_unprepare()

ChenXiaoSong (2):
      smb/client: use stack-allocated smb2_file_all_info in smb3_query_mf_symlink()
      smb/client: pass cifs_open_info_data to SMB2_open()

Chengchang Tang (1):
      RDMA/hns: Fix WQ_MEM_RECLAIM warning

Chengfeng Ye (7):
      KEYS: trusted: Fix TPM teardown ordering
      Bluetooth: RFCOMM: Fix initial port reference race
      Bluetooth: hci_core: Serialize ACL scheduling with channel deletion
      tipc: hold a reference to nodes found by link name
      net/smc: protect clcsock lifetime in smc_getname
      Bluetooth: hci_sock: Serialize dead-device detachment
      tipc: protect node reset trace dump with node lock

Chris Mason (3):
      nfsd: release path refs on follow_down() error
      SUNRPC: fix gssx_dec_option_array error path bugs
      SUNRPC: reject duplicate CREDS_VALUE options

Christian Borntraeger (2):
      KVM: s390: Zero initialize data structures for inject_pfault_token
      KVM: s390: Fix length check __import_wp_info()

Christian Brauner (13):
      fs: refuse fspick() on internal superblocks
      namespace: check a submount for references right before unmounting it
      dcache: don't put a mountpoint on a dentry that's being removed
      namespace: refuse an automount below a mount that is in no namespace
      namespace: don't inherit MNT_UMOUNT in clone_mnt()
      namespace: check the mounts before reading their parents in pivot_root()
      namespace: unhash a dentry before detaching the mounts on it
      namespace: don't copy an unmounted mount tree
      fcntl: refuse F_SET_RW_HINT on an immutable inode
      namespace: handle mount locking for automounts correctly
      clone: add CLONE_AUTOREAP
      unicode: free the map after a grace period
      signal: don't retarget shared signals in a dying thread group

Christian Göttsche (1):
      selinux: fix data race on AVC latest_notif

Christian König (1):
      drm/nouveau: switch over to the new pin interface

Christophe JAILLET (2):
      kernel/params.c: Use kstrtobool() instead of strtobool()
      watchdog: rtd119x: Use devm_clk_get_enabled() helper

Chuck Lever (1):
      nfsd: gate nfs2 setacl by argp->mask

Clément Léger (1):
      of/irq: add missing of_node_put() for interrupt parent node

Cong Nguyen (2):
      iio: proximity: pulsedlight: fix iio_device left registered on PM setup failure
      iio: adc: max1363: sign-extend bipolar differential channel reads

Daehyeon Ko (4):
      wifi: libipw: reject TKIP frames without a full MIC
      nvme-multipath: fix underflow in ANA log bounds checks
      thunderbolt: Reject oversized XDomain properties responses
      sctp: revalidate output stream after association connect wait

Dan Carpenter (1):
      HID: hid-steam: Fix cleanup in probe()

Daniel Wagner (1):
      nvme-tcp: Do not reset transport on data digest errors

Daniil Stas (1):
      hwmon: (drivetemp) Fix driver producing garbage data when SCSI errors occur

Dapeng Mi (1):
      perf/x86/intel: Remove anythread_deprecated bit from perf_capabilities

Darrick J. Wong (7):
      xfs: hoist recovered bmap intent checks out of xfs_bui_item_recover
      xfs: improve the code that checks recovered bmap intent items
      xfs: hoist recovered rmap intent checks out of xfs_rui_item_recover
      xfs: improve the code that checks recovered rmap intent items
      xfs: hoist recovered refcount intent checks out of xfs_cui_item_recover
      xfs: improve the code that checks recovered refcount intent items
      xfs: fix intermittent hang during quotacheck

Dave Airlie (1):
      nouveau/gem: reserve the bo in the info ioctl around the vma lookup

Dave Chinner (11):
      xfs: don't nest icloglock inside ic_callback_lock
      xfs: convert XLOG_FORCED_SHUTDOWN() to xlog_is_shutdown()
      xfs: log items should have a xlog pointer, not a mount
      xfs: aborting inodes on shutdown may need buffer lock
      xfs: remove xfs_buf_t typedef
      xfs: buffer pins need to hold a buffer reference
      xfs: xfs_ifree_cluster vs xfs_iflush_shutdown_abort deadlock
      xfs: catch stale AGF/AGF metadata
      xfs: rearrange code in xfs_buf_item.c
      xfs: factor out stale buffer item completion
      xfs: fix unmount hang with unflushable inodes stuck in the AIL

David Heidelberg (1):
      Input: s6sy761 - fix resume ordering and restore sensing

David Rosca (1):
      drm/amdgpu: Fix VCE 3 ring align_mask

Denis V. Lunev (1):
      openvswitch: fix soft lockup in the netlink flow dump

Di Shen (1):
      OPP: Fix race between OPP addition and lookup

Dibin Moolakadan Subrahmanian (1):
      drm/i915/dmc: Harden DMC firmware payload parsing

Dmitry Baryshkov (2):
      drm/msm/dsi: do not enable PHYs when called for the slave DSI interface
      drm/msm/dsi: rename dual DSI to bonded DSI

Donggeun Yoo (5):
      tracing: Set the trace clock before registering the histogram trigger
      tracing: Fix the shift out of bounds in the log2 histogram modifier
      tracing: Save the event file instead of the compatible histogram
      tracing: Unregister field variable histograms when the command fails
      tracing: Fix 64-bit and signed histogram fields on 32-bit kernels

Doruk Tan Ozturk (1):
      ocfs2: validate directory-index entry counts when reading metadata

Eric Biggers (2):
      fsverity: add dependency on 64K or smaller pages
      crypto: drbg - Fix ineffective sanity check

Eric Dumazet (5):
      ipv6: sr: use skb_get_hash_net() in seg6_make_flowlabel()
      bnxt_en: fix DMA mapping length for padded small packets
      flow_dissector: avoid u16 truncation of skb->len when computing thoff
      flow_dissector: avoid u16 truncation of hlen in bpf_flow_dissect()
      net: initialize net->net_cookie at netns setup

Fan Wu (11):
      wifi: rtl8xxxu: fix use-after-free from rx_urb_wq on stop
      power: supply: rt9455: quiesce delayed work before teardown
      mmc: via-sdmmc: cancel card-detect work on remove
      power: supply: bq24257: fix use-after-free on remove
      power: supply: ucs1002: fix use-after-free on remove
      hwmon: (gpio-fan) Fix use-after-free in alarm work
      wifi: wcn36xx: Fix potential use-after-free in TX ack timer teardown
      usb: gadget: aspeed-vhub: cancel wake work on device removal
      iio: light: gp2ap020a00f: drain irq_work after free_irq
      usb: cdns3: fix use-after-free in cdns3_gadget_exit()
      tty: serial: max3100: shut down timer before freeing port

Felix Fietkau (2):
      wifi: mac80211: set info->band for 802.3 encap offload frames
      netfilter: nf_tables: fix bidirectional offload regression

Felix Gu (2):
      iio: adc: sun4i-gpadc-iio: clean up on thermal zone registration failure
      iio: adc: sun4i-gpadc-iio: drop underflowing pm_runtime_put() calls

Fernando Fernandez Mancera (1):
      net: openvswitch: validate transport header presence in set_ipv6_addr

Florian Eckert (1):
      tools/thermal/tmon: Fix compilation warning for wrong format

Florian Fainelli (1):
      net: systemport: Fix RUNT MIB counter register offset calculation

Florian Westphal (6):
      netfilter: ipset: do not update comments from kernel-side adds
      netfilter: nf_tables: avoid skb access on nf_stolen
      net: add and use skb_get_hash_net
      netfilter: nf_tables: fix crash when nf_trace is enabled
      netlink: remove netlink_broadcast_filtered
      netfilter: nf_tables: always increment set element count

Francisco Beltrán Millalén (1):
      drm/amdgpu: reset VI ASIC on MacBookPro14,3

Frank Sorenson (7):
      smb: client: fix OOB read/write from unvalidated DataOffset in coalesce_t2()
      smb: client: fix potential OOB read in smb3_enum_snapshots()
      smb: client: fix next_buffer UAF and NextCommand bounds in compound PDUs
      smb: client: fix OOB struct field reads in move_smb2_ea_to_cifs()
      cifs: fix loff_t underflow in cifs_remap_file_range() when len == 0
      smb: client: split cifsFileInfo bitfields to avoid shared-byte RMW races
      cifs: add revalidation on FSCTL failure in smb2_duplicate_extents()

Fredrik Nyberg (1):
      net: usb: ax88179_178a: fix rx frame length for non-last packets

Fuad Tabba (1):
      KVM: arm64: vgic-its: Don't dereference a NULL collection on ITT save

Geliang Tang (1):
      skmsg: Skip zero length skb in sk_msg_recvmsg

Genjian Zhang (1):
      dm-ebs: fix incorrect device offset check in ebs_ctr()

Gilberto Conde (1):
      net: usb: qmi_wwan: add Quectel EG120K-EA

Greg Kroah-Hartman (1):
      Linux 5.10.273

Guangshuo Li (7):
      media: saa7164: fix cleanup on resource allocation failure
      net: ena: fix MMIO read buffer leak on probe failure
      wifi: iwlegacy: 3945: free EEPROM data on remove
      drm/amdgpu: fix ACP MFD device leak on init failure
      mmc: cavium-octeon: destroy slot platform devices on remove
      mmc: cavium-thunderx: destroy slot platform devices on remove
      mmc: sdhci-sprd: disable runtime PM on remove

Guo Xuenan (1):
      xfs: fix super block buf log item UAF during force shutdown

Han Xu (1):
      mtd: spinand: Enable QE on all dies

Hao Sun (1):
      bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS

Heyang Tan (1):
      wifi: p54: validate firmware record lengths

Hidayath Khan (1):
      net/smc: fix socket refcount leak in smc_switch_conns()

Hongjian Dai (1):
      i2c: at91: release DMA channels when probe defers

Hui Peng (2):
      usb: core: clear both ep_in and ep_out for non-ep0 control endpoints
      sctp: copy zeroed stats to user in sctp_getsockopt_pr_streamstatus() when !streamoute

HyeongJun An (7):
      ASoC: wm8903: Move the DRC QR threshold to the register that holds it
      ASoC: cs42l56: Put the Limiter Cushion control on the limiter register
      ASoC: cs42l52: Fix the NG Type Switch bit
      ASoC: pcm3168a: Fix the DAC zero flag polarity bit
      ASoC: max98371: Fix the Speaker DHT Min Volume bits
      ASoC: wm8978: Fix the 128x oversampling switch bits
      ASoC: nau8822: Fix the 128x oversampling switch bits

Hyunwoo Kim (2):
      apparmor: fix out-of-bounds write when null terminating a label vec
      KVM: x86/mmu: Preserve nested TDP shadow page tables if they are used as roots

Ian Lin (2):
      USB: serial: option: add Compal EXM-G1x support
      USB: serial: option: add Compal EXC-T1 support

Ido Schimmel (1):
      ipv4: udp: Create exceptions before socket matching

Ilkka Lappeteläinen (1):
      net/packet: prevent TX_RING byte count overflow

Ilya Maximets (1):
      net: openvswitch: conntrack: fix helper UAF due to extensions realloc

Ilya Titov (1):
      pinctrl: sunxi: keep a shadow copy of the data register output latches

Imre Kaloz (1):
      drm/radeon: Read the VRAM VBIOS signature with readb()

Jakub Kicinski (1):
      page_pool: always add GFP_NOWARN for ATOMIC allocations

Jamal Hadi Salim (3):
      net/sched: fq_codel: match the no-drop threshold to the packet size
      net/sched: sch_codel: match the no-drop threshold to the packet size
      net/sched: em_text: reject unterminated algo before autoload

Jameson Thies (1):
      usb: typec: ucsi: displayport: Current CAM OOB index fixup

Jann Horn (1):
      futex: Fix mm reuse handling for FUT_OFF_MMSHARED

Jason A. Donenfeld (1):
      wireguard: noise: reject response consumption after intermediate initiation

Jason Wang (1):
      ALSA: pcxhr: use __func__ to get funcion's name in an output message

Jeff Jo (1):
      tcp: refresh TS.Recent for accepted old ACKs

Jeff Layton (3):
      nfsd: fix nfsd_file leak on inter-server COPY setup failure
      nfsd: check nfsd4_acl_to_attr() return value in nfsd4_create()
      nfsd: fix clock domain mismatch in clients_still_reclaiming()

Jeffin Philip (1):
      usb: gadget: f_mass_storage: fix null pointer dereference in fsg_common_set_num_buffers()

Jens Axboe (1):
      io_uring/rw: end write accounting from ->ki_complete

Jesse Zhang (1):
      drm/amdgpu: don't drop the runtime PM reference twice in amdgpu_gpr

Jiacheng Yu (1):
      params: fix charp corruption on allocation failure

Jiale Yao (1):
      iio: accel: kxcjk-1013: reject duplicate event disable

Jiangshan Yi (1):
      smb: client: clear setuid/setgid bit on write with cifsacl/modefromsid/posix extensions

Jianing Li (1):
      power: supply: max17040: drop incorrect I2C functionality check

Jiayuan Chen (1):
      tls: device: fix out-of-bounds write in tls_append_frag()

Jie Deng (1):
      usb: cdns3: Fix NULL pointer dereference in cdns3_pci_probe

Jinjiang Tu (1):
      mm/rmap: fix missing barrier between anon_vma init and vma->anon_vma publish

Jinu Kim (1):
      KVM: x86: Use active memslots for the per-vCPU MMIO cache

Jiri Slaby (SUSE) (1):
      tty: introduce and use tty_port_tty_vhangup() helper

Johan Hovold (14):
      USB: cdc-acm: fix racy TIOCMIWAIT implementation
      USB: serial: fix port tear down use-after-free
      tty: amiserial: fix broken TIOCMIWAIT
      USB: serial: quatech2: fix baud rate overflow
      USB: serial: ssu100: fix baud rate overflow
      USB: serial: fix dynamic id driver deregistration race
      tty: fix saved termios reset race
      tty: tty_port: restore TTY_IO_ERROR on activation failure
      tty: abort break signalling on hangup
      serial: fix TIOCMIWAIT race
      USB: serial: fix ioctl hangup race
      USB: serial: clean up core error labels
      USB: serial: fix driver deregistration order
      tty: port: fix tty_port_tty_vhangup() race

Johannes Berg (1):
      Revert "wifi: libertas: reject short monitor TX frames"

Jonas Köppeler (1):
      net_sched: codel: fix stale state for empty flows in fq_codel

Jonathan Cameron (1):
      device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.

Josef Bacik (2):
      xen/netfront: drop RX packets with a short Ethernet header
      xen/netfront: don't leak the skb when xennet_fill_frags() fails

Joseph Qi (1):
      ocfs2: validate dx_root extent list fields during block read

Joshua Rogers (2):
      tty: vcc: zero-initialize control packet in vcc_send_ctl()
      tty: vcc: hold port lock when clearing tty pointer in vcc_cleanup

Julian Anastasov (3):
      ipvs: fix missing counter decrement in lblc
      ipvs: do not create invisible templates
      ipvs: filter some flags received in the backup server

Julian Sun (1):
      nvmet: preserve device path on allocation failure

Jun Yang (2):
      sctp: check RCV_SHUTDOWN after the sendmsg connect wait
      net: bridge: mcast: don't truncate the port group walk on teardown

Jérémy Carrat (1):
      USB: serial: cp210x: add Corsair AX1500i Power Supply

Jérémy Jean (3):
      audit: fix exe mark UAF in kill_rules()
      tipc: prevent GCM nonce reuse on peer key changes
      net/sched: fix use-after-free in __tcf_action_put()

Karl Mehltretter (2):
      arm64: mm: Fix the lockless page-table walk in show_pte()
      keys: finalize persistent keyring timeout after link attempt

Kavan Smith (1):
      drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value

Keith Busch (1):
      nios2: fix __wsum type degradation in csum_fold()

Konrad Dybcio (1):
      drm/msm/adreno: Assign msm_gpu->pdev earlier to avoid nullptrs

Krzysztof Karas (2):
      drm/i915/gem: Prevent overstepping exec array boundary
      drm/i915/gt: Unmask interrupts only when ACTIVE is true

Kuan-Wei Chiu (1):
      coresight: etm3x: Fix cntr_val_show() to match cntr_val_store() behavior

Kumar Kartikeya Dwivedi (1):
      bpf: Do mark_chain_precision for ARG_CONST_ALLOC_SIZE_OR_ZERO

Kuniyuki Iwashima (2):
      hsr: Remove WARN_ONCE() in hsr_addr_is_self().
      vxlan: Fix potential null-ptr-deref in vxlan_gro_prepare_receive().

Kyle Zeng (8):
      ALSA: seq: Clear variable event pointer on read
      ALSA: seq: Serialize compat port-info ioctls
      netlink: reset skb headers before unicast and multicast filtering
      pipe: preserve existing fasync readers on writer setup failure
      netlink: avoid hashing the network namespace pointer
      fsnotify: prevent mark additions during connector teardown
      tracing: Reject incomplete event filter expressions
      keys: make keyring indexes independent of kernel addresses

Laurence Oberman (2):
      scsi: st: Save the visited block for the partition the drive is in
      scsi: st: Fix use-after-free race between st_remove() and st_open()

Lee Jones (2):
      staging: sm750fb: sm750_accel: Provide description for 'accel' and fix function naming
      tracing/histograms: Reject non-stacktrace fields for synthetic stacktrace fields

Leon Hwang (1):
      kprobes: Skip disarmed probes when checking optkprobe overlap

Li RongQing (1):
      net/mlx5e: Order ICOSQ cc update after CQ doorbell

Linfeng Sun (1):
      scsi: target: iscsi: Fix race in discovery auth updates

Linmao Li (2):
      Bluetooth: hci_core: Fix inquiry cache timestamps on 64-bit systems
      Input: byd - synchronize timer deletion before freeing private data

Linus Torvalds (1):
      security/keys: fix missed RCU read section on lookup

Liu Chao (1):
      usb: gadget: f_uac1_legacy: validate bRequest index in generic_{set,get}_cmd

Loic Poulain (1):
      i2c: qcom-cci: Fix HALT_ACK reset request being dropped

Longlong Xia (1):
      zram: fix out-of-bounds access in read_block_state()

Lorenzo Stoakes (ARM) (3):
      mm/mremap: fix locked_vm leak by splitting VMA for MREMAP_DONTUNMAP
      mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP self-merge
      mm/vmalloc: acquire init_mm lock on huge vmap to avoid ptdump UAF

Lovekesh Solanki (3):
      Input: i8042 - add nomux quirk for Fujitsu LIFEBOOK U7410
      Input: synaptics - add LEN205b entry to smbus_pnp_ids for ThinkPad T490
      usb: hub: use shorter 120ms post resume hold for SS root hubs

Lu Baolu (1):
      iommu: disable SVA when CONFIG_X86 is set

Ma Xinmeng (1):
      dm-snap: reject the transient exception store for snapshot-merge

Maoyi Xie (1):
      rds_tcp: close NULL deref window in rds_tcp_set_callbacks

Marc Harvey (2):
      net: team: Remove unused team_mode_op, port_enabled
      net: team: Rename port_disabled team mode op to port_tx_disabled

Marcus Folkesson (1):
      HID: hid-alps: use default remove for hid device

Marek Szyprowski (1):
      ASoC: samsung: i2s: enable op_clk in probe to balance runtime PM

Martino Papero (1):
      Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3 15IWC11

Masami Hiramatsu (Google) (1):
      kprobes: Protect kprobe_blacklist with RCU

Matthew Wilcox (Oracle) (2):
      fs: Free any excess xarray nodes in clear_inode()
      highmem: round down the address passed to kunmap_flush_on_unmap()

Matti Vaittinen (3):
      workqueue: Add resource managed version of delayed work init
      devm-helpers: Add resource managed version of work init
      devm-helpers: Fix devm_delayed_work_autocancel() kerneldoc

Maxim Skokov (1):
      Bluetooth: RFCOMM: free the skb when the DLC has no owner

Maíra Canal (1):
      drm/vc4: Free the BO cache size list on teardown

Mehmet Fide (2):
      mtd: rawnand: vf610_nfc: fix reads on chips with more than 64 bytes of OOB
      mtd: rawnand: vf610_nfc: fix false bitflips on reads of erased pages

Michael Bommarito (2):
      ceph: bound copied dentry name length in NFS export get_name
      ceph: bound num_export_targets array for mds info v2/v3

Michael Kelley (1):
      Drivers: hv: Don't reset VMBus connection state on error/exit paths

Michal Luczaj (1):
      vsock: treat TCP_CLOSING as once-established

Michele Dionisio (1):
      wifi: brcmfmac: fix P2P device removal race in brcmf_detach()

Mika Westerberg (1):
      thunderbolt: Fix KASAN reported use-after-free when request is canceled

Mikhail Gavrilov (1):
      Bluetooth: RFCOMM: connect the session socket without rfcomm_mutex

Mikulas Patocka (1):
      dm: fix reading free memory in do_resume

Ming-Hung Tsai (1):
      dm cache: fix demotion stats in passthrough mode

Mingming Cao (1):
      ibmveth: h_free logical LAN on open-fail after register

Mingyu Wang (1):
      tty: vt: fix memory leak in vc_allocate()

Muhammad Bilal (2):
      staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()
      staging: sm750fb: fix mono image source stride mismatch in lynxfb_ops_imageblit()

Myeonghun Pak (5):
      usb: ohci-da8xx: disable controller wakeup on cleanup
      usb: ohci-s3c2410: disable controller wakeup on removal
      usb: ohci-st: disable controller wakeup on removal
      usb: ohci-spear: disable controller wakeup on removal
      drm/aspeed: Balance the display clock enable on teardown

Namhyung Kim (1):
      perf tools: Fix a asan issue in parse_events_multi_pmu_add()

Namjae Jeon (1):
      smb: client: use finish_no_open() for non-regular inodes

Nguyen Ngoc Thang (3):
      ALSA: caiaq: unregister the input device when probe fails
      memstick: rtsx_usb_ms: complete requests after eject instead of dropping them
      drm/fb-helper: defer setup when fbdev_probe() fails, not just on -EAGAIN

Nickolai Zeldovich (1):
      exit: fix lost-update race on the child_subreaper bitfields

Nicolas Escande (1):
      wifi: ath11k: reset ar->num_stations on hardware start

Niklas Schnelle (1):
      s390/pci: Fix leak of uninitialized kernel data in SCLP report

Nikola Prica (1):
      PCI: Accept AtomicOps already enabled by the hypervisor

Nilesh Javali (10):
      scsi: qla2xxx: Zero dport diagnostics buffer to avoid info leak
      scsi: qla2xxx: Fix queue teardown NULL dma_free and bitmap locking
      scsi: qla2xxx: Fix use-after-free of qpair work on queue teardown
      scsi: qla2xxx: Validate BSG request_len before reading vendor_cmd[]
      scsi: qla2xxx: Null out freed pointers in qla2x00_mem_alloc() error path
      scsi: qla2xxx: Fix 64G link speed reporting in get_data_rate
      scsi: qla2xxx: Quiesce response IRQ before freeing request queue
      scsi: qla2xxx: Use memset_io() to clear QLAFX00 request ring slot
      scsi: qla2xxx: Initialize NVMe abort_work once at submission
      scsi: qla2xxx: Fix NVMe abort reference leak on repeated abort

Oliver Hartkopp (1):
      can: fix unique skb identifier regression under RPS

Orgad Shaneh (1):
      usb: octeon-hcd: fix the FIFO-flush timeout computation

Oscar Ou (1):
      lockd: fix swapped arguments in nlmsvc_match_ip()

Pablo Neira Ayuso (2):
      netfilter: nf_tables: release flowtable after rcu grace period on error
      netfilter: nf_tables: unconditionally bump set->nelems before insertion

Palla Raghunath (2):
      dm ioctl: don't let data_start run past the buffer
      Bluetooth: RFCOMM: Fix NULL tty_dev dereference in rfcomm_dev_shutdown

Pannarat Wiriyaarritham (1):
      usb: typec: ucsi: acpi: Assume UCSI 1.2 on Acer Nitro ANV15-41

Pauli Virtanen (2):
      Bluetooth: L2CAP: access chan->conn safely in get/setsockopt
      Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn

Paulo Alcantara (2):
      smb: client: fix file type corruption in cifs_reparse_point_to_fattr()
      smb: client: fix smbd_connection leak on cifs_get_tcp_session() error

Pavankumar Kondeti (1):
      workqueue: Fix NULL current_pwq deref in chained work check

Pei Xiao (1):
      mtd: block2mtd: Fix divide error when erase_size is zero

Peiyang He (1):
      drm/nouveau: don't bump pin count on failed re-pin in nouveau_bo_pin_locked()

Pengpeng Hou (1):
      iio: adc: aspeed: propagate reset deassert errors

Peter Xu (1):
      mm/hugetlb: fix avoid_reserve to allow taking folio from subpool

Prashanth K (1):
      usb: typec: ucsi: Get the connector fwnode based on reg value

Qing Ming (1):
      gtp: serialize PDP context updates

Quchaosheng (1):
      net/packet: guard the ll header push in packet_rcv_spkt()

Raj Ojha (1):
      memstick: core: wait for request completion before freeing card

Raphaël Larocque (1):
      Input: synaptics - limit T440p InterTouch quirk to LEN0036

Runyu Xiao (5):
      ALSA: pcxhr: initialize mutexes before requesting threaded IRQ
      ALSA: harmony: initialize locks before requesting IRQ
      rtc: spear: initialize IRQ state before requesting alarm IRQ
      mtd: rawnand: cadence: Initialize IRQ state before requesting IRQ
      scsi: qedi: Initialize callback state before registration

Ruoyu Wang (2):
      i2c: mxs: fix DMA channel leak on probe error
      media: zoran: Avoid freeing a registered video_device twice

Sabrina Dubroca (1):
      strparser: make sure __strp_recv isn't running before tearing down the parser

Sai Teja Aluvala (1):
      Bluetooth: btintel: validate DDC record lengths

Salah Triki (2):
      iio: accel: sca3000: fix frequency divider condition check
      iio: proximity: isl29501: Fix return type of isl29501_register_write

Samuel Holland (1):
      pinctrl: sunxi: Refactor register/offset calculation

Sang-Hoon Choi (3):
      Bluetooth: hci_core: free the HCI ID if naming fails
      cxgb4/ch_ktls: disable softirqs around tid_list erases
      nvmet: use the local P2P device on metadata allocation failure

Sanghyun Park (1):
      vxlan: use one headroom snapshot for neighbour replies

Sasha Levin (3):
      Revert "scsi: sd: sd_zbc: Use logical blocks as unit when querying zones"
      samples: pidfd: fix userprogs typo
      tools: gpio: fix building from the top level with O=

Sean Christopherson (1):
      KVM: SVM: Use the active VMCB's MSR bitmap when checking if MSR is intercepted

Sebastian Andrzej Siewior (1):
      ring-buffer: Acquire the lock with irqsave in rb_wake_up_waiters()

Sebastian Sjoholm (1):
      USB: serial: option: add Quectel RG660QB

Sergey Senozhatsky (1):
      zram: fixup read_block_state()

Shao-Fu Chen (1):
      optee: register TEE devices only once fully initialized

Shawn Lin (3):
      pmdomain: rockchip: fix clock leak on domain probe failure
      pmdomain: rockchip: don't ignore clock lookup errors on attach
      pmdomain: rockchip: propagate subdomain add errors

Simon Gassner (1):
      serial: tegra: don't clear the Tx FIFO on an Rx-only reset

Stefan Wahren (1):
      staging: vchiq_arm: Avoid NULL ptr deref in vchiq_dump_platform_instances

Stephen Smalley (1):
      selinux: preserve NATIVE_LABELS on already-initialized sb in set_mnt_opts

Steve French (1):
      smb3: make query_on_disk_id open context consistent and move to common code

Steven Rostedt (2):
      ftrace: Take trace_array reference before accessing its ftrace_ops
      ftrace: Synchronize the initialization of ftrace_ops

Sung Byeongchan (1):
      autofs: ignore notification errors from a replaced pipe

Syed Labeeq Sajid Bukhari (1):
      usb: storage: sierra_ms: reject short SWoC info transfers

Tahera Fahimi (1):
      xfrm: prevent policy_hthresh.work from racing with netns teardown

Takashi Iwai (1):
      ALSA: parisc: Fix assignment in if condition

Thomas Gleixner (1):
      tick/broadcast: Plug clockevents replacement race

Thomas Weißschuh (1):
      HID: core: remove #ifdef CONFIG_PM from hid_driver

Thorsten Blum (1):
      net: ipconfig: Remove outdated comment and indent code block

Tianchu Chen (1):
      wifi: cw1200: fix TX padding OOB read leaking heap data to device

Tibor Harcsa (1):
      Bluetooth: btusb: Add IMC Networks QCA9377 to quirks table

Timur Kristóf (4):
      drm/amd/pm/si: Check AMD_IS_MOBILITY flag for PPSMC_SYSTEMFLAG_GPIO_DC
      drm/amd/pm/si: Fix updating clock limits on AC/DC
      drm/amd/display: Mark DCE 6.4 as not APU
      drm/amdgpu/sdma3: Work around POLL_REGMEM / FENCE hang

Tristan Madani (2):
      nvme: add missing SRCU grace period in error path
      wifi: wcn36xx: fix heap overflow from oversized firmware HAL response

Tzung-Bi Shih (1):
      watchdog: rtd119x: Avoid division by zero

Usama Arif (1):
      mm/huge_memory: transfer the pmd dirty bit to the folio on zap

Uwe Kleine-König (5):
      Bluetooth: btqcomsmd: Convert to platform remove callback returning void
      power: supply: rt9455: Convert to i2c's .probe_new()
      power: supply: max17040: Convert to i2c's .probe_new()
      wifi: wl12xx: Drop if with an always false condition
      wifi: wlcore: Convert to platform remove callback returning void

Varun Prakash (1):
      nvme-tcp: validate R2T PDU in nvme_tcp_handle_r2t()

Vicki Pfau (5):
      HID: hid-steam: Make client_opened a counter
      HID: steam: Fully unregister controller when hidraw is opened
      HID: steam: Rearrange teardown sequence
      HID: steam: Refactor registration
      HID: steam: Clean up locking

Victor Nogueira (1):
      net: sched: cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode

Viken Dadhaniya (2):
      tty: serial: qcom_geni_serial: Keep console RX functional after deep idle
      soc: qcom: geni-se: Correct QUP Core ICC vote constants

Vishal Badole (1):
      EDAC/amd64: Mask UMC chip select to the four implemented selects

Vivek BalachandharTN (1):
      staging: rtl8723bs: fix spacing around operators

Wang Jianzheng (1):
      pinctrl: sunxi: Use devm_clk_get_enabled() helpers

Weiming Shi (2):
      net: team: fix NULL pointer dereference in team_xmit during mode change
      net: team: stop reusing skb after queue override

Wenjie Qi (2):
      f2fs: return writeback error from collapse range
      f2fs: limit recovery filename logging to stored length

Wentao Liang (7):
      drm/amdgpu: Fix runtime PM leak in amdgpu_debugfs_test_ib_show()
      of/irq: Fix remaining refcount leaks in of_irq_init()
      kgdboc: Fix tty driver reference leak in configure_kgdboc()
      serial: vt8500: Fix clock reference leak in vt8500_serial_probe()
      wifi: wlcore: Fix runtime PM leak in wlcore_remove()
      btrfs: scrub: fix local_root reference leak in scrub_print_warning_inode()
      i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()

Willem de Bruijn (1):
      tcp: prevent collapsing skbs across boundary in rtx queue

Willian Oliveira (1):
      drm/amdgpu/gfx6: fix firmware leak on teardown

Xiang Mei (4):
      vlan: require the MAC header to be present in __vlan_insert_inner_tag()
      ALSA: line6: reject oversized playback packets
      ALSA: ua101: reject mismatched capture/playback packet sizes
      net: bonding: fix use-after-free in bond_xmit_broadcast()

Xin Long (1):
      openvswitch: add nf_ct_is_confirmed check before assigning the helper

XingWang Xiang (1):
      genetlink: pin family module during policy dump

Xu Rao (1):
      Bluetooth: btqcomsmd: destroy RPMsg endpoints before freeing hci_dev

Xu Yang (2):
      device property: fix infinite loop in fwnode_for_each_child_node()
      usb: typec: tcpm: fix debug accessory mode detection for sink ports

Xuanqiang Luo (1):
      net/sched: act_api: release all action references on NEWACTION failure

Xueqin Luo (1):
      power: supply: ds2780: Fix ds2780_get_capacity() returning raw value

Yehyeong Lee (5):
      nvme-tcp: fix host memory disclosure on R2T for a read command
      nvme-tcp: reject a read that transferred too few bytes
      scsi: libiscsi: Reject a negative task index from parse_pdu_itt
      scsi: libiscsi: Validate the ITT reflected in a Reject PDU
      scsi: libiscsi: Validate the task named by a management response

Yi Yang (1):
      vc_screen: reload vc pointer before if (ret) in vcs_write() to avoid UAF

Yibo Tan (1):
      mmc: mtk-sd: Cancel request timeout work on remove

Yosry Ahmed (1):
      KVM: nVMX: Service local TLB flushes on failed nested VM-Enter

Yuchao Zhang (1):
      usb: gadget: f_fs: Fix NULL pointer dereference in FUNCTIONFS_ENDPOINT_DESC

Yun Zhou (1):
      xfs: don't hold buffer locks across sync transaction commit in xfs_sync_sb_buf

Yuqi Xu (3):
      net: ipconfig: bound DHCP option construction
      wifi: mac80211: handle empty FILS association request payload
      tipc: destroy topsrv workqueues before closing connections

Yuxiao Wang (1):
      nitro_enclaves: fix use-after-free on SLOT_ALLOC failure

Zack Rusin (1):
      drm/vmwgfx: validate pitch coming from userspace

Zhang Changzhong (1):
      net/sched: cls_u32: skip hash tables in u32_bind_class()

Zhao Dongdong (1):
      USB: serial: option: add support for SIMCom SIM8260C

Zhao Li (5):
      wifi: cfg80211: preserve hidden-group beacon IE ownership
      wifi: mac80211: drain PS delivery work during station teardown
      wifi: mac80211: release mesh path quota on failed additions
      wifi: mac80211: keep fallback association elements alive
      wifi: mac80211: account proxy paths against the mesh path limit

Zhengchuan Liang (1):
      perf: Require kernel access for text poke events

Zhiling Zou (3):
      ipvs: bound LBLCR and LBLC cache growth
      wifi: mac80211: keep paired old chanctx alive
      wifi: mac80211: count only matching reservations in reserved switch

Zihan Xi (6):
      ipmr: account multicast table and route memory
      smb: client: fix create context out-of-bounds reads
      smb: client: validate POSIX create context length
      smb: client: close handle after create-context parsing failure
      smb: client: close completed creates on compound wait errors
      ipv4: avoid divide by zero in fib_rebalance

Zixuan Chai (1):
      net: bridge: avoid recursive multicast port cleanup

Zizhi Wo (1):
      vt: skip screen update for DEC alignment test on backgroup consoles

성병찬 (1):
      KEYS: Fix add_key() race with keyring restriction

