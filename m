Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403127;
	b=OJ+Te90/bCfHP7Sj4S/rZBfei0QFWixblWFo4tFH9Dsx1wNtI/wbYJSXJ/hw8aDGPLtP
	 9eGmn7k2NNKZlwPo5C0kGQWRAFFBoX4fzup8/gbOBAIetnTJPgD7wUIH6JO4QPcsMJQFq
	 1rj5F26AZ7rf+HCDd2TYAtRbscnPomwOqXyQGw5WulzTF//Dj+LFdfziySmkIyjk39RC0
	 UD05Mpc9sqXy0VlWzz9OEkwBPYLJpxVd5iEW3lV8fY4XgN63C9u8LjDQn0xvfO5F4c0p9
	 HjuwvGMoVzMVwtS5YE+1dlDwXkUm9Ucd/xp8QtQ0jufBZ0EXlS8dgIHyDnszkXSnrIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403127;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SJdMLqafvm+KLuD5FOpLe+66ffjiV7oq+8GZl6H/BF4=;
	b=s1NjqQ6xng+ulqOnKawidh3wvPS7zFpxlPqjvvZRleiutRIQRQP1I4QQLf5Cj1EFbuGf
	 BFxEK53lERFYbQonHhHt4JhLE6njaOxWcITz0iwTEgYl3uxNhEWCBdH1FOIDS72aTRLbo
	 P1cx9kCp5LnvkGNCGFuMZG9gONl2R1or5V2Sdaa4XWE/OAuC3xVFoqmTdPQBiUG99xWA9
	 VCXEpeFZNN3yp231wnPELuUEkVHKiNExD0YIBZ76ZHJRlfPNtosEly1kx0Pzl1kkP57U5
	 pw7tE6Gpaaqx+e19/nGKEcbRUEXnFmjzRSPSGK5elZaajjjTYaUXHxtj4mx4ulgF6hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYjIgXqm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7040606A32A;
	Wed, 11 Nov 2026 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYjIgXqm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399BB1F00A05;
	Wed, 11 Nov 2026 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794403127;
	bh=SJdMLqafvm+KLuD5FOpLe+66ffjiV7oq+8GZl6H/BF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BYjIgXqmUTZ8jphCM7ZVSg+9kJZ/A8NSQH6cCyu49g0npTqO7d4B5pWdaUVgpEEt1
	 1zlNN6EeZRYIOInLKPYt8bUYiVmaTmKtUmmXia3UcHEgOHbH/CnSAC44P2m+4bxmBs
	 Bl1HJww6+ivIptjbxmlzj7+47WQ2Tl6AZBBqIOwZz0UAjhq/RvajrtQpmF7hpODpVb
	 JF45vFpiVWpbFS5KuCh2QwhKiuINj25lZMSBRX1dtRiv2iAXTnjF0teipAPZbMK/sf
	 2cgoZibsgq28uhG0B8ykmcMCsRg1LYMn8wYfE141pQ8u0ic2ny50cb+at0i6Ce2fqJ
	 DIckyzgJQ4OlQ==
Date: Wed, 11 Nov 2026 13:18:36 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com, 
	byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com, 
	joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, mhocko@suse.com, 
	pfalcato@suse.de, rppt@kernel.org, surenb@google.com, vbabka@kernel.org, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com, kas@kernel.org, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com, 
	baolin.wang@linux.alibaba.com, Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: don't PTE-batch a swap-in over a
 hardware-poisoned subpage
Message-ID: <avRqaatdOUunxrcZ@gremlin>
References: <20261111113904.650722-1-usama.arif@linux.dev>
 <20261111113904.650722-2-usama.arif@linux.dev>
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
In-Reply-To: <20261111113904.650722-2-usama.arif@linux.dev>

On Wed, Nov 11, 2026 at 03:38:29AM -0800, Usama Arif wrote:
> do_swap_page() checks PageHWPoison() on the faulting page, but the
> large-folio batching path then maps the rest of the folio without looking
> at the other subpages. A poisoned subpage that is not the one being
> faulted gets mapped anyway, and the fault that would have reported it
> never happens.
>
> Skip batching for such a folio and let each page take its own fault,
> where the existing check catches it.
>
> Scan the subpages rather than testing the folio-level PG_has_hwpoisoned:
> memory_failure() sets PageHWPoison() on the subpage first and only sets
> the folio flag much later, and the bail-outs in between - for example
> get_hwpoison_page() losing a page lifecycle race - return with the
> subpage marked and the folio flag never set.
>
> Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  mm/internal.h | 15 +++++++++++++++
>  mm/memory.c   |  4 ++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index cd3675c044e0a..e61c02f4019b0 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -28,6 +28,21 @@ struct folio_batch;
>  int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
>  		void *buf, int len, unsigned int gup_flags);
>
> +/*
> + * Check every page of the folio for HWPoison, rather than relying on the
> + * folio-level PG_has_hwpoisoned, which memory_failure() can leave clear.
> + */
> +static inline bool folio_has_any_hwpoisoned_page(const struct folio *folio)
> +{
> +	long nr = folio_nr_pages(folio);
> +	long i;
> +
> +	for (i = 0; i < nr; i++)
> +		if (PageHWPoison(folio_page(folio, i)))
> +			return true;
> +	return false;
> +}
> +
>  /* mm/workingset.c */
>  bool workingset_test_recent(void *shadow, bool file, bool *workingset,
>  			    bool flush);
> diff --git a/mm/memory.c b/mm/memory.c
> index d477a4f986bc8..4b7d456332200 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5158,6 +5158,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
>  			goto check_folio;
>
> +		/* Let a poisoned subpage take its own fault. */
> +		if (folio_has_any_hwpoisoned_page(folio))
> +			goto check_folio;
> +

Hm, isn't scanning every single page in the folio potentially quite costly
here?  I thought the point of batching was to improve performance overall?

It seems broken to have stuff potentially interact with hwpoison but then
to only set the folio-level flag much later?

Also why are we swapping out folios containing hwpoison pages? Shouldn't we
migrate away from the hwpoison? :) (I'm not really familiar with the hw
poison stuff)


>  		page_idx = idx;
>  		address = folio_start;
>  		ptep = folio_ptep;
> --
> 2.53.0-Meta
>

--
Cheers, Lorenzo
