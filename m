Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E37F4F1
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086566; cv=none; b=flKtIhOhZqUySx4+tSWDVfCIXuxxIo1vvuNewDjoG9JQf5WwKTDJJ/+ZxpCA9kVruj5r5CQpSDEYJlTLDG1vbUCX2V06l3D/wrNe8NTkkb0xiojZ/Qy/r7yjNm7r1yxDVZ5D6aRl9RzH42vGNc+S7pXYXjLCUQNi50zlYy50Wjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086566; c=relaxed/simple;
	bh=DZx/v9GberCugKDSDCktJkpWp8vSMzL24+T1WMFOWGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioh5Pq/+rx3L7oJfEH2/HtFmLg5FQ3PrKR6vGabPot2EchcawOGHx3+iCjEKaCEb3dX/hoJh6a3gtRUo5SP5+5BvcmU80fyQma4kFneAwNM3/aUTotfa/JEscYMqAnGtaCsrkPxpM0xTWMBOOfwan5quA0usWRXuDmya9cJrCGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eprWcVQG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eprWcVQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973DD1F00893;
	Fri, 11 Sep 2026 00:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789086565;
	bh=RAUWuFyX9c6I1XRxDWI83fsHQfdfhc90za0LTNi+Q+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eprWcVQG75Oj7eVAEi29uovqNCHxZJKaTLQNpLhBzkkpxfBZuZ/k4EJmcV8PXfjEu
	 eJDAOfRJM+WzK/NItwiZhdg5Yoor2D848jIP8FbYw+IUA7Q9gl8VpMYwIUgUyQtIWv
	 8VK2zlqofupuh1Ipqxfgt8Vmw91dIgS36NfAibie2GCG44eMvuCygrkD5nBq/qDrDy
	 kjJflGcHaDqyMpOySAQBliVjPY9f/HByM0+8F015uTqrXZSZP5keLHvsjLcpxBbnoV
	 waHbmgC6x+EylN7q6XUvS3Pg1iQlubG9IoUixLOXy9OFG2/xFss6NnPZkTxN2Kb2rP
	 n9gG99vGUCNNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Zide Chen <zide.chen@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] perf/x86/intel: Remove anythread_deprecated bit from perf_capabilities
Date: Thu, 10 Sep 2026 20:29:22 -0400
Message-ID: <20260911002922.3428224-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090901-snowstorm-sandbar-8bac@gregkh>
References: <2026090901-snowstorm-sandbar-8bac@gregkh>
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
index 73d1cebddee70..14e2119f9d4b4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5022,12 +5022,6 @@ __init int intel_pmu_init(void)
 
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
@@ -5554,8 +5548,10 @@ __init int intel_pmu_init(void)
 		((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
 
 	/* AnyThread may be deprecated on arch perfmon v5 or later */
-	if (x86_pmu.intel_cap.anythread_deprecated)
+	if (version >= 5 && edx.split.anythread_deprecated) {
 		x86_pmu.format_attrs = intel_arch_formats_attr;
+		pr_cont("AnyThread deprecated, ");
+	}
 
 	if (x86_pmu.event_constraints) {
 		/*
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index bcc40b7850cb0..c63e7df31f8bc 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -587,7 +587,7 @@ union perf_capabilities {
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

