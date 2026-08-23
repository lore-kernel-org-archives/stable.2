Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAAD31F99A;
	Sun, 23 Aug 2026 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787489226; cv=none; b=osjcOauq4HrTlOYZEiaLXwdPeAOijY4Mvg/Wy/x6eD+oqRrXrrIlAW3LfvhzCtKsVggVeTsS4EYVHmCAv9ASbcpe+JDtPENDq9jbtiyhyCkQ5XoE+WF5v6EJN9nJT1oVSGWBQD/6Yzz6PFKWNuGhR9WfG2PmM+cn2IaXk5JVlqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787489226; c=relaxed/simple;
	bh=umJjV8LHd/TljDpEGMCe4jneeQXnU+4KbnYuLUdXX6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eRox4rDOcw46bf4i0JYvrYi9ndBVGt0eUHKIgbi4yUb1hu8pqx0EmFtB0AuBRX867JHuaN8Shhs1TOkBLQTDIYytK4/yhLaOUjDrX4yacs1/2wnQmliZAQ4smQ8aHwFlW8pR6Wntl0JyVzf0+G16Asq2oukN9MxAtlDsUYcgyds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QiagzwRu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QiagzwRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4B11F00A3E;
	Sun, 23 Aug 2026 12:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787489221;
	bh=YQHVOdQBD6diFKGJaRSSlq+mj6RJL9f4yLLcwxto4Fk=;
	h=From:To:Cc:Subject:Date;
	b=QiagzwRuASeZWYi3qZ3e7n0SpJa5q2e4pnoQZnu5iW58nuCtzfNGMK7qQEEVzYtYh
	 ZRJj+/q9EuclesoNKD33qr3QQFq2CWE21X8z7HtYOG8yIxWrzY2go2E348MKavhUU1
	 95nyW7E2Wwd2lS1ZAc738gU04tRAYRc+PIf2bes8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.1.10
Date: Sun, 23 Aug 2026 14:45:13 +0200
Message-ID: <2026082314-entomb-singing-a2be@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.1.10 kernel.

All users of the 7.1 kernel series must upgrade.

The updated 7.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                            |    2 
 arch/arm64/boot/dts/nvidia/tegra194.dtsi                            |    2 
 arch/m68k/Kconfig.cpu                                               |    4 
 arch/microblaze/kernel/head.S                                       |    2 
 arch/openrisc/include/asm/processor.h                               |    2 
 arch/openrisc/kernel/signal.c                                       |    5 
 arch/powerpc/platforms/pseries/lparcfg.c                            |    2 
 arch/powerpc/platforms/pseries/papr-phy-attest.c                    |   12 
 arch/powerpc/platforms/pseries/pci.c                                |    2 
 arch/riscv/kernel/ftrace.c                                          |    5 
 arch/riscv/kernel/unaligned_access_speed.c                          |    8 
 arch/riscv/lib/strnlen.S                                            |   10 
 block/genhd.c                                                       |   12 
 crypto/ccm.c                                                        |    2 
 drivers/accel/amdxdna/aie2_ctx.c                                    |   16 
 drivers/base/regmap/regmap-sdw-mbq.c                                |    4 
 drivers/clk/qcom/dispcc-eliza.c                                     |    2 
 drivers/clk/spacemit/ccu-k3.c                                       |    4 
 drivers/crypto/qce/core.c                                           |    2 
 drivers/crypto/starfive/jh7110-aes.c                                |    2 
 drivers/crypto/tegra/tegra-se-aes.c                                 |   22 
 drivers/firewire/ohci.c                                             |    4 
 drivers/gpio/gpio-ml-ioh.c                                          |   71 +
 drivers/gpio/gpio-sloppy-logic-analyzer.c                           |    2 
 drivers/gpio/gpiolib.c                                              |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                              |   31 
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c                    |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                          |   50 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c                       |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c                             |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                             |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c                           |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c                             |   85 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                              |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                              |    5 
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c                              |   48 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c                            |   21 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c                            |   21 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c                            |   21 
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c                            |   42 -
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                               |   26 
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c                               |    9 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                   |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c              |    2 
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c               |   31 
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c                  |    7 
 drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c            |    7 
 drivers/gpu/drm/clients/drm_log.c                                   |   12 
 drivers/gpu/drm/display/drm_hdmi_state_helper.c                     |    3 
 drivers/gpu/drm/drm_gem_shmem_helper.c                              |    6 
 drivers/gpu/drm/mediatek/mtk_dsi.c                                  |   32 
 drivers/gpu/drm/panthor/panthor_fw.c                                |    3 
 drivers/gpu/drm/radeon/radeon_fence.c                               |    7 
 drivers/gpu/drm/radeon/radeon_kms.c                                 |    1 
 drivers/gpu/drm/xe/xe_bo.h                                          |   14 
 drivers/gpu/drm/xe/xe_device.c                                      |    6 
 drivers/gpu/drm/xe/xe_guc_ads.c                                     |   93 +-
 drivers/gpu/drm/xe/xe_guc_ads_types.h                               |    5 
 drivers/gpu/drm/xe/xe_guc_pc.c                                      |   43 +
 drivers/gpu/drm/xe/xe_lrc.c                                         |    7 
 drivers/gpu/drm/xe/xe_oa.c                                          |   13 
 drivers/gpu/drm/xe/xe_pxp.c                                         |  162 +++-
 drivers/gpu/drm/xe/xe_pxp_types.h                                   |   27 
 drivers/input/joystick/iforce/iforce-packets.c                      |   11 
 drivers/input/joystick/iforce/iforce-usb.c                          |    3 
 drivers/input/joystick/psxpad-spi.c                                 |    1 
 drivers/input/joystick/xpad.c                                       |    2 
 drivers/input/keyboard/atkbd.c                                      |   20 
 drivers/input/misc/cs40l50-vibra.c                                  |   10 
 drivers/input/mouse/byd.c                                           |    2 
 drivers/input/mouse/focaltech.c                                     |    2 
 drivers/input/rmi4/rmi_f54.c                                        |   43 -
 drivers/input/rmi4/rmi_f55.c                                        |    4 
 drivers/input/touchscreen/hynitron_cstxxx.c                         |   13 
 drivers/input/touchscreen/sur40.c                                   |   23 
 drivers/mmc/host/atmel-mci.c                                        |    2 
 drivers/mmc/host/loongson2-mmc.c                                    |    8 
 drivers/mmc/host/omap_hsmmc.c                                       |    2 
 drivers/mmc/host/sdhci.c                                            |   16 
 drivers/mmc/host/sdhci.h                                            |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                           |  133 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                           |    3 
 drivers/net/ethernet/google/gve/gve_ptp.c                           |    6 
 drivers/net/ethernet/google/gve/gve_rx_dqo.c                        |    5 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                            |    2 
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c                       |    4 
 drivers/net/ipvlan/ipvlan_main.c                                    |    4 
 drivers/net/macvlan.c                                               |    4 
 drivers/net/ovpn/crypto.c                                           |   26 
 drivers/net/ovpn/crypto.h                                           |    4 
 drivers/net/ovpn/crypto_aead.c                                      |   19 
 drivers/net/ovpn/crypto_aead.h                                      |    1 
 drivers/net/ovpn/io.c                                               |   10 
 drivers/net/ovpn/main.c                                             |   19 
 drivers/net/ovpn/ovpnpriv.h                                         |    4 
 drivers/net/ovpn/peer.c                                             |    8 
 drivers/net/ovpn/tcp.c                                              |    9 
 drivers/net/phy/realtek/realtek_main.c                              |    2 
 drivers/net/tap.c                                                   |    3 
 drivers/net/veth.c                                                  |    2 
 drivers/pmdomain/arm/scmi_perf_domain.c                             |    2 
 drivers/pmdomain/mediatek/mt8183-pm-domains.h                       |    7 
 drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c                        |    2 
 drivers/pmdomain/mediatek/mtk-pm-domains.c                          |   30 
 drivers/pmdomain/qcom/rpmhpd.c                                      |    4 
 drivers/regulator/fp9931.c                                          |   54 -
 drivers/s390/cio/vfio_ccw_async.c                                   |   16 
 drivers/s390/cio/vfio_ccw_chp.c                                     |   31 
 drivers/s390/cio/vfio_ccw_cp.c                                      |   74 +-
 drivers/s390/cio/vfio_ccw_cp.h                                      |   10 
 drivers/s390/cio/vfio_ccw_drv.c                                     |   21 
 drivers/s390/cio/vfio_ccw_fsm.c                                     |    8 
 drivers/s390/cio/vfio_ccw_ops.c                                     |   39 -
 drivers/s390/cio/vfio_ccw_private.h                                 |   10 
 drivers/s390/crypto/zcrypt_ccamisc.c                                |   20 
 drivers/s390/crypto/zcrypt_ep11misc.c                               |   16 
 drivers/s390/crypto/zcrypt_msgtype6.c                               |  366 ++++++----
 drivers/s390/net/qeth_core_main.c                                   |    3 
 drivers/s390/net/qeth_l3_main.c                                     |    5 
 drivers/scsi/scsi_error.c                                           |    6 
 drivers/spi/spi-virtio.c                                            |    2 
 drivers/tee/optee/ffa_abi.c                                         |    3 
 drivers/ufs/core/ufshcd.c                                           |    4 
 drivers/video/fbdev/core/fb_io_fops.c                               |    8 
 drivers/video/fbdev/core/fbmem.c                                    |    5 
 drivers/video/fbdev/core/fbsysfs.c                                  |   15 
 fs/ceph/caps.c                                                      |   17 
 fs/ceph/file.c                                                      |    9 
 fs/ceph/mds_client.c                                                |   11 
 fs/ceph/mds_client.h                                                |    1 
 fs/ceph/mdsmap.c                                                    |    2 
 fs/erofs/Kconfig                                                    |    3 
 fs/xfs/libxfs/xfs_exchmaps.c                                        |   10 
 fs/xfs/libxfs/xfs_rtrefcount_btree.c                                |    4 
 fs/xfs/libxfs/xfs_sb.c                                              |    4 
 fs/xfs/scrub/agheader.c                                             |    2 
 fs/xfs/scrub/agheader_repair.c                                      |  152 +++-
 fs/xfs/scrub/alloc.c                                                |    5 
 fs/xfs/scrub/attr_repair.c                                          |    3 
 fs/xfs/scrub/bmap.c                                                 |    5 
 fs/xfs/scrub/dirtree_repair.c                                       |   22 
 fs/xfs/scrub/inode_repair.c                                         |    2 
 fs/xfs/scrub/nlinks.c                                               |   13 
 fs/xfs/scrub/nlinks_repair.c                                        |    7 
 fs/xfs/scrub/parent.c                                               |    2 
 fs/xfs/scrub/rtbitmap_repair.c                                      |   46 -
 fs/xfs/scrub/tempfile.c                                             |    1 
 fs/xfs/scrub/trace.h                                                |    2 
 fs/xfs/xfs_buf_item_recover.c                                       |   57 +
 fs/xfs/xfs_dquot.c                                                  |    3 
 fs/xfs/xfs_dquot_item_recover.c                                     |    2 
 fs/xfs/xfs_rtalloc.c                                                |    2 
 include/linux/rseq_entry.h                                          |    1 
 include/linux/tick.h                                                |    2 
 include/net/ip_vs.h                                                 |    2 
 include/net/netdev_lock.h                                           |    6 
 include/net/sctp/auth.h                                             |    3 
 include/scsi/scsi_host.h                                            |    6 
 kernel/events/core.c                                                |    8 
 kernel/pid.c                                                        |    6 
 kernel/trace/ftrace.c                                               |   33 
 lib/rhashtable.c                                                    |    2 
 net/ceph/cls_lock_client.c                                          |   13 
 net/ceph/decode.c                                                   |   18 
 net/ceph/osd_client.c                                               |    5 
 net/ceph/osdmap.c                                                   |    5 
 net/core/dev.c                                                      |   26 
 net/core/dev_addr_lists.c                                           |    2 
 net/core/link_watch.c                                               |    2 
 net/core/lock_debug.c                                               |    2 
 net/core/netdev_queues.c                                            |    2 
 net/ethtool/netlink.c                                               |    4 
 net/ipv4/tcp_input.c                                                |    6 
 net/ipv4/tcp_timer.c                                                |    4 
 net/ipv6/addrconf.c                                                 |    2 
 net/l2tp/l2tp_debugfs.c                                             |    4 
 net/l2tp/l2tp_ppp.c                                                 |   56 +
 net/mptcp/fastopen.c                                                |    7 
 net/mptcp/options.c                                                 |   67 +
 net/mptcp/pm.c                                                      |    6 
 net/mptcp/protocol.c                                                |    6 
 net/mptcp/protocol.h                                                |    1 
 net/netfilter/ipset/ip_set_bitmap_gen.h                             |    2 
 net/netfilter/ipset/ip_set_core.c                                   |   19 
 net/netfilter/ipset/ip_set_list_set.c                               |   10 
 net/netfilter/ipvs/ip_vs_core.c                                     |   11 
 net/netfilter/ipvs/ip_vs_xmit.c                                     |    3 
 net/netfilter/nf_flow_table_core.c                                  |    7 
 net/netfilter/nf_tables_offload.c                                   |    2 
 net/packet/af_packet.c                                              |    7 
 net/sched/act_api.c                                                 |   10 
 net/sched/cls_bpf.c                                                 |   18 
 net/sched/cls_u32.c                                                 |    3 
 net/sctp/auth.c                                                     |   75 ++
 net/sctp/sm_make_chunk.c                                            |    3 
 net/tls/tls_sw.c                                                    |    5 
 net/unix/garbage.c                                                  |    1 
 net/xdp/xsk_buff_pool.c                                             |    2 
 security/selinux/ss/policydb.c                                      |   34 
 security/selinux/ss/services.c                                      |   28 
 sound/hda/codecs/realtek/alc662.c                                   |    1 
 sound/soc/codecs/cs35l41-lib.c                                      |    2 
 sound/soc/codecs/cs35l45-tables.c                                   |   32 
 sound/soc/codecs/cs4265.c                                           |    4 
 sound/soc/codecs/lpass-tx-macro.c                                   |    4 
 sound/soc/codecs/lpass-wsa-macro.c                                  |    8 
 sound/soc/codecs/tas2562.c                                          |    9 
 sound/soc/codecs/tas2781-i2c.c                                      |   18 
 sound/soc/intel/common/sof-function-topology-lib.c                  |    7 
 sound/soc/sof/ipc4-pcm.c                                            |   25 
 sound/soc/sof/ipc4-topology.c                                       |   33 
 sound/soc/sof/sof-audio.c                                           |    9 
 sound/soc/xilinx/xlnx_formatter_pcm.c                               |   10 
 sound/usb/quirks.c                                                  |    2 
 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc |   27 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                     |    4 
 216 files changed, 2502 insertions(+), 929 deletions(-)

Abel Vesa (1):
      pmdomain: qcom: rpmhpd: Add missing MXC and MMCX power domains for Eliza

Abhishek Rajput (1):
      drm/mediatek: Convert legacy DRM logging to drm_* helpers in mtk_dsi.c

Ajrat Makhmutov (1):
      ALSA: hda/realtek: Enable headset mic on F+ FLAPTOP r

Aleksandr Nogikh (1):
      firewire: ohci: fix NULL pointer dereference in ar_context_release

Alex Deucher (3):
      drm/amdgpu/gmc12.1: implement tlb inv semaphore
      drm/amdgpu/gmc12.1: fix MMHUB0 check in pasid tlb flush
      drm/amdgpu: fix missing check in vm_flush()

Alexey Velichayshiy (1):
      netfilter: nf_tables_offload: suppress WARN_ON_ONCE for ENOMEM in abort path

Ali Ahmet Memis (1):
      openrisc: signal: do not restore privileged SR bits on sigreturn

Andrey Golovko (1):
      regmap: sdw-mbq: don't call an unset readable_reg callback

AngeloGioacchino Del Regno (2):
      pmdomains: mediatek: Avoid setting RTFF's CLK_DIS before NRESTORE
      drm/mediatek: mtk_dsi: Enable HS clock only at pre-enable

Asad Kamal (1):
      drm/amdgpu: fix aperture iounmap skipped on device removal

Bard Liao (1):
      ASoC: SOF: topology: Use acpi mach from the machine driver

Binbin Zhou (1):
      mmc: loongson2: Fix sg iteration in data reorder functions

Bryam Vargas (6):
      selinux: require every boolean value to be defined
      selinux: reject a class permission count below its inherited common
      selinux: do not cancel a policy conversion that never started
      selinux: reject an unclaimed class value in security_get_classes()
      selinux: reject a permission value exceeding the class permission count
      Input: synaptics-rmi4 - bound the F54 report size to the allocated buffer

Candice Li (2):
      drm/amdgpu: reject oversized IBs with per-ring packet limits
      drm/amdgpu: validate GEM_CREATE domain combinations

Cengiz Can (1):
      gpio: sloppy-logic-analyzer: fix use-after-free via debugfs trigger on unbind

Chao Shi (1):
      block: stop the timeout timer when releasing a never added disk

Charles Keepax (1):
      regmap: sdw-mbq: Fix swap of timeout and retry times

Christian A. Ehrhardt (1):
      drm/shmem_helper: Check VMA boundaries for PMD mappings

Christoph Hellwig (1):
      xfs: check v5 superblock features early

Christophe Leroy (CS GROUP) (1):
      gpiolib: Check gc->get_direction() before calling gpiod_get_direction()

Chuck Lever (1):
      net/tls: Fail tls_sw_splice_read() after a failed async decrypt

Daniele Ceraolo Spurio (1):
      drm/xe/pxp: add termination on resume

Darrick J. Wong (18):
      xfs: mark nonzero sb_gquotino as corrupt on metadir filesystems
      xfs: check cowextsize in xrep_inode_cowextsize
      xfs: fix transaction block reservation in xrep_rtbitmap
      xfs: zero i_nlink before repair puts inode on unlinked list
      xfs: only check mergeability of bnobt records
      xfs: don't double-lock when deleting a self-referential directory
      xfs: set the prev pointer when reinserting an inode on the unlinked list
      xfs: pass runtime errors from xrep_iunlink_mark_ondisk_rec up to callers
      xfs: nlink scrub must take IOLOCK before determining ILOCK state
      xfs: load next_agino from the correct xfarray in xrep_iunlink_relink_prev
      xfs: don't zap the attr fork on repair when there are queued pptr updates
      xfs: don't walk off the end of a null sc->sa.agi_bp in AGI repair
      xfs: fix allocated inodes that show up in the unlinked list
      xfs: fix another iunlink infinite loop bug in online fsck
      xfs: don't return EFSCORRUPTED when scrubbing corrupt parent pointers
      xfs: avoid UAF on sc->tempip in xrep_tempfile_create
      xfs: don't ignore runtime errors in xrep_iunlink_reload_next
      xfs: check xfarray iteration errors when committing unlinked inode lists

David Rosca (6):
      drm/amdgpu: Reject UVD message with invalid number of h265 refs
      drm/amdgpu: Reject UVD message with dimensions above 4096
      drm/amdgpu: Implement insert_end for VCE 3
      drm/amdgpu: Fix UVD min buffer sizes
      drm/amdgpu: Fix UVD dpb min size calculation for H264
      drm/amdgpu: Fix UVD decode image min size calculation

Dawid Wróbel (2):
      ASoC: codecs: lpass-tx-macro: Fix enum kcontrol accesses
      ASoC: codecs: lpass-wsa-macro: Fix enum kcontrol accesses

Dmitry Osipenko (1):
      pmdomain: mediatek: Fix mt8183 hang on boot

Dmitry Torokhov (6):
      Input: synaptics-rmi4 - fix F55 transmitter electrode count typo
      Input: synaptics-rmi4 - zero report size on F54 work error
      Input: synaptics-rmi4 - block s_input when F54 queue is busy
      Input: synaptics-rmi4 - propagate F54 worker errors to V4L2 queue
      Input: sur40 - fix input device registration ordering
      Input: sur40 - fix V4L error path cleanup

Donglin Lyu (1):
      Input: atkbd - skip deactivate for HONOR ZQC-P

Eric Dumazet (4):
      ipvlan: inherit needed_headroom and needed_tailroom from phy_dev
      macvlan: inherit needed_headroom and needed_tailroom from lowerdev
      af_packet: Don't send zero-byte data in tpacket_snd().
      l2tp: fix tunnel and session refcount leak on seq_file release

Eric Farman (10):
      s390/vfio_ccw: Free all memory if cp_init() fails
      s390/vfio_ccw: Limit the number of channel program segments
      s390/vfio_ccw: Cancel existing workqueues
      s390/vfio_ccw: Ensure index for read/write regions are within range
      s390/vfio_ccw: Ensure first IDAW remains constant
      s390/vfio_ccw: Fix out of bounds check on CCW array
      s390/vfio_ccw: Move cp cleanup out of not operational
      s390/vfio_ccw: Selectively expand io_mutex
      s390/vfio_ccw: Calculate idal length based on idaw type
      s390/vfio_ccw: Implement a crw lock

Florian Westphal (3):
      rhashtable: fix false-positive lockdep splat on rhltable destruction
      netfilter: ipset: fix list type element drift bug
      netfilter: ipset: let destroy callbacks adjust ext mem size

Gang Yan (1):
      selftests: mptcp: join: mark tests with data corruption as failed

Gao Xiang (1):
      erofs: fix EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS on some UP platforms

George Wilson (3):
      powerpc/pseries: pci - logic bug
      powerpc/pseries: lparcfg - fix kbuf[] underflow
      powerpc/pseries: papr-phy-attest - validate cmd.length, plug mem leak

Greg Kroah-Hartman (1):
      Linux 7.1.10

Guanghui Yang (1):
      xfs: propagate errors from xfs_rtginode_load

Guangshuo Li (2):
      pmdomain: mediatek: fix remaining %pOF after of_node_put()
      drm/radeon: fix autosuspend cleanup during teardown

Haibo Chen (1):
      mmc: sdhci: make tuning_err a signed int

Harald Freudenberger (5):
      s390/zcrypt: Fix CPRB memory allocation in zcrypt misc code
      s390/zcrypt: Improve CCA CPRB length and overflow checks
      s390/zcrypt: Improve EP11 CPRB length and overflow checks
      s390/zcrypt: Improve EP11 CPRB domain handling with ASN.1 parsing
      s390/zcrypt: Pad trailing CCA or EP11 message with zeros

Herbert Xu (1):
      crypto: ccm - Set rfc4309 maxauthsize from child

Hidayath Khan (1):
      s390/qeth: validate user buffer length in SNMP and ARP query ioctls

Hongjie Fang (1):
      scsi: core: pair EH runtime PM get and put

HyeongJun An (1):
      Input: cs40l50-vibra - validate custom data from user space

Ibrahim Hashimov (1):
      xfs: bounds-check buffer log item's dirty bitmap

Jakub Kicinski (6):
      net: rename netdev_ops_assert_locked()
      net: expect instance lock in netdev_queue_get_dma_dev()
      eth: bnxt: cancel IRQ notifier before freeing affinity mask
      eth: bnxt: keep the aRFS rmap updated when TPH is enabled
      eth: bnxt: decrease indent in bnxt_request_irq()
      eth: bnxt: avoid deadlock when canceling IRQ affinity notifier

Jamal Hadi Salim (2):
      net/sched: act_api: fix TOCTOU NULL deref on a->goto_chain
      net/sched: cls_bpf: reject dev-bound programs bound to a different device

Jasper Wise (1):
      spi: virtio: mark device ready before registering the controller

Jesse Zhang (4):
      drm/amdgpu/userq: serialize queue map against GPU reset
      drm/amdgpu: fix JPEG v5.3.0 queue reset failure in DPG mode
      drm/amdgpu: fix JPEG v5.0.0 queue reset failure in DPG mode
      drm/amdgpu: fix JPEG v4.0.5 queue reset failure in DPG mode

Jia Yao (3):
      drm/xe/guc_ads: allocate UM queues in a separate BO
      drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
      drm/xe/guc_ads: use uncached mapping for UM queue BO

Jianing Li (1):
      Input: hynitron_cstxxx - validate touch count and finger IDs

Jiawen Wu (1):
      net: ngbe: fix NULL pointer dereference in non-MSI-X interrupt enabling

Jiayuan Chen (1):
      tcp: fix icsk_ack.ato bitfield overflow

John Harrison (1):
      drm/connector/hdmi: Fix out of bounds memory read

Jon Hunter (1):
      arm64: tegra: Add EL2 virtual timer interrupt for Tegra194

Jonas Köppeler (1):
      veth: fix queue index used to wake the peer txq in veth_poll

Jordan Rhee (2):
      gve: fix NULL dereference due to missing ptp adjfine
      gve: fix zero-length skb frag with header-split

Josh Poimboeuf (1):
      ftrace: Fix off-by-one fentry site disable in ftrace_free_mem()

Julian Anastasov (1):
      ipvs: revalidate ihl to prevent out-of-bounds access

Junjie Cao (2):
      gpio: ml-ioh: use raw_spinlock_t for the register lock
      gpio: ml-ioh: share the register lock across channels

Junrui Luo (1):
      drm/amdgpu: disallow multiple FENCE chunks in one submit

Jérémy Jean (3):
      sctp: validate cookie AUTH state before use
      netfilter: flowtable: publish GC-visible tuple last
      pid: reject allocations through dead ancestor pid namespaces

Karl Mehltretter (2):
      pmdomain: mediatek: mfg: initialize prev_o in mtk_mfg_attach_dev()
      tick: Include ktime.h and jiffies.h in linux/tick.h

Kefu Chai (1):
      libceph: tolerate addrvecs with multiple entries of the same type

Krzysztof Kozlowski (1):
      clk: qcom: dispcc-eliza: Fix disp_cc_mdss_mdp_clk_src RCG stall on Eliza EVK

Kuniyuki Iwashima (1):
      af_unix: Unlink scc_entry in unix_del_edge().

Kyle Zeng (1):
      perf: Reject exited events as group leaders

Kyohei Kadota (1):
      Input: xpad - add support for ZENAIM LEVERLESS

Leon Hwang (3):
      ftrace: Protect direct_functions in ftrace_find_rec_direct
      ftrace: Protect direct_functions in update_ftrace_direct_del
      ftrace: Protect direct_functions in update_ftrace_direct_mod

Lijo Lazar (2):
      drm/amdgpu: Use virtual alloc during coredump
      drm/amdgpu: Prefer default discovery offset

Lin Jiapeng (1):
      xfs: fix exchange-range reflink flag clearing issue with INO1_WRITTEN

Linmao Li (4):
      Input: psxpad-spi - set driver data before use
      Input: byd - synchronize timer deletion before freeing private data
      drm/xe/oa: Fix sync entry leak on OA config emit failure
      drm/xe/oa: Check managed mutex initialization errors

Lizhi Hou (1):
      accel/amdxdna: Skip unmapped range in aie2_populate_range()

Long Li (2):
      xfs: fix ilock leak on error in xfs_dq_get_next_id
      xfs: don't swallow dquot recovery verification errors

Mark Brown (1):
      ASoC: tas2562: Validate values for volume writes

Matthew Brost (1):
      drm/xe: Order ring writes before ring tail updates

Matthieu Baerts (NGI0) (2):
      mptcp: avoid combining some incoming suboptions
      mptcp: options: reset DSS fields in case of unexpected size

Max Kellermann (2):
      ceph: avoid fs reclaim while using current->journal_info
      ceph: fix hanging __ceph_get_caps() with stale mds_wanted

Melbin K Mathew (2):
      fbdev: bound mode sysfs output to the sysfs buffer
      fbdev: clear fb_info->mode before deleting a videomode

Michael Neuling (1):
      riscv: lib: Fix ZBB strnlen reading past count boundary

Mingyu Wang (1):
      fbdev: core: Fix pointer desynchronization in fb_io_read()

Mostafa Saleh (1):
      optee: ffa: Add NULL check in optee_ffa_lend_protmem

Myeonghun Pak (1):
      mmc: sdhci: unmap the bounce buffer before device release

Nareshkumar Gollakoti (1):
      drm/xe: Set GT rp min frequency as 1.2GHz default for BMG/CRI

Nathan Lucas (2):
      drm/amd/display: fix BT.2020 YCbCr limited output CSC matrix
      drm/amd/display: fix BT.2020 YCbCr output CSC matrices for DCE

Niels Pressel (1):
      rseq: Prevent hard lockup on granted time slice extension

Oleksij Rempel (1):
      net: phy: realtek: fix EEE advertisement write on the internal PHY MMD path

Osama Abdelkader (1):
      drm/panthor: skip zero-sized firmware sections

Paolo Abeni (1):
      mptcp: reclaim forward-allocated memory on RX path errors

Pavitra Jha (2):
      libceph: fix multiple unsafe decodes in decode_locker()
      libceph: fix OOB read in decode_watchers() via missing bounds check

Pei Xiao (1):
      mmc: atmel-mci: Fix use-after-free in atmci_remove due to race condition

Pengpeng Hou (1):
      Input: iforce - validate input packet lengths

Peter Ujfalusi (6):
      ASoC: SOF: sof-audio: Fix error path in sof_widget_setup_unlocked()
      ASoC: SOF: ipc4-pcm: Continue the pipeline trigger in case of IPC timeout
      ASoC: cs4265: sort the register default table
      ASoC: cs35l45: sort the register default table
      ASoC: cs35l41: sort the register default table
      ASoC: SOF: ipc4-topology: Refresh copier IPC payload before widget setup

Praveen Talari (1):
      pmdomain: arm: Fix -EINVAL from scmi_pd_set_perf_state() on state 0

Pu Lehui (1):
      riscv: ftrace: Fix ftrace_modify_call failure on kprobed functions

Qiang Ma (1):
      xfs: clear zapped attr fork state when bmap repair finds no attr fork

Qiang Yu (1):
      drm/amdgpu: read TRUNCATE_COORD_MODE on gfx12

Qing Luo (1):
      mptcp: pm: fix data race in add_addr timer callback

Raag Jadav (1):
      drm/xe: Fix xe_device_probe() failure

Ralf Lici (4):
      ovpn: fix NULL dereference when killing missing key
      ovpn: finish crypto callback cleanup before peer release
      ovpn: run deferred work on a module-owned workqueue
      ovpn: defer key slot crypto freeing to workqueue

Ramin Moussavi (1):
      microblaze: restore the page alignment of swapper_pg_dir

Raphael Zimmer (1):
      libceph: Avoid using invalid osd indices from primary_temp

Richard Davies (1):
      Input: focaltech - fix array out-of-bounds in focaltech_process_rel_packet

Robby Cai (1):
      regulator: fp9931: Fix VPOS/VNEG voltage selector table

Rosen Penev (1):
      ASoC: xilinx: formatter_pcm: pass aud_drv_data to irq handlers

Rui Qi (2):
      selftests/ftrace: Convert ELF entry point to file offset in uprobe test
      riscv: hwprobe: Register unaligned probes before usermode

Samuel Pitoiset (1):
      drm/amd/display: Fix NULL pointer dereference in amdgpu_dm_crtc_set_vblank()

Shenghao Ding (1):
      ASoC: tas2781: fix clang build error for goto bypassing cleanup variable

Shixiong Ou (3):
      drm/log: Fix division by zero when scale module parameter is 0
      drm/log: Fix out-of-bounds read on empty message length
      drm/log: Fix infinite loop when scale is too large for display

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw-nuss: Fix port_id extraction from SRC TAG

Takashi Iwai (1):
      ALSA: usb-audio: Fix mixer regression on SteelSeries Arctis Nova 5

Thorsten Blum (2):
      crypto: starfive - use scatterlist length before DMA mapping
      crypto: qce - fix error path in devm_qce_register_algs

Travis K. Bangs (1):
      drm/amd: Disable DP audio spread spectrum for Cyan Skillfish

Uwe Kleine-König (1):
      m68k: Define NR_CPUS to 1

Vinay Belgaumkar (1):
      drm/xe: Fix a bug in pc_adjust_freq_bounds()

Vladislav Dronov (1):
      crypto: tegra - fix rctx->cryptlen calculation in tegra_gcm_do_one_req()

Wang Jiang (1):
      drm/radeon: restore hardware polling in fence_is_signaled to fix performance regression

Wei Fang (2):
      net: packet: fix wrong transport_header when sending VLAN-tagged frame
      net: tap: fix wrong transport_header when sending VLAN-tagged frame

William Palacek (1):
      drm/amdkfd: Add bounds check for CRAT subtype length

Wyatt Feng (1):
      mptcp: fastopen: only mark MPTFO subflows with SYN data

Xiang Mei (1):
      xfs: fix off-by-one in rtrefcount btree root level validation

Xiang Mei (Microsoft) (1):
      netfilter: ipset: fix refcount race between list:set GC and swap

Yang Wang (2):
      drm/amdgpu: fix nbif 6.3.1 l1 low power not functional
      drm/amdgpu: check ASPM on the dGPU host link

Yiming Zhu (1):
      ceph: fix MDS random selection readiness predicate

Yixun Lan (2):
      clk: spacemit: k3: fix USB2 bus clock
      clk: spacemit: k3: set hdma clock as critical

Zhan Xusheng (1):
      mmc: omap_hsmmc: fix busy_timeout overflow in ns conversion on 32-bit

Zhang Changzhong (1):
      net/sched: cls_u32: skip hash tables in u32_bind_class()

Zhefu Zhang (1):
      Input: atkbd - skip deactivate for Xiaomi Book Pro 14's internal keyboard

