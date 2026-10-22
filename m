Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672618;
	b=iNH36PfoaUqCN05LkHYJ/g7YCnOVwIZEXmvDsCfQe8mWHU6fc0cUqKZmxVlIuH6jO3g7
	 uJQNlx40hXsnCHdHexBmGQBTHcgN3RRr0345d0UnYq9WgbErdc01yLVgwyi8Sw8LZ8WCB
	 cZWfHpRqarTSX5VGtKkx7JwJyMEG6kajePc4kuLXceNsj7bAPMtpdMq/6cbMM/HPYtaoc
	 ev8iBdaC97fJdJmY0dqVPdKVs59wA64svXGSjk1po4p7/Df0N2NVaeGQQE67y2ugl2stF
	 DmUSg1xQTKSBA91g3mgeyyBmSuzUoDS6eW85gWwEozI++ebL4oRJ1O4X+QYgL/GuXGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672618;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=2AVYDVIfgqfkP0XMmMllKTp+e7zNLw0N1Ot5Z6OeEQ0=;
	b=dAcI6PrsghQniEG7T/gqVLkogShBUiMIK8fAurE3KLdiQYnz8DfhgWJz2aQScC0qstsP
	 xnNOjHFXB94ciUjWUPdFLG5l0lBiTmwbFucsLfyjeBI8muQoQnSgGcwp/DIsEqYGPF8ik
	 1EfC5bADTzUZ6js+dGQf4yJQDM1bYS3RBQMpOKvXlVWuK5ixeelQnBfhCAIkLmy1D5ei8
	 1LZpIiKmkb9TXiUWWWfiW1r5bW1EuAaU3btfSc0zUwDCqZPrNBMt+xischcHV+GdtSAXd
	 mDnOth/JPMdCLJNZooxonWVziOFipqjJQ+sF5jdKCO25wepRkmv3Xfsxs2ORV/rcRFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiAmWkn6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD35606A319;
	Thu, 22 Oct 2026 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiAmWkn6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595711F000C1;
	Thu, 22 Oct 2026 12:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792672617;
	bh=2AVYDVIfgqfkP0XMmMllKTp+e7zNLw0N1Ot5Z6OeEQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZiAmWkn6gV977xjzSfELCTexHhfd7cQ28a8A2y7P5QiuAz3cfvAhBt2nR2Ik8CTIM
	 yPoXr4vp/MSxBZmBnVsfaZAupj9yDUTA4k+C3OgHodJ7oEwkb3PqFUwBapWTlNDQIk
	 RFldXGSu2oL1jaT1Vre3tCgKVNNGz2dN8QGw2o8XEMUB5ak3MNVuPdsdMI56OA317h
	 MilcAXPLRuNoIxq7dCn4G3V1zp9pFObS3J1ejFUiIXguny83OzUlPGqA9Cy9OtDhor
	 K7z7TDaitCqsjAcSQxg7aTn+ryqVRLBQftOvtXNDTr4/lUhpYm+FD7A1O1OdHHUpgO
	 tSBtqbmBIVCqQ==
Date: Thu, 22 Oct 2026 14:36:55 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, tom.leiming@gmail.com, hare@suse.de, dwagner@suse.de,
	tj@kernel.org, sean@ashe.io, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	marco.crivellari@suse.com
Subject: Re: [PATCH v4] blk-mq: dispatch kworker to housekeeping CPU when
 hctx cpumask is empty
Message-ID: <atoDZ85GTNGyaNPL@localhost.localdomain>
References: <20261022034737.47820-1-atomlin@atomlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261022034737.47820-1-atomlin@atomlin.com>

(Adding Marco)

Le Wed, Oct 21, 2026 at 11:47:37PM -0400, Aaron Tomlin a écrit :
> Commit a46c27026da1 ("blk-mq: don't schedule block kworker on isolated
> CPUs") excluded isolated CPUs from hctx->cpumask to prevent worker
> threads from executing block work on isolated CPUs. When all CPUs mapped
> to a hardware queue are isolated (i.e. blk_mq_hctx_empty_cpumask(hctx)
> evaluates to true), blk_mq_hctx_next_cpu() returns WORK_CPU_UNBOUND with
> the intention of offloading execution.
> 
> However, kblockd_workqueue is allocated as a per-CPU workqueue
> (WQ_PERCPU). When WORK_CPU_UNBOUND is queued on a per-CPU workqueue, the
> workqueue core resolves the target CPU via raw_smp_processor_id().
> Consequently, if a task executing on an isolated CPU submits I/O and
> triggers an asynchronous queue dispatch with zero delay (e.g. upon
> hardware queue congestion, tag/resource exhaustion returning
> BLK_STS_RESOURCE, or plugging), &hctx->run_work is queued directly onto
> the local isolated CPU's worker pool. This causes the local per-CPU
> high-priority kworker (e.g. "kworker/6:1H-kblockd") to be scheduled on
> the isolated CPU. In real-time environments, an active SCHED_FIFO workload
> will starve this SCHED_NORMAL worker, causing hardware dispatch to stall,
> in addition to introducing unwanted latency jitter on nohz_full cores,
> thereby defeating the original objective of commit a46c27026da1.
> 
> Introduce blk_mq_hctx_unbound_cpu() to select an online housekeeping CPU
> from housekeeping_cpumask(HK_TYPE_DOMAIN) via
> cpumask_any_and_distribute() when executing on an isolated CPU, and
> otherwise fall back to WORK_CPU_UNBOUND. Use this helper across the
> unbound fallback paths in blk_mq_hctx_next_cpu().
> 
> Additionally, for single-queue devices, gate the check behind the static
> key housekeeping_overridden under CONFIG_CPU_ISOLATION to ensure that
> common configurations without CPU isolation incur zero overhead on the
> fast path.
> 
> This ensures that:
>     1.  When executing on an isolated CPU, deferred queue work is
>         cleanly offloaded to an online housekeeping CPU across single-queue
>         devices, hardware queues with empty cpumasks, and offline CPU
>         fallback paths.
> 
>     2.  The per-CPU high-priority kworker on the isolated CPU is not
>         scheduled, avoiding priority inversion and latency jitter.
> 
>     3.  When executing on a non-isolated CPU, WORK_CPU_UNBOUND is
>         preserved, maintaining optimal local execution with zero CPU
>         bouncing while avoiding timer pinning hazards.
> 
>     4.  On systems without CPU isolation, single-queue devices maintain
>         the zero-overhead fast path via a static key.
> 
> Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
> Changes since v3:
> 
>  - Create companion blktests test case (block/050) to reproduce this issue
>    and verify the fix (Daniel Wagner)
> 
>  - Gate the single-queue (nr_hw_queues == 1) check behind the static key
>    housekeeping_overridden under CONFIG_CPU_ISOLATION to ensure the
>    common case without CPU isolation incurs zero overhead on the fast
>    path (Jens Axboe)
> 
>  - Wrap the evaluation of cpu_is_isolated() inside guard(rcu)() in
>    blk_mq_hctx_unbound_cpu() to prevent an RCU lockdep warning and ensure
>    safe dereferencing of the housekeeping cpumask while concurrent cpuset
>    updates occur
> 
>  - Disable preemption via guard(preempt)() around cpumask_any_and_distribute()
>    to prevent a preemption warning under CONFIG_PREEMPT_RCU and avoid
>    data races when accessing per-CPU distribution state
> 
>  - Link to v3: https://lore.kernel.org/all/20261016052203.489760-1-atomlin@atomlin.com/
> 
> Changes since v2:
> 
>  - Query housekeeping_cpumask(HK_TYPE_DOMAIN) instead of HK_TYPE_TIMER
>    to align with cpu_is_isolated(), workqueue affinity rules, and cpuset
>    isolated partitions
> 
>  - Query the housekeeping cpumask under guard(rcu)() to safely handle
>    dynamic cpuset updates without lockdep warnings
> 
>  - Validate that cpumask_any_and_distribute() returns a valid cpu ID
>    before returning, falling back cleanly to WORK_CPU_UNBOUND
> 
>  - Link to v2: https://lore.kernel.org/lkml/20261015020225.422107-1-atomlin@atomlin.com/
> 
> Changes since v1:
> 
>  - Introduce the blk_mq_hctx_unbound_cpu() helper to steer deferred work
>    to an online housekeeping CPU only when executing on an isolated
>    core, preserving WORK_CPU_UNBOUND and local cache locality for
>    housekeeping cores
> 
>  - Apply blk_mq_hctx_unbound_cpu() across all unbound fallback paths in
>    blk_mq_hctx_next_cpu(), comprehensively covering single-queue devices
>    (nr_hw_queues == 1), empty hardware queue cpumasks, and the offline
>    CPU fallback path.
> 
>  - Elaborate in the commit log on the triggers for asynchronous queue
>    dispatch (e.g. tag exhaustion, BLK_STS_RESOURCE backpressure, and
>    plugging) and the SCHED_FIFO worker starvation hazard on isolated
>    cores
> 
>  - Link to v1: https://lore.kernel.org/lkml/20261012012905.267920-1-atomlin@atomlin.com/
> ---
>  block/blk-mq.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 025a799f35b9..f8f862a0e525 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2241,6 +2241,23 @@ static bool blk_mq_hctx_empty_cpumask(struct blk_mq_hw_ctx *hctx)
>          return hctx->next_cpu >= nr_cpu_ids;
>  }
>  
> +static inline int blk_mq_hctx_unbound_cpu(void)
> +{
> +	guard(rcu)();
> +
> +	if (cpu_is_isolated(raw_smp_processor_id())) {
> +		int cpu;
> +
> +		guard(preempt)();
> +		cpu = cpumask_any_and_distribute(housekeeping_cpumask(HK_TYPE_DOMAIN),
> +						 cpu_online_mask);
> +		if (cpu < nr_cpu_ids)
> +			return cpu;
> +	}
> +
> +	return WORK_CPU_UNBOUND;
> +}

Just for future record, we are working on a WQ_PREFER_PERCPU workqueue flag that
should automatically handle this sort of things. It's not ready for now so these
hacks are still necessary but keep in mind this is a good candidare for future
simplication.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
