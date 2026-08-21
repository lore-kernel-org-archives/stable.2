Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8761F30D407
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313569; cv=none; b=JTM2Z456CjiEsbGuZmHGFUxksn6nOy7MwtUZjVqVcy2yTfX1OzbetwpAkzibIxy9Pa+xHLMpxE2iGeO1SRQ2YlReBaI/ezdRePrP09ULQ00up2WIFFY+quUa/A49Emj3Ulmk8nWGh3+wyeQ7FPLXi2jXkVr6iZcCDpyYtz9wuxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313569; c=relaxed/simple;
	bh=JSg3/Azt7phnjbIiq+JJGiUiPr6JZ4M0ueuETB5Eg0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z1i3od8DZVbkzz03OUN/KtvSZAYi9MQaEpr1dXVIE7q/rYnF4FqFt2uFR5Q0qm5RuvsY2RJ9uNipBxNm+9ILq1F4I+r9DlbfhAMuQiRaEc7ULGh8RteYuaQDi5XrIfBXRW6ZgXmYm2iJzuuOERX8pB1LrJ2sYBhWhHtXeZx1h88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=bHsNwskp; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="bHsNwskp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1787313145;
	bh=JSg3/Azt7phnjbIiq+JJGiUiPr6JZ4M0ueuETB5Eg0M=;
	h=From:To:Cc:Subject:Date:From;
	b=bHsNwskpGZJNUqGm5OGd0RAzOcS/lTO/AUJHz+aY/hAnEZ4xMDhaoXXlwWlun4PB3
	 z4bvYzGSbaB4f9tfVph8sSwtvA0yiPd1SBSi8rv8NnyNk4X7/ld37Dhh9x45FAu305
	 pSuMo+pWnKX7LZRsTaLs7tr1r/Rom0t8wcCDlBe0JQXKUD2Ip7Rrqj8TfLVG6tkbL1
	 B7wugSlCNLHP3juxAxsAv8Xh4MxpAA5Awce31gNKWKCX65uCCp/a/p0ruFfvR8NkHJ
	 1ErmEu86W5GkfMgSn8+d0n1h7MTDHHLbsG/w4KVHGkHlHTVvbZZNg7+8U/MndFOPYv
	 laTxsIwASKIuA==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org
Cc: Maarten Lankhorst <dev@lankhorst.se>,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/gt: Use signalers_lock to prevent starvation of irq_work.
Date: Fri, 21 Aug 2026 13:45:08 +0200
Message-ID: <20260821114508.25669-1-dev@lankhorst.se>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IRQ-Work (FIFO-1) will be preempted by the threaded-interrupt (FIFO-50)
and the interrupt will poll on signaler_active while the irq-work can't
make progress.

Solve this by adding a global spinlock to prevent starvation and force
completion.

The existing RCU handling gets in the way on PREEMPT_RT, and would likely
require conversion to raw spinlock to take them inside a
rcu_read_lock(), so remove RCU as well.

This also fixes a case where we dereference the context after freeing
it, as reported by Shuangpeng Bai:

"The existing RCU loop removes rq from ce->signals and may then call
i915_request_put(rq). If that is the final reference, the request can be
released and its SLAB_TYPESAFE_BY_RCU slot reused before
list_for_each_entry_rcu() advances and reads rq->signal_link.next. The
RCU read-side critical section does not provide a stable reference to the
same request object in this cache.

The v4 conversion to signalers_lock/ce->signal_lock and the
list_first_entry_or_null() loop removes this post-put dereference, so it
also covers this UAF path.

This is independent of the PREEMPT_RT irq_work starvation trigger. I can
reach the sequence in a diagnostic run, although KASAN does not reliably
report it because i915_request uses a SLAB_TYPESAFE_BY_RCU cache.

Since this also removes a request lifetime UAF from the common signaling
path, it may be worth considering the relevant fix for stable kernels once
the series is accepted."

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Fixes: c744d50363b7 ("drm/i915/gt: Split the breadcrumb spinlock between global and contexts")
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: <stable@vger.kernel.org> # v5.12+
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c   | 172 +++++++++++-------
 .../gpu/drm/i915/gt/intel_breadcrumbs_types.h |   1 -
 drivers/gpu/drm/i915/gt/intel_context.c       |   1 +
 3 files changed, 112 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
index c10ac0ab3bfa8..0ae7759dc74a3 100644
--- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
@@ -88,24 +88,25 @@ static void add_signaling_context(struct intel_breadcrumbs *b,
 				  struct intel_context *ce)
 {
 	lockdep_assert_held(&ce->signal_lock);
+	lockdep_assert_held(&b->signalers_lock);
 
-	spin_lock(&b->signalers_lock);
-	list_add_rcu(&ce->signal_link, &b->signalers);
-	spin_unlock(&b->signalers_lock);
+	if (list_empty(&ce->signals))
+		return;
+
+	intel_context_get(ce);
+	list_add(&ce->signal_link, &b->signalers);
 }
 
 static bool remove_signaling_context(struct intel_breadcrumbs *b,
 				     struct intel_context *ce)
 {
 	lockdep_assert_held(&ce->signal_lock);
+	lockdep_assert_held(&b->signalers_lock);
 
-	if (!list_empty(&ce->signals))
+	if (!list_empty(&ce->signals) || list_empty(&ce->signal_link))
 		return false;
 
-	spin_lock(&b->signalers_lock);
-	list_del_rcu(&ce->signal_link);
-	spin_unlock(&b->signalers_lock);
-
+	list_del_init(&ce->signal_link);
 	return true;
 }
 
@@ -174,7 +175,7 @@ static void signal_irq_work(struct irq_work *work)
 	struct intel_breadcrumbs *b = container_of(work, typeof(*b), irq_work);
 	const ktime_t timestamp = ktime_get();
 	struct llist_node *signal, *sn;
-	struct intel_context *ce;
+	struct intel_context *ce, *next;
 
 	signal = NULL;
 	if (unlikely(!llist_empty(&b->signaled_requests)))
@@ -208,13 +209,13 @@ static void signal_irq_work(struct irq_work *work)
 	if (!signal && READ_ONCE(b->irq_armed) && list_empty(&b->signalers))
 		intel_breadcrumbs_disarm_irq(b);
 
-	rcu_read_lock();
-	atomic_inc(&b->signaler_active);
-	list_for_each_entry_rcu(ce, &b->signalers, signal_link) {
+	spin_lock(&b->signalers_lock);
+	list_for_each_entry_safe(ce, next, &b->signalers, signal_link) {
 		struct i915_request *rq;
+		bool release;
 
-		list_for_each_entry_rcu(rq, &ce->signals, signal_link) {
-			bool release;
+		spin_lock(&ce->signal_lock);
+		while ((rq = list_first_entry_or_null(&ce->signals, typeof(*rq), signal_link))) {
 
 			if (!__i915_request_is_complete(rq))
 				break;
@@ -228,15 +229,9 @@ static void signal_irq_work(struct irq_work *work)
 			 * spinlock as the callback chain may end up adding
 			 * more signalers to the same context or engine.
 			 */
-			spin_lock(&ce->signal_lock);
-			list_del_rcu(&rq->signal_link);
-			release = remove_signaling_context(b, ce);
-			spin_unlock(&ce->signal_lock);
-			if (release) {
-				if (intel_timeline_is_last(ce->timeline, rq))
-					add_retire(b, ce->timeline);
-				intel_context_put(ce);
-			}
+			list_del(&rq->signal_link);
+			if (list_empty(&ce->signals) && intel_timeline_is_last(ce->timeline, rq))
+				add_retire(b, ce->timeline);
 
 			if (__dma_fence_signal(&rq->fence))
 				/* We own signal_node now, xfer to local list */
@@ -244,9 +239,13 @@ static void signal_irq_work(struct irq_work *work)
 			else
 				i915_request_put(rq);
 		}
+
+		release = remove_signaling_context(b, ce);
+		spin_unlock(&ce->signal_lock);
+		if (release)
+			intel_context_put(ce);
 	}
-	atomic_dec(&b->signaler_active);
-	rcu_read_unlock();
+	spin_unlock(&b->signalers_lock);
 
 	llist_for_each_safe(signal, sn, signal) {
 		struct i915_request *rq =
@@ -347,14 +346,15 @@ static void irq_signal_request(struct i915_request *rq,
 		irq_work_queue(&b->irq_work);
 }
 
-static void insert_breadcrumb(struct i915_request *rq)
+static bool insert_breadcrumb(struct i915_request *rq,
+			      struct intel_breadcrumbs *b)
 {
-	struct intel_breadcrumbs *b = READ_ONCE(rq->engine)->breadcrumbs;
 	struct intel_context *ce = rq->context;
 	struct list_head *pos;
+	bool ret;
 
 	if (test_bit(I915_FENCE_FLAG_SIGNAL, &rq->fence.flags))
-		return;
+		return false;
 
 	/*
 	 * If the request is already completed, we can transfer it
@@ -363,14 +363,15 @@ static void insert_breadcrumb(struct i915_request *rq)
 	 */
 	if (__i915_request_is_complete(rq)) {
 		irq_signal_request(rq, b);
-		return;
+		return false;
 	}
 
 	if (list_empty(&ce->signals)) {
-		intel_context_get(ce);
-		add_signaling_context(b, ce);
+		ret = true;
 		pos = &ce->signals;
 	} else {
+		ret = false;
+
 		/*
 		 * We keep the seqno in retirement order, so we can break
 		 * inside intel_engine_signal_breadcrumbs as soon as we've
@@ -395,23 +396,19 @@ static void insert_breadcrumb(struct i915_request *rq)
 	}
 
 	i915_request_get(rq);
-	list_add_rcu(&rq->signal_link, pos);
+	list_add(&rq->signal_link, pos);
 	GEM_BUG_ON(!check_signal_order(ce, rq));
 	GEM_BUG_ON(test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &rq->fence.flags));
 	set_bit(I915_FENCE_FLAG_SIGNAL, &rq->fence.flags);
 
-	/*
-	 * Defer enabling the interrupt to after HW submission and recheck
-	 * the request as it may have completed and raised the interrupt as
-	 * we were attaching it into the lists.
-	 */
-	if (!READ_ONCE(b->irq_armed) || __i915_request_is_complete(rq))
-		irq_work_queue(&b->irq_work);
+	return ret;
 }
 
 bool i915_request_enable_breadcrumb(struct i915_request *rq)
 {
 	struct intel_context *ce = rq->context;
+	struct intel_breadcrumbs *b;
+	bool add_context = false;
 
 	/* Serialises with i915_request_retire() using rq->lock */
 	if (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &rq->fence.flags))
@@ -427,30 +424,87 @@ bool i915_request_enable_breadcrumb(struct i915_request *rq)
 		return true;
 
 	spin_lock(&ce->signal_lock);
+	b = READ_ONCE(rq->engine)->breadcrumbs;
+
 	if (test_bit(I915_FENCE_FLAG_ACTIVE, &rq->fence.flags))
-		insert_breadcrumb(rq);
+		add_context = insert_breadcrumb(rq, b);
+
+	if (add_context && spin_trylock(&b->signalers_lock)) {
+		add_signaling_context(b, ce);
+		spin_unlock(&b->signalers_lock);
+		add_context = false;
+	}
 	spin_unlock(&ce->signal_lock);
 
+	if (add_context) {
+		/*
+		 * Fast trylock didn't work, use slow locking.
+		 *
+		 * Dropping the lock to solve the inversion is safe, since
+		 * no race is possible against remove_signaling_context()
+		 * without being added as signaling context.
+		 */
+		spin_lock(&b->signalers_lock);
+		spin_lock(&ce->signal_lock);
+		add_signaling_context(b, ce);
+		spin_unlock(&ce->signal_lock);
+		spin_unlock(&b->signalers_lock);
+	}
+
+	/*
+	 * Defer enabling the interrupt to after HW submission and recheck
+	 * the request as it may have completed and raised the interrupt as
+	 * we were attaching it into the lists.
+	 */
+	if (!READ_ONCE(b->irq_armed) || __i915_request_is_complete(rq))
+		irq_work_queue(&b->irq_work);
+
 	return true;
 }
 
+
+static void unlock_context_remove_signaling(struct intel_context *ce,
+					    struct intel_breadcrumbs *b,
+					    unsigned long flags)
+{
+	bool release = false, retry = false;
+
+	if (list_empty(&ce->signals)) {
+		if (spin_trylock(&b->signalers_lock)) {
+			release = remove_signaling_context(b, ce);
+			spin_unlock(&b->signalers_lock);
+		} else {
+			retry = true;
+		}
+	}
+	spin_unlock_irqrestore(&ce->signal_lock, flags);
+
+	if (retry) {
+		spin_lock_irqsave(&b->signalers_lock, flags);
+		spin_lock(&ce->signal_lock);
+		release = remove_signaling_context(b, ce);
+		spin_unlock(&ce->signal_lock);
+		spin_unlock_irqrestore(&b->signalers_lock, flags);
+	}
+
+	if (release)
+		intel_context_put(ce);
+}
+
 void i915_request_cancel_breadcrumb(struct i915_request *rq)
 {
 	struct intel_breadcrumbs *b = READ_ONCE(rq->engine)->breadcrumbs;
 	struct intel_context *ce = rq->context;
-	bool release;
+	unsigned long flags;
 
-	spin_lock(&ce->signal_lock);
+	spin_lock_irqsave(&ce->signal_lock, flags);
 	if (!test_and_clear_bit(I915_FENCE_FLAG_SIGNAL, &rq->fence.flags)) {
-		spin_unlock(&ce->signal_lock);
+		spin_unlock_irqrestore(&ce->signal_lock, flags);
 		return;
 	}
 
-	list_del_rcu(&rq->signal_link);
-	release = remove_signaling_context(b, ce);
-	spin_unlock(&ce->signal_lock);
-	if (release)
-		intel_context_put(ce);
+	list_del(&rq->signal_link);
+	unlock_context_remove_signaling(ce, b, flags);
 
 	if (__i915_request_is_complete(rq))
 		irq_signal_request(rq, b);
@@ -462,7 +516,6 @@ void intel_context_remove_breadcrumbs(struct intel_context *ce,
 				      struct intel_breadcrumbs *b)
 {
 	struct i915_request *rq, *rn;
-	bool release = false;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ce->signal_lock, flags);
@@ -476,39 +529,36 @@ void intel_context_remove_breadcrumbs(struct intel_context *ce,
 					&rq->fence.flags))
 			continue;
 
-		list_del_rcu(&rq->signal_link);
+		list_del(&rq->signal_link);
 		irq_signal_request(rq, b);
 		i915_request_put(rq);
 	}
-	release = remove_signaling_context(b, ce);
 
 unlock:
-	spin_unlock_irqrestore(&ce->signal_lock, flags);
-	if (release)
-		intel_context_put(ce);
-
-	while (atomic_read(&b->signaler_active))
-		cpu_relax();
+	unlock_context_remove_signaling(ce, b, flags);
 }
 
 static void print_signals(struct intel_breadcrumbs *b, struct drm_printer *p)
 {
 	struct intel_context *ce;
 	struct i915_request *rq;
+	unsigned long flags;
 
 	drm_printf(p, "Signals:\n");
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(ce, &b->signalers, signal_link) {
-		list_for_each_entry_rcu(rq, &ce->signals, signal_link)
+	spin_lock_irqsave(&b->signalers_lock, flags);
+	list_for_each_entry(ce, &b->signalers, signal_link) {
+		spin_lock(&ce->signal_lock);
+		list_for_each_entry(rq, &ce->signals, signal_link)
 			drm_printf(p, "\t[%llx:%llx%s] @ %dms\n",
 				   rq->fence.context, rq->fence.seqno,
 				   __i915_request_is_complete(rq) ? "!" :
 				   __i915_request_has_started(rq) ? "*" :
 				   "",
 				   jiffies_to_msecs(jiffies - rq->emitted_jiffies));
+		spin_unlock(&ce->signal_lock);
 	}
-	rcu_read_unlock();
+	spin_unlock_irqrestore(&b->signalers_lock, flags);
 }
 
 void intel_engine_print_breadcrumbs(struct intel_engine_cs *engine,
diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs_types.h b/drivers/gpu/drm/i915/gt/intel_breadcrumbs_types.h
index bdf09fd67b6e7..648e5600587b4 100644
--- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs_types.h
@@ -39,7 +39,6 @@ struct intel_breadcrumbs {
 	spinlock_t signalers_lock; /* protects the list of signalers */
 	struct list_head signalers;
 	struct llist_head signaled_requests;
-	atomic_t signaler_active;
 
 	spinlock_t irq_lock; /* protects the interrupt from hardirq context */
 	struct irq_work irq_work; /* for use from inside irq_lock */
diff --git a/drivers/gpu/drm/i915/gt/intel_context.c b/drivers/gpu/drm/i915/gt/intel_context.c
index b1b8695ba7c97..b938ff5be7b80 100644
--- a/drivers/gpu/drm/i915/gt/intel_context.c
+++ b/drivers/gpu/drm/i915/gt/intel_context.c
@@ -409,6 +409,7 @@ intel_context_init(struct intel_context *ce, struct intel_engine_cs *engine)
 	/* NB ce->signal_link/lock is used under RCU */
 	spin_lock_init(&ce->signal_lock);
 	INIT_LIST_HEAD(&ce->signals);
+	INIT_LIST_HEAD(&ce->signal_link);
 
 	mutex_init(&ce->pin_mutex);
 
-- 
2.55.0

