Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E76E13B7A3;
	Sat, 27 Jun 2026 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782544429; cv=none; b=QHj8MVkZVwfif8xqJRXkTASB0g3zCYNdDwcg0uDhy8iMrJVvnA5DUm7BXmXopLYAF+5zf0V+7yHxofAzLSJlrAv7jeiuY1gHje7Koq/LvBkdI3XgJgGpKVfOyi8WE/7jeqp+E15rOuUY9ZnsgYZ9eFjddNjIO0XK+QVZuT54BXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782544429; c=relaxed/simple;
	bh=yRcIUZDb9qKuUQnLFd+ReKJj5Icp/O6BCQEU3OKwLUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdDnH+iHwex/zi8scSctfxUc+6JfjNsXEA4mZbZ5htf/3WrQQ3HHPdyMc9r6yBIcL1fl2P7VrfXnhubHxDQAPL45pYeA8AULrGgsiPzlw/tcQEvSPCjWpTu9Qm7uqH/ghSLmTDQX3HMuujFaPFkDhDwR2POUxiRmLQ9JSNeat8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YoAljMYl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YoAljMYl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B16DA288E;
	Sat, 27 Jun 2026 00:13:40 -0700 (PDT)
Received: from [10.163.169.90] (unknown [10.163.169.90])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82A553F836;
	Sat, 27 Jun 2026 00:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782544425; bh=yRcIUZDb9qKuUQnLFd+ReKJj5Icp/O6BCQEU3OKwLUQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YoAljMYl9iNda7vAS8dBUIz4EirPI6ctqUn5dx7zY9xMkmZW6DEJYPeF0vuZZDQ6Q
	 n4jYHioUUcRIeMy3crLUHOfSmQBOVSyB66DqmYHjT5+VXBlfvOA0KOsp7Kse8LbzXP
	 tTDw7axhmhHktS5IEVPDiFsI3khCFUlIAbi5EaQg=
Message-ID: <82395f5a-31d4-406b-b7ec-10d1a9d067d4@arm.com>
Date: Sat, 27 Jun 2026 12:43:31 +0530
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
References: <e6d1b813-0893-458e-9d58-8d3a9bd979c4@arm.com>
 <20260626141031.14309-1-lance.yang@linux.dev>
 <61e9fcf7-02a5-4285-948b-62fba4dcd69c@arm.com>
 <edee8461-34c6-41e9-ae0c-076380d92ebb@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <edee8461-34c6-41e9-ae0c-076380d92ebb@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/06/26 10:16 pm, Lance Yang wrote:
> 
> 
> On 2026/6/26 23:26, Dev Jain wrote:
>>
>>
>> On 26/06/26 7:40 pm, Lance Yang wrote:
>>>
>>> On Fri, Jun 26, 2026 at 06:53:10PM +0530, Dev Jain wrote:
>>>>
>>>>
>>>> On 26/06/26 1:18 pm, Lance Yang wrote:
>>>>>
>>>>> On Thu, Jun 25, 2026 at 11:29:53AM +0000, Dev Jain wrote:
>>>>>> check_pte() is the final validation step in page_vma_mapped_walk().
>>>>>> It reads pvmw->pte with ptep_get() to decide whether the entry maps
>>>>>> the PFN range being walked. For hugetlb VMAs, that pointer refers
>>>>>> to a hugetlb entry.
>>>>>>
>>>>>> On arches which provide their own huge_ptep_get() to dereference a huge
>>>>>> pte pointer, accessing via ptep_get() would cause pte_pfn(),
>>>>>> pte_present() etc to misbehave.
>>>>>>
>>>>>> It is not clear whether this has a trivially visible effect to userspace.
>>>>>>
>>>>>> Use huge_ptep_get() to dereference a huge pte pointer.
>>>>>>
>>>>>> Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>>> ---
>>>>>> mm/page_vma_mapped.c | 8 +++++++-
>>>>>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>>>>> index 2ccbabfb2cc17..18e1d341f463c 100644
>>>>>> --- a/mm/page_vma_mapped.c
>>>>>> +++ b/mm/page_vma_mapped.c
>>>>>> @@ -107,7 +107,13 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
>>>>>> static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
>>>>>> {
>>>>>>     unsigned long pfn;
>>>>>> -    pte_t ptent = ptep_get(pvmw->pte);
>>>>>> +    pte_t ptent;
>>>>>> +
>>>>>> +    if (is_vm_hugetlb_page(pvmw->vma))
>>>>>> +        ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
>>>>>> +                      pvmw->pte);
>>>>>
>>>>> I think check_pte() can pass a wrong address to huge_ptep_get() ...
>>>>
>>>> Won't this be handled by rmap_walk_anon/rmap_walk_file - they are the ones
>>>> performing the rmap traversal and passing address to try_to_unmap_one/folio_referenced_one
>>>> etc ...
>>>
>>> Right, that should cover the rmap callbacks. The bit I was worried about
>>> is page_mapped_in_vma() though.
>>>
>>>>>
>>>>> Not sure that is wrong in the first place. For memory failure,
>>>>> page_mapped_in_vma() can be called with a poisoned tail page of a hugetlb
>>>>> folio. In that case, pvmw->address need not be hugepage-aligned.
>>>>>
>>>>> @Miaohe
>>>
>>> For hugetlb memory failure we start with the poisoned PFN:
>>>
>>> static int try_memory_failure_hugetlb(unsigned long pfn, int flags)
>>> {
>>>     ...
>>>     struct page *p = pfn_to_page(pfn);
>>>     struct folio *folio;
>>>     ...
>>>
>>>     folio = page_folio(p);
>>>
>>>     ...
>>>
>>>     if (!hwpoison_user_mappings(folio, p, pfn, flags)) {
>>>         ...
>>>     }
>>>
>>>     ...
>>> }
>>>
>>> and pass the same p down:
>>>
>>> static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
>>>         unsigned long pfn, int flags)
>>> {
>>>     ...
>>>
>>>     collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
>>>
>>>     ...
>>> }
>>>
>>> static void collect_procs(const struct folio *folio, const struct page *page,
>>>         struct list_head *tokill, int force_early)
>>> {
>>>     ...
>>>
>>>     if (unlikely(folio_test_ksm(folio)))
>>>         ...
>>>     else if (folio_test_anon(folio))
>>>         collect_procs_anon(folio, page, tokill, force_early);
>>>     else
>>>         ...
>>> }
>>>
>>> So collect_procs_anon() still gets the poisoned page, not &folio->page:
>>>
>>> static void collect_procs_anon(const struct folio *folio,
>>>         const struct page *page, struct list_head *to_kill,
>>>         int force_early)
>>> {
>>>     ...
>>>
>>>     pgoff = page_pgoff(folio, page);
>>>     rcu_read_lock();
>>>     for_each_process(tsk) {
>>>         ...
>>>        
>>>         anon_vma_interval_tree_foreach(vmac, &av->rb_root,
>>>                            pgoff, pgoff) {
>>>             ...
>>>             addr = page_mapped_in_vma(page, vma);
>>>             ...
>>>         }
>>>     }
>>>     rcu_read_unlock();
>>>     anon_vma_unlock_read(av);
>>> }
>>>
>>> page_mapped_in_vma() then builds pvmw for that page:
>>>
>>> unsigned long page_mapped_in_vma(const struct page *page,
>>>         struct vm_area_struct *vma)
>>> {
>>>     const struct folio *folio = page_folio(page);
>>>     struct page_vma_mapped_walk pvmw = {
>>>         .pfn = page_to_pfn(page),
>>>         .nr_pages = 1,
>>>         .vma = vma,
>>>         .flags = PVMW_SYNC,
>>>     };
>>>
>>>     pvmw.address = vma_address(vma, page_pgoff(folio, page), 1);
>>>     ...
>>> }
>>>
>>> and page_pgoff() includes the subpage index:
>>>
>>> static inline pgoff_t page_pgoff(const struct folio *folio,
>>>         const struct page *page)
>>> {
>>>     return folio->index + folio_page_idx(folio, page);
>>> }
>>>
>>> So if the poisoned PFN points to a tail page, pvmw->address can be offset
>>> from the start of the hugetlb mapping by
>>>
>>> folio_page_idx(folio, page) << PAGE_SHIFT
>>>
>>> Should check_pte() pass the hugepage-aligned address to huge_ptep_get()
>>> for that case?
>>
>> Thanks! This looks correct.
>>
>> I can indeed fix this up in check_pte. But in the memory-failure path
>> it has always been confusing to me for hugetlb folios why we are bothering
>> with the tail page. I am sure that area can also be simplified. But for
>> now I'll just do a simple fix here itself.
> 
> Just thinking out loud: given that huge_ptep_get() already assumes that
> addr matches the huge pte, at least on arm64, would it make sense to
> have a small hugetlb wrapper around it that takes hstate and aligns
> the address before calling the arch helper?
> 
> Might make the rule clearer, and a bit harder to get wrong again :)

Are you suggesting something like:

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index fdb7bdf7645c..xxxxxxxxxxxx 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -825,6 +825,15 @@ static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,

 #include <asm/hugetlb.h>

+static inline pte_t hugetlb_ptep_get(struct vm_area_struct *vma,
+				     unsigned long addr, pte_t *ptep)
+{
+	struct hstate *h = hstate_vma(vma);
+
+	return huge_ptep_get(vma->vm_mm, addr & huge_page_mask(h), ptep);
+}
+
 #ifndef is_hugepage_only_range
 static inline int is_hugepage_only_range(struct mm_struct *mm,
 					unsigned long addr, unsigned long len)
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 18e1d341f463..xxxxxxxxxxxx 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -110,8 +110,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
 	pte_t ptent;

 	if (is_vm_hugetlb_page(pvmw->vma))
-		ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
-				      pvmw->pte);
+		ptent = hugetlb_ptep_get(pvmw->vma, pvmw->address, pvmw->pte);
 	else
 		ptent = ptep_get(pvmw->pte);



> 
> Thanks, Lance
> 
>>
>>>
>>> Cheers, Lance
>>>
>>>>>
>>>>> For arm64, CONT_PMD_SIZE is one supported HugeTLB size. With such a VMA,
>>>>> page_vma_mapped_walk() passes that size to hugetlb_walk():
>>>>>
>>>>> bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>>> {
>>>>>     ...
>>>>>     if (unlikely(is_vm_hugetlb_page(vma))) {
>>>>>         ...
>>>>>         pvmw->pte = hugetlb_walk(vma, pvmw->address, size);
>>>>>         ...
>>>>>     }
>>>>>     ...
>>>>> }
>>>>>
>>>>> hugetlb_walk() then calls arm64 huge_pte_offset(mm, addr, sz). For
>>>>> sz == CONT_PMD_SIZE, huge_pte_offset() aligns its local addr before
>>>>> calculating pmdp:
>>>>>
>>>>> pte_t *huge_pte_offset(struct mm_struct *mm,
>>>>>                unsigned long addr, unsigned long sz)
>>>>> {
>>>>>     ...
>>>>>     if (sz == CONT_PMD_SIZE)
>>>>>         addr &= CONT_PMD_MASK;
>>>>>
>>>>>     pmdp = pmd_offset(pudp, addr);
>>>>>     pmd = READ_ONCE(*pmdp);
>>>>>     ...
>>>>> }
>>>>>
>>>>> So for that case, pvmw->pte is calculated from the aligned addr, not
>>>>> necessarily from the original pvmw->address. But check_pte() passes the
>>>>> original address together with pvmw->pte:
>>>>>
>>>>> +        ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
>>>>> +                      pvmw->pte);
>>>>>
>>>>> arm64 then uses that addr again to choose ncontig:
>>>>>
>>>>> pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>>>>> {
>>>>>     ...
>>>>>     ncontig = find_num_contig(mm, addr, ptep, &pgsize);
>>>>>     for (i = 0; i < ncontig; i++, ptep++) {
>>>>>         ...
>>>>>     }
>>>>>     return orig_pte;
>>>>> }
>>>>>
>>>>> static int find_num_contig(struct mm_struct *mm, unsigned long addr,
>>>>>                pte_t *ptep, size_t *pgsize)
>>>>> {
>>>>>     pgd_t *pgdp = pgd_offset(mm, addr);
>>>>>     p4d_t *p4dp;
>>>>>     pud_t *pudp;
>>>>>     pmd_t *pmdp;
>>>>>
>>>>>     *pgsize = PAGE_SIZE;
>>>>>     p4dp = p4d_offset(pgdp, addr);
>>>>>     pudp = pud_offset(p4dp, addr);
>>>>>     pmdp = pmd_offset(pudp, addr);
>>>>>     if ((pte_t *)pmdp == ptep) {
>>>>>         *pgsize = PMD_SIZE;
>>>>>         return CONT_PMDS;
>>>>>     }
>>>>>     return CONT_PTES;
>>>>> }
>>>>>
>>>>> With a tail address, pmdp may no longer point at pvmw->pte, so
>>>>> find_num_contig() can return CONT_PTES for a CONT_PMD HugeTLB mapping.
>>>>>
>>>>> On 16K arm64, that changes ncontig from 32 to 128. So huge_ptep_get()
>>>>> can walk past the CONT_PMD entries, and possibly past the PMD table.
>>>>>
>>>>> Should check_pte() pass the address matching pvmw->pte, sth like:
>>>>>
>>>>> ---8<---
>>>>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>>>> index 406fd50bbd8f..58463493bd3d 100644
>>>>> --- a/mm/page_vma_mapped.c
>>>>> +++ b/mm/page_vma_mapped.c
>>>>> @@ -109,11 +109,14 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
>>>>>       unsigned long pfn;
>>>>>       pte_t ptent;
>>>>>
>>>>> -    if (is_vm_hugetlb_page(pvmw->vma))
>>>>> -        ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
>>>>> -                      pvmw->pte);
>>>>> -    else
>>>>> +    if (is_vm_hugetlb_page(pvmw->vma)) {
>>>>> +        struct hstate *hstate = hstate_vma(pvmw->vma);
>>>>> +        unsigned long haddr = pvmw->address & huge_page_mask(hstate);
>>>>> +
>>>>> +        ptent = huge_ptep_get(pvmw->vma->vm_mm, haddr, pvmw->pte);
>>>>> +    } else {
>>>>>           ptent = ptep_get(pvmw->pte);
>>>>> +    }
>>>>>
>>>>>       if (pvmw->flags & PVMW_MIGRATION) {
>>>>>           const softleaf_t entry = softleaf_from_pte(ptent);
>>>>> -- 
>>>>>
>>>>> while leaving pvmw->address unchanged for page_mapped_in_vma()?
>>>>>
>>>>> Cheers, Lance
>>>>>
>>>>>> +    else
>>>>>> +        ptent = ptep_get(pvmw->pte);
>>>>>>
>>>>>>     if (pvmw->flags & PVMW_MIGRATION) {
>>>>>>         const softleaf_t entry = softleaf_from_pte(ptent);
>>>>>> -- 
>>>>>> 2.43.0
>>>>>>
>>>>>>
>>>>
>>>>
>>>
>>
> 
> 

