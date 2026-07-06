Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFD33033F5;
	Mon,  6 Jul 2026 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339724; cv=none; b=Bn2Y5r9FNtpuKlgzXBg56f9YIAdoJ9W0/V03CH05in3Q67zHg6xFJDPN5LdJgYKGsWExeMki4jsKKhP0CgbA5e54ulfN5Z8yNotSNfmJNsBSmZOphzF4QF9o/Gxtf6lin6LpFJ+2Fzt65/2TPDdKmeM098pcSBDN9rh0pjk1W/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339724; c=relaxed/simple;
	bh=b8jXmnYhK3uOLfgrdJYFzlV8ZSiFyPZ71Gpw3aE3XQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQHoxC/nPk/IZfFP00cTo7JdO1DLXU6yDbL3VqX8Ej89pc1JtDhWt3cwH+OehOhFkDdTlk527RmgctjrCZEtVusoq6xU18dNlylxeeq5fGePXWsHuIFC0wPcm4gWocjEG8yr4OHWctleLZ7Y6BbL+Pb2U+xvBo8CWK1IiQ6w8aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Gdoe5j5t; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Gdoe5j5t"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783339717; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xZddxHRGgxDKnCx0072/zTHmK6GyWnLW8ka8kUBFC/I=;
	b=Gdoe5j5t+m8cSozIbugHPlSUQi2UagikqKdGSwcLCd/agJVE+EICm6dEUeSc4hGb1otRm4lupNNVE2UF0R5gQwhUODlGebA9G5D7pF0LDxdsf5B7lGWUDWUp2UbqSazJi2QoB2p9J4RiKaeooyydkIQ73UbIrAv1ivKaJnYNmSw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X6VYQxf_1783339715;
Received: from 30.246.179.165(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X6VYQxf_1783339715 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 06 Jul 2026 20:08:36 +0800
Message-ID: <8ef0b72e-a0e8-4913-8d30-519335305260@linux.alibaba.com>
Date: Mon, 6 Jul 2026 20:08:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18.y] mm: shmem: fix potential livelock issue for shmem
 direct swapin
To: Kairui Song <ryncsn@gmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, stable@vger.kernel.org,
 baohua@kernel.org, machao26@xiaomi.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <173f3fd983d735155d47e9e39d27f0c2d62a7c31.1783307463.git.baolin.wang@linux.alibaba.com>
 <CAMgjq7AQcyypJ-VhJ_CxY6fdEph64fxjOzzYU-=EkMrHemkpzA@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAMgjq7AQcyypJ-VhJ_CxY6fdEph64fxjOzzYU-=EkMrHemkpzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/6/26 1:59 PM, Kairui Song wrote:
> On Mon, Jul 6, 2026 at 11:25 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> When skipping swapcache for synchronous IO swap devices, swapcache_prepare()
>> is used to prevent parallel swapin from proceeding with the swap cache flag.
>> However, on PREEMPT kernels this can lead to a livelock, as reported by Chao[1]:
>>
>> Thread A starts direct swapin of a shmem folio and calls swapcache_prepare()
>> to set SWAP_HAS_CACHE. It may then be preempted inside workingset_refault().
>> Meanwhile, a higher priority thread B also attempts direct swapin of the same
>> shmem swap entry. Since swapcache_prepare() already marks the entry, thread B
>> repeatedly gets -EEXIST and busy-loops waiting for thread A to finish. But as
>> thread B runs at higher priority, thread A cannot preempt it, resulting in
>> starvation and a livelock.
>>
>> Fix it by yielding the CPU with schedule_timeout_uninterruptible(1) when
>> swapcache_prepare() fails, following the same approach used in commits
>> 029c4628b2eb ("mm: swap: get rid of livelock in swapin readahead") and
>> 13ddaf26be32 ("mm/swap: fix race when skipping swapcache").
>>
>> Note that mainline does not have this potential issue, which has already been
>> resolved by Kairui's swap refactoring work[2].
>>
>> [1] https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4@xiaomi.com/
>> [2] https://lore.kernel.org/all/20260517-swap-table-p4-v5-0-88ae43e064c7@tencent.com/
>> Fixes: 1dd44c0af4fa ("mm: shmem: skip swapcache for swapin of synchronous swap device")
>> Reported-by: Ma Chao <machao26@xiaomi.com>
>> Closes: https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4@xiaomi.com/
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>> Hi Chao, could you try this patch to check if it fixes your issue? Thanks.
>> ---
>>   mm/shmem.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 94c5b0d78ac3..d4cb57b3b0ef 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2066,6 +2066,8 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
>>          if (swapcache_prepare(entry, nr_pages)) {
>>                  folio_put(new);
>>                  new = ERR_PTR(-EEXIST);
>> +               /* Relax a bit to prevent rapid repeated page faults */
>> +               schedule_timeout_uninterruptible(1);
>>                  /* Try smaller folio to avoid cache conflict */
>>                  goto fallback;
>>          }
>> --
>> 2.47.3
>>
> 
> Thanks! That's much more simpler than I expected. Do we need a wakeup
> queue like the one in commit 01626a1823024? Perhaps the reporter can
> help confirm and test? I personally prefer to keep it simple if shmem
> users aren't as sensitive as anon users.

I agree. I'd like to keep the bugfix as simple as possible, if the 
reporter's scenario isn't latency-sensitive.
