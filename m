Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729333FCB3D
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922465; cv=none; b=Pe5Slg2HrD4HZuK1On26GhGn7381wgOay2jx3j9VDW0IP03uNWAG/1QJhP8H6HZ1XUkC5YT1GKuq/IG0kovkU9w1sUhYoYb0hZVlFsZINFjI1GWp3rS+dd6dt2sebRTcmDNHa1K3XGqRaz4xzTQ4RvoX2fr/+RaVsi/JBzaGNiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922465; c=relaxed/simple;
	bh=Bs6Yl3Qo6nVunGAqXROceG0gR+3D+jSX7FedyS0CsAo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RpJ9APSSV27rMhGeHQF46Nqvp12dWwH57RytUxSu2dMzugWYmrJGpEWi+wMaeBfaF0Olljf+daImdeDK0BPUtLGeiZEVkKV3f0L+vKZku+Q0ihMU+zkpeluopkV4YHkBZxMTgoXM5JvsOeh2yzVbpj66eDI/40crxqrKxKzKmZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hd1nQYZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hd1nQYZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A081F000E9;
	Wed,  5 Aug 2026 09:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785922462;
	bh=PzJjDbdxQquanN//Z/kTVKPlkG5zGz49tn33eImotqY=;
	h=Subject:To:Cc:From:Date;
	b=Hd1nQYZMXHrX4xSRIiO5OXV5GcU3MTFQ/VN0SbjlTHWSiAbSfGhof2ilzonTM6Y9L
	 FSqTFlCZgv94+By3K9CZ8gbaftyxC3idHXI2Hn7miPdNc8Udy2LxUFs+sf1fxvHJwH
	 ON4gUX/92jmS3Cqq8PYIgWw83uOPEuj8qRAg18S8=
Subject: FAILED: patch "[PATCH] mm/vmstat: fold stranded per-cpu node stats when a node comes" failed to apply to 5.10-stable tree
To: gourry@gourry.net,akpm@linux-foundation.org,hannes@cmpxchg.org,mgorman@techsingularity.net,rppt@kernel.org,stable@vger.kernel.org,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:33:57 +0200
Message-ID: <2026080557-petroleum-magma-09c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ea3034b2b00fa50c8d2518d0804c9d427bbafa86
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080557-petroleum-magma-09c9@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ea3034b2b00fa50c8d2518d0804c9d427bbafa86 Mon Sep 17 00:00:00 2001
From: Gregory Price <gourry@gourry.net>
Date: Sat, 27 Jun 2026 16:22:43 -0400
Subject: [PATCH] mm/vmstat: fold stranded per-cpu node stats when a node comes
 online

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

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 0f64909e8d20..498d62c4ece3 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1540,7 +1540,7 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 {
 	int nid = pgdat->node_id;
 	enum zone_type z;
-	int cpu;
+	int cpu, i;
 
 	pgdat_init_internals(pgdat);
 
@@ -1558,10 +1558,17 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 	pgdat->node_start_pfn = 0;
 	pgdat->node_present_pages = 0;
 
-	for_each_online_cpu(cpu) {
-		struct per_cpu_nodestat *p;
+	/*
+	 * Hot-unplug can leave per-cpu vmstat deltas unfolded (folders skip
+	 * offline nodes) - reconcile this at online. Foreign access to counters
+	 * is safe: the node is not online yet and we hold the hotplug lock.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct per_cpu_nodestat *p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
 
-		p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
+		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+			if (p->vm_node_stat_diff[i])
+				node_page_state_add(p->vm_node_stat_diff[i], pgdat, i);
 		memset(p, 0, sizeof(*p));
 	}
 

