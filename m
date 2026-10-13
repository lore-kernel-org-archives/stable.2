Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2455476CA;
	Tue, 13 Oct 2026 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930200; cv=none; b=e1nP1rtz+uMBhDEaByhzCjab5aQU1ATlIDJDkWYLmE76eOP+5rYKY9VIgXVuz1OneRV7A238gFvr8Myd+Jpirs8L42UebD4yH8mpyvVXnygLzaJIAdlBvtZR3t5OJ2a+aPvykvCcgdoQwTSuYPyAWsSO1r0NYI/w5HVMJmewbnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930200; c=relaxed/simple;
	bh=TQDEb1YIpMtVal/FY+gKoX25/3dPtFGXbrHHciApVaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shMbkbR0ArIvQ8/Yfn2WtUSJBqC7PwgNZ81zy6gCCAhxf6x/kRVxwqZbf9jXj6RvxL5OMkvwqK51GkRlW+mHtxAcN5fRQNo7OvWCHW1pkJ8vPzgnq2vgrEobLj7avWhIhIU+c3QOD2UxXObB7SC/2C9BfDWn8OB4kMHPhXZnu+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbVHmQjn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbVHmQjn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFADF1F000FF;
	Tue, 13 Oct 2026 22:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791930199;
	bh=3B0t0pdUPQGVbD/gYqKOzHdQS5+TzS1sAbmVd8BmAOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HbVHmQjniSdrw4laRku1zJeS7ADy9DQNNJGRWW/2zecE+CC0aCmk7Eahfai3NuAO/
	 dsyxCQoCwPRS4eEvkzidDE1gyq1gXJWZ26wa6nR9azrXf8Qe6mzHJCV6tsDd1X0c8q
	 ya6XT2Mcl5NMdzqYRZvJuUERl29POpqBdK0d1/B1ZdKsHoNCsjtzI2qoontsuZdNir
	 JfuOQn8o5YgkGSjftARoSXunQ/HLt6qaaE6Xq9uevirNZw9OnQQPSn0TlNc2bAilYP
	 3sKtMrjF5AHNopSU1yIp9KZQRK6amhb4+08RcApa9ivMzkjLR9Kph/J4grSOw7Iie8
	 q79KXmXj/GUzQ==
Date: Tue, 13 Oct 2026 23:23:17 +0100
From: Harry Yoo <harry@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Suren Baghdasaryan <surenb@google.com>, 
	Hao Ge <hao.ge@linux.dev>, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/percpu: account full object size for percpu memory
 allocations
Message-ID: <as6q8H5qxb5Gd471@thinkpad>
References: <20261013-fix-alloc-percpu-accounting-v1-1-03e788a1e41f@kernel.org>
 <20261013145424.341cb25ffdd488297bffd1a1@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013145424.341cb25ffdd488297bffd1a1@linux-foundation.org>

On Tue, Oct 13, 2026 at 02:54:24PM -0700, Andrew Morton wrote:
> On Tue, 13 Oct 2026 20:34:39 +0100 "Harry Yoo (Meta)" <harry@kernel.org> wrote:
> 
> > When memory allocation profiling is enabled, the pages backing percpu
> > memory chunks are attributed to func:pcpu_alloc_pages. However, the
> > accounting of individual percpu memory allocations via alloc_percpu()
> > and friends record only the size of a single object rather than its
> > full size across all CPUs.
> > 
> > As a result, it is often not straightforward to identify which kernel
> > code is actually responsible for percpu memory, because the size is
> > under-accounted by a factor of num_possible_cpus().
> > 
> > Account full object size with pcpu_obj_full_size(size) instead, which
> > multiplies the object size by num_possible_cpus() and adds the objcg
> > pointer overhead. This is consistent with what memcg already does for
> > charging percpu allocations.
> > 
> > Verified with 64-CPU VM by spawning 400 processes in a memory cgroup and
> > measuring mm_init()'s rss_stat counters.
> > 
> > Delta of kernel/fork.c:1142 func:mm_init in /proc/allocinfo:
> 
> Please make it use mm_init() rather than func:mm_init.

This is the output format of /proc/allocinfo:
https://docs.kernel.org/filesystems/proc.html#allocinfo
> Example output.
> 
>  > tail -n +3 /proc/allocinfo | sort -rn
> 127664128    31168 mm/page_ext.c:270 func:alloc_page_ext
>  56373248     4737 mm/slub.c:2259 func:alloc_slab_page
>  14880768     3633 mm/readahead.c:247 func:page_cache_ra_unbounded

> > 
> >                   bytes   calls   per allocation
> >     unpatched      6320     395         16
> >     patched      418176     396       1056
> > 
> > 'percpu' field in memory.stat: 422400 (1056 bytes per process)
> > 
> > Memory allocation profiling now accounts the same amount of memory as
> > what memcg charges.
> 
> Fair enough.
> 
> > Cc: stable@vger.kernel.org
> 
> Why cc:stable?

For anyone who uses memory allocation profiling to understand which
code locations allocated how much memory, it gives a false impression
that certain perpcu memory allocations are not as big as they actually
are.

On some workloads percpu memory (func:pcpu_alloc_pages) shows up as one
of the biggest memory allocations, but the actual users of percpu
memory allocator don't show up as they are under-reported.

-- 
Cheers,
Harry / Hyeonggon
