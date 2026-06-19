Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534A4368D71
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862845; cv=none; b=aX4r3h5Syvmr1agaCBwytHO3GK9gTjkw3qb0tHCOM+m/NmGEHkeMKX5RSanu+e95KOFOCkoP0iEWGqhY1ONSGAE/gQ9xlU1kWkz+aNUTrfGRwGSeVMpkGgRLq6SzUUSoXbIKMkeVHObO3ngW0DCZtnJ+v8tw73wwV7AURLHR+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862845; c=relaxed/simple;
	bh=aGauklNPabtsO7LQIp29AL9IE+hawJEwI3Iyt1CmxkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMSTvA/0IqGNxwWIlPzMS/YF57F0gy0jvG0Rwo0y4htZQv9wbLI5pK/Bnk78syOqzGpa4SW+pcZJpuNIx1rCsWcvDbpsPKlfv6CDgcpeJjosINsCeOM7dwu1W0nAv4P/2kw9ELUwlCs4fRKJitb9Kf7pM8UoowmioKLCJip9Bqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A3bXkiJs; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A3bXkiJs"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-46066e640easo1184630f8f.1
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 02:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781862840; x=1782467640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=es6lhLq2EOm7yOBpWKOLsnIHgXPOu61O1PDmQl8gQmU=;
        b=A3bXkiJsZvFlPgQQlnTMBCxmcRsMid8/k+Imw5Eq8zqVVC6tThSs4GQ+Xb+Ecprm8i
         f387gbqIb9sutCUCYoZ6fXIp25C/3ezfkjiWFSvX6zDYxUjVYgKKb7ESyIw6qFkPpuYA
         +7F1nkn7qH+LQaaMiAZt+8dG3QMs4VLa0+pnuiugm4LLPU5T9cavhZAM3od1xfSagaRN
         kRAMrsM0+Rst436u06NiqGHiLJxGXU3VH4ZktoGeFOBG+qOmbkB02eTqixTHJRhW/+GF
         QCnHihBvUYp6rN1LZlI6Mto0uWsYtELmEtqtIEjrwwMMYWOyrfN/x4yIGjoTWcjzFev9
         2ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781862840; x=1782467640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=es6lhLq2EOm7yOBpWKOLsnIHgXPOu61O1PDmQl8gQmU=;
        b=dpZtkV4nD9B8EmHjA1y/U43pGptjKcGJpVfjCkNE/p3rn08jOMro3AHCB6IhtWHqYm
         NkH/w4apeJZnsoZFseqcuihdpBUQD1bzCVu07GBFDSwKtMTznPLWE5E3N5abW6M0kwff
         kchuuj7sC7AkaV+rThIrsqSJzYgnuCvGw2hAmqnzMz6BAAebtBDNaEF88jacFRL88YkO
         /1XAfZeHsW/3+Mqc/f8dEpCPvR0eHn+/MSW6ri9cS6nmtVjsv9QSk1ZgAUk9evgt+cpq
         kSKJJeBrWEIIXx7H06531zLVFJmwm00NXCfhrrFwsqew6x2YT8iQ5OXzcKLfDeBdYRxF
         xi8A==
X-Forwarded-Encrypted: i=1; AFNElJ+WU/jB4BZ8Hkq/WxsJGUo9ySq3YXPSPRjLIdoTxqMUE7V0n/jFEoYzoMu4/3hKzXdDV6GcHMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfqo9DaBuPvhbuDwsJ41tWJegGHmM9QitjZPetLCTpVzVsMGrY
	83tZnc+9cpDnhpPXqdI5tNnZfmq5lybVSsA5I9bVsx+jpqV4LrlUWNNSSmldrExJVOI=
X-Gm-Gg: AfdE7ck3FsAe30UHqJ3wOUZN2DTuoSb/81xO6TxPl68aSksitZF1bei8ZY5aHPZIXZe
	VEyrs0YJcYGeXvh7qb/VCaDWyBul1lRvJlnvUU6FE4KN0oyUTuJ05LAvhVtcirQ2ksGsnS0Zc6+
	JiHkcCSCdZ0LqC49hcBNfeFtFL6K5a44sLzZiWF5B0rUun9V/tjZTVbxxvWrpKfEc+4Do0WMxSP
	ijsvGMxjp0fzGS8D3GhwvzpvOrvkKp+pVKZCTvkETWpubwOuPd3EUFEYNC3YeRPF6q2CTBuDN2q
	NbmjxEuBWZX1tHGhRMzPvLGFz800006wPdR7KAA8LAggKmJPZCIqAwC1z80Ps/N17a7IU/K6WAY
	FSJ90D0GIxgopKNdq5D3BTI3dpsJr4V6/gVkgiCGcdg5cHYi6jwM+HbosBqS0p43bJURU6zJIT1
	tLRLaR9isBkqZy5Vg=
X-Received: by 2002:adf:f751:0:b0:45e:d6b2:e6a5 with SMTP id ffacd0b85a97d-46509d58218mr4397934f8f.34.1781862839762;
        Fri, 19 Jun 2026 02:53:59 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46508a04c15sm6766712f8f.3.2026.06.19.02.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 02:53:59 -0700 (PDT)
Date: Fri, 19 Jun 2026 11:53:51 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vlad Poenaru <vlad.wing@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
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
Message-ID: <ajURr1G-12EJ4u-d@pathway.suse.cz>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616170257.GH49951@noisy.programming.kicks-ass.net>
 <20260616141719.67684bf0@kernel.org>
 <ajJ46o4fomfxY5CX@pathway.suse.cz>
 <20260617111958.GL49951@noisy.programming.kicks-ass.net>
 <ajKi4wtA8U1iZkMD@gmail.com>
 <87tsr1m6y5.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tsr1m6y5.fsf@jogness.linutronix.de>

On Wed 2026-06-17 19:13:30, John Ogness wrote:
> On 2026-06-17, Breno Leitao <leitao@debian.org> wrote:
> > On Wed, Jun 17, 2026 at 01:19:58PM +0200, Peter Zijlstra wrote:
> >> But anything using locking is not ->write_atomic() and should be driven
> >> from a kthread, no?
> >
> > Good point. If that's the case, netconsole might not ever be able to drop
> > CON_NBCON_ATOMIC_UNSAFE for any network-based console driver at all. 
> 
> It depends on what it needs to synchronize against. For example, the
> UART consoles cannot write if the port lock is taken by another
> context. And the port lock is the sole lock for writing to the UART. To
> deal with this, we added wrappers [0] for acquiring/releasing the port
> lock. The wrappers acquire the nbcon hardware after taking the port
> lock.
>
> The write_atomic() implementations for UART consoles do not take the
> port lock. Only the nbcon hardware is acquired (which can be done from
> any context). This automatically provides the synchronization based on
> the port lock.
> 
> > As far as I can tell, there isn't a network driver today whose transmit
> > path is completely lockless, so, even if we make netpoll lockless.
> >
> > It's unlikely any NIC will ever achieve this, given that NIC TX
> > fundamentally relies on a shared DMA ring and doorbell register, which
> > inherently cannot be made lockless.
> >
> > So, is it correct to state that CON_NBCON_ATOMIC_UNSAFE will be part of
> > netconsole forever-ish?
> 
> Is there some lock that can be taken to synchronize all writing of
> packets to the network? If yes, the netconsole can use a similar
> solution.

We need to be careful here. If more locks depend on the nbcon
ownership than it might become a kind of big kernel lock.

It might suffer from lock contention.

Another complication is that it is supposed to be a tail lock.

Finally, it might create tricky lockdep dependencies. But nbcon
context locking is not tracked by locked so it is not easy to be sure.

More details:

I always forget the details. But it seems that sleeping is allowed
in the nbcon context, see cant_migrate() in nbcon_device_try_acquire().
Which might break when someone tries to take it in atomic context.

AFAIK, the motivation was to allow using the normal (sleeping)
spin locks for serial console synchronization in RT. The nested nbcon
context locking should not disable the preemption when called
in NBCON_PRIO_NORMAL context.

It would still allow to take the nbcon context in atomic context
when called in NBCON_PRIO_EMERGENCY or _PANIC context because
nbcon_context_try_acquire() is able to take over the ownership
even from a sleeping NBCON_PRIO_NORMAL context.

But we need to make sure that outer locks behave the same.
In practice, they must be normal spin_locks. We could probably
add some lockdep annotation to catch eventual problems.

Sigh, I hope that I have got it right. I seem to be a bit lost
this week.

> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/serial_core.h?h=v7.1#n715

Best Regards,
Petr
