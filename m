Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624222;
	b=sNC7jXzUT13mrBbjhWDZbCGqPS3HyQDzWEx3xzCPOyteHOQfy8ZayljMMqn7JHqzEZys
	 R6qfN+yZzODMIiscOUgbpa6iFkdPgBVK1ZOGnJ1ox7oH2yWB8SJXZIYpJr/YhaCbrXenw
	 4o3aczfQfMSaqDoeb2ZAfRr2sfOHEIETMp4lDaLBHCeYGX//M8kOqfhQ1POUfJV00Eone
	 szm08RtTHEqgx2i5XnAgSSe6ulq4joufxKpwe4ff1ryauSFrfYqq6N2yXTM5tjUs3IKFl
	 T3Pc1dKZA9CD0TLk+20Q+qmfNUNjOr9Hd1RSaDI9/o3m5LeZGtxdzpnAXVC1+t7nOTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624222;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=plsPeRbdt3XJb2LcioIV1gOQf2fXrQ/d7TW6wySLtmc=;
	b=M8atgi7iYjqGDVGaz9S8d22OBE/kjxsCcXPUwShdoudhUUdaKa+pMHzKfnCBgA1l2Tlu
	 I1XM6+jNzods1uLCb+o6jQYhAYjflR5/iAWVCllaPNuZcpEG0aLBFA1qwaudFIuvvkUPu
	 HfH3HzdvF1VBYM4Sr75gOVLSXg6bUWfxwkMA6Z4rv9sgNSVVTd3mWsc00PKI6YBKsxnYQ
	 uL9ye7byDj/wXYplZa1oKSLID9nHgNc7TNsUt7yY4xrgBltOkjTskAduPXPd6A0f/7w5J
	 15zWqWn6qs12jcRXvQL94i6vJr0BhUuAGDNdR+vYFGOd3bMmQQITryHJN5kp0RCkrXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQTnNjrG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C776B606A339
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQTnNjrG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0FE1F000D2;
	Wed, 25 Nov 2026 16:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624222;
	bh=plsPeRbdt3XJb2LcioIV1gOQf2fXrQ/d7TW6wySLtmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XQTnNjrGFTpPqFx4fsPEVFunwpq83dKHGc+6o76yzl16e9yQYAAvGs+tBsuugm4yn
	 pxvMqiP1WLGfVBxn8sYqs/IsluYiZBzWH1KrnKvlIy/FpzHVftldy97pm00zCwUJpr
	 57PlwjDBG3OVtfoAXCNSAH6bBYsJJojg69fyJizfF55W9IUrSZFUldShrUlPYJNsaG
	 pw7cGIi4uzRQROTmf3tUHnoaD69xLnCJdh2HZfpadBoh5sPLDF59KvqRRMvRAb91Wh
	 DiHJj2r0/5f/b9XPexZ0RNKupvzNu16hbbOaIOZYq0zcicAIAlvBGB2c+6xT1+mxld
	 PnIxL0SJUGLLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zak Brighton Knight <zakbrightonknight@gmail.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Doug Smythies <dsmythies@telus.net>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] cpufreq: Improve suspend-resume synchronization
Date: Wed, 25 Nov 2026 11:30:19 -0500
Message-ID: <20261125163002.810185-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112513-parasail-absolve-96dd@gregkh>
References: <2026112513-parasail-absolve-96dd@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit eee2a44e4e2b41c0699919a550d41cc38daa4f42 ]

The suspend-resume synchronization in the cpufreq core is not perfect
because the global cpufreq_suspended variable is set at the end of
cpufreq_suspend() after stopping governors for all of the active
policies, so the governor .limits() callback may run via
cpufreq_governor_limits() after stopping the governor and before
setting cpufreq_suspended which is questionable.  Likewise, the
governor .limits() callback may run between clearing cpufreq_suspended
in cpufreq_resume() and starting the governor.

Address this by adding a per-policy "suspended" flag that is always
read under the policy rwsem and is updated under it when the governor
is stopped in cpufreq_suspend() and when the governor is restarted in
cpufreq_resume().

Also make cpufreq_resume() use the cpus_read_lock guard to reflect
what is done in cpufreq_suspend() and call cpufreq_exit_governor() for
policies that were suspended during a system suspend transition and
are inactive during the subsequent system resume (to avoid leaking an
inactive policy with a stopped governor that has not exited yet).

Fixes: 8e30444e1530 ("cpufreq: fix cpufreq suspend/resume for intel_pstate")
Fixes: b1b12babe3b7 ("cpufreq: update 'cpufreq_suspended' after stopping governors")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/4796894.LvFx2qVVIh@rafael.j.wysocki
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ sashal: Replaced guard()/scoped_guard() cpufreq_policy_write and cpus_read_lock guards with explicit down_write/up_write and cpus_read_lock/unlock using goto unlock, and adjusted pr_err messages to match the older code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 98 +++++++++++++++++++++++++++++----------
 include/linux/cpufreq.h   |  3 ++
 2 files changed, 76 insertions(+), 25 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fcddf5c41814b..e5807fb4eb3eb 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -34,6 +34,9 @@
 static LIST_HEAD(cpufreq_policy_list);
 
 /* Macros to iterate over CPU policies */
+#define for_each_policy(__policy)	\
+	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
+
 #define for_each_suitable_policy(__policy, __active)			 \
 	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list) \
 		if ((__active) == !policy_is_inactive(__policy))
@@ -1923,6 +1926,16 @@ int cpufreq_generic_suspend(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL(cpufreq_generic_suspend);
 
+static void cpufreq_suspend_policy(struct cpufreq_policy *policy)
+{
+	down_write(&policy->rwsem);
+
+	cpufreq_stop_governor(policy);
+	policy->suspended = true;
+
+	up_write(&policy->rwsem);
+}
+
 /**
  * cpufreq_suspend() - Suspend CPUFreq governors.
  *
@@ -1945,11 +1958,8 @@ void cpufreq_suspend(void)
 	pr_debug("%s: Suspending Governors\n", __func__);
 
 	for_each_active_policy(policy) {
-		if (has_target()) {
-			down_write(&policy->rwsem);
-			cpufreq_stop_governor(policy);
-			up_write(&policy->rwsem);
-		}
+		if (has_target())
+			cpufreq_suspend_policy(policy);
 
 		if (cpufreq_driver->suspend && cpufreq_driver->suspend(policy))
 			pr_err("%s: Failed to suspend driver: %s\n", __func__,
@@ -1961,6 +1971,35 @@ void cpufreq_suspend(void)
 	cpus_read_unlock();
 }
 
+static void cpufreq_resume_policy(struct cpufreq_policy *policy, bool start)
+{
+	down_write(&policy->rwsem);
+
+	if (!policy->suspended)
+		goto unlock;
+
+	policy->suspended = false;
+
+	if (policy_is_inactive(policy)) {
+		/*
+		 * The policy was active when it was suspended, so its governor
+		 * is still there.  Let the governor go.
+		 */
+		cpufreq_exit_governor(policy);
+		goto unlock;
+	}
+
+	if (!start)
+		goto unlock;
+
+	if (cpufreq_start_governor(policy))
+		pr_err("%s: Failed to start governor for policy: %p\n",
+		       __func__, policy);
+
+unlock:
+	up_write(&policy->rwsem);
+}
+
 /**
  * cpufreq_resume() - Resume CPUFreq governors.
  *
@@ -1970,35 +2009,38 @@ void cpufreq_suspend(void)
 void cpufreq_resume(void)
 {
 	struct cpufreq_policy *policy;
-	int ret;
 
 	if (!cpufreq_driver)
 		return;
 
+	cpus_read_lock();
+
 	if (unlikely(!cpufreq_suspended))
-		return;
+		goto unlock;
 
 	cpufreq_suspended = false;
 
 	if (!has_target() && !cpufreq_driver->resume)
-		return;
+		goto unlock;
 
 	pr_debug("%s: Resuming Governors\n", __func__);
 
-	for_each_active_policy(policy) {
-		if (cpufreq_driver->resume && cpufreq_driver->resume(policy)) {
-			pr_err("%s: Failed to resume driver: %p\n", __func__,
-				policy);
-		} else if (has_target()) {
-			down_write(&policy->rwsem);
-			ret = cpufreq_start_governor(policy);
-			up_write(&policy->rwsem);
+	for_each_policy(policy) {
+		int ret = 0;
 
+		if (cpufreq_driver->resume && !policy_is_inactive(policy)) {
+			ret = cpufreq_driver->resume(policy);
 			if (ret)
-				pr_err("%s: Failed to start governor for policy: %p\n",
-				       __func__, policy);
+				pr_err("%s: Failed to resume driver: %p\n", __func__,
+				       policy);
 		}
+
+		if (has_target())
+			cpufreq_resume_policy(policy, ret == 0);
 	}
+
+unlock:
+	cpus_read_unlock();
 }
 
 /**
@@ -2368,12 +2410,17 @@ __weak struct cpufreq_governor *cpufreq_fallback_governor(void)
 	return NULL;
 }
 
+static bool cpufreq_is_suspended(struct cpufreq_policy *policy)
+{
+	return cpufreq_suspended || policy->suspended;
+}
+
 static int cpufreq_init_governor(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	/* Don't start any governor operations if we are entering suspend */
-	if (cpufreq_suspended)
+	/* Don't start any governor operations for suspended policies. */
+	if (cpufreq_is_suspended(policy))
 		return 0;
 	/*
 	 * Governor might not be initiated here if ACPI _PPC changed
@@ -2416,7 +2463,7 @@ static int cpufreq_init_governor(struct cpufreq_policy *policy)
 
 static void cpufreq_exit_governor(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (cpufreq_is_suspended(policy) || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2431,7 +2478,7 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	if (cpufreq_suspended)
+	if (cpufreq_is_suspended(policy))
 		return 0;
 
 	if (!policy->governor)
@@ -2456,7 +2503,7 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
 
 void cpufreq_stop_governor(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (cpufreq_is_suspended(policy) || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2467,7 +2514,7 @@ void cpufreq_stop_governor(struct cpufreq_policy *policy)
 
 static void cpufreq_governor_limits(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (cpufreq_is_suspended(policy) || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2687,7 +2734,8 @@ void cpufreq_update_policy(unsigned int cpu)
 	 * -> ask driver for current freq and notify governors about a change
 	 */
 	if (cpufreq_driver->get && has_target() &&
-	    (cpufreq_suspended || WARN_ON(!cpufreq_verify_current_freq(policy, false))))
+	    (cpufreq_is_suspended(policy) ||
+	     WARN_ON(!cpufreq_verify_current_freq(policy, false))))
 		goto unlock;
 
 	refresh_frequency_limits(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 0f978ddb65d15..bf215983f126e 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -140,6 +140,9 @@ struct cpufreq_policy {
 	/* Per policy boost enabled flag. */
 	bool			boost_enabled;
 
+	/* The policy has been suspended. */
+	bool			suspended;
+
 	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
 	unsigned int cached_target_freq;
 	unsigned int cached_resolved_idx;
-- 
2.53.0

