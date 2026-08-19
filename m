Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6238230B514;
	Wed, 19 Aug 2026 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787148834; cv=none; b=Mpwi0qegV7dPvHIKDiEP12nrd8JP9ObSYF2ndVjOTfC72/mhwTgK02cECyluvcL8WEUtak2DQ9hGgWSfvJJlFM0mkadsCTovHyVhQB67G+0X6VCBwf3pMHcrXplYPW3b/H1xnpsddE+4Sybwll70ZeQdXoCaziuOe5dXaET59js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787148834; c=relaxed/simple;
	bh=lqDrErKa5YE0fmtSpwGaAftiWXEijy1Y1qdK9BE+i5Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=STaIa2aWxNiloKEGgaeRalh/MWQTkdjVsuM3s0XEEkpc3mlcwSZDhyD7ZPKkYtsG0FZMZZ61YV6BBiq7jLLdmVk1q1kfYju6DqoZzhTs9qDS2cP44tEVb7v2X23ACtKnq/QkKWXXN9qD9KmW4XSs0sbdOKf04VNUT7JQqxcm8tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7I8mRiz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7I8mRiz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18ABC1F000E9;
	Wed, 19 Aug 2026 14:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787148833;
	bh=ZAcPVYBwCwlRbFWasg8/xtIg2Y5PLtEjTE2sgm9V8K0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=n7I8mRiztlyvV8aXq8zcIvHLh0wxIwAIpvk6GPsebAgpC+B6T0Df7rQN1t1WELX2r
	 a4nyQKh2iWEN3pREWaFH4b9ED1H6Ht02QEnWDsZwaOswqv5w1sKwJ0nMFvwdgZsVz6
	 gxWmK8QnxknJlysgG5ab3tUnrF1uk7e5+c1j65v/fc3uxqu8+5OyLbyF9JMpql36eL
	 dnzq3oSCYmzCi/SIAqyzfTLItMNuOUpj1m6cZIO5cQSwSdcy536jNfyZNsLid4FTGk
	 he8/ceCooMLT9bT1L7EtGCzCMAbYnAAyw3xIdFkceD60o4jQcIcrAfQ/79BgFB+h3D
	 c5Ki05VjckAXg==
Message-ID: <cb75b0b5-02f1-4173-a689-5a7af3262a87@kernel.org>
Date: Wed, 19 Aug 2026 16:13:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: transfer the pmd dirty bit to the folio
 on zap
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: Usama Arif <usama.arif@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dev.jain@arm.com, lance.yang@linux.dev,
 liam@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ljs@kernel.org, nico.pache@linux.dev, ryan.roberts@arm.com, ziy@nvidia.com,
 kas@kernel.org, nphamcs@gmail.com, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kernel-team@meta.com
Cc: stable@vger.kernel.org
References: <20260819101222.3732660-1-usama.arif@linux.dev>
 <54d45248-1a06-43db-b71b-3d5e0fda9de4@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <54d45248-1a06-43db-b71b-3d5e0fda9de4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/26 16:13, David Hildenbrand (Arm) wrote:
> On 8/19/26 12:12, Usama Arif wrote:
>> zap_huge_pmd_folio() propagates the pmd young bit to the folio for the
>> file case, but not the dirty bit.  The pte path does propagate it, in
>> zap_present_folio_ptes() and so does the pmd split path, in
>> __split_huge_pmd_locked().
>>
>> For most file mappings the omission is harmless, because writing to a
>> shared file mapping goes through page_mkwrite(), which dirties the
>> folio.  tmpfs is different: it has no page_mkwrite(), and
>> vma_wants_writenotify() is false for it, so a *read* fault on a
>> MAP_SHARED tmpfs mapping installs a writable pmd via do_read_fault().
>> do_read_fault() does not call fault_dirty_shared_page(), so subsequent
>> stores through that mapping set only the hardware dirty bit in the pmd
>> and never call folio_mark_dirty().  A shmem folio allocated by a fault
>> is marked uptodate but not dirty (see the clear: block in
>> shmem_get_folio_gfp()), so PG_dirty is never set at all.
>>
>> Unmapping such a folio - munmap(), or exit_mmap() when the process dies
>> - then loses the only record that it was written, because zap_huge_pmd()
>> drops the pmd without transferring the dirty bit.  Reclaim afterwards
>> sees a clean shmem folio: the whole swap-out block in
>> shrink_folio_list() is inside "if (folio_test_dirty(folio))", so
>> pageout() is skipped and the folio falls into __remove_mapping().
>> There, folio_is_file_lru() is false for a swapbacked folio, so no shadow
>> entry is created and __filemap_remove_folio(folio, NULL) simply empties
>> the i_pages slot.  The data is freed without ever being written to swap,
>> and the next fault on that index returns a freshly zeroed folio.
>>
>> This is silent data loss for any process that keeps state in a
>> MAP_SHARED tmpfs segment across an unmap - for example a cache handed
>> from one process generation to the next through /dev/shm.  It requires
>> the folio to be PMD-mapped, so it only shows up once shmem THP is
>> enabled (which is what we did in Meta fleet and started noticing crashes);
>> with THP off the pte path transfers the dirty bit correctly.
>> It also only becomes visible when swap is enabled, because with no swap
>> device shmem folios (which are on the anon LRU) are not scanned by
>> reclaim at all, so the clean folio is never dropped.
>>
>> Reproduced on x86_64 with a tmpfs mounted huge=within_size: read-fault a
>> 2MB-backed region, write a known pattern through the resulting mapping,
>> munmap, force reclaim of the cgroup, then re-map and read back.  Without
>> this patch the region reads back as zeros and vmstat shows zswpout 0 -
>> the data was discarded rather than swapped.  With this patch the region
>> reads back correctly and the pages are swapped out as expected.  With
>> huge=never, or when the first touch is a write, the test passes either
>> way.
>>
>> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
>> ---
>>  mm/huge_memory.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index ced400f72d43a..afbb5974bd225 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2449,6 +2449,8 @@ static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
>>  		add_mm_counter(mm, mm_counter_file(folio),
>>  			       -HPAGE_PMD_NR);
>>  
>> +		if (is_present && pmd_dirty(pmdval))
>> +			folio_mark_dirty(folio);
> 
> We don't need that for anon folios, though. So best to just resemble
> zap_present_folio_ptes() logic and do it only for !anon folios?
> 

I'm stupid, that check is not visible in the diff above :)

Thanks!

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
