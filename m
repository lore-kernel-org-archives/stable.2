Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D2F7404E;
	Tue, 30 Jun 2026 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827648; cv=none; b=gHxxO5nAe8WxL+cxgKZidijuNn7d/koo8Khbc0lxGpFRvr2NQFl/3cAiGrvchGlWFm3Ww+Z0WyVPG5I1cQIqq7rRP+aywl6Msoe6gLZyzDodfKrcH3qBO/xARcIDlLLfyz/RN0skHsb6b0qeZLdhYolrAXqgezTkQj0YxQfxNEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827648; c=relaxed/simple;
	bh=bRjeMLBRn+jxQAm2ekNeaSxDem01aFIboF+1jmwc+uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gu3atihf7EWuhGTH6Hri4JIrL1bWun3LGH7ImoOy7FAw4OyDpEsvcL4Zz9mfmXQOMt1TZZvwnUzpTv2Jcnx0WAYsSbdeLrq5Ytj/Pr3ekKXH04PqSdGRB8ao27HpqixvOpQrPVjW2BkS6ugVvLmMKcrvsP+oxMfnwEYlS5I3Uac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Fiyz70s4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Fiyz70s4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B1BC1C01;
	Tue, 30 Jun 2026 06:54:01 -0700 (PDT)
Received: from [10.164.19.15] (unknown [10.164.19.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E86503F66F;
	Tue, 30 Jun 2026 06:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782827645; bh=bRjeMLBRn+jxQAm2ekNeaSxDem01aFIboF+1jmwc+uU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fiyz70s4+uUmNIjX6xDSUdsEK140AT1ai79NuNO+FWxq+cbpgHt9EB8jc7BkLtcU9
	 0K71n9prgUrk/y4KNQgNrLb42LI0u/iktK1roYgs9wWn3PE9SaEULIHo9SXT8C4g/+
	 gn+oSZCYkUxpoyK2BiuJDr9vOdIKKu/7eKYah7ME=
Message-ID: <cf369aa5-e540-4c3b-85d6-0e9e159496ed@arm.com>
Date: Tue, 30 Jun 2026 19:23:54 +0530
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
 <6fdc0cbd-0880-4594-bf33-a2993ac2fe60@arm.com>
 <1fb04774-1ac6-472a-bbc8-52fceb69b018@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <1fb04774-1ac6-472a-bbc8-52fceb69b018@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30/06/26 6:16 pm, David Hildenbrand (Arm) wrote:
> On 6/30/26 13:34, Dev Jain wrote:
>>
>>
>> On 29/06/26 1:35 pm, David Hildenbrand (Arm) wrote:
>>> On 6/29/26 09:48, Lance Yang wrote:
>>>>
>>>> >from pagewalk code (where some users like pagemap need the actual address).
>>>>
>>>> Indeed ...
>>>>
>>>>
>>>> Kinda lean toward option 1, even if it's more invasive. If we pass the
>>>> hstate down, each arch can figure out the right addr from there.
>>>>
>>>>
>>>> AFAICT, for huge_ptep_get() the addr users are arm64 and powerpc, riscv
>>>> doesn't really care about addr there. Looks mostly arm64-specific ... 
>>> powerpc handles it correctly in the weird "span two PMD entries" case by
>>> aligning the PMD down.
>>>
>>> Risc-v copied from arm64, but can simply derive the #entries from the PTE value.
>>> it doesn't have to re-walk the table using the address.
>>>
>>> But I think the following is required to fix, no?
>>
>> We don't receive an unaligned ptep in huge_ptep_get, and riscv derives the
>> number of cont ptes from the pte itself, so why is the below required?
> 
> Let me look at the actual report once more ...
> 
> I thought for a second that the problem would be having the ptep not point at the
> start of the hugetlb page mapping. But that should always be the case.
> So yes, riscv does not have any problems.
> 
> And IIUC, arm64 only has a problem when CONT_PTES != CONT_PMDS (16 kernel?).
> 
> Yeah, aligning the ptep down doesn't solve anything, it's already properly aligned.
> 
> To fix it inside arm64 code, we'd have to teach find_num_contig() to
> ignore the ptep and instead look for the cont bit, maybe?
> 
> But I'm sure I messed this up as I am working on 10 things at the same time :D
> 
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index d477a9dd1b472..d1d03795c135e 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -76,7 +76,7 @@ bool arch_hugetlb_migration_supported(struct hstate *h)
>  #endif
>  
>  static int find_num_contig(struct mm_struct *mm, unsigned long addr,
> -                          pte_t *ptep, size_t *pgsize)
> +                          size_t *pgsize)
>  {
>         pgd_t *pgdp = pgd_offset(mm, addr);
>         p4d_t *p4dp;
> @@ -87,7 +87,7 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
>         p4dp = p4d_offset(pgdp, addr);
>         pudp = pud_offset(p4dp, addr);
>         pmdp = pmd_offset(pudp, addr);
> -       if ((pte_t *)pmdp == ptep) {
> +       if (pmd_cont(*pmdp)) {

We can simply do this right:

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index b8432886085af..a35fa373263dc 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -87,7 +87,7 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
 	p4dp = p4d_offset(pgdp, addr);
 	pudp = pud_offset(p4dp, addr);
 	pmdp = pmd_offset(pudp, addr);
-	if ((pte_t *)pmdp == ptep) {
+	if ((pte_t *)PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS) == ptep) {
 		*pgsize = PMD_SIZE;
 		return CONT_PMDS;
 	}


>                 *pgsize = PMD_SIZE;
>                 return CONT_PMDS;
>         }
> @@ -131,7 +131,7 @@ pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>         if (!pte_present(orig_pte) || !pte_cont(orig_pte))
>                 return orig_pte;
>  
> -       ncontig = find_num_contig(mm, addr, ptep, &pgsize);
> +       ncontig = find_num_contig(mm, addr, &pgsize);
>         for (i = 0; i < ncontig; i++, ptep++) {
>                 pte_t pte = __ptep_get(ptep);
>  
> @@ -475,7 +475,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
>                 return;
>         }
>  
> -       ncontig = find_num_contig(mm, addr, ptep, &pgsize);
> +       ncontig = find_num_contig(mm, addr, &pgsize);
>  
>         pte = get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
>         pte = pte_wrprotect(pte);
> diff --git a/mm/memory.c b/mm/memory.c
> 
> 

