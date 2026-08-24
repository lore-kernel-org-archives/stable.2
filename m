Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C953D30C606;
	Mon, 24 Aug 2026 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787540777; cv=none; b=cnjubj6BpUwXwMpI/riPyGylME8v+XBcb9qNkecrqn7+ZLK+ixddK+3LGbo5VDEcJq3OXFDcDoqu1+ULqPz8JrviBbIvk0Tpp+4A7S8u+pI7lKFufi/r/U4L0dGU40d1tL2/xAsk6Gx9q5COQzj9YBYBHmJGbLJMQaoA6Cvui/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787540777; c=relaxed/simple;
	bh=IZ7CbRaH/RF9xVtpPuCBPpN+HgjMfV5xAq9Jy1OMS9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtP3HuDSpsYgXlctLBwsGqbVQmTq3VSQEVGO74rilRf2fzdP2h97P97nKV5+KBXs5qCy8yloUiFpaWlrJ3ZtIGO0djQwPVgOUbSze+uXffz+k7JlrP4X7PP5WjM4CjsDgDYWDXE/WRyb9XJSYFF6/lymJ3Zj86U724dMvOYnflM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AeW14FV0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AeW14FV0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X0RTeEPPkTUJwAhiSHeNNGSJtMypaSRst3/83QMi1Dk=; b=AeW14FV0pgandiUG8boMQJRZgN
	EPCw6yOxDJzGLA1rJCA/w4NwUKKN6YG0+UoMewkfLhX8Y/dQclE0U9YLbmNq4DpVp+OCxGn0630X7
	ERMYRdyMNW1NgTowHL2yUsLEf/zisUPcL8sJ7XPO7kdi4lvEmTTQ12T/Lfk5Fre1blEXjWWh9uNzt
	Y4YOI3q+aAz5YeGba6MJXcyPCBXhQC7S2rn2quLoh117+WJl3VR/SZOVfzPqntchz1t0Pui72hJ8E
	b0R+NPODtuOnXn0YrHCXL5iBrJnMsVU9QZ/+FDdfPyEzy4JjupA5I7wXLntsO7peH/6Z0ULQxnl6h
	YSwvTsxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyL0e-000000059Vk-0XNn;
	Mon, 24 Aug 2026 03:06:04 +0000
Date: Mon, 24 Aug 2026 04:06:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, edumazet@google.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org, david@kernel.org, ziy@nvidia.com,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	syzbot+0dbf6d295b3350944f0b@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/mempolicy: refcount the weighted interleave state
 instead of copying it
Message-ID: <aou1Gwxk2s8Qjdm9@casper.infradead.org>
References: <20260821104043.f692421fec915c0c5bc1fbe6@linux-foundation.org>
 <20260824024117.1755899-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824024117.1755899-1-gourry@gourry.net>

On Sun, Aug 23, 2026 at 10:41:17PM -0400, Gregory Price wrote:
> @@ -2632,7 +2654,7 @@ static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
>  	unsigned long nr_allocated = 0;
>  	unsigned long rounds;
>  	unsigned long node_pages, delta;
> -	u8 *weights, weight;
> +	u8 *table, weight;
>  	unsigned int weight_total = 0;
>  	unsigned long rem_pages = nr_pages;
>  	nodemask_t nodes;
> @@ -2676,25 +2698,12 @@ static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
>  	me->il_weight = 0;
>  	prev_node = node;
>  
> -	/* create a local copy of node weights to operate on outside rcu */
> -	weights = kzalloc(nr_node_ids, GFP_KERNEL);
> -	if (!weights)
> -		return total_allocated;
> -
> -	rcu_read_lock();
> -	state = rcu_dereference(wi_state);
> -	if (state) {
> -		memcpy(weights, state->iw_table, nr_node_ids * sizeof(u8));
> -		rcu_read_unlock();
> -	} else {
> -		rcu_read_unlock();
> -		for (i = 0; i < nr_node_ids; i++)
> -			weights[i] = 1;
> -	}
> +	state = wi_state_get();
> +	table = state ? state->iw_table : NULL;
>  
>  	/* calculate total, detect system default usage */
>  	for_each_node_mask(node, nodes)
> -		weight_total += weights[node];
> +		weight_total += table ? table[node] : 1;
>  
>  	/*
>  	 * Calculate rounds/partial rounds to minimize __alloc_pages_bulk calls.
> @@ -2706,10 +2715,10 @@ static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
>  	rounds = rem_pages / weight_total;
>  	delta = rem_pages % weight_total;
>  	resume_node = next_node_in(prev_node, nodes);
> -	resume_weight = weights[resume_node];
> +	resume_weight = table ? table[resume_node] : 1;
>  	for (i = 0; i < nnodes; i++) {
>  		node = next_node_in(prev_node, nodes);
> -		weight = weights[node];
> +		weight = table ? table[node] : 1;
>  		node_pages = weight * rounds;
>  		/* If a delta exists, add this node's portion of the delta */
>  		if (delta > weight) {
> @@ -2735,7 +2744,7 @@ static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
>  	}
>  	me->il_prev = resume_node;
>  	me->il_weight = resume_weight;
> -	kfree(weights);
> +	wi_state_put(state);
>  	return total_allocated;
>  }
>  

Bit of a shame to take/put a refcount on every memory allocation.  That
seems like it might hurt (even being on a different cacheline).  Would
it make more sense to use SRCU for this?
