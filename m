Received: from mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C2B4BCAAA
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447264; cv=none; b=tOESkZN//wjZ4DuzncE1MGNJdrgtQKCL48hqp/IK60EEiktVssAIuPOVV6cKFAuXpPjN+Nt9gNHnRQBruKEhaIxXoAJwKkNucqhV2+T7DwCq/ANI+kLwqsg/1bmShUtR33N3pyARI/m8ZFjXCJjNnSnKUqULq0j8Np/52Wy8pR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447264; c=relaxed/simple;
	bh=tkk36hhnqCNnAczCtVtvfHNcA6tWuFttAc23e/8SJ3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3LHL3NIhhEEuSeIMH0io2Bl6xUwft+FyqrcTCQEzEIS3nDM7gJxHFXRyN9R/FoXflijNDxc0Qbx+GSsLwMF1fDX5EWlDC5t9QWIWNyLG53Zk1oiKgpvuMmMS7QsPp6P0koLgB2XGRP+yrgRglMUAl2y5aQfd3Kt85TjgSwLT8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qq4Prwh7; arc=none smtp.client-ip=95.215.58.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qq4Prwh7"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tkk36hhnqCNnAczCtVtvfHNcA6tWuFttAc23e/8SJ3E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788447258; v=1; x=1789052058;
 b=Qq4Prwh7yEGvKcJ0+su0Uc7Sj2d9OoBAzuavOeCDWf7t3/BBku/Fwhfpuk12UDH43SOPmIpe
 gexi/r+zdsn7ywPhfXjp6FPtaLYgBz46nNkuk2sx772LZsjQa4weAMCDltes3sJA7sNmZMvnxx5
 +/RCm1dZAewTFdmXftt4HkC8=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 05c2eb3fd5c9c093;
	Thu, 03 Sep 2026 14:54:08 +0000
X-Mizu-Trace-ID: 05c2eb3fd5c9c093
X-Migadu-Flow: FLOW_OUT
Date: Thu, 3 Sep 2026 22:53:51 +0800
From: Hao Li <hao.li@linux.dev>
To: "Harry Yoo (Meta)" <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/slab: take n->list_lock in
 __slab_try_return_freelist() to avoid race
Message-ID: <apmJiWakiBw3VAgb@fedora>
References: <20260903-slab-fix-aba-v3-1-b44cb6badd54@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-slab-fix-aba-v3-1-b44cb6badd54@kernel.org>

On Thu, Sep 03, 2026 at 03:32:26PM +0100, Harry Yoo (Meta) wrote:
> Commit ba7425312607 ("mm, slab: add an optimistic
> __slab_try_return_freelist()") incorrectly assumed that nobody has freed
> an object to the slab as long as slab->freelist is NULL and cmpxchg
> succeeds.
> 
> However, as reported by Hyunwoo Kim [1], other CPUs might have freed
> an object to the slab, insert the slab to the partial list, then
> allocated an object from the slab, and be in the middle of removing
> the slab from the list under n->list_lock.
> 
> Since __refill_objects_node() puts the slab back on pc.slabs
> outside n->list_lock, it might insert the slab into that list while
> the slab is concurrently being removed from n->partial.
> This led to a list corruption [1]:
> 
>   list_add corruption. next->prev should be prev
>   (ffff888100000248), but was dead000000000122.
>   (next=ffffea000416e410).
>   kernel BUG at lib/list_debug.c:29!
>   Oops: invalid opcode: 0000 [#1] SMP NOPTI
>   CPU: 1 UID: 65534 PID: 144 Comm: poc Not tainted
>   7.2.0-16172-gcf72cbb39da8-dirty #1 PREEMPT(lazy)
>   RIP: 0010:__list_add_valid_or_report+0x80/0xd0
>   ...
>   Call Trace:
>    alloc_from_new_slab+0x183/0x300
>    ___slab_alloc+0x31c/0x890
>    __kmalloc_noprof+0x3d4/0x800
>    lsm_blob_alloc+0x2d/0x50
>    security_msg_msg_alloc+0x26/0x90
>    load_msg+0x1aa/0x210
>    do_msgsnd+0x91/0x800
>    do_syscall_64+0x109/0x5d0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   ...
>   Kernel panic - not syncing: Fatal exception
> 
> This is a classic ABA problem where cmpxchg succeeds but the state has
> changed since __refill_objects_node() took the freelist from the slab.
> 
> As Vlastimil Babka mentioned [2], it should be rare to return more than
> one slab (due to the racy read of slab->counters in
> get_partial_node_bulk()). Therefore, instead of introducing additional
> complexity, acquire and release n->list_lock twice in the worst case.
> 
> Return the slab directly to the partial list and hold n->list_lock
> across the cmpxchg and add_partial(). This is similar to the initial
> version of commit ba7425312607 [3]. This is enough to avoid the race as
> the list manipulation is serialized by n->list_lock. While at it,
> bring back unlikely() hint now that the condition is unlikely.
> 
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Closes: https://lore.kernel.org/linux-mm/apPa-cGLcyt90l-E@v4bel [1]
> Link: https://lore.kernel.org/linux-mm/ae25c193-b95f-40c1-83b6-1c2546467e41@kernel.org [2]
> Link: https://lore.kernel.org/all/20260421-b4-refill-optimistic-return-v1-1-24f0bfc1acff@kernel.org [3]
> Fixes: ba7425312607 ("mm, slab: add an optimistic __slab_try_return_freelist()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
> ---
> Changes in v3:
> - Don't repeat "As reported by Hyunwoo Kim" in changelog (Vlastimil)
> - Pass kmem_cache_node pointer directly to __slab_try_return_freelist() (Vlastimil)
> - Link to v2: https://lore.kernel.org/r/20260902-slab-fix-aba-v2-1-d1ece15a8417@kernel.org
> 
> Changes in v2:
> - Simplify the code to hold n->list_lock across cmpxchg + add_partial()
>   and acquire the lock twice in the rare worst case.
> - Link to v1: https://lore.kernel.org/r/apPa-cGLcyt90l-E@v4bel
> ---
>  mm/slub.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 

Looks good to me! Thanks for the fix!
Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao
