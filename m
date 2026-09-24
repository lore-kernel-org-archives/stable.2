Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FBF2D8DBB;
	Thu, 24 Sep 2026 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242586; cv=none; b=lIVwrLmf6BIqahlrtEVTj1h0MN35q5qXdlV8RX0Em17wKgW+/4WtqPRqShHzKTjohgZFidTqBRBHgnvG0DQbzJhLOXBruYfcKKKdfPyGh9M7t7JE/laCU72rEhJCHFkIdYQkDe+PW6qMDpZo+2kI6PSO1kfYm8LV4uBjHMov0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242586; c=relaxed/simple;
	bh=i3pt1H9qNRC/nyv8uVo4NsVAFMXIpMQd9zhfUIBZLK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ssksYsnKST1BZE5mjMvolPGt1kUADDs4UN7Wht0uGhvdvwr3/3YjfP0f6XubOnJICBDtEB5DeDygERe9vYBX1neYj5er6juHQtyPGcQteLIFs4GQr1+yM/fh8vxkZul3l3nnqey9wOLIlqH0ctPXweM9VJbIEnMC6n2jKBc2B4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i62KZs0V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i62KZs0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C551F000FF;
	Thu, 24 Sep 2026 09:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790242584;
	bh=ZiYfP3OJ/9LAMpeByACJ22Dt1rNk0pU/miAnrdFKvlc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=i62KZs0VBwe+7WBncDD2NIaGeytnxoCGW4Vafmq0m9+p38DyxbtEY9F5+z7w8RKUI
	 at2jPMAUdLGsOUedUT/Qs/GhkYLvX5xwWmLR4E093NhOY2B5AsPmLMTIYd0n1b3eLE
	 jhIHPNz/x+Rp64R6tyhnplcsec22FnQ4SrGhtQLsrwH0+Cm/NeU3z9pg0VBt9ToLhj
	 Q7Zrc9xaStAscYiuWDpsqw2oUJ1Li0YUXbw7+rGS3g7rIksABijDxpbfG4K9ZwVYCC
	 Z7i6jmG/FLBm6CXdF95+gRQYlDQL6tw6t5Wz5xcqudIbdlZZ1BYUfP78+H/98o7l4l
	 QLY5FdGww5brQ==
Message-ID: <0d798541-6486-44ff-ae57-f631d1465688@kernel.org>
Date: Thu, 24 Sep 2026 11:36:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] netfs: Fix missing alloc tagging of direct mempool
 allocations
Content-Language: en-US
To: Hao Ge <hao.ge@linux.dev>, David Howells <dhowells@redhat.com>,
 Paulo Alcantara <pc@manguebit.org>, Harry Yoo <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "Christian Brauner (Amutable)" <brauner@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Christoph Hellwig <hch@infradead.org>
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Erhard Furtner <erhard_f@mailbox.org>, stable@vger.kernel.org
References: <20260923063759.34667-1-hao.ge@linux.dev>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260923063759.34667-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+Cc Christoph

On 9/23/26 08:37, Hao Ge wrote:
> Commit 1d78d56c43ef ("netfs: Fix folio_queue ENOMEM in writeback by
> adding a mempool") added a mempool for the folio_queues and made the
> request, subrequest and folio_queue allocations distinguish between
> writeback and everything else.  Writeback is part of memory reclaim
> and must not fail due to ENOMEM, so it allocates under GFP_NOFS
> through mempool_alloc(), which may dip into the pool's reserve and,
> if that runs empty, wait for elements to be returned.  The
> GFP_KERNEL paths, which can return -ENOMEM to their callers, invoke
> the pool's ->alloc() callback directly instead.
> 
> The direct call, however, skips the alloc_hooks() wrapper that the
> mempool_alloc() macro provides.  The pool callbacks, mempool_alloc_slab()
> and mempool_kmalloc(), call kmem_cache_alloc_noprof() and kmalloc_noprof()
> and rely on current->alloc_tag having been set by the caller.  With
> CONFIG_MEM_ALLOC_PROFILING_DEBUG=y this leads to
> 
>     current->alloc_tag not set
>     WARNING: ./include/linux/alloc_tag.h:161 at __alloc_tagging_slab_alloc_hook
>     alloc_tag was not set
>     WARNING: ./include/linux/alloc_tag.h:166 at __alloc_tagging_slab_free_hook
> 
> at allocation and free time respectively, as reported when reading
> files on a CIFS mount.  The allocations are also missing from
> /proc/allocinfo.
> 
> Wrap the direct ->alloc() invocations in alloc_hooks() with a new
> mempool_alloc_noreserve() helper in include/linux/mempool.h, next to
> the other alloc_hooks()-wrapped macros such as mempool_alloc().  The
> GFP_KERNEL paths keep their failable allocation semantics, they just
> get tagged now.
> 
> Fixes: 1d78d56c43ef ("netfs: Fix folio_queue ENOMEM in writeback by adding a mempool")
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Closes: https://lore.kernel.org/all/0b004319-9ef7-437c-a4dd-174d6a9a83db@mailbox.org/
> Tested-by: Erhard Furtner <erhard_f@mailbox.org>
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Seems ok enough as a hotfix. The naming perhaps isn't ideal, we have
mempool_alloc_preallocated() already for the opposite case. Maybe
mempool_alloc_no_preallocated() to complement it? Rather long though.

I guess long-term it would be neater to have a mempool_alloc() variant with
extra parameter that says if preallocated pool is allowed or not. The "gfp
== GFP_KERNEL" check is probably not an universal one. mempool_alloc() is
actually rather aggressive in getting objects from the pool before even
attempting reclaim. Makes sense for I/O usecases but maybe not for this one?

> ---
> Changes in v2:
> - Move the alloc_hooks() wrapper from fs/netfs/internal.h into
>   include/linux/mempool.h as mempool_alloc_noreserve(), per Suren's
>   suggestion, so it is not netfs-specific.
> 
> v1 Link: https://lore.kernel.org/all/20260922023541.51532-1-hao.ge@linux.dev/
> ---
>  fs/netfs/objects.c        | 4 ++--
>  fs/netfs/rolling_buffer.c | 2 +-
>  include/linux/mempool.h   | 7 +++++++
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index 7f6a3e912602..ad549daa9c79 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -34,7 +34,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
>  
>  		rreq = mempool_alloc(mempool, gfp);
>  	} else {
> -		rreq = mempool->alloc(gfp, mempool->pool_data);
> +		rreq = mempool_alloc_noreserve(mempool, gfp);
>  		if (!rreq)
>  			return ERR_PTR(-ENOMEM);
>  	}
> @@ -214,7 +214,7 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq
>  	struct kmem_cache *cache = mempool->pool_data;
>  
>  	if (rreq->gfp == GFP_KERNEL)
> -		subreq = mempool->alloc(rreq->gfp, mempool->pool_data);
> +		subreq = mempool_alloc_noreserve(mempool, rreq->gfp);
>  	else
>  		subreq = mempool_alloc(mempool, rreq->gfp);
>  	if (!subreq)
> diff --git a/fs/netfs/rolling_buffer.c b/fs/netfs/rolling_buffer.c
> index 424e77a9a109..d30d5ef6d86e 100644
> --- a/fs/netfs/rolling_buffer.c
> +++ b/fs/netfs/rolling_buffer.c
> @@ -29,7 +29,7 @@ struct folio_queue *netfs_folioq_alloc(unsigned int rreq_id, gfp_t gfp,
>  	struct folio_queue *fq;
>  
>  	if (gfp == GFP_KERNEL)
> -		fq = netfs_folioq_pool.alloc(gfp, netfs_folioq_pool.pool_data);
> +		fq = mempool_alloc_noreserve(&netfs_folioq_pool, gfp);
>  	else
>  		fq = mempool_alloc(&netfs_folioq_pool, gfp);
>  	if (fq) {
> diff --git a/include/linux/mempool.h b/include/linux/mempool.h
> index a0fa6d43e0dc..6da502aef2f7 100644
> --- a/include/linux/mempool.h
> +++ b/include/linux/mempool.h
> @@ -70,6 +70,13 @@ int mempool_alloc_bulk_noprof(struct mempool *pool, void **elem,
>  #define mempool_alloc_bulk(...)						\
>  	alloc_hooks(mempool_alloc_bulk_noprof(__VA_ARGS__))
>  
> +/*
> + * Allocate a new element without dipping into the pool's reserves or
> + * waiting.  Returns NULL on failure.
> + */
> +#define mempool_alloc_noreserve(_pool, _gfp)				\
> +	alloc_hooks((_pool)->alloc(_gfp, (_pool)->pool_data))
> +
>  void *mempool_alloc_preallocated(struct mempool *pool) __malloc;
>  void mempool_free(void *element, struct mempool *pool);
>  unsigned int mempool_free_bulk(struct mempool *pool, void **elem,

