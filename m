Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFD34E4312
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 21:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790717558; cv=none; b=lM4HhbR7o9EX9MmJZBul6wOLHQfVttLFN/YIy4bdl/gTrBeMQUyISQTYrERU2jKQ4j0Wq7p3hwxxemPHZbhxlUNcZSUH9lDF2MO0Avsw20Yfz4KlZf5x4ugKB4IVGT0x9zpJ2GOoK7OZg5NjjznaN6WQ2ah/opqg6whwXj1ZIYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790717558; c=relaxed/simple;
	bh=ggpw2WVLkQZtMPh0QT2KkrZ7qmmnNIEfB0Quh8jo9nw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f37K6PXaLi14iaih/TssOkAlnoMMbcRVkSOBgwKO5GezPnKaySRZ6MMmsbPVUaD1Zbk2t+YUK+qDCuR+IX83IR8FKyx89IIwWpyiQMHhSgFPywnnG+ablx8zUdN092nG8UwL+VT47EcefKBVBMFyRa8D0A6xPnC4R2ClaRelEFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bq4FxpSu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bq4FxpSu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790717553; x=1822253553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ggpw2WVLkQZtMPh0QT2KkrZ7qmmnNIEfB0Quh8jo9nw=;
  b=bq4FxpSuRCgSmio1K6Oht2LtjeAOFf2G6yjKmr7mMNSIOWPS7QKb5/OH
   Z6+rGO6CkUML+bhE8sMJ/yCN07SCfnLcGmlUu5dCvpOy9igKWQxCDITX+
   UOPdbBXVJh6P57CT25cJiNf25F5FJThAsCs+xDY6G3gHiY12129EjD+zh
   pZ5r+7e4dtdpvf4EfJZXwks/pDV3B6S2EHmWLldDx42NcZFXPXax/AiTy
   tiX8+CJci4cw7YKhUgDViNXgBS9DioU9FZQjxXqq3mXp6dYIeCWLp5W0I
   Z6LqYpxOYE8KpvWSdTIRi7IjDZPB3gfSiXP2Ntw/c54eShuncIFAzuYrl
   g==;
X-CSE-ConnectionGUID: bLSIC3a5TgSP90lIHOcuQQ==
X-CSE-MsgGUID: iWBXpVA7Q+edu7ZVhUj1QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="113234683"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="113234683"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 14:32:32 -0700
X-CSE-ConnectionGUID: NbY1+Fb2QFmYGpg2mf9DcQ==
X-CSE-MsgGUID: Hoc2BJo5RqGjJrLNmyVq2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="275627098"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa008.fm.intel.com with ESMTP; 29 Sep 2026 14:32:32 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: stable@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Lu Wang <wanglu.priv@gmail.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	stable@kernel.org
Subject: [PATCH] sched/cache: Honor migrate_llc_task semantics in active load balance, to fix LLC mis-scheduling bug
Date: Tue, 29 Sep 2026 14:37:45 -0700
Message-Id: <45fc1f18b427f38539ad73143d97915526629e34.1790717763.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <2026092925-exponent-unwoven-df57@gregkh>
References: <2026092925-exponent-unwoven-df57@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Wang <wanglu.priv@gmail.com>

Cache aware scheduling introduced the migrate_llc_task migration type to direct
tasks toward their preferred LLC, but its semantics can be lost when passive
load balance falls back to active load balance (ALB). This may allow ALB to
select a candidate whose preferred LLC does not match the destination, moving
it away from its preferred LLC.

Example scenario:

src_rq has two runnable tasks, p1 and p2. p1 prefers dst_rq (dst_llc), while p2
prefers src_rq (src_llc). In this case, migrate_llc_task is set because src_rq
has at least one task, p1, that wants to migrate to dst_rq. In ALB,
can_migrate_task() finds p2 and returns true for it, thus moving p2 out of its
preferred LLC.

Solution:

The CPU stopper in ALB constructs a fresh lb_env that does not inherit
migration_type from the passive load-balance pass. Two approaches are
possible:

(a) Add a new member to struct rq so ALB can inherit migrate_llc_task
    from the passive LB that triggered it.

(b) Define a new flag LBF_ACTIVE_LB_LLC and select the stopper callback
    at kick time to preserve the migration semantics across the
    asynchronous boundary.

We choose (b) because it avoids passing migration_type through the
stopper, which would affect the meaning of migration_type for
delayed-dequeue tasks.

Fixes: e4c9a4cb244a ("sched/cache: Add migrate_llc_task migration type for cache-aware balancing")
Suggested-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Lu Wang <wanglu.priv@gmail.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Cc: <stable@kernel.org> # v7.2.x
Link: https://patch.msgid.link/cb39f64a17fc2b76097264aaec74a2d6dfff4315.1790035273.git.tim.c.chen@linux.intel.com
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 57 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bb8a5f358ee19..a395cf1b3dfc4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10266,6 +10266,7 @@ enum migration_type {
 #define LBF_SOME_PINNED	0x08
 #define LBF_ACTIVE_LB	0x10
 #define LBF_LLC_PINNED	0x20
+#define LBF_ACTIVE_LB_LLC	0x40
 
 struct lb_env {
 	struct sched_domain	*sd;
@@ -10657,6 +10658,21 @@ alb_break_llc(struct lb_env *env)
 	return false;
 }
 
+/*
+ * Returns true if p's preferred LLC does not match the destination CPU
+ * under migrate_llc_task semantics. Passive LB passes migrate_llc_task
+ * in env->migration_type, while active LB carries LBF_ACTIVE_LB_LLC in
+ * env->flags to avoid overwriting env->migration_type.
+ */
+static inline bool
+migrate_llc_task_wrong_dst(struct task_struct *p, struct lb_env *env)
+{
+	return sched_cache_enabled() &&
+	       (env->migration_type == migrate_llc_task ||
+		env->flags & LBF_ACTIVE_LB_LLC) &&
+	       READ_ONCE(p->preferred_llc) != llc_id(env->dst_cpu);
+}
+
 /*
  * Check if migrating task p from env->src_cpu to
  * env->dst_cpu breaks LLC localiy.
@@ -10685,8 +10701,7 @@ static bool migrate_degrades_llc(struct task_struct *p, struct lb_env *env)
 	 * run on env->dst_cpu, skip the tasks do not prefer
 	 * env->dst_cpu, and find the one that prefers.
 	 */
-	if (env->migration_type == migrate_llc_task &&
-	    READ_ONCE(p->preferred_llc) != llc_id(env->dst_cpu))
+	if (migrate_llc_task_wrong_dst(p, env))
 		return true;
 
 	if (can_migrate_llc_task(env->src_cpu,
@@ -10709,6 +10724,12 @@ alb_break_llc(struct lb_env *env)
 	return false;
 }
 
+static inline bool
+migrate_llc_task_wrong_dst(struct task_struct *p, struct lb_env *env)
+{
+	return false;
+}
+
 static inline bool
 migrate_degrades_llc(struct task_struct *p, struct lb_env *env)
 {
@@ -10808,7 +10829,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	 * 4) too many balance attempts have failed.
 	 */
 	if (env->flags & LBF_ACTIVE_LB)
-		return 1;
+		return !migrate_llc_task_wrong_dst(p, env);
 
 	degrades = migrate_degrades_locality(p, env);
 	if (!degrades) {
@@ -13170,6 +13191,20 @@ static int need_active_balance(struct lb_env *env)
 }
 
 static int active_load_balance_cpu_stop(void *data);
+static int active_load_balance_llc_cpu_stop(void *data);
+
+/*
+ * migration_type is checked elsewhere to decide migration policy, so
+ * it shouldn't be repurposed just to flag an LLC-directed active
+ * balance across the stopper. Pick the callback here instead.
+ */
+static inline cpu_stop_fn_t alb_stop_fn(struct lb_env *env)
+{
+	if (env->migration_type == migrate_llc_task)
+		return active_load_balance_llc_cpu_stop;
+
+	return active_load_balance_cpu_stop;
+}
 
 static int should_we_balance(struct lb_env *env)
 {
@@ -13506,7 +13541,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 			raw_spin_rq_unlock_irqrestore(busiest, flags);
 			if (active_balance) {
 				stop_one_cpu_nowait(cpu_of(busiest),
-					active_load_balance_cpu_stop, busiest,
+					alb_stop_fn(&env), busiest,
 					&busiest->active_balance_work);
 			}
 			preempt_enable();
@@ -13617,7 +13652,7 @@ update_next_balance(struct sched_domain *sd, unsigned long *next_balance)
  * least 1 task to be running on each physical CPU where possible, and
  * avoids physical / logical imbalances.
  */
-static int active_load_balance_cpu_stop(void *data)
+static int __active_load_balance_cpu_stop(void *data, unsigned int lb_flags)
 {
 	struct rq *busiest_rq = data;
 	int busiest_cpu = cpu_of(busiest_rq);
@@ -13667,7 +13702,7 @@ static int active_load_balance_cpu_stop(void *data)
 			.src_cpu	= busiest_rq->cpu,
 			.src_rq		= busiest_rq,
 			.idle		= CPU_IDLE,
-			.flags		= LBF_ACTIVE_LB,
+			.flags		= LBF_ACTIVE_LB | lb_flags,
 		};
 
 		schedstat_inc(sd->alb_count);
@@ -13695,6 +13730,16 @@ static int active_load_balance_cpu_stop(void *data)
 	return 0;
 }
 
+static int active_load_balance_cpu_stop(void *data)
+{
+	return __active_load_balance_cpu_stop(data, 0);
+}
+
+static int active_load_balance_llc_cpu_stop(void *data)
+{
+	return __active_load_balance_cpu_stop(data, LBF_ACTIVE_LB_LLC);
+}
+
 /*
  * Scale the max sched_balance_rq interval with the number of CPUs in the system.
  * This trades load-balance latency on larger machines for less cross talk.
-- 
2.32.0

