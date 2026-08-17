Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC34252D9;
	Mon, 17 Aug 2026 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983610; cv=none; b=WtAxcCoR8B88DNLL2ihDnBtmwMkLbB+ZR/Iw3CdVgNaHS86YmZOOahG462/Z72Cey2+vBWePRiSGPjRXbg4/QdXwego95DyWlBuaeldQpHxCoPEzDJvkfDSJ7Z+z5tOkh6WQZxQCJjidxIN3ROWm5pOhN/BCQFPct8z3JoWjcrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983610; c=relaxed/simple;
	bh=Tc6EKhKZEpOzx7zPHtS1ACk9Y+HJmXHvolXhoFltBGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgyhfHIbTodHKo3CXrajp2FFotH2mvFL+dxtt7NKGxmxwNR+3zzJ5+0CllgbLItPpxXn17FHfQg/AlfpIJg97kAUHfq6Sk6oj0cGsplwxy+yVArSlEgiDFoHLazBrCAjANk+EEcDzhfPAIcqKBbOjaxKKBBRs/M7gvjGrb/WqbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/lE1v/e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/lE1v/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D570F1F000E9;
	Mon, 17 Aug 2026 16:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786983608;
	bh=BwmBPA0cmpr0pww4s+vEVGEC63NoNEq70yV7x2DU3f0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K/lE1v/eySVjx+rC2sXxm6SLXW94ZMm218ziXfKDfGjLCAEm76QEtrWEkhZTX8+PM
	 epjC6DfaGpME43QZEc0wfNXeeBFCGAmKrxb4QOKgvqrPp/cEop7Y2lEVtroYPtZ6V6
	 IXK+WdZfYjHU48VoRpNdWw0NO4hKb/HTqeZmgosVts6DGxRewARn//GH4xn20ZJHjg
	 VOEUZxK56MCqVCsxhH6bugj1fzpTy5FOc66qhDw3Z2DE1hMECWnpySOH+Dd5ldoA67
	 wtLTOm2spBn4HB0owjypAfnC7cbNnU5uXLpgMVgveNjHt5DtEgwTIZN+meI6CkluH6
	 hxdl+R+Gem8CA==
Message-ID: <cd555188-2b51-4559-a315-0e8af6b2572a@kernel.org>
Date: Mon, 17 Aug 2026 18:20:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mm: khugepaged: fix folio is used after
 pte_unmap_unlock()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Vernon Yang <vernon2gm@gmail.com>
Cc: akpm@linux-foundation.org, nico.pache@linux.dev, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 usama.arif@linux.dev, zokeefe@google.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Vernon Yang <yanglincheng@kylinos.cn>,
 stable@vger.kernel.org
References: <20260815051924.194810-1-vernon2gm@gmail.com>
 <20260815051924.194810-3-vernon2gm@gmail.com> <aoMynfFI2XK2UXXN@lucifer>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <aoMynfFI2XK2UXXN@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/26 18:11, Lorenzo Stoakes (ARM) wrote:
> On Sat, Aug 15, 2026 at 01:19:23PM +0800, Vernon Yang wrote:
>> From: Vernon Yang <yanglincheng@kylinos.cn>
>>
>> After the page table lock has dropped, the folio can be freed
>> concurrently. The trace_mm_khugepaged_scan_pmd() is left with
>> a dangling folio pointer.
>>
>> So using the folio_pfn() before dropping the page table lock,
>> closing use-after-free window.
>>
>> Fixes: 7d2eba0557c1 ("mm: add tracepoint for scanning pages")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
>> ---
>>  include/trace/events/huge_memory.h | 6 +++---
>>  mm/khugepaged.c                    | 4 +++-
>>  2 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
>> index d3572d4ef453..5dc71d292f47 100644
>> --- a/include/trace/events/huge_memory.h
>> +++ b/include/trace/events/huge_memory.h
>> @@ -55,10 +55,10 @@ SCAN_STATUS
>>
>>  TRACE_EVENT(mm_khugepaged_scan_pmd,
>>
>> -	TP_PROTO(struct mm_struct *mm, struct folio *folio,
>> +	TP_PROTO(struct mm_struct *mm, unsigned long pfn,
>>  		 int referenced, int none_or_zero, int status, int unmapped),
>>
>> -	TP_ARGS(mm, folio, referenced, none_or_zero, status, unmapped),
>> +	TP_ARGS(mm, pfn, referenced, none_or_zero, status, unmapped),
>>
>>  	TP_STRUCT__entry(
>>  		__field(struct mm_struct *, mm)
>> @@ -71,7 +71,7 @@ TRACE_EVENT(mm_khugepaged_scan_pmd,
>>
>>  	TP_fast_assign(
>>  		__entry->mm = mm;
>> -		__entry->pfn = folio ? folio_pfn(folio) : -1;
>> +		__entry->pfn = pfn;
>>  		__entry->referenced = referenced;
>>  		__entry->none_or_zero = none_or_zero;
>>  		__entry->status = status;
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index e7830761d3a2..7c8c48577408 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1603,6 +1603,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>>  	enum scan_result result = SCAN_FAIL;
>>  	struct page *page = NULL;
>>  	struct folio *folio = NULL;
>> +	unsigned long pfn = -1;
>>  	unsigned long addr;
>>  	unsigned long enabled_orders;
>>  	spinlock_t *ptl;
>> @@ -1778,6 +1779,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>>  		result = SCAN_SUCCEED;
>>  	}
>>  out_unmap:
>> +	pfn = folio ? folio_pfn(folio) : -1;
>>  	pte_unmap_unlock(pte, ptl);
>>  	if (result == SCAN_SUCCEED) {
>>  		/* collapse_huge_page expects the lock to be dropped before calling */
>> @@ -1788,7 +1790,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>>  		*lock_dropped = true;
>>  	}
>>  out:
>> -	trace_mm_khugepaged_scan_pmd(mm, folio, referenced,
>> +	trace_mm_khugepaged_scan_pmd(mm, pfn, referenced,
> 
> Same comment as 1/3 I don't see why we should be storing a pfn value used
> nowhere else just for tracing.

I prefer it that way. Even if just for tracing. :)

-- 
Cheers,

David
