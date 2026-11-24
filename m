Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560938;
	b=3v2wvbZy2DXkfW/jy5wINKjkDIgRACxbrrwyzXay3Nimw5qKhgqyYy0EEcqHDGtFd7mL
	 tYZ30NDX6RWIiGz/DZ2lZuN2NXCSeeWBJhwAfsq4W5XDEgTPC6qcILIX6AieCUnqpOiJE
	 a65kqU5E0dks05gfbDZMZtA8vjk7VRx2sYH93K6wxNTxRYTTHwyl5aCEFPzMiSKRupIVA
	 ReX54PuhyE5U1TVouYEu5w3ZojeMM/l+5N2ZCU/rKb3RMPnYCVGMBDr68DMQFsDyqFNJz
	 zMziue8zotudBv66EOkwH0tMO4zEkyG0CN4i0hcCCJOYgzdla5e3crrhpnwUn98YHqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560938;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IVGAFU1DsEC0aFT5k3OFH3AYxjJIrS1gJL8TZGWwvzY=;
	b=kAFLw2XvNiRuPdOZ7G0W9j1w9vm7LiKzxqZzU0N7iD2ppGEfWB1gjHPkqukH6LvUlQO+
	 FK/v8uMjBhfwe0QDrmQH+YXai1OY4muEFwSPoCcsNigy81C5hvnrS9uFATJXUK8UZ5QGk
	 dfVMOy0qJHesGv1hJD++8/jIUc2T+2d3e+MAAjQVblvQfx6TAzcDl31wHN/WsQIIuKOvH
	 zVgja1nzi8NeC1YzchxxTGdmDNfHrKSi3xE6NDkpOy+mFsdLtoqyjxlk9NzVy+KBOwDo4
	 STUkN57jIJIwpMrlgMEwRJFP9o3mNyy4t6q0hoNM683BIEwEOabJoyTAWyZUW/PsSHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RnLy9Bka;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1828C606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RnLy9Bka
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B09B1F000D2;
	Tue, 24 Nov 2026 22:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795560937;
	bh=IVGAFU1DsEC0aFT5k3OFH3AYxjJIrS1gJL8TZGWwvzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RnLy9BkaP8NJCN4LjMkDTcSVqf1XToXcC9Avf5F6viDl+NgrTVCKxF6GIRrjFmpbK
	 IW+jAlqxzx2bZNr8YH6EYzUd/Dw5rKvHG6RpDsJCoY1RkF2jDFZl1Nk/lysCg1kMc6
	 hxBkGmNiT2/D9SopIV8fKIzAwLfxvUWWwFlXmHwfPNT5+dwfRisSxql+eF1xtzPHKa
	 sZ9690jdRnzidZ6v8b3utxgfFg78PZ99BQo9Qnia/KNAJKFcz5tpYPvlNcSPg2ZRXb
	 dZiRvzJ7BcG6RmXUzKbHe4uRa12YNW1Iqg6yqe09WTkDViSz8BFWurshK4KXLz1O5e
	 E8/XdQMvGtMiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/page_alloc: retry allocations that raced with a zonelist rebuild
Date: Tue, 24 Nov 2026 17:55:35 -0500
Message-ID: <20261124225438.3115990-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112432-fringe-contrite-ffcb@gregkh>
References: <2026112432-fringe-contrite-ffcb@gregkh>
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
[ sashal: Replaced __free_frozen_pages() with __free_pages() and __alloc_frozen_pages_noprof() with __alloc_pages_noprof(), dropped the ALLOC_NOLOCK handling, and adjusted context for the older bulk-allocator code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e9aadaf6e91b6..111b9e00929e2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3988,12 +3988,25 @@ static unsigned int zonelist_iter_begin(void)
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
@@ -4604,6 +4617,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
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
 
@@ -4684,6 +4703,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	struct alloc_context ac;
 	gfp_t alloc_gfp;
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
+	unsigned int zonelist_iter_cookie;
 	int nr_populated = 0, nr_account = 0;
 
 	/*
@@ -4724,6 +4744,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	/* May set ALLOC_NOFRAGMENT, fragmentation will return 1 page. */
 	gfp &= gfp_allowed_mask;
 	alloc_gfp = gfp;
+	zonelist_iter_cookie = zonelist_iter_sample();
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &alloc_gfp, &alloc_flags))
 		goto out;
 	gfp = alloc_gfp;
@@ -4769,6 +4790,10 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
+	/* The zone was chosen from a zonelist that a rebuild may have changed. */
+	if (unlikely(check_retry_zonelist(zonelist_iter_cookie)))
+		goto failed;
+
 	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
@@ -4841,6 +4866,7 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
 	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
 	struct alloc_context ac = { };
+	unsigned int zonelist_iter_cookie;
 
 	/*
 	 * There are several places where we assume that the order value is sane
@@ -4859,6 +4885,7 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
 	 */
 	gfp = current_gfp_context(gfp);
 	alloc_gfp = gfp;
+	zonelist_iter_cookie = zonelist_iter_sample();
 	if (!prepare_alloc_pages(gfp, order, preferred_nid, nodemask, &ac,
 			&alloc_gfp, &alloc_flags))
 		return NULL;
@@ -4871,6 +4898,10 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
 
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

