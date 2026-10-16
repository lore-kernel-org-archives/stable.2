Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856E539DBF4;
	Fri, 16 Oct 2026 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138761; cv=none; b=SycxVb3HL4DrykYXtvv+JOdnrCmnPf46CNa5i64h4OQVPvq/IW6emEqlbBrGwIgdIwA52aI1NPF9bgEGbIplT2BkHhdeAINu8UUcgNxXfQu3PwY93dlTLnU9ecAZ8x/IvFYKJ7BOBtoKVjLrpaWoI+ZV6hlbMu7JitPfuTHpCuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138761; c=relaxed/simple;
	bh=b6ijeQbZkhXZF0auksHQQ9XBIz+S33XRaGZjlyO4vGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJf5yjloLQJrpg8wnj5nbl61+xA0jB3lB16rWyZqnteyXdD8ZUh3+B6K1vYDl3XCz1MRvSOEeTmEAIV2uOJXWlUYu3afobkfGRvnA+s71xTOK56WgaBbJyfUycordRNitGgHBsGtKEcKTjGI2ne6QbLMsSYZG2pDNwS+ngp0kcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ev09OFLL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ev09OFLL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB111F000C4;
	Fri, 16 Oct 2026 08:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792138760;
	bh=JN5TVC//3O1ip10wW+8mi89WV09HEjoNN46Wit82ehw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ev09OFLLtBq9nlj0KDPf9/IRstqtsFz6Ma9lLNEXCK2KFDc8mIwCsD6RkeuW1o9Pn
	 L1tsgKuXM3Vc4nO+qGqC/yRqr/LgVTCxJ8JTrRCv80wO74W4u0WZCzTFCeNH/KCsuz
	 Ej+tFS73V67Vigzz5INsrTgs/0GbW9IJRGhER7LjpjNaTh2qF/RErjWDwFIj3wZDMC
	 4600l59QruiRbPJR1xEsyvCpDEgAM7wwLwfQe4XQB0nBqP0WDW7iIQLn9+kLdCx3NC
	 DLUbbWC4bn4uBpjd8S1NyvsLr695f0/LN/geC7Ni3tVb2iTM2ZoRUzHk8W4YChP+e+
	 7cDw+MENd6qTw==
Date: Fri, 16 Oct 2026 09:19:13 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Daehyeon Ko <4ncienth@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/vma: avoid spurious write locks when mm->mm_lock_seq
 overflows
Message-ID: <atHa3-KlMPg6oy8v@gremlin>
References: <20261015-fix-vma-lock-overflow-v1-1-01beb245d9da@kernel.org>
 <f5548d05-5aec-42d0-b9d9-c14fb575dec9@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5548d05-5aec-42d0-b9d9-c14fb575dec9@gmail.com>

It seems likely that you're using AI to generate these review points. Please do
say if you're doing that, thanks.

Normally that'd be totally unwelcome, but both Sashiko + local AI missed these,
and I have made mistakes here I need to fix, so this is actually useful...

On Fri, Oct 16, 2026 at 09:41:28AM +0200, Jose A. Perez de Azpillaga wrote:
> On 10/15/26 10:31 PM, Lorenzo Stoakes (ARM) wrote:
> [snip]
>
> > The reset, performed in reset_vma_seqcounts(), only needs to WRITE_ONCE()
> > the value. The stores follow the smp_wmb() in do_raw_write_seqcount_end(),
> > so a reader observing a reset value also observes the VMA modifications
> > made under the write lock.
>
> the writer side looks fine, but what orders it on the reader side?
> raw_read_seqcount() is just an smp_load_acquire() since d0dd066a0fa2,
> not the smp_rmb() the comment mentions, so the earlier
> READ_ONCE(vma->vm_lock_seq) isn't ordered against the later vma reads.
> couldn't a reader on arm64 see the reset 0 with the old odd
> mm_lock_seq, pass the parity check and read stale vma fields? would
> smp_load_acquire(&vma->vm_lock_seq) be enough?

Yup that's a mistake, will fix on respin.

>
> [snip]
>
> > Cc: stable@vger.kernel.org
>
> the parity check relies on e5e7fb278e59. before that, mm_lock_seq only
> increments on unlock, so locked values can be odd or even. should this
> be limited to 6.14+, with a note that older trees need a different fix?
> a straight backport of the odd check would ignore write locks taken on
> even cycles.

I have a plan for older kernels (just make the value 64 bit...)

>
> [snip]
>
> > +	/*
> > +	 * The VMA seqcount is always odd if locked. An even value can only be
> > +	 * the zero stored by reset_vma_seqcounts(), never a write lock.
> > +	 */
>
> vma_lock_init() now stores 0 too, so this isn't quite true, is it?

Yes it is true, because as the commit message and I think even comments say, the
VMA is not visible when detached, but it is visible when attached, at which
point a write lock will have been acquired by definition, hence non-zero.

I guess I could add a point about attached here.

>
> [snip]
>
> > -static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
> > -						    struct vm_area_struct *vma)
> > +static struct vm_area_struct *vma_start_read(struct mm_struct *mm,
> > +					     struct vm_area_struct *vma)
>
> is dropping the inline intended?

Yes. inline in C files is useless.

>
> [snip]
>
> > +EXPORT_SYMBOL(reset_vma_seqcounts);
>
> since it has to be exported for the inline mmap_write_unlock(), would a
> __ prefix make sense, so nobody calls it outside vma_end_write_all()?

Yup, that's fair, will update.

>
> I tested it on x86 in qemu with KASAN, lockdep and DEBUG_VM on top of
> mm-unstable and saw no issues, but I'm hesitant about the points above.
> happy to give a Tested-by on the next version :)

Thanks!

--
Cheers, Lorenzo
