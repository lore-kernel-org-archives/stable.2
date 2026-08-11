Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ACF1F3BA4
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447013; cv=none; b=an25zVm+tYpC6CWRDDoJars+AHgsQXmHNTrhF+BxSlh//IC+t27tStWbY+GL9RlCNwhP8WP2Pd+OaQVeVewBzyCegpAOj6sRENPutvrLQcX1A5CP9E7OnLmcUUXn1uiXgCb56zWwu9WQWHo0PCv8/Z8Wc4MRL5CHg0+/CxAJ3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447013; c=relaxed/simple;
	bh=BlRI1GOEfmQuluHGPd+YBP6leiJ5MCjWnze31SPpgic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDd+p12vPllnXkCkeujMMOVYH9WPjwx4qs9WtMM4ihvqTIYqsCvewppk2uP9ynV5JD4dnOY4m4828/FB3lsjtOgB7G4uWtcmnMmA/SNo6rrJ0qLBkrhRUMtUYJfkM7j4RhsDpXjYX2VjMDqCJEvVc0vlbwu1J8HkhuOyrkgHJUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3KTKpJ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3KTKpJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC22A1F000E9;
	Tue, 11 Aug 2026 11:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786447011;
	bh=tORdFlDfIdZ58w91KTQ97yoQPpW7KCG0M5OAOUmzZs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l3KTKpJ7+/52bC7L16uJs4UGf4iQPPr6FnuC0yl36HawEhB9+vpv7lfz01uyFapeN
	 IHvKpuCePt67+PAV24aW6hbnxNg7bQtxHLhVkJexxJXXs6wHwhd0gOmpGmZUiVQrxK
	 id6A6Ug9Dsj4EWlBX6ybCMduVnb14k4ijA8cIRexqLj37w+OKI6m5sDZ/r61cSSShA
	 HUlv4bZ8AYlGVnTy1GN3gPZUJfCjrHZ3vYOuemkrWWe4PU9S6i6LML8ExZwfZj8oHu
	 R/Ujp0iqn/ENerOhoQw6GrQtBH0DGlqF1sRWkVWW4HQRA1P4ZS/eBcO5oJg79gn3Cp
	 23fnBL0YRUBiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gregory Price <gourry@gourry.net>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Mike Rapoport <rppt@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/vmstat: fold stranded per-cpu node stats when a node comes online
Date: Tue, 11 Aug 2026 07:16:48 -0400
Message-ID: <20260811111648.2256800-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080557-petroleum-magma-09c9@gregkh>
References: <2026080557-petroleum-magma-09c9@gregkh>
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
 mm/memory_hotplug.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 553b0705dce8e..7629952530e2c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -894,7 +894,7 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid)
 			alloc_percpu(struct per_cpu_nodestat);
 		arch_refresh_nodedata(nid, pgdat);
 	} else {
-		int cpu;
+		int cpu, i;
 		/*
 		 * Reset the nr_zones, order and highest_zoneidx before reuse.
 		 * Note that kswapd will init kswapd_highest_zoneidx properly
@@ -903,10 +903,17 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid)
 		pgdat->nr_zones = 0;
 		pgdat->kswapd_order = 0;
 		pgdat->kswapd_highest_zoneidx = 0;
-		for_each_online_cpu(cpu) {
-			struct per_cpu_nodestat *p;
+		/*
+		 * Hot-unplug can leave per-cpu vmstat deltas unfolded (folders skip
+		 * offline nodes) - reconcile this at online. Foreign access to counters
+		 * is safe: the node is not online yet and we hold the hotplug lock.
+		 */
+		for_each_possible_cpu(cpu) {
+			struct per_cpu_nodestat *p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
 
-			p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
+			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+				if (p->vm_node_stat_diff[i])
+					node_page_state_add(p->vm_node_stat_diff[i], pgdat, i);
 			memset(p, 0, sizeof(*p));
 		}
 	}
-- 
2.53.0

