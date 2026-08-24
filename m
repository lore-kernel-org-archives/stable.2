Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE98B38551D;
	Mon, 24 Aug 2026 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596762; cv=none; b=Q0h7gNkqQGzZBFMwbz482h1UWQmJoCa7Yv6e1WW11JKQ0bjcoTaLe6PU3hh7KCNbM2dDsYMohxhgJVXUczEbZybuWRLqr9eyVWvZn2HRMsVcyyEQUklN2TRurb62gYGsW16AKTD64qq5ykFC7ZjNFgvHkjW4AW1ZoCtmV3FXFFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596762; c=relaxed/simple;
	bh=8kCzQ9k1GD83yzT9j2i2SMYt70G4duTSwE8gVcTrwEA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=N4Xm08lSvH/euxMXa2+z8vERFiuONM/TXTLn/XzrDKiBybGXEQQSwB025tcLzkXQklABFOpnModZ8KNsZFFFlHfuztcA5GMOzAOPhG11j6GJ1b766W8JmP+HIHD1TrosWEVsEFp06SSlFU0AJWWQLvZiA9TTZijziYT/0kx8kF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cdNkR56V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cdNkR56V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3401F000E9;
	Mon, 24 Aug 2026 18:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1787596760;
	bh=1UBV4/KgDhQsiGNcw2DjCpLZivT52o2Vrno9SL3MwTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cdNkR56VYQtfw3xp9l6ugyxRzV/Y5SUht8XoNKHe+E8IBBMIExHu//hqJ50tihgyy
	 0ms0WN5XD0q/QB/Ky7TM9nPdIgdP4pR5/0JtRZCBg/9MKZ6/WyUPiiEpI2GxhQGgtN
	 Ypil4wPiIwTUStSuR8ZAjWEKl1Afz2VzFKpmRIoQ=
Date: Mon, 24 Aug 2026 11:39:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, edumazet@google.com, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, stable@vger.kernel.org, david@kernel.org,
 ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, syzbot+0dbf6d295b3350944f0b@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/mempolicy: refcount the weighted interleave state
 instead of copying it
Message-Id: <20260824113919.caa89dd75553365977f8a42c@linux-foundation.org>
In-Reply-To: <20260824024117.1755899-1-gourry@gourry.net>
References: <20260821104043.f692421fec915c0c5bc1fbe6@linux-foundation.org>
	<20260824024117.1755899-1-gourry@gourry.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Aug 2026 22:41:17 -0400 Gregory Price <gourry@gourry.net> wrote:

> alloc_pages_bulk_weighted_interleave() copies iw_table into a scratch
> array on every call to get the table outside of RCU.
> 
> Refcount the weighted interleave state and cleanup with kfree_rcu().
> Refcount and iw_table get their own cachelines to prevent false sharing.
> 
> This drops a kzalloc/memcpy/kfree per call and deals with a bug induced
> by the scratch array's hardcoded GFP_KERNEL and the partial allocation it
> returned when that failed.
> 
> Tested in VM (KASAN, PROVE_LOCKING and DEBUG_OBJECTS_RCU_HEAD) with a
> udelay() injected between the rcu_dereference() and the refcount_inc
> to stress the race. Six concurrent bulk allocators racing four threads
> writing the sysfs weights took the retry path 2536 times with no splat,
> and the published state was back to a count of one at rest.
> 
> Replacing the kfree_rcu() with a bare kfree() in that same test reports
> a use-after-free immediately, so the test does exercise what the deferred
> free protects.
> 
> ...
> 
> Hi Andrew - please consider this instead.

Let's keep Eric's nice simple one-liner
(https://lore.kernel.org/20260821170407.3721004-1-edumazet@google.com)
for a backportable fix.  THen we can work on more sophisticated
approaches in the next -rc cycle.

