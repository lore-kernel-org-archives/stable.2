Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA1D48EC88
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055270; cv=none; b=lVekq9YrGAffNvHLAPEVURMsAY9TZwvaO9r/6+h92RWor7cWlR8fDXBjXqAoY9G0HYVQUhPPrDKKDw1F1tOPI3fhtZOOvzxPZHRr0EL+wofewyCz84GwMQdP1t+a1wQFPzcYsi7fzSc/pRn5hslnRAxH/2s7YGprZB6Vaae6/WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055270; c=relaxed/simple;
	bh=cE6ZH5i+do18EzZe8BgZNylCKZsFAk/fHM6qVE4gpkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=II2oLCCfVrC1hffoXrIgzOq2PjYLdeZd8d91chr6oCXibrW8HDGRTE9Dvs7Fq6k08QB+mPfnSBO+JEMewNf+4r0NFset9+Wqh2ZzJcc4ZG/PgQyGtYhASqFSbEWJu5/8YQETvw8rDLyrPi7t/MyEgZKiwIoumB331sT9unZ0O/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1HhBAR6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1HhBAR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C211F000FF;
	Thu, 10 Sep 2026 15:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055268;
	bh=evomDcAdWKURPQFilS/ODkODT9xt93Jpj2agY7hg1Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a1HhBAR67HgYN7Denn0z/7Fl8HzMzdHirNsa51YjVG9S0tZs/WxROCf8uOlOS5He+
	 0skVMfYF7ri7s1Wbtw7XbCRbfohfgeNxpisle27tmqdh26wadxzG2EQwCoYt5xJuqe
	 ia5WvNKw4tBRe/Au/MBOFhymgxhxRq7qPbrFjVS6d8fhnLSzO7YtDozzEaAcNom7aj
	 6dEl0fajNYsClJ/7ZBGKAPjEYH/QTCjv7uIYIgBOazSl/hSJL0wEnK6juF2gZkZV1b
	 h98AE1R5DIQi0CPBzgmVq9+tug/4vGSB9vHhxzs0DRDONajlWdGI/BCDanhDaJUXLr
	 CNRfrXddX0FeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] memcg: move LRU size accounting on reparenting instead of copying it
Date: Thu, 10 Sep 2026 11:47:41 -0400
Message-ID: <20260910154741.1039372-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090956-reorder-flypaper-cf1a@gregkh>
References: <2026090956-reorder-flypaper-cf1a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shakeel Butt <shakeel.butt@linux.dev>

[ Upstream commit 0e0ac326c511d514817cc7b6d7741afd59098ce2 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/swap.c   | 9 +++++++++
 mm/vmscan.c | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/mm/swap.c b/mm/swap.c
index 588f50d8f1a8c..1a87e56bdcc52 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1153,7 +1153,16 @@ static void lruvec_reparent_lru(struct lruvec *child_lruvec,
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
index ee3efc6213f49..8781dbcdb99a6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4554,7 +4554,12 @@ void lru_gen_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent,
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
-- 
2.53.0

