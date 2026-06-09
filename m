Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E6735A93C;
	Tue,  9 Jun 2026 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016778; cv=none; b=tCHUxfPEhx3eATsb+16ZqGSuhM5bgZ2SsvHHXVcDdCIdR3gN1Rc3hyLswMeXHKfjOZoKqA4KHDC4UzgGMYP2g6w90zuEyp5S+xS9C1W70qh5cCoNlv4HWPoaIooJD/738E2IgBv1DaIg05IAtcchDEZdlSFkaO7STciMeRZJiXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016778; c=relaxed/simple;
	bh=bC4btuelzMei4hLLrWdDC/hyQ6n1RGKvzOIi72zxWqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iULhsxW5bNXieCm0U0xRUVSRqpR+EbPLqWz1LqQP1M1pUxfAsJFwhMFQTylENFtihFPgvcwXGtPvCAnPKAl8+R9uLzCkn2PwF8eZEbY+Q/+3qI0HnC9tVOCqEq9ige4Nr36LA0Cv2g7filp8rGyPNCFFmCtQX6Ds8KmvITTDbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FH9KAw83; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FH9KAw83"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ma2XbH47OgCHmSnYRO01b2N3/ZgGpdGZ5hjI2OZ/1Ik=; b=FH9KAw83AZAGVh90QtebTL+7wr
	D7rCXXQoZ+vmhtRu7uLj9tvScXO3u554WJdlVtWEiBHjX5EpP4NNC7JAmsescMX+xL/ZhrJsDOFSS
	/3g7g0Ux+Z0H1IZI6RHEhlCcTGYqzSXlh30zu7Huoa3ArqMoXH/79wuz4bIqWZTXvo7aY7xmZdTmj
	WVYz9tg8nn3cTu7PJkoyc+Jj4hc+C+GdojXfoManMdlIeX7AnFXoNhAVsUYMJqSXiffp8l88oI+9j
	lWRC0P8/tdOIvnSUwpBz0fk2XvIjwDdBUdhu5Y99Wobhq90q5hVAl+zMBPDdmO/bNhhYeFSw+7DSf
	9ppLGcoA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWxox-00000002gS9-36HN;
	Tue, 09 Jun 2026 14:52:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BA2B7302F12; Tue, 09 Jun 2026 16:52:50 +0200 (CEST)
Date: Tue, 9 Jun 2026 16:52:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>, stable@vger.kernel.org
Subject: Re: [Patch v2 5/9] perf/x86/intel: Drop LBR entries whose privilege
 level mismatches br_sel
Message-ID: <20260609145250.GD49951@noisy.programming.kicks-ass.net>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
 <20260609050222.2458129-6-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609050222.2458129-6-dapeng1.mi@linux.intel.com>

On Tue, Jun 09, 2026 at 01:02:18PM +0800, Dapeng Mi wrote:
> Before Arch LBR gained CPL filtering support, a user-only branch stack
> could still contain kernel addresses. As a result, kernel branch records
> may be exposed to user space even when PERF_SAMPLE_BRANCH_USER is
> requested.
> 
> For example, on Intel Tiger Lake, the following command can still report
> SYSRET/ERET entries with kernel-space from addresses:
> 
> ```
> $./perf record -e cycles:p -o - --branch-filter any,save_type,u -- \
>  	./perf bench syscall basic --loop 1000 | \
> 	./perf script -i - --fields brstack|tr ' ' '\n'| \
> 	grep -E '0x[89a-f][0-9a-f]{15}'
> 
>     Total time: 0.000 [sec]
> 
>       0.219000 usecs/op
>      4,566,210 ops/sec
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.551 MB - ]
> 0xffffffff93c001c8/0x7f12a2b1d647/P/-/-/16959/SYSRET/-
> 0xffffffff93c001c8/0x7f12a2b1d5c2/P/-/-/17535/SYSRET/-
> 0xffffffff93c01928/0x7f12a2861000/P/-/-/6719/ERET/-
> 0xffffffff93c01928/0x7f12a297a000/P/-/-/8575/ERET/-
> ```
> 
> The problem is that intel_pmu_lbr_filter() does not fully validate the
> privilege level of sampled entries. It filters some mismatches based on
> the branch type and the to address, but it does not reject entries whose
> from address violates the requested branch privilege filter.
> 
> Fix this by extending software filtering to validate both from and to
> addresses against br_sel. Any LBR entry whose privilege level does not
> match the requested user/kernel filter is dropped. This prevents kernel
> addresses from appearing in user-only branch stacks, and likewise drops
> user entries from kernel-only stacks.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Ian Rogers <irogers@google.com>
> Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/lbr.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index d4c0ed85e1fb..807ce903c972 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1212,7 +1212,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  {
>  	u64 from, to;
>  	int br_sel = cpuc->br_sel;
> -	int i, j, type, to_plm;
> +	int i, j, type, to_plm, from_plm;
>  	bool compress = false;
>  
>  	/* if sampling all branches, then nothing to filter */

If there, might as well order those variables in reverse xmas.
