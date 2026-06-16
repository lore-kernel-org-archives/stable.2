Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444763BED69;
	Tue, 16 Jun 2026 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622691; cv=none; b=V0LI92Eed5DibDeFy56Q5okmdqKqogtgIEuFWBcRfLPm9xycPrOklYDNjTvgDCL2+QRbgWTSWlc5mfR3KS33wRaxmfPE+kScSr/pLYKSuRLyDXR2kk3BYkBcIrOHSflKSUZui+8j8zqfNaaA1b6fbdgAnVI+itsZtQE6GCiQpyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622691; c=relaxed/simple;
	bh=GCK/nO+mowJpDzZU/f37K0tE1WiQbdKbp6EpDp3Fb9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pG+VzHGa8tSEFkgdBTsDlmoAd2jE4aCVS2wYaNaBYM49fIoYiz1EDAX9AjAF7r8ip1f0nYxTpi2nkWBhClwUWG9F0bLl6SgwrHR28tobhIhYraUkR01TrOo6WhRvQ0sY/tRUpWhGwh5IEv5+MbuUcVzPc9e0ROyVuZDYnFAZqaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gahrGkU/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gahrGkU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C961F000E9;
	Tue, 16 Jun 2026 15:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781622690;
	bh=caOIpzBUGLY2xhSd7TNoK+CISeB7YToV6GWV4nJJGUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gahrGkU/0dSJoLTcYRdvkZZHBEQKHDIWgrOLb5XrXTuOb7BCbDsPqFknODA5rLGDw
	 g7Em7c/5vK2AaJu1FYlNLsjEN7TizcbrBcs4cMJjobS3Ld9mYxC3QcdjW1QgD+rL6P
	 3mm3RD+Z3pf4UKHxCz0Qt0QLEPcH7/Ean0emLuutiHmC1pxHJHkn5KffrWTWve2bsg
	 2zFHJtAbuCyiXkltFo3ntOdi9VgHcF52H9+dY2XszPp0K+O5w8NdxyrFae0+CDM6DM
	 xW3+aYTSTTSrsqX95DaJu4Vz2xPibj9ekWnpjsIQadG3yURpKyJ+Gi8hdEtzwGPDLw
	 dX6B6yjoECEDw==
Date: Tue, 16 Jun 2026 08:11:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Peter Zijlstra
 <peterz@infradead.org>, Vlad Poenaru <vlad.wing@gmail.com>, Thomas Gleixner
 <tglx@kernel.org>, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Breno Leitao
 <leitao@debian.org>, Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
Message-ID: <20260616081128.04e2c8dd@kernel.org>
In-Reply-To: <20260616103529.Yh9Dxsjp@linutronix.de>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
	<20260611191114.5bc43a59@kernel.org>
	<20260616103529.Yh9Dxsjp@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jun 2026 12:35:29 +0200 Sebastian Andrzej Siewior wrote:
> On 2026-06-11 19:11:14 [-0700], Jakub Kicinski wrote:
> > On Wed, 10 Jun 2026 11:36:21 -0700 Vlad Poenaru wrote: =20
> > > @@ -194,11 +194,56 @@ void netpoll_poll_dev(struct net_device *dev)
> > > +	local_bh_disable();
> > > + 	poll_napi(dev);
> > > +	_local_bh_enable(); =20
> >=20
> > tglx, Sebastian, are you okay with using _local_bh_enable() to trick
> > softirq into not waking ksoftirqd? The problematic path is:
> >=20
> >   scheduler -> printk -> netconsole -> raise softirq -> scheduler (dead=
lock)
> >=20
> > so the softirq may never get serviced.
> >=20
> > In netcons we try to avoid touching the network driver if the Tx path
> > locks are already held. Ideally we'd do something similar with the
> > scheduler. Try to do bare minimum if we may be in the scheduler.
> > Failing that - don't poll the driver if we were called with irqs
> > already disabled.
> >=20
> > Or maybe we only poll from console->write_thread ? =20
>=20
> So this is not an issue since commit 7eab73b18630e ("netconsole: convert
> to NBCON console infrastructure"). Because from here now on writes are
> deferred to the nbcon thread. So this purely about -stable in this case.
>=20
> Looking at the patch and the amount of comments vs code changes look
> somehow hackish. That ifdef for PREEMPT_RT is not needed because on
> PREEMPT_RT we have either nbcon or the legacy console (including
> netconsole before the mentioned commit) wrapped in a dedicated thread
> (via force_legacy_kthread()).
> That means in both cases the flow never ends there and the problem is
> limited to !PREEMPT_RT.
>=20
> Now. The scheduler usually does printk_deferred() because of the rq lock
> so it does not deadlock for various reasons. It is kind of a pity that
> the various WARN macros don't do that.
> I don't think that patch is enough. It works around the problem in this
> scenario but should the NIC driver invoke schedule_work() then we are
> back here again.
> Should the network driver acquire a lock then lockdep might observe
> rq -> driver-lock and then driver-lock -> rq and yell dead lock (CPU1
> doing AB and CPU2 doing BA). This includes also other console driver so
> it is not limited to netconsole.
>=20
> Point being made is that we should avoid the callchain:
>=20
> |  console_unlock
> |  vprintk_emit
> |  __warn
> |  __enqueue_entity                // WARN_ON_ONCE() here -- rq->lock held
> |  put_prev_entity
> |  put_prev_task_fair
> |  __schedule
>=20
> basically a printk under the rq lock.
>=20
> We could add printk_deferred_enter/exit() to all the rq_lock() variants.
> I think PeterZ loves this the most. And Greg will appreciate it too
> while backporting because of all the context changes.
>=20
> We could also introduce WARN_ON_DEFERRED +variants which do the
> printk_deferred_enter/exit() thingy should around the printk and replace
> all the WARNs in kernel/sched/.
> I *think* the tty/console layer has also a deadlock problem where it
> holds locks and then the WARN(), that never triggers, asks for the same
> locks again so we might have a second user=E2=80=A6
>=20
> Adding sched and printk folks for opinions while eyeballing
> WARN_ON_DEFERRED().

Thanks a lot for looking into this! To be clear - the printk_deferred /
WARN_DEFERRED would be just for stable? Or there's still some
sensitivity even with nbcon?
