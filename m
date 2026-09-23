Received: from mta1.migadu.com (out-22.mta1.migadu.com [95.215.58.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D8348C47
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 06:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790144378; cv=none; b=t1HBXEgsJghHykLVCMgqufl8k3YWc24gUUxV/v1fFDXCZtE02+Zj8BHC81QB05IET85409aWo9ZP8nTPFB90EBLQWEoRo6uDyXBDV6SwljbpcwzRXU7TidwYIRwFzZlk7mfJxPttLImYIHvhji3V3rjjcD8fATT9xmjMnlbZTqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790144378; c=relaxed/simple;
	bh=gqYJKjhqjhZCRUISxMKEN5mgQ/Vz+NGvnVFgRebCWRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+qvVzIR3UW4roMJobtcVh/shSl8wqMY/Emi0daKQ/Xxm3bzH7gnMjmdqXlWcES5OA4wKfqmzfhxupTw0IqR/TMKbImKFFaxirauIJwqOmUX08qGDcR7dclQwOckPVeTnpChNS0J+pxHQXABgKS3+mMLjEPsNHnscCNKtXogu24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CBggJVIH; arc=none smtp.client-ip=95.215.58.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CBggJVIH"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gqYJKjhqjhZCRUISxMKEN5mgQ/Vz+NGvnVFgRebCWRw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790144366; v=1; x=1790749166;
 b=CBggJVIHWOr6jv7jFBO29ZQfQ77opPcgBE+QoelBmBJoTl7M8HG5GeFhh5lk56iEkjM2Wjst
 IvcJNo14H0T8D5BrN1oWDy4TygKkWn4XC4bAcPi7ONsgT6sqvw4MicaT0Tt9lZfM04u6W5NZE+J
 uSuOqMXkYUOJLAY+ih784rT4=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 85859769026aedff;
	Wed, 23 Sep 2026 06:19:26 +0000
X-Mizu-Trace-ID: 85859769026aedff
X-Migadu-Flow: FLOW_OUT
Message-ID: <02a218c8-b655-4e6d-a6db-b35e178eef3d@linux.dev>
Date: Wed, 23 Sep 2026 14:20:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: Fix missing alloc tagging of direct mempool
 allocations
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>,
 "Christian Brauner (Amutable)" <brauner@kernel.org>, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Erhard Furtner <erhard_f@mailbox.org>, stable@vger.kernel.org
References: <20260922023541.51532-1-hao.ge@linux.dev>
 <CAJuCfpEFxn6peTwkE=orOuhSBchmuziYK1Xt75iwJo59rqYUQA@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpEFxn6peTwkE=orOuhSBchmuziYK1Xt75iwJo59rqYUQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Suren

Thanks for your review.

On 2026/9/23 11:06, Suren Baghdasaryan wrote:
> On Mon, Sep 21, 2026 at 7:37 PM Hao Ge <hao.ge@linux.dev> wrote:
>>
>> Commit 1d78d56c43ef ("netfs: Fix folio_queue ENOMEM in writeback by
>> adding a mempool") added a mempool for the folio_queues and made the
>> request, subrequest and folio_queue allocations distinguish between
>> writeback and everything else.  Writeback is part of memory reclaim
>> and must not fail due to ENOMEM, so it allocates under GFP_NOFS
>> through mempool_alloc(), which may dip into the pool's reserve and,
>> if that runs empty, wait for elements to be returned.  The
>> GFP_KERNEL paths, which can return -ENOMEM to their callers, invoke
>> the pool's ->alloc() callback directly instead.
>>
>> The direct call, however, skips the alloc_hooks() wrapper that the
>> mempool_alloc() macro provides.  The pool callbacks, mempool_alloc_slab()
>> and mempool_kmalloc(), call kmem_cache_alloc_noprof() and kmalloc_noprof()
>> and rely on current->alloc_tag having been set by the caller.  With
>> CONFIG_MEM_ALLOC_PROFILING_DEBUG=y this leads to
>>
>>     current->alloc_tag not set
>>     WARNING: ./include/linux/alloc_tag.h:161 at __alloc_tagging_slab_alloc_hook
>>     alloc_tag was not set
>>     WARNING: ./include/linux/alloc_tag.h:166 at __alloc_tagging_slab_free_hook
>>
>> at allocation and free time respectively, as reported when reading
>> files on a CIFS mount.  The allocations are also missing from
>> /proc/allocinfo.
>>
>> Wrap the direct ->alloc() invocations in alloc_hooks() with the new
>> netfs_mempool_alloc_noreserve() helper.  The GFP_KERNEL paths keep their
>> failable allocation semantics, they just get tagged now.
>>
>> Fixes: 1d78d56c43ef ("netfs: Fix folio_queue ENOMEM in writeback by adding a mempool")
>> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
>> Closes: https://lore.kernel.org/all/0b004319-9ef7-437c-a4dd-174d6a9a83db@mailbox.org/
>> Tested-by: Erhard Furtner <erhard_f@mailbox.org>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  fs/netfs/internal.h       | 3 +++
>>  fs/netfs/objects.c        | 4 ++--
>>  fs/netfs/rolling_buffer.c | 2 +-
>>  3 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
>> index c79c8e69d60c..08ba7f0ebff0 100644
>> --- a/fs/netfs/internal.h
>> +++ b/fs/netfs/internal.h
>> @@ -45,6 +45,9 @@ extern mempool_t netfs_request_pool;
>>  extern mempool_t netfs_subrequest_pool;
>>  extern mempool_t netfs_folioq_pool;
>>
>> +#define netfs_mempool_alloc_noreserve(_pool, _gfp)                             \
>> +       alloc_hooks((_pool)->alloc(_gfp, (_pool)->pool_data))
> 
> I think this macro should reside in include/linux/mempool.h and not be
> netfs-specific. Something like:
> 
> #define mempool_alloc_noreserve(_pool, _gfp)                             \
>        alloc_hooks((_pool)->alloc(_gfp, (_pool)->pool_data))
>

Sure. I kept it in netfs initially since we're the only ones calling ->alloc() directly today,
but it is indeed a better fit for mempool.h. 
Will fix that in v2.

Thanks
Best Regards
Hao

>> +
>>  #ifdef CONFIG_PROC_FS
>>  static inline void netfs_proc_add_rreq(struct netfs_io_request *rreq)
>>  {
>> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
>> index 7f6a3e912602..0b509c93d4af 100644
>> --- a/fs/netfs/objects.c
>> +++ b/fs/netfs/objects.c
>> @@ -34,7 +34,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
>>
>>                 rreq = mempool_alloc(mempool, gfp);
>>         } else {
>> -               rreq = mempool->alloc(gfp, mempool->pool_data);
>> +               rreq = netfs_mempool_alloc_noreserve(mempool, gfp);
>>                 if (!rreq)
>>                         return ERR_PTR(-ENOMEM);
>>         }
>> @@ -214,7 +214,7 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq
>>         struct kmem_cache *cache = mempool->pool_data;
>>
>>         if (rreq->gfp == GFP_KERNEL)
>> -               subreq = mempool->alloc(rreq->gfp, mempool->pool_data);
>> +               subreq = netfs_mempool_alloc_noreserve(mempool, rreq->gfp);
>>         else
>>                 subreq = mempool_alloc(mempool, rreq->gfp);
>>         if (!subreq)
>> diff --git a/fs/netfs/rolling_buffer.c b/fs/netfs/rolling_buffer.c
>> index 424e77a9a109..54867ceaa205 100644
>> --- a/fs/netfs/rolling_buffer.c
>> +++ b/fs/netfs/rolling_buffer.c
>> @@ -29,7 +29,7 @@ struct folio_queue *netfs_folioq_alloc(unsigned int rreq_id, gfp_t gfp,
>>         struct folio_queue *fq;
>>
>>         if (gfp == GFP_KERNEL)
>> -               fq = netfs_folioq_pool.alloc(gfp, netfs_folioq_pool.pool_data);
>> +               fq = netfs_mempool_alloc_noreserve(&netfs_folioq_pool, gfp);
>>         else
>>                 fq = mempool_alloc(&netfs_folioq_pool, gfp);
>>         if (fq) {
>> --
>> 2.25.1
>>
>>
