Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D6D81ACD;
	Sat, 27 Jun 2026 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782601809; cv=none; b=WwSZhQTe1QfxGSt1QUPhokb6aECcAgNyYnGjX9ArrFmiar7JCtgoi8d3NkLN3wpnkR3/2vjo3Mo+wLuo59/hXowTl1mmNOwL1eTwm+EVRXdi0kTC6O9r2TapZ7fGpLiCOXzPp5cndPBSG+lYNnjPQg/OGxBRXshFcUvwN9LfB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782601809; c=relaxed/simple;
	bh=WdwYo/UyB+hRWCV4QsPYStri1u0uQFQDmrNTN1mznEI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KEO1EcgmIUe0e1TkjWkz9z8tCybIaBmyMyYWfmbNRwmJGmUK+YqMPI2JeMy9+rtooA1DvNaaP+9Brede7+AAhynOGpm/6ErmfbblSs5maYyT+fySHMiEUuCKrlYVyvW0FgC0rYhulX/gyHEaZ4EPRAm5IGlFW9uJ/QbwTcuZFEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XPjgvX6y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XPjgvX6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABA91F000E9;
	Sat, 27 Jun 2026 23:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782601808;
	bh=5D6v0GXcAFL77pAcQTrYWtPV+T9YBufpS6c20apcpxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XPjgvX6ycSUd9Pjzv07W94UUP0I2rXBsMn1XGQ1TtVVprC6RaHbLLOlm8YRdyA82Y
	 gjAuEtnZwvYXdnZ2FS0zk9vkPz9y4ULh4V4ZNZ2hhggC1WwyU+AJXPnrrYwlTlN2Vc
	 ntMsz8r1/oJhB4GpC55pla69W3RJZN1NpPWFYtwk=
Date: Sat, 27 Jun 2026 16:10:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 rppt@kernel.org, vbabka@kernel.org, mgorman@techsingularity.net,
 hannes@cmpxchg.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/vmstat: fold stranded per-cpu node stats when a
 node comes online
Message-Id: <20260627161007.81e4533ce561c2951a69f927@linux-foundation.org>
In-Reply-To: <20260627202243.758289-1-gourry@gourry.net>
References: <20260627202243.758289-1-gourry@gourry.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jun 2026 16:22:43 -0400 Gregory Price <gourry@gourry.net> wrote:

> A per-node vmstat counter is pgdat->vm_stat[] plus per-cpu deltas.
> A balanced counter can sit split as global=+N / per-cpu=-N.
> 
> The folds reconciling the split only walk online nodes, so when
> try_offline_node() marks a node offline the per-cpu deltas are stranded.
> 
> A subsequent online resets the per-cpu area but not pgdat->vm_stat[],
> orphaning the +N permanently.  All NR_VM_NODE_STAT_ITEMS are affected.

Geeze, simple mistake, been there ten years...

> The existing code zeroes the per-cpu counters and causes a permanent
> skew. Fold the stranded deltas instead, before the node rejoins the
> online set. The node is not online yet and the hotplug lock is held,
> so the remote access to per-cpu values is safe.

Oh.  Shouldn't we be doing this during offlining?

> Discovered when node compaction hung for a nearly empty node, as the
> math to determine throttling broke.  Reproduced by repeated memory
> hotplug/unplug cycles on a node under pressure: NR_ISOLATED_ANON
> ratchets up and never returns to zero.
> 
> ...
>
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1536,7 +1536,7 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
>  {
>  	int nid = pgdat->node_id;
>  	enum zone_type z;
> -	int cpu;
> +	int cpu, i;
>  
>  	pgdat_init_internals(pgdat);
>  
> @@ -1554,10 +1554,17 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
>  	pgdat->node_start_pfn = 0;
>  	pgdat->node_present_pages = 0;
>  
> -	for_each_online_cpu(cpu) {
> -		struct per_cpu_nodestat *p;
> +	/*
> +	 * Hot-unplug can leave per-cpu vmstat deltas unfolded (folders skip
> +	 * offline nodes) - reconcile this at online. Foreign access to counters
> +	 * is safe: the node is not online yet and we hold the hotplug lock.
> +	 */
> +	for_each_possible_cpu(cpu) {

That's a lot of CPUs

> +		struct per_cpu_nodestat *p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
>  
> -		p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> +		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)

and that's a lot of items.

I guess the overall loop count won't be large enough to cause issues,
but it's large!

Perhaps there's some simple test we can do on the per_cpu_nodestat to
avoid the inner loop?  Perhaps might need to add a field for this?

btw, "for(int i..." is allowed nowadays.  It'll make this code nicer, IMO.

And... Sashiko seems to have found a pre-existing issue:
	https://sashiko.dev/#/patchset/20260627202243.758289-1-gourry@gourry.net

> +			if (p->vm_node_stat_diff[i])
> +				node_page_state_add(p->vm_node_stat_diff[i], pgdat, i);
>  		memset(p, 0, sizeof(*p));
>  	}

