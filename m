Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C498233ADAC
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782721391; cv=none; b=CsyK3a7XU3gxsYu0W0GFuJ4BXl+Ii0Viun8anGgwyB46UGkBU5eAqB7mEk0q3u6ZyWEqY2AlogmAxfKEz5q5KQ60u1HQclY5k37WQlYCWx3ePZYctoAL1fY9eFCGs6SUOqgH0n4aqpfj5OCdPnhsLF9UMhWdp1gI9fTe8HTbMJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782721391; c=relaxed/simple;
	bh=YxIPHSNC47f3A+LcnpLMRfV9Z1FvXBtSeeEpllaqegE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciXuHdoUIZ46Ai7Yy9qaF15DzijLANJxDY8V6/HRvrWOVa8jehC/exajKpHshfLz/mvglB3tgGiccbR836A14OR3OdL8LvaNZrxDYjJnhuUl11OLqc3mv3yvg77WhoXBycNnfLkWJnuTZ+71xY07T5jBeuscHQhqJkHSfoJrnio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ev1aNmXq; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ev1aNmXq"
Message-ID: <458f63e2-6ee4-44c7-a230-636e1927f857@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782721385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFxUO7tgIcr0aaRoeEv4WTyZn0JslVlD209KcTGHDqc=;
	b=ev1aNmXq7ogiDIfLA6fwdm8/E4svVMoXrQk1fT8rGFz3UmiKKzsl/hv4jM6VSXvdeRIXSY
	+hGUGRGHVpH/oq+1s7hpJexHb9LmvsPTB68wx+kCIH4MG4qC7Bk/doclxFP0JZyxlaaHbm
	u4aXlpHb3wvosR2bMj24RfY4WpKOuaI=
Date: Mon, 29 Jun 2026 16:22:49 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] mm/page_vma_mapped: use huge_ptep_get() for hugetlb
To: "David Hildenbrand (Arm)" <david@kernel.org>, dev.jain@arm.com
Cc: linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de,
 akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org,
 riel@surriel.com, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 kas@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 rcampbell@nvidia.com, apopple@nvidia.com, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 mel@csn.ul.ie, nao.horiguchi@gmail.com, ak@linux.intel.com,
 j-nomura@ce.jp.nec.com, pfalcato@suse.de, dave.hansen@intel.com,
 tglx@kernel.org, jpoimboe@kernel.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, stable@vger.kernel.org
References: <0fabee2a-edb7-41c8-91ec-8cf0646c9e83@kernel.org>
 <20260629074802.42727-1-lance.yang@linux.dev>
 <a1c6c3dd-8db1-4db6-b032-e350bacc4577@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <a1c6c3dd-8db1-4db6-b032-e350bacc4577@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/6/29 16:05, David Hildenbrand (Arm) wrote:
> On 6/29/26 09:48, Lance Yang wrote:
>>
>> On Mon, Jun 29, 2026 at 09:25:48AM +0200, David Hildenbrand (Arm) wrote:
>>> On 6/29/26 08:48, Dev Jain wrote:
>>>>
>>>>
>>>>
>>>> Sashiko notes other places:
>>>>
>>>> https://sashiko.dev/#/patchset/20260625112955.3254283-1-dev.jain%40arm.com
>>>
>>> Yeah, that looks shaky. We do seem to have a bunch of these cases, primarily
>> >from pagewalk code (where some users like pagemap need the actual address).
>>
>> Indeed ...
>>
>>> I think we have two options
>>>
>>> 1) To prevent any (further) issues, make huge_ptep_get() always consume the
>>> hstate, and let the arch code deal with aligning it. Invasive.
>>
>> Kinda lean toward option 1, even if it's more invasive. If we pass the
>> hstate down, each arch can figure out the right addr from there.
>>
>>> 2) Make the arch code handle aligning without the hstate.
>>>
>>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>>> index 30772a909aea3..303a1b74796c9 100644
>>> --- a/arch/arm64/mm/hugetlbpage.c
>>> +++ b/arch/arm64/mm/hugetlbpage.c
>>> @@ -126,6 +126,9 @@ pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>>>                 return orig_pte;
>>>
>>>         ncontig = find_num_contig(mm, addr, ptep, &pgsize);
>>> +       ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * ncontig);
>>> +       orig_pte = __ptep_get(ptep);
>>> +
>>>         for (i = 0; i < ncontig; i++, ptep++) {
>>>                 pte_t pte = __ptep_get(ptep);
>>>
>>> (nshift/order instead of ncontig might avoid a multiplication, but not sure if that matters in practice)
>>>
>>> IIUC, that's similar to what huge_ptep_get() does on ppc.
>>>
>>>
>>> static inline pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>>> {
>>> 	if (ptep_is_8m_pmdp(mm, addr, ptep))
>>> 		ptep = pte_offset_kernel((pmd_t *)ptep, ALIGN_DOWN(addr, SZ_8M));
>>> 	return ptep_get(ptep);
>>> }
>>>
>>> I'd assume we could do the same on riscv. Besides that, I don't think any arch has cont
>>> entries.
>>
>> AFAICT, for huge_ptep_get() the addr users are arm64 and powerpc, riscv
>> doesn't really care about addr there. Looks mostly arm64-specific ...
> powerpc handles it correctly in the weird "span two PMD entries" case by
> aligning the PMD down.
> 
> Risc-v copied from arm64, but can simply derive the #entries from the PTE value.
> it doesn't have to re-walk the table using the address.

Yeah, fair enough, thanks for spelling that out!

> But I think the following is required to fix, no?
> 
> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> index a6d217112cf46..7e25cc13b3dba 100644
> --- a/arch/riscv/mm/hugetlbpage.c
> +++ b/arch/riscv/mm/hugetlbpage.c
> @@ -5,6 +5,7 @@
>   #ifdef CONFIG_RISCV_ISA_SVNAPOT
>   pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>   {
> -       unsigned long pte_num;
> +       unsigned long pte_num, pte_order;
>          int i;
>          pte_t orig_pte = ptep_get(ptep);
> @@ -12,7 +13,11 @@ pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr,
> pte_t *ptep)
>          if (!pte_present(orig_pte) || !pte_napot(orig_pte))
>                  return orig_pte;
> 
> -       pte_num = napot_pte_num(napot_cont_order(orig_pte));
> +       pte_order = napot_cont_order(orig_pte);
> +       pte_num = napot_pte_num(pte_order);
> +
> +       ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) << pte_order);
> +       orig_pte = ptep_get(ptep);
> 
>          for (i = 0; i < pte_num; i++, ptep++) {
>                  pte_t pte = ptep_get(ptep);
> 
> 
> 
> I'd prefer (2) as a simple stable fix first.

Right. I'm good with (2) as the stable fix first :)

Still pretty new to arch code, but happy to stare at it some more.

> If we do (1) on top, huge_ptep_get() on arm64 could stop walking the page table
> another time.
> 
> If we pass the hstate (or vma) to set_huge_pte_at(), huge_pte_clear(),
> huge_ptep_get_and_clear(), we could likely get rid of the re-walk in
> num_contig_ptes() entirely and possibly just remove it.
> 
> That would probably be cleanest.

Agreed!
