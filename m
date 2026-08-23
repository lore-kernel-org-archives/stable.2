Received: from mta0.migadu.com (out-52.mta0.migadu.com [91.218.175.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F92F7F0F
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787484395; cv=none; b=c2Qj25Ci4yg0YffNH08hoGR+mRMSyEAcQs8m+1LttIZRNLo2+dqQAtAwDXLNMW7GnVKT7LYkk7fdoT2Fza+FLCE4/v8L9veGCEZWPDBF48lKnbC86osVegEFrf8AqYIvUaPs0Mx/wEiJ/MAit1qmVb9fWGGHBt3vmg9oWPUHii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787484395; c=relaxed/simple;
	bh=Tw2LOhOowIoe43nOm6vPWnRsHc7+hewPX1zrEPV9DfA=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:To:From:
	 In-Reply-To:Content-Type; b=oHQwa4INFhjqgVnYHORW9NUzwdRTyUZKZfhcv9/WhcISqov8MmJ93SFhjAydBZuvJOiDR65srJDPizOHWAgDFOWDDddZcoXVQEk6mAiS8Db3Fj4AaK1rMMxteRPQFpo67vn1TtpLClH2ka0JNstzmSf6gGO9Y/Bt/qVW1nPMmcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wXYcEdfe; arc=none smtp.client-ip=91.218.175.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wXYcEdfe"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Tw2LOhOowIoe43nOm6vPWnRsHc7+hewPX1zrEPV9DfA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787484390; v=1; x=1788089190;
 b=wXYcEdfeJVzPui5frmxYUPULqBOsGszkmgQ+zjX8lxOjbhVK8LsAlZsJ1yKl/AzZEV39/0JO
 63QLSTDtq9XM6JDlgU7k3oMdwCO9YVm6B+8TKNaa18xSNmCBP+CT6y7HupfeKkmiWk17xEe5vod
 +aTMpgatJ/FURPk3mToswSKQ=
X-Envelope-To: stable@vger.kernel.org
Received: from [IPV6:2409:8a55:34b0:5134:4e:83f5:e428:cd05] (2409:8a55:34b0:5134:4e:83f5:e428:cd05)
	by smtp.migadu.com with ESMTPS id d9b0bbb8218ea753;
	Sun, 23 Aug 2026 11:26:30 +0000
X-Mizu-Trace-ID: d9b0bbb8218ea753
X-Migadu-Flow: FLOW_OUT
Message-ID: <e77a6b10-0358-4ba7-9b80-c795fc7cac93@linux.dev>
Date: Sun, 23 Aug 2026 19:26:06 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mglru: fix ineffective memory protection for
 non-kswapd reclaim
Cc: Ridong Chen <chenridong@xiaomi.com>, stable@vger.kernel.org
References: <20260823112313.189468-1-ridong.chen@linux.dev>
Content-Language: en-US
To: stable@vger.kernel.org
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260823112313.189468-1-ridong.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/23/2026 7:22 PM, Ridong Chen wrote:
> From: Ridong Chen <chenridong@xiaomi.com>
> 
> memory.min/low is silently bypassed for MGLRU during global proactive
> reclaim (writing to the root memory.reclaim) and global direct reclaim.
> It can be reproduced as follows:
> 
>   # echo 7 > /sys/kernel/mm/lru_gen/enabled
>   # cd /sys/fs/cgroup
>   # mkdir -p a/b
>   # echo 100M > a/memory.min
>   # echo +memory > a/cgroup.subtree_control
>   # echo 100M > a/b/memory.min
>   # echo $$ > a/b/cgroup.procs
>   # dd if=/dev/zero of=/tmp/testfile bs=1M count=200
>   # cat a/b/memory.current
>   222650368
>   # echo 500M > memory.reclaim
>   -bash: echo: write error: Resource temporarily unavailable
>   # cat a/b/memory.current
>   6070272
> 
> memory.min is 100M, yet reclaim drops a/b down to 6M, breaking the
> protection.  The traditional LRU path is not affected because
> shrink_node() calls mem_cgroup_calculate_protection() for each memcg it
> visits during a top-down tree walk.
> 
> Commit 30d77b7eef01 ("mm/mglru: fix ineffective protection calculation")
> moved the protection computation into lru_gen_age_node(), which only
> runs for kswapd.  Non-kswapd global reclaim reaches shrink_one() through
> lru_gen_shrink_node() -> shrink_many() without any protection
> computation, so emin/elow remain stale or zero.
> 
> Introduce mem_cgroup_protection_path() which computes emin/elow along
> the root-to-target path only by iterating through the cgroup ancestors
> array top-down.  This avoids the full tree traversal that would be
> needed with mem_cgroup_calculate_protection(), limiting the cost to
> O(depth) per memcg - typically 3-5 levels.
> 
> Call it from shrink_one() for the non-kswapd path so that each memcg
> about to be shrunk has correct protection values.
> 
> Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> ---
>  include/linux/memcontrol.h |  7 +++++++
>  mm/memcontrol.c            | 42 ++++++++++++++++++++++++++++++++++++++
>  mm/vmscan.c                |  3 +++
>  3 files changed, 52 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 8170bb8066a2..4e0dd5d98f3a 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -600,6 +600,8 @@ static inline void mem_cgroup_protection(struct mem_cgroup *root,
>  
>  void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>  				     struct mem_cgroup *memcg);
> +void mem_cgroup_protection_path(struct mem_cgroup *root,
> +				struct mem_cgroup *memcg);
>  
>  static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
>  					  struct mem_cgroup *memcg)
> @@ -1126,6 +1128,11 @@ static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>  {
>  }
>  
> +static inline void mem_cgroup_protection_path(struct mem_cgroup *root,
> +					      struct mem_cgroup *memcg)
> +{
> +}
> +
>  static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
>  					  struct mem_cgroup *memcg)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 69b37f63a307..e915176ac06b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5134,6 +5134,48 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>  	page_counter_calculate_protection(&root->memory, &memcg->memory, recursive_protection);
>  }
>  
> +/**
> + * mem_cgroup_protection_path - compute protection along root->memcg path
> + * @root: the top ancestor of the sub-tree being checked (NULL for root_mem_cgroup)
> + * @memcg: the target memory cgroup
> + *
> + * Walk the ancestor path from @root down to @memcg and compute the effective
> + * protection at each level.  This is safe for isolated queries because it
> + * ensures parents are computed before children.
> + */
> +void mem_cgroup_protection_path(struct mem_cgroup *root,
> +				struct mem_cgroup *memcg)
> +{
> +	bool recursive_protection =
> +		cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT;
> +	struct cgroup *cg;
> +	int root_level, i;
> +
> +	if (mem_cgroup_disabled())
> +		return;
> +
> +	if (!root)
> +		root = root_mem_cgroup;
> +
> +	if (memcg == root)
> +		return;
> +
> +	root_level = root->css.cgroup->level;
> +	cg = memcg->css.cgroup;
> +
> +	rcu_read_lock();
> +	for (i = root_level + 1; i <= cg->level; i++) {
> +		struct mem_cgroup *cur;
> +
> +		cur = mem_cgroup_from_css(cgroup_css(cg->ancestors[i],
> +						    &memory_cgrp_subsys));
> +		if (cur)
> +			page_counter_calculate_protection(&root->memory,
> +					&cur->memory, recursive_protection);
> +	}
> +	rcu_read_unlock();
> +}
> +
>  static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
>  			gfp_t gfp)
>  {
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4ca9775ceee8..70e28d583255 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5031,6 +5031,9 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
>  	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>  
>  	/* lru_gen_age_node() called mem_cgroup_calculate_protection() */
> +	if (!current_is_kswapd())
> +		mem_cgroup_protection_path(NULL, memcg);
> +
>  	if (mem_cgroup_below_min(NULL, memcg))
>  		return MEMCG_LRU_YOUNG;
>  

Please ignore that, it was sent in error.

-- 
Best regards,
Ridong

