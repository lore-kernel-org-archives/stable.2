Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814143B52E6;
	Fri, 26 Jun 2026 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782480209; cv=none; b=my/qHrTVnyaFEXfRrgg/6svZlIrGnFrSRqOlg+3S6urj7GfR/8T3oxfPhZaX5+2qijZI7+jYoJWKLU5snFc1cx8oQARp/w9ls16YN8PoV3V6RlMnfCRttNssSKkLSCgjY6IKJQZXdYEo3850h11swsXlZU16i3+ZAeNpjW6rhHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782480209; c=relaxed/simple;
	bh=nb4rFe3Q3YhM3Qx4t4fYGfUdPmERHrvA3QR5e1Bgchs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUBsG9TpLFuUvKkkLHdlyVGl5/h8JMdw+Xagc2Q2odi1z4+lh6kWPwNtcoEB+L2WS3DeHfQglZQPwjWlgRlVroQK2ebMWTftuyS2YZ0FjB9pIXK70SOjfVLKYQIVnLDBoZ7E/k8nbR7IQhG7UYlhP6pyqJmeB/F39FsFO48Q2CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aTQKqclQ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aTQKqclQ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E66EF1570;
	Fri, 26 Jun 2026 06:23:17 -0700 (PDT)
Received: from [10.164.19.14] (unknown [10.164.19.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACEA63F632;
	Fri, 26 Jun 2026 06:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782480202; bh=nb4rFe3Q3YhM3Qx4t4fYGfUdPmERHrvA3QR5e1Bgchs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aTQKqclQjcgTkbNI4MumvFvF1LbJskNozCfFLIsoNnWnqeI0E2opjFTOglwCnW/5s
	 gHI3Xv8ss7i1SM+cK0FhKuJ5VaYRtmMsTiNT3ugLPzlHOsEMNrz9P/ugc9GqfDVzay
	 zUTxuwmrdRA0ns2koM7wqjGkpjQqXPcPMk1XhL2w=
Message-ID: <e6d1b813-0893-458e-9d58-8d3a9bd979c4@arm.com>
Date: Fri, 26 Jun 2026 18:53:10 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] mm/page_vma_mapped: use huge_ptep_get() for hugetlb
To: Lance Yang <lance.yang@linux.dev>, linmiaohe@huawei.com
Cc: muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org,
 ljs@kernel.org, david@kernel.org, liam@infradead.org, riel@surriel.com,
 vbabka@kernel.org, harry@kernel.org, jannh@google.com, kas@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcampbell@nvidia.com,
 apopple@nvidia.com, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, mel@csn.ul.ie,
 nao.horiguchi@gmail.com, ak@linux.intel.com, j-nomura@ce.jp.nec.com,
 pfalcato@suse.de, dave.hansen@intel.com, tglx@kernel.org,
 jpoimboe@kernel.org, ryan.roberts@arm.com, anshuman.khandual@arm.com,
 stable@vger.kernel.org
References: <20260625112955.3254283-5-dev.jain@arm.com>
 <20260626074855.97652-1-lance.yang@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260626074855.97652-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/06/26 1:18 pm, Lance Yang wrote:
> 
> On Thu, Jun 25, 2026 at 11:29:53AM +0000, Dev Jain wrote:
>> check_pte() is the final validation step in page_vma_mapped_walk().
>> It reads pvmw->pte with ptep_get() to decide whether the entry maps
>> the PFN range being walked. For hugetlb VMAs, that pointer refers
>> to a hugetlb entry.
>>
>> On arches which provide their own huge_ptep_get() to dereference a huge
>> pte pointer, accessing via ptep_get() would cause pte_pfn(),
>> pte_present() etc to misbehave.
>>
>> It is not clear whether this has a trivially visible effect to userspace.
>>
>> Use huge_ptep_get() to dereference a huge pte pointer.
>>
>> Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>> mm/page_vma_mapped.c | 8 +++++++-
>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index 2ccbabfb2cc17..18e1d341f463c 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -107,7 +107,13 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
>> static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
>> {
>> 	unsigned long pfn;
>> -	pte_t ptent = ptep_get(pvmw->pte);
>> +	pte_t ptent;
>> +
>> +	if (is_vm_hugetlb_page(pvmw->vma))
>> +		ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
>> +				      pvmw->pte);
> 
> I think check_pte() can pass a wrong address to huge_ptep_get() ...

Won't this be handled by rmap_walk_anon/rmap_walk_file - they are the ones
performing the rmap traversal and passing address to try_to_unmap_one/folio_referenced_one
etc ...

> 
> Not sure that is wrong in the first place. For memory failure,
> page_mapped_in_vma() can be called with a poisoned tail page of a hugetlb
> folio. In that case, pvmw->address need not be hugepage-aligned.
> 
> @Miaohe
> 
> For arm64, CONT_PMD_SIZE is one supported HugeTLB size. With such a VMA,
> page_vma_mapped_walk() passes that size to hugetlb_walk():
> 
> bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> {
> 	...
> 	if (unlikely(is_vm_hugetlb_page(vma))) {
> 		...
> 		pvmw->pte = hugetlb_walk(vma, pvmw->address, size);
> 		...
> 	}
> 	...
> }
> 
> hugetlb_walk() then calls arm64 huge_pte_offset(mm, addr, sz). For
> sz == CONT_PMD_SIZE, huge_pte_offset() aligns its local addr before
> calculating pmdp:
> 
> pte_t *huge_pte_offset(struct mm_struct *mm,
> 		       unsigned long addr, unsigned long sz)
> {
> 	...
> 	if (sz == CONT_PMD_SIZE)
> 		addr &= CONT_PMD_MASK;
> 
> 	pmdp = pmd_offset(pudp, addr);
> 	pmd = READ_ONCE(*pmdp);
> 	...
> }
> 
> So for that case, pvmw->pte is calculated from the aligned addr, not
> necessarily from the original pvmw->address. But check_pte() passes the
> original address together with pvmw->pte:
> 
> +		ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
> +				      pvmw->pte);
> 
> arm64 then uses that addr again to choose ncontig:
> 
> pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
> {
> 	...
> 	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
> 	for (i = 0; i < ncontig; i++, ptep++) {
> 		...
> 	}
> 	return orig_pte;
> }
> 
> static int find_num_contig(struct mm_struct *mm, unsigned long addr,
> 			   pte_t *ptep, size_t *pgsize)
> {
> 	pgd_t *pgdp = pgd_offset(mm, addr);
> 	p4d_t *p4dp;
> 	pud_t *pudp;
> 	pmd_t *pmdp;
> 
> 	*pgsize = PAGE_SIZE;
> 	p4dp = p4d_offset(pgdp, addr);
> 	pudp = pud_offset(p4dp, addr);
> 	pmdp = pmd_offset(pudp, addr);
> 	if ((pte_t *)pmdp == ptep) {
> 		*pgsize = PMD_SIZE;
> 		return CONT_PMDS;
> 	}
> 	return CONT_PTES;
> }
> 
> With a tail address, pmdp may no longer point at pvmw->pte, so
> find_num_contig() can return CONT_PTES for a CONT_PMD HugeTLB mapping.
> 
> On 16K arm64, that changes ncontig from 32 to 128. So huge_ptep_get()
> can walk past the CONT_PMD entries, and possibly past the PMD table.
> 
> Should check_pte() pass the address matching pvmw->pte, sth like:
> 
> ---8<---
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 406fd50bbd8f..58463493bd3d 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -109,11 +109,14 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
>  	unsigned long pfn;
>  	pte_t ptent;
> 
> -	if (is_vm_hugetlb_page(pvmw->vma))
> -		ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
> -				      pvmw->pte);
> -	else
> +	if (is_vm_hugetlb_page(pvmw->vma)) {
> +		struct hstate *hstate = hstate_vma(pvmw->vma);
> +		unsigned long haddr = pvmw->address & huge_page_mask(hstate);
> +
> +		ptent = huge_ptep_get(pvmw->vma->vm_mm, haddr, pvmw->pte);
> +	} else {
>  		ptent = ptep_get(pvmw->pte);
> +	}
> 
>  	if (pvmw->flags & PVMW_MIGRATION) {
>  		const softleaf_t entry = softleaf_from_pte(ptent);
> --
> 
> while leaving pvmw->address unchanged for page_mapped_in_vma()?
> 
> Cheers, Lance
> 
>> +	else
>> +		ptent = ptep_get(pvmw->pte);
>>
>> 	if (pvmw->flags & PVMW_MIGRATION) {
>> 		const softleaf_t entry = softleaf_from_pte(ptent);
>> -- 
>> 2.43.0
>>
>>

