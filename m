Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074299;
	b=3MWlF81MMYVmbQbWoo3aLn4o+ZULoUVjjHNm5b1GDe1Tjcc+mYVaXOL1dHaEG8OTA+in
	 m3ihr7+CGRgLYL2Sb8aHOe/Xhiwrscpk0aiM57/DdJ9Xv8NZcpC2jz5skCLsozGI3Lsx9
	 uvWdCAQPK1q+gtqMAsY/z4mm/dXz31xS5FJ8SwOEcv5HMiXrgOCQuXhzl892+6oTSxY9f
	 OXMrm7A62UAd4v0YCwKlfYu2MpLVx/vOjaQP5GPxrDwhLauciKwo6AetIAnoBogfi7IjK
	 Sj7p58XfsUCSvaswmts3E61falnF/r+hUSls2Ipx+RD05Q8wGKxuMQ1JAIapOXS681A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074299;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=le9G8wIlRJSWgn7Gbz0879zwb1b/fclQvbIib7zoTIw=;
	b=3b0JvgUKh6hQatSSgH+uN4ZE8ofeKjTtZdIK08ylvjc/NAJX0gaflI4NGA8G8osDgzdM
	 BWv35i4DqyPaYfI1VI25EZaMAySFZ6gXyC29qkouOfGXtw4411zSeGmIoxFdCOy7NIyf9
	 54XvS9YNxf2Q5Mq1Gs0Ks0+n3Hu2yx+2T3OvIfbeAGuRinpLIjtZhXXhGK+vyycql4J8z
	 oJXNIFqr9TFUmWQ4V6vjXzDgu8hCnpitctfkPgSfpbcQ0g0zjQvvwH3ovftohi1u65N1Y
	 XCEWUeAukWn8SUPCDB+J03nomIfyg5oq/3et9+zlkimaDgExIw+8JSegxniWKGZ/MIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSbXkZAG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CCB606A32C;
	Sat,  7 Nov 2026 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSbXkZAG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA581F0089F;
	Sat,  7 Nov 2026 17:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794074299;
	bh=le9G8wIlRJSWgn7Gbz0879zwb1b/fclQvbIib7zoTIw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FSbXkZAGAl9UVltlm9AXIlfugA/kSzlzN3A2PCw6vtMcTyVk033kyq7VLGisrFopV
	 IZyLx1/Vec5RWOolLg9b1i/oznWTl+NpQmlhB9CiOKZyabwcBg/amZkwlrNP5SujWN
	 j8ZVlXjdk+vm42UjUcwob+P4CluieylukHXhUsgNERk+YUf6ucYBJuW/MAn66f3hJX
	 xlYL++DaGRqszkRBCjMW7Pa5Qqyv8QA/kjJJ+aWlPPBCg7YwybKrR47fVhXK5Tqt6R
	 +tREd5IYwIc5ohsaaf3/t3KubTAcrSZNCw5ntlKWHFdmVuQmmCJ4Saf7VbDw2wAUg3
	 srM+jGb4leYwQ==
Message-ID: <7abb3aa1-385a-422f-86bd-7aac9661c4d8@kernel.org>
Date: Sat, 7 Nov 2026 18:58:10 +0100
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
Subject: Re: [PATCH v3 2/3] mm: gup: allow long-term pins of CMA-allocated
 HugeTLB folios
To: Qi Zheng <qi.zheng@linux.dev>, muchun.song@linux.dev, osalvador@suse.de,
 akpm@linux-foundation.org, azpijr@gmail.com, lance.yang@linux.dev
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <cover.1794046188.git.zhengqi.arch@bytedance.com>
 <586d6c53ab7e4c64d6e89ad3cf0cf7e07dabbfaf.1794046188.git.zhengqi.arch@bytedance.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <586d6c53ab7e4c64d6e89ad3cf0cf7e07dabbfaf.1794046188.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/26 11:30, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Long-term pinning treats explicitly CMA-allocated HugeTLB folios as
> unpinnable, causing unnecessary migration or pinning failures.
> 
> These folios already own their CMA bitmap ranges, and memory blocks
> overlapping CMA areas cannot be offlined. Allow HugeTLB folios with
> HPG_cma to be pinned directly, including in ZONE_MOVABLE.
> 
> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
> Cc: stable@vger.kernel.org
> Suggested-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> ---
>  include/linux/mm.h | 29 +----------------------------
>  mm/gup.c           | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2d0b8a4c9974f..75dd40265d3f4 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2975,35 +2975,8 @@ static inline bool is_zero_folio(const struct folio *folio)
>  	return is_zero_page(&folio->page);
>  }
>  
> -/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
>  #ifdef CONFIG_MIGRATION
> -static inline bool folio_is_longterm_pinnable(struct folio *folio)
> -{
> -#ifdef CONFIG_CMA
> -	int mt = folio_migratetype(folio);
> -
> -	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
> -		return false;
> -#endif
> -	/* The zero page can be "pinned" but gets special handling. */
> -	if (is_zero_folio(folio))
> -		return true;
> -
> -	/* Coherent device memory must always allow eviction. */
> -	if (folio_is_device_coherent(folio))
> -		return false;
> -
> -	/*
> -	 * Filesystems can only tolerate transient delays to truncate and
> -	 * hole-punch operations
> -	 */
> -	if (folio_is_fsdax(folio))
> -		return false;
> -
> -	/* Otherwise, non-movable zone folios can be pinned. */
> -	return !folio_is_zone_movable(folio);
> -
> -}

Moving code while adding new stuff to it, please don't.

Move code first, then modify it.

I don't want to play "find the difference between two pictures" on a Saturday
evening.

> +bool folio_is_longterm_pinnable(struct folio *folio);
>  #else
>  static inline bool folio_is_longterm_pinnable(struct folio *folio)
>  {
> diff --git a/mm/gup.c b/mm/gup.c
> index 2b405cce2ca5c..f41701c603500 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2216,6 +2216,37 @@ struct page *get_dump_page(unsigned long addr, int *locked)
>  
>  #ifdef CONFIG_MIGRATION
>  
> +bool folio_is_longterm_pinnable(struct folio *folio)
> +{
> +#ifdef CONFIG_CMA
> +	int mt = folio_migratetype(folio);
> +
> +	/* These HugeTLB folios own the CMA memory, so they can be long-term pinned. */
> +	if (folio_test_hugetlb(folio) && folio_test_hugetlb_cma(folio))
> +		return true;
More hugetlb hackery ... don't like that, sorry.

I think this just goes down to a problem we discussed a while ago that is
independent of hugetlb: we'd need some way to identify that the the page was
actually allocated by the CMA owner, and it's not just some other movable
allcoation that ended up there.

For something generic non-hugetlb thing, can't we call into CMA to ask whether
the current chunk is marked allocated?

If that's too hard, we could add a temporary hugetlb hack.

But we all hate hugetlb hacks. :)

-- 
Cheers,

David
