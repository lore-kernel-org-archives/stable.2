Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123343;
	b=f9pAZeUFm7fZa8r26VA2Jj9lFY8Qa9y6HX7VURDaijDgh1oena9JqiAtbxOORkSQW2Ve
	 usOojEqlXSyFHknI5EiPQAU2TuLx+6sEgBxKGHbBiK0LYo8752rrngNY3NHT5kBl471XI
	 BvOB23w1ItDeiV19PyYcUi37zczrDJtEnqegSYihl4tHi2V1VBQ6muKVj67/2uumksqoI
	 NC8ZmEimeZtZROQDHvED1ZUZZQOftw8MtzUJhkpMnwMb9ZGvOgx7bLAHS1dn7yuQtnewG
	 xvy2rcdMtIFe4Lkk/s07DxioE3RP6EX0EC5sy9DAEHUQrmUlpIgKESXRsW8ICsSlWqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123343;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=oKKkLGPvy7oc9Cj7oiHBn7WJYL3F1vQJtw5e9araRYA=;
	b=bqDyV2+uYwcHUoKnL2q8zoOM7BJWshtZajveRbkfk1E3CMbvjMYTVSX5Q3EbOeIdciAg
	 nqeVuLbYb8vHsvEypmMZzcsjqZZsEMbKoiFBXasIqL4stik5bS0jnRe6AJ/1gxOZwL22d
	 QkyGZ5xSofP2QHhw6kn0UoMyWa7fRAgTLuFCSCw1ycN5PTMQYQlFwUtk1foxK9tcwbszg
	 USSxRsD9qRQMgv54SzFET7YJiCvlcfZpd7p/nIA8DP9OGq8hrsN3t9OjWW/gQKWCb24rj
	 Cat80W5YGiS8tWTFR3DjhkEa2RHhgCj622B+NLsz7q8Jy1xKBHJeU4bnn1buYVPT35Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0I5l02K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F78C606A31A;
	Tue, 27 Oct 2026 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0I5l02K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4131F01828;
	Tue, 27 Oct 2026 17:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793123343;
	bh=oKKkLGPvy7oc9Cj7oiHBn7WJYL3F1vQJtw5e9araRYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B0I5l02KTGM/aT2NqPpE5PbeJiJ01nypwLlxR9g+urCcjWDkTQRH5b9WLq+xorRHu
	 gaHVsq+vWVVMMVgZJj99P7VPUK56MX+SN5GmhJeNjFsPHBhIfOxQxTHwfg8Yl55QBo
	 h2+L7k6uI8QSS0xnmDEwj1elvxOzwFVUmYIy2Z3V5FQ6jl7won1m4EuaQPtTHj+P6r
	 QKvr8WKDY3sWTZY8M7J0IgM6r+wZtuZ6OJmUoZFNowvnukVmofi17p6T84GYeCEfdh
	 y1I8cpLTJP+bHaVGZHux+dq7p9gdyGATdM7FGfT81kBiDIHHxo/fuqdDZDS0KSVFCy
	 fYw0ZMg7MIAXg==
Date: Tue, 27 Oct 2026 17:48:57 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Shakeel Butt <shakeel.butt@linux.dev>, SJ Park <sj@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, 
	"David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [PATCH v2] fs/proc/task_mmu: fix missed VMAs when reading
 /proc/PID/maps and friends
Message-ID: <auDEn8GmB0H7zj99@gremlin>
References: <20261027-fix-proc-pid-maps-missing-vmas-v2-1-2791cc9fc95f@kernel.org>
 <CAJuCfpELhxhyVQANspX14OBLbghiAqndYcfv1hnmh4Nvo=1vAQ@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpELhxhyVQANspX14OBLbghiAqndYcfv1hnmh4Nvo=1vAQ@mail.gmail.com>

On Tue, Oct 27, 2026 at 08:34:10AM -0700, Suren Baghdasaryan wrote:
> Overall the code looks correct bit I have a couple of questions below.

Thanks!

>
> > ---
> > Note that I decided it's best to defer any VMA iterator stuff to a
> > follow-up - with the abstractions added it's clear what's going on and
> > easier for backporting.
>
> Ok. But once we get VMA iterator validation routine implemented, we
> won't need vma_rcu_iter and its helpers, I think. Are you ok with the
> fact that most of this change will have to be removed later?

No, I don't think this is correct.

The iterator can't validate itself - the failure case is invisible to it,
something changed in the tree and it has no way of knowing, it has to be
prompted to re-init etc.

I tried a version of the code with vma_iter_next_before() and it really didn't
provide much delta.

So I think any version of this has to have the rvmi stuff.

In any case, I am happy to replace all this with whatever makes most sense
going forwards.

Key here is to fix the bug + get it backported :) [ before moving on to the
N other AI-reported bugs ;) ]

> > +static inline void vma_rcu_iter_init(struct vma_rcu_iter *rvmi,
> > +               struct mm_struct *mm, struct vma_iterator *vmi,
> > +               unsigned long addr)
> > +{
> > +       vma_iter_init(vmi, mm, addr);
> > +       rvmi->mm = mm;
> > +       rvmi->vmi = vmi;
> > +       rvmi->mm_wr_seq = UINT_MAX; /* Start odd so changed by default. */
>
> Why not initialize mm_wr_seq correctly using
> mmap_lock_speculate_try_begin(mm, &rvmi->mm_wr_seq)? That way on the
> first call to lock_next_vma() you won't be resetting vmi
> unnecessarily.

It doesn't really save anything, the init already sets you up in start state
where you need to do a traversal anyway, and vma_next() will trigger a walk
either way.

What's useful about it is it makes it such that only lock_next_vma() does the
speculation (and thus sampling of mm_wr_seq).

> > @@ -471,14 +505,9 @@ struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
> >          * installed ahead of it. Otherwise we might observe a gap that should
> >          * not be there.
> >          */
> > -       if (from_addr < vma->vm_start) {
> > -               /* Verify only if the address space might have changed since vma lookup. */
> > -               if (!mmap_unlocked || mmap_lock_speculate_retry(mm, mm_wr_seq)) {
> > -                       vma_iter_set(vmi, from_addr);
> > -                       if (vma != vma_next(vmi))
> > -                               goto fallback_unlock;
> > -               }
> > -       }
> > +       if (from_addr < vma->vm_start &&
> > +           vma_rcu_iter_may_have_skipped(rvmi, from_addr, vma->vm_start - 1))
> > +               goto fallback_unlock;
>
> Before this change we fell back only if the new search yielded a
> different VMA (the vma != vma_next(vmi) condition) while now we
> fallback unconditionally. Note that the VMA that we are rechecking is
> already locked, so it can't change. Was the previous logic invalid?

It's not unconditional - it requires that we have progressed and we may have
skipped a VMA change.

The 'we have progressed' bit was there before (from_addr < vma->vm_start), and
vma_rcu_iter_may_have_skipped() wraps the previous check plus actually walks to
check if something is there to traverse,

So this is strictly an improvement.

And yes the previous logic was invalid - the issue is with an unlocked VMA
in the range [from_addr, vma->vm_start - 1].

It's really the gap that's the problem AND a race against node replacement,
which means that 'X' is skipped by vma_next().

vma_next() is a walk to from_addr, then runs mas_next_slot() which advances
to the next entry. If a gap, then the walk assigns mas->last to the end of
the gap, and if a node is killed before that happens, due to a VMA
expanding _backwards_ like:

vma_iter_set(vmi, from_addr), then mas_walk() from mas_find():

        from_addr
           |
           v
 |---------|      |-----|   |---------|
 |    A    |      |  X  |   |    B    |
 |---------|      |-----|   |---------|
           ^     ^
           |     |
     mas->index  mas->last

The walk lands in the gap. mas_next_slot() saves mas->last as its
rewalk point.

X expands backwards, the node containing the gap is replaced:

        from_addr
           |
           v
 |---------|  |---------|   |---------|
 |    A    |  |    X    |   |    B    |
 |---------|  |---------|   |---------|
                 ^
                 |
             mas->last

mas_next_slot() finds the node dead and calls mas_rewalk(mas->last),
which now lands inside X:

        from_addr
           |
           v
 |---------|  |---------|   |---------|
 |    A    |  |    X    |   |    B    |
 |---------|  |---------|   |---------|
               ^        ^
               |        |
         mas->index  mas->last

mas_next_slot() then advances past the entry it is on, which is X:

        from_addr           vmi
           |                |
           v                v
 |---------|  |---------|   |---------|
 |    A    |  |    X    |   |    B    |
 |---------|  |---------|   |---------|

So vma_next() returns B, having stepped over X. We lock B:

        from_addr           vmi
           |                |
           v                v
 |---------|  |---------|   |---------|
 |    A    |  |    X    |   |    B    |
 |---------|  |---------|   |---------|
                              locked

Then if you get (really) unlucky, the same race happens again for the
existing code:

vma_iter_set(vmi, from_addr);
if (vma != vma_next(vmi))
    goto fallback_unlock;

The walk lands in the gap before X, something else is merged into X from
below, the rewalk lands inside X and the advance steps over it again:

        from_addr           vmi
           |                |
           v                v
 |---------| |----------|   |---------|
 |    A    | |     X    |   |    B    |
 |---------| |----------|   |---------|
                              locked

And suddenly vma == vma_next(vmi), no fallback, and X is never reported.

With the new approach you simply can't miss it, as
vma_rcu_iter_maybe_changed() will see a change could have happened, and
vma_range_is_empty() tells you explicitly, with a brand new separate walk,
whether e.g. X is there.

It's finnicky, finnicky stuff, which is probably why AI found it :))

--
Cheers, Lorenzo
