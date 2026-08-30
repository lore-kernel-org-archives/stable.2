Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5936380FC4;
	Sun, 30 Aug 2026 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788094359; cv=none; b=rwt41IWHTYYdVOvTRqLjGgwC2EypWfPgBxVMo1AtJHpU4T6hi5Bh6oS/OrhQsHofMVdEi5ZdjFB7dQdzogiO7aWn+84mLpB3bk6JcZCYpWCnhOfRxjPa7uP/l5J0MJSzIPjeQlqoJC0sXIv8o1sfB1G5ESvLSSZ3CuqPQv9fgig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788094359; c=relaxed/simple;
	bh=iC2ZlVDKAp88eC+e69DyRcAQpxMmjyiZKGKKx0sRvgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltfwCTD4ljWWpgUgi5cOxOGzeng1DTfqypQU0GpEO6S0YbuzGEhMhvGAIquYYZ28THmoUahWIP8YqpcYVsq3cka3qgZ+XaEOHPaJoKQPZp72shgmS/mjQJT/eSmjeTIR5CW1gyWxu+hL7Gfn0YkuA1ylAgGuCtH/9D59UYH1bY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wrcyrobq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wrcyrobq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00161F000E9;
	Sun, 30 Aug 2026 12:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788094357;
	bh=t+w2XNkCWNOAyz8LeQ5op7kMySPGtAcuPEqaVAY2YEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WrcyrobqCjymKqD9XkqUts7JrHZIY+yyBn+aDdn3CLT3xjJJAq1YINb7It1NcM/eX
	 8nFvixT1w2I8Ge0X4dZr1qlypupLyOzqKtJbId2XRFZvkt1NRoYP8pE+TFj4OE4g9A
	 aXXHuMhgC2YDxTSZdWTUERO/WjDR6lfFwxA5YWoif09eZ4nUrtJXlSRl4iC77X9TLJ
	 j54EeBjTfyBctaq8kxLZ/XsgaYwPyR/Ukpw9rMOGN2d1qhcJqXmCf3xykzJTb97TSx
	 Eb4LysfruHTXGuJqiiRHcIwy2pkgLJSDRKnVdWWW5rsXLLb5lxYIbHCg/Gyr6h+0wU
	 kbmM2LlD14/GQ==
Date: Sun, 30 Aug 2026 12:52:32 +0000
From: Harry Yoo <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzbot+805630f1453e490427fa@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: reject unsupported kmalloc sizes
Message-ID: <apQnNhrsBfGm40Lz@dev>
References: <20260817-limit_kmalloc_size-v1-1-5bef487701cc@nvidia.com>
 <82f138f5-11d4-4839-94a3-c226fd982715@kernel.org>
 <ao9dPUpHxP5uOOcw@MacBook-Air.tail10959e.ts.net>
 <DKZ7J9HNUDR6.BP9KG5Q7HYMJ@nvidia.com>
 <c4684212-f44a-4aff-a02d-f3f26095ebc1@kernel.org>
 <DKZUH9SFMP6H.1ZMKA92IHQLG2@nvidia.com>
 <c9c11ca3-8f78-4086-8549-5e99a4d79feb@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c11ca3-8f78-4086-8549-5e99a4d79feb@kernel.org>

On Thu, Aug 27, 2026 at 06:49:33PM +0200, Vlastimil Babka (SUSE) wrote:
> On 8/27/26 17:51, Zi Yan wrote:
> > On Thu Aug 27, 2026 at 3:47 AM EDT, Vlastimil Babka (SUSE) wrote:
> >> On 8/26/26 11:52 PM, Zi Yan wrote:
> >>> On Wed Aug 26, 2026 at 5:47 PM EDT, Harry Yoo wrote:
> >>>> On Wed, Aug 26, 2026 at 11:28:12AM +0000, Vlastimil Babka (SUSE) wrote:
> >>>>> On 8/17/26 22:40, Zi Yan wrote:
> >>>>>> kmalloc is used to allocate physically contiguous memory for kernel
> >>>>>> allocations. For requests larger than KMALLOC_MAX_CACHE_SIZE, kmalloc uses
> >>>>>> the page allocator and can only support up to KMALLOC_MAX_SIZE. For request
> >>>>>> sizes bigger than KMALLOC_MAX_SIZE, the page allocator can emit a WARN
> >>>>>> because kmalloc allocates an order greater than MAX_PAGE_ORDER. Systems
> >>>>>> with panic_on_warn=1 crash because of this WARN. Fix it by rejecting any
> >>>>>> kmalloc size bigger than KMALLOC_MAX_SIZE.
> >>>>>>
> >>>>>> Fixes: aadb4bc4a1f9 ("SLUB: direct pass through of page size or higher kmalloc requests")
> >>>>>> Reported-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
> >>>>>> Closes: https://lore.kernel.org/all/6a820ebc.9ebadd4d.20b15e.001b.GAE@google.com/
> >>>>>> Tested-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
> >>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>>>>> Cc: stable@vger.kernel.org
> >>>>>> ---
> >>>>>> It fixes a page allocator warning (order > MAX_PAGE_ORDER) when gadgetfs
> >>>>>> requests excessively large memory from kmalloc. Instead of adding
> >>>>>> __GFP_NOWARN to suppress the warning, as was done for usbfs[1], change
> >>>>>> kmalloc to return NULL without a warning for this specific issue.
> >>>>>>
> >>>>>> [1] commit 4f2629ea67e72 ("USB: usbfs: Don't WARN about excessively large memory allocations")
> >>>>>
> >>>>> So I checked and for kvmalloc() we have in __kvmalloc_node_noprof()
> >>>>>
> >>>>>         /* Don't even allow crazy sizes */
> >>>>>         if (unlikely(size > INT_MAX)) {
> >>>>>                 WARN_ON_ONCE(!(flags & __GFP_NOWARN));
> >>>>>                 return NULL;
> >>>>>         }
> >>>>>
> >>>>> This comes from Linus in commit 7661809d493b4. I'd do the same thing here
> >>>>> then.
> >>>>
> >>>> But the purpose of this patch is to avoid the warning in the page
> >>>> allocator. Should we fix this in the caller (gadgetfs) then? 
> >>> 
> >>> It is fixed by: https://lore.kernel.org/all/20260820223719.A4A3C1F000E9@smtp.kernel.org/
> >>> 
> >>> Please disregard this patch, but we can keep the discussion going.
> >>
> >> I still think this patch has some value if done as proposed above. Yes
> >> in practice it will just replace the page allocator's warning with a
> >> different warning, but IMHO it's "nicer" if kmalloc() sanitizes its own
> > 
> > And SLAB maintainers will be Cc'd. :)
> 
> For some people it doesn't matter if it's SLAB or PAGE ALLOCATOR :D
> 
> >> requests to the page allocator, using the KMALLOC_MAX_SIZE value.
> > 
> > Like this? Or the exact pattern as kvmalloc() is preferred?
> 
> LGTM.

Looks good to me too.

> Should return NULL even with __GFP_NOWARN or if the warning has fired
> and won't again, and AFAICS this does.

Right.

> The kvmalloc() pattern predates WARN_ON_ONCE_GFP addition, I think.
> 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 0337e60db5ace..b562f2a6fbbee 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -5263,7 +5263,12 @@ static void *___kmalloc_large_node(size_t size, gfp_t flags, int node)
> >  {
> >  	struct page *page;
> >  	void *ptr = NULL;
> > -	unsigned int order = get_order(size);
> > +	unsigned int order;
> > +
> > +	if (WARN_ON_ONCE_GFP(size > KMALLOC_MAX_SIZE, flags))
> > +		return NULL;
> > +
> > +	order = get_order(size);
> >  
> >  	if (unlikely(flags & GFP_SLAB_BUG_MASK))
> >  		flags = kmalloc_fix_flags(flags);
> > 
> > 

-- 
Cheers,
Harry / Hyeonggon
