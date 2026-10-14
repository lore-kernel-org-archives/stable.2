Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3BB486420;
	Wed, 14 Oct 2026 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007218; cv=none; b=bKSrgs5DI4v9SXJ7xUw/lx+YsrYATyymSHxdhCXJr0Ezc4NaWV+AS6dN9731tvck7zV8/ex7inxwAJx+88cWMSV5s/dd7aoLEe+1ZOD9QQ5YQGxdD6He5P/x7+14bBQ/BIrGV1MG/jdAX/CZuVBIAG0yTJWCapA/1pobTs/iMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007218; c=relaxed/simple;
	bh=F8iUNDa8xve1BSXQ6Tye39xGf3MOB6x7ueXyLnS6mfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neAK8zjYM9rADJuCZPEYMe+e1p2cBIKxMT+CCZWHqDqQJPu9etEvumrVOB37tTEhC/OrwF2Tv6+1iTU0zMkoo6BFXogNXRftbA8dG6yCbUcWPm1SpIMc6MFfJsm5zP/yOsV6s0jsoobogxe6MlVv/KuixIqiReo1JRWR6dVtLfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmQVoIwa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmQVoIwa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843F91F000C4;
	Wed, 14 Oct 2026 19:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792007216;
	bh=VkzoqxTdzmAg593ZpIds3NlLUMIFMc0b1AE/YCVZDWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RmQVoIwaX4F+m+QOTfBZ/BEap2Ci3CR8vUwT+k50W7Jgus1MTHRpWoDCeRk3szKas
	 uzosIYzkaiam6ix1S/hWjqoS0TxPoO4a78Ix3OO/QlCm1KxycxhrmJY+w49cFxMjwl
	 sk3k3ikgGrwEwt4FTM8SfDW2xPJnk3Dx29n1Nde0Q2+khRQ3bZthoThKsbDyY9fCQF
	 V3HBMdhNdz95Pk/NV2mftbwGl26FI4HxJ+7kXD1zqiIVSFJf7Yhh0vv+10/yJfQq8L
	 Ba+aRlqD7WHu3E5lC8suYwgKJ6fMw9JkM3+Njs0J4n1Tcuzpnv7F1mM/eacKy4v12z
	 hrI8yQ7+5y9kg==
Date: Wed, 14 Oct 2026 20:46:53 +0100
From: Harry Yoo <harry@kernel.org>
To: Imre Kaloz <kaloz@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, "Jose A . Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v2] mm/slab: sample slab_state once in
 kmem_cache_destroy()
Message-ID: <as_MPz_gXzkuGqFq@thinkstation>
References: <20261014150844.8536-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014150844.8536-1-kaloz@kernel.org>

On Wed, Oct 14, 2026 at 05:08:43PM +0200, Imre Kaloz wrote:
> kmem_cache_release() tests slab_state >= FULL after kmem_cache_destroy()
> has dropped slab_mutex and unlinked the cache, and for a
> SLAB_TYPESAFE_BY_RCU cache after rcu_barrier(). If slab_late_init() runs
> before that test it sets slab_state to FULL but skips the unlinked cache,
> which never got a sysfs entry, so sysfs_slab_release() calls kobject_put()
> on a kobject that was never initialized:
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
> The release-time test has run outside slab_mutex since at least v4.4 for
> SLAB_TYPESAFE_BY_RCU caches, and since v6.0 for the others. Since v6.12
> the unlink-time test in kmem_cache_destroy() is a separate read of its
> own, also after mutex_unlock(), so the two can disagree. Both tests ask
> whether the cache has a kobject, which cache creation skips while
> slab_state <= UP. UP is the state just below FULL, so a false sample
> cannot skip a kobject_put() that was owed.
> 
> Seen on sparc64 at boot, where the asynchronous floppy init tears down
> its bio slab while the late initcalls are running.
> 
> Sample slab_state once, under slab_mutex which slab_late_init() holds
> when it sets FULL, and use the result for both the unlink and the
> release.
> 
> Fixes: d50d82faa0c9 ("slub: fix failure when we delete and create a slab cache")
> Fixes: 4ec10268ed98 ("mm, slab: unlink slabinfo, sysfs and debugfs immediately")
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>

I guess it's late to queue this to slab/for-next-fixes.
Let's queue this to slab/for-next for 7.4-rc1.

-- 
Cheers,
Harry / Hyeonggon
