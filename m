Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494D737BE71
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784732426; cv=none; b=XFmVkyvpGPFpCexBdIb4knwndwnotkQjUjLNbQmKo6RJ0qtahfZKdhi5bLTVgD32QfW9MDNuyuLfrIgp0WQr4L4reo9o70gJiI3XIOqKSj6YO0/Eafj8yaOnIUVCHB9cl6o26PAsrG3k/aC1OlOqPQ5cCU9qjjIehK2jk+2mQh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784732426; c=relaxed/simple;
	bh=QKg5YGY/yCLwZN3vmT5c5UttyqkYjSANMRTryN3kfVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uT4b2OyrJOWJJjm/FUu1Bdkc30E+ZxYuyLuHeYjT624GJ8ezhdVEMGkm6SXRWMhVpXbsobLj6wSms83/fgWg63aot9LeJ6V6UDggMsQTBtQgj53OQf0gV7DaFIvMOmaIfBbFhIdU7NwP4miJXT+wu7+VKvm29pLWaDt5MRKGsKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=YquYS/A8; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="YquYS/A8"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8efb708b1a0so124735146d6.3
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 08:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1784732422; x=1785337222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ssUPrZXhmKEtcaomL/NSzb6q5Qkj8exc1H0XDUvt4yE=;
        b=YquYS/A81i4NStxAz2sixHxEV0vy/5FSbqv9AzkNe9wO41B/Q14lKBPu5zR6toHgVl
         dcLMhkU/wYun0sQKnBOSM3sSiz7G1NBONgJZDRdueIaC43Qir3PZj6ZEdk6lDW26IETh
         WltWVga59seLsifIWTqK6+yHhMBVRqaZbGjEhWaQmIjh4Z/sMTjlr3wdCcirq4JOPlkW
         A+4lye9IOCWnVYAs/4hfhEZcOd6E9QnmF5K4ddc7Unr2wfA8ezMpg6LU+sh1pFVEoFlG
         oE4/HiAFPIb+InIxP9GKbEr3fKNaJxemnET9GMMJdHDGE8Ht4aflCjPF/OEbL5zcAGCB
         E0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784732422; x=1785337222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ssUPrZXhmKEtcaomL/NSzb6q5Qkj8exc1H0XDUvt4yE=;
        b=kbir4yMsv1ZSrSDoXS/4qaZGJL8rljvrD01Ce5akKhGUV9xYlrbR1QIs5MC+BTOETq
         PHAvqbdeVlD8fGYuG6pyyFRppyrMtWH2NgS1AC7CM2JpdDvOWlY20dKJx9GgD0rCHlg9
         7J5Bvliv+3Tezz6OC4gm970e5FJMzZ0DdW8xs191JLRSMMDj9IIYquRyRbZMnT/2ttDm
         gunVRu8022qdEzna5EpHEJxh+/CSEMZtPQXlvAl7ImlLkswgwlY8GmpNKztNgHqF35vd
         FVIs8/vuIdhWUGG50UpNZnfTFysyOdbj3JBt/MbnFkt6GtFHZKRQGOQh20m59V3FAb2P
         pgqA==
X-Forwarded-Encrypted: i=1; AHgh+RpSkGpCHBhQbvnO2nZWWmLLLCDUZKQChtc45EP4MmtcRFUExPB/T5H/tq7z3ZGjrcBZrsR05bM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8iuXmMRCsgOW3NEk9AFPNDl899NNlq65inHOnE2DKvVyZZMCK
	58rE8lVLkKeN0NZVBFlaSmtJLv54pLBha19FTbC3waei6QNVVxsiz/vt/t0d6MzihKk=
X-Gm-Gg: AR+sD10cBOGls27oRRKUPEFykiixpBjDUx1nZzHc3CfqRJRazsQuHamb45CQ4uvf7ZS
	jt4As1n7eEiqkbdy/bBxIMmERCrAI/tD3peOKTD2Z+59S9Pp56D4ejonnwx43HjqOvzDT1PyaYo
	oZ+gsHCSEGu0EG/aJmDv0RHhSmwewEHJ6LyWbNzntIbGwekTHqzhVEbB6hgJV7wr+dqFeDriw3T
	9bK07MPsg6LwL2pHutnly0OhDcDJ6S8kcI1P2NoIEUgzUEvg7ivO86W3T7rsUrBb7lMuBqP9fvH
	sS+7t8QriY+qvap5siESjtWJ7qj3Qqz/2UvbWy3gm0eyLFuKsHAzf2dHM4tcQ8LmzpgQck1N6jA
	G4JOfHVqZayc1Eb5kdUNubiB9YztHBgsHAE5eBYHLro50bgdjS2rDXUli4Q7qY6LANx2pfuGIYH
	cz
X-Received: by 2002:a05:6214:3912:b0:8f1:323a:eede with SMTP id 6a1803df08f44-9077835ab03mr252766896d6.14.1784732418083;
        Wed, 22 Jul 2026 08:00:18 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907baa0a146sm22359506d6.33.2026.07.22.08.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:00:17 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] mm: page_alloc: fix non-movable reclaim storm in defrag_mode
Date: Wed, 22 Jul 2026 10:56:47 -0400
Message-ID: <20260722150006.3848560-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722150006.3848560-1-hannes@cmpxchg.org>
References: <20260722150006.3848560-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As we deployed defrag_mode into Meta production, pressure spikes and
excessive swapping were observed on some workloads. Tracing confirmed
that this is unmovable/reclaimable requests spinning in the allocator
and direct reclaim, causing excessive amounts of swap.

The initial plan for defrag_mode was to rely on kswapd/kcompactd to
produce blocks, and if those are overwhelmed under high pressure, let
the allocator fall back (__rmqueue_steal()) after its retry loops.
However, that retrying results in more reclaim on some of these
workloads than we'd hoped, sometimes excessively so, spurred on by the
!costly order conditions in should_reclaim_retry().

The storms are dependent on the request type. Reclaim will inevitably
make room in existing movable blocks, since that's where the LRU pages
live. So if movable requests retry on reclaim, they make progress.

When non-movable requests spin in reclaim that isn't productive. They
cannot use the individually freed pages, and the process is unlikely
to accidentally free whole blocks to meet the ALLOC_NOFRAGMENT bar.
They spin and overreclaim excessively, which tanks performance and
triggers userspace guards like swap exhaustion or pressure based OOM.

To fix this, send non-movable requests, regardless of order, into
pageblock reclaim/compaction. This way, they help move things along to
meet the ALLOC_NOFRAGMENT bar. After this patch, the reclaim storms
and excess OOM rates are no longer observed in production.

The longer-term plan is still to have all requests, including the
movable ones, help make blocks to spread the cost of defragmenting
more evenly and fairly; combined with proper watermarking to reduce
allocation latencies in the common case. However, doing this naively
unearths scaling and concurrency limitations in compaction that need
to be addressed first. Promoting just non-movables for now is the
minimally viable bug fix for the above issue.

Fixes: e3aa7df331bc ("mm: page_alloc: defrag_mode")
Cc: <stable@vger.kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/internal.h   |  6 ++++++
 mm/page_alloc.c | 31 ++++++++++++++++++++++++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 6d3402001b93..5acba3470659 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1061,6 +1061,12 @@ struct compact_control {
 struct capture_control {
 	struct zone *zone;
 	int migratetype;
+	/*
+	 * Allocation request order. May differ from the compaction
+	 * order: defrag_mode promotes sub-block allocations to
+	 * pageblock-order compaction; capture still matches at the
+	 * original allocation order so prep_new_page() is consistent.
+	 */
 	int order;
 	struct page *page;
 };
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4b9686fedb71..f92055827ae9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4152,8 +4152,24 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 		.order = order,
 		.page = NULL,
 	};
+	int compact_order = order;
 
-	if (!order)
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
+	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
+		compact_order = max(order, pageblock_order);
+
+	if (!compact_order)
 		return NULL;
 
 	psi_memstall_enter(&pflags);
@@ -4169,8 +4185,8 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 	barrier();
 	WRITE_ONCE(current->capture_control, &capc);
 
-	*compact_result = try_to_compact_pages(gfp_mask, order, alloc_flags, ac,
-							       prio, &capc);
+	*compact_result = try_to_compact_pages(gfp_mask, compact_order,
+					       alloc_flags, ac, prio, &capc);
 
 	/*
 	 * Make sure we hide capture control first before we read the captured
@@ -4215,7 +4231,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 		struct zone *zone = page_zone(page);
 
 		zone->compact_blockskip_flush = false;
-		compaction_defer_reset(zone, order, true);
+		compaction_defer_reset(zone, compact_order, true);
 		count_vm_event(COMPACTSUCCESS);
 		return page;
 	}
@@ -4455,9 +4471,14 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
 	struct page *page = NULL;
 	unsigned long pflags;
 	bool drained = false;
+	int reclaim_order = order;
+
+	/* Match the slowpath compaction promotion in __alloc_pages_direct_compact */
+	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
+		reclaim_order = max(order, pageblock_order);
 
 	psi_memstall_enter(&pflags);
-	*did_some_progress = __perform_reclaim(gfp_mask, order, ac);
+	*did_some_progress = __perform_reclaim(gfp_mask, reclaim_order, ac);
 	if (unlikely(!(*did_some_progress)))
 		goto out;
 
-- 
2.55.0

