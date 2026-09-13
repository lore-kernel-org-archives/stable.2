Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39ED37DAD5;
	Sun, 13 Sep 2026 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325333; cv=none; b=WA5+pwjRIX2B+BhPs63of++TeOv7yMaSLPuB+TZf+DU87HdixaVdca4fD0eU9Uc+EYfnv1ohMdHLM3oRunKLxYPyoPKNNBSWhA3rlnrACQw6JwAKNx8I7PArsc28AhjkqR723Cf2hFst6HBj6EIqbBXVulqVAW4maD9hwyi1bz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325333; c=relaxed/simple;
	bh=YpHQsc2Iy2Bk0FTSZfSYiNgSZKWCUQ3aj1Ad5T/x6Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGJR7a2FT23XtmmL/idjCtMvVcpOLVQXODkfpoIFNCrtc4hbwwGqzIN5Z0ZVC77QQM671Df+pcMFccwEzcx5mnmlOQw3OvPt8rMsL3+74+sn4ISrbCnSoGpeFAziNMQmgtXKuNC+99Dn24Qol9uz385HfCYzzQbBt04KEVnyphw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItY4COLM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItY4COLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79701F000FF;
	Sun, 13 Sep 2026 18:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789325331;
	bh=jb/hhwiK/UcdPAYGlSzJUb1U4vkmWKdi+D5nmTCyiwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ItY4COLMkAOPfq5upFo8+NRTEgTDJTWe71lMpMoYvx0ForD2G2ynjMLUv2Mnqq/Jo
	 C6CeqeBAIXxivARXiF0/4f1ecs//FHJoa5wN0EJkQq+rGGS9/FtWk79Jh/I5fzCZqr
	 hwZMMnyXadBtXtpmEgWarpdPi/AIA3J8c2CWRh5gPKngo4zKqcGydp/CKNne6/zAAA
	 xhozv6PlZTBw0YRIbYlFzREHen/VOfCFQhbe5rxQ9EHEZqVlV/OGyByRAIrjc6ugl4
	 2+ME+jKjjsts8211xwWo0ZHPTCfQl7vVJN1Ht8x9Tq0kbu4rKkT8V0GtXuT6+HfY08
	 SX9dpAjXFMf0g==
Date: Sun, 13 Sep 2026 19:48:44 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] khugepaged: hold invalidate_lock across
 collapse_file() readahead
Message-ID: <aqbvFtlXd3Jdnfbm@gremlin>
References: <DLEBZ0GIGNQ8.17U563YYJ37AA@nvidia.com>
 <20260913163644.122133-1-ngocthang2710.1999@gmail.com>
 <20260913111700.6de78b5834842f7dd3f12d07@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913111700.6de78b5834842f7dd3f12d07@linux-foundation.org>

(Nguyen - do not send v2 in reply to v1, look across mm and see how things are
done here).

somebody who has a

On Sun, Sep 13, 2026 at 11:17:00AM -0700, Andrew Morton wrote:
> On Sun, 13 Sep 2026 23:36:44 +0700 Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com> wrote:
>
> > collapse_file() calls page_cache_sync_readahead() to fault in missing
> > pages before collapsing them into a THP. That helper takes
> > mapping->invalidate_lock itself for the duration of the call, then
> > drops it -- but truncate (e.g. ext4_setattr() -> truncate_pagecache())
> > takes invalidate_lock and then waits on each page's folio lock while
> > holding it. If collapse_file() has already locked one of those folios
> > by the time truncate reaches it, and then tries to acquire
> > invalidate_lock again (e.g. on the first readahead call, since
> > invalidate_lock is not yet held at that point), the two paths can
> > deadlock/hang on each other's lock: truncate blocked on the folio lock
> > collapse holds, and collapse blocked waiting for invalidate_lock that
> > truncate holds.
> >
> > Reproducing this over ~150,000 collapse iterations with truncate
> > racing concurrently reliably hits hung_task: blocked tasks within
> > about 20 seconds on an unpatched kernel.
> >
> > Fix it by taking invalidate_lock_shared once for the whole scan, after
> > alloc_charge_folio() succeeds and before locking any folio, and using
> > page_cache_ra_unbounded() directly in the readahead call site instead
> > of page_cache_sync_readahead(), since the latter would try to retake
> > the lock we already hold. page_cache_ra_unbounded() does not clamp to
> > EOF like the helper it replaces, so clamp the requested range
> > explicitly.
> >
> > 730633f0b7f9 added invalidate_lock acquisition around readahead but
> > missed collapse_file(), which already locks pages while calling
> > readahead; later filesystem conversions made the deadlock reachable by
> > taking invalidate_lock before waiting on page locks during truncate.
> >
> > Reported-by: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=16bf7cd0ebeb1de93aa5
> > Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
>
> (You forgot to cc the original author)

Also a change log, and that mm doesn't like sending a respin in-reply-to a
previous version. Which is all consistent with somebody using e.g. openclaw to
pepper generated patches across the kernel...

>
> Five years.
>
> I wonder why this hasn't been discovered by lockdep, AI, syzbot or any
> other of the tools we've been using for so long.
>
> Thanks for doing all this.

See https://lore.kernel.org/linux-mm/aqbtfms0_2ULBIT7@gremlin/

I am not really entirely happy with somebody who has sent a flurry of patches
across disparate subsystems with no previous track record being in charge of a
potentially backported fix.

It's David's decision but I think this fix should be taken over by somebody
else.

See https://lore.kernel.org/all/?q=f%3ANguyen+Ngoc+Thang

>
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -2257,6 +2257,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
> >  	enum scan_result result = SCAN_SUCCEED;
> >  	int nr_none = 0;
> >  	bool is_shmem = shmem_file(file);
> > +	bool need_unlock = false;
> >
> >  	/*
> >  	 * MADV_COLLAPSE ignores shmem huge config, so do not check shmem
> > @@ -2271,6 +2272,15 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
> >  	if (result != SCAN_SUCCEED)
> >  		goto out;
> >
> > +	/*
> > +	 * Take invalidate_lock before any folio lock: the readahead below
> > +	 * needs it, and truncate holds it while waiting on folio locks.
> > +	 */
> > +	if (!is_shmem) {
>
> Is the shmem special-case a red flag?
>
> Probably this fix an acceptable minimal-thing-for-backporting.
>
> Question for maintainers as well as for yourself: but does this
> indicate a need for a more architected redo?
>

--
Cheers, Lorenzo
