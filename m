Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740734A8FCF;
	Tue, 15 Sep 2026 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487755; cv=none; b=aNGMwv5ZthOy+5xYYr1g0l0POdO88okeAw5jYeIm0fdbiuskqaWV3PJ2I37Jr3uwr1d017PhC0uB0IEbbfZaz7U+TP9IzTMdXZC70KWGw2cgnAWlwdmQydljucejiMjhnz8o1idp6F0SB0pEXPvc7VS4fz01cNrf6tiNSbD6HmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487755; c=relaxed/simple;
	bh=plVSc1FlLmAqk+2A5YF5q80TtyEnshF5p+3K28hnrhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lj8StIbjIO7aZKaB60MU73Nd9UhPJgyLqS9eNr/j7DtuiA2Y59/2q/mO64XqWBE1ySLQuWvJGmoTcimU1OJVSZfnBPTnG9YurEvnDOb3pZNCaysZw/2E0w7M4q49qgznTW5wj1AO2dB5b1SQ114YMc8HqLooJkq/uM5/swo52dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jX7wzDGS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jX7wzDGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEFC1F000FF;
	Tue, 15 Sep 2026 15:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789487753;
	bh=Ck/iKy4tr4M+OoXzMpF/kel2WjhTrOUqJFUS4adZunI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jX7wzDGSJXhqVbR925MIAaJe1yX9wpK9q83/+J8qU5r10cXHyAPSzaPaVae8wfyBX
	 /OBeb4ckVh6Ws2j2eD7/CvCMd8gPJNGLpdIPMXq6m/QEwwGOCrrqBH9yBH02LbQiVp
	 QSusn0MMDVidnsAimMaiwRP1W9tGttojyQC2i6tz3hjuFaV0Jkc8iMdNXjlWp6FRt/
	 KuEOoMXi0v5VT4zgNSaaL+siwyXvVnzPlpuvZkXjGYqD4c397fOIXtUO3yW70tFgEx
	 CXAADDjKSia0GY3oqhNddwHeuAUrLGuGWPzY70XsIeuDutI47lx2GAmvQ9KekOMs5I
	 iIaZ90Webon2Q==
Date: Tue, 15 Sep 2026 16:55:47 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, liam@infradead.org, david@kernel.org, vbabka@kernel.org, 
	jannh@google.com, wangjiexun@tinylab.org, sashiko-bot <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: reclaim isolated folios if PTE restart fails
Message-ID: <aqloB0zm3RjJ47m1@gremlin>
References: <20260912110832.3203902-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912110832.3203902-1-gourry@gourry.net>

On Sat, Sep 12, 2026 at 07:08:32AM -0400, Gregory Price wrote:
> MADV_PAGEOUT collects isolated folios on a local list before reclaiming
> them after the PTE walk.  The reschedule path drops the PTE lock and then
> restarts the mapping with pte_offset_map_lock().

Is this reschedule path even necessary? It's pretty bloody sketchy.

I thought the modern approach (TM) was to not do cond_resched() and friends so
can we actually look at removing this?

>
> A concurrent operation can remove or replace the PTE table while the lock
> is dropped, causing pte_offset_map_lock() to return NULL.  Returning directly
> in that case bypasses reclaim_pages(), leaving the collected folios off the
> LRU with elevated references.
>
> Route the failure through the existing cleanup path so any isolated folios
> are reclaimed or put back.
>
> Simplest userland pseudo-code reproducer:
>
> p = mmap(PMD_SIZE, ANONYMOUS);
> touch_every_page(p, PMD_SIZE);
> parallel {
>    while (1) madvise(p, PMD_SIZE, MADV_PAGEOUT);
>    while (1) {
>        madvise(p, PMD_SIZE, MADV_DONTNEED);
>        touch_every_page(p, PMD_SIZE);
>    }
> }
>
> Reproduced in qemu trivially with some explicit widening of the race window.
>
> Fixes: b2f557a21bc8 ("mm/madvise: add cond_resched() in madvise_cold_or_pageout_pte_range()")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260821150912.183976-1-gourry@gourry.net
> Cc: <stable@vger.kernel.org>
> Assisted-by: LLM
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  mm/madvise.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 574aa2bb7c7e..ba5a3d77241a 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -464,7 +464,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,

This function is truly some of the absolute worst code I've read in
mm. Shocking.

>  restart:
>  	start_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
>  	if (!start_pte)
> -		return 0;
> +		goto out;
>  	flush_tlb_batched_pending(mm);
>  	lazy_mmu_mode_enable();
>  	for (; addr < end; pte += nr, addr += nr * PAGE_SIZE) {
> @@ -568,6 +568,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  			folio_deactivate(folio);
>  	}
>
> +out:

Seems odd to put this here for a condition that explicitly guarantees
!start_pte? It should be before the if (pageout) reclaim_pages(...);
surely?

I honestly wonder whether, rather than adding yet another label/goto into this
absolute bloody mess, whether we should just live with a bit of duplication and do:

	if (!start_pte) {
		if (pageout)
			reclaim_pages(&folio_list);
		return 0;
	}

I actually think that'd be clearer at this point than throwing in some more
indirection.

That's for the backport but somebody needs to rework this entire bloody
function going forwards...

>  	if (start_pte) {
>  		lazy_mmu_mode_disable();
>  		pte_unmap_unlock(start_pte, ptl);
> --
> 2.55.0
>

--
Cheers, Lorenzo
