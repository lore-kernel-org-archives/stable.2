Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B8449E5D0;
	Wed, 14 Oct 2026 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965537; cv=none; b=AG4uz97obQ8zfssWT/l+YUMiVeTGCUADoFp37vX97ZraZjOxVAlbxRQAQHEQsriYYJVMCfgPuI8gzLWGeJWFVNWRTv4+1atQRA+Wq9WL8HnM5qNa1E4E1zjRiToYlsLR7xRspICF5h6EjNfgm1/5+QV9qnv3epjEH4wJJK0W2o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965537; c=relaxed/simple;
	bh=TlCfKWp5oH9BwqHtatiQU/mvDc0K3udy3jxuQ/8Ca3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XcAJU/PXVmwJBCO//T3akjx92kHGACRgJsqng+DNfc1A6cF0/ZGicEdfiKTBt8hQL2WcNZNq4vdMoL2wbztr6I7BxJLsFjJIgcJJpNzk1IJiZAu4+XKBpTAHPDxAQpt+a4yP7gbROksG0IorTC9xUjAQduyvnwxJ8OSeywSA84o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tpkb7ata; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tpkb7ata"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408071F00893;
	Wed, 14 Oct 2026 08:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791965533;
	bh=kjyStItez/lrqfbwrXHGoAACE+/nkxndtKi9r0jfGSc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Tpkb7ataYiB/8Njw/Xj3hVOnUVPs++6DaKbTyUJBA9VMD0aq9yUZKXe0/hlKuEpTY
	 mnUKX5xn+csTxxy/t1qlythXN0JwfhJWmIa7GxyN1Irq36gpBnxqWEHQfkkWKON9tG
	 LrHSm4oY69zjlKpCTaczIRAgC8jzDLN97l3wH09AyqUoz7Z/kI6FCBByn1ABJad8EH
	 T81WqRh0QCnjpaZOxAymGPBM2pMex0p1HVd9TqYf37voreoS57S9IVZC+6zXfXD4yo
	 WkgZWKYMGwoiNz3TghhRXYd+UY/DQ4KZKDBxHmXVN9iHLfREEAnvz2m0hj+3T+CABX
	 fkNTcgoIA3yBw==
Message-ID: <9add8400-66c1-47e9-b5af-7a4081ebf3c4@kernel.org>
Date: Wed, 14 Oct 2026 10:12:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix address wraparound when scanning large folio PTEs
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Ying Huang <huang.ying.caritas@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Chuanhua Han <hanchuanhua@oppo.com>,
 Kiryl Shutsemau <kas@kernel.org>, Kyle Zeng <kylebot@openai.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261013-folio_pte_scan_range-v1-1-c50dc30bf6ad@kernel.org>
 <as4kvHe9IFZH5qrC@gremlin>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <as4kvHe9IFZH5qrC@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>> Reported-by: Kyle Zeng <kylebot@openai.com>
>> Fixes: d2136d749d76 ("mm: support multi-size THP numa balancing")
>> Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  mm/memory.c | 43 +++++++++++++++++++++++++++++--------------
>>  1 file changed, 29 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 1f5d5f7d39cd2..a3823010aa981 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4933,6 +4933,27 @@ static void check_swap_exclusive(struct folio *folio, swp_entry_t entry,
>>  	} while (--nr_pages);
>>  }
>>
>> +/*
>> + * Get the address range in which a folio might be mapped, assuming its pages
>> + * are mapped consecutively and the folio page at the given idx is mapped at
>> + * the given address.
>> + */
> 
> I know it's a static function but kdoc here might be nice given the number of
> params, including 2 output parameters.

I had that, but decided "not worth it for an internal helper".

Is anything here really that confusing to understand in mm/memory.c context? I
highly doubt it.

> 
> Also then can specify exclusive end, etc.
> 
>> +static void folio_pte_scan_range(const struct folio *folio,
>> +		const struct vm_area_struct *vma, unsigned long addr,
>> +		unsigned long idx, unsigned long *start, unsigned long *end)
> 
> I don't love the name - to me it implies to me that you're scanning the range.
> 
> Maybe clamp_folio_pte_range()? I guess though clamp implies it limits an input
> range.

Ugly.

> 
> Maybe get_folio_pte_range()?

I can just call it "folio_pte_range()". Slightly similar (but different) to
"folio_pte_batch()"

> 
> Also I think it might be useful to have it return the number of pages contained
> within the range?
> 
> Then this below:
> 
> +		folio_pte_scan_range(folio, vma, address, idx, &folio_start,
> +				     &folio_end);
> +		if (unlikely((folio_end - folio_start) >> PAGE_SHIFT != nr))
> 
> Could be:
> 
> +		if (unlikely(get_folio_pte_range(folio, vma, address, idx,
> +						 &folio_start, &folio_end)) != nr)
> 
> OTOH, that's pretty ugly... :))


Not a fan of these semantics.

> 
>> +{
>> +	/* Stay within the page table and VMA boundaries. */
>> +	const unsigned long pmd_start = addr & PMD_MASK;
>> +	const unsigned long pmd_end = pmd_start + PMD_SIZE;
> 
> OK so get the range of the PTE page table.
> 
>> +	const unsigned long lower = max(pmd_start, vma->vm_start);
> 
> Then clamp to VMA start...
> 
>> +	const unsigned long upper = min(pmd_end - 1, vma->vm_end - 1) + 1;
> 
> This is trickier :)
> 
> I guess you're doing this in case either bound is right at wraparound
> somehow?
> 
> But then couldn't the +1 push you over the edge?
> 
> Oh wait no, because then vma->vm_end would have to equal 0, which would
> fail the other-place enforced invariant that vma->vm_start < vma->vm_end.
> 
> So it's pmd_end that could overflow, hence the -1, +1 dance.
> 

Yes. It's fairly common, though, to handle clamping of exclusive ends that way.

> Yeah I kind of hate that, that's a lot of 'just have to know' right there.
> 
> Actually we have pmd_addr_end() already, could we use that?
> 
> #define pmd_addr_end(addr, end)                                         \
> ({      unsigned long __boundary = ((addr) + PMD_SIZE) & PMD_MASK;      \
>         (__boundary - 1 < (end) - 1)? __boundary: (end);                \
> })

As replied elsewhere, I had that, but decided to open-code as pmd_addr_end() has
very weird semantics with folded page tables, where we just don't clamp at all.

I'll sleep over it, but to me using pmd_addr_end() is not particularly better.

> 
> That embeds the trick in the helper and it expresses what you're getting.
> 
> Then it could be:
> 
> 	const unsigned long pmd_start = addr & PMD_MASK;
> 	const unsigned long lower = max(pmd_start, vma->vm_start);
> 	const unsigned long upper = pmd_addr_end(addr, vma->vm_end);
> 
>> +	const unsigned long offset = idx << PAGE_SHIFT;
>> +
>> +	/* Avoid any address wraparounds. */
>> +	*start = addr - min(addr - lower, offset);
> 
> This is also tricky. This is clamping to max(lower, addr - offset) right,
> but being very careful about underflow?
> 
> I don't love the addr - (addr - lower) = lower here, and it feels like it
> embeds a comparison there too. It's all very implicit.
> 
> Actually maybe just naming addr - lower gets us there:
> 
> 	const unsigned long max_offset = addr - lower;
> 	...
> 	*start = addr - min(max_offset, offset);
> 
> There's check_sub_overflow() or you could use a ternary also but both feel
> like they add more complexity than is useful.
> 
>> +	*end = addr + min(upper - addr, folio_size(folio) - offset);
> 
> Same deal here.
> 
> Maybe something like:
> 
> 	const unsigned long max_remaining_bytes = upper - addr;
> 	...
> 	*end = addr + min(max_remaining_bytes, folio_size(folio) - offset);
> 

Sorry, to push back, but are we overthinking this helper here?

I much rather get this fixed quickly then fine tuning some details in a helper
with clear semantics that anybody can understand when looking at it for 1 minute?


-- 
Cheers,

David
