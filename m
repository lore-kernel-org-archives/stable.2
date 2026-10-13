Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FAE4FD278;
	Tue, 13 Oct 2026 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895085; cv=none; b=ZYxtneaLKbK4WT9UqDd/7JEfxWmM8HnRfcNrU18TI3VmhWpZOLl6+0r/X+bdfS3ae6eadbo66TSq4dJhYpRSwK35QRR9YPGwc8NfW17FQtsIBFgoyheFHLvoQX+REvup5mllLSXcfZVboJgVNVOC7E9HYfT5cMaYJpdCrDY482g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895085; c=relaxed/simple;
	bh=mwv9tJyKWWB3fTaJlLAmaVNIrw837U7j1ebYpEUuW/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBnc7nM/f9EWnAbZbKSg3zXiBzWuKl4L3vmA/NiQczsHxkO6bfkaBC3tVp/ijGPkINrXuqLDHFMdzK7C8MPnOgjKc0tRLXxHORgTjxLp8ghD7dahv+XQ97xQLyM2A61vC0CS9VdmMDC0DsF2Ug2ymgzvWPFpGyMCGGTdjG4rh3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yl0qMY6j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yl0qMY6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212401F000FF;
	Tue, 13 Oct 2026 12:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791895083;
	bh=GIMflr91/F4+/ElLk2iXFBQgQtgrPATZUPG9GvQDims=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yl0qMY6jwCOkNLtLFv6sTgRB1mFOK6e1GRyA5DvrmtTpv9MgjAnLuOroXeYhBaoXd
	 w1Mb/XI3ZfZ66+gSYg74JLpiau3G3m2WvcCkDhka8jj7mBJnLDBN9KmWL8+rMtXKCI
	 OrNCmQW42sUy4awxQNvvPnJ/C+2kpIVVY1hnwh1ux5FKn9DufDQNj05+2le4KGpsQa
	 evJCGrPVkclf16YP7RKRmxutWMVj5WjBI2g5IMuHPNgdG1p3LSTlX+98lskSdlvkhE
	 eKDMh9WcKcCU90jvTRa2PiE8o2Tjp7t38iY85i6B4hMrfG0csK4ZZMkwI9Kc1+/pe0
	 wwaJYkfkou8fA==
Date: Tue, 13 Oct 2026 13:38:01 +0100
From: Harry Yoo <harry@kernel.org>
To: Imre Kaloz <kaloz@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: sample slab_state once in kmem_cache_destroy()
Message-ID: <as4QhUscRVtBzYpm@thinkstation>
References: <20260930195110.13296-1-kaloz@kernel.org>
 <ar5pESlkEMqNsgxv@thinkstation>
 <aef97b97-0bd7-d720-7f59-8c0078747370@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aef97b97-0bd7-d720-7f59-8c0078747370@kernel.org>

Uh, apologies for the late reply.
Catching up after trip at LPC...

On Thu, Oct 01, 2026 at 05:42:36PM +0200, Imre Kaloz wrote:
> Hi Harry,
> 
> On Thu, 1 Oct 2026, Harry Yoo wrote:
> 
> > Hi Imre,
> > Thanks for catching and fixing this!
> > 
> > On Wed, Sep 30, 2026 at 09:51:09PM +0200, Imre Kaloz wrote:
> > > kmem_cache_destroy() tests slab_state >= FULL for sysfs_slab_unlink()
> > > and again in kmem_cache_release() for sysfs_slab_release(), with the
> > > cache already off slab_caches in between. If slab_late_init() runs in
> > > that gap it sets slab_state to FULL but never calls sysfs_slab_add() for
> > > the unlinked cache, so kmem_cache_release() ends up in kobject_put() on
> > > a kobject that was never initialized:
> > > 
> > >   WARNING: lib/kobject.c:734 at kobject_put+0x64/0x2c0, CPU#1: kworker/u8:3/55
> > >   kobject: '(null)' ((____ptrval____)): is not initialized, yet kobject_put() is being called.
> > >   refcount_t: underflow; use-after-free.
> > >   kobject_put+0x64/0x2c0
> > >   sysfs_slab_release+0xc/0x20
> > >   kmem_cache_destroy+0x104/0x1e0
> > >   bioset_exit+0x13c/0x1e0
> > >   disk_release+0x54/0x140
> > >   put_disk+0x18/0x40
> > >   floppy_async_init+0xbec/0xd10
> > > 
> > > Seen on sparc64 at boot, where the asynchronous floppy init tears down
> > > its bio slab while the late initcalls are running.
> > > 
> > > Read slab_state once, under slab_mutex which slab_late_init() holds when
> > > it sets FULL, and use the result for both the unlink and the release.
> > > The kobject flags (state_initialized, state_in_sysfs) were considered as
> > > the key instead, but slab_state is what cache creation and
> > > slab_late_init() decide on.
> > > 
> > > debugfs_slab_release() is not part of the race: it only looks the cache
> > > up by name in the debugfs root and does nothing before that root exists.
> > > 
> > > Fixes: 4ec10268ed98 ("mm, slab: unlink slabinfo, sysfs and debugfs immediately")
> > 
> > Overall looks good to me, but could you please explain why it's
> > not relevant before this commit? pre-4ec10268 still reads slab_state
> > outside slab_mutex.
> > 
> 
> The outside-mutex read is older, yes. What 4ec10268ed98 changed is that
> unlink and release no longer share it.

Right.

> Before that commit, kmem_cache_release() did one test and used it for
> both:
> 
>     if (slab_state >= FULL) {
>         sysfs_slab_unlink(s);
>         sysfs_slab_release(s);
>     } else {
>         slab_kmem_cache_release(s);
>     }
> 
> So the two could not disagree.

Right.

> 4ec10268 moved sysfs_slab_unlink() into
> kmem_cache_destroy(), after list_del() and after dropping slab_mutex,
> and left a second slab_state test in kmem_cache_release() for
> sysfs_slab_release(). The cache is already off slab_caches in between.

Right.

> That is the window in the warning: the first test sees < FULL, so the
> kobject is never linked; slab_late_init() then sets FULL under
> slab_mutex and calls sysfs_slab_add() only for caches still on the
> list; the second test sees FULL and kobject_put()s a kobject that
> kobject_init() never ran on.
> 
> A single read cannot produce that split decision, which is why Fixes:
> points at 4ec10268ed98.

Right.

> There is a related older window: after list_del() and before that
> single read, slab_sysfs_init() could set FULL, skip this cache, and
> the single read would then call both unlink and release on an
> uninitialized kobject.

No, with this patch slab_sysfs_init() cannot set the state to FULL
because the slab_caches list and slab_state are protected by slab_mutex.

> I have not hit that, and this patch does not close it.

I think the patch does close two bugs.

One introduced by 4ec10268ed98 (reading slab_state twice),
another (reading slab_state outside slab_mutex) introduced by, hmm,
not sure which commit introduced it :) should be very old.

-- 
Cheers,
Harry / Hyeonggon
