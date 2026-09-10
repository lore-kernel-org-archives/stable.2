Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989E0492E27
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051179; cv=none; b=E4VBYrqoidZsPwibVj6FRb8r/LG+fn85dv1zaSdJHD9qP9ABQHIsfV3qzcs9f7e0bbvcYGuOUTxlfKibPJjF+JzlmSuIFMeWoxih5XuP1aGX6Ih2FgfNn6tUNzDlRjabwpa1as8z/QmIG6mXO8erZroDJJeFURI3MklRJWVrJEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051179; c=relaxed/simple;
	bh=tWKqf11wYBUxVOa1OqbRX4uEKRZQ/We8dB6tfE4dOno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLcZkFxi0vhcErSw874iWqFWByFkvh2ZvaIMvF2O/Y01EKV6T6Ognb/6RKm6vU/h64PWMP7nWqv7IsmwrWiuBAqn2QtM1RbynVe0pszYEBatGfCUtFN2RpoztB1Pm4we3caGtJ1tVi8QlJIfn4Qo96H/UIQTl1FSAj3u0MslRnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHVBe5jL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHVBe5jL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7A21F0089A;
	Thu, 10 Sep 2026 14:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051177;
	bh=KnmMR39z3JTmPxGfOSLz8NxLSZx+MFhjhZP9eEtdZqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oHVBe5jLAt3JQEQeZym9FdVuQxGm5ry0mvZRtTpUp9lnzF1XEBmNt7qx6MMETEDtl
	 LzcA6+5tn7gByhczr/FUuX8WgOOxvpV1lh05/y8MKXIrpBIvoA1qkidVitwwurO/x8
	 wwoWXF8BGPhH+pxT5aSdSPYs9BaBhCHo/fsvjubRjGUF/1j0rerHmEZSvrTvEydAEb
	 Yyo8CpQvL+RKX3sOYwwlYgQ9xbeEPH7Rc37B8mkeSTRkY3suuyqFa0Sb8aLOnyfVvE
	 uKbBO+TnQYIF9UQ8ajCvRyfbqUN6UVLfD9g0TJ0BTR8l+T7lpRJuk2cJGkyVD+OqEb
	 EX32pjAHd2vXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 05/10] dma-direct: drop two CONFIG_DMA_RESTRICTED_POOL conditionals
Date: Thu, 10 Sep 2026 10:39:26 -0400
Message-ID: <20260910143932.771351-5-sashal@kernel.org>
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

[ Upstream commit f5d3939a5916c0a8a0b47dcbc33963dbffe74f90 ]

swiotlb_alloc and swiotlb_free are properly stubbed out if
CONFIG_DMA_RESTRICTED_POOL is not set, so skip the extra checks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Stable-dep-of: 94a04ad732c9 ("dma-direct: return struct page from dma_direct_alloc_from_pool()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 5a71b6edfd1cd..8ed15fd0abf83 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -97,8 +97,7 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
 static void __dma_direct_free_pages(struct device *dev, struct page *page,
 				    size_t size)
 {
-	if (IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL) &&
-	    swiotlb_free(dev, page, size))
+	if (swiotlb_free(dev, page, size))
 		return;
 	dma_free_contiguous(dev, page, size);
 }
@@ -114,8 +113,7 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 					   &phys_limit);
-	if (IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL) &&
-	    is_swiotlb_for_alloc(dev)) {
+	if (is_swiotlb_for_alloc(dev)) {
 		page = swiotlb_alloc(dev, size);
 		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 			__dma_direct_free_pages(dev, page, size);
-- 
2.53.0

