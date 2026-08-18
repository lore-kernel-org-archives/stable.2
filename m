Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D769F3368A7;
	Tue, 18 Aug 2026 07:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787037619; cv=none; b=O+8ut/iqr4gq5iblkRgwVETOSmYf31bYSicIY9t0IHG7Ks9LyzS2GhKrE2CPaHfadsdgJ2C4Va5eEC0C1HtEKG9W4VkdYu4ziayh8RF65b5NdIybE1KAIiICb1wdwa5FSHzHdeo8fEAelSyw3o8DeQnEQk9F/NDGQoiNSARf32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787037619; c=relaxed/simple;
	bh=MttyC9wCFOu09gAFocISBAt2TtzOnQqNuiuVLGIhdIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeyPNYfnNUIIrYyeE5ovGfT95g9nQFfwuho5j5oWVkLwU0ycCV6154CLowOPZJxRdI8SViU0s9Ck8S/MfkPZrRYmmcUCoo0BPW/awvEmRkWTKn68zXmlfUY3clG87FNG93+j26VBnsTBtND7vxx+OvsiKt9Iu0WNkotdclsLO6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2750B1F00A3A;
	Tue, 18 Aug 2026 07:20:11 +0000 (UTC)
Date: Tue, 18 Aug 2026 08:20:05 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	liam@infradead.org, nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev, vbabka@kernel.org, 
	jannh@google.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, balbirs@nvidia.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm/mempolicy: skip zone device folios when
 queueing folios
Message-ID: <aoQHgUBfTqChH9_-@gremlin>
References: <20260817220810.1175596-1-gourry@gourry.net>
 <20260817220810.1175596-4-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817220810.1175596-4-gourry@gourry.net>

On Mon, Aug 17, 2026 at 06:08:10PM -0400, Gregory Price wrote:
> queue_folios_pte_range() already pairs vm_normal_folio() with an
> explicit folio_is_zone_device() check before adding folios to the
> migration pagelist.
>
> vm_normal_folio() alone does not reject zone device memory (a present
> device-coherent page in a normal VMA is returned as "normal").
>
> Mirror the explicit check in queue_folios_pmd() as well.
>
> queue_folios_pmd() uses pmd_folio() directly and can encounter a present
> zone device PMD - e.g. a device-coherent THP.
>
> This is not filtered by existing checks:
>   !pmd_present()   - only rejects non-present device-private and
>                      migration entries
>
>   vma_migratable() - excludes DAX and VM_PFNMAP.
>
> The early return also means such a folio is no longer counted in
> qp->nr_failed under MPOL_MF_STRICT.  This is the same pattern used
> by queue_folios_pte_range() (skipping zone device without failing).
>
> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Seems sensible so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/mempolicy.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 3498a5651d50f..3418b5664dcf8 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -662,6 +662,8 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
>  		return;
>  	}
>  	folio = pmd_folio(pmdval);
> +	if (folio_is_zone_device(folio))
> +		return;
>  	if (is_huge_zero_folio(folio)) {
>  		walk->action = ACTION_CONTINUE;
>  		return;
> --
> 2.53.0-Meta
>

--
Cheers, Lorenzo
