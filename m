Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116012;
	b=emjr8FoSbouXFSVz3aUv/d9px2olbhu7XY2a7k4DVj1rr1BzMw7Yv45PWdIsLn2wC0sf
	 qlGbSw7Rac7zAYlB2PlvRRKXErjHkwzjtC2yHIuaiFPoAXs6HS2hI9aQTnu+8b/G7g76g
	 BQ79WrRqTysGLm9vdsRWr1T20lVTkE4i2jRCKI5WsMVCWw/qdM7cDweiG8xTMP7UrL6na
	 lPTZ1BI81+Z+v1KXZxZOJesoLna+C+XYBocWt69HhelQ4GX1BwvWz1mfl61ARGfZUoKLN
	 ld/2Yo730ZRhO8zTSyjsB+dAYkkdRsL1rl37m8qd31HXAEFrw99zPg6o5mhXpmV0YlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116012;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=JvUszYBU/N7jUawur+/6LzByWky1OpFKDF6ZGnWFJlw=;
	b=dE3sNYYuPLMdyJV+YJv8/B+AzLSKT4ScCAQpSsqw31oOF2eJ2uonSGO48qH6M9pzmOUg
	 uYb6tvbo0IzkB3TCemgcIgWhdfo3ZZM8r8Njv9DCKFwdDtYM1bo3kkEG49AzBpXDs/RGA
	 t6n5c/3VarXFNf1sNjXWUIUI+WPD61AMuGNzuG1RYe9eY7z6cOYs2BGi5Hx3fSUEy+Cto
	 B4IO6CWEI1OGtVzpZW7OenUQfZDyumsgoqyZF0l7Po7g30Bf8X4JGWBDVFRyWqtrGfVpg
	 W5hfzlnUIpem5qJ+n0dBilaLexM8rPCMcPdXaMnKJTNkbiDzMVXGeFmjdQJE7WtVwkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3Of6IeD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA1360A262B;
	Tue, 27 Oct 2026 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3Of6IeD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF9E1F01828;
	Tue, 27 Oct 2026 15:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793116012;
	bh=JvUszYBU/N7jUawur+/6LzByWky1OpFKDF6ZGnWFJlw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=D3Of6IeD944gEsByi1tbI5kVhZhWbjXQlclLubW2T1BCFomUIgZ3LiHyJdVbW4wiQ
	 mAtsKV8es4WuDsxvE+ZuAtQk2qfD61e0q0AYJUylBM09jV/Eaq9b3UDwxSJ0gOeQQR
	 dAqu98gTBNqbQQTVPUpR91e5mFj047yif4/mbU0+aLm61mTti9/N4ChkEaQMnn16sY
	 2ug5VoUaUGE0SFNSt3ZwMg1XhXVuZ4sOMacqIx1V4N+Ma6LVErvFQNKSDSgf7Sfyhz
	 zYBUmfrIK6ZJOrukO5VHUz5esNzs1UuAbpYLUiT015rOonxPmM01Bts1KWSeEzwdr7
	 10E8xzbi4qH6A==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 27 Oct 2026 16:46:31 +0100
Subject: [PATCH 5/9] mm, page_alloc: pass zone pointer to
 trace_reclaim_retry_zone
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-pgalloc-ai-hotfixes-v1-5-9c7d1aca801e@kernel.org>
References: <20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org>
In-Reply-To: <20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0

From: Josef Bacik <josef@toxicpanda.com>

should_reclaim_retry() walks a zonelist and passes the zoneref pointer
to the reclaim_retry_zone tracepoint, which loads the zone from the
entry again to find the node.

Memory hotplug rebuilds the zonelists in place while allocations are
under way. When a zone in front of the zoneref entry has become empty,
the entries move up, and this one can be the end marker by the time the
tracepoint looks at it. zonelist_node_idx() then dereferences a NULL
zone. Short of that, the event can name another zone than the one its
numbers belong to.

Pass the zone pointer instead of the zoneref pointer.

Fixes: d379f01de095 ("oom, trace: add oom detection tracepoints")
Cc: <stable@vger.kernel.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 include/trace/events/oom.h | 8 ++++----
 mm/page_alloc.c            | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index 9f0a5d1482c4..cbcf6fe4cc61 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -33,7 +33,7 @@ TRACE_EVENT(oom_score_adj_update,
 
 TRACE_EVENT(reclaim_retry_zone,
 
-	TP_PROTO(struct zoneref *zoneref,
+	TP_PROTO(struct zone *zone,
 		int order,
 		unsigned long reclaimable,
 		unsigned long available,
@@ -41,7 +41,7 @@ TRACE_EVENT(reclaim_retry_zone,
 		int no_progress_loops,
 		bool wmark_check),
 
-	TP_ARGS(zoneref, order, reclaimable, available, min_wmark, no_progress_loops, wmark_check),
+	TP_ARGS(zone, order, reclaimable, available, min_wmark, no_progress_loops, wmark_check),
 
 	TP_STRUCT__entry(
 		__field(	int, node)
@@ -55,8 +55,8 @@ TRACE_EVENT(reclaim_retry_zone,
 	),
 
 	TP_fast_assign(
-		__entry->node = zonelist_node_idx(zoneref);
-		__entry->zone_idx = zonelist_zone_idx(zoneref);
+		__entry->node = zone_to_nid(zone);
+		__entry->zone_idx = zone_idx(zone);
 		__entry->order = order;
 		__entry->reclaimable = reclaimable;
 		__entry->available = available;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 13211b8caada..8f8885165045 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4675,7 +4675,7 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		 */
 		wmark = __zone_watermark_ok(zone, order, min_wmark,
 				ac->highest_zoneidx, alloc_flags, available);
-		trace_reclaim_retry_zone(z, order, reclaimable,
+		trace_reclaim_retry_zone(zone, order, reclaimable,
 				available, min_wmark, *no_progress_loops, wmark);
 		if (wmark) {
 			ret = true;

-- 
2.56.0

