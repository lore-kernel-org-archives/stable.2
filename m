Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306CA27AC31
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085753; cv=none; b=CoV2tUbae1IQzM5jaRHcKXKUjpNaik7Ppm07tUfCDFPHHUFM3BZskWz0m+7QWVtns/2VLoSMdrGtgV2AXvlLCftQDYvouHUpgike8MbhY5P1MfByuwbFu9y8Mvr4CtJcWVASse4aQXGKq6XbYaH35aX7Bk9WIWtbbLvk6lkFYxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085753; c=relaxed/simple;
	bh=IM+CbmMBkg/UeFiSWKY0w8PujokSmHFHLYEp3JwQz5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egrckSzyTZ+ppYfd0bL4ilrugZcpksCVqwsBHn+x44AeojequgexzMdkuDAO0sNZx7otilpMlS8ao0EULmu0OeX01PEesAkf4GjUuAPbmnPx0PslOGOCQj+IIYS5AQwl7Z+czZpIDhZyWrSPH5r3WjQ0bcPdQfSuFO5f799zTKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PspdeZMF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PspdeZMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4F81F000FF;
	Fri, 11 Sep 2026 00:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789085750;
	bh=vkFH9OWKCH5l4Z8ZCkMba1BL5dDhklhiGSrqIgyeiXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PspdeZMFdVSFGirWzp2HXZcB4CDoUcKziscCd89j8hs2NEfP9dQH3Xzbp9L6yCoAS
	 6e4qVJ0lK+z0wwH2MXoNxqSwSI3/jR19p12WhjlSpan5HsF940Cc3oI49lVW5D2lWB
	 sHTeGyaoDwnxsb+v2a+9mJ5+bipnCnbZDVR3a3dyu4XfL2gTnXvQp8Y97fmOkso0y1
	 zzi/J4DrlJ/zujz8USLScyBKItN+HcPv0JvxH2YDoA4l+C8iQDpTXTUkoc1dPX4Ff3
	 GWN4TGsty3m+pDFPiy0hHSVdKjgAhzV9W0dMoPaa9g+tft2YL+gv5yOT3LWGrhbCkS
	 cI5CygAPkTE2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Zide Chen <zide.chen@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] perf/x86/intel: Remove anythread_deprecated bit from perf_capabilities
Date: Thu, 10 Sep 2026 20:15:47 -0400
Message-ID: <20260911001547.3304279-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090900-customize-unhidden-1ace@gregkh>
References: <2026090900-customize-unhidden-1ace@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/core.c | 10 +++-------
 arch/x86/events/perf_event.h |  2 +-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b1bc81bef4083..4b2b17d8d89d2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5971,12 +5971,6 @@ __init int intel_pmu_init(void)
 
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
@@ -6715,8 +6709,10 @@ __init int intel_pmu_init(void)
 				     (u64)fixed_mask);
 
 	/* AnyThread may be deprecated on arch perfmon v5 or later */
-	if (x86_pmu.intel_cap.anythread_deprecated)
+	if (version >= 5 && edx.split.anythread_deprecated) {
 		x86_pmu.format_attrs = intel_arch_formats_attr;
+		pr_cont("AnyThread deprecated, ");
+	}
 
 	intel_pmu_check_event_constraints(x86_pmu.event_constraints,
 					  x86_pmu.num_counters,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index b95cab9846dd7..5f93316c60216 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -606,7 +606,7 @@ union perf_capabilities {
 		u64     pebs_baseline:1;
 		u64	perf_metrics:1;
 		u64	pebs_output_pt_available:1;
-		u64	anythread_deprecated:1;
+		u64	__reserved:1;
 	};
 	u64	capabilities;
 };
-- 
2.53.0

