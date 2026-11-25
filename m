Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601591;
	b=bUKT9/vzERyoT+radkqim1jDJ7ULNxhW5vzHoAr+5mxZA03T94VqyT5Si8SUk9MEoHjm
	 tw4Jlb4WQOI1C2CAQGXsqx2gNoyRULoZQqK5BUHhMswVSR9mWjcdTsKsjnyrji7fF6Wn7
	 nmL46ft8Oksz7FiuyYdQ39wobD90EycgvuAaoETH/0glVlI6LUBJdAK0jaqvaDOtahZoJ
	 DipWU8HyZhkI94D1szTlO5ZHnvefyB/hvN+mr6G0HJdXV+2LCmSTvOllvVVEC9L9G4EK/
	 8/X3WtDoyRk9PKzrCOixcDCgvzuOUyfvoQGjbZnNglRZ1dpjP7RCL1+LYOdU4GKqpCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601591;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Bv5UNZYFa84i03TAton/5PNxPQg2DvsXBO+PhIthIvk=;
	b=stWxSehR5HDqNwpC2ZteQzlfvLcx+laZyzZUwM+9SUe5lIVKkIemvEASNur/xDDUrK/9
	 KO3Dat7lciQVgKvtfIL2EgFq+nKLV9XzcKitJ8ZzfZ1nkDklcELk6QYQB/1pAlBaR7FVc
	 v7usJc7EfxjluOtRpCdhbym9P4hBWIYuLSmLUurVWv3NjeTrHvZEhr+EmkE3SWaMdXFhS
	 t+q/9vdlDN8AHSAPhQAlfu8W+smC73c/M/B71EfxEpDmw90ZTiuw4s4Rk1Aj8MKNDQjaa
	 v78cX0ODFObAMSH8aYyItJ66hhx1YSXddFuKD8hXmacaouUQUC0xYszqAjQWSSMYHcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YZNKynS2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C675606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YZNKynS2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A264F1F000EB;
	Wed, 25 Nov 2026 10:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795601591;
	bh=Bv5UNZYFa84i03TAton/5PNxPQg2DvsXBO+PhIthIvk=;
	h=Subject:To:Cc:From:Date;
	b=YZNKynS2K5wzHVHuk8goSw+2iokJvbiLeS5/u4gICR46VDluLHvwhsmsG3ZQl8Kgs
	 N6PQpZ/mIS3BumQJdlaArZH1DIfhENQ3lTzzlXd8JiQZJAQnd+zj2h/PmQkF6i2LvL
	 3asBK0A8wu6ceqQzjULcQC/5TVgxzDXFuTP02qrM=
Subject: FAILED: patch "[PATCH] cpufreq: Improve suspend-resume synchronization" failed to apply to 5.10-stable tree
To: rafael.j.wysocki@intel.com,christian.loehle@arm.com,dsmythies@telus.net,stable@vger.kernel.org,viresh.kumar@linaro.org,zakbrightonknight@gmail.com,zhongqiu.han@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:09:13 +0100
Message-ID: <2026112513-handwrite-santa-669b@gregkh>
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
git cherry-pick -x eee2a44e4e2b41c0699919a550d41cc38daa4f42
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112513-handwrite-santa-669b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eee2a44e4e2b41c0699919a550d41cc38daa4f42 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Tue, 3 Nov 2026 20:45:38 +0100
Subject: [PATCH] cpufreq: Improve suspend-resume synchronization

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

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 015962e6c1fe..7b93cbf313bc 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -35,6 +35,9 @@
 static LIST_HEAD(cpufreq_policy_list);
 
 /* Macros to iterate over CPU policies */
+#define for_each_policy(__policy)	\
+	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
+
 #define for_each_suitable_policy(__policy, __active)			 \
 	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list) \
 		if ((__active) == !policy_is_inactive(__policy))
@@ -1960,6 +1963,14 @@ int cpufreq_generic_suspend(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL(cpufreq_generic_suspend);
 
+static void cpufreq_suspend_policy(struct cpufreq_policy *policy)
+{
+	guard(cpufreq_policy_write)(policy);
+
+	cpufreq_stop_governor(policy);
+	policy->suspended = true;
+}
+
 /**
  * cpufreq_suspend() - Suspend CPUFreq governors.
  *
@@ -1982,11 +1993,8 @@ void cpufreq_suspend(void)
 	pr_debug("%s: Suspending Governors\n", __func__);
 
 	for_each_active_policy(policy) {
-		if (has_target()) {
-			scoped_guard(cpufreq_policy_write, policy) {
-				cpufreq_stop_governor(policy);
-			}
-		}
+		if (has_target())
+			cpufreq_suspend_policy(policy);
 
 		if (cpufreq_driver->suspend && cpufreq_driver->suspend(policy))
 			pr_err("%s: Failed to suspend driver: %s\n", __func__,
@@ -1998,6 +2006,32 @@ void cpufreq_suspend(void)
 	cpus_read_unlock();
 }
 
+static void cpufreq_resume_policy(struct cpufreq_policy *policy, bool start)
+{
+	guard(cpufreq_policy_write)(policy);
+
+	if (!policy->suspended)
+		return;
+
+	policy->suspended = false;
+
+	if (policy_is_inactive(policy)) {
+		/*
+		 * The policy was active when it was suspended, so its governor
+		 * is still there.  Let the governor go.
+		 */
+		cpufreq_exit_governor(policy);
+		return;
+	}
+
+	if (!start)
+		return;
+
+	if (cpufreq_start_governor(policy))
+		pr_err("%s: Failed to start governor for CPU%u's policy\n",
+		       __func__, policy->cpu);
+}
+
 /**
  * cpufreq_resume() - Resume CPUFreq governors.
  *
@@ -2007,11 +2041,12 @@ void cpufreq_suspend(void)
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
 
@@ -2022,19 +2057,18 @@ void cpufreq_resume(void)
 
 	pr_debug("%s: Resuming Governors\n", __func__);
 
-	for_each_active_policy(policy) {
-		if (cpufreq_driver->resume && cpufreq_driver->resume(policy)) {
-			pr_err("%s: Failed to resume driver: %s\n", __func__,
-				cpufreq_driver->name);
-		} else if (has_target()) {
-			scoped_guard(cpufreq_policy_write, policy) {
-				ret = cpufreq_start_governor(policy);
-			}
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
 
@@ -2416,12 +2450,17 @@ __weak struct cpufreq_governor *cpufreq_fallback_governor(void)
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
@@ -2464,7 +2503,7 @@ static int cpufreq_init_governor(struct cpufreq_policy *policy)
 
 static void cpufreq_exit_governor(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (cpufreq_is_suspended(policy) || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2479,7 +2518,7 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	if (cpufreq_suspended)
+	if (cpufreq_is_suspended(policy))
 		return 0;
 
 	if (!policy->governor)
@@ -2503,7 +2542,7 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
 
 void cpufreq_stop_governor(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (cpufreq_is_suspended(policy) || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2514,7 +2553,7 @@ void cpufreq_stop_governor(struct cpufreq_policy *policy)
 
 static void cpufreq_governor_limits(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (cpufreq_is_suspended(policy) || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2751,7 +2790,8 @@ static void cpufreq_policy_refresh(struct cpufreq_policy *policy)
 	 * -> ask driver for current freq and notify governors about a change
 	 */
 	if (cpufreq_driver->get && has_target() &&
-	    (cpufreq_suspended || WARN_ON(!cpufreq_verify_current_freq(policy, false))))
+	    (cpufreq_is_suspended(policy) ||
+	     WARN_ON(!cpufreq_verify_current_freq(policy, false))))
 		return;
 
 	refresh_frequency_limits(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d3d0d9d02aa4..20a6863b640a 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -149,6 +149,9 @@ struct cpufreq_policy {
 	/* Pending policy->min/max update for the driver */
 	bool			update_limits;
 
+	/* The policy has been suspended. */
+	bool			suspended;
+
 	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
 	unsigned int cached_target_freq;
 	unsigned int cached_resolved_idx;

