Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D33C4BD0F8;
	Wed, 30 Sep 2026 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775149; cv=none; b=aHSr2FqABISVtdoiT5jZRiDaB74GmO4gjUHZixo6XP5y2soFE+5T0QPS6dn/ILeu8R2uiFU4G5qcjMQ3A1iZFwiHxBYPHfC85pAUAAqsEjuA61dFeOUwEJjpQv2dt8asFcVriXwsnLx2JGAGGjod4WU1G87Cvai0HuPGaQebgQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775149; c=relaxed/simple;
	bh=w01duXOsqaIj7Ykcw0BSo/+dy8h0/IfxsB8g+Xy4O90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGyRJbqsPG1EpBAF8QhM9XofFzurNHVS9dEW//5Mq1tCmYE11UAYSPxPtFWmmLJJe/yXumDRmdaspuo8Msu6+psSjA/SVkHIe8AP3ZQcSJnLnUl6Pq7RzTvFhVKpRPLHtAfP2k1PUIbvAE/GoeQMdb0weWp27BWuWqzKmQWutfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=F6shES5V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h3zvEid3; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="F6shES5V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h3zvEid3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C62627A0710;
	Wed, 30 Sep 2026 09:32:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 30 Sep 2026 09:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1790775134; x=
	1790861534; bh=kT70g/e1BinoTlFRCaQchj5fPXT4Rhu3g25XFhRLux8=; b=F
	6shES5VS85OtGCVgdYDP/12wzy6ulcsg7eCubivNzMFl5nfPOrYh7MUoVtHPf178
	RHtnhTIahToOIRPutvStB+Sch+EtJ5qlXGwi+PuJN3BEwL7yN621TlqEaqvGYbAL
	K6NhDH6wPl5nxEH58rVvpzJW2v/hxtE6a1xt1uM73eEYMFH92cXR5rK2D5h4srP2
	6utgekfc30BXxtYRwcDHECubFgDNeWZIRALUQV2KaaOQ8dDCI8OQTs3SWdMvhZBT
	1mZFOirfTnpHkTUrWUKxtd7pC8A92Zi95fAQE3+baKRo2I60UU/13M5bEMqo3uS7
	znIJwD8kGMhlMekW7ZG6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790775134; x=1790861534; bh=kT70g/e1BinoTlFRCaQchj5fPXT4Rhu3g25
	XFhRLux8=; b=h3zvEid3iyqCXEGNUdr80VJOJon+wApWB3CZqjplp1POx07p9l+
	GVSw503rggBd4+oeGbg2dWpjGI9Q1yPDJ7AXDHUnKA0OOE0tN+K3CwaR/Ipm8e4P
	FtvJJLXpjaW5Wyy6wB1uCascUNzR4EAte2FYMoby6a5yHTO06+FrG72JB3w0qSL8
	XIORGzBHbYeG6zAZAYYHavvqpHvE7/TIR1R4hPwZCdYcrIylCRacgQIp0jOnBG4s
	ofYqr3lJDEnILskyJSpCtcvjR+N3bCz+JIHT3MRKCJUSrUD2sye/QlMD/BDrhH0i
	ZKxmjOHic5wgy8NGoZIr3ShpWkas5WXOV5w==
X-ME-Sender: <xms:Xg-9apEV_QO6a33prlhnhYDnhVupMSEeaOCGXLRKua3zwn4SR2hSIA>
    <xme:Xg-9amFoVGNSyf6Q1ptNLBPOq0f_mQA2jZircJOaab4gH4jaAAeKvHuV14Fk-wLQ_
    4B-uRkdbuaRJDPQfC7eH85YV9XAlt8flWBnG4mbqI2tVDu_pUGlAn4A>
X-ME-Received: <xmr:Xg-9apu9lVsS58k7pulN4Ch57Z9XDX8cXxMY3y3HWQtTSz4W-DFTW7qnjuw>
X-ME-Proxy-Cause: dmFkZTGWTCTJlUoE9Ou313UmSRurRYELwZU5/PLAwDkK3laoAljGpMIKVH7qAuZ9GSngjA
    1EvMtStKjEa5/roiHFiTbhKKkwJCiCk+AwinfIKJ3qosGEP6j3C9/wbHuVNLZlgrD6giMt
    hGztvd9kNVhdDx3J2rH69ZVoaANFDOZOJmuChVpywE4AaNN4dvhs4+6gHlre7IZJIH/sxh
    PCpappBG17PAsDg3f6mKkS9azJMlqaJTwQipCcMEug3rG6XcNfuqG7+VQENKXNhtNLEHBh
    57jskelgptnByWBJAf6axOssKEQ0EHaQeO6fIOKEbEZKkY3H+cK61FwfGUsbQDeppDFvo4
    qU0TTdivootqDyNhGA3Ieh4CY4sG61dOAFga/oI8F2QL8N8s3LRqJWnD699zvrZ4rG2AjE
    2x3I7Xec67B164miWBnXe80dPfYM7KDpFnAfzn/BntvQerLInY9UDagCYn/OkUhChMe9Va
    dxqelkADNPXKWGBeRs4yt83IcocnypO3+7TZKaNwt+6sXpGU3TPxttjmA8nstFfxR78W7x
    rIWGFifKaAHta3mhhHfNh25Uef2pXSWCl/UYEbsTYLkPDfP8G8EFy0WrBWL9ayg/NwuI/k
    qbT8NjNlvVCG9tk79YJFowLp815UNJx1wn9Y1xwacZPtqeBts9NZ8ClaZMmA
X-ME-Proxy: <xmx:Xg-9apb-kbV6jfB75963Tfhdnd3hBdlZAP3MZ7K4QhGv8HgpTjEBBg>
    <xmx:Xg-9ajPV7MtR9Fe-1f3M8sWI_XQT0rMrUfmgY3FHzRvM6wd12DVwpw>
    <xmx:Xg-9auuh2aGylAh1qga1eyxN40XpsiF40qxW4ZY2czvuVFRda-6RHQ>
    <xmx:Xg-9arJCjK3eDl9B5AIfsi9wa8RnK5K-vThdZrAyleClKUPOB4AGww>
    <xmx:Xg-9akuGZp3Df71CqtfQ5jYvlvgvW43DmpYQShfNND4lHXOPcxx_G1X8>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 09:32:13 -0400 (EDT)
Date: Wed, 30 Sep 2026 14:32:12 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Harry Yoo <harry@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-ID: <ar0NRMxps8UErXaQ@thinkstation>
References: <20260929174553.175333-1-kirill@shutemov.name>
 <arv8J7ysrdazJmfY@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arv8J7ysrdazJmfY@thinkstation>

On Tue, Sep 29, 2026 at 07:39:41PM +0100, Harry Yoo wrote:
> On Tue, Sep 29, 2026 at 06:45:51PM +0100, Kiryl Shutsemau wrote:
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > 
> > Since commit 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim
> > storm in defrag_mode"), direct reclaim and compaction for non-movable
> > requests under defrag_mode run at pageblock_order, to produce the whole
> > blocks that ALLOC_NOFRAGMENT needs.
> 
> > The retry decisions that follow still use the request order.
> 
> Indeed, good catch!
> 
> > An order-0 request can therefore retry
> > indefinitely without ever reaching the ALLOC_NOFRAGMENT fallback:
> > 
> > - Reclaim at pageblock_order gives up after one pass as soon as a zone
> >   looks compaction_ready(), and do_try_to_free_pages() then returns 1
> >   even though nothing was reclaimed. It returns before the retry that
> >   would reclaim memory.low-protected cgroups, so when most memory is
> >   protected, the pass that did run finds next to nothing.
> >
> > - Compaction at pageblock_order fails or is deferred.
> > 
> > - should_reclaim_retry() takes the reported progress as progress for
> >   the order-0 request and resets no_progress_loops. The request
> >   retries.
> 
> Makes sense to me.
> 
> > Order 1-3 requests loop the same way, and should_compact_retry() also
> > checks their pageblock_order compaction result against the request
> > order.
> > 
> > On a production host (64G, defrag_mode, memory.low covering most of the
> > workload), 95% of direct reclaim runs were order-9 runs that returned 1
> > with nothing reclaimed, at up to 60k runs per second. Across ~200M
> > should_reclaim_retry() calls in a day, no_progress_loops never left 0.
> > The spinning allocations were SLUB slab refills for inode and dentry
> > caches. The time spent registers as memory pressure, and pressure-based
> > OOM killing takes down both workloads and system services.
> > 
> > Treat promoted requests like costly orders:
> > 
> > - Reclaim progress does not reset no_progress_loops for them.
> > 
> > - should_compact_retry() checks the compaction result at the promoted
> >   order. It does not retry COMPACT_SKIPPED, since the request can fall
> >   back, and it does not escalate compaction to COMPACT_PRIO_SYNC_FULL.
> > 
> > When the fallback is taken, reset the retry counters, so that the
> > fallback attempt gets a full retry budget before the OOM killer is
> > considered.
> > 
> > In a VM reproducer (32G, defrag_mode, inode churn under memory.low):
> > 
> >                                         before    after
> >     should_reclaim_retry() calls           63M     293k
> >     peak memory pressure (PSI some avg10)  99%      12%
> > 
> > File creation runs 5.7x faster.
> > 
> > Fixes: 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim storm in defrag_mode")
> > Cc: <stable@vger.kernel.org>
> > Assisted-by: LLM
> > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > ---
> >  mm/page_alloc.c | 85 ++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 56 insertions(+), 29 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 12fac9084c48..608487672d93 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4127,6 +4127,31 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
> >  	return page;
> >  }
> >  
> > +/*
> > + * If fallbacks are not permitted (defrag_mode), we either need to
> > + * reclaim space in a block of matching type, or clear out an entire
> > + * block to allow __rmqueue_claim() to convert.
> > + *
> > + * Reclaim by itself is primarily freeing space in movable blocks,
> > + * since that's where the LRU pages live. So this works for movable
> > + * requests, but not for others.
> > + *
> > + * For those, promote the order of reclaim and compaction to help make
> > + * blocks, instead of spinning in reclaim alone unproductively. Retry
> > + * decisions based on the outcome of that work - reclaim progress and
> > + * compaction results - must account for the promotion as well, see
> > + * should_reclaim_retry() and should_compact_retry().
> > + */
> > +static inline unsigned int nofrag_promote_order(unsigned int order,
> > +						unsigned int alloc_flags,
> > +						const struct alloc_context *ac)
> > +{
> > +	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
> > +		return max(order, pageblock_order);
> > +
> > +	return order;
> > +}
> 
> I think we should start distinguishing order and compact/reclaim_order
> in __alloc_pages_slowpath(). Silently overriding it makes it harder to
> follow and easy to make a mistake.

Agreed, four callers recomputing the same thing is asking for a
mismatch.

I would rather not grow this patch, it has to go to stable.

I will look into a cleanup on top: __alloc_pages_slowpath() computes the
promoted order once per iteration and passes it to direct
reclaim/compaction and the two retry helpers next to the request order,
so the helpers stop knowing about defrag_mode.

> > @@ -4299,7 +4316,7 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
> >  	/*
> >  	 * Compaction failed. Retry with increasing priority.
> >  	 */
> > -	min_priority = (order > PAGE_ALLOC_COSTLY_ORDER) ?
> > +	min_priority = (compact_order > PAGE_ALLOC_COSTLY_ORDER) ?
> >  			MIN_COMPACT_COSTLY_PRIORITY : MIN_COMPACT_PRIORITY;
> 
> This would change how hard we try to compact with defrag_mode in direct
> compaction as it won't try compaction with MIN_COMPACT_PRIORITY anymore.
> 
> It doesn't make much sense to change that as part of this fix?

It is a choice between compacting harder and falling back, which
fragments a block.

It is a judgement call on what defrag_mode means.

It would also mean that order-0 allocation request promoted to pageblock
can trigger SYNC_FULL compaction. I cannot say I understand the
implications. Will give it a try with the reproducer.

Johannes, Vlastimil, any comments here?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
