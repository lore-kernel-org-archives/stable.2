Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB82261B70;
	Thu,  6 Aug 2026 07:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786000950; cv=none; b=qvMkpxrXsRdpOJrPuQT8O+2MghjhyMaLw9ItiHK3AXB+ulmeQLrL0NQXjJddq30DeatNumJIUY9FgB4SRov77rhhA/oJKmijkYjaCCpkAPae95EPRBtv+r+qSlCiif7iXptjxKoTY+YMheIh7HToeh6qRrJIV1yCG50Ilr41IGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786000950; c=relaxed/simple;
	bh=tMS1lHTJwD4nIfOZ6zEcCV6UsC8udIMq7Fpqn8A/txU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJMdCqhqlN0XJ3bFe7BauiOcQUf235fKQsqQk42SO4HCriuslmv6MbnpUAUJNI0RiU6KOrXbzx04mqmd7A7BDYqZY/44GlRGWg04HPAdZPRBv4lanC1MDQG6SJf82Ef2nMEOu5fFnl4RAP9dmh+XOXfTZWGRE1eaNVQzaXmZ438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IFDzEvgr; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IFDzEvgr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eqgJPcvmoGZCRUrrFBeKrp5WqdRAbRD8x/auNjcOY1I=; b=IFDzEvgrpG/IfSGlZAXLmjMLcv
	nNd3Ij7wosdirpMfU3ksBSufX99QRW3kp35ep4rx0r38pROavSGps0gENpC2iUNCWETUFXjk6poNA
	o+GwDo3K/cR2XPf4ZpFV4BaSnLU5tt4yXSFVybywY9J/9wqOC5jyOBXN/8GZft+WXYb3klPGG4cbI
	3Xbs6eNwjqwjN0JwsO7iwojTkJaoFj6mYjJaHc0ZmcnbUuEBELG3c1lwUBI7WJuYq45OrMce/7FkA
	GN1Hrxm0djjlnkXATv4W/gltrvz4ZBYzxojy44JeY7gjEszaz7BZFWjLk293qV5tcfKSOBFBWG1aA
	qWTzgpNQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wrsQl-0000000BHq7-1JIN;
	Thu, 06 Aug 2026 07:22:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 019C6300CC0; Thu, 06 Aug 2026 09:22:18 +0200 (CEST)
Date: Thu, 6 Aug 2026 09:22:17 +0200
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
Message-ID: <20260806072217.GL49951@noisy.programming.kicks-ass.net>
References: <20260806071740.83931-1-me@krystianslowik.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806071740.83931-1-me@krystianslowik.com>

On Thu, Aug 06, 2026 at 09:17:40AM +0200, Krystian Slowik wrote:
> Since commit 650952d3fb38 ("sched: Make __do_set_cpus_allowed() use the
> sched_change pattern"), do_set_cpus_allowed() dequeues and re-enqueues
> the target task through the sched_change guard whenever it is queued.
> 
> The idle task counts as queued: init_idle() sets
> idle->on_rq = TASK_ON_RQ_QUEUED. But the idle sched class implements no
> real dequeue_task() (only the "bad: scheduling from the idle thread!"
> debug stub, which even drops and re-takes the rq lock in the middle of
> the guarded section) and no enqueue_task() at all, so running the guard
> on the idle task jumps through a NULL pointer in sched_change_end():
> 
>   bad: scheduling from the idle thread!
>   CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Kdump: loaded Not tainted 7.0.0-28-generic #28-Ubuntu PREEMPT(lazy)
>   Call Trace:
>    dequeue_task_idle+0x29/0x50
>    dequeue_task+0xfb/0x300
>    sched_change_begin+0x1ff/0x240
>    migrate_disable_switch.isra.0+0xf8/0x190
>    __schedule+0xdd/0x650
>    schedule_idle+0x22/0x40
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor instruction fetch in kernel mode
>   RIP: 0010:0x0
>   Call Trace:
>    enqueue_task+0x89/0x1d0
>    sched_change_end+0x18e/0x1d0
>    migrate_disable_switch.isra.0+0x11e/0x190
>    __schedule+0xdd/0x650
>    schedule_idle+0x22/0x40
>    do_idle+0xb6/0xf0
>    cpu_startup_entry+0x29/0x30
>    start_secondary+0x125/0x180
> 
> The path is reachable since commit 942b8db96500 ("sched: Fix
> migrate_disable_switch() locking") moved migrate_disable_switch() to
> the top of __schedule(), where it runs on every schedule out of the
> idle loop rather than only on an actual context switch: any
> migrate_disable() taken in the idle loop (e.g. from a tracing or BPF
> callback) that is still held when the idle task schedules triggers the
> pinning path.
> 
> Pinning the idle task is meaningless to begin with: it is a per-CPU
> task that can never migrate. Skip it. This also keeps
> ___migrate_enable() unreachable for the idle task, since its cpus_ptr
> is never repointed.
> 
> The check uses p == rq->idle rather than is_idle_task(), because the
> latter also matches idle-injection threads (PF_IDLE), which are
> ordinary queueable tasks.
> 
> Observed in production on two separate x86-64 machines running the
> Ubuntu 7.0.0-28 kernel, both panicking from the idle loop with the
> oops above.

What is actually doing migrate_disable() here? Why would the idle thread
ever hit this...
