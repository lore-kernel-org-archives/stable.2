Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C92D381EA8;
	Thu, 15 Oct 2026 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075694; cv=none; b=s1kN9Z6H26z2HM4vyfOJwth9YV9uB3SAvAXwhqPH6G7mAvQR7vC0OtOo+ZlfAPFzxmkPmmhxVDgEwpnvYf6BKJFNqGgWBaa89b0a+gPqAW/Va2wI6L0x/x59MEW025TfYeFZy1tnrBwZqSy6LoMpp/hAgM3XiRWAWH4KCJYWPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075694; c=relaxed/simple;
	bh=r4o9qKbn5uEj5Isj61iyocgh2vuIUNHK1KOMosud1PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=namDqp+N2B83ZDyNmGyN/qQsMhxhJ+j/2ASOTJKNG3ib/ZyPUT1s6rerI3z6IDyTQgA4O5PVstIKFE10rN9juzEjEZAH0YQD4oULaiLevKM/YrqO+Wf1/oyjZUr1V1Qu06xPU0ago6YFE78SFgbKWVoA1F7dDfMYILpNdMoVNck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6Npo+w4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6Npo+w4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642561F000C4;
	Thu, 15 Oct 2026 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792075692;
	bh=CI+ok0/Z43MdcnV3VUwcn2him7kLkNUJ17Hue0PIVoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I6Npo+w4u9JFFp4P/7aITeJ9Mrxa9x+/hj97hi1koxyVvBbv/oGud8SKnHdz1O4VK
	 K+/+v5C0hDTA4m/xkIat5mXAFuqMCW6n/eL/Z6CGVJVJWlOPXkwxHvUFF2YmzUADer
	 Vw5yFAD+xNmHX7klYT+L4eiusWgjQr7mApWL0s1rtbQftXIECY8PMqn+H8HgC5eFVq
	 u7oewxpX1Ai4uzkUjGGiEHV3PbFVTrGgfqMg5zyJcK1M9CVnI2w1MtvUiPDorft6SR
	 F3f8IjnLPpj3WNZxGvbBCrG0UdNocS/RYZO23NQm8HOPs8cevZlAaqM4JBvjfwoGme
	 Zo674Cu4zZvxg==
Date: Thu, 15 Oct 2026 15:48:10 +0100
From: Harry Yoo <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Imre Kaloz <kaloz@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, "Jose A . Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v2] mm/slab: sample slab_state once in
 kmem_cache_destroy()
Message-ID: <atDCYwNfKW3m6YXh@thinkstation>
References: <20261014150844.8536-1-kaloz@kernel.org>
 <d966f16a-a2be-48c7-b31a-a2c7d3ef6d5c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d966f16a-a2be-48c7-b31a-a2c7d3ef6d5c@kernel.org>

On Thu, Oct 15, 2026 at 09:21:43AM +0200, Vlastimil Babka (SUSE) wrote:
> On 10/14/26 17:08, Imre Kaloz wrote:
> > kmem_cache_release() tests slab_state >= FULL after kmem_cache_destroy()
> > has dropped slab_mutex and unlinked the cache, and for a
> > SLAB_TYPESAFE_BY_RCU cache after rcu_barrier(). If slab_late_init() runs
> > before that test it sets slab_state to FULL but skips the unlinked cache,
> > which never got a sysfs entry, so sysfs_slab_release() calls kobject_put()
> > on a kobject that was never initialized:
> > 
> >   WARNING: lib/kobject.c:734 at kobject_put+0x64/0x2c0, CPU#1: kworker/u8:3/55
> >   kobject: '(null)' ((____ptrval____)): is not initialized, yet kobject_put() is being called.
> >   refcount_t: underflow; use-after-free.
> >   kobject_put+0x64/0x2c0
> >   sysfs_slab_release+0xc/0x20
> >   kmem_cache_destroy+0x104/0x1e0
> >   bioset_exit+0x13c/0x1e0
> >   disk_release+0x54/0x140
> >   put_disk+0x18/0x40
> >   floppy_async_init+0xbec/0xd10
> > 
> > The release-time test has run outside slab_mutex since at least v4.4 for
> > SLAB_TYPESAFE_BY_RCU caches, and since v6.0 for the others. Since v6.12
> > the unlink-time test in kmem_cache_destroy() is a separate read of its
> > own, also after mutex_unlock(), so the two can disagree. Both tests ask
> 
> It would be useful to mention the commits here along with the versions. Also
> this suggests 3 commits but there's only 2 in Fixes.

Agreed.

At second look I think we should improve the changelog a bit....
And the history of this race is really... messy.

I'll just rewrite this part a little bit with specific commits and
add Fixes: tags for each commit that introduced for re-introduced
the commit, along with some history so that people* can decide whether
they* should pick this up.

*who may maintain downstream stable Linux kernels

> > the unlink-time test in kmem_cache_destroy() is a separate read of its
> > own, also after mutex_unlock(), so the two can disagree.

This part is unnecessary because reading slab_state outside
slab_mutex is what we should fix. As long as it's read under
slab_mutex, reading it once or twice doesn't really matter.

(See full changelog at the end of this email)

> I would guess the 6.0 change is not a crucial one?

Uh, I thought the Fixes: was 6.0 one, not 6.12 one :/

> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Thanks!

So... below is my suggestion. What do you think?

commit 13564e1cfc847aa540019b55a1f8e588670892fe
Author: Imre Kaloz <kaloz@kernel.org>
Date:   Wed Oct 14 17:08:43 2026 +0200

    mm/slab: sample slab_state once in kmem_cache_destroy()
    
    kmem_cache_release() tests slab_state >= FULL after kmem_cache_destroy()
    has dropped slab_mutex and unlinked the cache, and for a
    SLAB_TYPESAFE_BY_RCU cache after rcu_barrier(). If slab_late_init() runs
    before that test it sets slab_state to FULL but skips the unlinked cache,
    which never got a sysfs entry, so sysfs_slab_release() calls kobject_put()
    on a kobject that was never initialized:
    
      WARNING: lib/kobject.c:734 at kobject_put+0x64/0x2c0, CPU#1: kworker/u8:3/55
      kobject: '(null)' ((____ptrval____)): is not initialized, yet kobject_put() is being called.
      refcount_t: underflow; use-after-free.
      kobject_put+0x64/0x2c0
      sysfs_slab_release+0xc/0x20
      kmem_cache_destroy+0x104/0x1e0
      bioset_exit+0x13c/0x1e0
      disk_release+0x54/0x140
      put_disk+0x18/0x40
      floppy_async_init+0xbec/0xd10
    
    slab_state >= FULL asks whether the cache has a kobject, which cache
    creation skips while slab_state <= UP. UP is the state just below FULL,
    so a false sample cannot skip a kobject_put() that was owed.
    
    Seen on sparc64 at boot, where the asynchronous floppy init tears down
    its bio slab while the late initcalls are running.
    
    Sample slab_state once, under slab_mutex which slab_late_init() holds
    when it sets FULL, and use the result for both the unlink and the
    release.
    
    The history of this problem dates back to v3.2:
    
      Commit 69cb8e6b7c29 ("slub: free slabs without holding locks") in
      v3.2 moved sysfs_slab_remove() outside slub_lock and introduced
      a race condition between kmem_cache_destroy() and slab_sysfs_init().
    
      Commit 945cf2b6199be ("mm/sl[aou]b: Extract a common function for
      kmem_cache_destroy") in v3.7 accidentally closed the race while
      extracting a common implementation for kmem_cache_destroy().
    
      Commit 5413dfba88d6 ("slub: drop mutex before deleting sysfs entry")
      in v3.8 re-opened the race by dropping slab_mutex around
      sysfs_slab_remove() in __kmem_cache_shutdown(), to avoid a lockdep
      splat between slab_mutex and the sysfs lock.
    
      Commit 657dc2f97220 ("slab: remove synchronous rcu_barrier() call in
      memcg cache release path") in v4.11 shifted from synchronous
      rcu_barrier() to asynchronous RCU work for SLAB_TYPESAFE_BY_RCU caches.
      That commit, again, accidentally closed the race by moving
      sysfs_slab_release() to shutdown_cache(), but only for
      !SLAB_TYPESAFE_BY_RCU caches because destruction of
      SLAB_TYPESAFE_BY_RCU caches is done in an RCU work.
    
      Commit 0495e337b703 ("mm/slab_common: Deleting kobject in
      kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock") in
      v6.0 re-introduced the race for !SLAB_TYPESAFE_BY_RCU caches.
    
    Fixes: 69cb8e6b7c29 ("slub: free slabs without holding locks")
    Fixes: 5413dfba88d6 ("slub: drop mutex before deleting sysfs entry")
    Fixes: 0495e337b703 ("mm/slab_common: Deleting kobject in kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock")
    Cc: stable@vger.kernel.org
    Signed-off-by: Imre Kaloz <kaloz@kernel.org>
    Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
    Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
    Link: https://patch.msgid.link/20261014150844.8536-1-kaloz@kernel.org
    Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
    Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
