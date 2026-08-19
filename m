Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4AC3E00B6;
	Wed, 19 Aug 2026 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132278; cv=none; b=tRP2kwpfbXSNZ7lO15sYY7/Llgf6IhpPjnFvADcry9jcR52IfxMFHVD9DT0orwUjxNusL1LKnF+F+ltyA54QtJJYLJWZT9i0P+K2BP14nncuJZZ/IGs5Yh8SsIPus926nLztN9DFPZ5l71bKXPd8U6wwOXNrNXsRBLxA5fN9hZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132278; c=relaxed/simple;
	bh=+dRrp3AIN5yuXrdz9NBDxWPSQf9XYQieTKK904kbAHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpR/uPBg15BOhZo2Jxput7pEcN0U4QQ/Hz3tZ3JsBs5FDuUpvakY6RenYoJgJymAxdi219qSA5pLJCjmF5DSySVii+YomCu+5HgXAMEgc4JnXYenP1QmnC7oTfSyoKnu6K/dCkiVJxP/C5elOceMzqNMN8Y/FlS82goDiqicLnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jXnnvXbG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jXnnvXbG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=59z/QIjvMe1nZvRPKTLdtPO+qnUK1cyCF9JMys/gphA=; b=jXnnvXbGNAkklpAFCdrJRz3UHz
	mGzA3QeExJvWQRdKTliGMH38WGUbA76Fjx5uf90pyd4sl70xXoa6AViG3lMwTpTcBZf2juMA+w8wW
	SMQakrQjib8KbQ4Njfdg/p0bcq7b/5179QJ4i0eK6+WX40ZY2Xm9zlTrB0JKewpEm4MQ7yjehkIfL
	v0/TD+eYfqG0m325kZZZSzzSnV6GfF69f9ZMtlH3evsyrVpKWKe8YGojrP4CM6XYzCKyDFUX+jI/I
	BtkLXEa2zhR+GWkVPRyOL3UDbXHPS8srTsn0w3gfmv9sNmXrB5KxxEbo5OODO3SZEciBr9LHg39LL
	pThXjZ5g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwck3-0000000DRFX-3146;
	Wed, 19 Aug 2026 09:37:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2E67630030F; Wed, 19 Aug 2026 11:37:51 +0200 (CEST)
Date: Wed, 19 Aug 2026 11:37:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>, ElXreno <elxreno@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/6] sched/core: Handle pick_task() releasing the rq lock
Message-ID: <20260819093751.GI1247881@noisy.programming.kicks-ass.net>
References: <20260807210221.232543-1-tj@kernel.org>
 <20260807210221.232543-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807210221.232543-2-tj@kernel.org>

On Fri, Aug 07, 2026 at 11:02:16AM -1000, Tejun Heo wrote:
> Core scheduling's pick_next_task() breaks when a ->pick_task()
> implementation can release the rq lock. The selection state derived on entry
> is only valid while the lock is held continuously. Once a pick can drop the
> lock, an interleaving selection can invalidate all of it: the single-CPU
> fast path can commit an uncookied pick although the core went cookied during
> the release, and forceidle committed by the interleaving selection skews the
> restarted pass's accounting.
> 
> Fix it by restarting the whole selection when a pick returns RETRY_TASK
> after releasing the lock: a single restart point above the state derivation
> replaces the per-loop restart labels, so a retry picks up state committed by
> interleaving selections and accounts and resets forceidle like a fresh
> selection would.
> 
> need_sync and fi_before latch across retries. Clock validity can't be
> re-derived - there is no program-ordered way to tell whether the own and
> core rq clocks are still updated after the lock was released, as other
> lockers' pin cycles may or may not have invalidated them. When restarting,
> clear core_clock_updated so that the sibling loop re-updates the core rq,
> and update the own rq clock if invalidated.
> 
> Fixes: 4c95380701f5 ("sched/ext: Fold balance_scx() into pick_task_scx()")
> Cc: stable@vger.kernel.org # v6.19+
> Signed-off-by: Tejun Heo <tj@kernel.org>

Suppose the SMT siblings CPU0 and CPU1; this core sched pick nonsense
runs on CPU0 and does that multi pick thing.

For CPU0 it pulls a task from the global DSQ, places it in the local
DSQ, and returns that as the pick. No retry, all good.

Then for CPU1 it does the same, but hits a RETRY, so it stuffs the task
back on the global DSQ and return RETRY.

Then on retry we find a FIFO task on CPU0, because lock-break and all
that.

Now we pick the FIFO task, but have not had an opportunity to put the
CPU0 task back into the global DSQ.

This is still possible, right?
