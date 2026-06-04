Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1083D6663;
	Thu,  4 Jun 2026 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566322; cv=none; b=GK40KfHRQY8bzKlGxiFYLc3GPpCv0Hz/VWpYCwu5nKvqsxlplbBu0GdOTpUSvU6EW+e3xmFzLX4UjE0TheyyU/KZJtwyrwUTEqXaNYLb01pOP8w5gSDUoQpFD2yXWC5cb4RRzGOlnLTKgKclJ9gKasc18YXCVFhEWfj8DpTn7ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566322; c=relaxed/simple;
	bh=uWPYqwAIeWq9LA2hGNbF5VYO0LCMtPcVW339ZDlXh7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nm9PkEZlFmXJxJBPDcEwne4H8lmvpdv9Ey/bAD74E5HU1pGt0cyFTQi9QGyvqabzxpA149Qds1ZCOtZcr8+cfdzPcmZbGpeG5d5e89jn2S5eDKNRLGZzSJDQFe62jy6l7AvMvuLiYivNWqQPGCCQTXvlUedm8/WnUIE/4gsUQ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9JhUyhO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9JhUyhO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DBF1F00893;
	Thu,  4 Jun 2026 09:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780566321;
	bh=4gI8mD8pV6k1RYY2Wo8KeiJELh7kTkv3Ol2p2Vg4X6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G9JhUyhO3Qv+dYNWdEn8rWiK0J5nZC2FNsRT9Xp6vlDR/zNMvlINAjg64xxZYYqPV
	 6Nbn5fjuVsbNrAGe3q44tTLNV/H+jUqBX0JTZQv/FSZ7rfBTq3cQq42r84BVwDoM8m
	 9ZsPVrdesGnvqulog0iNVdix30fSd1EDxwNRQxK/RYnSE0BOcM5b60ottXImRlGwFn
	 3QQoauw1uOZMCSdIiLaeOxgxBpvZtHneksAH0T5LtOHP/rKAvA673fSBw8apkKr2MM
	 nJwYoQeK7rBzMgDjdL53PZ/OBi7tsOHJsuC+j3mWlBYiEv/NpVJNJZRQUJ62/CTwAZ
	 WCXo2s5XmOJhg==
Date: Thu, 4 Jun 2026 11:45:18 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Amit Matityahu <amitmat@amazon.com>
Cc: tglx@kernel.org, anna-maria@linutronix.de, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, dwmw@amazon.co.uk, jonnyc@amazon.com,
	abaransi@amazon.com, alonka@amazon.com, ronenk@amazon.com,
	farbere@amazon.com
Subject: Re: [PATCH] timers/migration: Fix livelock in
 tmigr_handle_remote_up()
Message-ID: <aiFJLiWDIVaMQOoV@localhost.localdomain>
References: <20260603170139.33628-1-amitmat@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603170139.33628-1-amitmat@amazon.com>

Le Wed, Jun 03, 2026 at 05:01:39PM +0000, Amit Matityahu a écrit :
> tmigr_handle_remote_cpu() skips timer_expire_remote() when cpu ==
> smp_processor_id(), assuming the local softirq path already handled
> this CPU's timers.
> 
> This assumption breaks when jiffies advances between
> run_timer_base(BASE_GLOBAL) and tmigr_handle_remote() in the same
> softirq invocation - a timer expires after the wheel ran but before
> the hierarchy snapshot is taken.
> 
> The stranded timer is never collected,
> fetch_next_timer_interrupt_remote() keeps reporting it as expired,
> and the event is re-queued with expires == now on each iteration.
> The goto-again loop spins indefinitely.
> 
> Fix by calling timer_expire_remote() unconditionally.
> __run_timer_base() already returns early when there is nothing to
> expire, making this a no-op in the common case.
> 
> Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
> Cc: stable@vger.kernel.org
> Reported-by: Alon Kariv <alonka@amazon.com>
> Cc: Jonathan Chocron <jonnyc@amazon.com>
> Cc: Akram Baransi <abaransi@amazon.com>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Amit Matityahu <amitmat@amazon.com>

That's quite serious indeed!

> ---
> 
> Questions for maintainers:
> 
> 1. What was the original rationale for the cpu != smp_processor_id()
>    check? There is no code comment, commit message explanation or anything
>    in the original patch's email discussion as to why
>    timer_expire_remote() is skipped for the local CPU.

The rationale was about assuming that such an expired timerqueue actually
reflected a timer that was handled locally already and so it could be safely
discarded. So we could spare some locking.

> 
> 2. There seems to be a design tension where a CPU can have timers
>    visible in the migration hierarchy while simultaneously running its
>    own local softirq. Is the expectation that run_timer_base() always
>    drains everything before tmigr_handle_remote() sees it, or should
>    the remote path handle local-CPU timers as a fallback?

That's not easy to defer all global timers handling to remote expiration
because the current CPU may or may not be the migrator.

> 
>  kernel/time/timer_migration.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> index 1d0d3a4058d5..298c34c942ae 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -978,8 +978,7 @@ static void tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
>  	/* Drop the lock to allow the remote CPU to exit idle */
>  	raw_spin_unlock_irq(&tmc->lock);
>  
> -	if (cpu != smp_processor_id())
> -		timer_expire_remote(cpu);
> +	timer_expire_remote(cpu);

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!

>  
>  	/*
>  	 * Lock ordering needs to be preserved - timer_base locks before tmigr
> 
> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
> -- 
> 2.47.3
> 

-- 
Frederic Weisbecker
SUSE Labs
