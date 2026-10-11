Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836D8450415;
	Sun, 11 Oct 2026 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791726826; cv=none; b=GYibmRmZnsq7inK6uAkk/E68XpG7hjp1sk+gf/QlzmD3Sla+xLD8OJ9yKAKhAXFJ5cmBqQ4Rf5l252pMWXcv9GRZ9DI57iWfit+P4yR0vw0VAA981zqDDjB8PhXO9RXHmujuE3ajMCsMtPHHAwjSDl2u61HWnU25YdjADIUj1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791726826; c=relaxed/simple;
	bh=PepL0itbaf/YY95Co0apZ9HlNXcEkahaTnVSfW6NuRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cPY3XXvAhtBZqDEYgky759G+ZlULRDVXGbvksawFFNen2AK2PJot5lMzAFmF0nFan89jcvuz0R/t1P3raZzlIKWpqUKcAhuIPIoh14ll2mFZPf7XFUYMZJYiCVxT0R2cCYvTpHbt55f47fVJ36W+eUTk+f/QWS402YD/hb86o0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rUZHusPR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rUZHusPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3AB1F0089C;
	Sun, 11 Oct 2026 13:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791726823;
	bh=sScXyhbdG0GP1D/TfnEJ1PBsMBpmS97sOUs/fXhNkdE=;
	h=From:To:Cc:Subject:Date;
	b=rUZHusPRyFnDMqkO1WcmTSZZPlhqvmbuqHqtu7wgIxdCrmeeMmBSko3494Vk0IJsH
	 g5A5eP8CHEXYnLKB6DYzcQt8FnthjwUAjh88JLjdxgmujbudaDazjEzx9WHHUK2BcN
	 bk+UucsVIL64ovcA8U7qnyVPZPkD0xQ3LDCZ+FKY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.2.10
Date: Sun, 11 Oct 2026 15:53:27 +0200
Message-ID: <2026101128-gave-stiffen-b868@gregkh>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.2.10 kernel.

All users of the 7.2 kernel series must upgrade.

The updated 7.2.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.2.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arch/arm64/silicon-errata.rst                            |    2 
 Documentation/filesystems/netfs_library.rst                            |   26 
 Makefile                                                               |    2 
 arch/arc/include/asm/atomic64-arcv2.h                                  |    6 
 arch/arc/include/asm/cmpxchg.h                                         |    4 
 arch/arm64/Kconfig                                                     |   30 
 arch/arm64/kernel/cpu_errata.c                                         |   24 
 arch/arm64/kernel/cpufeature.c                                         |    2 
 arch/arm64/kernel/signal.c                                             |   34 
 arch/arm64/kernel/topology.c                                           |   17 
 arch/arm64/kernel/vdso/Makefile                                        |    2 
 arch/arm64/kvm/emulate-nested.c                                        |    3 
 arch/arm64/kvm/hyp/nvhe/pkvm.c                                         |    9 
 arch/arm64/kvm/mmu.c                                                   |   47 -
 arch/arm64/kvm/vgic/vgic-its.c                                         |   12 
 arch/arm64/kvm/vgic/vgic-v2.c                                          |    6 
 arch/arm64/kvm/vgic/vgic-v3.c                                          |    6 
 arch/arm64/kvm/vgic/vgic.c                                             |   21 
 arch/arm64/mm/mmu.c                                                    |    2 
 arch/arm64/net/bpf_jit_comp.c                                          |   37 
 arch/arm64/tools/cpucaps                                               |    2 
 arch/loongarch/net/bpf_jit.c                                           |   60 +
 arch/loongarch/vdso/Makefile                                           |    1 
 arch/powerpc/kernel/vdso/Makefile                                      |    1 
 arch/powerpc/net/bpf_jit_comp.c                                        |   45 -
 arch/powerpc/perf/imc-pmu.c                                            |   23 
 arch/riscv/kernel/vdso/Makefile                                        |    1 
 arch/riscv/net/bpf_jit_comp64.c                                        |   56 +
 arch/s390/kernel/vdso/Makefile                                         |    1 
 arch/s390/net/bpf_jit_comp.c                                           |   46 -
 arch/x86/crypto/aesni-intel_glue.c                                     |    2 
 arch/x86/entry/vdso/vdso64/Makefile                                    |    2 
 arch/x86/kernel/sys_x86_64.c                                           |   15 
 arch/x86/kvm/mmu/mmu.c                                                 |    6 
 arch/x86/kvm/svm/nested.c                                              |    7 
 arch/x86/kvm/svm/sev.c                                                 |   46 -
 arch/x86/kvm/svm/svm.c                                                 |   38 -
 arch/x86/kvm/svm/svm.h                                                 |    1 
 arch/x86/kvm/vmx/nested.c                                              |   21 
 arch/x86/kvm/x86.c                                                     |    4 
 arch/x86/mm/pgtable.c                                                  |   38 -
 arch/x86/net/bpf_jit_comp.c                                            |   26 
 block/blk-cgroup.c                                                     |    5 
 block/blk-mq.c                                                         |   59 -
 block/fops.c                                                           |    5 
 block/mq-deadline.c                                                    |    2 
 drivers/android/binder.c                                               |    3 
 drivers/android/binder/thread.rs                                       |    8 
 drivers/android/binderfs.c                                             |    3 
 drivers/block/drbd/drbd_nl_gen.c                                       |    4 
 drivers/block/virtio_blk.c                                             |    1 
 drivers/bluetooth/btintel.c                                            |   15 
 drivers/bluetooth/btintel_pcie.c                                       |   12 
 drivers/bluetooth/btusb.c                                              |    2 
 drivers/char/tpm/tpm2-cmd.c                                            |    2 
 drivers/char/tpm/tpm2-sessions.c                                       |    1 
 drivers/clk/spacemit/ccu-k3.c                                          |   92 ++
 drivers/edac/altera_edac.c                                             |   67 -
 drivers/edac/versalnet_edac.c                                          |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c                                |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c                          |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                |    8 
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c                                  |    9 
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c                                 |    2 
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c                                 |    2 
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c                                 |    4 
 drivers/gpu/drm/amd/amdgpu/vi.c                                        |   21 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                      |  101 ++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c            |    6 
 drivers/gpu/drm/amd/display/dc/dc.h                                    |    1 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c |    4 
 drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c         |   13 
 drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c         |    2 
 drivers/gpu/drm/amd/display/modules/power/power.c                      |    2 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                             |   39 -
 drivers/gpu/drm/i915/display/intel_display_params.c                    |    4 
 drivers/gpu/drm/i915/display/intel_display_params.h                    |    1 
 drivers/gpu/drm/i915/display/intel_vrr.c                               |    4 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                                 |   17 
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c                             |    4 
 drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h                            |    2 
 drivers/gpu/drm/radeon/radeon_bios.c                                   |    6 
 drivers/gpu/drm/xe/xe_i2c.c                                            |   49 +
 drivers/gpu/drm/xe/xe_i2c.h                                            |    1 
 drivers/gpu/drm/xe/xe_pci_sriov.c                                      |   30 
 drivers/hid/bpf/hid_bpf_dispatch.c                                     |    2 
 drivers/hid/hid-multitouch.c                                           |    2 
 drivers/i2c/busses/i2c-at91-master.c                                   |    8 
 drivers/i2c/busses/i2c-xiic.c                                          |   61 +
 drivers/iio/accel/kionix-kx022a.c                                      |   30 
 drivers/iio/accel/kxcjk-1013.c                                         |    2 
 drivers/iio/accel/sca3000.c                                            |    2 
 drivers/iio/adc/ad4030.c                                               |   11 
 drivers/iio/adc/ad7173.c                                               |    4 
 drivers/iio/adc/ad_sigma_delta.c                                       |   31 
 drivers/iio/adc/ade9000.c                                              |   36 
 drivers/iio/adc/adi-axi-adc.c                                          |    4 
 drivers/iio/adc/aspeed_adc.c                                           |    4 
 drivers/iio/adc/axp288_adc.c                                           |    8 
 drivers/iio/adc/max1363.c                                              |    8 
 drivers/iio/adc/pac1934.c                                              |    4 
 drivers/iio/adc/rohm-bd79124.c                                         |   20 
 drivers/iio/adc/stm32-adc.c                                            |   43 -
 drivers/iio/adc/sun4i-gpadc-iio.c                                      |   10 
 drivers/iio/adc/xilinx-xadc-core.c                                     |    9 
 drivers/iio/buffer/industrialio-buffer-dmaengine.c                     |   16 
 drivers/iio/cdc/ad7150.c                                               |    8 
 drivers/iio/dac/rohm-bd79703.c                                         |    3 
 drivers/iio/frequency/adf4377.c                                        |    4 
 drivers/iio/frequency/admv1013.c                                       |    9 
 drivers/iio/gyro/adis16136.c                                           |    2 
 drivers/iio/health/max30102.c                                          |   12 
 drivers/iio/imu/adis16400.c                                            |    2 
 drivers/iio/imu/adis16480.c                                            |    4 
 drivers/iio/industrialio-buffer.c                                      |    7 
 drivers/iio/industrialio-trigger.c                                     |    2 
 drivers/iio/light/gp2ap020a00f.c                                       |    2 
 drivers/iio/light/rohm-bu27034.c                                       |   62 -
 drivers/iio/pressure/bmp280-core.c                                     |    2 
 drivers/iio/pressure/rohm-bm1390.c                                     |    2 
 drivers/iio/proximity/aw96103.c                                        |   30 
 drivers/iio/proximity/isl29501.c                                       |    2 
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c                      |    4 
 drivers/iio/proximity/sx9324.c                                         |    2 
 drivers/iio/proximity/vcnl3020.c                                       |   24 
 drivers/iio/proximity/vl53l0x-i2c.c                                    |    3 
 drivers/input/keyboard/atkbd.c                                         |    8 
 drivers/input/mouse/synaptics.c                                        |    7 
 drivers/input/serio/i8042-acpipnpio.h                                  |    9 
 drivers/input/touchscreen/s6sy761.c                                    |   14 
 drivers/md/dm-pcache/cache_gc.c                                        |    5 
 drivers/md/dm-pcache/cache_key.c                                       |   14 
 drivers/md/dm-pcache/cache_writeback.c                                 |    5 
 drivers/mtd/devices/block2mtd.c                                        |    2 
 drivers/mtd/devices/mtd_intel_dg.c                                     |    3 
 drivers/mtd/mtdcore.c                                                  |    3 
 drivers/mtd/nand/ecc.c                                                 |    7 
 drivers/mtd/nand/raw/cadence-nand-controller.c                         |    6 
 drivers/mtd/nand/raw/vf610_nfc.c                                       |   85 +-
 drivers/mtd/nand/spi/core.c                                            |   53 -
 drivers/mtd/spi-nor/core.c                                             |    2 
 drivers/net/ethernet/broadcom/bcmsysport.c                             |    8 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                         |   34 
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                         |    2 
 drivers/net/ethernet/google/gve/gve_tx_dqo.c                           |   14 
 drivers/net/ethernet/marvell/mvneta.c                                  |    2 
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c                        |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c                     |   11 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c               |   18 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h               |    9 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                            |   38 -
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c                       |    3 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                      |   10 
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c                    |    1 
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h                    |    1 
 drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c                  |    1 
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c                     |    3 
 drivers/net/ethernet/microchip/vcap/vcap_api.c                         |    2 
 drivers/net/ethernet/realtek/r8169_main.c                              |    6 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                      |   83 +-
 drivers/net/pcs/pcs-rzn1-miic.c                                        |    3 
 drivers/net/pfcp.c                                                     |    3 
 drivers/net/phy/aquantia/aquantia_main.c                               |    5 
 drivers/net/phy/qcom/at803x.c                                          |    8 
 drivers/net/usb/qmi_wwan.c                                             |    1 
 drivers/net/wireless/ath/ath11k/mac.c                                  |    1 
 drivers/net/wireless/ath/ath9k/hif_usb.c                               |   19 
 drivers/net/wireless/ath/ath9k/htc.h                                   |    1 
 drivers/net/wireless/ath/ath9k/htc_drv_init.c                          |    7 
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c                          |    8 
 drivers/net/wireless/ath/ath9k/wmi.c                                   |   28 
 drivers/net/wireless/ath/ath9k/wmi.h                                   |    1 
 drivers/net/wireless/intel/iwlegacy/3945-mac.c                         |    1 
 drivers/net/wireless/silabs/wfx/hif_tx.c                               |    4 
 drivers/net/wireless/st/cw1200/bh.c                                    |    8 
 drivers/net/wireless/st/cw1200/txrx.c                                  |   14 
 drivers/net/wireless/ti/wlcore/main.c                                  |    4 
 drivers/net/xen-netfront.c                                             |   12 
 drivers/nvme/host/core.c                                               |   74 +
 drivers/nvme/host/multipath.c                                          |   43 -
 drivers/nvme/host/nvme.h                                               |   10 
 drivers/nvme/host/pci.c                                                |    2 
 drivers/nvme/target/configfs.c                                         |    9 
 drivers/nvme/target/core.c                                             |    5 
 drivers/nvme/target/fabrics-cmd-auth.c                                 |    2 
 drivers/nvme/target/pci-epf.c                                          |    3 
 drivers/of/base.c                                                      |   10 
 drivers/of/irq.c                                                       |    2 
 drivers/of/overlay.c                                                   |   17 
 drivers/pci/pci.c                                                      |   15 
 drivers/rtc/dev.c                                                      |    2 
 drivers/rtc/rtc-ac100.c                                                |   39 -
 drivers/rtc/rtc-mpfs.c                                                 |    6 
 drivers/rtc/rtc-spear.c                                                |   11 
 drivers/spi/spi-cs42l43.c                                              |   97 ++
 drivers/staging/greybus/uart.c                                         |    3 
 drivers/thunderbolt/ctl.c                                              |   63 -
 drivers/thunderbolt/quirks.c                                           |    3 
 drivers/thunderbolt/switch.c                                           |    9 
 drivers/thunderbolt/tb.c                                               |   37 
 drivers/thunderbolt/test.c                                             |   58 +
 drivers/thunderbolt/tunnel.c                                           |   73 +
 drivers/thunderbolt/tunnel.h                                           |    8 
 drivers/thunderbolt/xdomain.c                                          |    4 
 drivers/tty/amiserial.c                                                |    9 
 drivers/tty/n_gsm.c                                                    |   47 -
 drivers/tty/serial/8250/8250_bcm7271.c                                 |    2 
 drivers/tty/serial/8250/8250_omap.c                                    |   15 
 drivers/tty/serial/kgdboc.c                                            |    9 
 drivers/tty/serial/ma35d1_serial.c                                     |    6 
 drivers/tty/serial/max3100.c                                           |   13 
 drivers/tty/serial/qcom_geni_serial.c                                  |    5 
 drivers/tty/serial/sc16is7xx.c                                         |   53 +
 drivers/tty/serial/serial-tegra.c                                      |   18 
 drivers/tty/serial/serial_core.c                                       |   32 
 drivers/tty/serial/vt8500_serial.c                                     |    1 
 drivers/tty/tty_io.c                                                   |   54 -
 drivers/tty/tty_port.c                                                 |   91 +-
 drivers/tty/vcc.c                                                      |    5 
 drivers/tty/vt/selection.c                                             |    4 
 drivers/tty/vt/vc_screen.c                                             |   23 
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
 drivers/usb/dwc3/gadget.c                                              |  108 ++
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
 drivers/usb/host/ohci-spear.c                                          |    1 
 drivers/usb/host/ohci-st.c                                             |    1 
 drivers/usb/serial/bus.c                                               |    6 
 drivers/usb/serial/cp210x.c                                            |    1 
 drivers/usb/serial/generic.c                                           |   10 
 drivers/usb/serial/option.c                                            |   14 
 drivers/usb/serial/quatech2.c                                          |   19 
 drivers/usb/serial/ssu100.c                                            |   18 
 drivers/usb/serial/usb-serial.c                                        |  127 ++-
 drivers/usb/serial/xr_serial.c                                         |   10 
 drivers/usb/storage/sierra_ms.c                                        |    7 
 drivers/usb/typec/anx7411.c                                            |    5 
 drivers/usb/typec/port-mapper.c                                        |   21 
 drivers/usb/typec/tcpm/tcpm.c                                          |    2 
 drivers/usb/typec/tipd/core.c                                          |   11 
 drivers/usb/typec/ucsi/displayport.c                                   |    9 
 drivers/usb/typec/ucsi/ucsi.c                                          |   17 
 drivers/usb/typec/ucsi/ucsi_acpi.c                                     |   34 
 drivers/usb/typec/ucsi/ucsi_glink.c                                    |   15 
 drivers/virt/nitro_enclaves/ne_misc_dev.c                              |    1 
 drivers/virt/vmgenid.c                                                 |    9 
 fs/exec.c                                                              |    1 
 fs/ext4/inode.c                                                        |    3 
 fs/netfs/buffered_read.c                                               |    7 
 fs/netfs/buffered_write.c                                              |    9 
 fs/netfs/direct_write.c                                                |    9 
 fs/netfs/internal.h                                                    |    2 
 fs/netfs/misc.c                                                        |   99 ++
 fs/netfs/read_collect.c                                                |   24 
 fs/smb/client/cifsfs.c                                                 |   41 -
 fs/smb/client/cifsglob.h                                               |   10 
 fs/smb/client/inode.c                                                  |    2 
 fs/smb/client/smb2ops.c                                                |  114 ++-
 fs/smb/client/smb2pdu.c                                                |   10 
 include/linux/bpf.h                                                    |   45 +
 include/linux/hrtimer_rearm.h                                          |    2 
 include/linux/mtd/nand.h                                               |    2 
 include/linux/netfilter_netdev.h                                       |    2 
 include/linux/netfs.h                                                  |    2 
 include/linux/perf_event.h                                             |    7 
 include/linux/rtnetlink.h                                              |    7 
 include/linux/sched.h                                                  |   14 
 include/linux/skbuff.h                                                 |    2 
 include/linux/soc/qcom/geni-se.h                                       |   15 
 include/linux/tty.h                                                    |    1 
 include/linux/tty_driver.h                                             |    6 
 include/linux/tty_port.h                                               |   22 
 include/linux/usb/serial.h                                             |    1 
 include/net/bluetooth/hci_core.h                                       |    5 
 include/net/gso.h                                                      |    8 
 include/net/netfilter/nf_flow_table.h                                  |    2 
 include/net/sch_generic.h                                              |    9 
 include/net/xdp.h                                                      |    5 
 include/sound/core.h                                                   |    9 
 include/uapi/linux/random.h                                            |    2 
 init/Kconfig                                                           |    5 
 io_uring/cmd_net.c                                                     |   19 
 io_uring/io_uring.c                                                    |    4 
 io_uring/tw.c                                                          |    3 
 io_uring/zcrx.c                                                        |    9 
 kernel/audit_tree.c                                                    |   24 
 kernel/bpf/core.c                                                      |   10 
 kernel/bpf/hashtab.c                                                   |   19 
 kernel/bpf/memalloc.c                                                  |   57 +
 kernel/bpf/syscall.c                                                   |   19 
 kernel/bpf/trampoline.c                                                |   85 +-
 kernel/events/core.c                                                   |  317 +++-----
 kernel/events/ring_buffer.c                                            |    7 
 kernel/exit.c                                                          |   33 
 kernel/fork.c                                                          |    2 
 kernel/futex/core.c                                                    |   10 
 kernel/kprobes.c                                                       |    8 
 kernel/module/main.c                                                   |    8 
 kernel/sched/ext/cid.c                                                 |  132 ++-
 kernel/sched/ext/cid.h                                                 |    2 
 kernel/sched/ext/ext.c                                                 |   77 +-
 kernel/sched/ext/types.h                                               |    4 
 kernel/sched/fair.c                                                    |  372 +++++++---
 kernel/sysctl.c                                                        |    2 
 kernel/time/jiffies.c                                                  |    2 
 kernel/trace/fprobe.c                                                  |   26 
 mm/damon/core.c                                                        |    2 
 mm/kasan/common.c                                                      |   13 
 mm/shmem.c                                                             |    7 
 mm/slab.h                                                              |   18 
 mm/slab_common.c                                                       |    2 
 mm/slub.c                                                              |   37 
 mm/vma.c                                                               |    4 
 net/bluetooth/hci_conn.c                                               |   18 
 net/bluetooth/hci_core.c                                               |   54 +
 net/bluetooth/hci_debugfs.c                                            |    2 
 net/bluetooth/hci_sync.c                                               |   19 
 net/bluetooth/rfcomm/tty.c                                             |    7 
 net/bluetooth/smp.c                                                    |    2 
 net/core/dev.c                                                         |   80 +-
 net/core/dev_ioctl.c                                                   |    3 
 net/core/gso.c                                                         |    1 
 net/core/page_pool.c                                                   |    2 
 net/core/skbuff.c                                                      |    8 
 net/core/sock.c                                                        |    4 
 net/ethtool/tsconfig.c                                                 |   24 
 net/ipv4/af_inet.c                                                     |    5 
 net/ipv4/tcp_input.c                                                   |    6 
 net/ipv4/tcp_ipv4.c                                                    |    2 
 net/ipv6/addrconf.c                                                    |    2 
 net/ipv6/ip6_offload.c                                                 |    4 
 net/ipv6/seg6_iptunnel.c                                               |    2 
 net/ipv6/seg6_local.c                                                  |  140 +++
 net/mac80211/agg-rx.c                                                  |    2 
 net/mac80211/chan.c                                                    |   50 +
 net/mac80211/drop.h                                                    |    1 
 net/mac80211/fils_aead.c                                               |    8 
 net/mac80211/ieee80211_i.h                                             |    2 
 net/mac80211/iface.c                                                   |    4 
 net/mac80211/mesh_pathtbl.c                                            |   30 
 net/mac80211/mlme.c                                                    |    4 
 net/mac80211/rc80211_minstrel_ht.c                                     |   89 ++
 net/mac80211/rx.c                                                      |    6 
 net/mac80211/spectmgmt.c                                               |    4 
 net/mac80211/sta_info.c                                                |    6 
 net/mac80211/status.c                                                  |   70 +
 net/mac80211/tx.c                                                      |   45 -
 net/mctp/device.c                                                      |    6 
 net/mptcp/protocol.c                                                   |    2 
 net/netfilter/ipset/ip_set_bitmap_gen.h                                |    2 
 net/netfilter/ipvs/ip_vs_conn.c                                        |    3 
 net/netfilter/ipvs/ip_vs_lblc.c                                        |    4 
 net/netfilter/ipvs/ip_vs_lblcr.c                                       |    3 
 net/netfilter/ipvs/ip_vs_sync.c                                        |   33 
 net/netfilter/nf_flow_table_core.c                                     |    7 
 net/netfilter/nf_flow_table_offload.c                                  |   14 
 net/netfilter/nf_nat_bpf.c                                             |    3 
 net/netfilter/nf_nat_core.c                                            |    5 
 net/netfilter/nft_flow_offload.c                                       |    7 
 net/packet/af_packet.c                                                 |    3 
 net/sched/act_ct.c                                                     |    2 
 net/sched/act_skbedit.c                                                |    5 
 net/sched/cls_api.c                                                    |   15 
 net/sched/sch_codel.c                                                  |    2 
 net/sched/sch_fq_codel.c                                               |    4 
 net/sctp/socket.c                                                      |    2 
 net/tipc/crypto.c                                                      |   20 
 net/wireless/nl80211.c                                                 |   11 
 net/wireless/scan.c                                                    |   22 
 rust/kernel/irq/request.rs                                             |   89 +-
 sound/core/seq/seq_compat.c                                            |    4 
 sound/hda/codecs/realtek/alc269.c                                      |    6 
 sound/hda/controllers/tegra.c                                          |    3 
 sound/pci/ctxfi/cthw20k2.c                                             |    2 
 sound/pci/ice1712/ice1712.c                                            |    2 
 sound/soc/codecs/lpass-wsa-macro.c                                     |    3 
 sound/soc/codecs/max98363.c                                            |    2 
 sound/soc/codecs/rt1017-sdca-sdw.c                                     |   27 
 sound/soc/codecs/rt274.c                                               |    4 
 sound/soc/codecs/rt286.c                                               |    2 
 sound/soc/codecs/wm8903.c                                              |    2 
 sound/soc/qcom/lpass-cpu.c                                             |    4 
 sound/soc/sdca/sdca_class_function.c                                   |   19 
 sound/soc/sdw_utils/soc_sdw_utils.c                                    |   20 
 sound/soc/tegra/tegra186_asrc.c                                        |    2 
 sound/usb/caiaq/device.c                                               |    3 
 sound/usb/line6/playback.c                                             |    7 
 sound/usb/misc/ua101.c                                                 |    9 
 sound/usb/quirks.c                                                     |   29 
 tools/sched_ext/include/scx/common.bpf.h                               |    4 
 tools/testing/selftests/cgroup/test_zswap.c                            |   28 
 412 files changed, 5045 insertions(+), 2009 deletions(-)

Aamir Ahmed (3):
      rtc: ac100: Assign .num before accessing .hws
      wifi: wfx: validate MIB read length before copying to caller
      rtc: ac100: Fix clock provider use-after-free on probe failure

Aaron Kling (1):
      ALSA: hda/tegra: Re-enable SDO workaround for Tegra194

Abdurrahman Hussain (6):
      of/overlay: put property on deadprops only after changeset add succeeds
      of/overlay: only treat a positive changeset id as registered
      of/overlay: don't leak fragment references when changeset init fails
      of/overlay: don't create "//" paths for fragments targeting the root
      i2c: xiic: preserve PEC byte length in SMBus block read setup
      i2c: xiic: don't clobber msg->len to signal block-read completion

Alan Stern (1):
      USB: gadget: dummy-hcd: Fix wait for outstanding request completions

Alberto Garcia (1):
      ext4: don't enable large folios on encrypted inodes

Aldo Ariel Panzardo (1):
      HID: multitouch: stop the release timer from being rearmed on remove

Alex Deucher (3):
      drm/amdgpu/gmc12.1: properly pass flush_type to gmc_v12_1_flush_vm_hub()
      drm/amdgpu/gmc12: properly pass flush_type to gmc_v12_0_flush_vm_hub()
      drm/amdgpu: drop userq callback assignment for sdma 7.1

Alexei Starovoitov (3):
      bpf: Fix overflow of jump offset in constant blinding
      bpf: Factor out __do_call_rcu_ttrace()
      bpf: Fix objects stuck in free_by_rcu_ttrace

Alice Ryhl (2):
      rust_binder: cancel deferred work items in thread exit
      rust: irq: pass RegistrationInner as cookie to request_irq

Alireza Asgari (1):
      net: fix checksum offsets in skb_splice_from_iter()

Amit Sunil Dhamne (1):
      usb: typec: tcpm: recover after failure to start the frs ams

Andre Eikmeyer (1):
      drm/amdgpu: reset VI ASIC on MacBookPro15,1

Andrea Mayer (1):
      seg6: ensure packet data is writable before modifying SRH and IPv6 DA

Andrea Parri (1):
      arm64: mm: Fix the break-before-make flush range for erratum 2645198

Andrey Ryabinin (1):
      kasan: unpoison task stack below watermark only in generic mode

Anirudh Virdi (1):
      net/mlx5: Fix slab-out-of-bounds when handling team device events

Antoniu Miclaus (3):
      iio: adc: ade9000: fix overlapping scan_index for current and voltage channels
      iio: adc: ade9000: handle Phase C dip events in IRQ1 handler
      iio: adc: ade9000: request interrupts after powering the device

Aohan Mei (1):
      netfilter: nft_flow_offload: drop flowtable reference on init error path

Arka Mondal (3):
      iio: gyro: adis16136: fix unprotected debugfs reads
      iio: imu: adis16400: fix unprotected debugfs reads
      iio: imu: adis16480: fix unprotected debugfs reads

Arnd Bergmann (2):
      drbd: remove unused drbd_nl_mcgrps[] array
      nvme: work around -Wformat-security warning

Arthur Heymans (1):
      drm/amd/display: Preserve eDP mode on initial ASSR failure

Baha Mesleh (1):
      octeontx2-af: mcs: Fix SC resource cleanup loop

Baolin Wang (1):
      mm: shmem: ignore sysfs configs for shmem forced collapse

Bartosz Golaszewski (1):
      net: phy: aquantia: fix system interface type not updated in forced mode

Bean Huo (1):
      nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for Micron 4100AT

Beata Michalska (2):
      arm64: errata: Factor out broken AMU const counter cap
      arm64: errata: Add Cortex-A725 erratum 3821522 workaround

Benjamin Tissoires (1):
      HID: bpf: cast size to ssize_t when checking hid_bpf_hw_request

Binbin Deng (1):
      net/mctp: publish the mctp_dev only after it is initialised

Bryam Vargas (2):
      dm-pcache: reject a kset that overruns its segment
      dm-pcache: bound the logical key offset from persistent memory

Carlo Szelinsky (1):
      USB: serial: option: add Quectel EG060W

Cen Zhang (Microsoft) (1):
      wifi: mac80211: fix slab-out-of-bounds read in ieee80211_monitor_select_queue()

Cezary Rojewski (2):
      ASoC: codecs: rt286: Revert delay value for jack setup
      ASoC: codecs: rt274: Fix format setting for 44100 rate

Chandrashekar Devegowda (3):
      Bluetooth: btintel: fix buffer over-read in btintel_hw_error()
      Bluetooth: btintel_pcie: fix plen overflow in btintel_pcie_recv_frame()
      Bluetooth: btintel_pcie: reject oversized TX packets in send_frame()

Chen Yu (1):
      sched/cache: Skip kernel threads for cache aware scheduling to rubustify the code

Chengfeng Ye (7):
      Bluetooth: RFCOMM: Fix initial port reference race
      Bluetooth: Serialize SMP remote OOB data access
      Bluetooth: hci_sync: Fix inquiry cache use-after-free
      Bluetooth: hci_conn: Lock parent access during enhanced SCO setup
      Bluetooth: hci_core: Serialize ACL scheduling with channel deletion
      Bluetooth: hci_core: Serialize SCO and ISO scheduling with teardown
      Bluetooth: hci_core: Serialize fragmented ISO packet queueing

Chris Mason (1):
      futex: Fix private hash use-after-free on resize

Cong Nguyen (2):
      iio: adc: max1363: sign-extend bipolar differential channel reads
      iio: proximity: pulsedlight: fix iio_device left registered on PM setup failure

Daehyeon Ko (3):
      nvme-multipath: fix underflow in ANA log bounds checks
      nvmet: pci-epf: reject too-short SGL segments
      thunderbolt: Reject oversized XDomain properties responses

Daniel Starke (1):
      tty: n_gsm: fix missing modem controls after DLCI open in convergence layer type 2

Dapeng Mi (1):
      perf/core: Check kernel access when kernel callchains are requested

David Heidelberg (1):
      Input: s6sy761 - fix resume ordering and restore sensing

Dinh Nguyen (4):
      EDAC/altera: Do not allow driver unbinding
      EDAC/altera: Drop __init from ECC setup paths for re-probe safety
      EDAC/altera: Fix memory leak on dci allocation failure
      EDAC/altera: Fix use-after-free in error paths

Donggeun Yoo (1):
      iio: proximity: vl53l0x-i2c: claim direct mode for raw reads

Eric Dumazet (3):
      net: restrict SO_RESERVE_MEM to TCP sockets and cap max value
      ipv6: sr: use skb_get_hash_net() in seg6_make_flowlabel()
      ipv4: free inet_opt and ireq_opt after an RCU grace period

Fabrice Gasnier (2):
      iio: adc: stm32-adc: fix check on internal channel availability
      iio: adc: stm32-adc: fix possible division by zero in processed channel

Fan Wu (9):
      usb: gadget: aspeed-vhub: cancel wake work on device removal
      usb: typec: ucsi: glink: fix use-after-free of ucsi on remove
      usb: cdns3: fix use-after-free in cdns3_gadget_exit()
      tty: serial: max3100: shut down timer before freeing port
      serial: 8250_bcm7271: fix use-after-free in brcmuart_remove()
      iio: adc: ad_sigma_delta: fix use-after-free on unbind
      iio: adc: xilinx-xadc: free IRQ before cancelling the unmask worker on unbind
      iio: light: gp2ap020a00f: drain irq_work after free_irq
      iio: trigger: cancel reenable_work before freeing trigger

Fedor Pchelkin (1):
      thunderbolt: Fix NULL dereference in tb_remove_work()

Felix Fietkau (2):
      wifi: mac80211: prevent AP VLAN tx from other interfaces
      wifi: mac80211: set info->band for 802.3 encap offload frames

Felix Gu (2):
      iio: adc: sun4i-gpadc-iio: clean up on thermal zone registration failure
      iio: adc: sun4i-gpadc-iio: drop underflowing pm_runtime_put() calls

Fernando Fernandez Mancera (1):
      netfilter: bpf: reject invalid NAT manipulation types

Florent Revest (Anthropic) (2):
      bpf: Wait for an RCU tasks grace period before freeing trampoline progs
      bpf: Skip detached progs in trampoline images that are still in use

Florian Fainelli (2):
      net: systemport: Fix buffer overflow in bcm_sysport_get_stats()
      net: systemport: Fix RUNT MIB counter register offset calculation

Florian Westphal (1):
      netfilter: ipset: do not update comments from kernel-side adds

Francisco Beltrán Millalén (1):
      drm/amdgpu: reset VI ASIC on MacBookPro14,3

Frank Sorenson (1):
      smb: client: split cifsFileInfo bitfields to avoid shared-byte RMW races

Fuad Tabba (2):
      KVM: arm64: Clear HCR_EL2.RW for 32-bit non-protected vCPUs
      KVM: arm64: Apply the fine-grained UNDEFs without FEAT_FGT

Geert Uytterhoeven (1):
      iio: frequency: adf4377: Fully initialize clk_init_data and clk_parent_data

Geetha sowjanya (1):
      octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB is enabled

Georgios Karantzas (1):
      wifi: ath9k_htc: bound TX aggregation to MAX_TX_BUF_SIZE

Gilberto Conde (1):
      net: usb: qmi_wwan: add Quectel EG120K-EA

Greg Kroah-Hartman (1):
      Linux 7.2.10

Guangshuo Li (5):
      drm/mediatek: Fix ovl adaptor platform device leak
      drm/amdgpu: fix IP instance memory leak on kobject add failure
      drm/amdgpu: fix ACP MFD device leak on init failure
      EDAC/versalnet: Drop remote processor handle refcount on driver removal
      wifi: iwlegacy: 3945: free EEPROM data on remove

Guixin Liu (2):
      nvme-multipath: set BLK_FEAT_ZONED only after the zone info is known
      nvmet: copy the hostid into the ctrl before creating PR pc_refs

Han Xu (1):
      mtd: spinand: Enable QE on all dies

Hannu Varjoranta (1):
      gve: DQO: accept TSO packets with non-protocol gso_type bits

Hao Ge (1):
      module: fix lost error code from codetag_load_module()

Hao Zhang (1):
      blk-cgroup: save IRQ state in blkg_tryget_closest()

Haojie Li (1):
      drm/mediatek: Add missing IS_ERR check for ovl_adaptor platform device

Hari Mishal (1):
      drm/amd/display: guard dc_sink dereferences in MST mode validation

Harin Lee (1):
      ALSA: ctxfi: Fix silent playback on Titanium HD (SB1270)

Harry Yoo (Meta) (1):
      mm/slab: do not wake up kswapd in __kfree_rcu_sheaf()

Harry Yoo (Oracle) (1):
      mm/slab: handle the !allow_spin case in kfree_rcu_sheaf()

Harshit Mogalapalli (1):
      net: microchip: vcap: stop scanning after deleting key field

Heikki Krogerus (1):
      drm/xe/i2c: Keep the i2c controller always enabled

Hongjian Dai (1):
      i2c: at91: release DMA channels when probe defers

Hui Peng (2):
      vt: selection: Fix unsigned underflow and slab-out-of-bounds read in paste_selection()
      usb: core: clear both ep_in and ep_out for non-ep0 control endpoints

Hui Su (1):
      iio: pressure: bmp280: fix out-of-bounds access in sampling frequency lookup

HyeongJun An (1):
      ASoC: wm8903: Move the DRC QR threshold to the register that holds it

Ian Lin (2):
      USB: serial: option: add Compal EXM-G1x support
      USB: serial: option: add Compal EXC-T1 support

Ian Rogers (1):
      perf: Replace perf_event_header__init_id with full header init

Ilkka Lappeteläinen (1):
      net/packet: prevent TX_RING byte count overflow

Imre Kaloz (1):
      drm/radeon: Read the VRAM VBIOS signature with readb()

Jakub Gawlik (1):
      ALSA: hda/realtek: Add micmute LED quirk for Acer Swift SFG16-72

Jamal Hadi Salim (4):
      net/sched: cls_api: reclaim an empty proto on the error path
      net/sched: fq_codel: match the no-drop threshold to the packet size
      net/sched: sch_codel: match the no-drop threshold to the packet size
      net: cap skb->queue_mapping when the tx queue is picked

Jameson Thies (1):
      usb: typec: ucsi: displayport: Current CAM OOB index fixup

Janani Sunil (1):
      iio: adc: adi-axi-adc: Initialize state mutex

Jari Seppälä (1):
      octeontx2-pf: Fix RSS indirection table size

Jeff Jo (1):
      tcp: refresh TS.Recent for accepted old ACKs

Jens Axboe (1):
      io_uring: fix task_work add use-after-free with SQPOLL

Jiale Yao (1):
      iio: accel: kxcjk-1013: reject duplicate event disable

Jiangshan Yi (4):
      drm/amd/display: check dc_state_create_copy() for NULL in dm_suspend
      ASoC: codecs: max98363: fix uninitialized stream_config->type
      ASoC: codecs: rt1017-sdca-sdw: fix uninitialized stream_config->type
      tpm: fix off-by-four bounds check in tpm2_get_random()

Jiazi Liu (1):
      usb: dwc3: gadget: fix IRQ storm on invalid event buffer count

Jie Deng (1):
      usb: cdns3: Fix NULL pointer dereference in cdns3_pci_probe

Jinseob Kim (1):
      iio: buffer: serialize buffer teardown with mode claims

Johan Hovold (14):
      USB: cdc-acm: fix racy TIOCMIWAIT implementation
      USB: serial: fix port tear down use-after-free
      tty: amiserial: fix broken TIOCMIWAIT
      tty: tty_port: restore TTY_IO_ERROR on activation failure
      tty: port: fix tty_port_tty_vhangup() race
      tty: abort break signalling on hangup
      tty: fix saved termios reset race
      serial: revert guards in uart_wait_modem_status()
      serial: fix TIOCMIWAIT race
      USB: serial: quatech2: fix baud rate overflow
      USB: serial: ssu100: fix baud rate overflow
      USB: serial: fix dynamic id driver deregistration race
      USB: serial: fix driver deregistration order
      USB: serial: fix ioctl hangup race

John Garry (2):
      nvme: add nvme_get_ns_head()
      nvme: fix cdev lifetime

Jonathan Cameron (1):
      iio: buffer: Ensure bounce buffer used for unaligned case is zeroed.

Josef Bacik (1):
      xen/netfront: drop RX packets with a short Ethernet header

Joshua Hahn (1):
      selftests/cgroup: account for zswap shrinker writeback

Joshua Rogers (2):
      tty: vcc: zero-initialize control packet in vcc_send_ctl()
      tty: vcc: hold port lock when clearing tty pointer in vcc_cleanup

Julian Anastasov (3):
      ipvs: fix missing counter decrement in lblc
      ipvs: do not create invisible templates
      ipvs: filter some flags received in the backup server

Julian Sun (1):
      nvmet: preserve device path on allocation failure

Julien Stephan (1):
      drm/mediatek: mtk_hdmi_v2: fix VID_DOWNSAMPLE_CONFIG register offset

Jun Yang (1):
      sctp: check RCV_SHUTDOWN after the sendmsg connect wait

Junyuan Feng (1):
      io_uring/zcrx: requeue multishot receives stopped by a local resource

Jérémy Carrat (1):
      USB: serial: cp210x: add Corsair AX1500i Power Supply

Jérémy Jean (2):
      audit: fix exe mark UAF in kill_rules()
      tipc: prevent GCM nonce reuse on peer key changes

Kailang Yang (1):
      ALSA: hda/realtek - Add headset mode for Dell Pro QC1255

Karl Mehltretter (4):
      mtd: core: avoid double-free of OTP NVMEM device
      mtd: core: call _get_device() with the master MTD
      random: fix vgetrandom_opaque_params kernel-doc
      hrtimer: Use the mask to clear TIF_HRTIMER_REARM from the exit work

Keith Busch (1):
      blk-mq: set RQF_USE_SCHED when the operation is known

Kendall Willis (1):
      serial: 8250_omap: fix wake irq cleared during suspend

Kumar Kartikeya Dwivedi (1):
      bpf: Hold map BTF for the memory allocator destructor record

Kurt Lieber (1):
      thunderbolt: Disable CL states for the Anker Prime TB5 dock

Kyle Zeng (1):
      ALSA: seq: Serialize compat port-info ioctls

Laurent Wandrebeck (1):
      x86/mm: Don't apply va_align to hugetlb mappings on AMD F15h

Laxman Acharya Padhya (1):
      iio: proximity: aw96103: validate firmware data length

Leon Hwang (1):
      kprobes: Skip disarmed probes when checking optkprobe overlap

Linkai Gong (1):
      usb: typec: anx7411 - stop the IRQ before destroying the workqueue

Linmao Li (2):
      Bluetooth: hci_core: Fix inquiry cache timestamps on 64-bit systems
      iio: adc: ade9000: fix NULL pointer dereference in clkout registration

Liu Chao (1):
      usb: gadget: f_uac1_legacy: validate bRequest index in generic_{set,get}_cmd

Liu Dalin (1):
      rtc: dev: zero-initialize struct rtc_wkalrm to prevent information leak

Liviu Nicoara (1):
      ASoC: codecs: lpass-wsa-macro: rewrite the interpolator volume after enabling clocks

Lorenzo Bianconi (2):
      net: stmmac: fix rx Scatter-Gather support
      net: mvneta: clear XDP pfmemalloc flag between frames

Lorenzo Stoakes (ARM) (1):
      mm/vma: predicate setting mmap_prepare VMA fields on new vma alloc

Lovekesh Solanki (3):
      Input: i8042 - add nomux quirk for Fujitsu LIFEBOOK U7410
      Input: synaptics - add LEN205b entry to smbus_pnp_ids for ThinkPad T490
      usb: hub: use shorter 120ms post resume hold for SS root hubs

Lu Wang (1):
      sched/cache: Honor migrate_llc_task semantics in active load balance, to fix LLC mis-scheduling bug

Luo Gengkun (1):
      perf: Fix race between perf_event_exit_task() and perf_pending_task()

Maciej Strozek (2):
      ASoC: SDCA: Set suspended flag after resuming within system suspend
      ASoC: SDCA: Add better pm_runtime error handling in func probe

Manush Prajwal (1):
      rtc: mpfs: fix unchecked devm_clk_get() error pointer in probe()

Marc Zyngier (3):
      KVM: arm64: vgic: Allow last_lr_irq to be NULL when LRs are not overflowing
      KVM: arm64: vgic: Take a refcount on IRQs referenced by last_lr_irq
      KVM: arm64: vgic-its: Fix MOVALL handling of source redistributor

Marcelo Schmitt (1):
      iio: adc: ad7173: Fix digital filter configuration

Marcin Bernatowicz (1):
      drm/xe/pf: Keep VF LMEM BAR size low if no VFs enabled

Marco Chen (1):
      iio: health: max30102: fix NULL dereference in interrupt handler

Marek Maslanka (1):
      usb: typec: port-mapper: Only match USB4 port if host interface is available

Marian Rotariu (1):
      usb: typec: tipd: don't send GAID when probe fails in APP mode

Mark Rutland (1):
      arm64/fpsimd: signal: Forbid non-streaming SVE payload on SME-only systems

Martino Papero (1):
      Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3 15IWC11

Masami Hiramatsu (Google) (1):
      fprobe: Use guard(rcu_sched_notrace) and check rcu_is_watching()

Matthieu Baerts (NGI0) (1):
      mptcp: fix msk->timer_ival reset

Matti Vaittinen (10):
      iio: dac: rohm-bd79703: Do not allow writing SCALE
      iio: light: rohm-bu27034: Fix error return
      iio: accel: kionix-kx022a: Fix array boundary check
      iio: accel: kionix-kx022a: Prevent memory leak and fix state
      iio: adc: rohm-bd79124: Catch regmap errors at measurement start/stop
      iio: adc: rohm-bd79124: Fix channel initialization
      iio: adc: rohm-bd79124: Fix GPIO mask check
      iio: adc: rohm-bd79124: Fix rising alarm
      iio: light: rohm-bu27034: Fix infinite delay on error
      iio: pressure: rohm-bm1390: Return error when read fails

Mehmet Fide (2):
      mtd: rawnand: vf610_nfc: fix reads on chips with more than 64 bytes of OOB
      mtd: rawnand: vf610_nfc: fix false bitflips on reads of erased pages

Menachem Adin (1):
      mtd: mtd_intel_dg: reset poll counter for each erase

Michael Hennerich (1):
      iio: buffer-dmaengine: fix sg entry iteration when building dma_vecs

Michal Wajdeczko (1):
      drm/xe/pf: Refactor VF LMEM BAR resize helper function

Mika Westerberg (1):
      thunderbolt: Fix KASAN reported use-after-free when request is canceled

Mikhail Gavrilov (1):
      x86/mm: Drop unnecessary PMD page copy when freeing

Mina Almasry (1):
      net: page_pool: fix use-after-free in page_pool_recycle_ring_bulk()

Mingyu Wang (1):
      tty: vt: fix memory leak in vc_allocate()

Mitul Golani (1):
      drm/i915/vrr: Disable DC balance by default

Mohamad Raizudeen (1):
      crypto: x86/aes-gcm - fix always true check for last AAD segment

Mostafa Saleh (1):
      KVM: arm64: Use stage-1 leaf size for VM_PFNMAP

Myeonghun Pak (5):
      usb: ohci-da8xx: disable controller wakeup on cleanup
      usb: ohci-s3c2410: disable controller wakeup on removal
      usb: ohci-spear: disable controller wakeup on removal
      usb: ohci-st: disable controller wakeup on removal
      usb: chipidea: tegra: disable runtime PM on resume failure

Nathan Chancellor (1):
      random: vDSO: avoid call to memset() when zeroing reserved parameter

Nguyen Ngoc Thang (2):
      ALSA: caiaq: unregister the input device when probe fails
      Bluetooth: hci_sync: don't drain cmd_sync backlog on unregister

Nicolai Buchwitz (3):
      net: bcmgenet: allocate RX buffers as page fragments
      net: ethtool: let tsconfig reach a PHY-only timestamp provider
      net: bcmgenet: fix NULL dereference in set_coalesce before first open

Nicolas Escande (1):
      wifi: ath11k: reset ar->num_stations on hardware start

Niklas Cassel (1):
      virtio_blk: set the zone write granularity

Nikola Prica (1):
      PCI: Accept AtomicOps already enabled by the hypervisor

Nuno Sá (2):
      mtd: spinand: fix NULL pointer dereference with no ECC engine
      mtd: spinand: fix zero oobavail when no ECC engine is used

Oleg Keri (1):
      arm64: topology: fix arch_freq_get_on_cpu() overflow above 4.19 GHz

Oleksij Rempel (1):
      r8169: disable EEE on RTL8168h/8111h

Orgad Shaneh (1):
      usb: octeon-hcd: fix the FIFO-flush timeout computation

Pablo Neira Ayuso (1):
      netfilter: flowtable: generalize pending status bit

Pannarat Wiriyaarritham (1):
      usb: typec: ucsi: acpi: Assume UCSI 1.2 on Acer Nitro ANV15-41

Paul Mbewe (2):
      serial: sc16is7xx: fix TX gap caused by kfifo circular buffer wrap-around
      serial: sc16is7xx: refill TX FIFO below trigger using fresh TXLVL

Paulo Alcantara (13):
      netfs: clear post-EOF pagecache when extending a file via write
      netfs: zero gaps in read-gaps folio to avoid writing back stale data
      netfs: zero the tail of a short DIO/unbuffered read
      smb: client: discard post-EOF pagecache when extending a file via zero range
      smb: client: discard post-EOF pagecache when extending a file via copy range
      smb: client: discard post-EOF pagecache when extending a file via clone range
      smb: client: flush and commit data before querying allocated ranges
      smb: client: only require read lease for size-extending zero range
      smb: client: flush dirty data before zeroing a range
      smb: client: distinguish real EOF from a stale remote_i_size on read
      smb: client: drain and invalidate before server-side copy/clone
      smb: client: require stable pages for signed connections
      smb: client: only require read lease for size-extending preallocate

Pei Xiao (1):
      mtd: block2mtd: Fix divide error when erase_size is zero

Peiyang He (1):
      binderfs: fix UAF write in binder_add_device

Pengpeng Hou (3):
      wifi: ath9k: reject short WMI command responses
      iio: adc: aspeed: propagate reset deassert errors
      iio: cdc: ad7150: fix OF matching and publish module aliases

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: implement workaround for sdma dcc corruption

Prashanth K (1):
      usb: typec: ucsi: Get the connector fwnode based on reg value

Prathamesh Deshpande (1):
      net/mlx5e: Fix AF_XDP TX timestamp teardown NULL dereference

Qishuai Liu (1):
      ipv6: fix prefix route expiry in modify_prefix_route()

Quentin Freimanis (2):
      net: sparx5: skip ptp deinit if init was skipped
      net: sparx5: make ports inherit the switch base mac address type

Radhey Shyam Pandey (3):
      usb: dwc3: am62: Fix runtime PM usage count leak on probe error path
      usb: typec: tipd: fix uninitialized typec_partner_desc in tps6598x_connect()
      usb: typec: tipd: fix uninitialized typec_partner_desc in cd321x_update_work()

Raphaël Larocque (1):
      Input: synaptics - limit T440p InterTouch quirk to LEN0036

Ray Wu (1):
      drm/amd/display: map PWM brightness through custom backlight curve

Richard Fitzgerald (2):
      ASoC: sdw_utils: Set snd_soc_dai_link_ch_map.codec_ch_mask for capture
      spi: cs42l43: Workaround for wrong speaker ID on Dell XPS 13 DX13260

Rounak Das (1):
      EDAC/altera: Fix device node reference leaks in the SDMMC ECC setup

Ruide Cao (1):
      wifi: mac80211: reject invalid 320 MHz CSA bandwidth

Runyu Xiao (5):
      rtc: spear: initialize IRQ state before requesting alarm IRQ
      USB: dwc2: shut down wakeup timer before freeing HCD state
      mtd: rawnand: cadence: Initialize IRQ state before requesting IRQ
      mtd: spi-nor: core: Fix mutex leak in spi_nor_rww_start_exclusive()
      iio: admv1013: initialize callback mutex before registering notifier

Ruslan Valiyev (1):
      serial: core: fix NULL pointer dereference in serial_core_unregister_port()

SJ Park (1):
      mm/damon/core: don't skip damos_adjust_quota() while esz is not zero

Sagnik Sasmal (1):
      mtd: spinand: Do not update the QE bit on devices without one

Sai Teja Aluvala (1):
      Bluetooth: btintel: validate DDC record lengths

Salah Triki (5):
      iio: accel: sca3000: fix frequency divider condition check
      iio: adc: ad4030: fix invalid oversampling_ratio validation
      iio: frequency: admv1013: fix wrong channel field used in admv1013_read_raw()
      iio: proximity: isl29501: Fix return type of isl29501_register_write
      iio: proximity: vcnl3020: fix ISR bitmask check in IRQ handler

Sandeep Haemoon (1):
      net: ethernet: mtk_eth_soc: allocate dummy netdev sooner

Sang-Hoon Choi (1):
      Bluetooth: hci_core: free the HCI ID if naming fails

Sean Christopherson (9):
      KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails
      KVM: x86: Fill kvm_run exit fields in common get_nested_state_pages() error paths
      KVM: nVMX: Force MSR bitmap refresh if runtime eVMCS controls are modified
      KVM: SEV: Nullify "have run CPUs" mask pointer when freeing it
      KVM: SEV: Do cache maintenance on the source VM *before* clearing SEV state
      KVM: x86/mmu: Bail from shadow walks if the root is invalid or a dummy
      KVM: SVM: Use the active VMCB's MSR bitmap when checking if MSR is intercepted
      KVM: SVM: Preserve TLB control (i.e. pending TLB flush) on failed VMRUN
      KVM: SVM: Update control fields on #VMEXIT if and only if VMRUN succeeded

Sebastian Dalfuß (1):
      ALSA: usb-audio: Add boot quirk for Behringer CM1A

Sebastian Sjoholm (1):
      USB: serial: option: add Quectel RG660QB

Sheetal (1):
      ASoC: tegra: Fix ASRC Stream6 input threshold control

Simon Gassner (1):
      serial: tegra: don't clear the Tx FIFO on an Rx-only reset

Simon Polack (1):
      drm/amd/display: Fix stale replay_events after mod_power stream removal

Slavin Liu (1):
      iio: adc: pac1934: check ACPI label duplication

Stanislaw Gruszka (1):
      wifi: cfg80211: fix RTS threshold setting for single-radio PHY

Surendran Kanagaraj (1):
      tpm: Disable TPM on null key name mismatch

Sven Peter (6):
      thunderbolt: Hold a router reference for each allocated HopID
      thunderbolt: Make the DP tunnel activation callback mandatory
      thunderbolt: Mark discovered tunnels as active
      thunderbolt: Tear down inactive DP tunnels when the domain is stopped
      thunderbolt: Fix domain reference leak when DPRX read is canceled
      thunderbolt: Don't access a DP tunnel after its DPRX read was canceled

Syed Labeeq Sajid Bukhari (1):
      usb: storage: sierra_ms: reject short SWoC info transfers

Takashi Iwai (5):
      ALSA: usb-audio: Apply IGNORE_CTL_ERROR quirk to all Audient devices
      ALSA: usb-audio: Apply boot quirk for Behringer models generically
      ALSA: core: Define auto-cleanup for snd_card_free()
      ALSA: ice1712: Fix the error handling via auto-cleanup at probe
      usb: gadget: midi2: Fix the jack descriptor array sizes

Tejun Heo (3):
      sched_ext: Build the cid tables privately and publish them with RCU
      sched_ext: Add a size argument to scx_bpf_cid_topo() so struct scx_cid_topo can grow
      sched_ext: Wait for SCX_OPSS_DISPATCHING before reenqueueing a task

Theo Andersen Carton (1):
      drm/amdgpu: skip the noirq suspend reset for a switcheroo-parked GPU

Tianchu Chen (1):
      wifi: cw1200: fix TX padding OOB read leaking heap data to device

Tibor Harcsa (1):
      Bluetooth: btusb: Add IMC Networks QCA9377 to quirks table

Tim Chen (3):
      sched/fair: Avoid creating misfits during cache-aware balancing
      sched/cache: Keep nr_pref_llc_running in the runnable domain, to fix LLC mis-scheduling bug
      sched/cache: Introduce task_struct->sched_cache_grp to fix UAF

Timur Kristóf (5):
      drm/amd/display: Fix fast updates on DCE 6.x
      drm/amd/display: Fix fast updates on DCE 8.1
      drm/amd/display: Mark DCE 6.4 as not APU
      drm/amd/pm/si: Check AMD_IS_MOBILITY flag for PPSMC_SYSTEMFLAG_GPIO_DC
      drm/amd/pm/si: Fix updating clock limits on AC/DC

Toke Høiland-Jørgensen (1):
      wifi: ath9k: Clean up device initialisation guards

Tomer Pomeranc (2):
      binder: fix is_failure flag for superseded transaction cleanup
      binder: fix leaked fd fixups on TF_UPDATE_TXN supersede

Troy Mitchell (1):
      clk: spacemit: k3: add CPU PLL rate tables

Viken Dadhaniya (2):
      soc: qcom: geni-se: Correct QUP Core ICC vote constants
      tty: serial: qcom_geni_serial: Keep console RX functional after deep idle

Vineet Gupta (1):
      ARC: arch_cmpxchg_relaxed to use size of pointed type not pointer

Vitaly Kuznetsov (1):
      virt: vmgenid: remap memory as decrypted

Vladyslav Ivashchenko (1):
      iio: adc: axp288: Add TS bias override for Haier HV103H

Weiming Shi (1):
      nvmet-auth: fix out-of-bounds write in nvmet_auth_challenge()

Wentao Liang (7):
      of/irq: Fix remaining refcount leaks in of_irq_init()
      wifi: wlcore: Fix runtime PM leak in wlcore_remove()
      drm/mediatek: Fix runtime PM leak in mtk_hdmi_ddc_v2_probe()
      drm/mediatek: Fix pdev reference leak in mtk_drm_bind()
      kgdboc: Fix tty driver reference leak in configure_kgdboc()
      serial: ma35d1: Fix clock reference leak in ma35d1serial_probe()
      serial: vt8500: Fix clock reference leak in vt8500_serial_probe()

Willem de Bruijn (1):
      net: extend IPv6 exthdr detection of tunneled packets

Willian Oliveira (1):
      drm/amdgpu/gfx6: fix firmware leak on teardown

Xiang Mei (2):
      ALSA: line6: reject oversized playback packets
      ALSA: ua101: reject mismatched capture/playback packet sizes

Xuanqiang Luo (1):
      pfcp: fix socket lifetime on netdevice registration failure

Yang Xiuwei (1):
      block: reject polled dio with user integrity metadata

Yao Sang (1):
      nvme: fix command effects log lifetime for multipath heads

Yi Yang (1):
      vc_screen: reload vc pointer before if (ret) in vcs_write() to avoid UAF

Yongzhao Chen (1):
      net: phy: qcom: at803x: Fix IPQ5018 short-cable DAC values

Yoshihisa Yamamoto (1):
      net: pcs: rzn1-miic: Clear MIIC protection state before unprotect sequence

Yu-Hsiang Tseng (1):
      ALSA: hda/realtek: Fix silent speaker on Higole F9B

Yuchao Zhang (3):
      wifi: mac80211: drop oversized fragments to avoid extra_len overflow
      USB: cdc-acm: skip URB restart in port_shutdown if disconnected
      usb: gadget: f_fs: Fix NULL pointer dereference in FUNCTIONFS_ENDPOINT_DESC

Yuho Choi (1):
      of: Put coreboot node after compatibility check

Yuqi Xu (3):
      wifi: mac80211: validate TX status rate metadata
      wifi: mac80211: minstrel_ht: validate fixed rate index
      wifi: mac80211: handle empty FILS association request payload

Yuxiao Wang (1):
      nitro_enclaves: fix use-after-free on SLOT_ALLOC failure

Zhan Xusheng (2):
      sysctl: Negate before converting in the int read path
      time/jiffies: Saturate in mult_hz() instead of wrapping

Zhang Heng (1):
      ALSA: hda/realtek: Fix square wave output on ASUS Strix G615LR

Zhang Jie (1):
      iio: proximity: sx9324: Correct proximity channel resolution

Zhao Dongdong (1):
      USB: serial: option: add support for SIMCom SIM8260C

Zhao Li (6):
      wifi: cfg80211: preserve hidden-group beacon IE ownership
      wifi: mac80211: shut down RX BA session timer on teardown
      wifi: mac80211: drain PS delivery work during station teardown
      wifi: mac80211: account proxy paths against the mesh path limit
      wifi: mac80211: keep fallback association elements alive
      wifi: mac80211: release mesh path quota on failed additions

Zhengchuan Liang (1):
      perf: Require kernel access for text poke events

Zhichen Wang (1):
      virt: vmgenid: set driver_data before registering notification handlers

Zhiling Zou (3):
      ipvs: bound LBLCR and LBLC cache growth
      wifi: mac80211: count only matching reservations in reserved switch
      wifi: mac80211: keep paired old chanctx alive

Zihan Xi (2):
      net: gso: limit recursive IP-in-IP segmentation
      wifi: mac80211: fix mesh fast xmit path deletion UAF

Zimeng Li (1):
      ASoC: qcom: lpass-cpu: use DAI table index for playback constraints

Zizhi Wo (1):
      vt: skip screen update for DEC alignment test on backgroup consoles

fangqiurong (1):
      sched_ext: Don't run ops.dequeue() with a DSQ lock held

lollipopkit (1):
      io_uring/cmd_net: end TX_TIMESTAMP multishot when the CQ is full

Ömer Mete Kaya (1):
      bpf: Fix missing migration protection in __rhtab_map_lookup_and_delete_batch()

