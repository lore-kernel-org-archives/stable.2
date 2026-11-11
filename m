Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379669;
	b=fGGgvMv9gsRlJjylwwOnMZxCZfaJX70P6n5iz/aM+qlrjyowYhpboooJr0dd3MjkzOiy
	 mudL7trOgvCRxgdSAGVHUqnfx6LSG/D9pXOQDaDbuWxVRShbSTAIWR0Ze3Ql7EfUkGtLB
	 +VQq2fRgJPXBfHekI6cERO8YcI6FN+UDteVheS1ytjoSxJR3XTSSX2pEEZEz+RGLl7wxg
	 GI+sA5F9TkHzlZmzRej6sZBsjKQ/hmdiOIG3QlIko3ctfHSwynQWj8PG2XMDzNAquVijq
	 3O+hbm+R86sS4ObfWCYc7zOqZ2TDytUDcLdMBdaReagJHgTeePRmCkM0s9pcIaN55mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379669;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F7M/ZhGLoFak/PJL0fDdgMXUJRkp736gJ7FlUGI9L4w=;
	b=tTgiluKpLNB0E+8FVBZuOsw0h+cSDt0sPYjYAC8XE/OGurAa0wnUWpSWdCNVj5URu9Cp
	 Z6zuerSXJeYLv4CwJG8ofCIGj10v1gfs4meOuMY4PaNUO3t60vLilHRbYJbuFQJRf039M
	 FXRG4A9fYdVsSNxh/3NDxxLIWrv3nPreh4SPqb0qK+0GCCpdmJGXhVoKm9GBhxYMHMI3j
	 pfMTKmqZreJ5G1Db4e22qfDZJH9OBmJr82tal4vP3TEfXE8qX5Z5sFSXLu1mBMJt+/Q61
	 TJtUloCgUb2RQTAV0mVgbTDorbIt+Tt8Gxuc2wiHh1Jh2IAgxqCE32QcP4EMW17Q9Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cfpLrqmh;
	arc=none smtp.remote-ip=91.218.175.8
Received: from mta0.migadu.com (out-8.mta0.migadu.com [91.218.175.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D511606C901
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D511606C901
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cfpLrqmh
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CyrF+6zOUIdoWIi0r/h1EvqhIeae82jXO4tYB0TkHx4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794379666; v=1; x=1794984466;
 b=cfpLrqmhwJJSEliryqhAtj3rr4P6RN4PhBhrTyf8xlUpPxkKHYYlNQ+HBkik6E7bhaS5AXdb
 FW7HPhAkYdrI6Yr6tLbvgh3PBQvAfsesFgU/Nvq7mp5d5BQdhp8rqygAWfgX2ooWHza6GYrO3PH
 E71rVcTI8f+pT8wwZl+6FjzA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 439764ee18b4fcfd;
	Wed, 11 Nov 2026 06:47:46 +0000
X-Mizu-Trace-ID: 439764ee18b4fcfd
X-Migadu-Flow: FLOW_OUT
From: Qi Zheng <qi.zheng@linux.dev>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	akpm@linux-foundation.org,
	azpijr@gmail.com,
	lance.yang@linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org,
	"Oscar Salvador (SUSE)" <osalvador@kernel.org>
Subject: [PATCH v4 3/3] mm: hugetlb: fix GFP mask propagation to CMA
Date: Wed, 11 Nov 2026 14:46:52 +0800
Message-ID: <1c5e8c4ae230dc238a16f2f42d65bffac6244ad3.1794379434.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1794379433.git.zhengqi.arch@bytedance.com>
References: <cover.1794379433.git.zhengqi.arch@bytedance.com>
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
index 8555d38a97b1a..4539ea5f2c4e8 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -53,7 +53,7 @@ extern bool cma_release(struct cma *cma, const struct page *pages, unsigned long
 
 struct page *cma_alloc_frozen(struct cma *cma, unsigned long count,
 		unsigned int align, bool no_warn);
-struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order);
+struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order, gfp_t gfp);
 bool cma_release_frozen(struct cma *cma, const struct page *pages,
 		unsigned long count);
 
diff --git a/mm/cma.c b/mm/cma.c
index 9ec1d1fd5dff5..a7c47c0e7d070 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -933,9 +933,15 @@ struct page *cma_alloc_frozen(struct cma *cma, unsigned long count,
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
index cd6a64986278a..3e5a30571524a 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -69,14 +69,14 @@ struct folio *hugetlb_cma_alloc_frozen_folio(int order, gfp_t gfp_mask,
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

