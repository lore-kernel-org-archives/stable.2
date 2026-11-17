Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908073;
	b=5CFaWUehC0R1430j03DgpazUyzBKesqzCdFoXUxwMOHxMR60wyDpNAImb8R7MmjBeoET
	 4sB53wSPcNOyeaCyy1gklJcAzc0AspkJGyHIrhWamJsF7F8IAAPAq1fnRirmYfpj4vlxE
	 xlKAhhuZhPzIFy2dK6UF35M9wATA9EZAczndhzLA7rgO8iOCorrhKsquKkvzaFsVb+7fn
	 yg3vGVlE8gBvwN5qY9md5bZGT3S+VHTKHm5k1q1pVv40JRyV6RvSKF+lar5UJxpJrpXHZ
	 jmg1UUIyvJCaD/0lRv7i92E498vGHDfVY7zYRS5Cs1ZlkJtj9Gp7GHq7NXW2o5BqZeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908073;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Pabw/uWm1cjpx9kdTQH80s4Ttm/z+LkqjaBTBCm9M1Q=;
	b=tgMy6kdP44b5FTLCbbbZFHwHNaw8OSpI75N7pRsjfV7WHVV64T3ziIAX2XA2DXW8bAhS
	 SnJAEmiE2wIkQ5Edsu9B8w6T3o9/OXsksFdhLYxqlOeXpro3T5SWPFAlwVTTrzIc2CT+e
	 QOZRQIRbaGYoMm+mJ4jPuaK/Ei6Vb+BdTl/lheMIK3wIRaCGZ8hz8YwfT2PnX+R96lLd/
	 ViZrrSrfXFY0rlurjXutCS2zOYh6ScYdt7bO7d4BlySGI17GVgufU5bUGbftj7EDj8Z4i
	 6AdwfBIaVpv7RfAW/hCjWw7uoL+vp2NuSyC9WQJWUlA1VJQAqnwSAZRN8OS8BogtVqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=saYThnMd;
	arc=none smtp.remote-ip=91.218.175.190
Received: from mta0.migadu.com (out-190.mta0.migadu.com [91.218.175.190])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DFC606A32F
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0DFC606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=saYThnMd
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ILUpJ4Ob0pNFnAX2ltHw4R7fKp4fmf8Un2vNiqYU0SU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794908070; v=1; x=1795512870;
 b=saYThnMd25FwYHaO2dELkyNcwQBLYWupj19AW6inLkyGWKuqxuwnJ7ByyqAK4RKHv5kR4OdX
 Yhthf3WKRsuyJF/YVmDE/nUeZdzdiTEoE6/ot9JYdsNoQUFHSzDvn9QLDFjMJUAbiyip/DfJkfK
 juSSztSXah+aHs3j+DHUY7HQ=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 81f6557a191836e0;
	Tue, 17 Nov 2026 09:34:30 +0000
X-Mizu-Trace-ID: 81f6557a191836e0
X-Migadu-Flow: FLOW_OUT
From: Qi Zheng <qi.zheng@linux.dev>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	akpm@linux-foundation.org,
	azpijr@gmail.com,
	lance.yang@linux.dev,
	fvdl@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org,
	"Oscar Salvador (SUSE)" <osalvador@kernel.org>
Subject: [PATCH v5 3/3] mm: hugetlb: fix GFP mask propagation to CMA
Date: Tue, 17 Nov 2026 17:33:59 +0800
Message-ID: <990efc61c4c3b2a4186cd578a56c6a74348fcdb1.1794907279.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1794907279.git.zhengqi.arch@bytedance.com>
References: <cover.1794907279.git.zhengqi.arch@bytedance.com>
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

From: Qi Zheng <zhengqi.arch@bytedance.com>

cma_alloc_frozen_compound() uses GFP_KERNEL, allowing direct reclaim
during the first MPOL_PREFERRED_MANY allocation attempt even though
the caller clears __GFP_DIRECT_RECLAIM.

Pass the caller's GFP mask through the helper so CMA respects its
reclaim constraints when trying the preferred nodes.

Fixes: 9bda131c6093 ("mm: cma: add cma_alloc_frozen{_compound}()")
Cc: stable@vger.kernel.org
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
---
 include/linux/cma.h |  2 +-
 mm/cma.c            | 10 ++++++++--
 mm/hugetlb_cma.c    |  4 ++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index d829fd0355bae..d6e97e831d970 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -56,7 +56,7 @@ extern bool cma_release(struct cma *cma, const struct page *pages, unsigned long
 
 struct page *cma_alloc_frozen(struct cma *cma, unsigned long count,
 		unsigned int align, bool no_warn);
-struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order);
+struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order, gfp_t gfp);
 bool cma_release_frozen(struct cma *cma, const struct page *pages,
 		unsigned long count);
 
diff --git a/mm/cma.c b/mm/cma.c
index fea5d1015319d..225e3bbaecf9a 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -944,9 +944,15 @@ struct page *cma_alloc_frozen(struct cma *cma, unsigned long count,
 	return __cma_alloc_frozen(cma, count, align, gfp);
 }
 
-struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order)
+struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order, gfp_t gfp)
 {
-	gfp_t gfp = GFP_KERNEL | __GFP_COMP | __GFP_NOWARN;
+	/*
+	 * The only caller of cma_alloc_frozen_compound() is hugetlb, and
+	 * hugetlb constructs its gfp mask via htlb_alloc_mask(), which already
+	 * sets __GFP_COMP. Check here for usecases bypassing htlb_alloc_mask().
+	 */
+	if (WARN_ON_ONCE(!(gfp & __GFP_COMP)))
+		return NULL;
 
 	return __cma_alloc_frozen(cma, 1 << order, order, gfp);
 }
diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index cd6f64da31a2c..1eb9d8d8732ba 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -71,14 +71,14 @@ struct folio *hugetlb_cma_alloc_frozen_folio(int order, gfp_t gfp_mask,
 	}
 
 	if (hugetlb_cma[nid] && node_isset(nid, *nmask))
-		page = cma_alloc_frozen_compound(hugetlb_cma[nid], order);
+		page = cma_alloc_frozen_compound(hugetlb_cma[nid], order, gfp_mask);
 
 	if (!page && !(gfp_mask & __GFP_THISNODE)) {
 		for_each_node_mask(node, *nmask) {
 			if (node == nid || !hugetlb_cma[node])
 				continue;
 
-			page = cma_alloc_frozen_compound(hugetlb_cma[node], order);
+			page = cma_alloc_frozen_compound(hugetlb_cma[node], order, gfp_mask);
 			if (page)
 				break;
 		}
-- 
2.54.0

