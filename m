Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236007;
	b=qKe4au7tDGpuVRJcYmuOnAXojb7hCek081/a2lUO0cY1c2Ijv5H+o+KojnB0tEnCjKQn
	 yzviIFv/TQGwhhbU0+dWZmYvZOwUxm9WhDeaelkpzrq1YHCldV/oXSxocaH0q7AVD4rHR
	 3LI+rXvVgSChW0s3KK7HSCYBuzctpn+xwL8DRSWVSyGb9g8UfD/CQ5xhqaTqKoYhAAwif
	 n0ItRkrGz33utncGAZ48E16eQRYaswNxkZ8ezkQwkTwvzn/cIqilwbR+BRna7qxVe3OoI
	 IrjbzI+ud5b4Sl07pOu8gkDzm2o/7+yTQzCUZmE+RthMSq60TjS1BaZrxtitSG8tJaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236007;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=q8CwJiaFiSjS0iS4+EMVQ2CzO0fMWeYXrQPCP5tU0EI=;
	b=A0oTVSHUeAIc9k6KJjZxV2zbupWEqFur/e7Fc0J3yklaeoOiNpC0iW/F/jzHITGb/0nB
	 /sgYpuKTNgNc0lnBki1394YD9Nis0PtcZCdWdqpp6BuykLOviYCxhU/jSHLPp5yLL7UMh
	 B+1bSdwlbxbMm+5ZIqlcwAPXR9FOFfRYNz15RDY3MAn/IQ1Um9/8mLMiE05sUFjlY8LT8
	 3YXpdvhTfggDu8u4TAAFqisQzSN7TD48uIwgllhcfNUfQ8gsHR7HOJftD2Vj+XNxUbn3d
	 Dnnk/Zp4P0GWKzt+JhrPpc5cc8NtDszrwSrzurS72q3u7pWVkiZIxUQtVnuP6llgtIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4OrgX+y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCF6606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4OrgX+y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58CC1F008A1;
	Mon,  9 Nov 2026 14:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794236007;
	bh=q8CwJiaFiSjS0iS4+EMVQ2CzO0fMWeYXrQPCP5tU0EI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D4OrgX+yVgnOeEEAbr7CE8aCzlhXZX7gBQAzd0/Q4D6cany0LbFaGc0YLVB5HyjVo
	 daD1lbcBUXeFI1f00RmR6oI7lb+/IZMG8blkRTQlRJV8IL09Sv6LivDXY1s6vAZFaV
	 u5WaxWxmWCPkZHz8fWLNEz/ze5W0yQjRNslY1ZyKiVtEgmrw3cggZb1RM+Ja9KJN4U
	 0bfoXYhho3zYy9HLwoh0plHDb26JcJ6iA3Qbx9UXR237A4sFELOoRTQ+YD8sRWYT9J
	 VyMY7qmbbtItnBEeSjzBKtDdnKLGhhL4JAoGuG24GEE13azXIdEPMIzaYYgiHA9Z7x
	 gQDOWXz81Z+ow==
Date: Mon, 9 Nov 2026 14:53:25 +0000
From: Harry Yoo <harry@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: stable@vger.kernel.org, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	akpm@linux-foundation.org, vbabka@kernel.org, hannes@cmpxchg.org, david@kernel.org, 
	usama.arif@linux.dev, surenb@google.com, mhocko@suse.com, brendan.jackman@linux.dev, 
	ziy@nvidia.com, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH 6.18.y] mm: page_alloc: make defrag_mode retries follow
 the promoted order
Message-ID: <avGwIEOdJ5Z4gmGD@thinkstation>
References: <20261107051426-failed-6.18-4cd78a2dcfbb@kernel.org>
 <20261109113007.46714-1-kirill@shutemov.name>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109113007.46714-1-kirill@shutemov.name>

On Mon, Nov 09, 2026 at 11:30:06AM +0000, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> commit 4cd78a2dcfbb13f049f841b98763896a3d1d7750 upstream.
> 
> Since commit 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim storm
> in defrag_mode"), direct reclaim and compaction for non-movable requests
> under defrag_mode run at pageblock_order, to produce the whole blocks that
> ALLOC_NOFRAGMENT needs.  The retry decisions that follow still use the
> request order.  An order-0 request can therefore retry indefinitely
> without ever reaching the ALLOC_NOFRAGMENT fallback:
> 
> - Reclaim at pageblock_order gives up after one pass as soon as a zone
>   looks compaction_ready(), and do_try_to_free_pages() then returns 1
>   even though nothing was reclaimed. It returns before the retry that
>   would reclaim memory.low-protected cgroups, so when most memory is
>   protected, the pass that did run finds next to nothing.
> 
> - Compaction at pageblock_order fails or is deferred.
> 
> - should_reclaim_retry() takes the reported progress as progress for
>   the order-0 request and resets no_progress_loops. The request
>   retries.
> 
> Order 1-3 requests loop the same way, and should_compact_retry() also
> checks their pageblock_order compaction result against the request order.
> 
> On a production host (64G, defrag_mode, memory.low covering most of the
> workload), 95% of direct reclaim runs were order-9 runs that returned 1
> with nothing reclaimed, at up to 60k runs per second.  Across ~200M
> should_reclaim_retry() calls in a day, no_progress_loops never left 0.
> The spinning allocations were SLUB slab refills for inode and dentry
> caches.  The time spent registers as memory pressure, and pressure-based
> OOM killing takes down both workloads and system services.
> 
> For promoted requests:
> 
> - Reclaim progress does not reset no_progress_loops, as for costly
>   orders.
> 
> - should_compact_retry() checks the compaction result at the promoted
>   order and does not retry COMPACT_SKIPPED, since the request can fall
>   back. The compaction priority floor and the COMPACT_SUCCESS retry
>   limit stay those of the request order, so a non-costly request still
>   gets its COMPACT_PRIO_SYNC_FULL pass before it falls back.
> 
> When a promoted request takes the fallback, reset the retry counters, so
> that the fallback attempt gets a full retry budget before the OOM killer
> is considered.  A request whose reclaim was not promoted spent its budget
> on the request itself and keeps its counters, as Usama Arif pointed out.
> 
> __alloc_pages_slowpath() computes the promoted order once per iteration
> and keeps it in alloc_context for direct reclaim, direct compaction and
> the two retry helpers, so no callee has to recompute it.  Harry Yoo asked
> for the promoted order to be explicit rather than derived in each callee,
> and Vlastimil Babka suggested alloc_context over new function parameters.
> 
> In a VM reproducer (32G, defrag_mode, inode churn under memory.low):
> 
>                                         before    after
>     should_reclaim_retry() calls           63M     293k
>     peak memory pressure (PSI some avg10)  99%      12%
> 
> File creation runs 5.7x faster.
> 
> [kas@kernel.org: s/order_nofrag_promoted/order_defrag_promoted/, per hannes]
>   Link: https://lore.kernel.org/atDL-nSFP2KVU7cI@thinkstation
> Link: https://lore.kernel.org/as5q14OsbK2CmOrh@thinkstation
> Fixes: 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim storm in defrag_mode")
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Assisted-by: LLM
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Harry Yoo <harry@kernel.org>
> Cc: Usama Arif <usama.arif@linux.dev>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Brendan Jackman <brendan.jackman@linux.dev>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: <stable@vger.kernel.org>
> [ kas: alloc_context is in mm/internal.h and compaction_zonelist_suitable()
>   takes no gfp_mask in 6.18. 6.18 also tries compaction once before the
>   retry loop; set reclaim_compact_order there as well, or that attempt
>   sees order 0 and is skipped. ]
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---

The backport looks good to me,
Acked-by: Harry Yoo (Meta) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
