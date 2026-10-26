Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014845;
	b=19Uj3DqUbq4lhkwwP6vWmOezd1UYgKnxID0BmS+3NaRv/ZOt+0XtpVYgtF0hw4XsesB+
	 BQxKUs2zTX4ejW5fM15yU/iC6Zjp6muMrMPEJKXfp6GbUdWxsO3OHGDWORQ5o9vPWIR8Z
	 wK5LuPgzpZA5CDa+d20eiwVokDAPLJ1XYcEzHEaivHzBRvxrtdpvLz+Cov/3o0y+oR3q/
	 WGWI1YajKgULsoEdNlvkfUCxkqxzLeY1NCKWLaK4JYQfxC7DA7+bknLQWzaL5qYCy85FY
	 rkfp+eq5OTH6A0p/G0q/L84GTX2x+Ffu5Z5UAaxv3ABE3SmiLLdq67OiCj/aTiT6wYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014845;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=yPAdl72E+7xklG7nRDjs082FkacgxDewbsxvMJxomYI=;
	b=hOFH/LhUoVekzhgD3rF2+k/q2ZeoGhwLKwW25Vh4Y1IkuOZK8JuGiKgXogLPaS2Yz9JJ
	 krh2VQJvrCvqm88m1mVqVNyWqMzwtYNNxfMQq8dOPVVyfvdPUys1YvB1Vg7jBUNIn0UYM
	 u+86zclYg871Cay9of5NrGQ6mQy+F8DYBopJ5sEnJk5mv9ROo9iHqHP26TbsTLXkkvG7Y
	 YL+T0s6LdH67RMMw6GJAzbleMRt+bW4U5hJbJ7+DFhUcMFopmpIAv1OHI19+wS/gvf47t
	 AD4b7au30WoDLNZh7mrng/z5gjlZeJCU6q+BbZXDmEjluyHuaWEMVfafrB1yyxUDdcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b="l23TYui/";
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF107606A31B;
	Mon, 26 Oct 2026 11:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF107606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=l23TYui/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yPAdl72E+7xklG7nRDjs082FkacgxDewbsxvMJxomYI=; b=l23TYui/tT2VtnunGJt9l1x/dz
	Urit897PyBh5STzFdbFbuP9rgPtLXueK6QjPZZPNVB4MnS1laeDfJMoc4BNlC+hkpscbCpTqMAiAM
	sgaCGAWvdFgQ13klnf6wwSXKmjMkbqkT5lLp9KxAM0NwijA0e2/w1ISPHSJvYLkOBVwkgM6Qs5Oxv
	An9nhAnTRGJOv7qzAsF4cjweEwUlYYCBN0O9Oocn8lV6nQUVePIxrl8K1tNQ1xW9SHM2LNA9LC85X
	POcOY5+4fVcGIHQlMnWtzsVYmUok2mqUtzynwAuS9FB8d50ZiV0JxEtD7/330mGuZx6jiw5SdQV2o
	40GGDHJQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLJ4B-0000000217E-1iIm;
	Mon, 26 Oct 2026 11:40:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 50A4C300DB9; Mon, 26 Oct 2026 12:40:38 +0100 (CET)
Date: Mon, 26 Oct 2026 12:40:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yao Kai <yaokai34@huawei.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] rseq: Prevent self-preemption when granting a time slice
 extension
Message-ID: <20261026114038.GE2668200@noisy.programming.kicks-ass.net>
References: <20261023040439.3829110-1-yaokai34@huawei.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023040439.3829110-1-yaokai34@huawei.com>

On Fri, Oct 23, 2026 at 12:04:39PM +0800, Yao Kai wrote:
> __rseq_grant_slice_extension() makes the grant visible to user space and
> then reads the clock to compute the expiry time before it clears the
> pending reschedule request. This runs in the exit to user mode loop with
> interrupts enabled.
> 
> Clocksource read functions are free to disable and enable preemption.
> kvm_clock_read(), xen_clocksource_read() and the arm64 architected timer
> counter accessors, which are used when a counter erratum workaround is
> active, do so. With full or lazy preemption, when the request which
> triggered the grant is a non-lazy TIF_NEED_RESCHED, e.g. a lazy request
> upgraded by the scheduler tick, then preempt_enable_notrace() in the clock
> read function schedules right away, e.g. in a KVM guest:
> 
>   __schedule
>   preempt_schedule_notrace
>   preempt_schedule_notrace_thunk
>   kvm_clock_get_cycles
>   ktime_get_mono_fast_ns
>   irqentry_exit
>   asm_sysvec_apic_timer_interrupt
> 
> The task is preempted with the grant already handed out to user space,
> i.e. in the middle of the critical section which the extension is supposed
> to protect. The stale grant is cleaned up when the task goes back to user
> space, so the damage is limited to the extension silently not working for
> such preemptions on systems which use one of these clocksources.
> 
> Read the clock in the interrupt disabled section after the reschedule
> request has been cleared.
> 
> Fixes: dfb630f548a7 ("rseq: Implement rseq_grant_slice_extension()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yao Kai <yaokai34@huawei.com>
> ---
>  include/linux/rseq_entry.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
> index 31ce349ed42c..3e6a339175f8 100644
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -174,8 +174,6 @@ static __always_inline bool __rseq_grant_slice_extension(bool work_pending)
>  	rseq_stat_inc(rseq_stats.s_granted);
>  
>  	curr->rseq.slice.state.granted = true;
> -	/* Store expiry time for arming the timer on the way out */
> -	curr->rseq.slice.expires = data_race(rseq_slice_ext_nsecs) + ktime_get_mono_fast_ns();
>  	/*
>  	 * This is racy against a remote CPU setting TIF_NEED_RESCHED in
>  	 * several ways:
> @@ -222,6 +220,18 @@ static __always_inline bool __rseq_grant_slice_extension(bool work_pending)
>  	scoped_guard(irq) {
>  		clear_tsk_need_resched(curr);
>  		clear_preempt_need_resched();
> +		/*
> +		 * Store expiry time for arming the timer on the way out.
> +		 *
> +		 * Read the clock only after the reschedule request has been
> +		 * cleared and with interrupts disabled. Clocksource read
> +		 * functions, e.g. kvm_clock_read(), may disable and enable
> +		 * preemption, which would otherwise schedule right here on a
> +		 * pending request and void the grant which was just handed
> +		 * out to user space.
> +		 */
> +		curr->rseq.slice.expires = data_race(rseq_slice_ext_nsecs) +
> +					   ktime_get_mono_fast_ns();
>  	}
>  	return true;

I am confused; even with this patch on, a tick that happens after
unsafe_put_user() can cause things to get rescheduled 'instantly'. That
preemption happens from irqentry_exit_cond_resched(), and needs no help
from any preempt_enable() usage.


