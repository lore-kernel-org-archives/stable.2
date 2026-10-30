Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378532;
	b=KCoSjZG1LIg6ANp7d7OpnBmuiGahAR3Ve8/lGfDqh/o/bstrQXdvIWoPbFLLaaPihl4t
	 3ANBwCSR161uhxTFG3KebzBRJ/q1PpnMSIyGWAbhoIfZAWb6jfn7aKIEuW/syXDOCIWER
	 tZVt3Ts9vgNpX13ufF+pyL/+Ro/brZmeMS+IHRfLAizeIktQ5ReRSYq2+yc9sSsCiju/W
	 2V/jIEHh3nL6WSu+mGlfSxkaYF5Ibu7nNi5be520zbFpA8oNuPWDNV51wqrclJq/M8XGp
	 EY4I22KvzhkvOCPs1vVIpUClFyEbSN+5xcSZqGFkApit4u6Wqy84+5ks6FeyIkvW0Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378532;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EDOt2CyO7Y0XuK7dg+yAlTQVBFn3g9zwKwOPs+uHpIc=;
	b=odgNlUSJcbQ31o/ZsyllTu6Yp/NawfvWcTYi49s8UwTvVQ0ReF64dslBai5AVtA8dUBb
	 HcTL1hsDy0CgrjM4WROlHSY09zMSaW1yA4iNSEQRZAS/R3U6LPqPPLocFGYbG0dg5VQzx
	 Q3qIhi0kv5a+LFBvnyOjQeS19JhnY9WePMZWm0Yb9Grq1Ppau0wehUMVWTNhVgOok3460
	 1VWobbQOEklGZWRf3N7zfegmAH8LX9cGl0aSdSigzuDsLq8ixSIHUofoV+0AT2SdZQNQS
	 mWIMW2TXf47JO46hosveARNVelgGv8yLQB3+rxuGJ12AxYJQCw33C0oHHQfdZUBUBXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BtLCzOyE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B0E606A31A;
	Fri, 30 Oct 2026 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BtLCzOyE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24E41F000C1;
	Fri, 30 Oct 2026 16:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793378532;
	bh=EDOt2CyO7Y0XuK7dg+yAlTQVBFn3g9zwKwOPs+uHpIc=;
	h=From:To:Cc:Subject:Date;
	b=BtLCzOyEjLTIJGf/OMYjbmmoJLRRdONTxBSw4WaUTC2Zau65RyZvHYNjybPaKwGQ3
	 0Oc+nEUPaawRWhkOflr0HA8ZSazdamTKVzHOHYeBLoB5KMtjG+F+w1gnLVcDmCvhOc
	 ZCQ/SuIvj4fd0J6mEiLKJLkmO5ng7UOoEm1O2CulEDmiDxLG3wb3y4KClGGvenmYcf
	 GyGS+/q+VrIgf4jIxW+WlBJLaldS7Wb6XVW8pjkUeNfkkF2SA8J5rmPowY1YajM2dJ
	 8B58FL2pD/Q4PKnZJFEeYSjgZWb0EDwOTIWWqxG/tw/mc2rBgDQLLH5FwPE8itDutD
	 n2ToMsm9GuLgQ==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH wq/for-7.4-fixes] workqueue: Fix drain_workqueue() missing work items chained across pwqs
Date: Fri, 30 Oct 2026 06:42:10 -1000
Message-ID: <20261030164210.3735018-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
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

drain_workqueue() flushes the workqueue, then checks each pwq under its
pool's lock and returns once a pass finds every pwq empty. Only chained
queueing is allowed meanwhile, and a chained work item can land on a pwq
other than the one the queueing work item is executing on. The pass misses
it when:

1. The pass finds pwq A empty.
2. A work item executing on pwq B queues a work item on pwq A.
3. The work item on pwq B finishes.
4. The pass finds pwq B empty.

drain_workqueue() returns with the work item on pwq A pending, and
destroy_workqueue() can then trip WARN_ON(pwq_busy()) and leak the
workqueue.

Add wq->drain_seq, which counts chained queueings while the workqueue is
draining. drain_workqueue() reads it before each flush and retries if it
changed by the end of the check pass. Flushing once more after an empty pass
is not enough, as a longer chain is missed the same way.

Verified with reproducers of both shapes: self-requeueing work items on an
unbound workqueue and chained queue_work_on() of another work item on a
per-cpu workqueue.

Fixes: c8efcc258946 ("workqueue: allow chained queueing during destruction")
Cc: stable@vger.kernel.org # v2.6.38+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 68 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f2e8071a6f4e..955bf021f042 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -386,6 +386,7 @@ struct workqueue_struct {
 	struct worker		*rescuer;	/* MD: rescue worker */
 
 	int			nr_drainers;	/* WQ: drain in progress */
+	atomic_t		drain_seq;	/* see drain_workqueue() */
 
 	/* See alloc_workqueue() function comment for info on min/max_active */
 	int			max_active;	/* WO: max active works */
@@ -2432,22 +2433,31 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	 * allowed. The __WQ_DESTROYING helps to spot the issue that
 	 * queues a new work item to a wq after destroy_workqueue(wq).
 	 */
-	if (unlikely(wq->flags & (__WQ_DESTROYING | __WQ_DRAINING) &&
-		     WARN_ONCE(!is_chained_work(wq), "workqueue: cannot queue %ps on wq %s\n",
-			       work->func, wq->name))) {
-		struct work_offq_data offqd;
+	if (unlikely(wq->flags & (__WQ_DESTROYING | __WQ_DRAINING))) {
+		if (WARN_ONCE(!is_chained_work(wq), "workqueue: cannot queue %ps on wq %s\n",
+			      work->func, wq->name)) {
+			struct work_offq_data offqd;
+
+			/*
+			 * State on entry: PENDING is set, work is off-queue (no
+			 * insert_work() has run).
+			 *
+			 * Returning without clearing PENDING would leave the
+			 * work in a weird state (PENDING=1, PWQ=0, entry empty)
+			 */
+			work_offqd_unpack(&offqd, *work_data_bits(work));
+			set_work_pool_and_clear_pending(work, offqd.pool_id,
+							work_offqd_pack_flags(&offqd));
+			return;
+		}
 
 		/*
-		 * State on entry: PENDING is set, work is off-queue (no
-		 * insert_work() has run).
-		 *
-		 * Returning without clearing PENDING would leave the work
-		 * in a weird state (PENDING=1, PWQ=0, entry empty)
+		 * Pairs with the two smp_mb()s in drain_workqueue(), which
+		 * retries its check pass if @wq->drain_seq changed.
 		 */
-		work_offqd_unpack(&offqd, *work_data_bits(work));
-		set_work_pool_and_clear_pending(work, offqd.pool_id,
-						work_offqd_pack_flags(&offqd));
-		return;
+		smp_mb__before_atomic();
+		atomic_inc(&wq->drain_seq);
+		smp_mb__after_atomic();
 	}
 	rcu_read_lock();
 retry:
@@ -4464,6 +4474,8 @@ void drain_workqueue(struct workqueue_struct *wq)
 {
 	unsigned int flush_cnt = 0;
 	struct pool_workqueue *pwq;
+	bool drained;
+	int seq;
 
 	/*
 	 * __queue_work() needs to test whether there are drainers, is much
@@ -4474,21 +4486,42 @@ void drain_workqueue(struct workqueue_struct *wq)
 	if (!wq->nr_drainers++)
 		wq->flags |= __WQ_DRAINING;
 	mutex_unlock(&wq->mutex);
+
+	/*
+	 * A chained work item can land on a pwq the check pass below has
+	 * already found empty. __queue_work() counts chained queueings in
+	 * @wq->drain_seq. Retry if it changed across the flush and the pass.
+	 */
 reflush:
+	seq = atomic_read(&wq->drain_seq);
+
+	/*
+	 * Pairs with smp_mb__before_atomic() in __queue_work(). For each
+	 * chained queueing, either the read above doesn't see its increment or
+	 * the flush sees the queueing work item and waits for it.
+	 */
+	smp_mb();
 	__flush_workqueue(wq);
 
 	mutex_lock(&wq->mutex);
 
+	drained = true;
 	for_each_pwq(pwq, wq) {
-		bool drained;
-
 		raw_spin_lock_irq(&pwq->pool->lock);
 		drained = pwq_is_empty(pwq);
 		raw_spin_unlock_irq(&pwq->pool->lock);
 
-		if (drained)
-			continue;
+		if (!drained)
+			break;
+	}
 
+	/*
+	 * Pairs with smp_mb__after_atomic() in __queue_work(). For the earliest
+	 * queueing the pass missed, either the pass sees the queueing work item
+	 * in flight or the read below sees its increment.
+	 */
+	smp_mb();
+	if (!drained || atomic_read(&wq->drain_seq) != seq) {
 		if (++flush_cnt == 10 ||
 		    (flush_cnt % 100 == 0 && flush_cnt <= 1000))
 			pr_warn("workqueue %s: %s() isn't complete after %u tries\n",
@@ -6179,6 +6212,7 @@ static struct workqueue_struct *__alloc_workqueue(const char *fmt,
 	wq->saved_max_active = max_active;
 	mutex_init(&wq->mutex);
 	atomic_set(&wq->nr_pwqs_to_flush, 0);
+	atomic_set(&wq->drain_seq, 0);
 	INIT_LIST_HEAD(&wq->pwqs);
 	INIT_LIST_HEAD(&wq->flusher_queue);
 	INIT_LIST_HEAD(&wq->flusher_overflow);
-- 
2.56.0

