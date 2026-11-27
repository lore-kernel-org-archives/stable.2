Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795780747;
	b=SdZ/lZGwaL26xDHwbmQfBBx5oivTppGVt9+YdAonIoGlYjdBnMgGuaE0rmT/3OI2xsIK
	 kqsuAQcAVB3Gx4/n/G6StZvZ1ZUwiuSyzx+CcyzWCmfOYHnwutbMyKMGDAK0ucqZzJQEC
	 CLjq/JOgDvSGHLRMWNs0wI8mYahjNDUK93gAXwQIuSQrigtNGJsN6yVF8O5F4nqVzK+Hy
	 FMWHhn2W02Ughuhml7wVbkRUvAsBajWeaSQvQZPikZfPLzduRNWVpBoXfzB/vgip7chbA
	 M2llikYSyMPIf/yMplvrOYgATIOzRxaFXU4pTqIX7SQArS3AoZrAjQf58ZJaeFN69NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780747;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=vdbCYgPmbQHi62R0raVxdOiQ6kGDpNOXi4l/wBMg4js=;
	b=Cd+VNbA8NXztAEkUhYmqEY4Lhls9A4M8GsIvy7swYtZhS+lXC08qkhWOXukxD5HoGuqE
	 xItdXYJiasyiy0EfmnGkuZblN8ApbO0fU6GqhFC41P2LbtqX+I60SJTdv8woqaHusNC/z
	 jzSpMU0s66v2dRBn/sBaHZM5NSsImFxCESzKVBbEfZqBsH/xOjmkcxLxMPUo2DnuPu7w8
	 DNl7I62HCVixpeTDJhbyU4NMc7NkgEDCCUZVDkhlkD7YMV4WdByRExstxMRaUuMwVsFDP
	 1+MMhXGz2aA6Jd7eVnu5zBHquugWxLCFGBbglxlhQm/7zgnHw53LOzUD8QUygxyiISw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Qa5Ih2AO;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D760A2611
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 11:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 685D760A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Qa5Ih2AO
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261127115903euoutp0241036fc6c54f24c61031ccaa0b569742~r5RJlUvdq1470514705euoutp022
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 11:59:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261127115903euoutp0241036fc6c54f24c61031ccaa0b569742~r5RJlUvdq1470514705euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795780743;
	bh=vdbCYgPmbQHi62R0raVxdOiQ6kGDpNOXi4l/wBMg4js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qa5Ih2AOt+YnoYKk+gucUtV5NOcK2cmgbdl9d0VRSm5TQHZX6NwfJ9uOA8l81bmkZ
	 3KDANUpPq5lO/8SDBS/ZT+qTAHtn6YXo9CZGNXB62QHjsSy66PEZlrxaYSZJZLWF9G
	 hoBpHMe+YMu11JjOur0Z23W8n5AChKkbs4ErqAOs=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261127115903eucas1p27ccc4cddb7f705d6afa5c2603597b97a~r5RJE9JYb2874728747eucas1p2-;
	Fri, 27 Nov 2026 11:59:03 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261127115901eusmtip14cb6ad1d98d81ec0ad3511996d5f286e~r5RIDnw6H0799507995eusmtip1O;
	Fri, 27 Nov 2026 11:59:01 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Honglei Huang
	<honghuan@amd.com>, prakash.gupta@oss.qualcomm.com, Alex Williamson
	<alex@shazbot.org>, Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar
	<abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho
	Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] iommu/dma: restore flush queue use in
 dma_iova_destroy()
Date: Fri, 27 Nov 2026 12:58:48 +0100
Message-ID: <20261127115849.2780625-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127115849.2780625-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261127115903eucas1p27ccc4cddb7f705d6afa5c2603597b97a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261127115903eucas1p27ccc4cddb7f705d6afa5c2603597b97a
X-EPHeader: CA
X-CMS-RootMailID: 20261127115903eucas1p27ccc4cddb7f705d6afa5c2603597b97a
References: <20261127115849.2780625-1-m.szyprowski@samsung.com>
	<CGME20261127115903eucas1p27ccc4cddb7f705d6afa5c2603597b97a@eucas1p2.samsung.com>

Commit 1acce29926d9 ("iommu/dma: simplify dma_iova_destroy() and drop
the free_iova helper") turned dma_iova_destroy() into dma_iova_unlink()
followed by dma_iova_free(). Before it, the destroy path marked its
IOTLB gather as queued for DMA-FQ domains, skipped iommu_iotlb_sync()
and handed the IOVA over to the flush queue, exactly like
__iommu_dma_unmap(). After it:

  - dma_iova_unlink() never queues its gather and always calls
    iommu_iotlb_sync() after iommu_unmap_fast(),
  - dma_iova_free() passes a NULL gather to iommu_dma_free_iova(), so
    the IOVA goes straight back to the allocator via free_iova_fast().

DMA-FQ domains therefore get strict invalidation on this path. This
includes blk_rq_dma_map(), which NVMe uses for all data transfers, so
iommu.strict=0 has no effect on NVMe I/O. On a Qualcomm Glymur CRD
(SMMUv3 without RANGE_INV, 4K pages, NVMe on PCIe Gen5 x4) sequential
fio throughput drops from 10.6/11.9 GiB/s (write/read) to the strict
mode level of ~2.7 GiB/s.

Instead of reverting, decide once in dma_iova_try_alloc() whether the
IOVA space is going to be released through the flush queue and record
it in a new DMA_IOVA_USE_FQ flag in dma_iova_state::__size, next to
DMA_IOVA_USE_SWIOTLB, so struct dma_iova_state does not grow.
dma_iova_destroy() then unmaps with a gather queued according to that
flag, skipping the sync for flush queue domains, and passes the same
gather to the IOVA free, so the IOVA space (and any page table pages
released by the unmap) goes through queue_iova() again. dma_iova_free()
honours the flag as well. The whole reservation is still freed, keeping
the size fix of the reverted commit.

A gather must always be retired, either by iommu_iotlb_sync() or by
handing it to the flush queue together with the IOVA, and the IOVA must
never be returned to the allocator while a queued invalidation for it is
still pending. To keep that obvious, the internal unlink helper only
unmaps into a gather supplied by its caller, and each caller retires it
right away: dma_iova_destroy() syncs or queues it together with the IOVA
free, exactly like __iommu_dma_unmap(), while dma_iova_unlink() always
uses a never queued gather and syncs it, as the unlinked range remains
owned by the caller and may be linked again immediately.

Fixes: 1acce29926d9 ("iommu/dma: simplify dma_iova_destroy() and drop the free_iova helper")
Reported-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Closes: https://lore.kernel.org/all/20261125135120.1126571-1-sibi.sankar@oss.qualcomm.com/
Suggested-by: Leon Romanovsky <leon@kernel.org>
Cc: stable@vger.kernel.org # v7.3+
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/dma-iommu.c   | 103 ++++++++++++++++++++++++++----------
 include/linux/dma-mapping.h |   8 ++-
 2 files changed, 83 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 99eb382a1359..0e329ecd7dfa 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1853,10 +1853,31 @@ bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
 
 	state->addr = addr + iova_off;
 	state->__size = size;
+	/*
+	 * Decide once, for the whole life cycle of @state, whether the IOVA
+	 * space is going to be released through the flush queue.  A domain
+	 * can only move from strict to lazy mode, so a stale "not queued"
+	 * value is always safe.
+	 */
+	if (READ_ONCE(cookie->fq_domain))
+		state->__size |= DMA_IOVA_USE_FQ;
 	return true;
 }
 EXPORT_SYMBOL_GPL(dma_iova_try_alloc);
 
+static void __dma_iova_free(struct device *dev, struct dma_iova_state *state,
+		struct iommu_iotlb_gather *gather)
+{
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	size_t iova_start_pad = iova_offset(iovad, state->addr);
+	size_t size = dma_iova_size(state);
+
+	iommu_dma_free_iova(domain, state->addr - iova_start_pad,
+			iova_align(iovad, size + iova_start_pad), gather);
+}
+
 /**
  * dma_iova_free - Free an IOVA space
  * @dev: Device to free the IOVA space for
@@ -1871,14 +1892,11 @@ EXPORT_SYMBOL_GPL(dma_iova_try_alloc);
  */
 void dma_iova_free(struct device *dev, struct dma_iova_state *state)
 {
-	struct iommu_domain *domain = iommu_get_dma_domain(dev);
-	struct iommu_dma_cookie *cookie = domain->iova_cookie;
-	struct iova_domain *iovad = &cookie->iovad;
-	size_t iova_start_pad = iova_offset(iovad, state->addr);
-	size_t size = dma_iova_size(state);
+	struct iommu_iotlb_gather iotlb_gather;
 
-	iommu_dma_free_iova(domain, state->addr - iova_start_pad,
-			iova_align(iovad, size + iova_start_pad), NULL);
+	iommu_iotlb_gather_init(&iotlb_gather);
+	iotlb_gather.queued = state->__size & DMA_IOVA_USE_FQ;
+	__dma_iova_free(dev, state, &iotlb_gather);
 }
 EXPORT_SYMBOL_GPL(dma_iova_free);
 
@@ -2097,27 +2115,20 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
 		arch_sync_dma_flush();
 }
 
-/**
- * dma_iova_unlink - Unlink a range of IOVA space
- * @dev: DMA device
- * @state: IOVA state
- * @offset: offset into the IOVA state to unlink
- * @size: size of the buffer
- * @dir: DMA direction
- * @attrs: attributes of mapping properties
- *
- * Unlink a range of IOVA space for the given IOVA state.
+/*
+ * Unmap a range of IOVA space into @gather. The caller owns @gather and must
+ * retire it, either by iommu_iotlb_sync() or, for a queued gather, by handing
+ * it over to the flush queue together with the IOVA via iommu_dma_free_iova().
  */
-void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
+static void __dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
 		size_t offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
+		unsigned long attrs, struct iommu_iotlb_gather *gather)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	dma_addr_t addr = state->addr + offset;
 	size_t iova_start_pad = iova_offset(iovad, addr);
-	struct iommu_iotlb_gather iotlb_gather;
 	size_t unmapped;
 
 	if ((state->__size & DMA_IOVA_USE_SWIOTLB) ||
@@ -2125,14 +2136,38 @@ void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
 	     !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))))
 		iommu_dma_iova_unlink_range_slow(dev, addr, size, dir, attrs);
 
-	iommu_iotlb_gather_init(&iotlb_gather);
-
 	size = iova_align(iovad, size + iova_start_pad);
 	addr -= iova_start_pad;
-	unmapped = iommu_unmap_fast(domain, addr, size, &iotlb_gather);
+	unmapped = iommu_unmap_fast(domain, addr, size, gather);
 	WARN_ON(unmapped != size);
+}
 
-	iommu_iotlb_sync(domain, &iotlb_gather);
+/**
+ * dma_iova_unlink - Unlink a range of IOVA space
+ * @dev: DMA device
+ * @state: IOVA state
+ * @offset: offset into the IOVA state to unlink
+ * @size: size of the buffer
+ * @dir: DMA direction
+ * @attrs: attributes of mapping properties
+ *
+ * Unlink a range of IOVA space for the given IOVA state.
+ */
+void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
+		size_t offset, size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	struct iommu_iotlb_gather iotlb_gather;
+
+	/*
+	 * The IOVA range stays owned by the caller and may be linked again
+	 * right away, so the IOTLB has to be invalidated synchronously even
+	 * for flush queue domains. The gather is therefore never queued and
+	 * is retired right here.
+	 */
+	iommu_iotlb_gather_init(&iotlb_gather);
+	__dma_iova_unlink(dev, state, offset, size, dir, attrs, &iotlb_gather);
+	iommu_iotlb_sync(iommu_get_dma_domain(dev), &iotlb_gather);
 }
 EXPORT_SYMBOL_GPL(dma_iova_unlink);
 
@@ -2152,14 +2187,28 @@ void dma_iova_destroy(struct device *dev, struct dma_iova_state *state,
 		size_t mapped_len, enum dma_data_direction dir,
 		unsigned long attrs)
 {
-	if (mapped_len)
-		dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs);
+	struct iommu_iotlb_gather iotlb_gather;
+
+	iommu_iotlb_gather_init(&iotlb_gather);
+	iotlb_gather.queued = state->__size & DMA_IOVA_USE_FQ;
 
 	/*
 	 * We can be here if the first call to dma_iova_link() failed and
 	 * there is nothing to unlink, so let's be more clear.
 	 */
-	dma_iova_free(dev, state);
+	if (mapped_len)
+		__dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs,
+				&iotlb_gather);
+
+	/*
+	 * Retire the gather together with the IOVA, like __iommu_dma_unmap()
+	 * does: either invalidate the IOTLB now, or hand the IOVA space and
+	 * any page table pages released by the unmap over to the flush queue,
+	 * so the IOVA cannot be reused before the deferred invalidation.
+	 */
+	if (!iotlb_gather.queued)
+		iommu_iotlb_sync(iommu_get_dma_domain(dev), &iotlb_gather);
+	__dma_iova_free(dev, state, &iotlb_gather);
 }
 EXPORT_SYMBOL_GPL(dma_iova_destroy);
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 0ebf3090ea0f..7524c14f1262 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -135,11 +135,17 @@ struct dma_iova_state {
  */
 #define DMA_IOVA_USE_SWIOTLB		(1ULL << 63)
 
+/*
+ * Set when the IOVA space is going to be released through the IOMMU flush
+ * queue. Internal to dma-iommu.
+ */
+#define DMA_IOVA_USE_FQ			(1ULL << 62)
+
 /*
  * All flags stored in the upper bits of dma_iova_state::__size. Sizes passed
  * to dma_iova_try_alloc() must not overlap with them.
  */
-#define DMA_IOVA_FLAGS			DMA_IOVA_USE_SWIOTLB
+#define DMA_IOVA_FLAGS			(DMA_IOVA_USE_SWIOTLB | DMA_IOVA_USE_FQ)
 
 static inline size_t dma_iova_size(struct dma_iova_state *state)
 {
-- 
2.43.0

