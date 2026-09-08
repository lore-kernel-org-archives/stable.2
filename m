Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921C54A1DF9;
	Tue,  8 Sep 2026 11:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865796; cv=none; b=PsDcjbhmQfh4Ldk3oyjae1pLs+31SvI8natOEUcfiihCJbHXWoRmbuEhdMiLL1kYJzfO8TW65TOZaS0k0ASftBRLPwkwcum5/yd2IKYZ4GGTbksS7uCtgUDl9OXlE3hipKZ8t1igm/loaLke1OxJ7sIbWlFx/YNQC4vWH46keZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865796; c=relaxed/simple;
	bh=HVH+A1GFz/X/2yj/naeeVPja5EEA11lro9gRX6J4Dgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGpYrj8DMEr90XP7+Ur0bTt24k0SlKUPDA5EM3NFH7ArGjzwdpQLnBlt6PwMrXQg1cr9MxO4GYCWU1sKOLR/ugyP/8IUwlxKPCxSlEcOtVlK/9jymDDAIuLKFtaY91wTIx7ay2LxcRb9lReYo49rWcH7CPEJIf5mZscdqPin1Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PUhJwgub; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PUhJwgub"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UoLoCYuddeXG7gpeaiQD110KDRCd319GS7KzMnh1Upc=; b=PUhJwgubQBHYABXl7YDZBTuH82
	dqcb/YlVf/HnSL94YGP6LyGVJDLrLVZC95nzwJe3prP6vj3qzB6E/EbTHt5NUQEkH4a9oNxeqCdTn
	q2kPHiWzX3aJbT5daETTDWsQFHMIiwgazNtmOYnnnN+Z0l1PSwikemwmL+uBxuVSWR1SUJYrMQJjG
	Mgaqh9zFekFl7xfTuVNz5qydmB3vm1hcGrZtMw7CoJk/KrTprQ/jZIwbNbyCvSoAcz7R98UX5c1G2
	rWISrNWq8oeoc4azvtWKsSO/DOQDE8BA2cf+M0ytASaGn7ej6s1PBwEbvhGJoLqP/25e0p4mIKFq3
	VbSwyWDg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x3thz-0000000HJzf-1cAd;
	Tue, 08 Sep 2026 11:09:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AB5BB300400; Tue, 08 Sep 2026 13:09:46 +0200 (CEST)
Date: Tue, 8 Sep 2026 13:09:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hrtimer: Use hard expiry when updating timers on the
 same base
Message-ID: <20260908110946.GE687043@noisy.programming.kicks-ass.net>
References: <20260907211134.3854-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907211134.3854-1-parri.andrea@gmail.com>

On Mon, Sep 07, 2026 at 11:11:33PM +0200, Andrea Parri wrote:
> Rearming a queued timer with nonzero slack can leave the timerqueue out
> of order. remove_and_enqueue_same_base() checks the new soft expiry
> against its neighbours' hard expiries, then stores the new hard expiry
> in the node without requeueing it.
> 
> For example, with A at 10 and B at 20, rearming A at 11 with slack 30
> passes the neighbour check but leaves A's hard expiry of 41 before B's
> 20. The same function also caches the soft expiry in base->expires_next
> when updating or inserting the first timer, giving next-event selection
> an earlier deadline than the queue head's hard expiry.
> 
> Compute the hard expiry with the same saturating addition used by
> hrtimer_set_expires_range_ns(). Use it for the in-place ordering check
> and both updates to base->expires_next.
> 
> Fixes: eddffab8282e3 ("hrtimer: Keep track of first expiring timer per clock base")
> Fixes: 343f2f4dc5425 ("hrtimer: Try to modify timers in place")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

Urgh!

> ---
>  kernel/time/hrtimer.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 530d61257b9a0..c5940323746db 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1261,6 +1261,7 @@ static inline bool
>  remove_and_enqueue_same_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
>  			     const enum hrtimer_mode mode, ktime_t expires, u64 delta_ns)
>  {
> +	ktime_t hard_expires = ktime_add_safe(expires, ns_to_ktime(delta_ns));
>  	bool was_first = false;
>  
>  	/* Remove it from the timer queue if active */
> @@ -1268,11 +1269,11 @@ remove_and_enqueue_same_base(struct hrtimer *timer, struct hrtimer_clock_base *b
>  		was_first = !timerqueue_linked_prev(&timer->node);
>  
>  		/* Try to update in place to avoid the de/enqueue dance */
> -		if (hrtimer_can_update_in_place(timer, base, expires)) {
> +		if (hrtimer_can_update_in_place(timer, base, hard_expires)) {
>  			hrtimer_set_expires_range_ns(timer, expires, delta_ns);
>  			trace_hrtimer_start(timer, mode, true);
>  			if (was_first)
> -				base->expires_next = expires;
> +				base->expires_next = hard_expires;
>  			return was_first;
>  		}
>  
> @@ -1291,7 +1292,7 @@ remove_and_enqueue_same_base(struct hrtimer *timer, struct hrtimer_clock_base *b
>  
>  	/* If it's the first expiring timer now or again, update base */
>  	if (timerqueue_linked_add(&base->active, &timer->node)) {
> -		base->expires_next = expires;
> +		base->expires_next = hard_expires;
>  		return true;
>  	}

Can't we do something like so?

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 530d61257b9a..8c157c4fa699 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1263,13 +1263,16 @@ remove_and_enqueue_same_base(struct hrtimer *timer, struct hrtimer_clock_base *b
 {
 	bool was_first = false;
 
+	/* Set the new expiry time */
+	hrtimer_set_expires_range_ns(timer, expires, delta_ns);
+	expires = timer->node.expires;
+
 	/* Remove it from the timer queue if active */
 	if (timer->is_queued) {
 		was_first = !timerqueue_linked_prev(&timer->node);
 
 		/* Try to update in place to avoid the de/enqueue dance */
 		if (hrtimer_can_update_in_place(timer, base, expires)) {
-			hrtimer_set_expires_range_ns(timer, expires, delta_ns);
 			trace_hrtimer_start(timer, mode, true);
 			if (was_first)
 				base->expires_next = expires;
@@ -1280,9 +1283,6 @@ remove_and_enqueue_same_base(struct hrtimer *timer, struct hrtimer_clock_base *b
 		timerqueue_linked_del(&base->active, &timer->node);
 	}
 
-	/* Set the new expiry time */
-	hrtimer_set_expires_range_ns(timer, expires, delta_ns);
-
 	debug_activate(timer, mode, timer->is_queued);
 	base->cpu_base->active_bases |= 1 << base->index;
 
