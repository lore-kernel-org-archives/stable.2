Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED41848987A;
	Thu,  1 Oct 2026 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851093; cv=none; b=MAG6plBWpdy5+bjaC/TWXz6sXIF6eIzN+CNpvbzcFz79Y2HFiJAD7VWghL+ANk9CzaB6Q/lonl58CtkeOGQ3UpVkL+8gxF4bkCCB4sWf5zwiFVJK1TQ1oYXGcV3N179ymD0ndt/L2KfaG0w+zK3kF+E2pq4Aa7cniCgCx9iSa6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851093; c=relaxed/simple;
	bh=0lvoM9Uov0PHFv/TgK6E+rr+66xb8ImFzWK5QMpAxfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwIdeasGqNaz+kZXHEfQkPmPVL26mBu3lmUOh/jn4LzSdCxovwPETy6Z/qkK8koaTQUwY2RvWv/Fx4OHB5qPlITMrosy+1KpcbgvFIUDbskXd21bvmsQt6ECqfhHcXfDkfxgg5hZD/VOn3M00EyHzvnblqepBlZ704L9dZ3wWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZovrmFGb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZovrmFGb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d/SBfLmE/IUg/8bgov3UKQHIFsY518zkbIOQZphzmtM=; b=ZovrmFGbxw5w/3zLH1tF5kcXdq
	oUY8DVmjJSxMiKDVuyNPfNoECQ7eDvUjZ8+8AlUkvzGrJcIIcDND6KNDMDj6W1WwWdI6f+hBVX1mh
	Oj0w4y5iTkPK6mo9lYNfcZ4kPKEVyEnZxPQW62/hvncJS+LHY8oEWBiXIHL2Y1yT7SkypzdxIzLfs
	CJb61sZtqrtHrQLrtGZiNA3AfD6KSB1sXSyN4kmRrgssL2ljSfpLlrjU/HcFs+Knwm8ZJAEn6BSZH
	2J/EWhRs2NNbVpnlmke4+K6QQLZYK7LWQUclpjq05epGp2SEJ+i0uHaWLQHWiXfZYU+I8GXqI+Ue/
	yxogy0/Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xCEAo-00000004qnp-3U4k;
	Thu, 01 Oct 2026 10:37:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F17EE3001FD; Thu, 01 Oct 2026 12:37:57 +0200 (CEST)
Date: Thu, 1 Oct 2026 12:37:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zhengchuan Liang <zcliangcn@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] perf/core: Require kernel access for text poke events
Message-ID: <20261001103757.GV4120091@noisy.programming.kicks-ass.net>
References: <cover.1790573390.git.zcliangcn@gmail.com>
 <99131354c41e23188f778b92f90363775b482395.1790573390.git.zcliangcn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99131354c41e23188f778b92f90363775b482395.1790573390.git.zcliangcn@gmail.com>

On Mon, Sep 28, 2026 at 10:59:35AM -0700, Zhengchuan Liang wrote:
> Perf events with exclude_kernel=1 can be opened without kernel perf
> access. However, exclude_kernel does not suppress text-poke sideband
> records. Every PERF_RECORD_TEXT_POKE is marked PERF_RECORD_MISC_KERNEL
> and contains a raw kernel instruction address.
> 
> An unprivileged task can therefore open and mmap a task-local software
> event with text_poke=1. Both opening a count-only tracepoint event and
> configuring UDP GRO for ESP-in-UDP cause updates to inline static calls;
> the observer receives the relocated addresses of the modified instructions.
> For a known kernel image, any such address reveals the runtime kernel
> text base despite KASLR.
> 
> Call perf_allow_kernel() whenever attr.text_poke is set, regardless of
> exclude_kernel. Events that neither monitor kernel execution nor request
> text-poke records retain their existing permissions.
> 
> Fixes: e17d43b93e54 ("perf: Add perf text poke event")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>

Nice one. Thanks!

>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 634d2ccbab82..b4e6e8ae3be7 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13953,7 +13953,7 @@ SYSCALL_DEFINE5(perf_event_open,
>  	if (err)
>  		return err;
>  
> -	if (!attr.exclude_kernel ||
> +	if (!attr.exclude_kernel || attr.text_poke ||
>  	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
>  	     !attr.exclude_callchain_kernel)) {
>  		err = perf_allow_kernel();
> -- 
> 2.34.1
