Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133114921B9
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041111; cv=none; b=ulX68uD2xuL9fUBkGGo0RxD/dUvhrssVKfPMo3zDRq21SArTzjxp6GkihBtyb9Rk/f5ZKP29buIaLVEwBUMKBrSTdtRWY955T89xv8tvYd/64ebXGoEARN+RvkqJz/Y7dXbvVqg4bC73mZ7PaANSAhuhBmJQVC7RQvfBBn8P+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041111; c=relaxed/simple;
	bh=rRUQbV1u7ROsI4oFxi9q9g78GbIJRjhFARsZvYFodWI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aGjSuLFNaarsBJ4ohq6p+BzzbEXB/OxhstdLfUrn7vtowuCe9fudgWPFLzXkK+8Vrrvbv1qeicuRSjARFc65SezzoSWgT5aL1qGdFDn1ehO9V3dS7igfDE6S+XewB28/HKZzHkindrBeqmx2kreD2gcSZYbKvks7Wl4yyZCVZWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H6D6s+h2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H6D6s+h2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932241F000E9;
	Tue, 14 Jul 2026 14:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784041107;
	bh=9sQl6kxnJN6x3oRTAjzQ7v29arl6WN7CP5R6WbziKqg=;
	h=Subject:To:Cc:From:Date;
	b=H6D6s+h2SSE4rbwZI50gDuUdNyFiWTe2D97AzgudRnGeFU6hv1VQduYtleL7uMeXD
	 8wZfD0Hp67gR1FPNXz5k+QTT8+cRWMVZ1KFEsOJQc3VPpuhe8GIQ2iXO94SMFfvr7E
	 FdYKjec4cMjwNFArxhAcjA4BB1INL26o3R93H71I=
Subject: FAILED: patch "[PATCH] cpufreq: intel_pstate: Sync policy->cur during CPU offline" failed to apply to 5.10-stable tree
To: wangfushuai@baidu.com,rafael.j.wysocki@intel.com,srinivas.pandruvada@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:56:52 +0200
Message-ID: <2026071452-shimmer-reformer-0bc4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x bcbdaa1086c25a8a5d48e04e1b82fdfb0682b681
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071452-shimmer-reformer-0bc4@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bcbdaa1086c25a8a5d48e04e1b82fdfb0682b681 Mon Sep 17 00:00:00 2001
From: Fushuai Wang <wangfushuai@baidu.com>
Date: Wed, 20 May 2026 11:21:19 +0800
Subject: [PATCH] cpufreq: intel_pstate: Sync policy->cur during CPU offline

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

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1f093e346430..0fbbdbd5765c 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2984,10 +2984,12 @@ static int intel_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 	 * from getting to lower performance levels, so force the minimum
 	 * performance on CPU offline to prevent that from happening.
 	 */
-	if (hwp_active)
+	if (hwp_active) {
 		intel_pstate_hwp_offline(cpu);
-	else
+	} else {
 		intel_pstate_set_min_pstate(cpu);
+		policy->cur = cpu->pstate.min_freq;
+	}
 
 	intel_pstate_exit_perf_limits(policy);
 

