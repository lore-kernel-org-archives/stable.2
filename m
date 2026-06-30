Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4369431E823;
	Tue, 30 Jun 2026 22:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860120; cv=none; b=rGItvveoZ86GFDtfoveWzPKaj8YTN8jgoHVSPvqjR5DfGNcUsWZEC7jELSb2zFz4rb7OobR+vZxcBBQFegj7qOdn7iLtNAQa4cHrCpcQGOiW2eNGizcLrcswFd02k+GwCWvT7xehcRdJf8UJdM/jL/NiGJN1PV9Bz6jtqdKC9OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860120; c=relaxed/simple;
	bh=bW2iVO5p1HwMr74vSECehUVdeXkq2JENlQ3PiCMKcO8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qqrgwluoA9jVqz7vtmqEDxdhXKKvL7yZZc+r2TsVWrrkURZGcSlCxYRyGIjTUwaNBASDqEpAVBIk1RRDATUrDwWHouRYoB0ZX901phJxg9nhsyA6IdTkytfHmnVcBeziwh/jOeJhGB8FIzyg4OMKCeC1XmEXlKPhLCLeg9EcpyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G/aWsL+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G/aWsL+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835181F000E9;
	Tue, 30 Jun 2026 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782860118;
	bh=uf4NCErCtbDw+Q8rHtEwdiycQJlKnF842/UAloF/2Fc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G/aWsL+gZx6ItIsGSSmT+5RPKoGmHvOITQxmaCiERCn4DhyhbNap1PAb3oH9MfqMm
	 Bh7wQOO2wDhDS6DyOyc0QD29/68fLKdeBWoBoAUBhJOeSefRHL+Ajk5VDX6LXHq1l6
	 1CSNbVtJfGaTt8Ps/WLqahzU1QRkavjL90LkbSu8=
Date: Tue, 30 Jun 2026 15:55:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 rppt@kernel.org, vbabka@kernel.org, mgorman@techsingularity.net,
 hannes@cmpxchg.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/vmstat: fold stranded per-cpu node stats when a
 node comes online
Message-Id: <20260630155517.38a99de9f32d20abcbf9440b@linux-foundation.org>
In-Reply-To: <akQtx7zhP7pxNCiy@gourry-fedora-PF4VCD3F>
References: <20260627202243.758289-1-gourry@gourry.net>
	<20260627161007.81e4533ce561c2951a69f927@linux-foundation.org>
	<akQtx7zhP7pxNCiy@gourry-fedora-PF4VCD3F>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 16:57:43 -0400 Gregory Price <gourry@gourry.net> wrote:

> On Sat, Jun 27, 2026 at 04:10:07PM -0700, Andrew Morton wrote:
> > On Sat, 27 Jun 2026 16:22:43 -0400 Gregory Price <gourry@gourry.net> wrote:
> > 
> > > +		struct per_cpu_nodestat *p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> > >  
> > > -		p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> > > +		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> > 
> > and that's a lot of items.
> > 
> > I guess the overall loop count won't be large enough to cause issues,
> > but it's large!
> > 
> > Perhaps there's some simple test we can do on the per_cpu_nodestat to
> > avoid the inner loop?  Perhaps might need to add a field for this?
> >
> 
> I took a look, but that would involve adding another per-cpu field and
> then making sure all the races on that field are respected as well.
> 
> Not sure it's worth it for such an extremely rare event.
> 
> I can try to get clever on the folding logic if you'd like, let me know.
> 
> > btw, "for(int i..." is allowed nowadays.  It'll make this code nicer, IMO.
> > 
> 
> Otherwise i can send you a respin for this.

Is OK, we could make this change in a million other places.

> > And... Sashiko seems to have found a pre-existing issue:
> > 	https://sashiko.dev/#/patchset/20260627202243.758289-1-gourry@gourry.net
> > 
> 
> Incoming patch for this shortly.  Pretty trivial.

Cool, what was the Subject?


I'll queue this patch in mm-hotfixes for some testing while we await
further review (please).


From: Gregory Price <gourry@gourry.net>
Subject: mm/vmstat: fold stranded per-cpu node stats when a node comes online
Date: Sat, 27 Jun 2026 16:22:43 -0400

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
---

 mm/mm_init.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/mm/mm_init.c~mm-vmstat-fold-stranded-per-cpu-node-stats-when-a-node-comes-online
+++ a/mm/mm_init.c
@@ -1540,7 +1540,7 @@ void __ref free_area_init_core_hotplug(s
 {
 	int nid = pgdat->node_id;
 	enum zone_type z;
-	int cpu;
+	int cpu, i;
 
 	pgdat_init_internals(pgdat);
 
@@ -1558,10 +1558,17 @@ void __ref free_area_init_core_hotplug(s
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
 
_

