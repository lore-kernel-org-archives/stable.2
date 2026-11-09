Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237876;
	b=u5Al+mpiivGQNW6spT4wpzQK37IR39TDEnBgKKXVB3am/YNLaqGj6EIiQgvShSs88ePr
	 pNH7SV8HXP/ixalo7PaaZpQ+QVZxDp72SrGpMYR6oa2+jNFSaXBT0YWfzad0Roke0rIRZ
	 9pLX2PzJ6X7H2l147xb5xwpkqtrIvpN8omdHjBeL9JVuFrczCxmxc8wEeg6LMC1EFDrLN
	 bkmigH4sngwIYe6tb5ub92V3VT3loDbG9Phwb5+6DNTpsshEaU1rWqSqIzeLSrP2Sn3ba
	 zjXjlW9hv8PewgRF1Id4YQduT5yCqPWoe22CQziR2Y4C7yQ6H5OyXTzdIGl93x17PBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237876;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=05PSSj9KAFKOlOAqbcefgviQBOp2FmRn72Lc22GkBCE=;
	b=3RzC8ra6X73JlVKZWF3wPOLUBZHi8xA4o2waqOV5RvVdM0Zxe+dQaVyM/6Al5mbR5KOl
	 4NuLh5I3AJP8zeicN+7FLqcBpPy6NyIR7Vs6R7ETeBCScUBZKzZkuu9f1kLZwiawi6/4d
	 Zd5mtULK3yHCx87uBSSHV44GQ3uVKTZxtxAIv3GJIE7Ju8hVl8g02NGP07bGmSOh5Rthm
	 saTlBXyI9zE+WwcZtylsh5YRqMBIXWJb/FAEO2mFa4qOB/xXxYFhVPgFwga0Opp1zcxco
	 QwhDl+UM/xJrTdTAlPaSAcx1kJBXgnRWl8JJsBCqUboXdrOUGGY00koVCBaLlxicPkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dW2hIoim;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C7A606A321;
	Mon,  9 Nov 2026 15:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1C7A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dW2hIoim
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AFAE14BF;
	Mon,  9 Nov 2026 07:24:30 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 066483F632;
	Mon,  9 Nov 2026 07:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794237873; bh=5m0+4MkLWcNQHhoWxQ/fZjW/kH3KPYnBjU3kMCC73T0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dW2hIoimCnQ4aKC8wFf3cXyw0LwNNqLNkYtgmSRm+3yJohT9NFUKs1o/pkWDFnJRT
	 1wKRX/L73wDMpIEmpsF9AhxYzUsWJZITwwrPlodIg5trvqYhZD/NzK9X9gVmZ6nJSB
	 yOgP4lk2Y95HlkvimKrTvBU+9ZtrzIzSVdrIsDto=
Date: Mon, 9 Nov 2026 15:24:28 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rik van Riel <riel@surriel.com>,
	Yuan-Hao Hsu <aa9736195201@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/6] mm: khugepaged: ignore MADV_HUGEPAGE for shadow
 stacks
Message-ID: <avHlrEfKXDNtFJG4@e129823.arm.com>
References: <20261109-refactor_gup_fast-v3-0-2aaef02df0e1@arm.com>
 <20261109-refactor_gup_fast-v3-1-2aaef02df0e1@arm.com>
 <3a2d4135-f531-4797-8dd2-a2732a846e45@kernel.org>
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
In-Reply-To: <3a2d4135-f531-4797-8dd2-a2732a846e45@kernel.org>

> On 11/9/26 13:32, Yeoreum Yun wrote:
> > commit 3efb9800557b ("mm: do not map the shadow stack as THP") makes
> > shadow stack mappings default to VM_NOHUGEPAGE. However, userspace can
> > still clear this flag and set VM_HUGEPAGE through madvise().
> > 
> > Allowing large folios in x86 shadow stacks exposes a limitation in
> > folio_pte_batch_flags(). For example:
> > 
> >   1. create a shadow stack mapping.
> >   2. apply MADV_HUGEPAGE and populate the mapping with a PTE-mapped
> >      large folio.
> >   3. apply MADV_DONTFORK to the first base page of that folio.
> >   4. call fork().
> > 
> > In the parent, the first page remains writable and anonymous-exclusive,
> > while the remaining pages shared with the child become write-protected
> > and lose PageAnonExclusive(). These pages can still belong to the same
> > large folio.
> > 
> > On x86, writable shadow-stack PTEs have _PAGE_RW clear and _PAGE_DIRTY
> > set. Write-protected PTEs have both bits clear, with the dirty state
> > preserved in _PAGE_SAVED_DIRTY.
> > 
> > When FPB_RESPECT_WRITE is set without FPB_RESPECT_DIRTY,
> > folio_pte_batch_flags() normalizes PTEs using pte_mkclean(), which clears
> > both dirty bits. This loses the distinction between writable
> > shadow-stack PTEs and write-protected PTEs, allowing them to be grouped
> > into the same batch. GUP-fast can encounter such a batch when walking
> > across the VMA boundary created by MADV_DONTFORK.
> > 
> > Since there is no practical use-case shadow stack with large folio,
> > ignore MADV_HUGEPAGE for shadow stack mappings, preserving their
> > VM_NOHUGEPAGE setting and preventing large-folio allocation.
> > 
> > Fixes: 3efb9800557b ("mm: do not map the shadow stack as THP")
> > Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  mm/khugepaged.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 40fad28c52f6f..51ec043fa26c3 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -367,6 +367,9 @@ int hugepage_madvise(struct vm_area_struct *vma,
> >  {
> >  	switch (advice) {
> >  	case MADV_HUGEPAGE:
> > +		/* PTE batching doesn't work reliably. */
> > +		if (vma_test_single_mask(vma, VMA_SHADOW_STACK))
> > +			break;
> >  		*vm_flags &= ~VM_NOHUGEPAGE;
> >  		*vm_flags |= VM_HUGEPAGE;
> >  		break;
> > 
> 
> Ack, I prefer this solution for now until we know how to make pte_mkclean() on
> x86 shadow stack PTEs not result in an implicit pte_wrprotect().

Yeap. As we discussed in offline, just skip clearing dirty bit for
shstk in pte_mkclear() wouldn't work since it would make a another
regression -- wouldn't be page-outed.

Might it would be good to use another soft-bit for shstk in x86.
But, for now, it seems enough as you said.

> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks!

-- 
Sincerely,
Yeoreum Yun
