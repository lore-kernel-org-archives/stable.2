Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABBE410D04;
	Tue, 30 Jun 2026 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823596; cv=none; b=TpgCSDmKJB3/Hxxf+KgHi/bc+duQZMvBYt+YiZSScWxiKk2hweL1iJKKjx/isfcINWQ3yR/HrYE5n637j/ZyQ+0Ea8WX7GndM1g2IEabQFut1wu0G+BtkTL6Zr+hfADLFPiQI9KDZyB8/1+rJgGYKOT8z7U5gFueoYiE4yBGpUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823596; c=relaxed/simple;
	bh=RT0dwjn0lBQ3vrq53HCmpzrU5ySV3XD8Calq9B5BmuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1K2kG0YBWH3k1pXtnFFjp11z6Kp3MykBeW//ylEnTh/M9eMSQBo9XPSa6saXcKgExm54fLX9NxLWPSvIu2T8lQcIOw1HBpjaFo+UScFoCuJICl8f9uJjaQp/Xyc6U39uNwXB7beAP32ErFy2B6F5QL56yKDilrACObhxsoZxJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9fHtvOQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9fHtvOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172481F000E9;
	Tue, 30 Jun 2026 12:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782823595;
	bh=zVRDifu1QOyyXsAGZkUm6ew4XqjId6qSZyoyYBdxCL4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l9fHtvOQOP1Ai0VpWvZKiub+ksLWhWziADe3pLNfPxthadvVrmehxH6q/40yTMPH1
	 VKlXtQcRFJUncsgox7z1MmPK+41arWoWSKb15luQrC+c7RZwPSRh6YaHuQHVDlr2zP
	 gE8n346B54Meo0ciXzFd11xIDgLQSmDXCrxIp2W8SKL2lQh5UiOZ7YltjkSkgnWpY4
	 EK8BYZHlvO7zQkCqxwftcbSy93CqfKyBZyqQhAuzUVHKqA45XL81fXEVvoJ4dwFkfn
	 DFgd9gCeYXOIecVHrqwaum6X/8FjP9lDctXz4DYecsPkUmIuLDbc5l7elbP5B9KEUA
	 WAar42Kf9ZP1Q==
Message-ID: <1fb04774-1ac6-472a-bbc8-52fceb69b018@kernel.org>
Date: Tue, 30 Jun 2026 14:46:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] mm/page_vma_mapped: use huge_ptep_get() for hugetlb
To: Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>
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
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <6fdc0cbd-0880-4594-bf33-a2993ac2fe60@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 13:34, Dev Jain wrote:
> 
> 
> On 29/06/26 1:35 pm, David Hildenbrand (Arm) wrote:
>> On 6/29/26 09:48, Lance Yang wrote:
>>>
>>> >from pagewalk code (where some users like pagemap need the actual address).
>>>
>>> Indeed ...
>>>
>>>
>>> Kinda lean toward option 1, even if it's more invasive. If we pass the
>>> hstate down, each arch can figure out the right addr from there.
>>>
>>>
>>> AFAICT, for huge_ptep_get() the addr users are arm64 and powerpc, riscv
>>> doesn't really care about addr there. Looks mostly arm64-specific ... 
>> powerpc handles it correctly in the weird "span two PMD entries" case by
>> aligning the PMD down.
>>
>> Risc-v copied from arm64, but can simply derive the #entries from the PTE value.
>> it doesn't have to re-walk the table using the address.
>>
>> But I think the following is required to fix, no?
> 
> We don't receive an unaligned ptep in huge_ptep_get, and riscv derives the
> number of cont ptes from the pte itself, so why is the below required?

Let me look at the actual report once more ...

I thought for a second that the problem would be having the ptep not point at the
start of the hugetlb page mapping. But that should always be the case.
So yes, riscv does not have any problems.

And IIUC, arm64 only has a problem when CONT_PTES != CONT_PMDS (16 kernel?).

Yeah, aligning the ptep down doesn't solve anything, it's already properly aligned.

To fix it inside arm64 code, we'd have to teach find_num_contig() to
ignore the ptep and instead look for the cont bit, maybe?

But I'm sure I messed this up as I am working on 10 things at the same time :D


diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index d477a9dd1b472..d1d03795c135e 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -76,7 +76,7 @@ bool arch_hugetlb_migration_supported(struct hstate *h)
 #endif
 
 static int find_num_contig(struct mm_struct *mm, unsigned long addr,
-                          pte_t *ptep, size_t *pgsize)
+                          size_t *pgsize)
 {
        pgd_t *pgdp = pgd_offset(mm, addr);
        p4d_t *p4dp;
@@ -87,7 +87,7 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
        p4dp = p4d_offset(pgdp, addr);
        pudp = pud_offset(p4dp, addr);
        pmdp = pmd_offset(pudp, addr);
-       if ((pte_t *)pmdp == ptep) {
+       if (pmd_cont(*pmdp)) {
                *pgsize = PMD_SIZE;
                return CONT_PMDS;
        }
@@ -131,7 +131,7 @@ pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
        if (!pte_present(orig_pte) || !pte_cont(orig_pte))
                return orig_pte;
 
-       ncontig = find_num_contig(mm, addr, ptep, &pgsize);
+       ncontig = find_num_contig(mm, addr, &pgsize);
        for (i = 0; i < ncontig; i++, ptep++) {
                pte_t pte = __ptep_get(ptep);
 
@@ -475,7 +475,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
                return;
        }
 
-       ncontig = find_num_contig(mm, addr, ptep, &pgsize);
+       ncontig = find_num_contig(mm, addr, &pgsize);
 
        pte = get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
        pte = pte_wrprotect(pte);
diff --git a/mm/memory.c b/mm/memory.c


-- 
Cheers,

David
