Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A13364942;
	Fri,  7 Aug 2026 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096762; cv=none; b=KGfvTVQVGewvyn2cyY593rldPH6staEKdkYlBxNTkRTS5677MvtjyhR8xbprQHvco3fiCGv+LKz5eUhtXUadRyqWTCnMjwujAV8nLQ+nTjmnMtYvtdVfTokdtSsu+clwdrXeCO1UH9KlSPLnlCQt0YxSfVotXg7hTlcLn7SwTu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096762; c=relaxed/simple;
	bh=gBfm0UCEDBkhZ+euK1epKj4CTt6AuJnpmJ1TJnACk+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+jAQOJKV4I/52PN27iSRClI9vqLTdRNhe2g1Csqv+Bfw4FINqF+IcAH5AnfM0MPRaJJ8urxfrc/MRzOXVV/j67ad5MUzDPDN9Pdg5lCgYIpiLCZhaup6a9Kb7BXQl07hY+W131F5hzNSqBFnip5Egq6fTbIl04VpVy7Mdm4alo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P6oY7SWC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P6oY7SWC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dnz59lq7Mwo2c8sTomXViytjgGyZ+J7WBRI6d6haKhs=; b=P6oY7SWCP18IEwUeJ6yTRu0HMW
	ZUI1Z14yj/kKBua+s3dIWdkntudv6fPuHQlmu40iOua/T1L/2Yl6vaPq9FUSloxuI8d90e3tCUHBt
	icmmAl9PuUPYV2F5lbMXWIFGNOOarKmJVVcmXEmjOZYM6ieB+mFnBWJ/AFMg0Psif3hFSjPmXrk2o
	jxHDHLf8kASWJ7oZD6GPrWVOQGyeD6rnJcLBFT737HT8RAsh4l9gnh2pZGVYv+tsxFMBTFpBkc+Kp
	SSlmuwEXEcNcOt4Pm5ozgY9R65Ww8B0NtObF3MupGhRYszTWvK22X9wDR/HoN9ivIRV7YpCTunEHH
	zwwkTMvQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsH3R-00000008jyf-1P34;
	Fri, 07 Aug 2026 09:39:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2DBCC3004C9; Fri, 07 Aug 2026 11:39:51 +0200 (CEST)
Date: Fri, 7 Aug 2026 11:39:51 +0200
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
Subject: Re: [PATCH v6 1/3] perf/core: Fix NULL pmu_ctx passed to
 pmu->sched_task()
Message-ID: <20260807093951.GS776954@noisy.programming.kicks-ass.net>
References: <20260806135224.3267890-1-puranjay@kernel.org>
 <20260806135224.3267890-2-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806135224.3267890-2-puranjay@kernel.org>

On Thu, Aug 06, 2026 at 06:52:21AM -0700, Puranjay Mohan wrote:
> perf_pmu_sched_task() returns early when cpuctx->task_ctx is set, and
> cpc->task_epc is only non-NULL while a task context is scheduled in on
> this CPU. __perf_pmu_sched_task() therefore always passes NULL:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 00
>   pc : armv8pmu_sched_task+0x14/0x50
>   Call trace:
>    armv8pmu_sched_task+0x14/0x50 (P)
>    perf_pmu_sched_task+0xac/0x108
>    __perf_event_task_sched_out+0x6c/0xe0
> 
> Pass &cpc->epc instead. __perf_init_event_pmu_context() sets its ->pmu
> when the PMU is registered; ->ctx stays NULL until a CPU-wide event
> attaches. That is enough here because armv8pmu_sched_task() is the only
> in-tree implementation that dereferences the argument at all, and it
> only reads ->pmu. The oops therefore needs BRBE, which arrived in v6.17.
> 
> Fixes: bd2756811766 ("perf: Rewrite core context handling")
> Cc: stable@vger.kernel.org
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/events/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index b282de3e7d7ca..9815894b67e77 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3907,7 +3907,8 @@ static void __perf_pmu_sched_task(struct perf_cpu_pmu_context *cpc,
>  	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>  	perf_pmu_disable(pmu);
>  
> -	pmu->sched_task(cpc->task_epc, task, sched_in);
> +	pmu->sched_task(cpc->task_epc ? cpc->task_epc : &cpc->epc,
> +			task, sched_in);

This can be written like: cpc->task_epc ?: &cpc->epc.

However, if cpc-task_epc is always NULL, then this all seems like an
overly complicated way of writing: &cpc->epc. What gives?
