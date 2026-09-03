Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B65A4AA01F
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439551; cv=none; b=XCiZOmNuiLzTAFdA2467SRk/r0O0OiyIGn7XZvcs3iAbd5VR8A9RduRDlUyfP10O4jcXBOBaqeGIgbM03CYrfPJjFOX7um64gp5xs4wkSScJtV2oPdF9RCql+wUkeXH6Ko+0OVkULbZVvWs4XT+TCmkUVcBhs/Bt3LMfulSGLCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439551; c=relaxed/simple;
	bh=17FzDhY0gSCt9ct9VmRx86ZD3fuT/i1d6cYk8H/Dpic=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bFeLBV5ZQWoP74Cmxp8ISqbxBUkhg8sW5wpQmk1LwmQS0JjOjFoOd8awO7gkB2OOoCSGfUTl2D/ekpZzIDaAQEQBAjqR2KL02DnDijrhC0gF7Wn9cZdsQvuLMJggtACTUdsIO8XOLR58bqUzkw8GBKUIeWVwzBWKG8HyjWxcGyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uMaSR2pz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uMaSR2pz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CC01F000E9;
	Thu,  3 Sep 2026 12:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439547;
	bh=+Z6Vwk7N7hERjBmlIJfx05c1uLFSByfLoMKQr1DoV4w=;
	h=Subject:To:Cc:From:Date;
	b=uMaSR2pzeg4QrGuz6kPqFvnyB78QxPiY01kXwDSBnrDEdlzmauFpUl5ddo5NDLJP3
	 dPNNCoCOKHME5jRJRPjAyoV0GjDxMLk+f3mECysDnO98ZRQNT2RzKf5h+6AHvbOBKp
	 oP3tbIL4CYx9QwCo1AQ+cbXUw85bj0/2I/or7aUs=
Subject: FAILED: patch "[PATCH] mm/mglru: fix and remove redundant unevictable folio handling" failed to apply to 6.1-stable tree
To: kasong@tencent.com,akpm@linux-foundation.org,axelrasmussen@google.com,baohua@kernel.org,baolin.wang@linux.alibaba.com,bgeffon@google.com,david@kernel.org,hannes@cmpxchg.org,heftig@archlinux.org,ljs@kernel.org,mhocko@kernel.org,oleksandr@natalenko.name,shakeel.butt@linux.dev,stable@vger.kernel.org,steven@liquorix.net,suleiman@google.com,weixugc@google.com,yuanchu@google.com,yuzhao@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:48:04 +0200
Message-ID: <2026090304-stipend-bankable-4d4f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f7e698e326b239a91ea15844817551921209e826
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090304-stipend-bankable-4d4f@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f7e698e326b239a91ea15844817551921209e826 Mon Sep 17 00:00:00 2001
From: Kairui Song <kasong@tencent.com>
Date: Wed, 12 Aug 2026 20:22:39 +0800
Subject: [PATCH] mm/mglru: fix and remove redundant unevictable folio handling

sort_folio() has a shortcut for moving folios that are no longer evictable
but are still sitting on a generation list.  However, this shortcut is
buggy.  It does not follow the PG_lru usage convention, and it has a more
serious issue.

Unevictable folios are not threaded on lists[LRU_UNEVICTABLE], so that
folio->lru can be reused to hold folio->mlock_count (see the comment in
lruvec_init()).  Hence lruvec_add_folio() skips the list_add() for them,
and every other place that turns a folio unevictable initialises
mlock_count explicitly: lru_add() sets it to 0, __mlock_folio() and
__mlock_new_folio() set it to !!folio_test_mlocked(folio).  sort_folio()
sets nothing, and the lru_gen_del_folio() right above it may have already
poisoned folio->lru via list_del(), so mlock_count ends up aliasing
LIST_POISON2, which reads as 0x122, i.e.  290.  The result is user
visible.  On munlock, __munlock_folio() decrements that bogus count, finds
it still non-zero and bails out before clearing PG_mlocked, so the folio
remains unevictable and the Mlocked accounting stays inflated until the
folio is freed.

The shortcut also touches the LRU flags in the wrong order.  It calls
lru_gen_del_folio() while PG_lru is still set, so a concurrent
folio_test_clear_lru() (e.g.  compaction, folio_isolate_lru()) can succeed
on a folio that has already been taken off the generation list, which may
lead to unexpected behavior.

So fix it by isolating them as common folios and letting the generic
shrink path cull them.  This matches the classical LRU behavior, and there
should be no visible effect on the generic eviction or isolation behavior.

There is no performance concern either, such a folio goes through this
once, and then it is off the generation lists for good.

Link: https://lore.kernel.org/20260812-mglru-mlock-fix-v2-1-a3fec5853c08@tencent.com
Fixes: ac35a4902374 ("mm: multi-gen LRU: minimal implementation")
Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Brian Geffon <bgeffon@google.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Steven Barrett <steven@liquorix.net>
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6c35f7e21465..c1404a59523d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4649,7 +4649,6 @@ void lru_gen_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent,
 static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_control *sc,
 		       int tier_idx)
 {
-	bool success;
 	int gen = folio_lru_gen(folio);
 	int type = folio_is_file_lru(folio);
 	int zone = folio_zonenum(folio);
@@ -4661,15 +4660,9 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 
 	VM_WARN_ON_ONCE_FOLIO(gen >= MAX_NR_GENS, folio);
 
-	/* unevictable */
-	if (!folio_evictable(folio)) {
-		success = lru_gen_del_folio(lruvec, folio, true);
-		VM_WARN_ON_ONCE_FOLIO(!success, folio);
-		folio_set_unevictable(folio);
-		lruvec_add_folio(lruvec, folio);
-		__count_vm_events(UNEVICTABLE_PGCULLED, delta);
-		return true;
-	}
+	/* unevictable: let it through and the generic path will cull it */
+	if (!folio_evictable(folio))
+		return false;
 
 	/* promoted */
 	if (gen != lru_gen_from_seq(lrugen->min_seq[type])) {
@@ -4922,11 +4915,9 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 	list_for_each_entry_safe_reverse(folio, next, &list, lru) {
 		DEFINE_MIN_SEQ(lruvec);
 
-		if (!folio_evictable(folio)) {
-			list_del(&folio->lru);
-			folio_putback_lru(folio);
+		/* move_folios_to_lru() culls unevictable folios via folio_putback_lru() */
+		if (!folio_evictable(folio))
 			continue;
-		}
 
 		/* retry folios that may have missed folio_rotate_reclaimable() */
 		if (!skip_retry && !folio_test_active(folio) && !folio_mapped(folio) &&

