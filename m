Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D60541A4E4;
	Mon, 12 Oct 2026 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806855; cv=none; b=NHYOj/rDrcIFXMp6qwyiSrIHoUMBELCVnzk6SoDwL23oeUKKIOlKOWiFsOWu5QdcZuuzCauexP0R3P3cbBLRcA4/em1GjzZLheDYN9mOFlI0eMwmEoQd/pqSrmNhdXH3YpcwrZS/ylFtP08FYODqrbZ07CQQaGNu3HVDPocBk9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806855; c=relaxed/simple;
	bh=IRJX6F9jPB4/pMCp3uWJDDLWMt5FbAGXkHmvqHLAJ4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nONXW3MqvaFOnD0TIfwmXgOjwLGMwVIZrC7GiSxfV0kr8/bzZ8oK0Mia0zf9QHHlpY0Ynihp+0YoyqQDOUxeHE40371kWngCHkBFcUMXuHBEsjx/Mz52J136YHTy+woV6SsGlJKhRGOg4QX54QG/hhDigA+U6Wf2oqTRaWyE50A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLcO5592; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLcO5592"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479031F0089B;
	Mon, 12 Oct 2026 12:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791806850;
	bh=5OQPr0ut11DqRv4tqIdGPLsEg2aaqnjobrfhtZ7EnVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MLcO5592LBj+bW5ZURBdZCsaxhSYcMr4j25Am5j8TvngwDTnNlpAoOqeeDUEyM3vP
	 9VNdGChfP8vSpA/YMNohtHSH28RS8ZnP0g975585/iIqdUZRNUUJ1kze6FADNofkTr
	 vGiBukdr9OPAdfR4l6V5qK1Yx6d+3BeXAoSGre4fMZaL09whilv0aGST7LDYdh/Rpr
	 avrAf5WxdN6OkRnMm7yJE5Jx/iPP3uqqDXkGWfhEnaCuYbcV7aRbRUmsnRxsJZ6myb
	 iIKvpsjnSV8y7Q8n75WrGPcfJg3YHhKwVqHcimHKs9iG7ulILJP2jnscPPy4ro0RUY
	 oR2HocTVFXRng==
Date: Mon, 12 Oct 2026 13:07:23 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
	Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: don't discard lazyfree THPs at PMD level
Message-ID: <asy445BYRhcsGDE9@gremlin>
References: <20261009-lazyfree-stable-fix-v1-1-70997958ef8d@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-lazyfree-stable-fix-v1-1-70997958ef8d@nvidia.com>

On Fri, Oct 09, 2026 at 10:08:18PM -0400, Zi Yan wrote:
> __discard_anon_folio_pmd_locked() clears a lazyfree THP PMD before it knows
> whether the folio can be discarded, and restores it if the folio was
> redirtied or has extra references. A concurrent munmap() or
> MREMAP_DONTUNMAP skips the temporary none PMD and unlinks the VMA from its
> anon_vma, so the folio stays mapped after the anon_vma is freed and a later

Yeah this seems pretty horrible, instating a page table entry under the rmap
lock is pretty gross in general, is there anywhere else where we actually
_install_ (even if 'reinstate') page table entries under the rmap lock?

I think this commit message needs to be clearer/more detailed though, I've been
sat here working this through in my head for a while.

I'm confused about the locking, which is really the key point about this change
isn't it?

unlink_anon_vmas() takes the anon rmap lock so that can't happen concurrently,
so is it _just_ the case that:

- The folio is not properly freed/unmapped and ends up with a dangling anon_vma
  pointer

In which case, nobody can actually access that folio since it's not mapped
anywhere, or is it the far more terrible case of the above and:

- set_pmd_at() in __discard_anon_folio_pmd_locked() reinstates the pmd entry
  regardless of the fact that the VMA and surrounding page tables could go away
  concurrently

?

But I'm confused here because unlink_anon_vmas() takes the anon_vma lock?

EDIT: See below, I figured out what it was.

Looking at the code:

<anon_vma lock>
[reclaim]
< PMD lock >
-> try_to_unmap_one()
    -> unmap_huge_pmd_locked()
      -> __discard_anon_folio_pmd_locked()
        [ clears PMD entry ]
	...
	[ reinstates PMD entry later ]

Concurrent munmap():

<mmap write lock, downgraded to mmap read lock later>
do_vmi_align_munmap()
  -> vms_complete_munmap_vmas()
    -> vms_clear_ptes()
      -> unmap_region()
        -> unmap_vmas() < zaps > <----- EDIT: the real issue, see below
	-> free_pgtables()
	   -> unlink_anon_vmas()
	     -> < anon_vma lock taken! >
	   ... clears down page tables (no rmap lock) ...

Is the issue actually the zapping in unmap_vmas(), which doesn't seem to be
protected by rmap lock at all, meaning that _that_ can happen with
concurrent munmap()?

So unmap_vmas() doesn't correctly populate the mmu_gather struct for the
range, meaning that the underlying page isn't freed and the refcount,
mapcount etc. are all left as they were?

MREMAP_DONTUNMAP seems a bit of a bizarre callout, but I suppose it is the
other case in which (under certain, likely, circumstances
e.g. non-partial/self-merging remap) an unlink_anon_vmas()'s call is done.

With normal mremap() that'd happen via an unmap of the original VMA.

> rmap walk uses the freed anon_vma.
>
> Using an invalidated PMD instead of a cleared one requires additional arch
> code fixes. Instead, disable the PMD level discard of lazyfree THPs, as
> before commit 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP during
> shrink_folio_list()").

Again it feels like this commit message assumes a bunch of information that
isn't presented here.

Why would you need to invalidate the PMD? Is the issue actually TLB flush?
How does that get around the fact that a PMD entry can be 'reinstated'
concurrent with a zap?

Or is it that you put something not-pmd_none() there? Hmm yeah I think so.

Doesn't all this cause pmd_none_or_clear_bad() to fire too?

All-round terrible.

I've not dug into the reports in detail, but I think the commit message
should also talk about what exactly is missing from pmdp_invalidate() that
is broken here? Are some arches not doing things quite right?

OK reading the code more and it seems the _real_ issue is actually
pmd_is_huge() in zap_pmd_range() right?

It's the -> pmd_none() in general. By doing that, you are breaking a
contract with PMD leaf entries.

So you get:

zap_pmd_range()
  -> pmd_is_huge() ? [ no ]
     -> zap_huge_pmd() [ WOULD HAVE taken PMD lock that blocks against reclaim ]

So using something like pmdp_invalidate() avoids this, because it keeps the
entry huge but invalid.

But I guess not every arch does this properly somehow?

>
> Fixes: 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP during shrink_folio_list()")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Closes: https://lore.kernel.org/r/20261009165214.40212-2-kylebot@openai.com
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Zi Yan <ziy@nvidia.com>

With the commit message made a lot clearer and calling out the specific
locking scenarios that allow this + getting rid of the dead code:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
> The proposed fix[1] requires additional arch code fixes[2]. Disable it
> first for stable fix. The function will be re-enabled along with arch code
> fixes.
>
> Link: https://lore.kernel.org/all/20261009165214.40212-2-kylebot@openai.com/ [1]
> Link: https://lore.kernel.org/all/DM0II2QHWWS1.2RXEJXC8S0101@nvidia.com/ [2]
> ---
>  mm/rmap.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 805db93fe0428..1131b76bbbc28 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2275,17 +2275,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  		}
>
>  		if (!pvmw.pte) {
> -			if (folio_test_lazyfree(folio)) {
> -				if (unmap_huge_pmd_locked(vma, pvmw.address, pvmw.pmd, folio))

This is the only caller of unmap_huge_pmd_locked(), making that and
__discard_anon_folio_pmd_locked() dead code, shouldn't we remove all of it?

Otherwise we're leaving dead code around.


> -					goto walk_done;
> -				/*
> -				 * unmap_huge_pmd_locked has either already marked
> -				 * the folio as swap-backed or decided to retain it
> -				 * due to GUP or speculative references.
> -				 */
> -				goto walk_abort;
> -			}
> -
>  			if (flags & TTU_SPLIT_HUGE_PMD) {
>  				/*
>  				 * We temporarily have to drop the PTL and
>
> ---
> base-commit: 8b38ed9ab5b09c8ba168cbcc49524e9b380ee5c4
> change-id: 20261009-lazyfree-stable-fix-67712b2049dd
>
> Best regards,
> --
> Yan, Zi
>

--
Cheers, Lorenzo
