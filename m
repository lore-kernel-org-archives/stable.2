Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A63C455B
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 03:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781579863; cv=none; b=mQ5gOb1OIN3y70C+DEHyexTdNLuzyirKwlFoFTYXofEDhKZX0+sYsWbdS88V031+Y7nu2OWsFg7P/vSk8S48eaFP+6akZ+0nOLnp/PY0JFFJGJskCzxpVavhr+lgK1Q0PkQfis4dTrxyWgf87U1covfRY67CaineSbU5a3OhOKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781579863; c=relaxed/simple;
	bh=qd5j1nVozA5UhADy0/r4q/6vRDgcNZHjlSPSWQl5oOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpROy/aR1pP0mQFUELkkEfzBFqBTpHv5fPrURY4zw3fIYFIn/tErnTGb0FzHq8qRTQTLDi+Ke60WXWG4wV1+PZP+NSbtlOKK4CIWKPXHfD7NnDenEZc68BAcU4E0jcvq+kJVWkNSZxECt4RbsrxN+E4g4WGmd3i8M5wQXPfvbHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcUeoqMs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcUeoqMs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AD91F00A3D;
	Tue, 16 Jun 2026 03:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781579859;
	bh=3yJk7eR9IY1FaatA07TMTPBrJi7l3frGZlT7ycrXg4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bcUeoqMsma/5ZxNweO0PF6AiSe4eBt971Xjs49z3StxOoAYmUW+c5PTOlW6MAUg9f
	 SOqDThXsMHe91MFDNgG7cJkQp4O0/IXYqxzgGr4BVe22fOHBs3XesBeXixsqsyVlqT
	 tAWIKt3+dC36d2eEW+0InF6Wz97O5wCbtNWLKZtYEbHQZFKjnMSZPP2fLDZYiXuixz
	 PgtAMT4Q93l289BW8ZDoM92aGKge5U11/dzWaQTjWGm7knuHZ5ngscirLVTjkgmioh
	 pnHx9j/pulIvrn9OfvxHoDWQmt2PbvsJYAERHDJ15ypPDKJjaUjnokyh9aW4ymET5K
	 G4ZfHWA8yWHNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] RDMA: Move DMA block iterator logic into dedicated files
Date: Mon, 15 Jun 2026 23:17:36 -0400
Message-ID: <20260616031737.2781524-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616031737.2781524-1-sashal@kernel.org>
References: <2026061513-rimless-afoot-0214@gregkh>
 <20260616031737.2781524-1-sashal@kernel.org>
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
 drivers/infiniband/core/iter.c               | 43 +++++++++++
 drivers/infiniband/core/verbs.c              | 37 ---------
 drivers/infiniband/hw/bnxt_re/qplib_res.c    |  2 +-
 drivers/infiniband/hw/cxgb4/mem.c            |  2 +-
 drivers/infiniband/hw/efa/efa_verbs.c        |  2 +-
 drivers/infiniband/hw/hns/hns_roce_alloc.c   |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    |  1 +
 drivers/infiniband/hw/mlx4/mr.c              |  1 +
 drivers/infiniband/hw/mlx5/mem.c             |  1 +
 drivers/infiniband/hw/mthca/mthca_provider.c |  2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |  2 +-
 drivers/infiniband/hw/qedr/verbs.c           |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h    |  2 +-
 include/rdma/ib_umem.h                       | 24 ------
 include/rdma/ib_verbs.h                      | 47 ------------
 include/rdma/iter.h                          | 80 ++++++++++++++++++++
 17 files changed, 135 insertions(+), 117 deletions(-)
 create mode 100644 drivers/infiniband/core/iter.c
 create mode 100644 include/rdma/iter.h

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index ccf2670ef45efe..b19200130fb440 100644
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
index 4a28f30c39f104..1fdaffd0b9880e 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2896,40 +2896,3 @@ int rdma_init_netdev(struct ib_device *device, u8 port_num,
 					     netdev, params.param);
 }
 EXPORT_SYMBOL(rdma_init_netdev);
-
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
-	unsigned int sg_delta;
-
-	if (!biter->__sg_nents || !biter->__sg)
-		return false;
-
-	biter->__dma_addr = sg_dma_address(biter->__sg) + biter->__sg_advance;
-	block_offset = biter->__dma_addr & (BIT_ULL(biter->__pg_bit) - 1);
-	sg_delta = BIT_ULL(biter->__pg_bit) - block_offset;
-
-	if (sg_dma_len(biter->__sg) - biter->__sg_advance > sg_delta) {
-		biter->__sg_advance += sg_delta;
-	} else {
-		biter->__sg_advance = 0;
-		biter->__sg = sg_next(biter->__sg);
-		biter->__sg_nents--;
-	}
-
-	return true;
-}
-EXPORT_SYMBOL(__rdma_block_iter_next);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 8547a8512541ce..49e6b9fae36e7d 100644
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
index 42234df896fb2c..02fb7c314ab46f 100644
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
index be6c5d48448784..15086856581f70 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -7,9 +7,9 @@
 #include <linux/log2.h>
 
 #include <rdma/ib_addr.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_verbs.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 
 #include "efa.h"
diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 4bcaaa0524b127..37cdcd6ba17bce 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -34,7 +34,7 @@
 #include <linux/platform_device.h>
 #include <linux/vmalloc.h>
 #include "hns_roce_device.h"
-#include <rdma/ib_umem.h>
+#include <rdma/iter.h>
 
 int hns_roce_bitmap_alloc(struct hns_roce_bitmap *bitmap, unsigned long *obj)
 {
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 89654dc91d81a7..ac37914a1ee21c 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -45,6 +45,7 @@
 #include <rdma/iw_cm.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_umem.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 #include "i40iw.h"
 
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 811b4bb345247d..0f303e8aa13776 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -33,6 +33,7 @@
 
 #include <linux/slab.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/iter.h>
 
 #include "mlx4_ib.h"
 
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 13de3d2edd34e3..47aca791cbf956 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -33,6 +33,7 @@
 #include <linux/module.h>
 #include <rdma/ib_umem.h>
 #include <rdma/ib_umem_odp.h>
+#include <rdma/iter.h>
 #include "mlx5_ib.h"
 #include <linux/jiffies.h>
 
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index c48e3be6754066..d4d7e34f173b2a 100644
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
index 2a691dc30a1299..700bd4b968aed8 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -44,9 +44,9 @@
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
index d382ac21159c28..ee215fa7168da7 100644
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
index de57f2fed74375..bd85a4380bf1a4 100644
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
index 161c80e1d71957..a68ba94fe799c8 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -46,30 +46,6 @@ static inline size_t ib_umem_num_pages(struct ib_umem *umem)
 {
 	return ib_umem_num_dma_blocks(umem, PAGE_SIZE);
 }
-
-static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
-						struct ib_umem *umem,
-						unsigned long pgsz)
-{
-	__rdma_block_iter_start(biter, umem->sg_head.sgl, umem->nmap, pgsz);
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
-	     __rdma_block_iter_next(biter);)
-
 #ifdef CONFIG_INFINIBAND_USER_MEM
 
 struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 495bf66620a6fc..bd04ec8c506822 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2756,21 +2756,6 @@ struct ib_client {
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
-	unsigned int __sg_nents;	/* number of SG entries */
-	unsigned int __sg_advance;	/* number of bytes to advance in sg in next step */
-	unsigned int __pg_bit;		/* alignment of current block */
-};
-
 struct ib_device *_ib_alloc_device(size_t size);
 #define ib_alloc_device(drv_struct, member)                                    \
 	container_of(_ib_alloc_device(sizeof(struct drv_struct) +              \
@@ -2792,38 +2777,6 @@ void ib_unregister_device_queued(struct ib_device *ib_dev);
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
index 00000000000000..3c85ea3eab78ee
--- /dev/null
+++ b/include/rdma/iter.h
@@ -0,0 +1,80 @@
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
+	__rdma_block_iter_start(biter, umem->sg_head.sgl, umem->nmap, pgsz);
+}
+
+/**
+ * rdma_umem_for_each_dma_block - iterate over contiguous DMA blocks of the umem
+ * @umem: umem to iterate over
+ * @biter: block iterator variable
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
+	     __rdma_block_iter_next(biter);)
+
+#endif /* _RDMA_ITER_H_ */
-- 
2.53.0

