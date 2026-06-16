Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8777425CF4;
	Tue, 16 Jun 2026 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604131; cv=none; b=gN+IBTb0dKz7N+dWrSt5p6yRSu5DA2qt/hyef9BsJSjp9Avju+dJ77lEh589S4sxS5MsTMyDR9onqM3rGQ4Ui+4+0ikJGHGM1qczJVDG15R1CP0SxLV2KhfOu8Y+VBwWMQwqhbv159P8bYgLIF/msHu2G0nBvwT4RZfiYtvi8Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604131; c=relaxed/simple;
	bh=BNy+8x57irBxsuWD1p+cRZxqf4Noxxn61V/KJ780R80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bROMZYUN4fwPMtzoVNonRWQwmfwvQa43v8sFrJCDlV/VBdmD9dzwS2LQFQ4teaZ7a5bdwA9HVK12n8skxl8rTZuzmq09emFTZjOBTpqln5iAr81hkgKxleH/ETK7NafrBuVIsjsySm7EzV2RdePpTE3R8SUak4rBSNqOB15jOzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oKv+fYVs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oKv+fYVs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0pA+uIAI5ZHf6Li4fMStaCXihEfBiMnRSgkaH7I2IhY=; b=oKv+fYVsRMSQNM3AM4uZ01aMcQ
	+x74yh6yddmOeVEOtBpiXMmJKE6qm1sB7NDnG78udDq7BU1D1fflLWhoLrSbIObf5H3ubYvbJ6Roy
	iXcy82V5JFSKGIgEwATrCax9GP8tv0syjJLsXOtESI8obC5T44LiGNWjOq/H7wFBonCczsfvcGQL3
	LtXzvelURnK5ApN+AHFgT3gKfUl00eYOsn1sDhjENtWnDCaAnCpRQxYNNOgu0sJXImjWo5y+oSmBz
	EFg0297wNTIIEQeqWW2bneMclSPjacA3fNnl8KZsijBXtgww071tOEkuNFUH53AOnZd6Jz5wDohMF
	Qeu7+Kzw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZQcM-0000000AWQ2-3yzO;
	Tue, 16 Jun 2026 10:02:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 18B3330036F; Tue, 16 Jun 2026 12:02:02 +0200 (CEST)
Date: Tue, 16 Jun 2026 12:02:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
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
Message-ID: <20260616100202.GJ42921@noisy.programming.kicks-ass.net>
References: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
 <20260612090114.3188886-2-dapeng1.mi@linux.intel.com>
 <20260612094648.GB42921@noisy.programming.kicks-ass.net>
 <96a18944-bc0d-47dd-b435-e9aa63b93c43@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96a18944-bc0d-47dd-b435-e9aa63b93c43@linux.intel.com>

On Mon, Jun 15, 2026 at 08:59:29AM +0800, Mi, Dapeng wrote:
> 
> On 6/12/2026 5:46 PM, Peter Zijlstra wrote:
> > On Fri, Jun 12, 2026 at 05:01:07PM +0800, Dapeng Mi wrote:
> >> AnyThread mode deprecation is enumerated by CPUID.0AH:EDX[15] instead of
> >> PERF_CAPABILITIES MSR. It's not a good practice to define a bit to
> >> represent "anythread deprecation" in perf_capabilities. It leads to the
> >> anythread_deprecated bit could be overwritten by the real value of
> >> PERF_CAPABILITIES MSR, just like the below code in update_pmu_cap() does.
> >>
> >> ```
> >> if (!intel_pmu_broken_perf_cap()) {
> >> 	/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
> >> 	rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
> >> }
> >> ```
> >>
> >> It leads to the anythread_deprecated bit is cleared to 0 and the "any"
> >> attribute is incorrectly shown in the /sys/devices/cpu/format/ folder on
> >> these support Perfmon v6 platforms, like Clearwater Forest.
> >>
> >> ```
> >> $grep . /sys/devices/cpu/format/*
> >> /sys/devices/cpu/format/acr_mask:config2:0-63
> >> /sys/devices/cpu/format/any:config:21
> >> /sys/devices/cpu/format/cmask:config:24-31
> >> ```
> >>
> >> So remove the anythread_deprecated bit from perf_capabilities structure
> >> and directly depends on CPUID.0AH:EDX[15] to judge if anythread is
> >> deprecated.
> > Again, no markdown please. I've stripped it from these patches.
> 
> My bad. Thanks a lot.
> 
> BTW, Peter, have you pull these patches? I didn't see them in perf/core or
> perf/urgent branches. Sashiko reports a defect about "Patch 5/8:
> perf/x86/intel: Validate the return value of intel_pmu_init_hybrid()". If
> not, I would post a v4 patchset to fix the defect. Thanks.
> 

I had them in queue:perf/core, but realized it was *really* late in the
window. I'll probably move them into tip post -rc1. If there's a new
version by then, I'll be sure to pick it up.
