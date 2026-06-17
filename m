Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BBB3F8EA7;
	Wed, 17 Jun 2026 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708230; cv=none; b=mTRnlxLb8mFGQ0dU1spTqIXmTWqHZGg/kaGspiJsQbYxiY1jb9kWrfSCI+/A1EXKdMa8VHJdg6dZnIDlh32z9RNbBWaveovdExEDi9N+/z5hwD9g1uhzBKZiY3yeU7uGGNxHi/hV81naj2v7o9IAZwcHSmOd21rF8ABdzRzCqdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708230; c=relaxed/simple;
	bh=Kb0K46wf+oOtriIVzSLs2BRre9ehKuOivbEA2vanJg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQUAy1qVVwWNoEFE+wHCrlZj0f1eSUDhKHFysBzwDTuOzQnVU9e3LQOiqrvObQca/zLsGFNUtiwGU4Jj4PmHlzmboYpoykUNluQuvqLkOYYTHnNCyF48QKAv2I8yFDPj7VWfTD+SK/xJ4TaR6MzNngHjsYUJyjJ1zcT4Mi98ahQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=EIfWc+FK; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="EIfWc+FK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MrRknOfSzpz9R15Mc3e7c9NlkPc7hEDp9dvwFWEnuWQ=; b=EIfWc+FKI7lOmP5oqQ0iXVksxJ
	fUyKMzpC+kSXH+d6S/obeGLCXM8Ez1ciZXh3IDb2/ONQGpOQLsLSp2mLjF7BqgmZP2WtqTIhCeTMG
	hv5cvhvI/21SxDt6juDD59ZgmeO/oeB3TInjke2+UWhGuE9AZoOxOytuCwi31q8Ft59guXZsz0DMK
	l+1DZytV7zIdzVl+6/QvBDVtNCrIIls1MvHZDg3Np84MA9PS8rcxpglCZk3PHldKP9y9K2joD8tr7
	5yisr4Dv9kddwgua6sz1BAQrZW74VFAAssQhkYbHeYn4CIVgmjCv65qNyT8YI/zZ36WwDPxBkX1Q3
	i/C8H8TQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZrhI-00EhJZ-27;
	Wed, 17 Jun 2026 14:56:57 +0000
Date: Wed, 17 Jun 2026 07:56:50 -0700
From: Breno Leitao <leitao@debian.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>, Jakub Kicinski <kuba@kernel.org>, 
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
Message-ID: <ajKi4wtA8U1iZkMD@gmail.com>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616170257.GH49951@noisy.programming.kicks-ass.net>
 <20260616141719.67684bf0@kernel.org>
 <ajJ46o4fomfxY5CX@pathway.suse.cz>
 <20260617111958.GL49951@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617111958.GL49951@noisy.programming.kicks-ass.net>
X-Debian-User: leitao

On Wed, Jun 17, 2026 at 01:19:58PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 17, 2026 at 12:37:30PM +0200, Petr Mladek wrote:
> > On Tue 2026-06-16 14:17:19, Jakub Kicinski wrote:
> > > On Tue, 16 Jun 2026 19:02:57 +0200 Peter Zijlstra wrote:
> > > > > So this is not an issue since commit 7eab73b18630e ("netconsole: convert
> > > > > to NBCON console infrastructure"). Because from here now on writes are
> > > > > deferred to the nbcon thread. So this purely about -stable in this case.  
> > > > 
> > > > Hmm, I thought netconsole had some reserved skbs and could to writes
> > > > 'atomic' like? That said, it was 2.6 era the last time I looked at
> > > > netconsole.
> > > 
> > > Yes, that part is fine. The problem is that netconsole tries
> > > to reap Tx completions if the Tx queue is full. We can't call
> > > skb destructor in irq context so we put the completed skbs on
> > > a queue and try to arm softirq to get to them later.
> > > Arming softirq causes a ksoftirq wake up.
> > > 
> > > We already skip the completion polling if we detect getting called
> > > from the same networking driver. It's best effort, anyway.
> > > Networking-side fix would be to toss another OR condition into
> > > the skip. But we don't have one that'd work cleanly :S
> > 
> > Alternative solution might be to offload the ksoftirq wake up
> > to an irq_work. It might make this part safe for the
> > console->write_atomic() call.
> > 
> > Well, my understanding is that there are more problems.
> > AFAIK, some drivers do not use an IRQ safe locking, see
> > https://lore.kernel.org/all/oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh/
> 
> But anything using locking is not ->write_atomic() and should be driven
> from a kthread, no?

Good point. If that's the case, netconsole might not ever be able to drop
CON_NBCON_ATOMIC_UNSAFE for any network-based console driver at all. 

As far as I can tell, there isn't a network driver today whose transmit
path is completely lockless, so, even if we make netpoll lockless.

It's unlikely any NIC will ever achieve this, given that NIC TX
fundamentally relies on a shared DMA ring and doorbell register, which
inherently cannot be made lockless.

So, is it correct to state that CON_NBCON_ATOMIC_UNSAFE will be part of
netconsole forever-ish?
