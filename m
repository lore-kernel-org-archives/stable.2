Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80D73AE197;
	Wed, 26 Aug 2026 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780836; cv=none; b=hWYOFb9klitTA6voea9tCDdmiX1QhtLvw8SH2caRdHtkl1y6Jjxwx+6JI6BI7XJzasoODWF1jmht0TwRkNkQ6rnjxwglZtOJHDWc4SlttoRwb8OAHTzGmc8tu+2AgL+7RBvLO669DlJ3n6xcY/uJP5qcVP0llZLhTRIux6AwDeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780836; c=relaxed/simple;
	bh=n9jllLuuuDxc50bnEHizMpfkHWDBDTipIiHN+X+f3/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o34vWTjURLlZHv5MXiHvys7POTSdBhoAASARfqJNi5x+qeWNNT2cnFvcBrwJwkdEbuyeis6F/wmvFxhu7oPEZcHR9GB1woF8UX6DgUpHo6FBn+fGCCD7K1fbpFNLAc4A5kW8I+pHzHMMYK6iKDf8aDfL6EAv1gJkecVvIThK1ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jrl06373; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jrl06373"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236451F000E9;
	Wed, 26 Aug 2026 21:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787780834;
	bh=uYhBnbgaM5tsdHStoHUAOfPpl70osUN/iMiXrAYwhXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jrl063735GQ651Sx5tkw/WYfZg87jCVUGYR086riCa1l56MJB0L9We//V+CrSnrMo
	 dtau/nQDtjn0s5iuzvLOk7wvZ5QjWIHMIFZC5xV26kSa0DESY7141+TMR744OqfrJq
	 011W7EqAScOWHs9Lm7dug5xBjPpqHf5+dJqRFC9TKnM3G1yOlmsK8/mQH9HfKLs1RB
	 GIwJKMpagaBcHmAbNBsjFSrlmxaOG67zccFondq9TsICcc8wspWwUpWAMSUKxNgE0v
	 Dnrr0NUQUIhXciX8+og6m+OIfSKPRYyVxYHmrwxXsXXk11eVTolO0g0c6VAQm20vrn
	 p0HDzXbjcDp6g==
Date: Wed, 26 Aug 2026 22:47:10 +0100
From: Harry Yoo <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzbot+805630f1453e490427fa@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: reject unsupported kmalloc sizes
Message-ID: <ao9dPUpHxP5uOOcw@MacBook-Air.tail10959e.ts.net>
References: <20260817-limit_kmalloc_size-v1-1-5bef487701cc@nvidia.com>
 <82f138f5-11d4-4839-94a3-c226fd982715@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82f138f5-11d4-4839-94a3-c226fd982715@kernel.org>

On Wed, Aug 26, 2026 at 11:28:12AM +0000, Vlastimil Babka (SUSE) wrote:
> On 8/17/26 22:40, Zi Yan wrote:
> > kmalloc is used to allocate physically contiguous memory for kernel
> > allocations. For requests larger than KMALLOC_MAX_CACHE_SIZE, kmalloc uses
> > the page allocator and can only support up to KMALLOC_MAX_SIZE. For request
> > sizes bigger than KMALLOC_MAX_SIZE, the page allocator can emit a WARN
> > because kmalloc allocates an order greater than MAX_PAGE_ORDER. Systems
> > with panic_on_warn=1 crash because of this WARN. Fix it by rejecting any
> > kmalloc size bigger than KMALLOC_MAX_SIZE.
> > 
> > Fixes: aadb4bc4a1f9 ("SLUB: direct pass through of page size or higher kmalloc requests")
> > Reported-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/6a820ebc.9ebadd4d.20b15e.001b.GAE@google.com/
> > Tested-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
> > Signed-off-by: Zi Yan <ziy@nvidia.com>
> > Cc: stable@vger.kernel.org
> > ---
> > It fixes a page allocator warning (order > MAX_PAGE_ORDER) when gadgetfs
> > requests excessively large memory from kmalloc. Instead of adding
> > __GFP_NOWARN to suppress the warning, as was done for usbfs[1], change
> > kmalloc to return NULL without a warning for this specific issue.
> > 
> > [1] commit 4f2629ea67e72 ("USB: usbfs: Don't WARN about excessively large memory allocations")
> 
> So I checked and for kvmalloc() we have in __kvmalloc_node_noprof()
> 
>         /* Don't even allow crazy sizes */
>         if (unlikely(size > INT_MAX)) {
>                 WARN_ON_ONCE(!(flags & __GFP_NOWARN));
>                 return NULL;
>         }
> 
> This comes from Linus in commit 7661809d493b4. I'd do the same thing here
> then.

But the purpose of this patch is to avoid the warning in the page
allocator. Should we fix this in the caller (gadgetfs) then? 

> Thus there would be a useful warning for e.g. development mistakes
> resulting in the size to be unexpectedly high.
> 
> Callers passing size that comes from userspace or similar untrusted source
> can either pass __GFP_NOWARN or sanitize the size to what they expect to be
> sane (which is context dependent and I assume actually way lower than
> kmalloc limits in practice). Note that passing even sizes within but close
> to/at the limit, trusting blindly some external source, can succeed the
> allocations but effectively DoS the system with heavy reclaim/compaction. So
> caller sanitization should still be preferred IMHO. Some of the recent
> arguments from Linus [1] would apply to this too, I think.
> 
> [1]
> https://lore.kernel.org/all/CAHk-=wiSmgwwLKCqJwGS-dVHnSLU8W+7q1UQq-G9=TBGGZbuhQ@mail.gmail.com/

-- 
Cheers,
Harry / Hyeonggon
