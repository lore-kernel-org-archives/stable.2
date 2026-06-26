Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F531419A4
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 02:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782441560; cv=none; b=AvjdjnuQ+IGhqxbCoY7759VuzpiCRpFb4HHhoKwqd+/+O6qZxpgtLdRs0tuOK24EePz+ywD6JLn6QrKlCs+6gf1hwoK+izFY98GsTgQoU/LUQYp0vjI1KoG+jCK405imFRWZU7gtc+SsvYcV9t51N4Qd0WVU2H+plcqvLZsgIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782441560; c=relaxed/simple;
	bh=8E8GaubErZXXm9BNp6qLG1+xEyXvonWSsfvk/hNcy8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfacZ0JrIWZlmr0lX8YupTMHtAPwIBxRT0MftHVlK772I2a/CcBdD0A3mcIpSjRMwsb4x+IvRdYTdIvz6Ro2mSzRrXj/Qd3v0Lpndb1LU/gaNamUpH1didQ8zjosGwqqZBzX2xnFf++adL6X/owp1W/rMkCOtEmNijEHDX1pWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HlxqWPhj; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HlxqWPhj"
Message-ID: <dc62c93c-2dbb-40ab-8e3c-2e2b1c9ff0e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782441557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMiBjpoG5x/PF8SzAf5XymHhBXZlwVkuA+guTc6Tz+s=;
	b=HlxqWPhjhC0j9hY/ieFKCrb9rfUDoIAlwoC+Sk8MOyqCqBiTsnN35cs89wF5SYH1TEWLOi
	qzU92R1k5+LncMjCk6o3/6qcDbYVn5k6wg7D8VSJCiDmMAkD8vPvVrqWPIfU5iR2Bx+jJI
	0er9sGgDMCZzJFFnjaiRH1MvAimy1aA=
Date: Fri, 26 Jun 2026 10:39:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, hannes@cmpxchg.org, harry@kernel.org,
 muchun.song@linux.dev, peiyang_he@smail.nju.edu.cn, mhocko@kernel.org,
 roman.gushchin@linux.dev, ljs@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
 stable@vger.kernel.org
References: <20260625151554.55105-1-qi.zheng@linux.dev>
 <aj2MsQ3tF0ACCCGi@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aj2MsQ3tF0ACCCGi@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Shakeel,

On 6/26/26 4:22 AM, Shakeel Butt wrote:
> On Thu, Jun 25, 2026 at 11:15:54PM +0800, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> The mglru page table walker batches per-generation size deltas in
>> walk->nr_pages while walking page tables without holding the lruvec lock.
>> The reset_batch_size() later folds those deltas into walk->lruvec under
>> the lruvec lock.
>>
>> The page table walker can run concurrently with the memcg reparenting path
>> as follows:
>>
>> CPU0                           CPU1
>> ====                           ====
>>
>> walk_mm
>> --> walk_page_range
>>      --> update_batch_size
>>          --> walk->nr_pages += delta
>>
>>                                mem_cgroup_css_offline
>>                                --> memcg_reparent_objcgs
>>                                    --> lock lruvec
>>                                        lru_gen_reparent_memcg
>>                                        --> reparent child folios to parent
>>                                        unlock lruvec
>>
>>      lock lruvec
>>      reset_batch_size
>>      --> child lrugen->nr_pages += delta
>>
>> This will trigger the following warning in lru_gen_exit_memcg():
>>
>> 	VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
>> 				   sizeof(lruvec->lrugen.nr_pages)));
>>
>> And the user-visible impact of underestimated nr_pages in MGLRU was
>> premature OOMs because MGLRU does not try to reclaim memory when nr_pages
>> reaches zero, but there are still more pages.
>>
>> To fix it, make reset_batch_size() check CSS_DYING under RCU before
>> flushing the pending batch. A non-dying memcg keeps the original lruvec
>> stable against RCU-delayed offlining; a dying memcg redirects the deltas
>> to the first non-dying ancestor.
>>
>> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
>> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn
>> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>> Changes in v3:
>>   - re-implement lock_batch_lruvec() by checking CSS_DYING under the RCU lock
>>     (suggested by Harry)
>>   - update the commit message (suggested by Harry)
>>   - temporarily drop the previous Reviewed-by tags
>>     (since the sync method has changed)
>>   - rebase onto the next-20260624
>>
>> Changes in v2:
>>   - update the commit message (pointed by Barry)
>>   - collect Reviewed-by
>>
>>   mm/vmscan.c | 45 ++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 38 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 35c3bb15ae96..1ec8c23c72b9 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -3262,10 +3262,44 @@ static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
>>   	walk->nr_pages[new_gen][type][zone] += delta;
>>   }
>>   
>> +#ifdef CONFIG_MEMCG
>> +static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
> 
> This is memcg specific function, move this function next to similar functions
> like lruvec_lock_irq. Also put irq in the name.

Currently, the lock_batch_lruvec() is only used by reset_batch_size().
Are you intend to make it a common function for use in other places?

Perhaps we could defer making it generic until we actually have a second
user. Since this is just a fix, keeping it self-contained within
vmscan.c might be more compact for now. ;)

> 
> BTW have you checked other places where lruvec_lock_irq is used and if similar
> kind of situation can happen?

I just checked and found no such callers.

Thanks,
Qi

> 

