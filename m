Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E223DEAD6;
	Thu,  1 Oct 2026 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864562; cv=none; b=YnpLG7xhBNKFa9y1SAboCEq93SZrUcK/Qe1MNveX/fBYyABlfaa191ppbL9OVUhcGVrUES1Cn5xkYeU8PPTQzY+/QyJS0lKBx3GQmkbncZ6q4wWjUV47ze2TohTJ9MieE1c25UhF1BFdOGuJDtPuX8SP9J1mlM5Nn2WhJSvriao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864562; c=relaxed/simple;
	bh=JbcQn7JpiM7PEaEmjlmMAyJ1Dxnz/Vi+BdywK1mY3HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOhr7V4yRYbPgmJi27e/pzObGni3lU07gb/1KhTFXDyIO8HhYKgaqj9Rp6ruThZUsclIp6icN+mt7XI6COloFfUxx3t8ewNk0y9kdWMLowDaN5SHmrSEaaOLZUciN86JGxGC/jmgG8ey0ofoth//O3K7gMiSY0kveh9FkRhBnhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PF6tJ1/6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PF6tJ1/6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097D01F000FF;
	Thu,  1 Oct 2026 14:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790864560;
	bh=XyzcN1CM+Sjmv9yngzarkO66OZbEgOAmUF41sBp7ArQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PF6tJ1/6dSILGxm3+IyWR0RN4HSaLeM8UR1tkSW5GiMJL9wSnl8UJkwfBnLtPIG/G
	 KEyrAl9ILdbIS4kB+c94qGEEc98b4qzwETcKQw4GGF7Gui5kTXsYjzvuEOBXlcAaIj
	 7fbVrKkEQ0QAnabLPF8Mjm3azdjKzXJifsjdx/xTVxUcYP0qSs9BhXmy909MnZMjBq
	 ix9/T1fGhCMUFG2XhrM0DBfC03we1JTwgQrglpcnIAGa70CyFnzi+cj6ijADRCFb0x
	 0yQ5xjmptDDcfbyLYEXK50UInFq790oUX+gfF4wGThuyfMwIIYx49ZdN+r54JEjESi
	 RSySn/z792Q2A==
Date: Thu, 1 Oct 2026 15:22:38 +0100
From: Harry Yoo <harry@kernel.org>
To: Imre Kaloz <kaloz@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: sample slab_state once in kmem_cache_destroy()
Message-ID: <ar5pESlkEMqNsgxv@thinkstation>
References: <20260930195110.13296-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930195110.13296-1-kaloz@kernel.org>

Hi Imre,
Thanks for catching and fixing this!

On Wed, Sep 30, 2026 at 09:51:09PM +0200, Imre Kaloz wrote:
> kmem_cache_destroy() tests slab_state >= FULL for sysfs_slab_unlink()
> and again in kmem_cache_release() for sysfs_slab_release(), with the
> cache already off slab_caches in between. If slab_late_init() runs in
> that gap it sets slab_state to FULL but never calls sysfs_slab_add() for
> the unlinked cache, so kmem_cache_release() ends up in kobject_put() on
> a kobject that was never initialized:
> 
>   WARNING: lib/kobject.c:734 at kobject_put+0x64/0x2c0, CPU#1: kworker/u8:3/55
>   kobject: '(null)' ((____ptrval____)): is not initialized, yet kobject_put() is being called.
>   refcount_t: underflow; use-after-free.
>   kobject_put+0x64/0x2c0
>   sysfs_slab_release+0xc/0x20
>   kmem_cache_destroy+0x104/0x1e0
>   bioset_exit+0x13c/0x1e0
>   disk_release+0x54/0x140
>   put_disk+0x18/0x40
>   floppy_async_init+0xbec/0xd10
> 
> Seen on sparc64 at boot, where the asynchronous floppy init tears down
> its bio slab while the late initcalls are running.
> 
> Read slab_state once, under slab_mutex which slab_late_init() holds when
> it sets FULL, and use the result for both the unlink and the release.
> The kobject flags (state_initialized, state_in_sysfs) were considered as
> the key instead, but slab_state is what cache creation and
> slab_late_init() decide on.
> 
> debugfs_slab_release() is not part of the race: it only looks the cache
> up by name in the debugfs root and does nothing before that root exists.
> 
> Fixes: 4ec10268ed98 ("mm, slab: unlink slabinfo, sysfs and debugfs immediately")

Overall looks good to me, but could you please explain why it's
not relevant before this commit? pre-4ec10268 still reads slab_state
outside slab_mutex.

> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
