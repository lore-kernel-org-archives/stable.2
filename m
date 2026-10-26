Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008484;
	b=B8deQl/C7qc7kfmbICsWJVP8rfvjfHahtzMUxzHSxLphRw8kqmjC/SXtb5oh9LpNTzx8
	 ll4is/KBwnt4RADY3edYuFHgHHeYoh9X1xqhjsiJA694j3HdDGU/alM0Z4O0Q6lmEnuYb
	 UVhyzdzORBR8D2yvZUGagTMoADbU+1izC8nUWW+nXWnWq2CahncDeSUHJ814VKc3YSxzl
	 1nz++a/s8FlC7eO4VUgU9iC0oF0iP4AJak32x9lT3q29FCmMbB9VwvzsV6PjQdgt2esJQ
	 rtGRXDYgSG7Ss9pBzApHBiL6XLR1RCUteNCl9oOqkbDRz3VQ5yT2RXBSxxpC8AB7b2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008484;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=0buObtVb/2pC/kcLH42VukkluHC/qbDtR/Zn+I99Ujo=;
	b=Pry5ZOfOkwQwcdL1VM8hD7fAKjVgDODceJIwiUt/KET1rOFZY8nLAiPAcWYAbr/SR0dt
	 qJ700avUoTh02GDcHpOioK3uBSMZHQ2EfaXck9PGe4tS5FyE52VO7g3gu7uAJVTzAk+k4
	 q0BQnJgHVj7SAyryYiH6Br8E+DnvMzS9Dg9twfx3PrbiUVXAMBIFvvSRWgNMTEBRklfTs
	 9G45EtEFnoK6cD5j1M7VJJBXPKx13b8J3/Z6WzCcmIDnlgAjQ45/0IKea057mQ23KItKw
	 BsPAqnwBhh99sRzt3uAh8mu34H6x7+YcPSDiossTzlagKlOGL4dGp0EnVRoa0hO4AwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=pG9lStF7;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE20660A3810
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE20660A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=pG9lStF7
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261026095437euoutp013ccb2f18482b9a7bedd1773b414142ce~iC7XII26S0311503115euoutp01K
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:54:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261026095437euoutp013ccb2f18482b9a7bedd1773b414142ce~iC7XII26S0311503115euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793008477;
	bh=0buObtVb/2pC/kcLH42VukkluHC/qbDtR/Zn+I99Ujo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pG9lStF7Ovzt/SVwF2LbAGXYp4JXFmU8HI3TCfhHdkqs4dkCIEVem5ZbhdnUTLpwP
	 TUSsxR9kiA4Nh1UfZjtiX+6nCB+0Q0Mh3lygJzDLtHuv6g2tobluezruwxKKv4YzF1
	 BngXy3sNYhg5n1jF2ktRZZyMrAywNb8fHUsZnpsM=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261026095436eucas1p1338aced1035d6754d5094555237b6748~iC7W3Atxs2179521795eucas1p1c;
	Mon, 26 Oct 2026 09:54:36 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261026095436eusmtip22ac1be213cbace3810e75d3c89484543~iC7Wg2M2e1180211802eusmtip2Q;
	Mon, 26 Oct 2026 09:54:36 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Lucas Stach
	<l.stach@pengutronix.de>, stable@vger.kernel.org
Subject: [PATCH 5/5] dma-direct: zero memory allocated with
 DMA_ATTR_NO_KERNEL_MAPPING
Date: Mon, 26 Oct 2026 10:54:16 +0100
Message-ID: <20261026095423.966856-6-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026095423.966856-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261026095436eucas1p1338aced1035d6754d5094555237b6748
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261026095436eucas1p1338aced1035d6754d5094555237b6748
X-EPHeader: CA
X-CMS-RootMailID: 20261026095436eucas1p1338aced1035d6754d5094555237b6748
References: <20261026095423.966856-1-m.szyprowski@samsung.com>
	<CGME20261026095436eucas1p1338aced1035d6754d5094555237b6748@eucas1p1.samsung.com>

dma_direct_alloc_no_mapping() explicitly clears __GFP_ZERO before
allocating the pages, so buffers allocated with
DMA_ATTR_NO_KERNEL_MAPPING are handed out with stale contents of the
previously freed pages. Such buffers are typically passed to devices or
mapped to userspace, which may expose old kernel data.

The mask comes from the regular allocation path, which always zeroes the
buffer manually through its kernel mapping once it is set up. The
DMA_ATTR_NO_KERNEL_MAPPING path returns early with only a page cookie,
so it never reaches that memset(). This has been the case since the
attribute was first supported in the generic remap code in commit
e440e26a0251 ("dma-remap: support DMA_ATTR_NO_KERNEL_MAPPING") and was
carried over during dma-direct refactoring.

All other dma_alloc_* paths always return zeroed memory, so do the same
here and pass __GFP_ZERO to the page allocator instead of masking it out.

Fixes: e440e26a0251 ("dma-remap: support DMA_ATTR_NO_KERNEL_MAPPING")
Fixes: d98849aff879 ("dma-direct: handle DMA_ATTR_NO_KERNEL_MAPPING in common code")
Fixes: cf14be0b41c6 ("dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING")
Fixes: 849facea92fa ("dma-direct: simplify the DMA_ATTR_NO_KERNEL_MAPPING handling")
Closes: https://sashiko.dev/#/bug/linux-c4421083-e44e-4373-a2c2-45649ea49c0b
Cc: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/direct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 25e9a86835fd..c8a1ae7c618d 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -202,7 +202,8 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
 {
 	struct page *page;
 
-	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
+	/* always zero the allocated memory */
+	page = __dma_direct_alloc_pages(dev, size, gfp | __GFP_ZERO, true);
 	if (!page)
 		return NULL;
 
-- 
2.43.0

