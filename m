Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A50D4369A;
	Fri, 10 Jul 2026 02:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783649233; cv=none; b=p1oNIe/HTJz8+qmhuNnCr8sJkFN8CIkiUTzN4Nt0JExQnVpp15y5d4ZOrQgvBDU3aaPCX5IHin4ukuBLRr+WcgS+yO54wnfXUY9iPwjNSdYm4733hoh6iOpZRXy3jvaCgUL6wwQD2qT5E6XuAuFcwHGBLQ7h66nVOsldCdOw1ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783649233; c=relaxed/simple;
	bh=taNYhcb1tPQszdUM7QfEM04UZ/RTACmRqQQ4HK+2tjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovw2jJed1pfk4jQ46GximwBniQT40RzVUsR9EtluH8Mw4NcfHxKU7uQ4FfJjSgAsNT+UTOSvdWujM3A/HWo8nvEx1OXXTfkfwaOQzBQ74wYqI2U7kPoX/JTYBurg+t+TUrk06KDJX3GlwR8CncXNwsTMJ4NLHlemMxOXe4tdgmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Kg1zphAV; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Kg1zphAV"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783649228; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2qWvmYTTV9g/8HbuZVFImT8qht0TwN0Nod2rNmixTuY=;
	b=Kg1zphAVco/uSum4F3C4iyAYYHkaU1qFA2N+ZMpxrezoa3El4HzQOm87DQPRbjnmrkNBld6OvV5hsJG84vsd20Safp454XYsQwMcDFsy2jt3QprqnIgJOxee3GYpygs2lC7qGVMdNscwp5CgwZ9qvwqzRUyRHzuHmJdODtV93s4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X6m29De_1783649226;
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X6m29De_1783649226 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Jul 2026 10:07:07 +0800
Message-ID: <d2854680-daf7-4f38-97c4-4de3423e3d49@linux.alibaba.com>
Date: Fri, 10 Jul 2026 10:07:06 +0800
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
 <d01bae40-f94d-4e8a-baac-ad6fffa18b64@linux.alibaba.com>
 <CAGsJ_4zbBRe383GQLGuPivUXXnjhs2L9xFyandXkCOUotcb7Vg@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4zbBRe383GQLGuPivUXXnjhs2L9xFyandXkCOUotcb7Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/7/26 10:34 PM, Barry Song wrote:
> On Tue, Jul 7, 2026 at 9:53 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 7/6/26 9:04 PM, Barry Song wrote:
>>> On Mon, Jul 6, 2026 at 8:08 PM Baolin Wang
>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>
>>>>
>>>>
>>>> On 7/6/26 1:59 PM, Kairui Song wrote:
>>>>> On Mon, Jul 6, 2026 at 11:25 AM Baolin Wang
>>>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>>>
>>>>>> When skipping swapcache for synchronous IO swap devices, swapcache_prepare()
>>>>>> is used to prevent parallel swapin from proceeding with the swap cache flag.
>>>>>> However, on PREEMPT kernels this can lead to a livelock, as reported by Chao[1]:
>>>>>>
>>>>>> Thread A starts direct swapin of a shmem folio and calls swapcache_prepare()
>>>>>> to set SWAP_HAS_CACHE. It may then be preempted inside workingset_refault().
>>>>>> Meanwhile, a higher priority thread B also attempts direct swapin of the same
>>>>>> shmem swap entry. Since swapcache_prepare() already marks the entry, thread B
>>>>>> repeatedly gets -EEXIST and busy-loops waiting for thread A to finish. But as
>>>>>> thread B runs at higher priority, thread A cannot preempt it, resulting in
>>>>>> starvation and a livelock.
>>>>>>
>>>>>> Fix it by yielding the CPU with schedule_timeout_uninterruptible(1) when
>>>>>> swapcache_prepare() fails, following the same approach used in commits
>>>>>> 029c4628b2eb ("mm: swap: get rid of livelock in swapin readahead") and
>>>>>> 13ddaf26be32 ("mm/swap: fix race when skipping swapcache").
>>>>>>
>>>>>> Note that mainline does not have this potential issue, which has already been
>>>>>> resolved by Kairui's swap refactoring work[2].
>>>>>>
>>>>>> [1] https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4@xiaomi.com/
>>>>>> [2] https://lore.kernel.org/all/20260517-swap-table-p4-v5-0-88ae43e064c7@tencent.com/
>>>>>> Fixes: 1dd44c0af4fa ("mm: shmem: skip swapcache for swapin of synchronous swap device")
>>>>>> Reported-by: Ma Chao <machao26@xiaomi.com>
>>>>>> Closes: https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4@xiaomi.com/
>>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>> ---
>>>>>> Hi Chao, could you try this patch to check if it fixes your issue? Thanks.
>>>>>> ---
>>>>>>     mm/shmem.c | 2 ++
>>>>>>     1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>>>> index 94c5b0d78ac3..d4cb57b3b0ef 100644
>>>>>> --- a/mm/shmem.c
>>>>>> +++ b/mm/shmem.c
>>>>>> @@ -2066,6 +2066,8 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
>>>>>>            if (swapcache_prepare(entry, nr_pages)) {
>>>>>>                    folio_put(new);
>>>>>>                    new = ERR_PTR(-EEXIST);
>>>>>> +               /* Relax a bit to prevent rapid repeated page faults */
>>>>>> +               schedule_timeout_uninterruptible(1);
>>>>>>                    /* Try smaller folio to avoid cache conflict */
>>>>>>                    goto fallback;
>>>>>>            }
>>>>>> --
>>>>>> 2.47.3
>>>>>>
>>>>>
>>>>> Thanks! That's much more simpler than I expected. Do we need a wakeup
>>>>> queue like the one in commit 01626a1823024? Perhaps the reporter can
>>>>> help confirm and test? I personally prefer to keep it simple if shmem
>>>>> users aren't as sensitive as anon users.
>>>>
>>>> I agree. I'd like to keep the bugfix as simple as possible, if the
>>>> reporter's scenario isn't latency-sensitive.
>>>
>>> On Android, we don't see much shmem; it's much less common
>>> than anon. So the chance of this concurrency happening should
>>> be lower than for anon. However, shmem can be shared by
>>> multiple processes, so could this still happen if process A is
>>> blocked by process B?
>>
>> Could you be more specific about how that happens? I think we should fix
>> this starvation/livelock issue if you think it could still happen.
> 
> Hi Baolin,
> 
> I think your change has fixed the livelock issue, but an unconditional
> one-tick sleep could still be problematic, as commit 01626a1823 tried to
> address in do_swap_page():
> 
> "mm: avoid unconditional one-tick sleep when swapcache_prepare fails"
> 
> If possible, I would suggest that your fix also include the change from
> commit 01626a1823 to avoid the issue caused by
> schedule_timeout_uninterruptible(1): an unconditional one-tick sleep
> could cause UI stuttering. At least, this would make the code more
> defensive.

Sounds reasonable to me. Will do in v2. Thanks.
