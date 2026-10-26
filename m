Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008481;
	b=eBjJrLxkliLRmQ0kQKAOHYjK16HSQD32H4voheQB9XFDASh+Ga7z5MhM2OYXQgs55op4
	 N3AspJdYtdt0RuLMvA8NESSQyehquNYOgF/45JDMWbD+T86hbuHgsx7rhjTRVW8BXHG5g
	 i0ItHLDU/vdKy3E4Oy6vWDYUNCVlmNUj69uB/M5p35EWYXkL+6yFUCrIyxdMYJQPcet6K
	 +UhXY+eXU2hPGSf5+lwag1bgdylerqzGhr5QM9KmWtmtw5a3NDuXQoltdmax50t+4OPIn
	 zgnr8dB5XgTHRxHVRTMI2+9f6kZXIdPoNOGzw1dhxQsl+R7jHs8sbJguw1et+vDmNAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008481;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=W3hVhpPdKeNN02AYtbG5/w1KwFA9zux4/7rF7tBrUlg=;
	b=s9ODcuj/3OkaIFIEnSstg8OhHCJYA5j2/TAZMdWCQd2AehIf7csdVdaYiCae0AcQdqo8
	 9peRD0qF9o5y7v/5O1ABjo5sXyk52wJF08GNtNUw2EpfBokr4BkTmpanddI7Vx3sWuxai
	 /6WjcRRKWUoVrqEVZL5LVIzK8R+aqCQNOpL9lUqQJ+U1b12YCdZRiNx5L/WvBwe8oejYW
	 rvrjoG5moyFQXzn+TXLesKjxdO/zzHsvi39bN2B0Rly+sr3+LvhoNIy05BIZdspTQo79A
	 StE7GCCM1OVduEFmOfSx9eY9gWEvyYpFbE+3kH3HwZWHODj33TjFgL8f6fm9UxT2W0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Op6PLYQT;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC71F60A261A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC71F60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Op6PLYQT
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261026095436euoutp020f0d3725ce68eff9b5ee7b1c8422e28f~iC7WpcUCY0960309603euoutp023
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:54:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261026095436euoutp020f0d3725ce68eff9b5ee7b1c8422e28f~iC7WpcUCY0960309603euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793008476;
	bh=W3hVhpPdKeNN02AYtbG5/w1KwFA9zux4/7rF7tBrUlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Op6PLYQThs3o9WhYilJPOd6yuyq2yIQce7wcdsRGJbJjbdIpQtDtWaUXOhZhwfDZu
	 ziGyIck1PoSIlwHeBX2meW4zZO8U+vF9jYa/ON6f86EPHuAfWNeiBmly8mF+MyT4DF
	 5GPwWV3X5GzMcRgAFQV8JkvsJPYydjEQzlaA9p+s=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261026095436eucas1p295baef3daff27873165c70d6d578c1b6~iC7WbUZpq2819828198eucas1p2Y;
	Mon, 26 Oct 2026 09:54:36 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261026095435eusmtip2d32ee7313ebdb42c92622940079571b2~iC7WHsbsj1301813018eusmtip23;
	Mon, 26 Oct 2026 09:54:35 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 4/5] dma-pool: release CMA pages on atomic_pool_expand()
 error path
Date: Mon, 26 Oct 2026 10:54:15 +0100
Message-ID: <20261026095423.966856-5-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261026095436eucas1p295baef3daff27873165c70d6d578c1b6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261026095436eucas1p295baef3daff27873165c70d6d578c1b6
X-EPHeader: CA
X-CMS-RootMailID: 20261026095436eucas1p295baef3daff27873165c70d6d578c1b6
References: <20261026095423.966856-1-m.szyprowski@samsung.com>
	<CGME20261026095436eucas1p295baef3daff27873165c70d6d578c1b6@eucas1p2.samsung.com>

atomic_pool_expand() may allocate the pool backing pages from CMA via
dma_alloc_from_contiguous(), but the error path unconditionally frees
them with __free_pages(). This hands CMA pages to the buddy allocator
while leaving them marked as allocated in the CMA bitmap, permanently
leaking CMA capacity on every failed expansion.

Try dma_release_from_contiguous() first and fall back to __free_pages()
only for pages that did not come from CMA, as the code did before CMA
allocation was temporarily removed from the pool.

Fixes: d7e673ec2c8e ("dma-pool: Only allocate from CMA when in same memory zone")
Closes: https://sashiko.dev/#/bug/linux-fdfc6e83-15e4-4980-9818-691b034397e7
Cc: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/pool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 00f422a1e896..381b3cb28368 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -152,7 +152,8 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 	dma_common_free_remap(addr, pool_size);
 free_page:
 #endif
-	if (!leak_pages)
+	if (!leak_pages &&
+	    !dma_release_from_contiguous(NULL, page, 1 << order))
 		__free_pages(page, order);
 out:
 	return ret;
-- 
2.43.0

