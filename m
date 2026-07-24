Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9667A416870;
	Fri, 24 Jul 2026 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896365; cv=none; b=YluUmZRcHnjOVvHOGjwHsaWo0CBXv1J8zmQZq269agr3gIzzxNaJe5ptEdeCCpXYJ4x7iuQL8MoFpYPpmqajU5pZODe4Jmf6KoUyNX2h9MCHJUQfHXiV2wt/LZmuN/Gb/4okz4zYsPYwbeLW14ggyoPDaVUHlnOA1SBZrZ7TQzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896365; c=relaxed/simple;
	bh=Ome03uAATeysnN9JhWzK7LS0/XgSpqpHi7sXIujF+HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/wkF7Q0jWFnQoPbg92O6Ke4kZALPQffDCCP1ZWCn+sdZSkXqi3SqA8OOq1cR4ByXqhasP6UEOQXuFJGdizibwxfz0eT7TucUrpE7Xik78Og57KclmnHtXKeoL/X9IkIFA6c0U1C/sMUkQFA7FXFs5Dk398dznUWPjW0TsMsG9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wWDleT+K; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wWDleT+K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ffuOTgmZJuwKmEXpuYSL7eRuSEjsYAbCNuPmD0+STOY=; b=wWDleT+K/GwFH9pZ9+ycsN9MoM
	hdIMW5V17AcWQUCV6JOzItWaoC+NzT0f/mk3ke7RGQjNJgPRnNexQGChIATLo0N9Dw8rlLJue1IfL
	qSE8+9cAdYJ8r6JxRIY1MduEZ7/U68vzPpI+mXSTzOeTjmsCyib/9mVPnb/TQOstziKPGf8evIDLY
	dTOKKN8Tb5XgFki0a23U87ZBKVAXIUAV7XnRTxgIyFbeu5emqjfCuFUM7BrvtbKdTL/RxfPWFYOwe
	1/d6aYRNq169GZfcJWgjTVO3QN2njOmMwq4baBIAF948dkpz/JDFrWi5XYQUiky+xvEu4TGSgMcrm
	aFT61TYw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnF4h-00000003SWX-0gG5;
	Fri, 24 Jul 2026 12:32:23 +0000
Date: Fri, 24 Jul 2026 13:32:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>, stable@vger.kernel.org,
	Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [PATCH v4 01/14] memory-failure: Fix hardware poison check in
 unpoison_memory() again
Message-ID: <amNbVpvrxRBbuGoi@casper.infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723143034.175661-2-willy@infradead.org>

Sashiko feedback:
> --- Patch [1]: [PATCH v4 01/14] memory-failure: Fix hardware poison check in unpoison_memory() again ---
> commit 5a43cce770d0c716bb5c78ee2c21e1cb711e5331
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> memory-failure: Fix hardware poison check in unpoison_memory() again
> 
> This commit addresses a bug in unpoison_memory() for hugetlb folios. It uses
> is_page_hwpoison() instead of checking the head page, and correctly targets
> the precise page for clearing the HWPoison flag.
> 
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 51508a55c4055..944e6e1d49719 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -2695,8 +2695,8 @@ int unpoison_memory(unsigned long pfn)
> >  		goto unlock_mutex;
> >  	}
> >  
> > -	if (!PageHWPoison(p)) {
> > -		unpoison_pr_info("%#lx: page was already unpoisoned\n",
> > +	if (!is_page_hwpoison(p)) {
> > +		unpoison_pr_info("%#lx: page is not poisoned\n",
> >  				 pfn, &unpoison_rs);
> >  		goto unlock_mutex;
> >  	}
> 
> This isn't a bug introduced by this patch, but can the speculative folio
> access without stabilization cause a use-after-free and reference leak?
> 
> Looking at unpoison_memory(), if the PFN belongs to a THP tail page and
> the THP is concurrently split, could the folio pointer refer to a stale
> head page?
> 
> unpoison_memory() {
>         ...
>         folio = page_folio(p);
>         ...
>         ghp = get_hwpoison_page(p, MF_UNPOISON);
>         ...
>         folio_put(folio);
> }
> 
> Since get_hwpoison_page() takes a reference on the new order-0 page, does
> calling folio_put() on the stale head page drop the wrong reference and leak
> the reference on the order-0 page?

Uh.  I don't know.  If it does, I didn't make this problem _worse_,
so I'm not going to address it.

> This is a pre-existing issue, but does unpoison_memory() clear the
> PG_hwpoison flag on the wrong page for unsplit THPs?
> 
> For THP tail pages, if get_hwpoison_page() returns 0 because their
> _refcount is 0, does the code fall into the !ghp branch and call
> folio_test_clear_hwpoison(folio)?
> 
> Because PF_HEAD redirects to the head page, this clears the flag on the
> head page. Since THPs set PG_hwpoison on the exact corrupted tail page
> (PF_ANY), does the tail page remain poisoned and fail to restore?

Hm.  Maybe?  This code probably needs to be more careful in general.

> [ ... ]
> 
> > @@ -2748,6 +2748,7 @@ int unpoison_memory(unsigned long pfn)
> >  				folio_put(folio);
> >  				goto unlock_mutex;
> >  			}
> > +			p = &folio->page;
> >  		}
> >  
> >  		folio_put(folio);
> 
> This is a pre-existing issue, but does unpoison_memory() fail to clear
> the per-folio PG_has_hwpoisoned flag when unpoisoning THPs?
> 
> When successfully unpoisoning a THP head page (where get_hwpoison_page
> succeeds), TestClearPageHWPoison() clears the per-page PG_hwpoison flag.
> 
> However, since the per-folio fast-indicator PG_has_hwpoisoned is never
> cleared, will folio_contain_hwpoisoned_page() continue to return true,
> causing the kernel to erroneously treat the unpoisoned THP as poisoned in
> future operations?

Yes, it does fail to clear the has_hwpoisoned flag.  We can have more
than one HWPoison page in a folio, so we either have to leave it set,
or scan all pages in the folio to know that it's safe to clear.

Again, I'm not making this worse for THP in this series, so I'm
not addressing it.  For hugetlb pages, later on I change to use the
has_hwpoisoned flag, and that does get cleared because there's no scan
of page bits involved, just a list of poisoned pages, and it's easy to
check when that's empty.

It's mostly moot because we always try to split large folios that aren't
THP, and that usually succeeds.  So all the large folio has_hwpoisoned
paths are very undertested.
