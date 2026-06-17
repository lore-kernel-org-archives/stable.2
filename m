Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1E22E7366;
	Wed, 17 Jun 2026 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716054; cv=none; b=hvwLABRuBNHYWUsgC9nJYx28XLZZu8dm2EeKZoP3o04ydI05EjEw4CSGiz16bHG3cAoam+/rkgz9Ko7s9OmXPuSmlyq5+gJdHC2ESFiWFAI8cMYgRzF8H9oUn5wp6tAAP0IOd5n56omhBEiKUeuy41icYv2wkg0dELhL/ikAdhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716054; c=relaxed/simple;
	bh=CdO6GuWUMsqqpmI3hePH+gTeyLJw015sL9ngEmNcebc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NFLEJFPuVd8VTlC9dKT7mtyBicP7ELs8DSYOdMYI/VJi+Bix8NIt76VpC4DvKkNyR7FzmVD+qG/GXbiiPRR1v4AvN/gfjaR3qA1qrac3o5bS8JSeUj7VCzN7Ar6/BmrR6tyRejOwIri98at1MnKR1ZO62Qku+HHzw7nw2Jl+odk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gErmhBUn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GzrX3dNx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gErmhBUn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GzrX3dNx"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781716051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q73pIfa8DydxtdtESZl0olKxdjpT7x7LJITthS02nJQ=;
	b=gErmhBUnwRuw1tSGilBNIaBkcq0NWMtDzpqoeAhnqa6lLhgQcVELC2BNydogeHppHqMAei
	0HwFTn/0YbT0zGfkvfuv5br1hX2LHrySSseLGnz/EQ5x7Xa8X4TpQMx4xwKQz5Ari12R9w
	pYRB5rvil8BofkV6CE413XTEdZ88LhSYuaZXEBHsFKPDrHjWUiJZITzlbNWSK0btmh0QD1
	ujG0PXMJNKRorZOpFlkI7GQmQigkI2gi3HXUTpK/Kkr2wBJ+fqoCs88pRnisBLYwMPNFbg
	1LFYR1JB8qJcflAkBxucYzQGu6i8CqzVZFP/VQzZLJwyxwRXeb9XINyEoBlU4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781716051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q73pIfa8DydxtdtESZl0olKxdjpT7x7LJITthS02nJQ=;
	b=GzrX3dNxVo14HRlgSgC8gWRqPk5gWUo8wJMIMmeHraUi9veuFpEw+ectUW9v+9ZIh/SX9O
	JkpkxXf7DWnMY8BQ==
To: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>, Jakub Kicinski <kuba@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Vlad Poenaru <vlad.wing@gmail.com>, Thomas
 Gleixner <tglx@kernel.org>, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
In-Reply-To: <ajKi4wtA8U1iZkMD@gmail.com>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616170257.GH49951@noisy.programming.kicks-ass.net>
 <20260616141719.67684bf0@kernel.org> <ajJ46o4fomfxY5CX@pathway.suse.cz>
 <20260617111958.GL49951@noisy.programming.kicks-ass.net>
 <ajKi4wtA8U1iZkMD@gmail.com>
Date: Wed, 17 Jun 2026 19:13:30 +0206
Message-ID: <87tsr1m6y5.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-06-17, Breno Leitao <leitao@debian.org> wrote:
> On Wed, Jun 17, 2026 at 01:19:58PM +0200, Peter Zijlstra wrote:
>> But anything using locking is not ->write_atomic() and should be driven
>> from a kthread, no?
>
> Good point. If that's the case, netconsole might not ever be able to drop
> CON_NBCON_ATOMIC_UNSAFE for any network-based console driver at all. 

It depends on what it needs to synchronize against. For example, the
UART consoles cannot write if the port lock is taken by another
context. And the port lock is the sole lock for writing to the UART. To
deal with this, we added wrappers [0] for acquiring/releasing the port
lock. The wrappers acquire the nbcon hardware after taking the port
lock.

The write_atomic() implementations for UART consoles do not take the
port lock. Only the nbcon hardware is acquired (which can be done from
any context). This automatically provides the synchronization based on
the port lock.

> As far as I can tell, there isn't a network driver today whose transmit
> path is completely lockless, so, even if we make netpoll lockless.
>
> It's unlikely any NIC will ever achieve this, given that NIC TX
> fundamentally relies on a shared DMA ring and doorbell register, which
> inherently cannot be made lockless.
>
> So, is it correct to state that CON_NBCON_ATOMIC_UNSAFE will be part of
> netconsole forever-ish?

Is there some lock that can be taken to synchronize all writing of
packets to the network? If yes, the netconsole can use a similar
solution.

That is an example of a general solution, but individual drivers may be
able to provide unique solutions, such as dedicated tx-channels for
netconsole. (Sorry, I am not a network guy.)

John Ogness

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/serial_core.h?h=v7.1#n715
