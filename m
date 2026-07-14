Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD603806B8;
	Tue, 14 Jul 2026 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041122; cv=none; b=urxSI0jO9C3yDX+TT6uRvGazteA3VD0jSUQ3aCfWoR3y+CDsI/RCeiIsir7PbYSGk8TcuDlMihGu8jnJwRakeDFrshrIk+rrYwgD0uBkwqImf6SyeNBGWDZWpGpaS4HMlZwK7l4lrqOmJUxjWkiN4pda2oagYYTjKJDyr0lKppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041122; c=relaxed/simple;
	bh=crNfwxjYmfbBRjp1JNdkVG2Bccrjzdqcg8iEAjXEvUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQRuSPoi5uHBR6xabaMBAt19/whHlJOby8AKg2yP7i4A9dLSt37aJ4MD48ATffLyPl7BMrHmckStTFetBDIzqe1+4i2lRWepRjpms5zljICtkV+joPqmgZD+l+GAcgyCh4I3EZlE75aMCXeRudKllpfznNqXzvFwWCmE+4K159c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRM3rkZt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRM3rkZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321A31F00A3A;
	Tue, 14 Jul 2026 14:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784041121;
	bh=/rDw+3jasEMQfWDR5/QI5ODPO0V9yA5DbFG2otOFc44=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GRM3rkZtto20bP3/Luu98NsJmLDkagWlrqsOixM8cvwNyxbbeaLw5UIoaiRzufdXT
	 KWMeO9vlv+CN38PSZJYzRmPrecqS/9elUGuXIIRUZ6X/IFUUZ+TSpAtpSkvzot5fW/
	 edQqYyE+wqRS+d2jUg1noS/tJDlsioUV07fohRUwI9zDrQGhiS8NVoWzvegJ3PE5iX
	 Gav5cG+5LPW46u96Cr6is8LYT+jyPZcVJg1yT9jAd0Lz1SYlTRVrcohaBGymOYSWFl
	 W1Da1iowMFfia0NZNLdEbAupRIiX54l4jr0Voa4QeJeM4P1c2NUL9R57RbXoBrtPjf
	 Fkt/XC1qhYLow==
Message-ID: <18fe5529-2ad5-4330-a362-708a152bacee@kernel.org>
Date: Tue, 14 Jul 2026 16:58:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mm/memory-failure: keep the folio, not the
 poisoned subpage, locked across split
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Hao Zhang <zhanghao1@kylinos.cn>,
 Hao Zhang <hao_zhang_kdev@163.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260714122344.351895-1-kirill@shutemov.name>
 <20260714122344.351895-2-kirill@shutemov.name>
 <c4aa63df-30ab-464d-bd0b-48dc37c8e6ba@kernel.org>
 <alZNYYsybKZA0eJb@thinkstation>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <alZNYYsybKZA0eJb@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/26 16:53, Kiryl Shutsemau wrote:
> On Tue, Jul 14, 2026 at 03:01:46PM +0200, David Hildenbrand (Arm) wrote:
>> On 7/14/26 14:23, Kiryl Shutsemau wrote:
>>> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
>>>
>>> try_to_split_thp_page() locked the poisoned page and passed it to
>>> split_huge_page_to_order(), which returns that very page locked to the
>>> caller.  For a tail page that means __folio_split() runs with @lock_at
>>> pointing into the middle of the folio.
>>>
>>> __folio_split() dereferences the mapping after the split completes
>>> (shmem_uncharge(), i_mmap_unlock_read()).  The only thing keeping the
>>> inode alive across that is the locked @lock_at folio: while it stays in
>>> the page cache, eviction cannot complete.
>>>
>>> But a tail @lock_at can lie beyond EOF -- e.g. part of a shmem THP that
>>> reaches past i_size while the file is being truncated.  The split then
>>> drops it from the page cache yet still returns it locked, so the pin is
>>> gone and a racing final iput() can evict and RCU-free the inode while
>>> __folio_split() is still running:
>>>
>>>   BUG: KASAN: slab-use-after-free in __up_read+0x634/0x790
>>>    i_mmap_unlock_read include/linux/fs.h:537 [inline]
>>>    __folio_split+0x732/0x1640 mm/huge_memory.c:4100
>>>    try_to_split_thp_page+0xab/0x390 mm/memory-failure.c:1675
>>>    memory_failure+0x1394/0x26e0 mm/memory-failure.c:2470
>>>
>>>   Freed by task 4601:
>>>    shmem_free_in_core_inode+0x54/0xb0 mm/shmem.c:5177
>>>    evict+0x57f/0xac0 fs/inode.c:870
>>>
>>> Split the folio as a folio, via split_folio_to_order(), so the head is
>>> the anchor left locked.  The head is piece 0, which the beyond-EOF drop
>>> loop never removes (it starts at folio_next(folio)), so the split always
>>> leaves it in the page cache and the inode stays pinned for the whole of
>>> __folio_split().  memory_failure() and soft offline re-lock the poisoned
>>> subpage's folio themselves after the split, so they do not depend on it
>>> being returned locked.
>>>
>>> Reported-by: Hao Zhang <zhanghao1@kylinos.cn>
>>> Closes: https://lore.kernel.org/linux-mm/20260710071344.GA106129@zh-pc
>>> Fixes: baa355fd3314 ("thp: file pages support for split_huge_page()")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>>> ---
>>>  mm/memory-failure.c | 13 ++++++++++---
>>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index 51508a55c405..68d42cbed458 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -1657,11 +1657,18 @@ static int identify_page_state(unsigned long pfn, struct page *p,
>>>  static int try_to_split_thp_page(struct page *page, unsigned int new_order,
>>>  		bool release)
>>>  {
>>> +	struct folio *folio = page_folio(page);
>>>  	int ret;
>>>  
>>> -	lock_page(page);
>>> -	ret = split_huge_page_to_order(page, new_order);
>>> -	unlock_page(page);
>>> +	/*
>>> +	 * Lock and split at the head, not the poisoned subpage: __folio_split()
>>> +	 * keeps the anchor folio locked and needs it to stay in the page cache
>>> +	 * to pin the inode. A tail beyond EOF would be dropped yet returned
>>> +	 * locked, losing that pin. The caller re-locks @page afterwards.
>>> +	 */
>>> +	folio_lock(folio);
>>> +	ret = split_folio_to_order(folio, new_order);
>>> +	folio_unlock(folio);
>>
>> With a non-uniform split it would actually make a difference: we'd want to split
>> such that we the other folio pages minimal.
>>
>>  split_folio_to_order() always seems to end up in
>> __split_huge_page_to_list_to_order() where we do a SPLIT_TYPE_UNIFORM.
>>
>> I recall discussing with Zi and Willy that in the future we'd want to convert
>> more places to do a non-uniform split.
>>
>> So I'm afraid that would just re-introduce the problem then.
> 
> Right. Non-uniform split can be useful.
> 
> But my patch is completely broken because code expects the pin to be on the
> @page, not on the head. put_page() few lines down can explode already.

Yeah.

> 
> So the fix does not belong in memory_failure(). It belongs in
> __folio_split(), and it is really just 2/5: refuse the split with -EBUSY
> when @lock_at is at or beyond the sampled EOF.
> 
> The safety then sits in __folio_split() regardless of caller or split type,
> which should also cover your non-uniform worry.
> 
> The behavioural change is that memory_failure() reports a beyond-EOF
> poisoned tail as unsplit (MF_FAILED) instead of recovered, and kills the
> mappers instead of splitting the page off. What we give up is salvaging
> the folio's healthy pages and the clean unmap -- both low value for a page
> that is beyond EOF and getting truncated away. Containment is unaffected:
> PageHWPoison is set before the split and free_pages_prepare() keeps a
> poisoned page out of the buddy allocator, so the bad page never comes back
> regardless.
> 
> The alternative, if we would rather keep the recovered outcome, is to leave
> @lock_at as the poisoned page and move i_mmap_unlock_read() (and
> shmem_uncharge()) ahead of the after-split unlock loop, so every mapping
> dereference happens while @folio -- the head, within EOF -- still pins the
> inode. That is close to Hao's original patch. It works, but it rests on "no
> mapping dereference after the unlock loop", which is its own fragility.

At least it can be well documented.

> 
> I lean towards the -EBUSY guard.

The latter approach seems cleaner to me, but let's hear others as well.

-- 
Cheers,

David
