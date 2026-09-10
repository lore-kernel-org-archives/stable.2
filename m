Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0BA49E5C1
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049725; cv=none; b=MsugzRhPcigJZQ+ebBC7h76poL/EVC2Uj/da3HO+g8JDrDp5Wn2i6xIarWp90ENVdBcfFPXxvYV9PZuPQhiGt+FErI2/KX+wYiVY4Qm/PIje1SCTcQcfi0SV9xiYjNnWgBfm6NhNBHoKYCSmeRZvRbOBTrCPRPMQKdJi4Y1eeuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049725; c=relaxed/simple;
	bh=1KVGB0nLwbzVT1bMeaKZLx219yCaRMnfvB0Q41fzfT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=op92ep7jIDi9cSo+iz1BGHqMsgaw73xMNaOOpzCEU0Oae944NubrV0TNMOGW1yN9t2ptUH/EtzyMsmpXtNveJsM25lUINaaEI/++Fd8FN9neIC4l5dSXrRDVvd2/keq/nDMUDFplntiFixlneur95uCW8Fqk8QfjDWfMkNitTZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsCvo9NS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsCvo9NS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565271F000FF;
	Thu, 10 Sep 2026 14:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049723;
	bh=M7v3JouBDUu1BuraLaGAHc0bENwFTsiBRwzp/StiesE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HsCvo9NSs5Zx2+HR+112QOvfe5VabtWNuM2MIgPf1Yosy6YxApMwuL+/mr2X45kCU
	 2GC8gGKi/ISyieMc2YFslctLs1vgPiqn6cG425wRr7KcRjgoYz74neWv8RDWUM9Vm5
	 swFMC/S7LeAwx7jymkgdkjGYogblVGSwzMddML74pL9kCWdnuQlSFVpaIfPXHJQGJG
	 go7FXHh5kO+MfVt1BHadXrzXaxOJMl1q2u9xDQfRtHu8d4tmSVlCtfBesAuDxvQ1wc
	 0H1+lLGy4q0yIXPlw6aRMEMbpUyMV+M/JcIQzTC3BbsQi22kQPEzD94R6oZopwwkgS
	 TZhiUpT87sFlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] dma-direct: cleanup parameters to dma_direct_optimal_gfp_mask
Date: Thu, 10 Sep 2026 10:15:19 -0400
Message-ID: <20260910141521.649048-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090811-upwind-reseller-c91c@gregkh>
References: <2026090811-upwind-reseller-c91c@gregkh>
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
index d4215739efc71..d6871a3fe5f6a 100644
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

