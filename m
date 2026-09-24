Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097CB3E3D92;
	Thu, 24 Sep 2026 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241398; cv=none; b=iOwhO/U5tVxtZp6c++vCxjj95EeAPOJQZKbM2fyI9dLh1smoWNb9GALdwVwYrtIR5/5TzzUHDlTEBvV64EsrSGmESSNjAxltATD2XkKQMe5RazdYun/qT+GBjuXZHem7p3zDMVxmYVAI9b64LJVafsPcVE0ez17rYqVGWhG+FN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241398; c=relaxed/simple;
	bh=3XEV9E61xtwvrZh57iYsPAsazLW3HpePKDaI9XA4MB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwwEVDvNoFqLwhBNpX4Kuh/CRlAJrhLZgPFxQGENgFGCTiYJmhhKWT2DvB0CpqQyk5mJRff66vHQjHTItWWLGcudk7+21ZfzE1s6NcBrV7N4Y69PTt0IaHfrY/m1WK6k2o+P2tITkmlIGg56GUkWTDXn44kik/eRS+f6DiQ+B3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHIt26i2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHIt26i2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3911F000FF;
	Thu, 24 Sep 2026 09:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790241396;
	bh=YY5WjYIG3f1uBQp6Ur0QabUoDMRyYOAvdBu7ScI7FM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bHIt26i2rpFUu/t1xBUBlDEnXD7TMOtgmGguf0DBwAO/nDy+IX6JYlaDG85TQHMfW
	 iJp0dQsVPG6t/RDJhyt8bkU2hFukJeCVcrd9BItaM8+HmvUFlON07i271HLS+BGGNf
	 7DiDo0hEQNhzm3+Q63XHGmvZmwDfq9Bg09tTheAmx//43o5PYG666yUSwuf1MREhxi
	 M9pXIeSNLb7+y1RlcW0Q2f7HjRec3jzPri2RJO/itywk9YzGiAgY+5qwqq/1fpCkHb
	 VuHhVKrgs7WG+imjMEIM/KugPaT6+Fg+xKBzdfsjqGLWhkQQFjG+EAWLNMIbh/LFQK
	 W4zqvLVAj4/zA==
Date: Thu, 24 Sep 2026 10:16:31 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vma: predicate setting mmap_prepare VMA fields on new
 vma alloc
Message-ID: <arTmmxwNEBJx4683@gremlin>
References: <20260923-fix-mmap-prepare-overwrite-v1-1-3b3f1bfcdf5e@kernel.org>
 <arTlHBgXSP64U7ky@pedro-suse.tail5790ac.ts.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arTlHBgXSP64U7ky@pedro-suse.tail5790ac.ts.net>

On Thu, Sep 24, 2026 at 09:57:03AM +0100, Pedro Falcato wrote:
> On Wed, Sep 23, 2026 at 06:45:41PM +0100, Lorenzo Stoakes (ARM) wrote:
> > It only makes sense to manipulate VMA fields if a new VMA was allocated,
> > rather than merged.
> >
> > VMA merging does not compare vm_ops or vm_private_data, so a merged VMA
> > keeps its own, which is also what the legacy f_op->mmap path does since it
> > never touches an existing VMA.
> >
> > Currently, these fields will get overwritten by whatever state is
> > established in the mmap_prepare hook, and if the VMA was merged,
> > vm_ops->mapped will not have been called, so this could destructively clear
> > existing state without replacing it with anything valid.
> >
> > There is an implicit requirement that vm_private_data and vm_ops are
> > fungible across VMAs which means that losing the 'new' state is
> > fine.
>
> Hmm, can you explain how this is safe? I was wondering if _any_ kind of
> mismatch should be a WARN_ON (sounds like something odd is happening if
> they don't match). But if the new state is practically discardable, that
> doesn't make sense.

I mean this is asking me to defend how the kernel has worked forever :) don't
make me responsible for that...

For the VAST majority of cases, vm_ops is static. So they WILL be identical.

shmem does something really stupid with that which it shouldn't do (vary the
vm_ops on whether the file is unlinked or not), and maybe that needs a follow
up.

But anyway, one thing that saves us from a lot of this crap is that the majority
of things that store meaningful state there are non-mergeable,
i.e. VMA_PFNMAP_BIT, et al.

Of those that remain, the state is very often simply forwarding file state,
like:

	vma->vm_private_data = file->private_data;

At which point you already have equality.

Even if shared file state things might be tied to VMAs, but that should always
come out in the wash.

If you, for instance, stored the number of mappings there as a reference count (I
think fairly typical) then you automatically get the correct number because
vm_ops->close() will be called on a fully merged VMA (but not a partially merged
one which is correct).

Typical usage for legacy hook is mmap -> set refcount 1, open refcount++
(e.g. on split), close refcount--.

The mmap_prepare equivalent for that is vm_ops->mapped set refcount 1 (you
mustn't set state like that in mmap_prepare), and open/close as usual.

Another thing here is the idea that vm_private_data is ephemeral state _tied to
the VMA_.

It is already the case that that state will not be updated on expand/shrink of a
VMA, and so it is the case that if the VMA is unmapped for any reason the state
disappears.

So this ephemeral quality extends, by convention, to not impacting merge.

Anyway, I sent that 40 patch series (sorry for the size) in large part to
_strengthen_ assumptions about mmap_prepare (and, via legacy, mmap) hook
behaviour.

In general part of the mmap_prepare project is to allow us to get rid of
vagueries of the past and be able to make strong assumptions about behaviour.

So in the same vein, I'll do an audit of the codebase to make sure nothing
relies on this.

It might be interesting as well to audit what this data is actually set
to.

Maybe it makes sense to enforce that vm_private_data is always set to file
private dataa?

But that then implies that the VMA private data is unnecessary.

I do think requiring equivalent vm_ops might be a good thing to change, and
then to at least document the fact that vm_private_data is ephemeral like
this on merge.

Let me investigate how they're used and I can figure out how to improve
things.

>
> --
> Pedro

--
Cheers, Lorenzo
