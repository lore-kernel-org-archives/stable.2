Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E6947277E;
	Tue, 16 Jun 2026 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627556; cv=none; b=VfJ9KY2h9M2MBFHiSDCZK9JYr5aiirCrNNYEe6fl1DF77YFGIfyQN9rWSS0bIXvr97s/y927+ugLshrBJ2hxJd9CVWe5jwrdQ/w9BKCtQBofeA2Czl+3/kFfRNo4/agBx4sPEau69yQq06hdEmcikYByMGxS79+4sQ611jOZf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627556; c=relaxed/simple;
	bh=cxNRD9g4JTaW+y9yuZOXTodl2RSrdAouq0DJHD38nOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dw5fytdQHzjs+1RBfPsSANYcvWQTfeTfOBKuYjBjwNAKw/WEjJpJIYOXemfl2VQcxtX5xg3p4f3KBI6cxjtk6TNVMFlQtuk9YKyn4BRAmWhSBJmcCXvLbLjbvLoYqllSZLM9QLmuGHttuafhnQQ996Trl/Y9Yb/8ZVj1QubQnrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Q10tw86R; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Q10tw86R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H/N0aB8Py/Rsbm9WsHxcEy8ZCZh8fJfopFRm2ogN+sI=; b=Q10tw86RhvHN3vrXb0JljfmNy0
	Mic5Rah8A1rmejO+xmpAuCq9affgrSN1SQm+aMjLe5ZO7Fbvw3NaESeAKjiSRx9MOYuwqg6rT/zGg
	SN5GQpcbguKXW/69gfGhM5f7x2SB92CYTpRxK77/mLFP9k0gva0BM4bvPXTFbYGejNf0TGLT9W68H
	cyxP7XKTqS+Un4PQzfGlgyXYsa1FqeVwixGuEYa81ZekcZ5nU4ux9ne7GWXLrOUatlIklfT3uaQlb
	ehRIIH7VN3BUD/S74di1u1vRYXcuircWgRXtXbOvIw0ghQODXz/OjILWE+dZ/WRZIeCmMiZi9HQ60
	y8M8a0vw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZWi8-00Dyp3-24;
	Tue, 16 Jun 2026 16:32:24 +0000
Date: Tue, 16 Jun 2026 09:32:15 -0700
From: Breno Leitao <leitao@debian.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	john.ogness@linutronix.de, pmladek@suse.com
Cc: Jakub Kicinski <kuba@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlad Poenaru <vlad.wing@gmail.com>, 
	Thomas Gleixner <tglx@kernel.org>, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
Message-ID: <ajF5S0uY-8F0jzoh@gmail.com>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616103529.Yh9Dxsjp@linutronix.de>
X-Debian-User: leitao

On Tue, Jun 16, 2026 at 12:35:29PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-06-11 19:11:14 [-0700], Jakub Kicinski wrote:
> > On Wed, 10 Jun 2026 11:36:21 -0700 Vlad Poenaru wrote:
> > > @@ -194,11 +194,56 @@ void netpoll_poll_dev(struct net_device *dev)
> > > +	local_bh_disable();
> > > + 	poll_napi(dev);
> > > +	_local_bh_enable();
> >
> > tglx, Sebastian, are you okay with using _local_bh_enable() to trick
> > softirq into not waking ksoftirqd? The problematic path is:
> >
> >   scheduler -> printk -> netconsole -> raise softirq -> scheduler (deadlock)
> >
> > so the softirq may never get serviced.
> >
> > In netcons we try to avoid touching the network driver if the Tx path
> > locks are already held. Ideally we'd do something similar with the
> > scheduler. Try to do bare minimum if we may be in the scheduler.
> > Failing that - don't poll the driver if we were called with irqs
> > already disabled.
> >
> > Or maybe we only poll from console->write_thread ?
>
> So this is not an issue since commit 7eab73b18630e ("netconsole: convert
> to NBCON console infrastructure"). Because from here now on writes are
> deferred to the nbcon thread. So this purely about -stable in this case.

Does the nbcon thread handle defer even for consoles that support atomic
operations?

netconsole is marked with CON_NBCON_ATOMIC_UNSAFE, which means it rarely
performs inline/direct printk and instead pushes to the thread, which
flushes in a safe context.

For drivers that behave correctly, I'd like to be able to drop
CON_NBCON_ATOMIC_UNSAFE, potentially setting it at runtime based on the
underlying driver capabilities. If netconsole is backed by a well-behaving
network driver, we could eventually remove the flag (!?)

Would that approach cause any issues?
