Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5262F7EF3
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782449333; cv=none; b=VaL7M03EIaRMZ9KDT08/O/KKrbygtM8r/sEFkyJe0/+ASTEtIZtJ5e6vMp08BkOW61Ixw4t/i2+yVQ3K1FXntxZWbmQDUht63LJEzHw8u/6h3vRpAOsROasnPv6D0HE5ywvLDtKjQu45NKg+UH9qGtIp29f84mylWAPy6pZ85bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782449333; c=relaxed/simple;
	bh=pshs9cS8z+GYnIH28HABDCqbCrv1qSUXb3AJw/fA3Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuVHqSuwjt6o0rnLF/iPD3fdVbt2Uk2SvKSSsvf7RLAn2ZwcrqZoKWuEw97m+pDD95XdikBLoLfQSGWpNqLroXmBe0BBokD23Ts+86hB52ktmpsrr1JRWDSUz5mOPXppQN8eA9vLH/UKFZ4mnY3ktnpry7JCBraOChgmxGWYs7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u6W1Mh5t; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u6W1Mh5t"
Message-ID: <08cf8972-6cfc-4452-9a3c-88e0368dbbf9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782449328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXWAjRXwVjfvQ2EeAYBpqAd/3dxRlR+I4BBsCU5i8SU=;
	b=u6W1Mh5tSI/Kxm1HgHeZwa/QlBHUNxcYuSPz2Jt+pfXZ9gjN1Ra9iT1TBy5lDtQH3pB0Dv
	WL+8IYnioDUK/Cs/3jMFCkweHWzC0/LkkwQIKhLtDgpOHEyn04+66sZSZs0BrAPBJ6qm1z
	K7PpuICdv8vceJ68w5R598mrhjnWb2s=
Date: Fri, 26 Jun 2026 12:48:37 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Harry Yoo <harry@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, muchun.song@linux.dev,
 peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <20260625151554.55105-1-qi.zheng@linux.dev>
 <aj12aVq3he6q7b2C@cmpxchg.org>
 <4c7b0c46-14f0-4a62-893e-e50714e09b74@linux.dev>
 <46ac28bf-5be1-4600-b522-0a1aa76c28e6@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <46ac28bf-5be1-4600-b522-0a1aa76c28e6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/26/26 12:43 PM, Harry Yoo wrote:
> 
> 
> On 6/26/26 11:27 AM, Qi Zheng wrote:
>> Hi Johannes,
>>
>> On 6/26/26 2:41 AM, Johannes Weiner wrote:
>>> On Thu, Jun 25, 2026 at 11:15:54PM +0800, Qi Zheng wrote:
>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>
>>>> The mglru page table walker batches per-generation size deltas in
>>>> walk->nr_pages while walking page tables without holding the lruvec
>>>> lock.
>>>> The reset_batch_size() later folds those deltas into walk->lruvec under
>>>> the lruvec lock.
>>>>
>>>> The page table walker can run concurrently with the memcg reparenting
>>>> path
>>>> as follows:
>>>>
>>>> CPU0                           CPU1
>>>> ====                           ====
>>>>
>>>> walk_mm
>>>> --> walk_page_range
>>>>       --> update_batch_size
>>>>           --> walk->nr_pages += delta
>>>>
>>>>                                 mem_cgroup_css_offline
>>>>                                 --> memcg_reparent_objcgs
>>>>                                     --> lock lruvec
>>>>                                         lru_gen_reparent_memcg
>>>>                                         --> reparent child folios to
>>>> parent
>>>>                                         unlock lruvec
>>>>
>>>>       lock lruvec
>>>>       reset_batch_size
>>>>       --> child lrugen->nr_pages += delta
>>>>
>>>> This will trigger the following warning in lru_gen_exit_memcg():
>>>>
>>>>      VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
>>>>                     sizeof(lruvec->lrugen.nr_pages)));
>>>>
>>>> And the user-visible impact of underestimated nr_pages in MGLRU was
>>>> premature OOMs because MGLRU does not try to reclaim memory when
>>>> nr_pages
>>>> reaches zero, but there are still more pages.
>>>>
>>>> To fix it, make reset_batch_size() check CSS_DYING under RCU before
>>>> flushing the pending batch. A non-dying memcg keeps the original lruvec
>>>> stable against RCU-delayed offlining; a dying memcg redirects the deltas
>>>> to the first non-dying ancestor.
>>>>
>>>> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
>>>> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-
>>>> efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn
>>>> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
>>>> Cc: <stable@vger.kernel.org>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>> Changes in v3:
>>>>    - re-implement lock_batch_lruvec() by checking CSS_DYING under the
>>>> RCU lock
>>>>      (suggested by Harry)
>>>>    - update the commit message (suggested by Harry)
>>>>    - temporarily drop the previous Reviewed-by tags
>>>>      (since the sync method has changed)
>>>>    - rebase onto the next-20260624
>>>>
>>>> Changes in v2:
>>>>    - update the commit message (pointed by Barry)
>>>>    - collect Reviewed-by
>>>>
>>>>    mm/vmscan.c | 45 ++++++++++++++++++++++++++++++++++++++-------
>>>>    1 file changed, 38 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index 35c3bb15ae96..1ec8c23c72b9 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -3262,10 +3262,44 @@ static void update_batch_size(struct
>>>> lru_gen_mm_walk *walk, struct folio *folio,
>>>>        walk->nr_pages[new_gen][type][zone] += delta;
>>>>    }
>>>>    +#ifdef CONFIG_MEMCG
>>>> +static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
>>>> +{
>>>> +    struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>>>> +    struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>>>> +
>>>> +    rcu_read_lock();
>>>
>>> Where is this unlocked?
>>
>> The lruvec_unlock_irq() in reset_batch_size() will handle the unlocking.
>>
>>>
>>>> +    /*
>>>> +     * The memcg can be NULL when the memory controller is disabled.
>>>> +     * Otherwise, the caller keeps the memcg owning @lruvec alive.
>>>> +     */
>>>> +    if (!memcg || !css_is_dying(&memcg->css))
>>>> +        goto lock;
>>>> +
>>>> +    do {
>>>> +        memcg = parent_mem_cgroup(memcg);
>>>> +    } while (memcg && css_is_dying(&memcg->css));
>>>> +    lruvec = mem_cgroup_lruvec(memcg, pgdat);
>>>
>>>      while (unlikely(memcg && css_is_dying(&memcg->css))) {
>>>          memcg = parent_mem_cgroup(memcg);
>>>          lruvec = mem_cgroup_lruvec(memcg, pgdat);
>>
>> There is no need to acquire the lruvec before finding the first
>> non-dying memcg.
> 
> struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> 
> rcu_read_lock()
> 
> while (unlikely(memcg_is_dying(memcg)))
>          memcg = parent_mem_cgroup(memcg);
> 
> lruvec = mem_cgroup_lruvec(memcg, pgdat);

If the first memcg is already non-dying, there's no need to re-acquire
the lruvec. ;)

Thanks,
Qi

> spin_lock_irq(&lruvec->lru_lock);
> 
> return lruvec;
> 
> should work?
> 
> if the memory controller is disabled, it's equivalent to:
> 
> rcu_read_lock();
> spin_lock_irq(&lruvec->lru_lock);
> return lruvec;
> 

