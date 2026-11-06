Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985514;
	b=vxvISRg9V7hXzKXFUGa1q2Gv8nHMBgi0LCtBXk+6ZZGizAzssuioSdnc2Bg7jUBQ/bXD
	 InpRZGHZuyImMxSv+ac2/IXcSp7N4QKFZdwnhMN7tYKJgYTzra4lQWXvTP/spvM714RZ+
	 F+4sUHjJ3DULGFCCHzkRNEtniIQWLyX76dVRZXlfcDz6Un94Q7rOjg0G1WmfsPvhmRI6C
	 U395973Xsgv05Q26BQukCybeZug5az+n6euFm+MPv0MBfoXy7tHac13CtTpucblfDdiSc
	 P3gaVBIlH8lHC4hlYor97xEANjNjxxY8+c8v5qo8cHuNYLR285Obzm4m+fWiXBjUDRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985514;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PC1VGFzx6gO/wcGeK5fjgA2o2oisn0luyvEhJXZ4xNc=;
	b=5N6yL38JgzDrCaTn0XGwUS3ykWtdPj0D5lPqytXXPif2kfRaACuKEgX7KQBfhyXYNcNh
	 sZhzwGS5g/N+QkqpD1OEL0BKbDdCVpS5o1CMVPNpf4HXLp2nwDC9qO//8Q1GMex7EuMzz
	 nrcydAqoPNdc+cpWngYkvp6WJ7HA3FXH7FKrF4WYKh6fDOjOoYjVpbnxQdMwAJV1w16nN
	 VkEtXwAJ1nIbu0z10cD8YnT9KJjUPtssZ384JtLMBqRjsdjqZMD+2HBaWREJPZdu4s2Jl
	 EFDFIPG7C+38BD6Mi/eGmoYbc4lU904qA/NIKR3rH4MG7lx0B/qLTdvmH1lFbHLIPqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HvN6AKmz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AC8606A337;
	Fri,  6 Nov 2026 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HvN6AKmz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1D61F0089F;
	Fri,  6 Nov 2026 17:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793985512;
	bh=PC1VGFzx6gO/wcGeK5fjgA2o2oisn0luyvEhJXZ4xNc=;
	h=From:To:Cc:Subject:Date;
	b=HvN6AKmzJ+5NJc9V/cbbZgu62dbITnQc4WJxHms6fPUr1//tw7W4ako23u6Mbp0D2
	 fvSjOqOg+f/fcnSvdnFxIQCCpy0FDvsqswUYkn79X4YAbwaQKHpM0E7EiXsHgUg2/S
	 hedmyZvDipaTmpmFts3ypvXpMx+RqKvBFCItGiZc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.3.2
Date: Fri,  6 Nov 2026 12:17:45 -0500
Message-ID: <2026110646-extruding-blitz-b2bc@gregkh>
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

I'm announcing the release of the 7.3.2 kernel.

All users of the 7.3 kernel series must upgrade.

The updated 7.3.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.3.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5.yaml |    9 
 Documentation/networking/rxrpc.rst                                     |   21 
 Makefile                                                               |    2 
 arch/arm/mm/mmap.c                                                     |   11 
 arch/powerpc/kvm/book3s_hv.c                                           |   76 
 arch/powerpc/kvm/book3s_paired_singles.c                               |    7 
 arch/s390/kernel/kprobes.c                                             |    3 
 arch/s390/kernel/perf_cpum_cf.c                                        |    3 
 arch/s390/kernel/process.c                                             |   12 
 arch/s390/kernel/signal.c                                              |    6 
 arch/s390/lib/probes.c                                                 |    2 
 arch/s390/mm/extable.c                                                 |    4 
 arch/s390/pci/pci_irq.c                                                |   93 -
 arch/x86/include/asm/cpufeatures.h                                     |    1 
 arch/x86/include/asm/cpuid/api.h                                       |    1 
 arch/x86/include/asm/kvm-x86-ops.h                                     |    1 
 arch/x86/include/asm/kvm_host.h                                        |    7 
 arch/x86/include/asm/vmx.h                                             |    8 
 arch/x86/kernel/cpu/bugs.c                                             |   18 
 arch/x86/kernel/cpu/scattered.c                                        |    1 
 arch/x86/kvm/hyperv.c                                                  |    2 
 arch/x86/kvm/mmu/mmu.c                                                 |    5 
 arch/x86/kvm/mmu/paging_tmpl.h                                         |   13 
 arch/x86/kvm/svm/nested.c                                              |    6 
 arch/x86/kvm/svm/svm.c                                                 |   19 
 arch/x86/kvm/vmx/common.h                                              |   20 
 arch/x86/kvm/vmx/main.c                                                |   26 
 arch/x86/kvm/vmx/posted_intr.c                                         |    2 
 arch/x86/kvm/vmx/tdx.c                                                 |   92 -
 arch/x86/kvm/vmx/vmx.c                                                 |   37 
 arch/x86/kvm/vmx/x86_ops.h                                             |    1 
 arch/x86/kvm/x86.c                                                     |   69 
 arch/x86/kvm/xen.c                                                     |   18 
 arch/x86/mm/pat/set_memory.c                                           |    8 
 block/blk-crypto-fallback.c                                            |    6 
 drivers/accel/amdxdna/aie2_message.c                                   |    1 
 drivers/accel/amdxdna/aie2_msg_priv.h                                  |    1 
 drivers/accel/amdxdna/npu4_regs.c                                      |    1 
 drivers/android/binder/thread.rs                                       |   38 
 drivers/ata/sata_fsl.c                                                 |   18 
 drivers/base/base.h                                                    |    1 
 drivers/base/bus.c                                                     |   32 
 drivers/base/core.c                                                    |    4 
 drivers/base/dd.c                                                      |   90 -
 drivers/block/xen-blkfront.c                                           |   12 
 drivers/bluetooth/hci_vhci.c                                           |    4 
 drivers/clk/renesas/r9a08g046-cpg.c                                    |    6 
 drivers/cpufreq/rcpufreq_dt.rs                                         |    1 
 drivers/gpu/drm/msm/msm_gem_shrinker.c                                 |    3 
 drivers/gpu/drm/panthor/panthor_sched.c                                |   14 
 drivers/hid/amd-sfh-hid/amd_sfh_client.c                               |    4 
 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h              |    2 
 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h       |    7 
 drivers/hid/hid-asus.c                                                 |   14 
 drivers/hid/hid-core.c                                                 |    4 
 drivers/hid/hid-cougar.c                                               |    3 
 drivers/hid/hid-cp2112.c                                               |    9 
 drivers/hid/hid-elo.c                                                  |    3 
 drivers/hid/hid-ids.h                                                  |    1 
 drivers/hid/hid-lenovo-go-s.c                                          |  655 +++++--
 drivers/hid/hid-logitech-dj.c                                          |    3 
 drivers/hid/hid-mcp2200.c                                              |    5 
 drivers/hid/hid-mcp2221.c                                              |   10 
 drivers/hid/hid-picolcd_fb.c                                           |   12 
 drivers/hid/hid-prodikeys.c                                            |    7 
 drivers/hid/hid-pxrc.c                                                 |    3 
 drivers/hid/hid-quirks.c                                               |    1 
 drivers/hid/hid-roccat-isku.c                                          |    3 
 drivers/hid/hid-roccat-koneplus.c                                      |    3 
 drivers/hid/hid-roccat-konepure.c                                      |    3 
 drivers/hid/hid-roccat-kovaplus.c                                      |    3 
 drivers/hid/hid-roccat-pyra.c                                          |    3 
 drivers/hid/hid-roccat-ryos.c                                          |    3 
 drivers/hid/hid-roccat-savu.c                                          |    3 
 drivers/hid/hid-zydacron.c                                             |    3 
 drivers/hid/usbhid/hid-core.c                                          |    9 
 drivers/hid/usbhid/hiddev.c                                            |   37 
 drivers/hid/wacom_sys.c                                                |  198 +-
 drivers/hid/wacom_wac.c                                                |   99 -
 drivers/hid/wacom_wac.h                                                |    6 
 drivers/hv/mshv_vtl_main.c                                             |   28 
 drivers/hv/ring_buffer.c                                               |   29 
 drivers/infiniband/core/ib_core_uverbs.c                               |   10 
 drivers/infiniband/core/uverbs.h                                       |   37 
 drivers/infiniband/core/uverbs_std_types_dmabuf.c                      |   39 
 drivers/infiniband/hw/irdma/icrdma_if.c                                |    9 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                            |    2 
 drivers/iommu/iommufd/eventq.c                                         |    4 
 drivers/irqchip/irq-gic-v5-irs.c                                       |    4 
 drivers/media/pci/cx23885/cx23885-core.c                               |    4 
 drivers/media/pci/cx23885/cx23885-dvb.c                                |   14 
 drivers/media/pci/cx88/cx88-mpeg.c                                     |    9 
 drivers/media/pci/intel/ipu-bridge.c                                   |    2 
 drivers/media/platform/marvell/mcam-core.c                             |   14 
 drivers/media/platform/microchip/microchip-csi2dc.c                    |    1 
 drivers/media/platform/microchip/microchip-isc-base.c                  |    6 
 drivers/media/platform/microchip/microchip-sama5d2-isc.c               |   17 
 drivers/media/platform/microchip/microchip-sama7g5-isc.c               |   17 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                         |    2 
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c                       |    4 
 drivers/media/rc/bpf-lirc.c                                            |   18 
 drivers/media/rc/fintek-cir.c                                          |    4 
 drivers/media/rc/imon.c                                                |    5 
 drivers/media/rc/ir-mce_kbd-decoder.c                                  |    5 
 drivers/media/rc/lirc_dev.c                                            |    3 
 drivers/media/rc/rc-ir-raw.c                                           |   86 
 drivers/media/rc/rc-main.c                                             |   61 
 drivers/media/rc/redrat3.c                                             |    4 
 drivers/media/usb/au0828/au0828-dvb.c                                  |    1 
 drivers/media/usb/em28xx/em28xx-audio.c                                |    7 
 drivers/media/usb/go7007/go7007-driver.c                               |    5 
 drivers/media/usb/gspca/gspca.c                                        |    3 
 drivers/media/usb/hackrf/hackrf.c                                      |    7 
 drivers/media/usb/usbtv/usbtv-core.c                                   |    2 
 drivers/media/usb/usbtv/usbtv-video.c                                  |    4 
 drivers/mtd/mtd_virt_concat.c                                          |    2 
 drivers/net/tun.c                                                      |   14 
 drivers/net/usb/pegasus.c                                              |    6 
 drivers/net/virtio_net.c                                               |   26 
 drivers/net/wireless/ath/ath12k/core.c                                 |    2 
 drivers/net/wireless/ath/ath12k/core.h                                 |    9 
 drivers/net/wireless/ath/ath12k/dp.c                                   |   81 
 drivers/net/wireless/ath/ath12k/dp.h                                   |  108 -
 drivers/net/wireless/ath/ath12k/dp_rx.c                                |   14 
 drivers/net/wireless/ath/ath12k/mac.c                                  |    5 
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c                          |   12 
 drivers/net/wireless/ath/ath9k/channel.c                               |    2 
 drivers/net/wireless/broadcom/b43/main.c                               |    5 
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c                        |    1 
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h                       |    3 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                        |    4 
 drivers/net/wwan/wwan_hwsim.c                                          |    4 
 drivers/nvme/target/auth.c                                             |    1 
 drivers/nvme/target/fabrics-cmd-auth.c                                 |   32 
 drivers/nvme/target/fc.c                                               |    8 
 drivers/nvme/target/nvmet.h                                            |    2 
 drivers/nvme/target/pr.c                                               |    2 
 drivers/nvmem/core.c                                                   |    4 
 drivers/phy/phy-core.c                                                 |   45 
 drivers/platform/cznic/turris-omnia-mcu-base.c                         |    1 
 drivers/platform/x86/amd/hfi/hfi.c                                     |    5 
 drivers/platform/x86/asus-wmi.c                                        |   12 
 drivers/power/supply/pf1550-charger.c                                  |   32 
 drivers/power/supply/sbs-battery.c                                     |   11 
 drivers/pps/generators/pps_gen.c                                       |   94 -
 drivers/rapidio/devices/rio_mport_cdev.c                               |    5 
 drivers/s390/char/vmcp.c                                               |    4 
 drivers/s390/crypto/zcrypt_api.c                                       |   35 
 drivers/s390/crypto/zcrypt_ccamisc.c                                   |   22 
 drivers/s390/crypto/zcrypt_msgtype50.c                                 |   95 -
 drivers/s390/crypto/zcrypt_msgtype6.c                                  |  202 +-
 drivers/scsi/dc395x.c                                                  |   10 
 drivers/spi/spi-pci1xxxx.c                                             |   71 
 drivers/spmi/spmi.c                                                    |    3 
 drivers/staging/rtl8723bs/core/rtw_recv.c                              |   21 
 drivers/thunderbolt/icm.c                                              |    6 
 drivers/tty/serial/serial_core.c                                       |   16 
 drivers/usb/core/driver.c                                              |    1 
 drivers/usb/core/message.c                                             |    1 
 drivers/usb/gadget/legacy/inode.c                                      |    3 
 drivers/vfio/pci/nvgrace-gpu/main.c                                    |   17 
 drivers/video/backlight/lm3630a_bl.c                                   |    1 
 drivers/video/backlight/qcom-wled.c                                    |   35 
 drivers/video/fbdev/atmel_lcdfb.c                                      |   11 
 drivers/video/fbdev/udlfb.c                                            |    5 
 fs/afs/rxrpc.c                                                         |   57 
 fs/btrfs/verity.c                                                      |    7 
 fs/ceph/dir.c                                                          |    4 
 fs/exec.c                                                              |   11 
 fs/ext4/verity.c                                                       |    4 
 fs/fuse/dev.c                                                          |    3 
 fs/iomap/ioend.c                                                       |   10 
 fs/kernfs/mount.c                                                      |   32 
 fs/lockd/svclock.c                                                     |    2 
 fs/nfs/blocklayout/blocklayout.h                                       |    5 
 fs/nfs/blocklayout/rpc_pipefs.c                                        |   79 
 fs/nfs/callback_xdr.c                                                  |    9 
 fs/nfs/delegation.c                                                    |    3 
 fs/nfs/dir.c                                                           |    2 
 fs/nfs/filelayout/filelayout.c                                         |    8 
 fs/nfs/filelayout/filelayoutdev.c                                      |   17 
 fs/nfs/flexfilelayout/flexfilelayout.c                                 |   52 
 fs/nfs/flexfilelayout/flexfilelayout.h                                 |    2 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                              |   17 
 fs/nfs/localio.c                                                       |   31 
 fs/nfs/netns.h                                                         |    5 
 fs/nfs/nfs4_fs.h                                                       |    2 
 fs/nfs/nfs4proc.c                                                      |    8 
 fs/nfs/nfs4state.c                                                     |   38 
 fs/nfs/nfstrace.h                                                      |    5 
 fs/nfs/pnfs.c                                                          |    2 
 fs/nfs/pnfs.h                                                          |    1 
 fs/nfs/pnfs_nfs.c                                                      |   21 
 fs/nfsd/filecache.c                                                    |    4 
 fs/nfsd/flexfilelayout.c                                               |   20 
 fs/nfsd/flexfilelayoutxdr.c                                            |    4 
 fs/nfsd/flexfilelayoutxdr.h                                            |    5 
 fs/nfsd/nfs3acl.c                                                      |   15 
 fs/nfsd/nfs4idmap.c                                                    |    4 
 fs/nfsd/nfs4layouts.c                                                  |    4 
 fs/nfsd/nfs4proc.c                                                     |    4 
 fs/nfsd/nfs4recover.c                                                  |   42 
 fs/nfsd/nfs4state.c                                                    |  250 ++
 fs/nfsd/nfs4xdr.c                                                      |   26 
 fs/nfsd/nfsctl.c                                                       |   73 
 fs/nfsd/nfsproc.c                                                      |   19 
 fs/nfsd/state.h                                                        |   13 
 fs/nfsd/xdr4.h                                                         |    1 
 fs/ocfs2/cluster/heartbeat.c                                           |   13 
 fs/ocfs2/cluster/netdebug.c                                            |    4 
 fs/ocfs2/cluster/nodemanager.c                                         |    3 
 fs/ocfs2/cluster/quorum.c                                              |    7 
 fs/ocfs2/cluster/quorum.h                                              |    1 
 fs/ocfs2/dlm/dlmconvert.c                                              |   10 
 fs/ocfs2/dlm/dlmdebug.c                                                |    5 
 fs/ocfs2/dlm/dlmdomain.c                                               |    3 
 fs/ocfs2/dlm/dlmlock.c                                                 |    8 
 fs/ocfs2/dlmglue.c                                                     |    2 
 fs/ocfs2/file.c                                                        |  100 -
 fs/ocfs2/filecheck.c                                                   |    5 
 fs/ocfs2/quota_local.c                                                 |   12 
 fs/ocfs2/refcounttree.c                                                |   15 
 fs/ocfs2/super.c                                                       |    1 
 fs/overlayfs/copy_up.c                                                 |  110 -
 fs/overlayfs/dir.c                                                     |   22 
 fs/overlayfs/inode.c                                                   |   16 
 fs/overlayfs/namei.c                                                   |   11 
 fs/overlayfs/overlayfs.h                                               |    8 
 fs/overlayfs/readdir.c                                                 |   40 
 fs/overlayfs/super.c                                                   |   31 
 fs/proc/task_mmu.c                                                     |    9 
 fs/smb/client/cached_dir.c                                             |   30 
 fs/smb/client/cifsacl.c                                                |    9 
 fs/smb/client/cifsfs.c                                                 |   20 
 fs/smb/client/cifsglob.h                                               |    2 
 fs/smb/client/cifsproto.h                                              |    1 
 fs/smb/client/cifssmb.c                                                |  152 +
 fs/smb/client/connect.c                                                |   40 
 fs/smb/client/inode.c                                                  |    4 
 fs/smb/client/readdir.c                                                |   69 
 fs/smb/client/sess.c                                                   |    6 
 fs/smb/client/smb2misc.c                                               |   16 
 fs/smb/client/smb2ops.c                                                |   37 
 fs/smb/client/smb2pdu.c                                                |   46 
 fs/smb/client/trace.h                                                  |    3 
 fs/smb/client/transport.c                                              |    2 
 fs/smb/common/smbglob.h                                                |    1 
 fs/smb/server/auth.c                                                   |    6 
 fs/smb/server/compress.c                                               |    1 
 fs/smb/server/connection.c                                             |   55 
 fs/smb/server/connection.h                                             |   26 
 fs/smb/server/ksmbd_netlink.h                                          |    8 
 fs/smb/server/ksmbd_work.c                                             |   19 
 fs/smb/server/ksmbd_work.h                                             |    2 
 fs/smb/server/mgmt/user_session.c                                      |  202 +-
 fs/smb/server/mgmt/user_session.h                                      |   12 
 fs/smb/server/misc.c                                                   |    8 
 fs/smb/server/oplock.c                                                 |  875 +++++-----
 fs/smb/server/oplock.h                                                 |   14 
 fs/smb/server/proc.c                                                   |    2 
 fs/smb/server/server.c                                                 |   23 
 fs/smb/server/server.h                                                 |    3 
 fs/smb/server/smb2misc.c                                               |    8 
 fs/smb/server/smb2ops.c                                                |   33 
 fs/smb/server/smb2pdu.c                                                |  372 +++-
 fs/smb/server/smb2pdu.h                                                |    1 
 fs/smb/server/smb_common.c                                             |    6 
 fs/smb/server/smbacl.c                                                 |   49 
 fs/smb/server/transport_ipc.c                                          |   23 
 fs/smb/server/transport_tcp.c                                          |  308 +++
 fs/smb/server/vfs.c                                                    |  107 +
 fs/smb/server/vfs.h                                                    |    3 
 fs/smb/server/vfs_cache.c                                              |  261 +-
 fs/smb/server/vfs_cache.h                                              |   12 
 fs/smb/smbdirect/accept.c                                              |  225 +-
 fs/smb/smbdirect/connection.c                                          |   12 
 fs/smb/smbdirect/internal.h                                            |    2 
 fs/smb/smbdirect/listen.c                                              |  137 +
 fs/smb/smbdirect/rw.c                                                  |    1 
 fs/smb/smbdirect/socket.c                                              |  113 +
 fs/smb/smbdirect/socket.h                                              |   42 
 fs/udf/inode.c                                                         |    2 
 fs/ufs/dir.c                                                           |    2 
 fs/verity/enable.c                                                     |   12 
 fs/xfs/libxfs/xfs_attr_leaf.c                                          |   13 
 fs/xfs/libxfs/xfs_da_btree.c                                           |   14 
 fs/xfs/libxfs/xfs_inode_fork.c                                         |    4 
 fs/xfs/libxfs/xfs_symlink_remote.c                                     |    8 
 fs/xfs/libxfs/xfs_symlink_remote.h                                     |    2 
 fs/xfs/libxfs/xfs_trans_space.c                                        |    6 
 fs/xfs/scrub/agheader_repair.c                                         |   13 
 fs/xfs/scrub/alloc_repair.c                                            |   11 
 fs/xfs/scrub/attr.c                                                    |   17 
 fs/xfs/scrub/attr_repair.c                                             |   18 
 fs/xfs/scrub/bitmap.c                                                  |   20 
 fs/xfs/scrub/bmap.c                                                    |    7 
 fs/xfs/scrub/btree.c                                                   |   16 
 fs/xfs/scrub/common.c                                                  |    7 
 fs/xfs/scrub/cow_repair.c                                              |   84 
 fs/xfs/scrub/dabtree.c                                                 |   27 
 fs/xfs/scrub/dir.c                                                     |    2 
 fs/xfs/scrub/dir_repair.c                                              |    9 
 fs/xfs/scrub/dirtree.c                                                 |    4 
 fs/xfs/scrub/dirtree_repair.c                                          |   76 
 fs/xfs/scrub/dqiterate.c                                               |    1 
 fs/xfs/scrub/fscounters.c                                              |   38 
 fs/xfs/scrub/ialloc_repair.c                                           |    8 
 fs/xfs/scrub/inode.c                                                   |    2 
 fs/xfs/scrub/inode_repair.c                                            |  181 ++
 fs/xfs/scrub/iscan.c                                                   |    2 
 fs/xfs/scrub/metapath.c                                                |   17 
 fs/xfs/scrub/newbt.c                                                   |   15 
 fs/xfs/scrub/newbt.h                                                   |    1 
 fs/xfs/scrub/parent_repair.c                                           |    4 
 fs/xfs/scrub/quota.c                                                   |    8 
 fs/xfs/scrub/quota_repair.c                                            |   39 
 fs/xfs/scrub/quotacheck_repair.c                                       |   54 
 fs/xfs/scrub/readdir.c                                                 |    2 
 fs/xfs/scrub/reap.c                                                    |   65 
 fs/xfs/scrub/refcount.c                                                |   17 
 fs/xfs/scrub/repair.c                                                  |   18 
 fs/xfs/scrub/repair.h                                                  |    2 
 fs/xfs/scrub/rtbitmap_repair.c                                         |    2 
 fs/xfs/scrub/rtrefcount.c                                              |    2 
 fs/xfs/scrub/rtsummary.c                                               |    9 
 fs/xfs/scrub/rtsummary.h                                               |    1 
 fs/xfs/scrub/rtsummary_repair.c                                        |    2 
 fs/xfs/scrub/stats.c                                                   |    5 
 fs/xfs/scrub/symlink.c                                                 |   17 
 fs/xfs/scrub/trace.c                                                   |   13 
 fs/xfs/scrub/trace.h                                                   |   10 
 fs/xfs/scrub/xfarray.c                                                 |    4 
 fs/xfs/xfs_dquot.c                                                     |   20 
 fs/xfs/xfs_dquot.h                                                     |    2 
 fs/xfs/xfs_handle.c                                                    |    2 
 fs/xfs/xfs_inode_item_recover.c                                        |   20 
 fs/xfs/xfs_mount.c                                                     |    9 
 fs/xfs/xfs_pnfs.c                                                      |   19 
 fs/xfs/xfs_qm.c                                                        |   42 
 fs/xfs/xfs_quota.h                                                     |    9 
 fs/xfs/xfs_trans_dquot.c                                               |    6 
 include/linux/device.h                                                 |    5 
 include/linux/device/bus.h                                             |    3 
 include/linux/filelock.h                                               |   13 
 include/linux/fsverity.h                                               |   12 
 include/linux/hiddev.h                                                 |    2 
 include/linux/interrupt.h                                              |    2 
 include/linux/io_uring_types.h                                         |    6 
 include/linux/kvm_host.h                                               |    2 
 include/linux/pps_gen_kernel.h                                         |    4 
 include/net/af_rxrpc.h                                                 |    5 
 include/net/mptcp.h                                                    |    9 
 include/trace/events/huge_memory.h                                     |   18 
 include/trace/events/rxrpc.h                                           |    2 
 include/trace/misc/nfs.h                                               |   10 
 io_uring/bpf-ops.c                                                     |   16 
 io_uring/cancel.c                                                      |   43 
 io_uring/cancel.h                                                      |    2 
 io_uring/fdinfo.c                                                      |   14 
 io_uring/futex.c                                                       |   32 
 io_uring/io-wq.c                                                       |  138 +
 io_uring/io_uring.c                                                    |  174 +
 io_uring/io_uring.h                                                    |   44 
 io_uring/kbuf.c                                                        |    6 
 io_uring/loop.c                                                        |    8 
 io_uring/mpscq.h                                                       |   14 
 io_uring/napi.c                                                        |    4 
 io_uring/net.c                                                         |   49 
 io_uring/openclose.c                                                   |   11 
 io_uring/poll.c                                                        |   21 
 io_uring/register.c                                                    |   61 
 io_uring/rsrc.c                                                        |    7 
 io_uring/rw.c                                                          |   18 
 io_uring/sqpoll.c                                                      |   35 
 io_uring/sqpoll.h                                                      |    3 
 io_uring/tctx.c                                                        |    9 
 io_uring/timeout.c                                                     |  105 -
 io_uring/tw.c                                                          |   36 
 io_uring/uring_cmd.c                                                   |    2 
 io_uring/wait.c                                                        |   32 
 io_uring/wait.h                                                        |   15 
 io_uring/waitid.c                                                      |   12 
 io_uring/zcrx.c                                                        |    2 
 kernel/cgroup/cgroup.c                                                 |   28 
 kernel/fork.c                                                          |    4 
 kernel/irq/internals.h                                                 |    2 
 kernel/irq/manage.c                                                    |   31 
 kernel/kcov.c                                                          |    8 
 kernel/kcsan/core.c                                                    |    7 
 kernel/power/em_netlink.c                                              |  122 -
 kernel/power/em_netlink.h                                              |    8 
 kernel/power/energy_model.c                                            |    8 
 kernel/resource.c                                                      |    9 
 kernel/sched/ext/ext.c                                                 |   15 
 lib/klist.c                                                            |   16 
 lib/kobject_uevent.c                                                   |    6 
 mm/hugetlb.c                                                           |   15 
 mm/khugepaged.c                                                        |   21 
 mm/rmap.c                                                              |   11 
 mm/slab_common.c                                                       |   17 
 mm/truncate.c                                                          |   30 
 net/8021q/vlan_dev.c                                                   |   33 
 net/bluetooth/hci_event.c                                              |    9 
 net/ceph/mon_client.c                                                  |    2 
 net/core/dev.c                                                         |    3 
 net/core/rtnetlink.c                                                   |    4 
 net/core/skbuff.c                                                      |    2 
 net/ipv4/inet_connection_sock.c                                        |    4 
 net/ipv4/metrics.c                                                     |    5 
 net/mptcp/subflow.c                                                    |   35 
 net/netfilter/nft_payload.c                                            |   40 
 net/rxrpc/recvmsg.c                                                    |   22 
 net/rxrpc/rxperf.c                                                     |   41 
 net/rxrpc/sendmsg.c                                                    |   86 
 net/sched/act_ife.c                                                    |    4 
 net/sched/cls_bpf.c                                                    |   28 
 net/sched/cls_flower.c                                                 |   50 
 net/sched/sch_generic.c                                                |   14 
 net/sched/sch_teql.c                                                   |   60 
 net/sunrpc/auth_gss/svcauth_gss.c                                      |   29 
 net/sunrpc/svc.c                                                       |    9 
 net/sunrpc/svc_xprt.c                                                  |   24 
 net/sunrpc/svcauth_unix.c                                              |    9 
 net/sunrpc/svcsock.c                                                   |   86 
 rust/bindgen_parameters                                                |    4 
 rust/bindings/bindings_helper.h                                        |    2 
 rust/kernel/bitmap.rs                                                  |   70 
 rust/kernel/block/mq/gen_disk.rs                                       |   10 
 rust/kernel/block/mq/operations.rs                                     |    2 
 rust/kernel/bug.rs                                                     |    9 
 rust/kernel/configfs.rs                                                |   43 
 rust/kernel/cpufreq.rs                                                 |   22 
 rust/kernel/fwctl.rs                                                   |   12 
 rust/kernel/module_param.rs                                            |    9 
 security/apparmor/include/policy_ns.h                                  |   16 
 security/apparmor/policy_ns.c                                          |    2 
 security/landlock/fs.c                                                 |   10 
 sound/core/control.c                                                   |    2 
 sound/drivers/pcmtest.c                                                |   42 
 sound/soc/amd/ps/acp63.h                                               |    8 
 sound/soc/amd/ps/pci-ps.c                                              |    2 
 sound/soc/amd/ps/ps-common.c                                           |    2 
 sound/soc/generic/audio-graph-card2.c                                  |    3 
 sound/synth/emux/emux_synth.c                                          |    3 
 sound/synth/emux/soundfont.c                                           |    9 
 sound/usb/line6/pcm.c                                                  |    8 
 sound/x86/intel_hdmi_audio.c                                           |    9 
 tools/objtool/check.c                                                  |    1 
 virt/kvm/guest_memfd.c                                                 |  106 -
 virt/kvm/guest_memfd.h                                                 |   19 
 virt/kvm/kvm_main.c                                                    |   75 
 virt/kvm/pfncache.c                                                    |   18 
 452 files changed, 8669 insertions(+), 3150 deletions(-)

Aamir Ahmed (1):
      ksmbd: deny access for an empty DACL instead of granting the request

Aaradhana Sahu (8):
      wifi: ath12k: move dp_profile_params to dp.h
      wifi: ath12k: convert DP_TX_COMP_RING_SIZE to inline helper
      wifi: ath12k: convert DP_RXDMA_MONITOR_BUF_RING_SIZE to inline helper
      wifi: ath12k: convert DP_RXDMA_MONITOR_DST_RING_SIZE to inline helper
      wifi: ath12k: convert ATH12K_NUM_POOL_TX_DESC to inline helper
      wifi: ath12k: convert ATH12K_RX_DESC_COUNT to inline helper
      wifi: ath12k: convert DP_RX_RELEASE_RING_SIZE to inline helper
      wifi: ath12k: Make RXDMA buffer ring size configurable per memory profile

Abdifatah Suruur (4):
      ksmbd: reserve space for the UTF-16 terminator in stream info
      smb: client: fix fiemap wild read on empty truncated response
      smb: client: reject short SESSION_SETUP responses
      smb: client: validate the data area in SMB2_read()

Ahmed Yaseen (1):
      HID: usbhid: skip interrupt IN polling for devices with no input reports

Alan Stern (1):
      HID: core: Fix out-of-bounds left shift by 32 in s32ton()

Aldo Ariel Panzardo (8):
      xfs: reject out-of-range attribute value lengths in xfs_attr_copy_value
      xfs: reject remote xattr entries with an out-of-range value length
      xfs: bound da-node entry count against the correct geometry
      xfs: bound inode fork length against the fork size during log recovery
      nfsd: clear XDR padding in GETXATTR replies
      NFSD: copy SETXATTR data from all XDR buffer segments
      nfsd: propagate SETXATTR value decode errors
      nfsd: zero NFSv4 COMPOUND tag padding

Aleksandr Nogikh (1):
      media: usbtv: fix null-pointer dereference on disconnect

Alice Ryhl (2):
      rust: fwctl: declare cfi_encoding for fwctl_rpc_scope
      rust_binder: wake epoll on self-work queued to poll thread

Ameer Hamza (4):
      nfsd: fix race between client_info_show() and free_client()
      nfsd: don't modify a session slot when replaying its cached reply
      sunrpc: honor the netlink unix_gid NEGATIVE flag
      sunrpc: treat empty auth.unix.gid replies as negative entries

Amir Goldstein (3):
      ovl: fix mount setup failing when override_creds drops CAP_SYS_ADMIN
      ovl: fortify ovl_copy_xattr() against underlying layer modifications
      ovl: skip copy up of empty security.capability

Amit Machhiwal (3):
      KVM: PPC: Book3S HV: Add SRCU protection for virtual-mode HPT hcalls
      KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE bit-lock users
      KVM: PPC: Fix get_d_signext() 12-bit displacement for paired-single D-form

Andrea Parri (4):
      kcsan: Avoid division by zero in kcsan_prandom_u32_max()
      iomap: don't resubmit an ioend after ->writeback_submit() failed
      vfio/nvgrace-gpu: Use a core-only open_device in fallback mode
      rtnetlink: wait for RCU readers in rtnl_link_unregister()

Andreas Hindborg (3):
      rust: block: fix `Send` bound for `GenDisk`
      rust: block: require `Sync` for `Operations::QueueData`
      rust: configfs: fix data offset calculation for subsystem callbacks

Andreas Wendleder (1):
      wifi: b43: fix use-after-free in b43_bcma_remove()

AngeloGioacchino Del Regno (1):
      spmi: Fix potential use-after-free by grabbing of_node reference

Antonio Quartulli (1):
      net/sched: fix packet reordering on requeue

Anuj Bolewar (1):
      media: hackrf: fix use-after-free in hackrf_alloc_urbs() error path

Balakrishnan Sambath (1):
      media: microchip-isc: take a reference on the parsed endpoints

Baokun Li (1):
      blk-crypto: fix NULL deref and UAF in __blk_crypto_evict_key()

Basavaraj Natikar (2):
      HID: amd_sfh: Remove unsupported motion-state field from accelerometer report
      HID: amd_sfh: Use report type from request node

Benjamin Coddington (9):
      pNFS: Fix CB_NOTIFY_DEVICEID CHANGE to consume ndc_immediate
      NFSv4/pnfs: bound the CB_NOTIFY_DEVICEID array count before allocating
      NFSv4/pnfs: Free the netid when draining a data-server address list
      NFSv4.1/pnfs: suspend pNFS on NFS4ERR_TOOSMALL from LAYOUTGET
      NFSv4/filelayout: Anchor page coalescing on pattern_offset
      NFSv4/flexfiles: fail I/O to the data server once a lock is lost
      NFSv4/flexfiles: Use the full 64-bit offset for read DS selection
      NFSv4/flexfiles: Use the full 64-bit stripe_unit
      NFSv4/flexfiles: Bound page coalescing on the absolute stripe offset

Biju Das (1):
      clk: renesas: r9a08g046: Propagate clk rate for ETH TX mux clocks

Binbin Deng (1):
      apparmor: fix a use-after-free in aa_lookupn_ns()

Borislav Petkov (AMD) (1):
      x86/bugs: Adapt SRSO mitigation to Zen6

Bryan O'Donoghue (1):
      phy: core: Fix race-condition between _of_phy_get() and try_module_get()

Bui Viet Dung (2):
      wwan: wwan_hwsim: Pin module for debugfs file operations
      Bluetooth: hci_vhci: Pin module for debugfs file operations

Cen Zhang (9):
      ocfs2/dlm: drain join handlers before releasing module text
      ocfs2: drain quorum work before removing the cluster
      ocfs2: pin owning modules for open debugfs files
      ocfs2: publish the filecheck owner before adding sysfs attributes
      ocfs2/heartbeat: unlink live slots when their node is missing
      ocfs2/dlm: hold a lock reference across grant AST enqueue
      ocfs2: cancel quota sync work before freeing quota info
      ocfs2: pin refcount trees before dropping the lookup lock
      ocfs2: snapshot dentry names in file and setattr traces

Cen Zhang (Microsoft Security FORGE Labs) (1):
      nfsd: hold cl_lock in client_has_openowners()

Cen Zhang (Microsoft) (1):
      ksmbd: fix parent dentry lifetime in directory enumeration

Cheng Yongkang (2):
      io_uring/timeout: count cancelled timeouts in cq_timeouts
      io_uring/net: fix multishot recv length limit accounting

Chengfeng Ye (1):
      KVM: x86: Take SRCU in kvm_zap_gfn_range()

Chris Mason (19):
      ovl: hold a reference on the parent in readdir
      ovl: set OVL_WHITEOUTS before publishing the upper dir
      ovl: take a snapshot of the name for copy up
      ovl: use the pinned upper dir in ovl_fix_origin()
      ovl: always encode the origin fh when index is enabled
      ovl: check that the parents of volatile/dirty are dirs
      ovl: check the casefold flag of directories only
      ovl: do not copy up a dentry that was removed
      ovl: do not copy up an xattr value that was never read
      ovl: fix a torn path in ovl_get_redirect()
      ovl: read the nlink xattr of every indexed non-dir
      ovl: set the revalidate flags after d_instantiate()
      sunrpc: pin gss module across auth_domain RCU free
      io_uring/rsrc: charge buffer arrays and nodes to memcg
      io_uring: charge tctx nodes and personalities
      io_uring: free XArray nodes left by a failed store
      io_uring/bpf-ops: clear bpf_ctx while submitting SQEs
      io_uring: free the task context after a grace period
      io_uring/sqpoll: don't wait for the thread to exit

Christian Borntraeger (1):
      s390/vmcp: Initialize full session info to zero

Christian Brauner (3):
      exec: cancel io_uring requests before de_thread()
      fork: move the coredump and exec checks into create_io_thread()
      fork: don't create io threads once PF_POSTCOREDUMP is set

Chuck Lever (20):
      lockd: Fix use-after-free in nlmsvc_retry_blocked
      pnfs/blocklayout: Complete a device upcall only on its own reply
      pnfs/blocklayout: Complete a device upcall when the pipe is closed
      NFSD: Destroy a recalled delegation the client does not hold
      NFSD: Do not send CB_RECALL_ANY to NFSv4.0 clients
      NFSD: Don't complete a cld upcall the daemon has not read
      NFSD: Fail a pool_threads read whose reply does not fit
      NFSD: Fix out-of-bounds read in the rpc_status dump
      NFSD: map fh_verify() status codes for NFS_ACLv3 replies
      NFSD: Map flex file layout IDs through the request's user namespace
      NFSD: Reject an oversized principal hash from nfsdcld
      NFSD: Resolve the recall-any mask names in the trace format
      NFSD: Return NFSERR_ISDIR for NFSv2 READ and WRITE on a non-regular file
      NFSD: Set nn->cld_net before registering the cld pipe
      SUNRPC: Copy the deferred RPC Call from the head buffer
      SUNRPC: Do not credit control-record octets to the RPC stream
      SUNRPC: Reject a socket that already has an svc_sock attached
      SUNRPC: Reject a TLS alert record that is not two octets
      SUNRPC: Resume receiving after a TLS control record
      SUNRPC: Treat every TLS error alert as fatal

Cong Nguyen (1):
      media: microchip-csi2dc: fix async notifier leak on probe error path

Daan De Meyer (1):
      io_uring/net: don't retry a non-blocking connect() that fails with -EAGAIN

DaeMyung Kang (5):
      ksmbd: avoid restoring only in-memory EOF after allocation change
      ksmbd: preserve unreadable named streams on open
      ksmbd: return end of file for reads past a named stream's data
      ksmbd: use the existing xattr name for a named stream
      ksmbd: fix named stream write and EOF handling

Daehyeon Ko (2):
      cgroup: serialize migrations of newly forked processes
      mshv_vtl: detach poll waiter on POLLFREE

Daejun Park (2):
      nvmet: fix use-after-free of the old registrant in nvmet_pr_preempt()
      xfs: map pNFS layouts to the end of the extent again

Daijiamu (1):
      ksmbd: use clear_and_wake_up_bit() directly

Dairui Zhang (2):
      ksmbd: fix OOB read and cross-share confusion in ksmbd_validate_name_reconnect()
      ksmbd: verify transform SessionId matches the decrypted header

Danish Khateeb (2):
      pps: generators: fix use-after-free when closing a removed device
      pps: generators: don't use the driver's info after unregister

Darrick J. Wong (69):
      xfs: fix integer overflow problem when setting large free areas
      xfs: clear the symlink zapped flag if inline symlink is ok
      xfs: mark cow extents bad if there's no rmap mapping for them
      xfs: compute the correct fdblocks/frextents for repair when they're negative
      xfs: fix ondisk symlink target validation in xrep_dinode_check_dfork
      xfs: fix xfs_rename_space_res for non-pptr filesystems
      xfs: fix missing xfs_qm_adjust_dqlimits call in quotacheck repair
      xfs: fix buffer overruns in xfs_ioc_attr_list
      xfs: online quotacheck must dirty dquot if enforcement adjustments needed
      xfs: avoid cross-rtgroup reaping after a repair
      xfs: actually lock the metafile reservation when adjusting after repair
      xfs: fix unnecessary dapos truncation in xchk_dir_walk
      xfs: fix buffer overflow in corrupt inline attr structure
      xfs: actually report corrupt xattrs as XFAIL during cross-referencing
      xfs: fix inode btree repair when a cluster is larger than a chunk
      xfs: always reset incore attr fork buffer when resetting fork
      xfs: don't pass iget failures up when marking ondisk inodes
      xfs: zero out di_metatype when removing the metadir file iflag
      xfs: flag excessive delalloc rt extents as corruption
      xfs: don't fix the directory tree if live update fails
      xfs: don't proceed with xattr repair if the live update fails
      xfs: fix skipped inode mask handling in iscan
      xfs: don't repair fs summary counters with garbage
      xfs: fix lost errno returned from xfarray_foliosort
      xfs: allow softlimit with no hardlimit in quota scrub
      xfs: assign an owner to scrub_stats_fops
      xfs: bail out of directory tree repairs on error
      xfs: fix revalidation of xchk_dquot_iter cached mappings
      xfs: abort dirtree repair if the live update hook dies
      xfs: check fork type against dabtree block magic number
      xfs: mark overfull dabtree node blocks as corrupt
      xfs: jump out of xchk_bmap_check_rmap if fatal signals
      xfs: adjust checks for cross-AG reaping issues
      xfs: actually check XFS_DIFLAG2_METADATA for metadata btree data forks
      xfs: fix xchk_stats_estimate_bufsize to allow for the trailing null
      xfs: reduce new btree slack factor if free space is negative
      xfs: reject absurdly large xattr value lengths in xchk_xattr_actor
      xfs: release ip after unlinked list store failure
      xfs: rescan the AGs if incore delalloc counter is negative
      xfs: update quota flags on secondary supers when metadir enabled
      xfs: abort directory tree repair whenever dl->aborted is set
      xfs: always forget cached ACLs if the attr fork swap succeeds
      xfs: always report inode repair setup failures
      xfs: always report scrub errors in tracepoints
      xfs: always zero the whole shortform header when zeroing attr fork
      xfs: check for fragments when full-extent sharing matches
      xfs: check for termination during rmap btree walk
      xfs: clarify various parts of the bitmap API
      xfs: clear set[ug]id mode bits when zapping attr fork
      xfs: complain loudly when dirtree checker finds broken links
      xfs: don't allow sm_agno for non-group metadir path checking
      xfs: don't clear COWEXTSIZE on directories on reflink filesystems
      xfs: don't overrun incore inode when cleaning attr forks
      xfs: don't queue rmap update twice when reaping a fork
      xfs: don't rescan ifree and icount when frozen
      xfs: don't scan across metadata/regular directory trees for dirents
      xfs: don't set a metadata directory's parent to sb_rootino
      xfs: don't subtract excess usage twice when computing agf_btreeblks
      xfs: don't try to repair rtsummary if the summary file isn't computed
      xfs: don't try to scrub self-referential dirent in metapath checker
      xfs: fix correction of unwritten extents in quota file data fork
      xfs: fix data fork block count check in xrep_inode_blockcounts
      xfs: init inode number for tracepoint
      xfs: never reset the default quota timer
      xfs: only written file data blocks can be shared
      xfs: opportunistically skip btree block checks
      xfs: propagate errors while checking null siblings
      xfs: range-check bc_levels array access in scrub tracepoints
      xfs: reattach dquots after changing inode ids

David Flynn (1):
      nfsd: fetch direct I/O alignment for files handed to the filecache

David Heidelberg (3):
      backlight: qcom-wled: Fix NULL pointer dereference in wled_remove()
      backlight: qcom-wled: Fix unbalanced OVP IRQ enable at probe
      backlight: qcom-wled: Fix WLED3 brightness register stride

David Hildenbrand (Arm) (1):
      mm/hugetlb: fix use-after-free in hugetlb_mfill_atomic_pte()

David Howells (5):
      rxrpc: Fix update of call->tx_pending without holding lock
      rxrpc: Fix lack of short-send handling in rxrpc_kernel_send_data()
      afs: Fix afs to abort the rxrpc call on send error
      rxrpc: Fix double IRQ enablement
      rxrpc: Fix return in rxrpc_recvmsg_data() for service calls

David Woodhouse (4):
      KVM: pfncache: use a dedicated invalidation sequence for cache refresh
      KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration
      KVM: x86/xen: Take kvm->srcu in __kvm_xen_has_interrupt()
      tun: Require CAP_NET_ADMIN to attach to an ownerless device

Deep Shah (1):
      RDMA/uverbs: Fix DMABUF use-after-free during ufile cleanup

Deepanshu Kartikey (1):
      media: imon: fix use-after-free in display_close via dev_dbg

Denis Benato (1):
      platform/x86: asus-wmi: fix use-after-free unregistering kbd_led led

Derek J. Clark (10):
      HID: hid-lenovo-go-s: Prevent deadlock if device removed during setup
      HID: hid-lenovo-go-s: Return ret instead of 0 in mcu_property_out()
      HID: hid-lenovo-go-s: Use pm_ptr for reset_resume callback
      HID: hid-lenovo-go-s: Add suspend function and gate access under bool.
      HID: hid-lenovo-go-s: Bound stale reply window before reusing send_cmd_complete
      HID: hid-lenovo-go-s: Move attribute init to after device query
      HID: hid-lenovo-go-s: Reorganize and rename hid_gos_cfg
      HID: hid-lenovo-go-s: Add kobject_uevent notify during reset-resume
      HID: hid-lenovo-go-s: Move static led_classdev_mc to drvdata struct
      HID: hid-lenovo-go-s: Use devm_kzalloc for drvdata

Diego Oliva (6):
      smb: client: fix use-after-free infoleak via the readdir resume name
      smb: client: fix OOB last_entry pointer from unbounded LastNameOffset
      smb: client: fix OOB read of the resume name sent in TRANS2_FIND_NEXT2
      smb: client: fix OOB read in the SMB_FIND_FILE_UNIX name scan
      smb: client: reject FIND data areas that run past the received response
      smb: client: reject short or out-of-range FIND response parameters

Dominik Maier (3):
      smb: client: fix slab-out-of-bounds write in id_mode_to_cifs_acl()
      io_uring/net: mask socket type with SOCK_TYPE_MASK in io_socket_bpf_populate()
      io_uring/register: enforce per-task restrictions in io_uring_register_blind()

Eduard Zateev (1):
      smb: client: hold server info until cifsd exits

Eliot Courtney (1):
      rust: bitmap: restrict bitmap length to at most i32::MAX

Eric Biggers (1):
      fsverity: Set S_VERITY only after rollback is no longer possible

Eric Dumazet (1):
      vlan: restore HW VLAN tag insertion with reorder_hdr off

Eric Sandeen (1):
      xfs: validate rc_domain in xchk_rtrefcount_mergeable

Eva Crystal (1):
      accel/amdxdna: clear the mailbox channel pointer when starting it fails

FUJITA Tomonori (2):
      rust: bug: pass TAINT_WARN to warn_slowpath_fmt() on UML
      rust: bug: update the SAFETY comment for warn_slowpath_fmt() on UML

Fan Wu (7):
      PM: EM: Fix use-after-free of perf domain in netlink doit handlers
      media: au0828: fix use-after-free in bulk_timeout timer on disconnect
      ASoC: amd: ps: fix snd_acp63_remove() teardown ordering
      media: imx-jpeg: cancel timeout worker when streaming stops
      media: marvell: mcam: stop DMA and cancel s_bh_work before freeing DMA buffers
      media: s5p-mfc: use timer_shutdown_sync() for the self-rearming watchdog
      scsi: dc395x: sync the waiting_timer before freeing the host

Fang Xieyan (1):
      kcov: ignore an out-of-range comparison count in write_comp_data()

Florian Westphal (1):
      netfilter: nft_payload: restrict checksum offsets to known values

Frank Zhang (1):
      rust: rcpufreq_dt: add module alias

Fredric Cover (1):
      smb: client: fix early procfs exposure race

Gabor Tanz (1):
      HID: quirks: Always poll the Anne Pro 2 with product ID a292

Giorgi Kobakhia (2):
      udf: fix return value for non-recorded-allocated extents in udf_map_block()
      ksmbd: fix overflow in dacloffset bounds check in build_sec_desc()

Greg Kroah-Hartman (1):
      Linux 7.3.2

Guangshuo Li (1):
      RDMA/irdma: avoid use-after-free in icrdma_remove

Günther Noack (1):
      landlock: Fix superblock use-after-free in release_inode()

Harald Freudenberger (3):
      s390/zcrypt: Fix and improve zcrypt reply message verification checks
      s390/zcrypt: Fix out-of-bounds ptr advance in cca_query_crypto_facility()
      s390/zcrypt: Guard domain index uses against speculative bypass

Harshit Mogalapalli (2):
      mtd: virt-concat: unlink concat node before freeing it
      mtd: virt-concat: unlink discarded items before freeing

Heiko Carstens (4):
      s390/extable: Fix mvcos instruction decoding
      s390/kprobes: Prevent kprobes on instructions with exception table entry
      s390/probes: Fix wrong opcode for cgrb fixup
      s390/signal: Fix incorrect return address in signal frame

Hengyu Liang (1):
      serial: core: fix TIOCSSERIAL and TIOCSERCONFIG on uninitialised ports

Henry Hu (1):
      ksmbd: fix invalid pointer dereference when get_inode_acl() fails

Henry Martin (1):
      smb: client: fix use-after-free in cifs_ses_add_channel()

Hungyu Lin (1):
      ovl: reserve space for the casefolded name terminator

Ian Bridges (4):
      ksmbd: fix session reference leak on compounded SESSION_SETUP
      ksmbd: fix out-of-bounds read when padding the final compound response
      ksmbd: fix app-instance non-durable supersede session UAF
      ksmbd: fix use-after-free after a failed durable reconnect

Igor Putko (1):
      serial: core: shut down initialized port on removal

Imre Kaloz (1):
      mm/slab: sample slab_state once in kmem_cache_destroy()

Jamal Hadi Salim (3):
      net/sched: cls_bpf: accept dev-bound programs on shared blocks
      net/sched: sch_teql: fix slaves_lock IRQ deadlock
      net/sched: act_ife: do not consume the inner header on egress

James Kim (1):
      rapidio: mport_cdev: fix use-after-free in mport_mm_close()

Jan Koester (1):
      ksmbd: ignore network devices of other namespaces

Janne Grunau (1):
      nvmem: core: Fix OOB read for bit offsets of more than one byte

Jeff Layton (4):
      NFSD: cap the number of listeners accepted in listener_set
      nfsd: don't offer flexfiles layouts when NFSv3 isn't being served
      NFSD: validate transport name in listener_set before serv creation
      SUNRPC: keep the first error in svc_register()

Jens Axboe (4):
      io_uring/timeout: don't put a sequence target behind the last flush
      io_uring/timeout: don't flush with the sequence behind the last flush
      io_uring/timeout: don't lose a cancel as io-wq arms a timeout
      io_uring: keep the drain active when a deferred drain request is started

Jiale Yao (16):
      HID: zydacron: validate key report length
      HID: cougar: reject short special-key reports
      HID: cp2112: validate response report lengths
      HID: elo: reject short touchscreen reports
      HID: logitech-dj: validate unnumbered keyboard reports
      HID: mcp2200: validate READ_ALL response length
      HID: mcp2221: validate response report length
      HID: prodikeys: validate fixed-format MIDI reports
      HID: pxrc: reject short input reports
      HID: roccat: isku: reject short button reports
      HID: roccat: koneplus: reject short button reports
      HID: roccat: konepure: reject short button reports
      HID: roccat: kovaplus: reject short button reports
      HID: roccat: pyra: reject short button reports
      HID: roccat: ryos: reject short special reports
      HID: roccat: savu: reject short special reports

Jiaming Zhang (1):
      ocfs2: fix chunk number of the first chunk in a local quota file

Jimmy Zuber (1):
      NFS: Fix stale negative cache on failed nfs_mkdir()

Johan Hovold (2):
      driver core: take parent lock on deferred probe
      driver core: fix parent lock use-after-free on USB disconnect

Jonathan Gopel (1):
      thunderbolt: Do not RPM complete unrelated subtrees on unplug

Josef Bacik (46):
      io_uring/waitid: own the request before clearing ->head
      io_uring/cmd: don't leave list poison in ->hash_node
      io_uring/wait: don't spin on a stuck overflow list
      io_uring/io-wq: don't lose the signal that ends work
      io_uring/io-wq: don't hide a link from cancellations
      io_uring: don't flood a cancelling task with task_work
      io_uring: don't lose the DEFER_TASKRUN wake up
      io_uring/cancel: rearm local work wake up before sleep
      io_uring/mpscq: disable preemption while pushing
      io_uring/io-wq: don't go to sleep on pending work
      io_uring/io-wq: don't strand work when a worker exits
      io_uring/io-wq: don't exit with a creation pending
      io_uring/io-wq: let cancel find picked up hashed work
      io_uring/poll: don't lose a cancel as io-wq arms poll
      io_uring: don't lose a cancel as io-wq parks a request
      io_uring/cancel: don't forget that the work was running
      io_uring/cancel: recognize "no timeout" on 32-bit
      io_uring/cancel: let CANCEL_ALL find parked requests
      io_uring: wake ring pollers for local task_work
      io_uring/wait: look at all CQ waiters on wake up
      io_uring/poll: drop stale double poll entry on rearm
      io_uring/futex: allocate private hash before waiting
      io_uring: drop the CQE cache if a refill fails
      io_uring: don't split 128b SQEs at the SQPOLL cap
      io_uring/register: don't wrap 32b CQEs when resizing
      io_uring/register: handle index wrap when resizing
      io_uring/register: keep 128b SQEs intact on resize
      io_uring/fdinfo: fix CQE dump of CQE32 rings
      io_uring/timeout: don't skip over reached sequences
      io_uring/timeout: keep repeat count on multishot update
      io_uring/timeout: use the right clock for ABS updates
      io_uring/wait: no early -ETIME if min_wait finds work
      io_uring/napi: make stale entries time out after 60s
      io_uring/napi: don't busy poll past an expired timeout
      io_uring/zcrx: fix buffer offsets in areas above 4GB
      io_uring/kbuf: handle index wrap in last buffer check
      io_uring/sqpoll: let the thread sleep on disabled rings
      io_uring/openclose: keep the lock in io_pipe_fixed()
      io_uring: don't pass restart error codes to userspace
      io_uring/net: don't retry recv on uncommitted buffers
      io_uring/timeout: no ABS update of multishot timeouts
      io_uring/timeout: don't end a linked timeout with 1
      io_uring: look up the file before queueing to io-wq
      driver core: Limit the messages on a refused uevent
      mm/hugetlb: fix use-after-free of a new anon folio
      io_uring/io-wq: no new workers once the exit has begun

Joseph Qi (1):
      ocfs2/dlm: hold the lookup reference across convert AST enqueue

Jérémy Jean (4):
      nvmet-auth: serialize access to DH-HMAC-CHAP state to fix UAF
      nfsd: preflight SEQUENCE replies before accepting a slot
      SUNRPC: fix oversized GSS proxy token copy
      ksmbd: fix SMB2 CREATE response buffer overflow

Kaho Jiang (1):
      net: ipv4: add zero check for snd_cwnd_clamp

Kameron Carr (1):
      Drivers: hv: vmbus: Bounds check the shared ring buffer indices

Karl Mehltretter (3):
      ARM: 9524/1: mm: align hugetlb mappings to the huge page size
      ksmbd: use u8 for SMB2 oplock level values
      klist: avoid accesses after waking klist_remove()

Keqiang Duan (1):
      KVM: x86: Clear hardware HLT state when userspace makes a vCPU not-halted

Kyle Zeng (3):
      io_uring/io-wq: save worker type before dropping its reference
      net: sched: prevent scheduling deactivated qdiscs
      io_uring: defer foreign io-wq enqueues to task_work

Lee Jones (5):
      HID: wacom: Use hdev->product in wacom_setup_touch_input_capabilities
      HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration
      HID: wacom: Fix Use-After-Free in wacom_intuos_pad
      HID: wacom: Fix Use-After-Free in wacom_bamboo_pad
      HID: wacom: Redesign shared sibling data lifecycle

Lee Seong Hyeon (1):
      ksmbd: reject FSCTL_SET_ZERO_DATA on a directory handle

Lizhi Hou (1):
      accel/amdxdna: Add support for AIE2 revision 9

Loc Nguyen (1):
      KVM: x86: Request event processing for exception VM-Exits

Lorenzo Pieralisi (2):
      dt-bindings: interrupt-controller: gicv5: Relax IRS properties constraints
      irqchip/gic-v5: Fix standalone IRSes OF probe

Lorenzo Stoakes (1):
      rust: bindings: fix VM_MAYSHARE value

Lorenzo Stoakes (ARM) (1):
      HID: picoLCD: check for fb_deferred_io_init() error

Luxiao Xu (1):
      smb: client: fix buffer overflow in SMB2_tcon()

Mario Limonciello (1):
      platform/x86/amd: hfi: Fix a use-after-free when unloading the driver

Mario Peter (1):
      driver core: take parent lock in async device attach

Mehmet Koseoglu (1):
      rust: cpufreq: reject NULL from cpufreq_cpu_get()

Michail Andreas Michalopoulos (2):
      ksmbd: accept share config responses from ksmbd-tools before 3.5.3
      ksmbd: restore Kerberos logins with released ksmbd-tools

Miguel Ojeda (2):
      objtool/rust: add one more `noreturn` Rust function for Rust 1.101.0
      rust: bindings: fix `VM_MAYSHARE` blocklist entry

Mike Rapoport (Microsoft) (1):
      x86/mm/pat: Fix effective RW computation in lookup_address_in_pgd_attr()

Mike Snitzer (3):
      NFS/localio: detect a short read or write before the iterator has moved
      NFS/localio: fix nfs_local_dio_misaligned tracepoint
      NFS/localio: report the stability a DIO WRITE actually has

Myeonghun Pak (6):
      media: cx88: Disable PCI device on MPEG initialization failure
      backlight: lm3630a: Cancel delayed work before destroying workqueue
      media: cx23885: unregister DVB bus when SP2 CI setup fails
      power: supply: pf1550: drain IRQ work before unregistering supplies
      power: supply: sbs-battery: disable polling before supply teardown
      HID: mcp2221: always initialize and cancel init_work

Namjae Jeon (15):
      ksmbd: wait for negotiation before receiving another PDU
      ksmbd: defer connection scavenging while session locks are busy
      ksmbd: drain session procfs readers before dropping table references
      ksmbd: fix extended session security negotiation for raw NTLMSSP
      ksmbd: hold a connection reference for each session channel
      ksmbd: limit sessions on each connection
      ksmbd: prevent session binding in compound requests
      ksmbd: prevent share root removal through empty paths
      ksmbd: prevent stale data from being written by SMB2 WRITE requests
      ksmbd: reclaim ended sessions on logoff and expiration
      ksmbd: validate security descriptor offsets before pointer arithmetic
      ksmbd: track delivery of queued TCP writes
      ksmbd: retry break notifications on another connection
      ksmbd: rebind completed CREATE replays without draining the old channel
      ksmbd: keep retry timeout clamp bounds constant

NeilBrown (1):
      nfsd: honour client-provided attributes for NFS4_CREATE_EXCLUSIVE4_1

Ngoc Quy (1):
      fs/proc/task_mmu: pin mm_users in do_pagemap_scan()

Nguyen Quang Le Kien (1):
      usb: gadget: fix refcount underflow in gadgetfs_bind() error path

Nickolai Zeldovich (1):
      resource: report a devm_request_resource() conflict under the lock

Nicolin Chen (1):
      iommu/arm-smmu-v3: Disable the impl before disabling the SMMU on shutdown

Niklas Cassel (1):
      ata: sata_fsl: Fix use-after-free of host_priv on probe() failure

Nirmoy Das (1):
      iommufd: Fix event queue release use-after-free

Osama Abdelkader (1):
      drm/panthor: Fix TOCTOU race between GROUP_REGISTERED check and erase

Panz Dev (1):
      HID: asus: do not send keyboard init reports to touchpads

Paulo Alcantara (3):
      smb: client: don't resurrect an exiting tcon from cached dir workers
      smb: client: reclaim credits for decrypted reads with no matching mid
      smb: client: require stable pages for SMB compression

Pavankumar Nandeshwar (1):
      wifi: ath12k: Increase RXDMA buffer ring size for default memory profile

Pei Xiao (1):
      media: cx23885: Fix use-after-free in cx23885_finidev due to race condition

Peter Ujfalusi (1):
      ALSA: x86: hdmi: fix chmap array missing terminator entry

Ping Cheng (2):
      HID: wacom: Setup SW_MUTE_DEVICE according to the order of input registration
      HID: wacom: Write shared touch initial status only once

Priya Bala Govindasamy (1):
      rust: module_param: Fix potentially incorrect access of `SetOnce<T>`

Radek Podgorny (1):
      Bluetooth: forget a peer's RPA once it advertises its identity address

Ratnaker Gautam (3):
      smb: client: bound POSIX lock data area by response length
      smb: client: validate NT transaction response layout and offsets
      smb: client: validate SMB1 EA list bounds before parsing

Richard Patel (2):
      genirq: Defer kfree(irqaction) until irq_thread_dtor() finishes
      genirq: Move interrupt thread exit_work object to irqaction

Ridham Khurana (1):
      platform: cznic: turris-omnia-mcu: Add missing MODULE_DEVICE_TABLE()

Rik van Riel (1):
      media: redrat3: fix UAF in probe error path leaving rc device registered

Rosen Penev (1):
      wifi: ath9k: delete channel-context timers on deinit

Ruide Cao (1):
      mptcp: hold MP_JOIN msk ref when cloning reqsk

Sean Christopherson (14):
      KVM: guest_memfd: Gracefully handle xarray errors when binding a memslot
      x86/cpuid: Mark CPUID function 0x23 as being indexed
      KVM: Only bind memslot to guest_memfd instance for CREATE operations
      KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=1 && EFER.LME=0
      KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when preparing L2 state
      KVM: Use goto to handle errors during memslot preparation
      KVM: VMX: Disallow using to_vmx() in common VT code
      KVM: VMX: Formally define KVM's "0xdead" exit reason used for failed VM-Enter
      KVM: x86/mmu: Bug the VM if KVM attempts to walk more levels than the MMU has
      KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with EFER.LMA=1 && CR4.PAE=0
      KVM: x86: Preserve DR6.BLD (Bus Lock Detect) when delivering #DB payload
      KVM: x86: Zero reserved synic flags when delivering message to avoid stack leak
      KVM: guest_memfd: Split bind() into prepare()+commit() phases
      KVM: guest_memfd: Establish memslot<=>guest_memfd bindings *after* memslot is ready

Sean Young (10):
      media: rc: Ensure that rc_unregister_device() does not free input device
      media: rc: Ensure registered is cleared in error path
      media: rc: Fix race between bpf(BPG_PROG_ATTACH) and device unregister
      media: rc: Fix race condition during rc_register_device()
      media: rc: mce_kbd: Fix inconsistent locking of keylock
      media: rc: Use after free in ir_raw_event_handle()
      media: rc: After rc_unregister_device() timers can be re-armed
      media: rc: Fix use after free in bpf progs
      media: rc: Fix ABBA deadlock by making locks more fine grained
      media: rc: Fix build failure with CONFIG_LIRC disabled

Shakeel Butt (1):
      kernfs: don't lose IN_DELETE_SELF when decoding a file handle

Shivank Garg (1):
      KVM: guest_memfd: take the invalidate lock when unbinding a dying file

Shuangpeng Bai (1):
      media: gspca: use vb2_video_unregister_device() on disconnect

Stefan Metzmacher (4):
      smb: smbdirect: don't wait for RDMA_CM_EVENT_DISCONNECTED in smbdirect_socket_destroy_sync()
      smb: smbdirect: release failed pending sockets of a listener
      smb: smbdirect: don't hand out already failed sockets in smbdirect_socket_accept()
      smb: smbdirect: fix buffer length underflow in RDMA transfers

Sumanth Korikkar (1):
      s390/cpum_cf: Check session mask before cpu offline

Sung Byeongchan (2):
      ksmbd: validate AppInstanceId takeover target
      ALSA: pcmtest: handle multiple wraps in random capture fill

Takashi Iwai (2):
      ALSA: control: Fix UAF in snd_ctl_elem_add() on card disconnect
      ALSA: emux: Fix UAF of soundfont zones at note-on

Tejun Heo (1):
      sched_ext: Fix use-after-free of a local reenq node left on an inactive cpu

Tianchu Chen (1):
      staging: rtl8723bs: fix protected RX frame validation in decrypt path

Tobias Schumacher (5):
      s390/pci: Fix double-free and NULL deref in zpci MSI domain cleanup
      s390/pci: Fix MSI directed-mode teardown IRQ bit count
      s390/pci: Fix resource leak in zpci MSI setup
      s390/pci: Fix use-after-free race in zpci floating interrupt cleanup
      s390/pci: Add error cleanup in zpci_directed_irq_init()

Trond Myklebust (1):
      NFSv4: Fix a regression in the handling of CB_RECALL_ANY

Vernon Yang (3):
      mm: khugepaged: fix folio is used after folio_put/unlock()
      mm: khugepaged: fix folio is used after pte_unmap_unlock()
      mm: khugepaged: fix swap entry value to folio_pfn()

VeroFess (1):
      smb: server: size directory name conversion buffer correctly

Wei Jie Law (1):
      net: usb: pegasus: do not advance rx_skb->data on dropped frames

Weibin Liu (1):
      spi: spi-pci1xxxx: quiesce DMA engines on transfer timeout

Weigang He (1):
      media: rc: fintek-cir: process a full RX buffer instead of overflowing it

Weiming Shi (2):
      virtio_net: atomically disable rx mode work
      smb: client: stop processing a read response after a receive error

Wentao Liang (3):
      ASoC: audio-graph-card2: Fix use-after-free in audio_graph2_link_c2c()
      drm/msm: Fix vm_bo use-after-free in with_vm_locks()
      nfsd: Fix id-to-name cache entry leak in idtoname_parse()

Xiang Mei (5):
      fuse: don't BUG when the copy buffer is exhausted
      libceph: bound mon_command ack decode to front len
      media: em28xx: reject audio endpoint with zero packet size
      media: go7007: only set audio_enabled if go7007_snd_init() succeeded
      fbdev: udlfb: don't rebuild the mode list while the framebuffer is in use

Xiaoyao Li (8):
      KVM: VMX: Make handle_bus_lock_vmexit() a shared helper
      KVM: VMX: Preserve negative return value in vmx_handle_exit() with bus lock detected
      KVM: TDX: Check if there is valid exit infos based on vp_enter_ret
      KVM: TDX: Enable Notify VM exit
      KVM: TDX: Set bits 31:16 to 0 and use UNDEFINED when synthesizing exit reason
      KVM: TDX: Stuff exit_reason with UNDEFINED on wait_for_sept_zap return
      KVM: TDX: Don't assume exit_reason[31:16] is all-0 in tdx_to_vmx_exit_reason()
      KVM: TDX: Enable Bus Lock VM exit

YANXIN LI (1):
      ufs: use u64 for directory size in ufs_last_byte

Yehyeong Lee (1):
      nvmet-fc: fix use-after-free in nvmet_fc_ls_create_connection()

Yibo Tan (2):
      media: ipu-bridge: Fix use-after-free in IVSC error path
      fbdev: atmel_lcdfb: Prevent FIFO work after removal

Yichong Chen (2):
      io_uring/kbuf: advance head when a pickup empties the buffer ring
      io_uring/net: keep recvmsg buffer select length within MAX_RW_COUNT

Yongjun Gwon (1):
      ksmbd: serialize directory emptiness checks with readdir

Yosry Ahmed (1):
      KVM: SVM: Trigger new ASID allocation in both VMCBs on pCPU switch

Yousef Alhouseen (1):
      HID: hiddev: keep state alive through disconnect unlock

YuanZhe Liu (1):
      ALSA: line6: Clear prev_fbuf on capture buffer release

Yuanfu Xie (1):
      ceph: fail readdir when the MDS reply carries no dirfrag

Yuchao Zhang (1):
      xen-blkfront: unbind irq before tearing down ring and shadow requests

Yuhang Zheng (1):
      net/sched: cls_flower: avoid stale mask references after delete

Zhang Yi (1):
      mm/truncate: look up the end-edge straddler by index

Zhao Gongyi (1):
      filelock: keep superblock active through delegation wait

Zhao Li (1):
      wifi: mt76: mt7996: unlink TWT flow if the MCU rejects the agreement

Zhiling Zou (1):
      SUNRPC: trace an accepted transport before publishing it

Zi Yan (1):
      mm/rmap: don't discard lazyfree THPs at PMD level

Zijing Yin (1):
      SUNRPC: fix netns use-after-free in write_gssp()

Zikang Gao (1):
      smb: client: do not pass a NULL buf to is_oplock_break()

Zizhen Liu (1):
      net: skbuff: propagate shared-frag marker in skb_zerocopy()

ck.chang (1):
      wifi: mt76: mt7925: fix reset panic caused by the WM2 rx irq mask

owen kwan (1):
      net/sched: sch_teql: fix use-after-free on lower qdisc drop

