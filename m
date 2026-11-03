Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718747;
	b=LBJu73pWiOfEMKsFJDeF1wUe0/wTU4w7W/Kvh/DC2yjx/bq535bp62IG1S/86QSBxxIE
	 FyM2zO33eq/nZBcwkwqJEJNYOg40qbZonxO4UFbDXkYsmx+yyl+FMtXk3RVxSQPX4mY8C
	 GbKK9e1x3nQ9NWTN2j7YHGSjIqLpPEExXuRflZlhlZVCsrTnuWPHDVoZQix2y314W3vzM
	 8kVVdqXOk/+Dr47D7+bkJG+Owa/qQ0BgSmE5ypLONzSFJenC6oQqn9CxiDJLoSHQi4ej4
	 Y5xWTIz6lWowrg9kANPkUdzjlolBsS74uyV+q+u1Su86FYD+PawTynLd7KCse9pSGbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718747;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=zV1T+I0M/X5fYajz5gf/61terI3BQ0fU42btgMq0usc=;
	b=aSD5RE5xvLDQ7KoJnq3QG6XHeHpMOCV8HWh1ITToSIK1yUSfl4NA2aK9EcPhSyjBfBXh
	 HCpBQwZSQnzPzByZCkcg7fSDoXX29WnNDgmrhU5oDeAimFou554rtC8j6fU1e1vsatYR6
	 /04dquW/xK8IBCOHo1ls+TIILJaT2OaL3BENipktSdEFboKDtd7nVe1yN0x5nZoYnqZXY
	 HGQnsJfBrgejAgLeYlbyzIaEorclqF4hIurxFUbT7E5KZ9aJ5+Kov9nCBd9mPpiacIRav
	 O9UOjT9KzgQAeUua95IAABvm3YRoKX0YTyc27tnFm3MmIj7NFKCpSFlsMK51ts/+x5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y8XX+R/3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6F3606A32E;
	Tue,  3 Nov 2026 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y8XX+R/3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E921F000C1;
	Tue,  3 Nov 2026 15:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718747;
	bh=zV1T+I0M/X5fYajz5gf/61terI3BQ0fU42btgMq0usc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Y8XX+R/34RU2qrAch5IzWEomeYhJRgnOPmQV0c1P4ua7aD9u6KoBL27GfTNHLhW4b
	 M+894MvjRu0FPV7UZqNf0BqBv+B3NPVLyYnLJEUvBvfNhTYzb/ZTgeFtmB8zxvqN1L
	 f8DVezDosMAJUoosTpIUr7qnBX3vQNbpsLPOOfx1bEe1EEFPm8kBu30mbWU4I3dxko
	 27z/yk6OveFo3E9sLlQLkZlcZpAGw3pxxon+OT0zrLkv7HhFxty/juVata4jEjgw0G
	 4p6/HQn1Ufn0qLwAYZn70b/sNfSCjlnNRLDhQhgy1o9iXAPrvL/jsm3XC4EJgColuC
	 3OGNqx1zKipNA==
Message-ID: <6091a4d5-ded8-423e-a806-2c4b11f21e09@kernel.org>
Date: Tue, 3 Nov 2026 16:12:20 +0100
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
Subject: Re: [PATCH 4/6] mm/page_alloc: don't undo another isolation in
 alloc_contig_range
Content-Language: en-US
To: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 kernel-team@meta.com, akpm@linux-foundation.org, surenb@google.com,
 mhocko@suse.com, brendan.jackman@linux.dev, hannes@cmpxchg.org,
 ziy@nvidia.com, linmiaohe@huawei.com, nao.horiguchi@gmail.com,
 david@kernel.org, ljs@kernel.org, liam@infradead.org, rppt@kernel.org,
 osalvador@suse.de, muchun.song@linux.dev, iamjoonsoo.kim@lge.com,
 anshuman.khandual@arm.com, stable@vger.kernel.org
References: <20261027042204.3741307-1-gourry@gourry.net>
 <20261027042204.3741307-5-gourry@gourry.net>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261027042204.3741307-5-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/26 05:22, Gregory Price (Meta) wrote:
> An alloc_contig_range() that overlaps a block going offline can leave
> the offline spinning until it gets a signal, holding the device hotplug
> lock.  When isolation fails, alloc_contig_frozen_range() undoes it over
> the whole range, clearing the offline's MIGRATE_ISOLATE too:
> 
>   CPU 1 (offline_pages)               CPU 2 (alloc_contig_range)
>   start_isolate_page_range()
>     blocks are MIGRATE_ISOLATE
>                                       start_isolate_page_range()
>                                         -EBUSY on CPU 1's blocks
>                                       undo_isolate_page_range()
>                                         blocks are MIGRATE_MOVABLE
>   test_pages_isolated()
>     never succeeds again
> 
> start_isolate_page_range() fails only on a block someone else isolated,
> after undoing its own, so this undo only ever clears another caller's.
> Return directly, as before alloc_contig_range() went pageblock granular.
> 
> With offline_pages() parked after isolating a DIMM block and a 1G
> hugetlb allocation made over it, the offline on base still loops 30s
> later in 4 of 4 runs:
> 
>   offline_pages+0x5b2/0x1570
>   memory_subsys_offline+0x17e/0x470
>   device_offline+0x250/0x340
>   state_store+0x88/0x110
> 
> With this patch the allocation still fails, and the offline completes in
> 3 of 3 runs.
> 
> Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

I've applied this single patch to page_alloc/for-next-fixes and will drop
the version from Josef [1]. Also transferred Zi's R-b since it's the same
code change (plus comment).

[1]
https://lore.kernel.org/all/20261027-pgalloc-ai-hotfixes-v1-1-9c7d1aca801e@kernel.org/

> ---
>  mm/page_alloc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 55d3fc4b307f5..bb3c7e95f2ed4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7396,9 +7396,13 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
>  	 * put back to page allocator so that buddy can use them.
>  	 */
>  
> +	/*
> +	 * On failure this has undone its own isolation, and any other
> +	 * isolated blocks in the range belong to someone else, e.g. offline.
> +	 */
>  	ret = start_isolate_page_range(start, end, mode);
>  	if (ret)
> -		goto done;
> +		return ret;
>  
>  	drain_all_pages(cc.zone);
>  

