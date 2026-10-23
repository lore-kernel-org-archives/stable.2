Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757525;
	b=r2dnYFS17HHKLx8Fakiaa9bDDYagiX0vv5KRmdQmVwCCkINesPwwDEjrAJHu+cKkI83h
	 Bf3q3T+Vf3V8hSVeYEBKitictYcetqFVDzNze11v5OuVx7o8My6IFZ58jYnrNiMAuXeIn
	 bqQlqAsMZxZ/ehksRwnpCyCLXNVC7jcCmf+TTFwUa/BAAp9eUIPImdVLxpDyPUQGVhweo
	 PiVBnnal6R+wsL65ZhE/a2InPjn32J7KRTsZGykYYDAYrcNNdSkhyFtn4o+oz+aofD66y
	 BSZZdQyaNYFbCxHMCRMNycstkJSPlxqgH7Bl/ngI+VHePlng4HI7mDxUa+zSQhaYSyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757525;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ImYp/IPwQsXrDYWR+V9PS9Kn2or/ZDe5R9PkfcXo1aI=;
	b=HkbW6aVi8RiYWiMQPBMZkGt3UZEOA2c1m5BkLFDCNeeUNLLKSuYykTe/7FIBE8qZKxWZ
	 SQyJVgNb95aB+ZbeTAfqS1xqoKFA22aweCkDqgFrFeBCEB0o8Fos1YqRucBWDzj5fSfsC
	 zMDinkCRUfdPDL2S5eS+WknMBoBiUnDqT+LnENrD4OPApK6DOLGxdlid3VFpR5gieazJJ
	 c1RZXS0611BwfAcc/n2qm8Tb1qpkdX3hWpqpvxYmu1v+/9LpYrdhG5ljMj9eEbNJ5d7Cx
	 1/88Q0OJ/NYvImiIqn41Zdnahn+BlWekcmlgCJg6Ay3Jk/UFGtjdRDDMFb1TbgL68JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVPS0krV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8073606A31D;
	Fri, 23 Oct 2026 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVPS0krV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F011F01829;
	Fri, 23 Oct 2026 12:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792757524;
	bh=ImYp/IPwQsXrDYWR+V9PS9Kn2or/ZDe5R9PkfcXo1aI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SVPS0krV7UVfxB/t0FK0SH7mV6ho4nTRAKr5EUn+Sb83csr9miwvCgXK4fUoGPASc
	 1U8sdoNZCiPg6JmgZjJubD0QeKeug2/lwrIwb+fGa0Vvw3OrxdOG5PY+nLoYgtcuA0
	 bGXchw83SSxkVgUhE0ZHDKE9C+pczoU+6DJ8PgQKONOfQy83FExJ+DdU43htRiRnA4
	 LH1SSxNoosy00JwQKqijxanF0K69tZ/+jcRW/Nc8/b+yRNc/ntwIJvRSN1uM7tSVl6
	 t5xXjkQYE9kqN6BkapPao869n2tEreUUlHepPoq1qRAhmyOjiL6+y42eaWASoYumPE
	 JmA5xt+ydho5w==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 8D721198003A;
	Fri, 23 Oct 2026 08:11:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 23 Oct 2026 08:12:02 -0400
X-ME-Sender: <xms:D0_bat4GuVXmUWIv3hyB_ZTKFvH3lv9UsxSxixWJtTowTBV63rWcAQ>
    <xme:D0_baq2h_JPEgpEuNOsRzosFIrB2cEQQuEpj_Olslc6qNCVWYOBVzbOzM6t9o5F3h
    Et7DBvMs2q1u5YgNfdMxFZ1jn81fgCkONrj7-gbh248o9YfY2Xh6xiZ>
X-ME-Received: <xmr:D0_bagBjTx2ev5A0Rur3Kfr4OXV6YfaQnPW5_zuMxG_NnsIXFVTKxA5CIvE>
X-ME-Proxy-Cause: dmFkZTEdCODWc9ddUGfQ4IOOOUIzoI0QKn5AfHqJtw1V6MzsndNiVR6Fdr/mXoaWAmVI4y
    uY1QiFXKxypQCoi4bEwLt8i36uyuf08mEYtOrIP4Q5NcUxwKXM8rojL2DoON/E2E23DYz9
    CrW7KMsILXA3yS6c9BMcx/yWxDXhhwJRmWHiv26frewJvlsQcJ9pDN+8weOOCzfG4rz1Fe
    QC1GGthUktNol0YwvoqI0833s9Cs2W7b7Dz6DRMF281msR95Jl/oVgk/dDR4axNz81Nzpb
    BI/sbAbDiB79cre0zrLm59IYHJSFXZnAgmdfu3rLuxKzGM/O6SI+iZRgwnZcoqgAP5X5Bd
    hO3fdXdwFR5STfU89F9zRsKZ51QgcYhHDQ+dFHX+dtg6hlzpDWDHerSMZulY/OalQcyzsp
    0e6B8xElvH6Yw5z75/MM65prLFAZl6aXLIct3PzAANYQey7EpQDquo+0ZE+OOCodaOlYVX
    7WVf+nMqhWcIsBfVWUF3KtW6CaftIKnr1xTGuKxKceJuIkzrD5iy4fUa5N01aqy6dN0BGe
    mrOANLkZ35S4ARS7srCCMR/qpOMggBzyX/SFNWyvcyTOPFB45bJrpRqK+GuBgIkdN40TG9
    drzZ26MXlTM3kVZviggvsT3KYXeTq31CnkGaidqaG6WNa3Av84jrAXWqfJWw
X-ME-Proxy: <xmx:D0_barF7h25de_YVBj_3NXyfzdtNX9PF6AwMgBnbjBTIQlKg9bsDGg>
    <xmx:D0_baqpU9uqMEpmljW8SUa90ocLqpfKiqRJuunD50ec82E_mP1rHtQ>
    <xmx:D0_bar0lfvCjS1LgvhR8lT74fxO3s_QujIZPnCCPHaBeQBWhcJ2JwQ>
    <xmx:D0_bamD1BuUrQwTkprGacWI4RJDmXIGB5l79Sv-i7-AlPaaaQAITzQ>
    <xmx:D0_bau_We9bglLWvjVSI8Sg2MMGMNXcLhASix1Mxqb4OjaO5g1ZvLBru>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 08:11:58 -0400 (EDT)
Date: Fri, 23 Oct 2026 13:11:56 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Harry Yoo <harry@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v3] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-ID: <attOFXch_TchIfEv@thinkstation>
References: <15a9e03e-c748-4e51-b8cc-583a3610c897@kernel.org>
 <20261012192834.6934ef85444dee4a60d6d876@linux-foundation.org>
 <as5q14OsbK2CmOrh@thinkstation>
 <20261014202936.GC371161@cmpxchg.org>
 <78238103-3a7f-432c-b1df-bd14d7cf4bb1@kernel.org>
 <atDMN5MoGrwJNpAj@thinkstation>
 <4aa14b41-9b89-494c-8825-55fffd5a541c@arm.com>
 <atiCG2iPrHwDznSZ@thinkstation>
 <d2b8edf0-39ab-4a44-bd0d-58230dee2fad@arm.com>
 <ats7oFM-fsYdUS8y@thinkstation>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ats7oFM-fsYdUS8y@thinkstation>

On Fri, Oct 23, 2026 at 11:59:06AM +0100, Kiryl Shutsemau wrote:
> 64K allocation is still lower with defrag_mode. I will look into this
> further.

Direct reclaim has the same problem.

compaction_ready() and should_continue_reclaim() ask the same watermark
check whether the allocation can already succeed. The free order-4+
pages left in unmovable pageblocks make it say yes, and reclaim stops
early.

I tried to generalize the fix: __zone_watermark_ok() takes the request's
migratetype and, under ALLOC_NOFRAGMENT, does not count other
migratetypes' free pages below pageblock_order. Direct reclaim learns
ALLOC_NOFRAGMENT from the allocation.

Medians of 15 runs of "compact-bench 99 64 16 20 0":

                             defrag_mode=0  defrag_mode=1  defrag_mode=1
                                                           + diff
    compact_stall                    2135          32476          8022
    compact_fail                      668          32330          4880
    64K anon_fault_alloc            20689           6780         19649
    64K anon_fault_fallback           776          14502          1851

The diff below replaces the previous one. It needs cleanup and splitting
before it goes upstream.

Could you give it a try?

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 94f9c3ff5416..f924940b5475 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1629,7 +1629,7 @@ static inline unsigned long pgdat_end_pfn(pg_data_t *pgdat)
 void build_all_zonelists(pg_data_t *pgdat);
 bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 			 int highest_zoneidx, unsigned int alloc_flags,
-			 long free_pages);
+			 long free_pages, int migratetype);
 bool zone_watermark_ok(struct zone *z, unsigned int order,
 		unsigned long mark, int highest_zoneidx,
 		unsigned int alloc_flags);
diff --git a/mm/compaction.c b/mm/compaction.c
index a049415512c6..420ff6c735eb 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2344,7 +2344,8 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 					high_wmark_pages(cc->zone),
 					cc->highest_zoneidx, cc->alloc_flags,
 					zone_page_state(cc->zone,
-							NR_FREE_PAGES_BLOCKS)))
+							NR_FREE_PAGES_BLOCKS),
+					cc->migratetype))
 			return COMPACT_SUCCESS;
 
 		return COMPACT_CONTINUE;
@@ -2365,6 +2366,11 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 			!free_area_empty(area, MIGRATE_CMA))
 			return COMPACT_SUCCESS;
 #endif
+		/* Under ALLOC_NOFRAGMENT it may only claim a whole block */
+		if ((cc->alloc_flags & ALLOC_NOFRAGMENT) &&
+		    order < pageblock_order)
+			continue;
+
 		/*
 		 * Job done if allocation would steal freepages from
 		 * other migratetype buddy lists.
@@ -2425,7 +2431,7 @@ static bool __compaction_suitable(struct zone *zone, int order,
 	if (order > PAGE_ALLOC_COSTLY_ORDER)
 		watermark += low_wmark_pages(zone) - min_wmark_pages(zone);
 	return __zone_watermark_ok(zone, 0, watermark, highest_zoneidx,
-				   ALLOC_CMA, free_pages);
+				   ALLOC_CMA, free_pages, MIGRATE_MOVABLE);
 }
 
 /*
@@ -2520,7 +2526,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 static enum compact_result
 compaction_suit_allocation_order(struct zone *zone, unsigned int order,
 				 int highest_zoneidx, unsigned int alloc_flags,
-				 bool async, bool kcompactd)
+				 int migratetype, bool async, bool kcompactd)
 {
 	unsigned long free_pages;
 	unsigned long watermark;
@@ -2532,7 +2538,7 @@ compaction_suit_allocation_order(struct zone *zone, unsigned int order,
 
 	watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
 	if (__zone_watermark_ok(zone, order, watermark, highest_zoneidx,
-				alloc_flags, free_pages))
+				alloc_flags, free_pages, migratetype))
 		return COMPACT_SUCCESS;
 
 	/*
@@ -2548,7 +2554,8 @@ compaction_suit_allocation_order(struct zone *zone, unsigned int order,
 	    !(alloc_flags & ALLOC_CMA)) {
 		if (!__zone_watermark_ok(zone, 0, watermark + compact_gap(order),
 					 highest_zoneidx, 0,
-					 zone_page_state(zone, NR_FREE_PAGES)))
+					 zone_page_state(zone, NR_FREE_PAGES),
+					 migratetype))
 			return COMPACT_SKIPPED;
 	}
 
@@ -2588,6 +2595,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 		ret = compaction_suit_allocation_order(cc->zone, cc->order,
 						       cc->highest_zoneidx,
 						       cc->alloc_flags,
+						       cc->migratetype,
 						       cc->mode == MIGRATE_ASYNC,
 						       !cc->direct_compaction);
 		if (ret != COMPACT_CONTINUE)
@@ -3073,7 +3081,7 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
 		ret = compaction_suit_allocation_order(zone,
 				pgdat->kcompactd_max_order,
 				highest_zoneidx, alloc_flags,
-				false, true);
+				MIGRATE_MOVABLE, false, true);
 		if (ret == COMPACT_CONTINUE)
 			return true;
 	}
@@ -3116,7 +3124,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 
 		ret = compaction_suit_allocation_order(zone,
 				cc.order, zoneid, cc.alloc_flags,
-				false, true);
+				MIGRATE_MOVABLE, false, true);
 		if (ret != COMPACT_CONTINUE)
 			continue;
 
diff --git a/mm/internal.h b/mm/internal.h
index 38b1165212c9..5a7556999ad2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -68,7 +68,8 @@ void folio_mark_lazyfree(struct folio *folio);
 /* mm/vmscan.c */
 unsigned long zone_reclaimable_pages(struct zone *zone);
 unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
-				gfp_t gfp_mask, const nodemask_t *mask);
+				gfp_t gfp_mask, const nodemask_t *mask,
+				bool nofragment);
 unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru,
 			      int zone_idx);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 12fac9084c48..83a52acf9c9c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3597,7 +3597,7 @@ static inline long __zone_watermark_unusable_free(struct zone *z,
  */
 bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 			 int highest_zoneidx, unsigned int alloc_flags,
-			 long free_pages)
+			 long free_pages, int migratetype)
 {
 	long min = mark;
 	int o;
@@ -3655,6 +3655,14 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 			continue;
 
 		for (mt = 0; mt < MIGRATE_PCPTYPES; mt++) {
+			/*
+			 * Under ALLOC_NOFRAGMENT, a request below
+			 * pageblock_order can take another migratetype's page
+			 * only by claiming the whole block.
+			 */
+			if ((alloc_flags & ALLOC_NOFRAGMENT) &&
+			    mt != migratetype && o < pageblock_order)
+				continue;
 			if (!free_area_empty(area, mt))
 				return true;
 		}
@@ -3676,8 +3684,11 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 bool zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 		      int highest_zoneidx, unsigned int alloc_flags)
 {
-	return __zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
-					zone_page_state(z, NR_FREE_PAGES));
+	/* Without the request's migratetype, count every migratetype's pages */
+	return __zone_watermark_ok(z, order, mark, highest_zoneidx,
+				   alloc_flags & ~ALLOC_NOFRAGMENT,
+				   zone_page_state(z, NR_FREE_PAGES),
+				   MIGRATE_MOVABLE);
 }
 
 static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
@@ -3706,7 +3717,7 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 	}
 
 	if (__zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
-					free_pages))
+				free_pages, gfp_migratetype(gfp_mask)))
 		return true;
 
 	/*
@@ -3719,7 +3730,8 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 		&& ((alloc_flags & ALLOC_WMARK_MASK) == WMARK_MIN))) {
 		mark = z->_watermark[WMARK_MIN];
 		return __zone_watermark_ok(z, order, mark, highest_zoneidx,
-					alloc_flags, free_pages);
+					alloc_flags, free_pages,
+					gfp_migratetype(gfp_mask));
 	}
 
 	return false;
@@ -4435,7 +4447,7 @@ static unsigned int check_retry_zonelist(unsigned int seq)
 
 /* Perform direct synchronous page reclaim */
 static unsigned long
-__perform_reclaim(gfp_t gfp_mask, unsigned int order,
+__perform_reclaim(gfp_t gfp_mask, unsigned int order, unsigned int alloc_flags,
 					const struct alloc_context *ac)
 {
 	unsigned int noreclaim_flag;
@@ -4449,7 +4461,8 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	progress = try_to_free_pages(ac->zonelist, order, gfp_mask,
-								ac->nodemask);
+				     ac->nodemask,
+				     alloc_flags & ALLOC_NOFRAGMENT);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 	fs_reclaim_release(gfp_mask);
@@ -4475,7 +4488,8 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
 		reclaim_order = max(order, pageblock_order);
 
 	psi_memstall_enter(&pflags);
-	*did_some_progress = __perform_reclaim(gfp_mask, reclaim_order, ac);
+	*did_some_progress = __perform_reclaim(gfp_mask, reclaim_order,
+					       alloc_flags, ac);
 	if (unlikely(!(*did_some_progress)))
 		goto out;
 
@@ -4682,10 +4696,12 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 
 		/*
 		 * Would the allocation succeed if we reclaimed all
-		 * reclaimable pages?
+		 * reclaimable pages?  Count free pages of every migratetype.
 		 */
 		wmark = __zone_watermark_ok(zone, order, min_wmark,
-				ac->highest_zoneidx, alloc_flags, available);
+				ac->highest_zoneidx,
+				alloc_flags & ~ALLOC_NOFRAGMENT,
+				available, ac->migratetype);
 		trace_reclaim_retry_zone(z, order, reclaimable,
 				available, min_wmark, *no_progress_loops, wmark);
 		if (wmark) {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f11491ee9ed5..f7c561c40e55 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -142,6 +142,9 @@ struct scan_control {
 	/* One of the zones is ready for compaction */
 	unsigned int compaction_ready:1;
 
+	/* The allocation cannot fall back to other migratetypes' blocks */
+	unsigned int nofragment:1;
+
 	/* There is easily reclaimable cold cache in the current node */
 	unsigned int cache_trim_mode:1;
 
@@ -6098,6 +6101,17 @@ static bool in_reclaim_compaction(struct scan_control *sc)
 	return false;
 }
 
+static bool allocation_can_succeed(struct zone *zone, struct scan_control *sc,
+				   unsigned long mark)
+{
+	unsigned int alloc_flags = sc->nofragment ? ALLOC_NOFRAGMENT : 0;
+	long free_pages = zone_page_state(zone, NR_FREE_PAGES);
+	int migratetype = gfp_migratetype(sc->gfp_mask);
+
+	return __zone_watermark_ok(zone, sc->order, mark, sc->reclaim_idx,
+				   alloc_flags, free_pages, migratetype);
+}
+
 /*
  * Reclaim/compaction is used for high-order allocation requests. It reclaims
  * order-0 pages before compacting the zone. should_continue_reclaim() returns
@@ -6136,8 +6150,7 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 		unsigned long watermark = min_wmark_pages(zone);
 
 		/* Allocation can already succeed, nothing to do */
-		if (zone_watermark_ok(zone, sc->order, watermark,
-				      sc->reclaim_idx, 0))
+		if (allocation_can_succeed(zone, sc, watermark))
 			return false;
 
 		if (compaction_suitable(zone, sc->order, watermark,
@@ -6362,8 +6375,7 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 		return false;
 
 	/* Allocation can already succeed, nothing to do */
-	if (zone_watermark_ok(zone, sc->order, min_wmark_pages(zone),
-			      sc->reclaim_idx, 0))
+	if (allocation_can_succeed(zone, sc, min_wmark_pages(zone)))
 		return true;
 
 	/*
@@ -6767,7 +6779,8 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
 }
 
 unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
-				gfp_t gfp_mask, const nodemask_t *nodemask)
+				gfp_t gfp_mask, const nodemask_t *nodemask,
+				bool nofragment)
 {
 	unsigned long nr_reclaimed;
 	struct scan_control sc = {
@@ -6780,6 +6793,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 		.may_writepage = 1,
 		.may_unmap = 1,
 		.may_swap = 1,
+		.nofragment = nofragment,
 	};
 
 	/*
@@ -7011,7 +7025,7 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
 			free_pages = zone_page_state_snapshot(zone, item);
 
 		if (__zone_watermark_ok(zone, order, mark, highest_zoneidx,
-					0, free_pages))
+					0, free_pages, MIGRATE_MOVABLE))
 			return true;
 	}
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
