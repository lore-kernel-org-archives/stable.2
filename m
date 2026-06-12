Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E99028C2A1;
	Fri, 12 Jun 2026 07:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781248881; cv=none; b=i6ljCpPlMxoxcZfion6fJPooFPFQotnGmhFCxHklFdPq51qLE1zkMQZxjG7OY7KUpWRaFuM2ObYxhHRFUYdFs6FTApHBkNmLR1lwifWm/oZtnXLTRszRt/j2urUXsHN+q51oChX2jPn3M2RfzR3rvKydELLfFYfKlt5irDxzPSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781248881; c=relaxed/simple;
	bh=BtKo2A0QgcltJ9m1dlsBtgJJWnQ7TNgQwxMy3bgVK2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItUrgdsxLP9FGhA9PhiT80Vr5TdDIKS0klG8NY0MIHWpiGtWNONKtGwZHtTHko8rBPIiK5hTnU4WYa5TaIZHsHiob2PG05Z5xxdzCWP/0G1VK0jNZqyBDU/aw7W+nEzRgK+yWvmWYQscG5+mXJB9a1geYLWgdBo5kf2gd0j3lPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PB0Ba+SN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PB0Ba+SN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h8ENVMjf1uMEpzt8YW7jdaVX+LrwHEufa96AeJ7JWAU=; b=PB0Ba+SNulcjALMzbFBU5gV8yu
	zCj1DoXGcXVadqtlirOy6AlcxtbHD2aEfbtF3IdTchQeCTzVSlEqyAm5Vg1Frklub/PCAtyRRM6Zq
	cTK02m2j2pWwEqcTmk2o7z1PAyUtg58yc9uatuk60bJ19mGaKxNBcF7lMS4WzBofVSjCVtqDOKUdj
	NZw5jmV7CpWlJsTySLHDCB1xO3J6fCVoytfns8QxRldONQr4BCNgW39WvEA7gHDVTLHgeVoDWeYKx
	amPkP1zRB7cglqNnUo9XcWhpuw1YocwMJtHyDg88yJWu2xaM+fn+fgK8IIjZgaCJXsgBR02ziM3lm
	8IMW5AUg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXwCS-00000003KRb-0FxV;
	Fri, 12 Jun 2026 07:21:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 551DB300673; Fri, 12 Jun 2026 09:21:07 +0200 (CEST)
Date: Fri, 12 Jun 2026 09:21:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, bsegall@google.com,
	dietmar.eggemann@arm.com, juri.lelli@redhat.com,
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
	mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
	vincent.guittot@linaro.org, vschneid@redhat.com,
	shakeel.butt@linux.dev, hannes@cmpxchg.org, riel@surriel.com,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] block: invalidate cached plug timestamp after task switch
Message-ID: <20260612072107.GR187714@noisy.programming.kicks-ass.net>
References: <20260611231428.345098-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611231428.345098-1-usama.arif@linux.dev>

On Thu, Jun 11, 2026 at 04:14:28PM -0700, Usama Arif wrote:
> blk_time_get_ns() caches ktime_get_ns() in current->plug->cur_ktime
> and marks the task with PF_BLOCK_TS. That cache is only valid while the
> task keeps running; if the task is switched out, wall-clock time
> advances and the cached value must not be reused when the task runs again.
> 
> The existing invalidation covers explicit plug flushes through
> __blk_flush_plug(), and the schedule() / rtmutex paths through
> sched_update_worker(). It does not cover in-kernel preemption paths such
> as preempt_schedule(), preempt_schedule_notrace(), and
> preempt_schedule_irq(), which enter __schedule(SM_PREEMPT) directly and
> return without calling sched_update_worker().
> 
> As a result, a task preempted while holding a plug with PF_BLOCK_TS set
> can reuse a stale plug->cur_ktime after it is scheduled back in. blk-iocost
> then consumes that stale timestamp through ioc_now(), producing stale vnow
> values for throttle decisions, and through ioc_rqos_done(), inflating
> on-queue time and feeding false missed-QoS samples into vrate
> adjustment.
> 
> Move the schedule-side invalidation to finish_task_switch(), which runs
> for the scheduled-in task after every actual context switch regardless
> of which schedule entry point was used. Keep __blk_flush_plug() as the
> explicit flush/finish-plug invalidation path, and remove only the
> PF_BLOCK_TS handling from sched_update_worker().
> 
> Fixes: 06b23f92af87 ("block: update cached timestamp post schedule/preemption")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  kernel/sched/core.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8b791e9e9f67..bf024ca115ff 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5368,6 +5368,13 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>  	 */
>  	kmap_local_sched_in();
>  
> +	/*
> +	 * Any cached block-layer timestamp (plug->cur_ktime) is stale now,
> +	 * invalidate it.
> +	 */
> +	if (unlikely(current->flags & PF_BLOCK_TS))
> +		blk_plug_invalidate_ts(current);

Can you make that just blk_plug_invalidate_ts() and move the branch into
the function itself, which is already inline anyway (but perhaps upgrade
it to __always_inline).
