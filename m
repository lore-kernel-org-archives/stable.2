Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E7434CFD3;
	Fri, 12 Jun 2026 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257616; cv=none; b=WwV4ztho/iVTNXyO6v1aye+uzzU0oJfnLNgVkbT0M4spVOowrxW6ImwBZW5Ad5cHkBlnvlPfweH4lvAUYI9PiGfqVRKaSGqAsLTuDyqRlV7CDfzLswt/jZ1v0f5ZJq0cCJlHDsfeMTZJF59CTOF07TPFFZ/cbw0Rhz6VzeAhDt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257616; c=relaxed/simple;
	bh=CmjqGI0s0vnqCK5JH597mmLCQGFSpnabTIVdkKXBQ0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNDzn8cbnhIf6u6UfCo9k5IV+vwUG+aNLPZRitXyfzx97BihGQ3P9fArCeiyJkilo/+hh22l/p2qJPqQj/z1VBaxOOCp3Mfke72WZj6QS6XIvxW4zQ5Fg1q2U3iXdQ+Eq1JHk820saA9b8/z02rI1A/957UI2N1uaAFjrH7Ekng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VNA323Dr; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VNA323Dr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rMS1rHvde0qOXS7Wu2x8UE9Q5Ye6ybC0ttjK2rfWB6Q=; b=VNA323DrX5BNk+JJOWyjsWhp3k
	KPj5g5zLfSAQIow4hDlCntjhnbabObBxW8UOZtzL2wXIXTvqeF/7jEUjfw/Ud3Wp5q9ZvMTGb81iB
	v27eu5sR/BcKatXQzYxNq5Yv0Sy/4YPaAcSlr3p/f/yKH/UvwfgQ+rkDExA11Ofac8m4Iw6wB2xxx
	gEJWdpOTl/1z1um/xIETExZlQnjjbZkhVFf0dm9cDLafES15o59uvv4nCN5YUhLn5DdAK3yR7UG8R
	2LdMBx1GMhnqwKb+JGeVtDJCOU1qQNTE/3OcPDbNkhQDS90gPksnH0E7Zx1qIMJPWuNGxzZsuITSN
	ahHKxomQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXyTR-00000006G7b-35qA;
	Fri, 12 Jun 2026 09:46:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C62ED300312; Fri, 12 Jun 2026 11:46:48 +0200 (CEST)
Date: Fri, 12 Jun 2026 11:46:48 +0200
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
Subject: Re: [Patch v3 1/8] perf/x86/intel: Remove anythread_deprecated bit
 from perf_capabilities
Message-ID: <20260612094648.GB42921@noisy.programming.kicks-ass.net>
References: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
 <20260612090114.3188886-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612090114.3188886-2-dapeng1.mi@linux.intel.com>

On Fri, Jun 12, 2026 at 05:01:07PM +0800, Dapeng Mi wrote:
> AnyThread mode deprecation is enumerated by CPUID.0AH:EDX[15] instead of
> PERF_CAPABILITIES MSR. It's not a good practice to define a bit to
> represent "anythread deprecation" in perf_capabilities. It leads to the
> anythread_deprecated bit could be overwritten by the real value of
> PERF_CAPABILITIES MSR, just like the below code in update_pmu_cap() does.
> 
> ```
> if (!intel_pmu_broken_perf_cap()) {
> 	/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
> 	rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
> }
> ```
> 
> It leads to the anythread_deprecated bit is cleared to 0 and the "any"
> attribute is incorrectly shown in the /sys/devices/cpu/format/ folder on
> these support Perfmon v6 platforms, like Clearwater Forest.
> 
> ```
> $grep . /sys/devices/cpu/format/*
> /sys/devices/cpu/format/acr_mask:config2:0-63
> /sys/devices/cpu/format/any:config:21
> /sys/devices/cpu/format/cmask:config:24-31
> ```
> 
> So remove the anythread_deprecated bit from perf_capabilities structure
> and directly depends on CPUID.0AH:EDX[15] to judge if anythread is
> deprecated.

Again, no markdown please. I've stripped it from these patches.
