Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451434;
	b=RFuYtb45/6au0pA6bB0qVdQj7sVhBYxkiv9e+cHpezPyMICofQ/B0GCmjqt8gW8+FbDD
	 qyGYPP8jPJU5rRGNYpWHV6lWq4uoeyJL7wlm+U2UrAtHCktG2mSES7o3NTG5m05GWcEfc
	 uM9AP8nGSA44YK2DVWGD17tIdc6DrblTosG+WE7d7dJaRzqt6My/9nFhAZuacGfdhOPXS
	 ZChBJR1Ia2SkdtUTPsoK5pHXHCb8xeRnRRWd4PdtpJCfBtnLvBAgrHQZocLobyCwX5b4p
	 4PBGtl7i+Kv7StBMrp8ixemAr4yZ8XkMP3TL3cU8uJGudjLDs52xPl0nDZEmb9uhfhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451434;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=3Id7WGSAHR3shCUUyvffsnWFyWGcWhkwKAm9+/q7F4Y=;
	b=h3fgosFOfic8NCls8XtgRR6VhNx3Fn2IIRj9B82YShmKUBefDs8Z4FKGEf28v4GJipQ3
	 +VPzrJnrNNMOcdgv3n8KwUqm/U+a/Qvx8Hjusss9rA+u6tvNtqb+jFuL/TnMkhIglhpQ7
	 /3LxJ2HJtDABl5rtugq8X6nKspOVZjjgqf/iZ0TDymmQvbB2rUyg76g+PoqGzPQuS4jsv
	 DvkkVO7Lt+G6WUO2dPIDwmQJYbJS7xk48I0ut3gY9ZtkFCwfyBkWb8Ax9Noaq+HPbjAYh
	 ztxHZi5Dbu5b3oesuHiyqmR3/8ktqs6tf/X0HsNfwV5rXS06pQPt9z90TYLLszrsDMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0+Q72hR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189C3606A33B;
	Mon, 23 Nov 2026 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0+Q72hR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D811F000C0;
	Mon, 23 Nov 2026 16:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795451433;
	bh=3Id7WGSAHR3shCUUyvffsnWFyWGcWhkwKAm9+/q7F4Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=E0+Q72hRW1vFotqa29WdwYokAX1DIUx5cQ2UT7hGDB5TaUbiSDhiuBmJxGTTg0eXz
	 K4wLkEyrVQy/UE1XtVx3D0jddWDAHoe8BjSleaxedxdNtC8G1UkQMznhkiAGX0Lc2z
	 wNluFPTHh0vx3+bfKbfVkr7K1wFCChtWWqKu60c1/9L9mfFWdOzBhHwzWZVKgUHGaV
	 J62ArEyK1ibIr0QVgrFANexEiHwac9nZXE+LdUw4KXZngZLNYtUu97sTCNuVmxrKMR
	 dRejsRcsTaFCZ31oA57K5nxtOagmRI726Cm2F0chUPkw09ZCpXeMZVO7xBeZEbPDYb
	 SYbV0BbmiHeQA==
Message-ID: <787a9e9e-407d-42ee-ac27-fb402323083b@kernel.org>
Date: Mon, 23 Nov 2026 17:30:26 +0100
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
Subject: Re: [PATCH] mm/shmem: fix swapin livelock on a mismatched large swap
 cache folio
To: Baolin Wang <baolin.wang@linux.alibaba.com>, mt4022@columbia.edu,
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, tz2294@columbia.edu,
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
 Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
 stable@vger.kernel.org
References: <20261027-shmem-swapin-mismatch-v1-1-84e30aa3b9e5@columbia.edu>
 <3c61a49f-6a0d-49eb-8682-aece4e7e7226@kernel.org>
 <4af8b7ef-8028-4b98-ad21-5620f8b92f42@linux.alibaba.com>
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
In-Reply-To: <4af8b7ef-8028-4b98-ad21-5620f8b92f42@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/26 08:18, Baolin Wang wrote:
> 
> 
> On 11/19/26 7:06 AM, David Hildenbrand (Arm) wrote:
>> On 10/27/26 21:33, Mani Tofigh via B4 Relay wrote:
>>> From: Mani Tofigh <mt4022@columbia.edu>
>>>
>>> On a SWP_SYNCHRONOUS_IO swap device, a large shmem folio can be left in
>>> the swap cache over swap slots that another file now uses.  Reading
>>> that other file then loops forever in shmem_get_folio_gfp():
>>> shmem_swapin_folio() finds the large folio, rounds the index and the
>>> swap entry down to the folio's size, finds no matching entry in the
>>> file and returns -EEXIST, and the retry finds the same folio again.
>>> Since the task keeps the mapping locked, a munmap() of the same mapping
>>> waits forever.
>>>
>>> The folio is left behind when the slots are freed and reused while the
>>> swapin is still allocating it:
>>>
>>>    Task A (reads X)                      Task B
>>>    ----------------                      ------
>>>    shmem_swapin_folio()
>>>      allocate a large folio
>>>      for X's slots
>>>                                          punch a hole in X
>>>                                          /* X's slots freed */
>>>                                          swap out file Y
>>>                                          /* Y reuses those slots */
>>>      add the folio to the swap
>>>      cache over those slots
>>>      shmem_confirm_swap() fails
>>>      /* -EEXIST, the folio stays
>>>         in the swap cache */
>>>
>>>    Task C (reads Y)
>>>    ----------------
>>>    shmem_swapin_folio()
>>>      finds the large folio
>>>      rounds down to its start,
>>>      where Y has no entry
>>>      /* -EEXIST, retried forever */
>>>
>>> Before commit c246d236b18b ("mm/shmem: never bypass the swap cache for
>>> SWP_SYNCHRONOUS_IO"), a direct swapin that failed this way freed its
>>> folio instead of leaving it in the swap cache.
>>>
>>> do_swap_page() already drops a large swap cache folio that does not
>>> fit for anonymous memory.  Do the same in shmem_swapin_folio() and on
>>> a -EEXIST, remove a large folio that is not
>>> anonymous/dirty/under-writeback from the swap cache so that the retry
>>> swaps in a folio that fits.
>>>
>>> The reproducer below fills a small brd swap device so that a 64K shmem
>>> folio and the 4K pages of another file land in the same slots, and races
>>> a read of the first file with a hole punch and a swapout of the second.
>>> This bug was identified and confirmed with the help of a deterministic
>>> hypervisor currently under development, but the non-deterministic C
>>> reproducer can typically trigger it in the 2-4s time range.  With the
>>> fix, nothing is triggered after 600 seconds.
>>>
>>> Fixes: c246d236b18b ("mm/shmem: never bypass the swap cache for SWP_SYNCHRONOUS_IO")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
>>> ---
>>> Two patches in David Hildenbrand's v2 shmem fixes series are related
>>> to this one.  "mm/shmem: fix truncate hang in large swap entry" [1]
>>> makes truncation retry -EEXIST directly, so it can also loop on such a
>>> folio.  "mm/shmem: preserve allocation errors when swapping in large
>>> entries" [2] fixes a different -EEXIST loop, where a failed allocation
>>> is reported as -EEXIST.
>>>
>>> [1] https://lore.kernel.org/all/20261027-fixes_shmem-v2-10-86a00952acb9@kernel.org/
>>> [2] https://lore.kernel.org/all/20261027-fixes_shmem-v2-11-86a00952acb9@kernel.org/
>>>
>>> Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/shmemloop.c
>>> ---
>>>   mm/shmem.c | 16 ++++++++++++++--
>>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index 13e0786436cd..f1da8432d55c 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -2568,11 +2568,14 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>>   	 * and swap cache folios are never partially freed.
>>>   	 */
>>>   	folio_lock(folio);
>>> -	if (!folio_matches_swap_entry(folio, swap) ||
>>> -	    shmem_confirm_swap(mapping, index, swap) < 0) {
>>> +	if (!folio_matches_swap_entry(folio, swap)) {
>>>   		error = -EEXIST;
>>>   		goto unlock;
>>>   	}
>>> +	if (shmem_confirm_swap(mapping, index, swap) < 0) {
>>> +		error = -EEXIST;
>>> +		goto failed;
>>> +	}
>>>   	if (!folio_test_uptodate(folio)) {
>>>   		error = -EIO;
>>>   		goto failed;
>>> @@ -2613,6 +2616,15 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>>   		error = -EEXIST;
>>>   	if (error == -EIO)
>>>   		shmem_set_folio_swapin_error(inode, index, folio, swap);
>>> +	/*
>>> +	 * A large folio that does not fit the mapping, e.g. because its swap
>>> +	 * entries were freed and reused, would be found again on every retry.
>>> +	 * Drop it from the swap cache so the retry can swap in a fitting one.
>>> +	 */
>>> +	if (error == -EEXIST && folio && folio_test_large(folio) &&
>>> +	    !folio_test_anon(folio) && !folio_test_dirty(folio) &&
>>> +	    !folio_test_writeback(folio))
>>> +		swap_cache_del_folio(folio);
>>>   unlock:
>>>   	if (folio)
>>>   		folio_unlock(folio);
>>>
>>> ---
>>
>> I have an AI fix here:
>>
>> Author: Chris Mason <mason@kernel.org>
>> Date:   Wed Nov 11 18:44:55 2026 +0000
>>
>>      mm/shmem: don't drop a folio whose swap write failed
>>
>>      If the swap write of a large shmem folio fails while a swap-in of
>>      another file finds that folio in the swap cache, its data can be
>>      silently lost. A read of the file then returns whatever the swap device
>>      holds.
>>
>>      "mm/shmem: fix swapin livelock on a mismatched large swap cache folio",
>>      earlier in this series, lets shmem_swapin_folio() drop a large folio
>>      from the swap cache, if the folio does not fit the file that is swapped
>>      in and is neither dirty nor under writeback. A folio that does not fit
>>      can belong to another file, with its swap write still in flight.
>>
>>      shmem_swapin_folio() holds the folio lock, but the code that completes a
>>      write does not take that lock. And a failed write sets dirty before it
>>      ends writeback. So the folio can look clean and written, although its
>>      write has failed:
>>
>>          shmem_swapin_folio()              swap_write_end(), failed write
>>          ====================              ==============================
>>          folio_test_dirty() == false
>>                                            folio_mark_dirty()
>>                                            folio_end_writeback()
>>          folio_test_writeback() == false
>>          swap_cache_del_folio()
>>            /* the only copy of the data */
>>
>>      The fix used here is to test writeback first, and dirty second.
>>
>>      Signed-off-by: Chris Mason <mason@kernel.org>
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 915b312e14175..457a502353a9a 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2809,10 +2809,13 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>           * A large folio that does not fit the mapping, e.g. because its swap
>>           * entries were freed and reused, would be found again on every retry.
>>           * Drop it from the swap cache so the retry can swap in a fitting one.
>> +        * A failed write sets dirty and then ends writeback, with no folio
>> +        * lock, so test writeback first. Both flags share folio->flags, so the
>> +        * order of the two loads holds.
>>           */
>>          if (error == -EEXIST && folio && folio_test_large(folio) &&
>> -           !folio_test_anon(folio) && !folio_test_dirty(folio) &&
>> -           !folio_test_writeback(folio))
>> +           !folio_test_anon(folio) && !folio_test_writeback(folio) &&
>> +           !folio_test_dirty(folio))
>>                  swap_cache_del_folio(folio);
>>   unlock:
>>          if (folio)
>>
>>
>> @Mani, can you double check if that makes sense (can we actually trigger that), and
>> if so, send it out officially, with Fixes tag ?
>>
>> Feel free to rework the patch as you please.
> 
> That makes sense to me. If Mani has no time, I'll take care of this fix.

Yes, please!

-- 
Cheers,

David
