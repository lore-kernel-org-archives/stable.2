Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7743BB120;
	Wed, 17 Jun 2026 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682131; cv=none; b=tQHHZdIZhIn0owxtHxIX8tdMIS0dKaLPS3VjWdTdHFDzQ6C+pimq6yMA1V8msaoqaBu5HDw8IlnGo9e5gPyo0nA5K23XSoUA2anni2MQERMx11EF8xtHRn0pxhXDtBBME9tqUAtiMj6QAbWdCR9azCo8ddz8w+TtwXoMOBgkxF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682131; c=relaxed/simple;
	bh=UYnPxb1Rl/unG8AVIs6+c36t87t9Pw4qOIB524d8GNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wc/ONT9KiziwJaxBHvE94gmFlLMIqMCg3nGB+ycZb7kBfFhkygNZUvwgICrzS+9KtJxw7WQ16+J9Gf3y+VbuKv7/2SgI8H1FFGF+ZwtPkn5X92D2fV0DwCpfgHSFqQwV4Uj4uxE3BmGn0QrTm3x1RuYxylWzVhbboo3oDOuIaZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4sW21Ypg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MbFlUpVf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4sW21Ypg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MbFlUpVf"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781682128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYnPxb1Rl/unG8AVIs6+c36t87t9Pw4qOIB524d8GNs=;
	b=4sW21YpgR3GAzE4SyMd8vyQ9/Cb0EJz4EJnc0UdmP6HbYmWBglbAq37akwe1SlIZOH4kr6
	+QiMgt436te6oOI+lmAu12sXggSA8cORImUvh09dMPn2DAqtt9W3CaSXbCKrbXMpbujb8y
	7hjlSxh5jtJf2H5wVpVnbKwrnBcB5NgKVRoe9s1usN8XMswu84YAoHuP0eBPbAdVExURku
	aOngiFO27/nVGbCat9KTiTSlWcZ1xc3h9VyTgoJ4LNFwlJ0jXUkyPGk2GmBuMRD3vq6hVn
	FvLiigQYy9isVxvIRYfOAe4trfrUo6sZI4ewhcNg39LCgR0g0wNhuZZ9BmH+wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781682128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYnPxb1Rl/unG8AVIs6+c36t87t9Pw4qOIB524d8GNs=;
	b=MbFlUpVfCCdPPCPFztBOHVzgXUqWNTd2yX6XgxBEb2+MroUmYBfg82eFym9PLbfdRDbPrt
	m+VdNMVvE0uzkWBA==
To: Breno Leitao <leitao@debian.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, pmladek@suse.com
Cc: Jakub Kicinski <kuba@kernel.org>, Petr Mladek <pmladek@suse.com>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Peter Zijlstra
 <peterz@infradead.org>, Vlad Poenaru <vlad.wing@gmail.com>, Thomas
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
In-Reply-To: <ajF5S0uY-8F0jzoh@gmail.com>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de> <ajF5S0uY-8F0jzoh@gmail.com>
Date: Wed, 17 Jun 2026 09:48:07 +0206
Message-ID: <877bnxfwa8.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-06-16, Breno Leitao <leitao@debian.org> wrote:
>> So this is not an issue since commit 7eab73b18630e ("netconsole: convert
>> to NBCON console infrastructure"). Because from here now on writes are
>> deferred to the nbcon thread. So this purely about -stable in this case.
>
> Does the nbcon thread handle defer even for consoles that support atomic
> operations?

The all "printk deferred" variants have zero effect on nbcon
drivers. The "printk deferred" variants exist purely as duct tape for
legacy console drivers.

If nbcon drivers provide a safe write_atomic(), they will _always_ write
synchronously when the CPU is in an emergency state. Otherwise nbcon
drivers _always_ defer to their dedicated console printing kthread and
there they use the write_thread() callback.

> netconsole is marked with CON_NBCON_ATOMIC_UNSAFE, which means it rarely
> performs inline/direct printk and instead pushes to the thread, which
> flushes in a safe context.

CON_NBCON_ATOMIC_UNSAFE means it _never_ performs inline/direct printk
console writing. That flags means that in panic, at the _very_ end, just
before going into an infinite nop loop, the CON_NBCON_ATOMIC_UNSAFE
consoles will be flushed directly from the panic context.

> For drivers that behave correctly, I'd like to be able to drop
> CON_NBCON_ATOMIC_UNSAFE, potentially setting it at runtime based on the
> underlying driver capabilities. If netconsole is backed by a well-behaving
> network driver, we could eventually remove the flag (!?)
>
> Would that approach cause any issues?

Removing the flag means the driver can safely write from _any_ context
(including scheduler and NMI), regardless what locks that context may be
holding.

Note that the nbcon framework allows console drivers to mark unsafe
regions in themselves, where atomic writing would not be possible. In
such scenarios, it defers to the dedicated printing kthread (except
during panic, where more agressive tactics are used).

John Ogness
