Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA5744AB88
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946628; cv=none; b=leSXtjLYe5Kt8Cj51+uAc0gXuMdqoTZAhbyoUMuHeHF5xBHVmeGykhbc+GNCAyeC02tGJnyYeMR70aQq2jB04A6ElySxX5fiyN79TRu0HPhFrACI0sduVhhs5kkmf05KfVafSIZto0PtJWGumY39SAXiENC3tFRmDuZRAtBWhR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946628; c=relaxed/simple;
	bh=FOfYlpJbv/Vq9GEHs3HlVQ80gfrcSBY3967eI6beHBo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bHUXMIJrfqiED0NOBfPzBaSKvfiBqPs+cgyy92IxK8CKC7YmgKxSIrQ5D/ZRfpCJElCWC2t5q+8RKBnC9ghXKdbef9p6OdHB6O8zQThtMXWexnxRnG4OPXwcM4BfnvyYuSJAWvcOckLWjela4w0UfDPFZND2y3ehBraNIOrEXpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E1A9DRll; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E1A9DRll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C256A1F00A3A;
	Wed,  9 Sep 2026 09:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788946624;
	bh=YNsLYsSMmJe9vkqJsICkcqyoaSUh0U/nu8nvQrx35fs=;
	h=Subject:To:Cc:From:Date;
	b=E1A9DRllqn195eDx9lTxXc3zpxquIK5QN9W2DfiN4prAu4ZypmxJaNzycLq9MMjOG
	 jPdR71AonK0XZcsTFE8ev38U2ITDivqCGVX0P29UFCRRemMZRWyO+8VqbzsEi+P6XS
	 1yG8o8ruY+EuGzg/jvqEmmvCEMCereqKuMgNDzTI=
Subject: FAILED: patch "[PATCH] memcg: move LRU size accounting on reparenting instead of" failed to apply to 7.2-stable tree
To: shakeel.butt@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@suse.com,muchun.song@linux.dev,roman.gushchin@linux.dev,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:36:56 +0200
Message-ID: <2026090956-reorder-flypaper-cf1a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 0e0ac326c511d514817cc7b6d7741afd59098ce2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090956-reorder-flypaper-cf1a@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0e0ac326c511d514817cc7b6d7741afd59098ce2 Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Fri, 21 Aug 2026 19:47:07 -0700
Subject: [PATCH] memcg: move LRU size accounting on reparenting instead of
 copying it

When a memory cgroup is offlined its LRU folios are reparented to the
parent.  lruvec_reparent_lru() splices the child's lists into the
parent's and credits the parent with the child's per-zone
lru_zone_size[], but never clears the child's copy, so the size is
copied rather than moved.  lru_gen_reparent_memcg() does the same for
MGLRU.

The parent is left correct, credited with exactly the folios it took
over.  The stale value sits on the child and nothing will correct it:
folio->memcg_data now resolves to the parent, so every later
update_lru_size() for those folios goes there.

Dying cgroups are not freed immediately and mem_cgroup_iter() still
walks them, so shrink_lruvec() keeps being called on them.
get_scan_count() reads the phantom counter through lruvec_lru_size() and
the scan loop then grinds through nr[] in SWAP_CLUSTER_MAX steps against
an empty list, for as long as the dead cgroup lives.  Under MGLRU the
MGLRU scanner runs instead, but count_shadow_nodes() sums all of
NR_LRU_LISTS through lruvec_lru_size() and over-budgets the shadow node
limit just the same.

On one 251 GiB host a sweep of every mz->lru_zone_size[] found 380
counters describing folios on no list at all: 124777314 pages, 476 GiB,
1.89x the machine's RAM, across 57 cgroups.  All were on memcgs with
CSS_DYING set and CSS_ONLINE clear, and parent/child pairs reported
byte-identical sizes.

LRU_UNEVICTABLE needs its size moved too.  Its list is deliberately not
spliced because lruvec_init() poisons the head - the unevictable LRU is
imaginary and folios are never threaded on it - but the size is kept by
lruvec_add_folio()/lruvec_del_folio() and those folios account to the
parent from here on.

This depends on commit bf4ade7dbd76 ("memcg: keep folio's objcg same as
its node") and must not be backported ahead of it.  Without that
invariant a folio's objcg can belong to another node, so a folio already
spliced onto the parent's list can still resolve to the child's lruvec
until the objcg's node is reparented in a later iteration of
memcg_reparent_objcgs(); clearing the child's counter early then lets
lruvec_del_folio() underflow it and trip the WARN_ONCE()/VM_BUG_ON() in
mem_cgroup_update_lru_size().

Link: https://lore.kernel.org/20260822024707.77192-1-shakeel.butt@linux.dev
Fixes: 07a6e9a2c199 ("mm: vmscan: prepare for reparenting traditional LRU folios")
Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org> # After: bf4ade7dbd76: memcg: keep folio's objcg same as its node
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/folio.c b/mm/folio.c
index 59c477120b9a..c02dcea9c03c 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -1130,7 +1130,16 @@ static void lruvec_reparent_lru(struct lruvec *child_lruvec,
 	for_each_managed_zone_pgdat(zone, NODE_DATA(nid), zid, MAX_NR_ZONES - 1) {
 		unsigned long size = mem_cgroup_get_zone_lru_size(child_lruvec, lru, zid);
 
+		if (!size)
+			continue;
+
+		/*
+		 * The folios are accounted to the parent from now on, so the
+		 * size has to be moved, not just copied. Leaving it behind
+		 * makes the dying child describe folios it no longer owns.
+		 */
 		mem_cgroup_update_lru_size(parent_lruvec, lru, zid, size);
+		mem_cgroup_update_lru_size(child_lruvec, lru, zid, -(long)size);
 	}
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b569eeca590d..73a81b4a3e16 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4635,7 +4635,12 @@ void lru_gen_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent,
 		for_each_managed_zone_pgdat(zone, NODE_DATA(nid), zid, MAX_NR_ZONES - 1) {
 			unsigned long size = mem_cgroup_get_zone_lru_size(child_lruvec, lru, zid);
 
+			if (!size)
+				continue;
+
+			/* Move the accounting, do not duplicate it. */
 			mem_cgroup_update_lru_size(parent_lruvec, lru, zid, size);
+			mem_cgroup_update_lru_size(child_lruvec, lru, zid, -(long)size);
 		}
 	}
 }

