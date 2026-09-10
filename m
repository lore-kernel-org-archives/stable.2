Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EF724501D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057895; cv=none; b=u2BCZqwy2P+0RyBBbNMQ3+/FNYXLIz0koPY9ZQ5lhtijchtLDl7jZRdCAO68h43tbEDbVgyb73f+VIyICZkBfX67PPr1eKR8U+GuGPYpmbMgYVGt29rNY3rwxOHTSOnTFi/N8Xwv/NBELuZrUu8DSW2IrA+PTcziuP71pukIPhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057895; c=relaxed/simple;
	bh=l1zS6SfykBOh2nwOA2Q6k62VAlUCclCrf/AcKpidv/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKmURVAV9lW3LL+XV1X+QdnTyMKo2TlGfIlx2sSNHXR9qQY2XrqX7TzeBpViLulbhpiXGfSHlucWtV4JKpOCX12pS27FbHp8I+DC6h5S0Yig75hyxJxiQP87sw7jDM5ZN1+4rkKkfGIXEPGdftET39kfmClrjkqpC+vv47vlhqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1E6C5C/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1E6C5C/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1390D1F000FF;
	Thu, 10 Sep 2026 16:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789057890;
	bh=r7numk0Amwxm0rbnhxd2d9oQnfSNv1+Hu1jJohl/OHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g1E6C5C/9QHWgiRUD6HBnl19SS+EhpuA+wdIWfeYB5IxcBQ1jpj+OoTgerRmXUQjg
	 yFhzh8CAkx0kbgCtZJ6UgsriY0qomIBAJS0hhc84n//2h4QuLuQt9ZTwyLziKAiFJ+
	 rGqDIO9HOq8FCKOFK3/dn6KLtYDjL8xlLqoO6w2MvKuZfBG5gdF9GaTU9rWVDhL/+4
	 CF7ArOQqjAAXACcOamhYwF7Da6CFgkh+mfMLVnLNb6F69aKU46X0VKHz0xNCIuPatU
	 L/1n8Sl0EY2KroN9dwOXZKgq9pOqDyNIMqbCqzEts3F6TUMEuYTMHWN201W7MUQU7u
	 DnBR1uz6Qn9zA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] dma-direct: cleanup parameters to dma_direct_optimal_gfp_mask
Date: Thu, 10 Sep 2026 12:31:27 -0400
Message-ID: <20260910163128.1220623-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090812-sway-tubular-8b4a@gregkh>
References: <2026090812-sway-tubular-8b4a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petr Tesarik <petrtesarik@huaweicloud.com>

[ Upstream commit 25a4ce564921db0973b74c04e0ea23bd2ee12a3a ]

Since both callers of dma_direct_optimal_gfp_mask() pass
dev->coherent_dma_mask as the second argument, it is better to
remove that parameter altogether.

Not only is reducing number of parameters good for readability, but
the new function signature is also more logical: The optimal flags
depend only on data contained in struct device.

While touching this code, let's also rename phys_mask to phys_limit
in dma_direct_alloc_from_pool(), because it is indeed a limit.

Signed-off-by: Petr Tesarik <petrtesarik@huaweicloud.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>

Backport preparation for 94a04ad732c9 on Linux 5.10:

Apply the parameter cleanup to the existing allocation paths without
importing the newer SWIOTLB allocation helpers or pool warning.

Keep the 5.10 atomic-pool eligibility test in a dma_direct_use_pool macro
and name the existing remapping condition locally. This preserves the
CONFIG_DMA_COHERENT_POOL and nonblocking checks while aligning both pool
call sites so the target's struct page return fix merges cleanly. Reuse
the remapping condition in the existing remap path. No functions are added.

Stable-dep-of: 94a04ad732c9 ("dma-direct: return struct page from dma_direct_alloc_from_pool()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 2922250f93b44..24fe791b4c06c 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -44,10 +44,11 @@ u64 dma_direct_get_required_mask(struct device *dev)
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
 
-static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
-				  u64 *phys_limit)
+static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
 {
-	u64 dma_limit = min_not_zero(dma_mask, dev->bus_dma_limit);
+	u64 dma_limit = min_not_zero(
+		dev->coherent_dma_mask,
+		dev->bus_dma_limit);
 
 	/*
 	 * Optimistically try the zone that the physical address mask falls
@@ -84,8 +85,7 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	WARN_ON_ONCE(!PAGE_ALIGNED(size));
 
-	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
-					   &phys_limit);
+	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
 	page = dma_alloc_contiguous(dev, size, gfp);
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 		dma_free_contiguous(dev, page, size);
@@ -114,15 +114,18 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	return page;
 }
 
+/* Atomic DMA pools are only available with CONFIG_DMA_COHERENT_POOL. */
+#define dma_direct_use_pool(dev, gfp) \
+	(IS_ENABLED(CONFIG_DMA_COHERENT_POOL) && !gfpflags_allow_blocking(gfp))
+
 static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
 	struct page *page;
-	u64 phys_mask;
+	u64 phys_limit;
 	void *ret;
 
-	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
-					   &phys_mask);
+	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
 	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
 	if (!page)
 		return NULL;
@@ -133,6 +136,8 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
+	bool remap = IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+		!dev_is_dma_coherent(dev);
 	struct page *page;
 	void *ret;
 	int err;
@@ -163,10 +168,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * Remapping or decrypting memory may block. If either is required and
 	 * we can't block, allocate the memory from the atomic pools.
 	 */
-	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
-	    !gfpflags_allow_blocking(gfp) &&
-	    (force_dma_unencrypted(dev) ||
-	     (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) && !dev_is_dma_coherent(dev))))
+	if ((remap || force_dma_unencrypted(dev)) &&
+	    dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	/* we always manually zero the memory once we are done */
@@ -174,9 +177,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
-	if ((IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	     !dev_is_dma_coherent(dev)) ||
-	    (IS_ENABLED(CONFIG_DMA_REMAP) && PageHighMem(page))) {
+	if (remap || (IS_ENABLED(CONFIG_DMA_REMAP) && PageHighMem(page))) {
 		/* remove any dirty cache lines on the kernel alias */
 		arch_dma_prep_coherent(page, size);
 
@@ -280,8 +281,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	struct page *page;
 	void *ret;
 
-	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
-	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp))
+	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	page = __dma_direct_alloc_pages(dev, size, gfp);
-- 
2.53.0

