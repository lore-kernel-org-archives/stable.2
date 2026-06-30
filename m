Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7984F382F35;
	Tue, 30 Jun 2026 05:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782796311; cv=none; b=M3KviJhotIB8yjQ36e2tkTo6N9sT0kBZx0t46zkR9B0jcgPsLvAL+N4f9zXN3F1lmNhsqb1zo7cztF6QRJ/t/Syf93dcqUZPEiewN/osll+WYIUQJ5vItIqipqjMigV6UpPFL8fDtdIbgyXv/qWgOw8fEDTTrDpHwTB4I/7Eco0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782796311; c=relaxed/simple;
	bh=jGsxe8EWGqj48FL1oGk7oxCabxWERVOOeFeCdjEeB3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVM5RPm+vNEIvRylJCugpLDXP0NiUVsLysZ7tGoJnibZhgf6e6n5lOUfLMMaTZQ2z1GyM8glnxsUpOLwFTMKbzZgqH/3QptEX2Ob8Vc0aOfeCBWqtLBQuqHaB/0mCIcWf6OMxwIdhJuaO9/kVM7i3znjOgRV2ViVfGK0r6P5v9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnSjygkQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnSjygkQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104EE1F000E9;
	Tue, 30 Jun 2026 05:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782796310;
	bh=vP04Zj5CVyJaLzf8VO3FeLXIWVNRIyp0CJ7kM8RLPd0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LnSjygkQujJBqze4waGOIxA4cm+8m4AE1x+c5lBZnG4xJkAtdCyqPk3ibPoNYdEu3
	 MbG+QZXK408/Z5Ck5L5bFZtdaP+g28hsmQadK4UGAZZABvYpyqR9IUK026gk64ypjg
	 dy1dgoldjYp4wmA5bcPqr9budrc/zppCwULkrbMfhZzZzjPw2Om0B/JJktqm9GghJr
	 MYorJCv9kgCI31nohJbJG1xp4u8izyMQZ8fN/lMo5gT3SQZL67B8Gc5AmkXDNqlhgG
	 EXECEmOrDreNwjnqFntAZEM99O11Fo4yTkhyqeNrtqPWDmeRUUoBVjgpRQmdP34e87
	 baS+wv5Fjm4lQ==
Message-ID: <f07168be-23c6-4ff2-bb74-60509454ee01@kernel.org>
Date: Tue, 30 Jun 2026 14:11:45 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/slub: serve slabobj_ext array from a strictly
 larger kmalloc cache
To: Shakeel Butt <shakeel.butt@linux.dev>, Vlastimil Babka
 <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Suren Baghdasaryan <surenb@google.com>, Usama Arif <usama.arif@linux.dev>,
 Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Danielle Costantino <dcostantino@meta.com>,
 stable@vger.kernel.org
References: <20260630024357.3591304-1-shakeel.butt@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260630024357.3591304-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 11:43 AM, Shakeel Butt wrote:
> A production host in the Meta fleet (6.16 kernel, memory allocation
> profiling enabled) panicked with a kernel stack overflow while a kernel
> driver was freeing a resource:
> 
>   BUG: TASK stack guard page was hit
>   Oops: stack guard page
>   RIP: 0010:kfree+0x8/0x5d0
>   Call Trace:
>    __free_slab+0x66/0xc0
>    kfree+0x3f0/0x5d0
>    ... ( ~125x __free_slab <-> kfree ) ...
>    <kernel driver freeing a resource>
>    do_syscall_64
> 
> The crash dump shows a 125-deep __free_slab<->kfree recursion that
> overflowed the 16 KiB kernel stack.
> 
> What happened: a KMALLOC_NORMAL slab's obj_exts array (used by allocation
> profiling / memcg accounting) is itself kmalloc()'d from a KMALLOC_NORMAL
> cache, so the "slab holds another slab's obj_exts array" relation can form
> cycles.  With sizeof(struct slabobj_ext) == 16 and the host's geometry:
> 
>   - kmalloc-512 has 64 objects/slab -> array is 64*16 == 1024 bytes,
>     served from kmalloc-1k;
>   - kmalloc-1k  has 32 objects/slab -> array is 32*16 ==  512 bytes,
>     served from kmalloc-512.
> 
> A kmalloc-512 slab and a kmalloc-1k slab therefore hold each other's
> obj_exts array.  Discarding one frees the other's array, which empties and
> discards that slab, which frees the first's array, and so on:
> __free_slab() -> free_slab_obj_exts() -> kfree() -> discard_slab() ->
> __free_slab() recurses along the cycle until the stack is exhausted.  The
> dump confirms it: the recursion's slabs strictly alternate kmalloc-512
> (obj_exts in kmalloc-1k) and kmalloc-1k (obj_exts in kmalloc-512), and
> mem_alloc_profiling_key was enabled.
> 
> Commit 280ea9c3154b ("mm/slab: avoid allocating slabobj_ext array from
> its own slab") is not sufficient: it bumps the allocation size only when
> the array would come from the *same* cache (object_size ==).  At the
> geometry above neither cache is self-referential (512 != 1024 and
> 1024 != 512), so the bump never triggers and the kmalloc-512 <-> kmalloc-1k
> cross cycle remains.
> 
> Fix it structurally by removing cycles of every shape: serve the array
> from a cache strictly larger than the one it describes whenever it would
> otherwise come from the same or a smaller cache.  Every reference edge
> then points from a smaller to a larger cache (here kmalloc-1k's array
> moves to kmalloc-2k), so the relation is a DAG and cannot contain a cycle.
> No slab can be self- or cross-pinned, the tear-down recursion is bounded
> by the number of kmalloc size classes (it terminates at the large-kmalloc
> path, which carries no obj_exts), and profiling/accounting coverage is
> unchanged - the array is still allocated, only relocated.
> 
> Reproduced on next-20260623 at the same geometry: churning
> kmalloc-512/kmalloc-1k under vm.mem_profiling and then shrinking leaves
> kmalloc-512 with thousands of unreclaimable objects without this patch
> (8056) and at baseline with it (847).
> 
> Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allocation and free paths")
> Reported-by: Danielle Costantino <dcostantino@meta.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Looks good to me so:
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

and it also passed my test suite, so:
Tested-by: Harry Yoo (Oracle) <harry@kernel.org>

Interestingly, Sashiko pointed out one issue [1] that
doesn't sound completely wrong. But that's a pre-existing one
and although Sashiko (presumably) thinks this patch makes it easier
to trigger this, I think the scenario is unreachable.

[1]
https://sashiko.dev/#/patchset/20260630024357.3591304-1-shakeel.butt%40linux.dev

Here's why I don't think anybody would be hitting it:

It says if s->object_size == KMALLOC_MAX_CACHE_SIZE,
alloc_slab_obj_exts() will always fail with SLAB_ALLOC_NOLOCK because
kmalloc_nolock() does not support large kmalloc.

Then a later allocation of slab objects allocates obj_exts array
(with large kmalloc), and freeing of the slab in unknown context tries
to free the obj_exts array, which kfree_nolock() doesn't support and
leaks the obj_exts array.

However, freeing slab in unknown context is done only when trylock
fails after allocating a new slab. So it's unreachable.

-- 
Cheers,
Harry / Hyeonggon
