Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260A93F8234;
	Wed, 19 Aug 2026 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787142290; cv=none; b=ld56FWdqlvuCiWxs6W+Bt27fiv3fqsAq+wvH4flYvl1itmiLYKZQJACoMLYFK+uL5uaMIm0l5dXDON41OC743pFRWt/vcHXTN8YMYuvCpqohiqpNav0tJDcQicHpnW7BpmWB6RCcbyZ5yk2MOztqzQe3/ao8wXfpyyoA+DDtXRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787142290; c=relaxed/simple;
	bh=0rwECUX0kPR0uJ1zP4O9K46OMa03R3gBmvrZ0uUUVY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVPB8+hODKoERI3vnrNVvetU57NlLpmAHagjhAbGqITuZ+LXekKOrWu6fauDv55Sosj6jy8KKwHHuoOJEpN9LbW17MTOmPAbZeKePckALlh+nl1kPF0aM5WAQOCTJwtFbd07gdKIQ63zT1yy3hx1/8nnpQxXAY7aiXIc3/4I5lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PdOkKHUb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PdOkKHUb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oLxnNxSsqZOJ+SWxcB9uaRPw36IEMk2UWFb2NFPfysI=; b=PdOkKHUbHfcq6KADMX1VfWu3/S
	G9i6SkleWGIoqhaa8Rm0GaGdnObBTyxWOT/wa/l08Z3lq+pudnoas2vR/dqYhAhOYYZ2lqHfJDsDJ
	lZjyYe82KnU6EWCTW5vRC2sEryKY1jAGEn5SHEfE2YvSfa57Imn66N/TDUOSnBT0d3A5W31C+/W9n
	py3McbcBDtrQtc+Mo//Ddhvz3/17ichDLCyGToqHibfQioEqMk6AqMj0Nuogel1Le3++vX1KscvE+
	jyrz3gnEEtsJcnN3+Yk//mzMEJRgjCimAfjjW65HUIMS0gzRtWw6kTeFBxF1bKtHaY0msm1xBLl9o
	og1uNA+w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wwfLT-00000002Mz4-3vvr;
	Wed, 19 Aug 2026 12:24:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A14A130030F; Wed, 19 Aug 2026 14:24:38 +0200 (CEST)
Date: Wed, 19 Aug 2026 14:24:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>, ElXreno <elxreno@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/6] sched/core: Handle pick_task() releasing the rq lock
Message-ID: <20260819122438.GA1248307@noisy.programming.kicks-ass.net>
References: <20260807210221.232543-1-tj@kernel.org>
 <20260807210221.232543-2-tj@kernel.org>
 <20260819093751.GI1247881@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819093751.GI1247881@noisy.programming.kicks-ass.net>

On Wed, Aug 19, 2026 at 11:37:51AM +0200, Peter Zijlstra wrote:
> On Fri, Aug 07, 2026 at 11:02:16AM -1000, Tejun Heo wrote:
> > Core scheduling's pick_next_task() breaks when a ->pick_task()
> > implementation can release the rq lock. The selection state derived on entry
> > is only valid while the lock is held continuously. Once a pick can drop the
> > lock, an interleaving selection can invalidate all of it: the single-CPU
> > fast path can commit an uncookied pick although the core went cookied during
> > the release, and forceidle committed by the interleaving selection skews the
> > restarted pass's accounting.
> > 
> > Fix it by restarting the whole selection when a pick returns RETRY_TASK
> > after releasing the lock: a single restart point above the state derivation
> > replaces the per-loop restart labels, so a retry picks up state committed by
> > interleaving selections and accounts and resets forceidle like a fresh
> > selection would.
> > 
> > need_sync and fi_before latch across retries. Clock validity can't be
> > re-derived - there is no program-ordered way to tell whether the own and
> > core rq clocks are still updated after the lock was released, as other
> > lockers' pin cycles may or may not have invalidated them. When restarting,
> > clear core_clock_updated so that the sibling loop re-updates the core rq,
> > and update the own rq clock if invalidated.
> > 
> > Fixes: 4c95380701f5 ("sched/ext: Fold balance_scx() into pick_task_scx()")
> > Cc: stable@vger.kernel.org # v6.19+
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> 
> Suppose the SMT siblings CPU0 and CPU1; this core sched pick nonsense
> runs on CPU0 and does that multi pick thing.
> 
> For CPU0 it pulls a task from the global DSQ, places it in the local
> DSQ, and returns that as the pick. No retry, all good.
> 
> Then for CPU1 it does the same, but hits a RETRY, so it stuffs the task
> back on the global DSQ and return RETRY.
> 
> Then on retry we find a FIFO task on CPU0, because lock-break and all
> that.
> 
> Now we pick the FIFO task, but have not had an opportunity to put the
> CPU0 task back into the global DSQ.
> 
> This is still possible, right?

Ah, I read the follow up patches more carefully, and I think you're
dealing with that here. That and I misremembered how the re-enqueue
worked. I though it was still done in pick_task_scx() on RETRY, but we
moved that to wakeup_preempt_scx().

OK, let me go over all this once more...
