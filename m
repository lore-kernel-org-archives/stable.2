Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC86443C17;
	Fri, 11 Sep 2026 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126124; cv=none; b=Fgq8cIzOIavXnuharztIlxc1SDGngW+rpUQAQ5F2P2uweDvqkTjrxAVJE+l0UxISPN6U88R1oK0b+/yH4YRkbwy8DlOAwS5srrq65IINYw6dJ0UWjPW7B3J6ihAp79Mg9kbdPL8sdwcDsDYQ/xwmyYYsRDxgR4SHj23pRPUhjZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126124; c=relaxed/simple;
	bh=XKqCO1q0DwHfWytmlVOCOiGUGTZqnTUfnK8NaFCHC+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GePZdKv/Gjj7C9J2EiN1uCHZfvzWnIpyNseCfPNY9rDB0fOJdWnkZYUYRkRmxbCN/hfwqa66BVF57dWrFXJc2xdSF7WlU+d0iETCH5S6SmdJxHSc/MDQ7K9tKAzQnmkqCtIPNPlI8foPcPlKltTvL8aP5kROyOq69CrpN+dslXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UDxULWNk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UDxULWNk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371661F000FF;
	Fri, 11 Sep 2026 11:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789126108;
	bh=T/3H2VfQdH8GIYI16//+9npy4z5tfl4iC9mCvERtcZ4=;
	h=From:To:Cc:Subject:Date;
	b=UDxULWNkesn0GENp5vAVdXD3K4cIOv8rw4GJ/xOLudPUJMSmCCHKU8yIndY43pKds
	 4xIkze8UfwZsPJlTQ6awAloWbXg/g7n0kSeE8mf+/eqqhtJBQCS/iS+KO71yilrLZc
	 8k8+wGlUDjOaSn8JjKOeKvtQh6ALdEaTgXDOAqVg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.51
Date: Fri, 11 Sep 2026 13:28:15 +0200
Message-ID: <2026091116-saffron-vitally-325a@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.51 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-kernel-mm-damon                   |    8 
 Documentation/admin-guide/cgroup-v1/memory.rst                    |   49 -
 Documentation/trace/hisi-ptt.rst                                  |   28 
 Documentation/userspace-api/media/v4l/ext-ctrls-colorimetry.rst   |   12 
 Makefile                                                          |    2 
 arch/arm64/include/asm/kvm_nested.h                               |   20 
 arch/arm64/kernel/cpu_errata.c                                    |    2 
 arch/arm64/kvm/at.c                                               |    2 
 arch/arm64/kvm/nested.c                                           |   94 +-
 arch/arm64/kvm/sys_regs.c                                         |   11 
 arch/arm64/kvm/vgic/vgic-init.c                                   |    1 
 arch/arm64/kvm/vgic/vgic-its.c                                    |    8 
 arch/arm64/kvm/vgic/vgic-v3-nested.c                              |    2 
 arch/arm64/kvm/vgic/vgic-v3.c                                     |   12 
 arch/arm64/mm/fault.c                                             |   12 
 arch/loongarch/Kconfig                                            |    2 
 arch/loongarch/include/asm/kvm_host.h                             |    1 
 arch/loongarch/include/asm/pgtable.h                              |    7 
 arch/loongarch/kernel/acpi.c                                      |    3 
 arch/loongarch/kernel/kprobes.c                                   |    3 
 arch/loongarch/kernel/rethook_trampoline.S                        |    2 
 arch/loongarch/kvm/exit.c                                         |    1 
 arch/loongarch/kvm/main.c                                         |    6 
 arch/loongarch/kvm/mmu.c                                          |   10 
 arch/loongarch/kvm/vcpu.c                                         |    6 
 arch/loongarch/kvm/vm.c                                           |    1 
 arch/loongarch/net/bpf_jit.c                                      |   22 
 arch/parisc/kernel/head.S                                         |    1 
 arch/powerpc/include/asm/papr-watchdog.h                          |   64 +
 arch/powerpc/include/asm/reg.h                                    |   12 
 arch/powerpc/kexec/file_load_64.c                                 |    2 
 arch/powerpc/kexec/ranges.c                                       |   12 
 arch/powerpc/kvm/book3s_hv.c                                      |   15 
 arch/powerpc/kvm/powerpc.c                                        |    6 
 arch/powerpc/mm/book3s64/radix_pgtable.c                          |    7 
 arch/powerpc/platforms/pseries/setup.c                            |   28 
 arch/s390/include/asm/nmi.h                                       |    3 
 arch/s390/kernel/nmi.c                                            |    5 
 arch/s390/kvm/guestdbg.c                                          |    9 
 arch/s390/kvm/interrupt.c                                         |   26 
 arch/s390/kvm/kvm-s390.c                                          |   15 
 arch/x86/events/intel/lbr.c                                       |   12 
 arch/x86/kernel/rtc.c                                             |    4 
 arch/x86/kvm/hyperv.c                                             |   25 
 arch/x86/kvm/mmu/mmu.c                                            |  102 +-
 arch/x86/kvm/mmu/tdp_iter.h                                       |    7 
 arch/x86/kvm/mmu/tdp_mmu.c                                        |   20 
 arch/x86/kvm/vmx/nested.c                                         |   75 +-
 arch/x86/kvm/x86.c                                                |    5 
 arch/x86/kvm/x86.h                                                |    2 
 block/genhd.c                                                     |    7 
 drivers/acpi/acpi_pnp.c                                           |    2 
 drivers/acpi/acpi_tad.c                                           |  178 +++--
 drivers/acpi/cppc_acpi.c                                          |   13 
 drivers/acpi/x86/cmos_rtc.c                                       |   13 
 drivers/ata/ahci.c                                                |   49 +
 drivers/block/ublk_drv.c                                          |    6 
 drivers/block/zram/zram_drv.c                                     |   65 -
 drivers/block/zram/zram_drv.h                                     |    1 
 drivers/clk/mediatek/Kconfig                                      |    1 
 drivers/clk/meson/gxbb.c                                          |    2 
 drivers/clk/qcom/gcc-mdm9607.c                                    |  182 -----
 drivers/clk/qcom/gcc-msm8916.c                                    |    5 
 drivers/clk/qcom/gcc-msm8939.c                                    |    5 
 drivers/clk/rockchip/clk-rk3588.c                                 |    2 
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c                        |    4 
 drivers/cpufreq/apple-soc-cpufreq.c                               |   36 -
 drivers/cpufreq/cppc_cpufreq.c                                    |    2 
 drivers/cpuidle/cpuidle-psci.c                                    |   42 -
 drivers/cpuidle/dt_idle_genpd.c                                   |    3 
 drivers/crypto/atmel-ecc.c                                        |   50 -
 drivers/crypto/intel/iaa/iaa_crypto_main.c                        |  138 ++-
 drivers/crypto/intel/iaa/iaa_crypto_stats.c                       |    9 
 drivers/crypto/intel/iaa/iaa_crypto_stats.h                       |    2 
 drivers/cxl/core/Makefile                                         |    1 
 drivers/cxl/core/core.h                                           |   11 
 drivers/cxl/core/mbox.c                                           |    8 
 drivers/cxl/core/mce.c                                            |   27 
 drivers/cxl/core/pci.c                                            |  115 ---
 drivers/cxl/core/ras_rch.c                                        |  136 +++
 drivers/cxl/core/region.c                                         |  122 ++-
 drivers/cxl/cxl.h                                                 |    9 
 drivers/cxl/cxlmem.h                                              |    2 
 drivers/dax/Makefile                                              |    3 
 drivers/dax/cxl.c                                                 |   27 
 drivers/dma/dw-edma/dw-edma-core.c                                |   23 
 drivers/dma/dw-edma/dw-hdma-v0-core.c                             |    2 
 drivers/dma/fsl-edma-trace.h                                      |    4 
 drivers/firmware/qcom/qcom_scm.c                                  |   30 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                  |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                        |   26 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                           |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                           |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                            |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c                      |    7 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                            |    8 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                            |    8 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                             |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                             |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                          |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c             |   23 
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c                          |   56 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                 |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c           |   13 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c   |    5 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                         |   13 
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c                         |    3 
 drivers/gpu/drm/drm_atomic_uapi.c                                 |    2 
 drivers/gpu/drm/drm_drv.c                                         |   34 
 drivers/gpu/drm/gud/gud_connector.c                               |   12 
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c                    |   52 -
 drivers/gpu/drm/i915/i915_pci.c                                   |    3 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                |   12 
 drivers/gpu/drm/nouveau/include/nvkm/engine/disp.h                |    1 
 drivers/gpu/drm/nouveau/nouveau_chan.c                            |    9 
 drivers/gpu/drm/nouveau/nouveau_sgdma.c                           |    4 
 drivers/gpu/drm/nouveau/nouveau_uvmm.c                            |    6 
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c                 |   10 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/Kbuild                   |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ga102.c                  |   13 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c                  |  191 +++++
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c                  |    4 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h                   |    4 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h                    |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h                   |   17 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c                  |   86 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c            |  129 +--
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/disp.c            |   64 +
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c             |    9 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/disp.h       |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h                   |    5 
 drivers/gpu/drm/panel/panel-edp.c                                 |   19 
 drivers/gpu/drm/panthor/panthor_fw.c                              |   22 
 drivers/gpu/drm/solomon/ssd130x.c                                 |    9 
 drivers/gpu/drm/sun4i/sun4i_backend.c                             |    2 
 drivers/gpu/drm/sysfb/ofdrm.c                                     |    8 
 drivers/gpu/drm/sysfb/simpledrm.c                                 |   74 +-
 drivers/gpu/drm/xe/xe_vram.c                                      |   26 
 drivers/hid/bpf/hid_bpf_struct_ops.c                              |   17 
 drivers/hid/hid-mcp2221.c                                         |   15 
 drivers/hid/hid-rmi.c                                             |   46 +
 drivers/hid/hid-sony.c                                            |   78 --
 drivers/hid/wacom_wac.c                                           |   13 
 drivers/i2c/busses/i2c-designware-platdrv.c                       |    2 
 drivers/i2c/busses/i2c-qcom-geni.c                                |    4 
 drivers/i2c/i2c-core-base.c                                       |    6 
 drivers/i2c/i2c-mux.c                                             |    1 
 drivers/i2c/muxes/i2c-demux-pinctrl.c                             |    1 
 drivers/iio/adc/Kconfig                                           |    1 
 drivers/iio/adc/adi-axi-adc.c                                     |   30 
 drivers/iio/adc/pac1921.c                                         |    2 
 drivers/iio/adc/ti-ads7138.c                                      |   42 -
 drivers/iio/chemical/atlas-sensor.c                               |   19 
 drivers/iio/chemical/sgp30.c                                      |    3 
 drivers/iio/dac/ad3552r-hs.c                                      |    2 
 drivers/iio/dac/m62332.c                                          |   17 
 drivers/iio/gyro/mpu3050-core.c                                   |    2 
 drivers/iio/industrialio-buffer.c                                 |   38 -
 drivers/iio/light/cm32181.c                                       |    2 
 drivers/iio/light/gp2ap002.c                                      |   10 
 drivers/iio/light/ltrf216a.c                                      |    3 
 drivers/iio/light/opt4001.c                                       |   37 -
 drivers/iio/light/opt4060.c                                       |    5 
 drivers/iio/pressure/dps310.c                                     |    3 
 drivers/iio/pressure/mpl115.c                                     |   11 
 drivers/iio/proximity/srf04.c                                     |    1 
 drivers/iio/temperature/hid-sensor-temperature.c                  |    3 
 drivers/infiniband/hw/ionic/ionic_hw_stats.c                      |   95 +-
 drivers/infiniband/hw/ionic/ionic_ibdev.h                         |   11 
 drivers/input/tablet/aiptek.c                                     |   13 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c                   |   14 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                       |    9 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h                       |    3 
 drivers/irqchip/irq-mbigen.c                                      |   20 
 drivers/irqchip/irq-stm32mp-exti.c                                |    4 
 drivers/md/dm.c                                                   |   14 
 drivers/media/cec/core/cec-adap.c                                 |   10 
 drivers/media/cec/core/cec-core.c                                 |    2 
 drivers/media/cec/platform/meson/ao-cec-g12a.c                    |    1 
 drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c |    3 
 drivers/media/dvb-frontends/rtl2832_sdr.c                         |   21 
 drivers/media/i2c/alvium-csi2.c                                   |    2 
 drivers/media/i2c/imx355.c                                        |    3 
 drivers/media/i2c/imx415.c                                        |    4 
 drivers/media/i2c/ov02a10.c                                       |   12 
 drivers/media/i2c/ov7740.c                                        |    4 
 drivers/media/i2c/video-i2c.c                                     |    8 
 drivers/media/pci/cobalt/cobalt-alsa-main.c                       |    1 
 drivers/media/pci/cx23885/cimax2.c                                |    1 
 drivers/media/pci/intel/ipu6/ipu6-isys.c                          |    1 
 drivers/media/pci/saa7164/saa7164-core.c                          |    8 
 drivers/media/pci/zoran/zoran_card.c                              |    2 
 drivers/media/platform/amphion/venc.c                             |    2 
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c          |    3 
 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c          |    6 
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c              |    6 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c           |    6 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c              |    2 
 drivers/media/platform/qcom/iris/iris_state.c                     |    2 
 drivers/media/platform/qcom/iris/iris_vidc.c                      |   11 
 drivers/media/platform/qcom/iris/iris_vpu_common.c                |    2 
 drivers/media/platform/qcom/venus/hfi_parser.c                    |    9 
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c            |    5 
 drivers/media/platform/rockchip/rkvdec/rkvdec.c                   |    4 
 drivers/media/rc/sunxi-cir.c                                      |    9 
 drivers/media/test-drivers/vimc/vimc-capture.c                    |    4 
 drivers/media/tuners/tda18250.c                                   |    4 
 drivers/media/usb/airspy/airspy.c                                 |   17 
 drivers/media/usb/cx231xx/cx231xx-video.c                         |    4 
 drivers/media/usb/em28xx/em28xx-cards.c                           |    3 
 drivers/media/usb/em28xx/em28xx-core.c                            |    2 
 drivers/media/usb/go7007/snd-go7007.c                             |   10 
 drivers/media/usb/s2255/s2255drv.c                                |   11 
 drivers/media/usb/usbtv/usbtv-audio.c                             |   11 
 drivers/media/v4l2-core/v4l2-async.c                              |    1 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                         |   49 -
 drivers/media/v4l2-core/v4l2-fwnode.c                             |    2 
 drivers/mfd/qnap-mcu.c                                            |   13 
 drivers/mtd/mtdoops.c                                             |    3 
 drivers/mtd/nand/ecc-realtek.c                                    |    1 
 drivers/mtd/nand/raw/nand_onfi.c                                  |   27 
 drivers/mtd/parsers/afs.c                                         |    7 
 drivers/nvdimm/btt.c                                              |    8 
 drivers/nvme/host/core.c                                          |    3 
 drivers/nvme/host/fabrics.c                                       |    2 
 drivers/nvme/host/fc.c                                            |   26 
 drivers/nvme/host/tcp.c                                           |    7 
 drivers/nvme/target/auth.c                                        |    6 
 drivers/nvme/target/core.c                                        |    2 
 drivers/nvme/target/nvmet.h                                       |    2 
 drivers/nvme/target/tcp.c                                         |   10 
 drivers/parisc/eisa.c                                             |    5 
 drivers/pci/controller/plda/pcie-starfive.c                       |   36 -
 drivers/pmdomain/mediatek/Kconfig                                 |    5 
 drivers/power/supply/ab8500_fg.c                                  |   32 
 drivers/remoteproc/qcom_q6v5_pas.c                                |    9 
 drivers/rtc/rtc-cmos.c                                            |   10 
 drivers/rtc/rtc-rzn1.c                                            |   30 
 drivers/s390/crypto/vfio_ap_ops.c                                 |  203 ++++-
 drivers/scsi/fnic/fip.c                                           |    2 
 drivers/scsi/megaraid/megaraid_sas_base.c                         |   13 
 drivers/scsi/pm8001/pm8001_init.c                                 |    4 
 drivers/scsi/qla2xxx/qla_attr.c                                   |    6 
 drivers/scsi/qla2xxx/qla_bsg.c                                    |   39 -
 drivers/scsi/qla2xxx/qla_dbg.c                                    |    2 
 drivers/scsi/qla2xxx/qla_dfs.c                                    |    4 
 drivers/scsi/qla2xxx/qla_edif.c                                   |    3 
 drivers/scsi/qla2xxx/qla_gs.c                                     |    4 
 drivers/scsi/qla2xxx/qla_init.c                                   |   61 +
 drivers/scsi/qla2xxx/qla_inline.h                                 |   13 
 drivers/scsi/qla2xxx/qla_isr.c                                    |   39 +
 drivers/scsi/qla2xxx/qla_mbx.c                                    |   28 
 drivers/scsi/qla2xxx/qla_nvme.c                                   |   31 
 drivers/scsi/qla2xxx/qla_os.c                                     |   14 
 drivers/soc/qcom/qcom-geni-se.c                                   |   24 
 drivers/spi/spi-bcm63xx-hsspi.c                                   |    8 
 drivers/spi/spi-bcm63xx.c                                         |    6 
 drivers/spi/spi-bcmbca-hsspi.c                                    |    8 
 drivers/spi/spi.c                                                 |   34 
 drivers/staging/media/meson/vdec/vdec.c                           |    4 
 drivers/staging/media/sunxi/cedrus/cedrus.c                       |    4 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c                    |    7 
 drivers/target/iscsi/iscsi_target_login.c                         |    2 
 drivers/thermal/imx_thermal.c                                     |    9 
 drivers/thermal/qoriq_thermal.c                                   |   13 
 drivers/usb/dwc3/ep0.c                                            |    2 
 drivers/usb/dwc3/gadget.c                                         |   21 
 drivers/usb/gadget/function/f_fs.c                                |   31 
 drivers/usb/gadget/function/f_mass_storage.c                      |    2 
 drivers/usb/gadget/function/f_midi.c                              |    2 
 drivers/usb/gadget/function/f_midi2.c                             |   17 
 drivers/usb/gadget/functions.c                                    |    2 
 drivers/usb/gadget/legacy/inode.c                                 |    3 
 drivers/usb/host/xhci-debugfs.c                                   |   21 
 drivers/usb/host/xhci-hub.c                                       |  117 +--
 drivers/usb/host/xhci-mem.c                                       |   34 
 drivers/usb/host/xhci-pci.c                                       |    6 
 drivers/usb/host/xhci-ring.c                                      |   40 -
 drivers/usb/host/xhci-tegra.c                                     |   12 
 drivers/usb/host/xhci-trace.h                                     |    5 
 drivers/usb/host/xhci.c                                           |   81 +-
 drivers/usb/host/xhci.h                                           |   46 -
 drivers/usb/image/mdc800.c                                        |    4 
 drivers/usb/storage/ene_ub6250.c                                  |    2 
 drivers/usb/storage/realtek_cr.c                                  |    9 
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c               |    2 
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c                |    5 
 drivers/usb/typec/tcpm/tcpm.c                                     |   28 
 drivers/usb/typec/tipd/core.c                                     |   17 
 drivers/usb/typec/tipd/tps6598x.h                                 |    4 
 drivers/usb/typec/ucsi/displayport.c                              |    2 
 drivers/watchdog/pseries-wdt.c                                    |   53 -
 drivers/xen/balloon.c                                             |   56 +
 fs/afs/callback.c                                                 |    1 
 fs/ceph/caps.c                                                    |   63 +
 fs/ceph/crypto.c                                                  |   46 +
 fs/ceph/mds_client.c                                              |   71 +-
 fs/ceph/mds_client.h                                              |    2 
 fs/ceph/super.h                                                   |   13 
 fs/erofs/zutil.c                                                  |    2 
 fs/f2fs/data.c                                                    |    5 
 fs/f2fs/dir.c                                                     |    7 
 fs/f2fs/file.c                                                    |  154 +++-
 fs/f2fs/gc.c                                                      |    2 
 fs/f2fs/inline.c                                                  |    2 
 fs/f2fs/namei.c                                                   |   17 
 fs/f2fs/node.c                                                    |    9 
 fs/f2fs/sysfs.c                                                   |    7 
 fs/f2fs/xattr.c                                                   |    2 
 fs/fuse/args.h                                                    |   65 +
 fs/fuse/cuse.c                                                    |    7 
 fs/fuse/dev.c                                                     |   44 -
 fs/fuse/dev_uring.c                                               |  187 +++--
 fs/fuse/file.c                                                    |   22 
 fs/fuse/fuse_i.h                                                  |   53 -
 fs/fuse/inode.c                                                   |   10 
 fs/lockd/svcsubs.c                                                |    2 
 fs/nfsd/filecache.c                                               |  115 +--
 fs/nfsd/netns.h                                                   |   11 
 fs/nfsd/nfs4proc.c                                                |  139 +++
 fs/nfsd/nfs4state.c                                               |  170 +++-
 fs/nfsd/nfsctl.c                                                  |   25 
 fs/nfsd/nfsd.h                                                    |   15 
 fs/nfsd/state.h                                                   |    2 
 fs/notify/fanotify/fanotify_user.c                                |   12 
 fs/notify/inotify/inotify_user.c                                  |   15 
 fs/ntfs3/frecord.c                                                |   20 
 fs/ocfs2/dir.c                                                    |   71 +-
 fs/overlayfs/dir.c                                                |    1 
 fs/pidfs.c                                                        |  136 ++-
 fs/smb/client/cifs_debug.c                                        |    4 
 fs/smb/client/cifs_spnego.h                                       |    2 
 fs/smb/client/cifs_unicode.h                                      |    3 
 fs/smb/client/cifsfs.c                                            |    5 
 fs/smb/client/cifsfs.h                                            |    6 
 fs/smb/client/cifsglob.h                                          |   10 
 fs/smb/client/cifsproto.h                                         |   29 
 fs/smb/client/cifssmb.c                                           |  146 ++++
 fs/smb/client/compress.c                                          |   21 
 fs/smb/client/compress.h                                          |   19 
 fs/smb/client/connect.c                                           |  142 ----
 fs/smb/client/dir.c                                               |    2 
 fs/smb/client/dns_resolve.h                                       |    4 
 fs/smb/client/fs_context.c                                        |    2 
 fs/smb/client/fs_context.h                                        |   16 
 fs/smb/client/fscache.h                                           |   10 
 fs/smb/client/inode.c                                             |   61 +
 fs/smb/client/misc.c                                              |    1 
 fs/smb/client/netmisc.c                                           |    2 
 fs/smb/client/smb1ops.c                                           |  171 ----
 fs/smb/client/smb1proto.h                                         |   40 +
 fs/smb/client/smb1transport.c                                     |  198 +++++
 fs/smb/client/smb2file.c                                          |    3 
 fs/smb/client/smb2inode.c                                         |    1 
 fs/smb/client/smb2maperror.c                                      |    3 
 fs/smb/client/smb2ops.c                                           |   99 ++
 fs/smb/client/smb2pdu.c                                           |    5 
 fs/smb/client/smb2proto.h                                         |   14 
 fs/smb/client/trace.h                                             |  151 ++++
 fs/smb/server/oplock.c                                            |   61 +
 fs/smb/server/smb2pdu.c                                           |    7 
 include/linux/acpi.h                                              |   14 
 include/linux/firmware/qcom/qcom_scm.h                            |   10 
 include/linux/huge_mm.h                                           |    7 
 include/linux/hugetlb.h                                           |    5 
 include/linux/kprobes.h                                           |    1 
 include/linux/lockd/lockd.h                                       |    2 
 include/linux/memcontrol.h                                        |   10 
 include/linux/mm.h                                                |    2 
 include/linux/rmap.h                                              |    9 
 include/linux/soc/qcom/geni-se.h                                  |    4 
 include/net/dst.h                                                 |    6 
 include/net/ip.h                                                  |   25 
 include/net/ip6_route.h                                           |   43 +
 include/net/ipv6.h                                                |   10 
 include/net/tcp.h                                                 |    5 
 kernel/bpf/percpu_freelist.c                                      |   35 
 kernel/bpf/percpu_freelist.h                                      |    1 
 kernel/bpf/stackmap.c                                             |  173 +++-
 kernel/bpf/verifier.c                                             |   81 +-
 kernel/dma/direct.c                                               |   18 
 kernel/entry/syscall-common.c                                     |    3 
 kernel/futex/requeue.c                                            |   12 
 kernel/kprobes.c                                                  |   14 
 kernel/sched/core.c                                               |   60 +
 kernel/sched/deadline.c                                           |    8 
 kernel/sched/ext.c                                                |   17 
 kernel/sched/fair.c                                               |    4 
 kernel/sched/idle.c                                               |    2 
 kernel/sched/rt.c                                                 |    8 
 kernel/sched/sched.h                                              |   12 
 kernel/sched/stop_task.c                                          |    2 
 kernel/trace/ftrace.c                                             |   13 
 kernel/trace/ring_buffer.c                                        |   20 
 mm/damon/core.c                                                   |   22 
 mm/damon/ops-common.c                                             |    5 
 mm/damon/paddr.c                                                  |   20 
 mm/damon/sysfs-schemes.c                                          |   18 
 mm/damon/sysfs.c                                                  |   23 
 mm/damon/tests/core-kunit.h                                       |   15 
 mm/damon/tests/vaddr-kunit.h                                      |    5 
 mm/damon/vaddr.c                                                  |   34 
 mm/huge_memory.c                                                  |  354 +++++-----
 mm/hugetlb.c                                                      |   25 
 mm/hugetlb_cgroup.c                                               |    7 
 mm/hugetlb_vmemmap.c                                              |  296 +++-----
 mm/memcontrol-v1.c                                                |   43 -
 mm/memcontrol.c                                                   |   13 
 mm/mempolicy.c                                                    |    2 
 mm/migrate.c                                                      |   12 
 mm/mm_init.c                                                      |    1 
 mm/page_alloc.c                                                   |    6 
 mm/page_vma_mapped.c                                              |    8 
 mm/rmap.c                                                         |   15 
 mm/slab.h                                                         |    8 
 mm/slab_common.c                                                  |   44 +
 mm/slub.c                                                         |  106 +-
 mm/sparse-vmemmap.c                                               |   53 -
 mm/userfaultfd.c                                                  |    4 
 mm/vmscan.c                                                       |   41 -
 net/8021q/vlan.c                                                  |    7 
 net/8021q/vlan_dev.c                                              |   32 
 net/batman-adv/bridge_loop_avoidance.c                            |   15 
 net/batman-adv/distributed-arp-table.c                            |    8 
 net/batman-adv/main.c                                             |    4 
 net/batman-adv/multicast_forw.c                                   |    7 
 net/core/skbuff.c                                                 |    5 
 net/ipv4/icmp.c                                                   |    2 
 net/ipv4/ip_output.c                                              |    4 
 net/ipv4/ip_sockglue.c                                            |    2 
 net/ipv4/ipmr.c                                                   |    2 
 net/ipv4/netfilter/nf_reject_ipv4.c                               |    2 
 net/ipv4/route.c                                                  |    4 
 net/ipv4/tcp_ipv4.c                                               |   15 
 net/ipv4/tcp_minisocks.c                                          |    2 
 net/ipv4/tcp_output.c                                             |    6 
 net/ipv6/exthdrs.c                                                |   55 -
 net/ipv6/ip6_gre.c                                                |    2 
 net/ipv6/ip6_output.c                                             |   47 -
 net/ipv6/ip6_tunnel.c                                             |    6 
 net/ipv6/ipv6_sockglue.c                                          |    4 
 net/ipv6/route.c                                                  |   10 
 net/ipv6/sit.c                                                    |    2 
 net/ipv6/tcp_ipv6.c                                               |   11 
 net/openvswitch/conntrack.c                                       |  121 ++-
 net/openvswitch/conntrack.h                                       |    6 
 net/openvswitch/datapath.c                                        |   10 
 net/openvswitch/datapath.h                                        |    8 
 net/packet/af_packet.c                                            |   96 ++
 net/sunrpc/auth_gss/gss_rpc_xdr.c                                 |    9 
 net/sunrpc/xprtrdma/ib_client.c                                   |   24 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c                           |   12 
 net/sunrpc/xprtrdma/svc_rdma_rw.c                                 |    5 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                          |   32 
 rust/kernel/bug.rs                                                |   10 
 rust/kernel/drm/ioctl.rs                                          |    6 
 samples/damon/mtier.c                                             |   14 
 samples/damon/prcl.c                                              |   11 
 samples/damon/wsse.c                                              |   11 
 security/integrity/ima/ima_appraise.c                             |    2 
 sound/core/pcm_native.c                                           |    2 
 sound/core/rawmidi.c                                              |    2 
 sound/parisc/harmony.c                                            |    6 
 sound/soc/codecs/aw88261.c                                        |   30 
 sound/soc/codecs/aw88261.h                                        |    6 
 sound/soc/codecs/cs35l33.c                                        |   14 
 sound/soc/codecs/cs35l34.c                                        |   14 
 sound/soc/codecs/hdac_hda.c                                       |    4 
 sound/soc/fsl/fsl_easrc.c                                         |    2 
 sound/soc/fsl/mpc5200_psc_i2s.c                                   |    1 
 sound/soc/intel/atom/sst/sst_pci.c                                |    4 
 sound/soc/loongson/loongson_card.c                                |    6 
 sound/soc/samsung/aries_wm8994.c                                  |    1 
 sound/usb/midi.c                                                  |    2 
 tools/objtool/check.c                                             |    3 
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c             |  155 ++--
 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c           |   47 -
 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h           |   12 
 tools/sched_ext/scx_qmap.bpf.c                                    |    2 
 tools/testing/cxl/Kbuild                                          |    1 
 480 files changed, 6983 insertions(+), 4022 deletions(-)

Abdifatah Suruur (1):
      ksmbd: fix use-after-free in oplock break notification

Abhijit Gangurde (1):
      RDMA/ionic: Embed counter driver data in rdma_counter allocation

Ahmad Byagowi (1):
      i2c: mux: Fix channel node leak on adapter add failure

Akari Tsuyukusa (1):
      clk: mediatek: mt8196: Select REGMAP_MMIO for vlpckgen

Aleksandr Nogikh (1):
      usb: gadget: midi2: Fix null-pointer dereference in f_midi2_free_ep_reqs

Ali Ahmet Memis (1):
      mfd: qnap-mcu: keep the reply buffer alive past a command timeout

Ali Tariq (1):
      PCI: starfive: Fix resource leaks on error paths in host_init()

Amit Barzilai (2):
      drm/ssd130x: fix column and row end address in partial updates for ssd132x
      drm/ssd130x: fix column and row end address in partial updates in ssd133x

Amit Machhiwal (1):
      KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode

Amit Sunil Dhamne (1):
      usb: typec: tcpm: constrain TCPM_SOURCING_VBUS event handling

Andy Shevchenko (1):
      usb: f_mass_storage: Bump local buffer size in fsg_common_create_luns()

Aneesh Kumar K.V (Arm) (1):
      dma-direct: return struct page from dma_direct_alloc_from_pool()

Anthony Krowiak (9):
      s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()
      s390/vfio-ap: Fix stale do_remove flag across iterations in vfio_ap_mdev_cfg_remove
      s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
      s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL
      s390/vfio-ap: Fix hot-unplug skipped when last AP adapter or domain removed
      s390/vfio-ap: Fix missing lock required to access list of ap_matrix_mdev objects
      s390/vfio-ap: Fix NULL deref in status_show() during queue probe
      s390/vfio-ap: fix potential use of uninitialized apm_filtered bitmap
      s390/vfio-ap: Fix required lock not held during update of ap_matrix_mdev object

Anton Protopopov (1):
      bpf: fix the return value of push_stack

Antoniu Miclaus (1):
      iio: adc: adi-axi-adc: add data size support for AD408X backend

Arash Golgol (1):
      media: vimc: fix pixel format lookup in enum_framesizes

Arthur Gautier (1):
      xhci: fix lost bounce buffers on TDs spanning several ring segments

Babanpreet Singh (1):
      iio: dac: ad3552r-hs: fix scnprintf() buffer bound in data source show

Bibo Mao (1):
      LoongArch: Fix acpi_package_ids[] array overflow

Binbin Zhou (1):
      ASoC: loongson: Fix error handling in ACPI property parsing

Biren Pandya (4):
      media: cec: disable delayed work before freeing an interrupted transmit
      media: i2c: ov02a10: fix endpoint parsing use-after-free
      media: i2c: ov7740: fix use-after-destroy in remove
      media: v4l2-fwnode: Fix fwnode leak in v4l2_fwnode_parse_link

Bradley Morgan (1):
      ima: Check for ERR_PTR from dentry_path() in validate_hash_algo()

Brendan Jackman (1):
      mm/page_alloc: don't spin_trylock() in NMI on UP

Breno Leitao (1):
      usb: xhci: bail out of setup if the controller is inaccessible

Bryam Vargas (3):
      nvdimm/btt: reject an arena whose nfree is below the lane count
      media: cx231xx: reject geometry changes while the VBI queue is busy
      smb: client: reject a tree connect response whose byte count is too small

Bryan Lim (1):
      userfaultfd: reset err to be 0 when move_pages_ptes succeeded

Bryan O'Donoghue (1):
      media: iris: Enumerate cap->bus_info to differentiate between encoder and decoder

Can Peng (6):
      thermal/drivers/imx: Disable clock on runtime resume failure
      thermal/drivers/qoriq: Disable clock on resume failure
      spi: bcm63xx-hsspi: disable clocks on resume failure
      spi: bcm63xx: disable clock on resume failure
      spi: bcmbca-hsspi: disable clocks on resume failure
      iio: pressure: mpl115: Fix runtime PM cleanup

Carlos López (1):
      KVM: x86: hyper-v: Clamp stimer deadline to avoid livelock

Chaithanya Lagisetty (1):
      LoongArch: KVM: Free init resources if kvm_init() fails

Chao Yu (7):
      f2fs: fix to avoid move_range and defragment on device_alias file
      f2fs: fix to avoid potential section-unaligned pinfile
      f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()
      f2fs: fix to off-by-one issue in f2fs_zero_post_eof_page()
      f2fs: fix to clear dirty flag on folio in error path
      f2fs: fix to pass folio->index to f2fs_sanity_check_node_footer()
      f2fs: fix to zero post-EOF data when extending file size

Chen Changcheng (1):
      f2fs: fix valid block count leak on data block allocation failure

Chen Linxuan (1):
      pidfd: hold exec_update_lock around namespace ioctl

Chris Mason (1):
      SUNRPC: fix gssx_dec_option_array error path bugs

Christian Borntraeger (9):
      KVM: s390: Fix length check __import_wp_info()
      KVM: s390: Fix memory leak in guest debug handling
      KVM: s390: Fix old_data leak in guest debug error path
      KVM: s390: Free guest debug data on vcpu destroy
      KVM: s390: Take srcu when importing watchpoint data
      KVM: s390: Zero initialize irq in reinject_machine_check
      KVM: s390: Fix memory corruption by not reinjecting CK machine checks
      KVM: s390: pv: Fix rc/rrc offset for PVM_DUMP
      KVM: s390: Restore sigset on error path

Christian Brauner (2):
      pidfs: simplify PIDFD_GET_<type>_NAMESPACE ioctls
      pidfs: protect PIDFD_GET_* ioctls() via ifdef

Christian Hewitt (1):
      media: meson: vdec: fix NULL pointer deref in vdec_try_fmt_common

Christian Loehle (1):
      ACPI: CPPC: Reject desired_perf reads on _CPC revision 4+

Christian Marangi (1):
      pmdomain: airoha: fix unselectable AIROHA_CPU_PM_DOMAIN kconfig

Chuck Lever (11):
      NFSD: Guard admin state-revocation walks with NFSD_NET_UP
      svcrdma: Release transport resources synchronously
      svcrdma: Reorder rpcrdma_rn_unregister before rdma_destroy_id
      rpcrdma: arm rn_done before publishing the notification
      svcrdma: Reject oversized Read segments at decode time
      svcrdma: Reject Read lists that exceed the page budget
      NFSD: Prevent client use-after-free during delegation revoke
      NFSD: Prevent client use-after-free during admin state revocation
      NFSD: Consolidate the revocation-path client unpin
      NFSD: Prevent client use-after-free during blocked-lock reaping
      NFSD: Prevent client use-after-free during close_lru reaping

Cong Nguyen (4):
      iio: adc: pac1921: fix wrong channel used in trigger handler read
      iio: gyro: mpu3050: fix sign of raw angular velocity readings
      iio: srf04: fix pm_runtime handling on probe error path
      media: intel/ipu6: fix async notifier cleanup leak on parse error

Daeho Jeong (1):
      f2fs: fix to migrate all curseg types during free_segment_range

Damien Le Moal (1):
      block: flag zoned disks with GENHD_FL_NO_PART

Dan Williams (1):
      dax/cxl, hmem: Initialize hmem early and defer dax_cxl binding

Danilo Krummrich (2):
      rust: drm: ioctl: fix unbounded lifetimes in ioctl handler arguments
      drm: fix race between partial drm_dev_register() failure and ioctl

Dapeng Mi (1):
      perf/x86/intel: Fix kernel address leakages in LBR stack

Dave Jiang (1):
      cxl/mce: Make the MCE notifier per-region

Dave Stevenson (1):
      media: imx355: Avoid calling imx355_power_off twice in error path

David (Ming Qiang) Wu (1):
      drm/amdgpu/vcn: fix integer overflow in dec_msg buffer count check

David Howells (9):
      afs: Fix leak of ungot volume
      cifs: Scripted clean up fs/smb/client/cifs_unicode.h
      cifs: Scripted clean up fs/smb/client/fscache.h
      cifs: Scripted clean up fs/smb/client/fs_context.h
      cifs: Scripted clean up fs/smb/client/smb2proto.h
      cifs: Remove dead function prototypes
      cifs: SMB1 split: Create smb1proto.h for SMB1 declarations
      cifs: SMB1 split: Separate out SMB1 decls into smb1proto.h
      cifs: Do some preparation prior to organising the function declarations

Dawei Feng (1):
      media: cedrus: fix memory leak in cedrus_init_ctrls()

Deepanshu Kartikey (2):
      drm/i915: Guard against NULL driver_data in i915_pci_probe()
      drm/gud: NUL-terminate TV mode names read from the device

Dev Jain (2):
      mm/page_vma_mapped: use huge_ptep_get() for hugetlb
      mm/rmap: use huge_ptep_get() in try_to_migrate_one()

Diego Fernando Mancera Gomez (1):
      media: em28xx: defer audio-only extension registration

Dikshita Agarwal (1):
      media: qcom: iris: fix state-change debug log printing stale value

Doruk Tan Ozturk (2):
      HID: sony: clean up device list on probe failure
      ocfs2: validate directory-index entry counts when reading metadata

Elson Serrao (1):
      usb: dwc3: clear forceRM when issuing EndTransfer

Eric Dumazet (7):
      mm/mempolicy: fix sleeping allocation in alloc_pages_bulk_weighted_interleave()
      vlan: fix skb_under_panic and races when toggling HW VLAN offload
      ipv6: pass proto by value to ipv6_push_nfrag_opts() and ipv6_push_frag_opts()
      ipv6: add some unlikely()/likely() clauses in ip6_output.c
      inet: add dst4_mtu() and dst6_mtu() helpers
      ipv6: use dst6_mtu() instead of dst_mtu()
      ipv4: use dst4_mtu() instead of dst_mtu()

Erick Henrique (1):
      iio: dac: m62332: Fix regulator reference count imbalance

FUJITA Tomonori (2):
      objtool/rust: add one more `noreturn` Rust function
      rust: bug: prevent dead_code warning from warn_on!'s flags constant

Faith Ekstrand (1):
      drm/nouveau: Use write-combined maps for coherent

Fan Wu (6):
      usb: typec: qcom-pmic-typec: disable cc_debounce_dwork on stop
      usb: typec: qcom-pmic-typec: drain cc_debounce_dwork if port_start() fails
      usb: typec: qcom-pmic: cancel reset_work on stop
      iio: chemical: atlas-sensor: use iio_trigger_poll_nested() to fix remove UAF
      media: cx23885: cancel NetUP CI work before teardown
      power: supply: ab8500_fg: fix use-after-free on remove

Florian Pradines (1):
      HID: mcp2221: fix OOB write in mcp2221_raw_event()

Frank Sorenson (4):
      cifs: add cifs_resize_file_locked() to guard fscache_resize_cookie() under i_rwsem
      smb: client: fix UAF and buffer leak in cifs_check_trans2() for malformed secondary T2
      smb: client: fix OOB read/write from unvalidated DataOffset in coalesce_t2()
      cifs: add fscache_resize_cookie() to cifs_setsize()

Fuad Tabba (2):
      KVM: arm64: vgic: Reset in_kernel on private IRQ allocation failure
      KVM: arm64: vgic-its: Don't dereference a NULL collection on ITT save

Gabriel Prostitis (1):
      USB: gadget: ffs: fix mm lifetime handling

Giorgi Tchankvetadze (1):
      iio: light: cm32181: return zero after writing calibscale

Giovanni Cabiddu (1):
      crypto: iaa - fall back to software for multi-entry scatterlists

Greg Kroah-Hartman (1):
      Linux 6.18.51

Griffin Kroah-Hartman (1):
      usb: image: mdc800: change kmalloc() to kzalloc()

Guanghui Yang (1):
      f2fs: fix dentry folio leak in find_in_level

Guangshuo Li (3):
      media: platform: mtk-mdp3: Fix SCP device refcounting
      media: saa7164: fix cleanup on resource allocation failure
      drm/amdgpu: fix autosuspend cleanup during removal

Guoniu Zhou (3):
      media: nxp: imx8-isi: Fix stream ID validation bypass in crossbar routing
      media: nxp: imx8-isi: Correct color map between V4L2 and ISI
      media: nxp: imx8-isi: Use BIT_ULL() for 64-bit stream masks

HE WEI（ギカク） (1):
      fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()

Hajo Noerenberg (1):
      ata: ahci: work around lost interrupts on Marvell 88SE61xx

Hal Feng (1):
      PCI: starfive: Use regulator APIs to control the 3v3 power supply of PCIe slots

Han Gao (1):
      LoongArch: Add DIRECT_MAP_PHYSMEM_END definition

Hans Verkuil (1):
      media: cec: extron-da-hd-4k-plus: add sanity check

Hao-Qun Huang (1):
      f2fs: reject overlapping move range after len expansion

Haoxiang Li (4):
      ASoC: fsl: mpc5200-i2s: Free DMA resources on probe failure
      ASoC: hdac_hda: Fix hlink refcount leak on component registration failure
      AsoC: intel: sst: fix PCI device reference leak on probe failure
      cpufreq: apple-soc: Fix OPP table cleanup

Hari Mishal (1):
      drm/amd/display: fix division by zero in get_estimated_bw()

Harry Wentland (2):
      drm/amd/display: avoid divide-by-zero in __is_lut_linear()
      drm/amd/display: validate plane degamma LUT size for private color prop

Heiko Stuebner (1):
      clk: rockchip: rk3588: Don't change PLL rates when setting dclk_vop2_src

Helge Deller (1):
      parisc: Fix alignment of asm statements in head.S

Hongbo Yao (1):
      i2c: designware: Enable interrupt mask workaround for HJMC3001

Honghui Jiang (1):
      spi: Fix DMA mapping ownership on partial map failure

Hui Su (1):
      bpf: Fix infinite loop in pcpu_freelist push with one possible CPU

Huiwen He (2):
      smb/client: reduce fallocate zero buffer allocation
      smb/client: emulate small EOF-extending mode 0 fallocate ranges

Hungyu Lin (1):
      media: qcom: iris: use disable_irq() during power-off

HyeongJun An (3):
      ALSA: usb-audio: fix OOB write in snd_usbmidi_us122l_output()
      ALSA: rawmidi: Return the error from snd_rawmidi_input_params()
      media: s2255: bound JPEG frame size before copying into the buffer

Ibrahim Hashimov (1):
      HID: wacom: validate report length in wacom_intuos_pro2_bt_irq

Ilya Krutskih (1):
      media: tda18250: fix possible integer overflow

Ivy Lopez (1):
      usb: gadget: f_midi2: fix use-after-free in string attribute show path

Jackson Lee (2):
      media: chips-media: wave5: Guard bit depth check with initial_info_obtained
      media: chips-media: wave5: Set inst->std during default format initialization

Jameson Thies (1):
      usb: typec: ucsi: displayport: Fix OOB altmode array index

Jeff Layton (8):
      nfsd: check nfsd4_acl_to_attr() return value in nfsd4_create()
      nfsd: move struct nfsd_genl_rqstp to nfsctl.c
      nfsd: widen nfsd_genl_rqstp address fields to sockaddr_storage
      nfsd: fix clock domain mismatch in clients_still_reclaiming()
      nfsd: fix fcache_disposal UAF by inlining dispose state into nfsd_net
      nfsd: fix UAF in async copy cancel and shutdown
      nfsd: close shrinker/GC/fsnotify vs per-net shutdown race in filecache
      nfsd: convert global state_lock to per-net deleg_lock

Jeffin Philip (2):
      usb: gadget: f_midi: initialize work in f_midi_alloc()
      usb: gadget: fix null pointer dereference in usb_put_function_instance()

Jiangong.Han (1):
      media: em28xx: fix use-after-free of dev_next->devlist on disconnect

Jiangshan Yi (2):
      HID: mcp2221: clear rxbuf after I2C/SMBus transfer completes
      smb: client: clear setuid/setgid bit on write with cifsacl/modefromsid/posix extensions

Jiayuan Chen (1):
      net: advertise TCP MSS from the configured MTU, not the learned PMTU

Jinjie Ruan (3):
      entry: Fix seccomp bypass after ptrace with TSYNC
      powerpc/kexec_file: Fix null-ptr-def in extra size calculation
      powerpc/kexec_file: Prevent kexec range truncation

Jiri Olsa (5):
      bpf: Factor stackid_init function from __bpf_get_stackid
      bpf: Factor stackid_fastpath function from __bpf_get_stackid
      bpf: Factor stackid_new_bucket from __bpf_get_stackid
      bpf: Use stack id functions instead of __bpf_get_stackid
      bpf: Disable preemption in bpf_get_stackid

Joanne Chang (1):
      f2fs: dirty directory inodes on mtime/ctime update

Joanne Koong (7):
      fuse: publish io-uring queues with release semantics
      fuse: fix missing barrier when checking io-uring readiness
      fuse-uring: refactor io-uring header copying to ring
      fuse-uring: refactor io-uring header copying from ring
      fuse-uring: use enum types for header copying
      fuse-uring: refactor setting up copy state for payload copying
      fuse-uring: use named constants for io-uring iovec indices

Johan Hovold (3):
      media: platform: mtk-mdp3: fix NULL deref on failed SCP lookup
      drm/bridge: dw-hdmi: fix i2c adapter leak on probe failure
      drm/panel-edp: fix i2c adapter leak on probe failure

John Stultz (2):
      sched: Add assert_balance_callbacks_empty helper
      sched: Rework prev_balance() to avoid stale prev references

Jonas Karlman (1):
      media: cec: core: Fix kmemleak due to missed rc_free_device() call

Jorijn van der Graaf (1):
      ASoC: codecs: aw88261: only check PLL and clock state at power-up

Joseph Qi (1):
      ocfs2: validate dx_root extent list fields during block read

Joshua Crofts (1):
      iio: adc: max34408: add missing 'select REGMAP_I2C' to Kconfig

Ju Nan (1):
      irqchip/stm32mp-exti: Fix the unit of the hwspinlock timeout

Jérémy Jean (1):
      LoongArch: Avoid preempt count underflow without probe

Kairui Song (2):
      mm/mglru: use the common routine for dirty/writeback reactivation
      mm/mglru: fix and remove redundant unevictable folio handling

Kajetan Puchalski (1):
      KVM: arm64: vgic: Fix detection of MI on no pending LR

Kanala Ramalingeswara Reddy (1):
      drm/amdgpu: Skip accessing psp rum time db for APUs

Kanishka De Silva (1):
      ublk: clear VM_MAYWRITE on read-only ublk char device mmap

Karl Mehltretter (1):
      arm64: mm: Fix the lockless page-table walk in show_pte()

Kathiravan Thirumoorthy (1):
      i2c: qcom-geni: update frequency table to fix timing parameters

Kavan Smith (1):
      drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value

Kazuki Hanai (1):
      nvmet-auth: Synchronize timeout work during SQ teardown

Khushit Shah (1):
      arm64: errata: pass REVIDR when matching target implementation CPUs

Kiryl Shutsemau (3):
      mm/hugetlb: refactor code around vmemmap_walk
      mm: rework compound_head() for power-of-2 sizeof(struct page)
      hugetlb: remove VMEMMAP_SYNCHRONIZE_RCU

Kiryl Shutsemau (Meta) (1):
      mm/hugetlb: defer vmemmap population for bootmem hugepages

Koichiro Den (3):
      dmaengine: dw-edma: Fix HDMA channel status register access
      dmaengine: dw-edma: Complete descriptors before pausing
      dmaengine: dw-edma: Initialize IRQ data before requesting IRQs

Kyle Zeng (1):
      net/packet: defer vmalloc TX_RING free until skbs finish

Lad Prabhakar (4):
      rtc: rzn1: Handle EPROBE_DEFER for optional pps interrupt
      rtc: rzn1: Fix weekday underflow when alarm crosses month boundary
      rtc: rzn1: Handle unset alarm weekday in rzn1_rtc_read_alarm
      rtc: rzn1: Disable alarm interrupt before reprogramming alarm registers

Lars-Peter Clausen (3):
      iio: buffer: Fix potential use-after-free in anonymous buffer release
      iio: buffer: Make IIO DMA fence release RCU-safe
      iio: buffer: Tie IIO dma fence lock lifetime to the fence

Laxman Acharya Padhya (1):
      iio: light: gp2ap002: Disable regulators on resume failure

Lei Huang (1):
      media: s2255: check firmware size before reading trailing marker

Li Xiasong (1):
      mm/slub: fix missing debugfs entries for caches created before sysfs init

Linkai Gong (4):
      cpuidle: dt_idle_genpd: kfree() the original name allocation
      i2c: mux: demux-pinctrl: fix OF node leak on kstrdup failure
      drm/amd/display: fix dc_lock leak on GPU reset error paths
      scsi: fnic: Use GFP_ATOMIC for VLAN alloc under spinlock

Linmao Li (1):
      iio: chemical: sgp30: Handle IAQ thread creation failure

Linus Torvalds (1):
      drm/xe: Don't hand out the flat CCS storage as usable VRAM

Liu Qi (1):
      usb-storage: ene_ub6250: fix race between scan work and probe

Longlong Xia (2):
      mm/hugetlb: keep max_huge_pages when dissolving surplus folios
      zram: fix out-of-bounds access in read_block_state()

Lovekesh Solanki (1):
      USB: gadget: fix NULL pointer dereference in gadget_dev_ioctl()

Lyude Paul (1):
      drm/nouveau/disp/r535: Add scanline position support + head state support

Marc Zyngier (6):
      KVM: arm64: Consider SCTLR_EL2.M when mapping the L1 VNCR page
      KVM: arm64: Handle negative S1 walk levels in VNCR TLB size evaluation
      KVM: arm64: Correctly handle end of VA space TLBI invalidation
      KVM: arm64: Make VNCR invalidation participate in MMU invalidation retry
      KVM: arm64: Sign-extend VA for range-based TLBI invalidation
      KVM: arm64: Correctly cap TLBI Range to the architural limit

Marek Czernohous (1):
      drm/nouveau: unsubscribe the channel-kill event before the fence context

Mario Limonciello (1):
      drm/amd: Drop calls to restore power limit and clock from smu_resume()

Martin Blumenstingl (1):
      clk: meson: align gxbb_32k_clk_sel number of parents with actual count

Martin Hecht (1):
      media: i2c: alvium: Fix: Correct name of register in alvium_set_ctrl_auto_exposure

Martin Kaiser (1):
      dmaengine: fsl-edma: tracing: no ptr dereference during log output

Masami Hiramatsu (Google) (1):
      kprobes: Protect kprobe_blacklist with RCU

Matthew Auld (1):
      drm/xe/vram: report FLAT_CCS base misalignment

Matthew Wilcox (Oracle) (1):
      migrate: replace RMP_ flags with TTU_ flags

Max Kellermann (2):
      ceph: lock mutex in ceph_mds_check_access()
      ceph: force a cap message when a deferred revoke can't be acked immediately

Michael Bommarito (1):
      ceph: cap delegated inode count in ceph_parse_deleg_inos()

Miklos Szeredi (3):
      fuse: split off fuse_args and related definitions into a separate header
      fuse: remove fm arg of args->end callback
      fuse: fix race between interrupt and resend

Mikulas Patocka (2):
      dm: fix race when loading and unloading a table
      dm: fix resume-vs-remove race

Ming Qian (2):
      media: amphion: Remove obsolete frame_count check in venc_start_session
      media: v4l2-ctrls: Allow unknown HDR10 white point and luminance

Mohamed Ahmed (8):
      drm/nouveau/gsp: use per-version DP_CONFIG_STREAM params on r570 firmware
      drm/nouveau/disp: move GSP head-timing ISR and vblank helpers to tu102.c
      drm/nouveau/disp: move the GSP HDMI GCP AVMute write to engine/disp
      drm/nouveau/disp: route GSP-RM display MMIO through nvkm_disp_func hooks
      drm/nouveau/disp: fix HDMI vendor infoframes on GB20x
      drm/nouveau/disp: fix HDMI GCP AVMute register offsets on GB20x
      drm/nouveau/disp: fix head state readback on GB20x
      drm/nouveau/gsp: fix vblank interrupts on GB20x

Mohammed EL Kadiri (2):
      media: venus: fix payload size returned by parse_caps() and parse_alloc_mode()
      media: venus: fix payload size calculation in parse_raw_formats()

Moksh Panicker (1):
      iio: chemical: atlas-sensor: fix PM reference leak in buffer postenable

Muchun Song (6):
      powerpc/mm: fix wrong addr_pfn tracking in compound vmemmap population
      mm/hugetlb: initialize gigantic bootmem hugepage struct pages earlier
      mm/hugetlb_vmemmap: fix __hugetlb_vmemmap_optimize_folios()
      mm: thp: introduce folio_split_queue_lock and its variants
      mm: thp: use folio_batch to handle THP splitting in deferred_split_scan()
      mm/hugetlb_vmemmap: fix incorrect vmemmap restore in rollback

Muhammad Bilal (2):
      staging: rtl8723bs: fix OOB read / stack overflow in rtw_get_wps_attr()
      staging: rtl8723bs: fix OOB read in rtw_action_frame_parse()

Mukesh Ojha (2):
      firmware: qcom_scm: Rename peripheral as pas_id
      remoteproc: qcom: pas: Guard dtb metadata release with dtb_pas_id check

Myeonghun Pak (2):
      usb: storage: realtek_cr: fix use-after-free on disconnect
      media: rc: sunxi-cir: Unregister rc device on probe failure

Namjae Jeon (1):
      ksmbd: zero pipe read compound padding

Narasimharao Vadlamudi (3):
      media: i2c: imx415: Release runtime PM reference on VBLANK error
      media: i2c: imx415: Return test pattern write errors
      media: rkvdec: Propagate platform_get_irq() errors

Narek Jilavyan (1):
      mm/hugetlb_cgroup: call page_counter_set_max() outside VM_BUG_ON()

Nathan Chancellor (1):
      LoongArch: Do not select HAVE_RUST when KASAN is enabled

Neill Kapron (1):
      usb: gadget: f_fs: Fix Use-After-Free in AIO error path

Nikhil Gautam (4):
      iio: light: opt4001: Fix power down clearing bits of the wrong register
      iio: light: opt4001: Fix incompatible pointer type passed to div_u64_rem()
      iio: light: opt4001: Reject integration times with a non-zero seconds part
      iio: light: opt4001: Fix reversed GENMASK() arguments in fault count mask

Nikhil Gurudasani (1):
      erofs: skip sufficiently large global buffers when resizing

Niklas Cassel (1):
      nvme-fc: fix double free of fabrics options when nvme_add_ctrl() fails

Niklas Neronin (6):
      usb: xhci: add tracing for PORTSC register writes
      usb: xhci: add helper to read PORTSC register
      usb: xhci: add USB Port Register Set struct
      usb: xhci: implement USB Port Register Set struct
      usb: xhci: use cached HCSPARAMS1 value
      usb: xhci: simplify handling of Structural Parameters 1 values

Nilesh Javali (28):
      scsi: qla2xxx: Zero SFP DMA buffer in FRU/I2C bsg handlers
      scsi: qla2xxx: Bound i2c->length in I2C bsg handlers
      scsi: qla2xxx: edif: Fix NULL pointer deref in RX SA delete check
      scsi: qla2xxx: Fix Name Server logout detection on FWI2 adapters
      scsi: qla2xxx: Hold vport reference in qla24xx_report_id_acquisition()
      scsi: qla2xxx: Initialize NVMe abort_work once at submission
      scsi: qla2xxx: Check entry_status in qla24xx_modify_vp_config()
      scsi: qla2xxx: Bound image count in qla2x00_update_fru_versions()
      scsi: qla2xxx: Hold qpair lock when sending NVMe LS reject
      scsi: qla2xxx: Clamp MSI-X derived queue counts to avoid truncation
      scsi: qla2xxx: Serialize flash version read in reset handler
      scsi: qla2xxx: Fix cs84xx use-after-free on host teardown
      scsi: qla2xxx: Fix FCE trace use-after-free during firmware dump
      scsi: qla2xxx: Zero mailbox struct in qla2x00_get_firmware_state()
      scsi: qla2xxx: Fix FCE trace enable parsing in debugfs
      scsi: qla2xxx: Don't query firmware state while chip is down
      scsi: qla2xxx: Reject non-SCSI SRB on status IOCB fast path
      scsi: qla2xxx: Fix response queue over-consumption in __qla_consume_iocb()
      scsi: qla2xxx: Quiesce response IRQ before freeing request queue
      scsi: qla2xxx: Avoid double completion in async IOCB timeout
      scsi: qla2xxx: Bound rsp_info_len to avoid OOB sense-data read
      scsi: qla2xxx: Avoid req_q_map double-read in qla2x00_error_entry()
      scsi: qla2xxx: Fix NVMe abort reference leak on repeated abort
      scsi: qla2xxx: Drop vport reference under lock in report ID acquisition
      scsi: qla2xxx: Hold vport_slock for host map update in report ID acquisition
      scsi: qla2xxx: Use coherent DMA buffer for D_Port diagnostics
      scsi: qla2xxx: Zero-init bsg stack buffers to avoid info leak
      scsi: qla2xxx: Skip NVMe LS reject IOCB when FW not started

Nirbhay Sharma (1):
      fs/ntfs3: fix KMSAN uninit-value in ni_create_attr_list

Norbert Szetei (1):
      net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()

Osama Abdelkader (2):
      drm/panthor: harden firmware build-info bounds checks
      drm/panthor: fix firmware control interface bounds checks

Oscar Ou (1):
      lockd: fix swapped arguments in nlmsvc_match_ip()

Pan Chuang (1):
      power: supply: ab8500_fg: Remove redundant dev_err()/dev_err_probe()

Paul Geurts (1):
      iio: ti-ads7138: Disable STATS_EN bit while reading conversion results

Pavel Löbl (1):
      clk: clocking-wizard: fix integer overflow in rate calculation

Pei Xiao (1):
      parisc: eisa: Fix infinite loop when parsing invalid IRQ value

Pengpeng Hou (4):
      Input: aiptek - validate raw macro indices before updating state
      mtd: afs: validate v2 image info bounds
      mtd: nand: realtek-ecc: add missing MODULE_DEVICE_TABLE()
      mtd: rawnand: validate ONFI extended parameter page sections

Phil Rosenthal (1):
      KVM: x86/mmu: Consume the locked rmap value in the lockless rmap walk

Priya Hosur (1):
      drm/amdkfd: Add TLB flush after MES queue eviction/suspension

Qihang (1):
      KVM: arm64: vgic-v3: take an LPI reference in vgic_v3_save_pending_tables

Rafael J. Wysocki (4):
      ACPI: x86: cmos_rtc: Create a CMOS RTC platform device
      ACPI: x86/rtc-cmos: Use platform device for driver binding
      ACPI: TAD: Rearrange RT data validation checking
      ACPI: TAD: Add locking around AML evaluations

Robin Murphy (1):
      iommu/arm-smmu-v3: Add HAFT support for SVA

Roger Pau Monne (2):
      xen/balloon: improve accuracy of initial balloon target for dom0
      x86/xen: fix init of balloon stats again

Rosalie Wanders (1):
      HID: sony: use guard() and scoped_guard()

Runyu Xiao (4):
      scsi: pm8001: Use rollback index when freeing MSI-X vectors
      ALSA: harmony: initialize locks before requesting IRQ
      ASoC: cs35l33: drain threaded IRQ before runtime suspend
      ASoC: cs35l34: drain threaded IRQ before runtime suspend

Ruoyu Wang (3):
      media: cec: Serialize exclusive follower delivery
      media: cobalt: Avoid freeing ALSA private data twice
      media: zoran: Avoid freeing a registered video_device twice

Rupesh Majhi (1):
      iio: pressure: dps310: fix NULL pointer dereference on ACPI probe

SJ Park (23):
      mm/damon/vaddr-kunit: check region count in three_regions test
      samples/damon/mtier: handle damon_start() failure
      samples/damon/mtier: handle damon_stop() failure
      samples/damon/prcl: handle damon_start() failure
      samples/damon/prcl: stop and free damon ctx when damon_call() fails
      samples/damon/wsse: handle damon_start() failure
      samples/damon/wsse: stop and free damon ctx when damon_call() fails
      mm/damon/sysfs-schemes: kobject_del() scheme action destination dirs
      mm/damon/sysfs-schemes: kobject_del() scheme dirs
      mm/damon/sysfs-schemes: kobject_del() scheme filter dirs
      mm/damon/sysfs-schemes: kobject_del() scheme quota goal dirs
      mm/damon/sysfs-schemes: kobject_del() scheme region dirs
      mm/damon/sysfs: kobject_del() region and target (error) dirs
      mm/damon/sysfs: kobject_del() target (normal), context and kdamond dirs
      mm/damon/core-kunit: check region count before testing in split_at()
      mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
      mm/damon/vaddr: drop last same folio access check optimization
      mm/damon/paddr: drop last same folio access check reuse optimization
      mm/damon/ops-common: use nr_accesses moving sum for quota score
      mm/damon/core: skip aging from repeated aggressive merging
      mm/damon/sysfs: read addr_unit only once in damon_sysfs_apply_inputs()
      mm/damon/core-kunit: handle region split failure in filter_out()
      mm/damon/core: initialize damos->last_applied

Sam Edwards (1):
      ceph: properly decrypt filenames in vmalloc() buffers

Sanjay Chitroda (1):
      iio: temperature: hid-sensor-temperature: switch to non-devm iio_device_register()

Sean Christopherson (8):
      KVM: nVMX: Decouple INVVPID operand checks from flushing of vpid02
      KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is cleared on VM-Exit
      KVM: x86/mmu: Fold kvm_mmu_zap_memslot() into kvm_arch_flush_shadow_memslot()
      KVM: x86/mmu: Split kvm_mmu_zap_all_fast() into "front" and "back" halves
      KVM: x86/mmu: Use CMPXCHG when clearing Accessed bit in TDP MMU
      KVM: x86/mmu: Use split "zap all fast" helpers when invalidating memslot
      KVM: x86: Serialize writes to disabled_quirks using kvm->lock
      KVM: x86: Ensure runtime reads of disabled_quirks are resolved once

Sergey Senozhatsky (5):
      zram: fixup read_block_state()
      zram: take write lock in wb limit store handlers
      zram: drop wb_limit_lock
      zram: read slot block idx under slot lock
      zram: set default primary compressor in zram_destroy_comps()

Shakeel Butt (2):
      memcg: bypass the reclaim and oom killer for dying tasks once oom_reaper is done
      memcg: make the v1 soft limit knob inert

Shen Yongchao (1):
      HID: bpf: serialize device reference release in struct_ops destroy path

Shivam Kumar (2):
      nvmet-tcp: fix out-of-bounds write when receiving an over-long PDU
      nvmet-tcp: reject unsolicited H2CData PDUs

Shixiong Ou (2):
      drm/sysfb: ofdrm: Fix integer overflow in fb_size calculation
      drm/sysfb: ofdrm: Fix is_avivo() constant comparison bug

Shuangpeng Bai (2):
      media: usbtv: keep device alive while ALSA card exists
      media: go7007: defer the ALSA v4l2 put until card release

Sizhe Liu (1):
      perf hisi-ptt: Fix PTT trace TLP header parsing

Smita Koralahalli (1):
      cxl/region: Add helper to check Soft Reserved containment by CXL regions

Song Hu (1):
      Docs/ABI/damon: fix typo in intervals_goal sysfs path

Sourabh Jain (3):
      powerpc/pseries: Handle and log pseries-wdt registration failures
      powerpc/pseries: Move H_WATCHDOG definitions to a common header
      powerpc/crash: stop watchdogs before booting kdump kernel

Stephan Gerhold (8):
      clk: qcom: gcc-mdm9607: Increase delay for USB PHY reset
      clk: qcom: gcc-msm8916: Fix enable_reg for gcc_blsp1_sleep_clk
      clk: qcom: gcc-msm8939: Fix enable_reg for gcc_blsp1_sleep_clk
      clk: qcom: gcc-mdm9607: Drop incorrect apss_tcu_clk_src
      clk: qcom: gcc-mdm9607: Drop incorrect system_noc_bfdcd_clk_src
      clk: qcom: gcc-mdm9607: Fix enable_reg for gcc_blsp1_sleep_clk
      clk: qcom: gcc-mdm9607: Fix halt_reg for gcc_apss_axi_clk
      clk: qcom: gcc-mdm9607: Drop incorrect BIMC PLL and related clocks

Steven Rostedt (1):
      ftrace: Synchronize the initialization of ftrace_ops

Sujal Tuladhar (1):
      scsi: target: iscsi: Reserve a terminator byte for the login payload

Sun Jian (1):
      fsnotify: inotify: pass mark connector to fsnotify_recalc_mask()

Sunday Clement (1):
      drm/amdkfd: Reject zero-sized AQL queue allocations after size halving

Sunil Khatri (3):
      drm/amdgpu: update the fw version for gfx11 userqueues
      drm/amdgpu: update the fw version for gfx12 userqueues
      drm/amdgpu: use AMDGPU_GPU_PAGE_SHIFT instead of PAGE_SHIFT

Sven Eckelmann (5):
      batman-adv: mcast: ensure unshared skb for multicast packets
      batman-adv: mcast: linearize skbuff for packet generation
      batman-adv: dat: avoid unaligned fault in IP extraction
      batman-adv: bla: fix freeing of claims on meshif deletion
      batman-adv: bla: prevent CRC corruptions after claim flush

Sven Peter (1):
      usb: typec: tipd: Fix Thunderbolt altmode VDOs for cd321x

Takashi Iwai (1):
      ALSA: pcm: Fix race between non-atomic ops and trigger-start

Tao Cui (1):
      LoongArch: KVM: Fix TOCTOU race on pv_features

Tao Yu (1):
      drm/gud: validate TV mode names before creating enum property

Tejun Heo (2):
      sched_ext: Fix inverted ops.core_sched_before() invocation
      sched/core: Make core-sched flips wait for in-flight selections

Terry Bowman (3):
      cxl/pci: Move CXL driver's RCH error handling into core/ras_rch.c
      cxl/ras: Fix cxl_rch_get_aer_info() out-of-bounds AER register read
      cxl/ras: Fix cxl_rch_get_aer_severity() wrong severity register

Thadeu Lima de Souza Cascardo (1):
      drm: Fix drm_crtc_commit leak if signaled when PAGE_FLIP_EVENT is used

Thomas Hellström (1):
      drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()

Thomas Lamprecht (1):
      scsi: megaraid_sas: Limit NVMe request size to the PRP chain frame

Thomas Zimmermann (5):
      drm/hibmc: Fix list of formats on the primary plane
      drm/hibmc: Use drm_atomic_helper_check_plane_state()
      drm/sysfb: simpledrm: Improve framebuffer-size validation
      drm/sysfb: simpledrm: Improve panel-size validation
      drm/sysfb: simpledrm: Improve stride validation

Thorsten Blum (3):
      crypto: atmel-ecc - replace min_t with min
      crypto: atmel-ecc - clean up and improve ECDH comments
      crypto: atmel-ecc - avoid stale fallback key after set_secret failure

Tiezhu Yang (2):
      LoongArch: BPF: Optimize redundant TCC loads in epilogue
      LoongArch: BPF: Refactor jump offset calculation in tail call

Tommaso Merciai (1):
      media: rzg2l-cru: Align bytesperline to hardware DMA stride requirement

Tristan Madani (1):
      nvme: add missing SRCU grace period in error path

Uday Khare (1):
      media: video-i2c: fix kthread error pointer left in kthread_vid_cap on failure

Ulf Hansson (1):
      cpuidle: psci: Fix support for probe deferral by dropping the faux device

Val Packett (1):
      ASoC: codecs: aw88261: reduce log spam

Valery Borovsky (3):
      media: airspy: use vb2_video_unregister_device() on disconnect to fix NULL deref
      media: rtl2832_sdr: use vb2_video_unregister_device() on remove to fix DMA leak
      media: rtl2832_sdr: release URBs and stream buffers on start_streaming() failure

Vasileios Almpanis (1):
      i2c: core: fix debugfs UAF on adapter removal

Vidhu Sarwal (3):
      iio: light: ltrf216a: fix runtime PM reference leak in error path
      iio: light: opt4060: Reject integration times with a non-zero seconds part
      iio: light: opt4060: Fix incorrect register name in threshold read error message

Viken Dadhaniya (1):
      soc: qcom: geni-se: Use HW PROG_RAM_DEPTH to validate firmware size

Viktor Malik (2):
      perf trace: Factor out BPF loop body
      perf trace: Refactor augmented_raw_syscalls using bpf_for

Vincent Donnefort (1):
      ring-buffer: Make cpu_buffer::free_page a buffer_data_read_page

Vinicius Costa Gomes (1):
      crypto: iaa - unmap dst before software fallback on decompress

Vivek Parikh (1):
      ovl: fix double end_creating() on the casefold-mismatch path

Vladimir Marioukhine (1):
      drm/amdkfd: guard against NULL restore_mqd in CRIU queue restore

Vlastimil Babka (1):
      mm/slab: move and refactor __kmem_cache_alias()

Wei Jie Law (1):
      HID: rmi: fix OOB access with undersized RMI reports

WenTao Liang (1):
      ASoC: samsung: aries_audio_probe: double of_node_put due to direct assignment without of_node_get

Wenjie Qi (4):
      f2fs: return symlink writeback errors
      f2fs: only redirty pinned folios in redirty_blocks
      f2fs: return writeback error from collapse range
      f2fs: avoid NULL checkpoint thread access in sysfs

Wentao Guan (1):
      LoongArch: Do not save/restore percpu base register in rethook trampoline

Wentao Liang (1):
      drm/sun4i: fix refcount leak in sun4i_backend_init_sat()

Wupeng Ma (1):
      mm/hugetlb: fix missing migratable flag on same-node hugetlb migration

Xiang Liu (1):
      drm/amdgpu: clamp the isolation index for rings outside a partition

Xiang Mei (1):
      fuse: copy request headers via a stack buffer for io-uring

Xiaogang Chen (2):
      drm/amdkfd: Fix error path at svm_migrate_copy_to_ram
      drm/amdkfd: Fix the case that vm range is hole at svm_migrate_copy_to_vram

Xu Rao (3):
      nvme-fabrics: fix DHCHAP secret leak on parse failure
      mtd: mtdoops: free page bitmap when the backing MTD is removed
      media: v4l2-async: avoid deleting unlinked ASC entry on link error

Yang Wang (2):
      drm/amdgpu: check thunderbolt before switcheroo registration
      drm/amdgpu: Disable runtime PM for externally attached dGPUs

Yao Kai (1):
      futex: Prevent rcuwait use-after-free during requeue PI

Yehyeong Lee (1):
      nvme-tcp: check the data direction of a C2HData PDU

Yi Ding (1):
      media: cec: meson: ao-cec-g12a: name the CEC core regmap to avoid debugfs clash

Yong Wang (1):
      tcp: clamp route advmss to TCP_MIN_MSS

Yosry Ahmed (3):
      KVM: nVMX: Always flush vpid02 on first use
      KVM: nVMX: Service local TLB flushes on failed nested VM-Enter
      KVM: nVM: Ensure INVVPID is emulated on the correct physical CPU

Youngjae Kwon (1):
      fsnotify: Fix stale object mask after concurrent mark updates

Yuqi Xu (1):
      openvswitch: Fix CT limit teardown use-after-free

Yuwen Chen (1):
      zram: fix the issue that the write - back limits might overflow

Zeng Chi (2):
      LoongArch: KVM: Fix PC double advance in kernel MMIO read fast path
      LoongArch: KVM: Preserve memslot arch flags on KVM_MR_FLAGS_ONLY

Zhan Xusheng (2):
      f2fs: use the mount idmap for the owner check in f2fs_xattr_advise_set()
      f2fs: fix i_size when pinned fallocate partially fails

ZhangGuoDong (1):
      smb: move some definitions from common/smb2pdu.h into common/fscc.h

Zhenhao Wan (3):
      drm/nouveau/uvmm: fix NULL deref unwinding an OP_MAP_SPARSE op
      drm/nouveau/uvmm: fix premature region free on failed OP_UNMAP_SPARSE
      drm/nouveau/uvmm: clear the dirty flag when unwinding an OP_UNMAP_SPARSE

Zhiling Zou (1):
      batman-adv: fix stale receive device on merged fragments

Zi Yan (3):
      mm/huge_memory: change folio_split_supported() to folio_check_splittable()
      mm/huge_memory: replace can_split_folio() with direct refcount calculation
      mm/huge_memory: use folio's memcg inside __folio_split()

caina (1):
      Revert "irqchip/mbigen: Fix mbigen node address layout"

fangqiurong (1):
      sched_ext: Fix exit_task leak on fork failure during enable

wangdicheng (1):
      ASoC: fsl_easrc: Use div64_u64 for 64-by-64 division

