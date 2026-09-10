Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD83484235
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051179; cv=none; b=Eea29Ep+l1EDml8HwQecrMxMgtYM6nUwqYwrhMTCPhtjRzKTbHQf/G7snvYcWbLN+7r5cxVV8zCBmt35e++B1ypQe4+lLp6scXYqdDHgeP4JVEm8OMIPnGV3yGpY1f8s7MIr3jKG5p4GjmyxojOmuYTOtwPsDu39tucocJ4qLWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051179; c=relaxed/simple;
	bh=wXaypBHtipjqUkMZDNVN3J9uG9I9rXRWOJYGSEIDsew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ckp7PI+vyfo1QEaTXTOPqn+G7De5gfM/X0BQd1icnTlDLnegQilD3Y/ZB6NKaA9MX0GHxjglNkAar8ssDo0d1KFEeT6RA/AHLarEg2IMW68RtxusyCorc+JQHjSWONMXF7gR6o8aTrBUzAzMhLwW6cRlSH7Y9W9IQxQiEbDHS+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W33L86K+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W33L86K+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5BC1F000FF;
	Thu, 10 Sep 2026 14:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051178;
	bh=/4e7wQfBSR0Nlr5Cq6W3xdW/yC+R3rxXEojVCxv10SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W33L86K+k6s6xb6LOyG+JpZgq5NBhqpmxxjbCStnJ3zUVKLXoioHiLHWm9442p7Qh
	 XeiNrkZnw+M9CxDQhrb9AkgtnL1V5rmD+hze+0HbzAmj/1gs9inqCY8H3new+jVNij
	 6pJ/GSXkwb/J6ZfdhP+oTO6F9qUowhqW03ypCaNi17KXWLxusDITEsm3VBnwi31mXI
	 1oqzrnQ3Aj8ILHxYHchDvvvppwu7++SVtn0IqA/PlpGP0JuXINnqYTJ1+mR/2dVaY1
	 gM9YyIU8laVaAH2oTHIlRdnDPvZiCV20JU8rEn1ZpsGnHR2e/fVToXbFQ3QNCZZmZc
	 bFJbuGi0l+Fbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 06/10] dma-direct: factor the swiotlb code out of __dma_direct_alloc_pages
Date: Thu, 10 Sep 2026 10:39:27 -0400
Message-ID: <20260910143932.771351-6-sashal@kernel.org>
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

[ Upstream commit aea7e2a86a94b2583e1e812c596140034398a169 ]

Add a new helper to deal with the swiotlb case.  This keeps the code
nicely boundled and removes the not required call to
dma_direct_optimal_gfp_mask for the swiotlb case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Stable-dep-of: 94a04ad732c9 ("dma-direct: return struct page from dma_direct_alloc_from_pool()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8ed15fd0abf83..0f9b9a52b274c 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -102,6 +102,18 @@ static void __dma_direct_free_pages(struct device *dev, struct page *page,
 	dma_free_contiguous(dev, page, size);
 }
 
+static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
+{
+	struct page *page = swiotlb_alloc(dev, size);
+
+	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
+		swiotlb_free(dev, page, size);
+		return NULL;
+	}
+
+	return page;
+}
+
 static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		gfp_t gfp, bool allow_highmem)
 {
@@ -111,17 +123,11 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	WARN_ON_ONCE(!PAGE_ALIGNED(size));
 
+	if (is_swiotlb_for_alloc(dev))
+		return dma_direct_alloc_swiotlb(dev, size);
+
 	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 					   &phys_limit);
-	if (is_swiotlb_for_alloc(dev)) {
-		page = swiotlb_alloc(dev, size);
-		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
-			__dma_direct_free_pages(dev, page, size);
-			return NULL;
-		}
-		return page;
-	}
-
 	page = dma_alloc_contiguous(dev, size, gfp);
 	if (page) {
 		if (!dma_coherent_ok(dev, page_to_phys(page), size) ||
-- 
2.53.0

