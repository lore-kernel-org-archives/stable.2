Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B4D3E3158
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783937575; cv=none; b=TDmfD5u1aaire/lPivUiVNeB9hKv9+Hxm0bLJXVd3aazRY2TogYEgKSZuM5nB2DZ/hQNlCRL1sAp4WMKMP5vFDfSN6N5Ym0sx4ysRzpr+LXJZOBztBNFGiOcnBfJz7WVkZ7VXTkaLy1fXVDL7jehb6zUlSbmWBmJWQdRRKoamx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783937575; c=relaxed/simple;
	bh=I0iNJ5l1KFpuImGwAYZaxJGvSjujxWdh8H760eEBEhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cBlUJm39+ZHPJ0diQIAx4tVJSokHJZ0997aRUV6UOOmCVZktvXAxltLVglevHcuWK5AeXkQRZSBEqQMKHAKiImEFuyWFxLrd6lLP1rrM1SieneB+2CDj/j8M+30cGSOjWKaRN8M+ew40muMIZs92CZGJzn6YL2WqdZRA3i1B5ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=r9ZHgQRu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="r9ZHgQRu"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-476a130c138so3580360f8f.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 03:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1783937570; x=1784542370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gQDcHMF91uNTbQRKUs7FtApfDoXRXDWv1xLDi776PsY=;
        b=r9ZHgQRu/aReOhR3NxdgCb7zasbspl28ZRPlQ/LVLucLBk1J5Y949HrRtsaukhfMAn
         GUEeuesayF3NYDSaSMoGZzuESW6OMN1xOSwhZ3bBxEcmOqTXniwnAakjDEiLnMpnWWtb
         npvDNGQov9qxj2LaujnttYKmEWO7Aa1k9Qj5n8sDLa1W4Mjx/3w/HCgQekByqV74g9GI
         nvcevf4c3FvUDrCSZBkcQZDjjqfFLZLmaw8+NFOtv1czLZ2158F3WsKl74H8QGdSTFtu
         CzqF6Z235LlNMXj42nnrPji/gObhBVNCAvhqRLXiBTmFiMkXn7OHztUpjxCfMBt8bjHP
         +nRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783937570; x=1784542370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gQDcHMF91uNTbQRKUs7FtApfDoXRXDWv1xLDi776PsY=;
        b=Y7SzqYaJDatn8zryq/zN1o1BI3j2HpSMIbBzYaprzvZo4nRLaWUF4yahCVjxKUpYdv
         PzsSivCoI6bJVc/HR8ECC0FROXHirLbS5xaSjHUJhjcr3MzyFUWwG0KHMWXGfTmIOof6
         HeL5JJYVi/8p1rkWWZ9i31lh0NxbfU26vokzaknQ57kct5/Dm6RNGYnvhjL9jWMOZ3MI
         +GI8BXphjnZJPBNX9QM4KaRRsaTPuFa4ap6Qg8JCcLXDexaEiHxdwhhq/7MtAk5u3CmA
         0neqZQPOGrFJGwsBVZSS3TIruMd6ZDZTf8JOpPFiCey6YSGTkob+MoPRgBMZp2xlbb7X
         LBKQ==
X-Forwarded-Encrypted: i=1; AHgh+RrZLSG/CpNVBXJiScDkJh/NRNObAiKH23UWwPeL05mQ0EvLp0oriiWjWBkwUOmfknYZ9X+vvHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuZ6oaq7kh3oylWk7oconfuxjsXiSGWU+XkAd/wmMMYRPDHbNC
	+F1pkQmpiKeEsrWbx0deXLjt/a823lQf9nw+XcIV+ZCtq2Mgaq0Ra3E1j52fYGws2Es=
X-Gm-Gg: AfdE7cmIIiggtjxcBNfTSIigGFrc45G6jW79amuU+0l3mQQvRKhMweq7wg6yLC/oJKx
	jYwnD3WJoq0wbM6iWeVse7Y6esTQcPfHi/vpOdV3Iby7+N4J7OUXUnf6tirY4v1EZsqygghRUfB
	TD9wD4jveknamerKEuBY3OpSRYtd26XIQFbGDG8JXzUwxovlfTFw/ZEM5CWd0xF3aOt5TWMy4My
	7jrN7by+8681xhhN4useIL3IsB1mYrinxM9MQguRZXS5rXrf4+7yyyF1GlWQvkT6bYA0An9qQ4p
	a4GX+1P//VtCDrN2mguZTd37D0PIGnUMR1pDOE2hjz0hzLs0+1fnZYOxV+a0Ilu2lIDYW6Lubk6
	QL1cubUqnYSQWuBghB3O6i3IvQuOgPybFRz/FSvTNIsjpIiqHeGi6a5ItQl6w3H82je8lB5Jel6
	Gkl0fW4WmfGjnoyl9Z
X-Received: by 2002:a05:6000:381:b0:478:6c1:6e34 with SMTP id ffacd0b85a97d-47f2dcde775mr9944873f8f.13.1783937570185;
        Mon, 13 Jul 2026 03:12:50 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:1f19::319:116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960b06sm85081489f8f.28.2026.07.13.03.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 03:12:49 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
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
Subject: [PATCH] rcu-tasks: Defer IRQ-disabled callback enqueue to irq_work
Date: Mon, 13 Jul 2026 11:12:45 +0100
Message-ID: <20260713101245.3207634-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

call_rcu_tasks_generic() can be invoked with IRQs disabled, and on
older kernels this exposed an ABBA deadlock against the scheduler
runqueue lock via sched_ext's task-storage teardown path:

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

Tasks Trace has since moved to SRCU and no longer takes this path, but
Tasks and Tasks Rude still go through call_rcu_tasks_generic() and
remain exposed to lock-order inversions against any lock that may be
held with IRQs disabled by a caller.

Split the enqueue based on the caller's IRQ state. When IRQs are
disabled, push the callback onto a statically initialised per-CPU
lockless llist and schedule a hard irq_work to drain it into the
segmented callback list under the usual per-CPU lock outside the
caller's lock context. The drain is also invoked from
rcu_barrier_tasks_generic() and rcu_tasks_need_gpcb() so barriers
and grace-period progress cannot miss in-transit callbacks.
IRQ-enabled callers keep the existing direct-enqueue semantics.

Fixes: ab97152f88a4 ("rcu-tasks: Use more callback queues if contention encountered")
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20260710095359.2643791-1-matt@readmodwrite.com
Cc: stable@vger.kernel.org
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---

I have a separately tested 6.18.y backport and will submit it once this
change lands upstream.

---
 kernel/rcu/tasks.h | 186 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 149 insertions(+), 37 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f4da5fad70f5..e16d14b7b4df 100644
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
@@ -129,11 +133,15 @@ struct rcu_tasks {
 };
 
 static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
+static void call_rcu_tasks_iw_drain_irq_bypass(struct irq_work *iwp);
+static void rcu_tasks_adjust_cbs(struct rcu_tasks *rtp);
 
 #define DEFINE_RCU_TASKS(rt_name, gp, call, n)						\
 static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {			\
 	.lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name ## __percpu.cbs_pcpu_lock),		\
 	.rtp_irq_work = IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_wakeup),			\
+	.rtp_irq_bypass_work = IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_drain_irq_bypass), \
+	.rtp_irq_bypass_list = LLIST_HEAD_INIT(rtp_irq_bypass_list),			\
 };											\
 static struct rcu_tasks rt_name =							\
 {											\
@@ -328,6 +336,103 @@ static void call_rcu_tasks_generic_timer(struct timer_list *tlp)
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
+	needwake = (!havekthread && rcu_segcblist_empty(&rtpcp->cblist)) ||
+		   (rhp->func == wakeme_after_rcu) ||
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
@@ -338,15 +443,40 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
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
@@ -359,44 +489,23 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
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
-	needwake = (!havekthread && rcu_segcblist_empty(&rtpcp->cblist)) ||
-		   (func == wakeme_after_rcu) ||
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
@@ -438,6 +547,7 @@ static void __maybe_unused rcu_barrier_tasks_generic(struct rcu_tasks *rtp)
 		if (cpu >= smp_load_acquire(&rtp->percpu_dequeue_lim))
 			break;
 		rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
+		rcu_tasks_drain_irq_bypass(rtpcp);
 		rtpcp->barrier_q_head.func = rcu_barrier_tasks_generic_cb;
 		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 		if (rcu_segcblist_entrain(&rtpcp->cblist, &rtpcp->barrier_q_head))
@@ -470,6 +580,8 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 			continue;
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
+		rcu_tasks_drain_irq_bypass(rtpcp);
+
 		/* Advance and accelerate any new callbacks. */
 		if (!rcu_segcblist_n_cbs(&rtpcp->cblist))
 			continue;
-- 
2.43.0

