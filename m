Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243976;
	b=Swx0CTpnsfSyMAMPut4sQGnd/oRhRxzO13q3gY1tPdVSKHNaHem5euhwCF8mdAqGi8hn
	 UucE8HUretI52mO5eY3UXkxYDILa04hfRtkIHduVt3VXQ99mc8iPY9jfa8puQbwxp1eCb
	 wHySj35xEOywdhDxJ5u0bR2Rgtti37Lf4oj4OPOCc4UbhMytoqPdiRlWqGuowNYkSasgS
	 DP99cT9lSV0reSnp45uAAwtGw1MFdEIroZj4zgDurbEbMnGHdDKbdvQjDUmXynmrWJOtr
	 SIxBOWzAcEJS/nlf/jZbcc6MaM1CC/DybSyJfhMg8us9/gbwEYcCvB9XDnbtNM7226g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243976;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=JyZxIiMEa7i80YYGIuCJFuRQJlQaChaSZ2pdSb11H68=;
	b=hnmwYuI+9Kcm4hBgYxFLG2KosvxSYr1p4IgE8r9Y9BrlsI3MgJvaNS8TxCfOBlMW/uvY
	 K+OMgxwxxr0jpsS+RrH3KGOqiRIjkYYMRPz/fimPzZpGHY4Jh0PqzSBlU0dpOL9/34IDk
	 Ipmxh+w/IO6V2yG8/pQo0zp+r3difVSHJMFmny8nuIvN9jBZlknuTW4V8e4jwXPJNqLiB
	 bKQZ5vBfO7zb+kows6oi0eUt5giTR33e4lZeBbq/mwl6R/NwIW7+r8jVHqkBBMR8QtFUZ
	 5nfrArra0yYK11KW9iFumWScx9qaFNqyl6yYhY+O+DszYQxmFQxTLqIif031rvn9ZqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=l9Pee3bL;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9011C606A325
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 17:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9011C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=l9Pee3bL
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261109170612euoutp01cfec57c6c00a2a35b8ea5495f0297ebd~mb2LlznrY2930929309euoutp01z
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 17:06:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261109170612euoutp01cfec57c6c00a2a35b8ea5495f0297ebd~mb2LlznrY2930929309euoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794243972;
	bh=JyZxIiMEa7i80YYGIuCJFuRQJlQaChaSZ2pdSb11H68=;
	h=From:To:Cc:Subject:Date:References:From;
	b=l9Pee3bLAmMtVbBKzoTWDug+SZ3vCGWajGoM+eA8RStshJVtlkO+RK3ORGIkOBak6
	 g8RP3M8IjvQ1XDMdvR3KL7u/opiuIPTf9Citr/B9oaCVtxd2cJFkWR+zEID4/CPgNF
	 N3KS4oi10CAK+HOfKvAulhH6t4Vm+x+WRPtu9lDg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261109170611eucas1p2366f6f6462a0178990e401e35849edd5~mb2LWDbTo2668126681eucas1p2B;
	Mon,  9 Nov 2026 17:06:11 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261109170611eusmtip21f2fc201cd44cc2a74f1ee08beb62c88~mb2LB0aAx2679626796eusmtip22;
	Mon,  9 Nov 2026 17:06:11 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Petr Tesarik <petr.tesarik.ext@huawei.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] dma: swiotlb: Properly tear down the default pool on
 exit
Date: Mon,  9 Nov 2026 18:06:02 +0100
Message-ID: <20261109170603.385791-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
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
X-CMS-MailID: 20261109170611eucas1p2366f6f6462a0178990e401e35849edd5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261109170611eucas1p2366f6f6462a0178990e401e35849edd5
X-EPHeader: CA
X-CMS-RootMailID: 20261109170611eucas1p2366f6f6462a0178990e401e35849edd5
References: <CGME20261109170611eucas1p2366f6f6462a0178990e401e35849edd5@eucas1p2.samsung.com>

With CONFIG_SWIOTLB_DYNAMIC enabled, the default memory pool is added to
the io_tlb_default_mem.pools RCU list during initialization. When an IOMMU
takes over DMA translation, swiotlb_exit() tears the default pool down and
clears it with memset(), but leaves its node on the pools list. The list
then contains a zeroed entry with a NULL next pointer, and any later walk
of the list, for example mem_used() when reading the io_tlb_used debugfs
file, dereferences an invalid pointer and crashes.

swiotlb_exit() also leaves the io_tlb_default_mem fields that describe
the pool. io_tlb_default_mem.nslabs and can_grow stay set, so
is_swiotlb_allocated() and is_swiotlb_active() keep returning true, and
swiotlb_find_slots() can schedule dynamic pool allocation after teardown.
Without CONFIG_SWIOTLB_DYNAMIC, a later mapping can reach the zeroed
defpool and hit BUG_ON(area_index >= pool->nareas). Before the pool data
was split out of struct io_tlb_mem, swiotlb_exit() cleared the whole
structure, including nslabs.

Clear can_grow and cancel any pending dyn_alloc work, then remove the
default pool from the list and subtract its slots from nslabs, and wait
for an RCU grace period before clearing it, so that no reader can still
see it. Without CONFIG_SWIOTLB_DYNAMIC, reset nslabs directly.

As a result, with CONFIG_SWIOTLB_DYNAMIC swiotlb no longer silently keeps
working through dynamic or transient pools after an IOMMU has turned it
off, so for example dma-iommu bouncing for untrusted devices reports that
bounce buffers are inactive, as it did before the dynamic pools support.

Fixes: 158dbe9c9a3d ("swiotlb: separate memory pool data from other allocator data")
Fixes: 62708b2ba405 ("swiotlb: add a flag whether SWIOTLB is allowed to grow")
Fixes: 1aaa736815eb ("swiotlb: allocate a new memory pool when existing pools are full")
Closes: https://sashiko.dev/#/bug/linux-f75998aa-65ea-4596-9bb4-fa83773012a3
Cc: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
The patch was prepared with LLM assistance.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
---
Changelog:

v2:
- addressed more sashiko.dev pointed issues: clear io_tlb_default_mem.nslabs
  and io_tlb_default_mem.can_grow, as well as cancel io_tlb_default_mem.dyn_alloc

v1: https://lore.kernel.org/all/20261026095423.966856-4-m.szyprowski@samsung.com/
---
 kernel/dma/swiotlb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9b0bc272dd82..786954bc5e6a 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -665,6 +665,17 @@ void __init swiotlb_exit(void)
 		return;
 
 	pr_info("tearing down default memory pool\n");
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+	io_tlb_default_mem.can_grow = false;
+	cancel_work_sync(&io_tlb_default_mem.dyn_alloc);
+	spin_lock(&io_tlb_default_mem.lock);
+	list_del_rcu(&mem->node);
+	io_tlb_default_mem.nslabs -= mem->nslabs;
+	spin_unlock(&io_tlb_default_mem.lock);
+	synchronize_rcu();
+#else
+	io_tlb_default_mem.nslabs = 0;
+#endif
 	tbl_vaddr = (unsigned long)phys_to_virt(mem->start);
 	tbl_size = PAGE_ALIGN(mem->end - mem->start);
 	slots_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), mem->nslabs));
-- 
2.43.0

