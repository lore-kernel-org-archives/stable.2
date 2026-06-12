Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D576F3932CA;
	Fri, 12 Jun 2026 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255198; cv=none; b=MkyB0G09ojiDxGkr/00RPlLyUfbqHNlaUfSteRoq21Xq4mALQwwI1Ng7mldyMVIpz2V7fjICPUx3r4lzJYGdCuJ0kZiRl3P41+HTuwRF91NreJSrR+WtNd+D8aMf5EkhOW1BJFGVj8uiYEI73WI+NLFU6aKRXbd7JeoiTR0e/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255198; c=relaxed/simple;
	bh=bD1BoXiqmyShSlNLT1bIG3TBncZCHp9m1WFvtZGgQc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GHVcuZpCdn8kqcfKUGE3cg81G7EnSlbo88mXj7grbYGRtkAg3eFZwxPWxqRnRQiKjmh7hQkQk1t3jHdPPZSWCKeWoMWvrMeQ/el5cX3uejh7ICR24YLoQkBKoaPJytuvdgUbURJtiz93STAxSIxY8ANIKEMTD3Pd6Ody/u+QXh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhTI3J9w; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhTI3J9w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781255194; x=1812791194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bD1BoXiqmyShSlNLT1bIG3TBncZCHp9m1WFvtZGgQc0=;
  b=FhTI3J9wErRBQoxmu7mM8aAflNnDbYp2wWoBRYlBohekdIMNuEKeMPIg
   aA0V0wNBCFw+QO2zO2be9wjZePjqwERV1+f4ywB6Z5rvd2URThfuK1jcW
   07sXxE8NSQvtWt+zPBe1KtHDMyiOitqTxbD/+gFmRM+nQrn/a/bzfbsVd
   DZhWqEPfs8U0ksIQWEI+VlrRkBRikegSDzwcoLMJIex+1YuJlM9Qf3lrw
   VzDrZ+DuCA0Nf3PKx+VAVYeSdR/rf0gFDt+BTVAqNfK5OFh+GxaYwCHGW
   uV9QlI+/mjuX3iTlv1vxxg3uHbJHSJ3fZXO+69FcAesiR3FBbGqiJIRAo
   A==;
X-CSE-ConnectionGUID: Bp/lW3JOTsSW72+QSh9riA==
X-CSE-MsgGUID: vwMdoXf+SiGwJP2rfmS/cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85714427"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="85714427"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 02:06:34 -0700
X-CSE-ConnectionGUID: EheoKvP3R/uuYRbPgxi40Q==
X-CSE-MsgGUID: qOaetd5vRrOPJGqT8pxa/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="246838638"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa007.jf.intel.com with ESMTP; 12 Jun 2026 02:06:30 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	stable@vger.kernel.org
Subject: [Patch v3 1/8] perf/x86/intel: Remove anythread_deprecated bit from perf_capabilities
Date: Fri, 12 Jun 2026 17:01:07 +0800
Message-Id: <20260612090114.3188886-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
References: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AnyThread mode deprecation is enumerated by CPUID.0AH:EDX[15] instead of
PERF_CAPABILITIES MSR. It's not a good practice to define a bit to
represent "anythread deprecation" in perf_capabilities. It leads to the
anythread_deprecated bit could be overwritten by the real value of
PERF_CAPABILITIES MSR, just like the below code in update_pmu_cap() does.

```
if (!intel_pmu_broken_perf_cap()) {
	/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
	rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
}
```

It leads to the anythread_deprecated bit is cleared to 0 and the "any"
attribute is incorrectly shown in the /sys/devices/cpu/format/ folder on
these support Perfmon v6 platforms, like Clearwater Forest.

```
$grep . /sys/devices/cpu/format/*
/sys/devices/cpu/format/acr_mask:config2:0-63
/sys/devices/cpu/format/any:config:21
/sys/devices/cpu/format/cmask:config:24-31
```

So remove the anythread_deprecated bit from perf_capabilities structure
and directly depends on CPUID.0AH:EDX[15] to judge if anythread is
deprecated.

Cc: stable@vger.kernel.org
Reported-by: Namhyung Kim <namhyung@kernel.org>
Fixes: cadbaa039b99 ("perf/x86/intel: Make anythread filter support conditional")
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
---
 arch/x86/events/intel/core.c | 10 +++-------
 arch/x86/events/perf_event.h |  2 +-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0217e701aeeb..ea3ab3050a3b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7946,12 +7946,6 @@ __init int intel_pmu_init(void)
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
 
-	if (version >= 5) {
-		x86_pmu.intel_cap.anythread_deprecated = edx.split.anythread_deprecated;
-		if (x86_pmu.intel_cap.anythread_deprecated)
-			pr_cont(" AnyThread deprecated, ");
-	}
-
 	/* The perf side of core PMU is ready to support the mediated vPMU. */
 	x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_MEDIATED_VPMU;
 
@@ -8828,8 +8822,10 @@ __init int intel_pmu_init(void)
 				      &x86_pmu.intel_ctrl);
 
 	/* AnyThread may be deprecated on arch perfmon v5 or later */
-	if (x86_pmu.intel_cap.anythread_deprecated)
+	if (version >= 5 && edx.split.anythread_deprecated) {
 		x86_pmu.format_attrs = intel_arch_formats_attr;
+		pr_cont("AnyThread deprecated, ");
+	}
 
 	intel_pmu_check_event_constraints_all(NULL);
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index eae24bb35dc1..5902a297daa1 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -668,7 +668,7 @@ union perf_capabilities {
 		u64	perf_metrics:1;
 		u64	pebs_output_pt_available:1;
 		u64	pebs_timing_info:1;
-		u64	anythread_deprecated:1;
+		u64	__reserved:1;
 		u64	rdpmc_metrics_clear:1;
 	};
 	u64	capabilities;
-- 
2.34.1

