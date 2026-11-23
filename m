Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795418335;
	b=SyPwz7DeUYdDcsPG4f9QuEAc3U9Z7Q2TQS2ygI8+qyz4kucbL6Hv2DK9k3FkQ9IAVjmz
	 F1hwTHvrCTSizwDjpFXThwA9hCHNgcqHcmoX06y695s0W2XNvTUl3DO3Fa2iWKk6mdqSM
	 PhgTjoSxJJecdArTmPgYBs8ZrAzGQZhS1ESVxI2hEbKWNqQqXGTM4bp5J7PdqsdtJWF+S
	 AxVQ4TDrCmAXQzwTOkgNJ3cqhRZ6m6qTj3b7UbIESVkoeT9oIZNEL38w0DKJKru7QgJDD
	 6L9Y6UbZZoc9ewa7vw7rlvoY18jr+16FvGt/rq1r02OeNHEJaSBzHKxpcsm6eT8bcfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418335;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Q8GYORsnAO82wSpPrzmShMv7mBPXyM/CZgLgnjki5vY=;
	b=u1K4+4Fx4nNTIzD70N++t1iWek38ORCtKj93vexao5fQsEFwdT5dlnJUxQzCgJ592Qxh
	 jWbGu2fvTd/5ZU/qGd6sNNo05FV5LAwaI2MJwo4HlzCluMnrmprnrnMeMHk33LtNiY44S
	 7509jy2C7zZagxlKgmC5yJTz+R9xvnXKR0tOwco1tvd2wc6y8kpiammYfMzSbsqQE/0a3
	 kYMX1XNUTp64H79C2WjMOguBACrf5oRRkq4slQGUvHL0flDO0Z+a+zBn7/Oo7JytaUNAl
	 pRzjFi0pbXmAeHHdzFdGw8dSakq8hWTJF9QKW3nqcQx5Hfz7swekRU4t6idRY53lO2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CfSP0pgN;
	arc=none smtp.remote-ip=115.124.30.110
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8098606A31A;
	Mon, 23 Nov 2026 07:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8098606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CfSP0pgN
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795418330; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Q8GYORsnAO82wSpPrzmShMv7mBPXyM/CZgLgnjki5vY=;
	b=CfSP0pgNFJHmbvfQ6ctTaNSXuadCkkuitAA1+Ts93PuzWTButsQXSapnZw+raCF+9+4KGeSlNhcBRNn1YtfKWOJPI06ltrF+uGJKa/BfRLIvhJ8blQKeh3tVHKG74UYBtrsaEKiiOxmH4yeFipFQrwI8NSuSY/oeO1bySVxAOQ4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0XFE82IO_1795418327;
Received: from 30.74.144.153(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XFE82IO_1795418327 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Nov 2026 15:18:49 +0800
Message-ID: <4af8b7ef-8028-4b98-ad21-5620f8b92f42@linux.alibaba.com>
Date: Mon, 23 Nov 2026 15:18:46 +0800
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
To: "David Hildenbrand (Arm)" <david@kernel.org>, mt4022@columbia.edu,
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, tz2294@columbia.edu,
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
 Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
 stable@vger.kernel.org
References: <20261027-shmem-swapin-mismatch-v1-1-84e30aa3b9e5@columbia.edu>
 <3c61a49f-6a0d-49eb-8682-aece4e7e7226@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <3c61a49f-6a0d-49eb-8682-aece4e7e7226@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/19/26 7:06 AM, David Hildenbrand (Arm) wrote:
> On 10/27/26 21:33, Mani Tofigh via B4 Relay wrote:
>> From: Mani Tofigh <mt4022@columbia.edu>
>>
>> On a SWP_SYNCHRONOUS_IO swap device, a large shmem folio can be left in
>> the swap cache over swap slots that another file now uses.  Reading
>> that other file then loops forever in shmem_get_folio_gfp():
>> shmem_swapin_folio() finds the large folio, rounds the index and the
>> swap entry down to the folio's size, finds no matching entry in the
>> file and returns -EEXIST, and the retry finds the same folio again.
>> Since the task keeps the mapping locked, a munmap() of the same mapping
>> waits forever.
>>
>> The folio is left behind when the slots are freed and reused while the
>> swapin is still allocating it:
>>
>>    Task A (reads X)                      Task B
>>    ----------------                      ------
>>    shmem_swapin_folio()
>>      allocate a large folio
>>      for X's slots
>>                                          punch a hole in X
>>                                          /* X's slots freed */
>>                                          swap out file Y
>>                                          /* Y reuses those slots */
>>      add the folio to the swap
>>      cache over those slots
>>      shmem_confirm_swap() fails
>>      /* -EEXIST, the folio stays
>>         in the swap cache */
>>
>>    Task C (reads Y)
>>    ----------------
>>    shmem_swapin_folio()
>>      finds the large folio
>>      rounds down to its start,
>>      where Y has no entry
>>      /* -EEXIST, retried forever */
>>
>> Before commit c246d236b18b ("mm/shmem: never bypass the swap cache for
>> SWP_SYNCHRONOUS_IO"), a direct swapin that failed this way freed its
>> folio instead of leaving it in the swap cache.
>>
>> do_swap_page() already drops a large swap cache folio that does not
>> fit for anonymous memory.  Do the same in shmem_swapin_folio() and on
>> a -EEXIST, remove a large folio that is not
>> anonymous/dirty/under-writeback from the swap cache so that the retry
>> swaps in a folio that fits.
>>
>> The reproducer below fills a small brd swap device so that a 64K shmem
>> folio and the 4K pages of another file land in the same slots, and races
>> a read of the first file with a hole punch and a swapout of the second.
>> This bug was identified and confirmed with the help of a deterministic
>> hypervisor currently under development, but the non-deterministic C
>> reproducer can typically trigger it in the 2-4s time range.  With the
>> fix, nothing is triggered after 600 seconds.
>>
>> Fixes: c246d236b18b ("mm/shmem: never bypass the swap cache for SWP_SYNCHRONOUS_IO")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
>> ---
>> Two patches in David Hildenbrand's v2 shmem fixes series are related
>> to this one.  "mm/shmem: fix truncate hang in large swap entry" [1]
>> makes truncation retry -EEXIST directly, so it can also loop on such a
>> folio.  "mm/shmem: preserve allocation errors when swapping in large
>> entries" [2] fixes a different -EEXIST loop, where a failed allocation
>> is reported as -EEXIST.
>>
>> [1] https://lore.kernel.org/all/20261027-fixes_shmem-v2-10-86a00952acb9@kernel.org/
>> [2] https://lore.kernel.org/all/20261027-fixes_shmem-v2-11-86a00952acb9@kernel.org/
>>
>> Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/shmemloop.c
>> ---
>>   mm/shmem.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 13e0786436cd..f1da8432d55c 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2568,11 +2568,14 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>   	 * and swap cache folios are never partially freed.
>>   	 */
>>   	folio_lock(folio);
>> -	if (!folio_matches_swap_entry(folio, swap) ||
>> -	    shmem_confirm_swap(mapping, index, swap) < 0) {
>> +	if (!folio_matches_swap_entry(folio, swap)) {
>>   		error = -EEXIST;
>>   		goto unlock;
>>   	}
>> +	if (shmem_confirm_swap(mapping, index, swap) < 0) {
>> +		error = -EEXIST;
>> +		goto failed;
>> +	}
>>   	if (!folio_test_uptodate(folio)) {
>>   		error = -EIO;
>>   		goto failed;
>> @@ -2613,6 +2616,15 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>   		error = -EEXIST;
>>   	if (error == -EIO)
>>   		shmem_set_folio_swapin_error(inode, index, folio, swap);
>> +	/*
>> +	 * A large folio that does not fit the mapping, e.g. because its swap
>> +	 * entries were freed and reused, would be found again on every retry.
>> +	 * Drop it from the swap cache so the retry can swap in a fitting one.
>> +	 */
>> +	if (error == -EEXIST && folio && folio_test_large(folio) &&
>> +	    !folio_test_anon(folio) && !folio_test_dirty(folio) &&
>> +	    !folio_test_writeback(folio))
>> +		swap_cache_del_folio(folio);
>>   unlock:
>>   	if (folio)
>>   		folio_unlock(folio);
>>
>> ---
> 
> I have an AI fix here:
> 
> Author: Chris Mason <mason@kernel.org>
> Date:   Wed Nov 11 18:44:55 2026 +0000
> 
>      mm/shmem: don't drop a folio whose swap write failed
> 
>      If the swap write of a large shmem folio fails while a swap-in of
>      another file finds that folio in the swap cache, its data can be
>      silently lost. A read of the file then returns whatever the swap device
>      holds.
> 
>      "mm/shmem: fix swapin livelock on a mismatched large swap cache folio",
>      earlier in this series, lets shmem_swapin_folio() drop a large folio
>      from the swap cache, if the folio does not fit the file that is swapped
>      in and is neither dirty nor under writeback. A folio that does not fit
>      can belong to another file, with its swap write still in flight.
> 
>      shmem_swapin_folio() holds the folio lock, but the code that completes a
>      write does not take that lock. And a failed write sets dirty before it
>      ends writeback. So the folio can look clean and written, although its
>      write has failed:
> 
>          shmem_swapin_folio()              swap_write_end(), failed write
>          ====================              ==============================
>          folio_test_dirty() == false
>                                            folio_mark_dirty()
>                                            folio_end_writeback()
>          folio_test_writeback() == false
>          swap_cache_del_folio()
>            /* the only copy of the data */
> 
>      The fix used here is to test writeback first, and dirty second.
> 
>      Signed-off-by: Chris Mason <mason@kernel.org>
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 915b312e14175..457a502353a9a 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2809,10 +2809,13 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>           * A large folio that does not fit the mapping, e.g. because its swap
>           * entries were freed and reused, would be found again on every retry.
>           * Drop it from the swap cache so the retry can swap in a fitting one.
> +        * A failed write sets dirty and then ends writeback, with no folio
> +        * lock, so test writeback first. Both flags share folio->flags, so the
> +        * order of the two loads holds.
>           */
>          if (error == -EEXIST && folio && folio_test_large(folio) &&
> -           !folio_test_anon(folio) && !folio_test_dirty(folio) &&
> -           !folio_test_writeback(folio))
> +           !folio_test_anon(folio) && !folio_test_writeback(folio) &&
> +           !folio_test_dirty(folio))
>                  swap_cache_del_folio(folio);
>   unlock:
>          if (folio)
> 
> 
> @Mani, can you double check if that makes sense (can we actually trigger that), and
> if so, send it out officially, with Fixes tag ?
> 
> Feel free to rework the patch as you please.

That makes sense to me. If Mani has no time, I'll take care of this fix.
