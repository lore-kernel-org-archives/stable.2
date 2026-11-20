Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795167820;
	b=SNFZCMAiXUAQ1pe3Fpiwcwvn+URMr5Uj3hp8Mvd4AKMwqHaN20at2qpwOZiKAaUa32AK
	 91gPwY4tXbWftTbRP9OKFJx9xZ29ysewYuQl11Z9DphVTsxUSPv7Hk6hDAUdnrnJi4maW
	 IHxI8Q5LIAPO35dU+Abs2+6se95oKSZ6X8WtGckEJiPPDfmDuwHuL8AzjR5G2I3ePAG17
	 MaSdyqyWSRfOEKfrstNRkqebtuAdS9JlHu5V/Hidva3Nhc0a8rG4PCMjr8NLuOLqtLRxu
	 upm2g0W680cC/hWIQfs0720WmY3mFWYhHYxK5WzFjx47jomWg7dXuvfjggDFI5G9ZcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167820;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Qlfw+YFO8Fcqd/R/TLbVoZ8wEQDahQw+YuIYfUUVuLo=;
	b=pA8TviTS1ZY0IqYkVRQp7CKLsHssA8dkP4a4SGi4MCE7br4LxVna+LSkGd0RRAeYyLtb
	 k4kvbtEGXApNeOaXFhAP6RqkO7P1wyqIhrn89/97neJSMjFcLhhB5w6hMztytPGjHoBy0
	 YxqKGpvqJlEER33lU4oZ8Eh+kkXfUDQkZkNquV547s4wdrfao+K7M7BoSAL5eOaLlYw8d
	 amjBI7eAENQvTx49KnHFfG5YlSvi1bSITKrh9Jkxyom0HNge6jfwuhlYHleXSWOG4jiXu
	 vOt8cHfwdBXvh1Dx/GJNkZRbJUFZApNpgM2C/aMlr3YMEfwmLFY+Zph3fOaQCPtyizA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nncHUcjB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357E3606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nncHUcjB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844A81F000C6;
	Fri, 20 Nov 2026 09:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795167819;
	bh=Qlfw+YFO8Fcqd/R/TLbVoZ8wEQDahQw+YuIYfUUVuLo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nncHUcjBgmpD1DKqjmAcOWkRe41fcqP2np+f9QsbJveew29CxwLnHYzCBcsdELbaF
	 YmMSbo88Ox7laHamdewokZHNVmveRYiWLtkKqeGdOHq4GgijDacrv7jzRecP8TUTtv
	 swqtvjXCyjJRlDf4XB+deqSI79qhuv9dIk+frTHmur7msNli7QEKv0iVJdViSOS5At
	 Z+sKkWEJ/GlcNRO3S0UUOt1bcWNLw1Bp+uVevIvQiwcdy4fT3aTWetriyfflwaOngf
	 nxsSo++xl1C0h3xkCadQ+WPez4U9ExIszkL/Ox0+VAVwJgHmsjzQGGhHQBaDrsWrMp
	 mjiyd+lCL7uZg==
Message-ID: <15168363-7171-4b3d-9b6c-a621b7700aee@kernel.org>
Date: Fri, 20 Nov 2026 10:43:35 +0100
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
Subject: Re: [PATCH 7.3.y] mm/slub: refill prefilled sheaves from the barn
To: Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org,
 david@kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Hao Li <hao.li@linux.dev>,
 Harry Yoo <harry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
References: <20261120030833.3188636-1-surenb@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261120030833.3188636-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/26 04:08, Suren Baghdasaryan wrote:
> From: Hao Li <hao.li@linux.dev>
> 
> commit 1b87ea06a34b213e45e3e0c4effd5043f15046ed upstream.
> 
> Currently, when the prefill API refills a non-full sheaf, it takes the
> objects from partial slabs and never from the full sheaves in the barn,
> so once the barn's full list becomes saturated, it stays saturated.
> 
> For objects freed via kfree_rcu(), every RCU sheaf then has to be
> flushed to slabs because the barn's full list has no room.
> 
> To fix this, let the sheaf refill from the barn first, and introduce a
> partial sheaf in the barn, which holds the leftover objects [1].
> 
> Only the prefill path needs the partial sheaf. The generic allocation
> path (__pcs_replace_empty_main()) exchanges an empty sheaf for a full
> one from the barn, so nothing is left over. The prefill path refills a
> sheaf that is not necessarily empty, so taking objects from the barn
> usually leaves leftovers, and the partial sheaf is where they are
> kept. refill_sheaf() only takes objects from partial slabs and never
> involves the partial sheaf.
> 
> The sheaf is refilled by copying objects from the partial sheaf, and
> then from a full sheaf taken from the barn if it is still not full. A
> sheaf that objects were copied from stays in the barn as the partial
> sheaf if it still holds objects, or goes on the empty list if it is
> empty. The sheaf being refilled is never replaced.
> 
> The gain comes from two sides: every full sheaf taken out makes room on
> the barn's full list for a future RCU sheaf, and refilling from the
> barn is cheaper than refilling from partial slabs under list_lock.
> 
> Note that putting the sheaf with the leftover objects on the full list
> instead would not work: it would occupy room on the full list, so the
> list would stay saturated and rcu_free_sheaf() would still keep
> flushing.
> 
> An earlier version of this patch swapped sheaves instead, to minimize
> the memcpy overhead. As Harry Yoo pointed out [2], replacing the
> caller's sheaf loses cache affinity, filling it directly is more
> straightforward, and testing showed no measurable difference between
> the two approaches, so the approach he suggested is used.
> 
> Tested with will-it-scale mmap1 (192 processes, one-minute runs) on the
> maple_node cache.
> 
> throughput: 27778727 -> 34500556 (+24.2%)
> 
> metric                       baseline           patched        change
> =====================================================================
> alloc_fastpath                 54,124            56,696        +4.75%
> alloc_slab                  7,100,651           159,739       -97.75%
> barn_get                          849       194,460,392    +22904539.81%
> barn_get_fail                       2               217    +10750.00%
> barn_put                          851       182,306,701    +21422544.07%
> barn_put_fail             260,400,484       145,522,675       -44.12%
> cmpxchg_double_fail         1,029,204           334,228       -67.53%
> free_add_partial          326,694,687       181,935,790       -44.31%
> free_fastpath                  13,297            15,611       +17.40%
> free_rcu_sheaf          8,332,839,104    10,490,535,227       +25.89%
> free_remove_partial         7,099,788           158,297       -97.77%
> free_slab                   7,099,788           158,297       -97.77%
> free_slowpath              10,969,156           782,851       -92.86%
> objects                        15,295            14,849        -2.92%
> objects_partial                15,295            14,849        -2.92%
> partial                         1,604             2,336       +45.64%
> sheaf_alloc               137,757,895       141,208,076        +2.50%
> sheaf_flush             8,332,823,922     4,656,725,764       -44.12%
> sheaf_free                137,757,883       141,208,072        +2.50%
> sheaf_prefill_fast      3,337,502,163     4,196,506,116       +25.74%
> sheaf_prefill_slow                685               400       -41.61%
> sheaf_refill            8,343,794,364     4,657,509,724       -44.18%
> sheaf_return_fast       3,337,502,411     4,196,506,382       +25.74%
> sheaf_return_slow                 437               134       -69.34%
> slabs                           1,604             2,336       +45.64%
> total_objects                 102,656           149,504       +45.64%
> 
> Here is what the important metric changes mean.
> 
> barn_get and barn_put: refills now take full sheaves out of the barn,
> and RCU sheaves are put into the barn again. Before, the barn's full
> list was saturated once and hardly ever consumed.
> 
> barn_put_fail: more than half of the RCU sheaves are now put into the
> barn instead of being flushed. The rest are still flushed because they
> arrive while the barn's full list is at its limit.
> 
> sheaf_refill and free_add_partial: fewer objects are taken from partial
> slabs to refill sheaves, and fewer slabs are added to the partial list,
> by the same percentage.
> 
> alloc_slab and free_slab: the partial list is almost never empty when a
> refill looks at it, so slabs are almost never allocated and freed again
> only to serve refills.
> 
> After the test, the maple_node cache holds 1604 slabs without the patch
> and 2336 with it. After a manual shrink
> (echo 1 > /sys/kernel/slab/maple_node/shrink), it holds 485 without
> the patch and 563 with it. So most of the extra slabs are held only by
> objects sitting in sheaves and are returned by a shrink, and what
> remains is a small difference, because objects handed out from the barn
> come from many more slabs than a refill from partial slabs would use.
> 
> Link: https://lore.kernel.org/linux-mm/aqPlMzUIw-4g2iOX@fedora/ [1]
> Link: https://lore.kernel.org/linux-mm/aq0ylDidEHa2kg4X@thinkstation/ [2]
> Signed-off-by: Hao Li <hao.li@linux.dev>
> Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
> Link: https://patch.msgid.link/20260921094521.141665-1-hao.li@linux.dev
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> Original patch from v7.4-rc1 applies cleanly over stable 7.3.y.
> 
> In v7.0-rc1, per-CPU slabs and per-CPU partial lists were removed (see:
> 17c38c88294d, e323b52cf00f, 32c894c7274b). Therefore once barn->nr_full
> hits MAX_FULL_SHEAVES, every refill_sheaf() and sheaf_flush_unused()
> will compete for the node-wide n->list_lock. This patch fixes this.
> 
> In pre-7.0 kernels per-CPU slabs and per-CPU partial lists are still
> there and refills use per-CPU c->freelist and per-CPU partial slabs
> without taking n->list_lock. Similarly, do_slab_free() recycles freed
> slabs through per-CPU c->slab and c->partial without taking n->list_lock.
> Therefore this patch has no performance benefit on those older branches.

IOW we want to avoid a regression from 6.18 LTS to 7.3 LTS.
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> 
>  mm/slub.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 544cff39762c..a0f0bdc1e30a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -422,6 +422,7 @@ struct node_barn {
>  	spinlock_t lock;
>  	struct list_head sheaves_full;
>  	struct list_head sheaves_empty;
> +	struct slab_sheaf *sheaf_partial;
>  	unsigned int nr_full;
>  	unsigned int nr_empty;
>  };
> @@ -3298,6 +3299,7 @@ static void barn_init(struct node_barn *barn)
>  	spin_lock_init(&barn->lock);
>  	INIT_LIST_HEAD(&barn->sheaves_full);
>  	INIT_LIST_HEAD(&barn->sheaves_empty);
> +	barn->sheaf_partial = NULL;
>  	barn->nr_full = 0;
>  	barn->nr_empty = 0;
>  }
> @@ -3315,6 +3317,10 @@ static void barn_shrink(struct kmem_cache *s, struct node_barn *barn)
>  	barn->nr_full = 0;
>  	list_splice_init(&barn->sheaves_empty, &empty_list);
>  	barn->nr_empty = 0;
> +	if (barn->sheaf_partial) {
> +		list_add(&barn->sheaf_partial->barn_list, &full_list);
> +		barn->sheaf_partial = NULL;
> +	}
>  
>  	spin_unlock_irqrestore(&barn->lock, flags);
>  
> @@ -5073,12 +5079,87 @@ void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t gfpflags, int nod
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_node_noprof);
>  
> +/*
> + * Refill @sheaf from the barn: from its partial sheaf first, then from its full
> + * sheaves. A sheaf that objects were copied from stays in the barn as the
> + * partial sheaf if it still holds objects, or goes on the empty list if it is
> + * empty.
> + *
> + * Returns true if the sheaf is now full, at s->sheaf_capacity.
> + * Returns false if the sheaf is still not full.
> + */
> +static bool refill_sheaf_from_barn(struct kmem_cache *s,
> +				   struct slab_sheaf *sheaf)
> +{
> +	struct node_barn *barn = get_barn(s);
> +	struct slab_sheaf *src;
> +	unsigned int to_move;
> +	unsigned long flags;
> +
> +	if (!barn)
> +		return false;
> +
> +	if (!data_race(barn->nr_full) && !data_race(barn->sheaf_partial))
> +		return false;
> +
> +	spin_lock_irqsave(&barn->lock, flags);
> +
> +	/*
> +	 * The partial sheaf can hold fewer objects than @sheaf needs to
> +	 * reach capacity, and a sheaf on the full list is not necessarily
> +	 * full (see the comment in rcu_free_sheaf()), so keep taking from
> +	 * the barn until @sheaf is full or nothing is left.
> +	 */
> +	while (sheaf->size < s->sheaf_capacity) {
> +		src = barn->sheaf_partial;
> +		barn->sheaf_partial = NULL;
> +		if (!src) {
> +			if (!barn->nr_full)
> +				break;
> +			src = list_first_entry(&barn->sheaves_full,
> +					       struct slab_sheaf, barn_list);
> +			list_del(&src->barn_list);
> +			barn->nr_full--;
> +		}
> +
> +		to_move = min(s->sheaf_capacity - sheaf->size, src->size);
> +		src->size -= to_move;
> +		memcpy(&sheaf->objects[sheaf->size], &src->objects[src->size],
> +		       to_move * sizeof(void *));
> +		sheaf->size += to_move;
> +
> +		if (src->size) {
> +			barn->sheaf_partial = src;
> +		} else {
> +			/*
> +			 * No empty-limit check: the sheaf put on the empty list
> +			 * was already in the barn, so the barn holds no more
> +			 * sheaves than before. barn_replace_empty_sheaf() skips
> +			 * the check for the same reason.
> +			 */
> +			list_add(&src->barn_list, &barn->sheaves_empty);
> +			barn->nr_empty++;
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&barn->lock, flags);
> +
> +	if (sheaf->size < s->sheaf_capacity)
> +		return false;
> +
> +	stat(s, BARN_GET);
> +	return true;
> +}
> +
>  static int __prefill_sheaf_pfmemalloc(struct kmem_cache *s,
>  				      struct slab_sheaf *sheaf, gfp_t gfp)
>  {
>  	gfp_t gfp_nomemalloc;
>  	int ret;
>  
> +	if (refill_sheaf_from_barn(s, sheaf))
> +		return 0;
> +
>  	gfp_nomemalloc = gfp | __GFP_NOMEMALLOC;
>  	if (gfp_pfmemalloc_allowed(gfp))
>  		gfp_nomemalloc |= __GFP_NOWARN;

