Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B74D4028F7;
	Thu, 30 Jul 2026 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403338; cv=none; b=Vt5HFWUM2Dre3Qqm2/CbeWqhHNYwrbag6gyX8M/MZYJS1v/vI5ryWs6C5H/6mvA9UnfDafRdE0o+D+qWBXtgmIxIaadaeJ51AapvXHDYXDE5cOgKB0eFfzB5TOrca7YFc3Mlqs1u/a8P7OE/Quy6G+CjAQ+Uosqas3EsE8nYY/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403338; c=relaxed/simple;
	bh=U6W/ER119pnEKBoJgtpOFBN3zpfsqoLZvrELCbUSj9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oP5dChph0PQYlQo2GDaqdo6QkfkAP51cffu/jLMAnxEQ5UHqXi/24BCWXJhQvMH5ldDd25icsJLhzGtfxD4N2sEEc7J+B4nmnnQol5jsmiXCWgjb8AM5BiTjnq/PhK3NgYrvrW1rYmkgT5FSxqJm9jHNyVUFBtEdaSF4TLt/5Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GX8vXUoM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GX8vXUoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4731F000E9;
	Thu, 30 Jul 2026 09:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785403336;
	bh=tG6cmXvm95wjXcqB8dvCOqPznntDpzBFT2+tmIJffq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GX8vXUoMPS74Qq8B+Tq0b69jgz1uhRRrIyHKabEiUKKHoZ3ViacaCkpqYYKZxIznj
	 qKZujjl4n7lvWZvgjgYibkx1/Q6L1sJivWDRu9PqF3gpRocIh3EfbVSQiv42bW3l8Z
	 H6cQ6UXiyy3c+DwXRrc21ng5ngJkQm7p2lN89KowbtQNAUA3kxIGG5At/zQx1P4Y5p
	 hMSTe1AjsBHgikiEWt5QFdZjCvbmTZNg3IwjkZia+m9H40VM8RNB10KIzgPRPTcAMh
	 WIoAmUZQen4gm8AKrSCNKIMRyxdx374WRlzA7z6xPR9p120jYLbXl20S/OZPoVTImi
	 LC6oeUUSdNBiA==
Message-ID: <25d560df-6d7e-462a-a987-60a8695793ba@kernel.org>
Date: Thu, 30 Jul 2026 11:22:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-hotfixes 2/2] mm/huge_memory: fix huge_zero_pfn race
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Pankaj Raghav <p.raghav@samsung.com>,
 Hannes Reinecke <hare@suse.de>, Hugh Dickins <hughd@google.com>,
 Yang Shi <shy828301@gmail.com>, Kiryl Shutsemau <kas@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Hengbin Zhang <uqbarz@gmail.com>, stable@vger.kernel.org
References: <20260728-fix-refcounted-huge-zero-v1-0-3f261f5447b4@kernel.org>
 <20260728-fix-refcounted-huge-zero-v1-2-3f261f5447b4@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260728-fix-refcounted-huge-zero-v1-2-3f261f5447b4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[...]

> So invariants are required - huge_zero_refcount MUST:
> 
> * Only be set in the huge_zero_lock critical section to ensure
>   serialisation of huge_zero_pfn, huge_zero_folio and huge_zero_refcount
>   writes.
> 
> * Be set non-zero only AFTER huge_zero_[pfn, folio] are set to valid values
>   so installation of the huge zero folio on read page fault ensures
>   concurrent is_huge_zero_*() calls correctly identify the huge zero folio.
> 
> * Be set zero only BEFORE huge_zero_[pfn, folio] are set to NULL and ~0UL
>   respectively, and atomically.
> 
> Establish these by:
> 
> * Only updating huge_zero_refcount in the huge_zero_lock critical section
>   in get_huge_zero_folio() and shrink_huge_zero_folio_scan().

That is imprecise. huge_zero_refcount is updated (incremented) outside of
huge_zero_lock in get_huge_zero_folio().

> 
> * Using atomic_set_release(&huge_zero_refcount) in get_huge_zero_folio()
>   after huge_zero_[pfn, folio] are set. This is paired with
>   atomic_inc_not_zero() to ensure atomic_inc_not_zero() only observes a
>   non-zero value if huge_zero_[pfn, folio] are set.

That makes sense, yes.

> 
> * Using atomic_cmpxchg() in shrink_huge_zero_folio_scan() to ensure that it
>   is set zero only when equal to 1 and set atomically.

What we already do, yes.

> 
> * atomic_cmpxchg() being fully ordered ensures this is done prior to
>   huge_zero_[folio, pfn] being set to NULL and ~0UL respectively.

Which is always the case for atomic_cmpxchg() I think, yes.

[...]

>  
> @@ -270,7 +272,8 @@ void mm_put_huge_zero_folio(struct mm_struct *mm)
>  static bool get_huge_zero_folio(void)
>  {
>  	struct folio *zero_folio;
> -retry:
> +
> +	/* Paired with atomic_set_release(). */
>  	if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
>  		return true;
>  
> @@ -278,17 +281,21 @@ static bool get_huge_zero_folio(void)
>  	if (unlikely(!zero_folio))
>  		return false;
>  
> -	preempt_disable();
> -	if (cmpxchg(&huge_zero_folio, NULL, zero_folio)) {
> -		preempt_enable();
> +	/* Paired with critical section in shrink_huge_zero_folio_scan(). */
> +	spin_lock(&huge_zero_lock);
> +	if (huge_zero_folio) {
> +		/* Somebody else already installed it. */
> +		atomic_inc(&huge_zero_refcount);

You replace the retry loop by an atomic_inc() here.

That works now by moving the atomic_cmpxchg() in shrink_huge_zero_folio_scan()
under the lock as well, so it cannot go away concurrently.

Worth spelling that out in the patch description (unless I missed it).

> +		spin_unlock(&huge_zero_lock);
>  		folio_put(zero_folio);
> -		goto retry;
> +		return true;
>  	}
> +	WRITE_ONCE(huge_zero_folio, zero_folio);
>  	WRITE_ONCE(huge_zero_pfn, folio_pfn(zero_folio));
> +	/* Paired with atomic_inc_not_zero(). +1 for shrinker pin. */
> +	atomic_set_release(&huge_zero_refcount, 2);

Ah, that must now go into the lock as well, otherwise the concurrent
atomic_inc() would be problematic as well.

> +	spin_unlock(&huge_zero_lock);
>  
> -	/* We take additional reference here. It will be put back by shrinker */
> -	atomic_set(&huge_zero_refcount, 2);
> -	preempt_enable();
>  	count_vm_event(THP_ZERO_PAGE_ALLOC);
>  	return true;
>  }
> @@ -312,15 +319,22 @@ static unsigned long shrink_huge_zero_folio_count(struct shrinker *shrink,
>  static unsigned long shrink_huge_zero_folio_scan(struct shrinker *shrink,
>  						 struct shrink_control *sc)
>  {
> -	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
> -		struct folio *zero_folio = xchg(&huge_zero_folio, NULL);
> -		BUG_ON(zero_folio == NULL);
> +	struct folio *zero_folio;
> +
> +	/* Paired with critical section in get_huge_zero_folio(). */
> +	scoped_guard(spinlock, &huge_zero_lock) {
> +		/* Paired with atomic_inc_not_zero() in get_huge_zero_folio(). */
> +		if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) != 1)
> +			return 0;
> +
> +		zero_folio = huge_zero_folio;
> +		VM_WARN_ON_ONCE(!huge_zero_folio);
> +		WRITE_ONCE(huge_zero_folio, NULL);
>  		WRITE_ONCE(huge_zero_pfn, HUGE_ZERO_UNSET_PFN);
> -		folio_put(zero_folio);
> -		return HPAGE_PMD_NR;
>  	}

One important point: The folio can't get freed and reallocated before we updated
huge_zero_folio/huge_zero_pfn I think.

The folio_put() should involve a full memory barrier (atomic RMW) and not get
reordered.

So we cannot misclassify the folio in new context as still being the zero folio.

LGTM, thanks!

-- 
Cheers,

David
