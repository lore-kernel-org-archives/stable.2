Received: from mta1.migadu.com (out-218.mta1.migadu.com [95.215.58.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D048662F
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157160; cv=none; b=uzbXi8dXe/R1cMHFIrYd9WI3tLhgrqG14k1DxSFlJ39rS/lA3ar+hjqcjbgNLhWTqlSxMDaQlKjTuFo8/92BREmKMtxZ5jbiw7el4dMceA8YQ78ihfiCPbg8YNac+Wf8yq2qrGwS1ugJuQSLmOBu142boiBXg6DQfvLtk5tnA0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157160; c=relaxed/simple;
	bh=zxkoUC4bgxUtiTO0LYujsc/ZDtFLJGnt/5/oXxFaLqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PN++FGP+Pf3ELSK/dQi8SloyPatTAZszsLgCAGfHXc6O402n3RYwDwGXRz1qtcsqerFGsuByqvHFVvtF+aOfdpNhEzEBHW2/eYljgSueiCmcTjPkBa1nLeYhSi+K9DQ1qwFatADSnGX7K4S/6i/0z/Mog4idHANsbh7lD8vf9HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kauuV0qv; arc=none smtp.client-ip=95.215.58.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kauuV0qv"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zxkoUC4bgxUtiTO0LYujsc/ZDtFLJGnt/5/oXxFaLqo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787157155; v=1; x=1787761955;
 b=kauuV0qvk+nddmk8N88Tg4r9m+tmv11v81X1/Ote7n7vArJhi78VlCePe4bCi6wipuBNmBqJ
 Oemk6UdiCpOOGRG/8KPlgCxKr3DI76E7nV60SkZfCqGckQRYxL12QATKpLoKrGCeJ776cpoqm38
 QENTxzivd8lKC/ZFizop58tQ=
X-Envelope-To: stable@vger.kernel.org
Received: from [IPV6:2a03:83e0:1126:4:9d:a05e:5bd8:c200] (2620:10d:c092:500::4:a428)
	by smtp.migadu.com with ESMTPS id f5385ad13ce1f56a;
	Wed, 19 Aug 2026 16:32:35 +0000
X-Mizu-Trace-ID: f5385ad13ce1f56a
X-Migadu-Flow: FLOW_OUT
Message-ID: <1d0271fc-9f60-4b7f-8b89-e82a4f7034d5@linux.dev>
Date: Wed, 19 Aug 2026 17:32:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: transfer the pmd dirty bit to the folio
 on zap
To: Lance Yang <lance.yang@linux.dev>, kas@kernel.org
Cc: hughd@google.com, akpm@linux-foundation.org, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com,
 liam@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ljs@kernel.org, nico.pache@linux.dev, ryan.roberts@arm.com, ziy@nvidia.com,
 nphamcs@gmail.com, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kernel-team@meta.com, stable@vger.kernel.org
References: <aoWw_iKEDLjKL2jr@thinkstation>
 <20260819161728.70270-1-lance.yang@linux.dev>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260819161728.70270-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/08/2026 17:17, Lance Yang wrote:
> 
> On Wed, Aug 19, 2026 at 03:31:40PM +0100, Kiryl Shutsemau wrote:
>> On Wed, Aug 19, 2026 at 03:12:22AM -0700, Usama Arif wrote:
> [...]
>>> ---
>>>  mm/huge_memory.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index ced400f72d43a..afbb5974bd225 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -2449,6 +2449,8 @@ static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
>>>  		add_mm_counter(mm, mm_counter_file(folio),
>>>  			       -HPAGE_PMD_NR);
>>>  
>>> +		if (is_present && pmd_dirty(pmdval))
>>> +			folio_mark_dirty(folio);
>>
>> Unrelated to your patch, but noticed while looking at it: we drop the rmap
>> here under the pmd lock, while the TLB flush is deferred to
>> tlb_finish_mmu(). The pte path handles this with
>> tlb_delay_rmap()/force_flush (5df397dec7c4), but there's no pmd equivalent:
>> tlb_flush_rmap_batch() only knows folio_remove_rmap_ptes(), and
>> zap_huge_pmd() uses tlb_remove_page_size(), which takes no delay_rmap.
> 
> Well spotted!
> 
>> Doesn't matter for shmem, but xfs & friends do get PMD-order folios, and
> 
> Right. pageout() cannot pass its refcount check while PMD mapping still
> holds an extra folio ref, and mmu_gather drops that ref only after TLB
> flush.
> 
>> do_set_pmd() makes the pmd dirty+writable once page_mkwrite() has run. So
>> folio_mkclean() can clean the folio while another CPU still stores through a
>> stale TLB entry -- silently lost write, no PG_dirty left behind.
> 
> Yep. Writeback can run folio_mkclean() while that ref is still held,
> though, and with rmap already gone it misses the PMD ...
> 
>> I think we need to fix this too.
> 
> +1
> 
>> Wanna give it a try?
> 
> zap_huge_pmd() only handles one PMD under PTL anyway ... how about just
> flushing before folio_remove_rmap_pmd()?
> 
> ---8<---
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index afbb5974bd22..6fb34924ef66 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2531,6 +2531,14 @@ bool zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	is_present = pmd_present(orig_pmd);
>  	folio = normal_or_softleaf_folio_pmd(vma, addr, orig_pmd, is_present);
>  	has_deposit = has_deposited_pgtable(vma, orig_pmd, folio);
> +	/*
> +	 * folio_mkclean() relies on the rmap to find writable mappings.
> +	 * Flush stale TLB entries before removing it below.
> +	 */
> +	if (folio && is_present && !folio_test_anon(folio) &&
> +	    pmd_dirty(orig_pmd))
> +		tlb_flush_mmu_tlbonly(tlb);
> +
>  	if (folio)
>  		zap_huge_pmd_folio(mm, vma, orig_pmd, folio, is_present);
>  	if (has_deposit)
> ---


I am currently at below to reduce tlb flushes, but still WIP


diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index bdcc2778ac64f..60bdd6287b5a9 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -301,6 +301,12 @@ bool __tlb_remove_folio_pages(struct mmu_gather *tlb, struct page *page,
  * function, except we define it before the 'struct mmu_gather'.
  */
 #define tlb_delay_rmap(tlb) (((tlb)->delayed_rmap = 1), true)
+/*
+ * Like tlb_delay_rmap() but without the side effect, for callers that must
+ * flush rather than delay: can another CPU still reach this mapping through a
+ * stale TLB entry once its rmap entry is gone? Not during fullmm teardown.
+ */
+#define tlb_rmap_needs_flush(tlb) (!(tlb)->fullmm)
 extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
 #endif

@@ -315,6 +321,7 @@ extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
  */
 #ifndef tlb_delay_rmap
 #define tlb_delay_rmap(tlb) (false)
+#define tlb_rmap_needs_flush(tlb) (false)
 static inline void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
 #endif

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index afbb5974bd225..76d8d5cf92ee0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2493,6 +2493,33 @@ static bool has_deposited_pgtable(struct vm_area_struct *vma, pmd_t pmdval,
        return folio && folio_test_anon(folio);
 }


+static bool pmd_zap_needs_tlb_flush(struct mmu_gather *tlb, pmd_t pmdval,
+                                   struct folio *folio, bool is_present)
+{
+       struct address_space *mapping;
+
+       if (!is_present || !pmd_dirty(pmdval) || folio_test_anon(folio))
+               return false;
+       if (!tlb_rmap_needs_flush(tlb))
+               return false;
+
+       mapping = folio_mapping(folio);
+       return mapping && mapping_can_writeback(mapping);
+}
+
 /**
  * zap_huge_pmd - Zap a huge THP which is of PMD size.
  * @tlb: The MMU gather TLB state associated with the operation.
@@ -2531,8 +2558,15 @@ bool zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
        is_present = pmd_present(orig_pmd);
        folio = normal_or_softleaf_folio_pmd(vma, addr, orig_pmd, is_present);
        has_deposit = has_deposited_pgtable(vma, orig_pmd, folio);
-       if (folio)
+       if (folio) {
+               /* Flush before zap_huge_pmd_folio() drops the rmap entry. */
+               if (pmd_zap_needs_tlb_flush(tlb, orig_pmd, folio, is_present)) {
+                       tlb_flush_mmu_tlbonly(tlb);
+                       /* Re-arm: tlb_remove_page_size() needs tlb->end set. */
+                       tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
+               }
                zap_huge_pmd_folio(mm, vma, orig_pmd, folio, is_present);
+       }
        if (has_deposit)
                zap_deposited_table(mm, pmd);

> 
> Cheers, Lance
> 
>>
>>>  		if (is_present && pmd_young(pmdval) &&
>>>  		    likely(vma_has_recency(vma)))
>>>  			folio_mark_accessed(folio);
>>> -- 
>>> 2.53.0-Meta
>>>
>>
>> -- 
>>  Kiryl Shutsemau / Kirill A. Shutemov
>>

