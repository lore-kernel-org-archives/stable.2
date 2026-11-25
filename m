Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623579;
	b=1WtX+n4UvLvVPaElqjAcVuLBWOrWxwsbcbt5CxXYpGJUg2hOo+IVhgmMboX9HYV/5qzq
	 OHx9C3juijCefpainayU7LAPOHp4S8tW0qc68R9n8sfFDnIQrQ8nhSpHlD6mbsim2VQGc
	 1xW9yKv8Zqdq8AEYEznoL9K2Gz986YOJKKZ1KGW06cKIC8vVezQy7t0udolUNRj1+W2HR
	 L2qKfPFuhw90OLtHL8O++NrYuuRw9ClOemTgxx6e0x6BQSkVoZkKwyrqV9YEfH5aFsiV2
	 HodMj7zXImJXZNzZuqe+gzzXiDPSUwOjpSQNyzkPc3/D6qv0Qu6GaqemIdZ3UKZwp3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623579;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JsCuso79c79ch6nsb3nVcREEnkpftlhiDvnpAlluKF8=;
	b=3VMJmC83r6XXYrj2sHCGbzCpFOfcoFudf3cIGCatQW6vKxGOsrniwq8cPlT/UZugl2xl
	 f3eQ1Ur8+z1cqV873LrS6hEpTD/CDJ4sBKbYuxgswOWyxEMelIY7SCLeqUu17gckiIsMB
	 ZYftXosyb/FBKpKpztG4cRM5kh4Z+7g7RzprVJIBSKHLIh9ZBHZIWZyQjVDv8jGJkKmCO
	 DONljmC+4tYVoSwcnP15YZw/LsQPNuyTvxbq0i3vsDjjQS8+UA0hnZtyB/jZu443xiDJ7
	 ODP6wvLe8doTOGIlDzWGFJQ/ed7+YFTCIrwXTcxeEKKtJTeh8uVnR6cTUIY1PQ/3uHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdBcZwf0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4233C606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdBcZwf0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B721B1F000CF;
	Wed, 25 Nov 2026 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795623578;
	bh=JsCuso79c79ch6nsb3nVcREEnkpftlhiDvnpAlluKF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cdBcZwf08wI8qrW4gS3uqds55UhjuRPAc518sq85l/dw+zZFBXhGdefGClicxwnxN
	 KG6Ycn4G0zslMrNLZz2+ooT1JZar3JS6ARYmxpJxVfmJuuomDD2kL9TS0gOGuLU1Xb
	 aVk2gVsKPWRPtUZi/JK2lmPuZ0M0C4AFtJxUrsqq1O5yRuMYybUIDkEXADPjbx25/H
	 byUvgMNiPjCqlC4aja25fMsDQmnlqCcBP9S9/ff3HBQ/6veFrZbS6kdYW22VSGEAHP
	 KbdR3an/eeSEVGOBMZJBBFn6P5pa0wqs5O0hjPjfZZs5f6sIXxpX8urMUTnQl7p5v6
	 ojVVTDM4OKvKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zak Brighton Knight <zakbrightonknight@gmail.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Doug Smythies <dsmythies@telus.net>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] cpufreq: Improve suspend-resume synchronization
Date: Wed, 25 Nov 2026 11:19:36 -0500
Message-ID: <20261125161902.759382-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112512-smith-jot-037d@gregkh>
References: <2026112512-smith-jot-037d@gregkh>
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
[ sashal: Replaced the upstream guard()/scoped_guard() cpufreq_policy_write helpers with explicit down_write()/up_write() on policy->rwsem, using goto unlock in place of early returns, and adjusted context in cpufreq_update_policy() and struct cpufreq_policy. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 89 +++++++++++++++++++++++++++++----------
 include/linux/cpufreq.h   |  3 ++
 2 files changed, 69 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f56958e539b69..8fc5f1fb62bdd 100644
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
@@ -1956,6 +1959,14 @@ int cpufreq_generic_suspend(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL(cpufreq_generic_suspend);
 
+static void cpufreq_suspend_policy(struct cpufreq_policy *policy)
+{
+	down_write(&policy->rwsem);
+	cpufreq_stop_governor(policy);
+	policy->suspended = true;
+	up_write(&policy->rwsem);
+}
+
 /**
  * cpufreq_suspend() - Suspend CPUFreq governors.
  *
@@ -1978,11 +1989,8 @@ void cpufreq_suspend(void)
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
@@ -1994,6 +2002,35 @@ void cpufreq_suspend(void)
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
+		pr_err("%s: Failed to start governor for CPU%u's policy\n",
+		       __func__, policy->cpu);
+
+unlock:
+	up_write(&policy->rwsem);
+}
+
 /**
  * cpufreq_resume() - Resume CPUFreq governors.
  *
@@ -2003,11 +2040,12 @@ void cpufreq_suspend(void)
 void cpufreq_resume(void)
 {
 	struct cpufreq_policy *policy;
-	int ret;
 
 	if (!cpufreq_driver)
 		return;
 
+	guard(cpus_read_lock)();
+
 	if (unlikely(!cpufreq_suspended))
 		return;
 
@@ -2018,19 +2056,18 @@ void cpufreq_resume(void)
 
 	pr_debug("%s: Resuming Governors\n", __func__);
 
-	for_each_active_policy(policy) {
-		if (cpufreq_driver->resume && cpufreq_driver->resume(policy)) {
-			pr_err("%s: Failed to resume driver: %s\n", __func__,
-				cpufreq_driver->name);
-		} else if (has_target()) {
-			down_write(&policy->rwsem);
-			ret = cpufreq_start_governor(policy);
-			up_write(&policy->rwsem);
+	for_each_policy(policy) {
+		int ret = 0;
 
+		if (cpufreq_driver->resume && !policy_is_inactive(policy)) {
+			ret = cpufreq_driver->resume(policy);
 			if (ret)
-				pr_err("%s: Failed to start governor for CPU%u's policy\n",
-				       __func__, policy->cpu);
+				pr_err("%s: Failed to resume driver: %s\n", __func__,
+				       cpufreq_driver->name);
 		}
+
+		if (has_target())
+			cpufreq_resume_policy(policy, ret == 0);
 	}
 }
 
@@ -2410,12 +2447,17 @@ __weak struct cpufreq_governor *cpufreq_fallback_governor(void)
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
@@ -2458,7 +2500,7 @@ static int cpufreq_init_governor(struct cpufreq_policy *policy)
 
 static void cpufreq_exit_governor(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (cpufreq_is_suspended(policy) || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2473,7 +2515,7 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	if (cpufreq_suspended)
+	if (cpufreq_is_suspended(policy))
 		return 0;
 
 	if (!policy->governor)
@@ -2498,7 +2540,7 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
 
 void cpufreq_stop_governor(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (cpufreq_is_suspended(policy) || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2509,7 +2551,7 @@ void cpufreq_stop_governor(struct cpufreq_policy *policy)
 
 static void cpufreq_governor_limits(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (cpufreq_is_suspended(policy) || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2736,7 +2778,8 @@ void cpufreq_update_policy(unsigned int cpu)
 	 * -> ask driver for current freq and notify governors about a change
 	 */
 	if (cpufreq_driver->get && has_target() &&
-	    (cpufreq_suspended || WARN_ON(!cpufreq_verify_current_freq(policy, false))))
+	    (cpufreq_is_suspended(policy) ||
+	     WARN_ON(!cpufreq_verify_current_freq(policy, false))))
 		goto unlock;
 
 	refresh_frequency_limits(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index a77efb227bc27..0bcd173db3355 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -147,6 +147,9 @@ struct cpufreq_policy {
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

