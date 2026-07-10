Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BB73FBEAA
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677250; cv=none; b=CeWqAVQxGsFHa2KVcR/6sqDVFuBSnmE3eRwVzcb1218mfUy4yP4q3rox5VisrUjzTmPajbCRCWPLwZzjtgqwuz2scv/1bfzOgvvpQT7lvHd9W9kR3qt9iWaafOm62BOP1FfBpDthxZdCTExtQR63EbOw3jZ2Gr2kG+TJMUuMcLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677250; c=relaxed/simple;
	bh=59J4qeM5w8Eger8VYrZ+ttgIMt/GxLGwK266TOOqPTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L3lQJGiUDuCMNKY2+Ssbg+YDqtZrPoXoEQJXF5+hkLfZJc0poS2PX3tX1+aUvHADgDNok2jYn484fNuqnyYbWGfqR43Py9xNga/OrPQaJXNlxalWQ5Ro5wT4VsvbrRy+s+tctCxkOJCpN9kBy8E00dyUiSQNASUuMNuEWCXcYH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=BlCpYH38; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="BlCpYH38"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493f0ae9572so2536515e9.3
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1783677244; x=1784282044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+MhXOCVYgw/edw9jUdRTTxml3OSASdRiAdgXb4/2WDY=;
        b=BlCpYH388rDRMVNi/2nTfLIDqUdgzWTkw+3oqv9eOOnIY5yWRIlHeT86+eOUcDBYB+
         QBgNops/YwXgo2/ywpMB8w2Q3+fXxXuEQTOauQA1QSQnHPyZbdTkSypIl4R2HCdrFwep
         PHc5reEIzEE7BnDaElS2sj9cEvjjTQffykpz4CZi+wYZ1aoTFRCeJiThncnJth9dR8Wr
         wOYyIP0S8cOkFtyb7DuVfPp/K+SK35q5n3eiwCpqoP8NWGrU+HXuXUQCVNBQWgy81Zz8
         eApImjtltMLxEt82tZIpmwzJITDg0KZbIwH6MVTIwrU3PmF+lDvFSJqqFkFmplsVzxwj
         /llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677244; x=1784282044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+MhXOCVYgw/edw9jUdRTTxml3OSASdRiAdgXb4/2WDY=;
        b=YCaOagyCCynLffpYGIlqpsWSXCHSjyESlOXKDedQQTVBxQPdebV8mUAfoevjH18JUw
         1JJAET//OjcU0GkByvFu9AWuxcvlXlPWIr2bvxMdRVTKPmWYefxDV2yllh8wFrsJTSln
         pYVmHh8pCLpP4w08d8Q4vfJHW9IgjZ7MhfZJUMDmVf7Od7yyCh9xJW2VEvxTBdW0vrpH
         EIg9NaMSD4Z/WkTa0CgJTMhCKo8AwAPl2+JL6mxfBrv525spnA8zP86phY3vPyQMVUuo
         UaiYz/xDA/A70buyNmimNJKh8wo2eFtxwei96pIiH8wJayga/C58z2Jy/o6F+7VaAbCm
         S2MA==
X-Forwarded-Encrypted: i=1; AHgh+RpwQmrNFzdr5HhWDXo2HV0+YZHTnTete/sDgM0FKRttpz4IXZPzWaJ14l8nGCfFIiU0stoXDMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOABNUqTiXXR5a7mUt6qo8lGjlHOGWu52yq2Wd+gZ0IMwPrJXu
	Jh9lgHDT3YPacWATC9tVeVxik++zy+XoyB+ldGusnBPk0bLcU6s1VsY+qZHcDitn1wQ=
X-Gm-Gg: AfdE7ckKzhqCiHcsk6D1xS8//F7jw+tqGFAQGNc6oTeym6cEGtrBPhqDEsXfy3ybOrF
	t5ufHRZmmSjdI7nqe6u/iN1gCcZJWYl04Uhtxzr1yaNTm2U4msQFsyOAHwKDxYpBCWCvW/lT+cv
	v1KXwewvJHLCXofHX4LiEHH0gAcQTm1jZpe3xi8uBN1VFeHDJLY6DPw6TNwxN8Amrjf3Sov4Ccg
	Mf7ravNhRHFWXRkVCtM9NdKwpSXrbnUYPloZI/4YdSKFtj2PR340L5ov32tCl6NIYV0BWjTsJHr
	aZbhFLFYhrJ/c+KgRT2iqJj0nk3scC1R8IFa7vfk92ZvUqWsKhwn1u2UQqTAWw54WfLnMSfPKt+
	t38X77WELYK4r9xSUYlAARKH3QCKoe7rci9Blmb82AA2ucmis8jUG5pQNBxFpzbV/oWXo3zxnmN
	1/2TE91hccd4ibKsE=
X-Received: by 2002:a05:600c:1910:b0:493:e52f:6ee1 with SMTP id 5b1f17b1804b1-493e8a618bamr86537905e9.0.1783677243393;
        Fri, 10 Jul 2026 02:54:03 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:26a0::3d9:1e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6df417sm131946725e9.8.2026.07.10.02.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:54:02 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH 6.18.y] rcu-tasks: Defer IRQ-disabled callback enqueue to irq_work
Date: Fri, 10 Jul 2026 10:53:59 +0100
Message-ID: <20260710095359.2643791-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

call_rcu_tasks_generic() can be invoked with IRQs disabled (e.g. from
scheduler paths holding rq->lock). On heavy contention the slow path
falls through to acquire rtp->cbs_gbl_lock to switch the flavor to
per-CPU enqueue. Taking cbs_gbl_lock underneath rq->lock inverts the
ordering used elsewhere and can deadlock against tasks-RCU wakeups that
run with cbs_gbl_lock held and then touch the scheduler.

        CPU 0                           CPU 1
        -----                           -----
sched_ext_free()
  task_rq_lock()
    raw_spin_lock(rq->lock)
                                      rcu_tasks_one_gp()
                                        raw_spin_lock(cbs_gbl_lock)
  scx_exit_task()
    bpf_task_storage_delete()
      call_rcu_tasks_generic()
        raw_spin_lock(cbs_gbl_lock)
          <blocks>
                                        _printk()
                                          console_unlock()
                                            try_to_wake_up()
                                              raw_spin_lock(rq->lock)
                                                <blocks>

Split enqueue into a helper and route IRQ-disabled callers through a
lockless per-CPU llist drained by a hard irq_work. The fast path with
IRQs enabled is unchanged; only IRQ-disabled callers are deferred, so we
never acquire rtpcp->cbs_pcpu_lock or cbs_gbl_lock under an unknown
outer lock. rcu_tasks_adjust_cbs() is factored out so both the direct
and deferred paths reach the same expansion logic.

Fixes: ab97152f88a4 ("rcu-tasks: Use more callback queues if contention encountered")
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20260609104733.1184001-1-mfleming@cloudflare.com
Cc: stable@vger.kernel.org
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 kernel/rcu/tasks.h | 184 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 148 insertions(+), 36 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 2dc044fd126e..56b51946bc6b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -30,6 +30,8 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @rtp_n_lock_retries: Rough lock-contention statistic.
  * @rtp_work: Work queue for invoking callbacks.
  * @rtp_irq_work: IRQ work queue for deferred wakeups.
+ * @rtp_irq_bypass_work: IRQ work queue for draining IRQ-bypassed callbacks.
+ * @rtp_irq_bypass_list: Lockless callback list for IRQ-disabled callers.
  * @barrier_q_head: RCU callback for barrier operation.
  * @rtp_blkd_tasks: List of tasks blocked as readers.
  * @rtp_exit_list: List of tasks in the latter portion of do_exit().
@@ -46,6 +48,8 @@ struct rcu_tasks_percpu {
 	unsigned int urgent_gp;
 	struct work_struct rtp_work;
 	struct irq_work rtp_irq_work;
+	struct irq_work rtp_irq_bypass_work;
+	struct llist_head rtp_irq_bypass_list;
 	struct rcu_head barrier_q_head;
 	struct list_head rtp_blkd_tasks;
 	struct list_head rtp_exit_list;
@@ -129,11 +133,14 @@ struct rcu_tasks {
 };
 
 static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
+static void call_rcu_tasks_iw_drain_irq_bypass(struct irq_work *iwp);
+static void rcu_tasks_adjust_cbs(struct rcu_tasks *rtp);
 
 #define DEFINE_RCU_TASKS(rt_name, gp, call, n)						\
 static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {			\
 	.lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name ## __percpu.cbs_pcpu_lock),		\
 	.rtp_irq_work = IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_wakeup),			\
+	.rtp_irq_bypass_work = IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_drain_irq_bypass), \
 };											\
 static struct rcu_tasks rt_name =							\
 {											\
@@ -276,6 +283,7 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		if (rcu_segcblist_empty(&rtpcp->cblist))
 			rcu_segcblist_init(&rtpcp->cblist);
 		INIT_WORK(&rtpcp->rtp_work, rcu_tasks_invoke_cbs_wq);
+		init_llist_head(&rtpcp->rtp_irq_bypass_list);
 		rtpcp->cpu = cpu;
 		rtpcp->rtpp = rtp;
 		rtpcp->index = index;
@@ -332,6 +340,102 @@ static void call_rcu_tasks_generic_timer(struct timer_list *tlp)
 		rcuwait_wake_up(&rtp->cbs_wait);
 }
 
+static bool call_rcu_tasks_enqueue_locked(struct rcu_head *rhp,
+					  struct rcu_tasks *rtp,
+					  struct rcu_tasks_percpu *rtpcp)
+{
+	bool havekthread;
+	bool needwake;
+
+	// Queuing callbacks before initialization not yet supported.
+	if (WARN_ON_ONCE(!rcu_segcblist_is_enabled(&rtpcp->cblist)))
+		rcu_segcblist_init(&rtpcp->cblist);
+	/* Pairs with the kthread publication in rcu_tasks_kthread(). */
+	havekthread = smp_load_acquire(&rtp->kthread_ptr);
+	needwake = (rhp->func == wakeme_after_rcu) ||
+		   (rcu_segcblist_n_cbs(&rtpcp->cblist) == rcu_task_lazy_lim);
+	if (havekthread && !needwake && !timer_pending(&rtpcp->lazy_timer)) {
+		if (rtp->lazy_jiffies)
+			mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
+		else
+			needwake = rcu_segcblist_empty(&rtpcp->cblist);
+	}
+	if (needwake)
+		rtpcp->urgent_gp = 3;
+	rcu_segcblist_enqueue(&rtpcp->cblist, rhp);
+	return needwake;
+}
+
+/* Acquire the callback-list lock and report whether the acquisition contended. */
+static bool call_rcu_tasks_lock(struct rcu_tasks_percpu *rtpcp)
+{
+	if (raw_spin_trylock_rcu_node(rtpcp)) // irqs already disabled.
+		return false;
+	raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
+	return true;
+}
+
+/* Record one callback-queuing-time contention event. */
+static bool rcu_tasks_need_queue_adjust(struct rcu_tasks *rtp,
+					struct rcu_tasks_percpu *rtpcp)
+{
+	unsigned long j = jiffies;
+
+	if (rtpcp->rtp_jiffies != j) {
+		rtpcp->rtp_jiffies = j;
+		rtpcp->rtp_n_lock_retries = 0;
+	}
+
+	return rcu_task_cb_adjust &&
+	       ++rtpcp->rtp_n_lock_retries > rcu_task_contend_lim &&
+	       READ_ONCE(rtp->percpu_enqueue_lim) != rcu_task_cpu_ids;
+}
+
+static void rcu_tasks_drain_irq_bypass(struct rcu_tasks_percpu *rtpcp)
+{
+	bool contended;
+	bool needadjust = false;
+	bool needwake = false;
+	unsigned long flags;
+	struct llist_node *llnode;
+	struct llist_node *next;
+	struct rcu_head *rhp;
+	struct rcu_tasks *rtp = rtpcp->rtpp;
+
+	local_irq_save(flags);
+	rcu_read_lock();
+	contended = call_rcu_tasks_lock(rtpcp);
+
+	/*
+	 * Serialize the entire bypass-to-cblist transfer with barrier
+	 * entrainment so that a barrier cannot pass callbacks in transit.
+	 */
+	llnode = llist_del_all(&rtpcp->rtp_irq_bypass_list);
+	if (!llnode) {
+		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+		rcu_read_unlock();
+		return;
+	}
+
+	if (contended)
+		needadjust = rcu_tasks_need_queue_adjust(rtp, rtpcp);
+
+	llnode = llist_reverse_order(llnode);
+	llist_for_each_safe(llnode, next, llnode) {
+		rhp = (struct rcu_head *)llnode;
+		needwake |= call_rcu_tasks_enqueue_locked(rhp, rtp, rtpcp);
+	}
+	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+
+	if (unlikely(needadjust))
+		rcu_tasks_adjust_cbs(rtp);
+	rcu_read_unlock();
+
+	/* We can't create the thread unless interrupts are enabled. */
+	if (needwake && READ_ONCE(rtp->kthread_ptr))
+		rcuwait_wake_up(&rtp->cbs_wait);
+}
+
 // IRQ-work handler that does deferred wakeup for call_rcu_tasks_generic().
 static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
 {
@@ -342,15 +446,40 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
 	rcuwait_wake_up(&rtp->cbs_wait);
 }
 
+// IRQ-work handler that drains IRQ-bypassed callbacks.
+static void call_rcu_tasks_iw_drain_irq_bypass(struct irq_work *iwp)
+{
+	struct rcu_tasks_percpu *rtpcp;
+
+	rtpcp = container_of(iwp, struct rcu_tasks_percpu, rtp_irq_bypass_work);
+	rcu_tasks_drain_irq_bypass(rtpcp);
+}
+
+static void rcu_tasks_adjust_cbs(struct rcu_tasks *rtp)
+{
+	unsigned long flags;
+	bool expanded = false;
+
+	raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
+	if (rtp->percpu_enqueue_lim != rcu_task_cpu_ids) {
+		WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
+		WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_ids);
+		smp_store_release(&rtp->percpu_enqueue_lim, rcu_task_cpu_ids);
+		expanded = true;
+	}
+	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
+	if (expanded)
+		pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
+}
+
 // Enqueue a callback for the specified flavor of Tasks RCU.
 static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 				   struct rcu_tasks *rtp)
 {
 	int chosen_cpu;
 	unsigned long flags;
-	bool havekthread = smp_load_acquire(&rtp->kthread_ptr);
 	int ideal_cpu;
-	unsigned long j;
+	bool irqsoff = irqs_disabled();
 	bool needadjust = false;
 	bool needwake;
 	struct rcu_tasks_percpu *rtpcp;
@@ -363,43 +492,23 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	chosen_cpu = cpumask_next(ideal_cpu - 1, cpu_possible_mask);
 	WARN_ON_ONCE(chosen_cpu >= rcu_task_cpu_ids);
 	rtpcp = per_cpu_ptr(rtp->rtpcpu, chosen_cpu);
-	if (!raw_spin_trylock_rcu_node(rtpcp)) { // irqs already disabled.
-		raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
-		j = jiffies;
-		if (rtpcp->rtp_jiffies != j) {
-			rtpcp->rtp_jiffies = j;
-			rtpcp->rtp_n_lock_retries = 0;
-		}
-		if (rcu_task_cb_adjust && ++rtpcp->rtp_n_lock_retries > rcu_task_contend_lim &&
-		    READ_ONCE(rtp->percpu_enqueue_lim) != rcu_task_cpu_ids)
-			needadjust = true;  // Defer adjustment to avoid deadlock.
-	}
-	// Queuing callbacks before initialization not yet supported.
-	if (WARN_ON_ONCE(!rcu_segcblist_is_enabled(&rtpcp->cblist)))
-		rcu_segcblist_init(&rtpcp->cblist);
-	needwake = (func == wakeme_after_rcu) ||
-		   (rcu_segcblist_n_cbs(&rtpcp->cblist) == rcu_task_lazy_lim);
-	if (havekthread && !needwake && !timer_pending(&rtpcp->lazy_timer)) {
-		if (rtp->lazy_jiffies)
-			mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
-		else
-			needwake = rcu_segcblist_empty(&rtpcp->cblist);
+	if (irqsoff) {
+		llist_add((struct llist_node *)rhp, &rtpcp->rtp_irq_bypass_list);
+		rcu_read_unlock();
+		local_irq_restore(flags);
+		irq_work_queue(&rtpcp->rtp_irq_bypass_work);
+		return;
 	}
-	if (needwake)
-		rtpcp->urgent_gp = 3;
-	rcu_segcblist_enqueue(&rtpcp->cblist, rhp);
+
+	if (call_rcu_tasks_lock(rtpcp))
+		needadjust = rcu_tasks_need_queue_adjust(rtp, rtpcp);
+
+	needwake = call_rcu_tasks_enqueue_locked(rhp, rtp, rtpcp);
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
-	if (unlikely(needadjust)) {
-		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
-		if (rtp->percpu_enqueue_lim != rcu_task_cpu_ids) {
-			WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
-			WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_ids);
-			smp_store_release(&rtp->percpu_enqueue_lim, rcu_task_cpu_ids);
-			pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
-		}
-		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
-	}
+	if (unlikely(needadjust))
+		rcu_tasks_adjust_cbs(rtp);
 	rcu_read_unlock();
+
 	/* We can't create the thread unless interrupts are enabled. */
 	if (needwake && READ_ONCE(rtp->kthread_ptr))
 		irq_work_queue(&rtpcp->rtp_irq_work);
@@ -441,6 +550,7 @@ static void __maybe_unused rcu_barrier_tasks_generic(struct rcu_tasks *rtp)
 		if (cpu >= smp_load_acquire(&rtp->percpu_dequeue_lim))
 			break;
 		rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
+		rcu_tasks_drain_irq_bypass(rtpcp);
 		rtpcp->barrier_q_head.func = rcu_barrier_tasks_generic_cb;
 		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 		if (rcu_segcblist_entrain(&rtpcp->cblist, &rtpcp->barrier_q_head))
@@ -473,6 +583,8 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 			continue;
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
+		rcu_tasks_drain_irq_bypass(rtpcp);
+
 		/* Advance and accelerate any new callbacks. */
 		if (!rcu_segcblist_n_cbs(&rtpcp->cblist))
 			continue;
-- 
2.43.0

