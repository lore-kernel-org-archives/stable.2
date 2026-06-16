Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BB5212564
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569195; cv=none; b=OGgElhDhHtVqxdWHek2r5U+ebP8dHvQiCcS6BSKA8GVd6cqFko11GVKVEksmYIQV6waoDvcr/feyBUDqvkgnIIoAWvKfrsr4/4fFPGQ9ZJEsXt5nOMFWNAq7zqsQkULucNMJMWPNVhT1wnIx8t15GAA27F/sqQOL1zoiJ+9/xwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569195; c=relaxed/simple;
	bh=QbyywVytG09o49hoRzTIFw13rzlM9C56uWoHuMB7zew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1OTGCNEaKggcTLf2/PAY8hPsIKgpGtVXAAfNpKweronqM7ejQTn1imGbKkAjJIWbbEYR4XX3u51w7O3fdPRJbRh3YwRsoHuy1mgvcoYNWgkgcMwL1cAa4lhE4IbT3M/I3RYUImO4QN+orGhE9afBsz2iW3h4yeyMO6Clla6Q7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRMTH8cP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRMTH8cP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B53A1F00A3E;
	Tue, 16 Jun 2026 00:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781569193;
	bh=hwDaglUpT5O5FwMCWIcqw0g32IdnMFjsJ6FnNNJbLag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mRMTH8cPo2rdf3ciHDYzIjI/bGPOdNiDGWie4QyhX1FXS86vTV8gS9MNh9F5z3foc
	 kNQoJ0rZwbt6NX6u6EH3KQi+x7e2TAkqvldcgjYjIhhCeGDRKGKUtcZ56w1y7ogOqF
	 2oosGXJk/u0P+JKOS6+c8tzlEt4i16rdh6gnXVgzHlL+m00x6lLFK2rnAQ4CD/eNzy
	 oDCmYDPvrGfxX/VzG2/m2lJJ1gFLyQjVsfV4s/3Eetc1L/8LVFHPbgaeVBLyUSaFfQ
	 9D3tdHtqmdiLEvpwyQqXwMFCN2TbhHZMf6DCMvj44v/yVNa5f66AvBuaaxa0JYbcaE
	 LXGLOFiZ1w9bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] RDMA: Move DMA block iterator logic into dedicated files
Date: Mon, 15 Jun 2026 20:19:49 -0400
Message-ID: <20260616001950.2587230-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616001950.2587230-1-sashal@kernel.org>
References: <2026061510-undamaged-opulently-daf3@gregkh>
 <20260616001950.2587230-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit 6094ea64c69520ed1e770e7c79c43412de202bfa ]

The DMA iterator logic was mixed into verbs and umem-specific code,
forcing all users to include rdma/ib_umem.h. Move the block iterator
logic into iter.c and rdma/iter.h so that rdma/ib_umem.h and
rdma/ib_verbs.h can be separated in a follow-up patch.

Link: https://patch.msgid.link/20260213-refactor-umem-v1-1-f3be85847922@nvidia.com
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Stable-dep-of: 15fe76e23615 ("RDMA/umem: Fix truncation for block sizes >= 4G")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/Makefile             |  2 +-
 drivers/infiniband/core/iter.c               | 43 ++++++++++
 drivers/infiniband/core/verbs.c              | 38 ---------
 drivers/infiniband/hw/bnxt_re/qplib_res.c    |  2 +-
 drivers/infiniband/hw/cxgb4/mem.c            |  2 +-
 drivers/infiniband/hw/efa/efa_verbs.c        |  2 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c    |  2 +-
 drivers/infiniband/hw/hns/hns_roce_alloc.c   |  2 +-
 drivers/infiniband/hw/irdma/main.h           |  2 +-
 drivers/infiniband/hw/mlx4/mr.c              |  1 +
 drivers/infiniband/hw/mlx5/mem.c             |  1 +
 drivers/infiniband/hw/mlx5/umr.c             |  1 +
 drivers/infiniband/hw/mthca/mthca_provider.c |  2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |  2 +-
 drivers/infiniband/hw/qedr/verbs.c           |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h    |  2 +-
 include/rdma/ib_umem.h                       | 32 -------
 include/rdma/ib_verbs.h                      | 48 -----------
 include/rdma/iter.h                          | 88 ++++++++++++++++++++
 19 files changed, 145 insertions(+), 129 deletions(-)
 create mode 100644 drivers/infiniband/core/iter.c
 create mode 100644 include/rdma/iter.h

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 8ab4eea5a0a5e4..394d7e1f737511 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -12,7 +12,7 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
 				multicast.o mad.o smi.o agent.o mad_rmpp.o \
 				nldev.o restrack.o counters.o ib_core_uverbs.o \
-				trace.o lag.o
+				trace.o lag.o iter.o
 
 ib_core-$(CONFIG_SECURITY_INFINIBAND) += security.o
 ib_core-$(CONFIG_CGROUP_RDMA) += cgroup.o
diff --git a/drivers/infiniband/core/iter.c b/drivers/infiniband/core/iter.c
new file mode 100644
index 00000000000000..8e543d100657ee
--- /dev/null
+++ b/drivers/infiniband/core/iter.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. */
+
+#include <linux/export.h>
+#include <rdma/iter.h>
+
+void __rdma_block_iter_start(struct ib_block_iter *biter,
+			     struct scatterlist *sglist, unsigned int nents,
+			     unsigned long pgsz)
+{
+	memset(biter, 0, sizeof(struct ib_block_iter));
+	biter->__sg = sglist;
+	biter->__sg_nents = nents;
+
+	/* Driver provides best block size to use */
+	biter->__pg_bit = __fls(pgsz);
+}
+EXPORT_SYMBOL(__rdma_block_iter_start);
+
+bool __rdma_block_iter_next(struct ib_block_iter *biter)
+{
+	unsigned int block_offset;
+	unsigned int delta;
+
+	if (!biter->__sg_nents || !biter->__sg)
+		return false;
+
+	biter->__dma_addr = sg_dma_address(biter->__sg) + biter->__sg_advance;
+	block_offset = biter->__dma_addr & (BIT_ULL(biter->__pg_bit) - 1);
+	delta = BIT_ULL(biter->__pg_bit) - block_offset;
+
+	while (biter->__sg_nents && biter->__sg &&
+	       sg_dma_len(biter->__sg) - biter->__sg_advance <= delta) {
+		delta -= sg_dma_len(biter->__sg) - biter->__sg_advance;
+		biter->__sg_advance = 0;
+		biter->__sg = sg_next(biter->__sg);
+		biter->__sg_nents--;
+	}
+	biter->__sg_advance += delta;
+
+	return true;
+}
+EXPORT_SYMBOL(__rdma_block_iter_next);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index d0c8ad45f3c244..a706855ecb84b8 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2943,44 +2943,6 @@ int rdma_init_netdev(struct ib_device *device, u32 port_num,
 }
 EXPORT_SYMBOL(rdma_init_netdev);
 
-void __rdma_block_iter_start(struct ib_block_iter *biter,
-			     struct scatterlist *sglist, unsigned int nents,
-			     unsigned long pgsz)
-{
-	memset(biter, 0, sizeof(struct ib_block_iter));
-	biter->__sg = sglist;
-	biter->__sg_nents = nents;
-
-	/* Driver provides best block size to use */
-	biter->__pg_bit = __fls(pgsz);
-}
-EXPORT_SYMBOL(__rdma_block_iter_start);
-
-bool __rdma_block_iter_next(struct ib_block_iter *biter)
-{
-	unsigned int block_offset;
-	unsigned int delta;
-
-	if (!biter->__sg_nents || !biter->__sg)
-		return false;
-
-	biter->__dma_addr = sg_dma_address(biter->__sg) + biter->__sg_advance;
-	block_offset = biter->__dma_addr & (BIT_ULL(biter->__pg_bit) - 1);
-	delta = BIT_ULL(biter->__pg_bit) - block_offset;
-
-	while (biter->__sg_nents && biter->__sg &&
-	       sg_dma_len(biter->__sg) - biter->__sg_advance <= delta) {
-		delta -= sg_dma_len(biter->__sg) - biter->__sg_advance;
-		biter->__sg_advance = 0;
-		biter->__sg = sg_next(biter->__sg);
-		biter->__sg_nents--;
-	}
-	biter->__sg_advance += delta;
-
-	return true;
-}
-EXPORT_SYMBOL(__rdma_block_iter_next);
-
 /**
  * rdma_alloc_hw_stats_struct - Helper function to allocate dynamic struct
  *   for the drivers.
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 6d811f67934e36..5a85bede4df3d4 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -46,7 +46,7 @@
 #include <linux/if_vlan.h>
 #include <linux/vmalloc.h>
 #include <rdma/ib_verbs.h>
-#include <rdma/ib_umem.h>
+#include <rdma/iter.h>
 
 #include "roce_hsi.h"
 #include "qplib_res.h"
diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index a2c71a1d93d5a8..88db7e527728c0 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -32,9 +32,9 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <rdma/ib_umem.h>
 #include <linux/atomic.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/iter.h>
 
 #include "iw_cxgb4.h"
 
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 3ed8af00363b2c..03f0424eca37cd 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -9,9 +9,9 @@
 #include <linux/log2.h>
 
 #include <rdma/ib_addr.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_verbs.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 
 #include "efa.h"
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index cc2b20c8b05037..193c9389bbb758 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -12,7 +12,7 @@
 #include <linux/vmalloc.h>
 #include <net/addrconf.h>
 #include <rdma/erdma-abi.h>
-#include <rdma/ib_umem.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 
 #include "erdma.h"
diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 950c133d4220e7..2074bf6f9e46d0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -32,7 +32,7 @@
  */
 
 #include <linux/vmalloc.h>
-#include <rdma/ib_umem.h>
+#include <rdma/iter.h>
 #include "hns_roce_device.h"
 
 void hns_roce_buf_free(struct hns_roce_dev *hr_dev, struct hns_roce_buf *buf)
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 6a6b14d8fca451..e38172af69395f 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -37,8 +37,8 @@
 #include <rdma/rdma_cm.h>
 #include <rdma/iw_cm.h>
 #include <rdma/ib_user_verbs.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_cache.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 #include "osdep.h"
 #include "defs.h"
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index a40bf58bcdd3ae..004311925dbf9b 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -33,6 +33,7 @@
 
 #include <linux/slab.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/iter.h>
 
 #include "mlx4_ib.h"
 
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 5a22be14d958f2..93812b9d00e70c 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -32,6 +32,7 @@
 
 #include <linux/io.h>
 #include <rdma/ib_umem_odp.h>
+#include <rdma/iter.h>
 #include "mlx5_ib.h"
 #include <linux/jiffies.h>
 
diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index cb5cee3dee2b6f..219e89242d8885 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. */
 
 #include <rdma/ib_umem_odp.h>
+#include <rdma/iter.h>
 #include "mlx5_ib.h"
 #include "umr.h"
 #include "wr.h"
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 25b13d15c8ac7a..bed3bb775a2252 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -35,8 +35,8 @@
  */
 
 #include <rdma/ib_smi.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 
 #include <linux/sched.h>
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 03f185c8cdac61..e79cfb8469e433 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -45,9 +45,9 @@
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/iw_cm.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 
 #include "ocrdma.h"
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 61755b5f3e20d9..089cdc72c0cc7a 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -39,9 +39,9 @@
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/iw_cm.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 
 #include <linux/qed/common_hsi.h>
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
index 763ddc6f25d1ae..23e547d4b3a715 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
@@ -53,8 +53,8 @@
 #include <linux/pci.h>
 #include <linux/semaphore.h>
 #include <linux/workqueue.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_verbs.h>
+#include <rdma/iter.h>
 #include <rdma/vmw_pvrdma-abi.h>
 
 #include "pvrdma_ring.h"
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index a18ece7d59a861..d049e7a60ad65e 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -71,38 +71,6 @@ static inline size_t ib_umem_num_pages(struct ib_umem *umem)
 {
 	return ib_umem_num_dma_blocks(umem, PAGE_SIZE);
 }
-
-static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
-						struct ib_umem *umem,
-						unsigned long pgsz)
-{
-	__rdma_block_iter_start(biter, umem->sgt_append.sgt.sgl,
-				umem->sgt_append.sgt.nents, pgsz);
-	biter->__sg_advance = ib_umem_offset(umem) & ~(pgsz - 1);
-	biter->__sg_numblocks = ib_umem_num_dma_blocks(umem, pgsz);
-}
-
-static inline bool __rdma_umem_block_iter_next(struct ib_block_iter *biter)
-{
-	return __rdma_block_iter_next(biter) && biter->__sg_numblocks--;
-}
-
-/**
- * rdma_umem_for_each_dma_block - iterate over contiguous DMA blocks of the umem
- * @umem: umem to iterate over
- * @biter: block iterator variable
- * @pgsz: Page size to split the list into
- *
- * pgsz must be <= PAGE_SIZE or computed by ib_umem_find_best_pgsz(). The
- * returned DMA blocks will be aligned to pgsz and span the range:
- * ALIGN_DOWN(umem->address, pgsz) to ALIGN(umem->address + umem->length, pgsz)
- *
- * Performs exactly ib_umem_num_dma_blocks() iterations.
- */
-#define rdma_umem_for_each_dma_block(umem, biter, pgsz)                        \
-	for (__rdma_umem_block_iter_start(biter, umem, pgsz);                  \
-	     __rdma_umem_block_iter_next(biter);)
-
 #ifdef CONFIG_INFINIBAND_USER_MEM
 
 struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 4d00fce739672b..f622adb5e86075 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2826,22 +2826,6 @@ struct ib_client {
 	u8 no_kverbs_req:1;
 };
 
-/*
- * IB block DMA iterator
- *
- * Iterates the DMA-mapped SGL in contiguous memory blocks aligned
- * to a HW supported page size.
- */
-struct ib_block_iter {
-	/* internal states */
-	struct scatterlist *__sg;	/* sg holding the current aligned block */
-	dma_addr_t __dma_addr;		/* unaligned DMA address of this block */
-	size_t __sg_numblocks;		/* ib_umem_num_dma_blocks() */
-	unsigned int __sg_nents;	/* number of SG entries */
-	unsigned int __sg_advance;	/* number of bytes to advance in sg in next step */
-	unsigned int __pg_bit;		/* alignment of current block */
-};
-
 struct ib_device *_ib_alloc_device(size_t size);
 #define ib_alloc_device(drv_struct, member)                                    \
 	container_of(_ib_alloc_device(sizeof(struct drv_struct) +              \
@@ -2863,38 +2847,6 @@ void ib_unregister_device_queued(struct ib_device *ib_dev);
 int ib_register_client   (struct ib_client *client);
 void ib_unregister_client(struct ib_client *client);
 
-void __rdma_block_iter_start(struct ib_block_iter *biter,
-			     struct scatterlist *sglist,
-			     unsigned int nents,
-			     unsigned long pgsz);
-bool __rdma_block_iter_next(struct ib_block_iter *biter);
-
-/**
- * rdma_block_iter_dma_address - get the aligned dma address of the current
- * block held by the block iterator.
- * @biter: block iterator holding the memory block
- */
-static inline dma_addr_t
-rdma_block_iter_dma_address(struct ib_block_iter *biter)
-{
-	return biter->__dma_addr & ~(BIT_ULL(biter->__pg_bit) - 1);
-}
-
-/**
- * rdma_for_each_block - iterate over contiguous memory blocks of the sg list
- * @sglist: sglist to iterate over
- * @biter: block iterator holding the memory block
- * @nents: maximum number of sg entries to iterate over
- * @pgsz: best HW supported page size to use
- *
- * Callers may use rdma_block_iter_dma_address() to get each
- * blocks aligned DMA address.
- */
-#define rdma_for_each_block(sglist, biter, nents, pgsz)		\
-	for (__rdma_block_iter_start(biter, sglist, nents,	\
-				     pgsz);			\
-	     __rdma_block_iter_next(biter);)
-
 /**
  * ib_get_client_data - Get IB client context
  * @device:Device to get context for
diff --git a/include/rdma/iter.h b/include/rdma/iter.h
new file mode 100644
index 00000000000000..19d64ef04ba9b9
--- /dev/null
+++ b/include/rdma/iter.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. */
+
+#ifndef _RDMA_ITER_H_
+#define _RDMA_ITER_H_
+
+#include <linux/scatterlist.h>
+#include <rdma/ib_umem.h>
+
+/**
+ * IB block DMA iterator
+ *
+ * Iterates the DMA-mapped SGL in contiguous memory blocks aligned
+ * to a HW supported page size.
+ */
+struct ib_block_iter {
+	/* internal states */
+	struct scatterlist *__sg;	/* sg holding the current aligned block */
+	dma_addr_t __dma_addr;		/* unaligned DMA address of this block */
+	size_t __sg_numblocks;		/* ib_umem_num_dma_blocks() */
+	unsigned int __sg_nents;	/* number of SG entries */
+	unsigned int __sg_advance;	/* number of bytes to advance in sg in next step */
+	unsigned int __pg_bit;		/* alignment of current block */
+};
+
+void __rdma_block_iter_start(struct ib_block_iter *biter,
+			     struct scatterlist *sglist,
+			     unsigned int nents,
+			     unsigned long pgsz);
+bool __rdma_block_iter_next(struct ib_block_iter *biter);
+
+/**
+ * rdma_block_iter_dma_address - get the aligned dma address of the current
+ * block held by the block iterator.
+ * @biter: block iterator holding the memory block
+ */
+static inline dma_addr_t
+rdma_block_iter_dma_address(struct ib_block_iter *biter)
+{
+	return biter->__dma_addr & ~(BIT_ULL(biter->__pg_bit) - 1);
+}
+
+/**
+ * rdma_for_each_block - iterate over contiguous memory blocks of the sg list
+ * @sglist: sglist to iterate over
+ * @biter: block iterator holding the memory block
+ * @nents: maximum number of sg entries to iterate over
+ * @pgsz: best HW supported page size to use
+ *
+ * Callers may use rdma_block_iter_dma_address() to get each
+ * blocks aligned DMA address.
+ */
+#define rdma_for_each_block(sglist, biter, nents, pgsz)		\
+	for (__rdma_block_iter_start(biter, sglist, nents,	\
+				     pgsz);			\
+	     __rdma_block_iter_next(biter);)
+
+static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
+						struct ib_umem *umem,
+						unsigned long pgsz)
+{
+	__rdma_block_iter_start(biter, umem->sgt_append.sgt.sgl,
+				umem->sgt_append.sgt.nents, pgsz);
+	biter->__sg_advance = ib_umem_offset(umem) & ~(pgsz - 1);
+	biter->__sg_numblocks = ib_umem_num_dma_blocks(umem, pgsz);
+}
+
+static inline bool __rdma_umem_block_iter_next(struct ib_block_iter *biter)
+{
+	return __rdma_block_iter_next(biter) && biter->__sg_numblocks--;
+}
+
+/**
+ * rdma_umem_for_each_dma_block - iterate over contiguous DMA blocks of the umem
+ * @umem: umem to iterate over
+ * @pgsz: Page size to split the list into
+ *
+ * pgsz must be <= PAGE_SIZE or computed by ib_umem_find_best_pgsz(). The
+ * returned DMA blocks will be aligned to pgsz and span the range:
+ * ALIGN_DOWN(umem->address, pgsz) to ALIGN(umem->address + umem->length, pgsz)
+ *
+ * Performs exactly ib_umem_num_dma_blocks() iterations.
+ */
+#define rdma_umem_for_each_dma_block(umem, biter, pgsz)                        \
+	for (__rdma_umem_block_iter_start(biter, umem, pgsz);                  \
+	     __rdma_umem_block_iter_next(biter);)
+
+#endif /* _RDMA_ITER_H_ */
-- 
2.53.0

