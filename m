Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7209C3CEB90;
	Thu,  2 Jul 2026 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983341; cv=none; b=tFQBJ1PmtefQ+dgaYi6emJu7aMQEq4duIhYDN39xOYYhCwFjADqAMRf28JLl3LXFrbY79OURIVvdrPAKTYvOzQsMAo+U/ZyovyqLI7MXn1RV4JGs2o1u9pgE4XfHVgrRYVGkp9ZWTAzofOGgLqWcse/sGsaAhcNC1ddCt2Rrlok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983341; c=relaxed/simple;
	bh=vCwix3VrRVa0qLybvbsy6PV5Ocf40WHZJfF5rvlVcUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpyeUYs+HqdQO+nBgvSrwTGHGLvlX6dwPnORyT82wiwbP10ZWHRU+F0GUhN5Yv2ttNMklrrYdPwWrSsRxVHnvZGGQ8jdpMyyL8PtNTgAg3Ud+e3iLPSWm1+sREw2W1zsgM0yl5Rbo0w1zSsIh0E6eSYb2oUwk1iMwepkArNu+tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Z/uB3Ryt; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Z/uB3Ryt"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BE54288E;
	Thu,  2 Jul 2026 02:08:55 -0700 (PDT)
Received: from [10.164.19.15] (unknown [10.164.19.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3A123F85F;
	Thu,  2 Jul 2026 02:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782983339; bh=vCwix3VrRVa0qLybvbsy6PV5Ocf40WHZJfF5rvlVcUo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z/uB3RytqoD94KC3C+8KsT7tF0rPMJKcCWTT/SCVOZRWqODg6FkDRSjxfpEYjUzot
	 Cylok/Y1uVEHB0aip7ANYaNvgAbx/CyAMt6Xy8pjRnj1P7Kq5dX822Ql7kmM0d0RVm
	 3jetQLb9C+gPogZ7ztn5jJMo89lnnC0g+H9e07Dk=
Message-ID: <a6a00b38-612f-439d-9b75-337170e3af30@arm.com>
Date: Thu, 2 Jul 2026 14:38:48 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
To: Muchun Song <muchun.song@linux.dev>
Cc: riel@surriel.com, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 lance.yang@linux.dev, kas@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcampbell@nvidia.com, apopple@nvidia.com,
 ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, nao.horiguchi@gmail.com, ak@linux.intel.com,
 mel@csn.ul.ie, pfalcato@suse.de, jpoimboe@kernel.org, dave.hansen@intel.com,
 tglx@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, stable@vger.kernel.org, osalvador@suse.de,
 akpm@linux-foundation.org, ljs@kernel.org, david@kernel.org,
 liam@infradead.org
References: <20260702051341.126509-1-dev.jain@arm.com>
 <20260702051341.126509-3-dev.jain@arm.com>
 <97a43d82-28c2-4f98-ad74-fe05ed9f0297@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <97a43d82-28c2-4f98-ad74-fe05ed9f0297@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 02/07/26 2:17 pm, Muchun Song wrote:
> 
> 
> On 2026/7/2 13:13, Dev Jain wrote:
>> try_to_unmap_one() handles hugetlb folios when memory failure needs
>> to replace a poisoned hugetlb mapping with a hwpoison entry. In that
>> case page_vma_mapped_walk() returns the pte pointer to the hugetlb folio
>> in pvmw.pte, but the code reads it with ptep_get().
>>
>> On arches which provide their own huge_ptep_get() to dereference a huge
>> pte pointer, accessing via ptep_get() would cause pte_pfn(), pte_present()
>> etc to misbehave.
>>
>> It is not clear whether this has a trivially visible effect to userspace.
>>
>> Just use huge_ptep_get() for dereferencing a huge pte pointer.
>>
>> Fixes: c7ab0d2fdc84 ("mm: convert try_to_unmap_one() to use page_vma_mapped_walk()")
>> Cc: stable@vger.kernel.org
>> Reported-by: David Hildenbrand <david@kernel.org>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   include/linux/hugetlb.h |  3 +++
>>   mm/rmap.c               | 16 ++++++++++------
>>   2 files changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 2abaf99321e90..fdb7bdf7645c5 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -1261,6 +1261,9 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
>>   {
>>   }
>>   +pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr,
>> +            pte_t *ptep);
>> +
> 
> Maybe I didn't express my thoughts clearly in the first version, let me
> explain in more detail.
> 
> We should define this stub as a no-op for !CONFIG_HUGETLB_PAGE (like
> set_huge_pte_at, that is why I mentioned 5d4af6195c87c6 for your reference
> in your previous version). Currently, you've added a declaration, but the
> function itself doesn't actually exist, which seems quite strange to me.

https://lore.kernel.org/all/a4fe8ba6-2ecd-4bb9-95a9-27f9f1e87d2e@kernel.org/

David suggested this. Honestly I quite like David's suggestion, what do you
think?


> 
> Muchun,
> Thanks.
>>   static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>>                         unsigned long addr, pte_t *ptep)
>>   {
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 1c77d5dc06e9f..aa8a254efaecc 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -2095,11 +2095,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>           /* Unexpected PMD-mapped THP? */
>>           VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>>   -        /*
>> -         * Handle PFN swap PTEs, such as device-exclusive ones, that
>> -         * actually map pages.
>> -         */
>> -        pteval = ptep_get(pvmw.pte);
>> +        address = pvmw.address;
>> +        if (folio_test_hugetlb(folio)) {
>> +            pteval = huge_ptep_get(mm, address, pvmw.pte);
>> +        } else {
>> +            /*
>> +             * Handle PFN swap PTEs, such as device-exclusive ones,
>> +             * that actually map pages.
>> +             */
>> +            pteval = ptep_get(pvmw.pte);
>> +        }
>>           if (likely(pte_present(pteval))) {
>>               pfn = pte_pfn(pteval);
>>           } else {
>> @@ -2110,7 +2115,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>           }
>>             subpage = folio_page(folio, pfn - folio_pfn(folio));
>> -        address = pvmw.address;
>>           anon_exclusive = folio_test_anon(folio) &&
>>                    PageAnonExclusive(subpage);
>>   
> 

