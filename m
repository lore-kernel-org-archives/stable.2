Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB624052CC;
	Wed, 29 Jul 2026 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785365940; cv=none; b=VGSiIXFOacojZlGpZ4nUABRecdsxYhznZeY5xwocYBXwCHix/L49415F6X9koI709Pit/nuTpC5zUU+WenjgxlwvFXqzc4qqWIJ99GtQeQfuf7s4VCVjlxszpGZRLlnlsRTiZGArIxJUDj+rPVhm9Ze6LbDlhSawfx+FkQ934fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785365940; c=relaxed/simple;
	bh=aShF1B1U+US/N/X+HJ/efgRLJE3SqAatFLl2Z3y2RJo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SDwXW0KON3de71QIHMIOZ0ElDznmeGueEnR0Dmuw2DyWD4nUGQCiHFvtuIoWtxXb2aWOREr65wtw3Sesw8FZXx5EBAUs05rgd5ggp+dwAlqbEYkUiWGr38ZfOAmIUn/F/IpFk3sqxtNr0Es8Cd+gn4PG1D9UToik/J0T5VixxrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KQH5/lG6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KQH5/lG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9661F000E9;
	Wed, 29 Jul 2026 22:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785365939;
	bh=xHp8vjg8AUcQ9RYWhSmkMpxvojYRQuqhX6Yx6R+1bvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KQH5/lG6Mpu71bBDfjFDZgTI0KIL1OjfRfZugop8MUjzLILb6CG4pzwBJeQzMG+9B
	 QwhWncbq4rhhjQXDM2f7C7OuKxI0I/2B9c9xraILMqkyOQ+a3Wctt95vGZsXrYslhW
	 HAZtvKUgdgyR+Ln7MGPCMvkzOYN7dzCKYvltY34E=
Date: Wed, 29 Jul 2026 15:58:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 mhocko@kernel.org, yosry@kernel.org, mkoutny@suse.com, nphamcs@gmail.com,
 chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/zswap: Fix global shrinker when memory cgroup
 is disabled
Message-Id: <20260729155858.c7aabff48166a9bca4d68ac3@linux-foundation.org>
In-Reply-To: <20260729084206.77793-2-jiahao.kernel@gmail.com>
References: <20260729084206.77793-1-jiahao.kernel@gmail.com>
	<20260729084206.77793-2-jiahao.kernel@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 16:42:05 +0800 Hao Jia <jiahao.kernel@gmail.com> wrote:

> Zswap writeback when the global pool limit is hit fails when memory
> cgroup is disabled. The pool remains full until it is organically
> drained by swapins or memory freeing, leading to zswap store failures
> and pages bypassing getting written directly to the backing swap device,
> causing LRU inversion (hotter pages with higher fault latency).
> 
> This happens because mem_cgroup_iter() always returns NULL when
> memory cgroups are disabled. As a result, the global shrinker
> shrink_worker() repeatedly takes empty walks. After MAX_RECLAIM_RETRIES
> failed attempts, the worker gives up without writing back any pages.
> 
> Therefore, when memory cgroup is disabled, fall through with the !memcg
> branch and shrink the root memcg directly.
> 
> With memcg disabled, shrink_memcg() only returns -ENOENT when the root
> LRU is empty, which means the total pages are already below thr. In the
> absence of heavy concurrent zswap stores, the loop then safely bails out
> via the zswap_total_pages() <= thr check; otherwise, it will resume
> shrinking the memcg after processing the reschedule check. For any other
> return value from shrink_memcg(), the loop is guaranteed to terminate,
> either after MAX_RECLAIM_RETRIES failures or once the threshold is met.
> 
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Cc: stable@vger.kernel.org

How does this affect users?  What behavior do they observe when it
occurs?

> Closes: https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxWVrHiZZeLc=eyTPKPVQgX4g@mail.gmail.com

hm, that isn't really a bug report and doesn't answer the above
question.


AI review asked a couple of questions:
	https://sashiko.dev/#/patchset/20260729084206.77793-1-jiahao.kernel@gmail.com

Thanks.
