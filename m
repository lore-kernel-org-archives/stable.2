Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D950B5733E;
	Sat, 18 Jul 2026 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784386893; cv=none; b=RTvQffMJwRjL6f0TmLIohLlFomZGaAFysTXSJXNwqMLa2KEg0D6r7RlxNocJps0NspB8RO2CF05IGXz8EJNhPAT9QAkNiKLcaEk4Ej3Tvi8Ah7E7P/jCzk1rKa8tFtn30TwwcwY7eJx0QJLqY0rskv1S/aV3VHbqJqzcOUI2ft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784386893; c=relaxed/simple;
	bh=aRmpeLlv5Git5OSBIgl276qG4thasC+5PTxao3HMvp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=roT/7DCj/56z4ADBxfme7Zxz0RM3VMNFfj6oKgnqL9qw/MAuFhEGJSs4mWSzFSclsS30WKSiOh9zd6zcOhMlVTaZhzAdyeXenkond65CuFy51XvTOKF6seCd/Nqlm6ce5xOE7gQue+bWoV2MHZJ8gq3NdYaPcoVatG9d4BCt6Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VTLLovIr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VTLLovIr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93531F00A3A;
	Sat, 18 Jul 2026 15:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784386889;
	bh=zdo0i5dNlskwPc1J04wmIo23bVVEWLkZNGlzZtR+w7U=;
	h=From:To:Cc:Subject:Date;
	b=VTLLovIrItFwIDtHdHCjMFiF5HO1t6RMhbZ7KQ9FG1Ftr54vdMbBmw20DSZpq55GO
	 5h1oGEdvBv3irGX/6h6QvhM5oW/azjYBnb7zIecCmaAE9hFfHKnjpZvq4Epg7KW2gK
	 fu3e6XlnuOvsqZZI5D5EkIvYWAwi8Tg06ow2QyIs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.1.4
Date: Sat, 18 Jul 2026 17:01:16 +0200
Message-ID: <2026071816-cussed-fantasy-7a62@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.1.4 kernel.

All users of the 7.1 kernel series must upgrade.

The updated 7.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/crypto/userspace-if.rst                        |   31 
 Documentation/sound/alsa-configuration.rst                   |    6 
 MAINTAINERS                                                  |    1 
 Makefile                                                     |    5 
 arch/arm64/include/asm/kvm_hyp.h                             |    1 
 arch/arm64/kernel/entry-fpsimd.S                             |    8 
 arch/arm64/kvm/arm.c                                         |    2 
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                           |   12 
 arch/arm64/kvm/nested.c                                      |   40 
 arch/arm64/net/bpf_jit_comp.c                                |    4 
 arch/loongarch/configs/loongson32_defconfig                  |    1 
 arch/loongarch/configs/loongson64_defconfig                  |    1 
 arch/loongarch/include/asm/acpi.h                            |    2 
 arch/loongarch/kernel/acpi.c                                 |   28 
 arch/loongarch/kernel/setup.c                                |    2 
 arch/loongarch/kvm/intc/eiointc.c                            |    6 
 arch/loongarch/kvm/intc/ipi.c                                |    2 
 arch/loongarch/kvm/intc/pch_pic.c                            |    2 
 arch/loongarch/net/bpf_jit.c                                 |    5 
 arch/loongarch/pci/acpi.c                                    |    2 
 arch/powerpc/net/bpf_jit_comp.c                              |    4 
 arch/riscv/boot/dts/sophgo/sg2042.dtsi                       |    4 
 arch/riscv/include/asm/pgtable.h                             |   10 
 arch/riscv/kernel/entry.S                                    |    7 
 arch/riscv/net/bpf_jit_comp64.c                              |    2 
 arch/riscv/net/bpf_jit_core.c                                |    3 
 arch/s390/Kconfig                                            |    1 
 arch/s390/include/asm/asm-extable.h                          |    4 
 arch/s390/include/asm/word-at-a-time.h                       |   22 
 arch/s390/mm/extable.c                                       |   18 
 arch/x86/events/intel/uncore_snb.c                           |    7 
 arch/x86/include/asm/nospec-branch.h                         |    4 
 arch/x86/kernel/cpu/bugs.c                                   |   50 -
 arch/x86/kernel/cpu/resctrl/monitor.c                        |    5 
 arch/x86/kvm/lapic.c                                         |   49 
 arch/x86/kvm/lapic.h                                         |    3 
 arch/x86/kvm/svm/avic.c                                      |   47 
 arch/x86/kvm/svm/sev.c                                       |   10 
 arch/x86/kvm/svm/svm.c                                       |    3 
 arch/x86/kvm/vmx/pmu_intel.c                                 |    6 
 arch/x86/kvm/vmx/tdx.c                                       |   16 
 arch/x86/kvm/vmx/vmx.c                                       |   44 
 arch/x86/kvm/x86.c                                           |   38 
 arch/x86/mm/init_64.c                                        |   40 
 arch/x86/net/bpf_jit_comp.c                                  |    5 
 block/bdev.c                                                 |    8 
 block/partitions/aix.c                                       |    9 
 block/partitions/of.c                                        |    5 
 crypto/af_alg.c                                              |   73 -
 crypto/algif_aead.c                                          |    8 
 crypto/asymmetric_keys/x509_loader.c                         |    2 
 crypto/chacha20poly1305.c                                    |   11 
 crypto/df_sp80090a.c                                         |    7 
 crypto/drbg.c                                                |   16 
 crypto/ecc.c                                                 |   31 
 crypto/krb5/krb5_api.c                                       |    2 
 crypto/pcrypt.c                                              |    4 
 drivers/acpi/cppc_acpi.c                                     |   11 
 drivers/acpi/nfit/core.c                                     |   21 
 drivers/android/binder.c                                     |   19 
 drivers/android/binder/allocation.rs                         |    5 
 drivers/android/binder/error.rs                              |   13 
 drivers/android/binder/freeze.rs                             |   11 
 drivers/android/binder/node.rs                               |   10 
 drivers/android/binder/process.rs                            |   18 
 drivers/android/binder/rust_binder_events.c                  |    7 
 drivers/android/binder/stats.rs                              |    4 
 drivers/android/binder/thread.rs                             |   65 -
 drivers/android/binder/transaction.rs                        |   15 
 drivers/base/firmware_loader/sysfs_upload.c                  |    8 
 drivers/bluetooth/btmtksdio.c                                |    2 
 drivers/bluetooth/btnxpuart.c                                |    6 
 drivers/bluetooth/btusb.c                                    |   39 
 drivers/bluetooth/hci_ldisc.c                                |   14 
 drivers/char/hw_random/jh7110-trng.c                         |   13 
 drivers/char/hw_random/virtio-rng.c                          |   23 
 drivers/clocksource/timer-tegra186.c                         |    3 
 drivers/cpufreq/cpufreq.c                                    |    2 
 drivers/cpufreq/intel_pstate.c                               |    6 
 drivers/cpufreq/pcc-cpufreq.c                                |    2 
 drivers/cpufreq/qcom-cpufreq-hw.c                            |    1 
 drivers/crypto/Kconfig                                       |    2 
 drivers/crypto/Makefile                                      |    1 
 drivers/crypto/amcc/crypto4xx_core.c                         |   88 -
 drivers/crypto/amcc/crypto4xx_core.h                         |    4 
 drivers/crypto/amcc/crypto4xx_reg_def.h                      |   11 
 drivers/crypto/amlogic/amlogic-gxl-core.c                    |    2 
 drivers/crypto/atmel-sha204a.c                               |   27 
 drivers/crypto/caam/caamalg.c                                |   12 
 drivers/crypto/caam/caamalg_qi.c                             |   12 
 drivers/crypto/caam/caamalg_qi2.c                            |   12 
 drivers/crypto/caam/caamhash.c                               |    4 
 drivers/crypto/caam/key_gen.c                                |    4 
 drivers/crypto/ccp/sev-dev.c                                 |   70 -
 drivers/crypto/hisilicon/Kconfig                             |    1 
 drivers/crypto/hisilicon/trng/trng.c                         |  296 -----
 drivers/crypto/intel/qat/qat_420xx/adf_drv.c                 |    2 
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c                  |    2 
 drivers/crypto/intel/qat/qat_6xxx/adf_drv.c                  |    2 
 drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c                 |    1 
 drivers/crypto/intel/qat/qat_c3xxxvf/adf_drv.c               |    1 
 drivers/crypto/intel/qat/qat_c62x/adf_drv.c                  |    1 
 drivers/crypto/intel/qat/qat_c62xvf/adf_drv.c                |    1 
 drivers/crypto/intel/qat/qat_common/adf_accel_devices.h      |    2 
 drivers/crypto/intel/qat/qat_common/adf_aer.c                |  109 +-
 drivers/crypto/intel/qat/qat_common/adf_common_drv.h         |    3 
 drivers/crypto/intel/qat/qat_common/adf_init.c               |   18 
 drivers/crypto/intel/qat/qat_common/adf_isr.c                |   39 
 drivers/crypto/intel/qat/qat_common/adf_sriov.c              |   32 
 drivers/crypto/intel/qat/qat_common/qat_asym_algs.c          |   10 
 drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c              |    1 
 drivers/crypto/intel/qat/qat_dh895xccvf/adf_drv.c            |    1 
 drivers/crypto/loongson/Kconfig                              |    5 
 drivers/crypto/loongson/Makefile                             |    1 
 drivers/crypto/loongson/loongson-rng.c                       |  209 ----
 drivers/crypto/talitos.c                                     |  549 +++++------
 drivers/crypto/talitos.h                                     |   12 
 drivers/crypto/tegra/tegra-se-main.c                         |    2 
 drivers/dma-buf/udmabuf.c                                    |    9 
 drivers/edac/i10nm_base.c                                    |   14 
 drivers/fpga/dfl-afu-main.c                                  |    3 
 drivers/gpio/gpio-eic-sprd.c                                 |    8 
 drivers/gpio/gpio-sch.c                                      |   32 
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c                |   31 
 drivers/hid/hid-appleir.c                                    |   45 
 drivers/hid/hid-goodix-spi.c                                 |    3 
 drivers/hid/hid-lenovo-go.c                                  |    9 
 drivers/hid/hid-letsketch.c                                  |   36 
 drivers/hid/hid-lg-g15.c                                     |   16 
 drivers/hid/hid-logitech-dj.c                                |    9 
 drivers/hid/hid-multitouch.c                                 |   32 
 drivers/hid/hid-sensor-hub.c                                 |   77 +
 drivers/hid/uhid.c                                           |    8 
 drivers/hid/usbhid/hid-pidff.c                               |    2 
 drivers/hid/wacom_sys.c                                      |   20 
 drivers/hwtracing/coresight/coresight-etb10.c                |    6 
 drivers/hwtracing/coresight/ultrasoc-smb.c                   |    1 
 drivers/i2c/busses/i2c-davinci.c                             |    4 
 drivers/i2c/busses/i2c-i801.c                                |    2 
 drivers/i2c/busses/i2c-imx-lpi2c.c                           |   15 
 drivers/i2c/busses/i2c-mpc.c                                 |    2 
 drivers/i2c/busses/i2c-stm32f7.c                             |    9 
 drivers/i2c/i2c-core-base.c                                  |   81 +
 drivers/iio/accel/bmc150-accel-core.c                        |    2 
 drivers/iio/accel/kxsd9.c                                    |    5 
 drivers/iio/adc/Kconfig                                      |    4 
 drivers/iio/adc/ad_sigma_delta.c                             |   39 
 drivers/iio/adc/lpc32xx_adc.c                                |    4 
 drivers/iio/adc/nxp-sar-adc.c                                |    4 
 drivers/iio/adc/spear_adc.c                                  |    3 
 drivers/iio/adc/ti-ads1119.c                                 |    6 
 drivers/iio/adc/ti-ads124s08.c                               |    3 
 drivers/iio/buffer/industrialio-hw-consumer.c                |    2 
 drivers/iio/chemical/scd30_core.c                            |   19 
 drivers/iio/common/st_sensors/st_sensors_core.c              |   23 
 drivers/iio/dac/ad3552r-hs.c                                 |    2 
 drivers/iio/gyro/bmg160_core.c                               |   16 
 drivers/iio/imu/adis_trigger.c                               |    2 
 drivers/iio/imu/bmi160/bmi160_core.c                         |    3 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c            |    4 
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c           |    9 
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h           |    1 
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c             |    4 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c                 |   21 
 drivers/iio/industrialio-backend.c                           |    2 
 drivers/iio/industrialio-core.c                              |    2 
 drivers/iio/industrialio-event.c                             |    5 
 drivers/iio/light/Kconfig                                    |    3 
 drivers/iio/light/al3010.c                                   |   10 
 drivers/iio/light/al3320a.c                                  |    8 
 drivers/iio/light/gp2ap002.c                                 |    2 
 drivers/iio/light/opt3001.c                                  |    6 
 drivers/iio/light/tsl2591.c                                  |    6 
 drivers/iio/light/veml6030.c                                 |    8 
 drivers/iio/magnetometer/ak8975.c                            |    1 
 drivers/iio/pressure/bmp280-core.c                           |    2 
 drivers/iio/pressure/mpl115.c                                |    4 
 drivers/iio/proximity/vl53l0x-i2c.c                          |    7 
 drivers/iio/resolver/ad2s1210.c                              |    2 
 drivers/iio/temperature/Makefile                             |    2 
 drivers/iio/temperature/ltc2983.c                            |    5 
 drivers/iio/temperature/tmp006.c                             |    2 
 drivers/infiniband/core/addr.c                               |    2 
 drivers/infiniband/sw/siw/siw_qp_rx.c                        |    9 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                       |    5 
 drivers/input/joystick/iforce/iforce-packets.c               |   18 
 drivers/input/joystick/maplecontrol.c                        |    3 
 drivers/input/keyboard/maple_keyb.c                          |    4 
 drivers/input/mouse/elan_i2c_core.c                          |   36 
 drivers/input/mouse/maplemouse.c                             |    9 
 drivers/input/rmi4/rmi_bus.c                                 |    4 
 drivers/input/rmi4/rmi_f30.c                                 |    2 
 drivers/input/rmi4/rmi_f3a.c                                 |    2 
 drivers/input/serio/gscps2.c                                 |    1 
 drivers/input/touchscreen/ads7846.c                          |    5 
 drivers/input/touchscreen/goodix.c                           |    3 
 drivers/input/touchscreen/mms114.c                           |   26 
 drivers/input/touchscreen/touchwin.c                         |   15 
 drivers/iommu/amd/iommu.c                                    |    3 
 drivers/iommu/intel/iommu.h                                  |   11 
 drivers/iommu/intel/svm.c                                    |   12 
 drivers/iommu/iommufd/driver.c                               |   13 
 drivers/iommu/iommufd/eventq.c                               |   36 
 drivers/iommu/iommufd/hw_pagetable.c                         |   11 
 drivers/iommu/iommufd/iommufd_private.h                      |    2 
 drivers/md/dm-ioctl.c                                        |    5 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c         |    3 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c          |    2 
 drivers/mfd/cros_ec_dev.c                                    |    3 
 drivers/net/usb/kalmia.c                                     |    8 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c             |    3 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c             |    3 
 drivers/net/wireless/realtek/rtw89/core.c                    |    3 
 drivers/net/wireless/realtek/rtw89/mac80211.c                |    3 
 drivers/ntb/hw/epf/ntb_hw_epf.c                              |   14 
 drivers/nvme/host/multipath.c                                |    6 
 drivers/nvme/target/discovery.c                              |   23 
 drivers/nvme/target/fabrics-cmd-auth.c                       |   15 
 drivers/nvme/target/rdma.c                                   |    6 
 drivers/opp/of.c                                             |    3 
 drivers/pci/controller/dwc/pci-imx6.c                        |   65 -
 drivers/pci/controller/dwc/pcie-qcom.c                       |    6 
 drivers/pci/controller/pci-host-common.c                     |    4 
 drivers/pci/controller/pci-loongson.c                        |   36 
 drivers/pci/controller/pcie-altera.c                         |   36 
 drivers/pci/controller/pcie-mediatek.c                       |   63 -
 drivers/pci/iov.c                                            |    6 
 drivers/pci/quirks.c                                         |   51 -
 drivers/pci/rebar.c                                          |    6 
 drivers/perf/arm-cmn.c                                       |   23 
 drivers/platform/x86/intel/hid.c                             |    9 
 drivers/regulator/scmi-regulator.c                           |    4 
 drivers/spi/spi-fsl-lpspi.c                                  |   18 
 drivers/staging/media/atomisp/pci/sh_css.c                   |    6 
 drivers/staging/media/ipu3/ipu3-css-params.c                 |    8 
 drivers/staging/media/ipu7/ipu7.c                            |   22 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c               |   15 
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c                |   20 
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c               |   23 
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c            |    8 
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c                |    6 
 drivers/staging/vme_user/vme_fake.c                          |    8 
 drivers/staging/vme_user/vme_tsi148.c                        |    8 
 drivers/staging/vme_user/vme_user.c                          |   22 
 drivers/tty/serial/8250/8250_mid.c                           |   13 
 drivers/tty/vt/keyboard.c                                    |   12 
 drivers/usb/cdns3/cdnsp-mem.c                                |    2 
 drivers/usb/class/cdc-acm.c                                  |    3 
 drivers/usb/common/ulpi.c                                    |   23 
 drivers/usb/core/quirks.c                                    |    6 
 drivers/usb/dwc3/core.c                                      |    4 
 drivers/usb/dwc3/dwc3-meson-g12a.c                           |   14 
 drivers/usb/dwc3/gadget.c                                    |   43 
 drivers/usb/fotg210/fotg210-hcd.c                            |    6 
 drivers/usb/gadget/composite.c                               |    5 
 drivers/usb/gadget/function/f_fs.c                           |    9 
 drivers/usb/gadget/function/f_printer.c                      |    3 
 drivers/usb/gadget/function/rndis.c                          |   20 
 drivers/usb/gadget/udc/core.c                                |   29 
 drivers/usb/host/ehci-sched.c                                |   11 
 drivers/usb/host/sl811-hcd.c                                 |    1 
 drivers/usb/host/xhci-sideband.c                             |    2 
 drivers/usb/host/xhci.c                                      |   11 
 drivers/usb/misc/chaoskey.c                                  |    1 
 drivers/usb/misc/idmouse.c                                   |   45 
 drivers/usb/misc/iowarrior.c                                 |   61 -
 drivers/usb/misc/ldusb.c                                     |   38 
 drivers/usb/misc/legousbtower.c                              |   37 
 drivers/usb/misc/usbio.c                                     |    8 
 drivers/usb/misc/uss720.c                                    |    5 
 drivers/usb/mtu3/mtu3_gadget.c                               |    1 
 drivers/usb/serial/digi_acceleport.c                         |   43 
 drivers/usb/serial/keyspan_pda.c                             |    2 
 drivers/usb/serial/option.c                                  |   16 
 drivers/usb/storage/ene_ub6250.c                             |    3 
 drivers/usb/storage/usb.c                                    |    2 
 drivers/usb/typec/anx7411.c                                  |    4 
 drivers/usb/typec/class.c                                    |    1 
 drivers/usb/typec/mux.c                                      |   13 
 drivers/usb/typec/mux/ps883x.c                               |    6 
 drivers/usb/typec/tcpm/tcpci_rt1711h.c                       |   13 
 drivers/usb/typec/tcpm/tcpm.c                                |    9 
 drivers/usb/typec/ucsi/displayport.c                         |    7 
 drivers/usb/typec/ucsi/ucsi.c                                |   20 
 drivers/usb/typec/ucsi/ucsi.h                                |    1 
 drivers/usb/typec/ucsi/ucsi_acpi.c                           |   10 
 drivers/usb/typec/ucsi/ucsi_ccg.c                            |    2 
 drivers/usb/usbip/vudc.h                                     |    1 
 drivers/usb/usbip/vudc_dev.c                                 |    4 
 drivers/vfio/debugfs.c                                       |    1 
 drivers/vfio/pci/mlx5/cmd.h                                  |   15 
 drivers/vfio/pci/vfio_pci_core.c                             |   37 
 drivers/vfio/vfio_main.c                                     |   11 
 drivers/virtio/virtio_mmio.c                                 |   26 
 drivers/virtio/virtio_pci_common.c                           |   10 
 drivers/watchdog/apple_wdt.c                                 |    1 
 fs/btrfs/btrfs_inode.h                                       |    2 
 fs/btrfs/direct-io.c                                         |   60 +
 fs/btrfs/extent-tree.c                                       |   12 
 fs/btrfs/file.c                                              |   25 
 fs/btrfs/inode.c                                             |   67 +
 fs/btrfs/ordered-data.c                                      |   12 
 fs/btrfs/ordered-data.h                                      |    2 
 fs/btrfs/reflink.c                                           |    4 
 fs/exfat/dir.c                                               |   63 +
 fs/exfat/exfat_fs.h                                          |    5 
 fs/exfat/namei.c                                             |   89 +
 fs/fs-writeback.c                                            |   31 
 fs/fuse/cuse.c                                               |    4 
 fs/fuse/dev.c                                                |   66 -
 fs/fuse/dev_uring.c                                          |   93 +
 fs/fuse/dev_uring_i.h                                        |   10 
 fs/fuse/dir.c                                                |   36 
 fs/fuse/fuse_dev_i.h                                         |    1 
 fs/fuse/notify.c                                             |  434 ++++++++
 fs/fuse/readdir.c                                            |   85 +
 fs/hfs/bnode.c                                               |    4 
 fs/hfsplus/bnode.c                                           |    2 
 fs/hfsplus/hfsplus_fs.h                                      |    2 
 fs/isofs/rock.c                                              |   11 
 fs/libfs.c                                                   |    1 
 fs/nfs/dir.c                                                 |    2 
 fs/nilfs2/segment.c                                          |   22 
 fs/ntfs/index.c                                              |    5 
 fs/ntfs3/fslog.c                                             |   20 
 fs/proc/array.c                                              |    6 
 fs/proc/base.c                                               |  160 +--
 fs/proc/fd.c                                                 |   27 
 fs/proc/internal.h                                           |    2 
 fs/proc/namespaces.c                                         |   12 
 fs/resctrl/monitor.c                                         |   39 
 fs/smb/client/cifs_swn.c                                     |  314 +++++-
 fs/smb/client/cifsacl.c                                      |    2 
 fs/smb/client/file.c                                         |    2 
 fs/smb/client/inode.c                                        |    3 
 fs/smb/client/smb2misc.c                                     |   52 -
 fs/smb/client/smb2ops.c                                      |   18 
 fs/smb/client/smb2pdu.c                                      |   22 
 fs/smb/client/trace.h                                        |    2 
 fs/smb/server/auth.c                                         |   20 
 fs/smb/server/smb2pdu.c                                      |  111 +-
 fs/smb/server/vfs.c                                          |   20 
 fs/smb/server/vfs_cache.c                                    |   28 
 fs/smb/server/vfs_cache.h                                    |    3 
 fs/udf/balloc.c                                              |    5 
 fs/udf/super.c                                               |   11 
 fs/userfaultfd.c                                             |   20 
 fs/xfs/libxfs/xfs_ag.c                                       |   10 
 fs/xfs/libxfs/xfs_ag.h                                       |    2 
 fs/xfs/libxfs/xfs_bmap_btree.h                               |    2 
 fs/xfs/libxfs/xfs_defer.c                                    |    2 
 fs/xfs/libxfs/xfs_dquot_buf.c                                |   14 
 fs/xfs/libxfs/xfs_exchmaps.c                                 |    2 
 fs/xfs/scrub/dirtree.c                                       |   16 
 fs/xfs/scrub/dqiterate.c                                     |    2 
 fs/xfs/scrub/inode_repair.c                                  |    4 
 fs/xfs/scrub/rgsuper.c                                       |   14 
 fs/xfs/scrub/rtbitmap.c                                      |    2 
 fs/xfs/scrub/rtrefcount.c                                    |    2 
 fs/xfs/scrub/rtrmap.c                                        |    8 
 fs/xfs/scrub/scrub.h                                         |    6 
 fs/xfs/scrub/xfarray.c                                       |    3 
 fs/xfs/xfs_dquot.c                                           |   16 
 fs/xfs/xfs_fsops.c                                           |    2 
 fs/xfs/xfs_iomap.c                                           |    2 
 fs/xfs/xfs_log_recover.c                                     |   15 
 fs/xfs/xfs_qm.c                                              |    5 
 fs/xfs/xfs_reflink.c                                         |   36 
 fs/xfs/xfs_rtalloc.c                                         |    8 
 include/asm-generic/rqspinlock.h                             |   14 
 include/crypto/drbg.h                                        |   18 
 include/crypto/internal/drbg.h                               |   18 
 include/linux/bpf_lsm.h                                      |    4 
 include/linux/damon.h                                        |    8 
 include/linux/filter.h                                       |   15 
 include/linux/fs.h                                           |    5 
 include/linux/glob.h                                         |    1 
 include/linux/hid-sensor-hub.h                               |   25 
 include/linux/kvm_host.h                                     |    3 
 include/linux/page_ext.h                                     |   19 
 include/linux/slab.h                                         |    6 
 include/linux/sunrpc/svc_rdma.h                              |    1 
 include/linux/vfio_pci_core.h                                |   15 
 include/net/bluetooth/hci_core.h                             |    1 
 include/net/bluetooth/l2cap.h                                |    1 
 include/net/netfilter/nf_flow_table.h                        |    2 
 include/net/tcp_ao.h                                         |    1 
 include/sound/hda_codec.h                                    |    1 
 init/Kconfig                                                 |    1 
 io_uring/io-wq.c                                             |    2 
 io_uring/nop.c                                               |    8 
 io_uring/rw.c                                                |   12 
 kernel/audit.c                                               |   21 
 kernel/audit_fsnotify.c                                      |    4 
 kernel/bpf/bpf_inode_storage.c                               |    9 
 kernel/bpf/btf.c                                             |    9 
 kernel/bpf/cgroup.c                                          |    2 
 kernel/bpf/core.c                                            |   68 +
 kernel/bpf/devmap.c                                          |    7 
 kernel/bpf/dispatcher.c                                      |    2 
 kernel/bpf/lpm_trie.c                                        |    8 
 kernel/bpf/verifier.c                                        |   15 
 kernel/events/core.c                                         |   19 
 kernel/futex/requeue.c                                       |    6 
 kernel/liveupdate/luo_session.c                              |    4 
 kernel/module/decompress.c                                   |    2 
 kernel/sched/features.h                                      |    8 
 kernel/time/jiffies.c                                        |   11 
 kernel/time/posix-cpu-timers.c                               |    1 
 kernel/time/timekeeping.c                                    |    7 
 kernel/trace/trace_events_filter.c                           |    6 
 kernel/trace/trace_functions.c                               |    8 
 lib/debugobjects.c                                           |   17 
 lib/glob.c                                                   |   31 
 lib/test_hmm.c                                               |    4 
 mm/damon/ops-common.c                                        |    1 
 mm/filemap.c                                                 |    2 
 mm/khugepaged.c                                              |   39 
 mm/madvise.c                                                 |    3 
 mm/mincore.c                                                 |    3 
 mm/mmap.c                                                    |    2 
 mm/shrinker.c                                                |   13 
 mm/shrinker_debug.c                                          |   14 
 mm/slub.c                                                    |   18 
 mm/swap_cgroup.c                                             |    2 
 mm/swapfile.c                                                |    1 
 net/6lowpan/nhc.c                                            |    2 
 net/bluetooth/6lowpan.c                                      |   18 
 net/bluetooth/af_bluetooth.c                                 |   17 
 net/bluetooth/bnep/core.c                                    |   27 
 net/bluetooth/hci_conn.c                                     |   21 
 net/bluetooth/hci_sync.c                                     |  133 ++
 net/bluetooth/iso.c                                          |   13 
 net/bluetooth/l2cap_core.c                                   |   80 +
 net/bluetooth/l2cap_sock.c                                   |    4 
 net/bluetooth/mgmt.c                                         |    3 
 net/bridge/netfilter/ebtables.c                              |   12 
 net/core/netpoll.c                                           |    9 
 net/ipv4/igmp.c                                              |    1 
 net/ipv4/sysctl_net_ipv4.c                                   |   10 
 net/ipv4/tcp_ao.c                                            |    5 
 net/ipv4/tcp_output.c                                        |    4 
 net/ipv6/netfilter/nf_conntrack_reasm.c                      |    2 
 net/key/af_key.c                                             |    1 
 net/netfilter/ipset/ip_set_core.c                            |    8 
 net/netfilter/nf_conntrack_netlink.c                         |    2 
 net/netfilter/nf_flow_table_core.c                           |   20 
 net/netfilter/nf_flow_table_offload.c                        |   22 
 net/netfilter/nfnetlink_log.c                                |   26 
 net/netfilter/nfnetlink_queue.c                              |   16 
 net/netfilter/xt_u32.c                                       |   16 
 net/sched/sch_dualpi2.c                                      |   11 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c                      |    4 
 net/sunrpc/xprtrdma/svc_rdma_rw.c                            |  229 ----
 net/sunrpc/xprtrdma/svc_rdma_sendto.c                        |    6 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                     |   30 
 net/tipc/bcast.c                                             |   22 
 net/tipc/bcast.h                                             |    2 
 net/tipc/node.c                                              |   15 
 rust/kernel/block/mq/gen_disk.rs                             |   20 
 rust/kernel/cpufreq.rs                                       |    2 
 rust/kernel/pci/io.rs                                        |    6 
 rust/kernel/str.rs                                           |   23 
 scripts/rustdoc_test_builder.rs                              |   16 
 security/bpf/hooks.c                                         |    3 
 security/landlock/domain.c                                   |    9 
 security/landlock/domain.h                                   |    5 
 security/landlock/net.c                                      |    1 
 sound/aoa/fabrics/layout.c                                   |    6 
 sound/core/compress_offload.c                                |   13 
 sound/core/seq/seq_memory.c                                  |    2 
 sound/firewire/isight.c                                      |    3 
 sound/hda/codecs/hdmi/hdmi.c                                 |    9 
 sound/hda/codecs/realtek/alc269.c                            |    1 
 sound/hda/codecs/side-codecs/cs35l41_hda.c                   |   77 +
 sound/hda/codecs/side-codecs/cs35l41_hda.h                   |    5 
 sound/hda/common/jack.c                                      |    6 
 sound/isa/gus/gus_pcm.c                                      |    2 
 sound/pci/cmipci.c                                           |    6 
 sound/pci/es1938.c                                           |    2 
 sound/pci/ice1712/aureon.c                                   |    2 
 sound/pci/ice1712/ice1712.c                                  |    8 
 sound/pci/ice1712/ice1724.c                                  |    6 
 sound/pci/ymfpci/ymfpci_main.c                               |    6 
 sound/usb/caiaq/input.c                                      |    2 
 sound/usb/endpoint.c                                         |   10 
 sound/usb/mixer_quirks.c                                     |  102 +-
 sound/usb/mixer_scarlett.c                                   |    4 
 sound/usb/mixer_us16x08.c                                    |  127 +-
 sound/usb/quirks.c                                           |    3 
 sound/usb/usbaudio.h                                         |    8 
 sound/usb/usx2y/us144mkii.c                                  |   17 
 sound/usb/usx2y/us144mkii_capture.c                          |    2 
 sound/virtio/virtio_kctl.c                                   |   50 +
 sound/virtio/virtio_pcm.c                                    |    3 
 sound/virtio/virtio_pcm_ops.c                                |    3 
 tools/mm/slabinfo.c                                          |    6 
 tools/perf/trace/beauty/fcntl.c                              |   16 
 tools/testing/selftests/landlock/audit.h                     |  140 +-
 tools/testing/selftests/landlock/audit_test.c                |    6 
 tools/testing/selftests/landlock/net_test.c                  |   62 +
 tools/testing/selftests/landlock/ptrace_test.c               |    1 
 tools/testing/selftests/landlock/scoped_abstract_unix_test.c |    1 
 tools/testing/selftests/liveupdate/liveupdate.c              |   42 
 tools/testing/selftests/mm/droppable.c                       |   46 
 tools/testing/selftests/mm/ksft_process_madv.sh              |    2 
 tools/testing/selftests/mm/pagemap_ioctl.c                   |   12 
 tools/usb/usbip/libsrc/usbip_common.c                        |    2 
 tools/usb/usbip/libsrc/usbip_device_driver.c                 |    4 
 tools/usb/usbip/libsrc/vhci_driver.c                         |    1 
 virt/kvm/guest_memfd.c                                       |   14 
 virt/kvm/kvm_mm.h                                            |    7 
 512 files changed, 5914 insertions(+), 3388 deletions(-)

Aaron Erhardt (1):
      ALSA: hda/realtek: Fix noisy mic for Clevo V6xxAW

Abdun Nihaal (1):
      OPP: of: Fix potential memory leak in opp_parse_supplies()

Achkinazi, Igor (1):
      nvme-multipath: set BIO_REMAPPED on bios remapped to per-path namespace disks

Adrian Bente (1):
      netfilter: flowtable: fix offloaded ct timeout never being extended

Ahsan Atta (8):
      crypto: qat - centralize bus master enable
      crypto: qat - fix restarting state leak on allocation failure
      crypto: qat - handle sysfs-triggered reset callbacks
      crypto: qat - keep VFs enabled during reset
      crypto: qat - notify fatal error before AER reset preparation
      crypto: qat - protect service table iterations with service_lock
      crypto: qat - skip restart for down devices
      crypto: qat - factor out AER reset helpers

Alan Stern (1):
      USB: chaoskey: Fix slab-use-after-free in chaoskey_release()

Alberto Ruiz (1):
      fuse: fix device node leak in cuse_process_init_reply()

Alex Williamson (5):
      vfio/pci: Latch disable_idle_d3 per device
      vfio/pci: Release the VGA arbiter client on register_device() failure
      vfio/pci: Fix racy bitfields and tighten struct layout
      vfio: Remove device debugfs before releasing devres
      vfio/mlx5: Fix racy bitfields and tighten struct layout

Alexander A. Klimov (2):
      iio: light: al3010: read both ALS ADC registers again
      iio: light: al3320a: read both ALS ADC registers again

Alexandru Hossu (9):
      staging: media: ipu7: fix double-free and use-after-free in error paths
      staging: rtl8723bs: fix heap buffer overflow in rtw_cfg80211_set_wpa_ie()
      staging: rtl8723bs: fix WEP length underflow and OOB read in OnAuth()
      staging: rtl8723bs: fix OOB read in OnAssocRsp() IE loop
      staging: rtl8723bs: fix OOB read in update_beacon_info() IE loop
      staging: rtl8723bs: fix OOB reads in IE loops in issue_assocreq() and join_cmd_hdl()
      staging: rtl8723bs: fix OOB reads in is_ap_in_tkip() IE loop
      staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()
      staging: rtl8723bs: fix OOB write in HT_caps_handler()

Alexey Nepomnyashih (1):
      xfs: fix unreachable BIGTIME check in dquot flush validation

Alice Ryhl (4):
      rust: kasan: KASAN+RUST requires clang
      rust: Kbuild: set frame-pointer llvm module flag for CONFIG_FRAME_POINTER
      rust_binder: fix BINDER_GET_EXTENDED_ERROR
      rust_binder: clear freeze listener on node removal

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

Andy Shevchenko (4):
      iio: adc: nxp-sar-adc: Fix the delay calculation in nxp_sar_adc_wait_for()
      iio: magnetometer: ak8975: Add missed pm_runtime_put_autosuspend() call
      serial: 8250_mid: Disable DMA for selected platforms
      i2c: mpc: Fix timeout calculations

Andy Yan (1):
      usb: typec: tcpm: Fix VDM type for Enter Mode commands

Anthony Yznaga (1):
      mm: fix mmap errno value when MAP_DROPPABLE is not supported

Arjan van de Ven (1):
      wifi: mt76: mt7921/mt7925: fix NULL dereference in CSA beacon

Arnd Bergmann (2):
      iio: adc: ad4062: add GPIOLIB dependency
      staging: media: atomisp: reduce load_primary_binaries() stack usage

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Validate SVID index in svdm_consume_modes()

Baokun Li (1):
      writeback: fix race between cgroup_writeback_umount() and inode_switch_wbs()

Ben Dooks (1):
      usb: dwc3: fix dwc3_readl() and dwc3_writel() calls in dwc3_ulpi_setup()

Benjamin Coddington (1):
      NFSv4: include MAY_WRITE in open permission mask for O_TRUNC

Bernd Schubert (3):
      fuse-uring: Avoid use-after-free in fuse_uring_async_stop_queues
      fuse-uring: Avoid queue->stopped races and set/read that value under lock
      fuse-uring: make a fuse_req on SQE commit only findable after memcpy

Biren Pandya (3):
      iio: accel: kxsd9: fix runtime PM imbalance on write_raw() error
      iio: light: gp2ap002: fix runtime PM leak on read error
      iio: pressure: mpl115: fix runtime PM leak on read error

Breno Leitao (1):
      netpoll: fix a use-after-free on shutdown path

Bryam Vargas (13):
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

Cameron Graham (1):
      ALSA: hda/hdmi: Add force-connect quirk for HP EliteDesk 800 G5 Mini

Carlos Llamas (3):
      binder: fix UAF in binder_thread_release()
      binder: fix UAF in binder_free_transaction()
      HID: uhid: convert to hid_safe_input_report()

Carlos López (1):
      KVM: x86: Unconditionally recompute CR8 intercept on PPR update

Carlos Song (3):
      spi: fsl-lpspi: replace dmaengine_terminate_all() with dmaengine_terminate_sync()
      spi: fsl-lpspi: terminate the RX channel on TX prepare failure path
      i2c: imx-lpi2c: mark I2C adapter when hardware is powered down

Cen Zhang (1):
      usb: misc: usbio: fix disconnect UAF in client teardown

Chao Shi (1):
      block: skip sync_blockdev() on surprise removal in bdev_mark_dead()

ChenXiaoSong (1):
      smb/server: do not require delete access for non-replacing links

Chi Wang (1):
      audit: Fix data races of skb_queue_len() readers on audit_queue

Chris Mason (3):
      fuse-uring: fix EFAULT clobber in fuse_uring_commit
      fuse-uring: fix data races on ring->ready
      fuse-uring: end fuse_req on io-uring cancel task work

Christoph Hellwig (3):
      xfs: pass back updated nb from xfs_growfs_compute_deltas
      xfs: only log freed extents for the current RTG in zoned growfs
      xfs: initialize iomap->flags earlier in xfs_bmbt_to_iomap

Christopher Mackle (1):
      staging: rtl8723bs: don't drop short TX frames in _rtw_pktfile_read()

Chuck Lever (2):
      svcrdma: wake sq waiters when the transport closes
      Revert "svcrdma: Use contiguous pages for RDMA Read sink buffers"

Cássio Gabriel (9):
      ALSA: virtio: Add missing 384 kHz PCM rate mapping
      ALSA: virtio: Validate control metadata from the device
      ALSA: compress: Fix task creation error unwind
      ALSA: hda/cs35l41: Fix firmware load work teardown
      ALSA: usb-audio: Propagate errors in scarlett_ctl_enum_put()
      ALSA: usb-audio: Propagate US-16x08 write errors in route/mix EQ-switch put callbacks
      ALSA: usb-audio: Roll back quirk control caches on write errors
      ALSA: usb-audio: Update Babyface Pro control caches only after successful writes
      ALSA: usb-audio: Update US-16x08 EQ/comp shadow state after successful writes

Dan Carpenter (4):
      iio: backend: fix uninitialized data in debugfs
      iio: core: fix uninitialized data in debugfs
      iio: dac: ad3552r-hs: fix uninitialized data ni ad3552r_hs_write_data_source()
      smb/client: Fix error code in smb2_aead_req_alloc()

Danilo Krummrich (1):
      rust: pci: use 'static lifetime for PCI BAR resource names

Darrick J. Wong (13):
      xfs: fix pointer arithmetic error on 32-bit systems
      xfs: resample the data fork mapping after cycling ILOCK
      xfs: don't wrap around quota ids in dqiterate
      xfs: grab rtrmap btree when checking rgsuper
      xfs: use the rt version of the cow staging checker
      xfs: set xfarray killable sort correctly
      xfs: handle non-inode owners for rtrmap record checking
      xfs: clamp timestamp nanoseconds correctly
      xfs: fully check the parent handle when it points to the rootdir
      xfs: don't zap bmbt forks if they are MAXLEVELS tall
      xfs: fix off-by-one error when calling xchk_xref_has_rt_owner
      xfs: write the rg superblock when fixing it
      xfs: use rtrefcount btree cursor in xchk_xref_is_rt_cow_staging

Darvell Long (1):
      ALSA: usb-audio: avoid kobject path lookup in DualSense match

Dave Airlie (1):
      nouveau/vmm: fix another SPT/LPT race

David Carlier (1):
      iio: pressure: bmp280: zero-init bmp580 trigger handler buffer

David Hildenbrand (Arm) (2):
      x86/mm: Fix freeing of PMD-sized vmemmap pages
      selftests: mm: fix and speedup "droppable" test

Davide Ornaghi (1):
      ksmbd: fix UAF of struct file_lock in SMB2_LOCK deferred-lock cancellation

Dawei Feng (4):
      crypto: amlogic - avoid double cleanup in meson_crypto_probe()
      xfs: fix memory leak in xfs_dqinode_metadir_create()
      bpf: Restore sysctl new-value from 1 to 0
      usb: free iso schedules on failed submit

Deepanshu Kartikey (1):
      nilfs2: reject CLEAN_SEGMENTS ioctl with out-of-range segment numbers

Dmitry Torokhov (5):
      Input: mms114 - fix touch indexing for MMS134S and MMS136
      Input: mms114 - fix multi-touch slot corruption
      Input: maple_keyb - set driver data before registering input device
      Input: maplemouse - set driver data before registering input device
      Input: maplecontrol - set driver data before registering input device

Eric Biggers (10):
      crypto: af_alg - Remove zero-copy support from skcipher and aead
      crypto: crypto4xx - Remove insecure and unused rng_alg
      crypto: hisi-trng - Remove crypto_rng interface
      crypto: loongson - Select CRYPTO_RNG
      crypto: loongson - Remove broken and unused loongson-rng
      crypto: drbg - Fix returning success on failure in CTR_DRBG
      crypto: drbg - Fix misaligned writes in CTR_DRBG and HASH_DRBG
      crypto: drbg - Fix ineffective sanity check
      crypto: drbg - Fix drbg_max_addtl() on 64-bit kernels
      crypto: drbg - Fix the fips_enabled priority boost

Erich E. Hoover (1):
      USB: quirks: add NO_LPM for the Samsung T5 EVO Portable SSD

Fabio Porcedda (1):
      USB: serial: option: add Telit Cinterion FE990D50 compositions

Fan Wu (1):
      usb: typec: ucsi: ccg: Fix use-after-free of ucsi on remove

Felix Gu (1):
      iio: buffer: hw-consumer: free scan_mask on buffer release

Florian Fainelli (1):
      perf trace beauty fcntl: Fix build with older kernel headers

Florian Fuchs (1):
      Input: maplemouse - fix NULL pointer dereference in open()

Florian Westphal (3):
      netfilter: handle unreadable frags
      netfilter: ebtables: zero chainstack array
      netfilter: ebtables: module names must be null-terminated

Fushuai Wang (1):
      cpufreq: intel_pstate: Sync policy->cur during CPU offline

Gabriele Monaco (1):
      rqspinlock: Fix order in raw_res_spin_(un)lock_irq to allow schedule

Gary Guo (1):
      rust: doctest: fix incorrect pattern in replacement

Geoffrey D. Bennett (1):
      ALSA: FCP: Add Focusrite ISA C8X support

Gil Portnoy (6):
      ksmbd: fix use-after-free of a deferred file_lock on SMB2_CLOSE then SMB2_CANCEL
      ksmbd: add permission checks for FSCTL_DUPLICATE_EXTENTS_TO_FILE
      ksmbd: add a permission check for FSCTL_SET_ZERO_DATA
      ksmbd: add a WRITE_DAC/WRITE_OWNER check to SMB2 SET_INFO SECURITY
      ksmbd: enforce FILE_READ_ATTRIBUTES on SMB_FIND_FILE_POSIX_INFORMATION
      ksmbd: add per-handle permission check to FILE_LINK_INFORMATION

Giovanni Cabiddu (2):
      crypto: qat - fix VF2PF work teardown race in adf_disable_sriov()
      crypto: qat - validate RSA CRT component lengths

Gordon Chen (1):
      ALSA: usb-audio: add IFB_SILENCE_ON_EMPTY quirk for Behringer Flow 8

Greg Kroah-Hartman (1):
      Linux 7.1.4

Griffin Kroah-Hartman (2):
      usb: gadget: function: rndis: add length check to response query
      usb: gadget: function: rndis: add length check for header

Guangshuo Li (3):
      iio: adc: ti-ads1119: fix PM reference leak in buffer preenable
      cpufreq: qcom-cpufreq-hw: Fix possible double free
      firmware_loader: fix device reference leak in firmware_upload_register()

Guillermo Rodríguez (1):
      i2c: stm32f7: truncate clock period instead of rounding it

HE WEI (ギカク) (1):
      usb: misc: usbio: bound bulk IN response length to the received transfer

Han Gao (1):
      riscv: dts: sophgo: Add dma-coherent to SG2042 PCIe controllers

Hao Ge (1):
      lib/test_hmm: use kvfree() to free kvcalloc() allocations

Hao-Qun Huang (2):
      staging: vme_user: fix location monitor leak in fake bridge
      staging: vme_user: fix location monitor leak in tsi148 bridge

Haofeng Li (1):
      ksmbd: validate NTLMv2 response before updating session key

Haoxiang Li (5):
      smb: client: Fix next buffer leak in receive_encrypted_standard()
      usb: cdnsp: fix stream context array leak in cdnsp_alloc_stream_info()
      usb: mtu3: unmap request DMA on queue failure
      i2c: davinci: Unregister cpufreq notifier on probe failure
      Input: synaptics-rmi4 - unregister function handlers on physical driver registration failure

Haoze Xie (1):
      rust: block: fix GenDisk cleanup paths

Heiko Carstens (1):
      s390: Revert support for DCACHE_WORD_ACCESS

Henrique Carvalho (6):
      smb: client: fix query directory replay double-free
      smb: client: fix query_info() replay double-free
      smb: client: fix double-free in SMB2_ioctl() replay
      smb: client: fix change notify replay double-free
      smb: client: fix double-free in SMB2_open() replay
      smb: client: fix double-free in SMB2_close() replay

Herman van Hazendonk (1):
      iio: common: st_sensors: honour channel endianness in read_axis_data

Huacai Chen (2):
      LoongArch: Add PIO for early access before ACPI PCI root register
      ALSA: hda/hdmi: Use 'AC_PINSENSE_ELDV' to detect pinsense for Loongson

Huihui Huang (1):
      tracing: Prevent out-of-bounds read in glob matching

HyeongJun An (4):
      platform/x86: intel-hid: Protect ACPI notify handler against recursion
      ALSA: usx2y: us144mkii: fix work UAF on disconnect
      ALSA: seq: Fix uninitialised heap leak in snd_seq_event_dup()
      HID: logitech-dj: Fix maxfield check in DJ short report validation

Hyunwoo Kim (3):
      rust_binder: use a u64 stride when cleaning up the offsets array
      KVM: arm64: Bound used_lrs when flushing the pKVM hyp vCPU
      KVM: arm64: Clear __hyp_running_vcpu when flushing the pKVM hyp vCPU

Jann Horn (2):
      proc: protect ptrace_may_access() with exec_update_lock (FD links)
      proc: protect ptrace_may_access() with exec_update_lock (part 1)

Janne Grunau (1):
      watchdog: apple: Add "apple,t8103-wdt" compatible

Jared Baldridge (1):
      usb: cdc_acm: Add quirk for Uniden BC125AT scanner

Javier Carrasco (1):
      iio: light: veml6030: fix channel type when pushing events

Jean-Baptiste Maneyrol (2):
      iio: imu: inv_icm42600: fix timestamp clock period by using lower value
      iio: imu: inv_icm42600: fix timestamping by limiting FIFO reading

Jens Glathe (1):
      Revert "usb: typec: mux: avoid duplicated mux switches"

Jeremy Linton (1):
      ACPI: CPPC: Suppress UBSAN warning caused by field misuse

Ji'an Zhou (1):
      fuse: clear intr_entry in fuse_resend and fuse_remove_pending_req

Jimmy Hu (1):
      usb: gadget: udc: Fix use-after-free in gadget_match_driver

Jinmo Yang (2):
      HID: wacom: fix slab-out-of-bounds write in wacom_wac_queue_insert
      HID: wacom: use GFP_ATOMIC in wacom_wac_queue_flush()

Joanne Koong (5):
      fuse: re-lock request before returning from fuse_ref_folio()
      fuse: fix io-uring background queue dispatch on request completion
      fuse: don't block in fuse_get_dev() for non-sync_init case
      fuse-uring: fix moving cancelled entry to ent_in_userspace list
      fuse-uring: remove request-less entries from ent_w_req_queue to fix NULL deref

Johan Hovold (20):
      Bluetooth: btusb: fix use-after-free on registration failure
      Bluetooth: btusb: fix use-after-free on marvell probe failure
      Bluetooth: btusb: fix wakeup source leak on probe failure
      virtio-mmio: fix device release warning on module unload
      USB: idmouse: fix use-after-free on disconnect race
      USB: ldusb: fix use-after-free on disconnect race
      USB: iowarrior: fix use-after-free on disconnect
      USB: iowarrior: fix use-after-free on disconnect race
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

John Hubbard (1):
      libfs: set SB_I_NOEXEC and SB_I_NODEV by default in init_pseudo()

Jonathan Cameron (1):
      iio: adc: ad7768-1: Select GPIOLIB

Jose Fernandez (Anthropic) (1):
      mm: swap_cgroup: fix NULL deref in lookup_swap_cgroup_id on swapless host

Joshua Crofts (5):
      iio: adc: ad7779: add missing 'select IIO_TRIGGERED_BUFFER' to Kconfig
      iio: light: al3000a: add missing REGMAP_I2C to Kconfig
      iio: light: al3010: add missing REGMAP_I2C to Kconfig
      iio: light: al3320a: add missing REGMAP_I2C to Kconfig
      iio: light: opt3001: fix missing state reset on timeout

Junrui Luo (2):
      vfio: prevent infinite loop in vfio_mig_get_next_state() on blocked arc
      coresight: ultrasoc-smb: Fix OOB write in smb_sync_perf_buffer()

Kai Aizen (1):
      iommufd: Use sizeof(*hdr) instead of sizeof(hdr) in veventq read

Kartik Rajput (1):
      clocksource/drivers/timer-tegra186: Fix support for multiple watchdog instances

Keshav Verma (2):
      rust_binder: reject context manager self-transaction
      rust_binder: synchronize Rust Binder stats with freeze commands

Ketan (1):
      mm: page_ext: add count limit to page_ext_iter_next to prevent invalid PFN access

Kiryl Shutsemau (1):
      userfaultfd: gate must_wait writability check on pte_present()

Koichiro Den (2):
      NTB: epf: Avoid calling pci_irq_vector() from hardirq context
      NTB: epf: Fix request_irq() unwind in ntb_epf_init_isr()

Kris Bahnsen (1):
      Input: ads7846 - don't use scratch for tx_buf when clearing register

Lars-Peter Clausen (1):
      iio: event: Fix event FIFO reset race

Lee Jia Jie (1):
      perf/aux: Fix page UAF in map_range()

Liviu Stan (2):
      iio: temperature: ltc2983: Fix n_wires default bypassing rotation check
      iio: temperature: ltc2983: Fix reinit_completion() called after conversion start

Louis-Alexis Eyraud (1):
      media: mtk-jpeg: cancel workqueue on release for supported platforms only

Lu Baolu (1):
      iommu/vt-d: Avoid WARNING in sva unbind path

Luca Boccassi (2):
      liveupdate: reject LIVEUPDATE_IOCTL_CREATE_SESSION with invalid name length
      selftests/liveupdate: add test cases for LIVEUPDATE_IOCTL_CREATE_SESSION calls with invalid length

Luiz Augusto von Dentz (1):
      Bluetooth: 6lowpan: Fix using chan->conn as indication to no remote netdev

Lukas Wunner (1):
      X.509: Fix validation of ASN.1 certificate header

Maciej W. Rozycki (1):
      PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining

Madhu M (1):
      usb: typec: ucsi: Pass full DP config payload in SET_NEW_CAM for DP alt mode

Maher Sanalla (1):
      RDMA/core: Fix broadcast address falsely detected as local

Mahesh Vaidya (2):
      PCI: altera: Do not dispose parent IRQ mapping
      PCI: altera: Fix resource leaks on probe failure

Manish Khadka (3):
      HID: hid-lenovo-go: cancel cfg_setup work in hid_go_cfg_remove()
      HID: letsketch: fix UAF on inrange_timer at driver unbind
      HID: appleir: fix UAF on pending key_up_timer in remove()

Manivannan Sadhasivam (1):
      PCI: mediatek: Fix IRQ domain leak when port fails to enable

Maoyi Xie (6):
      ALSA: caiaq: fix out-of-bounds read in the Traktor Kontrol S4 input parser
      ALSA: firewire: isight: bound the sample count to the packet payload
      Bluetooth: btnxpuart: Fix out-of-bounds firmware read in nxp_recv_fw_req_v3()
      HID: lg-g15: cancel pending work on remove to fix a use-after-free
      net: usb: kalmia: bound RX frame length in kalmia_rx_fixup()
      usb: gadget: composite: fix dead empty check in the USB_DT_OTG handler

Marc Zyngier (1):
      KVM: arm64: nv: Avoid dereferencing NULL VNCR pseudo-TLB

Marco Elver (1):
      Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref

Marco Nenciarini (2):
      PCI: Skip Resizable BAR restore on read error
      PCI/IOV: Skip VF Resizable BAR restore on read error

Mark Rutland (1):
      arm64: fpsimd: Fix type mismatch in sme_{save,load}_state()

Matt Bobrowski (1):
      bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF LSM is uninitialized

Matthew R. Ochs (1):
      fuse: back uncached readdir buffers with pages

Maximilian Heyne (1):
      selftests/landlock: Explicitly disable audit in teardowns

Maxwell Doose (3):
      iio: adc: lpc32xx: Initialize completion before requesting IRQ
      iio: adc: spear: Initialize completion before requesting IRQ
      iio: chemical: scd30: Cleanup initializations and fix sign-extension bug

Michael Bommarito (6):
      tcp: restore RCU grace period in tcp_ao_destroy_sock
      hwrng: virtio: clamp device-reported used.len at copy_data()
      crypto: krb5 - filter out async aead implementations at alloc
      smb: client: resolve SWN tcon from live registrations
      udf: validate free block extents against the partition length
      RDMA/siw: bound Read Response placement to the RREAD length

Michael Tautschnig (1):
      staging: vme_user: bound slave read/write to the kern_buf size

Michael Wigham (1):
      io_uring/rw: preserve partial result for iopoll

Mickaël Salaün (4):
      landlock: Set audit_net.sk for socket access checks
      landlock: Account all audit data allocations to user space
      selftests/landlock: Filter dealloc records in audit_count_records()
      selftests/landlock: Increase default audit socket timeout

Miguel Ojeda (3):
      rust: str: use the "kernel vertical" imports style
      rust: str: clean unused import for Rust >= 1.98
      rust: cpufreq: clean new `clippy::map_or_identity` lint for Rust 1.98.0

Mikhail Gavrilov (3):
      udmabuf: fix DMA direction mismatch in release_udmabuf()
      dma-buf/udmabuf: skip redundant cpu sync to fix cacheline EEXIST warning
      timekeeping: Register default clocksource before taking tk_core.lock

Miklos Szeredi (2):
      Revert "fuse: fix conversion of fuse_reverse_inval_entry() to start_removing()"
      fuse: do not use start_removing_noperm()

Mikulas Patocka (1):
      dm-ioctl: report an error if a device has no table

Mingyu Wang (1):
      i2c: i801: fix hardware state machine corruption in error path

Muhammad Bilal (2):
      Bluetooth: ISO: avoid NULL deref of conn in iso_conn_big_sync()
      Bluetooth: L2CAP: validate option length before reading conf opt value

Myeonghun Pak (5):
      usb: typec: tcpci_rt1711h: unregister TCPCI port with devres
      HID: wacom: stop hardware after post-start probe failures
      usb: sl811-hcd: disable controller wakeup on remove
      USB: misc: uss720: unregister parport on probe failure
      usb: typec: anx7411: use devm_pm_runtime_enable()

Namjae Jeon (7):
      ksmbd: prevent path traversal bypass by restricting caseless retry
      ksmbd: serialize QUERY_DIRECTORY requests per file
      ksmbd: require source read access for duplicate extents
      ksmbd: run set info with opener credentials
      ksmbd: use opener credentials for delete-on-close
      ksmbd: use opener credentials for ADS I/O
      ksmbd: track the connection owning a byte-range lock

Neill Kapron (2):
      usb: gadget: f_fs: Initialize epfile->in early to fix endpoint direction checks
      usb: gadget: f_fs: Tie read_buffer lifetime to ffs_epfile

Nicolas Pitre (1):
      vt: fix spurious modifier in CSI/cursor key sequences

Nicolin Chen (10):
      iommufd: Fix data_len byte-count vs element-count mismatch
      iommufd: Move vevent memory allocation outside spinlock
      iommufd: Set veventq_depth upper bound
      iommufd: Rewind header length in done if iommufd_veventq_fops_read() fails
      iommufd: Reject invalid read count in iommufd_veventq_fops_read()
      iommufd: Propagate allocation failure in iommufd_veventq_deliver_fetch()
      iommufd: Reject invalid read count in iommufd_fault_fops_read()
      iommufd: Break the loop on failure in iommufd_fault_fops_read()
      iommufd: Avoid partial fault group delivery in iommufd_fault_fops_read()
      iommufd: Set upper bounds on cache invalidation entry_num and entry_len

Norbert Manthey (1):
      smb: client: mask server-provided mode to 07777 in modefromsid

Nuoqi Gui (1):
      bpf: Keep dynamic inner array lookups nullable

Oleg Makarenko (1):
      HID: pidff: Use correct effect type in effect update

Oliver Upton (1):
      KVM: arm64: Don't leak PFN when kvm_translate_vncr() races MMU notifier

Pablo Neira Ayuso (1):
      netfilter: flowtable: IPIP tunnel hardware offload is not yet support

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

Pawan Gupta (6):
      bpf: Support for hardening against JIT spraying
      x86/bugs: Enable IBPB flush on BPF JIT allocation
      bpf: Restrict JIT predictor flush to cBPF
      bpf: Skip redundant IBPB in pack allocator
      bpf: Prefer packs that won't trigger an IBPB flush on allocation
      bpf: Prefer dirty packs for eBPF allocations

Pedro Falcato (2):
      mm/khugepaged: write all dirty file folios when collapsing
      mm: do file ownership checks with the proper mount idmap

Pengpeng Hou (2):
      iio: adc: ti-ads124s08: Return reset GPIO lookup errors
      iio: temperature: Build mlx90635 with CONFIG_MLX90635

Po-Hao Huang (1):
      wifi: rtw89: correct drop logic for malformed AMPDU frames

Pratham Gupta (1):
      netfilter: ctnetlink: use nf_ct_exp_net() in expectation dump

Qi Zheng (2):
      mm: shrinker: fix shrinker_info teardown race with expansion
      mm: shrinker: fix NULL pointer dereference in debugfs

Qu Wenruo (4):
      btrfs: fix false IO failure after falling back to buffered write
      btrfs: check and set EXTENT_DELALLOC_NEW before clearing EXTENT_DELALLOC
      btrfs: do not trim a device which is not writeable
      btrfs: fix incorrect buffered IO fallback for append direct writes

Radu Sabau (2):
      iio: adc: ad_sigma_delta: fix clear_pending_event for registerless devices
      iio: adc: ad_sigma_delta: fix CS held asserted and state leaks

Rafael J. Wysocki (2):
      ACPI: NFIT: core: Fix possible NULL pointer dereference
      ACPI: NFIT: core: Fix acpi_nfit_init() error cleanup

Raghavendra Rao Ananta (1):
      vfio/pci: Use a private flag to prevent power state change with VFs

Ralph Boehme (1):
      smb/client: fix chown/chgrp with SMB3 POSIX Extensions

Randy Dunlap (1):
      slab: recognize @GFP parameter as optional in kernel-doc

Ranjan Kumar (1):
      Input: elan_i2c - prevent division by zero and arithmetic underflow

Ratheesh Kannoth (1):
      PCI: host-common: Request bus reassignment when not probe-only

Reinette Chatre (1):
      x86,fs/resctrl: Prevent out-of-bounds access while offlining CPU when SNC enabled

Ricardo Ribalda (1):
      media: staging: ipu3-imgu: Add range check for imgu_css_cfg_acc_stripe

Ricardo Robaina (2):
      audit: fix potential integer overflow in audit_log_n_hex()
      audit: fix removal of dangling executable rules

Richard Zhu (3):
      PCI: imx6: Configure REF_USE_PAD before PHY reset for i.MX95
      PCI: imx6: Fix IMX6SX_GPR12_PCIE_TEST_POWERDOWN handling
      PCI: imx6: Assert ref_clk_en after reference clock stabilizes on i.MX95

Robin Murphy (1):
      perf/arm-cmn: Fix DVM node events

Rochan Avlur (1):
      exfat: preserve benign secondary entries during rename and move

Rodrigo Lugathe da Conceição Alves (1):
      USB: core: add USB_QUIRK_NO_LPM for VIA Labs USB 2.0 hub

Rong Zhang (1):
      ALSA: doc: usb-audio: Add doc for QUIRK_FLAG_IFB_SILENCE_ON_EMPTY

Ruijie Li (1):
      crypto: pcrypt - restore callback for non-parallel fallback

Runyu Xiao (8):
      iio: imu: adis: add IRQF_NO_THREAD to non-FIFO trigger IRQ
      iio: imu: bmi160: add IRQF_NO_THREAD to data-ready trigger IRQ
      usb: dwc3: run gadget disconnect from sleepable suspend context
      coresight: etb10: restore atomic_t for shared reading state
      gpio: eic-sprd: use raw_spinlock_t in the irq startup path
      gpio: sch: use raw_spinlock_t in the irq startup path
      io_uring/io-wq: re-check IO_WQ_BIT_EXIT for each linked work item
      Bluetooth: L2CAP: cancel pending_rx_work before taking conn->lock

Sam Day (1):
      usbip: vudc: fix NULL deref in vep_dequeue()

Samuel Moelius (2):
      iio: adc: ad7380: select REGMAP
      fuse: avoid 32-bit prune notification count wrap

Samuel Page (2):
      tipc: fix out-of-bounds read in broadcast Gap ACK blocks
      Bluetooth: MGMT: Fix UAF of hci_conn_params in add_device_complete

Sarthak Sharma (1):
      selftests/mm: fix ksft_process_madv.sh test category

Sean Christopherson (11):
      KVM: x86: Move update_cr8_intercept() to lapic.c
      KVM: VMX: Grab vmcs12 on CR8 interception update iff vCPU is in guest mode
      KVM: SEV: Pin source page for write when adding CPUID data for SNP guest
      KVM: x86: Add dedicated API for getting mask of accelerated x2APIC MSRs
      KVM: SVM: Disable x2AVIC RDMSR interception for MSRs KVM actually supports
      KVM: SVM: Only disable x2AVIC WRMSR interception for MSRs that are accelerated
      KVM: VMX: Refresh GUEST_PENDING_DBG_EXCEPTIONS.BS on all injected #DBs
      KVM: SEV: Don't terminate SNP VMs on #VMGEXIT without a registered GHCB
      KVM: TDX: Account all non-transient page allocations for per-TD structures
      KVM: x86: Ensure vendor's exit handler runs before fastpath userspace exits
      KVM: guest_memfd: Treat memslot binding offset+size as unsigned values

Sebastian Alba Vives (1):
      fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()

Sebastian Andrzej Siewior (1):
      futex/requeue: Revert "Prevent NULL pointer dereference in remove_waiter() on self-deadlock""

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

Siwei Zhang (1):
      Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()

Srinivas Pandruvada (1):
      HID: sensor-hub: Add sensor_hub_input_attr_read_values() for multi-byte reads

Stepan Ionichev (6):
      iio: gyro: bmg160: bail out when bandwidth/filter is not in table
      iio: gyro: bmg160: wait full startup time after mode change at probe
      iio: light: tsl2591: return actual error from probe IRQ failure
      iio: proximity: vl53l0x: notify trigger and clear IRQ on error paths
      iio: resolver: ad2s1210: notify trigger and clear state on fault read error
      iio: temperature: tmp006: use devm_iio_trigger_register

Stephan Gerhold (1):
      usb: typec: ps883x: Fix DP+USB3 configuration

Steven Rostedt (1):
      sched/rt: Have RT_PUSH_IPI be default off for non PREEMPT_RT

Taeyang Lee (1):
      perf/core: Detach event groups during remove_on_exec

Thomas Gleixner (2):
      debugobjects: Plug race against a concurrent OOM disable
      time/jiffies: Register jiffies clocksource before usage

Thorsten Blum (4):
      crypto: atmel-sha204a - drop hwrng quality reduction for ATSHA204A
      crypto: atmel-sha204a - fail on hwrng registration error in probe path
      crypto: caam - use print_hex_dump_devel to guard key hex dumps
      crypto: caam - use print_hex_dump_devel to guard key hex dumps again

Tianchu Chen (2):
      HID: hid-goodix-spi: validate report size to prevent stack buffer overflow
      nvmet-auth: validate reply message payload bounds against transfer length

Tianxiang Chen (1):
      cpufreq: Fix hotplug-suspend race during reboot

Tristan Madani (2):
      hfs/hfsplus: fix u32 overflow in check_and_correct_requested_length
      hfs/hfsplus: zero-initialize buffer in hfs_bnode_read

Trung Nguyen (1):
      HID: multitouch: fix out-of-bounds bit access on mt_io_flags

Tycho Andersen (AMD) (4):
      crypto: ccp - Do not initialize SNP for SEV ioctls
      crypto: ccp - Do not initialize SNP for ioctl(SNP_COMMIT)
      crypto: ccp - Do not initialize SNP for ioctl(SNP_VLEK_LOAD)
      crypto: ccp - Do not initialize SNP for ioctl(SNP_CONFIG)

Tyler Baker (1):
      usb: gadget: f_fs: initialize reset_work at allocation time

Valeriy Yashnikov (1):
      ntfs: avoid calling post_write_mst_fixup() for invalid index_block

Vasileios Almpanis (1):
      io_uring/nop: fix file reference leak with IOSQE_FIXED_FILE

Vasily Khoruzhick (1):
      EDAC/i10nm: Don't fail probing if ADXL is missing

Vidhu Sarwal (1):
      iio: light: al3010: fix incorrect scale for the highest gain range

Vivian Wang (2):
      riscv: mm: Define DIRECT_MAP_PHYSMEM_END
      riscv: mm: Unconditionally sfence.vma for spurious fault

Vlad Poenaru (1):
      bpf: Allow LPM map access from sleepable BPF programs

Vlastimil Babka (SUSE) (1):
      mm/slab: do not limit zeroing to orig_size when only red zoning is enabled

Weiming Shi (1):
      xfs: fail recovery on a committed log item with no regions

Weinan Liu (1):
      iommu/amd: Don't split flush for amd_iommu_domain_flush_all()

WenTao Liang (3):
      ALSA: us144mkii: capture_urb_complete: redundant usb_anchor_urb corrupts anchor list on each resubmission
      posix-cpu-timers: Fix pid refcount leak in do_cpu_nanosleep() error path
      usb: dwc3: meson-g12a: fix refcount leak in dwc3_meson_g12a_resume()

Wentao Liang (5):
      hwrng: jh7110 - fix refcount leak in starfive_trng_read()
      nvme: target: rdma: fix ndev refcount leak on queue connect
      block: partitions: fix of_node refcount leak in of_partition()
      crypto: tegra - fix refcount leak in tegra_se_host1x_submit()
      regulator: scmi: fix of_node refcount leak in scmi_regulator_probe()

Wyatt Feng (1):
      net: ipv4: bound TCP reordering sysctl writes and MTU probe sizes

Xiang Mei (2):
      netfilter: ipset: fix race between dump and ip_set_list resize
      netfilter: ebtables: terminate table name before find_table_lock()

Xiaolei Wang (1):
      media: nxp: imx8-isi: Fix use-after-free on remove

Xiaonan Zhao (1):
      crypto: chacha20poly1305 - validate poly1305 template argument

Xingquan Liu (1):
      net/sched: dualpi2: fix GSO backlog accounting

Xu Rao (6):
      xhci: sideband: fix ring sg table pages leak
      smb: client: fix atime clamp check in read completion
      usb: gadget: f_printer: take kref only for successful open
      USB: storage: include US_FL_NO_SAME in quirks mask
      USB: usb-storage: ene_ub6250: restore media-ready check
      Input: gscps2 - advance receive buffer write index

Xuanqing Shi (1):
      KVM: VMX: Handle bad values on proxied writes to LBR MSRs

Xuewen Wang (1):
      tools/mm/slabinfo: Fix trace disable logic inversion

Yadu M G (1):
      PCI: qcom: Initialize DWC MSI lock for firmware-managed ECAM hosts

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

Yuanhe Shu (1):
      tracing: Fix NULL pointer dereference in func_set_flag()

Yuho Choi (1):
      cpufreq: pcc: fix use-after-free and double free in _OSC evaluation

Yunpeng Tian (1):
      fs/ntfs3: validate Dirty Page Table capacity in log_replay copy_lcns

Yuyang Huang (1):
      ipv4: igmp: remove multicast group from hash table on device destruction

Zeng Chi (1):
      LoongArch: KVM: Add missing slots_lock for device register/unregister

Zenghui Yu (1):
      selftests/mm: pagemap_ioctl: use the correct page size for transact_test()

Zenm Chen (1):
      Bluetooth: btusb: Add USB ID 2c4e:0128 for Mercusys MA60XNB

Zhao Dongdong (6):
      ALSA: ymfpci: check snd_ctl_new1() return value
      ALSA: aoa: check snd_ctl_new1() return value
      ALSA: cmipci: check snd_ctl_new1() return value
      ALSA: es1938: check snd_ctl_new1() return value
      ALSA: gus: check snd_ctl_new1() return value
      ALSA: ice1712: check snd_ctl_new1() return value

Zhao Zhang (2):
      smb: client: fix double-free in SMB2_flush() replay
      bpf: Reject fragmented frames in devmap

Zhenhao Wan (1):
      RDMA/rtrs-srv: Bound RDMA-Write length to chunk size in rdma_write_sg

Zide Chen (1):
      perf/x86/intel/uncore: Defer ADL global PMON enable to enable_box()

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

