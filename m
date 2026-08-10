Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8BB3644B3;
	Mon, 10 Aug 2026 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359627; cv=none; b=tiKXksNRx2UrqHSVXhChRQAgxy1qfqMp5BNq9tieF6kq6cjOnjz8OQUtNc03nmr8lbQemICgpBeF3BSucmC1a2uoPXuiM5mSPvkNnrVhBwXg3zih5i91XOzImliQWlnDGaq2NRhArP6mx7/wZwOjS7YHZhm4FrFqd1faIlS3fq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359627; c=relaxed/simple;
	bh=Brz+WD8hrSSKGhX4ROvk13PtJi9YRL44b1YF9vPw5Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azXYTspEYNKPAG+jjmvYHUDj1Cmt/V6v3SIwNhtoKF9ZHm3RZzMK/fw0DF3BH9uEd2ODjgdHs8zIa8+F2W4SveNUD0YU3eIi2VSRFWj3EkzRP/LkeIZ8L8dn7OqDxF8AlH3/Tvazuzz19hDphehgMCmx6+nvbMnYk7vBa2sqmKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YLgpLAR3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YLgpLAR3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2blWNErbolu0mwOLr8kBfLG6M2VVhHB5f7lUthlHo2Y=; b=YLgpLAR3frCMZjhmljpKri38vy
	TXvipJL8/AxVZE2a3tLsokZ1PqQackREZEdQ2q4/FP77L2TK3oawA5aq2Am5wkXLseGWa0xcE3gRY
	cELX83nvJk+FAM8vtHrWLeoyoJn9HHbUhe7dPhnPa9jVI5/Gd/xMVyV/trtx2beUQuzVduosEGex6
	MZLFAoqlmF1GIgrLJfihILHFpL5tMeRSfwaWAPCqDsafZZF6NwRG9UsNDLq2pK9TS1O74L2Hvl2Q8
	WVjSDQRK9FlaMHXnGJkofhnqDZuZsxVOr5VixypN/fMPhubN80igrMXc4qICc31KdCBC+cApfsASA
	TgU2tCXw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wtNju-0000000Ditp-0uvU;
	Mon, 10 Aug 2026 11:00:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D2D1D30019A; Mon, 10 Aug 2026 13:00:16 +0200 (CEST)
Date: Mon, 10 Aug 2026 13:00:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>, ElXreno <elxreno@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/6] sched/core: Handle pick_task() releasing the rq lock
Message-ID: <20260810110016.GU687043@noisy.programming.kicks-ass.net>
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

Ah, yes indeed.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
