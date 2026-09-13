Received: from mta0.migadu.com (out-209.mta0.migadu.com [91.218.175.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F5348C4B
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789284224; cv=none; b=uAxt625SUgM6X7GcGvjcUbTkLzB18fEE5AjA1hueMioHoGc+F2V/b2aDRT5Y5KigvmNLM3R0yyqlm8IU2acr/gdSaiLDBWMsp+/6yFmAE6+lwTHl1Fp8/N2ryqXU3LRiLuuJT/Cm8208aquCrkSO4hb3TwjmzPQt9neHqiYvr70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789284224; c=relaxed/simple;
	bh=IxZ5irpoc9Wr9wY2wKWP3i1ANdXlxPv1vjeqCqP4vuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyEgy5Zmm874DsYdxV8vkUOlTGN+TrFjmYFlmJw3ry6LeexlgS7Ir9I1Al76GqeYKpRv45ZN63G8Je07tOrrrWrdfgRpNJYwXZXr/9dcNrtufra1/YHm550vGjgKfBvV328Y/bYcRe8E+tk63tD6fphAhokfNWzf0q0Z84D5u/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gVN42bTL; arc=none smtp.client-ip=91.218.175.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gVN42bTL"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IxZ5irpoc9Wr9wY2wKWP3i1ANdXlxPv1vjeqCqP4vuI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789284219; v=1; x=1789889019;
 b=gVN42bTLJHEEpg1p4L9bINSm2s8Z5Jm2mwRO2k7kkH5pmlJktgBDF2fp/wnkomQSGNRg19bq
 cLCFQPOk2AEIfyZETjX1ESTKuSCzf55Bak9dHzZknyl+hV10ZGppV1VR6y6Ic8hbcJOxtHCgL6y
 iPK+HKzUwjEl98TmCPSrq5rc=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fc7f62b8527fd901;
	Sun, 13 Sep 2026 07:23:29 +0000
X-Mizu-Trace-ID: fc7f62b8527fd901
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: lance.yang@linux.dev,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	usama.arif@linux.dev,
	kas@kernel.org,
	ljs@kernel.org,
	surenb@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/huge_memory: fix pgtable withdrawal for huge zero PMDs
Date: Sun, 13 Sep 2026 15:23:12 +0800
Message-Id: <20260913072312.52111-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260912234635.db50397364858aa15f58f4d7@linux-foundation.org>
References: <20260912234635.db50397364858aa15f58f4d7@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sat, Sep 12, 2026 at 11:46:35PM -0700, Andrew Morton wrote:
>On Sun, 13 Sep 2026 13:19:42 +0800 Lance Yang <lance.yang@linux.dev> wrote:
>
>> From: Lance Yang <lance.yang@linux.dev>
>> 
>> has_deposited_pgtable() uses !vma_is_dax() to decide whether a huge zero
>> PMD has a deposited PTE page table. That also accepts raw PFN mappings
>> of huge_zero_pfn, although vmf_insert_pfn_pmd() does not deposit a page
>> table on x86.
>> 
>> Zapping such a mapping would call pgtable_trans_huge_withdraw() without
>> a corresponding deposit. With pmd_huge_pte(mm, pmd) == NULL, that causes
>> a NULL pointer dereference.
>
>That's the sort of thing we'd prefer to avoid.
>
>> Use vma_is_anonymous() for the huge zero PMD check. This matches how PTE
>> page tables are allocated, deposited and moved.
>> 
>> - For anonymous page faults that install a huge zero PMD,
>>   do_huge_pmd_anonymous_page() allocates a PTE page table and
>>   set_huge_zero_folio() deposits it before installing the PMD.
>> 
>> - On fork, copy_huge_pmd() allocates and deposits a PTE page table when
>>   copying a huge zero PMD into an anonymous VMA.
>> 
>> - Raw PFN mappings use vmf_insert_pfn_pmd(), and DAX file holes use
>>   vmf_insert_folio_pmd() to map the huge zero folio. Both use insert_pmd(),
>>   which deposits a PTE page table only when arch_needs_pgtable_deposit()
>>   requires it.
>> 
>> - Moving an anonymous huge PMD preserves its deposited PTE page table.
>>   move_huge_pmd() transfers the deposit when necessary. For UFFD MOVE,
>>   both VMAs must be anonymous, and move_pages_huge_pmd() transfers the
>>   deposit as well.
>> 
>> Keep arch_needs_pgtable_deposit() first so architectures that require a
>> deposited PTE page table still return true regardless of the VMA type.
>> 
>> Commit d80a9cb1a64a ("mm/huge_memory: add and use
>> normal_or_softleaf_folio_pmd()") removed the vma_is_special_huge() check
>> in zap_huge_pmd(). That check skipped the huge zero PMD deposit test for
>> non-DAX VM_PFNMAP and VM_MIXEDMAP mappings. Removing it exposed these
>> mappings to the incorrect !vma_is_dax() test.
>> 
>> Fixes: d80a9cb1a64a ("mm/huge_memory: add and use normal_or_softleaf_folio_pmd()")
>> Cc: stable@vger.kernel.org
>
>How real is this?  Is there a reported-by:?  Do you have a reproducer? 

Yes, I reproduced it on x86 with a small test module. It sets
VM_MIXEDMAP | VM_HUGEPAGE and calls vmf_insert_pfn_pmd() with
huge_zero_pfn, without touching the page tables directly. A full-PMD
munmap() crashes before the split series[1] as well.

>Is it a theoretical, LLM-found-this thing which can't really happen?

I found this while reviewing the split series with LLM assistance.

mshv_vtl_low derives the PFN from the mmap offset, and its checks do not
exclude huge_zero_pfn. I haven't tested this on a Hyper-V, though.

[1] https://lore.kernel.org/linux-mm/cover.1787941780.git.yintirui@gmail.com/

>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2529,11 +2529,11 @@ static bool has_deposited_pgtable(struct vm_area_struct *vma, pmd_t pmdval,
>>  		return true;
>>  
>>  	/*
>> -	 * Huge zero always deposited except for DAX which handles itself, see
>> -	 * set_huge_zero_folio().
>> +	 * Huge zero PMDs have a deposited page table only for anonymous VMAs,
>> +	 * see set_huge_zero_folio().
>>  	 */
>>  	if (is_huge_zero_pmd(pmdval))
>> -		return !vma_is_dax(vma);
>> +		return vma_is_anonymous(vma);
>>  
>>  	/*
>>  	 * Otherwise, only anonymous folios are deposited, see
>
>Thanks, I'll add it for test-n-review.

Thanks!
