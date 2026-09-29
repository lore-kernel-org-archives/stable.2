Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54248388E4B;
	Tue, 29 Sep 2026 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711899; cv=none; b=Xdq5IFquNuV3rYe42f2Q46qOw8mEFu4nwF1gszeUJSy++iW3nLVUVYND1lEZaUd9hKZZpPf2LXhU4pjw2UwL+CLlLxMZXq1VUUEIvcy2D+tw8LoCKRJZU28aAflqKbHe81iTAFqIwFZyrmqsjW4kEPbfuJfr5yWkdcc2i4Ic1zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711899; c=relaxed/simple;
	bh=/ADuLmtFLNVszpfp49zfUi01381K6jSMwsUK6i6EnLY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SkBa/8r/Dr4UpWS5pcG12DTq4rBoreANqehDPduj7R6OwZmejVO9Zi/Us6niSmnAlM/pQYIGo9ZhRjHMUALveQSdY68ghFAtorYFT2X36YNzTleEtMyqzC6Az7pHo+1+RUDki8TtqcExzTTuZfr2KhwiXDpBmlWVWD3cARAFAXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LL9i6kj1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LL9i6kj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A1A1F000FF;
	Tue, 29 Sep 2026 19:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790711897;
	bh=JCN5Kn+gBtWe4kYHCGE6/4to6ZNiWj6FurMdUFPZ6Dw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LL9i6kj1EDtQTAbtFK5w8bLhV3X6WVWZcpFEx6FTRyFwhjmZrEOYzlR1SZ5E5N7uw
	 xuOdC6ot0DZsgX5uqUQiEoowghkz/ZA1Dt4psUggVcg8N2skpt9D1CbwOIAfcQ6FN2
	 3H7NU3LgvUawqwIxToLR4V3o9sUTYMEoXq6dJhGA=
Date: Tue, 29 Sep 2026 12:58:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Vlastimil Babka <vbabka@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan Jackman
 <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, Usama Arif <usama.arif@linux.dev>, Harry Yoo
 <harry@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-Id: <20260929125816.5a846a62943eeaf63725b525@linux-foundation.org>
In-Reply-To: <20260929174553.175333-1-kirill@shutemov.name>
References: <20260929174553.175333-1-kirill@shutemov.name>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 18:45:51 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:

> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> Since commit 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim
> storm in defrag_mode"), direct reclaim and compaction for non-movable
> requests under defrag_mode run at pageblock_order, to produce the whole
> blocks that ALLOC_NOFRAGMENT needs. The retry decisions that follow
> still use the request order. An order-0 request can therefore retry
> indefinitely without ever reaching the ALLOC_NOFRAGMENT fallback:

7e8756d7ad22 is new in 7.3-rcX, so no cc:stable needed.

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
> checks their pageblock_order compaction result against the request
> order.
> 
> On a production host (64G, defrag_mode, memory.low covering most of the
> workload), 95% of direct reclaim runs were order-9 runs that returned 1
> with nothing reclaimed, at up to 60k runs per second. Across ~200M
> should_reclaim_retry() calls in a day, no_progress_loops never left 0.
> The spinning allocations were SLUB slab refills for inode and dentry
> caches. The time spent registers as memory pressure, and pressure-based
> OOM killing takes down both workloads and system services.

A production host running latest -rc?

> Treat promoted requests like costly orders:
> 
> - Reclaim progress does not reset no_progress_loops for them.
> 
> - should_compact_retry() checks the compaction result at the promoted
>   order. It does not retry COMPACT_SKIPPED, since the request can fall
>   back, and it does not escalate compaction to COMPACT_PRIO_SYNC_FULL.
> 
> When the fallback is taken, reset the retry counters, so that the
> fallback attempt gets a full retry budget before the OOM killer is
> considered.
> 
> In a VM reproducer (32G, defrag_mode, inode churn under memory.low):
> 
>                                         before    after
>     should_reclaim_retry() calls           63M     293k
>     peak memory pressure (PSI some avg10)  99%      12%
> 
> File creation runs 5.7x faster.
> 
> Fixes: 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim storm in defrag_mode")
> Cc: <stable@vger.kernel.org>

Please double-check?


