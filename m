Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571996;
	b=yF3iuL/WwdjcxNbR/c8RUm7XC6UKM4tEAz8lIoOsLQGX96SJzVAFDGiabxkjUiP5hfsV
	 gf6yxdi6pbHnFEmP/zrla2uknvBpH9r7hFl2QB1binKZcvzeefPAaDIsIjpsK1SU5iGWL
	 Wnt5u+oMo+2RN+YPcc2YyuYlYiH1sSMzA+4V6gaxDzaN4knXn57HRb9N0oiolaNt07IZg
	 Uc2ZyGndtsqVYujCoKFN/dhxPkooPb2gzDGLxVRW1W7UJUDX23PTmahKi7MYaHPF9wgy0
	 +EeMODpgT3kyBF/qpZmkNMhhyKXPd2yguxxONbpmdSLmX4H6jqpUi13W3guPNkvmLPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571996;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UByFEMmADD615SCGKXZ9Gc+FjvS14ccKBFjnUkxNoz0=;
	b=xmT6lA2xRelSmMDqxOueTtWYyqgsgy5FzVS6jpWQyJuCBQh64Q/xJ0Uhi/NEoOERXh8p
	 2wiKNTyBIk1mewuSKAbGC/Z9ctjxq/MRWYl07zsR6lnitm3pmthbXy1Xyd3Repy+V0VSd
	 xv3FpAKzMA4vW0p5iv/bAUXu2M89HnECxhwv4Yr0MXtZVEeMLPrj8CgPgDaicSIA6tLip
	 wt2qnTQo00K2p7ThSjcwQIUL2JHqMI+dBFob2IR9CpfxlucEKRLsztmVW7PJoLeVWWAkJ
	 VXQoE5zTfryJfo6GoiFg14/PXwy10Oj0ePdgn4CBXATKkoTJ1APrk9nLdS0Pa+ZElCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QfT5C0PD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A133A60A2609;
	Wed, 21 Oct 2026 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QfT5C0PD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77261F000CB;
	Wed, 21 Oct 2026 08:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792571995;
	bh=UByFEMmADD615SCGKXZ9Gc+FjvS14ccKBFjnUkxNoz0=;
	h=From:To:Cc:Subject:Date;
	b=QfT5C0PDGPOl3PD635ELz0NCDB6alYWmSDkWmBLnUjb4bF/Rqcfq/icbjMz3AdEPk
	 QBBw+gvSCPC5vp+SPsLIpSlJivCEt79oE/QEP6N/hRNosQKWY5RGFgZhqprDRXyON1
	 HPJLusIAgV82s8KIir9/UVv4RI0DtQK3z6HXfHfA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.58
Date: Wed, 21 Oct 2026 10:38:21 +0200
Message-ID: <2026102122-borax-tamale-6dd2@gregkh>
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

I'm announcing the release of the 6.18.58 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                             |    2 
 arch/riscv/kernel/patch.c                            |   21 +-
 arch/x86/kvm/x86.h                                   |    4 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            |   12 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h        |   10 +
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c |   45 ++++++
 drivers/gpu/drm/xe/xe_i2c.c                          |    5 
 drivers/infiniband/hw/erdma/erdma_main.c             |    4 
 drivers/infiniband/hw/erdma/erdma_verbs.c            |   18 +-
 drivers/md/dm-integrity.c                            |   55 +++++++
 drivers/net/ethernet/intel/iavf/iavf.h               |   11 +
 drivers/net/ethernet/intel/iavf/iavf_main.c          |   85 +++++++++---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c      |  111 +++++++++++++--
 drivers/net/ethernet/microsoft/mana/mana_bpf.c       |    8 -
 drivers/net/ethernet/microsoft/mana/mana_en.c        |   26 +--
 drivers/net/ethernet/xilinx/xilinx_axienet.h         |    7 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c    |   51 +++++--
 drivers/net/wireless/ath/ath9k/wmi.c                 |   16 --
 drivers/net/wireless/ath/ath9k/wmi.h                 |    1 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |    9 +
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |   23 +++
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c      |    6 
 drivers/pci/controller/dwc/pcie-designware.c         |   31 ++++
 drivers/scsi/ch.c                                    |   30 +---
 drivers/spi/spi-mpc52xx.c                            |   26 ++-
 drivers/ufs/core/ufs-mcq.c                           |   35 +++-
 drivers/ufs/core/ufshcd.c                            |   37 ++---
 drivers/usb/gadget/function/f_hid.c                  |    4 
 drivers/usb/misc/iowarrior.c                         |   74 +++-------
 fs/fat/dir.c                                         |   44 +++++-
 fs/nfsd/nfs4proc.c                                   |    2 
 fs/smb/client/inode.c                                |   27 +++
 fs/smb/server/smb2pdu.c                              |    2 
 fs/xfs/libxfs/xfs_attr_leaf.c                        |   22 +++
 fs/xfs/libxfs/xfs_attr_leaf.h                        |    3 
 fs/xfs/libxfs/xfs_da_btree.c                         |   53 +++++--
 fs/xfs/libxfs/xfs_da_btree.h                         |    2 
 fs/xfs/xfs_attr_inactive.c                           |   95 ++++++++-----
 include/linux/damon.h                                |    1 
 include/linux/kernel_read_file.h                     |    1 
 include/linux/skmsg.h                                |   14 -
 include/net/bluetooth/rfcomm.h                       |    1 
 include/net/mana/mana.h                              |    4 
 io_uring/io_uring.c                                  |   12 -
 io_uring/kbuf.c                                      |    6 
 io_uring/memmap.c                                    |   29 +---
 io_uring/memmap.h                                    |    6 
 io_uring/register.c                                  |   15 +-
 io_uring/zcrx.c                                      |    4 
 kernel/kexec_handover.c                              |    2 
 kernel/module/main.c                                 |   17 +-
 kernel/sched/ext.c                                   |   29 +++-
 kernel/sched/sched.h                                 |    5 
 mm/damon/core.c                                      |   24 ++-
 mm/mremap.c                                          |   38 +++--
 mm/vma.c                                             |   21 ++
 mm/vma.h                                             |    7 
 net/bluetooth/rfcomm/core.c                          |  134 +++++++++++++------
 net/ipv4/tcp_bpf.c                                   |   17 ++
 net/ipv6/ip6_gre.c                                   |    7 
 net/rose/af_rose.c                                   |   44 +++++-
 net/rose/rose_timer.c                                |    5 
 security/integrity/ima/ima.h                         |    6 
 security/integrity/ima/ima_appraise.c                |   16 --
 security/integrity/ima/ima_main.c                    |   30 ++--
 security/integrity/ima/ima_policy.c                  |    3 
 security/ipe/hooks.c                                 |    1 
 security/selinux/hooks.c                             |    5 
 security/selinux/selinuxfs.c                         |   27 ---
 tools/testing/vma/vma.c                              |    4 
 70 files changed, 1093 insertions(+), 459 deletions(-)

Ahmed Abdelhaleem Ahmed (1):
      scsi: ch: Do not keep references to data transfer element devices

Bart Van Assche (2):
      scsi: ufs: core: Move an assignment in ufshcd_mcq_process_cqe()
      scsi: ufs: core: Add a comment block above ufshcd_mcq_compl_all_cqes_lock()

Bernard Pidoux (1):
      rose: hold a reference on incoming sockets queued for accept()

Cheng Xu (1):
      RDMA/erdma: Use IRQ-safe XArray helpers for QP and CQ tables

Chris J Arges (1):
      ima: Fix stack-out-of-bounds in is_bprm_creds_for_exec()

Coiby Xu (1):
      ima: Access decompressed kernel module to verify appended signature

Corinna Vinschen (1):
      iavf: iavf_virtchnl_completion: drop duplicate ether_addr_equal() test

Daehyeon Ko (1):
      ip6_gre: remove obsolete ERSPAN PMTU update

Ethan Tidmore (1):
      usb: gadget: f_hid: Add missing error code

Fan Wu (1):
      drm/xe/i2c: cancel the client work on remove

Frank Sorenson (1):
      cifs: fix time_last_write stamp placement in setattr/truncate paths

Greg Kroah-Hartman (1):
      Linux 6.18.58

Hamza Mahfooz (1):
      net: mana: reserve RX buffer headroom to fix forwarding performance

Hengyu Liang (1):
      io_uring: do not charge the SQ/CQ rings to RLIMIT_MEMLOCK

Ilan Dudnik (1):
      ksmbd: fix heap out-of-bounds write in krb5_authenticate()

Jens Axboe (1):
      io_uring/kbuf: don't charge provided buffer rings to RLIMIT_MEMLOCK

Jinu Kim (1):
      KVM: x86: Use active memslots for the per-vCPU MMIO cache

Johan Hovold (2):
      spi: mpc52xx: clean up interrupt handling
      USB: iowarrior: fix use-after-free on disconnect race

Jose Ignacio Tornos Martinez (1):
      iavf: send MAC change request synchronously

Long Li (3):
      xfs: factor out xfs_attr3_node_entry_remove
      xfs: factor out xfs_attr3_leaf_init
      xfs: close crash window in attr dabtree inactivation

Lorenzo Stoakes (ARM) (2):
      mm/mremap: fix locked_vm leak by splitting VMA for MREMAP_DONTUNMAP
      mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP self-merge

Lubos Rendek (1):
      nfsd: fix all-zero stateid in CB_OFFLOAD for async COPY

Manivannan Sadhasivam (2):
      PCI: dwc: Return -ENODEV from dw_pcie_wait_for_link() if device is not found
      PCI: dwc: Return -EIO from dw_pcie_wait_for_link() if device is not active

Mario Limonciello (1):
      drm/amd: Create a device link between APU display and XHCI devices

Matteo Croce (1):
      fat: stop reading directory entries past the end-of-directory marker

Mattia Meleleo (1):
      bpf, sockmap: Account for receive queue in FIONREAD without a verdict program

Mikhail Gavrilov (1):
      Bluetooth: RFCOMM: connect the session socket without rfcomm_mutex

Mikulas Patocka (2):
      dm-integrity: fix NULL pointer dereference when the 'R' flag is used
      dm-integrity: validate the superblock on resume

Oliver Neukum (1):
      usb: iowarrior: remove inherent race with minor number

Peter Wang (1):
      scsi: ufs: core: Add debug log for MCQ command timeout

Pratyush Yadav (1):
      kho: free chunks using free_page() instead of kfree()

Sean Wang (1):
      wifi: mt76: connac: tolerate inactive BSS deactivation

SeongJae Park (2):
      mm/damon/core: cancel damos_walk() before damon_ctx->kdamond reset
      mm/damon/core: fix damos_walk() vs kdamond_fn() exit race

Stanley Jhu (2):
      scsi: ufs: core: Decouple CQ sweep from request iterator in MCQ
      scsi: ufs: core: Avoid unsafe MMIO reads in ufshcd_mcq_compl_all_cqes_lock()

Stephen Smalley (1):
      selinux: allow multiple opens of /sys/fs/selinux/policy

Suraj Gupta (1):
      net: xilinx: axienet: Free outstanding DMA buffers on dmaengine stop

Tejun Heo (1):
      sched_ext: Fix CPU hotplug hang when a dying CPU's tasks sit in the BPF scheduler

Toke Høiland-Jørgensen (1):
      wifi: atk9k: Revert "wifi: ath9k: reject short WMI command responses"

Vivian Wang (1):
      riscv: patch: Avoid early phys_to_page()

Wei-Jie Hung (1):
      riscv: patch: fix handling of bpf-jit execmem addresses

