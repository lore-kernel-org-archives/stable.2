Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8463C09E3;
	Mon, 10 Aug 2026 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786360585; cv=none; b=J3WlpqRZeNhvqBYpy44D/hloDTzy2dRKXCoeAU06jTvFPnyq6zqIPGQzh0L9JRarqZsXDDM7HuhrnSD+exnVMFAgUmXdj+j/ehPXx/gBHIsNTePl9UL+ePWOhZ7Wz+SR/fopDqf2KeJ6gLpCUk0EKgO28MJsAvgiBjvcu9sQNWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786360585; c=relaxed/simple;
	bh=7IlfizHy/gI9pj/9ns5l7qQecDIYjZuggRG7wrLnYJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJarHBeNySHzJctJGLWxxnPenmhCjteOZipbi8deM4cS9jnVjMnlvvjL6uNm/rwSpIUiVSV+H1YJEVR0XkMA93T9d+6zPt8QCuvC23pGTMyL7VCw7x/DU8Cef5OxzCV5lNKEwRJQoTYTeG3TUcgY4hZ+8lRIXXEgux1vpbgyJ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=giS0XyNu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="giS0XyNu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3a52RpI8RZonRX/awqL1lqXeJZb2RmdUEdBEm0PbsTw=; b=giS0XyNux3jjhM/0VHYgHIllKn
	gdPt1HfN8YHm/nGkSA02DpXEnXY2gyFhC4rEJ16wHV6N4Aq+s5n/3ifv5Viigxr5wfmiyzBXIUmu0
	+3S9vTJfj4gzmOSoZG7B+My1lzYncWw134uDnrHyZgVhg1Osn0jXwKuhTbb25yxY6PmPtkdqGrfMZ
	sSF/vwDRMz/8NKX6+GX01luRRXIWS6gHARFfEnHH5Cp/+e9DbMXaXhm5ZQi0cgNsjZVBbHPfaSUvp
	pQE3irb6rwLBvnLMSqsx76rHI/HC+uQm2H79b8PaOXE3LW4ACZ5taTj8t+7j5UUColvUOBO5whwxp
	RBEHUgsg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wtNzN-0000000DjQp-0Uch;
	Mon, 10 Aug 2026 11:16:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3067330019A; Mon, 10 Aug 2026 13:15:46 +0200 (CEST)
Date: Mon, 10 Aug 2026 13:15:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>, ElXreno <elxreno@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/6] sched/core: Make core-sched flips wait for in-flight
 selections
Message-ID: <20260810111546.GV687043@noisy.programming.kicks-ass.net>
References: <20260807210221.232543-1-tj@kernel.org>
 <20260807210221.232543-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807210221.232543-3-tj@kernel.org>

On Fri, Aug 07, 2026 at 11:02:17AM -1000, Tejun Heo wrote:
> Core scheduling's pick_next_task() operates on all sibling rqs under one
> acquisition of the shared core-wide lock. A ->pick_task() that releases the
> rq lock leaves every sibling __lock momentarily free, letting
> __sched_core_flip(false) complete mid-selection and rebind rq_lockp() under
> it. The selection resumes on the split locks, touching sibling state it no
> longer protects, and __schedule() finally releases a lock that was never
> taken while leaking the one that was.
> 
> Count in-flight core-wide selections in the leader's rq->core_pick_in_flight
> and make __sched_core_flip() wait for the count to drain. The count only
> changes under the shared lock, which the flip holds while sampling, so no
> other ordering is needed. The wait can repeat while selections overlap, but
> the flip backs off between samples and flips are rare cookie-lifetime
> events.
> 
> sched_core_cpu_deactivate() moves the count to the new leader - a stale copy
> left behind would bias it forever if that CPU later returns as its own
> leader.
> 
> Fixes: 4c95380701f5 ("sched/ext: Fold balance_scx() into pick_task_scx()")

I'm not entirely sure this is the right commit. I suspect this was a
problem right from the beginning. This pick_next_task() always had a
prev_balance() call that could drop the locks IIRC.

Also yuck :/ this is rather prone to starvation, and it will leave the
flip spinning ad-infinitum. But yes, this is the simplest fix I suppose.
It is not like anybody is going to be toggling this on and off very
often.  And if they are, they can bloody well keep the pieces.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
