Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFE12F549F;
	Fri, 24 Jul 2026 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905563; cv=none; b=gc7AzDoJSfeMer1BWn4+QgaTPJD1V0gcko7tRJ+9zL4sv3XJLVcsj43IfwBcNBdzc3b0QBptrdgMdMQNp84uiSiOZKN9bfGUKknLabHLVpqSTZEsz5IJ4tR4fwBTw71AtHL8Dft894JIYpDur9j6z0cjw0DZOd8o+cAVmgmcVuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905563; c=relaxed/simple;
	bh=+v5jEj62SVdHuPx2XkzSrnRF53ml1x5JU1QxofD3aw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YhMzmKlv4ORWPlQyOksSYEkTfaP5ulOtF1GDVoGfy9SHJEzI0qm3EFFjFVXifZbQ7sxL3x/cYhZcNfhi5YXHrR29tBSuFm5qv0VUo7WF/NQdcQbY15cNdmBx5NWlW2ZCxrsPGKRUMptdMHUK8KxNavvZPvI0CJDSbTSdJomO1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zaunu8Ha; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zaunu8Ha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F441F00A3F;
	Fri, 24 Jul 2026 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784905556;
	bh=Ct2adeOOoV+t0vKTFMRth4m0LzoD9Ullspc7tLcAFvI=;
	h=From:To:Cc:Subject:Date;
	b=zaunu8HaRyHXKccVVy+LULNwlQXoQBZI+DD28QsNJWY11yH2vwN+wVBLqeJHbd/cK
	 VnZeTaiyDurd4lR33U6rPYlnq7kSzVE2Pymll2RXTQpWBQBU0pYF7/H3jklARngFdZ
	 n/OAg8yZorMYx3iLAt36OuEAfaJqdG3OrnzWOCVQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.178
Date: Fri, 24 Jul 2026 17:05:38 +0200
Message-ID: <2026072439-scarce-chump-f6b0@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.178 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/pm/cpufreq.rst                                      |    6 
 Documentation/crypto/userspace-if.rst                                         |   31 
 Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml |   10 
 Documentation/devicetree/bindings/net/renesas,ether.yaml                      |    3 
 Documentation/driver-api/nvdimm/btt.rst                                       |    5 
 Documentation/driver-api/pci/pci.rst                                          |    3 
 Documentation/filesystems/proc.rst                                            |   14 
 Makefile                                                                      |    2 
 arch/alpha/kernel/pci-sysfs.c                                                 |   13 
 arch/arm/boot/dts/am335x-sl50.dts                                             |    4 
 arch/arm/configs/sunxi_defconfig                                              |    1 
 arch/arm/mach-imx/cpu-imx31.c                                                 |    9 
 arch/arm/mach-imx/mm-imx3.c                                                   |    2 
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi                              |    2 
 arch/arm64/boot/dts/nvidia/tegra234.dtsi                                      |    8 
 arch/arm64/boot/dts/qcom/sdm630.dtsi                                          |    9 
 arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts                                |    2 
 arch/arm64/kernel/entry-fpsimd.S                                              |    8 
 arch/arm64/kernel/hw_breakpoint.c                                             |    9 
 arch/arm64/kvm/vgic/vgic-its.c                                                |    2 
 arch/arm64/kvm/vgic/vgic.c                                                    |   11 
 arch/arm64/lib/insn.c                                                         |    2 
 arch/arm64/mm/hugetlbpage.c                                                   |    2 
 arch/arm64/mm/mmu.c                                                           |   11 
 arch/loongarch/include/asm/pgtable.h                                          |    4 
 arch/loongarch/kernel/smp.c                                                   |    1 
 arch/mips/dec/int-handler.S                                                   |    2 
 arch/mips/dec/prom/init.c                                                     |    6 
 arch/mips/dec/setup.c                                                         |    6 
 arch/mips/fw/lib/call_o32.S                                                   |    2 
 arch/mips/include/asm/dec/prom.h                                              |   15 
 arch/mips/kernel/mips-mt-fpaff.c                                              |   28 
 arch/mips/kernel/smp.c                                                        |    2 
 arch/mips/mm/init.c                                                           |   12 
 arch/mips/n64/init.c                                                          |    2 
 arch/mips/ralink/mt7621.c                                                     |    2 
 arch/mips/sgi-ip22/ip22-gio.c                                                 |    7 
 arch/powerpc/kexec/core_64.c                                                  |    4 
 arch/powerpc/perf/core-fsl-emb.c                                              |    3 
 arch/powerpc/platforms/cell/spufs/file.c                                      |    6 
 arch/powerpc/platforms/powernv/setup.c                                        |    3 
 arch/powerpc/platforms/pseries/papr_platform_attributes.c                     |    8 
 arch/riscv/kernel/cacheinfo.c                                                 |    2 
 arch/riscv/kernel/machine_kexec.c                                             |    3 
 arch/riscv/kernel/stacktrace.c                                                |    2 
 arch/s390/kernel/process.c                                                    |    2 
 arch/s390/kvm/pci.c                                                           |   12 
 arch/sparc/kernel/led.c                                                       |    2 
 arch/x86/boot/compressed/acpi.c                                               |    7 
 arch/x86/boot/early_serial_console.c                                          |   11 
 arch/x86/events/amd/core.c                                                    |    6 
 arch/x86/kvm/lapic.c                                                          |    8 
 arch/x86/kvm/vmx/vmx.c                                                        |   38 
 arch/x86/mm/numa_emulation.c                                                  |   17 
 arch/x86/mm/tlb.c                                                             |   16 
 arch/x86/platform/efi/quirks.c                                                |    8 
 arch/x86/platform/olpc/olpc-xo15-sci.c                                        |    1 
 block/bdev.c                                                                  |    4 
 block/partitions/aix.c                                                        |    9 
 crypto/af_alg.c                                                               |    2 
 crypto/algif_skcipher.c                                                       |   49 
 crypto/asymmetric_keys/verify_pefile.c                                        |    2 
 crypto/asymmetric_keys/x509_loader.c                                          |    2 
 crypto/drbg.c                                                                 |    4 
 crypto/ecc.c                                                                  |   31 
 crypto/ecrdsa.c                                                               |    2 
 crypto/pcrypt.c                                                               |    4 
 crypto/rng.c                                                                  |   11 
 drivers/acpi/acpi_ipmi.c                                                      |    4 
 drivers/acpi/cppc_acpi.c                                                      |   11 
 drivers/acpi/nfit/core.c                                                      |   15 
 drivers/acpi/resource.c                                                       |    6 
 drivers/android/binder.c                                                      |   19 
 drivers/ata/pata_pxa.c                                                        |    1 
 drivers/ata/sata_gemini.c                                                     |    2 
 drivers/base/dd.c                                                             |    7 
 drivers/base/firmware_loader/main.c                                           |    3 
 drivers/base/firmware_loader/sysfs_upload.c                                   |    8 
 drivers/base/power/main.c                                                     |    6 
 drivers/base/property.c                                                       |    4 
 drivers/block/drbd/drbd_receiver.c                                            |    5 
 drivers/bluetooth/bpa10x.c                                                    |    8 
 drivers/bluetooth/btmtksdio.c                                                 |    2 
 drivers/bluetooth/btrtl.c                                                     |    5 
 drivers/bluetooth/btusb.c                                                     |   37 
 drivers/bus/mhi/ep/main.c                                                     |    9 
 drivers/bus/sunxi-rsb.c                                                       |    3 
 drivers/char/hw_random/virtio-rng.c                                           |   23 
 drivers/char/tlclk.c                                                          |    4 
 drivers/char/tpm/eventlog/tpm1.c                                              |    4 
 drivers/char/tpm/tpm-dev.c                                                    |    2 
 drivers/char/tpm/tpm_tis_core.c                                               |   35 
 drivers/char/tpm/tpmrm-dev.c                                                  |    2 
 drivers/clk/at91/pmc.c                                                        |    2 
 drivers/clk/clk-scmi.c                                                        |    4 
 drivers/clk/qcom/a53-pll.c                                                    |    2 
 drivers/clocksource/timer-tegra186.c                                          |    3 
 drivers/cpufreq/cpufreq.c                                                     |    2 
 drivers/cpufreq/cpufreq_conservative.c                                        |   12 
 drivers/cpufreq/intel_pstate.c                                                |    6 
 drivers/cpufreq/pcc-cpufreq.c                                                 |    2 
 drivers/crypto/allwinner/Kconfig                                              |    8 
 drivers/crypto/allwinner/sun4i-ss/Makefile                                    |    1 
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c                             |   36 
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c                             |   69 
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h                                  |   20 
 drivers/crypto/amcc/crypto4xx_alg.c                                           |  106 
 drivers/crypto/amcc/crypto4xx_core.c                                          |  130 
 drivers/crypto/amcc/crypto4xx_core.h                                          |   11 
 drivers/crypto/amcc/crypto4xx_reg_def.h                                       |   11 
 drivers/crypto/amlogic/amlogic-gxl-core.c                                     |    2 
 drivers/crypto/atmel-ecc.c                                                    |    2 
 drivers/crypto/atmel-sha204a.c                                                |   31 
 drivers/crypto/caam/caamalg.c                                                 |   12 
 drivers/crypto/caam/caamalg_qi.c                                              |   12 
 drivers/crypto/caam/caamalg_qi2.c                                             |   12 
 drivers/crypto/caam/caamhash.c                                                |    4 
 drivers/crypto/caam/key_gen.c                                                 |    4 
 drivers/crypto/cavium/cpt/cptvf_reqmanager.c                                  |    4 
 drivers/crypto/ccp/sev-dev.c                                                  |    3 
 drivers/crypto/hisilicon/Kconfig                                              |    1 
 drivers/crypto/hisilicon/qm.c                                                 |    4 
 drivers/crypto/hisilicon/trng/trng.c                                          |  298 --
 drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c                            |    4 
 drivers/crypto/qat/qat_common/adf_accel_devices.h                             |    2 
 drivers/crypto/qat/qat_common/adf_aer.c                                       |    7 
 drivers/crypto/qat/qat_common/adf_common_drv.h                                |    2 
 drivers/crypto/qat/qat_common/adf_isr.c                                       |   39 
 drivers/crypto/qat/qat_common/adf_sriov.c                                     |   20 
 drivers/crypto/qat/qat_common/qat_asym_algs.c                                 |   10 
 drivers/crypto/talitos.c                                                      |  213 +
 drivers/crypto/talitos.h                                                      |    2 
 drivers/dax/kmem.c                                                            |    6 
 drivers/dma-buf/udmabuf.c                                                     |    5 
 drivers/dma/dmaengine.c                                                       |    3 
 drivers/dma/dw-edma/dw-edma-core.h                                            |    2 
 drivers/dma/dw-edma/dw-edma-v0-core.c                                         |    6 
 drivers/dma/imx-sdma.c                                                        |    4 
 drivers/dma/qcom/gpi.c                                                        |    1 
 drivers/dma/tegra186-gpc-dma.c                                                |    7 
 drivers/edac/i10nm_base.c                                                     |   14 
 drivers/edac/skx_common.c                                                     |    3 
 drivers/firmware/arm_scmi/power.c                                             |    6 
 drivers/firmware/arm_scmi/sensors.c                                           |    2 
 drivers/firmware/efi/efi.c                                                    |    1 
 drivers/firmware/efi/vars.c                                                   |   12 
 drivers/fpga/microchip-spi.c                                                  |    3 
 drivers/gpio/gpio-eic-sprd.c                                                  |    8 
 drivers/gpio/gpio-f7188x.c                                                    |    6 
 drivers/gpio/gpio-htc-egpio.c                                                 |    6 
 drivers/gpio/gpio-mvebu.c                                                     |    5 
 drivers/gpio/gpio-palmas.c                                                    |   19 
 drivers/gpio/gpio-sch.c                                                       |   32 
 drivers/gpio/gpio-timberdale.c                                                |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                              |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                    |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c                                       |   25 
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c                                       |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                      |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_events.c                                       |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                          |    1 
 drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c                 |    2 
 drivers/gpu/drm/drm_edid.c                                                    |    8 
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c                                |   80 
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c                               |   11 
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c                              |   22 
 drivers/gpu/drm/i915/gt/intel_region_lmem.c                                   |    2 
 drivers/gpu/drm/msm/dp/dp_display.c                                           |    4 
 drivers/gpu/drm/msm/dp/dp_reg.h                                               |    4 
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowramin.c                        |    3 
 drivers/gpu/drm/radeon/radeon_ring.c                                          |    4 
 drivers/gpu/drm/tegra/dc.c                                                    |    4 
 drivers/gpu/drm/tegra/gem.c                                                   |   22 
 drivers/gpu/drm/tegra/submit.c                                                |    3 
 drivers/gpu/drm/tidss/tidss_kms.c                                             |    2 
 drivers/gpu/host1x/bus.c                                                      |   62 
 drivers/gpu/host1x/job.c                                                      |   10 
 drivers/hid/hid-appleir.c                                                     |   45 
 drivers/hid/hid-core.c                                                        |    7 
 drivers/hid/hid-letsketch.c                                                   |   36 
 drivers/hid/hid-lg-g15.c                                                      |   16 
 drivers/hid/hid-logitech-hidpp.c                                              |    1 
 drivers/hid/hid-multitouch.c                                                  |   32 
 drivers/hid/hid-picolcd_core.c                                                |    3 
 drivers/hid/hid-sensor-hub.c                                                  |   77 
 drivers/hid/wacom_sys.c                                                       |   12 
 drivers/hwmon/Kconfig                                                         |    1 
 drivers/hwmon/asus_atk0110.c                                                  |    3 
 drivers/hwmon/occ/common.c                                                    |   34 
 drivers/hwmon/occ/common.h                                                    |    1 
 drivers/hwmon/pmbus/adm1275.c                                                 |    2 
 drivers/hwmon/w83627hf.c                                                      |    4 
 drivers/hwmon/w83793.c                                                        |    1 
 drivers/hwspinlock/qcom_hwspinlock.c                                          |    5 
 drivers/hwtracing/coresight/coresight-cti-platform.c                          |    1 
 drivers/hwtracing/coresight/coresight-etb10.c                                 |    6 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                            |    4 
 drivers/i2c/busses/i2c-mlxbf.c                                                |    4 
 drivers/i2c/busses/i2c-mt65xx.c                                               |    2 
 drivers/i2c/busses/i2c-stm32f7.c                                              |    9 
 drivers/i2c/i2c-core-base.c                                                   |   83 
 drivers/i3c/master.c                                                          |   19 
 drivers/iio/accel/bmc150-accel-core.c                                         |    2 
 drivers/iio/accel/kxsd9.c                                                     |    5 
 drivers/iio/accel/mma8452.c                                                   |    2 
 drivers/iio/adc/lpc32xx_adc.c                                                 |    4 
 drivers/iio/adc/spear_adc.c                                                   |    3 
 drivers/iio/adc/ti-ads124s08.c                                                |    3 
 drivers/iio/adc/xilinx-ams.c                                                  |    5 
 drivers/iio/chemical/scd30_core.c                                             |   19 
 drivers/iio/common/Kconfig                                                    |    1 
 drivers/iio/common/Makefile                                                   |    1 
 drivers/iio/common/inv_sensors/Kconfig                                        |    7 
 drivers/iio/common/inv_sensors/Makefile                                       |    6 
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c                        |  191 +
 drivers/iio/common/st_sensors/st_sensors_core.c                               |   23 
 drivers/iio/gyro/bmg160_core.c                                                |   16 
 drivers/iio/imu/adis_trigger.c                                                |    2 
 drivers/iio/imu/bmi160/bmi160_core.c                                          |    3 
 drivers/iio/imu/inv_icm42600/Kconfig                                          |    1 
 drivers/iio/imu/inv_icm42600/Makefile                                         |    1 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c                             |   35 
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c                            |   61 
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h                            |    3 
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c                              |   24 
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c                              |   35 
 drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c                         |  195 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h                         |   85 
 drivers/iio/imu/inv_mpu6050/Kconfig                                           |    1 
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c                                    |   30 
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h                                     |   18 
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c                                    |   83 
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c                                 |   11 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c                                  |   21 
 drivers/iio/industrialio-event.c                                              |    5 
 drivers/iio/light/al3010.c                                                    |    2 
 drivers/iio/light/gp2ap002.c                                                  |    2 
 drivers/iio/light/opt3001.c                                                   |    6 
 drivers/iio/light/si1133.c                                                    |   14 
 drivers/iio/light/tsl2591.c                                                   |    6 
 drivers/iio/light/veml6030.c                                                  |    8 
 drivers/iio/magnetometer/ak8975.c                                             |   15 
 drivers/iio/orientation/hid-sensor-rotation.c                                 |   40 
 drivers/iio/temperature/ltc2983.c                                             |    5 
 drivers/infiniband/core/cm.c                                                  |   13 
 drivers/infiniband/core/counters.c                                            |    2 
 drivers/infiniband/hw/hns/hns_roce_hem.c                                      |    8 
 drivers/infiniband/hw/hns/hns_roce_main.c                                     |    2 
 drivers/infiniband/hw/irdma/verbs.c                                           |   18 
 drivers/infiniband/hw/irdma/verbs.h                                           |    1 
 drivers/infiniband/hw/mlx4/mlx4_ib.h                                          |    1 
 drivers/infiniband/hw/mlx4/mr.c                                               |    9 
 drivers/infiniband/hw/mlx4/sysfs.c                                            |   45 
 drivers/infiniband/hw/mlx5/devx.c                                             |   30 
 drivers/infiniband/hw/mlx5/main.c                                             |    2 
 drivers/infiniband/hw/mlx5/mr.c                                               |   17 
 drivers/infiniband/hw/mlx5/qp.c                                               |   12 
 drivers/infiniband/sw/rxe/rxe_resp.c                                          |   33 
 drivers/infiniband/sw/siw/siw_qp_rx.c                                         |    9 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                                        |    5 
 drivers/infiniband/ulp/srpt/ib_srpt.c                                         |    5 
 drivers/input/joystick/iforce/iforce-packets.c                                |   18 
 drivers/input/joystick/maplecontrol.c                                         |    3 
 drivers/input/keyboard/maple_keyb.c                                           |    4 
 drivers/input/misc/ims-pcu.c                                                  |  117 
 drivers/input/mouse/elan_i2c_core.c                                           |   36 
 drivers/input/mouse/maplemouse.c                                              |    9 
 drivers/input/rmi4/rmi_bus.c                                                  |    4 
 drivers/input/rmi4/rmi_f30.c                                                  |    2 
 drivers/input/rmi4/rmi_f3a.c                                                  |    2 
 drivers/input/touchscreen/goodix.c                                            |    3 
 drivers/input/touchscreen/mms114.c                                            |    2 
 drivers/input/touchscreen/touchwin.c                                          |   15 
 drivers/iommu/amd/amd_iommu_types.h                                           |   11 
 drivers/irqchip/irq-crossbar.c                                                |   10 
 drivers/irqchip/irq-gic-v3-its.c                                              |    6 
 drivers/irqchip/irq-ts4800.c                                                  |   10 
 drivers/leds/uleds.c                                                          |    3 
 drivers/mailbox/mtk-adsp-mailbox.c                                            |    9 
 drivers/md/dm-bufio.c                                                         |    4 
 drivers/md/dm-era-target.c                                                    |   10 
 drivers/md/dm-ioctl.c                                                         |    7 
 drivers/md/dm-log.c                                                           |    3 
 drivers/md/dm-stats.c                                                         |   10 
 drivers/md/dm-thin-metadata.c                                                 |   67 
 drivers/md/dm-verity-loadpin.c                                                |    2 
 drivers/md/dm-verity-target.c                                                 |    2 
 drivers/md/raid1.c                                                            |    6 
 drivers/md/raid10.c                                                           |    1 
 drivers/media/platform/qcom/venus/helpers.c                                   |    4 
 drivers/media/platform/qcom/venus/hfi_platform_v4.c                           |   20 
 drivers/media/platform/qcom/venus/hfi_platform_v6.c                           |   16 
 drivers/media/platform/rockchip/rga/rga-hw.c                                  |    2 
 drivers/media/platform/rockchip/rga/rga-hw.h                                  |    2 
 drivers/media/usb/uvc/uvc_video.c                                             |   30 
 drivers/memstick/core/ms_block.c                                              |    4 
 drivers/mfd/cros_ec_dev.c                                                     |    3 
 drivers/mfd/sm501.c                                                           |    4 
 drivers/mfd/tps6586x.c                                                        |    2 
 drivers/mmc/host/vub300.c                                                     |   26 
 drivers/mtd/devices/mchp23k256.c                                              |    2 
 drivers/mtd/devices/slram.c                                                   |   22 
 drivers/mtd/maps/vmu-flash.c                                                  |    1 
 drivers/mtd/nand/onenand/onenand_samsung.c                                    |    7 
 drivers/mtd/nand/raw/fsl_ifc_nand.c                                           |    9 
 drivers/mtd/nand/raw/lpc32xx_mlc.c                                            |   12 
 drivers/mtd/nand/raw/lpc32xx_slc.c                                            |   12 
 drivers/mtd/nand/raw/nand_base.c                                              |    2 
 drivers/mtd/nand/raw/pl35x-nand-controller.c                                  |    2 
 drivers/mtd/spi-nor/Kconfig                                                   |    1 
 drivers/mtd/spi-nor/swp.c                                                     |   11 
 drivers/net/amt.c                                                             |    6 
 drivers/net/bonding/bond_3ad.c                                                |    1 
 drivers/net/can/usb/esd_usb.c                                                 |    5 
 drivers/net/dsa/sja1105/sja1105_ptp.c                                         |    2 
 drivers/net/ethernet/amazon/ena/ena_netdev.c                                  |   23 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c                               |    3 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                                |   23 
 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c                       |   18 
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c                                    |    8 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c                           |    2 
 drivers/net/ethernet/freescale/enetc/enetc.c                                  |    7 
 drivers/net/ethernet/freescale/fman/fman.c                                    |    4 
 drivers/net/ethernet/freescale/gianfar.c                                      |   16 
 drivers/net/ethernet/intel/ice/ice_common.c                                   |    1 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                                  |   12 
 drivers/net/ethernet/intel/ice/ice_vf_lib.c                                   |    2 
 drivers/net/ethernet/marvell/mvneta.c                                         |    3 
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c                               |    6 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c                       |    3 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                           |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c                     |   10 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                          |   44 
 drivers/net/ethernet/marvell/prestera/prestera_main.c                         |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c                    |   29 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c                     |   47 
 drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c                         |    8 
 drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.h                         |    6 
 drivers/net/ethernet/mellanox/mlx5/core/lib/port_tun.c                        |    3 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                                |   12 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c                         |    1 
 drivers/net/ethernet/microchip/lan743x_main.c                                 |    2 
 drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c                      |    4 
 drivers/net/ethernet/microsoft/mana/gdma_main.c                               |    2 
 drivers/net/ethernet/microsoft/mana/mana_en.c                                 |    3 
 drivers/net/ethernet/qlogic/qede/qede_fp.c                                    |    9 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c                            |    5 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h                            |   20 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c                          |   23 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h                               |    7 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c                          |  263 +
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c                               |    9 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.h                               |    1 
 drivers/net/ethernet/sun/sungem.c                                             |   13 
 drivers/net/ieee802154/ca8210.c                                               |    9 
 drivers/net/macsec.c                                                          |    9 
 drivers/net/phy/sfp.c                                                         |    1 
 drivers/net/usb/gl620a.c                                                      |    6 
 drivers/net/usb/kalmia.c                                                      |    8 
 drivers/net/usb/lan78xx.c                                                     |  318 +-
 drivers/net/usb/net1080.c                                                     |    2 
 drivers/net/veth.c                                                            |    2 
 drivers/net/virtio_net.c                                                      |   55 
 drivers/net/vxlan/vxlan_core.c                                                |    8 
 drivers/net/wan/ixp4xx_hss.c                                                  |    4 
 drivers/net/wireless/ath/ath9k/xmit.c                                         |    5 
 drivers/net/wireless/ath/wcn36xx/smd.c                                        |   13 
 drivers/net/wireless/marvell/mwifiex/join.c                                   |    1 
 drivers/net/wireless/mediatek/mt76/mac80211.c                                 |    2 
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c                                |   12 
 drivers/net/wireless/realtek/rtw88/pci.c                                      |    5 
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c                                    |   40 
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c                                        |    3 
 drivers/ntb/hw/epf/ntb_hw_epf.c                                               |   89 
 drivers/nvdimm/btt.c                                                          |   14 
 drivers/nvdimm/nd.h                                                           |   11 
 drivers/nvdimm/region_devs.c                                                  |   66 
 drivers/nvme/host/core.c                                                      |    2 
 drivers/nvme/host/multipath.c                                                 |    6 
 drivers/nvme/target/fabrics-cmd.c                                             |    4 
 drivers/nvme/target/rdma.c                                                    |   18 
 drivers/nvme/target/tcp.c                                                     |   34 
 drivers/pci/Makefile                                                          |    2 
 drivers/pci/controller/dwc/pci-imx6.c                                         |    5 
 drivers/pci/controller/dwc/pcie-designware-host.c                             |    2 
 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c                          |    8 
 drivers/pci/controller/pci-host-common.c                                      |    4 
 drivers/pci/controller/pci-loongson.c                                         |   31 
 drivers/pci/controller/pcie-altera-msi.c                                      |    2 
 drivers/pci/controller/pcie-altera.c                                          |   32 
 drivers/pci/controller/pcie-iproc-bcma.c                                      |    2 
 drivers/pci/controller/pcie-iproc-platform.c                                  |    2 
 drivers/pci/controller/pcie-iproc.c                                           |    1 
 drivers/pci/controller/pcie-iproc.h                                           |    2 
 drivers/pci/controller/pcie-mediatek-gen3.c                                   |    4 
 drivers/pci/controller/pcie-mediatek.c                                        |  130 
 drivers/pci/controller/pcie-rcar-host.c                                       |    1 
 drivers/pci/controller/pcie-xilinx-nwl.c                                      |    2 
 drivers/pci/endpoint/functions/pci-epf-ntb.c                                  |   21 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                                 |    9 
 drivers/pci/msi/msi.c                                                         |    4 
 drivers/pci/pci-sysfs.c                                                       |   14 
 drivers/pci/pci.c                                                             |  139 
 drivers/pci/pci.h                                                             |    7 
 drivers/pci/rebar.c                                                           |  218 +
 drivers/pci/rom.c                                                             |  149 -
 drivers/pci/setup-bus.c                                                       |  104 
 drivers/pci/setup-res.c                                                       |   53 
 drivers/phy/phy-can-transceiver.c                                             |    3 
 drivers/pinctrl/mediatek/pinctrl-mt8167.c                                     |    2 
 drivers/pinctrl/mediatek/pinctrl-mt8516.c                                     |    2 
 drivers/pinctrl/meson/pinctrl-meson.c                                         |    2 
 drivers/pinctrl/sunxi/pinctrl-sunxi.c                                         |    2 
 drivers/platform/x86/xo15-ebook.c                                             |    7 
 drivers/power/supply/charger-manager.c                                        |    6 
 drivers/power/supply/cpcap-battery.c                                          |   11 
 drivers/power/supply/power_supply_core.c                                      |   11 
 drivers/pwm/pwm-imx27.c                                                       |    8 
 drivers/rapidio/devices/tsi721.c                                              |    3 
 drivers/regulator/core.c                                                      |   33 
 drivers/regulator/ltc3676.c                                                   |   10 
 drivers/regulator/scmi-regulator.c                                            |    6 
 drivers/reset/reset-sunxi.c                                                   |    4 
 drivers/rpmsg/rpmsg_char.c                                                    |   12 
 drivers/rtc/rtc-abx80x.c                                                      |    3 
 drivers/rtc/rtc-cmos.c                                                        |    6 
 drivers/rtc/rtc-ds1307.c                                                      |   30 
 drivers/rtc/rtc-mpfs.c                                                        |    2 
 drivers/rtc/rtc-msc313.c                                                      |    4 
 drivers/s390/char/monwriter.c                                                 |    3 
 drivers/scsi/elx/efct/efct_hw.c                                               |    2 
 drivers/scsi/elx/efct/efct_unsol.c                                            |    1 
 drivers/scsi/hpsa.c                                                           |    4 
 drivers/scsi/lpfc/lpfc_init.c                                                 |    3 
 drivers/scsi/pm8001/pm8001_ctl.c                                              |    5 
 drivers/scsi/scsi_scan.c                                                      |    2 
 drivers/scsi/scsi_transport_sas.c                                             |  101 
 drivers/scsi/sg.c                                                             |    7 
 drivers/scsi/smartpqi/smartpqi_init.c                                         |    2 
 drivers/slimbus/qcom-ctrl.c                                                   |    5 
 drivers/slimbus/qcom-ngd-ctrl.c                                               |  100 
 drivers/soc/fsl/qe/qe.c                                                       |    3 
 drivers/soc/ti/k3-ringacc.c                                                   |    4 
 drivers/spi/spi-dw.h                                                          |    1 
 drivers/spi/spi-ep93xx.c                                                      |    1 
 drivers/spi/spi-fsl-lpspi.c                                                   |   18 
 drivers/spi/spi-rpc-if.c                                                      |    6 
 drivers/spi/spi-sh-msiof.c                                                    |   10 
 drivers/spi/spi-uniphier.c                                                    |    4 
 drivers/spi/spi-xilinx.c                                                      |   11 
 drivers/staging/media/atomisp/pci/atomisp_cmd.c                               |    6 
 drivers/staging/media/atomisp/pci/sh_css.c                                    |    6 
 drivers/staging/media/ipu3/ipu3-css-params.c                                  |    8 
 drivers/staging/media/sunxi/cedrus/cedrus.c                                   |    4 
 drivers/staging/most/video/video.c                                            |    7 
 drivers/staging/nvec/nvec.c                                                   |    4 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c                                |   93 
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c                                 |   20 
 drivers/staging/rtl8723bs/core/rtw_security.c                                 |    2 
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c                                |   23 
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c                             |   88 
 drivers/staging/vme_user/vme_fake.c                                           |    8 
 drivers/staging/vme_user/vme_tsi148.c                                         |    8 
 drivers/staging/vme_user/vme_user.c                                           |   22 
 drivers/target/iscsi/iscsi_target_auth.c                                      |    6 
 drivers/target/target_core_fabric_lib.c                                       |   89 
 drivers/target/target_core_internal.h                                         |    3 
 drivers/target/target_core_pr.c                                               |   12 
 drivers/thermal/intel/therm_throt.c                                           |    7 
 drivers/thermal/thermal_hwmon.c                                               |    5 
 drivers/tty/serial/8250/8250_mid.c                                            |   31 
 drivers/tty/serial/8250/8250_omap.c                                           |    3 
 drivers/tty/serial/msm_serial.c                                               |    3 
 drivers/usb/atm/ueagle-atm.c                                                  |   36 
 drivers/usb/cdns3/cdnsp-mem.c                                                 |    2 
 drivers/usb/class/cdc-acm.c                                                   |    3 
 drivers/usb/common/ulpi.c                                                     |   23 
 drivers/usb/core/quirks.c                                                     |    6 
 drivers/usb/dwc3/dwc3-meson-g12a.c                                            |   14 
 drivers/usb/dwc3/gadget.c                                                     |   43 
 drivers/usb/gadget/composite.c                                                |    5 
 drivers/usb/gadget/function/f_fs.c                                            |    5 
 drivers/usb/gadget/function/rndis.c                                           |   20 
 drivers/usb/gadget/udc/core.c                                                 |   29 
 drivers/usb/host/max3421-hcd.c                                                |    8 
 drivers/usb/host/sl811-hcd.c                                                  |    1 
 drivers/usb/host/xhci.c                                                       |   11 
 drivers/usb/misc/chaoskey.c                                                   |    1 
 drivers/usb/misc/idmouse.c                                                    |   45 
 drivers/usb/misc/iowarrior.c                                                  |   21 
 drivers/usb/misc/ldusb.c                                                      |   38 
 drivers/usb/misc/legousbtower.c                                               |   37 
 drivers/usb/misc/uss720.c                                                     |    5 
 drivers/usb/mtu3/mtu3_gadget.c                                                |    1 
 drivers/usb/serial/digi_acceleport.c                                          |   43 
 drivers/usb/serial/keyspan_pda.c                                              |    2 
 drivers/usb/serial/option.c                                                   |   16 
 drivers/usb/storage/ene_ub6250.c                                              |    3 
 drivers/usb/storage/usb.c                                                     |    2 
 drivers/usb/typec/anx7411.c                                                   |    4 
 drivers/usb/typec/class.c                                                     |    1 
 drivers/usb/typec/tcpm/tcpm.c                                                 |    7 
 drivers/usb/typec/ucsi/displayport.c                                          |    7 
 drivers/usb/typec/ucsi/ucsi.c                                                 |   20 
 drivers/usb/typec/ucsi/ucsi.h                                                 |    1 
 drivers/usb/typec/ucsi/ucsi_acpi.c                                            |   10 
 drivers/usb/typec/ucsi/ucsi_ccg.c                                             |    2 
 drivers/usb/usbip/vudc.h                                                      |    1 
 drivers/usb/usbip/vudc_dev.c                                                  |    4 
 drivers/vdpa/vdpa_user/vduse_dev.c                                            |   64 
 drivers/vfio/pci/mlx5/cmd.h                                                   |   13 
 drivers/vfio/pci/vfio_pci_core.c                                              |   37 
 drivers/vhost/net.c                                                           |   15 
 drivers/vhost/vdpa.c                                                          |   29 
 drivers/video/fbdev/aty/radeon_base.c                                         |    1 
 drivers/video/fbdev/broadsheetfb.c                                            |    8 
 drivers/video/fbdev/carminefb.c                                               |    1 
 drivers/video/fbdev/core/fbcon.c                                              |   14 
 drivers/video/fbdev/hecubafb.c                                                |    6 
 drivers/video/fbdev/i740fb.c                                                  |    1 
 drivers/video/fbdev/metronomefb.c                                             |    8 
 drivers/video/fbdev/nvidia/nvidia.c                                           |    1 
 drivers/video/fbdev/s3fb.c                                                    |    1 
 drivers/video/fbdev/sm501fb.c                                                 |   16 
 drivers/video/fbdev/sm712.h                                                   |    2 
 drivers/video/fbdev/tdfxfb.c                                                  |    1 
 drivers/video/fbdev/tridentfb.c                                               |    1 
 drivers/video/fbdev/uvesafb.c                                                 |    4 
 drivers/virtio/virtio_mmio.c                                                  |   26 
 drivers/virtio/virtio_ring.c                                                  |  196 +
 drivers/watchdog/apple_wdt.c                                                  |    1 
 drivers/watchdog/sp5100_tco.c                                                 |    3 
 drivers/watchdog/sprd_wdt.c                                                   |    5 
 drivers/watchdog/watchdog_core.c                                              |    3 
 drivers/xen/gntdev.c                                                          |    8 
 drivers/xen/xen-scsiback.c                                                    |   30 
 fs/afs/cell.c                                                                 |    2 
 fs/afs/cmservice.c                                                            |    2 
 fs/afs/fs_operation.c                                                         |    2 
 fs/afs/rxrpc.c                                                                |   11 
 fs/afs/super.c                                                                |    3 
 fs/afs/vl_list.c                                                              |   10 
 fs/afs/volume.c                                                               |    2 
 fs/btrfs/ctree.h                                                              |    2 
 fs/btrfs/extent-tree.c                                                        |   17 
 fs/btrfs/file.c                                                               |   12 
 fs/btrfs/inode.c                                                              |  149 -
 fs/btrfs/ordered-data.c                                                       |   12 
 fs/btrfs/ordered-data.h                                                       |    2 
 fs/btrfs/reflink.c                                                            |    5 
 fs/btrfs/super.c                                                              |    3 
 fs/configfs/dir.c                                                             |   57 
 fs/efivarfs/super.c                                                           |   45 
 fs/efs/file.c                                                                 |   21 
 fs/eventpoll.c                                                                |  152 -
 fs/exfat/dir.c                                                                |   13 
 fs/ext4/ioctl.c                                                               |   12 
 fs/f2fs/checkpoint.c                                                          |   14 
 fs/f2fs/data.c                                                                |   45 
 fs/f2fs/f2fs.h                                                                |    1 
 fs/f2fs/inode.c                                                               |   13 
 fs/f2fs/segment.c                                                             |    8 
 fs/f2fs/xattr.c                                                               |    7 
 fs/fs-writeback.c                                                             |  133 
 fs/fuse/cuse.c                                                                |    4 
 fs/fuse/dev.c                                                                 |    2 
 fs/hfs/bfind.c                                                                |    2 
 fs/hfs/bnode.c                                                                |   56 
 fs/hfs/brec.c                                                                 |    2 
 fs/hfs/btree.c                                                                |    2 
 fs/hfs/btree.h                                                                |   71 
 fs/hfs/hfs_fs.h                                                               |   88 
 fs/hfs/inode.c                                                                |    3 
 fs/hfsplus/bfind.c                                                            |    2 
 fs/hfsplus/bnode.c                                                            |   62 
 fs/hfsplus/brec.c                                                             |    2 
 fs/hfsplus/btree.c                                                            |    2 
 fs/hfsplus/hfsplus_fs.h                                                       |   40 
 fs/isofs/rock.c                                                               |   11 
 fs/jbd2/journal.c                                                             |    2 
 fs/lockd/svcsubs.c                                                            |    4 
 fs/nfs/callback_proc.c                                                        |    9 
 fs/nfs/dir.c                                                                  |    2 
 fs/nfs/filelayout/filelayout.c                                                |    2 
 fs/nfs/flexfilelayout/flexfilelayout.c                                        |   33 
 fs/nfs/flexfilelayout/flexfilelayout.h                                        |   16 
 fs/nfs/pnfs.c                                                                 |    4 
 fs/nfsd/nfs4layouts.c                                                         |    4 
 fs/nfsd/nfs4recover.c                                                         |  120 
 fs/nfsd/nfs4state.c                                                           |   22 
 fs/nfsd/vfs.c                                                                 |   42 
 fs/nilfs2/segment.c                                                           |   22 
 fs/ntfs3/fslog.c                                                              |  106 
 fs/ntfs3/index.c                                                              |   31 
 fs/ntfs3/lznt.c                                                               |    2 
 fs/ntfs3/namei.c                                                              |    2 
 fs/ntfs3/ntfs_fs.h                                                            |    3 
 fs/ntfs3/run.c                                                                |    9 
 fs/ocfs2/alloc.c                                                              |    2 
 fs/ocfs2/aops.c                                                               |   13 
 fs/ocfs2/buffer_head_io.c                                                     |    7 
 fs/ocfs2/dlm/dlmdebug.c                                                       |   16 
 fs/ocfs2/dlmglue.c                                                            |   17 
 fs/ocfs2/inode.c                                                              |  150 +
 fs/ocfs2/journal.c                                                            |   13 
 fs/ocfs2/journal.h                                                            |    3 
 fs/ocfs2/move_extents.c                                                       |    4 
 fs/ocfs2/ocfs2.h                                                              |    2 
 fs/ocfs2/quota_local.c                                                        |    2 
 fs/ocfs2/stack_user.c                                                         |   10 
 fs/ocfs2/super.c                                                              |    2 
 fs/ocfs2/sysfile.c                                                            |    9 
 fs/orangefs/dir.c                                                             |    7 
 fs/proc/array.c                                                               |   15 
 fs/proc/base.c                                                                |  182 -
 fs/proc/fd.c                                                                  |   73 
 fs/proc/generic.c                                                             |    9 
 fs/proc/internal.h                                                            |    6 
 fs/proc/namespaces.c                                                          |   16 
 fs/proc/proc_net.c                                                            |    1 
 fs/quota/dquot.c                                                              |   10 
 fs/smb/client/cifs_swn.c                                                      |  327 +-
 fs/smb/client/cifsacl.c                                                       |    2 
 fs/smb/client/cifsfs.c                                                        |    2 
 fs/smb/client/cifsglob.h                                                      |   44 
 fs/smb/client/cifsproto.h                                                     |   10 
 fs/smb/client/connect.c                                                       |   38 
 fs/smb/client/dfs_cache.c                                                     |    2 
 fs/smb/client/fscache.c                                                       |   20 
 fs/smb/client/ioctl.c                                                         |   12 
 fs/smb/client/misc.c                                                          |   23 
 fs/smb/client/sess.c                                                          |   69 
 fs/smb/client/smb2misc.c                                                      |   62 
 fs/smb/client/smb2ops.c                                                       |   55 
 fs/smb/client/smb2pdu.c                                                       |   92 
 fs/smb/client/smb2transport.c                                                 |    2 
 fs/smb/client/trace.h                                                         |   95 
 fs/smb/client/transport.c                                                     |    2 
 fs/smb/common/cifsglob.h                                                      |   61 
 fs/smb/server/connection.c                                                    |   49 
 fs/smb/server/connection.h                                                    |    3 
 fs/smb/server/oplock.c                                                        |   10 
 fs/smb/server/smb2misc.c                                                      |    2 
 fs/smb/server/smb2ops.c                                                       |   28 
 fs/smb/server/smb2pdu.c                                                       |  146 -
 fs/smb/server/smb_common.h                                                    |   43 
 fs/smb/server/vfs.c                                                           |   20 
 fs/smb/server/vfs_cache.c                                                     |   31 
 fs/smb/server/vfs_cache.h                                                     |    3 
 fs/sysfs/file.c                                                               |    4 
 fs/udf/balloc.c                                                               |    5 
 fs/udf/super.c                                                                |   11 
 fs/userfaultfd.c                                                              |   14 
 fs/xfs/xfs_dquot.c                                                            |   16 
 fs/xfs/xfs_log_recover.c                                                      |   15 
 fs/xfs/xfs_reflink.c                                                          |   36 
 include/crypto/drbg.h                                                         |   18 
 include/dt-bindings/power/fsl,imx93-power.h                                   |    1 
 include/linux/audit.h                                                         |    8 
 include/linux/backing-dev-defs.h                                              |    4 
 include/linux/bitops.h                                                        |    2 
 include/linux/bpf.h                                                           |    3 
 include/linux/bpf_local_storage.h                                             |    3 
 include/linux/damon.h                                                         |    8 
 include/linux/device.h                                                        |    5 
 include/linux/efi.h                                                           |   11 
 include/linux/f2fs_fs.h                                                       |    3 
 include/linux/file.h                                                          |    2 
 include/linux/fwnode.h                                                        |    2 
 include/linux/glob.h                                                          |    1 
 include/linux/hid-sensor-hub.h                                                |   25 
 include/linux/hid.h                                                           |   29 
 include/linux/host1x.h                                                        |    7 
 include/linux/iio/common/inv_sensors_timestamp.h                              |   94 
 include/linux/jiffies.h                                                       |   13 
 include/linux/pci.h                                                           |    4 
 include/linux/seqlock.h                                                       |  110 
 include/linux/sunrpc/xprt.h                                                   |    2 
 include/linux/vfio_pci_core.h                                                 |   24 
 include/linux/virtio.h                                                        |   18 
 include/linux/vmalloc.h                                                       |    4 
 include/linux/writeback.h                                                     |    2 
 include/net/addrconf.h                                                        |   10 
 include/net/bluetooth/hci.h                                                   |   19 
 include/net/bluetooth/hci_core.h                                              |    9 
 include/net/bluetooth/l2cap.h                                                 |   54 
 include/net/fib_rules.h                                                       |    5 
 include/net/gue.h                                                             |    2 
 include/net/ip_fib.h                                                          |    7 
 include/net/ip_vs.h                                                           |    3 
 include/net/netfilter/nf_queue.h                                              |    1 
 include/net/rtnetlink.h                                                       |    2 
 include/net/sctp/sctp.h                                                       |    3 
 include/net/sock.h                                                            |    2 
 include/net/xfrm.h                                                            |   22 
 include/sound/asequencer.h                                                    |    4 
 include/sound/seq_kernel.h                                                    |    8 
 include/uapi/linux/bpf.h                                                      |    1 
 include/uapi/linux/xfrm.h                                                     |    6 
 include/uapi/sound/asequencer.h                                               |   54 
 io_uring/io-wq.c                                                              |    2 
 kernel/audit.c                                                                |   85 
 kernel/bpf/bpf_lsm.c                                                          |   34 
 kernel/bpf/cgroup.c                                                           |    2 
 kernel/bpf/core.c                                                             |    2 
 kernel/bpf/devmap.c                                                           |   19 
 kernel/bpf/hashtab.c                                                          |   21 
 kernel/bpf/helpers.c                                                          |   12 
 kernel/bpf/inode.c                                                            |   13 
 kernel/bpf/lpm_trie.c                                                         |   10 
 kernel/bpf/syscall.c                                                          |    5 
 kernel/bpf/verifier.c                                                         |    3 
 kernel/cgroup/cpuset.c                                                        |    7 
 kernel/cpu.c                                                                  |   20 
 kernel/module/decompress.c                                                    |    2 
 kernel/sched/core.c                                                           |    1 
 kernel/sched/fair.c                                                           |    2 
 kernel/sched/features.h                                                       |    8 
 kernel/time/posix-cpu-timers.c                                                |    3 
 kernel/time/time.c                                                            |    2 
 kernel/trace/bpf_trace.c                                                      |   11 
 kernel/trace/ring_buffer.c                                                    |    3 
 kernel/trace/trace_eprobe.c                                                   |    2 
 kernel/trace/trace_events_filter.c                                            |    6 
 kernel/trace/trace_probe.c                                                    |    3 
 kernel/trace/trace_probe.h                                                    |    2 
 kernel/workqueue.c                                                            |    2 
 lib/debugobjects.c                                                            |   17 
 lib/glob.c                                                                    |   31 
 lib/test_meminit.c                                                            |    2 
 mm/backing-dev.c                                                              |    5 
 mm/damon/core.c                                                               |    2 
 mm/damon/ops-common.c                                                         |    1 
 mm/damon/reclaim.c                                                            |    2 
 mm/damon/sysfs.c                                                              |    9 
 mm/shrinker_debug.c                                                           |   30 
 mm/vmscan.c                                                                   |    6 
 net/6lowpan/nhc.c                                                             |    2 
 net/9p/client.c                                                               |    2 
 net/9p/trans_rdma.c                                                           |   19 
 net/atm/common.c                                                              |    2 
 net/batman-adv/distributed-arp-table.c                                        |   30 
 net/batman-adv/fragmentation.c                                                |    8 
 net/batman-adv/gateway_client.c                                               |    3 
 net/batman-adv/main.c                                                         |   13 
 net/batman-adv/routing.c                                                      |    3 
 net/batman-adv/soft-interface.c                                               |   17 
 net/batman-adv/soft-interface.h                                               |    2 
 net/batman-adv/translation-table.c                                            |    5 
 net/bluetooth/6lowpan.c                                                       |   37 
 net/bluetooth/Kconfig                                                         |    8 
 net/bluetooth/Makefile                                                        |    1 
 net/bluetooth/a2mp.c                                                          | 1054 -------
 net/bluetooth/a2mp.h                                                          |  154 -
 net/bluetooth/af_bluetooth.c                                                  |   17 
 net/bluetooth/amp.c                                                           |  591 ----
 net/bluetooth/amp.h                                                           |   61 
 net/bluetooth/bnep/core.c                                                     |   27 
 net/bluetooth/eir.c                                                           |    8 
 net/bluetooth/hci_codec.c                                                     |    2 
 net/bluetooth/hci_conn.c                                                      |   60 
 net/bluetooth/hci_core.c                                                      |   65 
 net/bluetooth/hci_event.c                                                     |   66 
 net/bluetooth/hci_sync.c                                                      |   24 
 net/bluetooth/iso.c                                                           |   16 
 net/bluetooth/l2cap_core.c                                                    | 1396 +---------
 net/bluetooth/l2cap_sock.c                                                    |  125 
 net/bluetooth/mgmt.c                                                          |   75 
 net/bluetooth/msft.c                                                          |    2 
 net/bluetooth/sco.c                                                           |   60 
 net/bluetooth/smp.c                                                           |   27 
 net/bridge/br_cfm.c                                                           |    6 
 net/bridge/br_cfm_netlink.c                                                   |    4 
 net/bridge/br_if.c                                                            |    3 
 net/bridge/br_stp.c                                                           |    3 
 net/bridge/netfilter/ebtables.c                                               |   22 
 net/bridge/netfilter/nft_meta_bridge.c                                        |    4 
 net/can/bcm.c                                                                 |  127 
 net/can/isotp.c                                                               |    9 
 net/core/fib_rules.c                                                          |    6 
 net/core/filter.c                                                             |   28 
 net/core/flow_dissector.c                                                     |   12 
 net/core/lwt_bpf.c                                                            |   12 
 net/core/rtnetlink.c                                                          |    8 
 net/core/skbuff.c                                                             |   23 
 net/dsa/tag_ksz.c                                                             |   18 
 net/ieee802154/core.c                                                         |    2 
 net/ieee802154/header_ops.c                                                   |    9 
 net/ieee802154/ieee802154.h                                                   |   17 
 net/ieee802154/netlink.c                                                      |   36 
 net/ife/ife.c                                                                 |    2 
 net/ipv4/esp4_offload.c                                                       |    2 
 net/ipv4/igmp.c                                                               |    1 
 net/ipv4/ip_gre.c                                                             |    6 
 net/ipv4/ip_output.c                                                          |    4 
 net/ipv4/ip_vti.c                                                             |    3 
 net/ipv4/ipip.c                                                               |    3 
 net/ipv4/netfilter/nf_reject_ipv4.c                                           |    2 
 net/ipv4/sysctl_net_ipv4.c                                                    |   10 
 net/ipv4/tcp_output.c                                                         |    4 
 net/ipv6/addrconf.c                                                           |   23 
 net/ipv6/esp6_offload.c                                                       |    2 
 net/ipv6/ip6_gre.c                                                            |    6 
 net/ipv6/ip6_vti.c                                                            |    3 
 net/ipv6/mcast.c                                                              |  165 -
 net/ipv6/netfilter.c                                                          |    4 
 net/ipv6/netfilter/ip6t_ah.c                                                  |    5 
 net/ipv6/netfilter/ip6t_hbh.c                                                 |    1 
 net/ipv6/netfilter/ip6t_rt.c                                                  |    3 
 net/ipv6/netfilter/nf_conntrack_reasm.c                                       |    3 
 net/ipv6/route.c                                                              |    9 
 net/ipv6/seg6.c                                                               |    3 
 net/ipv6/sit.c                                                                |    3 
 net/kcm/kcmsock.c                                                             |    8 
 net/key/af_key.c                                                              |    1 
 net/llc/af_llc.c                                                              |    1 
 net/llc/llc_conn.c                                                            |    1 
 net/mac80211/main.c                                                           |    3 
 net/mac80211/tx.c                                                             |   17 
 net/mac802154/iface.c                                                         |    2 
 net/netfilter/ipset/ip_set_core.c                                             |   12 
 net/netfilter/ipset/ip_set_hash_gen.h                                         |   67 
 net/netfilter/ipvs/ip_vs_app.c                                                |   10 
 net/netfilter/ipvs/ip_vs_conn.c                                               |    4 
 net/netfilter/ipvs/ip_vs_core.c                                               |   36 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                                         |   18 
 net/netfilter/ipvs/ip_vs_proto_tcp.c                                          |   11 
 net/netfilter/ipvs/ip_vs_proto_udp.c                                          |    3 
 net/netfilter/nf_conncount.c                                                  |   23 
 net/netfilter/nf_conntrack_core.c                                             |   18 
 net/netfilter/nf_conntrack_ecache.c                                           |    2 
 net/netfilter/nf_conntrack_irc.c                                              |    6 
 net/netfilter/nf_conntrack_netlink.c                                          |    2 
 net/netfilter/nf_conntrack_seqadj.c                                           |    2 
 net/netfilter/nf_nat_core.c                                                   |   10 
 net/netfilter/nf_nat_sip.c                                                    |   11 
 net/netfilter/nf_queue.c                                                      |   14 
 net/netfilter/nfnetlink_cthelper.c                                            |    4 
 net/netfilter/nfnetlink_osf.c                                                 |    6 
 net/netfilter/nfnetlink_queue.c                                               |    3 
 net/netfilter/nft_log.c                                                       |   58 
 net/netfilter/nft_synproxy.c                                                  |    9 
 net/netfilter/xt_AUDIT.c                                                      |   58 
 net/netfilter/xt_cluster.c                                                    |    2 
 net/netfilter/xt_connmark.c                                                   |   14 
 net/netfilter/xt_nat.c                                                        |    9 
 net/netfilter/xt_rateest.c                                                    |    2 
 net/netfilter/xt_u32.c                                                        |   12 
 net/openvswitch/conntrack.c                                                   |    2 
 net/openvswitch/flow_netlink.c                                                |  201 +
 net/psample/psample.c                                                         |    6 
 net/qrtr/af_qrtr.c                                                            |    2 
 net/sched/act_bpf.c                                                           |    2 
 net/sched/act_pedit.c                                                         |   11 
 net/sched/cls_api.c                                                           |    3 
 net/sched/cls_bpf.c                                                           |   10 
 net/sched/cls_flow.c                                                          |   12 
 net/sched/sch_cake.c                                                          |    5 
 net/sched/sch_codel.c                                                         |   48 
 net/sched/sch_drr.c                                                           |    8 
 net/sched/sch_fq_codel.c                                                      |   41 
 net/sched/sch_hfsc.c                                                          |   24 
 net/sched/sch_hhf.c                                                           |   27 
 net/sched/sch_htb.c                                                           |   14 
 net/sched/sch_multiq.c                                                        |    2 
 net/sched/sch_teql.c                                                          |  128 
 net/sctp/diag.c                                                               |   67 
 net/sctp/sm_make_chunk.c                                                      |   10 
 net/sctp/sm_statefuns.c                                                       |   23 
 net/sctp/socket.c                                                             |   29 
 net/smc/smc_cdc.c                                                             |   15 
 net/socket.c                                                                  |    2 
 net/sunrpc/xprt.c                                                             |   16 
 net/sunrpc/xprtrdma/backchannel.c                                             |    5 
 net/sunrpc/xprtrdma/frwr_ops.c                                                |    2 
 net/sunrpc/xprtrdma/rpc_rdma.c                                                |  172 -
 net/sunrpc/xprtrdma/transport.c                                               |   85 
 net/sunrpc/xprtrdma/verbs.c                                                   |  167 -
 net/sunrpc/xprtrdma/xprt_rdma.h                                               |    7 
 net/tipc/bcast.c                                                              |   22 
 net/tipc/bcast.h                                                              |    2 
 net/tipc/bearer.c                                                             |    1 
 net/tipc/name_distr.c                                                         |   13 
 net/tipc/netlink.c                                                            |   12 
 net/tipc/node.c                                                               |   15 
 net/tipc/socket.c                                                             |    3 
 net/wireless/nl80211.c                                                        |    2 
 net/xfrm/xfrm_device.c                                                        |    3 
 net/xfrm/xfrm_input.c                                                         |    6 
 net/xfrm/xfrm_interface_core.c                                                |    3 
 net/xfrm/xfrm_policy.c                                                        |   32 
 net/xfrm/xfrm_state.c                                                         |    2 
 net/xfrm/xfrm_user.c                                                          |   22 
 samples/trace_events/trace-events-sample.c                                    |    4 
 scripts/kconfig/conf.c                                                        |    6 
 security/apparmor/apparmorfs.c                                                |    2 
 security/apparmor/domain.c                                                    |   58 
 security/apparmor/label.c                                                     |    2 
 security/apparmor/net.c                                                       |    2 
 security/apparmor/policy.c                                                    |    5 
 security/apparmor/procattr.c                                                  |    2 
 security/integrity/evm/evm_secfs.c                                            |   16 
 security/keys/keyring.c                                                       |    2 
 security/selinux/hooks.c                                                      |   19 
 sound/aoa/fabrics/layout.c                                                    |    6 
 sound/core/init.c                                                             |   11 
 sound/core/seq/Kconfig                                                        |    7 
 sound/core/seq/seq_clientmgr.c                                                |  172 -
 sound/core/seq/seq_clientmgr.h                                                |    2 
 sound/core/seq/seq_compat.c                                                   |    1 
 sound/core/seq/seq_memory.c                                                   |   10 
 sound/core/seq/seq_memory.h                                                   |   19 
 sound/core/seq/seq_midi.c                                                     |   55 
 sound/firewire/isight.c                                                       |    3 
 sound/isa/gus/gus_pcm.c                                                       |    2 
 sound/pci/cmipci.c                                                            |    6 
 sound/pci/es1938.c                                                            |    2 
 sound/pci/ice1712/aureon.c                                                    |    2 
 sound/pci/ice1712/ice1712.c                                                   |    8 
 sound/pci/ice1712/ice1724.c                                                   |    6 
 sound/pci/ymfpci/ymfpci_main.c                                                |    6 
 sound/soc/codecs/adau1372.c                                                   |    5 
 sound/soc/codecs/hdac_hdmi.c                                                  |    4 
 sound/soc/codecs/tlv320aic3x.c                                                |   25 
 sound/soc/fsl/fsl_asrc_dma.c                                                  |   20 
 sound/soc/fsl/fsl_audmix.c                                                    |    6 
 sound/soc/qcom/qdsp6/q6apm.c                                                  |    8 
 sound/soc/sof/ipc3-control.c                                                  |   52 
 sound/soc/tegra/tegra210_ahub.c                                               |    4 
 sound/usb/caiaq/input.c                                                       |    2 
 sound/usb/mixer_quirks.c                                                      |  101 
 sound/usb/mixer_scarlett.c                                                    |    4 
 sound/usb/mixer_us16x08.c                                                     |  127 
 sound/virtio/virtio_pcm.c                                                     |    3 
 sound/virtio/virtio_pcm_ops.c                                                 |    3 
 tools/bpf/bpftool/net.c                                                       |    4 
 tools/include/linux/bitops.h                                                  |    2 
 tools/include/uapi/linux/bpf.h                                                |    1 
 tools/lib/api/fs/fs.c                                                         |   19 
 tools/lib/bpf/libbpf.c                                                        |    9 
 tools/lib/bpf/strset.c                                                        |   62 
 tools/lib/bpf/usdt.c                                                          |   16 
 tools/perf/util/probe-finder.c                                                |    4 
 tools/power/x86/intel-speed-select/isst-daemon.c                              |    9 
 tools/testing/cxl/test/cxl.c                                                  |    8 
 tools/testing/cxl/test/mem.c                                                  |    4 
 tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c                         |    2 
 tools/testing/selftests/vm/compaction_test.c                                  |    3 
 tools/testing/selftests/vm/hmm-tests.c                                        |   63 
 tools/usb/usbip/libsrc/usbip_common.c                                         |    2 
 tools/usb/usbip/libsrc/usbip_device_driver.c                                  |    4 
 tools/usb/usbip/libsrc/vhci_driver.c                                          |    1 
 tools/virtio/linux/dma-mapping.h                                              |   12 
 tools/virtio/vringh_test.c                                                    |    5 
 tools/vm/slabinfo.c                                                           |    4 
 virt/kvm/eventfd.c                                                            |   12 
 virt/kvm/kvm_main.c                                                           |   16 
 957 files changed, 11622 insertions(+), 9021 deletions(-)

Aaron Tomlin (2):
      libbpf: Report error when a negative kprobe offset is specified
      mips: sched: Fix CPUMASK_OFFSTACK memory corruption

Abd-Alrhman Masalkhi (1):
      md/raid1: free r1_bio when REQ_NOWAIT is set and read would block on retry

Abdun Nihaal (15):
      fbdev: metronomefb: fix potential memory leak in metronomefb_probe()
      fbdev: broadsheetfb: fix potential memory leak in broadsheetfb_probe()
      fbdev: hecubafb: fix potential memory leak in hecubafb_probe()
      fbdev: radeon: fix potential memory leak in radeonfb_pci_register()
      fbdev: i740fb: fix potential memory leak in i740fb_probe()
      fbdev: s3fb: fix potential memory leak in s3_pci_probe()
      fbdev: uvesafb: fix potential memory leak in uvesafb_probe()
      fbdev: tdfxfb: fix potential memory leak in tdfxfb_probe()
      fbdev: carminefb: fix potential memory leak in alloc_carmine_fb()
      fbdev: nvidia: fix potential memory leak in nvidiafb_probe()
      fbdev: tridentfb: fix potential memory leak in trident_pci_probe()
      nvdimm/btt: Free arenas on btt_init() error paths
      nvdimm/btt: Free arena sub-allocations on discover_arenas() error path
      scsi: lpfc: Fix memory leak in lpfc_sli4_driver_resource_setup()
      bnx2x: fix potential memory leak in bnx2x_alloc_mem_bp()

Abhishek Ojha (1):
      regulator: ltc3676: Fix incorrect IRQSTAT bit offsets

Aboorva Devarajan (4):
      powerpc/perf: fix preempt count underflow in fsl_emb_pmu_del
      powerpc/powernv: fix preempt count leak in pnv_kexec_wait_secondaries_down
      powerpc/kexec: fix double get_cpu() imbalance in kexec_prepare_cpus
      selftests/mm: fix exclusive_cow test fork() handling

Achkinazi, Igor (1):
      nvme-multipath: set BIO_REMAPPED on bios remapped to per-path namespace disks

Adam Li (1):
      sched/fair: Only update stats for allowed CPUs when looking for dst group

Aditya Garg (2):
      net: mana: initialize gdma queue id to INVALID_QUEUE_ID
      net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check

Adrian Hunter (1):
      i3c: master: Prevent reuse of dynamic address on device add failure

Ahsan Atta (1):
      crypto: qat - fix restarting state leak on allocation failure

Al Viro (2):
      configfs_lookup(): don't leave ->s_dentry dangling on failure
      configfs: fix lockless traversals of ->s_children

Alan Stern (1):
      USB: chaoskey: Fix slab-use-after-free in chaoskey_release()

Alberto Ruiz (1):
      fuse: fix device node leak in cuse_process_init_reply()

Aleksandr Nogikh (2):
      ocfs2: fix circular locking dependency in ocfs2_dio_end_io_write
      ieee802154: fix kernel-infoleak in dgram_recvmsg()

Aleksandrova Alyona (1):
      net: dsa: sja1105: round up PTP perout pin duration

Alex Williamson (3):
      vfio/pci: Release the VGA arbiter client on register_device() failure
      vfio/pci: Latch disable_idle_d3 per device
      vfio/mlx5: Fix racy bitfields and tighten struct layout

Alexander Chesnokov (1):
      RDMA/hns: Fix arithmetic overflow in calc_hem_config()

Alexander Lobakin (1):
      bitops: make BYTES_TO_BITS() treewide-available

Alexander Potapenko (1):
      lib/test_meminit: use && for bools

Alexandru Hossu (9):
      staging: rtl8723bs: fix WEP length underflow and OOB read in OnAuth()
      staging: rtl8723bs: fix OOB read in OnAssocRsp() IE loop
      staging: rtl8723bs: fix OOB read in update_beacon_info() IE loop
      staging: rtl8723bs: fix OOB reads in IE loops in issue_assocreq() and join_cmd_hdl()
      staging: rtl8723bs: fix OOB reads in is_ap_in_tkip() IE loop
      staging: rtl8723bs: fix OOB write in HT_caps_handler()
      staging: nvec: fix use-after-free in nvec_rx_completed()
      staging: rtl8723bs: fix heap buffer overflow in rtw_cfg80211_set_wpa_ie()
      staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()

Alexey Nepomnyashih (1):
      xfs: fix unreachable BIGTIME check in dquot flush validation

Ali Ahmet MEMIS (1):
      tools/power/x86/intel-speed-select: Harden daemon pidfile open

Alison Schofield (1):
      nvdimm/btt: Handle preemption in BTT lane acquisition

Anastasia Tishchenko (1):
      crypto: ecc - Fix carry overflow in vli multiplication

Andrea Righi (1):
      net: lan743x: Initialize eth_syslock spinlock before use

Andreas Kemnade (1):
      gpios: palmas: add .get_direction() op

Andreas Kempe (1):
      iio: imu: st_lsm6dsx: deselect shub page before reading whoami

Andrei Kuchynski (2):
      mfd: cros_ec: Delay dev_set_drvdata() until probe success
      usb: typec: ucsi: Invert DisplayPort role assignment

Andrew Morton (1):
      security/apparmor/apparmorfs.c: conditionally compile get_loaddata_common_ref()

Andrii Kuchmenko (1):
      module: decompress: check return value of module_extend_max_pages()

Andrii Nakryiko (1):
      bpf: Consistently use bpf_rcu_lock_held() everywhere

Andy Shevchenko (4):
      iio: magnetometer: ak8975: Add missed pm_runtime_put_autosuspend() call
      phy: phy-can-transceiver: Check driver match and driver data against NULL
      ACPI: resource: Amend kernel-doc style
      serial: 8250_mid: Disable DMA for selected platforms

Andy Yan (1):
      usb: typec: tcpm: Fix VDM type for Enter Mode commands

Angela Czubak (1):
      HID: add haptics page defines

Anisse Astier (1):
      efivarfs: expose used and total size

Anshuman Khandual (1):
      arm64/mm: Optimize TLB flush in unmap_hotplug_[pmd|pud]_range()

Antoni Pokusinski (1):
      rtc: abx80x: fix the RTC_VL_CLR clearing all status flags

Armin Wolf (1):
      leds: uleds: Fix potential buffer overread

Arnaldo Carvalho de Melo (3):
      tools lib api: Fix missing null termination in filename__read_int/ull()
      tools lib api: Fix filename__write_int() writing uninitialized stack data
      tools lib api: Fix mount_overload() snprintf truncation and toupper range

Arnd Bergmann (1):
      staging: media: atomisp: reduce load_primary_binaries() stack usage

Arseniy Krasnov (1):
      mtd: rawnand: fix condition in 'nand_select_target()'

Asim Viladi Oglu Manizada (1):
      net: openvswitch: reject oversized nested action attrs

Avinash Duduskar (1):
      bpf: zero-initialize the fib lookup flow struct

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Validate SVID index in svdm_consume_modes()

Baokun Li (2):
      writeback: fix race between cgroup_writeback_umount() and inode_switch_wbs()
      writeback: drop now-unnecessary rcu_barrier() in cgroup_writeback_umount()

Baolin Liu (1):
      Documentation: proc: fix section numbering in table of contents

Bartosz Golaszewski (2):
      device property: initialize the remaining fields of fwnode_handle in fwnode_init()
      mfd: tps6586x: Fix OF node refcount

Bastien Curutchet (1):
      mtd: rawnand: pl353: fix probe resource allocation

Benjamin Coddington (1):
      NFSv4: include MAY_WRITE in open permission mask for O_TRUNC

Benjamin Marzinski (1):
      dm-log: fix a bitset_size overflow on 32bit machines

Bhargav Joshi (2):
      irqchip/crossbar: Fix parent domain resource leak
      irqchip/crossbar: Use correct index in crossbar_domain_free()

Biren Pandya (2):
      iio: accel: kxsd9: fix runtime PM imbalance on write_raw() error
      iio: light: gp2ap002: fix runtime PM leak on read error

Bjoern A. Zeeb (1):
      wifi: mt76: fix argument to ieee80211_is_first_frag()

Bjorn Andersson (4):
      slimbus: qcom-ngd-ctrl: Fix up platform_driver registration
      slimbus: qcom-ngd-ctrl: Fix probe error path ordering
      slimbus: qcom-ngd-ctrl: Correct PDR and SSR cleanup ownership
      slimbus: qcom-ngd-ctrl: Register callbacks after creating the ngd

Bradley Morgan (3):
      bpf: Disable xfrm_decode_session hook attachment
      cpu: hotplug: Preserve per instance callback errors
      cpu: hotplug: Bound hotplug states sysfs output

Breno Leitao (2):
      workqueue: drop spurious '*' from print_worker_info() fn declaration
      arm64/hw_breakpoint: reject unaligned watchpoints that would truncate BAS

Bryam Vargas (17):
      f2fs: bound i_inline_xattr_size for non-inline-xattr inodes
      iio: accel: bmc150: clamp the device-reported FIFO frame count
      udf: validate VAT header length against the VAT inode size
      udf: validate sparing table length as an entry count, not a byte count
      partitions: aix: bound the pp_count scan to the ppe array
      isofs: bound Rock Ridge symlink components to the SL record
      exfat: bound uniname advance in exfat_find_dir_entry()
      Input: synaptics-rmi4 - bound the F3A keymap to the GPIO count
      Input: synaptics-rmi4 - bound the F30 keymap to the GPIO/LED count
      Input: goodix - clamp the device-reported contact count
      Input: iforce - bound the device-reported force-feedback effect index
      Input: touchwin - reset the packet index on every complete packet
      nvmet-rdma: handle inline data with a nonzero offset
      scsi: target: Bound PR-OUT TransportID parsing to the received buffer
      scsi: target: core: Fix iSCSI ISID use-after-free in REGISTER AND MOVE
      net/sched: sch_multiq: Replace direct dequeue call with peek and qdisc_dequeue_peeked
      orangefs: keep the readdir entry size 64-bit in fill_from_part()

Cao Guanghui (1):
      dm era: fix NULL pointer dereference in metadata_open()

Carlos Bilbao (1):
      PCI/ASPM: Don't reconfigure ASPM entering low-power state

Carlos Llamas (3):
      binder: fix UAF in binder_thread_release()
      binder: fix UAF in binder_free_transaction()
      libbpf: Fix UAF in strset__add_str()

Carlos Song (2):
      spi: fsl-lpspi: replace dmaengine_terminate_all() with dmaengine_terminate_sync()
      spi: fsl-lpspi: terminate the RX channel on TX prepare failure path

Cen Zhang (1):
      Bluetooth: MGMT: Fix adv monitor add failure cleanup

Chaitanya Kulkarni (2):
      nvmet-tcp: fix race between ICReq handling and queue teardown
      nvmet: remove superfluous initialization

Chao Yu (1):
      f2fs: fix potential deadlock in gc_merge path of f2fs_balance_fs()

Chen Cheng (1):
      md/raid10: reset read_slot when reusing r10bio for discard

Chen-Yu Tsai (2):
      dt-bindings: media: sun4i-a10-video-engine: Add interconnect properties
      arm64: dts: mediatek: mt8192-asurada: Move PCIe DMA bounce buffer to host

ChenXiaoSong (1):
      smb/server: do not require delete access for non-replacing links

Chi Wang (1):
      audit: Fix data races of skb_queue_len() readers on audit_queue

Chris Mason (2):
      nfsd: release layout stid on setlease failure
      xprtrdma: Fix bcall rep leak and unbounded peek

Christian Brauner (8):
      file: add fput() cleanup helper
      eventpoll: use hlist_is_singular_node() in __ep_remove()
      eventpoll: split __ep_remove()
      eventpoll: kill __ep_remove()
      eventpoll: drop vestigial __ prefix from ep_remove_{file,epi}()
      eventpoll: rename ep_remove_safe() back to ep_remove()
      eventpoll: move epi_fget() up
      eventpoll: fix ep_remove struct eventpoll / struct file UAF

Christian Marangi (2):
      PCI: mediatek: Convert bool to single quirks entry and bitmap
      PCI: mediatek: Use generic MACRO for TPVPERL delay

Christoph Hellwig (1):
      proc: rename proc_setattr to proc_nochmod_setattr

Chuck Lever (14):
      xprtrdma: Remove temp allocation of rpcrdma_rep objects
      xprtrdma: Avoid 250 ms delay on backlog wakeup
      xprtrdma: Close lost-wakeup race in xprt_rdma_alloc_slot
      xprtrdma: Post receive buffers after RPC completion
      xprtrdma: Use sendctx DMA state for Send signaling
      xprtrdma: Decouple req recycling from RPC completion
      xprtrdma: Check frwr_wp_create() during connect
      xprtrdma: Document and assert reply-handler invariants
      xprtrdma: Resize reply buffers before reposting receives
      xprtrdma: Sanitize the reply credit grant after parsing
      xprtrdma: Repost Receive buffers for malformed replies
      xprtrdma: Return sendctx slot after Send preparation failure
      lockd: Plug nlm_file leak when nlm_do_fopen() fails
      lockd: Plug nlm_file refcount leak on cached nlm_do_fopen() failure

Claudia Draghicescu (1):
      Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID

Colin Ian King (1):
      iio: invensense: remove redundant initialization of variable period

Conor Dooley (1):
      rtc: mpfs: fix counter upload completion condition

Cristian Marussi (1):
      clk: scmi: Fix clock rate rounding

Cássio Gabriel (6):
      ALSA: virtio: Add missing 384 kHz PCM rate mapping
      ALSA: usb-audio: Propagate errors in scarlett_ctl_enum_put()
      ALSA: usb-audio: Propagate US-16x08 write errors in route/mix EQ-switch put callbacks
      ALSA: usb-audio: Roll back quirk control caches on write errors
      ALSA: usb-audio: Update Babyface Pro control caches only after successful writes
      ALSA: usb-audio: Update US-16x08 EQ/comp shadow state after successful writes

DaeMyung Kang (2):
      ksmbd: destroy async_ida in ksmbd_conn_free()
      ksmbd: centralize ksmbd_conn final release to plug transport leak

Daehyeon Ko (1):
      macsec: don't read an unset MAC header in macsec_encrypt()

Dai Ngo (1):
      NFSv4/pnfs: defer return_range callbacks until after inode unlock

Dan Carpenter (3):
      rapidio/tsi721: prevent a bad dereference in tsi721_db_dpc()
      scsi: pm8001: Fix error code in non_fatal_log_show()
      afs: Fix error code in afs_extract_vl_addrs()

Daniel Borkmann (2):
      bpf, arm64: Reject out-of-range B.cond targets
      bpf: Tighten cgroup storage cookie checks for prog arrays

Daniele Palmas (1):
      net: qualcomm: rmnet: add tx packets aggregation

Danilo Krummrich (3):
      driver core: use READ_ONCE() for dev->driver in dev_has_sync_state()
      driver core: Fix missing jiffies conversion in deferred_probe_extend_timeout()
      driver core: Guard deferred probe timeout extension with delayed_work_pending()

Darrick J. Wong (1):
      xfs: resample the data fork mapping after cycling ILOCK

Darvell Long (1):
      ALSA: usb-audio: avoid kobject path lookup in DualSense match

Dave Jiang (2):
      cxl/test: Fix integer overflow in mock LSA bounds checks
      cxl/test: Add check after kzalloc() memory in alloc_mock_res()

David Carlier (1):
      netfilter: nfnl_cthelper: apply per-class values when updating policies

David Disseldorp (1):
      scsi: target: Fix hexadecimal CHAP_I handling

David Howells (8):
      afs: Fix netns teardown to cancel the preallocation charger
      afs: Fix further netns teardown to cancel the preallocation charger
      afs: Fix callback service message parsers to pass through -EAGAIN
      afs: Fix vllist leak
      afs: Fix the volume AFS_VOLUME_RM_TREE is set on
      afs: Fix unchecked-length string display in debug statement
      cifs: Fix reacquisition of volume cookie on still-live connection
      cifs: Add tracing for the cifs_tcon struct refcounting

David Laight (1):
      fbdev: sm501fb: Fix buffer errors in OF binding code

Davide Ornaghi (1):
      ksmbd: fix UAF of struct file_lock in SMB2_LOCK deferred-lock cancellation

Davidlohr Bueso (1):
      dax/kmem: account for partial discontiguous resource upon removal

Dawei Feng (4):
      crypto: amlogic - avoid double cleanup in meson_crypto_probe()
      bpf: Restore sysctl new-value from 1 to 0
      net: ena: clean up XDP TX queues when regular TX setup fails
      wifi: mac80211: fix memory leak in ieee80211_register_hw()

Dawid Osuchowski (1):
      ice: fix FDIR CTRL VSI resource leak in ice_reset_all_vfs()

Deepanshu Kartikey (2):
      nilfs2: reject CLEAN_SEGMENTS ioctl with out-of-range segment numbers
      bpf: fix UAF by restoring RCU-delayed inode freeing in bpffs

Denis Arefev (1):
      block: Avoid mounting the bdev pseudo-filesystem in userspace

Dmitry Antipov (1):
      ocfs2: fix buffer head management in ocfs2_read_blocks()

Dmitry Torokhov (13):
      Input: mms114 - fix multi-touch slot corruption
      Input: maple_keyb - set driver data before registering input device
      Input: maplemouse - set driver data before registering input device
      Input: maplecontrol - set driver data before registering input device
      Input: ims-pcu - fix use-after-free and double-free in disconnect
      Input: ims-pcu - release data interface on disconnect
      Input: ims-pcu - validate control endpoint type
      Input: ims-pcu - add response length checks
      Input: ims-pcu - fix DMA mapping violation in line setup
      Input: ims-pcu - fix out-of-bounds read in ims_pcu_irq() debug logging
      Input: ims-pcu - fix potential infinite loop in CDC union descriptor parsing
      Input: ims-pcu - fix race condition in reset_device sysfs callback
      Input: ims-pcu - fix type confusion in CDC union descriptor parsing

Dmitry Vyukov (1):
      firmware_loader: Fix recursive lock in device_cache_fw_images()

Doruk Tan Ozturk (1):
      net/mlx5e: macsec: fix use-after-free of metadata_dst on RX SC delete

Douglas Anderson (1):
      regulator: core: Make regulator_lock_two() logic easier to follow

Dragos Tatulea (1):
      net/mlx5: Check max_macs devlink param value against max capability

Easwar Hariharan (2):
      jiffies: Define secs_to_jiffies()
      jiffies: Cast to unsigned long in secs_to_jiffies() conversion

Edward Adam Davis (1):
      Bluetooth: Ignore too large handle values in BIG

Enrico Pozzobon (1):
      net: usb: lan78xx: disable VLAN filter in promiscuous mode

Eric Biggers (7):
      crypto: drbg - Fix returning success on failure in CTR_DRBG
      crypto: drbg - Fix drbg_max_addtl() on 64-bit kernels
      crypto: drbg - Fix the fips_enabled priority boost
      crypto: sun4i-ss - Remove insecure and unused rng_alg
      crypto: crypto4xx - Remove insecure and unused rng_alg
      crypto: af_alg - Remove zero-copy support from skcipher and aead
      crypto: hisi-trng - Remove crypto_rng interface

Eric Dumazet (12):
      net/sched: sch_hfsc: annotate data-races in hfsc_dump_class_stats()
      net/sched: sch_htb: do not change sch->flags in htb_dump()
      net/sched: sch_htb: annotate data-races (I)
      net/sched: sch_drr: annotate data-races around cl->deficit
      ipv6: guard against possible NULL deref in __in6_dev_stats_get()
      tipc: fix UAF in tipc_l2_send_msg()
      tcp: ipv6: clamp default adverting MSS to avoid GSO_BY_FRAGS (0xFFFF)
      xfrm: annotate data-races around xfrm_policy_count[] and xfrm_policy_default[]
      xfrm: validate selector family and prefixlen during match
      veth: fix NAPI leak in XDP enable error path
      amt: fix size calculation in amt_get_size()
      ipv6: mcast: Fix potential UAF in MLD delayed work

Erich E. Hoover (1):
      USB: quirks: add NO_LPM for the Samsung T5 EVO Portable SSD

Fabio Porcedda (1):
      USB: serial: option: add Telit Cinterion FE990D50 compositions

Fan Wu (2):
      usb: typec: ucsi: ccg: Fix use-after-free of ucsi on remove
      can: esd_usb: kill anchored URBs before freeing netdevs

Farhad Alemi (1):
      cgroup/cpuset: rebind mm mempolicy to effective_mems, not mems_allowed

Felix Gu (6):
      watchdog: sprd_wdt: Remove redundant sprd_wdt_disable() on register failure
      pinctrl: sunxi: fix regulator leak in sunxi_pmx_request() error path
      drm/tegra: dc: Fix device node reference leak in tegra_dc_has_output()
      spi: ep93xx: fix double-free of zeropage on DMA setup failure
      crypto: marvell/octeontx - fix DMA cleanup using wrong loop index
      crypto: cavium/cpt - fix DMA cleanup using wrong loop index

Feng Liu (2):
      net/mlx5e: Fix HV VHCA stats zero-sized buffer allocation
      net/mlx5e: Fix HV VHCA stats agent registration race

Feng Wu (1):
      netfilter: xt_rateest: fix u64 truncation in xt_rateest_mt()

Fernando Fernandez Mancera (7):
      netfilter: nfnetlink_osf: fix mss parsing on big-endian architectures
      netfilter: synproxy: protect nf_ct_seqadj_init() with conntrack lock
      netfilter: nf_conncount: prevent connlimit drops for early confirmed ct
      ipv6: fix error handling in disable_ipv6 sysctl
      ipv6: fix error handling in ignore_routes_with_linkdown sysctl
      ipv6: fix error handling in forwarding sysctl
      ipv6: fix error handling in disable_policy sysctl

Filipe Manana (1):
      btrfs: fix invalid pointer dereference in __btrfs_run_delayed_refs()

Florian Fuchs (2):
      Input: maplemouse - fix NULL pointer dereference in open()
      mtd: maps: vmu-flash: fix NULL pointer dereference in initialization

Florian Westphal (6):
      netfilter: ebtables: module names must be null-terminated
      netfilter: nf_conncount: callers must hold rcu read lock
      netfilter: nf_reject: skip iphdr options when looking for icmp header
      netfilter: nft_meta_bridge: fix NFT_META_BRI_IIFPVID stack leak
      netfilter: nf_nat_sip: reload possible stale data pointer
      netfilter: ebtables: zero chainstack array

Frank Li (1):
      dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and ABORT_INT_MASK

Franziska Naepelt (2):
      staging: rtl8723bs: Fix indentation issues
      staging: rtl8723bs: Fix space issues

Fredric Cover (1):
      smb: client: use kvzalloc() for megabyte buffer in simple fallocate

Fredrik M Olsson (1):
      rtc: ds1307: Fix off-by-one issue with wday for rx8130

Fushuai Wang (1):
      cpufreq: intel_pstate: Sync policy->cur during CPU offline

Geert Uytterhoeven (1):
      firmware: arm_scmi: Fix OOB in scmi_power_name_get()

Geetha sowjanya (2):
      octeontx2-af: mcs: Fix unsupported secy stats read
      octeontx2-pf: mcs: Fix mcs resources free on PF shutdown

Genjian Zhang (1):
      dm thin metadata: fix superblock refcount leak on snapshot shadow failure

Georgiy Osokin (1):
      HID: picolcd: prevent NULL pointer dereference in picolcd_send_and_wait()

Gerald Schaefer (1):
      s390/monwriter: Reject buffer reuse with different data length

Gil Portnoy (6):
      ksmbd: fix use-after-free of a deferred file_lock on SMB2_CLOSE then SMB2_CANCEL
      ksmbd: add permission checks for FSCTL_DUPLICATE_EXTENTS_TO_FILE
      ksmbd: add a permission check for FSCTL_SET_ZERO_DATA
      ksmbd: add a WRITE_DAC/WRITE_OWNER check to SMB2 SET_INFO SECURITY
      ksmbd: add per-handle permission check to FILE_LINK_INFORMATION
      ksmbd: fix use-after-free of conn->preauth_info in concurrent SMB2 NEGOTIATE

Giovanni Cabiddu (2):
      crypto: qat - fix VF2PF work teardown race in adf_disable_sriov()
      crypto: qat - validate RSA CRT component lengths

Gleb Markov (1):
      cxgb4: Fix decode strings dump for T6 adapters

Greg Kroah-Hartman (3):
      sysfs: clamp show() return value in sysfs_kf_read()
      ksmbd: fix mechToken leak when SPNEGO decode fails after token alloc
      Linux 6.1.178

Griffin Kroah-Hartman (2):
      usb: gadget: function: rndis: add length check to response query
      usb: gadget: function: rndis: add length check for header

Guangshuo Li (9):
      firmware_loader: fix device reference leak in firmware_upload_register()
      IB/mlx4: Fix refcount leak in add_port() error path
      ASoC: adau1372: Clear PLL_EN on failed PLL lock without reset GPIO
      ksmbd: fix use-after-free in same_client_has_lease()
      staging: most: video: avoid double free on video register failure
      cifs: validate DFS referral string offsets
      smb: client: fix overflow in passthrough ioctl bounds check
      gpu: host1x: Fix device reference leak in host1x_device_parse_dt() error path
      mfd: sm501: Fix reference leak on failed device registration

Guanyou.Chen (1):
      sched: restore timer_slack_ns when resetting RT policy on fork

Gui-Dong Han (1):
      KEYS: Use acquire when reading state in keyring search

Guilherme Ivo Bozi (1):
      iio: adc: xilinx-ams: fix out-of-bounds channel lookup in event handling

Guillermo Rodríguez (1):
      i2c: stm32f7: truncate clock period instead of rounding it

Guixin Liu (2):
      PCI: Introduce named defines for PCI ROM
      PCI: Check ROM header and data structure addr before accessing

Guoniu Zhou (1):
      dt-bindings: power: imx93: Add MIPI PHY power domain

Hao-Qun Huang (2):
      staging: vme_user: fix location monitor leak in fake bridge
      staging: vme_user: fix location monitor leak in tsi148 bridge

Haoxiang Li (13):
      smb: client: Fix next buffer leak in receive_encrypted_standard()
      usb: cdnsp: fix stream context array leak in cdnsp_alloc_stream_info()
      usb: mtu3: unmap request DMA on queue failure
      Input: synaptics-rmi4 - unregister function handlers on physical driver registration failure
      rtc: cmos: unregister HPET IRQ handler on probe failure
      KVM: s390: pci: Fix GISC refcount leak on AIF enable failure
      net: sparx5: unregister blocking notifier on init failure
      scsi: hpsa: Fix DMA mapping leak on IOACCEL2 reset path
      scsi: elx: efct: Fix I/O leak on unsupported additional CDB
      net: wwan: t7xx: destroy DMA pool on CLDMA late init failure
      net: ixp4xx_hss: fix duplicate HDLC netdev allocation
      net: liquidio: fix BAR resource leak on PF number failure
      fsl/fman: Free init resources on KeyGen failure in fman_init()

Haoze Xie (1):
      netfilter: nf_queue: pin bridge device while NFQUEUE holds fake dst

Harman Kalra (1):
      octeontx2-af: fix VF bringup affecting PF promiscuous state

Heiko Carstens (1):
      s390/process: Fix kernel thread function pointer type

Heinrich Schuchardt (1):
      efivarfs: fix statfs() on efivarfs

Herbert Xu (2):
      crypto: crypto4xx - Remove ahash-related code
      crypto: rng - Free default RNG on module exit

Herman van Hazendonk (1):
      iio: common: st_sensors: honour channel endianness in read_axis_data

Hongchen Zhang (1):
      LoongArch: Fix missing dirty page tracking in {pte,pmd}_wrprotect()

Huacai Chen (1):
      LoongArch: Report dying CPU to RCU in stop_this_cpu()

Hui Wang (1):
      ring-buffer: Fix event length with forced 8-byte alignment

Hui Zhu (1):
      vmalloc: fix NULL pointer dereference in is_vm_area_hugepages()

Huihui Huang (1):
      tracing: Prevent out-of-bounds read in glob matching

Huiwen He (2):
      smb/client: always return a value for FS_IOC_GETFLAGS
      smb/client: preserve errors from smb2_set_sparse()

HyeongJun An (5):
      ASoC: codecs: hdac_hdmi: Validate written enum value
      ASoC: fsl: fsl_audmix: Validate written enum values
      ASoC: tegra: tegra210_ahub: Validate written enum value
      hwmon: (asus_atk0110) Check package count before accessing element
      ALSA: seq: Fix uninitialised heap leak in snd_seq_event_dup()

Hyunwoo Kim (2):
      KVM: arm64: vgic: Check the interrupt is still ours before migrating it
      Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()

Ian Bridges (2):
      fbcon: fix NULL pointer dereference for a console without vc_data
      ocfs2: fix NULL h_transaction deref in ocfs2_assure_trans_credits

Ibrahim Hashimov (1):
      ksmbd: fix integer overflow in set_file_allocation_info()

Icenowy Zheng (1):
      dmaengine: qcom: gpi: set DMA_PRIVATE capability

Ido Schimmel (1):
      bridge: stp: Fix a potential use-after-free when deleting a bridge

Ilpo Järvinen (6):
      PCI: Prevent resource tree corruption when BAR resize fails
      PCI: Free saved list without holding pci_bus_sem
      PCI: Fix restoring BARs on BAR resize rollback path
      PCI: Add kerneldoc for pci_resize_resource()
      PCI: Move Resizable BAR code to rebar.c
      serial: 8250_mid: Remove 8250_pci usage

Ioana Ciornei (1):
      dpaa2-switch: fix VLAN upper check not rejecting bridge join

Ionut Nechita (1):
      scsi: sas: Skip opt_sectors when DMA reports no real optimization hint

Ivan Abramov (1):
      ieee802154: Remove WARN_ON() in cfg802154_pernet_exit()

Jacob Moroni (2):
      RDMA/irdma: Fix out-of-bounds write in irdma_copy_user_pgaddrs
      RDMA/irdma: Fix OOB read during CQ MR registration

Jaewon Yang (1):
      tpm: Make the TPM character devices non-seekable

Jakub Kicinski (1):
      net: psample: fix info leak in PSAMPLE_ATTR_DATA

Jamal Hadi Salim (4):
      net/sched: cls_flow: Dont expose folded kernel pointers
      net/sched: cls_api: Handle TC_ACT_CONSUMED in tcf_qevent_handle
      net/sched: sch_teql: Introduce slaves_lock to avoid race condition and UAF
      net/sched: sch_teql: move rcu_read_lock()/spin_lock() from _bh variants

James Kim (1):
      char: tlclk: fix use-after-free in tlclk_cleanup()

James Raphael Tiovalen (1):
      macsec: fix promiscuity refcount leak in macsec_dev_open()

Jan Kara (2):
      writeback: Avoid contention on wb->list_lock when switching inodes
      writeback: Fix use after free in inode_switch_wbs_work_fn()

Jann Horn (2):
      proc: protect ptrace_may_access() with exec_update_lock (FD links)
      proc: protect ptrace_may_access() with exec_update_lock (part 1)

Janne Grunau (1):
      watchdog: apple: Add "apple,t8103-wdt" compatible

Jared Baldridge (1):
      usb: cdc_acm: Add quirk for Uniden BC125AT scanner

Jarkko Sakkinen (1):
      tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()

Jason Gunthorpe (4):
      IB/cm: Fix av cm device leak on an error path in cm_init_av_by_path()
      IB/mlx5: Don't take the rereg_mr fallback without a new translation
      IB/mlx5: Properly support implicit ODP rereg_mr
      IB/mlx4: Fill in the access_flags if IB_MR_REREG_ACCESS is not specified

Javier Carrasco (1):
      iio: light: veml6030: fix channel type when pushing events

Jean-Baptiste Maneyrol (10):
      iio: imu: inv_icm42600: make timestamp module chip independent
      iio: move inv_icm42600 timestamp module in common
      iio: make invensense timestamp module generic
      iio: imu: inv_mpu6050: use the common inv_sensors timestamp module
      iio: invensense: fix timestamp glitches when switching frequency
      iio: imu: inv_icm42600: stabilized timestamp in interrupt
      iio: imu: inv_icm42600: fix timestamping by limiting FIFO reading
      iio: imu: inv_mpu6050: fix frequency setting when chip is off
      iio: invensense: fix odr switching to same value
      iio: imu: inv_icm42600: fix timestamp clock period by using lower value

Jeff Layton (1):
      nfsd: reset write verifier on deferred writeback errors

Jeremy Linton (1):
      ACPI: CPPC: Suppress UBSAN warning caused by field misuse

Jessica Zhang (2):
      drm/msm/dp: fix HPD state status bit shift value
      drm/msm/dp: Fix the ISR_* enum values

Jiakai Xu (1):
      PM: sleep: Use complete() in device_pm_sleep_init()

Jian Zhang (1):
      cifs: remove all cifs files before kill super

Jiayuan Chen (2):
      mm/vmscan: flush deferred TLB before freeing large folios
      net/sched: cls_bpf: prevent unbounded recursion in offload rollback

Jihed Chaibi (1):
      ARM: dts: am335x-sl50: Fix audio bitclock and frame master endpoint

Jimmy Hu (1):
      usb: gadget: udc: Fix use-after-free in gadget_match_driver

Jiri Olsa (1):
      bpf: Add missing access_ok call to copy_user_syms

Jiri Slaby (SUSE) (1):
      PCI: controller: Use dev_fwnode() instead of of_fwnode_handle()

Jisheng Zhang (1):
      spi: dw: fix wrong BAUDR setting after resume

Joanne Koong (1):
      fuse: re-lock request before returning from fuse_ref_folio()

Johan Hovold (22):
      i2c: core: fix irq domain leak on adapter registration failure
      i2c: core: fix hang on adapter registration failure
      i2c: core: fix NULL-deref on adapter registration failure
      i2c: core: fix adapter debugfs creation
      i2c: core: fix adapter registration race
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
      i2c: core: fix adapter deregistration race
      MIPS: ip22-gio: fix gio device memory leak
      MIPS: ip22-gio: fix kfree() of static object
      MIPS: ip22-gio: fix device reference leak in probe

Johannes Thumshirn (1):
      btrfs: zoned: don't account data relocation space-info in statfs free space

John Johansen (2):
      apparmor: advertise the tcp fast open fix is applied
      apparmor: fix label can not be immediately before a declaration

John Keeping (1):
      mm: shrinkers: fix debugfs file permissions

Jon Hunter (1):
      arm64: tegra: Fix Tegra234 MGBE PTP clock

Jonas Jelonek (1):
      MIPS: smp: report dying CPU to RCU in stop_this_cpu()

Joseph Qi (2):
      ocfs2: fix race between ocfs2_control_install_private() and ocfs2_control_release()
      ocfs2: add journal NULL check in ocfs2_checkpoint_inode()

Joshua Crofts (5):
      iio: light: opt3001: fix missing state reset on timeout
      iio: light: si1133: reset counter to prevent race condition
      iio: light: si1133: prevent race condition on timeout
      iio: magnetometer: ak8975: fix potential kernel stack memory leak
      hwmon: (ltc2992) add missing 'select REGMAP_I2C' to Kconfig

Jozsef Kadlecsik (4):
      netfilter: ipset: Fix data race between add and dump in all hash types
      netfilter: ipset: annotate "pos" for concurrent readers/writers
      netfilter: ipset: Don't use test_bit() in lockless RCU readers in hash types
      netfilter: ipset: fix order of kfree_rcu() and rcu_assign_pointer()

Julian Anastasov (2):
      ipvs: ensure inner headers in ICMP errors are in headroom
      ipvs: fix more places with wrong ipv6 transport offsets

Junrui Luo (2):
      jbd2: fix integer underflow in jbd2_journal_initialize_fast_commit()
      powerpc/spufs: fix out-of-bounds access in spufs_mem_mmap_access()

Kartik Rajput (2):
      clocksource/drivers/timer-tegra186: Fix support for multiple watchdog instances
      dmaengine: tegra: Fix burst size calculation

Keshav Verma (1):
      f2fs: fix listxattr handling of corrupted xattr entries

Kiryl Shutsemau (1):
      userfaultfd: gate must_wait writability check on pte_present()

Koichiro Den (5):
      NTB: epf: Avoid calling pci_irq_vector() from hardirq context
      NTB: epf: Fix request_irq() unwind in ntb_epf_init_isr()
      NTB: epf: Make db_valid_mask cover only real doorbell bits
      NTB: epf: Report 0-based doorbell vector via ntb_db_event()
      NTB: epf: Fix doorbell bitmask and IRQ vector handling

Konstantin Komarov (4):
      fs/ntfs3: add bounds check to run_get_highest_vcn()
      fs/ntfs3: bound DeleteIndexEntryAllocation memmove length
      fs/ntfs3: bound attr_off in UpdateResidentValue against data_off
      fs/ntfs3: validate lcns_follow in log_replay conversion

Krzysztof Kozlowski (2):
      crypto: atmel-sha204a - Mark OF related data as maybe unused
      regulator: scmi: Simplify with scoped for each OF child loop

Krzysztof Wilczyński (3):
      alpha/PCI: Add security_locked_down() check to pci_mmap_resource()
      alpha/PCI: Fix __pci_mmap_fits() overflow for zero-length BARs
      proc: only bump parent nlink when registering directories

Kunihiko Hayashi (1):
      spi: uniphier: Fix completion initialization order before devm_request_irq()

Kuniyuki Iwashima (4):
      vxlan: Fix potential null-ptr-deref in vxlan_gro_prepare_receive().
      net: fib_rules: Don't dump dying fib_rule in fib_rules_dump().
      ipv4: fib: Don't ignore error route in local/main tables.
      ipv6: mcast: Replace locking comments with lockdep annotations.

Kyle Zeng (2):
      ALSA: seq: Clear variable event pointer on read
      ocfs2: avoid moving extents to occupied clusters

Lad Prabhakar (1):
      PCI: rcar-host: Remove unused LIST_HEAD(res)

Lars Pöschel (1):
      spi: xilinx: use FIFO occupancy register to determine buffer size

Lars-Peter Clausen (1):
      iio: event: Fix event FIFO reset race

Laxman Acharya Padhya (1):
      Bluetooth: btrtl: validate firmware patch bounds

Lee Jones (2):
      HID: core: Fix OOB read in hid_get_report for numbered reports
      can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

Leo Yan (1):
      coresight: etm4x: Correct TRCVMIDCCTLR1 save and restore

Leon Hwang (3):
      bpf: Check tail zero of bpf_prog_info
      bpf: Update transport_header when encapsulating UDP tunnel in lwt
      bpf: Fix bpf_get/setsockopt to tos for ipv4-mapped ipv6 socket

Leon Romanovsky (2):
      RDMA/mlx5: Release the HW‑provided UAR index rather than the SW one
      xfrm: add new packet offload flag

Li RongQing (3):
      PCI: mediatek: Fix operator precedence in PCIE_FTS_NUM_L0 macro
      net/mlx5: Fix L3 tunnel entropy refcount leak
      fbdev: sm712: Fix operator precedence in big_swap macro

Lianfa Weng (1):
      RDMA/hns: Fix warning in poll cq direct mode

Liew Rui Yan (1):
      mm/damon/reclaim: fix typo in damon_reclaim_timer_fn()

Lifeng Zheng (1):
      cpufreq: conservative: Simplify frequency limit handling

Liming Wu (1):
      tools/virtio: Add dma sync api for virtio test

Lin He (2):
      drm/hisilicon/hibmc: move display contrl config to hibmc_probe()
      drm/hisilicon/hibmc: use clock to look up the PLL value

Linmao Li (1):
      ipv6: addrconf: bail out of dad_failure when state is no longer POSTDAD

Linus Torvalds (1):
      eventpoll: don't decrement ep refcount while still holding the ep mutex

Liviu Stan (2):
      iio: temperature: ltc2983: Fix reinit_completion() called after conversion start
      iio: temperature: ltc2983: Fix n_wires default bypassing rotation check

Longjun Tang (1):
      virtio_net: disable cb when NAPI is busy-polled

Lothar Rubusch (1):
      crypto: atmel-sha204a - fix blocking and non-blocking rng logic

Louis Kotze (1):
      wifi: cfg80211: fix grammar in MLO group key error message

Louis Scalbert (1):
      bonding: 3ad: fix mux port state on oper down

Luca Leonardo Scorcia (2):
      pinctrl: mediatek: mt8516: Fix Schmitt trigger register offset of pins 34-39
      pinctrl: mediatek: mt8167: Fix Schmitt trigger register offset of pins 34-39

Lucas Tsai (1):
      power: supply: core: fix supplied_from allocations

Luiz Augusto von Dentz (4):
      Bluetooth: Remove BT_HS
      Bluetooth: L2CAP: Fix not tracking outstanding TX ident
      Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
      Bluetooth: L2CAP: Fix regressions caused by reusing ident

Lukas Wunner (1):
      X.509: Fix validation of ASN.1 certificate header

Lukasz Czapnik (1):
      ice: fix AQ error code comparison in ice_set_pauseparam()

Ma Ke (1):
      power: supply: cpcap-battery: Fix missing nvmem_device_put() causing reference leak

Maciej W. Rozycki (3):
      MIPS: Fix big-endian stack argument fetching in o32 wrapper
      MIPS: DEC: Remove do_IRQ() call indirection
      MIPS: DEC: Ensure 32-bit stack location for o32 prom_printf()

Madhu M (1):
      usb: typec: ucsi: Pass full DP config payload in SET_NEW_CAM for DP alt mode

Maher Sanalla (1):
      RDMA/mlx5: Fix undefined shift of user RQ WQE size

Mahesh Vaidya (2):
      PCI: altera: Do not dispose parent IRQ mapping
      PCI: altera: Fix resource leaks on probe failure

Manish Khadka (2):
      HID: letsketch: fix UAF on inrange_timer at driver unbind
      HID: appleir: fix UAF on pending key_up_timer in remove()

Manivannan Sadhasivam (5):
      PCI: mediatek: Use actual physical address instead of virt_to_phys()
      PCI: endpoint: pci-epf-vntb: Add check to detect 'db_count' value of 0
      PCI: endpoint: pci-epf-ntb: Add check to detect 'db_count' value of 0
      bus: mhi: ep: Protect mhi_ep_handle_syserr() in the error path
      PCI: mediatek: Fix IRQ domain leak when port fails to enable

Maoyi Xie (14):
      net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink
      ALSA: caiaq: fix out-of-bounds read in the Traktor Kontrol S4 input parser
      ALSA: firewire: isight: bound the sample count to the packet payload
      HID: lg-g15: cancel pending work on remove to fix a use-after-free
      net: usb: kalmia: bound RX frame length in kalmia_rx_fixup()
      usb: gadget: composite: fix dead empty check in the USB_DT_OTG handler
      xfrm: xfrm_interface: require CAP_NET_ADMIN in the device netns for changelink
      net: sit: require CAP_NET_ADMIN in the device netns for changelink
      net: ip6_vti: require CAP_NET_ADMIN in the device netns for changelink
      net: ip_vti: require CAP_NET_ADMIN in the device netns for changelink
      net: ipip: require CAP_NET_ADMIN in the device netns for changelink
      net: ip6_gre: require CAP_NET_ADMIN in the device netns for changelink
      net: wwan: iosm: bound device offsets in the MUX downlink decoder
      memstick: ms_block: reject a card that reports too many blocks

Marc Zyngier (1):
      KVM: Move kvm_io_bus_get_dev() locking responsibilities to callers

Marco Nenciarini (1):
      PCI: Skip Resizable BAR restore on read error

Mario Limonciello (1):
      drm/amdkfd: fix list_del corruption in kfd_criu_resume_svm

Mark Rutland (1):
      arm64: fpsimd: Fix type mismatch in sve_{save,load}_state()

Mark Tomlinson (1):
      PCI: iproc: Restore .map_irq() for the platform bus driver

Martin Kaiser (2):
      tracing: probes: fix typo in a log message
      tracing: eprobe: read the complete FILTER_PTR_STRING pointer

Martin Wilck (2):
      scsi: Revert "scsi: Fix sas_user_scan() to handle wildcard and multi-channel scans"
      scsi: smartpqi: Use shost_to_hba() in pqi_scan_finished()

Masami Hiramatsu (Google) (2):
      tracing/events: Fix to check the simple_tsk_fn creation
      tracing/probes: Fix double addition of offset for @+FOFFSET

Mathias Krause (1):
      netfilter: nf_nat: avoid invalid nat_net pointer use on failed nf_nat_init()

Matthew Rosato (1):
      KVM: s390: pci: Fix handling of AIF enable without AISB

Matthias Feser (1):
      serial: 8250_omap: clear rx_running on zero-length DMA completes

Matti Vaittinen (1):
      hwmon: adm1275: Prevent reading uninitialized stack

Matvey Kovalev (2):
      afs: fix NULL pointer dereference in afs_get_tree()
      qede: fix out-of-bounds check for cqe->len_list[]

Mauricio Faria de Oliveira (1):
      usb: atm: ueagle-atm: wait for pre-firmware load in .disconnect()

Maxime Bélair (1):
      apparmor: fix potential UAF in aa_replace_profiles

Maxwell Doose (4):
      iio: adc: lpc32xx: Initialize completion before requesting IRQ
      iio: adc: spear: Initialize completion before requesting IRQ
      iio: chemical: scd30: Cleanup initializations and fix sign-extension bug
      fs: efs: remove unneeded debug prints

Michael Bommarito (23):
      NFSv4/flexfiles: reject zero filehandle version count
      hwrng: virtio: clamp device-reported used.len at copy_data()
      udf: validate free block extents against the partition length
      RDMA/siw: bound Read Response placement to the RREAD length
      libbpf: Harden parse_vma_segs() path parsing
      tipc: require net admin for TIPCv2 netlink mutators
      tipc: prevent snt_unacked underflow on CONN_ACK
      tipc: reject inverted service ranges from peer bindings
      net: qrtr: fix 32-bit integer overflow in qrtr_endpoint_post()
      fs/ntfs3: bound copy_lcns dp->page_lcns[] index in analysis pass
      fs/ntfs3: add depth limit to indx_find_buffer to prevent stack overflow
      fs/ntfs3: bound NTFS_DE view.data_off in UpdateRecordData{Root,Allocation}
      ntfs3: cap RESTART_TABLE free-chain walker at rt->used
      ntfs3: bound to_move in indx_insert_into_root before hdr_insert_head
      ocfs2: reject dinodes with non-canonical i_mode type
      ocfs2: reject dinodes whose i_rdev disagrees with the file type
      ocfs2: reject non-inline dinodes with i_size and zero i_clusters
      scsi: xen: scsiback: Free the command tag on the TMR submit-failure path
      scsi: xen: scsiback: Free unsubmitted command instead of double-putting it
      ieee802154: admin-gate legacy LLSEC dump operations
      ieee802154: allow legacy LLSEC ADD/DEL ops to pass strict validation
      drbd: reject data replies with an out-of-range payload size
      smb: client: resolve SWN tcon from live registrations

Michael Tautschnig (1):
      staging: vme_user: bound slave read/write to the kern_buf size

Mike Snitzer (2):
      NFSv4/flexfiles: honor FF_FLAGS_NO_IO_THRU_MDS on fatal DS connect errors
      NFSv4/flexfiles: honor FF_FLAGS_NO_IO_THRU_MDS in pg_get_mirror_count_write

Mike Yu (1):
      xfrm: Support crypto offload for inbound IPv6 ESP packets not in GRO path

Mikhail Gavrilov (1):
      udmabuf: fix DMA direction mismatch in release_udmabuf()

Mikko Perttunen (3):
      gpu: host1x: Allow entries in BO caches to be freed
      gpu: host1x: Fix iommu_map_sgtable() return value check
      drm/tegra: Fix iommu_map_sgtable() return value check

Mikulas Patocka (7):
      dm-ioctl: report an error if a device has no table
      dm-bufio: fix wrong count calculation in dm_bufio_issue_discard
      dm-stats: fix dm_jiffies_to_msec64
      dm-stats: fix merge accounting
      dm_early_create: fix freeing used table on dm_resume failure
      dm-verity: fix a possible NULL pointer dereference
      dm-verity: increase sprintf buffer size

Ming-Hung Tsai (1):
      dm thin metadata: fix metadata snapshot consistency on commit failure

Mingyu Wang (1):
      fbdev: fbcon: fix out-of-bounds read in err_out of fbcon_do_set_font()

Miquel Raynal (2):
      mtd: spi-nor: Drop duplicate Kconfig dependency
      mtd: spi-nor: swp: Improve locking user experience

Muhammad Bilal (2):
      Bluetooth: L2CAP: validate option length before reading conf opt value
      netfilter: nf_conntrack_irc: fix parse_dcc() off-by-one OOB read

Muhammet Kaan KILINÇ (1):
      crypto: algif_skcipher - force synchronous processing on trees without ctx->state

Myeonghun Pak (5):
      HID: wacom: stop hardware after post-start probe failures
      usb: sl811-hcd: disable controller wakeup on remove
      USB: misc: uss720: unregister parport on probe failure
      usb: typec: anx7411: use devm_pm_runtime_enable()
      ata: sata_gemini: unwind clocks on IDE pinctrl errors

Namjae Jeon (6):
      ksmbd: serialize QUERY_DIRECTORY requests per file
      ksmbd: require source read access for duplicate extents
      ksmbd: run set info with opener credentials
      ksmbd: use opener credentials for FSCTL mutations
      ksmbd: fix use-after-free in __ksmbd_close_fd() via durable scavenger
      ksmbd: track the connection owning a byte-range lock

NeilBrown (2):
      nfsd: move name lookup out of nfsd4_list_rec_dir()
      nfsd: change nfs4_client_to_reclaim() to allocate data

Neill Kapron (1):
      usb: gadget: f_fs: Tie read_buffer lifetime to ffs_epfile

Nickolay Goppen (1):
      arm64: dts: qcom: sdm630: describe adsp_mem region properly

Nikolay Kulikov (1):
      staging: rtl8723bs: fix spaces around binary operators

Nilay Shroff (1):
      nvme-multipath: fix flex array size in struct nvme_ns_head

Norbert Manthey (1):
      smb: client: mask server-provided mode to 07777 in modefromsid

Nuno Sá (1):
      dmaengine: Fix possible use after free

Nuoqi Gui (2):
      bpf: Fix stack slot index in nospec checks
      seg6: validate SRH length before reading fixed fields

Oleg Nesterov (1):
      seqlock: Change do_task_stat() to use scoped_seqlock_read()

Oleksij Rempel (1):
      net: usb: lan78xx: move functions to avoid forward definitions

Oliver Hartkopp (3):
      can: isotp: use unconditional synchronize_rcu() in isotp_release()
      can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure
      can: bcm: add missing rcu list annotations and operations

Oliver Neukum (1):
      usb: iowarrior: remove inherent race with minor number

Ovidiu Panait (1):
      net: bcmgenet: Use weighted round-robin TX DMA arbitration

Pablo Neira Ayuso (1):
      netfilter: conntrack: call nf_ct_gre_keymap_destroy() if master helper is pptp

Patrisious Haddad (1):
      RDMA/mlx5: Remove raw RSS QP restrack tracking

Paul Louvel (6):
      crypto: talitos - use dma_sync_single_for_cpu() before reading descriptor header
      crypto: talitos - add chaining of arbitrary number of descriptor for the SEC1
      crypto: talitos - move dma unmapping code in flush_channel() into a standalone dma_unmap_request() function
      crypto: talitos - move dma mapping code in talitos_submit() into a standalone dma_map_request() function
      crypto: talitos - move code in current_desc_hdr() into a standalone function
      gpio-f7188x: Add support for NCT6126D version B

Paul Menzel (1):
      usb: typec: ucsi: cancel pending work on system suspend

Pauli Virtanen (4):
      Bluetooth: ISO: exclude RFU bits from ISO_SDU_Length
      Bluetooth: SCO: fix sleeping under spinlock in sco_conn_ready
      Bluetooth: SCO: hold sk properly in sco_conn_ready
      Bluetooth: 6lowpan: fix cyclic locking warning on netdev unregister

Pavel Skripkin (1):
      bluetooth/hci: disallow setting handle bigger than HCI_CONN_HANDLE_MAX

Pedro Tammela (1):
      net/sched: act_pedit: use NLA_POLICY for parsing 'ex' keys

Pengjie Zhang (2):
      cpufreq: Documentation: fix sampling_down_factor range
      cpufreq: Documentation: fix conservative governor freq_step description

Pengpeng Hou (13):
      iio: adc: ti-ads124s08: Return reset GPIO lookup errors
      evm: terminate and bound the evm_xattrs read buffer
      sparc: led: avoid trimming a newline from empty writes
      spi: sh-msiof: abort transfers when reset times out
      gpio: mvebu: fail probe if gpiochip registration fails
      gpio: htc-egpio: use managed gpiochip registration
      hwmon: (w83627hf) remove VID sysfs files on error and remove
      hwmon: (w83793) remove vrm sysfs file on probe failure
      mtd: onenand: samsung: report DMA completion timeouts
      mtd: mchp23k256: use SPI match data for chip caps
      mtd: rawnand: fsl_ifc: return errors for failed page reads
      mtd: rawnand: lpc32xx_mlc: fail DMA transfers on timeout
      mtd: rawnand: lpc32xx_slc: fail DMA transfer on completion timeout

Peter Ujfalusi (3):
      ASoC: SOF: ipc3-control: Use overflow checks in control_update size calc
      ASoC: SOF: ipc3-control: Fix TOCTOU in bytes_put and bytes_get
      ASoC: SOF: ipc3-control: Validate size in snd_sof_update_control

Peter Zijlstra (1):
      seqlock: Introduce scoped_seqlock_read()

Petr Wozniak (1):
      net: phy: sfp: free mii_bus in sfp_i2c_mdiobus_destroy

Phillip Varney (1):
      clk: qcom: a53: Corrected frequency multiplier for 1152MHz

Philo Lu (1):
      virtio_net: Support dynamic rss indirection table size

Pratham Gupta (1):
      netfilter: ctnetlink: use nf_ct_exp_net() in expectation dump

Prathamesh Deshpande (1):
      RDMA/mlx5: Fix devx subscribe-event unwind NULL dereference

Qi Zheng (2):
      mm: shrinker: remove redundant shrinker_rwsem in debugfs operations
      mm: shrinker: fix NULL pointer dereference in debugfs

Qianfeng Rong (1):
      netfilter: ebtables: Use vmalloc_array() to improve code

Qihang (1):
      gue: validate REMCSUM private option length

Qihang Tang (2):
      vduse: hold vduse_lock across IDR lookup in open path
      vhost/vdpa: validate virtqueue index in mmap and fault paths

Qing Ming (1):
      vhost/net: complete zerocopy ubufs only once

Qingshuang Fu (1):
      irqchip/ts4800: Fix missing chained handler cleanup on remove

Qu Wenruo (4):
      btrfs: do not trim a device which is not writeable
      btrfs: check and set EXTENT_DELALLOC_NEW before clearing EXTENT_DELALLOC
      btrfs: fix false IO failure after falling back to buffered write
      btrfs: fix incorrect buffered IO fallback for append direct writes

Quang Nguyen (1):
      spi: rpc-if: Use correct device for hardware reinitialization on resume

Rafael Beims (1):
      wifi: mwifiex: fix permanently busy scans after multiple roam iterations

Rafael J. Wysocki (4):
      thermal: hwmon: Fix critical temperature attribute removal
      x86/platform/olpc: xo15: Drop wakeup source on driver removal
      platform/x86: xo15-ebook: Fix wakeup source and GPE handling
      ACPI: NFIT: core: Fix acpi_nfit_init() error cleanup

Raghavendra Rao Ananta (1):
      vfio/pci: Use a private flag to prevent power state change with VFs

Randy Dunlap (1):
      seqlock: fix scoped_seqlock_read kernel-doc

Ranjan Kumar (1):
      Input: elan_i2c - prevent division by zero and arithmetic underflow

Ratheesh Kannoth (2):
      PCI: host-common: Request bus reassignment when not probe-only
      octeontx2-pf: Fix leak of SQ timestamp buffer on teardown

Reinette Chatre (1):
      vfio/pci: Use bitfield for struct vfio_pci_core_device flags

Renjiang Han (3):
      media: qcom: venus: drop extra padding in NV12 raw size calculation
      media: qcom: venus: relax encoder frame/blur dimension steps on v4
      media: qcom: venus: relax encoder frame/blur step size on v6

Ricardo Neri (1):
      thermal: intel: Fix dangling resources on thermal_throttle_online() failure

Ricardo Ribalda (3):
      media: staging: ipu3-imgu: Add range check for imgu_css_cfg_acc_stripe
      media: uvcvideo: Avoid partial metadata buffers
      media: uvcvideo: Fix buffer sequence in frame gaps

Ricardo Robaina (2):
      audit: add audit_log_nf_skb helper function
      audit: fix potential integer overflow in audit_log_n_hex()

Richard Zhu (1):
      PCI: imx6: Fix IMX6SX_GPR12_PCIE_TEST_POWERDOWN handling

Rob Herring (Arm) (1):
      dt-bindings: net: renesas,ether: Drop example "ethernet-phy-ieee802.3-c22" fallback

Rodrigo Lugathe da Conceição Alves (1):
      USB: core: add USB_QUIRK_NO_LPM for VIA Labs USB 2.0 hub

Roman Vivchar (1):
      i2c: mediatek: fix WRRD for SoCs without auto_restart option

Ronaldo Nunez (1):
      pwm: imx27: Fix variable truncation in .apply()

Ronan Dalton (1):
      rtc: ds1307: handle oscillator stop flag for ds1337/ds1339/ds3231

Rong Zhang (1):
      PCI: loongson: Do not ignore downstream devices on external bridges

Rosen Penev (4):
      mips: ralink: mt7621: add missing __iomem
      mips: n64: add __iomem for writel call
      HID: logitech-hidpp: remove excess kernel-doc member in hidpp_scroll_counter
      net: gianfar: dispose irq mappings on probe failure and device removal

Rui Qi (1):
      riscv: stacktrace: Remove bogus -0x4 offset in non-FP walk_stackframe

Ruijie Li (1):
      crypto: pcrypt - restore callback for non-parallel fallback

Ruipeng Qi (1):
      f2fs: fix potential deadlock in f2fs_balance_fs()

Runyu Xiao (13):
      iio: imu: bmi160: add IRQF_NO_THREAD to data-ready trigger IRQ
      usb: dwc3: run gadget disconnect from sleepable suspend context
      gpio: eic-sprd: use raw_spinlock_t in the irq startup path
      io_uring/io-wq: re-check IO_WQ_BIT_EXIT for each linked work item
      kcm: use WRITE_ONCE() when changing lower socket callbacks
      netfilter: nft_synproxy: stop bypassing the priv->info snapshot
      hwmon: (occ) unregister sysfs devices outside occ lock
      wifi: rt2x00: avoid full teardown before work setup in probe
      mmc: vub300: defer reset until cmd_mutex is unlocked
      iio: imu: adis: add IRQF_NO_THREAD to non-FIFO trigger IRQ
      coresight: etb10: restore atomic_t for shared reading state
      gpio: sch: use raw_spinlock_t in the irq startup path
      Bluetooth: L2CAP: cancel pending_rx_work before taking conn->lock

Ruoyu Wang (4):
      apparmor: check label build before no_new_privs test
      net: marvell: prestera: initialize err in prestera_port_sfp_bind
      net: sungem: fix probe error cleanup
      mtd: slram: remove failed entries from the device list

Ryan Lee (1):
      apparmor: grab ns lock and refresh when looking up changehat child profiles

Ryan Roberts (1):
      arm64/mm: convert ptep_clear() to ptep_get_and_clear()

Ryder Lee (1):
      PCI: mediatek: Fix possible truncation in mtk_pcie_parse_port()

Sagi Grimberg (2):
      nvmet-tcp: Fix potential UAF when ddgst mismatch
      pNFS/filelayout: fix cheking if a layout is striped

Sam Day (1):
      usbip: vudc: fix NULL deref in vep_dequeue()

Samuel Holland (2):
      media: cedrus: Fix failure to clean up hardware on probe failure
      bus: sunxi-rsb: Always check register address validity

Samuel Moelius (4):
      Bluetooth: hci: validate codec capability element length
      net/sched: hhf: clear heavy-hitter state on reset
      net/sched: cake: reject overhead values that underflow length
      dm era: fix out-of-bounds memory access for non-zero start sector

Samuel Page (1):
      tipc: fix out-of-bounds read in broadcast Gap ACK blocks

Sandipan Das (1):
      perf/x86/amd/core: Always use the NMI latency mitigation

Sang-Heon Jeon (1):
      mm/fake-numa: fix under-allocation detection in uniform split

Sanjay Chitroda (1):
      iio: accel: mma8452: handle I2C read error(s) in mma8452_read()

Sanman Pradhan (1):
      xfrm: use compat translator only for u64 alignment mismatch

Sara Venkatesh (1):
      RDMA/srpt: fix integer overflow in immediate data length check

Sayali Patil (2):
      selftests/mm: clarify alternate unmapping in compaction_test
      selftests/mm: allow PUD-level entries in compound testcase of hmm tests

Sean Christopherson (6):
      KVM: Replace guest-triggerable BUG_ON() in ioeventfd datamatch with get_unaligned()
      KVM: VMX: Refresh GUEST_PENDING_DBG_EXCEPTIONS.BS on all injected #DBs
      KVM: VMX: Grab vmcs12 on CR8 interception update iff vCPU is in guest mode
      iommu/amd: Fix a stale comment about which legacy mode is user visible
      crypto: ccp - Treat zero-length cert chain as query for blob lengths
      KVM: x86: Ignore pending PV EOI if the vCPU has since disabled PV EOIs

Sebastian Alba Vives (1):
      fpga: microchip-spi: fix zero header_size OOB read in mpf_ops_parse_header()

Sebastian Andrzej Siewior (1):
      net: Drop the lock in skb_may_tx_timestamp()

Sechang Lim (2):
      bpf, sockmap: fix integer overflow in bpf_msg_pop_data() bounds check
      net/sched: act_bpf: use rcu_dereference_bh() to read the filter

Sen Wang (1):
      ASoC: tlv320aic3x: restrict CLKDIV bypass Q values in dual-rate mode

SeongJae Park (3):
      mm/damon/ops-common: handle extreme intervals in damon_hot_score()
      mm/damon/core: make charge_addr_from aware of end-address exclusivity
      mm/damon/sysfs-schemes: fix dir put orders in access_pattern_add_dirs()

Sergey Senozhatsky (2):
      Bluetooth: btmtksdio: fix infinite loop in btmtksdio_txrx_work()
      mailbox: mtk-adsp: fix UAF during device teardown

Seungjin Bae (2):
      usb: host: max3421: Fix shift-out-of-bounds in max3421_hub_control()
      usb: host: max3421: Reject hub port requests for non-existent ports

Shakeel Butt (1):
      mm/shrinker: do not hold RCU lock in shrinker_debugfs_count_show()

Shashank A P (1):
      fs: quota: create dedicated workqueue for quota_release_work

Shengjiu Wang (2):
      dmaengine: imx-sdma: Refine spba bus searching in probe
      ASoC: fsl_asrc_dma: fix eDMA maxburst misalignment with channel count

Shigeru Yoshida (1):
      qede: fix off-by-one in BD ring consumption on build_skb failure

Shitalkumar Gandhi (2):
      ieee802154: ca8210: fix cas_ctl leak on spi_async failure
      ieee802154: ca8210: fix pointer truncation in kfifo on 64-bit

Shivam Kumar (1):
      nvmet-tcp: check INIT_FAILED before nvmet_req_uninit in digest error path

Shoichiro Miyamoto (2):
      smb: client: restrict implied bcc[0] exemption to responses without data area
      smb: client: reject overlapping data areas in SMB2 responses

Shuangpeng Bai (2):
      usb: typec: class: drop PD lookup reference
      llc: fix SAP refcount leak in llc_ui_autobind()

Shyam Prasad N (3):
      cifs: handle when server stops supporting multichannel
      cifs: after disabling multichannel, mark tcon for reconnect
      cifs: fix lock ordering while disabling multichannel

Siddharth Vadapalli (1):
      soc: ti: k3-ringacc: Fix access mode for k3_ringacc_ring_pop_tail_io/proxy

Siwei Zhang (1):
      Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()

Srinivas Kandagatla (1):
      ASoC: qcom: q6apm: fix NULL pointer dereference in graph_callback

Srinivas Pandruvada (1):
      HID: sensor-hub: Add sensor_hub_input_attr_read_values() for multi-byte reads

Srinivasan Shanmugam (2):
      drm/amdkfd: Validate CRIU-restored IDs before idr_alloc
      drm/amd/display: Add missing kdoc for ALLM parameters

Steffen Klassert (1):
      xfrm: Use the XFRM_GRO to indicate a GRO call on input

Stepan Ionichev (5):
      iio: gyro: bmg160: bail out when bandwidth/filter is not in table
      iio: gyro: bmg160: wait full startup time after mode change at probe
      iio: light: tsl2591: return actual error from probe IRQ failure
      device property: fix fwnode reference leak in fwnode_graph_get_endpoint_by_id()
      rtc: msc313: fix NULL deref in shared IRQ handler at probe

Stephan Gerhold (1):
      serial: msm: Disable DMA for kernel console UART

Stephen Dolan (1):
      x86/mm: Fix check/use ordering in switch_mm_irqs_off()

Stephen Smalley (1):
      selinux: check connect-related permissions on TCP Fast Open

Steven Rostedt (1):
      sched/rt: Have RT_PUSH_IPI be default off for non PREEMPT_RT

Stig Hornang (1):
      Bluetooth: L2CAP: fix tx ident leak for commands without a response

Subbaraya Sundeep (1):
      octeontx2-pf: Clear stats of all resources when freeing resources

Sudeep Holla (1):
      firmware: arm_scmi: Read sensor config as 32-bit value

Suman Ghosh (1):
      octeontx2-pf: check DMAC extraction support before filtering

Sumit Kumar (1):
      bus: mhi: ep: Fix potential deadlock in mhi_ep_reset_worker()

Sun Jian (1):
      bpf: Run generic devmap egress prog on private skb

Sungwoo Kim (1):
      Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_connect()

Sven Eckelmann (14):
      batman-adv: gw: acquire ethernet header only after skb realloc
      batman-adv: access unicast_ttvn skb->data only after skb realloc
      batman-adv: dat: acquire ARP hw source only after skb realloc
      batman-adv: bla: reacquire gw address after skb realloc
      batman-adv: dat: ensure accessible eth_hdr proto field
      batman-adv: dat: fix tie-break for candidate selection
      batman-adv: tt: avoid request storms during pending request
      batman-adv: fix VLAN priority offset
      batman-adv: frag: free unfragmentable packet
      batman-adv: frag: fix primary_if leak on failed linearization
      batman-adv: tt: prevent TVLV OOB check overflow
      batman-adv: retrieve ethhdr after potential skb realloc on RX
      batman-adv: ensure minimal ethernet header on TX
      batman-adv: clean untagged VLAN on netdev registration failure

Sven Püschel (1):
      media: rockchip: rga: fix too small buffer size

Takashi Iwai (6):
      ALSA: seq: Introduce SNDRV_SEQ_IOCTL_USER_PVERSION ioctl
      ALSA: seq: Add UMP support
      ALSA: core: Fix unintuitive behavior of snd_power_ref_and_wait()
      ALSA: seq: Avoid confusion of aligned read size
      ALSA: seq: Skip event type filtering for UMP events
      ALSA: seq: Check UMP support for midi_version change

Tao Cui (1):
      RDMA/counter: Fix incorrect port index in rdma_counter_init() error cleanup

Tao Liu (1):
      riscv: Prevent NULL pointer dereference in machine_kexec_prepare()

Tetsuo Handa (1):
      ocfs2: kill osb->system_file_mutex lock

Thadeu Lima de Souza Cascardo (1):
      drm/amdgpu: initialize irq.lock spinlock earlier

Thomas Gleixner (2):
      debugobjects: Plug race against a concurrent OOM disable
      treewide: Switch/rename to timer_delete[_sync]()

Thomas Weißschuh (1):
      proc: use generic setattr() for /proc/$PID/net

Thorsten Blum (8):
      crypto: caam - use print_hex_dump_devel to guard key hex dumps
      crypto: caam - use print_hex_dump_devel to guard key hex dumps again
      crypto: ecrdsa - fix unknown OID check in ecrdsa_param_curve
      x86/boot: Validate console=uart8250 baud rate to fix early boot hang
      x86/boot: Reject too long acpi_rsdp= values
      tpm: fix event_size output in tpm1_binary_bios_measurements_show
      powerpc/pseries: fix memory leak on krealloc failure in papr_init
      crypto: atmel-sha204a - drop hwrng quality reduction for ATSHA204A

Tianxiang Chen (1):
      cpufreq: Fix hotplug-suspend race during reboot

Timur Tabi (2):
      drm/nouveau/bios: specify correct display fuse register for Ampere and Ada
      regulator: core: regulator_lock_two() should test for EDEADLK not EDEADLOCK

Tomi Valkeinen (1):
      drm/tidss: Drop extra drm_mode_config_reset() call

Tristan Madani (11):
      hfs/hfsplus: zero-initialize buffer in hfs_bnode_read
      wifi: rtw88: fix OOB read from firmware RX descriptor exceeding DMA buffer
      wifi: ath9k: fix OOB access from firmware tx status queue ID
      RDMA/rxe: Fix TOCTOU heap overflow in get_srq_wqe
      RDMA/rxe: Copy WQE to local buffer in non-SRQ receive path
      wifi: wcn36xx: fix heap overflow from oversized firmware HAL response
      wifi: wcn36xx: fix OOB read from firmware count in PRINT_REG_INFO indication
      wifi: wcn36xx: fix OOB read from short trigger BA firmware response
      ntfs3: fix out-of-bounds read in decompress_lznt
      ocfs2: use kzalloc for quota recovery bitmap allocation
      hfs/hfsplus: fix u32 overflow in check_and_correct_requested_length

Trond Myklebust (1):
      nfsd: Don't reset the write verifier on a commit EAGAIN

Trung Nguyen (1):
      HID: multitouch: fix out-of-bounds bit access on mt_io_flags

Tyler Baker (1):
      usb: gadget: f_fs: initialize reset_work at allocation time

Tyler Hicks (Microsoft) (1):
      proc: Move fdinfo PTRACE_MODE_READ check into the inode .permission operation

Uwe Kleine-König (2):
      slimbus: Convert to platform remove callback returning void
      crypto: atmel - Drop explicit initialization of struct i2c_device_id::driver_data to 0

Vasiliy Kovalev (1):
      net/9p: fix infinite loop in p9_client_rpc on fatal signal

Vasily Khoruzhick (1):
      EDAC/i10nm: Don't fail probing if ADXL is missing

Viacheslav Bocharov (1):
      pinctrl: meson: restore non-sleeping GPIO access

Viacheslav Dubeyko (1):
      hfs/hfsplus: prevent getting negative values of offset/length

Victor Nogueira (3):
      net/sched: sch_hfsc: Don't make class passive twice
      net/sched: sch_fq_codel: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
      net/sched: sch_codel: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen

Vidhu Sarwal (1):
      iio: light: al3010: fix incorrect scale for the highest gain range

Vlad Poenaru (1):
      bpf: Allow LPM map access from sleepable BPF programs

Vladimir Oltean (1):
      net: dsa: tag_ksz: do not rely on skb_mac_header() in TX paths

Vladimir Zapolskiy (1):
      gpio: timberdale: Return -ENOMEM on dynamic memory allocation in probe

Wang Jun (1):
      soc: fsl: qe: panic on ioremap() failure in qe_reset()

Wang Yan (1):
      time: Fix off-by-one in compat settimeofday() usec validation

Wei Fang (1):
      net: enetc: check the number of BDs needed for xdp_frame

Weili Qian (1):
      crypto: hisilicon/qm - disable error report before flr

Weiming Shi (6):
      xfs: fail recovery on a committed log item with no regions
      crypto: asymmetric_keys - fix OOB read in pefile_digest_pe_contents
      Bluetooth: eir: Fix stack OOB write when prepending the Flags AD
      bpf, sockmap: reject overflowing copy + len in bpf_msg_push_data()
      Bluetooth: bpa10x: avoid OOB read of revision string in bpa10x_setup()
      sctp: validate STALE_COOKIE cause length before reading staleness

Weixin Guo (1):
      arm64: dts: rockchip: fix rk809 interrupt pin on rk3566-roc-pc

WenTao Liang (4):
      posix-cpu-timers: Fix pid refcount leak in do_cpu_nanosleep() error path
      usb: dwc3: meson-g12a: fix refcount leak in dwc3_meson_g12a_resume()
      power: supply: charger-manager: fix refcount leak in is_full_charged()
      scsi: elx: efct: Fix refcount leak in efct_hw_io_abort()

Wenjie Qi (2):
      f2fs: keep atomic write retry from zeroing original data
      f2fs: validate orphan inode entry count

Wentao Liang (4):
      mlxsw: fix refcount leak in mlxsw_sp_vrs_lpm_tree_replace()
      xen/gntdev: fix error handling in ioctl
      ata: pata_pxa: Fix DMA channel leak on probe error
      regulator: scmi: fix of_node refcount leak in scmi_regulator_probe()

Werner Kasselman (1):
      drm/amdgpu: fix integer overflow in amdgpu_gem_align_pitch()

William Hansen-Baird (1):
      staging: rtl8723bs: core: move constants to right side in comparison

Wolfram Sang (1):
      hwspinlock: qcom: avoid uninitialized struct members

Wongi Lee (1):
      ipv4: account for fraggap on the paged allocation path

Woojin Ji (1):
      bpftool: Use libbpf error code for flow dissector query

Wyatt Feng (5):
      net: ipv4: bound TCP reordering sysctl writes and MTU probe sizes
      netfilter: xt_u32: reject invalid shift counts
      netfilter: xt_connmark: reject invalid shift parameters
      netfilter: xt_cluster: reject template conntracks in hash match
      netfilter: xt_nat: reject unsupported target families

Xiang Mei (12):
      netfilter: ipset: fix race between dump and ip_set_list resize
      netfilter: ebtables: terminate table name before find_table_lock()
      bridge: cfm: reject invalid CCM interval at configuration time
      virtio-net: fix len check in receive_big()
      drm/edid: fix OOB read in drm_parse_tiled_block()
      ipv6: Fix null-ptr-deref in fib6_nh_mtu_change().
      net, bpf: check master for NULL in xdp_master_redirect()
      usbnet: gl620a: fix out-of-bounds read in genelink_rx_fixup()
      net: usb: net1080: validate packet_len before pad-byte access in rx_fixup
      net: qualcomm: rmnet: validate MAP frame length before ingress parsing
      net/smc: fix UAF in smc_cdc_rx_handler() by pinning the socket
      netfilter: nf_conntrack_reasm: guard mac_header adjustment after IPv6 defrag

Xiang Mei (Microsoft) (1):
      netfilter: bridge: fix stale prevhdr pointer in br_ip6_fragment()

Xin Long (2):
      sctp: validate embedded address parameter length
      sctp: hold socket lock when dumping endpoints in sctp_diag

Xingjing Deng (1):
      kconfig: fix potential NULL pointer dereference in conf_askvalue

Xu Kuohai (1):
      bpf, lsm: Add disabled BPF LSM hook list

Xu Rao (4):
      USB: storage: include US_FL_NO_SAME in quirks mask
      USB: usb-storage: ene_ub6250: restore media-ready check
      ACPI: IPMI: Fix inverted interface check in ipmi_bmc_gone()
      scsi: sg: Report request-table problems when any status is set

Xuan Zhuo (4):
      virtio_ring: introduce virtqueue_set_dma_premapped()
      virtio_ring: introduce dma map api for virtqueue
      virtio_ring: introduce dma sync api for virtqueue
      virtio_ring: fix syncs DMA memory with different direction

Xuanqiang Luo (2):
      i2c: mlxbf: Fix use-after-free in mlxbf_i2c_init_resource()
      llc: fix SAP refcount leak when creating incoming sockets

Yadan Fan (1):
      MIPS: mm: Fix out-of-bounds write in maar_res_walk()

Yichong Chen (2):
      usbip: tools: support SuperSpeedPlus devices
      tools/mm/slabinfo: fix total_objects attribute name

Yingchao Deng (1):
      coresight: cti: Fix DT filter signals silently ignored

Yingjie Gao (1):
      watchdog: sp5100_tco: Use EFCH MMIO for newer Hygon FCH

Yizhou Zhao (9):
      6lowpan: fix NHC entry use-after-free on error path
      net/9p: fix race condition on rdma->state in trans_rdma.c
      ipvs: pass parsed transport offset to state handlers
      ipvs: use parsed transport offset in TCP state lookup
      ipvs: fix PMTU for GUE/GRE tunnel ICMP errors
      netfilter: nf_conncount: fix zone comparison in tuple dedup
      netfilter: ecache: fix inverted time_after() check
      ipvs: use parsed transport offset in SCTP state lookup
      ipvs: reset full ip_vs_seq structs in ip_vs_conn_new

Yong Wang (1):
      net: ife: require ETH_HLEN to be pullable in ife_decode()

Yonghong Song (1):
      selftests/bpf: Fix bpf_iter/task_vma test

Yousef Alhouseen (4):
      Bluetooth: bnep: pin L2CAP connection during netdev registration
      Bluetooth: fix UAF in bt_accept_dequeue()
      xfs: use null daddr for unset first bad log block
      mac802154: remove interfaces with RCU list deletion

Yuanhe Shu (1):
      Revert "PCI/MSI: Unmap MSI-X region on error"

Yuho Choi (9):
      rpmsg: char: Fix use-after-free on probe error path
      cpufreq: pcc: fix use-after-free and double free in _OSC evaluation
      drm/radeon: fix memory leak in radeon_ring_restore() on lock failure
      ARM: imx3: Fix CCM node reference leak
      ARM: imx31: Fix IIM mapping leak in revision check
      ACPI: IPMI: Fix message kref handling on dead device
      watchdog: unregister PM notifier on watchdog unregister
      clk: at91: keep securam node alive while mapping it
      irqchip/gic-v3-its: Fix OF node reference leak

Yun Zhou (2):
      flow_dissector: check device type before reading ETH_ADDRS
      net: mvneta: re-enable percpu interrupt on resume

Yunpeng Tian (1):
      fs/ntfs3: validate Dirty Page Table capacity in log_replay copy_lcns

Yunxiang Li (1):
      drm/amdkfd: Avoid double-unpin of DOORBELL/MMIO BOs on free

Yuyang Huang (1):
      ipv4: igmp: remove multicast group from hash table on device destruction

Zhan Xusheng (2):
      fs/ntfs3: fix syncing wrong inode on DIRSYNC cross-directory rename
      posix-cpu-timers: Use u64 multiplication in update_rlimit_cpu()

Zhang Cen (4):
      ALSA: seq: midi: Serialize output teardown with event_input
      ocfs2: rebase copied fsdlm LVB pointers in locking_state
      ocfs2: reject FITRIM ranges shorter than a cluster
      ocfs2/dlm: require a ref for locking_state debugfs open

Zhang Lixu (1):
      iio: hid-sensor-rotation: Fix stale or zero output when reading raw values

Zhang Tianci (2):
      vduse: Requeue failed read to send_list head
      vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter

Zhang Yi (1):
      ext4: fix LOGFLUSH shutdown ordering to allow ordered-mode data writeback

Zhang Yuwei (1):
      driver core: Use mod_delayed_work to prevent lost deferred probe work

ZhangGuoDong (2):
      smb: move some duplicate definitions to common/cifsglob.h
      smb: move smb_version_values to common/smbglob.h

Zhao Dongdong (7):
      ALSA: ymfpci: check snd_ctl_new1() return value
      ALSA: cmipci: check snd_ctl_new1() return value
      ALSA: es1938: check snd_ctl_new1() return value
      ALSA: gus: check snd_ctl_new1() return value
      ALSA: ice1712: check snd_ctl_new1() return value
      reset: sunxi: fix memory region leak on ioremap failure
      ALSA: aoa: check snd_ctl_new1() return value

Zhao Zhang (1):
      bpf: Reject fragmented frames in devmap

ZhengYuan Huang (1):
      ocfs2: don't BUG_ON an invalid journal dinode

Zhengchuan Liang (1):
      net: atm: reject out-of-range traffic classes in QoS validation

Zhenhao Wan (1):
      RDMA/rtrs-srv: Bound RDMA-Write length to chunk size in rdma_write_sg

Zhiling Zou (1):
      wifi: mac80211: free ack status frame on TX header build failure

Zhixing Chen (1):
      netfilter: ip6tables: mark malformed IPv6 extension headers for hotdrop

Zihan Xi (2):
      smb: client: use unaligned reads in parse_posix_ctxt()
      smb: client: harden POSIX SID length parsing

Zijing Yin (1):
      net: af_key: initialize alg_key_len for IPComp states

Zilin Guan (2):
      media: atomisp: Fix memory leak in atomisp_fixed_pattern_table()
      afs: use kvfree() to free memory allocated by kvcalloc()

Zishun Yi (1):
      riscv: cacheinfo: Fix node reference leak in populate_cache_leaves

Ziyang Xuan (1):
      Bluetooth: Make handle of hci_conn be unique

Zygmunt Krynicki (3):
      apparmor: aa_label_alloc use aa_label_free on alloc failure
      apparmor: aa_getprocattr free procattr leak on format failure
      apparmor: put secmark label after secid lookup

longlong yan (1):
      tools/virtio: check mmap return value in vringh_test

zhoumin (1):
      EDAC/{skx_common,skx}: Fix UBSAN shift-out-of-bounds in skx_get_dimm_info

胡连勤 (1):
      usb: xhci: Fix sleep in atomic context in xhci_free_streams()

