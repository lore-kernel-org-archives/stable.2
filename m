Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ECE20E334;
	Thu, 18 Jun 2026 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772232; cv=none; b=Za6yJ0AxpjrF2gH9+CyOcPVxI5QeQzCtu4ApD1UEPSjz5agOQdXoeGDX7C7ZjB3rSuFMu6L6LzWLVZe8znhUDFvzuea7h0rxOtCUOQXBU19VcOUIEyZw0NX3zwH54/r+G3QjXziCrXH3FY2e0m63Xlk1TcAYmKWDtEZsm3+bIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772232; c=relaxed/simple;
	bh=FyoE8GbvYTwS6GbEF4K/IhfVIv8iF4ZW99LFKKB1bpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUvONOjsG/dD6jMH34OpaclTdW6SNUW4FKruRRA12mEXbcyjdzzW8uYGphqCDxdpoqFzqDqoHIA4Zr34+6u2OIRdKVVv5pvBm/NT2fvhstbeXksf1ljAVIBLDPb5/4f2BA+Hs/1Y1uWI37QZqMl5X/NzQJnXi6drpu4sqcUxQv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UR41z7fP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UR41z7fP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5241F000E9;
	Thu, 18 Jun 2026 08:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781772231;
	bh=uMHM7UuTf2do2f7Hpoqk2j+rviNJ44WWlkZ4oTbhXQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UR41z7fPG6eVHeAWjFEh8fwBtmodmDzk+F3Lk7VGgBEcVCo7xuYoZlzv7ajxbUgqL
	 8NHszgXK/0ld2fcayuwb183RFUP1LmOuiz8CbdQgQ+g0aO0woiBL8P+QQK+hbRFoDO
	 scrCxeHw9o6SozJBMF197xUAr85od+/VUepcFepPuO7ob6AsDpPB7baAHXFqQU9bze
	 tLh/Di3w+K881gfrWsflutns/P2W3oo92/VVrZ4xA6cB4Z+qMlmLgc5MtZAvTm2jQo
	 anD2gB94b5c2C0p9yp04vf7bSzD4EtsceR/sSm0clC8omBqYDROVEDgjC8FNutME9t
	 0mcXH1jXo+WWA==
Date: Thu, 18 Jun 2026 11:43:44 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>,
	vova tokarev <vladimirelitokarev@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: prevent registration of special VMAs
Message-ID: <ajOvwGs5xhnfBu-k@kernel.org>
References: <20260617194059.2529406-1-rppt@kernel.org>
 <5a993689-f730-406d-8515-8bb6025cc851@kernel.org>
 <ajOtfdGgFQYL-T6f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajOtfdGgFQYL-T6f@kernel.org>

On Thu, Jun 18, 2026 at 11:34:12AM +0300, Mike Rapoport wrote:
> On Thu, Jun 18, 2026 at 10:19:17AM +0200, David Hildenbrand (Arm) wrote:
> > On 6/17/26 21:40, Mike Rapoport wrote:
> > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > > 
> > > Vova Tokarev says:
> > > 
> > >   userfaultfd allows registration on shadow stack VMAs.  With userfaultfd
> > >   access, you can register on the shadow stack, discard a page ... and
> > >   inject a page with chosen return addresses via UFFDIO_COPY.
> > > 
> > > Update vma_can_userfault() to reject VM_SHADOW_STACK.
> > > 
> > > While on it, also reject VM_IO, VM_MIXEDMAP and VM_PFNMAP so that if a
> > > driver would implement vm_uffd_ops, it wouldn't be possible to register
> > > special VMAs with userfaultfd.
> > > 
> > > Reported-by: vova tokarev <vladimirelitokarev@gmail.com>
> > > Fixes: 54007f818206 ("mm: Introduce VM_SHADOW_STACK for shadow stack memory")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > ---
> > >  mm/userfaultfd.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index 246af12bf801..b8d2d87ce8d7 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -2111,7 +2111,8 @@ static bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
> > >  {
> > >  	const struct vm_uffd_ops *ops = vma_uffd_ops(vma);
> > >  
> > > -	if (vma->vm_flags & VM_DROPPABLE)
> > > +	if (vma->vm_flags & (VM_DROPPABLE | VM_IO | VM_MIXEDMAP | VM_PFNMAP |
> > > +			     VM_SHADOW_STACK))
> > 
> > I'm sure you considered VM_SPECIAL, which additionally includes VM_DONTEXPAND.
> > 
> > Would that be better, or what was the reason to allow VM_DONTEXPAND?
> 
> By itself VM_DONTEXPAND won't matter, as uffd can't resize a VMA.
> But thinking more about it, it's better to make vma_can_userfault() more
> restrictive and just use VM_SPECIAL.

Ah, hugetlb sets VM_DONTEXPAND, so it must me excluded to allow uffd with
hugetlb.

-- 
Sincerely yours,
Mike.
