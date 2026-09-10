Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BC4489FB2
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051177; cv=none; b=B/mOblZwAjR2U/KyMSrIBnASmqwVOzgTmzlktwRU0vNmB1RLVHzS8xaoPOzRMhAI/f/ra/z0rjv8UIin60jlNVZBu1s8tR1KKbOsNNsD8CuJWyjp+v3iX9rr5Qe+2bVfx2NwabDYnwfG+75tWcjanJswFkkoPNVMVbGK1jBZFUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051177; c=relaxed/simple;
	bh=r6RDmF6NVF/BbgUE8HzetZYNhnitwVfwMAIjHK3FzVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZm4XQzrvx9Ir6qzGROG0TTHjZU37Ku0j/r9VLCuWKTpQwXRlKdX+TERo+xgpKkG5tbJAaL6uMbZAhDDBfas7vpDBMiwop8m7k6rgqx9FidObf+MWgjFC7xl6ZkHoP/MHqmF24qFEqa9fjvnOYTvC0kXidJNOlpsU7U5FkQsu/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezkCTBHP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezkCTBHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5ED1F00893;
	Thu, 10 Sep 2026 14:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051174;
	bh=AUEvzBxc0OY5Fl+hSj2TsLSl3wlxu8MK7mHw/MV5u7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ezkCTBHPAt52uhcLkrgw8euEw8mHUDGee769qh3yKSJcSU4YCFQbPaea9qX+eop74
	 FovtnylZmSZFkyYts+vO4rDuGdjyOywcaWy8x/+DiyF4isFbfISR/umqDdIbDUeao+
	 TaKV5UAOQrwzfb7wMbHAwqEoMiuv7D57dXuY+JDlyEqixmekaNyphX93EJcL40iowx
	 flGEp6J0ZBC5DUVBuLYXQvqRN/q6MJLzymGT7pHSg5n7Dnt3ZjfPyF8b3+cQNJLz8M
	 EGdMlKXFcEy2tggZS07JbS7QXdQpFVEfuJyK46yRWHEZDMTPIPKdiMn2/xHjB0Jx57
	 y7kaXQJ3+KMdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 01/10] dma-direct: clean up the remapping checks in dma_direct_alloc
Date: Thu, 10 Sep 2026 10:39:22 -0400
Message-ID: <20260910143932.771351-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090811-unwound-smuggler-adf1@gregkh>
References: <2026090811-unwound-smuggler-adf1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit f3c962226dbec7a611ddd4eb7af7f4e19f4790ea ]

Add two local variables to track if we want to remap the returned
address using vmap or call dma_set_uncached and use that to simplify
the code flow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Stable-dep-of: 94a04ad732c9 ("dma-direct: return struct page from dma_direct_alloc_from_pool()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 48 ++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index ed5dd9e023241..fd47717af82fd 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -192,6 +192,7 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
 void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
+	bool remap = false, set_uncached = false;
 	struct page *page;
 	void *ret;
 
@@ -234,9 +235,25 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
-	if ((IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	     !dev_is_dma_coherent(dev)) ||
-	    (IS_ENABLED(CONFIG_DMA_REMAP) && PageHighMem(page))) {
+	if (!dev_is_dma_coherent(dev) && IS_ENABLED(CONFIG_DMA_DIRECT_REMAP)) {
+		remap = true;
+	} else if (PageHighMem(page)) {
+		/*
+		 * Depending on the cma= arguments and per-arch setup,
+		 * dma_alloc_contiguous could return highmem pages.
+		 * Without remapping there is no way to return them here, so
+		 * log an error and fail.
+		 */
+		if (!IS_ENABLED(CONFIG_DMA_REMAP)) {
+			dev_info(dev, "Rejecting highmem page from CMA.\n");
+			goto out_free_pages;
+		}
+		remap = true;
+	} else if (!dev_is_dma_coherent(dev) &&
+		   IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED))
+		set_uncached = true;
+
+	if (remap) {
 		/* remove any dirty cache lines on the kernel alias */
 		arch_dma_prep_coherent(page, size);
 
@@ -246,34 +263,21 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 				__builtin_return_address(0));
 		if (!ret)
 			goto out_free_pages;
-		memset(ret, 0, size);
-		goto done;
-	}
-
-	if (PageHighMem(page)) {
-		/*
-		 * Depending on the cma= arguments and per-arch setup
-		 * dma_alloc_contiguous could return highmem pages.
-		 * Without remapping there is no way to return them here,
-		 * so log an error and fail.
-		 */
-		dev_info(dev, "Rejecting highmem page from CMA.\n");
-		goto out_free_pages;
+	} else {
+		ret = page_address(page);
+		if (dma_set_decrypted(dev, ret, size))
+			goto out_free_pages;
 	}
 
-	ret = page_address(page);
-	if (dma_set_decrypted(dev, ret, size))
-		goto out_free_pages;
 	memset(ret, 0, size);
 
-	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
-	    !dev_is_dma_coherent(dev)) {
+	if (set_uncached) {
 		arch_dma_prep_coherent(page, size);
 		ret = arch_dma_set_uncached(ret, size);
 		if (IS_ERR(ret))
 			goto out_encrypt_pages;
 	}
-done:
+
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
 	return ret;
 
-- 
2.53.0

