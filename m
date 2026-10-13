Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417444F7CCB;
	Tue, 13 Oct 2026 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895956; cv=none; b=imn+MHRJitLob63Zb1eKI1vtQnZkou0Bn4FkKETZZq+HAHBibwfmEqUE83inBW8J3DfI0GcfDMgC8XEonf5Y5S3u7kz1La+BCV4F3d+vb/NFvW9VzCPQ5yZWypuNPOSbYdTRycjngejKLEmpCUTqQ1TKfv8bffcs62r13MuTgqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895956; c=relaxed/simple;
	bh=08sJ15vQvPn22EKkE3fnR9OOkCBn/Y/3QGXwmX5Vt2Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mlJo/A+7CU0E4qF3lPlBeIXFmtkg9hF7xuhMay7pkmM+TMHkjgei4I0HdftLVslSr/w2QdTpnYp7vtAYYLVAwLTlp6ht8ry+EejJY+7GfTkBUYUVgXdXKAuEpfP2E139Cx2QRAxHp5XcU2zQHWTRp1P7bh+NSaZJkmMUbP10Jjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7kj/CfI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7kj/CfI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AC51F00893;
	Tue, 13 Oct 2026 12:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791895954;
	bh=08sJ15vQvPn22EKkE3fnR9OOkCBn/Y/3QGXwmX5Vt2Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=S7kj/CfIsRYfKCjGHwQxhK1cwvGWhLM8Jm/El2TwQ2t2QUjlfqSh/gvHEzw2iGOgF
	 62a7WM3l/vY0+jJqRmfZ5De8XiVDehL4EaN9oWkBOcgC6toVID6ZAtrSYLxZ3Wtl4s
	 2Y5DQAI5nZ/kCTcds+Q5CPw7MiKLwtYC4HkwnGpMa7EFGXzTJw2vYtYPAnb+gQNEiC
	 31Rbt7X2D9y7MS0taYY0fjtPWQNf6t/dFPOUn+SaZZFbrcYZfL3EyrX3VROWP5kSH3
	 TI9IbAcJr49hnKlyuacSX1wSZRFVENj5iNz0YRINVQbZVdaw5vzjEstx7AsO25a0qi
	 hqkkRKk+TeIUQ==
Date: Tue, 13 Oct 2026 14:51:30 +0200 (CEST)
From: Imre Kaloz <kaloz@kernel.org>
To: Harry Yoo <harry@kernel.org>
cc: Vlastimil Babka <vbabka@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
    Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, Jann Horn <jannh@google.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: sample slab_state once in
 kmem_cache_destroy()
In-Reply-To: <as4QhUscRVtBzYpm@thinkstation>
Message-ID: <481e9a16-cd30-d463-14ee-b5602bcd5a21@kernel.org>
References: <20260930195110.13296-1-kaloz@kernel.org> <ar5pESlkEMqNsgxv@thinkstation> <aef97b97-0bd7-d720-7f59-8c0078747370@kernel.org> <as4QhUscRVtBzYpm@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Harry,

On Tue, 13 Oct 2026, Harry Yoo wrote:

> Uh, apologies for the late reply.
> Catching up after trip at LPC...

No worries, hope LPC was good!

> On Thu, Oct 01, 2026 at 05:42:36PM +0200, Imre Kaloz wrote:

<snip>

>> There is a related older window: after list_del() and before that
>> single read, slab_sysfs_init() could set FULL, skip this cache, and
>> the single read would then call both unlink and release on an
>> uninitialized kobject.
>
> No, with this patch slab_sysfs_init() cannot set the state to FULL
> because the slab_caches list and slab_state are protected by slab_mutex.
>
>> I have not hit that, and this patch does not close it.
>
> I think the patch does close two bugs.
>
> One introduced by 4ec10268ed98 (reading slab_state twice),
> another (reading slab_state outside slab_mutex) introduced by, hmm,
> not sure which commit introduced it :) should be very old.

You're right, I got that one wrong. Sampling under slab_mutex in the
same section as the list_del() means slab_late_init() either sees the
cache on the list or we see slab_state < FULL, so the older window is
closed too.

As for where the outside-mutex read came from, as far as I can tell it's
0495e337b703 ("mm/slab_common: Deleting kobject in kmem_cache_destroy()
without holding slab_mutex/cpu_hotplug_lock"). Before that, the unlink
and release and their slab_state checks ran in shutdown_cache() under
slab_mutex. SLAB_TYPESAFE_BY_RCU caches were already released from the
workfn outside the mutex since 657dc2f97220.

Want me to send a v2 with a second Fixes: for 0495e337b703, or is it
fine to add it when applying?


Best,
Imre
