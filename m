Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48E638DC46;
	Sun, 23 Aug 2026 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787489222; cv=none; b=oAmiee0szPAIhxYzzXnb62aXS4dzotS7RlS6MZT4DO6IRmIhDeqdxL7AXY+MVEaXsfuKHUd3cbxOB6c9P/utDBdHLf0B61/MzdX1FmX1iQy6BwSp4kddCNNyIJAQDH9HB9rFd3ePpkgyaKIjVReGShAfKMPebeed/KB4NTsm5ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787489222; c=relaxed/simple;
	bh=eq47uO1jW1ENCcdQwG9Rw/fxCK/xaGVgbCNi3tggkYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uR10d62uI3Ga6fPido/rvOirTO8t8iUbqylWoqsI13Kr6KVOQqZj95NDEkCiT0GMjxjQ191dRrolZhKRWYa8Z8iYkX/Skt2ux7mIvil053iPc4pDGMnUmbRa6wTzLv6r8hWZFl2QQMKgymbUBNK7/EQ82wYj42mUbaekSwLsgVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O8KsPBVH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O8KsPBVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D7D1F00A3D;
	Sun, 23 Aug 2026 12:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787489218;
	bh=Hj5I1sFFxaKBcZ+cnTaUlUthEN1bKuj0vbVnbxgpkqs=;
	h=From:To:Cc:Subject:Date;
	b=O8KsPBVHWF+dLYlVmEwAUwsAoM2P6JtI7gj14eT0KBM9/gW3cQIrHgPIvP1xrb+jb
	 p02+IUwRj+ac0LRDP+osmEHoUGTPq9r2NOa+mYnZ89Dq2bxG+JuPXVSVHTBJVs633o
	 sM9xtpvVZTc04fKZv7fGt+dkXZ3rCabTZvf8E3go=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.46
Date: Sun, 23 Aug 2026 14:45:07 +0200
Message-ID: <2026082308-gimmick-washed-83fa@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.46 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                            |    2 
 arch/arm64/boot/dts/nvidia/tegra194.dtsi                            |    2 
 arch/m68k/Kconfig.cpu                                               |    4 
 arch/openrisc/include/asm/processor.h                               |    2 
 arch/openrisc/kernel/signal.c                                       |    5 
 arch/powerpc/platforms/pseries/lparcfg.c                            |    2 
 arch/powerpc/platforms/pseries/papr-phy-attest.c                    |   12 
 arch/powerpc/platforms/pseries/pci.c                                |    2 
 arch/riscv/kernel/ftrace.c                                          |    5 
 arch/x86/kvm/x86.c                                                  |    6 
 block/genhd.c                                                       |   12 
 crypto/ccm.c                                                        |    2 
 drivers/accel/amdxdna/aie2_ctx.c                                    |   16 
 drivers/ata/libata-eh.c                                             |   29 
 drivers/ata/libata-scsi.c                                           |  117 +++-
 drivers/ata/libata.h                                                |    3 
 drivers/base/regmap/regmap-sdw-mbq.c                                |    4 
 drivers/crypto/qce/core.c                                           |    2 
 drivers/crypto/starfive/jh7110-aes.c                                |    2 
 drivers/crypto/tegra/tegra-se-aes.c                                 |   22 
 drivers/firewire/ohci.c                                             |   83 +-
 drivers/gpio/gpio-ml-ioh.c                                          |   71 +-
 drivers/gpio/gpio-sloppy-logic-analyzer.c                           |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                              |   31 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                          |   50 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c                             |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                             |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c                             |   85 --
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                              |    5 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c                            |   21 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c                            |   21 
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c                            |   42 -
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                               |   26 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c              |    2 
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c               |   31 -
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c                  |    7 
 drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c            |    7 
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                                 |   24 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                                  |   18 
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h                             |    3 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                    |    5 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                           |    2 
 drivers/gpu/drm/clients/drm_log.c                                   |   13 
 drivers/gpu/drm/display/drm_hdmi_state_helper.c                     |    3 
 drivers/gpu/drm/drm_client.c                                        |  181 ++----
 drivers/gpu/drm/drm_fbdev_dma.c                                     |    6 
 drivers/gpu/drm/drm_fbdev_shmem.c                                   |    4 
 drivers/gpu/drm/drm_fbdev_ttm.c                                     |    8 
 drivers/gpu/drm/panthor/panthor_fw.c                                |    3 
 drivers/gpu/drm/radeon/radeon_kms.c                                 |    1 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                                 |    3 
 drivers/gpu/drm/xe/xe_device.c                                      |    6 
 drivers/gpu/drm/xe/xe_lrc.c                                         |    7 
 drivers/gpu/drm/xe/xe_oa.c                                          |    4 
 drivers/input/joystick/iforce/iforce-packets.c                      |   11 
 drivers/input/joystick/iforce/iforce-usb.c                          |    3 
 drivers/input/joystick/psxpad-spi.c                                 |    1 
 drivers/input/joystick/xpad.c                                       |    2 
 drivers/input/keyboard/atkbd.c                                      |    8 
 drivers/input/misc/cs40l50-vibra.c                                  |   10 
 drivers/input/mouse/byd.c                                           |    2 
 drivers/input/mouse/focaltech.c                                     |    2 
 drivers/input/rmi4/rmi_f54.c                                        |   43 +
 drivers/input/rmi4/rmi_f55.c                                        |    4 
 drivers/input/touchscreen/hynitron_cstxxx.c                         |   13 
 drivers/input/touchscreen/sur40.c                                   |   23 
 drivers/mmc/host/atmel-mci.c                                        |    2 
 drivers/mmc/host/loongson2-mmc.c                                    |    8 
 drivers/mmc/host/omap_hsmmc.c                                       |    2 
 drivers/mmc/host/sdhci.c                                            |   16 
 drivers/mmc/host/sdhci.h                                            |    2 
 drivers/mtd/ubi/attach.c                                            |    4 
 drivers/mtd/ubi/fastmap-wl.c                                        |    8 
 drivers/mtd/ubi/io.c                                                |   10 
 drivers/mtd/ubi/ubi.h                                               |   12 
 drivers/net/can/rcar/rcar_canfd.c                                   |  181 +++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                           |   30 -
 drivers/net/ethernet/google/gve/gve_ptp.c                           |    6 
 drivers/net/ethernet/google/gve/gve_rx_dqo.c                        |    5 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                            |    2 
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c                       |    4 
 drivers/net/ipvlan/ipvlan_main.c                                    |    4 
 drivers/net/macvlan.c                                               |    4 
 drivers/net/ntb_netdev.c                                            |  292 ++++++----
 drivers/net/ovpn/crypto.c                                           |   16 
 drivers/net/ovpn/io.c                                               |   10 
 drivers/net/phy/realtek/realtek_main.c                              |    2 
 drivers/net/tap.c                                                   |    3 
 drivers/net/veth.c                                                  |    2 
 drivers/pmdomain/arm/scmi_perf_domain.c                             |    2 
 drivers/pmdomain/mediatek/mt8183-pm-domains.h                       |    7 
 drivers/pmdomain/mediatek/mtk-pm-domains.c                          |   30 -
 drivers/s390/cio/vfio_ccw_async.c                                   |   16 
 drivers/s390/cio/vfio_ccw_chp.c                                     |   31 -
 drivers/s390/cio/vfio_ccw_cp.c                                      |   74 +-
 drivers/s390/cio/vfio_ccw_cp.h                                      |   10 
 drivers/s390/cio/vfio_ccw_drv.c                                     |   21 
 drivers/s390/cio/vfio_ccw_fsm.c                                     |    8 
 drivers/s390/cio/vfio_ccw_ops.c                                     |   39 +
 drivers/s390/cio/vfio_ccw_private.h                                 |   10 
 drivers/s390/crypto/zcrypt_ccamisc.c                                |   20 
 drivers/s390/crypto/zcrypt_ep11misc.c                               |   16 
 drivers/s390/net/qeth_core_main.c                                   |    3 
 drivers/s390/net/qeth_l3_main.c                                     |    5 
 drivers/spi/spi-virtio.c                                            |    2 
 drivers/video/fbdev/core/fb_io_fops.c                               |    8 
 fs/binfmt_misc.c                                                    |   32 -
 fs/btrfs/block-group.c                                              |   36 -
 fs/btrfs/zoned.c                                                    |    5 
 fs/btrfs/zoned.h                                                    |    6 
 fs/ceph/caps.c                                                      |   17 
 fs/ceph/file.c                                                      |    9 
 fs/ceph/mds_client.c                                                |   11 
 fs/ceph/mds_client.h                                                |    1 
 fs/ceph/mdsmap.c                                                    |    2 
 fs/erofs/Kconfig                                                    |    3 
 fs/proc/task_mmu.c                                                  |  146 ++---
 fs/smb/client/cifsglob.h                                            |    6 
 fs/smb/client/cifssmb.c                                             |    6 
 fs/smb/client/connect.c                                             |    2 
 fs/smb/client/smb1transport.c                                       |    8 
 fs/smb/common/cifsglob.h                                            |    5 
 fs/smb/server/auth.c                                                |    4 
 fs/smb/server/connection.c                                          |   23 
 fs/smb/server/oplock.c                                              |    8 
 fs/smb/server/server.c                                              |    2 
 fs/smb/server/smb2pdu.c                                             |   70 +-
 fs/smb/server/smb2pdu.h                                             |    9 
 fs/smb/server/smb_common.c                                          |   26 
 fs/smb/server/smb_common.h                                          |   14 
 fs/xfs/libxfs/xfs_exchmaps.c                                        |   10 
 fs/xfs/libxfs/xfs_rtrefcount_btree.c                                |    4 
 fs/xfs/libxfs/xfs_sb.c                                              |    4 
 fs/xfs/scrub/agheader.c                                             |    2 
 fs/xfs/scrub/agheader_repair.c                                      |  152 ++++-
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
 include/drm/drm_client.h                                            |   16 
 include/linux/libata.h                                              |    2 
 include/linux/swapops.h                                             |    4 
 include/net/ip_vs.h                                                 |    7 
 include/uapi/linux/ip_vs.h                                          |    6 
 kernel/events/core.c                                                |    8 
 kernel/futex/core.c                                                 |    4 
 kernel/sched/ext.c                                                  |   95 +--
 kernel/trace/ftrace.c                                               |    9 
 kernel/trace/ring_buffer.c                                          |  118 ++--
 mm/hmm.c                                                            |    2 
 mm/huge_memory.c                                                    |   22 
 mm/khugepaged.c                                                     |    2 
 mm/madvise.c                                                        |    2 
 mm/memory.c                                                         |    4 
 mm/mempolicy.c                                                      |    2 
 mm/migrate.c                                                        |    2 
 mm/page_table_check.c                                               |   20 
 mm/page_vma_mapped.c                                                |    2 
 mm/pagewalk.c                                                       |    2 
 mm/pgtable-generic.c                                                |    2 
 net/ceph/cls_lock_client.c                                          |   21 
 net/ceph/decode.c                                                   |   18 
 net/ceph/osdmap.c                                                   |    9 
 net/ipv4/tcp_input.c                                                |    6 
 net/ipv4/tcp_timer.c                                                |    4 
 net/mptcp/fastopen.c                                                |    7 
 net/mptcp/options.c                                                 |   67 ++
 net/mptcp/pm.c                                                      |    6 
 net/mptcp/protocol.c                                                |    6 
 net/mptcp/protocol.h                                                |    1 
 net/netfilter/ipset/ip_set_bitmap_gen.h                             |    2 
 net/netfilter/ipset/ip_set_core.c                                   |   19 
 net/netfilter/ipset/ip_set_list_set.c                               |   10 
 net/netfilter/ipvs/ip_vs_conn.c                                     |    4 
 net/netfilter/ipvs/ip_vs_core.c                                     |    6 
 net/netfilter/ipvs/ip_vs_ctl.c                                      |    4 
 net/netfilter/ipvs/ip_vs_dh.c                                       |    4 
 net/netfilter/ipvs/ip_vs_lblc.c                                     |    2 
 net/netfilter/ipvs/ip_vs_lblcr.c                                    |    8 
 net/netfilter/nf_flow_table_core.c                                  |    7 
 net/netfilter/nf_tables_offload.c                                   |    2 
 net/packet/af_packet.c                                              |    7 
 net/sched/act_api.c                                                 |   10 
 net/sched/cls_bpf.c                                                 |   18 
 net/sched/cls_u32.c                                                 |    3 
 net/sched/sch_api.c                                                 |   24 
 net/tls/tls_sw.c                                                    |    5 
 security/selinux/ss/policydb.c                                      |   34 +
 security/selinux/ss/services.c                                      |   28 
 sound/hda/codecs/realtek/alc269.c                                   |    1 
 sound/hda/codecs/realtek/alc662.c                                   |    1 
 sound/soc/codecs/cs35l41-lib.c                                      |    2 
 sound/soc/codecs/cs35l45-tables.c                                   |   32 -
 sound/soc/codecs/cs4265.c                                           |    4 
 sound/soc/codecs/lpass-wsa-macro.c                                  |    8 
 sound/soc/codecs/tas2562.c                                          |    9 
 sound/soc/codecs/tas2781-i2c.c                                      |   18 
 sound/soc/intel/common/sof-function-topology-lib.c                  |    7 
 sound/soc/sof/ipc4-pcm.c                                            |   25 
 sound/soc/sof/ipc4-topology.c                                       |   33 +
 sound/soc/sof/sof-audio.c                                           |    9 
 sound/soc/xilinx/xlnx_formatter_pcm.c                               |   10 
 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc |   27 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                     |    4 
 215 files changed, 2502 insertions(+), 1262 deletions(-)

Ajrat Makhmutov (1):
      ALSA: hda/realtek: Enable headset mic on F+ FLAPTOP r

Aldo Ariel Panzardo (1):
      net/sched: serialize qdisc_rtab_list against concurrent get/put

Aleksandr Nogikh (1):
      firewire: ohci: fix NULL pointer dereference in ar_context_release

Alexey Velichayshiy (1):
      netfilter: nf_tables_offload: suppress WARN_ON_ONCE for ENOMEM in abort path

Ali Ahmet Memis (1):
      openrisc: signal: do not restore privileged SR bits on sigreturn

Andrey Golovko (1):
      regmap: sdw-mbq: don't call an unset readable_reg callback

Andy Shevchenko (1):
      libceph: Amend checking to fix `make W=1` build breakage

AngeloGioacchino Del Regno (1):
      pmdomains: mediatek: Avoid setting RTFF's CLK_DIS before NRESTORE

Asad Kamal (1):
      drm/amdgpu: fix aperture iounmap skipped on device removal

Bard Liao (1):
      ASoC: SOF: topology: Use acpi mach from the machine driver

Biju Das (1):
      can: rcar_canfd: Use devm_clk_get_optional() for RAM clk

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

ChenXiaoSong (3):
      smb/server: rename include guard in smb_common.h
      smb/server: fix minimum SMB1 PDU size
      smb/server: fix minimum SMB2 PDU size

Cheng Ming Lin (1):
      mtd: ubi: skip programming unused bits in ubi headers

Christian Brauner (1):
      binfmt_misc: don't leak the user namespace when the mount fails

Christoph Hellwig (1):
      xfs: check v5 superblock features early

Chuck Lever (1):
      net/tls: Fail tls_sw_splice_read() after a failed async decrypt

Damien Le Moal (1):
      ata: libata-scsi: terminate deferred commands on time out

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

David Howells (1):
      ksmbd: Fix to handle removal of rfc1002 header from smb_hdr

David Rosca (6):
      drm/amdgpu: Reject UVD message with invalid number of h265 refs
      drm/amdgpu: Reject UVD message with dimensions above 4096
      drm/amdgpu: Implement insert_end for VCE 3
      drm/amdgpu: Fix UVD min buffer sizes
      drm/amdgpu: Fix UVD dpb min size calculation for H264
      drm/amdgpu: Fix UVD decode image min size calculation

Dawid Wróbel (1):
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

Eric Dumazet (3):
      ipvlan: inherit needed_headroom and needed_tailroom from phy_dev
      macvlan: inherit needed_headroom and needed_tailroom from lowerdev
      af_packet: Don't send zero-byte data in tpacket_snd().

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

Filipe Manana (1):
      btrfs: remove fs_info argument from btrfs_zoned_activate_one_bg()

Florian Westphal (2):
      netfilter: ipset: fix list type element drift bug
      netfilter: ipset: let destroy callbacks adjust ext mem size

Gang Yan (1):
      selftests: mptcp: join: mark tests with data corruption as failed

Gao Xiang (1):
      erofs: fix EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS on some UP platforms

Geert Uytterhoeven (3):
      can: rcar_canfd: Invert reset assert order
      can: rcar_canfd: Invert global vs. channel teardown
      can: rcar_canfd: Extract rcar_canfd_global_{,de}init()

George Wilson (3):
      powerpc/pseries: pci - logic bug
      powerpc/pseries: lparcfg - fix kbuf[] underflow
      powerpc/pseries: papr-phy-attest - validate cmd.length, plug mem leak

Greg Kroah-Hartman (1):
      Linux 6.18.46

Guanghui Yang (2):
      xfs: propagate errors from xfs_rtginode_load
      btrfs: zoned: fix missing chunk metadata reservation

Guangshuo Li (2):
      pmdomain: mediatek: fix remaining %pOF after of_node_put()
      drm/radeon: fix autosuspend cleanup during teardown

Haibo Chen (1):
      mmc: sdhci: make tuning_err a signed int

Harald Freudenberger (1):
      s390/zcrypt: Fix CPRB memory allocation in zcrypt misc code

Herbert Xu (1):
      crypto: ccm - Set rfc4309 maxauthsize from child

Hidayath Khan (1):
      s390/qeth: validate user buffer length in SNMP and ARP query ioctls

HyeongJun An (1):
      Input: cs40l50-vibra - validate custom data from user space

Ibrahim Hashimov (1):
      xfs: bounds-check buffer log item's dirty bitmap

Jakub Kicinski (4):
      eth: bnxt: always set the queue mgmt ops
      eth: bnxt: make sure we populate the qcfg defaults on old FW/HW
      eth: bnxt: cancel IRQ notifier before freeing affinity mask
      eth: bnxt: keep the aRFS rmap updated when TPH is enabled

Jamal Hadi Salim (2):
      net/sched: act_api: fix TOCTOU NULL deref on a->goto_chain
      net/sched: cls_bpf: reject dev-bound programs bound to a different device

Jasper Wise (1):
      spi: virtio: mark device ready before registering the controller

Jesse Zhang (2):
      drm/amdgpu: fix JPEG v5.0.0 queue reset failure in DPG mode
      drm/amdgpu: fix JPEG v4.0.5 queue reset failure in DPG mode

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

Junjie Cao (2):
      gpio: ml-ioh: use raw_spinlock_t for the register lock
      gpio: ml-ioh: share the register lock across channels

Junrui Luo (1):
      drm/amdgpu: disallow multiple FENCE chunks in one submit

Jérémy Jean (1):
      netfilter: flowtable: publish GC-visible tuple last

Kefu Chai (1):
      libceph: tolerate addrvecs with multiple entries of the same type

Koichiro Den (2):
      net: ntb_netdev: Introduce per-queue context
      NTB: ntb_netdev: Preserve RX queue depth on allocation failure

Kyle Zeng (1):
      perf: Reject exited events as group leaders

Kyohei Kadota (1):
      Input: xpad - add support for ZENAIM LEVERLESS

Leon Hwang (1):
      ftrace: Protect direct_functions in ftrace_find_rec_direct

Lin Jiapeng (1):
      xfs: fix exchange-range reflink flag clearing issue with INO1_WRITTEN

Linmao Li (3):
      Input: psxpad-spi - set driver data before use
      Input: byd - synchronize timer deletion before freeing private data
      drm/xe/oa: Fix sync entry leak on OA config emit failure

Liyuan Pang (1):
      ubi: fastmap: fix ubi->fm memory leak

Lizhi Hou (1):
      accel/amdxdna: Skip unmapped range in aie2_populate_range()

Long Li (2):
      xfs: fix ilock leak on error in xfs_dq_get_next_id
      xfs: don't swallow dquot recovery verification errors

Lorenzo Stoakes (2):
      fs/proc/task_mmu: refactor pagemap_pmd_range()
      mm: replace pmd_to_swp_entry() with softleaf_from_pmd()

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

Michael Diesen (1):
      ALSA: hda/realtek: Add quirk for HP Dragonfly Folio G3 2-in-1 (103c:8a05)

Mingyu Wang (1):
      fbdev: core: Fix pointer desynchronization in fb_io_read()

Myeonghun Pak (1):
      mmc: sdhci: unmap the bounce buffer before device release

Namjae Jeon (2):
      ksmbd: rename smb2_get_msg to smb_get_msg
      ksmbd: validate minimum PDU size for transform requests

Nathan Lucas (2):
      drm/amd/display: fix BT.2020 YCbCr limited output CSC matrix
      drm/amd/display: fix BT.2020 YCbCr output CSC matrices for DCE

Oleksij Rempel (1):
      net: phy: realtek: fix EEE advertisement write on the internal PHY MMD path

Osama Abdelkader (1):
      drm/panthor: skip zero-sized firmware sections

Paolo Abeni (1):
      mptcp: reclaim forward-allocated memory on RX path errors

Pavitra Jha (2):
      libceph: fix multiple unsafe decodes in decode_locker()
      libceph: fix two unsafe bare decodes in decode_lockers()

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

Ralf Lici (2):
      ovpn: fix NULL dereference when killing missing key
      ovpn: finish crypto callback cleanup before peer release

Raphael Zimmer (1):
      libceph: Avoid using invalid osd indices from primary_temp

Richard Davies (1):
      Input: focaltech - fix array out-of-bounds in focaltech_process_rel_packet

Rosen Penev (1):
      ASoC: xilinx: formatter_pcm: pass aud_drv_data to irq handlers

Rui Qi (1):
      selftests/ftrace: Convert ELF entry point to file offset in uprobe test

Samuel Pitoiset (1):
      drm/amd/display: Fix NULL pointer dereference in amdgpu_dm_crtc_set_vblank()

Shenghao Ding (1):
      ASoC: tas2781: fix clang build error for goto bypassing cleanup variable

Shixiong Ou (2):
      drm/log: Fix out-of-bounds read on empty message length
      drm/log: Fix infinite loop when scale is too large for display

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw-nuss: Fix port_id extraction from SRC TAG

Steven Rostedt (1):
      ring-buffer: Add helper functions for allocations

Takashi Sakamoto (2):
      firewire: ohci: split page allocation from dma mapping
      firewire: ohci: initialize page array to use alloc_pages_bulk() correctly

Tejun Heo (3):
      sched_ext: Update p->scx.disallow warning in scx_init_task()
      sched_ext: Reorganize enable/disable path for multi-scheduler support
      sched_ext: Take cgroup_lock() first in scx_cgroup_lock()

Thomas Zimmermann (6):
      drm/client: Remove pitch from struct drm_client_buffer
      drm/client: Move dumb-buffer handling to drm_client_framebuffer_create()
      drm/client: Inline drm_client_buffer_addfb() and _rmfb()
      drm/client: Deprecate struct drm_client_buffer.gem
      drm/client: Remove drm_client_framebuffer_delete()
      drm/vmwgfx: Set surface-framebuffer GEM objects

Thorsten Blum (2):
      crypto: starfive - use scatterlist length before DMA mapping
      crypto: qce - fix error path in devm_qce_register_algs

Tu Nguyen (1):
      can: rcar_canfd: change the initializing flow for clocks and resets

Usama Arif (1):
      userfaultfd: wait on source PMD during UFFDIO_MOVE

Uwe Kleine-König (1):
      m68k: Define NR_CPUS to 1

Vincent Donnefort (2):
      ring-buffer: Store bpage pointers into subbuf_ids
      ring-buffer: Prevent resizing of persistent ring buffer

Vladislav Dronov (1):
      crypto: tegra - fix rctx->cryptlen calculation in tegra_gcm_do_one_req()

Wei Fang (2):
      net: packet: fix wrong transport_header when sending VLAN-tagged frame
      net: tap: fix wrong transport_header when sending VLAN-tagged frame

Weiming Shi (1):
      KVM: x86: Cancel delayed I/O APIC EOI handling before destroying vCPUs

Wyatt Feng (1):
      mptcp: fastopen: only mark MPTFO subflows with SYN data

Xiang Mei (2):
      xfs: fix off-by-one in rtrefcount btree root level validation
      libceph: bound pg_{temp,upmap,upmap_items} length to CEPH_PG_MAX_SIZE

Xiang Mei (Microsoft) (1):
      netfilter: ipset: fix refcount race between list:set GC and swap

Yang Wang (4):
      drm/amdgpu: fix nbif 6.3.1 l1 low power not functional
      drm/amdgpu: check ASPM on the dGPU host link
      drm/amd/pm: adjust the visibility of pp_table sysfs node
      drm/amd/pm: fix pptable use-after-free

Yao Kai (1):
      futex: Fix race in futex_pivot_pending() during private hash resize

Yiming Zhu (1):
      ceph: fix MDS random selection readiness predicate

Yizhou Zhao (1):
      ipvs: separate destination availability state

Zhan Xusheng (1):
      mmc: omap_hsmmc: fix busy_timeout overflow in ns conversion on 32-bit

Zhang Changzhong (1):
      net/sched: cls_u32: skip hash tables in u32_bind_class()

ZhangGuoDong (1):
      smb: move get_rfc1002_len() to common/smbglob.h

Zhefu Zhang (1):
      Input: atkbd - skip deactivate for Xiaomi Book Pro 14's internal keyboard

Zhiling Zou (1):
      mm/page_table_check: skip special zero mappings

