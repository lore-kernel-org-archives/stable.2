Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5194A43F3;
	Wed, 16 Sep 2026 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789556762; cv=none; b=ZRWPsvQOGlHM4sc45PS0w84AQntQEoJMhNcyS8mKOG9q6MzoOrQtU9Djkjsn/uDL8Gqd5vVx4UkIvVWt/SAwMrTEI22WjLdwWf1zh/sxUvUCapdXLI4+pCJtaa0lK/i0h0qpnqRSHEzxXtratlqGDh8M9/+FwfpPe8LEST8JD2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789556762; c=relaxed/simple;
	bh=bDLs31Lfm2cKfCRfJsL403n5WJBN857J9a9SfnOfq1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjvFti4QOaUZgerCYaMkmU23G5aEvk0Se4MnViSVy9jq9dpouvKDaj5QNG3qobxA7uoAbr2OfCKCEQ49cMFGDPM/J8vI3Rv1rgUSlN1/ksjhBaKJAZAYBl6ully27eMc1bkKFscMNtnE3TeQ9et+mPHfQn88YBkgtTtH38T/fUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZA3RLk6f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZA3RLk6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8831F000FF;
	Wed, 16 Sep 2026 11:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789556751;
	bh=DYEbp3NDbWCNlMXuaXTXLtCtA8T9knTbdyJ+6diMaPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZA3RLk6f5n/v3mZ9/7OVo3fJZHY0MAmzZ+5QFDzF2dod2OVpfNO6VBCctrHbqs6i6
	 A/QtImdtfHw2cCEDIPmoCTtVHReumt29NbdSIpeuBgCLyBoDtDwPfaXMazedOhoX/G
	 xUCHOkCuN+DFcInc+PYB4dEITaNa32GPcF38QLDt86dWtyjq24SF+APGC9KGPXBAeV
	 HK7u/iWI8SG3LfUfgZjSo576F9X4Lcdb4gkOls9qCv5wqRXYZluBJa2QhwM4459Wij
	 VlFlb11urNHILrRaDFVb+teLrwyUBU1kFqXYtyLwDv1g7VC6Ykd3JyM/iQDzEOg0sv
	 B3dZ+rP/Kb/vg==
Date: Wed, 16 Sep 2026 12:05:43 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, liam@infradead.org, david@kernel.org, vbabka@kernel.org, 
	jannh@google.com, ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, peterx@redhat.com, jgg@ziepe.ca, 
	sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/madvise: use vm_normal_folio_pmd() in
 cold/pageout PMD range
Message-ID: <aqp2uu4_QY7NRjoH@gremlin>
References: <20260912034833.2952750-1-gourry@gourry.net>
 <20260912034833.2952750-3-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912034833.2952750-3-gourry@gourry.net>

On Fri, Sep 11, 2026 at 11:48:33PM -0400, Gregory Price wrote:
> mmap a VM_MIXEDMAP region whose ->huge_fault installs a PMD through

Gosh, shock, horror! VMA_MIXEDMAP_BIT sir! :P

(It's fine it's fine)

> vmf_insert_pfn_pmd() - mshv_vtl_low does this, and needs CAP_SYS_ADMIN
> to open - then:
>
>   madvise(p, PMD_SIZE, MADV_PAGEOUT);
>
> With a stand-in module for the driver:
>
>   BUG: unable to handle page fault for address: fffff587c0000008
>   RIP: 0010:madvise_cold_or_pageout_pte_range+0x410/0x9b0
>    walk_pgd_range+0x52b/0xaf0
>    __walk_page_range+0x6a/0x1d0
>    walk_page_range_vma_unsafe+0x8e/0x120
>    madvise_pageout+0xb2/0x180
>    madvise_vma_behavior+0x46b/0xa90
>    do_madvise+0x108/0x190
>    __x64_sys_madvise+0x26/0x30
>
> Nothing validates the pfn on the way in:
>
>   can_madv_lru_vma()     rejects VM_PFNMAP, but not VM_MIXEDMAP
>   can_fault()            *pfn = vmf->pgoff & ~(mask >> PAGE_SHIFT);
>   vmf_insert_pfn_pmd()   no pfn_valid() check
>   pmd_folio()            pfn_to_page() -> unpopulated vmemmap

I definitely suggest checking out the small series [0] I sent which changes
how these kinds of semantics are expressed where I... ugh what I missed
can_madv_lru_vma()! Damn it.

Noted as a follow up :)

[0]:https://lore.kernel.org/linux-mm/20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org/

>
> Even with a valid pfn the path is wrong.  The mapping carries no rmap, so

Isn't a non-rmappable page not a folio?

I mean the fact that vm_normal_folio_pmd() returns NULL is kinda saying
that :)

> folio_maybe_mapped_shared() sees mapcount 0, and the walker goes on to
> folio_deactivate(), or folio_isolate_lru() plus reclaim_pages(), against a
> folio this mapping does not own.
>
> Use vm_normal_folio_pmd() and skip on NULL, as the PTE half of this same
> walker already does with vm_normal_folio().  This also filters the huge
> zero PMD, so its separate check is no longer needed.
>
> Fixes: 3c8e44c9b369 ("mm: mark special bits for huge pfn mappings when inject")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260817220810.1175596-1-gourry%40gourry.net
> Cc: stable@vger.kernel.org # v6.19+
> Assisted-by: LLM
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

LGTM in general so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/madvise.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index f75a9d139980..fbb72ab49aa6 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -395,16 +395,15 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  			return 0;
>

Oh God! This function again!

>  		orig_pmd = *pmd;
> -		if (is_huge_zero_pmd(orig_pmd))
> -			goto huge_unlock;
> -
>  		if (unlikely(!pmd_present(orig_pmd))) {
>  			VM_WARN_ON_ONCE(!pmd_is_migration_entry(orig_pmd) &&
>  					!pmd_is_device_private_entry(orig_pmd));
>  			goto huge_unlock;
>  		}
>
> -		folio = pmd_folio(orig_pmd);

Again I'm wondering if pmd_folio() is just a code smell in general?

> +		folio = vm_normal_folio_pmd(vma, addr, orig_pmd);
> +		if (!folio)
> +			goto huge_unlock;
>
>  		if (folio_is_zone_device(folio))
>  			goto huge_unlock;
> --
> 2.55.0
>

--
Cheers, Lorenzo
