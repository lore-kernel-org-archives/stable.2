Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943EC5616B4;
	Tue, 13 Oct 2026 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933147; cv=none; b=ZCmcg7S5JQ+IFywcwN/jL2j/p2P3v2q0O73EgVMBY3xSEiVBBNZ9ljYuSjDy7flAYIvgv6ZXn/KuKXk5O1MCoOry0G9tpnVn6ErwTnvgkUvyOHGdBuBETibZD7vS/ge5kgMH0E0Jt5HYc/fikA+ZBuLzGKEk/QTpiONlrOC2qJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933147; c=relaxed/simple;
	bh=Hoqy9Bxw203545uH9ZKZrV9cb8QHxKQAGEjDHea9Zx0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TWkPY7t337RQSl716KZNgVv+0mcLqO03bpOYshZSKuEn6Kt0bxsV++HtbOVt4wAGMOD3mkzTDWsnE1C13TW47pBXoTwLWuJr4tOh9TxQL/xXfl4e2u9dJXIg6W/jg4YE0WrZPMauY429hL5jG0dS/5+x+00ljKZHAAJImlYYcWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nh0uxDtZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nh0uxDtZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB341F000FF;
	Tue, 13 Oct 2026 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791933146;
	bh=chWKPe6Jv6DSrpAzSu8B8yBVA/m1DZxXRX4ZIJ40tPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nh0uxDtZ9iwQ1ZIEtlXgAVgxR0jRhYBNM8kDLNiv95iV5WEL1a3Sp9b6a6OaHqemf
	 3aqCellWqqAGtRlWzYIuN+WL2rdrschvIrwVoQ6yopfczTVqRn3qCDIZeX6ZJ76LPi
	 8TnyEBudwHh0wO4116e4p5lnM1SOpT47j/JdypWI=
Date: Tue, 13 Oct 2026 16:12:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Harry Yoo <harry@kernel.org>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph
 Lameter <cl@gentwo.org>, Suren Baghdasaryan <surenb@google.com>, Hao Ge
 <hao.ge@linux.dev>, kernel-team@meta.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/percpu: account full object size for percpu memory
 allocations
Message-Id: <20261013161225.9286887bec0ee7fe6627aadd@linux-foundation.org>
In-Reply-To: <as6q8H5qxb5Gd471@thinkpad>
References: <20261013-fix-alloc-percpu-accounting-v1-1-03e788a1e41f@kernel.org>
	<20261013145424.341cb25ffdd488297bffd1a1@linux-foundation.org>
	<as6q8H5qxb5Gd471@thinkpad>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 23:23:17 +0100 Harry Yoo <harry@kernel.org> wrote:

> On Tue, Oct 13, 2026 at 02:54:24PM -0700, Andrew Morton wrote:
> > On Tue, 13 Oct 2026 20:34:39 +0100 "Harry Yoo (Meta)" <harry@kernel.org> wrote:
> > 
> > > When memory allocation profiling is enabled, the pages backing percpu
> > > memory chunks are attributed to func:pcpu_alloc_pages. However, the
> > > accounting of individual percpu memory allocations via alloc_percpu()
> > > and friends record only the size of a single object rather than its
> > > full size across all CPUs.
> > > 
> > > As a result, it is often not straightforward to identify which kernel
> > > code is actually responsible for percpu memory, because the size is
> > > under-accounted by a factor of num_possible_cpus().
> > > 
> > > Account full object size with pcpu_obj_full_size(size) instead, which
> > > multiplies the object size by num_possible_cpus() and adds the objcg
> > > pointer overhead. This is consistent with what memcg already does for
> > > charging percpu allocations.
> > > 
> > > Verified with 64-CPU VM by spawning 400 processes in a memory cgroup and
> > > measuring mm_init()'s rss_stat counters.
> > > 
> > > Delta of kernel/fork.c:1142 func:mm_init in /proc/allocinfo:
> > 
> > Please make it use mm_init() rather than func:mm_init.
> 
> This is the output format of /proc/allocinfo:

oh, OK.

> https://docs.kernel.org/filesystems/proc.html#allocinfo
> > Example output.
> > 
> >  > tail -n +3 /proc/allocinfo | sort -rn
> > 127664128    31168 mm/page_ext.c:270 func:alloc_page_ext
> >  56373248     4737 mm/slub.c:2259 func:alloc_slab_page
> >  14880768     3633 mm/readahead.c:247 func:page_cache_ra_unbounded

Well that's odd.  What can a caller be other than a function?

> > 
> > Why cc:stable?
> 
> For anyone who uses memory allocation profiling to understand which
> code locations allocated how much memory, it gives a false impression
> that certain perpcu memory allocations are not as big as they actually
> are.
> 
> On some workloads percpu memory (func:pcpu_alloc_pages) shows up as one
> of the biggest memory allocations, but the actual users of percpu
> memory allocator don't show up as they are under-reported.

OK.  I guess it's a small deal, but a larger deal for allocinfo users!
