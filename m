Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1EB42848B
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323937; cv=none; b=RfpQw93xzKBkxKsltNrQ+d5N3BqI6gQvNYs6DeUKBgQa5iZlcy3xSPumkbrlot92F/S48SZZdcCflv/RQtdNFYFtMFzhuHAwupCyCEsZPhrVVYQaZ3bvSMzl2wLo9X+TLTRLvJd2f+zzIr3zgvCdGauLTD0YTK1CkK4PCF0wRE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323937; c=relaxed/simple;
	bh=bJ6I4X7RSLqQ9Pjm2NDdixe48SEQeISssbIgfDk4x94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAP4ejsnjfsPYDwp1BJCY+EyZqycUpU6W9wD6MKbz0Vr1JzpQfhdrcYWwFjIJKAAgn/Hl8u7297e+7RCMcOad1enLgozwh1jNiUca5boFlCu+S37Bx1vUARJVBdzIR0E0sOjzIS1oaj+v5OnHN1f0orsg33NH+F1JGxHwhZJvR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtGzqWXI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtGzqWXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5621F000E9;
	Fri, 21 Aug 2026 14:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787323934;
	bh=FPu5Ba2vxN4Ehz3rN3o5OsmHEpKoOzM4c7NaX06s4FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OtGzqWXIkeaR5FSG5F7bYwRURCKd7DWxtYmco7qx4ZVPmZvomi/Af1/ssrxmniXnI
	 3z3Wdw8LMKIdIPNpw79aeHfZmRyChtOVVCHVNx03QFemJ9qL+ZwwJEnasj6q9HPlQ6
	 e+vp1NhS7gAx/NIOKzD7XRbwfq/z2+0tzUb+lOQfhpOolkYIYgzpoGUFi3bZhphNmX
	 YUuW2FsE0iumd0bDOAYTMI5G27Kzfng2qCyoSG5gTSdDm+RpSpPtph7zxKvfF+deeD
	 /CLP6YoNowctv6Awrr2PpraNd9DReMaaSI59tRa+ESjjwRHFQdVGtcTICO20pTxSus
	 Ge+mU2Kr18iLw==
Date: Fri, 21 Aug 2026 16:52:10 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: intel-gfx@lists.freedesktop.org, 
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Chris Wilson <chris@chris-wilson.co.uk>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gt: Use signalers_lock to prevent starvation of
 irq_work.
Message-ID: <aohKIjZZ6Qjy8qGQ@zenone.zhora.eu>
References: <20260821114508.25669-1-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821114508.25669-1-dev@lankhorst.se>

Hi Maarten,

...

> @@ -208,13 +209,13 @@ static void signal_irq_work(struct irq_work *work)
>  	if (!signal && READ_ONCE(b->irq_armed) && list_empty(&b->signalers))
>  		intel_breadcrumbs_disarm_irq(b);
>  
> -	rcu_read_lock();
> -	atomic_inc(&b->signaler_active);
> -	list_for_each_entry_rcu(ce, &b->signalers, signal_link) {
> +	spin_lock(&b->signalers_lock);
> +	list_for_each_entry_safe(ce, next, &b->signalers, signal_link) {

without converting rcu lists to normal lists, can't we simply use
spinlocks around this for_each to avoid PREEMPT_RT starvation?

>  		struct i915_request *rq;
> +		bool release;
>  
> -		list_for_each_entry_rcu(rq, &ce->signals, signal_link) {
> -			bool release;
> +		spin_lock(&ce->signal_lock);
> +		while ((rq = list_first_entry_or_null(&ce->signals, typeof(*rq), signal_link))) {
>  
>  			if (!__i915_request_is_complete(rq))
>  				break;

...

> @@ -427,30 +424,87 @@ bool i915_request_enable_breadcrumb(struct i915_request *rq)
>  		return true;
>  
>  	spin_lock(&ce->signal_lock);
> +	b = READ_ONCE(rq->engine)->breadcrumbs;
> +
>  	if (test_bit(I915_FENCE_FLAG_ACTIVE, &rq->fence.flags))
> -		insert_breadcrumb(rq);
> +		add_context = insert_breadcrumb(rq, b);
> +
> +	if (add_context && spin_trylock(&b->signalers_lock)) {
> +		add_signaling_context(b, ce);
> +		spin_unlock(&b->signalers_lock);
> +		add_context = false;
> +	}
>  	spin_unlock(&ce->signal_lock);
>  
> +	if (add_context) {
> +		/*
> +		 * Fast trylock didn't work, use slow locking.
> +		 *
> +		 * Dropping the lock to solve the inversion is safe, since
> +		 * no race is possible against remove_signaling_context()
> +		 * without being added as signaling context.
> +		 */
> +		spin_lock(&b->signalers_lock);
> +		spin_lock(&ce->signal_lock);
> +		add_signaling_context(b, ce);
> +		spin_unlock(&ce->signal_lock);
> +		spin_unlock(&b->signalers_lock);

If I want to be a bit paranoic, a new request can be added in
between the two locking blocks and "add_context" is not valid
anymore.

add_signaling_context() already checks for ce->signals, but it
does not check whether ce->signal_link is already linked. Should
we also check !list_empty(&ce->signal_link)?

Thanks,
Andi

> +	}
> +
> +	/*
> +	 * Defer enabling the interrupt to after HW submission and recheck
> +	 * the request as it may have completed and raised the interrupt as
> +	 * we were attaching it into the lists.
> +	 */
> +	if (!READ_ONCE(b->irq_armed) || __i915_request_is_complete(rq))
> +		irq_work_queue(&b->irq_work);
> +
>  	return true;
>  }
