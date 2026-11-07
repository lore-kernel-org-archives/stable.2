Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.190.28.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794041785;
	b=ZMK/aM2enf7eQ8nb3Ah4iTQcysgu+q8MIkFn9rKPO4UZXlR3bL8Id8byVxhfj29gUrN5
	 Br6xeJpEB1KGx9GpXd163LUdC66U+IqvmkLwCyG9GEyfgBXCQdMPQgR97etKXIa+ejvBF
	 LpEczy3xjavZEh9gd76Kq91gfq5AhIMiiHoMBUpuQQC2sx9d8OArQ/kriyEHEqjxrNANs
	 R9aCbE43xiwM87kTC9VMdib5QnqOl9sOW3cK3C5ShZmZ7vX9VuUaxMJQxVoDwDeNl7OoD
	 T0xnQh0XFHXmFRMdrL3jhlxvXDAKbk2lrCQUI1OFOMBPawCaQhNBUIuhzvEHkUvJ1ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794041785;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=KqgTANG32Er6Jg57cJtaPHmu/UQaqMgRjuWUu0ykUL0=;
	b=BwLhTgmCOgbmCW8vCn33kdPH/JXQFblqJpTkqLbT1KkGhJz4wGqFyeqxlsbdG3vzjH7F
	 Dzxol99qA2LZrwM3RCY3/rfThkrvFNdko+kqop1mlm+bPu/1FneS6P5y0ohzrWHtdk6ZW
	 l9vHx3Uhd57Gi94dUqL9zMfHT8VkTvHxcFpq7UlpgYbzb+yYayWsyrXdXZpxZTH2M9LCu
	 o9Q6DVF4CHSVp0L+cL9rMBEkHrJMDEuRTRlfTXkQnU1Fx0Lz7ThGYw4D0eOD8Ax4i0gF0
	 r3ht+LjyT9si8PYyWOHKB11P4Hj8FL7I0mdnQrOhT1Czj504m3KNujbbMgKQUSLy2Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hardfalcon.net;
	spf=pass smtp.mailfrom=hardfalcon.net;
	dkim=pass header.d=hardfalcon.net header.i=@hardfalcon.net header.a=ed25519-sha256 header.s=dkim_2024-02-03 header.b=NPyK2wCD;
	arc=none smtp.remote-ip=213.190.28.75
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X448 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B64606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 08:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64B64606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=hardfalcon.net header.i=@hardfalcon.net header.a=ed25519-sha256 header.s=dkim_2024-02-03 header.b=NPyK2wCD
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1794041772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqgTANG32Er6Jg57cJtaPHmu/UQaqMgRjuWUu0ykUL0=;
	b=NPyK2wCD0FM3LSgqkb9xPWAk04rEXIalQnc4K5qdR+57QmNmSPZjFKuv5GkdAgIkVi5TAs
	bHtCQ2Ksxwov4xCA==
Message-ID: <c2569e78-f102-429a-a4a6-0b59d14226e1@hardfalcon.net>
Date: Sat, 7 Nov 2026 09:56:10 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: Patch "sched_ext: Fix the stall watchdog testing and blaming the
 wrong sched under bypass" has been
To: Sasha Levin <sashal@kernel.org>, Tejun Heo <tj@kernel.org>,
 stable@vger.kernel.org
References: <20261107013319.2604965-1-sashal () kernel ! org>
Content-Language: en-US, de-DE, en-US-large
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <20261107013319.2604965-1-sashal () kernel ! org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[2026-11-07 02:33] Sasha Levin:
> This is a note to let you know that I've just added the patch titled
> 
>     sched_ext: Fix the stall watchdog testing and blaming the wrong sched under bypass
> 
> to the 7.3-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      sched_ext-fix-the-stall-watchdog-testing-and-blaming.patch
> and it can be found in the queue-7.3 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit f62968b215d2977aef31c6c9eab21e3272c9f766
> Author: Tejun Heo <tj@kernel.org>
> Date:   Mon Oct 26 14:08:59 2026 -1000
> 
>     sched_ext: Fix the stall watchdog testing and blaming the wrong sched under bypass
>     
>     [ Upstream commit 93b1512ca69fbe3da66bbd2bab76e9ed74277679 ]
>     
>     While a sched is bypassing, its tasks are run by its host, the nearest
>     ancestor that isn't bypassing. check_rq_for_timeouts() tests a runnable task
>     against its owner's timeout. Since 2c91169377f4 ("sched_ext: Blame the DSQ's
>     owning scheduler for a runnable stall"), it ejects the sched owning the DSQ
>     the task waits on. The sched tested, the sched ejected and the sched running
>     the task can all differ.
>     
>     - Timeouts are per sched. A bypassing sub-scheduler with a 2s timeout under
>       a root with the default 30s has its tasks on the root's bypass DSQ. The
>       root, not bypassing itself, consumes that DSQ before calling
>       ops.dispatch() only on every other pass, and on the others only after
>       ops.dispatch() yields nothing. A task that waits 2s there ejects the root,
>       disabling all of sched_ext.
>     
>     - A bypassing owner's task on the local DSQ is blamed on the owner, which
>       places nothing while bypassing. If the owner is already exiting, e.g.
>       during its own disable, the exit is a no-op and nothing is ejected. If the
>       host isn't running the task, the owner's disable, which waits on it, may
>       never finish.
>     
>     - The wait isn't restarted when bypass moves a task. The time it waited
>       under its owner counts against the host once it is on the host's bypass
>       DSQ, and its time there against the owner once bypass lifts.
>     
>     The sched running a task is its owner, or the host while the owner is
>     bypassing. Test the task against that sched's timeout and blame it. A bypass
>     requeue can change the sched running a task, so restart the wait of every
>     task scx_bypass() requeues except the root's own, which the root runs
>     bypassing or not. Single-scheduler behavior is unchanged.
>     
>     A task that migrates while scx_bypass() works through the cpus, leaving one
>     before its requeue and arriving on another after it, is requeued by neither
>     and keeps its wait, which then counts against the sched now running it. That
>     is what happened to every task before this patch. This might be worth
>     addressing in the future, but the race is rare and the real-world
>     implications should be limited.
>     
>     Fixes: 2c91169377f4 ("sched_ext: Blame the DSQ's owning scheduler for a runnable stall")
>     Cc: stable@vger.kernel.org # v7.3+: 30fb2b1e4d41: sched_ext: Fix the running task keeping its protection into bypass
>     Cc: stable@vger.kernel.org # v7.3+: 5809f749fbdb: sched_ext: Fix a bypassed task stalling on a cpu its scheduler has no caps on
>     Cc: stable@vger.kernel.org # v7.3+
>     Reported-by: Andrea Righi <arighi@nvidia.com>
>     Link: https://lore.kernel.org/all/at4l0yXTk7T_ouk0@gpd4/
>     Reported-by: Sashiko <sashiko-bot@kernel.org>
>     Signed-off-by: Tejun Heo <tj@kernel.org>
>     Reviewed-by: Andrea Righi <arighi@nvidia.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 84774147a1d5b..28e04d1043a28 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -2235,7 +2235,8 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>  	/*
>  	 * Don't reset runnable_at. If @p is waiting, the wait continues across
>  	 * temporary dequeues, e.g. for a migration or an attribute change.
> -	 * scx_disable_task() ends it if @p leaves its scheduler.
> +	 * scx_disable_task() ends it if @p leaves its scheduler. scx_bypass()
> +	 * restarts it when its requeue can change the sched running @p.
>  	 */
>  	clr_task_runnable(p, false);
>  
> @@ -3844,24 +3845,17 @@ static bool check_rq_for_timeouts(struct rq *rq)
>  		goto out_unlock;
>  
>  	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node) {
> -		struct scx_sched *sch = scx_task_sched(p);
> +		/*
> +		 * @p's owner schedules @p, or its host while the owner is
> +		 * bypassing. Test @p against that sched's timeout and blame it.
> +		 */
> +		struct scx_sched *sch = scx_exec_sched(scx_task_sched(p), cpu_of(rq));
>  		unsigned long last_runnable = p->scx.runnable_at;
>  
>  		if (unlikely(time_after(jiffies,
>  					last_runnable + READ_ONCE(sch->watchdog_timeout)))) {
> -			struct scx_dispatch_q *dsq = READ_ONCE(p->scx.dsq);
>  			u32 dur_ms = jiffies_to_msecs(jiffies - last_runnable);
>  
> -			/*
> -			 * A task can be stuck on a DSQ that a sched other than
> -			 * its owner is responsible for draining, e.g. an
> -			 * ancestor's bypass DSQ while the owner is bypassing.
> -			 * Blame the drainer. The local DSQ is consumed by the
> -			 * cpu itself and keeps blame on the owner.
> -			 */
> -			if (dsq && dsq->sched && dsq->id != SCX_DSQ_LOCAL)
> -				sch = dsq->sched;
> -
>  			__scx_exit(sch, SCX_EXIT_ERROR_STALL, 0, cpu_of(rq),
>  				   "%s[%d] failed to run for %u.%03us",
>  				   p->comm, p->pid, dur_ms / 1000,
> @@ -6369,7 +6363,9 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
>  		 */
>  		list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list,
>  						 scx.runnable_node) {
> -			if (!scx_is_descendant(scx_task_sched(p), sch))
> +			struct scx_sched *owner = scx_task_sched(p);
> +
> +			if (!scx_is_descendant(owner, sch))
>  				continue;
>  
>  			/*
> @@ -6381,7 +6377,19 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
>  
>  			/* cycling deq/enq is enough, see the function comment */
>  			scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
> -				/* nothing */ ;
> +				/*
> +				 * The requeue can change the sched running @p,
> +				 * and the watchdog counts @p's wait against
> +				 * that sched. Restart the wait unless @owner is
> +				 * the root, which runs its own tasks bypassing
> +				 * or not.
> +				 *
> +				 * A dispatch in flight writes p->scx.flags
> +				 * without @p's rq lock. The dequeue waits it
> +				 * out, so set the flag after it.
> +				 */
> +				if (scx_parent(owner))
> +					p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
>  			}
>  		}
>  


Hi, this breaks the build for kernel 7.3.3 with the patches from stable-queue/queue-7.3 at commit id 77ecab77b25567c54df997dcb8030dea6bca03ed (which should be the equivalent of linux-stable-rc at commit id 11a9a1b1063f5f401fecb0ce486defa701c4cbe3), because the changed code tries to use the scx_exec_sched() function although that function doesn't exist (yet?) in the 7.3 branch. Removing this single patch *appears* to make the kernel compile again (I can't tell with 100% certainty at this point because my compile run hasn't finished yet).


Regards
Pascal
