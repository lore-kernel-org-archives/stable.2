Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D58F31F985;
	Fri,  7 Aug 2026 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097327; cv=none; b=tXIsE1jKcBOYDgm/2SXCeAUgvexqN1wKw4PRhnSew+W/8mtZ1VDaeUqnRbu7R4KKBgof77g+hiFv4toLuZv8YyEgloyd+8KNR2KECDrWs4N0GJHABLYSC4lxtLyabyGV/kfcmVVvuoRHtNqibVU8PZYFNevwQ2Pg965H8r/SaZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097327; c=relaxed/simple;
	bh=u7B02/+VCnuFZ1Ic4MPf/QDkV/erW1ApSomB86lvCC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfK+3kd7S2iNJUsh9b+FBSK4/bvQ383lI9eNDwDLYw6MfUUFa7GkX9iGDt/OO0Jut/CTjp3xqowOryCP1pGqoEdwCjoq9lBOSQy6vP1y/Ohvg5kLpi9TpCdiVCETVL56ll9jBuuxa5+kbeXIQXzWYchlpgqorBnASZX/4twuzl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SoPbuoDL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SoPbuoDL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pxd2Bwic7PKpnObPnanvqm3imyXmQVIGXfi6xaFwDyk=; b=SoPbuoDL//b/TLfrArWwkBtQmx
	X6eIDKgTfpdWXQdmKf4AXcbF5b0VQ3qmBq+S6MCQZuDg90g678481eEX40K9spHN/8p2NwPXx567U
	41uF3nCJGL3AI2kz+ZjiaVUG6y6CTuAUWY9t/64MWsQ6BHbFxAAgPEfw/2guUkVzqAy7EQ3Wdtrpp
	rKhga7piSyObi1ysEuXkCJhtSmYx4WVkrUP1wjBv7aMER4f6h60Pvoa0R/stTjg5so0/e5Lv/9zyt
	AJhjEmt8xi7m6gNZh2HwJBZDf0RD/0DRxVIr3IsFV67Rd9dYBbjaiaf4ub1U5xtlCXaXKgGjox9/M
	kVeLPjQw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wsHV8-0000000CGfh-1Kat;
	Fri, 07 Aug 2026 10:08:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 945EF3004C9; Fri, 07 Aug 2026 12:08:28 +0200 (CEST)
Date: Fri, 7 Aug 2026 12:08:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Usama Arif <usama.arif@linux.dev>, Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 2/3] perf/core: Run sched_task() for PMUs with only
 CPU-wide events
Message-ID: <20260807100828.GT776954@noisy.programming.kicks-ass.net>
References: <20260806135224.3267890-1-puranjay@kernel.org>
 <20260806135224.3267890-3-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806135224.3267890-3-puranjay@kernel.org>

On Thu, Aug 06, 2026 at 06:52:22AM -0700, Puranjay Mohan wrote:
> perf_pmu_sched_task() returns early when cpuctx->task_ctx is set and
> leaves the work to perf_ctx_sched_task_cb(). That one only walks
> ctx->pmu_ctx_list, so a PMU whose events are all CPU-wide is never
> visited and its sched_task() callback does not run. With
> 
>   perf record -b -e cycles -a -- ls
> 
> armv8pmu_sched_task() is skipped on every switch to a task that has a
> perf event of its own, and BRBE records leak across the task boundary.
> intel_pmu_lbr_add() calls perf_sched_cb_inc() unconditionally as well,
> so LBR records leak the same way on x86.
> 
> Drop the early return and instead skip the individual CPCs that
> perf_ctx_sched_task_cb() already handles.
> 
> That requires the two to agree on which CPC belongs to which path, and
> they do not. perf_ctx_sched_task_cb() gates on cpc->sched_cb_usage,
> which perf_sched_cb_inc() sets per CPU for every branch stack user,
> while the new gate uses cpc->task_epc, which __link_epc() sets only on
> the CPU the task context is scheduled in on. A task with an event for
> that PMU pinned to another CPU has an epc on ctx->pmu_ctx_list while
> cpc->task_epc is NULL, so both paths would run and sched_task() would be
> called twice per context switch. On x86 the second
> __intel_pmu_lbr_restore() finds lbr_stack_state == LBR_NONE and calls
> intel_pmu_lbr_reset(), throwing away the callstack the first one
> restored. So gate perf_ctx_sched_task_cb() on cpc->task_epc too.
> 
> For the CPCs that perf_pmu_sched_task() now handles, the callback no
> longer runs inside the perf_ctx_disable() and perf_ctx_enable() pair in
> perf_event_context_sched_in(). __perf_pmu_sched_task() disables the PMU
> around the call itself, so the callback still runs with it disabled.
> 
> Fixes: bd2756811766 ("perf: Rewrite core context handling")
> Cc: stable@vger.kernel.org
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/events/core.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 9815894b67e77..675dd05935f35 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3757,6 +3757,9 @@ static void perf_ctx_sched_task_cb(struct perf_event_context *ctx,
>  	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
>  		cpc = this_cpc(pmu_ctx->pmu);
>  
> +		if (cpc->task_epc != pmu_ctx)
> +			continue;

Why isn't this the inverse condition of the below? That is, we should
call either this or the other, right?

> +
>  		if (cpc->sched_cb_usage && pmu_ctx->pmu->sched_task)
>  			pmu_ctx->pmu->sched_task(pmu_ctx, task, sched_in);
>  	}
> @@ -3921,12 +3924,15 @@ static void perf_pmu_sched_task(struct task_struct *prev,
>  	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
>  	struct perf_cpu_pmu_context *cpc;
>  
> -	/* cpuctx->task_ctx will be handled in perf_event_context_sched_in/out */
> -	if (prev == next || cpuctx->task_ctx)
> +	if (prev == next)
>  		return;
>  
> -	list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_entry)
> +	list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
> +		if (cpuctx->task_ctx && cpc->task_epc)

I'm not sure I see the need for the first part of that clause; why
isn't: 'cpuc->task_epc' sufficient?

> +			continue;
> +
>  		__perf_pmu_sched_task(cpc, sched_in ? next : prev, sched_in);
> +	}
>  }
>  
>  static void perf_event_switch(struct task_struct *task,
> -- 
> 2.53.0-Meta
> 
