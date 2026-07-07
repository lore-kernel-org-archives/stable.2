Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3D317144;
	Tue,  7 Jul 2026 01:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783389504; cv=none; b=afiUBrOPN6JYMBH77NmO3ts2ndsVtLgySSijzd7bcV+ZE6j1/b6hODfUYIbIFu07zPhdTVubtVtJFp6EHvEa5gsWHmJe0Sspm8pf0H3vt/qsS2saKIXr7oAQL8+HezoxlWWgfGLWF5MVY8WKY+UcLacJzID0K7uj6RmKOoxueng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783389504; c=relaxed/simple;
	bh=dQhOYoAS1TcvAHsBUpv2IF0x7YAujpgcs66iDr6gnnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4HJPxMatWPP9nzZdHuo/4TSvpCFyZgbGN6JTaUtZBl/piW+4c9u4j+Ny5G5zjNtFKSSCubx+AEGF8vmP376rfpunnj91mlvqNtLdyD0ivXR7uovVGMsSn3iJj7DxKZDV2nfZ17dBXFKS2EvsS83wRvdFoPRilnprdKmCO6g/+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ay0iOHbv; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ay0iOHbv"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783389494; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Hw5q4igm2fogQzAtaGDe/H5R57ywxMLb1WkudZyAasU=;
	b=ay0iOHbv1ftI3oqGpZWVoIxtCXC4m74x+K+zA7L3XCR5Z/x6zeMkepjt/Tdfm1D8Q9ClYO91vJ6SjTYMzSspTCr+6xwA4GkY5hXCAKo/mgiw9bx4R0EKWVG7oLyDiQqiYz2fWwHw5y32AJmCBKcCPdl6frWi8m0pktCdlUV+9Lk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X6atYrA_1783389174;
Received: from 30.246.177.139(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X6atYrA_1783389174 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 09:52:55 +0800
Message-ID: <d01bae40-f94d-4e8a-baac-ad6fffa18b64@linux.alibaba.com>
Date: Tue, 7 Jul 2026 09:52:54 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18.y] mm: shmem: fix potential livelock issue for shmem
 direct swapin
To: Barry Song <baohua@kernel.org>
Cc: Kairui Song <ryncsn@gmail.com>, akpm@linux-foundation.org,
 hughd@google.com, stable@vger.kernel.org, machao26@xiaomi.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <173f3fd983d735155d47e9e39d27f0c2d62a7c31.1783307463.git.baolin.wang@linux.alibaba.com>
 <CAMgjq7AQcyypJ-VhJ_CxY6fdEph64fxjOzzYU-=EkMrHemkpzA@mail.gmail.com>
 <8ef0b72e-a0e8-4913-8d30-519335305260@linux.alibaba.com>
 <CAGsJ_4z5N6FSfWt5WUZ5YmqhCzLcd3Cj1sc9B79WYX9ZbDH8Gw@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4z5N6FSfWt5WUZ5YmqhCzLcd3Cj1sc9B79WYX9ZbDH8Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/6/26 9:04 PM, Barry Song wrote:
> On Mon, Jul 6, 2026 at 8:08 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 7/6/26 1:59 PM, Kairui Song wrote:
>>> On Mon, Jul 6, 2026 at 11:25 AM Baolin Wang
>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>
>>>> When skipping swapcache for synchronous IO swap devices, swapcache_prepare()
>>>> is used to prevent parallel swapin from proceeding with the swap cache flag.
>>>> However, on PREEMPT kernels this can lead to a livelock, as reported by Chao[1]:
>>>>
>>>> Thread A starts direct swapin of a shmem folio and calls swapcache_prepare()
>>>> to set SWAP_HAS_CACHE. It may then be preempted inside workingset_refault().
>>>> Meanwhile, a higher priority thread B also attempts direct swapin of the same
>>>> shmem swap entry. Since swapcache_prepare() already marks the entry, thread B
>>>> repeatedly gets -EEXIST and busy-loops waiting for thread A to finish. But as
>>>> thread B runs at higher priority, thread A cannot preempt it, resulting in
>>>> starvation and a livelock.
>>>>
>>>> Fix it by yielding the CPU with schedule_timeout_uninterruptible(1) when
>>>> swapcache_prepare() fails, following the same approach used in commits
>>>> 029c4628b2eb ("mm: swap: get rid of livelock in swapin readahead") and
>>>> 13ddaf26be32 ("mm/swap: fix race when skipping swapcache").
>>>>
>>>> Note that mainline does not have this potential issue, which has already been
>>>> resolved by Kairui's swap refactoring work[2].
>>>>
>>>> [1] https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4@xiaomi.com/
>>>> [2] https://lore.kernel.org/all/20260517-swap-table-p4-v5-0-88ae43e064c7@tencent.com/
>>>> Fixes: 1dd44c0af4fa ("mm: shmem: skip swapcache for swapin of synchronous swap device")
>>>> Reported-by: Ma Chao <machao26@xiaomi.com>
>>>> Closes: https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4@xiaomi.com/
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>> Hi Chao, could you try this patch to check if it fixes your issue? Thanks.
>>>> ---
>>>>    mm/shmem.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>> index 94c5b0d78ac3..d4cb57b3b0ef 100644
>>>> --- a/mm/shmem.c
>>>> +++ b/mm/shmem.c
>>>> @@ -2066,6 +2066,8 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
>>>>           if (swapcache_prepare(entry, nr_pages)) {
>>>>                   folio_put(new);
>>>>                   new = ERR_PTR(-EEXIST);
>>>> +               /* Relax a bit to prevent rapid repeated page faults */
>>>> +               schedule_timeout_uninterruptible(1);
>>>>                   /* Try smaller folio to avoid cache conflict */
>>>>                   goto fallback;
>>>>           }
>>>> --
>>>> 2.47.3
>>>>
>>>
>>> Thanks! That's much more simpler than I expected. Do we need a wakeup
>>> queue like the one in commit 01626a1823024? Perhaps the reporter can
>>> help confirm and test? I personally prefer to keep it simple if shmem
>>> users aren't as sensitive as anon users.
>>
>> I agree. I'd like to keep the bugfix as simple as possible, if the
>> reporter's scenario isn't latency-sensitive.
> 
> On Android, we don't see much shmem; it's much less common
> than anon. So the chance of this concurrency happening should
> be lower than for anon. However, shmem can be shared by
> multiple processes, so could this still happen if process A is
> blocked by process B?

Could you be more specific about how that happens? I think we should fix 
this starvation/livelock issue if you think it could still happen.
