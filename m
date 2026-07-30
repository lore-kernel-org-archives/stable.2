Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B53D401A18;
	Thu, 30 Jul 2026 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405354; cv=none; b=Rm+VovIdc0x9BHTqI1dqkzDwYEdjOqmstJyWwEkJj06vl1HrVLKvc+ZQg2mnO5SjdRdTFSoASZGkhhLEOErE4FPCkEUBg+FWiaVIv89m+pQac7ft+upU262r2JYzuzOfeoUos3giRRb/2wkIlplJynccOCPNwBHdNvCSqizT1Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405354; c=relaxed/simple;
	bh=7t6MCDhvx8jwxDe7M9MS0LQMmwEbTuL/05u1isNR8hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Io2+JL4UY2GPLOgl2qUPFvGR67RSCFNk48av1HhTU7mpPLG3aVy6kqxi+GvIK6K3ZtP8FYSVJ4UIco8J/btOfRcHdrPPuBWCs8/5FUQ3v6UV5VCMaL7HHNnYe7UNv64J/EKtlOGuATxkcjBDeW5/BPvW2JiL0Gb+b7hduHuxnBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQAxh5/2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQAxh5/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E3E1F000E9;
	Thu, 30 Jul 2026 09:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785405353;
	bh=LmFHZYjYEhR9L2M0IZ+yGiKhRvSdesMu7mGYmAquCHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iQAxh5/2Z1A09Gu12kg0ZxT+ocYlRgFAurgIufhDqIRNwShR9zznJWDPoCBPOv+vY
	 3osgeFo9Er+RIAO09ZwPAu+62IbwmuwFLeuO06yi2lL2eJcTPzzit4DmNIZok7ga3/
	 lZZs/jNQ7aAiHqCodLRmOvC2gte1hqztTLjiKY3z7yI77J3iLf5IdBqQqQuDsx1iSS
	 EkVxnAqk7tCnATlIy9l/0mWLXqybx0E5cufxhggGNWsUxyS5+lcZ0hYXgTXD55H8fr
	 7NJsmksSobGQTpbDfRcX0sD2KMCFjwG/gCyFmGsawE209FcTcSBr6ngfhybS2rUe47
	 PwFVTE+2bXSpg==
Date: Thu, 30 Jul 2026 10:55:33 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Pankaj Raghav <p.raghav@samsung.com>, 
	Hannes Reinecke <hare@suse.de>, Hugh Dickins <hughd@google.com>, Yang Shi <shy828301@gmail.com>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Hengbin Zhang <uqbarz@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes 2/2] mm/huge_memory: fix huge_zero_pfn race
Message-ID: <amsch6HvEH5IJjfM@lucifer>
References: <20260728-fix-refcounted-huge-zero-v1-0-3f261f5447b4@kernel.org>
 <20260728-fix-refcounted-huge-zero-v1-2-3f261f5447b4@kernel.org>
 <25d560df-6d7e-462a-a987-60a8695793ba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25d560df-6d7e-462a-a987-60a8695793ba@kernel.org>

On Thu, Jul 30, 2026 at 11:22:09AM +0200, David Hildenbrand (Arm) wrote:
> [...]
>
> > So invariants are required - huge_zero_refcount MUST:
> >
> > * Only be set in the huge_zero_lock critical section to ensure
> >   serialisation of huge_zero_pfn, huge_zero_folio and huge_zero_refcount
> >   writes.
> >
> > * Be set non-zero only AFTER huge_zero_[pfn, folio] are set to valid values
> >   so installation of the huge zero folio on read page fault ensures
> >   concurrent is_huge_zero_*() calls correctly identify the huge zero folio.
> >
> > * Be set zero only BEFORE huge_zero_[pfn, folio] are set to NULL and ~0UL
> >   respectively, and atomically.
> >
> > Establish these by:
> >
> > * Only updating huge_zero_refcount in the huge_zero_lock critical section
> >   in get_huge_zero_folio() and shrink_huge_zero_folio_scan().
>
> That is imprecise. huge_zero_refcount is updated (incremented) outside of
> huge_zero_lock in get_huge_zero_folio().

You're right.

->

* Only setting huge_zero_refcount to zero or an absolute value in the
  huge_zero_lock critical section in get_huge_zero_folio() and
  shrink_huge_zero_folio_scan() and updating atomically elsewhere.

Seems better?

>
> >
> > * Using atomic_set_release(&huge_zero_refcount) in get_huge_zero_folio()
> >   after huge_zero_[pfn, folio] are set. This is paired with
> >   atomic_inc_not_zero() to ensure atomic_inc_not_zero() only observes a
> >   non-zero value if huge_zero_[pfn, folio] are set.
>
> That makes sense, yes.
>
> >
> > * Using atomic_cmpxchg() in shrink_huge_zero_folio_scan() to ensure that it
> >   is set zero only when equal to 1 and set atomically.
>
> What we already do, yes.

Yup, point is it's part of why the invariant holds.

>
> >
> > * atomic_cmpxchg() being fully ordered ensures this is done prior to
> >   huge_zero_[folio, pfn] being set to NULL and ~0UL respectively.
>
> Which is always the case for atomic_cmpxchg() I think, yes.

Yup.

>
> [...]
>
> >
> > @@ -270,7 +272,8 @@ void mm_put_huge_zero_folio(struct mm_struct *mm)
> >  static bool get_huge_zero_folio(void)
> >  {
> >  	struct folio *zero_folio;
> > -retry:
> > +
> > +	/* Paired with atomic_set_release(). */
> >  	if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
> >  		return true;
> >
> > @@ -278,17 +281,21 @@ static bool get_huge_zero_folio(void)
> >  	if (unlikely(!zero_folio))
> >  		return false;
> >
> > -	preempt_disable();
> > -	if (cmpxchg(&huge_zero_folio, NULL, zero_folio)) {
> > -		preempt_enable();
> > +	/* Paired with critical section in shrink_huge_zero_folio_scan(). */
> > +	spin_lock(&huge_zero_lock);
> > +	if (huge_zero_folio) {
> > +		/* Somebody else already installed it. */
> > +		atomic_inc(&huge_zero_refcount);
>
> You replace the retry loop by an atomic_inc() here.
>
> That works now by moving the atomic_cmpxchg() in shrink_huge_zero_folio_scan()
> under the lock as well, so it cannot go away concurrently.

Yup. The retry logic in general would be silly now.

>
> Worth spelling that out in the patch description (unless I missed it).

OK.

>
> > +		spin_unlock(&huge_zero_lock);
> >  		folio_put(zero_folio);
> > -		goto retry;
> > +		return true;
> >  	}
> > +	WRITE_ONCE(huge_zero_folio, zero_folio);
> >  	WRITE_ONCE(huge_zero_pfn, folio_pfn(zero_folio));
> > +	/* Paired with atomic_inc_not_zero(). +1 for shrinker pin. */
> > +	atomic_set_release(&huge_zero_refcount, 2);
>
> Ah, that must now go into the lock as well, otherwise the concurrent
> atomic_inc() would be problematic as well.

Yup. It's all very delicate.

>
> > +	spin_unlock(&huge_zero_lock);
> >
> > -	/* We take additional reference here. It will be put back by shrinker */
> > -	atomic_set(&huge_zero_refcount, 2);
> > -	preempt_enable();
> >  	count_vm_event(THP_ZERO_PAGE_ALLOC);
> >  	return true;
> >  }
> > @@ -312,15 +319,22 @@ static unsigned long shrink_huge_zero_folio_count(struct shrinker *shrink,
> >  static unsigned long shrink_huge_zero_folio_scan(struct shrinker *shrink,
> >  						 struct shrink_control *sc)
> >  {
> > -	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
> > -		struct folio *zero_folio = xchg(&huge_zero_folio, NULL);
> > -		BUG_ON(zero_folio == NULL);
> > +	struct folio *zero_folio;
> > +
> > +	/* Paired with critical section in get_huge_zero_folio(). */
> > +	scoped_guard(spinlock, &huge_zero_lock) {
> > +		/* Paired with atomic_inc_not_zero() in get_huge_zero_folio(). */
> > +		if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) != 1)
> > +			return 0;
> > +
> > +		zero_folio = huge_zero_folio;
> > +		VM_WARN_ON_ONCE(!huge_zero_folio);
> > +		WRITE_ONCE(huge_zero_folio, NULL);
> >  		WRITE_ONCE(huge_zero_pfn, HUGE_ZERO_UNSET_PFN);
> > -		folio_put(zero_folio);
> > -		return HPAGE_PMD_NR;
> >  	}
>
> One important point: The folio can't get freed and reallocated before we updated
> huge_zero_folio/huge_zero_pfn I think.

It's non-LRU + set not-rmappable so there's nothing that would do that AFAICT.

>
> The folio_put() should involve a full memory barrier (atomic RMW) and not get
> reordered.

Yeah will mention in commit msg.

>
> So we cannot misclassify the folio in new context as still being the zero folio.
>
> LGTM, thanks!

Thanks!

>
> --
> Cheers,
>
> David

CHeers, Lorenzo
