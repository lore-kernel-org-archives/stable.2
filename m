Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C9552843E
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913051; cv=none; b=raLFO/IrWQxb6eC7T10/q97EGGMQLvCNm6SFlRKCpNhp9n2MBUFxflvIMd+Ik3AFTIh0e9tz9fRi/Qv7YZjxodkwnpb2CgbN6EOEJvVlRCWQuZpmWdRzk6ywi20nWzSrMKI+XTAF0dpbVVICpk4jpobcgaGPwU27tGSm67q9pXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913051; c=relaxed/simple;
	bh=TfE6K//KSRnXsCDJ/S7kVAoopviRog9/EUFtoyIX3LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaigCswYXS7vkD9PcQ+J7EIGmZvBq8UzD9gDBZtvZehHLVh0n+NQhWR/EHaBziqHkPtwTXtIVOEHNQWKDcVs6zXr1hvBsBqd6ttjPadyodvcRqATAZj8U7dRGlEqpKNY7st13UM1QiP/B00tsNOo5yhCQ0aZuhMqzCEeFodVtaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYKzWQP/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYKzWQP/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAA01F000FF;
	Tue, 13 Oct 2026 17:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791913048;
	bh=ItHOFurF0GFQRA6It6dM40DD3xfzAvazWxmgf/BUmBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZYKzWQP/TIQAZNuFvYlE3KC36JFXTs2ktUyKeVWKtIieEOmsEiHYg0ahihLsSVvY6
	 laVe4LsKmCdNc45nUKXZxwldRp/RlOUFCRufvmDNqARo6VAl0TI9Zpsz3pIOWYY7MR
	 oOHBruWUv/3F7gTn7/+lOoQRWAW3am6a5QtkXa/OsL6JLVpl84k+c523hG+YPu9ejC
	 +ZGG8PwwId+JJ3eioqI3/mOT7aoYq2FYTYlFFdIFn+peMAiL4FNwq1RntUrTZ/brDG
	 nT8gOX0/BP4/NDrm2KI/oDAfeyp217l4qTCT5iYiCQI0G3WP4EYMmBHlEa4wTLHY+8
	 auYJhGmUxd06w==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.ams.internal (Postfix) with ESMTP id BF8D9198003A;
	Tue, 13 Oct 2026 13:37:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 13 Oct 2026 13:37:25 -0400
X-ME-Sender: <xms:UmzOaiscHIsycxuF1Wgm8ZaCIteYieOUZxx2qBIeUFwvjzJIrUFHHg>
    <xme:UmzOavOTcG266AF0GEm0tljePNOQnfAYo-GxygIBpgUcR1QjwTle9lLOpm8dL05_x
    o1L9lV8VjmtGlYRtyWsdS389s1Ogv3IO4P--i9KpZ45O7NsHZplris>
X-ME-Received: <xmr:UmzOasV2Ub_zmk6MreDrMSuypAACJRVX4r2d8r-dQaogmy6-R86O5y3UMKc>
X-ME-Proxy-Cause: dmFkZTGaSLSNEdrEpWVq/xgKAXbkXcancctTX10+wEWv7DMcsnFyMgu9+pSYpo0VGFOySV
    moqua97KZBEfcR4gAqYaCIW/dVL+HGutfIxnyM/WMpKSFNOwWBAosBp80UQh9QHl5/YiY4
    MOtQzMc+1xN/31ohrlOj3YBYtA+TqEjCBxfGTbFh21jxr7Gfuzku5fTiethsnYdr9GTMBM
    0j+646XIMSxbqATS/8JFZzGxEDYizeMzj+edNYuEE8SF4x38s/H5eKD9u/XfKtOq4KT0TW
    HRw2Z1fB7+Gbs3+g6ytGsmBu7/RUOPsrbzRBZNdNopaeoLebR+yMz4uidOcDXUemElOroY
    cMo+bboCvjwLN/OgFggpHevhsSrTU17pItrWJv+cR6fRbzmYLgfQTwPH7nSjLTCjyCUS8B
    CrnMWvmxK2qg2aswD+/4jY/JDhHQY0+uqbMOSJdvVs/l1h9EIR8zHZuuFlGCjVIXMntNzA
    x7zLHGJouJeFyPlhRZIJc5pNPSuIKRhaOG51CDwitW+DZP2tLc+JdAizl/wICHphd9Hr55
    BZQvdYNnAc/MdPGGSwJ6JuX5zeH1WQHdiRszkoIOIFwqEg4W/o2L7oV1Ey1ZS5WlcErIZV
    2lrXKG4/abPTJzXJxCkoLPSx19kBwJjVFQzDY1ltisveB/pLiUyjn2yVWdMA
X-ME-Proxy: <xmx:UmzOaniRk_PRwRPKssrP03tWmo06v0Jmva8PSTxl3Dbl7Hrnk1Vh-g>
    <xmx:UmzOam1r5wB-rj3wVqowbf7-wI5AIOC8eEVMyJYwhDxwq0ot4dPqDg>
    <xmx:UmzOap20-xyq6k_q61RuwrWhyJWqxbVMTsl2T-s2LjKTvyb_C-Zm3A>
    <xmx:UmzOanwk8k9iBfBICuvaAaD-5-biwfJgSiE0W0HCf0RcBZQIusG-6w>
    <xmx:UmzOavuGzwbHJz7CGTbgaicls3plNiHfxHdT0MTm_JKBVn28rqELrNWd>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 13:37:21 -0400 (EDT)
Date: Tue, 13 Oct 2026 18:37:20 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, 
	Harry Yoo <harry@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v3] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-ID: <as5q14OsbK2CmOrh@thinkstation>
References: <20261009125503.126202-1-kas@kernel.org>
 <15a9e03e-c748-4e51-b8cc-583a3610c897@kernel.org>
 <20261012192834.6934ef85444dee4a60d6d876@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012192834.6934ef85444dee4a60d6d876@linux-foundation.org>

On Mon, Oct 12, 2026 at 07:28:34PM -0700, Andrew Morton wrote:
> On Mon, 12 Oct 2026 13:40:36 +0200 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:
> 
> > > In a VM reproducer (32G, defrag_mode, inode churn under memory.low):
> > > 
> > >                                         before    after
> > >     should_reclaim_retry() calls           63M     293k
> > >     peak memory pressure (PSI some avg10)  99%      12%
> > > 
> > > File creation runs 5.7x faster.
> > > 
> > > Fixes: 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim storm in defrag_mode")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: LLM
> > > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > 
> > LGTM, but I think we could simplify and get rid of all the function
> > parameter additions by adding a field to alloc_context instead? We could
> > call it e.g. reclaim_compact_order.
> > 
> > The function nofrag_promote_order() probably doesn't need to exist, given it
> > has just one caller, could be just open coded.
> > 
> > What could be useful instead is wrapper for comparing order vs
> > ac->reclaim_compact_order. E.g. something like bool
> > order_nofrag_promoted(order, ac) ?
> 
> I'm concerned about the sheer size of this patch.  It fixes significant
> issues, but it's not going to be a simple or safe backport.
> 
> So for now please let's optimize for simplicity and backportability and
> defer cleanups for the -rc cycle.
> 
> Of course, if the changes you suggest achieve that then go for it.

They do. The patch with Vlastimil's suggestion is below. It is shorter.
Behaviour is unchanged; the reproducer gives the same results on both
versions.

Vlastimil, does it look like what you had in mind?

> Perhaps we should defer this change into next -rc?  It has cc:stable so
> it'll eventually end up where we want it.

Do you mean the next -rc cycle? I hoped to get it into 7.4-rc1, as we
agreed earlier.

----------------------------------->8----------------------------------

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v4] mm: page_alloc: make defrag_mode retries follow the promoted order

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

When a promoted request takes the fallback, reset the retry counters,
so that the fallback attempt gets a full retry budget before the OOM
killer is considered. A request whose reclaim was not promoted spent
its budget on the request itself and keeps its counters, as Usama Arif
pointed out.

__alloc_pages_slowpath() computes the promoted order once per iteration
and keeps it in alloc_context for direct reclaim, direct compaction and
the two retry helpers, so no callee has to recompute it. Harry Yoo asked
for the promoted order to be explicit rather than derived in each
callee, and Vlastimil Babka suggested alloc_context over new function
parameters.

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
v4:
 - keep the promoted order in alloc_context instead of passing it as a
   new parameter (Vlastimil Babka)

 mm/page_alloc.c | 65 +++++++++++++++++++++++++++++--------------------
 mm/page_alloc.h |  2 ++
 2 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 12fac9084c48..c593913a14f8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4127,6 +4127,12 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	return page;
 }
 
+static inline bool order_nofrag_promoted(unsigned int order,
+					 const struct alloc_context *ac)
+{
+	return ac->reclaim_compact_order != order;
+}
+
 /*
  * Maximum number of compaction retries with a progress before OOM
  * killer is consider as the only way to move forward.
@@ -4149,22 +4155,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
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
+	int compact_order = ac->reclaim_compact_order;
 
 	if (!compact_order)
 		return NULL;
@@ -4257,7 +4248,7 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
 	int retries = *compaction_retries;
 	enum compact_priority priority = *compact_priority;
 
-	if (!order)
+	if (!ac->reclaim_compact_order)
 		return false;
 
 	if (fatal_signal_pending(current))
@@ -4266,10 +4257,12 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
 	/*
 	 * Compaction was skipped due to a lack of free order-0
 	 * migration targets. Continue if reclaim can help.
+	 * Promoted requests fall back instead.
 	 */
 	if (compact_result == COMPACT_SKIPPED) {
-		ret = compaction_zonelist_suitable(ac, order, alloc_flags,
-						   gfp_mask);
+		if (!order_nofrag_promoted(order, ac))
+			ret = compaction_zonelist_suitable(ac, order,
+							   alloc_flags, gfp_mask);
 		goto out;
 	}
 
@@ -4468,11 +4461,7 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
 	struct page *page = NULL;
 	unsigned long pflags;
 	bool drained = false;
-	int reclaim_order = order;
-
-	/* Match the slowpath compaction promotion in __alloc_pages_direct_compact */
-	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
-		reclaim_order = max(order, pageblock_order);
+	int reclaim_order = ac->reclaim_compact_order;
 
 	psi_memstall_enter(&pflags);
 	*did_some_progress = __perform_reclaim(gfp_mask, reclaim_order, ac);
@@ -4648,9 +4637,12 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	/*
 	 * Costly allocations might have made a progress but this doesn't mean
 	 * their order will become available due to high fragmentation so
-	 * always increment the no progress counter for them
+	 * always increment the no progress counter for them. The same goes for
+	 * promoted requests: their reclaim reports progress when it backs off
+	 * for compaction without freeing anything.
 	 */
-	if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER)
+	if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER &&
+	    !order_nofrag_promoted(order, ac))
 		*no_progress_loops = 0;
 	else
 		(*no_progress_loops)++;
@@ -4934,6 +4926,22 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	/* If allocation has taken excessively long, warn about it */
 	check_alloc_stall_warn(gfp_mask, ac->nodemask, order, alloc_start_time);
 
+	/*
+	 * If fallbacks are not permitted (defrag_mode), we either
+	 * need to reclaim space in a block of matching type, or clear
+	 * out an entire block to allow __rmqueue_claim() to convert.
+	 *
+	 * Reclaim by itself is primarily freeing space in movable
+	 * blocks, since that's where the LRU pages live. So this
+	 * works for movable requests, but not for others.
+	 *
+	 * For those, promote the order to help make blocks, instead
+	 * of spinning in reclaim alone unproductively.
+	 */
+	ac->reclaim_compact_order = order;
+	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
+		ac->reclaim_compact_order = max(order, pageblock_order);
+
 	/* Try direct reclaim and then allocating */
 	if (!compact_first) {
 		page = __alloc_pages_direct_reclaim(gfp_mask, order, alloc_flags,
@@ -5015,6 +5023,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	/* Reclaim/compaction failed to prevent the fallback */
 	if (defrag_mode && (alloc_flags & ALLOC_NOFRAGMENT)) {
 		alloc_flags &= ~ALLOC_NOFRAGMENT;
+		/* Retries went into making blocks, start the fallback afresh */
+		if (order_nofrag_promoted(order, ac)) {
+			no_progress_loops = 0;
+			compaction_retries = 0;
+		}
 		goto retry;
 	}
 
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index b9259deddb59..2b1017a91928 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -93,6 +93,8 @@ struct alloc_context {
 	bool spread_dirty_pages;
 	/* Only flags that are global to the whole allocation go here. */
 	unsigned int alloc_flags;
+	/* Set by __alloc_pages_slowpath() before reclaim and compaction */
+	unsigned int reclaim_compact_order;
 };
 
 /*
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
