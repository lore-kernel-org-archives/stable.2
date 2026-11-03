Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721036;
	b=oxloFe9ufZaAfA2JkJTuwUaWCrb4jonzMOBP9UBtNF08ZzcH6lVDR9aEJZFGiNsjNHty
	 1pn0eUJ1030mH2HH/l8o3AIrpqmq4KmjuxV91DJDKu+GSsdM8wry7cuRi2m1nLizFIt4n
	 XThWp38wcBqngdPGS7VHVt8GCmt+O/yDwEC0JqSD+LLW8v02+yVWZLEpWzWp86FqGtPmQ
	 X7fptB+SKOIWA1iCIrbtI3bOr8VVPt9AxAs0Oicjih/1U2Ri2aFYEAa+hncMIaqW19GtL
	 ibA9ESuNtHv+ky6SXzDD4TeYPOmr6WqDz9MJrWRarNGT1x9ppVxg9qGkHZQAHZEoXGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721036;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=jUuh6/lKK6xw8cS+kh/8Cmw6Ho/ruTgSGsuvxXQIYO8=;
	b=I4kbXnMQsgS+7Ovx5T1YhpHL+G3Bylpywd2QrCzvLun4ZLGLRyQ6GKftK5LD7Sh7l6dK
	 4aL28RAShOAdpZfYq3WZswv1XUPiAiSUYWRDKPxSaeIz9mFYN0L6UAbCK+drCT63xaAVy
	 OwvL565pv2hFf4SKsx/nh5/55W6fKD5kop4tt4Fulqu+/WKNkJ+Sb+tYuybvv6TBKrdbk
	 t/MCbez4quJt1mZeRCn7CBfSVS0v0VnP31oiKk/kBEVfBEgaArTrtC22RM0m/vMrMoHqk
	 lr4zPdMY+sw/Ehss5b5IfpgRCju+QrT3Gvp7r/jX7bSWwzFHXYEdT+as+ZLJvIqGjqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Y4X99kLo;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF14606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DF14606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Y4X99kLo
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261103155032euoutp02ba9b6f9493bb3e918b32151d24db8c39~kk8abNe3k2108221082euoutp02R
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:50:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261103155032euoutp02ba9b6f9493bb3e918b32151d24db8c39~kk8abNe3k2108221082euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793721032;
	bh=jUuh6/lKK6xw8cS+kh/8Cmw6Ho/ruTgSGsuvxXQIYO8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Y4X99kLobsyhQQc72bZN6GGWortvk3vdo9DBZoftuF5RFBNpQxCmCagZOLKawFJtz
	 a5NkKdzx18Gg2yJNSHPbW0/diNAmKTA51VJuE8JXhxB38OAy2IFJkiOtdeUDShhji1
	 6/9umFtZBTLDWQFheFJyeWTFVTMzSm6rohN7XvN4=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261103155032eucas1p10934ce1bc0c0e2f1fa86891fb2626862~kk8aFg2gt2502125021eucas1p1S;
	Tue,  3 Nov 2026 15:50:32 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261103155031eusmtip2766ca655008c9ad0bf3b91d2b60bdbd5~kk8ZpZzNZ2102621026eusmtip2L;
	Tue,  3 Nov 2026 15:50:31 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Claire Chang <tientzu@chromium.org>, Konrad
	Rzeszutek Wilk <konrad@kernel.org>, Giorgi Kobakhia <gkobakhi@asu.edu>,
	Michael Kelley <mhklinux@outlook.com>, stable@vger.kernel.org
Subject: [PATCH] dma: swiotlb: Round restricted DMA pool size down to
 IO_TLB_SEGSIZE
Date: Tue,  3 Nov 2026 16:50:15 +0100
Message-ID: <20261103155016.1107958-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261103155032eucas1p10934ce1bc0c0e2f1fa86891fb2626862
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261103155032eucas1p10934ce1bc0c0e2f1fa86891fb2626862
X-EPHeader: CA
X-CMS-RootMailID: 20261103155032eucas1p10934ce1bc0c0e2f1fa86891fb2626862
References: <CGME20261103155032eucas1p10934ce1bc0c0e2f1fa86891fb2626862@eucas1p1.samsung.com>

All other paths creating a swiotlb pool ensure that nslabs is a multiple
of IO_TLB_SEGSIZE, and the swiotlb code relies on that. Since commit
0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization") a
restricted pool can have an arbitrary size taken from the device tree.

If the pool size is not a multiple of IO_TLB_SEGSIZE, the last segment is
partial and swiotlb_release_slots() reads mem->slots[index + nslabs],
which is one past the end of the slots array when the freed buffer ends
at the end of the pool:

 BUG: KASAN: slab-out-of-bounds in swiotlb_release_slots
 Read of size 2

Round the pool size down to a multiple of IO_TLB_SEGSIZE, wasting a bit
of memory, and warn about it.

Reported-by: Giorgi Kobakhia <gkobakhi@asu.edu>
Closes: https://lore.kernel.org/all/20261026032007.1957949-1-gkobakhi@asu.edu/
Fixes: 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization")
CC: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/swiotlb.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 2c57b49ac7c0..a68f35192582 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -2007,6 +2007,19 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 	 */
 	if (!mem) {
 		struct io_tlb_pool *pool;
+		unsigned long aligned_nslabs = ALIGN_DOWN(nslabs, IO_TLB_SEGSIZE);
+
+		if (aligned_nslabs != nslabs) {
+			dev_warn(dev, "Restricted DMA pool size %zu is not a multiple of %lu, rounding down to %lu bytes\n",
+				 (size_t)rmem->size,
+				 (unsigned long)IO_TLB_SEGSIZE << IO_TLB_SHIFT,
+				 aligned_nslabs << IO_TLB_SHIFT);
+			nslabs = aligned_nslabs;
+		}
+		if (!nslabs) {
+			dev_err(dev, "Restricted DMA pool is too small\n");
+			return -EINVAL;
+		}
 
 		mem = kzalloc_obj(*mem);
 		if (!mem)
@@ -2034,7 +2047,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 
 			mem->cc_shared = true;
 			ret = set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
-						   rmem->size >> PAGE_SHIFT);
+						   (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
 			if (ret) {
 				dev_err(dev, "Failed to decrypt restricted DMA pool\n");
 				kfree(pool->areas);
-- 
2.43.0

