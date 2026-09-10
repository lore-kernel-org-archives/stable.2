Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2E51C5D59;
	Thu, 10 Sep 2026 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789019947; cv=none; b=oZG77bxdVyEBX7nJf1eEA2UmY81QBwFCSC2iUtzCzHgNxSGCESirqg7HzLhlQ2StmeGS51XAdzPTV35ShNG+J/m3azUegtBW0ILqGxuKD7b1J2BYvNKwGsva6VXg+xEap9nFdjdGln2HIMMZYWr3hKmuzf9NF7iz+ntbXnyh56I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789019947; c=relaxed/simple;
	bh=UYklCB0vOsedLPk8gbIcfZRFc4+bCVWDxvOA6gvPHz8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Rvg8jNa792pz4/Afn5vQez9YxQS+geqXcgajcMPo7+nzZg/N32+XVifYWR8DF6VY17t9lISxtfy8HoZus22R9S9Jp4bKvn15Hgw016OuPnovAlwfk83d7sis/Wh6MRX+tJqnRTOfBeY2oHQIdA5v35x6H8yCZFS5wOAr1HYrZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=r+b243BF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="r+b243BF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7891F000FF;
	Thu, 10 Sep 2026 05:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789019945;
	bh=6+W848YAGgId+r0hutVeqFh0OVKi+g9bP4xQ6R+kF14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=r+b243BFAi1hYjM3C5FSUaRF87pjCI3Jp7Gy16gGEtlDLB+qr6pI76jTdWFOtd9nV
	 zkzmtHr+WvIyIfodL4jckPUVjGIkNxEyFRj+Smk+lt5tFZjU5I+Dq4DFaIhIbXOau+
	 yDBPitQAj0zIg9oKLCDEAfYVZtHGv0mwIfk8RdxY=
Date: Wed, 9 Sep 2026 22:59:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: bingfangguo@tencent.com
Cc: Bingfang Guo via B4 Relay <devnull+bingfangguo.tencent.com@kernel.org>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Kemeng Shi
 <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He
 <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, Youngjun Park
 <youngjun.park@lge.com>, Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt
 <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Johannes
 Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, Michal
 Hocko <mhocko@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Bingfang Guo
 <bfguo@icloud.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v5] mm/memcg: clear folio memcg after changing per memcg
 stats
Message-Id: <20260909225904.6d60c722ba21f26e18c98767@linux-foundation.org>
In-Reply-To: <20260910-memcg-swapcache-stats-fix-v5-1-033f510ba748@tencent.com>
References: <20260910-memcg-swapcache-stats-fix-v5-1-033f510ba748@tencent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 11:46:58 +0800 Bingfang Guo via B4 Relay <devnull+bingfangguo.tencent.com@kernel.org> wrote:

> I notice extremely high swapcached count in the per memcg level
> memory.stat when running tests with cgroupv1 setup by swapping pages in
> and out.  It seems that the counter never gets decreased so the value is
> rather useless and confusing to users reading it. So I think fixing it
> so that the value can reflect the actual swapcache usage correctly could
> be helpful.
> 
> __memcg1_swapout() transfers the memsw charge of a folio to its swap
> entry and clears folio->memcg_data as part of that.  In the vmscan
> swapout path it runs before __swap_cache_del_folio(), which then
> decrements the swapcache stats through lruvec_stat_mod_folio().  Since
> folio->memcg_data has already been cleared, folio_memcg() returns NULL
> and the NR_SWAPCACHE decrement only updates the node-level counter
> instead of the memcg's lruvec, leaking the per-memcg swapcache count.
> 
> Move the __memcg1_swapout() call into __swap_cache_del_folio(), after
> the NR_FILE_PAGES and NR_SWAPCACHE updates but before
> __swap_cache_do_del_folio() removes the folio from the swap cache.  This
> keeps the stats attributed to the folio's memcg while still recording
> the swap cgroup with a valid folio->swap.  Add a swapout parameter so
> the plain swap_cache_del_folio() path is left unchanged.

Thanks.

> Fixes: 2732acda82c9 ("mm, swap: use swap cache as the swap in synchronize layer")

January this year.

How does this affect users?  Should we backport the fix into earlier
kernels?  If so, why?

