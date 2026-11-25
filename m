Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624032;
	b=SiI7Uba+vCfsSJCev0qJWD+E1JyU+K0Q7PwiPkz1xcrl03MK21+JtC/d2L7bKDXwidQ4
	 EX74R6U0XhqUWnrEkrwL+YcvLNsxRV6Urxp287P990UC260HzGK701LD6VGI4LLI1Q+w8
	 MP41+tsbqZw2BB4fAI0Xrsgo3+bZtRpTVoF5+o21iFaEZucjsiEFV7ILMFey2GPJO//p4
	 2BF063vBoKjrIj9k3/iHVSol+pwY28UTz7NFVk4QYvFJB0JUVvR3K3h3r3XVBsXbQwheu
	 xQ+e7o1lK5j8bF8Ut9JUfSyOKr5PTDre4k4QcU9mmQ6MWRLK9EXEF+pVKuP8NEHgjLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624032;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XpQn5oP9RyZc4wwYJwVVDLBdW/1VfLQJ59YmyytWShA=;
	b=RLJKk3IWtksLygSFm6vUiuX6l4HStLx8QiywpHKObfDu2bB4nS4s0qAzYbH+dW55/usx
	 srrVIQPmgIS85VBgYP/PYwTNcTt/FsMkoiWvxoTtz5XQcH1V4Hh3dZxkoLn5TFA8+xjPo
	 HEAGLHSO/tO78h/yFhda5SeC/1EsMeroE2DiIp2mHzXED/AoaCXpxhPRwNBUkPHktCi9q
	 mq1dA2uiAfJTW7ql2hQWx7jsT23SUCkyPupodqDYcLFdOq0QyU8jNxXJ0LLkxu/fkQSY+
	 WhxfmiJ3f6/1ABKIOBsBrDq4ycx0cJYHIm7AyA/6ZROMLLsGc9lBW2REs5JzdfiUG7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjftDzeB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D50606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjftDzeB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2422C1F000D1;
	Wed, 25 Nov 2026 16:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624032;
	bh=XpQn5oP9RyZc4wwYJwVVDLBdW/1VfLQJ59YmyytWShA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KjftDzeBDpb/kS9HAhwPaknzyyKNLOyCbK7USJ4PQD/QcqjClTBbqmaS4eLDZq4If
	 kjBJctQenULBVb9PDkjgg5apfIDta6p0/l6lEcmlkoZk6o7lt5j3rpT3HUaKroj0u2
	 WwlatBNV3qBqcCA7Pdv7mKny182fTqlY3cZlRuH9x2VAK8rIREjUhg8+pc9UbsFkwY
	 ugLAzugE7921tgkUW8AtQt2m1OXvKD63HVTC7cSzcLjw3zpOvnkCSLRAJu0AkwT6gL
	 7ptGHXURW4OtUJEFIgsAzKmhaKMdQP+xGzysopsuNrMPZoojAMqHLqK3XTBJDTll5D
	 gfL718ARzgJ+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zak Brighton Knight <zakbrightonknight@gmail.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Doug Smythies <dsmythies@telus.net>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] cpufreq: Improve suspend-resume synchronization
Date: Wed, 25 Nov 2026 11:27:09 -0500
Message-ID: <20261125162644.780770-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112512-whooping-statute-cfae@gregkh>
References: <2026112512-whooping-statute-cfae@gregkh>
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
[ sashal: Replaced guard()-based locking with explicit down_write/up_write and cpus_read_lock/unlock using goto unlock, and kept the older pr_err policy-pointer format and cpufreq_update_policy naming. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 98 +++++++++++++++++++++++++++++----------
 include/linux/cpufreq.h   |  3 ++
 2 files changed, 76 insertions(+), 25 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2c06fc7451663..c35e04c4f21f8 100644
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
@@ -1950,6 +1953,16 @@ int cpufreq_generic_suspend(struct cpufreq_policy *policy)
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
@@ -1972,11 +1985,8 @@ void cpufreq_suspend(void)
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
@@ -1988,6 +1998,35 @@ void cpufreq_suspend(void)
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
@@ -1997,35 +2036,38 @@ void cpufreq_suspend(void)
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
@@ -2404,12 +2446,17 @@ __weak struct cpufreq_governor *cpufreq_fallback_governor(void)
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
@@ -2452,7 +2499,7 @@ static int cpufreq_init_governor(struct cpufreq_policy *policy)
 
 static void cpufreq_exit_governor(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (cpufreq_is_suspended(policy) || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2467,7 +2514,7 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	if (cpufreq_suspended)
+	if (cpufreq_is_suspended(policy))
 		return 0;
 
 	if (!policy->governor)
@@ -2492,7 +2539,7 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
 
 void cpufreq_stop_governor(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (cpufreq_is_suspended(policy) || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2503,7 +2550,7 @@ void cpufreq_stop_governor(struct cpufreq_policy *policy)
 
 static void cpufreq_governor_limits(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (cpufreq_is_suspended(policy) || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2730,7 +2777,8 @@ void cpufreq_update_policy(unsigned int cpu)
 	 * -> ask driver for current freq and notify governors about a change
 	 */
 	if (cpufreq_driver->get && has_target() &&
-	    (cpufreq_suspended || WARN_ON(!cpufreq_verify_current_freq(policy, false))))
+	    (cpufreq_is_suspended(policy) ||
+	     WARN_ON(!cpufreq_verify_current_freq(policy, false))))
 		goto unlock;
 
 	refresh_frequency_limits(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c7fceb67a6a39..28d1e43312e75 100644
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

