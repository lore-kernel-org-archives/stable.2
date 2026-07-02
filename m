Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7662BDC23
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 01:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956360; cv=none; b=LnD2FIdXLpWufSq5BcJ1i6v0yQGA6LO/iostpvV9QlNOuN3pievJU2Bo1LD7bVT+oT+yp2uUmWqkPp8QwrxdShp6BzdlcoWJvqwa/IYqwzbo4RSVWTDYGhKkQSS5bmQKbSJeniZC6Eio+LlW6lrcsKo/1RhUL45V52zKK9X101E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956360; c=relaxed/simple;
	bh=66DydrvzAjI033LmDdftprpH7jAqg26PyF9qX1g/7OA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R16ZMjB8MBoLWlNehlc7LIl/rjhF/zZAbV25Ucs5PKbAIGQQBV6unC9CXF6JiS7DZ6XhPBy/MtaKuJywOGSb9187LD8f09FlF4ZUgThxn4CuoWcLBUta/VDGeepGcALNDCRp8hfy5jxpQbGJnp/jvijRKG9uvzWE8pAn7dqkc5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FWVIAyHU; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FWVIAyHU"
Message-ID: <cbba6349-55a1-416d-a686-d03ff72cc211@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782956346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oy1rhcxFbJPb8dTCKU8Gfj8AxUhJZJdRCaNcIMoi9hk=;
	b=FWVIAyHUAhvVuzDPPF9CTLQ/MP/m+BXRk2M/5Nyym94ltS0gGjlgX50dne/NMoifnWgzcL
	25c+3QkD3raK6VNU9Ug5FwpGDYFrIlsdiqG7oo17tMmezBIn4UU1GY2ixBYrCYci/6LVMM
	rpd6LCAqwTU5etYfN9G8gEudOanqpPw=
Date: Thu, 2 Jul 2026 09:38:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Johannes Weiner <hannes@cmpxchg.org>, Harry Yoo <harry@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>, akpm@linux-foundation.org,
 david@kernel.org, kasong@tencent.com, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, muchun.song@linux.dev, peiyang_he@smail.nju.edu.cn,
 mhocko@kernel.org, roman.gushchin@linux.dev, ljs@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <20260701145736.3785016-1-usama.arif@linux.dev>
 <2fb5ce53-666b-4b0a-a4ad-2b3a28c54768@kernel.org>
 <akU5VdOBkLGInh_t@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <akU5VdOBkLGInh_t@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/1/26 11:59 PM, Johannes Weiner wrote:
> On Thu, Jul 02, 2026 at 12:36:42AM +0900, Harry Yoo wrote:
>>
>>
>> On 7/1/26 11:57 PM, Usama Arif wrote:
>>> On Wed,  1 Jul 2026 15:52:51 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
>>>
>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>
>>>> The mglru page table walker batches per-generation size deltas in
>>>> walk->nr_pages while walking page tables without holding the lruvec lock.
>>>> The reset_batch_size() later folds those deltas into walk->lruvec under
>>>> the lruvec lock.
>>>>
>>>> The page table walker can run concurrently with the memcg reparenting path
>>>> as follows:
>>>>
>>>> CPU0                           CPU1
>>>> ====                           ====
>>>>
>>>> walk_mm
>>>> --> walk_page_range
>>>>      --> update_batch_size
>>>>          --> walk->nr_pages += delta
>>>>
>>>>                                mem_cgroup_css_offline
>>>>                                --> memcg_reparent_objcgs
>>>>                                    --> lock lruvec
>>>>                                        lru_gen_reparent_memcg
>>>>                                        --> reparent child folios to parent
>>>>                                        unlock lruvec
>>>>
>>>>      lock lruvec
>>>>      reset_batch_size
>>>>      --> child lrugen->nr_pages += delta
>>>>
>>>> This will trigger the following warning in lru_gen_exit_memcg():
>>>>
>>>> 	VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
>>>> 				   sizeof(lruvec->lrugen.nr_pages)));
>>>>
>>>> And the user-visible impact of underestimated nr_pages in MGLRU was
>>>> premature OOMs because MGLRU does not try to reclaim memory when nr_pages
>>>> reaches zero, but there are still more pages.
>>>>
>>>> To fix it, make reset_batch_size() check CSS_DYING under RCU before
>>>> flushing the pending batch. A non-dying memcg keeps the original lruvec
>>>> stable against RCU-delayed offlining; a dying memcg redirects the deltas
>>>> to the first non-dying ancestor.
>>>>
>>>> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
>>>> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn
>>>> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
>>>> Cc: <stable@vger.kernel.org>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
>>>> ---
>>>> Changes in v4:
>>>>   - re-implement lock_batch_lruvec() in a simpler way
>>>>     (suggested by Johannes and Harry)
>>>>   - collect Reviewed-by
>>>>   - rebase onto the next-20260630
>>>>
>>>> Changes in v3:
>>>>   - re-implement lock_batch_lruvec() by checking CSS_DYING under the RCU lock
>>>>     (suggested by Harry)
>>>>   - update the commit message (suggested by Harry)
>>>>   - temporarily drop the previous Reviewed-by tags
>>>>     (since the sync method has changed)
>>>>   - rebase onto the next-20260624
>>>>
>>>> Changes in v2:
>>>>   - update the commit message (pointed by Barry)
>>>>   - collect Reviewed-by
>>>>
>>>>   mm/vmscan.c | 41 ++++++++++++++++++++++++++++++++++-------
>>>>   1 file changed, 34 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index 35c3bb15ae96..ca1e2a870d51 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -3262,10 +3262,40 @@ static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
>>>>   	walk->nr_pages[new_gen][type][zone] += delta;
>>>>   }
>>>>   
>>>> +#ifdef CONFIG_MEMCG
>>>> +static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
>>>> +{
>>>> +	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>>>> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>>>> +
>>>> +	rcu_read_lock();
>>>> +
>>>> +	/*
>>>> +	 * The memcg can be NULL when the memory controller is disabled.
>>>> +	 * Otherwise, the caller keeps the memcg owning @lruvec alive.
>>>> +	 */
>>>> +	while (unlikely(memcg && css_is_dying(&memcg->css))) {
>>>> +		memcg = parent_mem_cgroup(memcg);
>>>> +		lruvec = mem_cgroup_lruvec(memcg, pgdat);
>>>> +	}
>>>> +
>>>> +	spin_lock_irq(&lruvec->lru_lock);
>>>
>>> Do we need an rcu_read_unlock() here?
>>
>> lruvec_unlock_irq() does that.
> 
> Yeah, that tripped me up too. And it makes me think Shakeel was right
> after all: this should live next to the other lruvec_lock() primitives.
> 
> Sure, MGLRU is the only user, but it's still much easier to understand
> this if the code sits next to the rest of the API (and the unlock!).
> 
> lruvec_live_lock_irq()?

But lruvec_lock_irq() grabs the rcu lock too. :(




