Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226A547F783;
	Thu,  6 Aug 2026 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786049488; cv=none; b=LFMlxA+uAgCST5ET7CC6yVM/Z9yuPgZVWcUZtP4X8MzVONfC80GI1B3ESNFafyuF1Elfm2/AraWFkmBCx9uG503E4JEK7FpjoioQIuCJ5oLsB8YKj1h/MsbZDvxVu6CosbvfuwNGvqwrRUUcQf6JZEy+LBM3b/ADgF8Tb0WTpRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786049488; c=relaxed/simple;
	bh=r5Yqbyzhel4WtjqbPPKjUBoZaBDqYdF5SBShBhrsrPY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O394ABzwjv5IH3F0OZXSX1pjYFgdsNzlhitQtP1llVP2ZCP6YYSaPy5a3H7cvzs8mMhRjPQmMNsDMB6665v7JNSrrPUxgn8g2+TQU6rIA2vtnlRN3zptsrR5xjvgMsNo6RBghllGyPo4d3ZaO/+macj2wcarVMd3guSPV0WNRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C+YcwY3+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C+YcwY3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD571F000E9;
	Thu,  6 Aug 2026 20:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786049486;
	bh=f/m0Pt9rEkujk538tJlotLFHiaCNx9L5OrF4ncWFhCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C+YcwY3+ewj4f0V7oB5VXGbSj1kdSurp7xQ3JeQvZ0e76GRfp7ZziDK4QxiiVT99/
	 23yekx32zhI9sbpbAFuD1/Z0M0DiEBP8Ky7FVjN80qD/VnKfv0ougEsrUMQ3vUk/AY
	 9VgYvGOuST1VvOVERpEdQpJd42M2s/3mUv0bm/Hw=
Date: Thu, 6 Aug 2026 13:51:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hui Su <sh_def@163.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Zqiang
 <qiang1.zhang@intel.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kasan: fix cache shrink race with CPU hotplug
Message-Id: <20260806135125.a444f867993cb3cd3122551e@linux-foundation.org>
In-Reply-To: <20260806121006.1642946-1-sh_def@163.com>
References: <20260806121006.1642946-1-sh_def@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Aug 2026 20:10:06 +0800 Hui Su <sh_def@163.com> wrote:

> kasan_quarantine_remove_cache() first invokes per_cpu_remove_cache() on
> all online CPUs. Each callback moves objects belonging to the cache from
> cpu_quarantine to the CPU's shrink_qlist, where they can later be freed
> from task context.
> 
> kmem_cache_destroy() invokes the quarantine removal path while holding
> cpus_read_lock(), but kmem_cache_shrink() does not. The latter can
> therefore race with CPU offlining as follows:
> 
>   kmem_cache_shrink()             CPU hotplug
>   -------------------             -----------
>   on_each_cpu()
>     CPU1 moves objects to
>     CPU1's shrink_qlist
>   on_each_cpu() returns
>                                   CPU1 goes offline
>                                   kasan_cpu_offline()
>                                     drains cpu_quarantine
>                                     leaves shrink_qlist untouched
>   for_each_online_cpu()
>     skips CPU1
> 
> The objects left on CPU1's shrink_qlist are not returned to the slab
> allocator. This may prevent kmem_cache_shrink() from releasing slabs
> that would otherwise become empty. If CPU1 remains offline, a later
> kmem_cache_destroy() also skips the list and can report that the cache
> still contains objects.
> 
> Per-CPU shrink_qlist storage exists for every possible CPU, and each
> list is protected by its own raw spinlock. Iterate over possible CPUs
> so that a list populated before its CPU went offline is drained as well.

Thanks.

Please always describe the userspace-visible runtime effects of a bug
when proposing a fix.

> Fixes: 07d067e4f2ce ("kasan: fix sleeping function called from invalid context on RT kernel")
> Cc: stable@vger.kernel.org

Especially when proposing a backport.  At present we've provided our
-stable recipients no reason to accept the patch.

Documentation/process/stable-kernel-rules.rst says "it must fix a real
bug that bothers people".


> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -355,7 +355,12 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
>  	 */
>  	on_each_cpu(per_cpu_remove_cache, cache, 1);
>  
> -	for_each_online_cpu(cpu) {
> +	/*
> +	 * A CPU can go offline after on_each_cpu() returns, leaving cache
> +	 * objects on that CPU's shrink list. Scan all possible CPUs to
> +	 * drain those lists.
> +	 */
> +	for_each_possible_cpu(cpu) {

In some configurations, for_each_possible_cpu() can do a lot more work
than for_each_online_cpu().  What are the worst-case userspace-visible
runtime effects of this additional work?


