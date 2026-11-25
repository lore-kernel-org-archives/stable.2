Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601613;
	b=kGTJTmTPAxyQZJ6Xa7Nh3PZI/7alHdOpChotR1ku+1TqTHZ8NOcHUkDabNZJOfpGjoNc
	 SSxfuDIdGIWkUa0klmnlzHkUqgSnISEFKVF3Sec/d1onU8jbZiK50bIbBLXE8zhYM8Ieq
	 tzQnHOws1UU2LGX+oeGyOgcFrscNIqGdodlhYWQDneFSOZwP1HOJlaNnSOsTTC1C0vk4K
	 u/Mglf1EIJ27GIr72MrDNjO51+m3juAMl2hYH3L788efS7/84J2u1lTIXz5ukhylRpy0z
	 BGklQ5uVyS5WwSgmVMnq5K3lxpRSTC3/vFmTAXJRsTQSaerqw74bPMUZ0y0+RP3cmfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601613;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EEuMfBmB4BNA9KpW4BxkgF2WvHdjMh1K4Vg8JwO9O7s=;
	b=mndWZQIKOZkfh1dqWRqQCSbns/lOhrV5ixxl9+8KLHO0H18Yol0UBtMOuYZA6dIl5xpz
	 KRFwW8CMOtfQUFSOxgwEs2me8pFpnVNA97eTy9xloINFQBZmcSPjNFtQGUdFrB6IUvL4l
	 gbza4x8rkl7fLM4DELVpya4dFNTgt1AelqDtQncR0l/PYTvlzeQEZ0j1qHNcB6w3tuvxM
	 EkNRzFt5pfO1L8FhHAzM1JZIWyLWOyrIEiZQujykyKY1ikGdLH3Qxd8UMCGuqtfcYAFdR
	 85ZM5IY41LcPU+m7/DbtPvrbK/8Ew4wGWbiG+ZarEVi9YG+goC7V7qbmzDjV+ylLq8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=n9yWH1zD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554A0606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=n9yWH1zD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E211F000C6;
	Wed, 25 Nov 2026 10:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795601613;
	bh=EEuMfBmB4BNA9KpW4BxkgF2WvHdjMh1K4Vg8JwO9O7s=;
	h=Subject:To:Cc:From:Date;
	b=n9yWH1zDQw7AAjGbS8UGZGGGu0KuRCiJ4FV87I6rK72TIsObIKhi8rptV4NlaaFrY
	 CCRQi/tuBDRITMbgG5i88erA8q0w/N4IT09nZSGkv3gOLzodAO6lCOC4xZ30uw9rsU
	 dBFh/oP6J/YIo6DhzhrayMsTiGul2t5QHLnY0SNM=
Subject: FAILED: patch "[PATCH] cpufreq: Force passing target frequency to driver during" failed to apply to 5.10-stable tree
To: rafael.j.wysocki@intel.com,christian.loehle@arm.com,dsmythies@telus.net,stable@vger.kernel.org,viresh.kumar@linaro.org,zakbrightonknight@gmail.com,zhongqiu.han@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:10:10 +0100
Message-ID: <2026112510-gauntlet-tightness-db8f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 342d3a73c5dbc2f1cd0c5142e2d11bda4dc54cd7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112510-gauntlet-tightness-db8f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 342d3a73c5dbc2f1cd0c5142e2d11bda4dc54cd7 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Tue, 3 Nov 2026 20:47:48 +0100
Subject: [PATCH] cpufreq: Force passing target frequency to driver during
 resume

The policy->cur value preserved across a system suspend-resume cycle
may become stale in some cases and it may prevent the CPU performance
scaling logic from being updated due to the target_freq == policy->cur
check in __cpufreq_driver_target() [1].

To address this, adjust the existing mechanism to force the invocation
of the driver .target() callback in __cpufreq_driver_target() and make
cpufreq_resume_policy() use it.

This involves renaming update_limits in struct cpufreq_policy to
force_target and moving the driver CPUFREQ_NEED_UPDATE_LIMITS flag check
from __cpufreq_driver_target() to cpufreq_set_policy(), where it is used
as a condition for setting policy->force_target.

In cpufreq_resume_policy(), policy->force_target is set for drivers that
implement the .target() callback, but don't implement the .get() one,
which is the case when the driver callback needs to run if policy->cur
becomes stale while suspended.

Fixes: 2f0aea936360 ("cpufreq: suspend governors on system suspend/hibernate")
Link: https://lore.kernel.org/linux-pm/20261027143725.3763827-1-zakbrightonknight@gmail.com/ [1]
Reported-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
Reported-by: Doug Smythies <dsmythies@telus.net>
Cc: All applicable <stable@vger.kernel.org> # eee2a44e4e2b cpufreq: Improve suspend-resume synchronization
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/1995295.tdWV9SEqCh@rafael.j.wysocki
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7b93cbf313bc..c8ab23afa66d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2027,6 +2027,15 @@ static void cpufreq_resume_policy(struct cpufreq_policy *policy, bool start)
 	if (!start)
 		return;
 
+	/*
+	 * Force executing the driver .target() callback, if present, in the
+	 * next invocation of __cpufreq_driver_target() in case policy->cur has
+	 * become stale while suspended, but do it only for drivers without a
+	 * .get() callback for which cpufreq_verify_current_freq() is a NOP.
+	 */
+	if (cpufreq_driver->target && !cpufreq_driver->get)
+		policy->force_target = true;
+
 	if (cpufreq_start_governor(policy))
 		pr_err("%s: Failed to start governor for CPU%u's policy\n",
 		       __func__, policy->cpu);
@@ -2404,17 +2413,14 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 		policy->cpu, policy->cur, target_freq, old_target_freq, relation);
 
 	/*
-	 * This might look like a redundant call as we are checking it again
-	 * after finding index. But it is left intentionally for cases where
-	 * exactly same freq is called again and so we can save on few function
-	 * calls.
+	 * Unless invoking the target callback is forced, skip the update if the
+	 * frequency is not really changing.
 	 */
-	if (target_freq == policy->cur) {
-		if (!(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS) ||
-		    !policy->update_limits)
-			return 0;
-
-		policy->update_limits = false;
+	if (policy->force_target) {
+		/* Avoid forcing the driver callback unnecessarily next time. */
+		policy->force_target = false;
+	} else if (target_freq == policy->cur) {
+		return 0;
 	}
 
 	if (cpufreq_driver->target) {
@@ -2673,6 +2679,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 			      struct cpufreq_governor *new_gov,
 			      unsigned int new_pol)
 {
+	bool need_update_limits = cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS;
 	struct cpufreq_policy_data new_data;
 	struct cpufreq_governor *old_gov;
 	unsigned int freq;
@@ -2712,7 +2719,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 			      CPUFREQ_RELATION_H);
 	if (freq != policy->max) {
 		WRITE_ONCE(policy->max, freq);
-		policy->update_limits = true;
+		if (need_update_limits)
+			policy->force_target = true;
 	}
 
 	freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
@@ -2720,7 +2728,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	freq = min(freq, policy->max);
 	if (freq != policy->min) {
 		WRITE_ONCE(policy->min, freq);
-		policy->update_limits = true;
+		if (need_update_limits)
+			policy->force_target = true;
 	}
 
 	trace_cpu_frequency_limits(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 20a6863b640a..be1eaa43aeb0 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -146,8 +146,8 @@ struct cpufreq_policy {
 	/* Per policy boost supported flag. */
 	bool			boost_supported;
 
-	/* Pending policy->min/max update for the driver */
-	bool			update_limits;
+	/* Force passing target frequency to the driver. */
+	bool			force_target;
 
 	/* The policy has been suspended. */
 	bool			suspended;

