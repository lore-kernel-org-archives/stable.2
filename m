Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE19D502571;
	Tue, 13 Oct 2026 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791928466; cv=none; b=WP3RJd7YuB2Fo/BJSIvJSrF0Kq3Di1656ZbsLgTg9xELcMxHLiyy7BiqXuKrB4qW/JLhmOYdLuYbCTinbgrTShovJ7PgVTmQhoPj/79ZGGBpll31efSA/8rFV9r/qkw/mIbG9JzlXRx8mvUuUQaHmzidystdwvTnwI6IPIMaHSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791928466; c=relaxed/simple;
	bh=2b35TF7LOb6wCrZ7GrIZsWJ/HzEZVN5CL/Oyt+DT+8U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Dr95S3tlWT2qUqgrlanpue0ZVUYwpMTrSZZBqAhr5f3IEgR6JupdhMr0c/C6eLG4zwc5H5TGpil4a/byJC5pBckLs4i1d3VQfqm43+8Fd/LJvuKdH7+uIYH/40M0EfFKTIhlIv8/4mVZ0WpXacnC9eqOI0vYKwaB6RfgSpN52To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1URnK6SZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1URnK6SZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28791F000FF;
	Tue, 13 Oct 2026 21:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791928465;
	bh=iLbY2L194GuSxlWbJvMphR/amPsNZN4yp/IavVHxfYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=1URnK6SZvCssZJpm7tqIDh/YRPM26motAbIWUINR/TKD9dTwdd+Q45eZi0OvBEUQG
	 0iZ2xyhwx+xPORnq5/GaoVnb87XlVDJR/RW0MS+TdH9yPpZMvseTNMhcKmqm9ieGIF
	 LSDvWbh1XKsM11BcXjPnbFpJgBmIyYqLD4XbHY7A=
Date: Tue, 13 Oct 2026 14:54:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Harry Yoo (Meta)" <harry@kernel.org>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph
 Lameter <cl@gentwo.org>, Suren Baghdasaryan <surenb@google.com>, Hao Ge
 <hao.ge@linux.dev>, kernel-team@meta.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/percpu: account full object size for percpu memory
 allocations
Message-Id: <20261013145424.341cb25ffdd488297bffd1a1@linux-foundation.org>
In-Reply-To: <20261013-fix-alloc-percpu-accounting-v1-1-03e788a1e41f@kernel.org>
References: <20261013-fix-alloc-percpu-accounting-v1-1-03e788a1e41f@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 20:34:39 +0100 "Harry Yoo (Meta)" <harry@kernel.org> wrote:

> When memory allocation profiling is enabled, the pages backing percpu
> memory chunks are attributed to func:pcpu_alloc_pages. However, the
> accounting of individual percpu memory allocations via alloc_percpu()
> and friends record only the size of a single object rather than its
> full size across all CPUs.
> 
> As a result, it is often not straightforward to identify which kernel
> code is actually responsible for percpu memory, because the size is
> under-accounted by a factor of num_possible_cpus().
> 
> Account full object size with pcpu_obj_full_size(size) instead, which
> multiplies the object size by num_possible_cpus() and adds the objcg
> pointer overhead. This is consistent with what memcg already does for
> charging percpu allocations.
> 
> Verified with 64-CPU VM by spawning 400 processes in a memory cgroup and
> measuring mm_init()'s rss_stat counters.
> 
> Delta of kernel/fork.c:1142 func:mm_init in /proc/allocinfo:

Please make it use mm_init() rather than func:mm_init.

> 
>                   bytes   calls   per allocation
>     unpatched      6320     395         16
>     patched      418176     396       1056
> 
> 'percpu' field in memory.stat: 422400 (1056 bytes per process)
> 
> Memory allocation profiling now accounts the same amount of memory as
> what memcg charges.

Fair enough.

> Cc: stable@vger.kernel.org

Why cc:stable?


