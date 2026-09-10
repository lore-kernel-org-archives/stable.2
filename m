Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859FA4CCDFF
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067338; cv=none; b=j2a6d0kR5H0bmAjFsvn3LMMEgI/C81SjCnqmYoTx6nSPt4yVSGDE61Prg9/VG2WKs5/05RV5iv/7blCpM7dijX7SDVpdzt3LSAzw4eFwdjkETn9ViLgxhmdUmObhYUemoUGK8ZlnWIUZaOTL+Gynu+REXzArE3OEPhjozEme5SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067338; c=relaxed/simple;
	bh=zSohi2TuYm/L5WReCkcQFRR5fFCPyQmEfF+kwisoMV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCneO4QQ9s30m3yLbtJ+ZDZOyIWMMa4ImfRFRIAoLfZSdjk4uTQz+UZAaGafWWW4VIM+6b8uJlQBYU376XeLT2bcJ1VR9txWOAwdAtrNVoyxNn3bXyGhJPIDspWzvC8/gvAzFHMqjrsdRa+KzulvTmGD3NiyUle6FLekIZ9txnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjSVIE/v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjSVIE/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F101F00899;
	Thu, 10 Sep 2026 19:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067335;
	bh=AjbSjAHun/5NStFg5/JglzQGeP7AnyDf24VWUjWfCeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EjSVIE/v+RStXnusloWOZ0Lbwj9C/7ZCY626Xmwbxehzs3vwLDmOmcA8xwitDN9z2
	 RuDnDAV9hK+JWb7M3MJqH2DGomMUeh+J4uG/GTqdOtfCJUYWJ/QokLDZSnK7+ONQjK
	 mG+GCnnwE24Wji58gK8MSWByM1jp63TBJHlSR7KyhkzQYE4HCjFJByThk9/BNrWaI/
	 49Oik+E611YvYtUjNaGhbDT6jJ08t/6Oiy1fQDW+QkI+SXGSTPhlNzcKH+2ahn6ojr
	 rXWWwnZPciWhf3KO4wyFWj3kMgWdLb8ecmILvmexEriWBcz3YgIPZ3BMQlGOL4v2n+
	 xCNS9ENQo0syQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Zide Chen <zide.chen@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] perf/x86/intel: Remove anythread_deprecated bit from perf_capabilities
Date: Thu, 10 Sep 2026 15:08:52 -0400
Message-ID: <20260910190852.1454402-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910190852.1454402-1-sashal@kernel.org>
References: <2026090959-treadmill-straddle-c245@gregkh>
 <20260910190852.1454402-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

[ Upstream commit 8767b4d73018bd3143f4c55b672064fad292f11b ]

AnyThread mode deprecation is enumerated by CPUID.0AH:EDX[15] instead of
PERF_CAPABILITIES MSR. It's not a good practice to define a bit to
represent "anythread deprecation" in perf_capabilities. It leads to the
anythread_deprecated bit could be overwritten by the real value of
PERF_CAPABILITIES MSR, just like the below code in update_pmu_cap() does.

if (!intel_pmu_broken_perf_cap()) {
	/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
	rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
}

It leads to the anythread_deprecated bit is cleared to 0 and the "any"
attribute is incorrectly shown in the /sys/devices/cpu/format/ folder on
these support Perfmon v6 platforms, like Clearwater Forest.

$ grep . /sys/devices/cpu/format/*
/sys/devices/cpu/format/acr_mask:config2:0-63
/sys/devices/cpu/format/any:config:21
/sys/devices/cpu/format/cmask:config:24-31

So remove the anythread_deprecated bit from perf_capabilities structure
and directly depends on CPUID.0AH:EDX[15] to judge if anythread is
deprecated.

Fixes: cadbaa039b99 ("perf/x86/intel: Make anythread filter support conditional")
Reported-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260616044654.3468742-2-dapeng1.mi@linux.intel.com
[ Adjusted patch context to match the older PMU initialization and capability layout. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/core.c | 10 +++-------
 arch/x86/events/perf_event.h |  2 +-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ddde2f1d0bd29..f7b4db1132bcd 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6538,12 +6538,6 @@ __init int intel_pmu_init(void)
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
 
-	if (version >= 5) {
-		x86_pmu.intel_cap.anythread_deprecated = edx.split.anythread_deprecated;
-		if (x86_pmu.intel_cap.anythread_deprecated)
-			pr_cont(" AnyThread deprecated, ");
-	}
-
 	/*
 	 * Install the hw-cache-events table:
 	 */
@@ -7271,8 +7265,10 @@ __init int intel_pmu_init(void)
 				      &x86_pmu.intel_ctrl);
 
 	/* AnyThread may be deprecated on arch perfmon v5 or later */
-	if (x86_pmu.intel_cap.anythread_deprecated)
+	if (version >= 5 && edx.split.anythread_deprecated) {
 		x86_pmu.format_attrs = intel_arch_formats_attr;
+		pr_cont("AnyThread deprecated, ");
+	}
 
 	intel_pmu_check_event_constraints(x86_pmu.event_constraints,
 					  x86_pmu.cntr_mask64,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ab77bc634c392..c82c6b5e4013a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -630,7 +630,7 @@ union perf_capabilities {
 		u64	perf_metrics:1;
 		u64	pebs_output_pt_available:1;
 		u64	pebs_timing_info:1;
-		u64	anythread_deprecated:1;
+		u64	__reserved:1;
 	};
 	u64	capabilities;
 };
-- 
2.53.0

