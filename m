Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.253
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047484;
	b=e5I3feeAixDOCNTtgOPiCDDi8xDfnUlAxkYrZl2D7gboK3W0D3wP4vhQRhCA/hHT8DjH
	 z2Y949td9rE+Mcl+lXm03AySuf6iSt7qXYJZh4fsNtANzptfEQomFWIDTtktEyNPhJY+d
	 pjY8r3+8jBRkv/V31hKSXr5BsFpozI1MCv/NlEDxL1HjWsekBYB0SZt+jdQEc5Gf77j9l
	 uATM/fe9f4ZbfsCJRJdU9p4/eIXLtXUzoOB148xltZ3RRtcxAWyGBcCaNYwfcaosLcRPJ
	 hsM6lnR9biHCTceFRzg/KX+7vI9P41edSq5jCZvSWGxfaJAqh5XKZ5L/kUMHHd93aag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047484;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3qa8oAW5DrZueQ/BMJ/7YOYYWqHn60qhqkLUj4/UYEY=;
	b=hPfVLO5ryRhbuAi2pVMCaQzErxw2325MICVKABOeSm2B4ReD5AhLJt0xSQ1hWy0Fq2hc
	 NGXi/p3WvnMRGw37cvyeQCLXGW3vkZGkzID0E6uSPwsrtxb06fLUACR0CEKqUhIBWpceP
	 NNYqIxykzhPNi20JxPy4P2xvcTAHbvSKqC69ap8CRDnku0MEsjgc2QylidSYZPvQQ2D6e
	 5PIP1FNM923ya40HJG3MXvKw6jO4L6Flh3KbZ8tO4ByiXvUeG7TF5yQaY9Hkm08DYMvNA
	 Zuf268dJzZ4lpUItfYw8rWhTLgORUXt1rD9E72+DsunFfGy9R9SJHnckfjhc71FQgnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=j56m8Gaq;
	arc=none smtp.remote-ip=91.218.175.253
Received: from mta0.migadu.com (out-253.mta0.migadu.com [91.218.175.253])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B104606D81F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B104606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=j56m8Gaq
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DC3/xFjT+cytEgYhhw4Ov9ae3LqMYLHYR7j8UIs7GXc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794047481; v=1; x=1794652281;
 b=j56m8Gaqvoh+cFzEbg4/MEzg+YppVMNj+sR1fMYzKWYXYWMk2rRjPLTBq8SO1w6np5mAWMKS
 8VeKEBMCAmE8dBSJuEeCcsSEdA1a5gZ2JQuU1TojZXumo3V8uY1Jovsdp75nLJTCjBT+ENf5D8w
 ln0e73O/tbEhcir2eg88or+Q=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id be80d4488337d4f5;
	Sat, 07 Nov 2026 10:31:21 +0000
X-Mizu-Trace-ID: be80d4488337d4f5
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
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] mm: hugetlb: fix GFP mask propagation to CMA
Date: Sat,  7 Nov 2026 18:30:47 +0800
Message-ID: <61ee04513d6cac32347ebec9b295025b8a1f07ca.1794046188.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1794046188.git.zhengqi.arch@bytedance.com>
References: <cover.1794046188.git.zhengqi.arch@bytedance.com>
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
---
 include/linux/cma.h | 2 +-
 mm/cma.c            | 5 +++--
 mm/hugetlb_cma.c    | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

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
index 9ec1d1fd5dff5..45017ed876f76 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -933,9 +933,10 @@ struct page *cma_alloc_frozen(struct cma *cma, unsigned long count,
 	return __cma_alloc_frozen(cma, count, align, gfp);
 }
 
-struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order)
+struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order, gfp_t gfp)
 {
-	gfp_t gfp = GFP_KERNEL | __GFP_COMP | __GFP_NOWARN;
+	if (WARN_ON_ONCE(!(gfp & __GFP_COMP)))
+		return NULL;
 
 	return __cma_alloc_frozen(cma, 1 << order, order, gfp);
 }
diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index 80b2407e9f077..307e5736ecdbe 100644
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

