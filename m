Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAB7385D75
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285162; cv=none; b=HgnUr9JOWX0JB9fxrFtyGoVECMSdbkmA9o5GdATpbavd/6t5Mdbm7OVyAJmcegNdsbpEaS1YxCZ5w4C/E1FqsFsmnVToQb3ajXxKGwwN34/q1JM43xG+M1yoYdVQ+FZ2AxPaJwnsBKrfp+NQlgrPYnyocyFqCbQTSW3v68KjOkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285162; c=relaxed/simple;
	bh=n0IEHjX//acEk3dD0zAM4yDYsraUM1Co33q8WEXpc9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYnfda/ZRu/zH0LBLcVO2rk2rligv+i4VwgqibwZaIic3w2EFDbIMzWgr950R6JH97hnDY23Rgf9uCELb1p5ijt9D7WOBG+HDPEtZsRZIwbJ3TsCiv1hjv3EEBU66tLLk5TbmFiwDa7Y/7i/GRyNSAklKSXKueyFdhsJ/8GHKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pScYdSzc; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pScYdSzc"
Message-ID: <1d638906-6d64-4e57-a181-4b77683652b5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782285148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DE60QhT/9TIkbnwdBa1IYV0upZCsNlOd11TX3mGeBc=;
	b=pScYdSzcoIw3LlQrsqm+dUGApjLrnkhSSXhR1XjT1wGHtRCn/M2UQoPA4bLfm86WJM8meV
	1R2FvGl5DomnILpB8yR1P7mDDh7+OGUJzF0fF/Zz/aWq4vuHcahfQuJU9xVagqILwo7kJJ
	UmAflc10g9+6wE4vQbEC0rBAQaPpjAg=
Date: Wed, 24 Jun 2026 15:11:56 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Harry Yoo <harry@kernel.org>, akpm@linux-foundation.org,
 david@kernel.org, kasong@tencent.com, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, hannes@cmpxchg.org, muchun.song@linux.dev,
 peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <20260623024237.45990-1-qi.zheng@linux.dev>
 <e74b0808-3bcc-414d-a037-41e479210cc0@kernel.org>
 <d97128c0-7d89-4b5c-b891-84f9af702fee@linux.dev>
 <8a76aefd-629c-41f3-b365-aefd4cc1411e@kernel.org>
 <7946da94-dc1d-4cf2-986e-466c378665b6@linux.dev>
 <dfe5d773-2992-448b-a6cb-ef633714a08f@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <dfe5d773-2992-448b-a6cb-ef633714a08f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Harry,

On 6/24/26 12:29 PM, Harry Yoo wrote:
> 
> 
> On 6/23/26 6:14 PM, Qi Zheng wrote:
>> Hi Harry,
>>
>> On 6/23/26 4:18 PM, Harry Yoo wrote:
>>> On 6/23/26 4:16 PM, Qi Zheng wrote:
>>>> Hi Harry,
>>>
>>> Hi Qi!
>>>
>>>> On 6/23/26 2:17 PM, Harry Yoo wrote:
>>>>> On 6/23/26 11:42 AM, Qi Zheng wrote:
>>>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>>
>>>>>> The mglru page table walker batches per-generation size deltas in
>>>>>> walk->nr_pages while walking page tables without holding the lruvec
>>>>>> lock.
>>>>>> The reset_batch_size() later folds those deltas into walk->lruvec
>>>>>> under
>>>>>> the lruvec lock.
>>>>>
>>>>> Ouch.
>>>>>
>>>>> IIRC the user-visible impact of underestimated nr_pages in MGLRU
>>>>> was premature OOMs because MGLRU does not try to reclaim memory when
>>>>> nr_pages reaches zero, but there are still more pages.
>>>>>
>>>>> Perhaps worth mentioning in the changelog?
>>>>
>>>> Maybe this should be placed before "To fix it...".
>>>
>>> Thanks!
>>>
>>>>>> The page table walker can run concurrently with the memcg reparenting
>>>>>> path
>>>>>> as follows:
>>>>>>
>>>>>> CPU0                           CPU1
>>>>>> ====                           ====
>>>>>>
>>>>>> walk_mm
>>>>>> --> walk_page_range
>>>>>>        --> update_batch_size
>>>>>>            --> walk->nr_pages += delta
>>>>>>
>>>>>>                                  mem_cgroup_css_offline
>>>>>>                                  --> memcg_reparent_objcgs
>>>>>>                                      --> lock lruvec
>>>>>>                                          lru_gen_reparent_memcg
>>>>>>                                          --> reparent child folios to
>>>>>> parent
>>>>>>                                          unlock lruvec
>>>>>>
>>>>>>        lock lruvec
>>>>>>        reset_batch_size
>>>>>>        --> child lrugen->nr_pages += delta
>>>>>
>>>>> The problem here is that, while grabbing a reference to memcg
>>>>> (via mem_cgroup_iter(), for example) makes sure that the memcg is not
>>>>> freed, it does not prevent offlining happening, and reset_batch_size()
>>>>> doesn't check whether the lruvec has been reparented, or the lruvec
>>>>> is going to be reparented.
>>>>>
>>>>>> This will trigger the following warning in lru_gen_exit_memcg():
>>>>>>
>>>>>>       VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
>>>>>>                      sizeof(lruvec->lrugen.nr_pages)));
>>>>>>
>>>>>> To fix it, add lrugen->reparented to remember the new owner of a
>>>>>> reparented lruvec, and make reset_batch_size() charge pending
>>>>>> deltas to
>>>>>> that owner.
>>>>>
>>>>> Could you please explain why it is unavoidable to introduce the new
>>>>> field and why checking whether the cgroup is dying (and charging deltas
>>>>> to non-dying parent) doesn't work?
>>>>
>>>> Peiyang tried doing this [1], but it doesn't work because
>>>> ss->css_offline() is called before clearing the CSS_ONLINE flag.
>>>
>>> Right.
>>>
>>>> I also considered using mem_cgroup_tryget_online(), but that only
>>>> prevent
>>>> the memcg from being freed. It's doesn't prevent the offlining.
>>>
>>> Right.
>>>
>>> I think checking CSS_DYING under RCU and grabbing the lruvec
>>> of the first non-dying memcg should work (this pattern is already
>>> used where we use RCU to guarantee memcgs are not freed).
>>>
>>> If we do not observe CSS_DYING flag, it is safe to charge deltas
>>> to the lruvec because RCU guarantees that reparenting cannot happen
>>> under us.
>>>
>>> If we do observe CSS_DYING, we can walk up the hierarchy and charge
>>> deltas to the first non-dying memcg.
>>
>> Checking CSS_DYING looks feasible, but the rcu lock alone cannot prevent
>> reparenting. We should recheck CSS_DYING after acquiring the lruvec
>> lock, otherwise we might run into the following race:
> 
> Haha, actually, I was thinking of checking CSS_DYING under both RCU and
> lruvec lock. (because that's the pattern)
> 
>>    CPU0 reset_batch_size              CPU1 memcg teardown
>>    =====================              ==================
>>
>>    read !CSS_DYING
>>
>>                                       set CSS_DYING
> 
> Oh, I thought the entire critical section is covered by RCU.
> (I see lock_batch_lruvec() you suggested below doesn't do that)
> 
> Isn't RCU enough to prevent reparenting because RCU guarantees that
> all readers who read !CSS_DYING complete before reparenting?

Oh, I think you are right.

I forgot that offlining is executed in the rcu work context.

Let's walk through this again:

cgroup_destroy_locked
--> kill_css_sync
     --> css->flags |= CSS_DYING;                    1)
     kill_css_finish
     --> css_killed_ref_fn
         --> css_killed_work_fn  <-- RCU work !!     2)
             --> offline_css
                 --> reparent memcg

So while holding the rcu lock, if CSS_DYING is not observed,
css_killed_work_fn() will not be called until rcu_read_unlock().

So lock_batch_lruvec() can be implemented like this:

#ifdef CONFIG_MEMCG
static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
{
	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
	struct mem_cgroup *memcg = lruvec_memcg(lruvec);

	rcu_read_lock();

	/*
	 * The memcg can be NULL when the memory controller is disabled.
	 * Otherwise, the caller keeps the memcg owning @lruvec alive.
	 */
	if (!memcg || !css_is_dying(&memcg->css))
		goto lock;

	do {
		memcg = parent_mem_cgroup(memcg);
	} while (memcg && css_is_dying(&memcg->css));
	lruvec = mem_cgroup_lruvec(memcg, pgdat);

lock:
	spin_lock_irq(&lruvec->lru_lock);

	return lruvec;
}
#else
static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
{
	lruvec_lock_irq(lruvec);

	return lruvec;
}
#endif

Does this make sense?

Thanks,
Qi

> 
> Now I'm confused. Is it strictly required to check CSS_DYING under
> lruvec lock? CSS_DYING is updated outside the lruvec lock anyway?
> 
>>                                       memcg_reparent_objcgs()
>>                                       lock child lruvec
>>                                       move child to parent
>>                                       zero child nr_pages
>>                                       unlock child lruvec
>>
>>    lock child lruvec
>>    charge stale delta to child
>>
>> So it seems lock_batch_lruvec() should be implemented like this:
>>
>> static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
>> {
>>      struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>>
>>      rcu_read_lock();
>> retry:
>>      while (memcg && css_is_dying(&memcg->css))
>>          memcg = parent_mem_cgroup(memcg);
> 
> Isn't this loop unnecessary as spin_lock_irq() -> check CSS_DYING ->
> goto retry does the same thing? (of course, we need to fetch the parent
> memcg before retry then...)
> 
>>      lruvec = mem_cgroup_lruvec(memcg, pgdat);
>>      spin_lock_irq(&lruvec->lru_lock);
>>      if (memcg && unlikely(css_is_dying(&memcg->css))) {
>>          spin_unlock_irq(&lruvec->lru_lock);
>>          goto retry;
>>      }
>>
>>      rcu_read_unlock();
>>
>>      return lruvec;
>> }
> 
> Thanks!
> 

