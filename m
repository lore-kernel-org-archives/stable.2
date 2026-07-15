Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF634420495;
	Wed, 15 Jul 2026 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120487; cv=none; b=K7J63IgrJMPA0Jc06AwMbn1HdiekLqvnho0k/qrZEUkwO2OmMniQnKVS/GvNl5nMkqqEeQEX7tMT4p8CifXzOciEXNUxAf2xPNiJJ6oSIz2gp/PgDx7bDIC1thAKV+ePW0le6HYAy3fDvSXVCV8HJsMF7vaINtBIamf/sHawNt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120487; c=relaxed/simple;
	bh=yNI48JaSPVl4jMylxlukTc/KWVLQfKqioRE6j8c//0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvE9K75RPF8Yrh/p00aSKHtIFWptfAOlfi5uQLgWxG7vdjZhPZSBoDeBd/2NCBsWGOwXiy0QVVMNoFTtRyzWKGJJ7KsSy/2JtTNPekOnQY6b6vPuKHyl9N/rIRR+V2JsCRwb1mNv3vZ1aHNew1iPfBORmmjn7pVFc4Vm6tpiHVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWf54nLm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWf54nLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397A31F000E9;
	Wed, 15 Jul 2026 13:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784120485;
	bh=wUXuEqTpyi55WJTpZHqeaTPsyp4qkuq1mFSEddNo1tA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gWf54nLmEwWJANF5qUC6poTKMViOSzEpoFuUKkjJj63i8H9uciYM6Dlgpy27x1WZp
	 4Nw2fRu/qXdKsuvJ6taqOeOQeKbrO9UqxRGcK2DhOjKN3flD4HKVB57Uvj+f14KnVr
	 VPzyVR7iuSIdM4xo2zbz5c40benVATHoca0c+Ls+3c6h6GT44ZSGFrL+6C2UCl6SGd
	 +frsS5rS/CWL4+tNaQu90B+aRXEviBOQwiFgrkYAXSOk8K/bdY9HtIMk2gJW2Cy2MX
	 f31aWYHXfliY5eoDu6elZcL524x422cFRrEthYOJ3xufmQIEmkM8m/Acc+JADTzuvg
	 0r2w6G5b9EWQw==
Message-ID: <feaa5d7f-0717-4309-be90-7fd99ea525c1@kernel.org>
Date: Wed, 15 Jul 2026 15:01:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mm/memory-failure: keep the folio, not the
 poisoned subpage, locked across split
To: Kiryl Shutsemau <kirill@shutemov.name>, Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
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
 <18fe5529-2ad5-4330-a362-708a152bacee@kernel.org>
 <66A57599-EDA0-4E99-B073-F2AE0B2ED708@nvidia.com>
 <alZljHr4Nk3FOpCP@thinkstation> <DJYH202OLKZF.432DAJWF2MGA@nvidia.com>
 <aldjhtfVByHDQXe6@thinkstation>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <aldjhtfVByHDQXe6@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/26 12:42, Kiryl Shutsemau wrote:
> On Tue, Jul 14, 2026 at 01:31:54PM -0400, Zi Yan wrote:
>> On Tue Jul 14, 2026 at 12:40 PM EDT, Kiryl Shutsemau wrote:
>>>
>>> I saw this option too, but I wound rather not go this path.
>>>
>>> iput() still can lead to inode eviction an bunch of random filesystem
>>> complexity under us. I don't think we want to think about other
>>> fs-related locking issues in split context.
>>
>> Your reasoning makes sense to me. Let's ignore this option.
>>
>> For your patch 2, we might want something like below to avoid over
>> rejecting splits. WDYT?
>>
>> offset = folio_page_idx(folio, lock_at);
>>
>> if (split_type == SPLIT_TYPE_UNIFORM)
>> 	lock_at_index = folio->index + round_down(offset, 1UL << new_order);
>> else
>> 	/* @lock_at in non uniform split is always @folio */
>> 	lock_at_index = folio->index;
>>
>> if (lock_at_index >= end) {
>> 	ret = -EBUSY;
>> 	goto out_unlock;
>> }
>>
> 
> Right. With the -EBUSY condition growing this hairy -- and having to stay
> correct for non-uniform splits too -- just moving i_mmap_unlock_read() out
> of the window looks more attractive.
> 
> This is really Hao's original patch with the reasoning corrected, so I kept
> him as author. v3 below.
> 
> ----------------------------------------------------------------------
> 
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> Subject: [PATCH v3] mm/huge_memory: unlock i_mmap_rwsem before releasing
>  after-split folios
> 
> __folio_split() keeps dereferencing the mapping after the split:
> shmem_uncharge(mapping->host) and remap_page() while the folios are still
> frozen/locked, and i_mmap_unlock_read(mapping) at the very end, after the
> after-split folios have been unlocked and freed.
> 
> Nothing holds an inode reference across that. The split relies on @folio
> -- which the beyond-EOF drop loop never removes, as it starts at
> folio_next(folio) -- staying locked and in the page cache to hold off
> eviction. But the unlock loop unlocks @folio before i_mmap_unlock_read()
> runs. If the caller's @lock_at is a tail beyond EOF, as memory_failure()
> passes when splitting a poisoned tail of a shmem THP that reaches past
> i_size during truncation, it too is gone from the page cache; so once
> @folio is unlocked no locked, in-cache folio pins the inode, and a
> concurrent final iput() can evict and RCU-free it before
> i_mmap_unlock_read() touches i_mmap_rwsem:
> 
>   BUG: KASAN: slab-use-after-free in __up_read+0x634/0x790
>    i_mmap_unlock_read include/linux/fs.h:537 [inline]
>    __folio_split+0x732/0x1640 mm/huge_memory.c:4100
>    try_to_split_thp_page+0xab/0x390 mm/memory-failure.c:1675
>    memory_failure+0x1394/0x26e0 mm/memory-failure.c:2470
> 
>   Freed by task 4601:
>    shmem_free_in_core_inode+0x54/0xb0 mm/shmem.c:5177
>    evict+0x57f/0xac0 fs/inode.c:870
> 
> Do every mapping dereference while @folio still pins the inode: drop
> i_mmap_rwsem right after remap_page(), before the loop that unlocks and
> frees the after-split folios, and clear @mapping so the exit path does not
> unlock it again. shmem_uncharge() and remap_page() already run before that
> point, so after this nothing past the unlock loop touches the inode or the
> mapping.
> 
> This is now a rule the split depends on, alongside keeping @folio frozen
> until the page cache is updated: no inode or mapping dereference once the
> after-split folios start being unlocked.
> 
> Reported-by: Hao Zhang <zhanghao1@kylinos.cn>
> Closes: https://lore.kernel.org/linux-mm/20260710071344.GA106129@zh-pc
> Fixes: baa355fd3314 ("thp: file pages support for split_huge_page()")
> Cc: <stable@vger.kernel.org>
> Co-developed-by: Hao Zhang <zhanghao1@kylinos.cn>
> Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---
>  mm/huge_memory.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2bccb0a53a0a..abaea34ef558 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4109,6 +4109,18 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> 
>  	remap_page(folio, 1 << old_order, ttu_flags);
> 
> +	/*
> +	 * Drop the mapping while the inode is still pinned. @folio stays
> +	 * locked and present in the page cache until the loop below, so
> +	 * eviction cannot free the inode yet; @lock_at is not enough, it may
> +	 * be a tail beyond EOF that the split already dropped from the page
> +	 * cache. Nothing past this point may touch the inode or the mapping.
> +	 */
> +	if (mapping) {
> +		i_mmap_unlock_read(mapping);
> +		mapping = NULL;
> +	}
> +
>  	/*
>  	 * Unlock all after-split folios except the one containing
>  	 * @lock_at page. If @folio is not split, it will be kept locked.

LGTM

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
