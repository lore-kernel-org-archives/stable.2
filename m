Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795566454;
	b=sci8DwWONBy24WwbkKcNjwYaDDfQ0m2cMxVNXUFSIyJ0FBcvvZmHmrFavE3CXuPDEdN+
	 KFMSMTKjFCl9uDCpUvsC/UyhA3r2JIBzA912CGYgf+pYM5GPWYRhS2is/leCQ80Y0Q0m9
	 XGxP4QWnaIoTljj6AzpJx7CYRoEz7IInJKvkcHU4eBzNsLqMnDa9Rl5w6wx8Yigc10Hr6
	 RBJHXyQGFiFMcu80BK1ZR/HESggj7sXOIJwB5r0V2mKQ/EwFXaiK5FHTMe+q43/+T3nqY
	 e7EXoHAsoAOIWj+9mYzr73LBKZMCznI7G/Biw0ln/lLHf/7NepKRl67WTW5F8yVRRmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795566454;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8KkZhv6nLVhMayRdVkaWe2hyzuZSEW7DVo4cZuCRt6Q=;
	b=tsEhc/RtKDtsTK1soA+6KLRvLlNQhzhXEEvTbKld9d3NSW8vZDhfJEbCBUo2cMDddbfd
	 +da/fhFaFzLGEvkzAp/hKAyvRgA9dYr9dZwrchQYzjB5gBAQ02PF7PRH/2S4q/PuxG3WL
	 Ee/2yFFkTkXiUyFzvYWu3CmrL9m4lpX5H8IsI15grK99TkRD2rsxXiwa7C/jP5FGU0zxZ
	 FKhGyFpAVrB1F54mOXQKpk98RWEB4IUC1JwV7n1+L41VXBKzTL7L5ivL3DlhpedyKXlVb
	 PHqovCMVLFeWION4JT3yOl/oocjbhggP0hzTYk9JuQfvzQoZOn/ZTUEWhN86P6EF9vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2XgPCBD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F1F606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 00:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2XgPCBD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364531F000C4;
	Wed, 25 Nov 2026 00:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795566453;
	bh=8KkZhv6nLVhMayRdVkaWe2hyzuZSEW7DVo4cZuCRt6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d2XgPCBDteuTdl/WoxXnmzvnM7p/4OH3Aot9NHA0bJhj13OFI6h78B+TR3k/zvJ9y
	 3dqpH2BWXpmIbxp4q39SuWa8Q5E2CaEQHRsqjYvqHg+OY4oWw7NRKAnH3+zh6gOd2m
	 6AzVxSR9Pu7rRxJw5vvmedee72sNzFBS1E62XKX+oMQAg0SW6XH5fCBqXqP5R99jGg
	 FvywkqvxT5UQmFSGQB6IyHsXEWIAOJFRcv/cN3r7Bti4V+QskNDwaI1d949BZRg+X4
	 mKvJ/ldfn4VI8WVjzhdRfbkvQHJlSLnQBAQvtP/Hvz0dpvz2e72RHfuFFkXeXmRP1Z
	 1GMtjAMrZWixg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/page_alloc: retry allocations that raced with a zonelist rebuild
Date: Tue, 24 Nov 2026 19:27:31 -0500
Message-ID: <20261125002123.3430825-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112439-stack-scarf-c441@gregkh>
References: <2026112439-stack-scarf-c441@gregkh>
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

From: "Gregory Price (Meta)" <gourry@gourry.net>

[ Upstream commit bcfc8286f0cd5a74c827d502f9f1ad408d7eff30 ]

Onlining the first block of a zone rebuilds every zonelist in place,
shifting the slots after the new zone.  The iterator approves a slot,
then the allocator loads the zone from it, so a GFP_KERNEL request can
land in ZONE_MOVABLE and a nodemask request on a node outside its mask:

  CPU 0                             CPU 1
  prepare_alloc_pages()
    first_zones_zonelist(nodemask {1})
      slot 0 (NORMAL1) approved
                                    online_pages()
                                      build_all_zonelists()
                                        [NORMAL1, NORMAL2, ...]
                                        -> [MOVABLE1, NORMAL1, ...]
  get_page_from_freelist()
    zone = zonelist_zone(slot 0)    /* MOVABLE1 */
    allocates from MOVABLE1

zonelist_update_seq detects the rebuild, but only the slowpath's failure
exits check it.

Check it whenever an allocation succeeds too, and if it changed, free
the page and retry, as the memcg charge failure path does.  Eligible
pages are dropped as well: zonelists only change when memory comes or
goes, and a retry is simpler than rechecking the page.

Freeing the page does not undo a block the allocation claimed.  A
GFP_KERNEL request that lands in a fresh ZONE_MOVABLE converts a free
block to MIGRATE_UNMOVABLE, which stays until the zone's movable free
list runs out and a movable allocation takes it back.

The fast and bulk paths read the seqlock's raw seqcount without waiting:
an ALLOC_NOLOCK caller can be an NMI that interrupted the writer, and on
PREEMPT_RT the seqlock accessor takes the spinlock.  A sample taken
mid-write costs a retry, or NULL under ALLOC_NOLOCK.
check_retry_zonelist() returns 0 when compiled out, so a backport
without the hot-add change stays harmless.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Link: https://patch.msgid.link/20261101021340.2251928-9-gourry@gourry.net
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
[ sashal: Adapted to the older allocator by using __alloc_pages()/__alloc_pages_bulk() and __free_pages(), local_lock_irqsave() in place of pcp_spin_trylock, and dropping the ALLOC_NOLOCK/FPI_NOLOCK parts. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e58f3f514e640..e237a65a7c665 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4640,12 +4640,25 @@ static unsigned int zonelist_iter_begin(void)
 	return 0;
 }
 
+/*
+ * Never wait for the writer, which an ALLOC_NOLOCK caller in NMI may have
+ * interrupted. Read the raw seqcount: on PREEMPT_RT the seqlock accessor takes
+ * the spinlock while a write is in progress.
+ */
+static unsigned int zonelist_iter_sample(void)
+{
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		return raw_seqcount_begin(&zonelist_update_seq.seqcount.seqcount);
+
+	return 0;
+}
+
 static unsigned int check_retry_zonelist(unsigned int seq)
 {
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqretry(&zonelist_update_seq, seq);
 
-	return seq;
+	return 0;
 }
 
 /* Perform direct synchronous page reclaim */
@@ -5254,6 +5267,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	warn_alloc(gfp_mask, ac->nodemask,
 			"page allocation failure: order:%u", order);
 got_pg:
+	/* A rebuild during the walk may have handed out an ineligible zone. */
+	if (page && check_retry_zonelist(zonelist_iter_cookie)) {
+		__free_pages(page, order);
+		page = NULL;
+		goto restart;
+	}
 	return page;
 }
 
@@ -5337,6 +5356,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	struct alloc_context ac;
 	gfp_t alloc_gfp;
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
+	unsigned int zonelist_iter_cookie;
 	int nr_populated = 0, nr_account = 0;
 
 	/*
@@ -5377,6 +5397,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	/* May set ALLOC_NOFRAGMENT, fragmentation will return 1 page. */
 	gfp &= gfp_allowed_mask;
 	alloc_gfp = gfp;
+	zonelist_iter_cookie = zonelist_iter_sample();
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &alloc_gfp, &alloc_flags))
 		goto out;
 	gfp = alloc_gfp;
@@ -5411,6 +5432,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
+	/* The zone was chosen from a zonelist that a rebuild may have changed. */
+	if (unlikely(check_retry_zonelist(zonelist_iter_cookie)))
+		goto failed;
+
 	/* Attempt the batch allocation */
 	local_lock_irqsave(&pagesets.lock, flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
@@ -5477,6 +5502,7 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
 	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
 	struct alloc_context ac = { };
+	unsigned int zonelist_iter_cookie;
 
 	/*
 	 * There are several places where we assume that the order value is sane
@@ -5497,6 +5523,7 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 	 */
 	gfp = current_gfp_context(gfp);
 	alloc_gfp = gfp;
+	zonelist_iter_cookie = zonelist_iter_sample();
 	if (!prepare_alloc_pages(gfp, order, preferred_nid, nodemask, &ac,
 			&alloc_gfp, &alloc_flags))
 		return NULL;
@@ -5509,6 +5536,10 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 
 	/* First allocation attempt */
 	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
+	if (likely(page) && unlikely(check_retry_zonelist(zonelist_iter_cookie))) {
+		__free_pages(page, order);
+		page = NULL;
+	}
 	if (likely(page))
 		goto out;
 
-- 
2.53.0

