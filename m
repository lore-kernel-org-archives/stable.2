Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85533FE644;
	Thu,  6 Aug 2026 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007643; cv=none; b=aZKViIcxB8NgTkSpm9bh356p4PZrkQhIELhMS7JvpylgrH3JXFpLnKTMVm33YbRuVtq9yyX3/TLjEdwY4Gtdvm8dDyO9V9XkMt4PS9gI5NTpmZr28RV4Y6fwKqiDfxZKUyDH/N6iNPi61HzKUDAONBloSTHuIzZIPUo6CdIG+ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007643; c=relaxed/simple;
	bh=Db5J2hXeGzziUGBmrzt1Yskw9fUJx9AQMW8Yt81mv4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyjPY1+a949+wHK9GaLc0Qx673mwwt5Ardc2CS2dkbRgzS6AMdb6Q9KHUeKgQNfV+aPvv9/7797yzcYll0yc+4/dOZnduTll1L57deyyKxKR+6i6tHZAkuWRCiCaksRWUpRfillbluj4WSaSepJDcrkCkmotqTCFwm9V08oaP8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahR/JYAq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahR/JYAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536751F000E9;
	Thu,  6 Aug 2026 09:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786007642;
	bh=gbQN0P9juxp84awMvUOVeJt+czRmTpTGzHczqTVhmjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ahR/JYAqTsxKULko6tkqNQ2E6tQsxzilFd5mbjlkZ9bCe9jMcvJQBbCax+ukFjdiS
	 FHVNUg/BJYrZ1+athIOIJmRHfasgwhnA08NCjXSHnmeaDeHNfD5KqGgxTQTgcUVpUm
	 AcTVDSwbd7caomvwKfFNoLVCX9bodE0PhtB7ntzEKKsmxShK56Tj0ztIW8HyK5Jvsc
	 b0K/4HSRiW4Z90lQ72x4tVgP3IYh3+OhYmNhjkMMLqyyX8dTw1Wev1zlP6LbLnk0vS
	 t323NiEnfZaa6k0UyLGirhUSeGkRHSNderfEJ0Ye/k3hdThIUIt6FFaV7MvG4P6c4f
	 Vsb7fwccSjcdg==
Date: Thu, 6 Aug 2026 10:13:45 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org, 
	liam@infradead.org, vbabka@kernel.org, jannh@google.com, 
	00moses.alexander00@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/madvise: avoid skipping pages after splitting
 large folios
Message-ID: <anRPzJiraQUnsHa5@lucifer>
References: <20260806055501.56761-1-cuiyunhui@bytedance.com>
 <699fc1b0-7af8-42ac-9882-c01225379586@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <699fc1b0-7af8-42ac-9882-c01225379586@kernel.org>

On Thu, Aug 06, 2026 at 10:41:06AM +0200, David Hildenbrand (Arm) wrote:
> On 8/6/26 07:55, Yunhui Cui wrote:
> > madvise_inject_error() advances through the requested range using the
> > size of the page returned by get_user_pages_fast(). Saving the size
> > before error injection is required for hugetlb pages because successful
> > soft offlining can dissolve the source huge page.
> >
> > That stride is incorrect for non-hugetlb large folios in system memory.
> > The memory failure handlers split such a folio and handle only the base
> > page for the supplied PFN. Advancing by the pre-split folio size then
> > skips the remaining pages in the requested range while madvise() still
> > reports success.
> >
> > Advance by PAGE_SIZE for non-hugetlb folios in system memory. Retain
> > folio_size() for hugetlb and ZONE_DEVICE folios, as compound Device DAX
> > folios are handled as a whole.
> >
> > Fixes: 19bfbe22f59a ("mm, hugetlb, soft_offline: save compound page order before page migration")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  mm/madvise.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 5a09cc24f04a0..e9d4c3bbc5290 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1455,20 +1455,25 @@ static int madvise_inject_error(struct madvise_behavior *madv_behavior)
> >
> >  	for (; start < end; start += size) {
> >  		unsigned long pfn;
> > +		struct folio *folio;
> >  		struct page *page;
> >  		int ret;
> >
> >  		ret = get_user_pages_fast(start, 1, 0, &page);
> >  		if (ret != 1)
> >  			return ret;
> > +		folio = page_folio(page);
> >  		pfn = page_to_pfn(page);
> >
> >  		/*
> > -		 * When soft offlining hugepages, after migrating the page
> > -		 * we dissolve it, therefore in the second loop "page" will
> > -		 * no longer be a compound page.
> > +		 * Non-hugetlb large folios in system memory are split and only
> > +		 * the addressed base page is handled. Hugetlb folios may be
> > +		 * dissolved and ZONE_DEVICE folios may be handled as a whole,
> > +		 * so save their size before error injection.
> >  		 */
> > -		size = page_size(compound_head(page));
> > +		size = PAGE_SIZE;
> > +		if (folio_test_hugetlb(folio) || folio_is_zone_device(folio))
> > +			size = folio_size(folio);
>
>
> We should never ever try deferring "how much has been mapped" from a single PTE.

Inferring? :)

>
> While this currently works for hugetlb, it's just an anti-pattern to throw
> hugetlb checks and similar around.
>
> So this is not the way to fix it.

All of this code is disgusting. Also what about an address range that is
partially inside a folio...? Then presumably the whole folio is discarded? Or
does it figure it out somehow and does the split for the rest of the range?

And what if end < the end of the hugetlb size?

Ugh god I hate all of this, it's so so bad. And hugetlb being the special
snowflake is the cherry on the s*** cake...

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
