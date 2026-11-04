Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793763569;
	b=MrF6h5bkTvucdvZwNShzEbSrYGvEJdqwa6o3G95+34mZD7O0HOINylaPa9/ikcEqTZKu
	 yUh8d9cplEvH2f4K5xLwkwVU2fO4cLMOYzXrB9a1nJsQ1CBSs9mDMAZXC/zpQ2NZNregw
	 EkHt/nh+SMfO5MLBgXIG2FkmLqIZqg2cPphIAkWhQJlFi7Hb8mtnVhzd4jsBObShwnAR1
	 y2kIqmHSCMxAgJUUc66yuPJfdxyLLHIGxqdjivGkonyYBvjnqioLecAJdSNeI+OugIw62
	 bD1vLRbRtpTttUv0KSHht6C0tqqdZsHJzZgorXYkV8RESIBSQmZ5P3Y1xV2kHwMBU+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763569;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=01Aq7gKPieZxE3SBl3+t+xrp06XwQVnR3Mk/k1CLSlA=;
	b=rlDAY1eKfAlxtxQd1e83ujB5D9OBEKOD2S2wewo0MJIjVxALPFhPmdflgFy04rN44B/a
	 Yrs2Xgn76K6+i7qb6ILfbwf0VaD9qNF4L/HY6VHtV4aE0gAdOOgyBZ4NMkFkjVd3uKBDg
	 vRBzhoV+81Zy+cOad3xMPeXQxUg493xoTuXEA5yxMvD0XTF9dDs4bR7H7/WrZheo6fIAw
	 5kUdU+C6FYVRWcXR7SfXfzjnQRAiIJuZs82yItK4dIKxojMKyLjldG1VDBq5calMA1Ra9
	 iHNxxICfJl/0AMRtaWCmnTTQSBuEVsvzRHrWm2ofmlNr5nEG6PYzAwItRVbXpt1975w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="MyX5D/kW";
	arc=none smtp.remote-ip=95.215.58.198
Received: from mta1.migadu.com (out-198.mta1.migadu.com [95.215.58.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9F0606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 03:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D9F0606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MyX5D/kW
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jqUVmAlPtX6mbUXql1pA60JQ91sSKa7gr/G4bWwt47g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793763560; v=1; x=1794368360;
 b=MyX5D/kW0AqUhD0Q/cHG9pm+8XXS6sMt8TkP9NdXO+CvGqNUlgJ5vZG+HoJjJ2wWjwDffLr7
 DxgIUfSAce18eh/8+TmNdFDLxQiXaezPFaxWuGFeKYQdwfT6OVarApE/YPz4hY+7pSjYE3HWoVt
 4GdOeOTHtiXRWfj219rxGcEI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5171a04d1f5983c4;
	Wed, 04 Nov 2026 03:39:20 +0000
X-Mizu-Trace-ID: 5171a04d1f5983c4
X-Migadu-Flow: FLOW_OUT
Message-ID: <c8e43f76-3f99-44e5-9c33-d45660d9b5f7@linux.dev>
Date: Wed, 4 Nov 2026 11:39:15 +0800
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
Subject: Re: [PATCH 4/4] mm: hugetlb: respect cpuset restrictions for surplus
 allocations
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, muchun.song@linux.dev,
 osalvador@suse.de, david@kernel.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
 Lance Yang <lance.yang@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1793692578.git.zhengqi.arch@bytedance.com>
 <d1e41a65970ced879715a73ce2607de7ad102fb2.1793692578.git.zhengqi.arch@bytedance.com>
 <b1c86bc9-24e8-4c87-b2a7-2eefbdd96c12@gmail.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <b1c86bc9-24e8-4c87-b2a7-2eefbdd96c12@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/3/26 8:21 PM, Jose A. Perez de Azpillaga wrote:
> On 11/3/26 9:01 AM, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Gigantic surplus allocations can escape the faulting task's cpuset.
>> CMA and the contiguous allocator trust the supplied nodemask without
>> checking the current cpuset.
>>
>> For example, a shared HugeTLB VMA has MPOL_BIND={0,1}, and T is a
>> non-leader thread. With surplus allocation enabled and no eligible free
>> HugeTLB folio, the following sequence can occur:
>>
>>    CPU0 (cgroup v1 migration)       CPU1 (thread T)
>>    -------------------------       ---------------
>>    cpuset_attach_task(..., T)
>>      T->mems_allowed = {0}
>>      /* Non-leader: skip
>>         mpol_rebind_mm(). */
>>                                    /* Fault; VMA policy is still {0,1}. */
>>                                    policy_nodemask()
>>                                      /* {0,1} intersects {0}. */
>>                                      nodemask = {0,1}
>>                                    hugetlb_cma_alloc_frozen_folio()
>>                                      /* node0 fails; node1 succeeds. */
>>
>> The 1 GiB folio is allocated on node1 despite T being restricted to node0.
>>
>> Intersect the interpreted policy with the current cpuset before surplus
>> allocation, preserving MPOL_BIND and MPOL_PREFERRED_MANY fallback rules.
>> Apply the restriction at the policy-aware entry point to preserve
>> per-node pool management semantics.
>>
>> If the cpuset changes during allocation, rebuild the mask and revalidate
>> any allocated folio against the current constraints. Keep it if it is
>> still eligible: freeing an HVO-optimized folio can defer returning its
>> range to CMA, so discarding a usable folio can cause a needless allocation
>> failure. Only release the folio and allocate again if it is no longer
>> eligible.
>>
>> Fixes: eb02f14c4a2b ("mm/hugetlb: allow overcommitting gigantic hugepages")
>> Cc: stable@vger.kernel.org
>> Reported-by: Lance Yang <lance.yang@linux.dev>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/hugetlb.c | 38 +++++++++++++++++++++++++++++++-------
>>   1 file changed, 31 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index ce9c8e57b8e5c..6fd6e58ace869 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -2181,22 +2181,46 @@ struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
>>   		gfp_t gfp_mask, struct mempolicy_interpreted *mpoli)
>>   {
>>   	struct folio *folio = NULL;
>> -	nodemask_t *nodemask = mpoli->nodemask;
>> +	nodemask_t alloc_nodemask;
>> +	unsigned int cpuset_mems_cookie;
>> +
>> +retry:
>> +	cpuset_mems_cookie = read_mems_allowed_begin();
>> +	alloc_nodemask = cpuset_current_mems_allowed;
>> +	if (mpoli->mode == MPOL_BIND && mpoli->nodemask &&
>> +	    nodes_intersects(*mpoli->nodemask, alloc_nodemask))
>> +		nodes_and(alloc_nodemask, alloc_nodemask, *mpoli->nodemask);
>> +
>> +	if (folio) {
>> +		if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
>> +			goto retry;
>> +
>> +		if (node_isset(folio_nid(folio), alloc_nodemask))
>> +			return folio;
>> +
>> +		/* Balance free_huge_folio()'s decrement before caller accounting */
>> +		lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
>> +		free_huge_folio(folio);
>> +		folio = NULL;
>> +	}
> 
> the page allocator only retries when the allocation fails, why does this
> need to drop a folio that raced with a cpuset change? retrying only on
> !folio would make this whole block go away, with the check at the end as:

You're right. I overthought the cpuset race and added unnecessary
revalidation of successful allocations.

> 
>          if (!folio &&
>              unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
>                  goto retry;

I'll follow your suggestion and retry only failed allocations, and
update the commit message accordingly.

Thanks,
Qi

> 
>>   
>>   	if (mpoli->mode == MPOL_PREFERRED_MANY) {
>>   		gfp_t gfp = gfp_mask & ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
>>   
>> +		nodes_and(alloc_nodemask, alloc_nodemask, *mpoli->nodemask);
>>   		folio = alloc_surplus_hugetlb_folio(h, gfp, mpoli->nid,
>> -						    nodemask);
>> +						    &alloc_nodemask);
>>   
>> -		/* Fallback to all nodes if page==NULL */
>> -		nodemask = NULL;
>> +		/* Fallback to all nodes allowed by the current cpuset */
>> +		alloc_nodemask = cpuset_current_mems_allowed;
>>   	}
>>   
>> -	if (!folio) {
>> +	if (!folio)
>>   		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, mpoli->nid,
>> -						    nodemask);
>> -	}
>> +						    &alloc_nodemask);
>> +
>> +	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
>> +		goto retry;
>>   
>>   	return folio;
>>   }
> 
> 

