Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE4826E142;
	Mon, 15 Jun 2026 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781494106; cv=none; b=ek6vLKR7etc14s+bFt/gRvOzbwxfgdxGcvGTqWrCNITmf26h9R/nFd2OTFFXo7F28qYVRlDTflYLg1BXbqE3vxAlm9HzTmYEuZyhooL/+avB7avEZvLCtdae2Vm2/to2AzRAwFRWKpc2SooMQaq2REJvkexpQQsR31nEMar/ar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781494106; c=relaxed/simple;
	bh=4QSeKF6M2bUtmSPGPmXEQd1gPEVqe2+AlnvWiJkvk4A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=p1SQDSeDX1tztJrVO7vai74Z6Oz/DyJM0fGzmBuagnFShjCoqVR9iA+Updm4Ik6wm0RIoqJ6rNhEIKnt4Y/cwPwORNmJ2xk0OPQ7lIv2wOW0B4WT0FUdz2SUhN2NAJxNwBhbtUEGMAvk+ixdX8k4Y0X5cPBOTw1+6JzpNbtTM+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dfC+60IP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dfC+60IP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781494105; x=1813030105;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=4QSeKF6M2bUtmSPGPmXEQd1gPEVqe2+AlnvWiJkvk4A=;
  b=dfC+60IPa18fv0/AVEbuZE6fq66/1zO0oWwrpEvqENkDKUD78FMgF54t
   dAkQ5uKFVF/LckFGvIZSgemTO1C8xrGlU/J15+u5+QF6N19r+xiZ3PPoD
   BhuOISOP6ddRtwidE7UZFb6skYQB0oH8zJo7gHQ5pbVE846RPndyfP/2w
   lF/Uk6k+MhgNIL9Xsm3AT6r8IO4X7eKdHxANgJJAiU3XMjagmr3219yLf
   4z8GcnFwWEdk8zp0z865ibgs0zrHOa/TQeR010zRNfb9TLqiyjpP/zum6
   X62DOCliGkPwqloGlKFsGCR54xzKXWsebvdR8yJbMgRB1XQLr398P1AUx
   w==;
X-CSE-ConnectionGUID: Cx+qcwZySWmXyP3CXX7JzQ==
X-CSE-MsgGUID: OwgBu3uxQEmadMOKs3P2Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="82239981"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="82239981"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 20:28:24 -0700
X-CSE-ConnectionGUID: bv2PsRgiR9enq/l6OvGb4A==
X-CSE-MsgGUID: 0mi2TBzDRv6fQxTpBXaUmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="247443760"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 20:28:20 -0700
Message-ID: <603bdf11-1bf1-4781-b129-c13da7c5e386@linux.intel.com>
Date: Mon, 15 Jun 2026 11:28:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 1/8] perf/x86/intel: Remove anythread_deprecated bit
 from perf_capabilities
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
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
Content-Language: en-US
In-Reply-To: <96a18944-bc0d-47dd-b435-e9aa63b93c43@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/15/2026 8:59 AM, Mi, Dapeng wrote:
> On 6/12/2026 5:46 PM, Peter Zijlstra wrote:
>> On Fri, Jun 12, 2026 at 05:01:07PM +0800, Dapeng Mi wrote:
>>> AnyThread mode deprecation is enumerated by CPUID.0AH:EDX[15] instead of
>>> PERF_CAPABILITIES MSR. It's not a good practice to define a bit to
>>> represent "anythread deprecation" in perf_capabilities. It leads to the
>>> anythread_deprecated bit could be overwritten by the real value of
>>> PERF_CAPABILITIES MSR, just like the below code in update_pmu_cap() does.
>>>
>>> ```
>>> if (!intel_pmu_broken_perf_cap()) {
>>> 	/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
>>> 	rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
>>> }
>>> ```
>>>
>>> It leads to the anythread_deprecated bit is cleared to 0 and the "any"
>>> attribute is incorrectly shown in the /sys/devices/cpu/format/ folder on
>>> these support Perfmon v6 platforms, like Clearwater Forest.
>>>
>>> ```
>>> $grep . /sys/devices/cpu/format/*
>>> /sys/devices/cpu/format/acr_mask:config2:0-63
>>> /sys/devices/cpu/format/any:config:21
>>> /sys/devices/cpu/format/cmask:config:24-31
>>> ```
>>>
>>> So remove the anythread_deprecated bit from perf_capabilities structure
>>> and directly depends on CPUID.0AH:EDX[15] to judge if anythread is
>>> deprecated.
>> Again, no markdown please. I've stripped it from these patches.
> My bad. Thanks a lot.
>
> BTW, Peter, have you pull these patches? I didn't see them in perf/core or
> perf/urgent branches. Sashiko reports a defect about "Patch 5/8:
> perf/x86/intel: Validate the return value of intel_pmu_init_hybrid()". If
> not, I would post a v4 patchset to fix the defect. Thanks.

Just found the patches are merged into the perf/core branch in peterz/queue
tree. :)

Peter, Sashiko raises below concern against the patch 5/8: "perf/x86/intel:
Validate the return value of intel_pmu_init_hybrid()",

"

[Severity: Medium]
Does moving intel_pmu_arch_lbr_init() below
intel_pmu_check_event_constraints_all() bypass the dynamic constraint
validation for branch counters?

When intel_pmu_check_event_constraints_all() runs, it eventually calls
intel_pmu_check_dyn_constr(). This check relies on the PMU_FL_BR_CNTR flag
and the x86_pmu.lbr_counters mask:

arch/x86/events/intel/core.c:intel_pmu_check_dyn_constr() {
    ...
        case DYN_CONSTR_BR_CNTR:
            if (x86_pmu.flags & PMU_FL_BR_CNTR)
                mask = x86_pmu.lbr_counters;
            break;
    ...
}

Because intel_pmu_arch_lbr_init() is now deferred until after this validation,
the PMU_FL_BR_CNTR flag hasn't been set yet. Will this cause the dynamic
constraint check for branch counters to evaluate to false and be skipped?

"

It's a true defect. We need below changes to fix the defect. Would you
prefer to post a new patchset or just a single patch to fix the defect? Thanks.

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 74dbf24b0ab6..edf6f8732234 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -8840,11 +8840,11 @@ __init int intel_pmu_init(void)
                pr_cont("AnyThread deprecated, ");
        }

-       intel_pmu_check_event_constraints_all(NULL);
-
        if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
                intel_pmu_arch_lbr_init();

+       intel_pmu_check_event_constraints_all(NULL);
+
        /*
         * Access LBR MSR may cause #GP under certain circumstances.
         * Check all LBR MSR here.


>
>
>
