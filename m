Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A7443E4BC;
	Tue, 16 Jun 2026 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629393; cv=none; b=g5/25hnX9nUO4VZY4mTgaN49M2CiCV2j3BfI4sZHjqtvRW8D6m6tiypy4KXapp5KeQdAW3/vSFaFaIHtEl1c0gogbxPitrKOQWqdQvdOK4ga3KXO0S6dNYoLL4hQjP32wedXL3JG4vQdo4J7wgz5Kk25AL5vKDVHrpd/o6q4sOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629393; c=relaxed/simple;
	bh=nXyaxubBahtAj4IF3o5TF1RlpykJP5S53+F1RX11ENA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZeQ20ifgZwbGUPQmqT1d+Hvzoke+Y7/+htutAQB/PpmeFTVmmM/Dm34qbGz1gF53bODN8IifwkQ6uX+VBJXYNX3hkTby9Wun8Fo2evMwdLA6HFzPCoXGZq3gkz1H6bJEZsOQF7u9r8wp3/d6luyNSxcZqCUp6O05x1spWJG8Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AZHf18eO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AZHf18eO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gHmaC1y77edf1raPS3NRFAP5eOMW0ukbCIFVpK4KJzo=; b=AZHf18eOjKe9xide+CG8vnAQFU
	CyIwrdZIxFmuVcYUeNJ1SRVrOv9o/aWH+PrOj61P+piOiP+qXU65EwjR5iCEvZApLA1IxtlhWHU2e
	AvhCwKIL9gBTUQUxBV7V7ZCao42RwnH8WaeRPg8n0ss2L5JgRMveHDrRGIsGt3qMYolhWE3PlYW85
	yt77XTh58IUQajIYIrRd7zx16Cexmz4jnPpl5BRxtGy6SzkrwwySN7pxp/DwBeLzFl0HzgKkJ+xY6
	uDZqRwNGfxFhiBMoAbfSrNu+VMSLTgdd/hyGFlDR4YTEzzu+jfOGA5O3aZ8mBGW2nkR5jcG7/7/bj
	kgNZrnjg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZXBi-0000000BAAh-0hDh;
	Tue, 16 Jun 2026 17:02:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6C0F430039E; Tue, 16 Jun 2026 19:02:57 +0200 (CEST)
Date: Tue, 16 Jun 2026 19:02:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <20260616170257.GH49951@noisy.programming.kicks-ass.net>
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

On Tue, Jun 16, 2026 at 12:35:29PM +0200, Sebastian Andrzej Siewior wrote:

> So this is not an issue since commit 7eab73b18630e ("netconsole: convert
> to NBCON console infrastructure"). Because from here now on writes are
> deferred to the nbcon thread. So this purely about -stable in this case.

Hmm, I thought netconsole had some reserved skbs and could to writes
'atomic' like? That said, it was 2.6 era the last time I looked at
netconsole.

> Now. The scheduler usually does printk_deferred() because of the rq lock
> so it does not deadlock for various reasons. It is kind of a pity that
> the various WARN macros don't do that.

People have tried, last time was here:

  https://lkml.kernel.org/r/20260611074344.GG48970@noisy.programming.kicks-ass.net

and I hate deferred with a passion. It means you'll never see the
message when you wreck the machine.

> We could add printk_deferred_enter/exit() to all the rq_lock() variants.
> I think PeterZ loves this the most. And Greg will appreciate it too
> while backporting because of all the context changes.

No, not going to happen, ever, sorry. Instead printk should delete
console sem and have printk() itself be atomic safe.

As stated, printk deferred is an abomination and needs to die a horrible
painful death.

As described here:

  https://lkml.kernel.org/r/20260611191922.GK187714@noisy.programming.kicks-ass.net

"So printk should:

 - stick msg in buffer (lockless)
 - print to atomic consoles (lockless)
 - use irq_work to wake console kthreads (lockless)
 - each kthread then tries to flush buffer to its own non-atomic console
   in non-atomic context."



