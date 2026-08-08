Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5744A4B04B7;
	Sat,  8 Aug 2026 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786174764; cv=none; b=GHAyzJiGvi6vi1TiAQ8mONkBk8/cK0NydI7RI27SuY6xuvvTFE4usYw8uILJaFZCHMs01wMqZo0qK6OwEjfiSbeK1xE2vmmdeHOnL6UjGZbeplJu2uppHjvymNSVi0gvYG1spl8OTseqLIxGK5hZGcdVxhLIfYqSUqpfNWFF2xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786174764; c=relaxed/simple;
	bh=mgeanBQ1k/1en+JCuP0z5CXbKEJj2IheRnA0/9ssZlM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hz7A9z6BWw0ZxfKwzyTRD7d3TUTbRukU5t0l+dmkELzUKTepAO3JrDmd8M3MO7ZYiZDpy61P0CInjX+j4aL0Bf8oJxI4YsYbavNjIJhQUCUsOwJrvLqKxmMlQ0AwEyArtqPoUhhBYeeVLlV0JhXBhMJgtXkceziDwOOhHJn1Ym0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pzi2XBnq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pzi2XBnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C32A1F000E9;
	Sat,  8 Aug 2026 07:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786174762;
	bh=fTqmss+78C12rcL4AP/UtiB7LfHQKq113VHbYFFrqcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=pzi2XBnqjj3cs7kAMZAN+DoWvhbfRQqAvRkg1oPN0Q8iVowtqU6yJ3pCnbMBdycGT
	 h5aykI8H+JU7shpXU7Pg6MrEMK7Hj86T2nrGYMpY26CVqSPc9KIWD8mtE2mEApQRJI
	 QlOtPZBeaT4c5tTNcAw41Qvr0b9ZrJ+bhPC+QLHE=
Date: Sat, 8 Aug 2026 00:39:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hui Su <sh_def@163.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Zqiang
 <qiang1.zhang@intel.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] kasan: fix cache shrink race with CPU hotplug
Message-Id: <20260808003921.fdb0df9ee4417b38f15e8c68@linux-foundation.org>
In-Reply-To: <20260808031459.3032812-1-sh_def@163.com>
References: <20260808031459.3032812-1-sh_def@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  8 Aug 2026 11:14:59 +0800 Hui Su <sh_def@163.com> wrote:

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
> An intermittent occurrence was observed with a virtio-9p filesystem.
> The mount and umount commands both returned 0, but the kernel logged
> the following during the userspace-triggered teardown:
>
> ...
>

Thanks, I'll queue this for testing while we await maintainer review.

AI review suggests that there's a pre-existing quarantine_size
accounting flaw later in this function:

	https://sashiko.dev/#/patchset/20260808031459.3032812-1-sh_def@163.com

If true, I'm surprised this hasn't yet been reported.


Also, I'd like to see a need_resched() wrapping that expensive

		/* Scanning whole quarantine can take a while. */
		raw_spin_unlock_irqrestore(&quarantine_lock, flags);
		cond_resched();
		raw_spin_lock_irqsave(&quarantine_lock, flags);


