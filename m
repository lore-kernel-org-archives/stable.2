Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603026;
	b=pWz7QVUDO58JDpD0JGrOF9KF1JHLkVzM5tvPvGxzGzk/JHrWeK6SN/rbLFEvZIvuwKND
	 zsBsDYRD5JrNcV9i4mWD+kRrgRs/+8A4R6y5iKQ0/KYQp98+JlSf34jC/rkfPM9l5zo80
	 KVpjpKTnW3NhMg7COif8gMjnRYxu3ctJld8/lBMkrEMwzleB/L83fmtUW8GNEXbj1h8jT
	 pRzW3E6Mzs7qMFNQwWc0ROX22iPlTOnY9LPylNAw3dv1rp64STKCAFzHBOd3JmhbakAUZ
	 VJxs0txm2x3SfmdGBdby6u69K2RlxAkGFPKREo7VV5zhO4+1+JRmM1rLQYLCYG1vM9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603026;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EC9AWEmzdb3mx7GaYBkj8L9Od51WTDKFfuLwDBATqm4=;
	b=dxQ9Z8M5YYWRK7r4rEvD0AMS5d+bJzLPyodBAM3RGRfJqwK2J+QkIgkDlyXfdYKialVs
	 bPvv6gFYXuxVi/SbJxCe5/SlQozlarwJ5k2uTucXuqnKFuVVv1Cq4tvTw7C6hODCihXL6
	 bh5WuwRCNymoqbHSwCNfiypZJSGZFjIiZw+0jTU0+Q6Z95PwRMDuPwWQ1JyrpCuxbZujk
	 qzRZCSVqS4ieyoaZEiV/K43ftCJQ/cufYwOmrUtAZL8LkHQq6VgRKPQEZWIQVoBLV4LHq
	 4oNM+1d76uXdQa01H559A94h5mmsefAjy6mVsPNPrCeF96I2xX/ri/1Kjf2X8n54FuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=SVLRgMmT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD63C606A32E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=SVLRgMmT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AD11F000D3;
	Wed, 25 Nov 2026 10:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603026;
	bh=EC9AWEmzdb3mx7GaYBkj8L9Od51WTDKFfuLwDBATqm4=;
	h=Subject:To:Cc:From:Date;
	b=SVLRgMmTBgXHQM5KPmoN9LJ/sF5l/801V156riJM6eeinZ+GT8YqC2Qrr17uBGU/y
	 7nuDDmS5FVIzN3rcPfVXyeGtanBn7yU5tZqWKHyj7ds6JU3E/i5sEqH7fN+Y8ZovGe
	 tFqpHHYb3/5cf9k3VGx4gr3cSQn4frTiis/l+jJc=
Subject: FAILED: patch "[PATCH] sched_ext: Factor out drain_offline_rq()" failed to apply to 6.18-stable tree
To: tj@kernel.org,arighi@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:22:17 +0100
Message-ID: <2026112517-energy-proven-d70f@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1826e5aa068cf6c21791773f160b4a2ce5d5f9a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112517-energy-proven-d70f@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1826e5aa068cf6c21791773f160b4a2ce5d5f9a5 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Sat, 31 Oct 2026 07:05:40 -1000
Subject: [PATCH] sched_ext: Factor out drain_offline_rq()

Factor drain_offline_rq() out of rq_offline_scx() so that the drain can move
to handle_hotplug() in the following patch, which removes the rq_online and
rq_offline hooks. The drain is the rescue flush and the re-enqueue of an
offline cpu's tasks onto its local DSQ. No functional change.

Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e533c1a5c56d..0d64253569e8 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2428,7 +2428,7 @@ static void set_task_runnable(struct rq *rq, struct task_struct *p)
 	}
 
 	/*
-	 * list_add_tail() must be used. scx_bypass() and rq_offline_scx()
+	 * list_add_tail() must be used. scx_bypass() and drain_offline_rq()
 	 * depend on tasks being appended to the runnable_list.
 	 */
 	list_add_tail(&p->scx.runnable_node, &rq->scx.runnable_list);
@@ -4314,6 +4314,24 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 		scx_call_op_set_cpumask(sch, task_rq(p), p, (struct cpumask *)p->cpus_ptr);
 }
 
+static void drain_offline_rq(struct rq *rq)
+{
+	struct task_struct *p, *n;
+
+	scx_rescue_flush(rq);
+
+	/*
+	 * An offline CPU no longer calls ops.dispatch(). Re-enqueue its tasks
+	 * onto the local DSQ so that they run here and balance_push() moves
+	 * them off.
+	 */
+	list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list, scx.runnable_node) {
+		if (p->scx.dsq == &rq->scx.local_dsq)
+			continue;
+		guard(sched_change)(p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK);
+	}
+}
+
 static void handle_hotplug(struct rq *rq, bool online)
 {
 	struct scx_sched *sch = scx_root_protected();
@@ -4401,26 +4419,13 @@ static void rq_online_scx(struct rq *rq)
 
 static void rq_offline_scx(struct rq *rq)
 {
-	struct task_struct *p, *n;
-
 	rq->scx.flags &= ~SCX_RQ_ONLINE;
 
 	/* sched domain rebuilds call rq_offline with the CPU staying alive */
 	if (cpu_active(cpu_of(rq)))
 		return;
 
-	scx_rescue_flush(rq);
-
-	/*
-	 * An offline CPU no longer calls ops.dispatch(). Re-enqueue its tasks
-	 * onto the local DSQ so that they run here and balance_push() moves
-	 * them off.
-	 */
-	list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list, scx.runnable_node) {
-		if (p->scx.dsq == &rq->scx.local_dsq)
-			continue;
-		guard(sched_change)(p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK);
-	}
+	drain_offline_rq(rq);
 }
 
 static bool check_rq_for_timeouts(struct rq *rq)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6c7c5633524a..2cc16c01b168 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -4294,7 +4294,7 @@ extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
  * Typically this must be called while holding task_rq_lock, since most/all
  * properties are serialized under those locks. There are currently two
  * exceptions to this rule in sched/ext which only hold rq->lock: scx_bypass()
- * and rq_offline_scx().
+ * and drain_offline_rq().
  */
 
 /*

