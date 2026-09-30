Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5157C55293A
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790186; cv=none; b=GE2ZEX85bmh+2pHIx0xoSpx5hqxE1lCc7LpYohxKWoDMlmrVjFXicepomF0zXgwEyzVIeEkSKnoVn4PdOeZBO3bWw3dNtZs9W3kBnAw2iVb/fqRoCjEjCK1u424VL8IKI+Gy4IwrihHiV0EyM//JsYYS7UJDtz+oNROudZzx2B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790186; c=relaxed/simple;
	bh=UEXUW6xhApsvb1k4+g//l2aEA6gZWOMUz21iUbbPf4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nf8PEYNc03/vAGAHsrRS4h+vKFaRW7IhbOSMSMUK5mae4gClvDyZkakK4A2M0264rZ5skesykVq2vi5MgCy9mIRuzjMxeXACqkQHzSjM7TEfdZZwunlXZBUig4qa8OKdyMQdSOLEGUX0YU8CcXRyZ5yMU7XLJMSwOcqRQ4YLPPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQrikTCL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQrikTCL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790790185; x=1822326185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UEXUW6xhApsvb1k4+g//l2aEA6gZWOMUz21iUbbPf4U=;
  b=AQrikTCLSmq8m398DHPqRYr3hBOgs3xFJxd4CkJIheacbuaN7UrZQ23v
   G8VjB4ThrJ63zdvFgCpsuRPoJPVz6J4wSJUf5A+BVMv2Otn0ZLgJOljBO
   7U7jNqL3mMzx2q1hj508SidZCGG9bNLN+IKIyyJLqFZjUfHK4bN0Hrp9p
   EiexLW0CjQhi/9JcyiybGoUDaJMWM94ie9ZD+mgHajKxwMSPYsO3g0FF5
   EWvFVm90+doYgE74l1VyP9SZ7tzmWo8ciCRbxp2o8JYBK6jhUTByzSNWt
   Jc11Qp7fJQ00CC68l+VJPv4EGJ3fZ+0BSEf0GqPgf1G3XfiJUwQD19e4N
   Q==;
X-CSE-ConnectionGUID: 67vzrVFIQtO8HeTguO4nXQ==
X-CSE-MsgGUID: C1HDS8OTTkywifGpx5jyMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="91633306"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="91633306"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 10:42:52 -0700
X-CSE-ConnectionGUID: iH/5g3IfQrSdqX5bQgOrGg==
X-CSE-MsgGUID: gxn9R+HeSeaGj+DF8tVf/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="303684031"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa001.fm.intel.com with ESMTP; 30 Sep 2026 10:42:53 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Lu Wang <wanglu.priv@gmail.com>,
	Davi Chaves Azevedo <davichazbh@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	stable@vger.kernel.org,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 7.2.y 1/7] sched/fair: Avoid creating misfits during cache-aware balancing
Date: Wed, 30 Sep 2026 10:48:03 -0700
Message-Id: <71b25bb6163de295a64f864dd16f3f4a6a43dc0c.1790790344.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1790790344.git.tim.c.chen@linux.intel.com>
References: <cover.1790790344.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit f0d243a96f2684ad771d678767d17972cf840bd7 ]

Cache-aware load balancing biases tasks toward their preferred LLC. On
asymmetric CPU capacity systems (e.g. big.LITTLE) the destination LLC may
contain CPUs that are too small to run the task. Pulling the task there
turns it into a misfit, trading a cache-locality gain for a capacity loss
that's more detrimental to performance.

Guard both cache-aware migration entry points against this:

 - can_migrate_llc_task(): forbid the LLC migration when the task fits its
   source CPU but would not fit the destination CPU.
 - alb_break_llc(): veto the active balance under the same condition so the
   runnable task is not pushed onto a CPU that cannot accommodate it.

Both checks are gated with checks for hybrid processors, so symmetric
systems are unaffected. Tasks that already do not fit their source CPU
are left to the existing LLC policy, since the move cannot make their
fitness worse (this also preserves misfit up-migration to bigger CPUs).

Additionally, if there are misfit tasks found in the load balancing
classification phase, prioritize misfit task migrations
over LLC load aggregation on asymmetric systems. A better fitting
CPU will boost performance more than better cache locality.

Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/edbb2503d554c63dc9b72e201fb4a17e1cb119e7.camel@linux.intel.com
Stable-dep-of: d6013e2465d9 ("sched/cache: Honor migrate_llc_task semantics in active load balance, to fix LLC mis-scheduling bug")
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 50 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bb8a5f358ee19..3cc672122599a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10575,17 +10575,40 @@ static enum llc_mig can_migrate_llc(int src_cpu, int dst_cpu,
 	return mig_llc;
 }
 
+static inline bool task_misfits_asym_cpu(struct lb_env *env, struct task_struct *p)
+{
+	/*
+	 * On asymmetric CPU capacity domains, do not let cache-aware
+	 * balancing pull the task onto a destination CPU that cannot
+	 * accommodate it. Doing so would turn the task into a misfit on
+	 * the destination, trading a cache-locality gain for a capacity
+	 * loss. If the task already does not fit its source CPU, the move
+	 * cannot make things worse, so let the LLC preference decide.
+	 */
+	if ((env->sd->flags & SD_ASYM_CPUCAPACITY) && p &&
+	    !task_fits_cpu(p, env->dst_cpu) &&
+	    task_fits_cpu(p, env->src_cpu))
+		return true;
+
+	return false;
+}
+
 /*
  * Check if task p can migrate from source LLC to
  * destination LLC in terms of cache aware load balance.
  */
-static enum llc_mig can_migrate_llc_task(int src_cpu, int dst_cpu,
+static enum llc_mig can_migrate_llc_task(struct lb_env *env,
 					 struct task_struct *p)
 {
 	struct mm_struct *mm;
 	bool to_pref;
-	int cpu;
+	int cpu, src_cpu, dst_cpu;
+
+	if (task_misfits_asym_cpu(env, p))
+		return mig_forbid;
 
+	src_cpu = env->src_cpu;
+	dst_cpu = env->dst_cpu;
 	mm = p->mm;
 	if (!mm)
 		return mig_unrestricted;
@@ -10642,6 +10665,14 @@ alb_break_llc(struct lb_env *env)
 		unsigned long util = 0;
 		struct task_struct *cur;
 
+		/*
+		 * Migrating misfit tasks from current CPU
+		 * to CPU with a better fit.
+		 * Prioritize that over LLC preference.
+		 */
+		if (env->migration_type == migrate_misfit)
+			return false;
+
 		if (env->src_rq->nr_running <= 1)
 			return true;
 
@@ -10649,7 +10680,8 @@ alb_break_llc(struct lb_env *env)
 		if (cur && cur->sched_class == &fair_sched_class)
 			util = task_util(cur);
 
-		if (can_migrate_llc(env->src_cpu, env->dst_cpu,
+		if (task_misfits_asym_cpu(env, cur) ||
+		    can_migrate_llc(env->src_cpu, env->dst_cpu,
 				    util, false) == mig_forbid)
 			return true;
 	}
@@ -10689,8 +10721,7 @@ static bool migrate_degrades_llc(struct task_struct *p, struct lb_env *env)
 	    READ_ONCE(p->preferred_llc) != llc_id(env->dst_cpu))
 		return true;
 
-	if (can_migrate_llc_task(env->src_cpu,
-				 env->dst_cpu, p) != mig_forbid)
+	if (can_migrate_llc_task(env, p) != mig_forbid)
 		return false;
 
 	return true;
@@ -11753,6 +11784,15 @@ static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
 	if (env->sd->flags & SD_SHARE_LLC)
 		return false;
 
+	/*
+	 * On asymmetric domains, group_misfit_task_load
+	 * should be prioritized to move tasks to CPU that fit them
+	 * over aggregating tasks to their preferred LLC.
+	 */
+	if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
+	    sgs->group_misfit_task_load)
+		return false;
+
 	/*
 	 * Skip cache aware tagging if nr_balanced_failed is sufficiently high.
 	 * Threshold of cache_nice_tries is set to 1 higher than nr_balance_failed
-- 
2.32.0

