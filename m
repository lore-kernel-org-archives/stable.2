Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671285;
	b=bdzT4CxQvL6n1bKU9ycX76CNTjPABsEK3wWeDd2yfchBx7u5r/VtC6Fo8lGgY/qcvRJL
	 MzZZYUdz6+O0SgE2FdaaK+d35NCjbsjX0vlcLM99qZrGhMCb8O465sLzWOt3AGV1R+QcJ
	 6CHEW/WofaGOojaVBnlWBmKhO1MJgBwVEDP44Jhmxx5LMJ9D3zoXufhj8h0da21SPXrDL
	 tepTTbZZ9xD58WHmdNni9FqndUZ8kq48Odf4cqAzYHHXc5dmkSVDUYYb7mZrqyeyqJruq
	 T162qHN/xXERdimUlsv+E8HT4Hpviwfiy54lBAeOGDqm9aqQ8LNID1MmJXNE66I64oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671285;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=UJ+8MsoQlMt7ippaBHIRpOExH3OMdJs3rL46l0+BjYY=;
	b=hDU1yjiK3R6BaEF2jEP+6D2Ccj3qtCtbWOxYCAFsIBZZjuDeWuSRUa4Al2uPbDzDvPLP
	 Btwt4IvkPwn0jJM54cIHWwQ7ESDbxi5KInUDA9L+bZjJrns57J5Wpg2itwANCoUeOKngP
	 CHtXuO62fpq8lcdiRdOy4YMUtCXIQ9oEoF61EuQtbVPPO/6hCEP8IgAjAknMheQRbYWjl
	 HxuWpssU/dNxzxWZoTb4PhaLOTg/HpKraPTjEXJnxOSyU7EjdvyQ18qGriRrobxHc0zcQ
	 BXcX/xnbal/R0nghqucL7m5mz62gzxsKVPG3alp8Ba0g3QzCjuNlbS/UI5avmit2KaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=NsK73AF1;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3921E606A31E;
	Thu, 26 Nov 2026 05:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3921E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=NsK73AF1
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4B42420B7166;
	Wed, 25 Nov 2026 21:34:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B42420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795671279;
	bh=UJ+8MsoQlMt7ippaBHIRpOExH3OMdJs3rL46l0+BjYY=;
	h=From:To:Cc:Subject:Date:From;
	b=NsK73AF1/58D1ommrNJwFydZ1fP6q4zi10VfDT6LGHko+x/GK/EjL+6Z83cVawBi9
	 rWanWfrNs3ylGDS8BN/WX9mgTXEymSNGibKse2E6DyFzNoc7TFHzIDb3e9Qh3T0RtH
	 sBNHopDrk+M2KR5asloqhpWjOGdMWOdbCkK9/weM=
From: Naman Jain <namjain@linux.microsoft.com>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Logan Gunthorpe <logang@deltatee.com>,
	Leon Romanovsky <leon@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	namjain@linux.microsoft.com
Subject: [PATCH] iov_iter: Fix direct I/O across compatible device pgmaps
Date: Thu, 26 Nov 2026 05:34:33 +0000
Message-ID: <20261126053433.88531-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 38446014648c ("block: don't merge different kinds of P2P transfers
in a single bio") made bio_add_page() reject pages from different
dev_pagemaps. This was needed for PCI P2PDMA, but also rejected pages
with compatible DMA mapping requirements.

Commit 41c665aae2b5 ("block: relax pgmap check in bio_add_page for
compatible zone device pages") allows these pages in separate bvecs.
Commit 13920e4b7b784 ("block: add pgmap check to biovec_phys_mergeable")
prevents physically contiguous bvecs from different pgmaps from being
merged into one segment.

But direct I/O now fills a bio using iov_iter_extract_bvecs(), which
retained the original restriction and bypasses bio_add_page().
For a non-atomic request handled by a single bio, only the data before
the pgmap boundary is submitted. The rest is not transferred, and the
request completes with fewer bytes than requested.

Fix this by moving zone_device_pages_compatible() from blk.h to
memremap.h and using it in iov_iter_extract_bvecs(). This allows
compatible pages to be added as separate bvecs without relaxing the
same-pgmap requirement for PCI P2PDMA.

Fixes: 38446014648c ("block: don't merge different kinds of P2P transfers in a single bio")
Cc: stable@vger.kernel.org
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 block/blk.h              | 19 -------------------
 include/linux/memremap.h | 19 +++++++++++++++++++
 lib/iov_iter.c           |  3 ++-
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 50abfd9328861..460c064f1d1b0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -142,25 +142,6 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
 	return true;
 }
 
-/*
- * Check if two pages from potentially different zone device pgmaps can
- * coexist as separate bvec entries in the same bio.
- *
- * The block DMA iterator (blk_dma_map_iter_start) caches the P2PDMA mapping
- * state from the first segment and applies it to all subsequent segments, so
- * P2PDMA pages from different pgmaps must not be mixed in the same bio.
- *
- * Other zone device types (FS_DAX, GENERIC) use the same dma_map_phys() path
- * as normal RAM.  PRIVATE and COHERENT pages never appear in bios.
- */
-static inline bool zone_device_pages_compatible(const struct page *a,
-						const struct page *b)
-{
-	if (is_pci_p2pdma_page(a) || is_pci_p2pdma_page(b))
-		return zone_device_pages_have_same_pgmap(a, b);
-	return true;
-}
-
 static inline bool __bvec_gap_to_prev(const struct queue_limits *lim,
 		struct bio_vec *bprv, unsigned int offset)
 {
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index c8a4979d4c780..a1d447a847990 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -202,6 +202,25 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 		folio_is_pci_p2pdma(page_folio(page));
 }
 
+/*
+ * Check if two pages from potentially different zone device pgmaps can
+ * coexist as separate bvec entries in the same bio.
+ *
+ * The block DMA iterator (blk_dma_map_iter_start) caches the P2PDMA mapping
+ * state from the first segment and applies it to all subsequent segments, so
+ * P2PDMA pages from different pgmaps must not be mixed in the same bio.
+ *
+ * Other zone device types (FS_DAX, GENERIC) use the same dma_map_phys() path
+ * as normal RAM.  PRIVATE and COHERENT pages never appear in bios.
+ */
+static inline bool zone_device_pages_compatible(const struct page *a,
+						const struct page *b)
+{
+	if (is_pci_p2pdma_page(a) || is_pci_p2pdma_page(b))
+		return zone_device_pages_have_same_pgmap(a, b);
+	return true;
+}
+
 static inline bool folio_is_device_coherent(const struct folio *folio)
 {
 	return folio_is_zone_device(folio) &&
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 56c59a2b589d3..a0c76b40a4f90 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -4,6 +4,7 @@
 #include <linux/fault-inject-usercopy.h>
 #include <linux/uio.h>
 #include <linux/pagemap.h>
+#include <linux/memremap.h>
 #include <linux/highmem.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -1968,7 +1969,7 @@ ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
 		unsigned int nr_to_add;
 
 		if (*nr_vecs > 0 &&
-		    !zone_device_pages_have_same_pgmap(bv[*nr_vecs - 1].bv_page,
+		    !zone_device_pages_compatible(bv[*nr_vecs - 1].bv_page,
 				pages[i]))
 			break;
 
-- 
2.43.0

