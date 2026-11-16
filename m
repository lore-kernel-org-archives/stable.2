Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839913;
	b=SoXRNqd81msIgudDggiLSQHiRqN49QNhMNVZNWtUmLjP7IvXCwNgNTbef7Hat4j9qWDi
	 jpZM+CQPYgSiZzDJ00HzZZbj+jWaiXq6T8nR7H6XDRCXyn88ysEfj9MDDGZoyeZk86Qjv
	 QeGrkQFsyZmfX2MkC90DYHNruS+DUbNvI81MSHsnWmM/8TNCc69ke07Ei95GKyfa2W7yM
	 B9zDXYLRYwtwZYHTBN8jN60KvL1QK4KlwEAyNAiePrPXM1dzZhMwC8RfzLoCBFxnbS15h
	 IR1ksBaqxzp8ileW5JE+UgSZHNnfNehjkDyXGMalfJnhOxDWR+B1qxfstMSkOsSNmZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839913;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=LuZbrEms8/XjVfQuEiWI77RY5HstSttO4i4AHQMMfTc=;
	b=KYiMFtiW3KK3eME5mND1lcnwmsYnx2meSyytW3WtIyXThSvkl9RHfBPJi/RR1evzbZX9
	 ZMfr+8CsfeOg5u3aIrfWsSCQp9wfdnykks9TMaBLPXuDLVHY6j58vPlKT4Te0bayI6G9y
	 X0LBLp0pLjsvkUhDF6dfOvrs6ljcUkhThwUxQ3Rpe7db5kwcmuZRehuLyUPLQZFCLMajL
	 gTxqrWog7jFHtK0IT1hmVE8KfsiE2mdQeIhhj0cqgzflwooXbT9sSaaURFM+TjedLCV+C
	 5rNq6RO7FNl6kNDdplw6VOX9nZDgGjpGoViMw812h49CWJill2LqpLZjpW7q/deHK9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SUIMehYn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5C3606A32A;
	Mon, 16 Nov 2026 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SUIMehYn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4A61F000C5;
	Mon, 16 Nov 2026 14:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794839912;
	bh=LuZbrEms8/XjVfQuEiWI77RY5HstSttO4i4AHQMMfTc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SUIMehYnz+NkUe0s2KVDqKyd60bR9BnVVKhVRKxgUTq24AJFSodw6eK+Vn7iSNqB9
	 17mHZrB0TFnYq1Ka3dPkUDWrLOyKFdNgUT2fPUkmOujGS+6Zadkn0ReXMB8AFsj1zC
	 h3qWLOnwIIpEFujVi8NKJIzw6UMpUcI0RWu+ogFDlwh2cqrt/fePQtDrcohX9d2QQq
	 +r6SwrPXbN1mL/8Jx+j2n/YKQ3qdkiPOYHAe2l0jR4SN8KLBgImGZIQ3jTh4lPKbRU
	 ZCGuM7VZwsht7BN4YjxY1QKsdOAfGB112ToEvM0u/nMhIrpJsZzoxyK/Pqu+7wL0XC
	 z21YKetd2m2uw==
Message-ID: <c32e4671-e785-400a-973a-7f973af08e2b@kernel.org>
Date: Mon, 16 Nov 2026 15:38:22 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: flush dirty file PMDs before removing
 rmap
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Will Deacon <will@kernel.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jan Kara <jack@suse.cz>, Ross Zwisler <zwisler@kernel.org>,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>
References: <20261113-dirty_file_pmd-v1-1-8c11f2a2e65f@kernel.org>
 <avrxOt_GyXLXNqtR@gremlin>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <avrxOt_GyXLXNqtR@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/26 13:25, Lorenzo Stoakes (ARM) wrote:
> On Fri, Nov 13, 2026 at 06:15:26PM +0100, David Hildenbrand (Arm) wrote:
>> Unmapping a file PMD can lose concurrent stores when it races with
>> writeback. zap_huge_pmd() removes rmap and drops the PMD lock before the
>> gather flushes the TLB. Writeback can then clean the folio while another
>> CPU can still write through a stale writable TLB entry. Those stores do
>> not fault and dirty the folio again. Filesystem DAX has the same problem
>> with its dirty tags.
>>
>> Commit 5df397dec7c4 ("mm: delay page_remove_rmap() until after the TLB
>> has been flushed") fixed the same race for PTEs by adding delayed rmap
>> removal to the mmu_gather infrastructure. The PMD path still removes
>> rmap before flushing.
>>
>> Flush the TLB under the PMD lock before removing rmap for dirty file
>> PMDs. Skip the early flush at address-space teardown, when no users
>> remain, and for mappings without writeback, including shmem and device
>> DAX.
>>
>> Use tlb_can_delay_rmap() to share the PTE path's architecture checks.
>> On s390, clearing the entry already handles TLB synchronization, and
>> __tlb_remove_page_size() immediately drops the mapping reference, so
>> rmap must be removed first. UP cannot have concurrent stores from
>> another CPU while holding the page table lock. Make the predicate
>> side-effect-free and set the gather's delayed_rmap flag when an entry
>> is actually queued for delayed rmap removal.
>>
>> Queue the folio before the early flush, while the gather still has a
>> valid range. Keep batching references and drain a full batch only after
>> dropping the PMD lock. The early flush resets the gather's TLB state,
>> so draining the batch does not flush that range again.
>>
>> Although writing to files through mmap is generally discouraged,
>> unmapping such mappings may become slower: each dirty file PMD now
>> requires a TLB flush under the PMD lock. Future work should properly
>> extend the delayed-rmap machinery to PMDs and hold the PMD spinlock
>> across multiple entries, so their TLB invalidations and rmap removals
>> can be batched.
>>
>> Fixes: 4b4bb46d00b3 ("dax: clear dirty entry tags on cache flush")
>> Cc: stable@vger.kernel.org
>> Reported-by: Kiryl Shutsemau <kas@kernel.org>
>> Link: https://lore.kernel.org/linux-mm/aoWw_iKEDLjKL2jr@thinkstation/
>> Reported-by: Chris Mason <mason@kernel.org>
>> Suggested-by: Lance Yang <lance.yang@linux.dev>
>> Suggested-by: Usama Arif <usama.arif@linux.dev>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  include/asm-generic/tlb.h | 10 +++-------
>>  mm/huge_memory.c          | 38 ++++++++++++++++++++++++++++++--------
>>  mm/memory.c               |  2 +-
>>  mm/mmu_gather.c           |  2 ++
>>  4 files changed, 36 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>> index 4bba02fd5d543..2dcf4ce0de589 100644
>> --- a/include/asm-generic/tlb.h
>> +++ b/include/asm-generic/tlb.h
>> @@ -250,11 +250,7 @@ bool __tlb_remove_folio_pages(struct mmu_gather *tlb, struct page *page,
>>  		unsigned int nr_pages, bool delay_rmap);
>>
>>  #ifdef CONFIG_SMP
>> -/*
>> - * This both sets 'delayed_rmap', and returns true. It would be an inline
>> - * function, except we define it before the 'struct mmu_gather'.
>> - */
>> -#define tlb_delay_rmap(tlb) (((tlb)->delayed_rmap = 1), true)
>> +#define tlb_can_delay_rmap() (true)
>>  extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
>>  #endif
>>
>> @@ -267,8 +263,8 @@ extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
>>   * remote TLBs to flush and is not preemptible due to this
>>   * all happening under the page table lock.
>>   */
>> -#ifndef tlb_delay_rmap
>> -#define tlb_delay_rmap(tlb) (false)
>> +#ifndef tlb_can_delay_rmap
>> +#define tlb_can_delay_rmap() (false)
>>  static inline void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
>>  #endif
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 7791872f14af7..600a68a54ecf8 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2508,10 +2508,12 @@ static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
>>  	mm_dec_nr_ptes(mm);
>>  }
>>
>> -static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
>> -		pmd_t pmdval, struct folio *folio, bool is_present)
>> +static void zap_huge_pmd_folio(struct mmu_gather *tlb, struct vm_area_struct *vma,
>> +		pmd_t pmdval, struct folio *folio, bool is_present, bool *force_flush)
>>  {
>>  	const bool is_device_private = pmd_is_device_private_entry(pmdval);
>> +	struct mm_struct *mm = tlb->mm;
>> +	bool delay_rmap = false;
>>
>>  	if (folio_test_anon(folio)) {
>>  		add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
>> @@ -2519,23 +2521,41 @@ static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
>>  		add_mm_counter(mm, mm_counter_file(folio),
>>  			       -HPAGE_PMD_NR);
>>
>> -		if (is_present && pmd_dirty(pmdval))
>> +		if (is_present && pmd_dirty(pmdval)) {
>>  			folio_mark_dirty(folio);
>> +			/*
>> +			 * Remove rmap after the TLB flush if other CPUs could
>> +			 * still write to a mapping that supports writeback.
>> +			 */
>> +			if (!tlb->fullmm && vma->vm_file &&
>> +			    mapping_can_writeback(vma->vm_file->f_mapping))
>> +				delay_rmap = tlb_can_delay_rmap();
> 
> Claude flagged an issue here - for UP arches this is false, so
> zap_huge_pmd_folio() doesn't flush under the PMD lock or defer the rmap removal.

Yes, and that's a preexisting issue in the PTE case. Let me dig.

-- 
Cheers,

David
