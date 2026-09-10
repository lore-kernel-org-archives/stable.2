Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D563859E0
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069368; cv=none; b=fbXC7wpELnCwn7sWVLUXRCq3ZIN5f0jn3Nlgq/3hu4+oVtQ3X9r1UcTfMcxOqBzV4usty/aBDjKJ7M7Mas9ZTOCDbXxI5ENFoml3d5ndZLFsVp6IF8wz8hNsFBC6B6w/iGQF+tGiTsfgjJDIKvp3nnCZJUn1RqGHYEMk7nP3axE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069368; c=relaxed/simple;
	bh=h8CsMN6HVGp+1Fueambe3qT/crxV1jlSR7hA/ErmNe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbTz8xTEoYUBxORnHJ2JcOazFpFazu7aWeJVP5whw0spE65jiu/nMdglkdVSV5yPTkbKON8VekzecAgYOBgVFy5/PeU5XU+zdY/R118M8O5hqtbrPdxfjUM13wNP8fOhWK8m40GiUliGJvjeu2HEx5vpkGxyg9Rwm69fyzzu/mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDyXb2o3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDyXb2o3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FA91F000FF;
	Thu, 10 Sep 2026 19:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789069367;
	bh=UFgw7zPLlGcSR5QYiRdwoHoNXETlSjjvP/YVhEkOvbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NDyXb2o38u7vYIXSCtkjn1UFrSzu4H4KyWX9oYG4ap+3BRkLcXDhAc25V8VHpk3zi
	 pcRyeMo2JnqxkDwIO0DjC0/zlm7waVS4ldnlU5vWVVUCkj/o1sTEOsrBqdz+MfXcAj
	 WGy8+0KU29rifEty2JIFzVLlh5EYjNFzfoqUaYoiZK5j8WDLhyQNoqq+KF5A+shzA+
	 0wf5LZd2Fj4ECFI/MaXLWtwgecjpxkySdD9e7hOZcOG1W5VuFYBboJgtGjc5b2MpmO
	 SskHpuEu2WFPJ/BOs9CRU52seYqlqhU5cYvP932rvGsebzP/bKXjOjE4730/1jbtN3
	 UIlIoFGHCo8bA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Zide Chen <zide.chen@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] perf/x86/intel: Remove anythread_deprecated bit from perf_capabilities
Date: Thu, 10 Sep 2026 15:42:44 -0400
Message-ID: <20260910194244.1586611-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090959-popper-rotunda-e863@gregkh>
References: <2026090959-popper-rotunda-e863@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
[ Adjusted patch context to match Linux 6.6’s older PMU code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/core.c | 10 +++-------
 arch/x86/events/perf_event.h |  2 +-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8d1ec1d888da7..2c3d1f645fc24 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6155,12 +6155,6 @@ __init int intel_pmu_init(void)
 
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
@@ -6951,8 +6945,10 @@ __init int intel_pmu_init(void)
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
index 4ca15be45cb80..9837e8d0deb39 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -609,7 +609,7 @@ union perf_capabilities {
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

