Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534874;
	b=SzQWD6uLO4FrLfyoy9DrUw8pNvNzNyqdu0t9FjkfQSMwHSUJLWqxJaDf43Er6DhVk8EY
	 jNsBLy3VhlpjOcIAVHm+cS1tscFmJcZ7+16lqTS1tHHv92miXpAyQrqu96b41mCNrnUue
	 H7jnFE3vD6BhZWo4BL/5/0ASxkSc+301Syx4zV7C9VrLxw1QK3/S3yhXE50c7t83Tcs+Z
	 t3Ch+/YBH2PORuv2Tgz3pD7pmMO/9ZicnQCN0wNcZwm/3isfFrzQAKioc5mC8ZtmCfV53
	 DQy+RD6G2HLZlndrmHgDFkXPYlVsTeKAb0osUcf/eKcV4r5YEYSyd0EMi6YdTlKQ4KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534874;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TqwPrwaYgnt6sxay99ur2unIag1eHHlhOJqDc17a52s=;
	b=5VKQ2gyQla6LsrgSiZgUl6LScUekXib7K5VJwvSd1MunTbORLaVrZISRgi1p1wblBDlH
	 B6sWGqKQK8n5OPxAOZ/fO34YU4SjRuZJryu5t/9m4Ql/piHlTUM4M4ZWIgOEPgxoAblQb
	 YChW38/CSt0EPBJ7mWo/mEePDYnmnKN4wKubMq2mXtjiBeWFKauSa/0dv8HRJXckvR/3b
	 gpWvDKs5T1EG+hcY+UIxr+xo889bSmrraMAxS1vCch+gf/zzQkyZQdihcNSf19yMRIUl7
	 sIftwx+4acdjQgENeRAVsyN0TjriQxg9QVxPlqk/rNpS31V2DEU1BMzTw4VmTr86u/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tohcbndY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFE606A68E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tohcbndY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897E81F000C0;
	Tue, 24 Nov 2026 15:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534874;
	bh=TqwPrwaYgnt6sxay99ur2unIag1eHHlhOJqDc17a52s=;
	h=Subject:To:Cc:From:Date;
	b=tohcbndYQQ4T4gcNRVxKJQehSKZtEih+4SpqshqSyZJG2SIeULcMVa9yFh+5wFfHd
	 AOe2jzi55QOtmOSu0NT8B7vmoFC3D8eCPycG+Oo5XUhPSsziErIOCotffYsagzAWkd
	 gMSXYXdy9Rnx/dGfhPAu2JUxxmxKuQkaukcGRR10=
Subject: FAILED: patch "[PATCH] mm/page_alloc: retry allocations that raced with a zonelist" failed to apply to 7.3-stable tree
To: gourry@gourry.net,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:41:28 +0100
Message-ID: <2026112428-expend-compacter-6b96@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x bcfc8286f0cd5a74c827d502f9f1ad408d7eff30
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112428-expend-compacter-6b96@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bcfc8286f0cd5a74c827d502f9f1ad408d7eff30 Mon Sep 17 00:00:00 2001
From: "Gregory Price (Meta)" <gourry@gourry.net>
Date: Sat, 31 Oct 2026 22:13:36 -0400
Subject: [PATCH] mm/page_alloc: retry allocations that raced with a zonelist
 rebuild

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

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 37a25de68249..f54e1eeb7bc1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4419,12 +4419,25 @@ static unsigned int zonelist_iter_begin(void)
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
@@ -5100,6 +5113,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
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
 
@@ -5184,6 +5203,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	struct list_head *pcp_list;
 	struct alloc_context ac;
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
+	unsigned int zonelist_iter_cookie;
 	int nr_populated = 0, nr_account = 0;
 
 	/*
@@ -5224,6 +5244,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	/* May set ALLOC_NOFRAGMENT, fragmentation will return 1 page. */
 	gfp &= gfp_allowed_mask;
 	gfp = current_gfp_context(gfp);
+	zonelist_iter_cookie = zonelist_iter_sample();
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &gfp, &alloc_flags))
 		goto out;
 
@@ -5273,6 +5294,10 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
+	/* The zone was chosen from a zonelist that a rebuild may have changed. */
+	if (unlikely(check_retry_zonelist(zonelist_iter_cookie)))
+		goto failed;
+
 	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (!pcp)
@@ -5413,6 +5438,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 		.alloc_flags = alloc_flags,
 	};
 	unsigned int fastpath_alloc_flags = alloc_flags;
+	unsigned int zonelist_iter_cookie;
 
 	/* Other flags could be supported later if needed. */
 	if (WARN_ON(alloc_flags & ~(ALLOC_NOLOCK | ALLOC_NO_CODETAG)))
@@ -5442,6 +5468,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 	 */
 	gfp = current_gfp_context(gfp);
 	alloc_gfp = gfp;
+	zonelist_iter_cookie = zonelist_iter_sample();
 	if (!prepare_alloc_pages(gfp, order, preferred_nid, nodemask, &ac,
 			&alloc_gfp, &fastpath_alloc_flags))
 		return NULL;
@@ -5458,6 +5485,11 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 
 	/* First allocation attempt (or, for nolock, only attempt) */
 	page = get_page_from_freelist(alloc_gfp, order, fastpath_alloc_flags, &ac);
+	if (likely(page) && unlikely(check_retry_zonelist(zonelist_iter_cookie))) {
+		__free_frozen_pages(page, order,
+				    alloc_flags & ALLOC_NOLOCK ? FPI_NOLOCK : 0);
+		page = NULL;
+	}
 	if (likely(page) || (alloc_flags & ALLOC_NOLOCK))
 		goto out;
 

