Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CE048EC81
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051177; cv=none; b=ttYermntdzwqo5wUbt2Tng5lM4SG3Y7N92Ss775tQPMzyM7mVN6cwOyOZiYk4G9PPQJRt0yTJ/AxRIM9oG2UFeYYqVshmvAGCowf6vMePO6jsCCK/N30CbaFF0T+7bXW/ffU1lJa2N4j/CZMTeffJnnU44uzG65jKJYVDYtjWzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051177; c=relaxed/simple;
	bh=5AbzimVzM1gwgfm/w8Qd/KF2acJ6VH5SNkYmYFD8IRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzC0v+iIGqCYt+FVUL8CaQPBYrLpX982LHUUtkCDeg02iHoapSlmZGmTAuuC+NCS6fpPcSHE+nTX3gClVg4BLOGRieO+fDZPoMIM6ckmKloihWm3kjtD9st882djo6oEbJoYXZMZfs477Cd5+S0uJrDEZHnApsO8Y+srV2Q9AeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKFB2HCx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKFB2HCx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60D91F000FF;
	Thu, 10 Sep 2026 14:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051175;
	bh=H/OT8i32RXNb8w3svvbOK9bVd8Y0cVM+LvNSjjNnarU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eKFB2HCxsobGGhMcvuPbc6HFj3QRkSdYESJdnGtLz6MLM+zuQCJA2W4bCJv1+j8eH
	 HcQEI7ocUZAqhE9tNSzN12iVOU6UKTtmeYWM4YZeDWgfscdee87WZukrCCOiWZRmai
	 dcRksRDJF0AdFcHK+Ae2EnBjJ+v9IEY7GK+OIeLZZSPvh5WdZ922+UznwLH9fJb0Nc
	 4r8xWJ/gWLh7vO2Ij253RGoUAy1bO5RRnFzuvvBaJb2YBV/SlfFj9v0SnmndQPwbSu
	 OYfua7iWV040JlQcnCMbATKOiWLGiFn9ya9zpBdTUsePtrQSmjpqAoGTXln3wO4Ciw
	 QnPNuzms0ruuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 02/10] dma-direct: refactor the !coherent checks in dma_direct_alloc
Date: Thu, 10 Sep 2026 10:39:23 -0400
Message-ID: <20260910143932.771351-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910143932.771351-1-sashal@kernel.org>
References: <2026090811-unwound-smuggler-adf1@gregkh>
 <20260910143932.771351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit a86d10942db2e0099a369b367fe62898f95987a8 ]

Add a big central !dev_is_dma_coherent(dev) block to deal with as much
as of the uncached allocation schemes and document the schemes a bit
better.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Stable-dep-of: 94a04ad732c9 ("dma-direct: return struct page from dma_direct_alloc_from_pool()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 66 ++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index fd47717af82fd..517ca0e61a57c 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -204,29 +204,49 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
 		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
 
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
-	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
-	    !dev_is_dma_coherent(dev) &&
-	    !is_swiotlb_for_alloc(dev))
-		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
+	if (!dev_is_dma_coherent(dev)) {
+		/*
+		 * Fallback to the arch handler if it exists.  This should
+		 * eventually go away.
+		 */
+		if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
+		    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+		    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
+		    !is_swiotlb_for_alloc(dev))
+			return arch_dma_alloc(dev, size, dma_handle, gfp,
+					      attrs);
 
-	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
-	    !dev_is_dma_coherent(dev))
-		return dma_alloc_from_global_coherent(dev, size, dma_handle);
+		/*
+		 * If there is a global pool, always allocate from it for
+		 * non-coherent devices.
+		 */
+		if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL))
+			return dma_alloc_from_global_coherent(dev, size,
+					dma_handle);
+
+		/*
+		 * Otherwise remap if the architecture is asking for it.  But
+		 * given that remapping memory is a blocking operation we'll
+		 * instead have to dip into the atomic pools.
+		 */
+		remap = IS_ENABLED(CONFIG_DMA_DIRECT_REMAP);
+		if (remap) {
+			if (!gfpflags_allow_blocking(gfp) &&
+			    !is_swiotlb_for_alloc(dev))
+				return dma_direct_alloc_from_pool(dev, size,
+						dma_handle, gfp);
+		} else {
+			if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED))
+				set_uncached = true;
+		}
+	}
 
 	/*
-	 * Remapping or decrypting memory may block. If either is required and
-	 * we can't block, allocate the memory from the atomic pools.
-	 * If restricted DMA (i.e., is_swiotlb_for_alloc) is required, one must
-	 * set up another device coherent pool by shared-dma-pool and use
-	 * dma_alloc_from_dev_coherent instead.
+	 * Decrypting memory may block, so allocate the memory from the atomic
+	 * pools if we can't block.
 	 */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
-	    !gfpflags_allow_blocking(gfp) &&
-	    (force_dma_unencrypted(dev) ||
-	     (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	      !dev_is_dma_coherent(dev))) &&
+	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
 	    !is_swiotlb_for_alloc(dev))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
@@ -234,10 +254,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
 	if (!page)
 		return NULL;
-
-	if (!dev_is_dma_coherent(dev) && IS_ENABLED(CONFIG_DMA_DIRECT_REMAP)) {
-		remap = true;
-	} else if (PageHighMem(page)) {
+	if (PageHighMem(page)) {
 		/*
 		 * Depending on the cma= arguments and per-arch setup,
 		 * dma_alloc_contiguous could return highmem pages.
@@ -249,9 +266,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			goto out_free_pages;
 		}
 		remap = true;
-	} else if (!dev_is_dma_coherent(dev) &&
-		   IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED))
-		set_uncached = true;
+		set_uncached = false;
+	}
 
 	if (remap) {
 		/* remove any dirty cache lines on the kernel alias */
-- 
2.53.0

