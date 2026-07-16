Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EB22D238F;
	Thu, 16 Jul 2026 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784165084; cv=none; b=GGBgkYV/ResVbBtlqjtmgKagIuZJMyfsWtscUYunMDgQhcaw7KYtF/GtAJkJRTFsbsOo193b3Zdjc1NDigiuIMRYHFEAAKiN+kgSn6Vip+skGlB91+gsu7HOB4O/ghvFgMrkSzX5KzfGjrZyzRfl92hiYXXz9bOAU6XspVFbRPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784165084; c=relaxed/simple;
	bh=Wfxi5oNI7iBeqN5wECIs1+ILVzA43OZBHnQzp4Zk1x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awV9felejp73YFnXuLA8xtEsFyShxVWaiRV4T7ZFaJnrrdqVPOd1j+vRjYnOmNfzm2sr5Z/pgAdx0snVOPcIBKvHQ7i+doz8mZGIXEUFCBEGhqQ8wRJHKqMd88vlGkyjv4prwc2oww7zwrLQjvw5jTSt7nee+qzC4xsgTMfZLr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dK5P+oqz; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dK5P+oqz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784165075; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2BN+QYnQWtB57fvjRZtapEPLHI2ra+Tc8MDvGL8FkvU=;
	b=dK5P+oqzg2JpyVD/2afhbVOnrUqS818M/kT2cUX85dGAy0/htyCwnOLfmt0YkcO7+T9/Rjx/6OdfVaxBzgwASQaNz4SaYbsUwiayWk5WWzLq2aSSqwd77nCEjuXlORrZ0IoBlS6kE2lc46yI4Hfb1G8m4JpowmrYE613Xj9qUx8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X7AyyF9_1784165072;
Received: from 30.74.144.123(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X7AyyF9_1784165072 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Jul 2026 09:24:33 +0800
Message-ID: <c7b29638-69c9-45f9-a9cd-21dea1460848@linux.alibaba.com>
Date: Thu, 16 Jul 2026 09:24:32 +0800
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
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, "Liam R . Howlett" <liam@infradead.org>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Hao Zhang <zhanghao1@kylinos.cn>, Hao Zhang <hao_zhang_kdev@163.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260714122344.351895-1-kirill@shutemov.name>
 <20260714122344.351895-2-kirill@shutemov.name>
 <c4aa63df-30ab-464d-bd0b-48dc37c8e6ba@kernel.org>
 <alZNYYsybKZA0eJb@thinkstation>
 <18fe5529-2ad5-4330-a362-708a152bacee@kernel.org>
 <66A57599-EDA0-4E99-B073-F2AE0B2ED708@nvidia.com>
 <alZljHr4Nk3FOpCP@thinkstation> <DJYH202OLKZF.432DAJWF2MGA@nvidia.com>
 <aldjhtfVByHDQXe6@thinkstation>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <aldjhtfVByHDQXe6@thinkstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/15/26 6:42 PM, Kiryl Shutsemau wrote:
> On Tue, Jul 14, 2026 at 01:31:54PM -0400, Zi Yan wrote:
>> On Tue Jul 14, 2026 at 12:40 PM EDT, Kiryl Shutsemau wrote:
>>> On Tue, Jul 14, 2026 at 11:44:39AM -0400, Zi Yan wrote:
>>>> There is an alternative, only igrab() when @lock_at is at or beyond the EOF,
>>>> as I was bouncing ideas with Codex.
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

Agree.

> This is really Hao's original patch with the reasoning corrected, so I kept
> him as author. v3 below.
> 
> ----------------------------------------------------------------------
> 
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> Subject: [PATCH v3] mm/huge_memory: unlock i_mmap_rwsem before releasing
>   after-split folios
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
>    BUG: KASAN: slab-use-after-free in __up_read+0x634/0x790
>     i_mmap_unlock_read include/linux/fs.h:537 [inline]
>     __folio_split+0x732/0x1640 mm/huge_memory.c:4100
>     try_to_split_thp_page+0xab/0x390 mm/memory-failure.c:1675
>     memory_failure+0x1394/0x26e0 mm/memory-failure.c:2470
> 
>    Freed by task 4601:
>     shmem_free_in_core_inode+0x54/0xb0 mm/shmem.c:5177
>     evict+0x57f/0xac0 fs/inode.c:870
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

LGTM. Thanks for the analysis.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   mm/huge_memory.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2bccb0a53a0a..abaea34ef558 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4109,6 +4109,18 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> 
>   	remap_page(folio, 1 << old_order, ttu_flags);
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
>   	/*
>   	 * Unlock all after-split folios except the one containing
>   	 * @lock_at page. If @folio is not split, it will be kept locked.

