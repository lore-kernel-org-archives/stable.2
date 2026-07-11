Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DF423BCEE
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 05:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783747954; cv=none; b=GiVnQTpM9uAI5+MlLpM7pE6zGAquEEQd2qAiQ9c/lqkjGuVR+xlReunslbTFHDs3SC1nqjSHQMTI7JIkGj7lCQ+NiwJLqNJf7jBbjmdFOYWAlyK7ICrJlUjAsAInwIdq0/zxRxQsRmpHJ6c1BbuIjTgmkKP7C8DNRSSUJ8bw57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783747954; c=relaxed/simple;
	bh=gP5Y0SjcbfN2LqAkP2yZSvcUzXaeKw4zrxEpZjs6dRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7N466DxUqmKwluQEgLZ5hZWUT1U64wWRxA3toj4xfpjS88hLgqEl1WaIJ78QKfGblgLUDupQILHXEWs+/PQQHocsJ8G9vmwLEz35fyOegEo8swzYvl17MHRtHntH3Z9F8De+NGoa2L7NqX37K4CSE1bGjqRjK002+5gG+18T5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=deige75K; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="deige75K"
Message-ID: <ab1bdfa0-7382-4d26-a65d-68eb172eb84a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783747940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G5NmJY2iw9mr7LiD+wBGyisuFVRNUZ+aiJ7vkuUhCAE=;
	b=deige75KcMd91XGDV/xznNzEracNWg8yXfEIAK9/OOOe8uqF1uoLyRtIg5SSGFwX2AQ8jc
	WqXflyjQsmlcZq67w+XQRJVVFQ4k2yAoCA5Pj3Ag6IHox67Nho1Z+EK2liTxHbD25RhjwS
	8hKFh1eTpSfmQhoXQoLcCR3KpQ6sEZA=
Date: Sat, 11 Jul 2026 13:31:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: shrinker: Fix double-free in alloc_shrinker_info
 error path
To: Hongling Zeng <zenghongling@kylinos.cn>, akpm@linux-foundation.org,
 david@fromorbit.com, roman.gushchin@linux.dev, muchun.song@linux.dev
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, zhongling0719@126.com,
 stable@vger.kernel.org
References: <20260711041954.95749-1-zenghongling@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260711041954.95749-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Hongling,

On 7/11/26 12:19 PM, Hongling Zeng wrote:
> In alloc_shrinker_info(), when shrinker_unit_alloc() fails for a node,
> the error handler calls free_shrinker_info() which iterates over ALL
> nodes and tries to free their shrinker_info. For the failed node,
> rcu_assign_pointer() was skipped, so its shrinker_info still points
> to old data. This causes double-free of valid shrinker_info structures.

No, it will be NULL, not old data. Therefore, the double-free you
mentioned doesn't exist. Before sending the fix, please verify the
problem exists and your fix actually works.

And as a reminder, please don't repeatedly send identical patches:

1. 
https://lore.kernel.org/all/20260711041509.92926-1-zenghongling@kylinos.cn/
2. 
https://lore.kernel.org/all/20260711041823.95135-1-zenghongling@kylinos.cn/
3. 
https://lore.kernel.org/all/20260711041954.95749-1-zenghongling@kylinos.cn/

One last thing, please make sure to base your changes on the latest
tree.

Thanks,
Qi

> 
> Fix by tracking which node failed and only freeing shrinker_info
> structures that were successfully assigned via rcu_assign_pointer()
> in this call. Failed/unhandled nodes are left untouched.
> 
> Fixes: 15e8156713cc ("mm: shrinker: avoid memleak in alloc_shrinker_info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>   mm/shrinker.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index 7082d01c8c9d..92c6cb455fc9 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -78,6 +78,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>   {
>   	int nid, ret = 0;
>   	int array_size = 0;
> +	int failed_nid;
>   
>   	mutex_lock(&shrinker_mutex);
>   	array_size = shrinker_unit_size(shrinker_nr_max);
> @@ -98,8 +99,18 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>   	return ret;
>   
>   err:
> +	failed_nid = nid;
> +	for_each_node(nid) {
> +		struct shrinker_info *info;
> +
> +		if (nid >= failed_nid)
> +			break;
> +		info = shrinker_info_protected(memcg, nid);
> +		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, NULL);
> +		shrinker_unit_free(info, 0);
> +		kvfree(info);
> +	}
>   	mutex_unlock(&shrinker_mutex);
> -	free_shrinker_info(memcg);
>   	return -ENOMEM;
>   }
>   

