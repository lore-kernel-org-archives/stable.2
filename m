Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7572738C41B;
	Tue, 30 Jun 2026 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819300; cv=none; b=Ey/CG7cTs7RG4SDj5Jvb9xRB5ovbSO0jjfn/iwLFiqGvIBEspj9Dsx3D5J2MYcbeglM+jSSyzLd4j78gZ417fM4eGzC7BlEwTMRI1x7HQzfk7QtWROWy36OYIqtZxnvmKoRzeRHTw6qF1x+BjERHhrwwK2+YyvRG22g2CsEF8rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819300; c=relaxed/simple;
	bh=36e7WO1Yf+y2VcPGOuHpBYDw36f17/2PgIYLivcK1GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VgvwiekNQSMZ+1WbGVtT47rMLCjmCIuVJZnilhMh1FKoRemB/WEEI5jR7itG40yWAHJMX6piXLifsgE20wCn7YocUS0OVuEU1mq8yxEu4X11mnzHgO3q4U95oleH0iRdykEMRygXoc1XmU2zdZOPJ8Ws61W0av9gCB/G6DajFeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=c638sO79; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="c638sO79"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D61AE2C1C;
	Tue, 30 Jun 2026 04:34:51 -0700 (PDT)
Received: from [10.164.19.15] (unknown [10.164.19.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A140F3F673;
	Tue, 30 Jun 2026 04:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782819296; bh=36e7WO1Yf+y2VcPGOuHpBYDw36f17/2PgIYLivcK1GA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c638sO79AScfINz5lZY6NrPZdHX2ctsv9So73SM3zl35Hsiy/29ZmsbJxrZ30q+le
	 e8zRVT9LylhWv0Ori+TlPSrHZw89TwAHrD9JM74Wu6c/1CyEbgAzceXuUBzpPnNzSf
	 MJzWFP/AotQfgT6G7BDiLWvW1fbUjAPzzb7V+pCE=
Message-ID: <6fdc0cbd-0880-4594-bf33-a2993ac2fe60@arm.com>
Date: Tue, 30 Jun 2026 17:04:44 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] mm/page_vma_mapped: use huge_ptep_get() for hugetlb
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lance Yang <lance.yang@linux.dev>
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
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <a1c6c3dd-8db1-4db6-b032-e350bacc4577@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/06/26 1:35 pm, David Hildenbrand (Arm) wrote:
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
>>>                return orig_pte;
>>>
>>>        ncontig = find_num_contig(mm, addr, ptep, &pgsize);
>>> +       ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * ncontig);
>>> +       orig_pte = __ptep_get(ptep);
>>> +
>>>        for (i = 0; i < ncontig; i++, ptep++) {
>>>                pte_t pte = __ptep_get(ptep);
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
> 
> But I think the following is required to fix, no?

We don't receive an unaligned ptep in huge_ptep_get, and riscv derives the
number of cont ptes from the pte itself, so why is the below required?


> 
> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> index a6d217112cf46..7e25cc13b3dba 100644
> --- a/arch/riscv/mm/hugetlbpage.c
> +++ b/arch/riscv/mm/hugetlbpage.c
> @@ -5,6 +5,7 @@
>  #ifdef CONFIG_RISCV_ISA_SVNAPOT
>  pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>  {
> -       unsigned long pte_num;
> +       unsigned long pte_num, pte_order;
>         int i;
>         pte_t orig_pte = ptep_get(ptep);
> @@ -12,7 +13,11 @@ pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr,
> pte_t *ptep)
>         if (!pte_present(orig_pte) || !pte_napot(orig_pte))
>                 return orig_pte;
> 
> -       pte_num = napot_pte_num(napot_cont_order(orig_pte));
> +       pte_order = napot_cont_order(orig_pte);
> +       pte_num = napot_pte_num(pte_order);
> +
> +       ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) << pte_order);
> +       orig_pte = ptep_get(ptep);
> 
>         for (i = 0; i < pte_num; i++, ptep++) {
>                 pte_t pte = ptep_get(ptep);
> 
> 
> 
> I'd prefer (2) as a simple stable fix first.
> 
> If we do (1) on top, huge_ptep_get() on arm64 could stop walking the page table
> another time.
> 
> If we pass the hstate (or vma) to set_huge_pte_at(), huge_pte_clear(),
> huge_ptep_get_and_clear(), we could likely get rid of the re-walk in
> num_contig_ptes() entirely and possibly just remove it.
> 
> That would probably be cleanest.
> 

