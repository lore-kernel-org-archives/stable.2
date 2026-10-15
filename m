Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F4E47668B;
	Thu, 15 Oct 2026 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060665; cv=none; b=iaFvQEVmA3W4j1wzvXxBmh+3SMCS/MDGiJbqflNgsOYzln9LVctTzyVGC9rJSiKJw2GGBHjwv3Y2w+KsG4VqI6Mcb/hxfPdqkALTLP4GSCcqZXS68o6o/z3AUd1V1zwfgpxfc5NJKZIlng1DhQkjbs27bW/qoK15jI2FuQGWptc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060665; c=relaxed/simple;
	bh=19UOwPZqUuIOnagCGqv/5x+6cKLweAIJxDpYdXgLZcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JuXVkc9Sp9R3bSo78sqYhMHX2lV8plYIr0lpVvQ/9R8/qF6yinzp3ywo7Zgs5EI9pxpifGNGTUwhERKnfe/GRIqT+bUUh169xSzWjduqpT7aq9/7UqGW49yLlAqNCLhELyRr8qVtCEIzLllbMQh/FFZvs6UmYZzu7gmS+Me6K5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bc36olZC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bc36olZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E21E1F000C4;
	Thu, 15 Oct 2026 10:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792060661;
	bh=8zNxJlpVhfp/DTnwAF/88gW3BLQso4gX/vYkJJ3xaMY=;
	h=From:To:Cc:Subject:Date;
	b=bc36olZC+OcPK9ug7GTpcIkoVA/Gh+0Kua3qrvB6MEDYlMwKd+ALVLsU0N8b2J3+H
	 /yj+9B0PKUK41Xh/RTM6/e/NVRZf9+t1M3OTnAt9w7a8VUyR9lIDY0zoOQJmH1CK2j
	 5rIC5edW0zM33lt72Sqjq1SUba5NX9OVpZ9biwOM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.113
Date: Thu, 15 Oct 2026 12:37:43 +0200
Message-ID: <2026101544-swore-subprime-45b8@gregkh>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.113 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arch/arm64/silicon-errata.rst                            |    2 
 Documentation/filesystems/netfs_library.rst                            |   26 
 Documentation/netlink/genetlink-c.yaml                                 |   14 
 Documentation/netlink/genetlink-legacy.yaml                            |   14 
 Documentation/netlink/genetlink.yaml                                   |   14 
 Documentation/netlink/netlink-raw.yaml                                 |   20 
 Documentation/networking/strparser.rst                                 |    2 
 Makefile                                                               |    2 
 arch/arm64/Kconfig                                                     |   30 
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi                         |   19 
 arch/arm64/include/asm/el2_setup.h                                     |    5 
 arch/arm64/include/asm/kvm_host.h                                      |    2 
 arch/arm64/include/asm/kvm_nested.h                                    |    3 
 arch/arm64/kernel/Makefile                                             |    3 
 arch/arm64/kernel/cpu_errata.c                                         |   24 
 arch/arm64/kernel/cpufeature.c                                         |    2 
 arch/arm64/kernel/signal.c                                             |   85 +-
 arch/arm64/kernel/topology.c                                           |   11 
 arch/arm64/kernel/vdso/Makefile                                        |    2 
 arch/arm64/kvm/arm.c                                                   |   10 
 arch/arm64/kvm/emulate-nested.c                                        |    4 
 arch/arm64/kvm/mmu.c                                                   |   46 -
 arch/arm64/kvm/nested.c                                                |   95 +-
 arch/arm64/kvm/vgic/vgic-its.c                                         |   22 
 arch/arm64/tools/cpucaps                                               |    2 
 arch/loongarch/vdso/Makefile                                           |    1 
 arch/powerpc/kernel/vdso/Makefile                                      |    1 
 arch/powerpc/perf/imc-pmu.c                                            |   23 
 arch/riscv/include/asm/scs.h                                           |   17 
 arch/riscv/kernel/entry.S                                              |    2 
 arch/riscv/kvm/aia_imsic.c                                             |    5 
 arch/riscv/mm/extable.c                                                |    4 
 arch/s390/kernel/vdso64/Makefile                                       |    1 
 arch/x86/entry/vdso/Makefile                                           |    1 
 arch/x86/events/intel/bts.c                                            |    2 
 arch/x86/events/intel/core.c                                           |    2 
 arch/x86/events/intel/p4.c                                             |    2 
 arch/x86/kvm/mmu/mmu.c                                                 |    6 
 arch/x86/kvm/svm/svm.c                                                 |   12 
 arch/x86/kvm/vmx/nested.c                                              |    6 
 crypto/drbg.c                                                          |   11 
 drivers/android/binder.c                                               |    3 
 drivers/block/virtio_blk.c                                             |    1 
 drivers/bluetooth/btintel.c                                            |   29 
 drivers/bluetooth/btintel_pcie.c                                       |  138 +++-
 drivers/bluetooth/btintel_pcie.h                                       |    2 
 drivers/bluetooth/btusb.c                                              |    2 
 drivers/char/tpm/tpm2-cmd.c                                            |    2 
 drivers/char/tpm/tpm2-sessions.c                                       |    1 
 drivers/edac/altera_edac.c                                             |    4 
 drivers/edac/amd64_edac.c                                              |    4 
 drivers/gpio/gpio-exar.c                                               |    2 
 drivers/gpio/gpio-xilinx.c                                             |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c                                |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                             |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                            |   77 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c                          |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                                |   17 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                                |    5 
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c                                  |    9 
 drivers/gpu/drm/amd/amdgpu/vi.c                                        |   21 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c                  |   32 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                                  |    7 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                      |   16 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c                |   20 
 drivers/gpu/drm/amd/display/dc/dc.h                                    |    1 
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c                  |    1 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c |    4 
 drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c         |    1 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                             |   39 -
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c                    |   10 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c                  |   11 
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c                                |    5 
 drivers/gpu/drm/display/drm_dp_helper.c                                |    4 
 drivers/gpu/drm/drm_fb_helper.c                                        |    6 
 drivers/gpu/drm/gud/gud_pipe.c                                         |    1 
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c                         |    2 
 drivers/gpu/drm/i915/gt/intel_rps.c                                    |    3 
 drivers/gpu/drm/imagination/pvr_mmu.c                                  |   25 
 drivers/gpu/drm/imagination/pvr_vm.c                                   |    8 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                                 |   17 
 drivers/gpu/drm/panthor/panthor_sched.c                                |    3 
 drivers/gpu/drm/radeon/radeon_bios.c                                   |    6 
 drivers/gpu/drm/vc4/vc4_bo.c                                           |   29 
 drivers/gpu/drm/vc4/vc4_crtc.c                                         |    4 
 drivers/gpu/drm/vc4/vc4_drv.c                                          |    8 
 drivers/gpu/drm/vc4/vc4_drv.h                                          |    2 
 drivers/gpu/drm/vc4/vc4_gem.c                                          |   32 
 drivers/gpu/drm/vc4/vc4_irq.c                                          |   16 
 drivers/gpu/drm/vc4/vc4_kms.c                                          |    2 
 drivers/gpu/drm/vc4/vc4_perfmon.c                                      |   20 
 drivers/gpu/drm/vc4/vc4_render_cl.c                                    |    2 
 drivers/gpu/drm/vc4/vc4_v3d.c                                          |   60 -
 drivers/gpu/drm/vc4/vc4_validate.c                                     |   10 
 drivers/gpu/drm/vc4/vc4_validate_shaders.c                             |    2 
 drivers/hid/bpf/hid_bpf_dispatch.c                                     |    2 
 drivers/hid/hid-multitouch.c                                           |    2 
 drivers/hid/hid-steam.c                                                |  226 +++----
 drivers/i2c/busses/i2c-at91-master.c                                   |    8 
 drivers/i2c/busses/i2c-xiic.c                                          |   98 +--
 drivers/iio/accel/kionix-kx022a.c                                      |   77 +-
 drivers/iio/accel/kxcjk-1013.c                                         |    2 
 drivers/iio/accel/sca3000.c                                            |    2 
 drivers/iio/adc/ad_sigma_delta.c                                       |   27 
 drivers/iio/adc/aspeed_adc.c                                           |   13 
 drivers/iio/adc/axp288_adc.c                                           |    8 
 drivers/iio/adc/max1363.c                                              |    8 
 drivers/iio/adc/pac1934.c                                              |    4 
 drivers/iio/adc/stm32-adc.c                                            |   43 -
 drivers/iio/adc/sun4i-gpadc-iio.c                                      |   10 
 drivers/iio/adc/xilinx-xadc-core.c                                     |    9 
 drivers/iio/buffer/industrialio-buffer-dmaengine.c                     |   16 
 drivers/iio/cdc/ad7150.c                                               |    8 
 drivers/iio/frequency/admv1013.c                                       |    9 
 drivers/iio/gyro/adis16136.c                                           |    2 
 drivers/iio/health/max30102.c                                          |   12 
 drivers/iio/imu/adis16400.c                                            |    2 
 drivers/iio/imu/adis16480.c                                            |    4 
 drivers/iio/industrialio-buffer.c                                      |    7 
 drivers/iio/industrialio-trigger.c                                     |    2 
 drivers/iio/light/gp2ap020a00f.c                                       |    2 
 drivers/iio/light/rohm-bu27034.c                                       |  133 +---
 drivers/iio/pressure/bmp280-core.c                                     |    2 
 drivers/iio/proximity/aw96103.c                                        |   30 
 drivers/iio/proximity/isl29501.c                                       |    2 
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c                      |    4 
 drivers/iio/proximity/sx9324.c                                         |    2 
 drivers/iio/proximity/vcnl3020.c                                       |   24 
 drivers/input/joystick/xpad.c                                          |    3 
 drivers/input/keyboard/atkbd.c                                         |    8 
 drivers/input/misc/ati_remote2.c                                       |   12 
 drivers/input/mouse/synaptics.c                                        |    7 
 drivers/input/serio/i8042-acpipnpio.h                                  |    9 
 drivers/input/touchscreen/s6sy761.c                                    |   14 
 drivers/md/dm-crypt.c                                                  |    7 
 drivers/md/dm-ioctl.c                                                  |   14 
 drivers/md/dm-snap.c                                                   |   14 
 drivers/memstick/core/memstick.c                                       |    8 
 drivers/memstick/host/rtsx_usb_ms.c                                    |   31 
 drivers/mmc/host/cavium-octeon.c                                       |    5 
 drivers/mmc/host/cavium-thunderx.c                                     |    5 
 drivers/mmc/host/mtk-sd.c                                              |    1 
 drivers/mmc/host/sdhci-sprd.c                                          |    4 
 drivers/mtd/devices/block2mtd.c                                        |    2 
 drivers/mtd/mtdcore.c                                                  |    2 
 drivers/mtd/nand/raw/cadence-nand-controller.c                         |    6 
 drivers/mtd/nand/raw/vf610_nfc.c                                       |   85 ++
 drivers/mtd/nand/spi/core.c                                            |   37 -
 drivers/net/amt.c                                                      |   48 -
 drivers/net/can/dev/skb.c                                              |    2 
 drivers/net/can/usb/f81604.c                                           |    2 
 drivers/net/dsa/microchip/ksz_common.h                                 |    2 
 drivers/net/ethernet/broadcom/bcmsysport.c                             |    8 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                              |   84 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                         |    5 
 drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c         |    4 
 drivers/net/ethernet/ibm/ibmveth.c                                     |   22 
 drivers/net/ethernet/intel/ice/ice_eswitch.c                           |    2 
 drivers/net/ethernet/marvell/mvneta.c                                  |    2 
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c                        |    4 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                            |   38 -
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c                       |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c                    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                        |   13 
 drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c                  |   13 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                      |  191 +++--
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h                      |   14 
 drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c                       |   24 
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c                    |   10 
 drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c                 |   16 
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h                         |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c                     |   10 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c                  |    9 
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c                    |    1 
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h                    |    1 
 drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c                  |    1 
 drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c             |    1 
 drivers/net/ethernet/microchip/vcap/vcap_api.c                         |    2 
 drivers/net/ethernet/microsoft/mana/mana_en.c                          |   10 
 drivers/net/pfcp.c                                                     |   10 
 drivers/net/usb/ax88179_178a.c                                         |    6 
 drivers/net/usb/qmi_wwan.c                                             |    1 
 drivers/net/veth.c                                                     |    1 
 drivers/net/wireguard/noise.c                                          |    7 
 drivers/net/wireguard/queueing.h                                       |    2 
 drivers/net/wireless/ath/ath11k/mac.c                                  |    1 
 drivers/net/wireless/ath/ath12k/qmi.c                                  |    9 
 drivers/net/wireless/ath/ath12k/qmi.h                                  |    3 
 drivers/net/wireless/ath/ath9k/hif_usb.c                               |   19 
 drivers/net/wireless/ath/ath9k/wmi.c                                   |   16 
 drivers/net/wireless/ath/ath9k/wmi.h                                   |    1 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c                |   27 
 drivers/net/wireless/intel/iwlegacy/3945-mac.c                         |    1 
 drivers/net/wireless/marvell/libertas/tx.c                             |    7 
 drivers/net/wireless/mediatek/mt76/mt7603/init.c                       |    1 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                       |    6 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c                        |    3 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                       |   12 
 drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c                   |  128 ++-
 drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h                   |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                        |    3 
 drivers/net/wireless/silabs/wfx/hif_tx.c                               |    4 
 drivers/net/wireless/st/cw1200/bh.c                                    |    8 
 drivers/net/wireless/st/cw1200/txrx.c                                  |   14 
 drivers/net/wireless/ti/wlcore/main.c                                  |    4 
 drivers/net/xen-netfront.c                                             |   16 
 drivers/nvme/host/multipath.c                                          |   10 
 drivers/nvme/host/pci.c                                                |    2 
 drivers/nvme/target/configfs.c                                         |    9 
 drivers/nvme/target/core.c                                             |    2 
 drivers/nvme/target/fabrics-cmd-auth.c                                 |    2 
 drivers/of/irq.c                                                       |    2 
 drivers/of/overlay.c                                                   |   17 
 drivers/pci/pci.c                                                      |   15 
 drivers/perf/arm_spe_pmu.c                                             |    4 
 drivers/pmdomain/imx/imx8m-blk-ctrl.c                                  |   15 
 drivers/pmdomain/rockchip/pm-domains.c                                 |   20 
 drivers/ptp/ptp_ocp.c                                                  |    2 
 drivers/regulator/ltc3676.c                                            |   15 
 drivers/regulator/tps6594-regulator.c                                  |    6 
 drivers/rtc/dev.c                                                      |    2 
 drivers/rtc/rtc-88pm80x.c                                              |    2 
 drivers/rtc/rtc-88pm860x.c                                             |    2 
 drivers/rtc/rtc-ab8500.c                                               |    2 
 drivers/rtc/rtc-ac100.c                                                |   39 -
 drivers/rtc/rtc-asm9260.c                                              |    2 
 drivers/rtc/rtc-at91rm9200.c                                           |    2 
 drivers/rtc/rtc-at91sam9.c                                             |    2 
 drivers/rtc/rtc-brcmstb-waketimer.c                                    |    2 
 drivers/rtc/rtc-cadence.c                                              |    2 
 drivers/rtc/rtc-cmos.c                                                 |    2 
 drivers/rtc/rtc-cros-ec.c                                              |    2 
 drivers/rtc/rtc-ds1685.c                                               |    2 
 drivers/rtc/rtc-ftrtc010.c                                             |    2 
 drivers/rtc/rtc-hid-sensor-time.c                                      |    2 
 drivers/rtc/rtc-imxdi.c                                                |    2 
 drivers/rtc/rtc-loongson.c                                             |    2 
 drivers/rtc/rtc-lpc24xx.c                                              |    2 
 drivers/rtc/rtc-max77686.c                                             |    2 
 drivers/rtc/rtc-mc13xxx.c                                              |    2 
 drivers/rtc/rtc-mpc5121.c                                              |    2 
 drivers/rtc/rtc-mpfs.c                                                 |    8 
 drivers/rtc/rtc-mt7622.c                                               |    2 
 drivers/rtc/rtc-mv.c                                                   |    2 
 drivers/rtc/rtc-mxc_v2.c                                               |    2 
 drivers/rtc/rtc-omap.c                                                 |    2 
 drivers/rtc/rtc-palmas.c                                               |    2 
 drivers/rtc/rtc-pcf50633.c                                             |    2 
 drivers/rtc/rtc-pic32.c                                                |    2 
 drivers/rtc/rtc-pm8xxx.c                                               |    2 
 drivers/rtc/rtc-pxa.c                                                  |    2 
 drivers/rtc/rtc-rc5t583.c                                              |    2 
 drivers/rtc/rtc-rtd119x.c                                              |    2 
 drivers/rtc/rtc-rzn1.c                                                 |    2 
 drivers/rtc/rtc-s3c.c                                                  |    2 
 drivers/rtc/rtc-sa1100.c                                               |    2 
 drivers/rtc/rtc-sh.c                                                   |    2 
 drivers/rtc/rtc-spear.c                                                |   13 
 drivers/rtc/rtc-stm32.c                                                |    2 
 drivers/rtc/rtc-stmp3xxx.c                                             |    2 
 drivers/rtc/rtc-sunplus.c                                              |    2 
 drivers/rtc/rtc-tegra.c                                                |    2 
 drivers/rtc/rtc-tps6586x.c                                             |    2 
 drivers/rtc/rtc-twl.c                                                  |    2 
 drivers/rtc/rtc-vt8500.c                                               |    2 
 drivers/rtc/rtc-wm8350.c                                               |    2 
 drivers/rtc/rtc-xgene.c                                                |    2 
 drivers/rtc/rtc-zynqmp.c                                               |    2 
 drivers/scsi/qedi/qedi_main.c                                          |    3 
 drivers/staging/greybus/uart.c                                         |    3 
 drivers/tee/optee/ffa_abi.c                                            |   38 -
 drivers/tee/optee/optee_ffa.h                                          |   27 
 drivers/tee/optee/optee_msg.h                                          |  132 +++-
 drivers/tee/optee/optee_private.h                                      |  120 +--
 drivers/tee/optee/optee_smc.h                                          |   37 +
 drivers/tee/optee/smc_abi.c                                            |   17 
 drivers/tee/tee_shm.c                                                  |    4 
 drivers/thunderbolt/ctl.c                                              |   63 -
 drivers/thunderbolt/quirks.c                                           |    3 
 drivers/thunderbolt/xdomain.c                                          |    4 
 drivers/tty/amiserial.c                                                |    9 
 drivers/tty/n_gsm.c                                                    |   47 -
 drivers/tty/serial/8250/8250_bcm7271.c                                 |    2 
 drivers/tty/serial/kgdboc.c                                            |    9 
 drivers/tty/serial/ma35d1_serial.c                                     |    6 
 drivers/tty/serial/max3100.c                                           |   13 
 drivers/tty/serial/qcom_geni_serial.c                                  |    5 
 drivers/tty/serial/sc16is7xx.c                                         |   53 +
 drivers/tty/serial/serial-tegra.c                                      |   18 
 drivers/tty/serial/serial_core.c                                       |    4 
 drivers/tty/serial/vt8500_serial.c                                     |    1 
 drivers/tty/tty_io.c                                                   |   54 +
 drivers/tty/tty_port.c                                                 |  205 +++---
 drivers/tty/vcc.c                                                      |    5 
 drivers/tty/vt/vc_screen.c                                             |   50 -
 drivers/tty/vt/vt.c                                                    |    5 
 drivers/usb/cdns3/cdns3-gadget.c                                       |    4 
 drivers/usb/cdns3/cdns3-pci-wrap.c                                     |    5 
 drivers/usb/chipidea/ci_hdrc_tegra.c                                   |    4 
 drivers/usb/class/cdc-acm.c                                            |   41 -
 drivers/usb/class/cdc-acm.h                                            |    1 
 drivers/usb/core/hub.c                                                 |    7 
 drivers/usb/core/message.c                                             |    8 
 drivers/usb/dwc2/hcd.c                                                 |    3 
 drivers/usb/dwc3/core.h                                                |   19 
 drivers/usb/dwc3/dwc3-am62.c                                           |    1 
 drivers/usb/dwc3/ep0.c                                                 |    9 
 drivers/usb/dwc3/gadget.c                                              |  108 +++
 drivers/usb/gadget/function/f_fs.c                                     |   15 
 drivers/usb/gadget/function/f_midi2.c                                  |    4 
 drivers/usb/gadget/function/f_uac1_legacy.c                            |    6 
 drivers/usb/gadget/udc/aspeed-vhub/core.c                              |    4 
 drivers/usb/gadget/udc/aspeed-vhub/dev.c                               |    2 
 drivers/usb/gadget/udc/aspeed-vhub/hub.c                               |    5 
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h                              |    1 
 drivers/usb/gadget/udc/dummy_hcd.c                                     |    4 
 drivers/usb/host/octeon-hcd.c                                          |    2 
 drivers/usb/host/ohci-da8xx.c                                          |    2 
 drivers/usb/host/ohci-s3c2410.c                                        |    1 
 drivers/usb/host/ohci-spear.c                                          |    4 
 drivers/usb/host/ohci-st.c                                             |    1 
 drivers/usb/serial/bus.c                                               |    6 
 drivers/usb/serial/cp210x.c                                            |    1 
 drivers/usb/serial/generic.c                                           |   10 
 drivers/usb/serial/option.c                                            |   14 
 drivers/usb/serial/quatech2.c                                          |   19 
 drivers/usb/serial/ssu100.c                                            |   18 
 drivers/usb/serial/usb-serial.c                                        |  127 +++
 drivers/usb/serial/xr_serial.c                                         |   10 
 drivers/usb/storage/sierra_ms.c                                        |    7 
 drivers/usb/typec/anx7411.c                                            |    5 
 drivers/usb/typec/tcpm/tcpm.c                                          |    2 
 drivers/usb/typec/tipd/core.c                                          |    8 
 drivers/usb/typec/ucsi/displayport.c                                   |    9 
 drivers/usb/typec/ucsi/ucsi.c                                          |   17 
 drivers/usb/typec/ucsi/ucsi_acpi.c                                     |   33 +
 drivers/usb/typec/ucsi/ucsi_glink.c                                    |   15 
 drivers/virt/nitro_enclaves/ne_misc_dev.c                              |    1 
 drivers/virt/vmgenid.c                                                 |    6 
 fs/attr.c                                                              |   12 
 fs/btrfs/scrub.c                                                       |    4 
 fs/btrfs/xattr.c                                                       |    9 
 fs/dcache.c                                                            |    4 
 fs/ext4/inode.c                                                        |    4 
 fs/f2fs/f2fs.h                                                         |    2 
 fs/f2fs/file.c                                                         |    4 
 fs/f2fs/gc.c                                                           |   36 -
 fs/f2fs/segment.c                                                      |   13 
 fs/fsopen.c                                                            |    3 
 fs/inode.c                                                             |   23 
 fs/jfs/jfs_dtree.c                                                     |   18 
 fs/namei.c                                                             |   29 
 fs/namespace.c                                                         |   87 +-
 fs/netfs/buffered_write.c                                              |    9 
 fs/netfs/direct_write.c                                                |    9 
 fs/netfs/internal.h                                                    |    2 
 fs/netfs/misc.c                                                        |   99 +++
 fs/smb/client/cifsfs.c                                                 |    7 
 fs/smb/client/cifsglob.h                                               |   10 
 fs/smb/client/cifssmb.c                                                |    2 
 fs/smb/client/dir.c                                                    |   39 -
 fs/smb/client/file.c                                                   |   17 
 fs/smb/client/inode.c                                                  |   30 
 fs/smb/client/link.c                                                   |   15 
 fs/smb/client/smb1ops.c                                                |   21 
 fs/smb/client/smb2file.c                                               |   19 
 fs/smb/client/smb2misc.c                                               |    9 
 fs/smb/client/smb2ops.c                                                |   38 -
 fs/smb/client/smb2pdu.c                                                |   38 -
 fs/smb/client/smb2proto.h                                              |    2 
 fs/smb/client/trace.h                                                  |   16 
 fs/smb/client/transport.c                                              |   69 +-
 fs/verity/Kconfig                                                      |    3 
 fs/verity/open.c                                                       |    8 
 fs/xfs/scrub/newbt.c                                                   |    8 
 fs/xfs/xfs_log_recover.c                                               |   13 
 include/linux/can/skb.h                                                |    2 
 include/linux/console.h                                                |    2 
 include/linux/fsverity.h                                               |   25 
 include/linux/lsm_hook_defs.h                                          |    2 
 include/linux/memcontrol.h                                             |   50 +
 include/linux/netfilter_netdev.h                                       |    2 
 include/linux/netfs.h                                                  |    2 
 include/linux/nvme.h                                                   |    4 
 include/linux/pagemap.h                                                |   16 
 include/linux/perf_event.h                                             |   17 
 include/linux/rtnetlink.h                                              |    7 
 include/linux/sched/ext.h                                              |    1 
 include/linux/sched/user.h                                             |    3 
 include/linux/security.h                                               |    5 
 include/linux/skbuff.h                                                 |    2 
 include/linux/soc/qcom/geni-se.h                                       |   15 
 include/linux/tty.h                                                    |    1 
 include/linux/tty_driver.h                                             |    6 
 include/linux/tty_port.h                                               |   30 
 include/linux/usb/serial.h                                             |    1 
 include/net/amt.h                                                      |    4 
 include/net/bluetooth/hci_core.h                                       |    5 
 include/net/ip.h                                                       |    7 
 include/net/mac80211.h                                                 |    4 
 include/net/netfilter/nf_conntrack.h                                   |   18 
 include/net/netfilter/nf_flow_table.h                                  |    2 
 include/net/proto_memory.h                                             |    2 
 include/net/sch_generic.h                                              |    9 
 include/net/sock.h                                                     |   22 
 include/net/strparser.h                                                |   10 
 include/net/tcp.h                                                      |    2 
 include/net/xdp.h                                                      |   34 -
 include/net/xdp_sock_drv.h                                             |   11 
 include/net/xsk_buff_pool.h                                            |    2 
 include/sound/core.h                                                   |    9 
 include/sound/sof/ipc4/header.h                                        |    2 
 include/uapi/linux/random.h                                            |    2 
 init/Kconfig                                                           |    5 
 io_uring/io_uring.c                                                    |    7 
 io_uring/waitid.c                                                      |   19 
 kernel/audit_tree.c                                                    |   24 
 kernel/cgroup/cpuset.c                                                 |  134 ++--
 kernel/dma/swiotlb.c                                                   |    6 
 kernel/events/core.c                                                   |  322 ++++------
 kernel/events/ring_buffer.c                                            |    7 
 kernel/kprobes.c                                                       |    8 
 kernel/sched/ext.c                                                     |   20 
 kernel/sched/sched.h                                                   |    1 
 kernel/trace/trace_event_perf.c                                        |    4 
 kernel/workqueue.c                                                     |    2 
 mm/damon/core.c                                                        |   48 -
 mm/memcontrol.c                                                        |   27 
 mm/secretmem.c                                                         |  117 +++
 mm/shmem.c                                                             |   70 --
 mm/vmpressure.c                                                        |    2 
 net/bluetooth/hci_conn.c                                               |   18 
 net/bluetooth/hci_core.c                                               |   55 +
 net/bluetooth/hci_debugfs.c                                            |    2 
 net/bluetooth/hci_event.c                                              |    7 
 net/bluetooth/hci_sock.c                                               |    2 
 net/bluetooth/hci_sync.c                                               |   19 
 net/bluetooth/iso.c                                                    |  153 +++-
 net/bluetooth/mgmt.c                                                   |    2 
 net/bluetooth/rfcomm/sock.c                                            |    5 
 net/bluetooth/rfcomm/tty.c                                             |    9 
 net/bluetooth/smp.c                                                    |    2 
 net/bridge/br_multicast.c                                              |   23 
 net/bridge/netfilter/nf_conntrack_bridge.c                             |   10 
 net/can/af_can.c                                                       |    6 
 net/can/bcm.c                                                          |    2 
 net/can/isotp.c                                                        |   11 
 net/can/j1939/socket.c                                                 |    1 
 net/can/j1939/transport.c                                              |    2 
 net/can/raw.c                                                          |    7 
 net/core/dev.c                                                         |  139 ++--
 net/core/flow_dissector.c                                              |   11 
 net/core/neighbour.c                                                   |   12 
 net/core/netdev-genl-gen.c                                             |    4 
 net/core/skbuff.c                                                      |   14 
 net/core/sock.c                                                        |   15 
 net/devlink/core.c                                                     |   10 
 net/ipv4/af_inet.c                                                     |    2 
 net/ipv4/cipso_ipv4.c                                                  |    8 
 net/ipv4/fib_semantics.c                                               |    3 
 net/ipv4/fib_trie.c                                                    |    2 
 net/ipv4/inet_connection_sock.c                                        |    2 
 net/ipv4/ip_output.c                                                   |   10 
 net/ipv4/route.c                                                       |    5 
 net/ipv4/tcp.c                                                         |    2 
 net/ipv4/tcp_input.c                                                   |    6 
 net/ipv4/tcp_ipv4.c                                                    |    2 
 net/ipv4/tcp_output.c                                                  |    2 
 net/ipv6/addrconf.c                                                    |    2 
 net/ipv6/ip6_output.c                                                  |   29 
 net/ipv6/route.c                                                       |    2 
 net/ipv6/seg6_iptunnel.c                                               |    2 
 net/mac80211/agg-rx.c                                                  |    2 
 net/mac80211/chan.c                                                    |   45 +
 net/mac80211/fils_aead.c                                               |    8 
 net/mac80211/ieee80211_i.h                                             |    2 
 net/mac80211/mesh_pathtbl.c                                            |   30 
 net/mac80211/mlme.c                                                    |    4 
 net/mac80211/rc80211_minstrel_ht.c                                     |   30 
 net/mac80211/spectmgmt.c                                               |    4 
 net/mac80211/sta_info.c                                                |    6 
 net/mac80211/tx.c                                                      |  128 +++
 net/mctp/device.c                                                      |    6 
 net/mptcp/protocol.c                                                   |   10 
 net/mptcp/subflow.c                                                    |   11 
 net/netfilter/ipset/ip_set_bitmap_gen.h                                |    2 
 net/netfilter/ipvs/ip_vs_conn.c                                        |    3 
 net/netfilter/ipvs/ip_vs_lblc.c                                        |    4 
 net/netfilter/ipvs/ip_vs_lblcr.c                                       |    3 
 net/netfilter/ipvs/ip_vs_sync.c                                        |   33 -
 net/netfilter/nf_conntrack_amanda.c                                    |    2 
 net/netfilter/nf_conntrack_broadcast.c                                 |    2 
 net/netfilter/nf_conntrack_core.c                                      |   13 
 net/netfilter/nf_conntrack_h323_main.c                                 |    4 
 net/netfilter/nf_conntrack_sip.c                                       |    4 
 net/netfilter/nf_flow_table_core.c                                     |  123 +++
 net/netfilter/nf_flow_table_offload.c                                  |   14 
 net/netfilter/nf_nat_bpf.c                                             |    3 
 net/netfilter/nf_nat_core.c                                            |    5 
 net/netfilter/nfnetlink_queue.c                                        |    7 
 net/netfilter/nft_ct.c                                                 |    2 
 net/netfilter/nft_flow_offload.c                                       |    7 
 net/netfilter/xt_CHECKSUM.c                                            |    6 
 net/openvswitch/actions.c                                              |    7 
 net/openvswitch/datapath.c                                             |    8 
 net/packet/af_packet.c                                                 |    6 
 net/rds/tcp.c                                                          |    9 
 net/sched/act_ct.c                                                     |    2 
 net/sched/act_skbedit.c                                                |    5 
 net/sched/cls_api.c                                                    |   15 
 net/sched/cls_route.c                                                  |    6 
 net/sched/em_text.c                                                    |    3 
 net/sched/sch_codel.c                                                  |    2 
 net/sched/sch_fq_codel.c                                               |    4 
 net/sctp/socket.c                                                      |    8 
 net/smc/af_smc.c                                                       |    7 
 net/strparser/strparser.c                                              |    6 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                               |    8 
 net/tipc/crypto.c                                                      |   20 
 net/tipc/node.c                                                        |   10 
 net/tipc/topsrv.c                                                      |   80 ++
 net/vmw_vsock/af_vsock.c                                               |    2 
 net/vmw_vsock/virtio_transport_common.c                                |    4 
 net/wireless/scan.c                                                    |   22 
 net/xfrm/xfrm_output.c                                                 |   16 
 security/keys/key.c                                                    |    6 
 security/keys/persistent.c                                             |   55 -
 security/security.c                                                    |    5 
 security/selinux/avc.c                                                 |    5 
 security/selinux/hooks.c                                               |   11 
 sound/core/seq/seq_compat.c                                            |    4 
 sound/pci/hda/hda_tegra.c                                              |    3 
 sound/pci/ice1712/ice1712.c                                            |    2 
 sound/soc/amd/yc/acp6x-mach.c                                          |    7 
 sound/soc/codecs/adau1372.c                                            |   18 
 sound/soc/codecs/max98363.c                                            |    2 
 sound/soc/codecs/rt1017-sdca-sdw.c                                     |   27 
 sound/soc/codecs/rt274.c                                               |    4 
 sound/soc/codecs/rt286.c                                               |    2 
 sound/soc/codecs/wm8903.c                                              |    2 
 sound/soc/qcom/lpass-cpu.c                                             |    4 
 sound/soc/samsung/i2s.c                                                |    8 
 sound/soc/sdw_utils/soc_sdw_utils.c                                    |   20 
 sound/soc/sof/intel/hda-loader.c                                       |    7 
 sound/soc/sof/ipc4-loader.c                                            |    6 
 sound/soc/sof/ipc4-priv.h                                              |    3 
 sound/soc/sof/ipc4.c                                                   |   14 
 sound/soc/tegra/tegra186_asrc.c                                        |    2 
 sound/usb/caiaq/device.c                                               |    3 
 sound/usb/line6/playback.c                                             |    7 
 sound/usb/misc/ua101.c                                                 |    9 
 sound/usb/quirks.c                                                     |    4 
 tools/net/ynl/ynl-gen-c.py                                             |   70 +-
 tools/testing/selftests/mm/hugepage-mremap.c                           |    5 
 tools/testing/selftests/mm/memfd_secret.c                              |   30 
 555 files changed, 5746 insertions(+), 2906 deletions(-)

Aamir Ahmed (3):
      rtc: ac100: Assign .num before accessing .hws
      wifi: wfx: validate MIB read length before copying to caller
      rtc: ac100: Fix clock provider use-after-free on probe failure

Aaron Kling (1):
      ALSA: hda/tegra: Re-enable SDO workaround for Tegra194

Aaron Ma (1):
      wifi: mt76: mt7925: restore the legacy BSS after MLO teardown

Abdurrahman Hussain (6):
      of/overlay: put property on deadprops only after changeset add succeeds
      of/overlay: only treat a positive changeset id as registered
      of/overlay: don't leak fragment references when changeset init fails
      of/overlay: don't create "//" paths for fragments targeting the root
      i2c: xiic: don't clobber msg->len to signal block-read completion
      i2c: xiic: preserve PEC byte length in SMBus block read setup

Abhishek Ojha (1):
      regulator: ltc3676: don't read the write-only HRST and CLIRQ registers

Aditya Dutt (1):
      jfs: fix array-index-out-of-bounds read in add_missing_indices

Adrian Bente (1):
      netfilter: flowtable: fix offloaded ct timeout never being extended

Adrian Betschart (1):
      drm/amd/display: Don't replace a sink mode that shares the native totals

Alan Stern (1):
      USB: gadget: dummy-hcd: Fix wait for outstanding request completions

Aldo Ariel Panzardo (2):
      Bluetooth: ISO: release unused CIS holds after channel attach
      HID: multitouch: stop the release timer from being rearmed on remove

Alex Deucher (1):
      drm/amdgpu: make Mac FB workaround generic

Alexander Lobakin (1):
      xdp, xsk: constify read-only arguments of some static inline helpers

Alireza Asgari (1):
      net: fix checksum offsets in skb_splice_from_iter()

Alvin Šipraga (2):
      ASoC: adau1372: allow sleepy powerdown GPIOs
      ASoC: adau1372: fix invalid default state of output ASRC and DAC muxes

Amit Sunil Dhamne (1):
      usb: typec: tcpm: recover after failure to start the frs ams

Andre Eikmeyer (1):
      drm/amdgpu: reset VI ASIC on MacBookPro15,1

Andrey Albershteyn (1):
      fs,fsverity: remove check for fsverity being enabled in setattr_prepare()

Anirudh Virdi (1):
      net/mlx5: Fix slab-out-of-bounds when handling team device events

Aohan Mei (1):
      netfilter: nft_flow_offload: drop flowtable reference on init error path

Arka Mondal (3):
      iio: gyro: adis16136: fix unprotected debugfs reads
      iio: imu: adis16400: fix unprotected debugfs reads
      iio: imu: adis16480: fix unprotected debugfs reads

Arthur Heymans (1):
      drm/amd/display: Preserve eDP mode on initial ASSR failure

Asad Kamal (1):
      drm/amd/powerplay: fix VoltageObjectInfo zero-stride loop and OOB read

Baha Mesleh (1):
      octeontx2-af: mcs: Fix SC resource cleanup loop

Baochen Qiang (1):
      wifi: ath12k: fix reusing m3 memory

Baolin Wang (3):
      mm: factor out the order calculation into a new helper
      mm: shmem: change shmem_huge_global_enabled() to return huge order bitmap
      mm: shmem: ignore sysfs configs for shmem forced collapse

Bean Huo (1):
      nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for Micron 4100AT

Beata Michalska (2):
      arm64: errata: Factor out broken AMU const counter cap
      arm64: errata: Add Cortex-A725 erratum 3821522 workaround

Ben Cressey (1):
      dm-crypt: reject the lmk IV mode with AEAD ciphers

Benjamin Tissoires (1):
      HID: bpf: cast size to ssize_t when checking hid_bpf_hw_request

Binbin Deng (1):
      net/mctp: publish the mctp_dev only after it is initialised

Carlo Szelinsky (1):
      USB: serial: option: add Quectel EG060W

Cezary Rojewski (2):
      ASoC: codecs: rt286: Revert delay value for jack setup
      ASoC: codecs: rt274: Fix format setting for 44100 rate

Chandrashekar Devegowda (3):
      Bluetooth: btintel: fix buffer over-read in btintel_hw_error()
      Bluetooth: btintel_pcie: fix plen overflow in btintel_pcie_recv_frame()
      Bluetooth: btintel_pcie: reject oversized TX packets in send_frame()

Chao Yu (3):
      f2fs: fix to reclaim space in f2fs_allocate_pinning_section()
      f2fs: fix to shrink gc_lock coverage in f2fs_gc_range()
      f2fs: fix to reset all pinned status during fggc

Chen Ni (1):
      usb: ohci-spear: Remove unnecessary NULL check before clk_disable_unprepare()

Chen Ridong (1):
      cpuset: separate tmpmasks and cpuset allocation logic

ChenXiaoSong (2):
      smb/client: use stack-allocated smb2_file_all_info in smb3_query_mf_symlink()
      smb/client: pass cifs_open_info_data to SMB2_open()

Chengfeng Ye (12):
      Bluetooth: RFCOMM: Fix initial port reference race
      Bluetooth: hci_sync: Fix inquiry cache use-after-free
      Bluetooth: hci_conn: Lock parent access during enhanced SCO setup
      Bluetooth: hci_core: Serialize ACL scheduling with channel deletion
      Bluetooth: hci_core: Serialize fragmented ISO packet queueing
      Bluetooth: hci_core: Serialize SCO and ISO scheduling with teardown
      Bluetooth: Serialize SMP remote OOB data access
      tipc: hold a reference to nodes found by link name
      net/smc: protect clcsock lifetime in smc_getname
      Bluetooth: hci_sock: Serialize dead-device detachment
      Bluetooth: ISO: Reject concurrent BIS listener setup
      Bluetooth: ISO: Serialize concurrent connect calls

Christian Brauner (7):
      namespace: don't copy an unmounted mount tree
      fs: refuse fspick() on internal superblocks
      namespace: check a submount for references right before unmounting it
      dcache: don't put a mountpoint on a dentry that's being removed
      namespace: don't let a pseudo dentry become the root of a mount
      namei: don't reveal overmounted entries in refwalk
      namespace: refuse an automount below a mount that is in no namespace

Christian Göttsche (1):
      selinux: fix data race on AVC latest_notif

Christoph Hellwig (1):
      fs,fsverity: reject size changes on fsverity files in setattr_prepare

Chuck Lever (1):
      svcrdma: Use svc_xprt_put to free listener on create failure

Cong Nguyen (2):
      iio: proximity: pulsedlight: fix iio_device left registered on PM setup failure
      iio: adc: max1363: sign-extend bipolar differential channel reads

Cristian Papa (1):
      wifi: mt76: mt7603: initialize global station WCID

Daehyeon Ko (10):
      nvme-multipath: fix underflow in ANA log bounds checks
      thunderbolt: Reject oversized XDomain properties responses
      ipv4: stop PMTU walk when nexthop group shrinks
      ipv4: stop exception dump when nexthop group shrinks
      ipv4: stop route notification sizing when nexthop group shrinks
      ipv4: do not warn on route notification size race
      ipv6: do not warn on route notification size race
      cipso: adjust cached option offsets when removing CIPSO
      vsock/virtio: account only unread bytes in read_skb()
      tcp: reject net_iov in zerocopy receive mapping hints

Daniel Machon (1):
      net: sparx5: free the matchall entry on destroy

Daniel Starke (1):
      tty: n_gsm: fix missing modem controls after DLCI open in convergence layer type 2

Dapeng Mi (1):
      perf/core: Check kernel access when kernel callchains are requested

Darrick J. Wong (2):
      xfs: don't let memory failures leak blocks and kill repairs
      xfs: fix cursor and pointer handling when recovering iunlink buckets

David Heidelberg (1):
      Input: s6sy761 - fix resume ordering and restore sensing

David Howells (1):
      cifs: Fix handling of a beyond-EOF DIO/unbuffered read over SMB1

Denis V. Lunev (1):
      openvswitch: fix soft lockup in the netlink flow dump

Devin Wittmayer (2):
      wifi: mt76: mt7925: don't put the band auto marker in TGID
      wifi: mt76: mt792x: pick the SAR table layout from the table itself

Dinh Nguyen (1):
      EDAC/altera: Fix memory leak on dci allocation failure

Dipayaan Roy (3):
      net: mana: check xdp_rxq registration before unreg in mana_destroy_rxq()
      net: mana: Skip WQ object destruction for uninitialized RXQ
      net: mana: remove double CQ cleanup in mana_create_rxq error path

Eric Biggers (2):
      fsverity: add dependency on 64K or smaller pages
      crypto: drbg - Fix ineffective sanity check

Eric Dumazet (7):
      net: restrict SO_RESERVE_MEM to TCP sockets and cap max value
      ipv6: sr: use skb_get_hash_net() in seg6_make_flowlabel()
      ipv6: use RCU in ip6_output()
      ipv4: free inet_opt and ireq_opt after an RCU grace period
      bnxt_en: fix DMA mapping length for padded small packets
      flow_dissector: avoid u16 truncation of skb->len when computing thoff
      flow_dissector: avoid u16 truncation of hlen in bpf_flow_dissect()

Fabrice Gasnier (2):
      iio: adc: stm32-adc: fix check on internal channel availability
      iio: adc: stm32-adc: fix possible division by zero in processed channel

Fan Wu (11):
      smb: client: fix cifsFileInfo reference leak in deferred close
      usb: gadget: aspeed-vhub: cancel wake work on device removal
      usb: typec: ucsi: glink: fix use-after-free of ucsi on remove
      usb: cdns3: fix use-after-free in cdns3_gadget_exit()
      tty: serial: max3100: shut down timer before freeing port
      serial: 8250_bcm7271: fix use-after-free in brcmuart_remove()
      iio: adc: xilinx-xadc: free IRQ before cancelling the unmask worker on unbind
      iio: light: gp2ap020a00f: drain irq_work after free_irq
      iio: trigger: cancel reenable_work before freeing trigger
      iio: adc: ad_sigma_delta: fix use-after-free on unbind
      drm/vc4: drain the hangcheck timer and works on V3D unbind

Felix Fietkau (2):
      wifi: mac80211: prevent AP VLAN tx from other interfaces
      wifi: mac80211: set info->band for 802.3 encap offload frames

Felix Gu (2):
      iio: adc: sun4i-gpadc-iio: clean up on thermal zone registration failure
      iio: adc: sun4i-gpadc-iio: drop underflowing pm_runtime_put() calls

Fernando Fernandez Mancera (2):
      netfilter: bpf: reject invalid NAT manipulation types
      net: openvswitch: validate transport header presence in set_ipv6_addr

Filipe Manana (1):
      btrfs: fix xattr replace when multiple xattrs are packed in the same item

Florian Fainelli (2):
      net: systemport: Fix buffer overflow in bcm_sysport_get_stats()
      net: systemport: Fix RUNT MIB counter register offset calculation

Florian Westphal (4):
      netfilter: ipset: do not update comments from kernel-side adds
      netfilter: conntrack: remove skb argument from nf_ct_refresh
      netfilter: conntrack: rework offload nf_conn timeout extension logic
      netfilter: conntrack: fix erronous removal of offload bit

Francisco Beltrán Millalén (1):
      drm/amdgpu: reset VI ASIC on MacBookPro14,3

Frank Sorenson (2):
      smb: client: fix OOB read/write from unvalidated DataOffset in coalesce_t2()
      smb: client: split cifsFileInfo bitfields to avoid shared-byte RMW races

Fredrik Nyberg (1):
      net: usb: ax88179_178a: fix rx frame length for non-last packets

Fuad Tabba (3):
      KVM: arm64: vgic-its: Don't dereference a NULL collection on ITT save
      KVM: arm64: Apply the fine-grained UNDEFs without FEAT_FGT
      arm64/boot: Don't set PMUv3p9 FGT2 bits without PMUv3

Georgios Karantzas (1):
      wifi: ath9k_htc: bound TX aggregation to MAX_TX_BUF_SIZE

Georgiy Osokin (1):
      tee: shm: reject zero-sized allocations in tee_dyn_shm_alloc_helper()

Gilberto Conde (1):
      net: usb: qmi_wwan: add Quectel EG120K-EA

Greg Kroah-Hartman (1):
      Linux 6.12.113

Guangshuo Li (7):
      drm/mediatek: Fix ovl adaptor platform device leak
      drm/amdgpu: fix IP instance memory leak on kobject add failure
      drm/amdgpu: fix ACP MFD device leak on init failure
      wifi: iwlegacy: 3945: free EEPROM data on remove
      mmc: cavium-octeon: destroy slot platform devices on remove
      mmc: cavium-thunderx: destroy slot platform devices on remove
      mmc: sdhci-sprd: disable runtime PM on remove

Guixin Liu (1):
      nvme-multipath: set BLK_FEAT_ZONED only after the zone info is known

Gyeyoung Baek (2):
      drm/imagination: Size page table preallocation by device address
      drm/imagination: Fix reference and vm_bo handling in remap()

Haishuang Yan (2):
      devlink: fix devlink_rel reference leak when notify work is pending
      pfcp: make sure the SEID is linear before reading it

Han Xu (1):
      mtd: spinand: Enable QE on all dies

Haojie Li (2):
      drm/mediatek: Add missing IS_ERR check for ovl_adaptor platform device
      drm/amdkfd: fix dma_buf reference leak in get_dmabuf_info

Haotian Zhang (1):
      Input: ati_remote2 - fix type confusion in device attribute handlers

Harshit Mogalapalli (1):
      net: microchip: vcap: stop scanning after deleting key field

Hongjian Dai (1):
      i2c: at91: release DMA channels when probe defers

Hui Peng (2):
      usb: core: clear both ep_in and ep_out for non-ep0 control endpoints
      sctp: copy zeroed stats to user in sctp_getsockopt_pr_streamstatus() when !streamoute

Hui Su (1):
      iio: pressure: bmp280: fix out-of-bounds access in sampling frequency lookup

HyeongJun An (1):
      ASoC: wm8903: Move the DRC QR threshold to the register that holds it

Ian Lin (2):
      USB: serial: option: add Compal EXM-G1x support
      USB: serial: option: add Compal EXC-T1 support

Ian Rogers (1):
      perf: Replace perf_event_header__init_id with full header init

Iaroslav Voitovych (1):
      Bluetooth: MGMT: Fix status of pending commands flushed on power off

Ilia Gavrilov (1):
      vsock: Fix memory leak in vmci_transport_recv_dgram_cb()

Ilkka Lappeteläinen (1):
      net/packet: prevent TX_RING byte count overflow

Imre Kaloz (1):
      drm/radeon: Read the VRAM VBIOS signature with readb()

Jakub Kicinski (3):
      tools: ynl-gen: use names of constants in generated limits
      tools: ynl-gen: support limits using definitions
      tools: ynl: add scope qualifier for definitions

Jamal Hadi Salim (5):
      net/sched: cls_api: reclaim an empty proto on the error path
      net/sched: fq_codel: match the no-drop threshold to the packet size
      net/sched: sch_codel: match the no-drop threshold to the packet size
      net: cap skb->queue_mapping when the tx queue is picked
      net/sched: em_text: reject unterminated algo before autoload

Jameson Thies (1):
      usb: typec: ucsi: displayport: Current CAM OOB index fixup

Jason A. Donenfeld (1):
      wireguard: noise: reject response consumption after intermediate initiation

Jeff Jo (1):
      tcp: refresh TS.Recent for accepted old ACKs

Jens Axboe (3):
      io_uring: fix task_work add use-after-free with SQPOLL
      io_uring/waitid: use io_waitid_remove_wq() consistently
      io_uring/waitid: fix KCSAN warning on io_waitid->head

Jens Wiklander (1):
      optee: sync secure world ABI headers

Jerome Tollet (2):
      net/mlx5e: Prevent stale XSK buffer release on refill retry
      net/mlx5e: Prevent stale XSK buffer release on MPWQE refill retry

Ji-Ze Hong (Peter Hong) (1):
      usb: f81604: fix struct f81604_int_data size mismatch

Jiajia Liu (1):
      Bluetooth: hci_event: fix simultaneous discovery stuck in FINDING

Jiakai Xu (1):
      RISC-V: KVM: Fix null pointer dereference in kvm_riscv_aia_imsic_has_attr()

Jiale Yao (1):
      iio: accel: kxcjk-1013: reject duplicate event disable

Jiangshan Yi (5):
      smb: client: clear setuid/setgid bit on write with cifsacl/modefromsid/posix extensions
      drm/amd/display: check dc_state_create_copy() for NULL in dm_suspend
      ASoC: codecs: max98363: fix uninitialized stream_config->type
      ASoC: codecs: rt1017-sdca-sdw: fix uninitialized stream_config->type
      tpm: fix off-by-four bounds check in tpm2_get_random()

Jiayuan Chen (1):
      bpf, xdp: move offload check into dev_xdp_install()

Jiazi Liu (1):
      usb: dwc3: gadget: fix IRQ storm on invalid event buffer count

Jie Deng (1):
      usb: cdns3: Fix NULL pointer dereference in cdns3_pci_probe

Jinseob Kim (1):
      iio: buffer: serialize buffer teardown with mode claims

Jiri Slaby (SUSE) (4):
      console: introduce console_lock guard()s
      tty/vt: use guard()s
      tty: introduce tty_port_tty guard()
      tty: tty_port: use guard()s

Johan Hovold (13):
      USB: cdc-acm: fix racy TIOCMIWAIT implementation
      USB: serial: fix port tear down use-after-free
      tty: amiserial: fix broken TIOCMIWAIT
      tty: abort break signalling on hangup
      serial: fix TIOCMIWAIT race
      USB: serial: quatech2: fix baud rate overflow
      USB: serial: ssu100: fix baud rate overflow
      USB: serial: fix dynamic id driver deregistration race
      USB: serial: fix driver deregistration order
      USB: serial: fix ioctl hangup race
      tty: fix saved termios reset race
      tty: tty_port: restore TTY_IO_ERROR on activation failure
      tty: port: fix tty_port_tty_vhangup() race

Johannes Berg (1):
      Revert "wifi: libertas: reject short monitor TX frames"

Jonathan Cameron (1):
      iio: buffer: Ensure bounce buffer used for unaligned case is zeroed.

Josef Bacik (3):
      xen/netfront: drop RX packets with a short Ethernet header
      xen/netfront: don't leak the skb when xennet_fill_frags() fails
      net: skbuff: don't leave stale bytes in skb_copy_and_csum_bits()

Joshua Rogers (2):
      tty: vcc: zero-initialize control packet in vcc_send_ctl()
      tty: vcc: hold port lock when clearing tty pointer in vcc_cleanup

Julian Anastasov (3):
      ipvs: fix missing counter decrement in lblc
      ipvs: do not create invisible templates
      ipvs: filter some flags received in the backup server

Julian Sun (1):
      nvmet: preserve device path on allocation failure

Jun Yang (1):
      sctp: check RCV_SHUTDOWN after the sendmsg connect wait

Junjie Cao (1):
      wifi: mt76: mt792x: treat 0xff ACPI SAR entries as no limit

Jérémy Carrat (1):
      USB: serial: cp210x: add Corsair AX1500i Power Supply

Jérémy Jean (2):
      audit: fix exe mark UAF in kill_rules()
      tipc: prevent GCM nonce reuse on peer key changes

Karl Bonde Torp (1):
      nvme: fix swapped ZRASF zone state values for full and read only

Karl Mehltretter (5):
      mtd: core: call _get_device() with the master MTD
      random: fix vgetrandom_opaque_params kernel-doc
      arm64: irq: exclude the softirq stack switch from KCOV
      keys: finalize persistent keyring timeout after link attempt
      riscv: fix load_unaligned_zeropad() fixup for RV32

Kefeng Wang (1):
      mm: shmem: remove __shmem_huge_global_enabled()

Kiran K (1):
      Bluetooth: btintel_pcie: Add recovery mechanism

Krzysztof Furman (1):
      Input: xpad - add support for Corsair Novablade Pro

Krzysztof Karas (2):
      drm/i915/gem: Prevent overstepping exec array boundary
      drm/i915/gt: Unmask interrupts only when ACTIVE is true

Krzysztof Kozlowski (1):
      iio: adc: aspeed: Simplify with dev_err_probe

Kuba Piecuch (1):
      sched_ext: Generate qseq from a per-task counter

Kuniyuki Iwashima (6):
      neighbour: Skip default parms when resumed in neightbl_dump_info().
      memcg: convert memcg->socket_pressure to u64
      mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
      net: Clean up __sk_mem_raise_allocated().
      net-memcg: Introduce mem_cgroup_from_sk().
      net-memcg: Introduce mem_cgroup_sk_enabled().

Kurt Lieber (1):
      thunderbolt: Disable CL states for the Anker Prime TB5 dock

Kyle Zeng (1):
      ALSA: seq: Serialize compat port-info ioctls

Laxman Acharya Padhya (1):
      iio: proximity: aw96103: validate firmware data length

Leo Li (1):
      drm/amd/display: Fix direct scanout alpha on some DRM_FORMATs

Leon Hwang (1):
      kprobes: Skip disarmed probes when checking optkprobe overlap

Li RongQing (1):
      net/mlx5e: Order ICOSQ cc update after CQ doorbell

Liew Rui Yan (1):
      mm/damon/core: fix unconditionally skip last region

Linkai Gong (1):
      usb: typec: anx7411 - stop the IRQ before destroying the workqueue

Linmao Li (1):
      Bluetooth: hci_core: Fix inquiry cache timestamps on 64-bit systems

Liu Chao (1):
      usb: gadget: f_uac1_legacy: validate bRequest index in generic_{set,get}_cmd

Liu Dalin (1):
      rtc: dev: zero-initialize struct rtc_wkalrm to prevent information leak

Lorenzo Bianconi (1):
      net: mvneta: clear XDP pfmemalloc flag between frames

Lorenzo Stoakes (ARM) (1):
      mm/secretmem: properly account locked pages

Lovekesh Solanki (3):
      Input: i8042 - add nomux quirk for Fujitsu LIFEBOOK U7410
      Input: synaptics - add LEN205b entry to smbus_pnp_ids for ThinkPad T490
      usb: hub: use shorter 120ms post resume hold for SS root hubs

Luo Gengkun (2):
      perf: Fix race between perf_event_exit_task() and perf_pending_task()
      perf: Remove unnecessary parameter of security check

Ma Xinmeng (1):
      dm-snap: reject the transient exception store for snapshot-merge

Mahantesh Salimath (1):
      tee: optee: ffa: support shared memory offsets on large-page kernels

Manikanta Guntupalli (1):
      i2c: xiic: Relocate xiic_i2c_runtime_suspend and xiic_i2c_runtime_resume to facilitate atomic mode

Manush Prajwal (1):
      rtc: mpfs: fix unchecked devm_clk_get() error pointer in probe()

Maoyi Xie (1):
      rds_tcp: close NULL deref window in rds_tcp_set_callbacks

Marc Zyngier (3):
      KVM: arm64: nv: Fix life cycle of the nested_mmus array
      KVM: arm64: nv: Delay freeing of shadow S2 structures until VM destruction
      KVM: arm64: vgic-its: Fix MOVALL handling of source redistributor

Marco Chen (1):
      iio: health: max30102: fix NULL dereference in interrupt handler

Marek Szyprowski (2):
      swiotlb: fix default_swiotlb_limit() for non-growable default pool
      ASoC: samsung: i2s: enable op_clk in probe to balance runtime PM

Marian Rotariu (1):
      usb: typec: tipd: don't send GAID when probe fails in APP mode

Mark Rutland (4):
      arm64/fpsimd: signal: Clear PSTATE.SM when restoring FPSIMD frame only
      arm64/fpsimd: signal: Mandate SVE payload for streaming-mode state
      arm64/fpsimd: signal: Consistently read FPSIMD context
      arm64/fpsimd: signal: Forbid non-streaming SVE payload on SME-only systems

Martino Papero (1):
      Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3 15IWC11

Matthew Wilcox (Oracle) (1):
      fs: Free any excess xarray nodes in clear_inode()

Matti Vaittinen (6):
      iio: accel: kionix-kx022a: Fix array boundary check
      iio: accel: kx022a: Use cleanup.h helpers
      iio: accel: kionix-kx022a: Prevent memory leak and fix state
      iio: bu27034: simplify using guard(mutex)
      iio: light: rohm-bu27034: Fix infinite delay on error
      iio: light: rohm-bu27034: Fix error return

Maxim Skokov (1):
      Bluetooth: RFCOMM: free the skb when the DLC has no owner

Maxime Ripard (1):
      drm/vc4: Make v3d paths unavailable on any generation newer than vc4

Maíra Canal (2):
      drm/vc4: Free the BO cache size list on teardown
      drm/vc4: Fix binner slot allocation failing on an idle GPU

Mehmet Fide (2):
      mtd: rawnand: vf610_nfc: fix reads on chips with more than 64 bytes of OOB
      mtd: rawnand: vf610_nfc: fix false bitflips on reads of erased pages

Michael Chan (2):
      bnxt_en: Add bnxt_clear_bars() helper
      bnxt_en: Fix driver init in kdump kernel

Michael Garland (1):
      ASoC: amd: yc: Add DMI quirk for Acer Aspire Go 15 (AG15-21P)

Michael Hennerich (1):
      iio: buffer-dmaengine: fix sg entry iteration when building dma_vecs

Michael S. Tsirkin (1):
      ipv4: validate checksum_start before completing checksum

Michele Dionisio (1):
      wifi: brcmfmac: fix P2P device removal race in brcmf_detach()

Mika Westerberg (1):
      thunderbolt: Fix KASAN reported use-after-free when request is canceled

Mike Rapoport (Microsoft) (1):
      selftests/mm: hugetlb-mremap: add setup of HugeTLB pages

Mikhail Gavrilov (1):
      drm/amdgpu: copy debugfs register data outside the GRBM/SRBM locks

Mikulas Patocka (1):
      dm: fix reading free memory in do_resume

Ming Qian (1):
      pmdomain: imx8m-blk-ctrl: Serialize power on/off across sibling domains

Mingming Cao (2):
      ibmveth: h_free logical LAN on open-fail after register
      ibmveth: fix TX LTB and filter unwind on open-fail

Mingyu Wang (1):
      tty: vt: fix memory leak in vc_allocate()

Mostafa Saleh (1):
      KVM: arm64: Use stage-1 leaf size for VM_PFNMAP

Myeonghun Pak (6):
      usb: ohci-da8xx: disable controller wakeup on cleanup
      usb: ohci-s3c2410: disable controller wakeup on removal
      usb: ohci-st: disable controller wakeup on removal
      usb: chipidea: tegra: disable runtime PM on resume failure
      usb: ohci-spear: disable controller wakeup on removal
      drm/aspeed: Balance the display clock enable on teardown

Namjae Jeon (1):
      smb: client: use finish_no_open() for non-regular inodes

Nathan Chancellor (1):
      random: vDSO: avoid call to memset() when zeroing reserved parameter

Nguyen Ngoc Thang (4):
      ALSA: caiaq: unregister the input device when probe fails
      Bluetooth: hci_sync: don't drain cmd_sync backlog on unregister
      memstick: rtsx_usb_ms: complete requests after eject instead of dropping them
      drm/fb-helper: defer setup when fbdev_probe() fails, not just on -EAGAIN

Nicolai Buchwitz (1):
      net: bcmgenet: fix NULL dereference in set_coalesce before first open

Nicolas Cavallari (1):
      wifi: mt76: mt7915: disable rx napi when removing device

Nicolas Escande (1):
      wifi: ath11k: reset ar->num_stations on hardware start

Niklas Cassel (1):
      virtio_blk: set the zone write granularity

Nikola Prica (1):
      PCI: Accept AtomicOps already enabled by the hypervisor

Nuno Sá (2):
      mtd: spinand: fix zero oobavail when no ECC engine is used
      mtd: spinand: fix NULL pointer dereference with no ECC engine

Oleg Keri (1):
      drm/dp: don't mark the AUX backlight enabled when enabling failed

Oliver Hartkopp (1):
      can: fix unique skb identifier regression under RPS

Omar Ramadan (1):
      amt: send the relay's General Query directly from the receive path

Orgad Shaneh (1):
      usb: octeon-hcd: fix the FIFO-flush timeout computation

Osama Abdelkader (1):
      drm/panthor: validate userspace queue count against initialized firmware slot count

Pablo Neira Ayuso (1):
      netfilter: flowtable: generalize pending status bit

Palla Raghunath (2):
      dm ioctl: don't let data_start run past the buffer
      Bluetooth: RFCOMM: Fix NULL tty_dev dereference in rfcomm_dev_shutdown

Pannarat Wiriyaarritham (1):
      usb: typec: ucsi: acpi: Assume UCSI 1.2 on Acer Nitro ANV15-41

Paolo Abeni (1):
      mptcp: prevent race between disconnect() and rtx

Paul Mbewe (2):
      serial: sc16is7xx: fix TX gap caused by kfifo circular buffer wrap-around
      serial: sc16is7xx: refill TX FIFO below trigger using fresh TXLVL

Paulo Alcantara (4):
      smb: client: discard post-EOF pagecache when extending a file via zero range
      smb: client: discard post-EOF pagecache when extending a file via copy range
      netfs: clear post-EOF pagecache when extending a file via write
      smb: client: only require read lease for size-extending preallocate

Pavankumar Kondeti (1):
      workqueue: Fix NULL current_pwq deref in chained work check

Pei Xiao (1):
      mtd: block2mtd: Fix divide error when erase_size is zero

Pengpeng Hou (3):
      wifi: ath9k: reject short WMI command responses
      iio: adc: aspeed: propagate reset deassert errors
      iio: cdc: ad7150: fix OF matching and publish module aliases

Peter Ujfalusi (2):
      ASoC: SOF: ipc4-priv: Add kernel doc for fw_context_save of sof_ipc4_fw_data
      ASoC: SOF: ipc4/Intel: Add support for library restore firmware functionality

Petr Machata (1):
      mlxsw: spectrum_flower: Fix port range register leak in tmplt_create()

Prashanth K (1):
      usb: typec: ucsi: Get the connector fwnode based on reg value

Prathamesh Deshpande (1):
      net/mlx5e: Fix AF_XDP TX timestamp teardown NULL dereference

Qishuai Liu (1):
      ipv6: fix prefix route expiry in modify_prefix_route()

Quchaosheng (1):
      net/packet: guard the ll header push in packet_rcv_spkt()

Quentin Freimanis (1):
      net: sparx5: make ports inherit the switch base mac address type

Radhey Shyam Pandey (2):
      usb: dwc3: am62: Fix runtime PM usage count leak on probe error path
      usb: typec: tipd: fix uninitialized typec_partner_desc in tps6598x_connect()

Raj Ojha (1):
      memstick: core: wait for request completion before freeing card

Ramses de Norre (1):
      wireguard: queueing: preserve tstamp_type when encapsulating packet

Raphaël Larocque (1):
      Input: synaptics - limit T440p InterTouch quirk to LEN0036

Ravindra (1):
      Bluetooth: btintel_pcie: fix TX descriptor bounds check

Remy D. Farley (1):
      doc/netlink: netlink-raw: Add max check

Richard Fitzgerald (1):
      ASoC: sdw_utils: Set snd_soc_dai_link_ch_map.codec_ch_mask for capture

Ridham Khurana (2):
      gpio: xilinx: fix runtime PM leak on request error path
      regulator: tps6594-regulator: Fix n_linear_ranges for TPS65224 BUCK2-4

Rodrigo Zaiden (1):
      tee: optee: fix kernel-doc warnings

Rongwei Liu (1):
      net/mlx5: LAG, Refactor lag logic

Ruide Cao (1):
      wifi: mac80211: reject invalid 320 MHz CSA bandwidth

Runyu Xiao (6):
      rtc: spear: initialize IRQ state before requesting alarm IRQ
      mtd: rawnand: cadence: Initialize IRQ state before requesting IRQ
      iio: admv1013: initialize callback mutex before registering notifier
      USB: dwc2: shut down wakeup timer before freeing HCD state
      scsi: qedi: Initialize callback state before registration
      Bluetooth: btintel_pcie: use managed IRQ teardown

SJ Park (1):
      mm/damon/core: don't skip damos_adjust_quota() while esz is not zero

Sabrina Dubroca (1):
      strparser: make sure __strp_recv isn't running before tearing down the parser

Sai Teja Aluvala (2):
      Bluetooth: btintel: validate DDC record lengths
      Bluetooth: btintel_pcie: Add shared HW reset for clean start

Sajal Gupta (1):
      drm/gud: don't keep a connector without a CRTC as connector_state

Salah Triki (4):
      iio: accel: sca3000: fix frequency divider condition check
      iio: frequency: admv1013: fix wrong channel field used in admv1013_read_raw()
      iio: proximity: isl29501: Fix return type of isl29501_register_write
      iio: proximity: vcnl3020: fix ISR bitmask check in IRQ handler

Saleel Kudchadker (1):
      drm/amdkfd: align SDMA doorbell base for shader doorbell writes

Sandeep Haemoon (1):
      net: ethernet: mtk_eth_soc: allocate dummy netdev sooner

Sang-Hoon Choi (4):
      Bluetooth: hci_core: free the HCI ID if naming fails
      gpio: exar: initialize the ID before registering its cleanup
      cxgb4/ch_ktls: disable softirqs around tid_list erases
      nvmet: use the local P2P device on metadata allocation failure

Sean Christopherson (3):
      KVM: nVMX: Force MSR bitmap refresh if runtime eVMCS controls are modified
      KVM: x86/mmu: Bail from shadow walks if the root is invalid or a dummy
      KVM: SVM: Use the active VMCB's MSR bitmap when checking if MSR is intercepted

Sebastian Sjoholm (1):
      USB: serial: option: add Quectel RG660QB

Sebastien Royen (1):
      net: dsa: microchip: fix KSZ8765 fiber detection

SeongJae Park (1):
      mm/damon/core: do non-safe region walk on kdamond_apply_schemes()

SeungJu Cheon (1):
      Bluetooth: ISO: Fix data-race on iso_pi(sk) in socket and HCI event paths

Shao-Fu Chen (1):
      optee: register TEE devices only once fully initialized

Shawn Lin (3):
      pmdomain: rockchip: don't ignore clock lookup errors on attach
      pmdomain: rockchip: fix clock leak on domain probe failure
      pmdomain: rockchip: propagate subdomain add errors

Sheetal (1):
      ASoC: tegra: Fix ASRC Stream6 input threshold control

Simon Gassner (1):
      serial: tegra: don't clear the Tx FIFO on an Rx-only reset

Slavin Liu (1):
      iio: adc: pac1934: check ACPI label duplication

Stephen Smalley (1):
      selinux: preserve NATIVE_LABELS on already-initialized sb in set_mnt_opts

Surendran Kanagaraj (1):
      tpm: Disable TPM on null key name mismatch

Syed Labeeq Sajid Bukhari (1):
      usb: storage: sierra_ms: reject short SWoC info transfers

Takashi Iwai (4):
      ALSA: usb-audio: Apply IGNORE_CTL_ERROR quirk to all Audient devices
      ALSA: core: Define auto-cleanup for snd_card_free()
      ALSA: ice1712: Fix the error handling via auto-cleanup at probe
      usb: gadget: midi2: Fix the jack descriptor array sizes

Tamizh Chelvam Raja (3):
      wifi: mac80211: Add multicast to unicast support for 802.3 path
      wifi: mac80211: Add 802.3 multicast encapsulation offload support
      wifi: mac80211: Add sta pointer sanity check in ieee80211_8023_xmit()

Tao Gong (1):
      wifi: mt76: mt7996: fix struct mt7996_mcu_wed_rro_ba_delete_event layout

Tetsuo Handa (1):
      perf/core: Fix WARN in perf_sigtrap()

Tianchu Chen (1):
      wifi: cw1200: fix TX padding OOB read leaking heap data to device

Tianyi Gao (1):
      veth: fix peer NETDEV_XDP_ACT_NDO_XMIT after GRO is toggled while down

Tibor Harcsa (1):
      Bluetooth: btusb: Add IMC Networks QCA9377 to quirks table

Timur Kristóf (4):
      drm/amd/pm/si: Check AMD_IS_MOBILITY flag for PPSMC_SYSTEMFLAG_GPIO_DC
      drm/amd/pm/si: Fix updating clock limits on AC/DC
      drm/amd/display: Fix fast updates on DCE 8.1
      drm/amd/display: Mark DCE 6.4 as not APU

Tomer Pomeranc (2):
      binder: fix is_failure flag for superseded transaction cleanup
      binder: fix leaked fd fixups on TF_UPDATE_TXN supersede

Tristan Madani (1):
      ice: fix metadata_dst refcount handling on representor teardown

Uwe Kleine-König (1):
      rtc: Switch back to struct platform_driver::remove()

Vadim Fedorenko (1):
      ptp: ocp: fix PCIe delay estimation calculation

Vicki Pfau (4):
      HID: steam: Fully unregister controller when hidraw is opened
      HID: steam: Rearrange teardown sequence
      HID: steam: Refactor registration
      HID: steam: Clean up locking

Victor Nogueira (1):
      net/sched: cls_route: reject change with no routing attribute

Viken Dadhaniya (2):
      soc: qcom: geni-se: Correct QUP Core ICC vote constants
      tty: serial: qcom_geni_serial: Keep console RX functional after deep idle

Vincent Jardin (3):
      arm64: dts: lx2160a: fix incorrect pinmux
      arm64: dts: lx2160a: fix IIC1 pinmux submask rejected by pinctrl-single
      arm64: dts: lx2160a: fix the iic5 spi3 pinmux offset and value

Vishal Badole (1):
      EDAC/amd64: Mask UMC chip select to the four implemented selects

Vitaly Prosyak (1):
      drm/amdgpu: serialize vblank counter reads against GPU reset

Vladyslav Ivashchenko (1):
      iio: adc: axp288: Add TS bias override for Haier HV103H

Waiman Long (1):
      cgroup/cpuset: Call is_in_v2_mode() after acquiring cpuset_mutex in cpuset_handle_hotplug()

Weiming Shi (1):
      nvmet-auth: fix out-of-bounds write in nvmet_auth_challenge()

Wentao Liang (7):
      of/irq: Fix remaining refcount leaks in of_irq_init()
      wifi: wlcore: Fix runtime PM leak in wlcore_remove()
      drm/mediatek: Fix pdev reference leak in mtk_drm_bind()
      kgdboc: Fix tty driver reference leak in configure_kgdboc()
      serial: ma35d1: Fix clock reference leak in ma35d1serial_probe()
      serial: vt8500: Fix clock reference leak in vt8500_serial_probe()
      btrfs: scrub: fix local_root reference leak in scrub_print_warning_inode()

Willem de Bruijn (1):
      net: extend IPv6 exthdr detection of tunneled packets

Willian Oliveira (1):
      drm/amdgpu/gfx6: fix firmware leak on teardown

Xiang Mei (2):
      ALSA: line6: reject oversized playback packets
      ALSA: ua101: reject mismatched capture/playback packet sizes

Xuanqiang Luo (1):
      pfcp: fix socket lifetime on netdevice registration failure

Yi Yang (1):
      vc_screen: reload vc pointer before if (ret) in vcs_write() to avoid UAF

Yibo Tan (1):
      mmc: mtk-sd: Cancel request timeout work on remove

Yuchao Zhang (2):
      USB: cdc-acm: skip URB restart in port_shutdown if disconnected
      usb: gadget: f_fs: Fix NULL pointer dereference in FUNCTIONFS_ENDPOINT_DESC

Yuqi Xu (3):
      wifi: mac80211: minstrel_ht: validate fixed rate index
      wifi: mac80211: handle empty FILS association request payload
      tipc: destroy topsrv workqueues before closing connections

Yuxiao Wang (1):
      nitro_enclaves: fix use-after-free on SLOT_ALLOC failure

Zhang Jie (1):
      iio: proximity: sx9324: Correct proximity channel resolution

Zhao Dongdong (1):
      USB: serial: option: add support for SIMCom SIM8260C

Zhao Li (6):
      wifi: cfg80211: preserve hidden-group beacon IE ownership
      wifi: mac80211: drain PS delivery work during station teardown
      wifi: mac80211: account proxy paths against the mesh path limit
      wifi: mac80211: keep fallback association elements alive
      wifi: mac80211: release mesh path quota on failed additions
      wifi: mac80211: shut down RX BA session timer on teardown

Zhengchuan Liang (1):
      perf: Require kernel access for text poke events

Zhichen Wang (1):
      virt: vmgenid: set driver_data before registering notification handlers

Zhiling Zou (3):
      ipvs: bound LBLCR and LBLC cache growth
      wifi: mac80211: keep paired old chanctx alive
      wifi: mac80211: count only matching reservations in reserved switch

Zihan Xi (3):
      smb: client: close handle after create-context parsing failure
      smb: client: close completed creates on compound wait errors
      wifi: mac80211: fix mesh fast xmit path deletion UAF

Zimeng Li (1):
      ASoC: qcom: lpass-cpu: use DAI table index for playback constraints

Zixuan Chai (1):
      net: bridge: avoid recursive multicast port cleanup

Ziyi Guo (1):
      riscv: entry: gate shadow call stack reload on sstatus.SPP, not tp

Zizhi Wo (1):
      vt: skip screen update for DEC alignment test on backgroup consoles

성병찬 (1):
      KEYS: Fix add_key() race with keyring restriction

