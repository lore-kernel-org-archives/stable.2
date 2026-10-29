Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267474;
	b=wRy7ZdZpod4HUkFU+xQ8ovxNqdcGo4z/+Z8ZiVgAHU3Pgks/XAuMtkLqoRJt2O+IFVo4
	 cFcv9GJSAjFit+qxEnXlJCJj+2HYmtYpl+ThmKjuzNCcgUoru+Ln21y+5VFwt0TnXGi07
	 cEl7Cj8dw14dn+jaeBoS64oDtWiITj5H2em064AhjRr3c5i+HAIoAGY/JVrEhb4ZJFnrm
	 kRdYWTSR0Sa+fM8RkzLm/Gl9b5txS9U9g24oZLZNrFU3lg+o2rMu5pQeCfM3Ay1EX2Vl5
	 Tc9zvNsunMHGApTPWKNo8N1QhxbZFmjfPSDFKyxxZCWuRlhP4Y5iPkQzt5XXQEFi1UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267474;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=1D22SNiqa1UrbTEMSaPprbApV03u/ZanKGMk7KtF224=;
	b=kVgqDrCtySgCEmhIyPjxB3WRgtvtqjbXIQfO0lvMPWpN/vof44M+trrAzir7gCGE60Jx
	 GoqoppmbE7U/ESXEcBoTP/7qljq/MJ4FseODf1Zk+DbShbwj80ozj0s9ITh2JHI+3+LX5
	 3BGUwNuOZAEgIkJ9fBIHgrUDmlwM8MKSdwNwJDtaXkBB+I0xzAleH0FoP6lZzZtchVdpj
	 Gf5T9oijoOpTSVIh0jOnXi/y/sMIlPsWG/LUu4/HMiSrvznshvfJY6mZR1idss6WPxkXs
	 OZ9qRnf2n07fYHhZmC6nUdGU9E3VsGtyM616hHPPz0RDdq+nU5yIMAgwof+ZreU5zlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EOyp7y/K";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEA6606A31A;
	Thu, 29 Oct 2026 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOyp7y/K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B5F1F01825;
	Thu, 29 Oct 2026 09:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793267473;
	bh=1D22SNiqa1UrbTEMSaPprbApV03u/ZanKGMk7KtF224=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EOyp7y/KQ28jNwvMBe17X8JocvZojLzsh4FbzrqXockmjLe7Jme2XXnp3gbWwiWZe
	 laDyyVTBheueGI71ovv2woMgR727qgvuJPLBTtp7uFvu+OH9Uu/sXD7p7JSS/9Xj3x
	 O+z2Dfe166i/lVoLbFMjxdwAahvXk5LL/Fr0Iu+UBtVMm4+l0+p/QVVhKBkD1iRYNp
	 3dyA7B1dRKSiWatmXumWdeYbDmgOTdPAu6KfZjoHITIiDQeopMTbx00Lo8TXw/6kbu
	 ue/fnbOAR+t/BFpeBcs/MblQoGdXM0EUZD6Ik9K0iLtH5mAOIAoSDJ6Gai8efjPWkJ
	 B3zoQo7u53SrA==
Message-ID: <9c35b2f5-ab90-468f-98af-3763b557e439@kernel.org>
Date: Thu, 29 Oct 2026 10:51:09 +0100
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
Subject: Re: [PATCH 2/2] mm: page_alloc: remove ALLOC_NON_BLOCK from
 ALLOC_RESERVES
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
 Salvatore Dipietro <dipiets@amazon.it>, Christoph Hellwig <hch@lst.de>,
 Dave Chinner <dgc@kernel.org>, Matt Fleming <matt@readmodwrite.com>,
 Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261028171719.2043421-1-hannes@cmpxchg.org>
 <20261028171719.2043421-3-hannes@cmpxchg.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261028171719.2043421-3-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 18:15, Johannes Weiner wrote:
> 1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH
> non-blocking allocations accesses reserves") stopped handing out
> reserve access for ALLOC_NON_BLOCK on its own: the extra 25% below the
> min watermark is now only granted on top of ALLOC_MIN_RESERVE. But the
> flag was left in ALLOC_RESERVES, which produces something odd:
> 
> With the ALLOC_RESERVES match, __zone_watermark_unusable_free() doesn't
> subtract the free highatomic pages for them. So in the slowpath, they
> get to consume regular blocks below the min watermark by the number of
> free highatomic pages. The highatomic reserve is capped at 1% of the
> zone, which on any decently sized machine is a multiple of the min
> watermark: GFP_NOWAIT can drain regular memory to zero.
> 
> The user-visible result is brutal hiccups during bursts of GFP_NOWAIT
> allocations under memory pressure. This was found in review and
> reproduced with a synthetic burst, not observed in production, but the
> sequence of events is a realistic one: On a 32G box with an anonymous
> working set, swap, and a filled 290M highatomic reserve, a GFP_NOWAIT
> burst drove regular free memory in the 28G Normal zone (min=60M) to
> 28M, 0.8M and 0.6M in three runs. Swapout failed to allocate its swap
> table, reclaim scanned 13M pages to reclaim 200k, page faults stalled
> for tens to hundreds of milliseconds. The machine survives it, but not
> by design: direct reclaimers eventually fail and start unreserving
> highatomic blocks, until the allocation succeeds or the reserve is
> gone and the OOM killer runs. That reserve exists for high-order
> atomic allocations; here it is destroyed to bail out a GFP_NOWAIT
> consumer that was never entitled to the memory.
> 
> Remove ALLOC_NON_BLOCK from ALLOC_RESERVES. With that, the GFP_NOWAIT
> burst is stopped short at the min watermark. No direct reclaim, no
> stalls, no failed allocations, and the highatomic reserve stays intact
> for the requests it exists for.
> 
> __zone_watermark_ok() is unaffected, since everything it keys on
> ALLOC_NON_BLOCK is already nested under ALLOC_MIN_RESERVE. Update the
> flag comments accordingly: ALLOC_NON_BLOCK just means the caller can't
> block; the reserve math belongs with ALLOC_MIN_RESERVE.
> 
> GFP_ATOMIC order-0 requests have a milder version of the same problem.
> Through ALLOC_MIN_RESERVE they also count the free highatomic pages in
> their watermark check, but rmqueue_buddy() serves them regular pages
> first and only falls back to the reserve once those are gone. They can
> still push regular free memory to 37.5% of min minus the free
> highatomic pages before the reserve is touched. Unlike GFP_NOWAIT they
> are entitled to the reserve, so this needs the watermark check and the
> freelist order reworked together, and is left to a separate patch.
> 
> Fixes: 1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH non-blocking allocations accesses reserves")
> Cc: stable@vger.kernel.org
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  mm/page_alloc.h | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_alloc.h b/mm/page_alloc.h
> index 9c3c2830acb0..7097ea1805f6 100644
> --- a/mm/page_alloc.h
> +++ b/mm/page_alloc.h
> @@ -32,12 +32,11 @@
>  #define ALLOC_OOM		ALLOC_NO_WATERMARKS
>  #endif
>  
> -#define ALLOC_NON_BLOCK		 0x10 /* Caller cannot block. Allow access
> -				       * to 25% of the min watermark or
> -				       * 62.5% if __GFP_HIGH is set.
> -				       */
> +#define ALLOC_NON_BLOCK		 0x10 /* Caller cannot block. */
>  #define ALLOC_MIN_RESERVE	 0x20 /* __GFP_HIGH set. Allow access to 50%
> -				       * of the min watermark.
> +				       * of the min watermark, or 62.5% if
> +				       * the caller cannot block either
> +				       * (ALLOC_NON_BLOCK).
>  				       */
>  #define ALLOC_CPUSET		 0x40 /* check for correct cpuset */
>  #define ALLOC_CMA		 0x80 /* allow allocations from CMA areas */
> @@ -58,7 +57,7 @@
>  #define ALLOC_NO_CODETAG       0x1000
>  
>  /* Flags that allow allocations below the min watermark. */
> -#define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
> +#define ALLOC_RESERVES (ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
>  
>  /* Flags that mean GFP_ATOMIC */
>  #define ALLOC_MASK_ATOMIC (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE)

