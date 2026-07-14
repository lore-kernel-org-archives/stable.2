Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BC147DD42;
	Tue, 14 Jul 2026 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040843; cv=none; b=O68b8LrSkT5SeQwrPXQPRdCT9oYZPma2kYmFcud6Dpm5qzOCVh5gAKk+d95s+bOrL5Y/eKMgLBiLg/Kh89/exeyDDkJCHPYgSKqaasX331B08CI4BC1ionHyHgh7YGtgakorGl7VipFLz0fOxJvuoSXIRGaJopeyoY9qk7hrI6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040843; c=relaxed/simple;
	bh=QSeOIvk99bu62pNbNhzg8VIxfvd3Ob8NHAu7pE1se7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEiwZw2t1m7Tn4cvodBHx8BodpsSHniqaf9ThyyAd/oqlv4aeHHrEWKrd9ayW+1KTVcnJgmfLAwyqSRuPUIb+f6ptVEXvPxMkuRGXwTn/HGBOuOtSqkxm4uUg+TAwnN3Yg+hYM/ID+gwOrj7BrzSTZnXzLswFgb5C6XQV4mtzro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=bmFdAdh3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GMK5LnZ5; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="bmFdAdh3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GMK5LnZ5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 70F6C7A01B9;
	Tue, 14 Jul 2026 10:53:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 14 Jul 2026 10:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1784040839; x=
	1784127239; bh=nQSEvv8Ji5wHP6dbtiBwKk1VRYsau1XbRKPN6tHYx1M=; b=b
	mFdAdh33VHTcyDSHWsQ+0WugAdbti5voM8qIo1v4SKhuvjcbuY0JS7hmbWOvdJt5
	mipTbRE00hjBgcp4d5JEKFzMoFsW2ui6IDOB6gyJEShqSHD5xaYOLLVoPpTu4g4j
	ZHNA6mhRRBd3Oj+pFJ2jZpNT2EGZuTACl1HtAWxqmAvPTw1cj4nRfWb7QOqJKpWR
	4mSkiD7vmWxKJ0F4rDqsNT1mC7gM058AsY2N1jPdyg5jsaZxlYhP79W3lkuqgoR2
	nvGhiBdV9URp2LAcjveRSL+QFHkI0Zu5w3KWchKg/P7QDdrZ70OC69QNJcBIMmZi
	4cPLf4DnBfnxcdtNLsBaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784040839; x=1784127239; bh=nQSEvv8Ji5wHP6dbtiBwKk1VRYsau1XbRKP
	N6tHYx1M=; b=GMK5LnZ5PB5+wdyHPH5lFt7IGLSOE4mO7Z7MKE5f73+3ZrRRPVg
	al8F+XlN0BkX0iq3FRSilAxFIfWj3OAK5jSaoN3YhYD3wPxxUWs9GzDafRfQKnOR
	P5f5yxZF0OHXgVw5KJgG8bqgnAVmi8qLBLaWHg++AH1cvkhOq+09v6NoYxdOMypJ
	PRYBHi8ufjxbFwrAMooq7ZV4Dg/byZELH5nfn1ehy2P9gxf85nFynBiMOVG048tm
	rTdZQersbXlP2Y4qAwMwQYhCvKBF29A6Fq+icMgk+IuHBDoasWT1QG7mNNBS/sYk
	3Ubdtm8w12kjtaE3wFE5g1w5sLdHr9ogoiQ==
X-ME-Sender: <xms:hU1Was4D8Wd7A92k3PC7rOU97Ezh9LAGCcrF9jTKJ_ZP4pnlirIQtQ>
    <xme:hU1WaqrcVo8grnXkhvCsL1uOY3LqfeeYtr1mIkyfAzP6T_quyNSuWRcaYJ9gMnxiq
    KGZcioOcLEZpYZTrNSywWLW74u34UgJoc9ldZAKkNmHD_-gxO06PpPK>
X-ME-Received: <xmr:hU1WarB6FrNL6bqxlPff_xDWf0bpIAd7uOJkbpyIPOqqKEC43C6mrNGWw-mD3g>
X-ME-Proxy-Cause: dmFkZTFCjKBpqF2AR4Iy8Xi7RXztKtZs1VxOjZg2Y6DrZbU2u5b7SdZVsP/MxxYB9D5lx1
    fWtzDUSp89q6mLHdfChL6kBpCrlZWf6Bfh78JGo1QdklPsgYxTkfCmYxxye1CPm3XWI6oz
    sNCHWxj1tj1Z6yEVxAsAa4vD4R1E7BIBEwVcCrpxJQLS1mS0xN7fU/y8oDI+qSJ4XMIZUm
    e0LNvdfjgEUA2+xUN8dyzEzlcNdzSyzPgHjrbWxM5RK9B2hRP0V7mUdZaWlgBxv+yVC/3d
    cVx1aAVbys5cwpIsZlhXlxXsH9GFH9MyXkDFrmP/wknqkilVJW+iCM59mwiZed7GL7QwWa
    C3f+b8bmPCfSXdocKU4qgut34NolPN6xHvt96lWk7GHH5qE7A98uIVCJ/yNpmofazFwPYD
    n9lAMLNmZ4ZnzebK4MsG3HVj9p65aLuI0iKc6afSGDa76C9etQL/cokjwU84UG7WHMKMQi
    jMsS1Cm1ZkSsazWZvOM1LGU72LblSJboOHtNTiQxqF8+C+hKFgbsUBcW2NZTXOI6zPiuQP
    LFF/IONyEKvE0RfTNRAWEvM3UMTlY7EOLh+PbHPSdGzSGN94zFTtiN2D0CT7WmVslCMX+w
    erfM3v7bLZrSMiHUNCLMh/cfhsRkyUNxNduKE7LecmGfOOTfcKKTVfLWcEnA
X-ME-Proxy: <xmx:hU1Wapy3cAA_4qdE78bB5v5a4S1mMdiKH9OCNKaM9r-FVJikk2dYYQ>
    <xmx:hU1Waka4LohTE7esP0gEnQGQ2zZvBazYQs_dSfv0zBI5s5Fgc7PuWw>
    <xmx:hU1Waiue1N6NzXFcBl95--LcWmzXjIcU48lvM_C2fyub25SUZldDKQ>
    <xmx:hU1Waqzo1_Ymy1N4lPc2Dp8RfiDiD85_0m0iOXI8UkIzYB5_0EaCHg>
    <xmx:h01WapBLMdTTgf53F79sETWJM8MfF9kl9w4ybfCDvjHmYFDZgdySp5QO>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 10:53:56 -0400 (EDT)
Date: Tue, 14 Jul 2026 15:53:55 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Hao Zhang <zhanghao1@kylinos.cn>, 
	Hao Zhang <hao_zhang_kdev@163.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm/memory-failure: keep the folio, not the
 poisoned subpage, locked across split
Message-ID: <alZNYYsybKZA0eJb@thinkstation>
References: <20260714122344.351895-1-kirill@shutemov.name>
 <20260714122344.351895-2-kirill@shutemov.name>
 <c4aa63df-30ab-464d-bd0b-48dc37c8e6ba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4aa63df-30ab-464d-bd0b-48dc37c8e6ba@kernel.org>

On Tue, Jul 14, 2026 at 03:01:46PM +0200, David Hildenbrand (Arm) wrote:
> On 7/14/26 14:23, Kiryl Shutsemau wrote:
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > 
> > try_to_split_thp_page() locked the poisoned page and passed it to
> > split_huge_page_to_order(), which returns that very page locked to the
> > caller.  For a tail page that means __folio_split() runs with @lock_at
> > pointing into the middle of the folio.
> > 
> > __folio_split() dereferences the mapping after the split completes
> > (shmem_uncharge(), i_mmap_unlock_read()).  The only thing keeping the
> > inode alive across that is the locked @lock_at folio: while it stays in
> > the page cache, eviction cannot complete.
> > 
> > But a tail @lock_at can lie beyond EOF -- e.g. part of a shmem THP that
> > reaches past i_size while the file is being truncated.  The split then
> > drops it from the page cache yet still returns it locked, so the pin is
> > gone and a racing final iput() can evict and RCU-free the inode while
> > __folio_split() is still running:
> > 
> >   BUG: KASAN: slab-use-after-free in __up_read+0x634/0x790
> >    i_mmap_unlock_read include/linux/fs.h:537 [inline]
> >    __folio_split+0x732/0x1640 mm/huge_memory.c:4100
> >    try_to_split_thp_page+0xab/0x390 mm/memory-failure.c:1675
> >    memory_failure+0x1394/0x26e0 mm/memory-failure.c:2470
> > 
> >   Freed by task 4601:
> >    shmem_free_in_core_inode+0x54/0xb0 mm/shmem.c:5177
> >    evict+0x57f/0xac0 fs/inode.c:870
> > 
> > Split the folio as a folio, via split_folio_to_order(), so the head is
> > the anchor left locked.  The head is piece 0, which the beyond-EOF drop
> > loop never removes (it starts at folio_next(folio)), so the split always
> > leaves it in the page cache and the inode stays pinned for the whole of
> > __folio_split().  memory_failure() and soft offline re-lock the poisoned
> > subpage's folio themselves after the split, so they do not depend on it
> > being returned locked.
> > 
> > Reported-by: Hao Zhang <zhanghao1@kylinos.cn>
> > Closes: https://lore.kernel.org/linux-mm/20260710071344.GA106129@zh-pc
> > Fixes: baa355fd3314 ("thp: file pages support for split_huge_page()")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > ---
> >  mm/memory-failure.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 51508a55c405..68d42cbed458 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1657,11 +1657,18 @@ static int identify_page_state(unsigned long pfn, struct page *p,
> >  static int try_to_split_thp_page(struct page *page, unsigned int new_order,
> >  		bool release)
> >  {
> > +	struct folio *folio = page_folio(page);
> >  	int ret;
> >  
> > -	lock_page(page);
> > -	ret = split_huge_page_to_order(page, new_order);
> > -	unlock_page(page);
> > +	/*
> > +	 * Lock and split at the head, not the poisoned subpage: __folio_split()
> > +	 * keeps the anchor folio locked and needs it to stay in the page cache
> > +	 * to pin the inode. A tail beyond EOF would be dropped yet returned
> > +	 * locked, losing that pin. The caller re-locks @page afterwards.
> > +	 */
> > +	folio_lock(folio);
> > +	ret = split_folio_to_order(folio, new_order);
> > +	folio_unlock(folio);
> 
> With a non-uniform split it would actually make a difference: we'd want to split
> such that we the other folio pages minimal.
> 
>  split_folio_to_order() always seems to end up in
> __split_huge_page_to_list_to_order() where we do a SPLIT_TYPE_UNIFORM.
> 
> I recall discussing with Zi and Willy that in the future we'd want to convert
> more places to do a non-uniform split.
> 
> So I'm afraid that would just re-introduce the problem then.

Right. Non-uniform split can be useful.

But my patch is completely broken because code expects the pin to be on the
@page, not on the head. put_page() few lines down can explode already.

So the fix does not belong in memory_failure(). It belongs in
__folio_split(), and it is really just 2/5: refuse the split with -EBUSY
when @lock_at is at or beyond the sampled EOF.

The safety then sits in __folio_split() regardless of caller or split type,
which should also cover your non-uniform worry.

The behavioural change is that memory_failure() reports a beyond-EOF
poisoned tail as unsplit (MF_FAILED) instead of recovered, and kills the
mappers instead of splitting the page off. What we give up is salvaging
the folio's healthy pages and the clean unmap -- both low value for a page
that is beyond EOF and getting truncated away. Containment is unaffected:
PageHWPoison is set before the split and free_pages_prepare() keeps a
poisoned page out of the buddy allocator, so the bad page never comes back
regardless.

The alternative, if we would rather keep the recovered outcome, is to leave
@lock_at as the poisoned page and move i_mmap_unlock_read() (and
shmem_uncharge()) ahead of the after-split unlock loop, so every mapping
dereference happens while @folio -- the head, within EOF -- still pins the
inode. That is close to Hao's original patch. It works, but it rests on "no
mapping dereference after the unlock loop", which is its own fragility.

I lean towards the -EBUSY guard.

Comments?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
