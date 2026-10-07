Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDFE3E558C
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791395241; cv=none; b=Zl7l0rDEBmrecTdHCWHIev4TzzqzRFEf59PL0wgZ6ImRX4vlXVeKgiDtDKjIqvUqLzrt2rf2uX27NxPZiJ7ThqY39N19/XNZLzOdK7zbFiqCOFY/7zTpI8K8VT4BbUhUL0xEbF3lL6VbwJ6DJxFDdYT8K6B/hdNol4hYzQdMo08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791395241; c=relaxed/simple;
	bh=BmZUZyyfGt22djwdV8E6ldOl5KR1aVf78hKhaE22XdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjE8SuxllkqlAuay01Cwk87D1Bmqs80kSevU8Ju3fwmSOs2+u6O8dLZQgaK7ijP6mvPfzuTcDcdpAW0jdcMZJs3i5viE9Ez6VhRnpyYau9EFSPc8kIvhFmhLUaq7hjBwf+3PC0v5iGXQ8SxdHlkocgF9SsLGa/Mjv6akcD7QQTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EquxJzNs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EquxJzNs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CF61F000FF;
	Wed,  7 Oct 2026 17:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791395239;
	bh=hrN5jCbJ23KzWZs6wwkV2zHBbc7V4zUmP1BS2E476mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EquxJzNsDMw/0KeyNG4auMBMP0wP6kLplxNS0LhgoG8NQkbThad0GD4F+LIHwhjKQ
	 lzhs7kZ8PLpagPgk0y1dQEr2sKoxFTF4VqcLYltNa+9zSNkt0qihVmYvm+T7RLeoJg
	 0skBcNxgWndYoIykw748fEC/y2ZM0C+tGqWjJ4uN4Vo+bDlXfcJlVBUnTuJU++ujdI
	 AWXgAEYuzlFNBO/4/LHlsFkVJjlNRPHpJWiyQc13ZMYSpJPnZIMPqrriMGpFzGpFXq
	 GrlYjW1py4ss8EaIqhW5r6lIrFAFskZdX6ngh+EV5yo8Eo01UwhN8e8q8Pn2aEFvW+
	 7v4SNSGFvSfOA==
Date: Wed, 7 Oct 2026 19:47:14 +0200
From: Harry Yoo <harry@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Hao Li <hao.li@linux.dev>, linux-mm@kvack.org, 
	Roman Gushchin <roman.gushchin@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/slub: clamp slab_min_order to MAX_PAGE_ORDER
Message-ID: <asaEdFRDdZlRdAc4@thinkpad>
References: <20261007163403.1643768-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007163403.1643768-1-ekffu200098@gmail.com>

On Thu, Oct 08, 2026 at 01:34:02AM +0900, Sang-Heon Jeon wrote:
> setup_slub_max_order() clamps slab_max_order to MAX_PAGE_ORDER, but
> setup_slub_min_order() has no such clamp.
> 
> The buddy allocator cannot allocate more than 2^MAX_PAGE_ORDER pages
> at once, so slab_min_order above it makes no sense.
> 
> If slab_min_order is set above MAX_PAGE_ORDER, it can even panic at
> boot or invoke undefined behavior in order_objects().
> 
> So clamp slab_min_order to MAX_PAGE_ORDER as well.
> 
> Fixes: 818cf5909701 ("slub: enforce MAX_ORDER")

I think Fixes: should be the commit that introduced slub_min_order.

> Cc: stable@vger.kernel.org

And no need for Cc: stable? It's been there for decades and people
should realize the kernel parameter is broken when it doesn't boot.

Otherwise looks good to me.

> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
> QEMU-based test results
> 
> - Booted with "slab_min_order=20"
> 
> 1) AS-IS (before fix)
> [    0.094926] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
> [    0.097776] Kernel panic - not syncing: Creation of kmalloc slab kmem_cache_node size=64 failed. Reason -22
> [    0.099542] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 7.2.0 #1 PREEMPT(undef) 
> [    0.100903] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [    0.102607] Call Trace:
> [    0.103040]  <TASK>
> [    0.103417]  vpanic+0x32a/0x4b0
> [    0.103976]  panic+0x5e/0x60
> [    0.104491]  create_boot_cache+0xe3/0xf0
> [    0.105194]  kmem_cache_init+0x12d/0x410
> [    0.105890]  ? mem_init+0x1fc/0x210
> [    0.106521]  mm_core_init+0xba/0x140
> [    0.107153]  start_kernel+0x441/0x8b0
> [    0.107814]  x86_64_start_reservations+0x18/0x30
> [    0.108638]  x86_64_start_kernel+0x10c/0x120
> [    0.109401]  common_startup_64+0x13e/0x158
> [    0.110145]  </TASK>
> [    0.110584] ---[ end Kernel panic - not syncing: Creation of kmalloc slab kmem_cache_node size=64 failed. Reason -22 ]---
> 
> 2) TO-BE (after fix)
> [    0.008976] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
> [    0.011366] SLUB: HWalign=64, Order=10-10, MinObjects=0, CPUs=4, Nodes=1
> 
> Also, I'm not sure about the Fixes commit. Please change it if you know
> a better one.
> 
> ---
>  mm/slub.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 1559cbace469..8400df7c222e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -8354,6 +8354,8 @@ static int __init setup_slub_min_order(const char *str, const struct kernel_para
>  	if (ret)
>  		return ret;
>  
> +	slub_min_order = min_t(unsigned int, slub_min_order, MAX_PAGE_ORDER);
> +
>  	if (slub_min_order > slub_max_order)
>  		slub_max_order = slub_min_order;
>  
> 
> base-commit: d755441b7672c74f29d1241ffdd2b067ecab1ca0
> -- 
> 2.43.0
> 

-- 
Cheers,
Harry / Hyeonggon
