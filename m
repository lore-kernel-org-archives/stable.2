Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3171303C87;
	Wed, 29 Jul 2026 01:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785289425; cv=none; b=iUva9GlFK13ElTmhu/9u9LoahpoWt7nbWhq+wpA7gCOecSqkKun70MLRux9Klj5BfRCzmHtxOmtExoEdsiLxLC1Qa7GXELWjofVHKbtV2XsOTKWBGpmNx/PWUe8KwD97xaCbkfjghsPf3/1XnQCeHXGAxXcziBQ+wJjN9/LiEao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785289425; c=relaxed/simple;
	bh=QK9nR0QSz9VWbmNc5Qc2oIjlCqBbMYtD+FtNZdi+diY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxcRPIP3gMsKgwrbuqovklcDEKExprNj/RmGlnU7mQt9aflWk3Uhp2sh0iPgSQAKoiEfxDhoPOUdtm6F4c6gV4Ua4piRSfV411tqmFcW2YfnfkUnn/86LTDjPoYZISZXp0qVW56Yi0iF5e7fxwbuqzsT6H9JgANGkhR+2bO7qSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UztfcEwy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UztfcEwy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tQe3rducnc/hAq/daIrVP62zjCCXI1gzLpDOiqHGhmw=; b=UztfcEwyLXvFJYGKiI0fBUhlUz
	Zehf6jCxV2aHeB3/kb/wK2M3s0cM22Pp6GAkn9UyivROwOpdBcMJmGWy3KqqGMCt1KjY43k0Z+fpB
	wKty6uOXF+ObZBIzi4vuuJ8n1bjVP9NhmZw8kZjW6SLpAYnlA5XQE0Saiaonqz+z8H3ZAFUYTmxOp
	16rN9olJdVlhIiyemH+UIyjkxk9BLKmrfyaZFtRRjSyU2xPRLVfIvKkS0Oopvr5n3WBLSW/hks46u
	mm9VB5evniPrOD+M81SIJwM6mJY7AX6ST0R44yGgRsM/RmOzJOYEHO8dVDL8GtMoDiY2rWOYO6+Qc
	MUcSg/Nw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wotKR-0000000Erx8-2KYz;
	Wed, 29 Jul 2026 01:43:27 +0000
Date: Wed, 29 Jul 2026 02:43:27 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gourry@gourry.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v7 01/13] memory-failure: Fix hardware poison check in
 unpoison_memory() again
Message-ID: <amlav1zfVy-9fLw5@casper.infradead.org>
References: <20260728204409.3396238-1-willy@infradead.org>
 <20260728204409.3396238-2-willy@infradead.org>
 <amlKHkemYQBxFESG@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amlKHkemYQBxFESG@gourry-fedora-PF4VCD3F>

On Tue, Jul 28, 2026 at 08:39:29PM -0400, Gregory Price wrote:
> On Tue, Jul 28, 2026 at 09:43:53PM +0100, Matthew Wilcox (Oracle) wrote:
> > The earlier patch (6c54312f9689) that attempted to fix unpoison_memory()
> > was incorrect for hugetlb folios.  Before a6fddef49eef, we checked
> > the head page for poison (which was correct for hugetlb and incorrect
> > for THP).  We are currently incapable of unpoisoning pages (other than
> > the first page) in a hugetlb folio.
> > 
> > Use is_page_hwpoison() which handles hugetlb pages sufficiently well for
> > this purpose.  This is racy as we don't have a reference on the folio at
> > this point, but fixing that properly requires deeper surgery and this
> > is a CAP_SYS_ADMIN path only so this will do for the moment and can be
> > easily backported.  It's no worse than the situation before a6fddef49eef.
> > 
> > The other bug in a6fddef49eef is that we currently clear the HWPoison
> > flag on the precise page, which is wrong for hugetlb.  Fix that too.
> > 
> > Fixes: a6fddef49eef ("mm/memory-failure: convert unpoison_memory() to folios")
> > Cc: stable@vger.kernel.org
> > Cc: Miaohe Lin <linmiaohe@huawei.com>
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Just trying to wrap my head around the state before/after, assuming
> the following is correct then LGTM:
> 
> prior:
>    pfn_to_online_page(pfn) -> p = precise page
>    PageHWPoison(page)      -> checks precise page. Poison for hugetlb
>                               is only set only on the head, so bug.
> after:
>    is_page_hwpoison(page)  -> checks precise page AND head (if hugetlb)
>    p = folio->page         -> now TestClearPageHWPoison() explicitly
>                               clears the head page poison if hugetlb

Exactly.  That was how it worked before a6fddef49eef; it used to do
p = compound_head(p) (which wasn't great _either_ but had different
problems ...)

The careful reader will observe that injecting two memory failures
into the same hugetlb causes ... problems.  That's true before and after
this patch, so it's no longer a regression.

> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> 
