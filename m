Received: from mta0.migadu.com (out-241.mta0.migadu.com [91.218.175.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0836197C
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789316237; cv=none; b=Haka9hS22RTqy7j1+WntJG6hAuN8Y0gKG09lR6DEP6koBK8VqJvDVV29ILZXiBv0GKqvx6CGYGCkL0fOvuuL3R2aLERg3qeKHdV0jtLnf6DjtgPcJjmOcvpixnaDLFanSQBh+qSoHM4KGz6ol8ycPCijqUD12p3QDh3a1XrZV2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789316237; c=relaxed/simple;
	bh=svZCpv21FthwypPz3c8MpF7aUfNyE0+BDGgA1bEnvbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPEsqAElDpXZAYVVWrRmOekKfnC/rrVexheQc3rYbzTDQnwaCgkw1CB/p6TRZEV7XLu7+qMYVQoyAwDkgUCUrPohYs4O3duiYhcLFS/TJRN+PpSIGIQDkLW+tPtEgmTL/988DY5mT1pxMEqYXvbsCzqyZ6lF9IjBYQZaB9M6/gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VZXQLr/h; arc=none smtp.client-ip=91.218.175.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VZXQLr/h"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=svZCpv21FthwypPz3c8MpF7aUfNyE0+BDGgA1bEnvbg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789316231; v=1; x=1789921031;
 b=VZXQLr/hmgNgOJwye9d2L+gV/euc+YUVN1o+oyvNDQW/WqP2Dg0N/iy/YDC1wM2wYkiKUpm6
 3Jo6E0Uut3QwEwxOEbYcJrf5tL7DDnUtdohLUNvTaY3lTLeV9KQfAVFyk4MGa0sbJk7y8uZZM0J
 vWYmrJJ3lP0gGqGFdJLZEX7s=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id caa88b22c15f5b16;
	Sun, 13 Sep 2026 16:17:10 +0000
X-Mizu-Trace-ID: caa88b22c15f5b16
X-Migadu-Flow: FLOW_OUT
Message-ID: <dc6f3b89-58cf-48c6-bb4f-9fe605c92028@linux.dev>
Date: Mon, 14 Sep 2026 00:16:58 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] khugepaged: hold invalidate_lock across collapse_file()
 readahead
To: ngocthang2710.1999@gmail.com
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, liam@infradead.org,
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260913101142.28802-1-ngocthang2710.1999@gmail.com>
 <20260913161245.11120-1-lance.yang@linux.dev>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260913161245.11120-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/9/14 00:12, Lance Yang wrote:
> Hi Nguyen,
> 
> Good catch, thanks!
> 
> On Sun, Sep 13, 2026 at 05:11:42PM +0700, Nguyen Ngoc Thang wrote:
>> collapse_file() calls page_cache_sync_readahead() to fault in missing
>> pages before collapsing them into a THP. That helper takes
>> mapping->invalidate_lock itself for the duration of the call, then
>> drops it -- but truncate (e.g. ext4_setattr() -> truncate_pagecache())
>> takes invalidate_lock and then waits on each page's folio lock while
>> holding it. If collapse_file() has already locked one of those folios
>> by the time truncate reaches it, and then tries to acquire
>> invalidate_lock again (e.g. on the next iteration, or via a nested
>> readahead call), the two paths can deadlock/hang on each other's lock:
>> truncate blocked on the folio lock collapse holds, and collapse
>> blocked waiting for invalidate_lock that truncate holds.
> 
> That can happen on the first readahead call.
> 
>>
>> Reproducing this over ~150,000 collapse iterations with truncate
>> racing concurrently reliably hits hung_task: blocked tasks within
>> about 20 seconds on an unpatched kernel.
>>
>> Fix it by taking invalidate_lock_shared once for the whole scan, before
>> locking any folio, and using page_cache_ra_unbounded() directly in the
>> readahead call site instead of page_cache_sync_readahead(), since the
>> latter would try to retake the lock we already hold.
>> page_cache_ra_unbounded() does not clamp to EOF like the helper it
>> replaces, so clamp the requested range explicitly.
>>
>> Reported-by: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=16bf7cd0ebeb1de93aa5
> 
> Ouch, we should add a Fixes tag and Cc stable:
> 
> Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
> Cc: stable@vger.kernel.org
> 
> 730633f0b7f9 added invalidate_lock acquisition to readahead but missed
> collapse_file(), which already called it with page locks held. The
> subsequent filesystem conversions made the deadlock possible by taking
> invalidate_lock before locking pages :( right?
> 
>> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
>> ---

Forgot to mention:

I reproduced the hang too, and it goes away with this patch applied :)

Tested-by: Lance Yang <lance.yang@linux.dev>

>> mm/khugepaged.c | 25 ++++++++++++++++++++++---
>> 1 file changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 11ff98d55c76..690ccbcdf593 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -2267,6 +2267,13 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>> 	VM_WARN_ON_ONCE(!is_shmem && !mapping_pmd_folio_support(mapping));
>> 	VM_WARN_ON_ONCE(start & (HPAGE_PMD_NR - 1));
>>
>> +	/*
>> +	 * Take invalidate_lock before any folio lock: the readahead below
>> +	 * needs it, and truncate holds it while waiting on folio locks.
>> +	 */
>> +	if (!is_shmem)
>> +		filemap_invalidate_lock_shared(mapping);
> 
> Could we take the lock after alloc_charge_folio() succeeds, before
> locking any folio? That would keep allocation and charging outside the
> critical section. And if allocation fails, we should skip the unlock :)
> 
> Cheers, Lance
> 
>> +
>> 	result = alloc_charge_folio(&new_folio, mm, cc, HPAGE_PMD_ORDER);
>> 	if (result != SCAN_SUCCEED)
>> 		goto out;
>> @@ -2337,10 +2344,20 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>> 			}
>> 		} else {	/* !is_shmem */
>> 			if (!folio || xa_is_value(folio)) {
>> +				DEFINE_READAHEAD(ractl, file, &file->f_ra,
>> +						  mapping, index);
>> +				pgoff_t eof = DIV_ROUND_UP(i_size_read(mapping->host),
>> +							    PAGE_SIZE);
>> +
>> 				xas_unlock_irq(&xas);
>> -				page_cache_sync_readahead(mapping, &file->f_ra,
>> -							  file, index,
>> -							  end - index);
>> +				/*
>> +				 * invalidate_lock held above; don't retake it.
>> +				 * page_cache_ra_unbounded(), unlike the readahead
>> +				 * helper this replaces, does not clamp to EOF.
>> +				 */
>> +				if (index < eof)
>> +					page_cache_ra_unbounded(&ractl,
>> +						min(end, eof) - index, 0);
>> 				/* drain lru cache to help folio_isolate_lru() */
>> 				lru_add_drain();
>> 				folio = filemap_lock_folio(mapping, index);
>> @@ -2672,6 +2689,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>> 	folio_unlock(new_folio);
>> 	folio_put(new_folio);
>> out:
>> +	if (!is_shmem)
>> +		filemap_invalidate_unlock_shared(mapping);
>> 	VM_BUG_ON(!list_empty(&pagelist));
>> 	trace_mm_khugepaged_collapse_file(mm, new_folio, index, addr, is_shmem, file, HPAGE_PMD_NR, result);
>> 	return result;
>> -- 
>> 2.43.0
>>
>>

