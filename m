Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F935B631;
	Thu, 18 Jun 2026 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781781360; cv=none; b=fFW9SaqSiEGHan5l1YKj79oOEl5C89iz9PEyApf9xIOBawGyfonLX8z6q0fhpTLyZeAqbYnTGhCplt0PVAnGFfMl+0mwMpYSf6ROsT/wbg5x+110ZYcWA55cJ7sSMghN/S5Ijv9n2dT3UpwP9ButUxzYkJXYkyx+JnOWULUu5OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781781360; c=relaxed/simple;
	bh=4Q6ZnwgQHwqg5bbKw3hGLIWY2Dv5wDy8lbefD8ZiA9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyuO9phQ+hu/b+zI1lTrJMHqaBckFRCZ/jcTyIgergBqw3B+piEOOr6HyuH5OKOgEa/khUXFVkQFFi4sfjrE+FTXcDIn64l8+L2jyjPYCyg3ZBtpwnGwyRRG0S42shd0acXPU5M9gE+8neFsZYwREd3XB5WVr6IMkGRtERPPw/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kvmpbuce; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rRCrU/dt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kvmpbuce";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rRCrU/dt"
Date: Thu, 18 Jun 2026 13:15:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781781356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJE+7NCV8kzvv1UOWk66G8/P9oEaUNRk4KpBY1gLjDk=;
	b=kvmpbuce0dLd1Ocvnfp2fxiXEVLOYCdxGQhjYri4DnBBXgDeAL3z9X1bXvhbgdbDTAXt2H
	Ehs/9DO/WsR1GzEjcw/XQAD4wdT4C7tyAQYG6vTdePje1oT/bYHNZdL1lV8DBy6ugejsCz
	8VAL43wwMH1epA627izyKSthKQO0fjEy+qtPv65nRKVQPK3ix1Wo7O4Gds654D0Iditkoo
	qwipMnco5ZCePHhKtezCWWN4hQaU2O1o0MttYs3K7A2eXuaMRSOwFwSN8T9Q1YZVJ0xCsm
	DxWJclgZwMe+DPPHxqFWc95I47i+Dy2pQeUAOdmZGRtlimMxIZdFggyruMqWnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781781356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJE+7NCV8kzvv1UOWk66G8/P9oEaUNRk4KpBY1gLjDk=;
	b=rRCrU/dtIx/rfIVmHIoUMY0R6lEnmjzmptJNMeng/g0IB4W7EY4n118Wa+naFibn9rrSCZ
	f6z76fHA67NktuDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vlad Poenaru <vlad.wing@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
Message-ID: <20260618111554.2n0pP_O9@linutronix.de>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616170257.GH49951@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260616170257.GH49951@noisy.programming.kicks-ass.net>

On 2026-06-16 19:02:57 [+0200], Peter Zijlstra wrote:
> On Tue, Jun 16, 2026 at 12:35:29PM +0200, Sebastian Andrzej Siewior wrote:
> 
> > So this is not an issue since commit 7eab73b18630e ("netconsole: convert
> > to NBCON console infrastructure"). Because from here now on writes are
> > deferred to the nbcon thread. So this purely about -stable in this case.
> 
> Hmm, I thought netconsole had some reserved skbs and could to writes
> 'atomic' like? That said, it was 2.6 era the last time I looked at
> netconsole.

Let's look at 8250 for a second in this scenario.
serial8250_console_write() -> uart_port_lock_irqsave(). The uart lock is
a spinlock_t. lockdep does not complain because printk annotates it as
with RT we have NBCONs mandatory and don't use this path.
serial8250_console_write() -> serial8250_modem_status() does a
wake_up_interruptible(). Even if not here, it is used under the port
lock so eventually lockdep will see it and complain about rq lock vs
port lock ordering.

> > Now. The scheduler usually does printk_deferred() because of the rq lock
> > so it does not deadlock for various reasons. It is kind of a pity that
> > the various WARN macros don't do that.
> 
> People have tried, last time was here:
> 
>   https://lkml.kernel.org/r/20260611074344.GG48970@noisy.programming.kicks-ass.net
> 
> and I hate deferred with a passion. It means you'll never see the
> message when you wreck the machine.

Oh, I do hate them, too. Maybe not as much because I spread my hate
evenly across the code. I did *miss* output on RT because the box
crashed before sending output so hate is here.

> > We could add printk_deferred_enter/exit() to all the rq_lock() variants.
> > I think PeterZ loves this the most. And Greg will appreciate it too
> > while backporting because of all the context changes.
> 
> No, not going to happen, ever, sorry. Instead printk should delete
> console sem and have printk() itself be atomic safe.

That was not meant serious but as a possibility.

> As stated, printk deferred is an abomination and needs to die a horrible
> painful death.
> 
> As described here:
> 
>   https://lkml.kernel.org/r/20260611191922.GK187714@noisy.programming.kicks-ass.net
> 
> "So printk should:
> 
>  - stick msg in buffer (lockless)
>  - print to atomic consoles (lockless)
>  - use irq_work to wake console kthreads (lockless)
>  - each kthread then tries to flush buffer to its own non-atomic console
>    in non-atomic context."

So we do this with nbcon afaik and this is the plan forward. The 8250 is
stuck behind broken flow control that John works tirelessly on fixing
before the 8250 can move over to the nbcon land. And some point it might
be possible to force-thread legacy consoles as we do it on RT or remove
them due to no users.

However until then and for stable I do suggest the following:

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 09e8eccee8ed9..9cba16474cb6e 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -115,6 +115,17 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 })
 #endif
 
+#define WARN_ON_DEFERRED(condition) ({						\
+	int __ret_warn_on = !!(condition);				\
+	if (unlikely(__ret_warn_on)) {					\
+		printk_deferred_enter();				\
+		__WARN_FLAGS(#condition,				\
+			     BUGFLAG_TAINT(TAINT_WARN));		\
+		printk_deferred_exit();					\
+	}								\
+	unlikely(__ret_warn_on);					\
+})
+
 #ifndef WARN_ON_ONCE
 #define WARN_ON_ONCE(condition) ({					\
 	int __ret_warn_on = !!(condition);				\
@@ -125,6 +136,18 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 	unlikely(__ret_warn_on);					\
 })
 #endif
+
+#define WARN_ON_ONCE_DEFERRED(condition) ({				\
+	int __ret_warn_on = !!(condition);				\
+	if (unlikely(__ret_warn_on)) {					\
+		printk_deferred_enter();				\
+		__WARN_FLAGS(#condition,				\
+			     BUGFLAG_ONCE |				\
+			     BUGFLAG_TAINT(TAINT_WARN));		\
+		printk_deferred_exit();				\
+	}								\
+	unlikely(__ret_warn_on);					\
+})
 #endif /* __WARN_FLAGS */
 
 #if defined(__WARN_FLAGS) && !defined(__WARN_printf)
@@ -159,6 +182,18 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 })
 #endif
 
+#ifndef WARN_ON_DEFERRED
+#define WARN_ON_DEFERRED(condition) ({					\
+	int __ret_warn_on = !!(condition);				\
+	if (unlikely(__ret_warn_on)) {					\
+		printk_deferred_enter()					\
+		__WARN();						\
+		printk_deferred_exit()					\
+	}								\
+	unlikely(__ret_warn_on);					\
+})
+#endif
+
 #ifndef WARN
 #define WARN(condition, format...) ({					\
 	int __ret_warn_on = !!(condition);				\
@@ -180,6 +215,11 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 	DO_ONCE_LITE_IF(condition, WARN_ON, 1)
 #endif
 
+#ifndef WARN_ON_ONCE_DEFERRED
+#define WARN_ON_ONCE_DEFERRED(condition)				\
+	DO_ONCE_LITE_IF(condition, WARN_ON_DEFERRED, 1)
+#endif
+
 #ifndef WARN_ONCE
 #define WARN_ONCE(condition, format...)				\
 	DO_ONCE_LITE_IF(condition, WARN, 1, format)
@@ -215,7 +255,9 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 })
 #endif
 
+#define WARN_ON_DEFERRED(condition) WARN_ON(condition)
 #define WARN_ON_ONCE(condition) WARN_ON(condition)
+#define WARN_ON_ONCE_DEFERRED(condition) WARN_ON(condition)
 #define WARN_ONCE(condition, format...) WARN(condition, format)
 #define WARN_TAINT(condition, taint, format...) WARN(condition, format)
 #define WARN_TAINT_ONCE(condition, taint, format...) WARN(condition, format)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3ebec186f9823..439379e6a83de 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5814,7 +5814,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 		/* in !on_rq case, update occurred at dequeue */
 		update_load_avg(cfs_rq, prev, 0);
 	}
-	WARN_ON_ONCE(cfs_rq->curr != prev);
+	WARN_ON_ONCE_DEFERRED(cfs_rq->curr != prev);
 	cfs_rq->curr = NULL;
 }
 

This plus this other occurrences in sched under rq lock.

If I replace the above WARN_ON_ONCE with
  WARN_ON_ONCE(system_state >= SYSTEM_RUNNING);

then my box fails to boot. Which means the warning seems harmful as of
today. The disgusting _DEFERERED workaround gets the box to boot until
we are in nbcon land.

Sebastian
