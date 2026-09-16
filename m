Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F474FB9B5;
	Wed, 16 Sep 2026 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567980; cv=none; b=vB/ybv5sgmwNqcH3rJ5ccZHQIL3KwVfpskjqAjglEECI+Q8JpZDwS0UxpEl/+AdRm4FrObT6wxs38nyHYH9BDMg8wtq+pByXNp5UiunxaVzlFF5wY2ADuzhdLskgjYh+wMS3LEl70yM/UJSDuskGlm2bQmdcH6JUt64uzx0I3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567980; c=relaxed/simple;
	bh=j6zqZiIjusb3tFMWaxthaEG81AzOZdJTSF4ZVYTQVUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnLCLjAZ1vG3XoSiTdpNPPLDp0IKp30LJM3dg7WO5FvN8/6285umPqZ9gGaUOGe8ortOJvu/92jTje/2MxMPcBwC/x8jEDtPQI8NNSJCVfuUgk70xUsJ2OEc2wctUdbuEddSSCyw87S7qLxQGZEBA2ivYCugs/I0JiL7tbgeMzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNbqf9U+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNbqf9U+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222021F000FF;
	Wed, 16 Sep 2026 14:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789567979;
	bh=V9BvKqoMA2UwcJ0p6bue8Tv/N7Zz0zZu76H109sCcw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BNbqf9U+xd8eNMek3w+m7W2aF6pGr2mM9pbehi4DYkeN5VFbz4RQIYK8fUqx2s2sE
	 G9twMG102Bf+0PhP/gvNWqXQ0aumAMk0RA3b4IPVBZhpVgpJdAWis5SDpuHjKq9gt3
	 4OR9r793/aLxM5Fkixycul6E3yfKLZ1Iq9hVvBX+ejNZklHC4GfyXT3Gdv1G5JtCa2
	 oHZcSzM2RxqDxKSGhX1hSWGhQt2oPBqoiS87ylpDSOOkj5qSu56zo5eK+j88BdWWzv
	 fKN3+qtZ9bpaE/ruSk1gKdvfHlLSmO7GzLw67qHtoioFaqVkE7uLExXCEld0Bp8xFD
	 6hd1xpAE9km1w==
Date: Wed, 16 Sep 2026 15:12:53 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, liam@infradead.org, david@kernel.org, vbabka@kernel.org, 
	jannh@google.com, wangjiexun@tinylab.org, sashiko-bot <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: reclaim isolated folios if PTE restart fails
Message-ID: <aqqjW5dpyznijYLh@gremlin>
References: <20260912110832.3203902-1-gourry@gourry.net>
 <aqloB0zm3RjJ47m1@gremlin>
 <aql65IhMobL5Al9B@gourry-fedora-PF4VCD3F>
 <aqqTbGMJL86TzDrf@gremlin>
 <aqqbB_nFAOGenDhy@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqqbB_nFAOGenDhy@gourry-fedora-PF4VCD3F>

On Wed, Sep 16, 2026 at 09:57:44AM -0400, Gregory Price wrote:
> On Wed, Sep 16, 2026 at 02:03:29PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Sep 15, 2026 at 01:12:03PM -0400, Gregory Price wrote:
> > > On Tue, Sep 15, 2026 at 04:55:47PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > > On Sat, Sep 12, 2026 at 07:08:32AM -0400, Gregory Price wrote:
> > > > > MADV_PAGEOUT collects isolated folios on a local list before reclaiming
> > > > > them after the PTE walk.  The reschedule path drops the PTE lock and then
> > > > > restarts the mapping with pte_offset_map_lock().
> > > >
> > > > Is this reschedule path even necessary? It's pretty bloody sketchy.
> > > >
> > > > I thought the modern approach (TM) was to not do cond_resched() and friends so
> > > > can we actually look at removing this?
> > > >
> > >
> > > Sorry - meant to reply to this.
> > >
> > > Honestly there's so much jammed into this function i can't give you a
> > > straight answer. I can take a short detour to figure out if we can
> > > rework this as a whole.
> >
> > s/short detour/long journey through hell/ perhaps? :P ;)
> >
>
> Not as much as you'd think.
>
> I did it yesterday and left an agent to validate it overnight with
> existing in-tree tests, LTP tests, and added some new tests.
>
> The naming could use some work (cold_or_pageout -> lru_op, bleh),
> but new call graph / pseudo-code:
>
> • walk_page_range_vma()
>   └── madvise_lru_op_pmd()              [PMD callback]
>       │
>       ├── PMD is a huge mapping
>       │   └── madvise_lru_op_huge_pmd()
>       │       ├── acquire PMD lock
>       │       ├── madvise_lru_op_huge_pmd_locked()
>       │       │   ├── process whole folio, or
>       │       │   └── return locked+referenced split candidate
>       │       ├── release PMD lock
>       │       └── split folio / reclaim isolated folios
>       │
>       └── PMD points to a PTE table
>           └── madvise_lru_op_ptes()
>               ├── map PTE table and acquire PTL
>               ├── madvise_lru_op_pte_range_locked()
>               │   └── madvise_lru_op_pte_batch_locked()
>               │       ├── process one folio/PTE batch, or
>               │       └── return locked+referenced split candidate
>               ├── leave lazy-MMU mode
>               ├── unmap PTE table and release PTL
>               ├── split candidate if necessary
>               ├── reclaim isolated folios
>               └── reschedule and restart from current address if necessary
>
> Looks like a normal table walk now.  Significantly easier to review and
> doesn't make my eyes vomit. (there's still an ifdef wart, but it's not
> mid-function anymore... so that's nice).

OK nice, I will have to see the code to comment intelligently though I
think :)

>
> Going to spend a little more time testing and tweaking before I post it.
>
> I've been working on a making more extensive unit tests for certain
> parts of mm/ and this might be a good time to look at whether I can
> introduce a piece of it.

Nice, curious as to how?

Have you tried the userland VMA tests btw? Not tooting my own horn so to
speak :P but it's nice, though it comes at a bit of a cost in how the files
have to be set up...

I always feel like I should do more with it but don't have the time
atm. May set the LLM on it though...

>
> ~Gregory

--
Cheers, Lorenzo
