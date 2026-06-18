Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB2258CE7;
	Thu, 18 Jun 2026 23:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781826456; cv=none; b=eGLlaj20SPUib3QBPRFhi0LH9Rez6iXD0s4G6rPLmDwMRLVAZ9z96exL15pIOOb9+y5TmjlMRf6uWf5jte5Rsf7T8wp6GlgxomKV3kU7gftFTtg61eFW0Ia33lD9ffYnIghdu3XFp1D+hPOE8gyRkPyzZK63vQGXzXZuG0iqZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781826456; c=relaxed/simple;
	bh=Hgx7gS5P2EbYXi9kGfoDRRrX8TYw8Lnz+LamjNGgOoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SgNBFTvVR0mZQ6qJ0VoHuECaKaFdwcL5ennPUfcCwxEVTVNGVJQNrF0HBxjbkHLIfTSmAhuDRCp4Ibcmbng5uDlK7i+1nHlxk7B0+p2L2Yaiqsd1JtiEhNmsc3ZGRiwqG5m5KXoB9BQqmZRGQTkSTdfV/OdoJ3F1QUZgE38jTSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjInI95v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjInI95v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28A21F000E9;
	Thu, 18 Jun 2026 23:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781826454;
	bh=Hgx7gS5P2EbYXi9kGfoDRRrX8TYw8Lnz+LamjNGgOoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AjInI95vFpdMaqcgDoeFdM4ksjmtX6M58qi2GHmnlsVhG5sHo7viooQ6xF4znuu0c
	 i0GQzla3wtAIqThFkOFURGfVUyDJlHHqeqK+0p1WJjwWiW8gLb+LbZp9UHNjbaacoT
	 P02fy5a3Q+wjdqNoTbCBQDwFNSMMtEqIH57A98KxhLxhFKYuO77mhtcN48WFPt0zDB
	 zLRy7IF/vnjNaiQ68QEzegRSgUSIfjTpeUJ+Kvb7C12zQAmpWhEMtc0rPlBogJuBu+
	 gODyHVyXB/TNMvELRqQYPgx3YEcrfZEVNtiqXaQbVAFpv3J8qNhWKgYNR48aor2KFg
	 kqGR6ISo7tQjQ==
Date: Thu, 18 Jun 2026 16:47:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Vlad Poenaru <vlad.wing@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
Message-ID: <20260618164733.49539468@kernel.org>
In-Reply-To: <ajQFMS4ucT-mybhi@gmail.com>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
	<20260611191114.5bc43a59@kernel.org>
	<20260616103529.Yh9Dxsjp@linutronix.de>
	<20260616170257.GH49951@noisy.programming.kicks-ass.net>
	<20260616141719.67684bf0@kernel.org>
	<ajJ46o4fomfxY5CX@pathway.suse.cz>
	<20260617111958.GL49951@noisy.programming.kicks-ass.net>
	<ajKi4wtA8U1iZkMD@gmail.com>
	<20260617132127.645534d1@kernel.org>
	<ajQFMS4ucT-mybhi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jun 2026 07:57:33 -0700 Breno Leitao wrote:
> Let me verify my understanding: if we switched to __raise_softirq_irqoff()
> in dev_kfree_skb_irq_reason(), the issue would be resolved since we'd
> avoid waking ksoftirqd and therefore wouldn't touch the runqueue lock in this
> code path.

That's the same as Vlad's patch. It risks leaving the softirq raised
but never invoked.
