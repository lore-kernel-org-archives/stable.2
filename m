Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565369;
	b=p2L/Zp0xta2tuglEk20yvVVNNTcF57FjI5jM2w+Zg64D0+zxHzJjz56P7xHq8GnRpZiE
	 WvqRonmSMKBTP++2OdZ2coj1TJ4+l6JcDf9VRpEb2fiu2ZdI9mBk2e5DFXCdu1t38rQY1
	 81UcUcK0h3G975TDwOQJYljQ/fCDpAjH5E+cuZSsU6Hmr+e6ukMAIERxeG2xfj1lYFMTL
	 xs/vZwgjcXPQKfsXeopXtPajpxS84I+xYuLwqzdI5CPNL1/L/XQv8M2u4x74aDbx6bnoV
	 BatytX5cjuAihmkeIaqhKx/Mq4/Taku56v4h5DXbWicdMrnW6ubxWGxGPlH2GcqfZSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565369;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XRFGqWZ79fbyKPA+SVKZAvvhYmQrQCIg92Zvtbp9/qk=;
	b=Xcgvane7eMzGJiIc9icWrX+xpGnELKWRESRDlI50uoJtDsk3k4XcA/wdUdCf9F/rDf8R
	 dsR5hguHbvoKoJaBoBl+8wU97kZ3dvkoaDq0ciCFa297eYPkSG/BRqIYozfYCiBNBmYB5
	 yh2XF5V9zWGvH9LSact+JaozLau9TGBRUFamwLWC5dsHEDrR+ozB2AcRziY8RWnr+StIR
	 fiuNdl5ehq4RAH+kRNRpAm1DESx1YHU/dH+6czgQDhXtqXrZSnPZwys8+t/bNY30d9N++
	 DsyD5gGxCyTUFgtZx6F3MkxNmBFjsuspBTkBLQClS3DRy5nFZfq4SjygfamEicV6NpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ef77z3Fw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6A606A334
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 00:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ef77z3Fw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D791F000C4;
	Wed, 25 Nov 2026 00:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795565368;
	bh=XRFGqWZ79fbyKPA+SVKZAvvhYmQrQCIg92Zvtbp9/qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ef77z3FwfYjT8fT48hhanWIEoiXf1TWVO2oV7/+W4sO13lplkZay2fDFEygsiLclS
	 AROAb2Dg6fDvQpq2Ti4vsQ1G0Od5qB8h4G6YFkVdYfvx+Vf1VrVGSnSXvV5Ur3ME7r
	 KidGE+C3DjrXFQGKM+22V+qHQTl7hjkXdH1jVXBo7dGjM4naUTLT/iHT4O1bRAt192
	 qH8WdbzsIyMok/PuLkvNn1fn+vQUcUQQNAE6ltZnU/7T21QQrtPrTPi6VNhVhBCXyd
	 /MXXNT5OIMll14gaPv2lQjZztngneSgq/CiAZA7YVvi5dXNWke9+iZhbH+VxyaaqLd
	 XgTFXr+AiUZyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/page_alloc: retry allocations that raced with a zonelist rebuild
Date: Tue, 24 Nov 2026 19:09:26 -0500
Message-ID: <20261125000113.3377822-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112436-overtime-sectional-a2c3@gregkh>
References: <2026112436-overtime-sectional-a2c3@gregkh>
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
[ sashal: Replaced the __free_frozen_pages() calls with __free_pages() and adapted the hunks to the older __alloc_pages/__alloc_pages_bulk code, which has no ALLOC_NOLOCK handling. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ba7f386331a65..952496c1e546b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4809,12 +4809,25 @@ static unsigned int zonelist_iter_begin(void)
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
@@ -5410,6 +5423,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
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
 
@@ -5490,6 +5509,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	struct alloc_context ac;
 	gfp_t alloc_gfp;
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
+	unsigned int zonelist_iter_cookie;
 	int nr_populated = 0, nr_account = 0;
 
 	/*
@@ -5530,6 +5550,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	/* May set ALLOC_NOFRAGMENT, fragmentation will return 1 page. */
 	gfp &= gfp_allowed_mask;
 	alloc_gfp = gfp;
+	zonelist_iter_cookie = zonelist_iter_sample();
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &alloc_gfp, &alloc_flags))
 		goto out;
 	gfp = alloc_gfp;
@@ -5564,6 +5585,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
+	/* The zone was chosen from a zonelist that a rebuild may have changed. */
+	if (unlikely(check_retry_zonelist(zonelist_iter_cookie)))
+		goto failed;
+
 	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
@@ -5636,6 +5661,7 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
 	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
 	struct alloc_context ac = { };
+	unsigned int zonelist_iter_cookie;
 
 	/*
 	 * There are several places where we assume that the order value is sane
@@ -5654,6 +5680,7 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 	 */
 	gfp = current_gfp_context(gfp);
 	alloc_gfp = gfp;
+	zonelist_iter_cookie = zonelist_iter_sample();
 	if (!prepare_alloc_pages(gfp, order, preferred_nid, nodemask, &ac,
 			&alloc_gfp, &alloc_flags))
 		return NULL;
@@ -5666,6 +5693,10 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 
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

