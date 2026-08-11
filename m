Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE68A23EAB4
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 00:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407798; cv=none; b=hSm2YggQHVl/GEUGzy4yA4tJgCisY0HDlRiwegnNazxW9ro2FZT8vahqfpPy+6aheYEeQA0RdKFRSEd5OJhEWAeLbFsyYhdnWbZCrD6Niug3qjF7gMj54V5dv7FBaFwpe+Rm8Mxsisvm1Sy4iO+Qy2JQQC43MVst81TvIH7dydQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407798; c=relaxed/simple;
	bh=CDVu0r83h9uoF6NT5UhRDurqEY1V0HDssvd/qs8GFcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQgiSLxnektYPSUnPSsQv/u0NlmDmywCh1Rxekw2d+8cAPGmB8gNBkv2R7FzUE65Ec0mGEq5uQT8mC1gLs9KzCGZZRH7fR6lsmikALWVQjXGtSvyHsNN5kt7mq1mMWuHTry4fHKqro8JN5+wp4tnYZtA+RB4lmpL1O6t1lT0wJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKFMPUMZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKFMPUMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793491F000E9;
	Tue, 11 Aug 2026 00:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786407796;
	bh=3fMOQGVwumAPKMc26pL1Lmy9CjuXREVmBAPxttkQOEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QKFMPUMZKE7gh1nEy5E4tf/l5a93rbe13sbT2nT2rFlnu0zkiVkvWQAdDpAF8lomh
	 hQ99F4XTTORczgCpnvcg7MldUZU+4tb8eZBmRsIQAzihU9pyupjpupBXx7nrtcZ9EL
	 0Z8oBBH9WtEFJ9AKthb4C4Ld4iLuknTAoJrQA0jaFTxP4cLr853+fxckc/BmR/WyuC
	 BRoIeF5aIJ74g9SYLNBlShTsg9wmfttymsPxTNGWf45JWD++ZgiX3B5Bo6JESUTBWu
	 JocDekFFEQBSzt7lDm2WmaOtBm98oUsY2S4NR6PV1oukVJsfYSPLrcv9SmD7c4YkSp
	 aDH1YD4UrgTrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gregory Price <gourry@gourry.net>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Mike Rapoport <rppt@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/vmstat: fold stranded per-cpu node stats when a node comes online
Date: Mon, 10 Aug 2026 20:23:11 -0400
Message-ID: <20260811002311.3409677-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080556-undermost-commerce-4a9a@gregkh>
References: <2026080556-undermost-commerce-4a9a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gregory Price <gourry@gourry.net>

[ Upstream commit ea3034b2b00fa50c8d2518d0804c9d427bbafa86 ]

A per-node vmstat counter is pgdat->vm_stat[] plus per-cpu deltas.  A
balanced counter can sit split as global=+N / per-cpu=-N.

The folds reconciling the split only walk online nodes, so when
try_offline_node() marks a node offline the per-cpu deltas are stranded.

A subsequent online resets the per-cpu area but not pgdat->vm_stat[],
orphaning the +N permanently.  All NR_VM_NODE_STAT_ITEMS are affected.

The existing code zeroes the per-cpu counters and causes a permanent skew.
Fold the stranded deltas instead, before the node rejoins the online set.
The node is not online yet and the hotplug lock is held, so the remote
access to per-cpu values is safe.

Discovered when node compaction hung for a nearly empty node, as the math
to determine throttling broke.  Reproduced by repeated memory
hotplug/unplug cycles on a node under pressure: NR_ISOLATED_ANON ratchets
up and never returns to zero.

Link: https://lore.kernel.org/20260627202243.758289-1-gourry@gourry.net
Fixes: 75ef71840539 ("mm, vmstat: add infrastructure for per-node vmstats")
Signed-off-by: Gregory Price <gourry@gourry.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 93c63b5fad288..6ce12838f0fad 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7870,7 +7870,7 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 {
 	int nid = pgdat->node_id;
 	enum zone_type z;
-	int cpu;
+	int cpu, i;
 
 	pgdat_init_internals(pgdat);
 
@@ -7886,10 +7886,18 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 	pgdat->kswapd_order = 0;
 	pgdat->kswapd_highest_zoneidx = 0;
 	pgdat->node_start_pfn = 0;
-	for_each_online_cpu(cpu) {
-		struct per_cpu_nodestat *p;
 
-		p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
+	/*
+	 * Hot-unplug can leave per-cpu vmstat deltas unfolded (folders skip
+	 * offline nodes) - reconcile this at online. Foreign access to counters
+	 * is safe: the node is not online yet and we hold the hotplug lock.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct per_cpu_nodestat *p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
+
+		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+			if (p->vm_node_stat_diff[i])
+				node_page_state_add(p->vm_node_stat_diff[i], pgdat, i);
 		memset(p, 0, sizeof(*p));
 	}
 
-- 
2.53.0

