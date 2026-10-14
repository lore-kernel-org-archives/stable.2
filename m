Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0F44BD375;
	Wed, 14 Oct 2026 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983242; cv=none; b=KH2xpOetJH1mXTe9XeXvld+tN39dKzTaK642x5pyX3qXId0wbL25afvfsVIQ8AbyvAWyOHObicwB7T60f7uofX5qioCpo353+K6QuQft+zyvVrEZUaV4XcA6l0NrRYupWSzCaBnpachb296eNrpYlfgI1V1hPywHQ3PFROGQxcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983242; c=relaxed/simple;
	bh=tgeyzmFEqjRy/ewes1KGFcQbVOxQv8aq24/1Dxe5iq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0hI2X0dVsnVI7r3g3jYgTQjTSbV99HjX/Zz23xq3LQCHX3lHr2vNFmTlpFlC7kY8IBalU1V3riJmbkp0tWxN3mNh0H7X5zqL/1tRHFuXMzCG8WRtLW2boKWwbAB+gCBTAPWovLFO1g0Q8HhgBXHfVQcv+aQVyTRsP70GxVrUU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJXvNhle; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJXvNhle"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5C31F000FF;
	Wed, 14 Oct 2026 13:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791983240;
	bh=wVcsAY5wGMlDOwmq1UZhDfW0sTXv6nSmjcnxiZJCQSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gJXvNhlenmvFPChjIvsCVcupdI2lvpG74I76/6onSupzyO0JjNjLRd8nqJ5I0mzJr
	 iqy0aBl7eU/sNq1UeTHQcq9kHlgTtxYiZmwV87gGeg9gF/6S/nInXVBK1+WAheoZrq
	 IsAggvZ85Uz2egR5kLg2PBngfG6QygA/b7Y+0giJQQfNvt3ErLXI7YHtm4srzKTxyU
	 1D0sdzRuOzsf8lXOhV1QyPsJ40wzLX+by66/gY8/om4e4E12NwZy01kmORNiJoZIQd
	 S0lEEw9xFXQeZEwJWzPJWpyO035uhqDkm6XDfP7Nsmvhg6Z2TZgUulV6X8W6/QR/yZ
	 dT6m3qgj6lUew==
Date: Wed, 14 Oct 2026 14:07:18 +0100
From: Harry Yoo <harry@kernel.org>
To: Imre Kaloz <kaloz@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: sample slab_state once in kmem_cache_destroy()
Message-ID: <as96u-sh8BbjXW24@thinkstation>
References: <20260930195110.13296-1-kaloz@kernel.org>
 <ar5pESlkEMqNsgxv@thinkstation>
 <aef97b97-0bd7-d720-7f59-8c0078747370@kernel.org>
 <as4QhUscRVtBzYpm@thinkstation>
 <481e9a16-cd30-d463-14ee-b5602bcd5a21@kernel.org>
 <as4q2WlR7mLhMBpG@thinkstation>
 <e4184209-75ee-929d-0103-ca15d5886000@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4184209-75ee-929d-0103-ca15d5886000@kernel.org>

On Tue, Oct 13, 2026 at 06:32:26PM +0200, Imre Kaloz wrote:
> Hi Harry,
> 
> On Tue, 13 Oct 2026, Harry Yoo wrote:
> 
> <snip>
> 
> > > > > There is a related older window: after list_del() and before that
> > > > > single read, slab_sysfs_init() could set FULL, skip this cache, and
> > > > > the single read would then call both unlink and release on an
> > > > > uninitialized kobject.
> > > > 
> > > > No, with this patch slab_sysfs_init() cannot set the state to FULL
> > > > because the slab_caches list and slab_state are protected by slab_mutex.
> > > > 
> > > > > I have not hit that, and this patch does not close it.
> > > > 
> > > > I think the patch does close two bugs.
> > > > 
> > > > One introduced by 4ec10268ed98 (reading slab_state twice),
> > > > another (reading slab_state outside slab_mutex) introduced by, hmm,
> > > > not sure which commit introduced it :) should be very old.
> > > 
> > > You're right, I got that one wrong. Sampling under slab_mutex in the
> > > same section as the list_del() means slab_late_init() either sees the
> > > cache on the list or we see slab_state < FULL, so the older window is
> > > closed too.
> > > 
> > > As for where the outside-mutex read came from, as far as I can tell it's
> > > 0495e337b703 ("mm/slab_common: Deleting kobject in kmem_cache_destroy()
> > > without holding slab_mutex/cpu_hotplug_lock"). Before that, the unlink
> > > and release and their slab_state checks ran in shutdown_cache() under
> > > slab_mutex.
> > 
> > 0495e337b703 Probably yes. Not 100% sure.
> > 
> > It's quite messy, reading slab_state has been done inside, switched
> > to outside, and back to inside, and so on.
> > 
> > But should be fine as long as we can find the first commit that
> > affects -stable kernels (>= 5.10.y)
> > 
> > > SLAB_TYPESAFE_BY_RCU caches were already released from the
> > > workfn outside the mutex since 657dc2f97220.
> > > 
> > > Want me to send a v2 with a second Fixes: for 0495e337b703, or is it
> > > fine to add it when applying?
> > 
> > Could you please verify fixing which bugs resolves the issue on sparc64
> > described in the changelog? Reading it twice, or outside slab_mutex, or
> > both?
> 
> I tested it. I built five variants of rc7 with a small test that
> destroys a SLAB_TYPESAFE_BY_RCU cache while slab_late_init() runs
> (same path the floppy bio slab takes), and booted each 10 times on
> x86 and 8 times on sparc64. Boots that hit the WARN:
> 
>                                              x86     sparc64
>   mainline                                   9/10    8/8
>   one read, in kmem_cache_release()          9/10    8/8
>   unlink check under slab_mutex,
>     release still re-reads                   10/10   8/8
>   one read under slab_mutex (this patch)     0/10    0/8
>   one read right after mutex_unlock()        0/10    0/8
> 
> So it takes both. The read that hurts is the one at release time,
> after rcu_barrier(); fixing only the double read keeps it, and so
> does moving only the unlink check under the mutex. Reading once
> right after the unlock didn't trigger it, but that is still racy,
> just a much smaller window.

Thanks for verifying that.

> For stable, as far as I can tell the release-side read has been
> outside slab_mutex since d50d82faa0c9 ("slub: fix failure when we
> delete and create a slab cache") in v4.18

For SLAB_TYPESAFE_BY_RCU caches, yes.
and others since 0495e337b703.

I think Fixes: d50d82faa0c9 should be fine.

> , so that would cover
> 5.10.y. The patch doesn't apply before 6.12, so the older branches
> need their own backports.

Ack.
Are you willing to backport it to -stable kernels as well?

And could you please post v2 with updated Fixes: and the
commit message ;)

Thanks for fixing this!

-- 
Cheers,
Harry / Hyeonggon
