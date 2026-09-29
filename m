Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA412D7D47;
	Tue, 29 Sep 2026 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669412; cv=none; b=kWOwG1K7sO1n9iT4iet0mTugk9dtgXB/8ZXpTq0eFo11ZqPECFRXrwkQ3jkTj4g+IFHe/Y27SxyD7NLYbDYFKzVJEgHuSNGT2MqbCqbix1VBoafKl6mf36S41ta/JeqH1IvFC77X1LlEU/Hjxl1O+q57M2V4p0nd5hTC7Ves3xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669412; c=relaxed/simple;
	bh=j14PUnDWyvtVX+JVE1nsd1U/3NrbLE64Ie9+TNCrg/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdN27Rge9Fp+2z+txsi8DtDxQMNIe83G9jSexgtjDvW8sg7AWnT8Xvd+FMPD9aicq+7W3vpGi3KzQ8FMCiB27HWekaMUKKpxkHfwtKs+kAJICno0LJl1oecFACkJx3BHaZrgtQJsITS1kH+oyWtfHF0wBBCMsDJmlQt5ar42x3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rejaOlNJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rejaOlNJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GrrCWJrQIDX+byHSw9MLTTgoRL44sB2XW2+zn1LvxZ8=; b=rejaOlNJxTqQss0yM5Yd5Q5Yzb
	HtDtoco18t2R5QqqOdvn912fweW6YoV0dpmmEfuZJQuSfIDQoslgIY8YIe0X6Yx5nwz8ci/2/NNWs
	YR/G8O6S2wXnZ0kAFTPNk95H98bpjdpZerYR2sS8rk2ksypijgSTC5bWHtMb/ipVd8ZMn/gDLSIQZ
	qLfDZb9VkjewA+eY8S/Susk5/mf5XJ9PdDP8KLwQr2XPjIONl7rTbIFCBkNyJOCkFyAKbfaWu7jZZ
	pYCyBr9knFKtUS2rrMO3bXbva07ZWceaMrhRHMioCGRnWyWypgl8sUAtfY4qlPlNhsKbdTZ/UVZ94
	DMG3Ks8Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xBSub-00000002KgX-23Ph;
	Tue, 29 Sep 2026 08:10:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CBC6F300446; Tue, 29 Sep 2026 10:10:04 +0200 (CEST)
Date: Tue, 29 Sep 2026 10:10:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Stevens <stevensd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] sched/psi: clamp negative cpu_clock() skew
Message-ID: <20260929081004.GS4120091@noisy.programming.kicks-ass.net>
References: <20260928233743.3777102-1-stevensd@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928233743.3777102-1-stevensd@google.com>

On Mon, Sep 28, 2026 at 04:37:43PM -0700, David Stevens wrote:
> When working with timestamps, psi is careful to only compare timestamps
> from cpu_clock(cpu) with the same cpu argument. However, on systems with
> a stable clock, that cpu argument is ignored. This means that despite
> psi's best efforts, there will be some cross-CPU cpu_clock() timestamp
> comparisons.
> 
> The cross-CPU skew in cpu_clock() timestamps is generally orders of
> magnitude smaller than psi measurement intervals, so the cyclic times
> counters naturally absorb the jitter. However, if get_recent_times()
> executes immediately after a task on another CPU enters an active stall
> state, then negative skew can cause the u32 active state duration
> calculation to underflow. If that state had not been active since the
> previous execution of get_recent_times(), then times and times_prev will
> be equal and the very large underflow value will be passed out to
> collect_percpu_times(). There, it will be zero extended and folded into
> the u64 total accumulator as a very large delta of about 4 seconds
> scaled by that CPU's share of nonidle time.
> 
> That large jump can lead to spurious wakeups for the PSI_POLL aggregator
> or incorrect values for the PSI_AVGS aggregator. Spurious triggers or
> nonsense psi values (e.g. full>some, psi values >100%) can cause
> userspace to take unnecessary corrective action, such as a userspace OOM
> daemon killing processes to relieve (non-existent) memory pressure.
> 
> When running browser workloads on an Intel N100 with a sustained
> psi.mem.some of 2-3%, this underflow is observed once every couple of
> hours.
> 
> Clamping elapsed time to >= 0 prevents this jump from happening. It does
> result in the total accumulator being slightly elevated compared to what
> it should actually be, but that error is bounded by the skew and is in
> practice always smaller than what is added today. Note that expanding
> times to u64 to prevent the u32->u64 conversion from causing issues
> would result in userspace-facing total counters no longer being
> monotonic, which could break consumers that derive rates via successive
> total values.
> 
> Clock skew can cause issues in two more places. First, negative clock
> skew in record_times() can propagate through the times accumulator to
> the delta calculation against times_prev in get_recent_times() and cause
> it to underflow. Second, the elapsed time values calculated by
> successive executions of get_recent_times() can appear to go backwards
> if the first execution has positive skew and the second has negative
> skew. This can cause the delta calculation to underflow, since elapsed
> is propagated in the times_prev value. However, both of these require
> that the growth in stall time between iterations be non-zero but smaller
> than the inter-CPU skew. Neither issue has been observed in practice and
> they are not addressed here.
> 
> Cc: stable@vger.kernel.org
> Fixes: eb414681d5a0 ("psi: pressure stall information for CPU, memory, and IO")
> Signed-off-by: David Stevens <stevensd@google.com>
> ---
>  kernel/sched/psi.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 4e152410653d..893ad16ff42c 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -305,8 +305,24 @@ static void get_recent_times(struct psi_group *group, int cpu,
>  		 * (u32) and our reported pressure close to what's
>  		 * actually happening.
>  		 */
> -		if (state_mask & (1 << s))
> -			times[s] += now - state_start;
> +		if (state_mask & (1 << s)) {
> +			s64 elapsed = now - state_start;
> +
> +			/*
> +			 * When sched_clock_stable(), cpu_clock(cpu) ignores
> +			 * the cpu argument, so we can end up doing cross-CPU
> +			 * comparisons. A negative clock skew can result in
> +			 * underflow to a very large u32.
> +			 *
> +			 * While the u32 cyclic accumulators in groupc could
> +			 * handle a very large u32 from underflow, folding it
> +			 * into the u64 totals in collect_percpu_times()
> +			 * would result in huge jumps. Clamp to avoid that.
> +			 */

I am confused. If sched_clock_stable() you are 1) running x86 and 2)
that promises CPU A and CPU B doing RDTSC cannot observe non monotonic
movement.

If you are somehow able to see non monotonic movement, then 1) your
hardware is fucked, and 2) you should not have sched_clock_stable().

What kind of machine are you seeing this on?

> +			if (elapsed < 0)
> +				elapsed = 0;
> +			times[s] += elapsed;
> +		}
>  
>  		delta = times[s] - groupc->times_prev[aggregator][s];
>  		groupc->times_prev[aggregator][s] = times[s];
> 
> base-commit: 1fb28c664a19df8d45a6afa04d28d102b04ea680
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
