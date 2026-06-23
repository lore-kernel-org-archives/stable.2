Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB325B0BD
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199017; cv=none; b=dHWmTal+dnaktzkQtYRjkFNVABBFOshAv+XUUXpcfJf/CMaRf/M1xW1pyCktfTcjRJE/qYj2HH4MbhpPJ2mLbGdhOp4hnVscIMV5pK5pd+anM4rAivkeRlbBeiulKDI06i0U/7rdDgDL4YVRxt9C9gaZW5AtdDGcY2ZZ6BGNc/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199017; c=relaxed/simple;
	bh=l1gQ6oU5AxLIn/0A7p5EEoFlikm6dyZM/gbIW61sjS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fr5YeY999kh3zhNHiXupa/9/3up7UircPu/ehL/e6eIbNqTKivuoCXpL/NPcelveiGLwDdO36uQ3LhFc1hZ6/3o5qzo854DXwu4f+FfWjlJZgu40JqIXEYUIjOUnh9Gg8XVuvts3mQPoLQltTrBLWPAPV93PXjzgDjTWOD7Ap+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jQrd2K6W; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jQrd2K6W"
Message-ID: <d97128c0-7d89-4b5c-b891-84f9af702fee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782199012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZ+uAaSGd3OZS1aU2uMCCmFDj6tXs2rYH2kiB6ZZtOs=;
	b=jQrd2K6Wcjb+o/3i0dgciyF91g4QWNDhUnuaOH0U/WqJXuqyfCODDSAdXGvqwnfORs9/pp
	NoJIu+nDxRDWNjuYV3koTQWxNHMwTCB4948DzxfGQiXU4rgwzn1XJNWgfBp0ZlycHlj8Bs
	6FPTSMSFVXKDjpvJFk6zfgKzttDwzSc=
Date: Tue, 23 Jun 2026 15:16:16 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <e74b0808-3bcc-414d-a037-41e479210cc0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Harry,

On 6/23/26 2:17 PM, Harry Yoo wrote:
> 
> 
> On 6/23/26 11:42 AM, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> The mglru page table walker batches per-generation size deltas in
>> walk->nr_pages while walking page tables without holding the lruvec lock.
>> The reset_batch_size() later folds those deltas into walk->lruvec under
>> the lruvec lock.
> 
> Ouch.
> 
> IIRC the user-visible impact of underestimated nr_pages in MGLRU
> was premature OOMs because MGLRU does not try to reclaim memory when
> nr_pages reaches zero, but there are still more pages.
> 
> Perhaps worth mentioning in the changelog?

Maybe this should be placed before "To fix it...".

> 
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
> 
> The problem here is that, while grabbing a reference to memcg
> (via mem_cgroup_iter(), for example) makes sure that the memcg is not
> freed, it does not prevent offlining happening, and reset_batch_size()
> doesn't check whether the lruvec has been reparented, or the lruvec
> is going to be reparented.
> 
>> This will trigger the following warning in lru_gen_exit_memcg():
>>
>> 	VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
>> 				   sizeof(lruvec->lrugen.nr_pages)));
>>
>> To fix it, add lrugen->reparented to remember the new owner of a
>> reparented lruvec, and make reset_batch_size() charge pending deltas to
>> that owner.
> 
> Could you please explain why it is unavoidable to introduce the new
> field and why checking whether the cgroup is dying (and charging deltas
> to non-dying parent) doesn't work?

Peiyang tried doing this [1], but it doesn't work because
ss->css_offline() is called before clearing the CSS_ONLINE flag. I
also considered using mem_cgroup_tryget_online(), but that only prevent
the memcg from being freed. It's doesn't prevent the offlining.

So in the end, I chose the approach used in this patch. Simply adding
a new field to mglru to track its reparenting status seems to be the
most straightforward and effective approach.

Thanks,
Qi

[1]. 
https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn

> 
>> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
>> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn
>> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Barry Song <baohua@kernel.org>
>> ---
> 

