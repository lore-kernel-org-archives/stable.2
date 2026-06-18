Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359C12F8E98;
	Thu, 18 Jun 2026 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794687; cv=none; b=fb1mbL4wZEEyZ3rn/aR4OEwAKzgmaM7BCX2wb/OVdCF/4iQjPxx7APh02xpFO1G/r3wxqshnhL8vdsKodGI2tE8cuo+EtGEDgLUPHcQLQGrnmZ5KWtXG88WouR7kWAwdN6/ejbgaTbDt6tL2Gxk3GTTDW8GFXdj3UmW65lR6kX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794687; c=relaxed/simple;
	bh=Lb4FyC7Ekz69u+9qsy/xF8Lzb83LcMb7fj8UNOSj6rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7GLdydCgz6vhFqhBhxNgXRPUKlye56LlZ7AT2KAFc/buBG97BUNEeDvyyujzkwc2phhaR7NP3rE/TpSH27rondlE3zLkOoSxd2o/ZnNE3Y6nBUDtNHida1Bj7jGXQ3xf5AynwrMZ9SawBvvE6xGcebFucryutyXvnKL6bTqzsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=n/ef3PsJ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="n/ef3PsJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dNVBwl6tN837Jk/0emEDMWa6+L0egY10+e608sAc88E=; b=n/ef3PsJ8p87f0Z+21HMnx+2UJ
	0yQg6sdrnP6oYPRXwS7GLFKDiVpxH28j+bI3RlsQVU/pgfWrv388yGp14WqSQyVr3Db6Zv1hZN+EI
	JceaOVp/MHX3XD69EDs/IT/fGAdG1bXDg44wvXcsYUfIQnPrTYs5YJoBnTTUhAHjr+p4cSudfjLg4
	kNTTyFZ5lfst/9rtVbDur4M02XD5eYStaY1lfmSeb3nPWPC0woA5k/05cYyzwiBy8J/z62WK8anET
	4kRAFep4T5k5BMANYXDjrJmBTili214RRGCGwGAlHd30Ln547QAXBJrqG6u1sqUWsjd8XZF0jCvk3
	w0mIHXxQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1waEBY-00FT83-0v;
	Thu, 18 Jun 2026 14:57:40 +0000
Date: Thu, 18 Jun 2026 07:57:33 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Vlad Poenaru <vlad.wing@gmail.com>, 
	Thomas Gleixner <tglx@kernel.org>, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
Message-ID: <ajQFMS4ucT-mybhi@gmail.com>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616170257.GH49951@noisy.programming.kicks-ass.net>
 <20260616141719.67684bf0@kernel.org>
 <ajJ46o4fomfxY5CX@pathway.suse.cz>
 <20260617111958.GL49951@noisy.programming.kicks-ass.net>
 <ajKi4wtA8U1iZkMD@gmail.com>
 <20260617132127.645534d1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617132127.645534d1@kernel.org>
X-Debian-User: leitao

On Wed, Jun 17, 2026 at 01:21:27PM -0700, Jakub Kicinski wrote:
> On Wed, 17 Jun 2026 07:56:50 -0700 Breno Leitao wrote:
> > As far as I can tell, there isn't a network driver today whose transmit
> > path is completely lockless, so, even if we make netpoll lockless.
> > 
> > It's unlikely any NIC will ever achieve this, given that NIC TX
> > fundamentally relies on a shared DMA ring and doorbell register, which
> > inherently cannot be made lockless.
> 
> The lock which protects the queue is maintained by the stack,
> and we trylock it. Maybe I lost the thread but if you're saying
> that writes to netconsole are impossible from arbitrary context,
> that is _not_ true, AFAIU. We can queue a packet and kick off 
> the transfer on well-behaved drivers.
> 
> Main problem is the opportunistic freeing up of the queue space.
> If we could avoid that in atomic context I think we'd be good.

Thanks for the clarification, this is quite valuable.

Let me verify my understanding: if we switched to __raise_softirq_irqoff()
in dev_kfree_skb_irq_reason(), the issue would be resolved since we'd
avoid waking ksoftirqd and therefore wouldn't touch the runqueue lock in this
code path.

However, while that would eliminate the nested lock problem, it could
increase memory pressure by delaying SKB garbage collection, which may
not be acceptable.

Naive question: What if we deferred SKB cleanup only during netpoll operations?

Such as tracking in_netpoll per cpu:

		struct softnet_data {
			....
	+ 		bool                    in_netpoll;
		}

and then choosing between __raise_softirq_irqoff() and raise_softirq_irqoff()?

	@@ -3456,7 +3456,13 @@ void dev_kfree_skb_irq_reason(struct sk_buff *skb, enum skb_drop_reason reason)
		local_irq_save(flags);
		skb->next = __this_cpu_read(softnet_data.completion_queue);
		__this_cpu_write(softnet_data.completion_queue, skb);
	-       raise_softirq_irqoff(NET_TX_SOFTIRQ);
	+       if (__this_cpu_read(softnet_data.in_netpoll))
	+               __raise_softirq_irqoff(NET_TX_SOFTIRQ);
	+       else
	+               raise_softirq_irqoff(NET_TX_SOFTIRQ);
		local_irq_restore(flags);
	}


Is it too hacky!?

Thanks,
--breno
