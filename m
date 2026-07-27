Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78A93264DA;
	Mon, 27 Jul 2026 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163456; cv=none; b=ZXKGoTHvT4+KVH5+g8ey25kHEZPeeOS8OVjiaoVhowcxROnSMmxS1f42sh7rDlJwarpUFc4xq/qena3ImRkTSKqWkOs5peb2Ev4am0rfRKVSQ0WAftbJY4Xb2N5Xyi3SwP/mWTPjcMleGE3pFSb8qKj24xbbPa6Nlak0VWnmHIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163456; c=relaxed/simple;
	bh=CjhSFY3xBt6q/T0ZQwWij8vz59WBw7J38gbvRPqFtac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkjRRXuAyG2a0/D+XAd6bcMGoMiFJVzc5WMKHWb/f/V6TpHDtRklb6EA2upuZ0DiaBVYrG2Qb1S7TQEkLugRhW5uBdNIKIDYTITof937cNBH9Ewb5alA0MpYOGZvTF9tnAxbGEDXNK0nGrhE3V/+39Ije8W8pD29o8iJwtROwFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FzSS4rVN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FzSS4rVN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/qlnN76+tF13o25mQrF2tByNLJl9jVDI3UupoYwfeo8=; b=FzSS4rVNlmr2vAmNPfcByvvRVm
	muTlKZJB75MZFWDauFFbHpKxidXffT1sKlfKz8rKlrdtgWFJWlHLVN7jKkJT5trsA9spB62OyXr+o
	vzS1ITss3JwL7f04WZ8KhvlO1pYqxJ88MnPFnPC3n0wZQdK9tBUSAHY128m92RQ6g99YYI8UoOUbr
	lBxtt2hfFJO4tS3O2XVllmCDs6vWz6AZ9eNXcqw8BOaIUZm6AVhwkb58EH3i8+19A/XCiJvFLpTU0
	zpymd//i1OPXyZAp1KS6a/su4PpSdMOtrLGgcidm7Rgh/UBQu+MhuD+yTNaeQ5y6/fl2XQ+pxQxEg
	278UE33Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woMYb-0000000AsJm-1HZL;
	Mon, 27 Jul 2026 14:43:53 +0000
Date: Mon, 27 Jul 2026 15:43:53 +0100
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
Subject: Re: [PATCH v5 01/12] memory-failure: Fix hardware poison check in
 unpoison_memory() again
Message-ID: <amduqWdnxeYwToax@casper.infradead.org>
References: <20260725160042.1557264-1-willy@infradead.org>
 <20260725160042.1557264-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725160042.1557264-2-willy@infradead.org>

Sashiko:
> --- Patch [1]: [PATCH v5 01/12] memory-failure: Fix hardware poison check in unpoison_memory() again ---
> commit 4beed8e27f2afa68261389ac2133cfe324d37d0e
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> memory-failure: Fix hardware poison check in unpoison_memory() again
> 
> This commit modifies unpoison_memory() to use is_page_hwpoison() to better
> support hugetlb folios and ensures the HWPoison flag is cleared on the correct
> head page.
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
> 
> Can this speculative evaluation of is_page_hwpoison() trigger a panic?
> 
> Since this is evaluated without a reference on the page, the underlying
> page could be concurrently freed and reallocated as a tail page.
> Looking at is_page_hwpoison() in include/linux/page-flags.h, it calls
> folio_test_hugetlb(folio), which uses const_folio_flags(). That function

No it doesn't.  folio_test_hugetlb() is one of th FOLIO_TYPE_OPS which is
defined as return data_race(folio->page.page_type >> 24) == PGTY_##lname;
and no asserts.  I mean, there probably should be!  But this is irrelevant;
this whole function contains many such folio tests and the same problem
applies to all of them.  This patch doesn't make it worse.

> enforces a strict assertion:
> 
> VM_BUG_ON_PGFLAGS(PageTail(&folio->page))
> 
> If the page is concurrently reallocated as a tail page while
> is_page_hwpoison() executes, won't this crash the kernel on debug builds?
> 
> >  				 pfn, &unpoison_rs);
> >  		goto unlock_mutex;
> >  	}
> 
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
> This isn't a bug introduced by this patch, but does this lead to a
> double folio_put() and use-after-free for hugetlb folios?
> 
> If memory_failure() handles an in-use hugetlb folio, me_huge_page()
> might fail to dissolve it, meaning no extra poison reference is taken
> but the folio remains marked as hwpoisoned. If the folio is later
> unmapped and holds a single transient reference, unpoison_memory()
> will acquire a reference (ghp = 1) and perform the folio_put(folio)
> seen just below this reassignment.

I'm not an expert in the memory-poison field, but this also seems wrong.
Don't all hugetlb folios have a folio_mapping()?  And thus we'll never
take the dissolve path in me_huge_page().

At any rate, it says "not introduced by this patch", so I'm not going
to take any action.

> By reassigning p = &folio->page here, the subsequent call to
> TestClearPageHWPoison(p) will be tested on the head page and return
> true, triggering a second unconditional folio_put(folio). Does this
> underflow the transient pin and cause a use-after-free?
> 
> 
> This is a pre-existing issue, but does this same logic underflow the
> refcount for THP folios that previously failed to split?
> 
> If memory_failure() handles a THP and try_to_split_thp_page() fails, it
> explicitly drops the reference acquired via get_hwpoison_page(p), leaving
> the THP with no extra poison pin. However, TestSetPageHWPoison(p) was
> already called.
> 
> If the THP later reaches a state with a single transient reference
> and no mappings, unpoison_memory() acquires a reference (ghp = 1),
> calls folio_put(folio) once, and then TestClearPageHWPoison(p) clears
> the flag and returns true. This triggers the second folio_put(folio),
> dropping a non-existent poison pin.

I don't know, and I'm losing patience with the Sashiko rabbit holes.
This is all getting very far afield from the problem I actually want
to fix.
