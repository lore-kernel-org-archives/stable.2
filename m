Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5E9556BA7
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790187; cv=none; b=n0y1SPOmBVuBJ4sizMGyc8avKYaU96PC5f62NYkR1j2QtqvPZmdT+PWLak4jb1svH/wMZTfGXVm6099QImDCM4XBEzysqEA3W+s+wHvVOOtgzlGp+E4hhGPHM0NcbF9LLqUo0A2cRh5r/SNIJ3BUMAQd5OIKEt57zKGOGzPxgIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790187; c=relaxed/simple;
	bh=6tY4f91+kfWQPI1og9VzHwJuHvGt+u69V424OggsWCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a8u0OPog8jPNzNfdUtbusz6Ga4FKvXkUdr+ZHrC6/EPM4ppkNeT5X5bZN6dbac6rY5DyAGSZyXMtAH6P0K0RJ0jvI/fcxZ0/ZPV6ZisZIQH2xmdy/MDZOrwJkLxTMwao6YnvQ77IXNO1weKAP6CwA2QXE9YtZwdWpQPPa9ZNehQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljy2mewk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljy2mewk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790790186; x=1822326186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6tY4f91+kfWQPI1og9VzHwJuHvGt+u69V424OggsWCw=;
  b=ljy2mewksqjctRq5tP2CcJr/NLizTJg/4ZfWM2cEqJR5ApWEqXLv+7gJ
   XvtsI6gR8i4vizVi8jl3xBd5LRnKcwll94PXmUkVKi1huq4hDl4BkyHAv
   5YsOMztROGau+r/Z+1RkqJ9iBAMa6dfsZqc3C9CIP3JxTMwMoxfJxD68O
   KOlf0Atv9P15Wady2gLzx+H9WHwgConLmOK5ikUm69dKo5zId8uSgflFg
   74ewHCEDNs1bHZQ34jOP5BZWHTVj/uFsPuhcTxfkxQwbe1nisBVKXuTI8
   M04y0Js7aXDiPTyWFekpHzCYsM41kb/GKMZc1gaLEgvFyJxaX8ZS8M4gv
   Q==;
X-CSE-ConnectionGUID: rTiXBAxoRS2R1EB98Dk6Rw==
X-CSE-MsgGUID: PDd3sA7OSGiPH1s+JBKIkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="91633317"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="91633317"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 10:42:54 -0700
X-CSE-ConnectionGUID: If83Wz59RLaM8fnqAyULKQ==
X-CSE-MsgGUID: N0GVe6dhR42Lc5Y2M2MihA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="303684038"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa001.fm.intel.com with ESMTP; 30 Sep 2026 10:42:54 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Lu Wang <wanglu.priv@gmail.com>,
	Davi Chaves Azevedo <davichazbh@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	stable@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kayra Cizmeci <kayracizmeci@gmail.com>,
	stable@kernel.org
Subject: [PATCH 7.2.y 2/7] sched/cache: Keep nr_pref_llc_running in the runnable domain, to fix LLC mis-scheduling bug
Date: Wed, 30 Sep 2026 10:48:04 -0700
Message-Id: <c3a63086301b33b329b82783bdf294a97e4610eb.1790790344.git.tim.c.chen@linux.intel.com>
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

[ Upstream commit 0d6526f82c3cdefcca47f73f5fc08dc6f335eac6 ]

alb_break_llc() decides whether to break LLC preference during active
load balance. It does so by testing that every runnable fair task on the
source rq prefers its LLC:

	env->src_rq->nr_pref_llc_running == env->src_rq->cfs.h_nr_runnable

But the two counters cover different sets. nr_pref_llc_running is updated
in account_llc_enqueue()/account_llc_dequeue(), next to cfs_rq->nr_queued,
so it follows queued tasks. h_nr_runnable is updated in set_delayed()/
clear_delayed() and drops delay-dequeued tasks.

So under DELAY_DEQUEUE, a preferring task that goes to sleep stays counted
in nr_pref_llc_running while h_nr_runnable falls. The equality then breaks,
alb_break_llc() returns false, and active balance is free to pull a task
off its preferred LLC. Active balance only moves runnable tasks, and this
is the only LLC check it consults: once the stopper runs, LBF_ACTIVE_LB
skips the per-task test in can_migrate_task(). The runnable set is the one
we want.

Fix it on the counter side. A task should be counted in
nr_pref_llc_running exactly while it is both queued on its preferred LLC
(pref_llc_queued) and runnable (!sched_delayed). Define that membership
once in task_pref_llc_runnable(), and adjust the counter only through
pref_llc_running_inc()/pref_llc_running_dec() from the four sites that
change either input: account_llc_enqueue(), account_llc_dequeue(),
set_delayed() and clear_delayed(). Gating every update on the same
predicate keeps the delay, wake and dequeue paths from double-counting
or underflowing; see the comments at those sites for the ordering.

nr_llc_running and sd->llc_counts are not touched and stay on queued
semantics.

Fixes: 714059f79ff0 ("sched/cache: Handle moving single tasks to/from their preferred LLC")
Closes: https://lore.kernel.org/lkml/20260827135000.735138-1-zhanxusheng@xiaomi.com/
Reported-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Suggested-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: <stable@kernel.org> # v7.2.x
Link: https://patch.msgid.link/06af61afedac32e6477f57feb4d658f6c411c3af.1790035273.git.tim.c.chen@linux.intel.com
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 63 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3cc672122599a..f0ff714d3a4ce 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1507,6 +1507,28 @@ static bool invalid_llc_nr(struct mm_struct *mm, struct task_struct *p,
 			(scale * per_cpu(sd_llc_size, cpu)));
 }
 
+/*
+ * A task counts in nr_pref_llc_running while it is queued on its preferred
+ * LLC (pref_llc_queued) and runnable (!sched_delayed), keeping the counter in
+ * the runnable domain so alb_break_llc() can compare it with h_nr_runnable.
+ */
+static bool task_pref_llc_runnable(struct task_struct *p)
+{
+	return p->pref_llc_queued && !p->se.sched_delayed;
+}
+
+static void pref_llc_running_inc(struct rq *rq, struct task_struct *p)
+{
+	if (task_pref_llc_runnable(p))
+		rq->nr_pref_llc_running++;
+}
+
+static void pref_llc_running_dec(struct rq *rq, struct task_struct *p)
+{
+	if (task_pref_llc_runnable(p))
+		rq->nr_pref_llc_running--;
+}
+
 static void account_llc_enqueue(struct rq *rq, struct task_struct *p)
 {
 	int pref_llc, pref_llc_queued;
@@ -1518,7 +1540,6 @@ static void account_llc_enqueue(struct rq *rq, struct task_struct *p)
 
 	pref_llc_queued = (pref_llc == task_llc(p));
 	rq->nr_llc_running++;
-	rq->nr_pref_llc_running += pref_llc_queued;
 
 	/*
 	 * Record whether p is enqueued on its preferred
@@ -1536,6 +1557,9 @@ static void account_llc_enqueue(struct rq *rq, struct task_struct *p)
 	 */
 	p->pref_llc_queued = pref_llc_queued;
 
+	/* Skipped while delayed; clear_delayed() adds it back on wake. */
+	pref_llc_running_inc(rq, p);
+
 	sd = rcu_dereference_all(rq->sd);
 	if (sd && (unsigned int)pref_llc < sd->llc_max)
 		sd->llc_counts[pref_llc]++;
@@ -1552,7 +1576,12 @@ static void account_llc_dequeue(struct rq *rq, struct task_struct *p)
 
 	rq->nr_llc_running--;
 	if (p->pref_llc_queued) {
-		rq->nr_pref_llc_running--;
+		/*
+		 * Skipped if still delayed (set_delayed() already removed it);
+		 * clearing pref_llc_queued below also stops clear_delayed()
+		 * from re-adding it.
+		 */
+		pref_llc_running_dec(rq, p);
 		/*
 		 * Update the status in case
 		 * other logic might query
@@ -1956,6 +1985,7 @@ void init_sched_mm(struct task_struct *p)
 	 * polluting account_llc_enqueue().
 	 */
 	p->preferred_llc = -1;
+	p->pref_llc_queued = 0;
 }
 
 #else /* CONFIG_SCHED_CACHE */
@@ -1977,6 +2007,10 @@ static void account_llc_enqueue(struct rq *rq, struct task_struct *p) {}
 
 static void account_llc_dequeue(struct rq *rq, struct task_struct *p) {}
 
+static void pref_llc_running_inc(struct rq *rq, struct task_struct *p) {}
+
+static void pref_llc_running_dec(struct rq *rq, struct task_struct *p) {}
+
 #endif /* CONFIG_SCHED_CACHE */
 
 /*
@@ -6202,15 +6236,27 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 
 static void set_delayed(struct sched_entity *se)
 {
-	se->sched_delayed = 1;
-
 	/*
 	 * Delayed se of cfs_rq have no tasks queued on them.
 	 * Do not adjust h_nr_runnable since dequeue_entities()
 	 * will account it for blocked tasks.
+	 *
+	 * This check can be removed because when flat pick
+	 * patches get merged as only task can get delayed,
+	 * same for clear_delayed().
 	 */
-	if (!entity_is_task(se))
+	if (!entity_is_task(se)) {
+		se->sched_delayed = 1;
 		return;
+	}
+
+	/*
+	 * Drop a task leaving the runnable set.
+	 * Needs to be called before sched_delayed is set.
+	 * clear_delayed() mirrors this after clearing the flag.
+	 */
+	pref_llc_running_dec(rq_of(cfs_rq_of(se)), task_of(se));
+	se->sched_delayed = 1;
 
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
@@ -6232,6 +6278,13 @@ static void clear_delayed(struct sched_entity *se)
 	if (!entity_is_task(se))
 		return;
 
+	/*
+	 * Re-add on wake, after sched_delayed is cleared. On a final delayed
+	 * dequeue account_llc_dequeue() already cleared pref_llc_queued, so
+	 * this does nothing.
+	 */
+	pref_llc_running_inc(rq_of(cfs_rq_of(se)), task_of(se));
+
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-- 
2.32.0

