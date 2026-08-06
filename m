Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CDD3DAAD4;
	Thu,  6 Aug 2026 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025684; cv=none; b=YfqMFRCJCJEWkM66Gbg/O49RrBX0Xb6ZhTJg44fq7NpijPIZvkfMGGFGgRsskZIhsp1TZo5Bjze1Q3/92Z2lN3IZ3EQEZAmH2EBMdZjVxzcRfUlxJPwG/ezFbNdvAYz4ch8knoC88KkXgTa+IC1QIXmvIINUfiI3+OKxhta+PpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025684; c=relaxed/simple;
	bh=AUDdSohbvjhYzBJau+83iFI895fGYlEEAj20t+OYgxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtbYtgYKR5pHKrQjB7xahX9CxyFxHyM7AOWoWf+OyMr1rke5pAIVpnaGwbh6J/1kNMr+1fUobn45P9Q/7X/OKFtsero6OJnABPKuYZZKNbh7sXJEPYXlWBw3t+NLJ0aHDoYV7omdSDSd3uFct5KiNnAgHxbdSRNIgJl2h+ekuOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZzJMCe+w; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZzJMCe+w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8JTERntFCWMtQX6/E7f1GLM7DEgjXwdKdV8Wxozt9iU=; b=ZzJMCe+wv1xe6F5nQHvRm5sWLb
	Nyhy3GtlXj/1OPGSAjd7/xp8Xy8vBDLefjQTsL72j7uE9Do4KOSi+USSWhWgdlbtCAmDwp5+vjRzA
	fbztn7EsIjcPB8wAK0rSP5x8C9y4voPhtrSjcwe7MPw6SvSNg2CTqZ7nrYWy4yMNZDJ3tSAq5exkA
	xigAc4lWqlianq3d+Wn50kxGJUYoJJp9u/nZaT7ljKMIFtTytsGuLwUhsl+pCUSJKkrX/URA7oPmL
	BeHbtBynwwFyv7bIPz0z0RJb/FYRJQDU+9BID6GtrYrB9k92wY8CfpjYBiC2x2CoEk/Y6S/9++ezk
	7TYwDRKw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wryrX-0000000BYOA-1YoV;
	Thu, 06 Aug 2026 14:14:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AB7FD30045A; Thu, 06 Aug 2026 16:13:51 +0200 (CEST)
Date: Thu, 6 Aug 2026 16:13:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Krystian Slowik <me@krystianslowik.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] sched/core: Don't pin the idle task in
 migrate_disable_switch()
Message-ID: <20260806141351.GN49951@noisy.programming.kicks-ass.net>
References: <20260806072217.GL49951@noisy.programming.kicks-ass.net>
 <20260806090139.20495-1-me@krystianslowik.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806090139.20495-1-me@krystianslowik.com>

On Thu, Aug 06, 2026 at 11:01:32AM +0200, Krystian Slowik wrote:
> [Resend as plain text, the lists rejected my first attempt for HTML.]
> 
> > What is actually doing migrate_disable() here? Why would the idle thread
> > ever hit this...
> 
> Nothing, as far as I can tell. I went back into the vmcore and the
> counter didn't come from migrate_disable() at all:
> 
>   swapper/3->migration_disabled == 8      /* 0b1000 */
>   cpu3 rq->nr_pinned == 0
>   the other 15 idle tasks: 0 and 0
> 
> That pair can't come from the API. Surrounding bytes are clean, the
> whole anomaly is one set bit:
> 
>   swapper/2 +2416: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>   swapper/3 +2416: 00 00 00 00 00 00 00 00  08 00 00 00 00 00 00 00
>                    migration_pending        ^^ migration_disabled
> 
> A second dump from the same box two days later (rcu_cblist_dequeue,
> unrelated) has all 16 idle tasks at 0.
> 
> Correction to my patch description while I'm here: "two separate
> machines" was wrong, both idle-loop oopses are the same box.
> 
> Fleet context, since it changes how much you should care: three
> Ryzen 7 7840HS boxes, no ECC, DDR5 at JEDEC 5600, no EXPO. Same
> board, BIOS and microcode, identical apart from DIMM vendor and SSD.
> Taint 0 on all three, no out-of-tree modules ever, BPF is systemd
> cgroup boilerplate only. Two of the three have produced corruption
> oopses over five weeks (css_rstat_flush GPF twice at the same RIP
> plus a slab freelist on one, the rcu_cblist fault plus this bit flip
> on the other), and they were on different kernel builds at the time.
> So I can't separate a scribbler from a platform fault yet. DDR5
> on-die ECC makes marginal cells the less likely half, though it's
> SEC per burst so not excluded. Memtest next, with low expectations
> at 11 events in five weeks.

Oof, memory corruption is a pain.

> Which makes this not a fix but an assertion, and the stable Cc
> should go. If you want it at all:
> 
>     if (likely(!p->migration_disabled))
>         return;
> 
>     if (WARN_ON_ONCE(p == rq->idle))
>         return;
> 
> behind the existing early return, so the hot path doesn't pay for it
> and the state screams instead of oopsing under the rq lock.
> 
> Placement is a guess though. Anything reaching do_set_cpus_allowed()
> with p == rq->idle hits the same missing enqueue_task(), so
> sched_change_begin() might be the better home. And if you'd rather
> not paper over corruption in the scheduler at all, that's a fine
> answer too. The thread already answered the question I actually had.

Well, do_set_cpus_allowed() or any of the other sched_change users. I
think I'm leaning towards no change here, as you found we already get a
'nice' splat if this happens. Additionally, tripping a WARN inside
schedule() is commonly fatal all on its own (printk likes to do a
wakeup, which doesn't really work all that great from inside the
scheduler -- this is being worked on on the prink side).

Thanks!
