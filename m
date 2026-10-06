Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A74D3DA7E2
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274263; cv=none; b=mXXWcTS+aDJnsWCMwbzjupvjDRDexwwYmMSxY/UXUbAli4hYKM/1QykPigL7CkSK69O6BA6QM8fXAIfDC2iAxJm1FK6UwuQjnMmQM5gXMkkITr3xE1n9Jjn/WQ2ATTZDWtp1QNDXb3jztGIfqaDLwGgvf7x+o5oDCbxRIrRYJHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274263; c=relaxed/simple;
	bh=iSaj9HreJrtjgeXQea0qlyhUh8GWapDSL8Ofyqv645w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Za4+sxAF5NlYFMMqlLjUmIM1/AZylQ8wJfBd4XDtgFuyYj9CbFCk4g5GCAvAMg996TPteHcE14lvfuldv6zhcQOVdLOcw6Vd9bEvT+4U/fFWSVkswdhYozS8YJ5EFZovOe8d1Wat7SKSi1DneOkoLx9ll/VN/GiT3JxckYFW600=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=jiW3RyTC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="jiW3RyTC"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48b0946c2c2so223351f8f.3
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 01:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1791274256; x=1791879056; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tVXYOf8mvidID9ngA6Wiy5Zd6aixe2bdtBClg3CvrsU=;
        b=jiW3RyTCnERM+gTO1/IKwFXi0GFXa+B/cwYGRDDDcrF2c7aIWgczdyuETSGzmq/JH2
         4648F8Hw+05SbLlx8N2KQeniy8SfVA8E69Dj139spR2EpVIWat2XmQ8aPvS8u0/elyYy
         0qG1UYDYxQlG8Le+LKg2K0wrR6f+/0ztCcc3vPzxPYEZaxAOAfhcE3LtplKRTqrOnT/9
         2kkJDcB3HwRZxO/OP0uZYHUS41mt20rlDRAmhI+FPaCsnBp6BfG364+x27aBswWNHt8m
         F4O6136Mu2xn+WpA/xDZNR8DRcBQu0rLH+fcBBBxqQu+zdDy0oEqKBhdo+lJVmCa538/
         XlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791274256; x=1791879056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tVXYOf8mvidID9ngA6Wiy5Zd6aixe2bdtBClg3CvrsU=;
        b=nQB2jNYv7YH7aysUX+C6Ucg94siZkfa+/tmY86MgCYLmYi9q84QQ5Xbvm9XjFdnldF
         W4pWcEGr3FgFt4kd5vpTApFRkG8yYuiZmktQKuMQiX8lma8fCMdwDMt9UInFXQWKx3vG
         8hTnV6cSkUw2wBBgJsNQ521qJwCPVWnR8ZwOR6xOCvIsBkoax4r/HtSEOdzUsifV3ER9
         sFGikCVTBIDyqZuoeNeHC+AfOvJ4CCnBOIdq3m9oyUot9gsULu9ew8zxO5Ep1jLGDnmj
         5lSK6XtQ40u4I21tc3/NMyVDnrVTFLNeFPg67SJiho543tXb3Kvj01PRImu6T0I52uBV
         P9Vg==
X-Forwarded-Encrypted: i=1; AKwUvBxlx1C7xKlJ6oVVzy/j52a2QIdM4ShWLZyHe5zU/xNHdyPi0g8HaM39oJnn7zZwBJ4MJd+TkQ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIt5FE16ej3ljgP9RCk+Fir0W008zHchTlAHJJFpi7NVEfYUuC0
	+Py7RpTsZQ4vIHQPG9I5uHAsJoouMl6n/wIwPpGpF/x5VyXW4208IFlesEyWRRWN+M0=
X-Gm-Gg: AYBFou0cBhJTViC0qQkm2Rf+z2yODPEHtoq8mD3Lqct6NkZ1z2zGEsqtFjsub1QOG6h
	AQKVGmy1x6GwFgoOgv73hSzi+GL3vfcMCWQS3W3B4df7bp1ZWXLjQPWGWo04eT09LjAJ3oK2jDh
	IJvyJmUAw2Caek798QkfLfMzpdRW/EsvOpoGGZ+bQJ82E4dl2iWE60AE1g549xZbvnDXy8Ancit
	qM/JtLB4jU5PQdsrD9cPxwNRfM2oU/raChDpe2r2YiIeS4inSpjCioOsxHgkBR3Q2vgbUTmR9Ym
	S5M4Vc9ffzxl8apcKLxzwRfKSg9vtfsm/WvILqLw3l4Y4LUIYzRRRHp6ONq7sGORkpp6kKphOAX
	zRuu+HYSRSQcbYrzYWxjIcnnFyyJP1Geb16poyhIj6AxzP57NzpsOJRAiPfMdzrdTF4rIFn+N+8
	QUbHHVq7RQU+Uk4bRlLR+ETIhLyWAlOl60Z4WYvZUFi9gmV6NbN0iwd/y1RJzA+awcjYHRX9eWW
	U3x2kBxE4ES
X-Received: by 2002:a05:6000:220f:b0:48b:60a:760c with SMTP id ffacd0b85a97d-48c6d18629cmr1226749f8f.31.1791274255753;
        Tue, 06 Oct 2026 01:10:55 -0700 (PDT)
Received: from localhost (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c6308481dsm9975049f8f.3.2026.10.06.01.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 01:10:54 -0700 (PDT)
Date: Tue, 6 Oct 2026 10:10:50 +0200
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Harry Yoo <harry@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-ID: <20261006081050.GA234057@cmpxchg.org>
References: <20260929174553.175333-1-kirill@shutemov.name>
 <arv8J7ysrdazJmfY@thinkstation>
 <ar0NRMxps8UErXaQ@thinkstation>
 <ar0Xbs9mEu-vUHvc@cmpxchg.org>
 <ar5rOHWwc_iPJF6C@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ar5rOHWwc_iPJF6C@thinkstation>

On Fri, Oct 02, 2026 at 10:59:32AM +0100, Kiryl Shutsemau wrote:
> On Wed, Sep 30, 2026 at 10:06:38AM -0400, Johannes Weiner wrote:
> > > > > @@ -4127,6 +4127,31 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
> > > > >  	return page;
> > > > >  }
> > > > >  
> > > > > +/*
> > > > > + * If fallbacks are not permitted (defrag_mode), we either need to
> > > > > + * reclaim space in a block of matching type, or clear out an entire
> > > > > + * block to allow __rmqueue_claim() to convert.
> > > > > + *
> > > > > + * Reclaim by itself is primarily freeing space in movable blocks,
> > > > > + * since that's where the LRU pages live. So this works for movable
> > > > > + * requests, but not for others.
> > > > > + *
> > > > > + * For those, promote the order of reclaim and compaction to help make
> > > > > + * blocks, instead of spinning in reclaim alone unproductively. Retry
> > > > > + * decisions based on the outcome of that work - reclaim progress and
> > > > > + * compaction results - must account for the promotion as well, see
> > > > > + * should_reclaim_retry() and should_compact_retry().
> > > > > + */
> > > > > +static inline unsigned int nofrag_promote_order(unsigned int order,
> > > > > +						unsigned int alloc_flags,
> > > > > +						const struct alloc_context *ac)
> > > > > +{
> > > > > +	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
> > > > > +		return max(order, pageblock_order);
> > > > > +
> > > > > +	return order;
> > > > > +}
> > > > 
> > > > I think we should start distinguishing order and compact/reclaim_order
> > > > in __alloc_pages_slowpath(). Silently overriding it makes it harder to
> > > > follow and easy to make a mistake.
> > > 
> > > Agreed, four callers recomputing the same thing is asking for a
> > > mismatch.
> > > 
> > > I would rather not grow this patch, it has to go to stable.
> > > 
> > > I will look into a cleanup on top: __alloc_pages_slowpath() computes the
> > > promoted order once per iteration and passes it to direct
> > > reclaim/compaction and the two retry helpers next to the request order,
> > > so the helpers stop knowing about defrag_mode.
> > 
> > +1
> > 
> > All they really need to know is the split into requested order vs
> > production order (reclaim_order, compaction_order).
> 
> Will fold it into the fix itself. The cleanup changes the same places as
> the fix. It makes zero sense to keep it separate.
> 
> > > > > @@ -4299,7 +4316,7 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
> > > > >  	/*
> > > > >  	 * Compaction failed. Retry with increasing priority.
> > > > >  	 */
> > > > > -	min_priority = (order > PAGE_ALLOC_COSTLY_ORDER) ?
> > > > > +	min_priority = (compact_order > PAGE_ALLOC_COSTLY_ORDER) ?
> > > > >  			MIN_COMPACT_COSTLY_PRIORITY : MIN_COMPACT_PRIORITY;
> > > > 
> > > > This would change how hard we try to compact with defrag_mode in direct
> > > > compaction as it won't try compaction with MIN_COMPACT_PRIORITY anymore.
> > > > 
> > > > It doesn't make much sense to change that as part of this fix?
> > > 
> > > It is a choice between compacting harder and falling back, which
> > > fragments a block.
> > > 
> > > It is a judgement call on what defrag_mode means.
> > > 
> > > It would also mean that order-0 allocation request promoted to pageblock
> > > can trigger SYNC_FULL compaction. I cannot say I understand the
> > > implications. Will give it a try with the reproducer.
> > > 
> > > Johannes, Vlastimil, any comments here?
> > 
> > I would leave this one with requested order unless the reproducer
> > disagrees.
> 
> I built a reproducer around what we saw in production, which was oomd
> killing the workload on sustained PSI, so PSI and the number of times
> ALLOC_NOFRAGMENT gets dropped are the headline numbers. 32G VM, 8 CPUs:
> 
>  - fill memory with 4K anon pages in a cgroup, memory.low = fill + 1G,
>    so page cache beyond that stays reclaimable;
> 
>  - pin one page in every pageblock with io_uring registered buffers[1],
>    except one block in 50 (2%), so whole blocks can be made but only
>    from a few places. Without the pins rc5 does not storm in 180s:
>    compaction makes 130-210 blocks per run and every retry loop ends in
>    one. The storm needs blocks to be hard to produce, and the pin
>    fraction is the knob for that;
> 
>  - free one page in eight so ~4G sit scattered in movable blocks;
> 
>  - turn on defrag_mode and run 8 build-like workers on btrfs for 180s:
>    write 1-64K files, read earlier ones back, unlink 20%, fdatasync
>    every 50 creates.
> 
> Kernels: v7.3-rc5; the fix as posted; the fix with the priority floor
> and the COMPACT_SUCCESS retry limit on the requested order. Three runs
> each, mean ± stddev, 2% producible:
> 
>                             rc5            posted        requested
>     ops/s                   4751 ± 684     5181 ± 18     5206 ± 84
>     PSI some, mean %        28.7 ± 11.5    22.0 ± 0      22.0 ± 0
>     PSI some, peak avg10    42.8 ± 30.7    24.9 ± 0.3    25.0 ± 0.8
>     s with some avg10 > 50  3.3 ± 5.8      0             0
>     give-ups (NOFRAG off)   0              222 ± 58      277 ± 199
>     movable blocks lost     641 ± 13       654 ± 10      652 ± 14
>     whole blocks claimed    90 ± 8         81 ± 10       76 ± 8
> 
> rc5 stormed in one of its three runs: 3.85M order-9 reclaim runs in
> 180s, PSI at 42% with ten seconds above 50, workers that would not die
> on SIGKILL. The other two were quiet, which matches a workload that
> OOMs regularly rather than always. The fixed kernels never stormed.

Ack. Nice. Thanks for testing it out.

> Between the two floors there is no difference I can measure here: same
> PSI, same throughput, same give-ups, same movable blocks lost, same
> whole blocks produced.
> 
> The promoted path is a small part of what the allocator does in this
> workload, 16-22k order-9 reclaim runs against a million order-0 ones for
> page cache, and a few hundred give-ups in 180s.
> 
> > There is a risk of defrag_mode self defeating over time by raising the
> > bar for fallbacks but not high enough. Every fallback we let through
> > will make it harder down the line to compact towards that higher bar.
> 
> Same movable blocks lost and same whole blocks produced in all three
> kernels, so in this workload the extra SYNC_FULL passes neither produce
> blocks nor save any.

Ok that's good to know.

Without counter indication, I would prefer to keep the tighter
guarantees. ISTR this mattered on some of my ext4 tests in the past
with the buffer locking.

> > There is also a non-zero risk of connecting order-0 request contexts
> > to SYNC compaction which they haven't done before 7e8756d7ad22. But
> > you traced the problem to retrying, not sync compaction itself.
> 
> That shows up only when I take the I/O out: tmpfs, every block pinned,
> 1M empty files. Then every exhausted order-0 refill does a whole-zone
> SYNC_FULL pass before it falls back, PSI some runs at 39% against 20%,
> and the churn takes 1.3-2.8x as long, five runs each.

That seems acceptable for the no-hope worst-case behavior.

> What do you prefer here? I don't have strong preference either way.
> 
> [1] One thing the pins made me notice. A FOLL_LONGTERM pin migrates
>     the page first only for ZONE_MOVABLE, CMA and isolated blocks, see
>     folio_is_longterm_pinnable(); a page in a MIGRATE_MOVABLE block in
>     ZONE_NORMAL is pinned where it sits, and the block can never be
>     made whole for as long as the pin lives. The migration target in
>     gup already uses GFP_USER without __GFP_MOVABLE, so a moved page
>     lands in a non-movable block.

+1

>     Should defrag_mode treat MIGRATE_MOVABLE like ZONE_MOVABLE there and
>     move the page out at pin time? Ideally we might want to move it back
>     on unpin, but it can be done by compaction too.

Should it even be specific to defrag_mode? I suppose without it, the
poisoning from fallbacks would dominate by a landslide under
pressure. But these pins can mess with compactability long before
becoming capacity-bound.
