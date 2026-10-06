Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A903932CD
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278307; cv=none; b=Xlvf7kXtDdtSkDZ7zxHR+AiD9HE4bbElVvoXWhUTj+IVudIvWWSOE7FDs4eElVMQ7fAshdgiR+QENDUMmsZ2Txw9MnUH/jBoUYZdHGnLbSb3DyQMXfyiH2piyORZ7fxAw89mPSc5WYEJbPu2QoowjvKg8LqmQ/yYbD6lWwcQ32w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278307; c=relaxed/simple;
	bh=EqQ0/J4tZYzickGSAfp5bYZsGiez5BeTtSqzTBhlLDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QsCFhDDkQnMqjjlRLvolaupqsVV4FTb8gcCktx8Wicx2kHeyH10wrTkMi65kpJTKt/jNXw1BNJmg2kfU2qdTstgAjHpGKy9IYCkjmT80Qx9M1FQOzattd4tFCtaur0VL3sKxLNQmOM289LX/ivOfgu7s1ADFBSMVXTo78sZfN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=WNw2pdea; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dA9ZmQMZ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="WNw2pdea";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dA9ZmQMZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 25BFDEC0A88
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 05:18:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 06 Oct 2026 05:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1791278300; x=1791364700; bh=DXfWVFdzWM
	RQ9iDD9vys1E4C/WVQnOS4eiTK9NNyV7w=; b=WNw2pdeaeXsaGx0RdVa/2ybV1I
	i0kYr5JHbwx42HD1CsH6vU5/uuzsu52sFyYAwNAr/JpEfJRSeN2sEQa+Wa+bUPHf
	9l/FAiJCt3XYdMBcWA2rckzkKklmmSpVCPN8DSKEFjFttmu1ofRhsRdoSUeBkOXZ
	Q2GSDSxOTXe6UTyg9CkSdR9uin/PG9Fs44dYWkABJg/xLjLFksVnsmM8ntKUBDay
	s+STgROt8QFYMNftURtwRWALOhpAyDEZ736TqFZwnm+mgWdbYhQAAPetpqgvED+W
	3F/mprGIJDvWMu8NSb4c6yUxjn2hTIjRX+8JVZSUq1+HOmke7Di+HLdIVc4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791278300; x=1791364700; bh=DXfWVFdzWMRQ9iDD9vys1E4C/WVQnOS4eiT
	K9NNyV7w=; b=dA9ZmQMZunaw5m+Zqq5upeHCNTdOTYD8Y0E2l0bnInjQoxPUQZk
	F/CVhSeFSmj8wIdr0Jj9aTteSFw3lmldfGk9ArplbbZPHQqaba3JE392MH9//55j
	GK0ltTLNpwExwwyNjeN4ylfH8zmLL7qxKopOX5co1Ji9BNiqhPoiLXs0G1djQyQR
	ZIs+OXzelnKDUA164yV2J0YAjFa+NNiC1uBrN+gifUVfDr3+PEwSa7i4bbtulWSu
	9UjkiAA9U5KhMyRv2Xzlr0Y57Cd+kx5s0PHDUmqqtGUpTY7aMZqbJ/9LB6ua1w0s
	cZa/ezH/ti3PRkoR/6T5zSGpkf8UNLtrGeQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=shutemov.name a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791278300; d=shutemov.name;
	mf=PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:vVUvAKHgGWS44x9Av7NR4uyaeyqtAbPRQfdY/+rWsIeUW/G
	yQshbewsXnqurefCyGg0mY0xtX7/B5EOW/IXKjRPcPxU0N1msdFOA/fjqH45Hef3
	XqyqH+K1nMXKArMtYHO5uxgkNkcFfoAdPyHHvNaK6JzJoGHMP5xKoLzWL6+FSk4g
	dIYkjUXOiELSIJx9siLPQhoukVS+olfiNEATl0ITeFTB9k+HPx/ZS8QrFlmrgsxH
	Kxxs4b9v/D9Z84KDI0LnRd4i8sICDWkkjY11PU/zv+Dxz70cZJSzbDd7/ClSLh4+
	S3zbhxtw+/lFzunIzYXgwFOBdazru+yiQUDZFhQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:QDpJV8Oq7lWRbr6spM/JoUgxKo98Gu54C4fUNAZI4XE=:EqQ0/J4tZYzickGSAfp5bYZsGiez5BeTtSqzTBhlLDU=;
X-ME-Sender: <xms:27zEaufGpKAPDwZ9o9NPciYhIYidk9UU_VdslPy92UTAhRTI7qAbFA>
    <xme:27zEavwJYnZ2luobfbJD1ARP-Xf-vlnPZULMKcrL0KNZsenDmpF5qQ1D1oG-JGZcv
    D-_N7dIIv1_GF1kQQgDNDJKh_ryZZSgFXXMP0rHXYK0c52mNVW1fAqH>
X-ME-Received: <xmr:27zEavKysVNLTiE22ZvSie6OVxviGJfXe0UozMoXnV9wwK-UaXxRMiNU8LY>
X-ME-Proxy-Cause: dmFkZTEuV6x5p6Svnun/6xCsopXC4rEFNWzJaopYoywZiN/3Cowgwzd2kSQ6tf5nAaAbkg
    iJfB8ZihjWJSQSH0IuxjM7kUFs6mKJnYy1kcZnMAAnlrLvM2nZO81kTuo1y1XaDU007RRC
    y3s7bHR2O+wSXZD4NxZazeJ4UjF9kMNb5CgjHI8hdTGnm9fGcxkUJWNv2hcK4mNFd8mq+e
    KSWYy4FVbJptwwa8mHyOxcGAefpVbo74bpDDKJSnO7v8q8RmU9bP/ZbvX5KismatCwEHWN
    OTmPDbADDBs86XqF+utj91mCqx6mNxXzLEyPyOWDKXxaG9abXsyhz5A6a4dAGt112qgWkp
    xhEgPikzTZa8MNdXYRxnWyeS7W13MMyrg15fyvQqjBD3Ab8U7UBVhP7cUytnIV/Fv08yAI
    1giqYnUMEl6nxZjS5dD7KJKkEMXw0t7+Sd1vTG8FEDZeOUn8TXFN6QYDY51PEZBow4AE/b
    Iiz5XWuWLMncrj14lAw2Jy5G3hAiig9NnBBv+UuAyYBIYkw4TkrzFegImwSkBEwus+ieyU
    84FYyyaY/Uws80jNKn9daP6PXXKQH2jzT895wiMimU8lKYT3eVl72OQ9RoGBw1m881Ka07
    4dry5c0qFqFl12tK7sadtzn3vkz61dRoKyOyE21F7Zo6hwRMhVm9umYQYLhA
X-ME-Proxy: <xmx:27zEaov8OdDdJZpfD7JAGE_ZmPsBgcF_Hypw6ESKOgFjeCTI4HEAOQ>
    <xmx:27zEahTxCjA3s5bq-XDfpbIFxOGkui2gnvxjsANBwRE4wKaijiKWFQ>
    <xmx:27zEapTbNr9t2EMowGO-ktBRw11GiHMCUnhsIPme8TCuD4XUE3bD6A>
    <xmx:27zEatqRDu52mZuKID7KnVHlx7uP1eolBLNtnOV_ArA6IVy63i2Enw>
    <xmx:3LzEattnvOFbvRLehzqrBcwPwdH5OwTYNFU6itAntCcfiN1pvD7qn6nu>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 05:18:19 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Harry Yoo <harry@kernel.org>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2] mm: page_alloc: make defrag_mode retries follow the promoted order
Date: Tue,  6 Oct 2026 10:18:13 +0100
Message-ID: <20261006091815.897133-1-kirill@shutemov.name>
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

For promoted requests:

- Reclaim progress does not reset no_progress_loops, as for costly
  orders.

- should_compact_retry() checks the compaction result at the promoted
  order and does not retry COMPACT_SKIPPED, since the request can fall
  back. The compaction priority floor and the COMPACT_SUCCESS retry
  limit stay those of the request order, so a non-costly request still
  gets its COMPACT_PRIO_SYNC_FULL pass before it falls back.

When the fallback is taken, reset the retry counters, so that the
fallback attempt gets a full retry budget before the OOM killer is
considered.

__alloc_pages_slowpath() computes the promoted order once per iteration
and passes it to direct reclaim, direct compaction and the two retry
helpers next to the request order, so no callee has to recompute it.
Harry Yoo asked for the two orders to be explicit rather than derived
in each callee.

In a VM reproducer (32G, defrag_mode, inode churn under memory.low):

                                        before    after
    should_reclaim_retry() calls           63M     293k
    peak memory pressure (PSI some avg10)  99%      12%

File creation runs 5.7x faster.

Fixes: 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim storm in defrag_mode")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
v2:
 - keep the compaction priority floor and the COMPACT_SUCCESS retry
   limit on the request order, so non-costly requests still escalate to
   SYNC_FULL before falling back (Harry Yoo, Johannes Weiner)
 - compute the promoted order once in __alloc_pages_slowpath() and pass
   it to direct reclaim, direct compaction and the retry helpers, instead
   of each of them deriving it (Harry Yoo)

 mm/page_alloc.c | 123 ++++++++++++++++++++++++++++++------------------
 1 file changed, 78 insertions(+), 45 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 12fac9084c48..41830d230f06 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4127,6 +4127,32 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
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
+ * compaction results - must account for the promotion as well, so
+ * __alloc_pages_slowpath() computes the promoted order once and passes
+ * it alongside the request order.
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
@@ -4137,8 +4163,9 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 /* Try memory compaction for high-order allocations before reclaim */
 static struct page *
 __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
-		unsigned int alloc_flags, const struct alloc_context *ac,
-		enum compact_priority prio, enum compact_result *compact_result)
+		unsigned int compact_order, unsigned int alloc_flags,
+		const struct alloc_context *ac, enum compact_priority prio,
+		enum compact_result *compact_result)
 {
 	struct page *page = NULL;
 	unsigned long pflags;
@@ -4149,22 +4176,6 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
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
 
 	if (!compact_order)
 		return NULL;
@@ -4246,7 +4257,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 
 static inline bool
 should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
-		     int alloc_flags,
+		     int compact_order, int alloc_flags,
 		     enum compact_result compact_result,
 		     enum compact_priority *compact_priority,
 		     int *compaction_retries)
@@ -4257,7 +4268,7 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
 	int retries = *compaction_retries;
 	enum compact_priority priority = *compact_priority;
 
-	if (!order)
+	if (!compact_order)
 		return false;
 
 	if (fatal_signal_pending(current))
@@ -4266,10 +4277,14 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
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
 
@@ -4314,8 +4329,9 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
 #else
 static inline struct page *
 __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
-		unsigned int alloc_flags, const struct alloc_context *ac,
-		enum compact_priority prio, enum compact_result *compact_result)
+		unsigned int compact_order, unsigned int alloc_flags,
+		const struct alloc_context *ac, enum compact_priority prio,
+		enum compact_result *compact_result)
 {
 	*compact_result = COMPACT_SKIPPED;
 	return NULL;
@@ -4323,7 +4339,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 
 static inline bool
 should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
-		     int alloc_flags,
+		     int compact_order, int alloc_flags,
 		     enum compact_result compact_result,
 		     enum compact_priority *compact_priority,
 		     int *compaction_retries)
@@ -4462,17 +4478,12 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
 /* The really slow allocator path where we enter direct reclaim */
 static inline struct page *
 __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
-		unsigned int alloc_flags, const struct alloc_context *ac,
-		unsigned long *did_some_progress)
+		unsigned int reclaim_order, unsigned int alloc_flags,
+		const struct alloc_context *ac, unsigned long *did_some_progress)
 {
 	struct page *page = NULL;
 	unsigned long pflags;
 	bool drained = false;
-	int reclaim_order = order;
-
-	/* Match the slowpath compaction promotion in __alloc_pages_direct_compact */
-	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
-		reclaim_order = max(order, pageblock_order);
 
 	psi_memstall_enter(&pflags);
 	*did_some_progress = __perform_reclaim(gfp_mask, reclaim_order, ac);
@@ -4638,8 +4649,9 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
  */
 static inline bool
 should_reclaim_retry(gfp_t gfp_mask, unsigned order,
-		     struct alloc_context *ac, int alloc_flags,
-		     bool did_some_progress, int *no_progress_loops)
+		     unsigned int reclaim_order, struct alloc_context *ac,
+		     int alloc_flags, bool did_some_progress,
+		     int *no_progress_loops)
 {
 	struct zone *zone;
 	struct zoneref *z;
@@ -4648,9 +4660,17 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
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
+	    reclaim_order == order)
 		*no_progress_loops = 0;
 	else
 		(*no_progress_loops)++;
@@ -4790,6 +4810,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
 	struct page *page = NULL;
 	unsigned int alloc_flags;
+	unsigned int reclaim_order;
 	unsigned long did_some_progress;
 	enum compact_priority compact_priority;
 	enum compact_result compact_result;
@@ -4934,17 +4955,22 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	/* If allocation has taken excessively long, warn about it */
 	check_alloc_stall_warn(gfp_mask, ac->nodemask, order, alloc_start_time);
 
+	/* The order reclaim and compaction work at, see nofrag_promote_order() */
+	reclaim_order = nofrag_promote_order(order, alloc_flags, ac);
+
 	/* Try direct reclaim and then allocating */
 	if (!compact_first) {
-		page = __alloc_pages_direct_reclaim(gfp_mask, order, alloc_flags,
-							ac, &did_some_progress);
+		page = __alloc_pages_direct_reclaim(gfp_mask, order, reclaim_order,
+						    alloc_flags, ac,
+						    &did_some_progress);
 		if (page)
 			goto got_pg;
 	}
 
 	/* Try direct compaction and then allocating */
-	page = __alloc_pages_direct_compact(gfp_mask, order, alloc_flags, ac,
-					compact_priority, &compact_result);
+	page = __alloc_pages_direct_compact(gfp_mask, order, reclaim_order,
+					    alloc_flags, ac, compact_priority,
+					    &compact_result);
 	if (page)
 		goto got_pg;
 
@@ -4996,8 +5022,9 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	    check_retry_zonelist(zonelist_iter_cookie))
 		goto restart;
 
-	if (should_reclaim_retry(gfp_mask, order, ac, alloc_flags,
-				 did_some_progress > 0, &no_progress_loops))
+	if (should_reclaim_retry(gfp_mask, order, reclaim_order, ac,
+				 alloc_flags, did_some_progress > 0,
+				 &no_progress_loops))
 		goto retry;
 
 	/*
@@ -5007,14 +5034,20 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * of free memory (see __compaction_suitable)
 	 */
 	if (did_some_progress > 0 && can_compact &&
-	    should_compact_retry(gfp_mask, ac, order, alloc_flags,
-				 compact_result, &compact_priority,
+	    should_compact_retry(gfp_mask, ac, order, reclaim_order,
+				 alloc_flags, compact_result, &compact_priority,
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

