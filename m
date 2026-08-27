Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEF5499F35
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851308; cv=none; b=U32sRmWYyUMNSKi+tXIavFSvuB4/gEcEa8ZiFaFFsI0K6s/R261eWSQpmfiC+n4o1XW72wCv5qHOwWogT8ZyU995z9haHkTIAd+wlxrW7P1b6hEEbOyC3S767Aw2hL5hP+qhkfND2kh2I6RcCyC3RVlCkuwnGe5vxdmqbAPzQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851308; c=relaxed/simple;
	bh=XCEdbMhBY8Had8F7rNDhT8O1l7rcC9aWSrPNsmPWThk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpcg/gsoGSvUPAmTdovBwGoP6fBIktaat6Vd6YXD0ioAH40xDNyk/+6gas8v9fN0NdDMiX2Cv8ZxqxUiVfvZUuCMsj5hTptiTq+eC7yDlkHu+rJD7kJzC52KBxTnhxLopurdgbLNjBcBnAm/3CZIrC0zMqOiv1h3/D/3qIucneY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=BlS6mpwo; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="BlS6mpwo"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-836c718715fso843107b3.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 10:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1787851304; x=1788456104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xrXvqZ4Uoqu6reOsdn9gvEt7CTtol+8nWaGWRJaprE0=;
        b=BlS6mpwo1pJcWm5qROn6z1I+0HbiihUyWICWChPXUd8Q6SHNC0AWyKgr2WbiCiToOW
         vI534WGvwI2aLtt+PT8+MK13ja4JJKoWuOAO6eM8IMVZKpzj8T6kqxdXs8vm5u7O6ogD
         g2+DLZG6c2FY/wliSsv6p+pxrWfH0R0u1q6xR18cgUNMgNOA6Par4qt0Tfhg2E38oBMj
         zP6YXnj5/uQKfwC0LNrEdo3NNRKCkUsiTMvbOJs7ik8h29yRq24n9m82L5KIIxJ8NGZh
         z/heGxv4qm5rsRKKthyctket0dGhQUpk9QxgP+5BWPU5NNp7jZYx2bvYaHFwSYKtRKuz
         7x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787851304; x=1788456104;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xrXvqZ4Uoqu6reOsdn9gvEt7CTtol+8nWaGWRJaprE0=;
        b=nMqLaXM4vNHFHkG9gTtrcvxGtL4jgdGlWGRW824+59LwZRf6P0K6hHmdsWBX7JG+iA
         M7rzo1hM47fbQzgQv9UqC03qJGfR5jtsaemOYgkTBVN+dVTadZ4a6fB43yOrGPfVwE6X
         xqTztG8z/aWHXybIYPlXZwEoYkjWgPUTdnDmQQIxbTXxdhEs+eGCU1jMuGPvEuKlCVRO
         +QcJ4oDLMvpUaENRC0UGYFoDwTVIp1WE6pnR/UaLKjCJRtgIZn5btQ9cQq7zEuqJOAsy
         FVkQmx63qULejR2w5y7GJzhgYay7ioyQ8xZ8d/5A2o6+7RSVQ6ZSMnXe+VFAYS4pBZau
         xNeg==
X-Forwarded-Encrypted: i=1; AHgh+RoxasfmgSbgHe4vCpu5g6iNCIrCEaE8XNfKa8VPj+RViu+B2tZFb0eNnfDSNBkcG7WWs23aBWM=@vger.kernel.org
X-Gm-Message-State: AFuF++mTTMa1OFCF0XJIN6zt5+hGyO2RrktjyqLYMHkijZvRaaHsEu7r
	lXOPiuqaxuXSV4uRYlphiIBODodFJfkFxlJ038PH2KeD8aSW//qNozhkHyqw9uDML/g=
X-Gm-Gg: AR+sD13AySoLetbwErN0ndt/JlfT7yvT73/yO8FZ++wolBUdiblcfNQgsdeYfnytgbc
	QR+qgB+BJaflhaEC15wcEZtjJuP7/EO9y7b5yEZumUERbyFoB0zzr1ybc3kPOe+0xf/0QPpjyHx
	v3CVmyHVdTIROfsQNadOuT1o9/zYuxQNkVb0gx1VZc3N1zmaLCKuj9XwI4HGiM4HGSkyzu/sv5O
	fn1h9IHkdhq5OeKsMXTLaa3kKcCQkxX695Te1Xndt6qxfpzzWXKMxPbJp1qOY7OWZNjQB572epU
	fdix9xGXW9cGsH/g1JDAr5oPpGdwLIhGxLtFTRjzqOSMj+6JeY2EYqvb8L1W99aKBR0RwKIL6uK
	tGsN8QBg+qW+Ur6CS+hsjYEyLCRO1DRULSVEXB2Aq0X8PY5wx/Yrcn5P0rezjgLjKo2Rk7Al1lR
	zLn9HCt3XqAQ9XIGgYixMXNC02Q3HigalrIWyGIoJTHuXtq7z1BSZyd/tcKAJg
X-Received: by 2002:a05:690c:4004:b0:85a:a905:ecf9 with SMTP id 00721157ae682-85d65ee883cmr4829107b3.2.1787851303687;
        Thu, 27 Aug 2026 10:21:43 -0700 (PDT)
Received: from localhost ([2605:8600:200:1a83:fe59:7385:2855:8588])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85b6143eee3sm13944617b3.31.2026.08.27.10.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:21:42 -0700 (PDT)
Date: Thu, 27 Aug 2026 13:21:41 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Yu Zhao <yuzhao@google.com>,
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>,
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Ridong Chen <chenridong@xiaomi.com>,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH] mm/mglru: fix ineffective memory protection for
 non-kswapd reclaim
Message-ID: <20260827172141.GF3004@cmpxchg.org>
References: <20260826133054.88529-1-ridong.chen@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826133054.88529-1-ridong.chen@linux.dev>

On Wed, Aug 26, 2026 at 09:30:54PM +0800, Ridong Chen wrote:
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

Right, because of the memcg-lru...

> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5198,6 +5198,48 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
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

Please wrap this in a #ifdef CONFIG_LRU_GEN block.
