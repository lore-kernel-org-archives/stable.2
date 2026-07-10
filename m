Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C03F356742
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696942; cv=none; b=gFN6e5dyYyfP3mXemnhUMSkYiJs38CbKgfoDnCfSMsFnhA+hEBOu3HA+mTvS36Ww4TtcsyT5wYq5irJyfUJoR1dj3N2Bp8olQiFttB7RORk/bVUBQkO1fIWqvhHazFdrz33NvIoNaPAfFp8BXMidHflGiuW1Mo52fEZQ/0VuLzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696942; c=relaxed/simple;
	bh=mopxrwpdkIb+I3G7IhaOPyxUECZRBM3iFUXJGiR/KII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmUoSjF8de2Dz+mcL6rWRmKqoa7eFYZHdz4FkK8sAVcGAtDZ/dUQ5KvNMc4i29Me5z8UUvMMB67I+EZOyhcdyn+Edw8rizydCZXBoWvG4uLxjIOkPSSXp29fcdV7nBhH3weE3BlEnl3FSIPftxgblNFgcDS7Gs3Xd3bt2RH/VUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=D2w+2ttP; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="D2w+2ttP"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51bfad59921so6353911cf.0
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1783696938; x=1784301738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LslWkPhTduHsnfKJmg6Amsj5C5OwSASqPOJLzZ77NKQ=;
        b=D2w+2ttPaTvDJSNx0PEYfm081RqLBJFCZ8oCl8kU6SEoAoEUM8RUrXWMkEh1w1VZIa
         n7V6cdybO9xY/nKNTiFwPNQERnh12aftMh2JNI/lDaApWQSkcYVlt5zA7lr31m9LOzG5
         qfyaLWh4m4AHixrcHiCJQrLIljcFyHZrc+DYrK5buGCJRPDesc9BeKQbfb9nTeK/aFKq
         rnkRghelD7S3CoZunwww6vPdvefy4pJnNYePQ44hVufBkbNQ/dKWLct3TyJT2kREc4Gx
         iVOSI1itWWQkftyC4/Bat8HPbDMULq1ASZDQ2yRFlqgIXiFKe/hc+YZehyXIe4Q5VZFV
         AM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696938; x=1784301738;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LslWkPhTduHsnfKJmg6Amsj5C5OwSASqPOJLzZ77NKQ=;
        b=Zb8RJlfRpbKG2oZltQK+8IiEYHc1/wNwWiDh7AFwsCGLeVQVI5XpunUrasfcQISFnS
         ScWPoJvld5B3Z22qw4jIOHlfN1bmTpuVLiwHocStN4GPqzU59kwNvhc3i4/ISppz56MD
         DMvQgQwcNGn3kGwmGcUgmYnVfalbC8MrvkWecEyj3UUOSY+kQgEgE5IS6/wk1bZgVLjN
         VQbd8OulZjAXvvRy2OTH7yBupo1TN2zuCeDBhnrpeD9nBzz+IvFSpvjJgh/cSNJE+ALh
         fdMy0Y+kd1/9mN3VWoj8HeJQspnkjA4difVTNROemoxr/n2notjc3cO3Zwal2nVAXS+c
         cCBA==
X-Forwarded-Encrypted: i=1; AHgh+Rp9XB6LWmCfbLzbd1ZL71ldRF3mER9GBe+/f/xxyf6S54FGJb9mvl4DMPHEpC+kEjn5P2cSDjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTjWWiGBNRe8pBwHyZg0IqLt/5TQeOBx8r7iuRq3b1mHKawsDC
	HmLHq9m3QskNyewPVTpVENyAlieFmVsbNCbcgU91Yhu5LSAoJaP2IqBGBNdACD1Sufc=
X-Gm-Gg: AfdE7ckvKgmVYTVNPkLOpc6P4GaAuypGR25pkNQSmXaNlIPaOscfDdbJnf6RngzW1so
	vryEUzlYQrIPJXThPgNQ81HA1G91a+gdnKYJRF85Wf0WaS3DdFBWZjrHm+EfDr9lwOpfvQW3WhO
	ZvzD4k2hJd2di/JOz8yO1pLCmlWy51Nfvx8aQGGKzmbma6O+lm7ncyPQruNc1H0oZd3dLIR7Kgt
	ZbxRPRKJJkQuSJDZImrxZapYXFZ5c1aQVw+JT7mqWCRhVCLfrtNAAlF/oYxdLqH4ZAi3jGURjvb
	DCNIWiws6y0YNpqZ0cQjTBa8qLkg2w2+qiiuc96DzY1XRnnN3oKBn7xMmm19CGjIjsfKJE9bjRt
	a2xoJNVgVVVTGK0RFaXrZVZwkfqWuLALjc13Gu02Tkl2yQ/kPg8o1Wwd+nkLYck2WS+e85u+zVQ
	DpbVZLErZfdMg=
X-Received: by 2002:ac8:5d46:0:b0:51c:2554:a8f5 with SMTP id d75a77b69052e-51c8b43a3c8mr125847521cf.36.1783696937888;
        Fri, 10 Jul 2026 08:22:17 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caae2068asm17426371cf.17.2026.07.10.08.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 08:22:17 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:22:13 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: linux-mm@kvack.org, hch@infradead.org, willy@infradead.org,
	ritesh.list@gmail.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, dgc@kernel.org, vbabka@suse.cz,
	djwong@kernel.org, brauner@kernel.org, alisaidi@amazon.com,
	blakgeof@amazon.com, abuehaze@amazon.com,
	dipietro.salvatore@gmail.com, stable@vger.kernel.org,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v3] mm/page_alloc: avoid direct compaction for costly
 __GFP_NORETRY allocations
Message-ID: <alEOJffTvlAnYtjJ@cmpxchg.org>
References: <20260710143437.12379-1-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710143437.12379-1-dipiets@amazon.it>

On Fri, Jul 10, 2026 at 02:34:37PM +0000, Salvatore Dipietro wrote:
> Commit 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> introduced high-order folio allocations in the iomap buffered write
> path.  When memory is fragmented, each failed costly-order allocation
> enters __alloc_pages_slowpath() which runs direct compaction and
> drain_all_pages(), causing a 0.45x throughput drop on PostgreSQL
> pgbench (simple-update) with 1024 clients on a 96-vCPU arm64 system.
> 
> The root issue is that direct compaction is too expensive for hot
> allocation paths that have fallbacks to smaller allocations.
> __filemap_get_folio_mpol() already marks higher-order allocations with
> __GFP_NORETRY | __GFP_NOWARN, signalling that the caller can handle
> failure.  However, the page allocator still attempts full direct
> compaction for costly orders with __GFP_NORETRY, which is unnecessarily
> aggressive when the caller will simply retry at a lower order.
> 
> For costly-order allocations with __GFP_NORETRY, skip direct compaction
> but wake kcompactd on the preferred node so that background compaction
> can defragment memory for future allocations, and return failure
> immediately so the caller can fall back.
> 
> This keeps compaction working for long-term system health while
> removing it from the latency-critical direct allocation path.
> 
> Test environment:
>   Hardware:  AWS EC2 m8g.24xlarge (96 vCPU, arm64)
>              12x 1TB IO2 32000 IOPS RAID0 XFS
>   OS:        AL2023
>   Kernel:    next-20260707
>   Database:  PostgreSQL 18.4
>   Workload:  pgbench simple-update, 1024 clients, 96 threads, 1200s
> 
> Results (average of 3 runs, TPS):
> 
>   Config                   Avg TPS      % vs Baseline
>   baseline (no patch)       70,389.24    -
>   With this patch          154,977.02   +120.17%
> 
> 
> Link: https://lore.kernel.org/all/20260403193535.9970-1-dipiets@amazon.it/T/#t [v1]
> Link: https://lore.kernel.org/linux-mm/20260420161404.642-1-dipiets@amazon.it/T/#u [v2]
> Fixes: 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Salvatore Dipietro <dipiets@amazon.it>
> ---
> v3: Move to mm/page_alloc.c, wake kcompactd instead of avoiding it
> v2: Move from fs/iomap/buffered-io.c to mm/filemap.c
> v1: Avoid compaction in iomap folio allocation
> 
>  mm/page_alloc.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a63733dac659..2d02703d8f0f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4883,6 +4883,26 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	/* If allocation has taken excessively long, warn about it */
>  	check_alloc_stall_warn(gfp_mask, ac->nodemask, order, alloc_start_time);
>  
> +	/*
> +	 * Costly allocations with __GFP_NORETRY are opportunistic - Don't
> +	 * stall on direct compaction or reclaim; instead, kick
> +	 * kcompactd on the preferred node so large pages may become
> +	 * available for future allocations and let the caller fall back now.
> +	 *
> +	 * Direct compaction is way too costly for hot allocation paths on
> +	 * large systems: each attempt calls drain_all_pages() which IPIs
> +	 * every CPU.  Only wake kcompactd on the local node to avoid
> +	 * cross-NUMA interference with unrelated workloads.
> +	 */
> +	if (costly_order && (gfp_mask & __GFP_NORETRY)) {

I think that's reasonable. __GFP_NORETRY is a bad name, in practice it
just means try not too hard. One direct attempt at say order-0 is
fine; a direct attempt at order-8 is something entirely different.

The callsites COULD judiciously use __GFP_DIRECT_RECLAIM but I don't
think we want to burden them with that. And as much as I hate that
kind of arbitrary costly_order gating, having every caller make up its
own rules would be even worse.

> +		struct zone *preferred_zone = ac->preferred_zoneref->zone;
> +
> +		if (preferred_zone)
> +			wakeup_kcompactd(preferred_zone->zone_pgdat, order,
> +					 ac->highest_zoneidx);

Let's not do that, though. The page allocator doesn't wake kcompactd
directly - it's subordinate to kswapd because it needs free pages to
operate. The coordination code is in kswapd. And that's woken up
further up the function.

The problem is we're lying to it by passing __GFP_DIRECT_RECLAIM when
in fact we categorically don't do that for this request.

And we're lying to various other can_direct_reclaim and can_compact
gates inside the slowpath itself.

That's not good.

My suggestion would be to clear __GFP_DIRECT_RECLAIM first thing in
the slowpath function. Before that nofail branch. Before
can_direct_reclaim and can_compact are set. So that everything in the
function that checks these works properly. And then you'll get kswapd
-> kcompactd wakes for that request.

> +		goto nopage;
> +	}
> +
>  	/* Try direct reclaim and then allocating */
>  	if (!compact_first) {
>  		page = __alloc_pages_direct_reclaim(gfp_mask, order, alloc_flags,
> -- 
> 2.47.3
