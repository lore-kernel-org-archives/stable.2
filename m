Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E610164A8C;
	Wed, 17 Jun 2026 00:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781655268; cv=none; b=FENBLZT+jxsiq/ASZjeOzo4FYAD14Tffuz2mFgP1hH7jK+5S+QCYArulwxki8DRf5bsoAqCpAemLHTiqKv6M6Hh0aibgHlWJT0ZoPGYj+Xk6w7w236Oisfq54dVmLuoxSSORTG1Irt1xgWnBNJE8oyDLEE3DxEnyRsyVlQPJV4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781655268; c=relaxed/simple;
	bh=m4b8G7jItuY1gGNh1LAd2eHdKrNcegBZPJbhiqWxcoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XrnY1dJnT2pYcRnS3sjCeiHfXWuomquw2nc9W8dAuZqA0G/JqxYH0L/jD7STzMjRsWZ3Kvs7pSjM0TMo6VLqPuv5aTGMA3qTt7h/duQm4fpeHb4p0naujICA6uEq+TH4r2DG203CEJfgu9nJ68r5VoGCyRX2PH2RirtzxbKW9xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hsd3cEbc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hsd3cEbc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781655266; x=1813191266;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m4b8G7jItuY1gGNh1LAd2eHdKrNcegBZPJbhiqWxcoo=;
  b=Hsd3cEbcxXdIQttnVAHd1iB0tjzlMmv1PXWNIrd3zmofD9IZ6wLe4oDV
   gnd2YPEiIRRSdMbFpc9anl4GpyUBcwW+dc6f63uHioF7TNMYHjMXw9BzP
   GygeVV2+ZqsB5VFIJOU+vGyU3b84QKBXneEogpink0yBFMJmbF/J6XaRM
   japK+1PUytIdKGEAbTJxLNG6rx4CBRa90v5NWNC5B4zaLp+Qnk0S+R142
   o3BzvNLIRGOSX6Kn4zy1LkkvfqXmvTZcGKSqyuT7O4pWZrbK69XbA1JxA
   wrudbJCnRzvW3+UNkcNx1ueQv6xtnX3LcM71v2hC6I4Cdn+cEAxqKwtT2
   g==;
X-CSE-ConnectionGUID: aKNDIfOoQXqVtxm4LNMFMA==
X-CSE-MsgGUID: Mpk6vBKdRiebZ7COvvi8KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82340983"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82340983"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 17:14:25 -0700
X-CSE-ConnectionGUID: 12mnV9WcQCSHP4om7t8aQg==
X-CSE-MsgGUID: eQ8zBdHMTvubKd7ktbpVQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="252234066"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 17:14:21 -0700
Message-ID: <47a9642f-68ab-432c-a607-548995bd82fa@linux.intel.com>
Date: Wed, 17 Jun 2026 08:14:18 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 1/8] perf/x86/intel: Remove anythread_deprecated bit
 from perf_capabilities
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 stable@vger.kernel.org
References: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
 <20260612090114.3188886-2-dapeng1.mi@linux.intel.com>
 <20260612094648.GB42921@noisy.programming.kicks-ass.net>
 <96a18944-bc0d-47dd-b435-e9aa63b93c43@linux.intel.com>
 <20260616100202.GJ42921@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260616100202.GJ42921@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/16/2026 6:02 PM, Peter Zijlstra wrote:
> On Mon, Jun 15, 2026 at 08:59:29AM +0800, Mi, Dapeng wrote:
>> On 6/12/2026 5:46 PM, Peter Zijlstra wrote:
>>> On Fri, Jun 12, 2026 at 05:01:07PM +0800, Dapeng Mi wrote:
>>>> AnyThread mode deprecation is enumerated by CPUID.0AH:EDX[15] instead of
>>>> PERF_CAPABILITIES MSR. It's not a good practice to define a bit to
>>>> represent "anythread deprecation" in perf_capabilities. It leads to the
>>>> anythread_deprecated bit could be overwritten by the real value of
>>>> PERF_CAPABILITIES MSR, just like the below code in update_pmu_cap() does.
>>>>
>>>> ```
>>>> if (!intel_pmu_broken_perf_cap()) {
>>>> 	/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
>>>> 	rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
>>>> }
>>>> ```
>>>>
>>>> It leads to the anythread_deprecated bit is cleared to 0 and the "any"
>>>> attribute is incorrectly shown in the /sys/devices/cpu/format/ folder on
>>>> these support Perfmon v6 platforms, like Clearwater Forest.
>>>>
>>>> ```
>>>> $grep . /sys/devices/cpu/format/*
>>>> /sys/devices/cpu/format/acr_mask:config2:0-63
>>>> /sys/devices/cpu/format/any:config:21
>>>> /sys/devices/cpu/format/cmask:config:24-31
>>>> ```
>>>>
>>>> So remove the anythread_deprecated bit from perf_capabilities structure
>>>> and directly depends on CPUID.0AH:EDX[15] to judge if anythread is
>>>> deprecated.
>>> Again, no markdown please. I've stripped it from these patches.
>> My bad. Thanks a lot.
>>
>> BTW, Peter, have you pull these patches? I didn't see them in perf/core or
>> perf/urgent branches. Sashiko reports a defect about "Patch 5/8:
>> perf/x86/intel: Validate the return value of intel_pmu_init_hybrid()". If
>> not, I would post a v4 patchset to fix the defect. Thanks.
>>
> I had them in queue:perf/core, but realized it was *really* late in the
> window. I'll probably move them into tip post -rc1. If there's a new
> version by then, I'll be sure to pick it up.

Thanks Peter. I posted the v4 patchset yesterday to fix the defect of
Sashiko. Please pick up the v4 version. Here is the v4 patchset link. 

https://lore.kernel.org/all/20260616044654.3468742-1-dapeng1.mi@linux.intel.com/


