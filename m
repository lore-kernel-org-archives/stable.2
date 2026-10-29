Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267400;
	b=QRkImSWF40rvQ4hdKXOCkO4/IV6Q0L9IaIu9jX0nc08eRsCgH0/MleLwFDZC08Om06To
	 ox4mVGiWgeaKhSF3Qs2gk7xyYs4BJ6LQ/31g2GPMof/VXVeTcJaU66ekEESvL3qAT4P3D
	 MaATI6Bkyzo5jKzB4hD3sdCO0CxAs1Hw3N/P0h2NnQPwaSdESUlPRkB5YoIT1bh/fANz3
	 EF3sM8R7JjTv3NGgcAdy2YFqAbPo40hLJqevlBr34AODLHUhoGjBP/iQ3j7aKmiON4oc7
	 8pC52agP8RlZhUyNs7f6yJy8q8Qgche3oO/JqDxfNNJI78aUkSZJmGu7YMjuCD3+Ufg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267400;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Ia0Mtm3zy/9bRYGZBaX24d9DjUyjcJwGOTQAf9z14P8=;
	b=Dj8zMl6X6CTg7NuCXQtFEt+dUqCInx8CkxFUAkr0DW9RIrfcpZm/bVH1yMPnYvELzLyk
	 wa07y5shlvZwnCFWFJldHvivZGxhj4Gy4SD+nPqmhcrKwXkWnVEX+bEUfMdRGcEoaZd7+
	 qE0QY6gutu4owUyldVDDzOTUPzfRQOkqeHl/ssAPUHpnxEgEA/c96yafbiWB37RQK4l3f
	 P8tki2x95ZNKiTJzFZPqWbR3kx5u/tLXPH3AgBveVGb48h7iSoQTCLZle6Z8tIsB3rl2X
	 tfTqK6DNfWd4LyZF9F0aUjU8ry2NvdzkoE9tdtcH7aR0TT366BkdcaFRyb3b/JE435Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6l6g97f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640BC606A31F;
	Thu, 29 Oct 2026 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6l6g97f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36DA1F031E1;
	Thu, 29 Oct 2026 09:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793267400;
	bh=Ia0Mtm3zy/9bRYGZBaX24d9DjUyjcJwGOTQAf9z14P8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l6l6g97ftKGETwe9W+MgWjB7StxSM/rVyuw87s1BGU7VPUbP4jpcnKr+cLkBw1ym4
	 2fFxA8DyzSMtnmtuppQVDmKr2v60BVjWnZ9wwNmhttPQfkgNceKO6BjypqhXsEkHwe
	 x5s/RRZgYbPhDo/ygFvmqmqWAP7Lmv1wVCBrtn4LDqBFKPRsGdZFBM5rB1Q1ztxo9f
	 LSUvmic9nHXt8/ZyZG4fdyAy1iqul0fJd4do3I3sPN0C92jftCAGhHw0gXpglGLLJF
	 7f6jS0ePCDTOhaVGFBvmoBRhtmZHHfoNPyo//JqpZCvvSutgP5vz5wYWa2JKdIf+NB
	 YMfPInhXkqAEA==
Message-ID: <3126db67-8ac8-4913-bd4a-4008de730148@kernel.org>
Date: Thu, 29 Oct 2026 10:49:54 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: page_alloc: do not give all non-blocking requests
 reserve access
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
 Salvatore Dipietro <dipiets@amazon.it>, Christoph Hellwig <hch@lst.de>,
 Dave Chinner <dgc@kernel.org>, Matt Fleming <matt@readmodwrite.com>,
 Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261028171719.2043421-1-hannes@cmpxchg.org>
 <20261028171719.2043421-2-hannes@cmpxchg.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261028171719.2043421-2-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 18:15, Johannes Weiner wrote:
> 281dd25c1a01 ("mm/page_alloc: let GFP_ATOMIC order-0 allocs access
> highatomic reserves") accidentally gave all non-blocking allocation
> requests access to highatomic reserves, which includes GFP_NOWAIT and
> other sites clearing __GFP_DIRECT_RECLAIM.
> 
> While this improved atomic request success rate, it's unintentionally
> broad and can actually worsen highatomic requests by squandering the
> reserves on requests that don't need it.
> 
> There are concurrent efforts to clear __GFP_DIRECT_RECLAIM altogether
> for costly order __GFP_NORETRY requests, which would then also fall
> into this exemption and deplete reserves even faster.
> 
> What GFP_ATOMIC has over the others is __GFP_HIGH, which
> alloc_flags_slowpath() translates to ALLOC_MIN_RESERVE.
> 
> Narrow the exemption to contexts that have both ALLOC_NON_BLOCK |
> ALLOC_MIN_RESERVE.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260904115629.3993331-1-dipiets@amazon.it
> Fixes: 281dd25c1a01 ("mm/page_alloc: let GFP_ATOMIC order-0 allocs access highatomic reserves")
> Cc: stable@vger.kernel.org
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  mm/page_alloc.c | 4 +++-
>  mm/page_alloc.h | 3 +++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a8cac5e01066..8ac2e2bf14fc 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3238,7 +3238,9 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
>  			 * reserves as failing now is worse than failing a
>  			 * high-order atomic allocation in the future.
>  			 */
> -			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_NON_BLOCK)))
> +			if (!page &&
> +			    ((alloc_flags & ALLOC_OOM) ||
> +			     (alloc_flags & ALLOC_MASK_ATOMIC) == ALLOC_MASK_ATOMIC))
>  				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
>  
>  			if (!page) {
> diff --git a/mm/page_alloc.h b/mm/page_alloc.h
> index e238ee91ed24..9c3c2830acb0 100644
> --- a/mm/page_alloc.h
> +++ b/mm/page_alloc.h
> @@ -60,6 +60,9 @@
>  /* Flags that allow allocations below the min watermark. */
>  #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
>  
> +/* Flags that mean GFP_ATOMIC */
> +#define ALLOC_MASK_ATOMIC (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE)
> +
>  /*
>   * Structure for holding the mostly immutable allocation parameters passed
>   * between functions involved in allocations, including the alloc_pages*

