Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F526296;
	Mon, 22 Jun 2026 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136009; cv=none; b=iMNgTJE9GMAWygoush1HcXnNQOwa9HwNQZoMMiRowy07TYcAMz+xZnrlyWE8FXKd7zLi7fm1C4Sp+Z9JCKYeshIUV42/8fyeoDjFld9uAm1Mmsmf7MfE7f9a+CUK9EVhlTxiyHeGnY/0tN/I/6WADo74Qpxd6fJIRIDRREvnCy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136009; c=relaxed/simple;
	bh=3cvFqi+syeMc8OVAVIVKQFM1wbcZhCVdGtNhcCA8cRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQlidpU8ix6F+8jQaFckQCBFNPjUqfeehI22I2lAQ8u8Jq+834vB2hXsTmija+GHZwN1CYVAat1aS1vasbAE/y6+Wsqp6r0qLPyXuhhrnnUWeBVNn2Mqwfn8ngxW0pG9WQxSMtXjwRMlgkt8mLAmFfbTSrVxmYTXRxLH92yhBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1L1W/pK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1L1W/pK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AFE1F000E9;
	Mon, 22 Jun 2026 13:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782136007;
	bh=KBrYpAt0fcYYHAE06TXqvrMNJSvx95b7CU6adYHciUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n1L1W/pKS03XydAfkjGJXl8EGD/W2L8vpd+vjCBHE4vZJpr/yxPmwO3xtV5prNw5m
	 QAIhosGROdRNBFiPFSLiLZ700JCXa4ljxF9IbB0ppS7TqVD9e6FEiWIQULWspTXb/7
	 AGQGPCEx7WW3MzyFohJw1XGYD8BgkaFLcnZ7wRNpFya8ZqwZZdov/oqeEFjeWlahoc
	 YqyNXqkRNEBfKUhmIcuN/UY8b/e7+/3lYOXCm7AL6LYdBRAIbypoH4NWqD30jVVrP1
	 ClNxPf/1/YfXEmoOChPwRK8X/eS3HYGGY+CN6k0F8Kx+qU0Dl9XU9AEiM5J3CbuKjI
	 GMu5dIjAZgWpA==
Date: Mon, 22 Jun 2026 14:46:40 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, riel@surriel.com, 
	liam@infradead.org, vbabka@kernel.org, harry@kernel.org, jannh@google.com, 
	sj@kernel.org, ziy@nvidia.com, balbirs@nvidia.com, linux-mm@kvack.org, 
	stable@vger.kernel.org, Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <ajk0N3Aekapljaoh@lucifer>
References: <20260622130651.23359-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622130651.23359-1-richard.weiyang@gmail.com>

+cc Lance, linux-kernel

Your subject line is 83 characters long and is way too detailed how about 'fix
device-private PMD handling'?

You forgot to include linux-kernel@vger.kernel.org on the mail, lore seems to be
a bit broken atm but in general it's helpful to include that.

Also is useful to make this [PATCH mm-hotfixes] to make it really clear it's
intended as a hotfix.

Some commit msg language nits:

On Mon, Jun 22, 2026 at 01:06:51PM +0000, Wei Yang wrote:
> For pmd_trans_huge() and pmd_is_migration_entry(), we does following
> before return the pmd entry:

Sounds better as:

	For PMD entries that satisfy pmd_trans_huge() or pmd_is_migration_entry(), we
	perform the following actions:

>
>   * re-validate pmd entry after PTL
>   * check PVMW_MIGRATION
>   * check_pmd()
>   * handle on pte level if split under us
>
> But for device-private pmd, we just return after pmd_lock().

->

	However, for device-private PMD entries, we simply acquire the PMD lock
	and return.

Also can you please give some justification here as to why all this also applies
to device-private PMD? Right now it sounds hand wavey.

>
> If a softleaf entry is present, e.g. device-private pmd, the existing
> code simply acquires the PMD lock and returns success even if
> PVMW_MIGRATION is set (indicating a migration entry is sought), meaning
> that the caller can incorrectly interpret the entry as something it is
> not, causing data corruption.

This is repetitive, you already mentioned device-private PMD, you already
mentioned that it simply acquires the PMD lock.

You should talk about what issue it caused and why:

	This is particularly problematic when PVMW_MIGRATION is set (meaning a
	migration entry is sought), as it causes a device-private PMD entry to
	be returned with a different data layout, causing memory corruption.

>
> This patch fixes commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration
> support device-private entries") by following the same pattern as
> pmd_trans_huge() and pmd_is_migration_entry() for device private entry.

This is pretty useless. We see what patch it fixes in the Fixes tag, and you're
just repeating things you said above, I'd drop it.

>
> Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Suggested-by: David Hildenbrand <david@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Balbir Singh <balbirs@nvidia.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
>
> ---
> v3:
>   * remove cleanup part, only fix the issue for device-private entry
>   * refine user effect description based on Lorenzo's suggestion
> v2: https://lore.kernel.org/all/20260616063436.20455-1-richard.weiyang@gmail.com/T/#u
>   * specify the possible error case of current code and user visible effect
>   * besides fix, cleanup the pmd entry handling based on David's suggestion
>
> v1: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiyang@gmail.com/
> ---
>  mm/page_vma_mapped.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 2ccbabfb2cc1..8de3c6b82df6 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -270,21 +270,33 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  			spin_unlock(pvmw->ptl);
>  			pvmw->ptl = NULL;
>  		} else if (!pmd_present(pmde)) {
> -			const softleaf_t entry = softleaf_from_pmd(pmde);
> +			softleaf_t entry = softleaf_from_pmd(pmde);
>
>  			if (softleaf_is_device_private(entry)) {
>  				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> -				return true;
> -			}
>
> -			if ((pvmw->flags & PVMW_SYNC) &&
> -			    thp_vma_suitable_order(vma, pvmw->address,
> -						   PMD_ORDER) &&
> -			    (pvmw->nr_pages >= HPAGE_PMD_NR))
> -				sync_with_folio_pmd_zap(mm, pvmw->pmd);
> +				entry = softleaf_from_pmd(*pvmw->pmd);
>
> -			step_forward(pvmw, PMD_SIZE);
> -			continue;
> +				if (softleaf_is_device_private(entry)) {

This is all very horrible. You have an example of how pmde is re-got in the
pmd_trans_huge() branch and pmd_is_device_private_entry() exists...

We can just make this another branch and do the re-check more neatly.

I enclose a patch that does that (untested, please check).


> +					if (pvmw->flags & PVMW_MIGRATION)
> +						return not_found(pvmw);
> +					if (!check_pmd(softleaf_to_pfn(entry), pvmw))
> +						return not_found(pvmw);
> +					return true;
> +				}
> +				/* device-private pmd was split under us: handle on pte level */
> +				spin_unlock(pvmw->ptl);
> +				pvmw->ptl = NULL;
> +			} else {
> +				if ((pvmw->flags & PVMW_SYNC) &&
> +				    thp_vma_suitable_order(vma, pvmw->address,
> +							   PMD_ORDER) &&
> +				    (pvmw->nr_pages >= HPAGE_PMD_NR))
> +					sync_with_folio_pmd_zap(mm, pvmw->pmd);
> +
> +				step_forward(pvmw, PMD_SIZE);
> +				continue;
> +			}
>  		}
>  		if (!map_pte(pvmw, &pmde, &ptl)) {
>  			if (!pvmw->pte)
> --
> 2.34.1
>

Thanks, Lorenzo

----8<----
From e6a3c1c782714ed831c4d46a14bb99226423bf59 Mon Sep 17 00:00:00 2001
From: Wei Yang <richard.weiyang@gmail.com>
Date: Mon, 22 Jun 2026 13:06:51 +0000
Subject: [PATCH] refactored

Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 mm/page_vma_mapped.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 2ccbabfb2cc1..17dff8aab9f9 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -269,14 +269,24 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			/* THP pmd was split under us: handle on pte level */
 			spin_unlock(pvmw->ptl);
 			pvmw->ptl = NULL;
-		} else if (!pmd_present(pmde)) {
-			const softleaf_t entry = softleaf_from_pmd(pmde);
+		} else if (pmd_is_device_private_entry(pmde)) {
+			softleaf_t entry;
+
+			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
+			pmde = *pvmw->pmd;
+			entry = softleaf_from_pmd(pmde);

-			if (softleaf_is_device_private(entry)) {
-				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
+			if (likely(softleaf_is_device_private(entry))) {
+				if (pvmw->flags & PVMW_MIGRATION)
+					return not_found(pvmw);
+				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
+					return not_found(pvmw);
 				return true;
 			}
-
+			/* device-private pmd was split under us: handle on pte level */
+			spin_unlock(pvmw->ptl);
+			pvmw->ptl = NULL;
+		} else if (!pmd_present(pmde)) {
 			if ((pvmw->flags & PVMW_SYNC) &&
 			    thp_vma_suitable_order(vma, pvmw->address,
 						   PMD_ORDER) &&
--
2.54.0
