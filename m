Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DF9531AE8;
	Thu,  1 Oct 2026 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869425; cv=none; b=E4ZwWcFmSUsA8OKOv4T0z5Ly8HcNdrB4KVkgNMye1EVn+3i0DX17G/hYU549dCD0ii/KBzxiprcPBuvth9MjM2t8hTXJeQJojUWSUqc0DXctENjCSvZOdhaIe53rYTXikbl+8dyrq6OIen9e9OWTDIxUYDYCkvQgHYRGFXfx5Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869425; c=relaxed/simple;
	bh=412Hgnp1g82M9qFz6+sDtgsvjwFHwriz0tMGDlvwn+E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ginLv5zMPQAjaJ4umS1HVlV1ovRF4BE86IOL1tHOf9GZ2CY1gJMehTSJqCJtfExmgSgx4Cpx1pse/A9/elGDEpqwsJMBMGL4pK2g920eEmlvZyT6aSY1XuZh2QqvgWDlIvWQl0geKh5Yk87ojyZxyT+0hKgb/Wayx/7jCgW7Uu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bl7lRu/y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bl7lRu/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2D21F008A7;
	Thu,  1 Oct 2026 15:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790869421;
	bh=lIp0N9ETA3Ja1lXBntUo6INabFxn7mCNqP7rfPsOXFQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=bl7lRu/yIaxzsQ4nzU+OP+SPRjQnX6mk5j5X7Ft7Ob3u1RwRuDJS0GiMDVn/k3+vO
	 u0HIi3vLEMcgEdS5UrvmMZBFGaC6F34HMXVf/JnKpSXrnct6KSM0lPmmck3WbIpi+c
	 /mYxdOy98oklfeGmVuxMIraEjH/7/eLvfZG6yvz9cIxe+V/pyVZ0aIzMvFiK1iEWG9
	 PT7Ms/4wbxfi9kmAaFSlSJFFyQlJGYr33piDKPlitAOYh+iWv+8Og4udaKPkHsYF7z
	 coJL01mH+7EYIfe4nS6Xv4ihfMRg9dQWTtMI2yMJ9852DrKOSu6qxHLBq36EYNoOau
	 6hyA0ejP0z0Bg==
Date: Thu, 1 Oct 2026 17:42:36 +0200 (CEST)
From: Imre Kaloz <kaloz@kernel.org>
To: Harry Yoo <harry@kernel.org>
cc: Vlastimil Babka <vbabka@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
    Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, Jann Horn <jannh@google.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: sample slab_state once in
 kmem_cache_destroy()
In-Reply-To: <ar5pESlkEMqNsgxv@thinkstation>
Message-ID: <aef97b97-0bd7-d720-7f59-8c0078747370@kernel.org>
References: <20260930195110.13296-1-kaloz@kernel.org> <ar5pESlkEMqNsgxv@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Harry,

On Thu, 1 Oct 2026, Harry Yoo wrote:

> Hi Imre,
> Thanks for catching and fixing this!
>
> On Wed, Sep 30, 2026 at 09:51:09PM +0200, Imre Kaloz wrote:
>> kmem_cache_destroy() tests slab_state >= FULL for sysfs_slab_unlink()
>> and again in kmem_cache_release() for sysfs_slab_release(), with the
>> cache already off slab_caches in between. If slab_late_init() runs in
>> that gap it sets slab_state to FULL but never calls sysfs_slab_add() for
>> the unlinked cache, so kmem_cache_release() ends up in kobject_put() on
>> a kobject that was never initialized:
>>
>>   WARNING: lib/kobject.c:734 at kobject_put+0x64/0x2c0, CPU#1: kworker/u8:3/55
>>   kobject: '(null)' ((____ptrval____)): is not initialized, yet kobject_put() is being called.
>>   refcount_t: underflow; use-after-free.
>>   kobject_put+0x64/0x2c0
>>   sysfs_slab_release+0xc/0x20
>>   kmem_cache_destroy+0x104/0x1e0
>>   bioset_exit+0x13c/0x1e0
>>   disk_release+0x54/0x140
>>   put_disk+0x18/0x40
>>   floppy_async_init+0xbec/0xd10
>>
>> Seen on sparc64 at boot, where the asynchronous floppy init tears down
>> its bio slab while the late initcalls are running.
>>
>> Read slab_state once, under slab_mutex which slab_late_init() holds when
>> it sets FULL, and use the result for both the unlink and the release.
>> The kobject flags (state_initialized, state_in_sysfs) were considered as
>> the key instead, but slab_state is what cache creation and
>> slab_late_init() decide on.
>>
>> debugfs_slab_release() is not part of the race: it only looks the cache
>> up by name in the debugfs root and does nothing before that root exists.
>>
>> Fixes: 4ec10268ed98 ("mm, slab: unlink slabinfo, sysfs and debugfs immediately")
>
> Overall looks good to me, but could you please explain why it's
> not relevant before this commit? pre-4ec10268 still reads slab_state
> outside slab_mutex.
>

The outside-mutex read is older, yes. What 4ec10268ed98 changed is that
unlink and release no longer share it.

Before that commit, kmem_cache_release() did one test and used it for
both:

     if (slab_state >= FULL) {
         sysfs_slab_unlink(s);
         sysfs_slab_release(s);
     } else {
         slab_kmem_cache_release(s);
     }

So the two could not disagree. 4ec10268 moved sysfs_slab_unlink() into
kmem_cache_destroy(), after list_del() and after dropping slab_mutex,
and left a second slab_state test in kmem_cache_release() for
sysfs_slab_release(). The cache is already off slab_caches in between.

That is the window in the warning: the first test sees < FULL, so the
kobject is never linked; slab_late_init() then sets FULL under
slab_mutex and calls sysfs_slab_add() only for caches still on the
list; the second test sees FULL and kobject_put()s a kobject that
kobject_init() never ran on.

A single read cannot produce that split decision, which is why Fixes:
points at 4ec10268ed98.

There is a related older window: after list_del() and before that
single read, slab_sysfs_init() could set FULL, skip this cache, and
the single read would then call both unlink and release on an
uninitialized kobject. I have not hit that, and this patch does not
close it.


Best,
Imre
