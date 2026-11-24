Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559923;
	b=T+cEzfud2Ld7ZsMtEnAkqelA+kG2KA0PAanYsx8CJVFsTjCrMqteDo6Us4S5b9/Qc4D1
	 zs7RO0FL0HY00JADqb1tKbW1w82M4GTk5rPHTy5Xgr7F5DUS4KdNjsOAZUVFIFt8Ocutf
	 8KLjM8sgfbFVNmjlu8zQF9wRpuS05VWhpAKmcG93dZuZIxgYIwNUn7gp+nNRxmdumw0Ro
	 f/4XJcdaVmqq+X9GdyiFB3ofbrXIIBnrBxedWk/kPtuHm0xcMyti7sQjeGFc2ePfNr9xs
	 k2NDlxppE6U9+QDiUdHuLQXghC4ID8I0emwKIywgUn/NBLaVGKdPtbpFzH9sX4iQfrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559923;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=i+RMwa018Uo/FNzoVwRPghlj7QZQsBfvjCo6calX8vU=;
	b=odtuKtDPDWMoFuNR5qPp9xhDLVqAXswzcj7YQPZTEoifz84GPUmChuDK2ASqq1a3n+Vt
	 UyQnZjbvPrc8VgTFXy51Lrl3gIDP4omkkaQd7+nuDF2xJmlXjpYqzj/WQzeifqy0XCADI
	 xF2Ve1WmYmysj0AQJ63a0dj8O1xPXn1V5zbJU+pPyiuITaRMnpl27BvKx3AaTYj79AZZh
	 9mdAY9vormzt8IQ3vuOXApTBebPc8cDVgQKXT60fN/v165RPus8ym1V3VM4qYRzToU+aa
	 WzljJpoxCbG2VOAU/J8cEORgczz5KxhWDS/UzEBG4o03HCWn/8Tyh3xJA53gg3iPhVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljbPlNcc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC6606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljbPlNcc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404E01F000C4;
	Tue, 24 Nov 2026 22:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795559922;
	bh=i+RMwa018Uo/FNzoVwRPghlj7QZQsBfvjCo6calX8vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ljbPlNcc/Iyuz3CZT3q7JQWkgU431J92ti22Eb2HIpnJZfPvnzaw3vH6Kdyfrojck
	 RuDU9ck91T7u8JnltZ+IADvMc67DO99854csHIzu8eIjD6/sqkjNLYmulYnu8tP7IR
	 aXEI1PILkZUll2H12Bi2cHpIFeZ2yYtgssvNljUO7Q/1iC0IpElCjadEppiLGVE/NW
	 kF67yrwgQ2OwYpfhxCh304YP28U28oTNpdbOwP09b3+9ffztmfEJ4arvhGXX5dxc6i
	 vlYZ6cdS8Dvo5HCZ+FG0LgbutmRQW6Wp4r4rJ3hmFkYkv/0PkqOFt3IfwVfeLF7aSi
	 xrJAjXRS0BHRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/page_alloc: retry allocations that raced with a zonelist rebuild
Date: Tue, 24 Nov 2026 17:38:41 -0500
Message-ID: <20261124222705.2805192-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112430-unlawful-unlisted-18cc@gregkh>
References: <2026112430-unlawful-unlisted-18cc@gregkh>
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
[ sashal: Added a matching zonelist-cookie check to the separate nolock allocation function (freeing with the trylock flag and returning NULL), and used the non-nolock free flag in the regular path. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 074178f4d7a07..c89effbaf331e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4433,12 +4433,25 @@ static unsigned int zonelist_iter_begin(void)
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
@@ -5093,6 +5106,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	warn_alloc(gfp_mask, ac->nodemask,
 			"page allocation failure: order:%u", order);
 got_pg:
+	/* A rebuild during the walk may have handed out an ineligible zone. */
+	if (page && check_retry_zonelist(zonelist_iter_cookie)) {
+		__free_frozen_pages(page, order, FPI_NONE);
+		page = NULL;
+		goto restart;
+	}
 	return page;
 }
 
@@ -5174,6 +5193,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	struct alloc_context ac;
 	gfp_t alloc_gfp;
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
+	unsigned int zonelist_iter_cookie;
 	int nr_populated = 0, nr_account = 0;
 
 	/*
@@ -5214,6 +5234,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	/* May set ALLOC_NOFRAGMENT, fragmentation will return 1 page. */
 	gfp &= gfp_allowed_mask;
 	alloc_gfp = gfp;
+	zonelist_iter_cookie = zonelist_iter_sample();
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &alloc_gfp, &alloc_flags))
 		goto out;
 	gfp = alloc_gfp;
@@ -5264,6 +5285,10 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
+	/* The zone was chosen from a zonelist that a rebuild may have changed. */
+	if (unlikely(check_retry_zonelist(zonelist_iter_cookie)))
+		goto failed;
+
 	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
@@ -5327,6 +5352,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
 	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
 	struct alloc_context ac = { };
+	unsigned int zonelist_iter_cookie;
 
 	/*
 	 * There are several places where we assume that the order value is sane
@@ -5345,6 +5371,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 	 */
 	gfp = current_gfp_context(gfp);
 	alloc_gfp = gfp;
+	zonelist_iter_cookie = zonelist_iter_sample();
 	if (!prepare_alloc_pages(gfp, order, preferred_nid, nodemask, &ac,
 			&alloc_gfp, &alloc_flags))
 		return NULL;
@@ -5357,6 +5384,10 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 
 	/* First allocation attempt */
 	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
+	if (likely(page) && unlikely(check_retry_zonelist(zonelist_iter_cookie))) {
+		__free_frozen_pages(page, order, FPI_NONE);
+		page = NULL;
+	}
 	if (likely(page))
 		goto out;
 
@@ -7757,6 +7788,7 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
 			| gfp_flags;
 	unsigned int alloc_flags = ALLOC_TRYLOCK;
 	struct alloc_context ac = { };
+	unsigned int zonelist_iter_cookie;
 	struct page *page;
 
 	VM_WARN_ON_ONCE(gfp_flags & ~__GFP_ACCOUNT);
@@ -7788,6 +7820,7 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
 	if (nid == NUMA_NO_NODE)
 		nid = numa_node_id();
 
+	zonelist_iter_cookie = zonelist_iter_sample();
 	prepare_alloc_pages(alloc_gfp, order, nid, NULL, &ac,
 			    &alloc_gfp, &alloc_flags);
 
@@ -7796,6 +7829,10 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
 	 * If it's empty attempt to spin_trylock zone->lock.
 	 */
 	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
+	if (page && unlikely(check_retry_zonelist(zonelist_iter_cookie))) {
+		__free_frozen_pages(page, order, FPI_TRYLOCK);
+		page = NULL;
+	}
 
 	/* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
 
-- 
2.53.0

