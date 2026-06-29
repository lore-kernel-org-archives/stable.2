Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7483A3C1094;
	Mon, 29 Jun 2026 08:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782720347; cv=none; b=tk8HwPVLCV4PkrSkSCk5MwOuwWA0VtZi+VkfAt3N2/+a8yeQaDoNvlhaclr78NSH06tTreQjYvoyP6QxPKMYU6hvZL2dKUxiUqVIqQkc+cZZq3p8WlZQaJ6aCDX1CnCwAtwNzWNntCAoCNNBgxO/Ehql94wts13xgvlnGMEDySk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782720347; c=relaxed/simple;
	bh=buXJIIEXekLyzktQ/7C0hS8mt8zx4DI5H6PGmvM2lVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TcvOMwLXCk3eAQHMvWAmjQK/UM0cy3QTMl4xTkqoLy8W/3vwQKILtYzgXBAmwoiCwU0zC6cMH2dKZTXF5Vfvlp9VqyH1W5sIQ+wzgtZHKXHo7Cy8wGz+GxazooEF6PbvzdP1095C0smtjB+RUVu4CgIICUmDrwvjMlmSCvCRFUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPZyX1P0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPZyX1P0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F641F000E9;
	Mon, 29 Jun 2026 08:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782720346;
	bh=JEg7brAAvAD6VmAeeUK1ttX0+QTXv/iHt/rkrKR6nWA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WPZyX1P06ncN7ohxau8IAqQhLuNlBAz4PPzAKX50qNhkWdcc4cmC7HcKmOrcb9GV5
	 Fi0r4sPBd/qvGFxMGYKrnYhRp9UND1K8i6wPYWmDEqwP6rGo1TCpaxsW4I8m8Qa68D
	 5WT+hcZQwpQzInpI2o3Q4dBVXg8UC7YCZzwKqY0uHsH0tYJBrwHIrDPku/+tFLKKhk
	 6VSqVTwFYLENOlwgOSBFvBuk0kx92H25JzLBPYbTTZ263Zs+95SbiYgzu1IZbJqHJd
	 B68yT17ThRUd1lQnspzkE77ctLEhmWxxGE+JbP5vWDdVDLRw050NTKr2noUiVoo/ll
	 n9o761p2ow3lQ==
Message-ID: <a1c6c3dd-8db1-4db6-b032-e350bacc4577@kernel.org>
Date: Mon, 29 Jun 2026 10:05:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] mm/page_vma_mapped: use huge_ptep_get() for hugetlb
To: Lance Yang <lance.yang@linux.dev>, dev.jain@arm.com
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
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20260629074802.42727-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 09:48, Lance Yang wrote:
> 
> On Mon, Jun 29, 2026 at 09:25:48AM +0200, David Hildenbrand (Arm) wrote:
>> On 6/29/26 08:48, Dev Jain wrote:
>>>
>>>
>>>
>>> Sashiko notes other places:
>>>
>>> https://sashiko.dev/#/patchset/20260625112955.3254283-1-dev.jain%40arm.com
>>
>> Yeah, that looks shaky. We do seem to have a bunch of these cases, primarily
>>from pagewalk code (where some users like pagemap need the actual address).
> 
> Indeed ...
> 
>> I think we have two options
>>
>> 1) To prevent any (further) issues, make huge_ptep_get() always consume the
>> hstate, and let the arch code deal with aligning it. Invasive.
> 
> Kinda lean toward option 1, even if it's more invasive. If we pass the
> hstate down, each arch can figure out the right addr from there.
> 
>> 2) Make the arch code handle aligning without the hstate.
>>
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index 30772a909aea3..303a1b74796c9 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -126,6 +126,9 @@ pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>>                return orig_pte;
>>
>>        ncontig = find_num_contig(mm, addr, ptep, &pgsize);
>> +       ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * ncontig);
>> +       orig_pte = __ptep_get(ptep);
>> +
>>        for (i = 0; i < ncontig; i++, ptep++) {
>>                pte_t pte = __ptep_get(ptep);
>>
>> (nshift/order instead of ncontig might avoid a multiplication, but not sure if that matters in practice)
>>
>> IIUC, that's similar to what huge_ptep_get() does on ppc.
>>
>>
>> static inline pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>> {
>> 	if (ptep_is_8m_pmdp(mm, addr, ptep))
>> 		ptep = pte_offset_kernel((pmd_t *)ptep, ALIGN_DOWN(addr, SZ_8M));
>> 	return ptep_get(ptep);
>> }
>>
>> I'd assume we could do the same on riscv. Besides that, I don't think any arch has cont
>> entries.
> 
> AFAICT, for huge_ptep_get() the addr users are arm64 and powerpc, riscv
> doesn't really care about addr there. Looks mostly arm64-specific ... 
powerpc handles it correctly in the weird "span two PMD entries" case by
aligning the PMD down.

Risc-v copied from arm64, but can simply derive the #entries from the PTE value.
it doesn't have to re-walk the table using the address.

But I think the following is required to fix, no?

diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index a6d217112cf46..7e25cc13b3dba 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -5,6 +5,7 @@
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
 pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
-       unsigned long pte_num;
+       unsigned long pte_num, pte_order;
        int i;
        pte_t orig_pte = ptep_get(ptep);
@@ -12,7 +13,11 @@ pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr,
pte_t *ptep)
        if (!pte_present(orig_pte) || !pte_napot(orig_pte))
                return orig_pte;

-       pte_num = napot_pte_num(napot_cont_order(orig_pte));
+       pte_order = napot_cont_order(orig_pte);
+       pte_num = napot_pte_num(pte_order);
+
+       ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) << pte_order);
+       orig_pte = ptep_get(ptep);

        for (i = 0; i < pte_num; i++, ptep++) {
                pte_t pte = ptep_get(ptep);



I'd prefer (2) as a simple stable fix first.

If we do (1) on top, huge_ptep_get() on arm64 could stop walking the page table
another time.

If we pass the hstate (or vma) to set_huge_pte_at(), huge_pte_clear(),
huge_ptep_get_and_clear(), we could likely get rid of the re-walk in
num_contig_ptes() entirely and possibly just remove it.

That would probably be cleanest.

-- 
Cheers,

David
