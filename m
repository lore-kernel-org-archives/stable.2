Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199313B5E19;
	Thu,  6 Aug 2026 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024788; cv=none; b=rOZtTUkh7e4PLSMyOJ0P54hixkxE9YKxz4AO9OT3/+bpUuL6IedjlgI2wDBBG8rdRev/B/9DX82do8KE9dbptUHZz5bXrGZvZNr3/uBsaxErZmyjXj5iQA4Ks9sM4/nATYpGiConVvcPkXLXRwkE9QnzJuv1DzzeNi//yBwXs2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024788; c=relaxed/simple;
	bh=Vzhep9VK3EP1iYF7xvNAe0QmYYeTds8mqwczMoFEiQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImJ8Bxxwz4Nk7ZOtpf2TzR4VAuwFpkCesKklJjdndx01trXqF7bx1+sE2gxj04acc0hlggfiCdIXCI+2YtWm6lfmRum9jnROjGyZNQemC5zOxXNwSvXIKkB0lqcyn+c/ZU8TfU0skc4nE113NlUTUp+asRDZ/K0hvasxVXgM1lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CocnQO/e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CocnQO/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB321F000E9;
	Thu,  6 Aug 2026 13:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024782;
	bh=JgYt8RNCcPu1D6s4vJCxJg9Q9vbO/MH5z4jIJNXLqW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CocnQO/e5fu5Hao1GR9Ff6qlMjFfZufWuu6STHsEGTPoSaNl1oSOeMZ+r/Atx/yfI
	 ZGnBTMIPdlR2m96eyfnZCZ2LXq8/p4mI4eILOYpG7o8+OS05QU2EYKRc5nAe8jw2Ww
	 Fk4mrYFbr+shmtuMTxUpRJTFn43Nvxpc+nR6QftRB5qvFg/cT78u9qbjSzLLGYAeFz
	 6faQSzhZyTLXCox5CsSxw0tg1zociXNvhhPo1u9osAwJ0/rqCKDQtTEN/Hhd/1nUq0
	 vNkBCZih9B4kmV90hQPyZY9atnBlJkPXHQEE7lUe6nqC+fPYOb3Kq21iyf95xHmduE
	 oLUCgJ6KQG5jQ==
Date: Thu, 6 Aug 2026 14:59:22 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, sj@kernel.org, akpm@linux-foundation.org, 
	david@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	liam@infradead.org, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev, vbabka@kernel.org, 
	jannh@google.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/huge_memory: skip zone device folios in
 madvise_free_huge_pmd()
Message-ID: <anSOvqN1_Hs190xi@lucifer>
References: <20260728194714.3713735-1-gourry@gourry.net>
 <20260728194714.3713735-3-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728194714.3713735-3-gourry@gourry.net>

I kinda wish he had some generalised folio handler like:

	struct folio_ops {
		int (*handle_empty_entry)(void *priv);
		int (*handle_normal_folio)(void *priv, struct folio *folio);
		int (*handle_softleaf_pte_entry)(void *priv, const pte_t *ptep);
		int (*handle_zone_folio)(void *priv, struct folio *folio);
		...
	};

Or I don't know an equivalent type of thing, as we keep having these same
patterns emerge in mm that are duplicated in a million places with slight
variations... :)

I wonder if C is expressive enough to get us to something sane though.

On Tue, Jul 28, 2026 at 03:47:12PM -0400, Gregory Price wrote:
> madvise_free_huge_pmd() resolves the folio backing a PMD via pmd_folio()
> and marks it lazyfree without checking for zone device memory.
>
> The surrounding guards do not cover every zone device case:
>  - MADV_FREE only operates on anonymous VMAs (DAX mappings are excluded)
>
>  - !pmd_present() branch rejects device-private and migration entries
>
>  - present zone device PMD (device coherent THP) is not filtered.
>    Unlike vm_normal_page_pmd(), it performs no special/pfnmap check,
>    and would be marked lazyfree here.
>
> Bail out when the folio is a zone device folio.
>
> Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Anyway LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/huge_memory.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 5bd8d4f59a7b..e0ffdeeb3077 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2338,6 +2338,10 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	}
>
>  	folio = pmd_folio(orig_pmd);
> +
> +	if (folio_is_zone_device(folio))
> +		goto out;
> +
>  	/*
>  	 * If other processes are mapping this folio, we couldn't discard
>  	 * the folio unless they all do MADV_FREE so let's skip the folio.
> --
> 2.55.0
>

--
Cheers, Lorenzo
