Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5869447DD42;
	Wed, 22 Jul 2026 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713131; cv=none; b=AXm5hANNEqaPwRtX3b7+3HnQhg0e63ipW6OYweNTvyBaNavin0/dGRdj1vc5SDQUHo0/otzAKqQHhTiiTtAWR/OPSdy0WeF4UiI7OBAX6JA9fst7NaIBkP9R6XR9rn07QyZDZ+7SXTGtudN+vxbTIROIxp0aPlLRP9y8BKHFGa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713131; c=relaxed/simple;
	bh=9+5puAjZdwGp4Kyus6+xo36McxelBeom4xWvgQ/KYcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZAAY5VlKbKR7LS+IqsgM8TpDuOZSkF/i97SH3MHQni0Q2x4l1Css9V3iUSGGffE7deU+esnz6zmXoBbf8FEb11O+ZkaDHhfW8JyYEottrILLUqr1fIjoJhN1Mpqo4PZ9NQc4yISTgW8/fJ/h9aYuwUlHGtX7/wXRQL5yUHF44sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oHIoBrlk; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oHIoBrlk"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C3F51691;
	Wed, 22 Jul 2026 02:38:44 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A32913F86F;
	Wed, 22 Jul 2026 02:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784713128; bh=9+5puAjZdwGp4Kyus6+xo36McxelBeom4xWvgQ/KYcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oHIoBrlkFLSP5I3dg+0Kwv6dkjRqUiWknXqNSz3LrNNvXekPLucVwRFkd+Nk4ZDFD
	 f0gDENWATcCrabMHrC6UXy2Ypo27yA3KPvIuDjG9WT2fcLOM8RCMxMNT7qo/DGRwtf
	 Wf3kHzt5kl3+Mi4/rCHLcBoz5rZPSdR5M84vuVb8=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] cpufreq: cppc: Sanitize lockless policy limit snapshots
Date: Wed, 22 Jul 2026 10:38:25 +0100
Message-Id: <20260722093825.1030594-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722093825.1030594-1-christian.loehle@arm.com>
References: <20260722093825.1030594-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cppc_cpufreq_update_perf_limits() reads policy->min and policy->max
without holding the policy lock. The cpufreq core updates those fields
with separate stores, so a reader can observe the old minimum together
with the new maximum and construct MIN_PERF greater than MAX_PERF.

Read both fields once and, if the lockless snapshot is inconsistent,
reduce the minimum to the observed maximum. This matches the conservative
correction used by cpufreq_driver_resolve_freq() and ensures that CPPC
never receives an inverted limit pair.

Fixes: ea3db45ae476 ("cpufreq: cppc: Update MIN_PERF/MAX_PERF in target callbacks")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index b943bf78d3f5..6fe0e972952a 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -290,19 +290,32 @@ static inline void cppc_freq_invariance_exit(void)
 }
 #endif /* CONFIG_ACPI_CPPC_CPUFREQ_FIE */
 
-static void cppc_cpufreq_update_perf_limits(struct cppc_cpudata *cpu_data,
-					    struct cpufreq_policy *policy)
+static void cppc_cpufreq_get_perf_limits(struct cppc_cpudata *cpu_data,
+					 struct cpufreq_policy *policy,
+					 u32 *min_perf, u32 *max_perf)
 {
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
-	u32 min_perf, max_perf;
+	unsigned int min_freq, max_freq;
+	u32 min, max;
+
+	min_freq = READ_ONCE(policy->min);
+	max_freq = READ_ONCE(policy->max);
+	if (unlikely(min_freq > max_freq))
+		min_freq = max_freq;
+
+	min = cppc_khz_to_perf(caps, min_freq);
+	max = cppc_khz_to_perf(caps, max_freq);
 
-	min_perf = cppc_khz_to_perf(caps, policy->min);
-	max_perf = cppc_khz_to_perf(caps, policy->max);
+	*min_perf = clamp_t(u32, min, caps->lowest_perf, caps->highest_perf);
+	*max_perf = clamp_t(u32, max, caps->lowest_perf, caps->highest_perf);
+}
 
-	cpu_data->perf_ctrls.min_perf =
-		clamp_t(u32, min_perf, caps->lowest_perf, caps->highest_perf);
-	cpu_data->perf_ctrls.max_perf =
-		clamp_t(u32, max_perf, caps->lowest_perf, caps->highest_perf);
+static void cppc_cpufreq_update_perf_limits(struct cppc_cpudata *cpu_data,
+					    struct cpufreq_policy *policy)
+{
+	cppc_cpufreq_get_perf_limits(cpu_data, policy,
+				     &cpu_data->perf_ctrls.min_perf,
+				     &cpu_data->perf_ctrls.max_perf);
 }
 
 static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
-- 
2.34.1

