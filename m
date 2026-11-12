Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489413;
	b=MjQ3jYCSBaOUN1mFLBWnJnrHUm3oxzeGvcvHmmQZbnL/Ey1wZYsSgFbgc6SPZOU92P3G
	 oGoRlcXzpiyYs2Q9yom1/uxOMTGbxEdta8zC0zOOGHHvA9EJiZ0fLO40HPtx61RDEUhXL
	 FwZbRnJL5jnkztnxSBhLimgqC7hWr+oFumzL6zdokF3Kac4uGxpoMkEvsqdiWqDz2yMfX
	 Lv5mCH2e4GhGVAb/QrPOPNZkqWXqEmkWX6CPOvOIGo5XmOqSudVcfWXO5FXjeaEdCK3zz
	 iKrvhpd9Rl4yxMh6GW0dbCNb2eqDf5lLHfbipSRE5lSm9EyFdlJdRyyA52QkyznhF+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489413;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=i2Oes8RZDkSEXFI8H+2vd0Da2cFliXVxwNXn1JhwifA=;
	b=R6CpjBXbo9UkPQwauKY841zadvBR08T6flCTcsHMJnIuDrGCX8TJ68dYJISl1CRYRiF3
	 rlHKnZEYJbEMy/C6I1D+NP2M8vkzTnpw0gUxnj2ulyrBCDEAguw7IAUqtNVqZhRmH/lvn
	 JILmt45F5oZZmsJWgnZ9pj5cveADbENyimM+C1ScjwX0eUqUHjZYafGt6mVRAiG87DCaj
	 JYHMFbRSLGeWYyeb9RngjgHgU3qPnZqyk5Q9HYk9L42BEy4ZmzpD1o4DyTA4L1S6GuwXU
	 EeRMVqq+qyi/Q+e7BXgLkjFDgHk1XZRi8iLbt5/r/0KgPbdHp4HtqGDFwjOkUNec5HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OWHHd/ls";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72201606A323;
	Thu, 12 Nov 2026 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWHHd/ls
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5611F00A05;
	Thu, 12 Nov 2026 13:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794489413;
	bh=i2Oes8RZDkSEXFI8H+2vd0Da2cFliXVxwNXn1JhwifA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OWHHd/lsZYkX+Jq2T55F046KvGJkwVb6ZNJHRXrnIltU3y9ehCady9llvQYz7eT6C
	 b6gwiEygyCndpaJIRyg+GavO8iI+YCfZ2Uwp35NT0l9voskGAjqZjcNzrW7ElwS9vq
	 xA2xR8/J9T5ZBK4HMLhcLMY5URFYgvGfGjWh0b1z5FjYipbPVvuLhazpnlXmjoISp0
	 28UuXxrC6BUTP/lTG8Y9aJkxGNLyQrFX3s04RL5B3nRopwvnht2pma59Ed4xyBMoWC
	 GkpVbhIoxBJV+NY5ZH8W+H4wvUY/uz5MDTIPd+UxtdLDO+3fcrB0mm6Vh6AdesMpbH
	 e/KSk7ObVX1PA==
Message-ID: <86206f64-fefa-4a13-95bc-eddf756eecc8@kernel.org>
Date: Thu, 12 Nov 2026 14:16:33 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] mm: limit pagecache folio refcount when mapping
 pages
To: Pedro Falcato <pfalcato@suse.de>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard
 <jhubbard@nvidia.com>, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, netdev@vger.kernel.org, Chris Mason
 <mason@kernel.org>, stable@vger.kernel.org
References: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
 <20261110-refcount_overflow_stable-v3-1-318625d63a98@kernel.org>
 <avW0HGjF6wuqn12T@pedro-suse.tail5790ac.ts.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <avW0HGjF6wuqn12T@pedro-suse.tail5790ac.ts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Mostly LGTM, with some comments:
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Thanks for the review, Pedro!

> 
>> ---
>>  include/linux/mm.h | 35 +++++++++++++++++++++++++++++++----
>>  mm/filemap.c       |  6 ++++++
>>  mm/huge_memory.c   | 29 +++++++++++++++++++++++++++--
>>  mm/memory.c        | 33 +++++++++++++++++++++++++++++----
>>  mm/migrate.c       | 11 +++++++++++
>>  mm/userfaultfd.c   |  4 ++++
>>  mm/util.c          | 18 ++++++++++++++++++
>>  7 files changed, 126 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index e6da76fbe8e83..6c7c29a086bd1 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2229,9 +2229,36 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
>>   *   back into memory.
>>   */
>>  
>> -/* 127: arbitrary random number, small enough to assemble well */
>> -#define folio_ref_zero_or_close_to_overflow(folio) \
>> -	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
>> +/* Leave separate reserves for administrators and concurrent reference gains. */
>> +#define FOLIO_REF_COUNT_LIMIT		(INT_MAX - (1U << 26))
>> +#define FOLIO_REF_COUNT_ADMIN_LIMIT	(INT_MAX - (1U << 25))
>> +
>> +bool __folio_ref_count_over_limit(unsigned int ref_count);
>> +
>> +/**
>> + * folio_ref_count_over_limit - Check whether to refuse more folio references.
>> + * @folio: The folio.
>> + *
>> + * Check before adding page table mappings or other significant refcount users
>> + * to pagecache folios (!hugetlb), either before acquiring references or
>> + * afterwards with rollback if the operation is refused.
>> + *
>> + * Checking other folios does no harm.
>> + *
>> + * This check is an approximation; we leave some headroom such that concurrent
>> + * increments, batches, temporary references, or other bounded refcount
>> + * consumers are not a problem.
>> + *
>> + * Return: True if the caller should refuse the operation, false otherwise.
>> + */
>> +static inline bool folio_ref_count_over_limit(const struct folio *folio)
>> +{
>> +	const unsigned int ref_count = folio_ref_count(folio);
>> +
>> +	if (likely(ref_count < FOLIO_REF_COUNT_LIMIT))
>> +		return false;
>> +	return __folio_ref_count_over_limit(ref_count);
>> +}
>>  
>>  /**
>>   * folio_get - Increment the reference count on a folio.
>> @@ -2243,7 +2270,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
>>   */
>>  static inline void folio_get(struct folio *folio)
>>  {
>> -	VM_BUG_ON_FOLIO(folio_ref_zero_or_close_to_overflow(folio), folio);
>> +	VM_WARN_ON_FOLIO(folio_ref_count(folio) <= 0, folio);
>>  	folio_ref_inc(folio);
>>  }
>>  
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 9871b4f32a916..0f6d57432a7e5 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -3968,6 +3968,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>>  		unsigned long end;
>>  		vm_fault_t map_ret;
>>  
>> +		if (unlikely(folio_ref_count_over_limit(folio))) {
>> +			folio_ref_dec(folio);
>> +			goto next;
>> +		}
>> +
> 
> It's a bit odd that you take a ref, only to check later if we're over the
> limit, and ditch the folio. Could you move this to next_uptodate_folio()?

That might be even better (and avoids one conflict with Andrew's tree). Let me
take a look.

> 
>>  		addr += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
>>  		vmf->pte += xas.xa_index - last_pgoff;
>>  		last_pgoff = xas.xa_index;
>> @@ -4009,6 +4014,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>>  					   mmap_miss - 1);
>>  		}
>>  
>> +next:
>>  		folio_unlock(folio);
>>  	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
>>  	add_mm_counter(vma->vm_mm, folio_type, rss);
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 4608540e40d46..439cfe446cea4 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1626,6 +1626,7 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
>>  {
>>  	struct mm_struct *mm = vma->vm_mm;
>>  	pgtable_t pgtable = NULL;
>> +	vm_fault_t ret = VM_FAULT_NOPAGE;
>>  	spinlock_t *ptl;
>>  	pmd_t entry;
>>  
>> @@ -1662,6 +1663,10 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
>>  		if (is_huge_zero_folio(fop.folio)) {
>>  			entry = pmd_mkspecial(entry);
>>  		} else {
>> +			if (unlikely(folio_ref_count_over_limit(fop.folio))) {
>> +				ret = VM_FAULT_SIGBUS;
>> +				goto out_unlock;
>> +			}
>>  			folio_get(fop.folio);
> 
> I see you use this pattern often. Would it make sense to have a
> bool folio_get_unless_overflow()?

I commented somewhere (in v2 I think) that I played with using
folio_get_checked() from #2, but didn't quite like it so I discarded it as

(a) it cannot be used everywhere here, as I'd need more functions to add
multiple references. next_uptodate_folio() also could use it as I would need yet
another temporary helper for a try_get().

(b) these changes here are going to get reverted fairly soon once I change the
way how mappings are refcounted (which is, unfortunately, not suitable for
stable, otherwise I wouldn't be throwing in this temporary change in the first
place)

So everything that is expected to stay in later patches uses the proper helper.

[...]

>>  
>> +		if (unlikely(folio_ref_count_over_limit(folio))) {
>> +			/* Skip this PUD; it can be faulted in later. */
>> +			ret = (dst_vma->vm_flags & VM_MIXEDMAP) ? -ENOMEM : 0;
> 
> A comment as to what's going on here with VM_MIXEDMAP would be useful. I guess
> the idea is that faulting on a mixedmap later will not necessarily hand you the
> exact same page fault result?

I can throw in a comment, yes.

[...]

>> +bool __folio_ref_count_over_limit(unsigned int ref_count)
>> +{
>> +	if (ref_count >= FOLIO_REF_COUNT_ADMIN_LIMIT)
>> +		return true;
>> +	/* Background threads must not consume admin reserves. */
>> +	if (current->flags & PF_KTHREAD)
>> +		return true;
>> +	/* Neither must interrupt contexts on behalf of the interrupted task. */
>> +	if (!in_task())
>> +		return true;
>> +	/* Capability checks are not safe with IRQs disabled. */
>> +	if (irqs_disabled())
>> +		return true;
>> +	/* Use the task's credentials, which filesystem overrides cannot change. */
>> +	return !has_capability_noaudit(current, CAP_SYS_RESOURCE);
>> +}
> 
> In case this function ever returns over limit, we probably want to log this
> in the kernel log. If this function gets the folio you could even print
> the problematic file offset/inode/filesystem/etc. Ratelimited of course.

You mean, if this function returns "true", right? Is printing always fine?
(e.g., irqs disabled?)

> 
>> +EXPORT_SYMBOL_GPL(__folio_ref_count_over_limit);
> 
> I'm fairly sure this will break the build for a number of non-GPL drivers
> when calling folio_get() with CONFIG_DEBUG_VM=y.

You mean, breaking OOT drivers, right? I can switch to EXPORT_SYMBOL if that's a
concern.

-- 
Cheers,

David
