Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAFE48EC81
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051181; cv=none; b=qTQdQAbw8Kd/9P4q0RpCES17x2dmn2DzTYuRuSjIzNdSn2fl7piXDmO/9e3q0HE5QLZXbUtdanmvcpeIU2Rlgbf5rRsydFNJGahFmyPLXDjUsemm350HqUgH/UHKzfVkLWiunllBLIJ2WPHjhpgFJP0KSAAjqa83ElASghTfiEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051181; c=relaxed/simple;
	bh=/yr3Im/1CZBPczHIDisUNUn7VkQp06pFwifBr79egxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4fejrAaBGHk2qvowrH8ts8teY/ljVEZwRylQryQb0v6ptDwUR7q3HmaMOdUFr6/wcQC4hWRfiWCkYMkX2tSTT8FuzghDparzE13TCtbG2U1LpJAkxmnx4KBiEKD1NO3M9bo2yvcJfCBEVlXYjuE25tFNq2RIZcOuMuHpHvsyh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2qKeegA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2qKeegA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411C51F00898;
	Thu, 10 Sep 2026 14:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051179;
	bh=07GrujI9OsmDkeE3v5697yEkzbMkpL9p6Mqz6LwkCEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B2qKeegAz+q4BIuvwwCGCYZA1YI18uZOgqN/E/Nt4V4yFektMfal4qaGUZC64OOES
	 jAZLKKvvFi6sVbAwXo8RWjMgn39fPdAezTXxULyKLsOlEYTwfN+5cjDCpucQg64RRf
	 hf5nmzlxnOf7JGEsgWSAYFjFupUAjeTazTSldPuE7AHMDO7Jff/eWQa/viD6NfvVdp
	 SzAISjfqa28MdKdASFz7jdzlFKaiqr17SA1kShcRZ8FAiFxNk5vUZdsBLuLuxtsp3T
	 HVosS9XATalzhhAsrRAnMtoK6zxuax7pF96g3Z6i2xKqx5lY2jNAwgdN2fp3cMS6Tt
	 q4B6DoJr/53LQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 08/10] dma-direct: cleanup parameters to dma_direct_optimal_gfp_mask
Date: Thu, 10 Sep 2026 10:39:29 -0400
Message-ID: <20260910143932.771351-8-sashal@kernel.org>
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
Stable-dep-of: 94a04ad732c9 ("dma-direct: return struct page from dma_direct_alloc_from_pool()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 97bd785560239..5c4c0c9f1c6d6 100644
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
@@ -126,8 +127,7 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (is_swiotlb_for_alloc(dev))
 		return dma_direct_alloc_swiotlb(dev, size);
 
-	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
-					   &phys_limit);
+	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
 	page = dma_alloc_contiguous(dev, size, gfp);
 	if (page) {
 		if (!dma_coherent_ok(dev, page_to_phys(page), size) ||
@@ -172,14 +172,13 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
 	struct page *page;
-	u64 phys_mask;
+	u64 phys_limit;
 	void *ret;
 
 	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_COHERENT_POOL)))
 		return NULL;
 
-	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
-					   &phys_mask);
+	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
 	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
 	if (!page)
 		return NULL;
-- 
2.53.0

