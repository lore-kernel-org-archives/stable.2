Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932AC344DB7
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784316231; cv=none; b=dZ0lQwYKzyvO/P2h27rNSs2UsJxYKD54FqFzdDsuPp2Q8IDGjWR+CWBWi3eL0ey9zJpBb+Smukkv7Lk4nKW5J8XyBPcl3jIECH3ZF5Kig2gmm4AlWPQca6nz4h8+mJuUkoOT7d7iObYSLNvL5UvMj1S5BAx40DXz7ardXfItpRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784316231; c=relaxed/simple;
	bh=Rkus7gJPxCDTG3JKcXqPf7at7G8dXuHvvlL0T5XvC98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2WIXebHyfYwlpa+5Wa+GIlGJn7Hx35mI0gJhXteSe3aaxA401a8yP+TXf0aG+0x30CCZ1szORzwajYO951sU5rnBeY+RldwdCRPenCmON1QWDsNlYKzvO6bZkVzDfLm5BmNTp2+rXumA7om/f368e+z9B8btm4UrK90U6EUwts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTQL74Nr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTQL74Nr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B741C1F000E9;
	Fri, 17 Jul 2026 19:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784316230;
	bh=lZSvbRtINwJ5M5FQ4uKgY+WEb5VgqOKOsLYN34Q7qgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gTQL74NrZK6INrEdn0W3Jy1AOysjXZqKAn30CCDub0x92fdEHxmMPCMJe2P0bpuYW
	 mZnP34Gr6Q3W0xekvVp6tuVWFOpB8+RfVzAn95AIKZtImQm/ay07p/9fJyT7dt43Vk
	 8xjS4Iz3DSNbBXo9TVyy70sFh+18IjRp0fnKDtPmONeO7LVjHYUmN9660vmDv5aC3b
	 XpNM6RMa5pREOUdQoX1haywKim571vSxk/CVjueA0sZ4rtSNyegORYFKdzCw7MWWzD
	 yN3O6Qw2jcuBjAztJEjAqZ+6Nf3djDY+nNYnSlHVENilcYQeUJ1CiCMtuf4eUvPZ21
	 Q/6jFMGpKyHJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fushuai Wang <wangfushuai@baidu.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] cpufreq: intel_pstate: Sync policy->cur during CPU offline
Date: Fri, 17 Jul 2026 15:23:48 -0400
Message-ID: <20260717192348.2131400-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071452-shimmer-reformer-0bc4@gregkh>
References: <2026071452-shimmer-reformer-0bc4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fushuai Wang <wangfushuai@baidu.com>

[ Upstream commit bcbdaa1086c25a8a5d48e04e1b82fdfb0682b681 ]

When a CPU goes offline with HWP disabled, intel_pstate_set_min_pstate()
sets the MSR_IA32_PERF_CTL to minimum frequency to prevent SMT siblings
from being restricted. However, the policy->cur value was not updated,
leaving it at the previous value.

When the CPU comes back online, governor->limits() checks if target_freq
equals policy->cur and skips the frequency adjustment if they match. Since
policy->cur still holds the previous value, the governor does not call
cpufreq_driver->target to update MSR_IA32_PERF_CTL.

Fix this by synchronizing policy->cur with the hardware state when setting
minimum pstate during CPU offline.

Fixes: bb18008f8086 ("intel_pstate: Set core to min P state during core offline")
Cc: stable@vger.kernel.org # 3.15+
Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
[ rjw: Subject refinement ]
Link: https://patch.msgid.link/20260520032119.30615-1-fushuai.wang@linux.dev
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ replaced `cpu->pstate.min_freq` with `cpu->pstate.min_pstate * cpu->pstate.scaling` since 5.10 lacks the min_freq field ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/intel_pstate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index e0a7d580d48729..8dc11d5fed17b6 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2355,10 +2355,12 @@ static int intel_pstate_cpu_offline(struct cpufreq_policy *policy)
 	 * from getting to lower performance levels, so force the minimum
 	 * performance on CPU offline to prevent that from happening.
 	 */
-	if (hwp_active)
+	if (hwp_active) {
 		intel_pstate_hwp_offline(cpu);
-	else
+	} else {
 		intel_pstate_set_min_pstate(cpu);
+		policy->cur = cpu->pstate.min_pstate * cpu->pstate.scaling;
+	}
 
 	intel_pstate_exit_perf_limits(policy);
 
-- 
2.53.0

