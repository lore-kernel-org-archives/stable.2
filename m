Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B21838E8BB
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 04:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783570657; cv=none; b=d8Q22xvc0GhwCxT83EORzbgUcpX7zi7ZCpGfXMAn0Kxz1tFlErAiJoCxOAuRNs1A/cuYkyBP7kUze4xNflXmDezS8deswdN5baDOM0SJHLv27u3R3IG5VzrUMqXxH6XUUGd9fbDaav20bfzHs3VVustjymKP0AFbNHkdnpmTlgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783570657; c=relaxed/simple;
	bh=aOdWUvlzAgvC5OCsq7N+HUUyKZx0APKH7Z2sNls4Csw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgYhtCgl0rwKBja9SVzFlBNrRxiSDkGT8/Rmjb8SYifaf7t8uU0f0gvSB2KTE2vaQHlBrlkXZ9Kn46jda3iKpxiZNJC1OvSLw5CfiPT6aQy55Oj5+j0KZZsGv4MHh5e65PGqEcN4MI9TRgL8dsvbOEKCh+G7bZY33J88Ou4iTRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=icLsN4oX; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="icLsN4oX"
Message-ID: <e90d3476-01aa-4037-91b5-bc35394b488c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783570642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UBqGUL0+KiK1FMBVGSLXqyXS9/Lja6xJ1/PzEqDDCFY=;
	b=icLsN4oXxOuREtLzUD4RXdMBccXd3DogAuZu4P1fEGCT4JgDFQZq7H9tzLzb0F0iYq0bME
	bOQp8MNv4Xq5eO+wuHws9itPdkw19ohX6bpcS859IzbhmKMOrEMHmLCIGXPSamjlWfuvpY
	De4KCJBJwUMom/iyle/je2BeLnQsmEQ=
Date: Thu, 9 Jul 2026 12:17:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4] mm: mglru: fix stale batch updates after memcg
 reparenting
To: akpm@linux-foundation.org, david@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org,
 kasong@tencent.com, shakeel.butt@linux.dev, baohua@kernel.org,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 hannes@cmpxchg.org, harry@kernel.org, muchun.song@linux.dev,
 peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org
References: <20260701075251.56413-1-qi.zheng@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260701075251.56413-1-qi.zheng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Andrew and David,

Gentle ping.

Is this patch good to be applied?

Thanks,
Qi

On 7/1/26 3:52 PM, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> The mglru page table walker batches per-generation size deltas in
> walk->nr_pages while walking page tables without holding the lruvec lock.
> The reset_batch_size() later folds those deltas into walk->lruvec under
> the lruvec lock.
> 
> The page table walker can run concurrently with the memcg reparenting path
> as follows:
> 
> CPU0                           CPU1
> ====                           ====
> 
> walk_mm
> --> walk_page_range
>      --> update_batch_size
>          --> walk->nr_pages += delta
> 
>                                mem_cgroup_css_offline
>                                --> memcg_reparent_objcgs
>                                    --> lock lruvec
>                                        lru_gen_reparent_memcg
>                                        --> reparent child folios to parent
>                                        unlock lruvec
> 
>      lock lruvec
>      reset_batch_size
>      --> child lrugen->nr_pages += delta
> 
> This will trigger the following warning in lru_gen_exit_memcg():
> 
> 	VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
> 				   sizeof(lruvec->lrugen.nr_pages)));
> 
> And the user-visible impact of underestimated nr_pages in MGLRU was
> premature OOMs because MGLRU does not try to reclaim memory when nr_pages
> reaches zero, but there are still more pages.
> 
> To fix it, make reset_batch_size() check CSS_DYING under RCU before
> flushing the pending batch. A non-dying memcg keeps the original lruvec
> stable against RCU-delayed offlining; a dying memcg redirects the deltas
> to the first non-dying ancestor.
> 
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn
> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
> ---
> Changes in v4:
>   - re-implement lock_batch_lruvec() in a simpler way
>     (suggested by Johannes and Harry)
>   - collect Reviewed-by
>   - rebase onto the next-20260630
> 
