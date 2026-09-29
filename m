Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F75548568;
	Tue, 29 Sep 2026 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703967; cv=none; b=M+xAthChyOcNQ7tnndNuDBS0NctipuiN6nxPejUeWwRSWFaqvXlc0uppeYM+Vs2OXLPT2BF/zvrStmz0yLO7y8yPMBUIKH2aKVh2EFyNbYjemjJ2X7J6supBC7IP0p3J6u0aTOXFII5tbiDRPtitIEi9YRsh3wRcYtV7AlDIoAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703967; c=relaxed/simple;
	bh=GG9vmyDN3zxIQfJWCyk52q7U/2eSDw9IfZ9/sjuxsnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lapqp+GMU0Q2T9Nq/EZ1PVOGhkOAJtC6Q+wphWIYz2g4mWwqMyLxMs3cwlUEiQrx2G6Q+xQbaoxpEgLtRadksV7tNBF6PXYuY+YiOzJQhAyRmk92BR7yideXcjW5C+/7m0vgnFFVXgNZ7IyNsQGt37C3/bYs/7poO7sjWlol0/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=mEZrM0ru; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pibGmYNj; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="mEZrM0ru";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pibGmYNj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 396F5EC00C1;
	Tue, 29 Sep 2026 13:46:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 29 Sep 2026 13:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1790703962; x=1790790362; bh=xYaDr73/bc
	2x48KiPGkBt/LUYLtm5CQPKTJdXW+o7xI=; b=mEZrM0ruycxhlwLj+2yfqbYPLl
	umGiRkpqti5NVkMR2RdiN4NI2hsba4dgZm/flgi2Tgr40ANMsrXIHXPBtGol43ZW
	9nRGVXjsIYs87sIXXjM9hLJkvv3eMgHVOi7BnKnLVxfu1smyEUB7C8RHYCWa5C0c
	r1S7nC8z49rKNprbMX5sWmnFvqA+S4MMaM47tPo6c1Is59rEuhTRPvHNLbXuTd2M
	7izoBfTA3iouNBVAqdOZkXxmxIuNfBht9jlrDq72cVRAnloGCYvsGC/eo1npXl/p
	CCV15UybttM9+QlcsI2nR786EahPm/VSIvtEmAQ5g49DJ1wc1gkPPSevpudw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790703962; x=1790790362; bh=xYaDr73/bc2x48KiPGkBt/LUYLtm5CQPKTJ
	dXW+o7xI=; b=pibGmYNjFlEvYoM5Bw/2eQjTERwdLG1aItEvFeIccLHEgvlyAnM
	2Olm7XLfP2ITgJtDGKNqrrXeIWm5/QGitRjygcyFEI0gV81CnfW0idyy9vUbv095
	EIpm7NncEm/Yep3fKiLfWfC0CDyo4KUSZKc8kAuZ4QrVyCA37tili+NlsSNP/yzy
	wBgrCWSC4jrmaGaraBmzdJJOcFe3KXYvvOiruqkh2HzAiFsDQNnFV92vyK9STzdg
	RsdzNDOFX9K4+TCG0iowPscIuH9lMNfVjYWk4JxHwl9ApRA6dUtLP7DOTxqlECQH
	S2LlTanbXynIt/p8HvFVmRFClow983kaXuw==
X-ME-Sender: <xms:Wfm7akmvqM8f7uMXwu25MjG-zGXs6OjSGbK8dkg9aejmkEVb6GINRw>
    <xme:Wfm7arYHLDT_jEuJEdWmgbDFAS5qhawQTqVqy5gdxlRoNmURX1AnWTDhbg7FVS2Ln
    RIv0sPrXg63LjdcOIzmCR9cIvh4IqwvWDQMhBoPjx0pTXy5mu2RBgUa>
X-ME-Received: <xmr:Wfm7aiTXH9AldnlpXMpmWTFNCklFiaW-rux58Vi1uUpLsi66iS2TEiBCRe4>
X-ME-Proxy-Cause: dmFkZTGiQXNYL99eKp3SE9l0ZmfYVDc8zNcb7fYURtN05SMtW87zJPRiXYMgfK3YXBP7y6
    5mB1C8IBWC9LPSTMYrf8YIxqDXfWziidvhiE/e/3blg1pvqimIho4NENtkLREEAC+FOwsr
    i8G5AwzNUfxCwcaE4TyADpVUbdQPFphcZJrDj+Ii2/HcWzS3oWsUSny9h3kmYKW3QAllKC
    4Cw+aKk8h3bUryonN3OyJXnwGOKVu1FQTEFiJA1FTlwbcn8rWRs71H4c0ecYvB7rqhXo2i
    px5EH9WhAbCs/cRtQCYi13IMfsZ3eyQHBtDtGlmxilWV/V/EYdDUratAsGr3CqZXkxPogj
    wnM7W9tgXMkSMPo4zz4y3lG3psiWCYqS1uAjbtr/kB2D5madNlT8RtCflwUQeOi5CjETsa
    Ww337jDauXLFzHzX7piHtOFDBOx03a6h1TkhZhctqgwD20AO7GIvvFd+kgGa7Ru5d2S18m
    ogmDMWcDa6LnolxwW3golItdIEr3bjpG/SWYziaZHXdzvcqQAJgKQWoW+AEuPcuxBXVJOS
    sZX+IbzsUS++i3wgNYMgICEwIiZ+sBLKObekrMuSse4f3meuiZ+m5/qwFL8THIOUD3pZNw
    MNhUJfEX4HZsfIqbU9EzCfEFCkLb6kyjxjAvxtTLvYv4IiGqm1pNdMSVKFng
X-ME-Proxy: <xmx:Wfm7atVRvHmpoRlfL05Q4Njd0gIlzZZcUNU0b6a6cMhQxd1hibN9Fw>
    <xmx:Wfm7apa9YUGjyCjGMWC83wFv6mRtIE_ZqULt1tex_GveSI5_dc0Mzw>
    <xmx:Wfm7au66wGCMX7R7J08vNupF6BrsCJvYZKyQ2lGHVI1xDsbsOQ855Q>
    <xmx:Wfm7aiyHZYfSr6ARV9cJ4KqpXMMDwW4Jwi7UcLA2Gw2CI6LhXbq4fw>
    <xmx:Wvm7an0XWb_JRFaZFzxGv2Bt14oTQWPWYFSy0TaFPwAtxdhUh53G3kGz>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 13:46:00 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Harry Yoo <harry@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH] mm: page_alloc: make defrag_mode retries follow the promoted order
Date: Tue, 29 Sep 2026 18:45:51 +0100
Message-ID: <20260929174553.175333-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

Since commit 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim
storm in defrag_mode"), direct reclaim and compaction for non-movable
requests under defrag_mode run at pageblock_order, to produce the whole
blocks that ALLOC_NOFRAGMENT needs. The retry decisions that follow
still use the request order. An order-0 request can therefore retry
indefinitely without ever reaching the ALLOC_NOFRAGMENT fallback:

- Reclaim at pageblock_order gives up after one pass as soon as a zone
  looks compaction_ready(), and do_try_to_free_pages() then returns 1
  even though nothing was reclaimed. It returns before the retry that
  would reclaim memory.low-protected cgroups, so when most memory is
  protected, the pass that did run finds next to nothing.

- Compaction at pageblock_order fails or is deferred.

- should_reclaim_retry() takes the reported progress as progress for
  the order-0 request and resets no_progress_loops. The request
  retries.

Order 1-3 requests loop the same way, and should_compact_retry() also
checks their pageblock_order compaction result against the request
order.

On a production host (64G, defrag_mode, memory.low covering most of the
workload), 95% of direct reclaim runs were order-9 runs that returned 1
with nothing reclaimed, at up to 60k runs per second. Across ~200M
should_reclaim_retry() calls in a day, no_progress_loops never left 0.
The spinning allocations were SLUB slab refills for inode and dentry
caches. The time spent registers as memory pressure, and pressure-based
OOM killing takes down both workloads and system services.

Treat promoted requests like costly orders:

- Reclaim progress does not reset no_progress_loops for them.

- should_compact_retry() checks the compaction result at the promoted
  order. It does not retry COMPACT_SKIPPED, since the request can fall
  back, and it does not escalate compaction to COMPACT_PRIO_SYNC_FULL.

When the fallback is taken, reset the retry counters, so that the
fallback attempt gets a full retry budget before the OOM killer is
considered.

In a VM reproducer (32G, defrag_mode, inode churn under memory.low):

                                        before    after
    should_reclaim_retry() calls           63M     293k
    peak memory pressure (PSI some avg10)  99%      12%

File creation runs 5.7x faster.

Fixes: 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim storm in defrag_mode")
Cc: <stable@vger.kernel.org>
Assisted-by: LLM
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/page_alloc.c | 85 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 29 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 12fac9084c48..608487672d93 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4127,6 +4127,31 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	return page;
 }
 
+/*
+ * If fallbacks are not permitted (defrag_mode), we either need to
+ * reclaim space in a block of matching type, or clear out an entire
+ * block to allow __rmqueue_claim() to convert.
+ *
+ * Reclaim by itself is primarily freeing space in movable blocks,
+ * since that's where the LRU pages live. So this works for movable
+ * requests, but not for others.
+ *
+ * For those, promote the order of reclaim and compaction to help make
+ * blocks, instead of spinning in reclaim alone unproductively. Retry
+ * decisions based on the outcome of that work - reclaim progress and
+ * compaction results - must account for the promotion as well, see
+ * should_reclaim_retry() and should_compact_retry().
+ */
+static inline unsigned int nofrag_promote_order(unsigned int order,
+						unsigned int alloc_flags,
+						const struct alloc_context *ac)
+{
+	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
+		return max(order, pageblock_order);
+
+	return order;
+}
+
 /*
  * Maximum number of compaction retries with a progress before OOM
  * killer is consider as the only way to move forward.
@@ -4149,22 +4174,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 		.order = order,
 		.page = NULL,
 	};
-	int compact_order = order;
-
-	/*
-	 * If fallbacks are not permitted (defrag_mode), we either
-	 * need to reclaim space in a block of matching type, or clear
-	 * out an entire block to allow __rmqueue_claim() to convert.
-	 *
-	 * Reclaim by itself is primarily freeing space in movable
-	 * blocks, since that's where the LRU pages live. So this
-	 * works for movable requests, but not for others.
-	 *
-	 * For those, promote the order to help make blocks, instead
-	 * of spinning in reclaim alone unproductively.
-	 */
-	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
-		compact_order = max(order, pageblock_order);
+	unsigned int compact_order = nofrag_promote_order(order, alloc_flags, ac);
 
 	if (!compact_order)
 		return NULL;
@@ -4256,8 +4266,11 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
 	bool ret = false;
 	int retries = *compaction_retries;
 	enum compact_priority priority = *compact_priority;
+	unsigned int compact_order;
 
-	if (!order)
+	/* Check the compaction result at the order compaction ran at */
+	compact_order = nofrag_promote_order(order, alloc_flags, ac);
+	if (!compact_order)
 		return false;
 
 	if (fatal_signal_pending(current))
@@ -4266,10 +4279,14 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
 	/*
 	 * Compaction was skipped due to a lack of free order-0
 	 * migration targets. Continue if reclaim can help.
+	 *
+	 * Promoted requests have exhausted their reclaim retries at
+	 * this point, and they can fall back instead.
 	 */
 	if (compact_result == COMPACT_SKIPPED) {
-		ret = compaction_zonelist_suitable(ac, order, alloc_flags,
-						   gfp_mask);
+		if (compact_order == order)
+			ret = compaction_zonelist_suitable(ac, order, alloc_flags,
+							   gfp_mask);
 		goto out;
 	}
 
@@ -4287,7 +4304,7 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
 		 * need much more detailed feedback from compaction to
 		 * make a better decision.
 		 */
-		if (order > PAGE_ALLOC_COSTLY_ORDER)
+		if (compact_order > PAGE_ALLOC_COSTLY_ORDER)
 			max_retries /= 4;
 
 		if (++(*compaction_retries) <= max_retries) {
@@ -4299,7 +4316,7 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
 	/*
 	 * Compaction failed. Retry with increasing priority.
 	 */
-	min_priority = (order > PAGE_ALLOC_COSTLY_ORDER) ?
+	min_priority = (compact_order > PAGE_ALLOC_COSTLY_ORDER) ?
 			MIN_COMPACT_COSTLY_PRIORITY : MIN_COMPACT_PRIORITY;
 
 	if (*compact_priority > min_priority) {
@@ -4468,11 +4485,7 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
 	struct page *page = NULL;
 	unsigned long pflags;
 	bool drained = false;
-	int reclaim_order = order;
-
-	/* Match the slowpath compaction promotion in __alloc_pages_direct_compact */
-	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
-		reclaim_order = max(order, pageblock_order);
+	unsigned int reclaim_order = nofrag_promote_order(order, alloc_flags, ac);
 
 	psi_memstall_enter(&pflags);
 	*did_some_progress = __perform_reclaim(gfp_mask, reclaim_order, ac);
@@ -4648,9 +4661,17 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	/*
 	 * Costly allocations might have made a progress but this doesn't mean
 	 * their order will become available due to high fragmentation so
-	 * always increment the no progress counter for them
+	 * always increment the no progress counter for them.
+	 *
+	 * The same goes for requests whose reclaim is promoted to make whole
+	 * blocks. At that order, reclaim also reports progress when it backs
+	 * off for compaction without freeing anything.
+	 *
+	 * The watermark check below stays at the request order: it asks
+	 * whether the request itself could succeed after reclaim.
 	 */
-	if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER)
+	if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER &&
+	    nofrag_promote_order(order, alloc_flags, ac) == order)
 		*no_progress_loops = 0;
 	else
 		(*no_progress_loops)++;
@@ -5012,9 +5033,15 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 				 &compaction_retries))
 		goto retry;
 
-	/* Reclaim/compaction failed to prevent the fallback */
+	/*
+	 * Reclaim/compaction failed to prevent the fallback. The retry
+	 * budget was spent on making blocks, not on the request itself;
+	 * give the fallback a fresh one before considering OOM.
+	 */
 	if (defrag_mode && (alloc_flags & ALLOC_NOFRAGMENT)) {
 		alloc_flags &= ~ALLOC_NOFRAGMENT;
+		no_progress_loops = 0;
+		compaction_retries = 0;
 		goto retry;
 	}
 
-- 
2.54.0

