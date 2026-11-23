Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435501;
	b=lZhXGOL9FoUBtj6zmsNIBzJnaL+iH6DVV/LtmmETRrldCRarTr4EqupShNMazRu5Jmhv
	 8n0bbZELiKktnlCDWi32zdYjiw+IWpn3VMiXDPS3B64dkm+sFMSN6OqypMQ2tLRn9dl8w
	 uD6NjNEFwr47FMuX8UGSdhkWxCyv1O6FQS+EV++G3xYFBUMArRwgrOUQLoCKEqbH4BEzJ
	 uaRV2iHwkKjiaIe6B6J2Su2PXo1eHiSp3rOV/J7nNbBKkhvPcjycRw/RaTywnDO/jdfm9
	 CBSMWkUtw8LSSEwF0qL89Aps20Ggx+FAPfa7cxQPQDzkgaCPKRG8hrl/j12xnwrmnJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435501;
	h=Received:DKIM-Signature:Date:From:To:Cc:Message-ID:In-Reply-To:
	 References:Subject;
	bh=mqH7OKXaciQeHdxtYyYAmoEalgZtOU0hzW0YdVrk+I8=;
	b=J74pypXFpa45LMRgiRx5LLcwhvdne6nL9nfLjeEPcUTxpahSZPsJevWSkSYUolMkvMhP
	 1NM9i6ERFMiPr2/Gf5Tjt52tGJIMi8c2dbMn3ag2pEONji6oeYQtalDy2UkZ6/RT2ER/7
	 yoER4GktOGXRk4gJH8aGC+p/2c2ruoJFPWANI6xbsrt5NFLRrH2YEwaCM/PZJUe1HiEIN
	 NUVzTydtlpxwJZx6vgXaP6lLBgQ2j/S2DCakh7HX1FQBma00vl5IDuF7FB9ianXZvVVAx
	 uxJF/wWLnA1kifoIJA0MMfVz6Ao9wzCxsAwbvq3FYIXCM99mQvZhWWcVT5NQcT3A0FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DKSt6R77;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EEE606A31A;
	Mon, 23 Nov 2026 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DKSt6R77
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7291F000CF;
	Mon, 23 Nov 2026 12:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795435501;
	bh=mqH7OKXaciQeHdxtYyYAmoEalgZtOU0hzW0YdVrk+I8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=DKSt6R7790trB8iEkt3k3lJ2rVfcLGImK5nLRUDr/t7mxgnOtA7TP32/IO5xilqdC
	 eERcz8Vx10xrw2Bi/iZnPr2r6uPm0LiKOFx3kDZi2x6tcAk6zTBiEV7A+5Lv6Fg/iC
	 fi2wVXcQHosjqQ21caknU3eFij5ENBIufc4s4AQk7PIUXzbg4KafMha+hPl9qvbsrx
	 sqWysJhCFCOxlabrq+l8GcLtHbxvyyTvOxMzLKMOvG5slKihbBHVCZcF4ij2GXqhAJ
	 Su9aikgvlEbW5RyRsBzBR0wt6d6ZV2KaAND+4PhJ1SqgyQ5kXGnrszw40Us9nx7nMd
	 wWHJS2JGnwaeA==
Date: Mon, 23 Nov 2026 02:05:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Breno Leitao <leitao@debian.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-ID: <20261123120125.375076-1-tj@kernel.org>
In-Reply-To: <CAHk-=wjm3vbiNYsR+aHxmM3KCEgsSWb379ZQbCuZEsN1dhvbKg@mail.gmail.com>
References: <fb224bad9baf5f44cf17e1d664776a4e@kernel.org>
 <CAHk-=wg4jAWZvxWo0OZ+fFTU=SBtQ7dnsUCV7hx+UAifkwPUwQ@mail.gmail.com>
 <avs4uWg9ch-Bqobj@slm.duckdns.org>
 <CAHk-=wg+MO19H7KVgA+SaZvvt5O+3Tp8AxHVhpN23JtaSq=G4g@mail.gmail.com>
 <CAHk-=wjm3vbiNYsR+aHxmM3KCEgsSWb379ZQbCuZEsN1dhvbKg@mail.gmail.com>
Subject: [PATCH wq/for-7.4-fixes] workqueue: Fix drain_workqueue() missing work items chained across pwqs
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

From: Linus Torvalds <torvalds@linux-foundation.org>

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

Add pwq->nr_started, which counts the work items a pwq has started
executing, and check the pwqs twice after each flush. The drain is complete
only if both passes find every pwq empty and no work item started in
between. The counter is updated and read under pool->lock, and the queueing
path is not touched.

Verified with reproducers of both shapes: self-requeueing work items on an
unbound workqueue and chained queue_work_on() of another work item on a
per-cpu workqueue.

Fixes: c8efcc258946 ("workqueue: allow chained queueing during destruction")
Cc: stable@vger.kernel.org # v2.6.38+
Link: https://lore.kernel.org/all/CAHk-=wjm3vbiNYsR+aHxmM3KCEgsSWb379ZQbCuZEsN1dhvbKg@mail.gmail.com/
[ tj: Wrote the description and updated the pwqs_nr_started() comment. ]
Signed-off-by: Tejun Heo <tj@kernel.org>
---
Applied to wq/for-7.4-fixes, replacing c7d64f52bffa ("workqueue: Fix
drain_workqueue() missing work items chained across pwqs") from the pull
request.

 kernel/workqueue.c | 51 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f2e8071a6f4e..08046ff0d697 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -281,6 +281,7 @@ struct pool_workqueue {
 	int			total_in_flight; /* L: sum of nr_in_flight[] */
 	int			nr_in_flight[WORK_NR_COLORS];
 						/* L: nr of in_flight works */
+	unsigned long		nr_started;	/* L: see drain_workqueue() */
 	struct list_head	flush_node;	/* FN: node on wq_flush_pnode->pwqs */
 	bool			plugged;	/* L: execution suspended */
 
@@ -3455,6 +3456,7 @@ __acquires(&pool->lock)
 	 */
 	set_work_pool_and_clear_pending(work, pool->id, pool_offq_flags(pool));
 
+	pwq->nr_started++;
 	pwq->stats[PWQ_STAT_STARTED]++;
 
 	rcu_read_lock();
@@ -4449,6 +4451,33 @@ void __flush_workqueue(struct workqueue_struct *wq)
 }
 EXPORT_SYMBOL(__flush_workqueue);
 
+/*
+ * Return 0 if any pwq of @wq is busy. Otherwise, return the sum of nr_started
+ * of all pwqs encoded as 2 * sum + 1, which is always odd, so that 0 can only
+ * mean busy.
+ */
+static unsigned long pwqs_nr_started(struct workqueue_struct *wq)
+{
+	struct pool_workqueue *pwq;
+	unsigned long sum = 0;
+
+	lockdep_assert_held(&wq->mutex);
+
+	for_each_pwq(pwq, wq) {
+		bool empty;
+
+		raw_spin_lock_irq(&pwq->pool->lock);
+		empty = pwq_is_empty(pwq);
+		sum += pwq->nr_started;
+		raw_spin_unlock_irq(&pwq->pool->lock);
+
+		if (!empty)
+			return 0;
+	}
+
+	return 2 * sum + 1;
+}
+
 /**
  * drain_workqueue - drain a workqueue
  * @wq: workqueue to drain
@@ -4462,8 +4491,8 @@ EXPORT_SYMBOL(__flush_workqueue);
  */
 void drain_workqueue(struct workqueue_struct *wq)
 {
+	unsigned long started;
 	unsigned int flush_cnt = 0;
-	struct pool_workqueue *pwq;
 
 	/*
 	 * __queue_work() needs to test whether there are drainers, is much
@@ -4479,16 +4508,16 @@ void drain_workqueue(struct workqueue_struct *wq)
 
 	mutex_lock(&wq->mutex);
 
-	for_each_pwq(pwq, wq) {
-		bool drained;
-
-		raw_spin_lock_irq(&pwq->pool->lock);
-		drained = pwq_is_empty(pwq);
-		raw_spin_unlock_irq(&pwq->pool->lock);
-
-		if (drained)
-			continue;
-
+	/*
+	 * A pass isn't atomic across pwqs, so a chained work item can land on
+	 * a pwq it already found empty. Anything slipping past the second pass
+	 * needs a work item that was in flight at its pwq's first check, or
+	 * that started between its pwq's two checks. The first makes the first
+	 * pass fail, the second changes nr_started. wq->mutex keeps the set of
+	 * pwqs stable across both passes.
+	 */
+	started = pwqs_nr_started(wq);
+	if (!started || pwqs_nr_started(wq) != started) {
 		if (++flush_cnt == 10 ||
 		    (flush_cnt % 100 == 0 && flush_cnt <= 1000))
 			pr_warn("workqueue %s: %s() isn't complete after %u tries\n",
-- 
2.56.1

