Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106968;
	b=nkiXENZBsCJow8HjMWryRLoiU11ac3jdwHVuCx+imwno4rQgZTJOoJAN5a6LbOajqM8M
	 9oV0X+KsRJMGG/hAD2/4+Jw9Fr8//AJ4+XckLCQO7qlyRBaloEzAdpaa7urcPWlAaCodw
	 CUNbE4PC1u3sInek5mXjsrLrG6PxpB+6nVxZgBKu8xqMsqR8+bQah3RsW2IT7nSkb20BQ
	 SLWLOKOkx/2knFzDUdXedI41vYJcTGu4vNfcCkcfRvZ1wMf/P5aZM+I8iVFsnMWESig3U
	 6LPHGF1SClnNvT79k9ZrFJenIayuN3IL3nbEOKQQSfF6SNpgbaPGhD9rUZM8LSduVfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106968;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=g2NLCWMzCBs5iISki7pmWBULLDwgxILgVxkU7maNnjk=;
	b=UXi4XVqS9ZDNiBdUDGDHaFufEfPTukDXpVlRV8VakSYJ1MhqswEty6KmVPaPHUY4VnW4
	 Jk+xdjUGCr5AqSPxjZIWWASYP6dZVx4VOccY+ueZXAyyuwBGJs0iAK0qPWOsRcScA/PIJ
	 gg3v8pOKcWB0Jid0chhUrlTUT4zBsvCo7yO/KC7sV40PzxN0Xa5G8RWeoVsqDa/047R0w
	 kvAwxZe0E1cL9yVyxNWek5PYkmHTvyOS+5xyr9O8aEKxCVonGimF+TcehwX3lBn9hbZHB
	 I2ajouoVUkS448lw5G7Xj1OqkUiQ4vHBzsXVKtacL2Tj0tOkWPoYZXzogNsbDCrvSZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BN+3RWfc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE19606A32F;
	Thu, 19 Nov 2026 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BN+3RWfc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E551F000C4;
	Thu, 19 Nov 2026 16:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795106968;
	bh=g2NLCWMzCBs5iISki7pmWBULLDwgxILgVxkU7maNnjk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BN+3RWfcKIFzUoeKmqEttwtFOgparQ1eTm7XKtYs9babzr++yx++Fr1ZrRXsyMU8N
	 w/jWMc1zmZ2nECqFd9bOGmta/8PKHTHx8j9WY8WFfq4UmZTxtDDNwE77ymvgQQUuz/
	 8/3e6YWD8QQrYDXEVUurh10ZYVSK4qK3TlfVZez8ppJSL+Tsi6zgFUZw4xjxjYfI9n
	 b0X5erlrq83HrCnEitf1nfP0DFb3XhypMIv6uUKXm0LByyyTAo8OwIPGROeP0HQK42
	 5vCYXSk+9q07ln4NcWBqGvsgqElmiLVNyUmnYVnTceWqrOTlZR3Z50nawAfzlBO+dB
	 rOJ4VQ/8z6pSA==
Message-ID: <98be89bc-1394-406b-8723-0032a7b57ad1@kernel.org>
Date: Thu, 19 Nov 2026 17:49:15 +0100
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
Subject: Re: [PATCH 1/4] mm: flush stale TLB entries before installing a
 CoW'ed folio
To: Zi Yan <ziy@nvidia.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 =?UTF-8?Q?Cenk_Y=C4=B1lmaz?= <cenk@deepfinresearch.com>,
 Zhang Peng <zippermonkey@icloud.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
 Youngjun Park <youngjun.park@lge.com>, Mel Gorman <mgorman@suse.de>,
 Sasha Levin <sasha.levin@oracle.com>, Rik van Riel <riel@redhat.com>,
 Ingo Molnar <mingo@kernel.org>, Peter Xu <peterx@redhat.com>,
 Hugh Dickins <hughd@google.com>, Axel Rasmussen <axelrasmussen@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261118-file_folio_flush-v1-0-e9e739ed14e0@kernel.org>
 <20261118-file_folio_flush-v1-1-e9e739ed14e0@kernel.org>
 <22DF2F1E-2692-48AC-AEE5-79B61947D86D@nvidia.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <22DF2F1E-2692-48AC-AEE5-79B61947D86D@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/19/26 17:47, Zi Yan wrote:
> On 18 Nov 2026, at 4:20, David Hildenbrand (Arm) wrote:
> 
>> Zapping PTEs in zap_pte_range() defers the TLB flush until after dropping
>> the PTL for clean page-cache folios.
>>
>> A concurrent write fault in a MAP_PRIVATE mapping can then CoW the
>> page-cache folio and install a new anon folio without a prior TLB
>> flush:
>>
>> 	CPU0				CPU1
>> 	LOAD(ADDR)
>> 	 -> #PF
>> 	    installs R/O PTE -> A
>> 					fuse_open()
>> 					 -> invalidate_inode_pages2()
>> 					    -> zap_pte_range()
>> 					       clears R/O PTE
>> 					       // delayed flush
>> 	// Other CPUs (incl CPU0) still cache ADDR -> A
>> 	STORE(ADDR)
>> 	 -> #PF
>> 	    do_cow_fault()
>> 	    copies A to B, installs R/W PTE -> B
>> 	    // no TLB flush: PTE was none
>>
>> CPUs with stale TLB entries will still read from the old folio while writes
>> go to the new folio, until the TLB is flushed.
>>
>> We really must process pending TLB flushes if we are not faulting the
>> same folio back in.
>>
>> Fix it by flushing the TLB before installing an anon (CoW'ed) folio in
>> set_pte_range() if a TLB flush is pending. Zapping itself stays as fast
>> as before.
>>
>> Other faults are not affected: unmap_mapping_*() users only remove
>> folios from the page-cache after their own TLB flush, so until then, a
>> refault maps the same folio again. The exception is a concurrent
>> invalidation that removes the already-unmapped folio from the
>> page-cache before the zapper flushed the TLB; that is an unlikely corner
>> case that we'll not handle for now.
>>
>> Note that we don't care about MADV_DONTNEED followed by a new read
>> fault, as MADV_DONTNEED only guarantees its semantics once the operation
>> completed. CoW faults will flush the TLB either way.
>>
>> For example, imagine that MADV_DONTNEED zaps a page-cache folio and
>> doesn't flush the TLB (but still holds a reference). If the page-cache
>> replaces the folio, a new read fault might map the new folio without
>> flushing the TLB. That's okay, as MADV_DONTNEED did not complete yet.
>> Same applies to MADV_DONTNEED of CoW'ed folios when re-faulting the
>> page-cache folio.
>>
>> Memory reclaim, which removes folios from the page-cache before performing
>> its own batched TLB flush, will be handled separately.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> This is really old.
> 
>> Reported-by: Cenk Yılmaz <cenk@deepfinresearch.com>
>> Debugged-by: Cenk Yılmaz <cenk@deepfinresearch.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  mm/memory.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index d2f48d78b0d7b..e1d9759e6fde1 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5888,6 +5888,12 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
>>  	/* copy-on-write page */
>>  	if (write && !(vma->vm_flags & VM_SHARED)) {
>>  		VM_BUG_ON_FOLIO(nr != 1, folio);
>> +		/*
>> +		 * Concurrent zapping might have dropped the PTL but not flushed
>> +		 * the TLB yet. Flush before installing a new folio.
>> +		 */
>> +		if (mm_tlb_flush_pending(vma->vm_mm))
>> +			flush_tlb_page(vma, addr);
> 
> This looks like an adhoc fix, but it is minimal for backport.
> Hopefully we can find a cleaner refactoring later.

I'm afraid if we don't want to throw away performance there is no way around it.

We have similar handling on the uffd-wp path ...

-- 
Cheers,

David
