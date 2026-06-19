Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF43655C2
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781865862; cv=none; b=JtKNYo7v5MetvUPgJS2GKz3+iRdPST8/dX66IzmzeMSrgcGP+LCSl0xw+3RH93xoiK5XqVn5IyKQccw/uk8iAm3nB/Y7MgoVbujY4Vo1L7+Hl0gUspVd4PF2y9ODz4Snx5H+dV2EnoyOAFSHwODuB8iJjCTiUO+4TGYmlT2MdE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781865862; c=relaxed/simple;
	bh=dmh0y6MfacyKByStQaTv+5TuymwKCJjd+klHHDdxtKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2wd82IxZrMnfzqPmQLBm3X9PtKyBLZbod50yH3OShWslHrXHs4VMVz2WIHxC4J49aufNsnYGWT1KKHZjy3MEu38AJmDsDE7UOvMzZPDCmWESCQmGElDWB90F/9zhlJGGPGCrICEu8sB0oTFabmKbwnG2gkgR2emqgbLeqjb9Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6qrF8oa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6qrF8oa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855901F000E9;
	Fri, 19 Jun 2026 10:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781865860;
	bh=3is9oNUkO05ESVUSRNJqZRRZt4O+9EMA6drdEzl8B68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J6qrF8oa8Ce1axqO5TBKRGUIxxnelyGPH1bxZG5sgabhh0ckucM9dtnfIFtsBE56N
	 hbmcXlxDSl1Z/fkkvWeJLWb69cLX8bxzwklqhWOzw71AF8p187TfF7szkwRlPmV/bZ
	 0l4TWFWcqZdES/1GWna+TDMVFnSB88BbxYcyGJbQfTdjonz+9H0+zfS4tqhPSqNMxz
	 XiIHo7XzMvncEA+sgwxTPmMAvTkUA8v8P0RcpbEyyRIQPBqsd+122+JV2reOC3K/8W
	 67bK6cS2ngFduL9ghXXIqZNXep2MPTHJia5m9k9/W2NtHVs1lqyaQ+AdPuVWbsrOFF
	 Y5eJ4dM57+i6w==
Date: Fri, 19 Jun 2026 11:44:13 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, riel@surriel.com, 
	liam@infradead.org, vbabka@kernel.org, harry@kernel.org, jannh@google.com, 
	balbirs@nvidia.com, ziy@nvidia.com, sj@kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Subject: Re: [Patch v2] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <ajUXNjRMraKb6k2n@lucifer>
References: <20260616063436.20455-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616063436.20455-1-richard.weiyang@gmail.com>

-cc wrong email

On Tue, Jun 16, 2026 at 06:34:36AM +0000, Wei Yang wrote:
> For pmd_trans_huge() and pmd_is_migration_entry(), we does following
> before return the pmd entry:
>
>   * re-validate pmd entry after PTL
>   * check PVMW_MIGRATION
>   * check_pmd()
>   * handle on pte level if split under us
>
> But for device-private pmd, we just return after pmd_lock().
>
> This may return improper entry, e.g. if we are looking for a migration
> entry, device-private entry could still be returned, which leads to data
> corruption.

I don't thik this is quite clear?

How about:

	If a softleaf entry is present, the existing code simply acquires the
	PMD lock and returns success even if PVMW_MIGRATION is set (indicating a
	migration entry is sought), meaning that the caller can incorrectly
	interpret the entry as something it is not, causing data corruption.

>
> This patch fixes commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration
> support device-private entries") by following the same pattern as
> pmd_trans_huge() and pmd_is_migration_entry() for device private entry.
>
> While at it, it cleanups the pmd entry handling in page_vma_mapped_walk().
>
>   * Instead of handling trans huge/migration entry/device private entry
>     in a mixed manner, we put each case into its own if condition and
>     handle with the same pattern.
>   * Also we grab PTL and make sure pmd is not changed under us after
>     above check instead of do the check with PTL hold.
>   * restart the process if pmd is changed under us

You're doing quite a bit for a fix and you're putting it all in one place.

How about do the fix as 1 patch, and then cleanups as other ones? It helps with
review too :)

It's a general rule of thumb that if you do more than one of moving, refactoring
or changing code, to do them as separate patches so a reviewer/somebody
bisecting can clearly separate each.

Also PLEASE do not add new functionality (this lock recheck) in a fixes
patch. We'll end up backporting new logic that way.

Make the fixes bit _minimal_.

I think in general Andrew prefers separate fixes patches so I'd just make the
_minimal_ change that fixes this for the backport, and the cleanup stuff as a
separate series.

>
> Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")

Hmm seems the device private stuff has had a rocky road of late!

I wonder if we need some more test coverage on this?

> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Suggested-by: David Hildenbrand <david@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Balbir Singh <balbirs@nvidia.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Annoying nag: You sent to my correct email ljs@kernel.org (thanks!) but also
cc'd the incorrect one, please only send to ljs@kernel.org thanks :)

> Cc: <stable@vger.kernel.org>

Be better to just have this with the Fixes tag, Andrew adds the Cc's from the
actual cc- list anyway.

>
> ---
> v2:
>   * specify the possible error case of current code and user visible effect
>   * besides fix, cleanup the pmd entry handling based on David's suggestion
>
> v1: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiyang@gmail.com/
> ---
>  mm/page_vma_mapped.c | 63 +++++++++++++++++++++-----------------------
>  1 file changed, 30 insertions(+), 33 deletions(-)
>
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 2ccbabfb2cc1..21635fab209c 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -243,40 +243,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  		 */
>  		pmde = pmdp_get_lockless(pvmw->pmd);
>
> -		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
> -			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> -			pmde = *pvmw->pmd;
> -			if (!pmd_present(pmde)) {
> -				softleaf_t entry;
> -
> -				if (!thp_migration_supported() ||
> -				    !(pvmw->flags & PVMW_MIGRATION))
> -					return not_found(pvmw);
> -				entry = softleaf_from_pmd(pmde);
> -
> -				if (!softleaf_is_migration(entry) ||
> -				    !check_pmd(softleaf_to_pfn(entry), pvmw))
> -					return not_found(pvmw);
> -				return true;
> -			}
> -			if (likely(pmd_trans_huge(pmde))) {
> -				if (pvmw->flags & PVMW_MIGRATION)
> -					return not_found(pvmw);
> -				if (!check_pmd(pmd_pfn(pmde), pvmw))
> -					return not_found(pvmw);
> -				return true;
> -			}
> -			/* THP pmd was split under us: handle on pte level */

Don't drop critical comments like this, that's very bad.

> -			spin_unlock(pvmw->ptl);
> -			pvmw->ptl = NULL;
> -		} else if (!pmd_present(pmde)) {
> -			const softleaf_t entry = softleaf_from_pmd(pmde);
> -
> -			if (softleaf_is_device_private(entry)) {
> -				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> -				return true;
> -			}
> +		if (pmd_present(pmde)) {

You're not checking pmd_trans_huge() at all now? Just assuming pmd_present() ==
pmd_trans_huge()?

> +			if (!pmd_leaf(pmde))
> +				goto pte_table;

OK now assuming pmd_leaf() == pmd_trans_huge()?

You didn't mention this in the commit msg? Justificaiton please?

> +			if (pvmw->flags & PVMW_MIGRATION)
> +				return not_found(pvmw);
> +			if (!check_pmd(pmd_pfn(pmde), pvmw))
> +				return not_found(pvmw);



> +		} else if (pmd_is_migration_entry(pmde)) {
> +			softleaf_t entry = softleaf_from_pmd(pmde);
> +

Err you dropped the thp_migration_supported() check? Why?

> +			if (!(pvmw->flags & PVMW_MIGRATION))
> +				return not_found(pvmw);
> +			if (!check_pmd(softleaf_to_pfn(entry), pvmw))
> +				return not_found(pvmw);
> +		} else if (pmd_is_device_private_entry(pmde)) {
> +			softleaf_t entry = softleaf_from_pmd(pmde);
>
> +			if (pvmw->flags & PVMW_MIGRATION)
> +				return not_found(pvmw);
> +			if (!check_pmd(softleaf_to_pfn(entry), pvmw))
> +				return not_found(pvmw);

I mean it's less awful than what was there before, but as refactoring goes,
putting a massive set of branches in the middle of a long function isn't really
the best.

Can we avoid this horrible goto by separating this out into a function?

> +		} else {

Else means what exactly? A comment would be good.

I feel like in an effort to keep all this at one level of indentation you've
created a confusing else case.

Sane thing would be to:

a. have this as a separate function
b. to do:

	if (pmd_none(pmde)) {
		...
		return ...;
	}

	if (pmd_present(pmde)) {
		...
		return ...;
	}

	softleaf = softleaf_from_pmd(pmde);

	/* softleaf stuff */

	return ...;

In this function.

That way it's _very clear_ you're doing softleaf stuff.


>  			if ((pvmw->flags & PVMW_SYNC) &&
>  			    thp_vma_suitable_order(vma, pvmw->address,
>  						   PMD_ORDER) &&

Umm... previously this was done for all softleaf entries other than
device-private, now not, and you haven't, why?



> @@ -286,6 +274,15 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  			step_forward(pvmw, PMD_SIZE);
>  			continue;
>  		}
> +
> +		/* Double-check under PTL that the PMD didn't change. */
> +		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> +		if (pmd_same(pmde, pmdp_get(pvmw->pmd)))
> +			return true;
> +		spin_unlock(pvmw->ptl);
> +		pvmw->ptl = NULL;
> +		goto restart;

I'm not sure I really get the justification for this? seems you just added this
arbitrarily?

Again, you shouldn't be making changes like this in a fix patch.

> +pte_table:
>  		if (!map_pte(pvmw, &pmde, &ptl)) {
>  			if (!pvmw->pte)
>  				goto restart;
> --
> 2.34.1
>

This is really hard to review like this, as above please split this up properly.

Thanks, Lorenzo
