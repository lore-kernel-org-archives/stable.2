Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8B52FC876;
	Tue,  1 Sep 2026 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261876; cv=none; b=KH4tp9yZbXqxUXNya6z7zCLYCC+7yv1lO44MJ4CWn5L0/vPim928nF5WH5IESwV62zJ/H8eX+sYo9Nmlg6J1cZCp4UQpEQxN3WFGu7kez7GS+IDceHBxotDJ2F6Hut/f9w15nr8Q8NxKQQX8EDYOx9lk4GnoGT9igmNRoaWi8ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261876; c=relaxed/simple;
	bh=6A74c6VeFiGCcRUJXPOiiloHoNuVTWCrnP59el5AHIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D2sUKvRcfsdf+hNf/mQXZgUNm3dyGVWW4GMIgttM0+r0bJNgJFuA6z6teNF87ykOT/ewgSO24UEF6gz4b/42W0wS/xkrdcNUjTjUApAVUrzie9/tAbCsAejapkZnZKOMXdMUEOA9RvYLKXiccfo4q+EcwDoyYPT+PZ4RFfaQGYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Fahymril; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Fahymril"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788261870; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=E3VURlQpvCj0IFlfDMpwATe4ShsH6UZzlqTrim1jfqQ=;
	b=FahymrilpzSI1AUpye2VtepI1PGqGi494INZmVf1EuBaKve/DFgEHQzif/iUfUg1fq3ZGHWmj1JFVbzzYLM2EXqTOYkxb5EWlJg8zsXAMnsiX6tGLkJ3Y3wDIzkFNqWHjp7OTYnOGocIEyWfE7dgTV4fQ9wIeJ6RjkT5V9K2T90=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=ying.huang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0XA7CcCs_1788261862;
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0XA7CcCs_1788261862 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 19:24:28 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  kernel-team@meta.com,  akpm@linux-foundation.org,  david@kernel.org,
  ziy@nvidia.com,  matthew.brost@intel.com,  joshua.hahnjy@gmail.com,
  rakie.kim@sk.com,  byungchul@sk.com,  apopple@nvidia.com,
  urezki@gmail.com,  chenwandun@huawei.com,  Chelsy Ratnawat
 <chelsyratnawat2001@gmail.com>,  stable@vger.kernel.org
Subject: Re: [PATCH] mm/mempolicy: take a cpuset cookie for the interleave
 node count
In-Reply-To: <20260828193111.1023497-1-gourry@gourry.net> (Gregory Price's
	message of "Fri, 28 Aug 2026 15:31:11 -0400")
References: <20260828193111.1023497-1-gourry@gourry.net>
Date: Tue, 01 Sep 2026 19:24:21 +0800
Message-ID: <877bl5qknu.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> alloc_pages_bulk_interleave() counts pol->nodes without a cpuset cookie:
>
> 	nodes = nodes_weight(pol->nodes);
> 	nr_pages_per_node = nr_pages / nodes;
>
> nodemask_t spans several words once MAX_NUMNODES exceeds BITS_PER_LONG, so
> a concurrent cpuset rebind can tear that read and yield an empty mask even
> though neither version of it was empty.  The call then allocates nothing
> and returns 0.
>
> Some compilers will hoist the loop entry test above the division,
> because nr_pages_per_node is dead when the loop does not run.
>
> 	682e:	call	...		<- nodes_weight()
> 	6838:	test	%eax,%eax
> 	683a:	jle	692d		<- nodes <= 0 skips the loop
> 	684a:	div	%rcx
>
> So in most deployments, this div/0 is unreachable - but nothing in the
> source guarantees that, it's just not easily exercised.
>
> Take the cookie around the count and bail if the mask really is empty.
> Only the count needs it, interleave_nodes() takes the cookie itself so
> so a torn read there is already retried.
>
> A rebind landing mid-loop can still leave the count disagreeing with the
> mask, so the loop may revisit a node or skip one - but a rebind where
> nodes change causes migration, so a handful of misplaced pages isn't
> catastrophic in any sense.
>
> Measured on a 72 node VM (NODES_SHIFT=10) with a cgroup v2 cpuset flipping
> cpuset.mems between a word 0 and a word 1 node set, and the two word read
> artificially widened: 330 zero counts in 130414 calls without the cookie,
> and 401 retries with it.
>
> Reported-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
> Link: https://lore.kernel.org/all/20250907160829.91628-1-chelsyratnawat2001@gmail.com/
> Fixes: c00b6b961099 ("mm/vmalloc: introduce alloc_pages_bulk_array_mempolicy to accelerate memory allocation")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  mm/mempolicy.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 79053ece02cd..060a0eb26917 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2592,6 +2592,7 @@ static unsigned long alloc_pages_bulk_interleave(gfp_t gfp,
>  		struct mempolicy *pol, unsigned long nr_pages,
>  		struct page **page_array)
>  {
> +	unsigned int cpuset_mems_cookie;
>  	int nodes;
>  	unsigned long nr_pages_per_node;
>  	int delta;
> @@ -2599,7 +2600,16 @@ static unsigned long alloc_pages_bulk_interleave(gfp_t gfp,
>  	unsigned long nr_allocated;
>  	unsigned long total_allocated = 0;
>  
> -	nodes = nodes_weight(pol->nodes);
> +	/* count the nodes, retry if a rebind happened during the read */
> +	do {
> +		cpuset_mems_cookie = read_mems_allowed_begin();
> +		nodes = nodes_weight(pol->nodes);
> +	} while (read_mems_allowed_retry(cpuset_mems_cookie));
> +
> +	/* if the nodemask has become invalid, we cannot do anything */
> +	if (!nodes)
> +		return 0;
> +
>  	nr_pages_per_node = nr_pages / nodes;
>  	delta = nr_pages - nodes * nr_pages_per_node;

LGTM, feel free to add my

Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>

in the future version.

---
Best Regards,
Huang, Ying
