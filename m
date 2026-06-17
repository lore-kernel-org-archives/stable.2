Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEB53C4178;
	Wed, 17 Jun 2026 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695214; cv=none; b=Ah3AZJN8ozRSZEkEa2QseWlwZrXQe+tdkZrdbEiFNn8C/Pgj7KwTrD1kMUIcIs213l4UrM8gk9qVosCn7tGqPJfi4/2Rx3mgCyRE6QKxcB8faN68b0O1pWH1TarGqMlfBe6/7p6kgpEhXHl8sSROiG3QwgIfKieesBmyHwCThm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695214; c=relaxed/simple;
	bh=DFl0wWs3wZa64CW8NotWTgeXdpSmLH1QUjX84KCFJ64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRmG/o8D6q1m3Nxh5JIl9RIe3b4+6ycTt/FiqtVveBeg3m8tZtCSwUB5Ssu48SvTSiczJ73W6c/mIPkW6fmL3JxKj9LmKNcuwaO+C+5FVAV3a+uR8+m7gg6PEd6JJ2Ipp738r4d/+AwIX4mR7MH7bETWTPtIBAvfocn8W1EDUXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CmCUdEuf; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CmCUdEuf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=36EDr/CyzfD8dqA4WQH+TVeeKiP5aMpQzHU5I0JNKdA=; b=CmCUdEufle9jh4dE4SDN2nAskQ
	H1t0QpS5pkV/nv70xpB05yd7dgwhXjCySYifTPYRhPw7yXC7GLonCX5LLGTf3+I3UlD+UanRI47S9
	uItuc3YCSSBVA5yOTrqRt2nF0HGT9u3Qus5yIlKm/UJeZpSh05QemaLTOhSoq+FmUrB350TzGtxAv
	9CYleJKmH89OTUcUQP9Ovlw/z1NvZ1e5DoncftBJhJCF9bF6p3dfPlfnX+b9maaF2ur2l9NWNsqOm
	4p/cMvrOP/2N5cE6s8MY0d3OS5Irky52mbqWwIg23H9GV5Kr3GGQnIm7VTsC1tINtEiAmIc8Vy2B9
	zTBru5jA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wZoJL-0000000C3mB-1Jov;
	Wed, 17 Jun 2026 11:19:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 24BA930036F; Wed, 17 Jun 2026 13:19:58 +0200 (CEST)
Date: Wed, 17 Jun 2026 13:19:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Message-ID: <20260617111958.GL49951@noisy.programming.kicks-ass.net>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616170257.GH49951@noisy.programming.kicks-ass.net>
 <20260616141719.67684bf0@kernel.org>
 <ajJ46o4fomfxY5CX@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajJ46o4fomfxY5CX@pathway.suse.cz>

On Wed, Jun 17, 2026 at 12:37:30PM +0200, Petr Mladek wrote:
> On Tue 2026-06-16 14:17:19, Jakub Kicinski wrote:
> > On Tue, 16 Jun 2026 19:02:57 +0200 Peter Zijlstra wrote:
> > > > So this is not an issue since commit 7eab73b18630e ("netconsole: convert
> > > > to NBCON console infrastructure"). Because from here now on writes are
> > > > deferred to the nbcon thread. So this purely about -stable in this case.  
> > > 
> > > Hmm, I thought netconsole had some reserved skbs and could to writes
> > > 'atomic' like? That said, it was 2.6 era the last time I looked at
> > > netconsole.
> > 
> > Yes, that part is fine. The problem is that netconsole tries
> > to reap Tx completions if the Tx queue is full. We can't call
> > skb destructor in irq context so we put the completed skbs on
> > a queue and try to arm softirq to get to them later.
> > Arming softirq causes a ksoftirq wake up.
> > 
> > We already skip the completion polling if we detect getting called
> > from the same networking driver. It's best effort, anyway.
> > Networking-side fix would be to toss another OR condition into
> > the skip. But we don't have one that'd work cleanly :S
> 
> Alternative solution might be to offload the ksoftirq wake up
> to an irq_work. It might make this part safe for the
> console->write_atomic() call.
> 
> Well, my understanding is that there are more problems.
> AFAIK, some drivers do not use an IRQ safe locking, see
> https://lore.kernel.org/all/oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh/

But anything using locking is not ->write_atomic() and should be driven
from a kthread, no?

