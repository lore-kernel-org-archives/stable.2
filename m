Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624401;
	b=hmlJoexqbk1NwegGbWpg0tSLqCcagR+n8zLxLAYUUnYLeZTMNN3UtUQ7I40PlDFXJgdm
	 3yXyLXphE2PDjRjpK2jbg9h0fO0wPNLFKrHxUp1Ybm2ar8P0ZLnrtjFJDxJwdUDjA2bih
	 ivhCgHeqwS6X4ZYwug+qOb4PqzKbtnfeHRIRbJaA/cxzwJW85QLhWwudjtdTCSO8pHsmF
	 z1M31+d4doi8k8XAXB/uLznIkq9LgTfpCqVr81jYrJWNhuTzQOwX646DSk8J29i+jlCUu
	 jVQs8pE+CfkltcPmFhTYCCDg3ZJOj9Qsr1MG1AX0dqXvSEzytg88ZHaqcKcJe4dgQmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624401;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=p6eKQBPRpTqQbqgec5G3PL/1LlPqqjayJAWrWhlvDZg=;
	b=w0s2tqrFdd4DnDo5F5bwlkpkfOuQpwgGcylEhZHQdwN1CCe/yUvFssb1EFWq9pFqJus7
	 OSv7tpDSd8xJo+iRSdfQEPzorMqyyJaI5qzXkZwpW5COPpQ0v7OzTpXKG/aAG39s4GD0g
	 mOpd/wy9Mq2U7UgQ2dw2t9kRlDFW98mrTsbUJGI8J86ePGl69yTnP4Sm1ospQtoBb5S7P
	 3SD2cKeKhhsOzRIvbd65qVvQ6d+awL3tN+VxLiDmZSBOm8+YAj5PWnvanw3vZu52+k1Lg
	 JVcQTmYwrNcqK/q3dkkCrlpHUIIR1/1vbeWKvVEgioBrXB95GpNF1o5dhMEAYF3MbBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPQ4h0h2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC72606A68F
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPQ4h0h2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC5B1F000D0;
	Wed, 25 Nov 2026 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624401;
	bh=p6eKQBPRpTqQbqgec5G3PL/1LlPqqjayJAWrWhlvDZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FPQ4h0h2g1oq7BlR6qcH7XgJUoTSTMC3j1RUspYN4F8CMe4nGGn4f5OvbRv2glJ1Q
	 D3ezL0OUx6orVPpiMR3U3Oe6vyNCOuOrxJvPZWU4EIKS4hPw3ycGKBnjAPiw/3697u
	 JOCfQSJSkZYWe3DdwC84U9UvW2fjSQbeyAQYgKh22hbBcSx92sc2PdOh9zkwQqdPsz
	 U7KyLuyqN8E4mZgYWnlG/ysPOj4LRXD2oOv1Rfuu4XV6N6/NowwCbFqO0urCq0DIsC
	 BgwDIkd+n/8fTYSX5pQIL9rOvpnsRioOKWJT2lGpxtAaVA8lmx9CI14MIY/AtQVIcU
	 DIjpM8kBUdOQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zak Brighton Knight <zakbrightonknight@gmail.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Doug Smythies <dsmythies@telus.net>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] cpufreq: Improve suspend-resume synchronization
Date: Wed, 25 Nov 2026 11:33:18 -0500
Message-ID: <20261125163259.821886-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112513-handwrite-santa-669b@gregkh>
References: <2026112513-handwrite-santa-669b@gregkh>
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
[ sashal: Replaced the guard()/scoped_guard() helpers with explicit down_write/up_write and cpus_read_lock/unlock using goto unlock, and kept the older pr_err messages that print the policy pointer. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 98 +++++++++++++++++++++++++++++----------
 include/linux/cpufreq.h   |  3 ++
 2 files changed, 76 insertions(+), 25 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 69b7cd1146bbb..b541c028cae51 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -33,6 +33,9 @@
 static LIST_HEAD(cpufreq_policy_list);
 
 /* Macros to iterate over CPU policies */
+#define for_each_policy(__policy)	\
+	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
+
 #define for_each_suitable_policy(__policy, __active)			 \
 	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list) \
 		if ((__active) == !policy_is_inactive(__policy))
@@ -1904,6 +1907,16 @@ int cpufreq_generic_suspend(struct cpufreq_policy *policy)
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
  * cpufreq_suspend() - Suspend CPUFreq governors
  *
@@ -1926,11 +1939,8 @@ void cpufreq_suspend(void)
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
@@ -1942,6 +1952,35 @@ void cpufreq_suspend(void)
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
  * cpufreq_resume() - Resume CPUFreq governors
  *
@@ -1951,35 +1990,38 @@ void cpufreq_suspend(void)
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
@@ -2314,12 +2356,17 @@ __weak struct cpufreq_governor *cpufreq_fallback_governor(void)
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
@@ -2362,7 +2409,7 @@ static int cpufreq_init_governor(struct cpufreq_policy *policy)
 
 static void cpufreq_exit_governor(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (cpufreq_is_suspended(policy) || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2377,7 +2424,7 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	if (cpufreq_suspended)
+	if (cpufreq_is_suspended(policy))
 		return 0;
 
 	if (!policy->governor)
@@ -2402,7 +2449,7 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
 
 void cpufreq_stop_governor(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (cpufreq_is_suspended(policy) || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2413,7 +2460,7 @@ void cpufreq_stop_governor(struct cpufreq_policy *policy)
 
 static void cpufreq_governor_limits(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (cpufreq_is_suspended(policy) || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2626,7 +2673,8 @@ void cpufreq_update_policy(unsigned int cpu)
 	 * -> ask driver for current freq and notify governors about a change
 	 */
 	if (cpufreq_driver->get && has_target() &&
-	    (cpufreq_suspended || WARN_ON(!cpufreq_verify_current_freq(policy, false))))
+	    (cpufreq_is_suspended(policy) ||
+	     WARN_ON(!cpufreq_verify_current_freq(policy, false))))
 		goto unlock;
 
 	refresh_frequency_limits(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 6e7f611c5e197..4a9ced85476c6 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -134,6 +134,9 @@ struct cpufreq_policy {
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

