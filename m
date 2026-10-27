Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091375;
	b=q4QJT32fOK4KvIyaBK4Pnefa9apYQdMcNlqlOUE+7KE81Eoq9VgtEZfMHKt04LrGsNQ0
	 qAXh/B0N0DJW4f6Js3pSnfnm+KjhpzexO1zaa6+3KVjTDKJ22d1Cd35iyvF1mUDWCostV
	 Ix2BHqEyqmHj3wm57NraoxmPEDIfaZRxZNyyksKRcqhoVjLScKuhzsT31HR+N3lBgprsd
	 s3sldvvsyjNsitE17uuHIJP2Rgmb9jM8attHLoQCzTcWAGP6t8+sFbrve6IkbrG+orPwD
	 j4PA8WIB3T199j2W3X0Kh3pfmtUOVFk3D1iRfj/EgHIM9vszUxCzbU8fIVB1sFf+EMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091375;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LLjeyafLWq906e/KlV7udPCtdijPfLEIi8SSit6QWfU=;
	b=AeU9fwTpEg/wmuzjbxNHyt98vC2NSkjMlLEFn4ygx/Ls1lvhEDaztczU9sLzWCObhtnv
	 mex6qrsXwykaflzWc9jRj1OCtI86a5hoPjCeGYpXPHaKGFCqahSDSwFGeqVpnA2uyi+kt
	 q4jPYmzc9OH6IueE8+3Ton/bDHSfepj4s8xHJ1jH295Y9xUu0Px3NJC9FLg58rdYMGySw
	 hUx+WcXVChWg3pZQRVk39Benp+JVP3D/mewI/TLaCS3X4Pyb/rG2aP/3sxRi4G7XwdNXI
	 7uou41YMdzFGbjgeyYtcVZiD6rHqZbajzGfVkl4EkGLKq7yqbP0KCCS/jWvabK6a5hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBNUrHgp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B841606A31E;
	Tue, 27 Oct 2026 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBNUrHgp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEAE1F01828;
	Tue, 27 Oct 2026 08:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793091375;
	bh=LLjeyafLWq906e/KlV7udPCtdijPfLEIi8SSit6QWfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EBNUrHgpyjuV+uDWfTfjiZjrVUSiaANjjrfsc3nkFZWTw82J+OqHpWvLIciRV9TNx
	 2ZYRqlKawGk39ZaulprNCM2tNwh2zki3TsMiowIH13vcslKJA7833dN8riI4s3kDAM
	 Q3qfXOkNFX5VxnUmiQtmg5QWQCqFP+dYzLxz19uSTgl5bash6cqoBqqOskiaRk2/C6
	 RL8HDc2rNHtv0XIn1ejrOpB1M3CI9bhEBJhZRP1bllfI+FRzWtybU61jzIzwI0z0Od
	 /meOw5AGq2fgtE0iXpBuP7zSuxszxjxhbNpF90J6AdO/j7okIvx+jpqUI1F2fZM2tZ
	 5wOIAvJFgckew==
Date: Tue, 27 Oct 2026 08:55:58 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 44/46] mm/cma: don't release CMA pages still in use
Message-ID: <auBmRQDzFPea5FeS@gremlin>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-44-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-44-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:18:04AM +0100, David Hildenbrand (Arm) wrote:
> From: Rik van Riel <riel@surriel.com>
>
> When a driver calls dma_free_contiguous() before quiescing DMA, the
> page might still have a reference from the device.
> put_page_testzero() there returns false, WARN fires, but the code proceeds
> to free_contig_frozen_range() putting a live page onto buddy and clearing
> the bitmap. A subsequent allocation can hand the same PFN to a new
> owner while the original holder still references it.
>
> A concurrent put_page() that drops the last reference between the
> testzero loop and free_contig_frozen_range() can double-queue the page
> via page->lru, corrupting buddy lists.
>
> Avoid the corruption by not freeing a CMA region if any of the
> pages inside are still in use.
>
> Make it explicit in the warning that the driver allowed a leak.
>
> While at it, use page_ref_freeze() to make the semantics clearer and
> switch to pr_warn_ratelimited().
>
> Fixes: 9bda131c6093 ("mm: cma: add cma_alloc_frozen{_compound}()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Link: https://patch.msgid.link/20260811132045.5f114772@fangorn
> [ david: use page_ref_freeze() + pr_warn_ratelimited() ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/cma.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/mm/cma.c b/mm/cma.c
> index a10ea37a261da..871f95c9ae9f0 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -1020,7 +1020,7 @@ bool cma_release(struct cma *cma, const struct page *pages,
>  		 unsigned long count)
>  {
>  	struct cma_memrange *cmr;
> -	unsigned long ret = 0;
> +	unsigned long leaked = 0;
>  	unsigned long i, pfn;
>
>  	cmr = find_cma_memrange(cma, pages, count);
> @@ -1029,9 +1029,13 @@ bool cma_release(struct cma *cma, const struct page *pages,
>
>  	pfn = page_to_pfn(pages);
>  	for (i = 0; i < count; i++, pfn++)
> -		ret += !put_page_testzero(pfn_to_page(pfn));
> +		leaked += !page_ref_freeze(pfn_to_page(pfn), 1);
>
> -	WARN(ret, "%lu pages are still in use!\n", ret);
> +	if (leaked) {
> +		pr_warn_ratelimited("%lu pages are still in use, not freeing CMA region!\n",
> +				   leaked);
> +		return true;
> +	}
>
>  	__cma_release_frozen(cma, cmr, pages, count);
>
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
