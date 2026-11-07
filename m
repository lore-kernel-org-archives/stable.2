Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045917;
	b=GIYETqaRbr/uY+jhKpqUDckJb8vl8a4lllqtSwlr4j/AXXIGghdwYis2UDn0iho4GvPA
	 M0brPH5J1+N+RFAK9V0rdutpHxGhdHfKPyT0H0VliuLFljvgn4xoYTdFsZY+agXXoO5k1
	 oFEebeAVmKQhAmztaKb0duZCW/Ik6U3IgFOHti3NdiKFrtaNTVbflDRWFGfnDegOsjFUt
	 6UTNxjEKa9FlxOSDQ1HQzJ5LnFoQzt2VHO8PCtmThWtb2cvVuzg9roXZcDdA00DfQtjnB
	 ai2wz3s2RmY+3RY7GmGwQyKJPQYMPs3ULUiz7Nz16cqVR0nwicfRFjUpDatTGOvWxvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045917;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PeZNAdMXgSqoMvXat2V4VvKFLioTAA0MT7sPXX744RQ=;
	b=0eYTeQTd2HiE9v9dcS5uBH+mn295HTKpbCCMeJwKvzubQDucEYGN/+Mq7Ur3Pct9Hhgq
	 u+WRwYAAdHrRhMQcLr65iFFRlm4WuastdJm+f/vnzcBRkfFflfwe1AQ5fZzJopvFqt8eY
	 wupsOR9nNLw07hvx9WpHPnpi8r/vYj5zbm/Upv7i6myoitZVQBV+xOSF0jgD2GVSwim8R
	 Y4tFi6YpEvDzTrw14HMF/9fkDACgsDd7/wFNAubuminZo0XXxGaDJx0hHKfAoc1DFCBNN
	 s3qpSz9THkp/Ltz1wbSZoKmLVrOTb+oiCtJ7GPNwg9aWETwATawAajFvGdSV87W+sng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QAugf89P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EEB606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QAugf89P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B241F0089F;
	Sat,  7 Nov 2026 10:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045916;
	bh=PeZNAdMXgSqoMvXat2V4VvKFLioTAA0MT7sPXX744RQ=;
	h=From:To:Cc:Subject:Date;
	b=QAugf89P8E4eoCacpCd5Z+Qoq3WFcmy9iHlXBhY7iAVrQiKivUSeCj2zQyyM5MDF1
	 LoIR0fEYwds48MQfupYtPeNBJLDM5QL+ecgzYBs2slFJ6yCzGfAdrAcYRsAkS4HLpp
	 ahRLoCOiEPZId5STzSA0aIZx0TQejSZukC14MoXD5g0KbIdokrTQaeMnstTM5xYFsy
	 0DcNTrdU8XxUFobYlLL5xBOlUAC5cLWIxRJ5mQCDHwAMxlsMQP73zqpXTvePUZ85s6
	 S3hCyd/oMOK0CtYgZd+OLeLoU7f+wOmlHIC1Haa+F+p0K5lWQwGUo/jG0Tly884Xmp
	 PQOzUce2XV8lA==
From: Sasha Levin <sashal@kernel.org>
To: arighi@nvidia.com,
	tj@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] sched_ext: Queue the kick_sync wait from set_next_task_scx()" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:05:14 -0500
Message-ID: <20261107050514-failed-7.3-e2859566ffbc@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x e2859566ffbc3a9f33308255114ccf167124e048
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050514-failed-7.3-e2859566ffbc@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e2859566ffbc3a9f33308255114ccf167124e048 Mon Sep 17 00:00:00 2001
From: Andrea Righi <arighi@nvidia.com>
Date: Sun, 18 Oct 2026 18:24:15 +0200
Subject: [PATCH] sched_ext: Queue the kick_sync wait from set_next_task_scx()

The SCX_KICK_WAIT wait is deferred to rq->scx.kick_sync_bal_cb, which a
final pick queues on the local rq. Under core scheduling, a pick that
returns a task isn't final: pick_next_task() goes on to pick the SMT
siblings, and their dispatch can release the shared rq lock with the
callback still queued. A CPU acquiring the rq lock in that window then
finds a pending balance callback and triggers the warning in
rq_pin_lock().

Fix this by queuing the callback from set_next_task_scx() on SNT_PICK
and SNT_REPICK. put_prev_set_next_task() calls it once the pick is
final, after the core-wide selection, so the rq lock can't be dropped
with the callback queued. If the CPU ends up running idle or a higher
class task, no SCX task runs there and there's nothing to wait for:
kick_sync_pending stays set and the next pick of an SCX task waits
before running it.

Also, proxy exec zaps the balance callbacks and picks again when
find_proxy_task() fails, so clear kick_sync_pending when the callback
runs rather than when it's queued.

Fixes: 415cb193bb97 ("sched_ext: Fix SCX_KICK_WAIT deadlock by deferring wait to balance callback")
Cc: stable@vger.kernel.org # v7.0+: c72945693b90: sched: Restart fair hrtick after same-task repicks
Cc: stable@vger.kernel.org # v7.0+
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 50 ++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 6fec09fd09707..5efc3ad1b1198 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3422,6 +3422,8 @@ static void scx_start_task_running(struct rq *rq, struct task_struct *p)
 	p->scx.flags |= SCX_TASK_RUN_TRACKED;
 }
 
+static void kick_sync_wait_bal_cb(struct rq *rq);
+
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, enum snt_e type)
 {
 	bool first = type == SNT_PICK;
@@ -3437,6 +3439,20 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, enum snt_e t
 	    (type == SNT_PICK || type == SNT_REPICK))
 		rq->scx.flags |= SCX_RQ_PROXY_PENDING;
 
+	/*
+	 * Defer the kick_sync wait to a balance callback which can drop rq lock
+	 * and enable IRQs. Waiting directly in the pick path would deadlock
+	 * against CPUs sending us IPIs (e.g., TLB flushes) while we wait for
+	 * them.
+	 *
+	 * Queue it only once the pick is final, so that the rq lock can't be
+	 * released with the callback queued (e.g., by another dispatch during
+	 * a core-wide selection). If no SCX task gets picked, there's nothing
+	 * to wait for and kick_sync_pending stays set for the next SCX pick.
+	 */
+	if (unlikely(rq->scx.kick_sync_pending) && (type == SNT_PICK || type == SNT_REPICK))
+		queue_balance_callback(rq, &rq->scx.kick_sync_bal_cb, kick_sync_wait_bal_cb);
+
 	if (type == SNT_REPICK)
 		return;
 
@@ -3717,17 +3733,22 @@ static void kick_sync_wait_bal_cb(struct rq *rq)
 	s32 cpu;
 
 	/*
-	 * This callback is queued and normally flushed within @rq's own
-	 * scheduling pass. However, dispatch can drop the rq lock while it sits
-	 * queued, and lock takers in that window (the sched class change paths,
-	 * the scx task iterator) flush pending balance callbacks on release,
-	 * running this one on a foreign CPU whose snapshots are unrelated. The
-	 * kicked CPUs are already on their way to advance the kick_syncs being
-	 * waited on. Don't get in the way.
+	 * This callback is queued once the pick is final and flushed within
+	 * @rq's own scheduling pass. If a lock taker on a foreign CPU ever
+	 * flushes it, the snapshots are unrelated to that CPU. Don't get in the
+	 * way and leave the wait pending for @rq's next pick.
 	 */
 	if (unlikely(cpu_of(rq) != smp_processor_id()))
 		return;
 
+	/*
+	 * Clear only when the wait actually runs. The callback can be dropped
+	 * without running (e.g., proxy exec zaps the balance callbacks and
+	 * picks again when find_proxy_task() fails), in which case the next
+	 * pick must queue it again.
+	 */
+	rq->scx.kick_sync_pending = false;
+
 	ks = __this_cpu_read(scx_kick_syncs);
 	ksyncs = rcu_dereference_sched(ks)->syncs;
 
@@ -3926,25 +3947,12 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 	 * NULL pick from the dl_server, the core continues picking and can
 	 * release the rq lock (e.g., prev_balance() or another dispatch). In
 	 * that case, run the deferred work from irq_work, which doesn't depend
-	 * on the current rq lock section, and leave the kick sync wait pending
-	 * for the next pick.
+	 * on the current rq lock section.
 	 */
 	if (p != RETRY_TASK && (p || !force_scx)) {
 		/* under core scheduling, see dispatch_core_pick() */
 		if (!core_sched)
 			maybe_queue_balance_callback(rq);
-
-		/*
-		 * Defer to a balance callback which can drop rq lock and enable
-		 * IRQs. Waiting directly in the pick path would deadlock against
-		 * CPUs sending us IPIs (e.g., TLB flushes) while we wait for
-		 * them.
-		 */
-		if (unlikely(rq->scx.kick_sync_pending)) {
-			rq->scx.kick_sync_pending = false;
-			queue_balance_callback(rq, &rq->scx.kick_sync_bal_cb,
-					       kick_sync_wait_bal_cb);
-		}
 	} else if (!core_sched && (rq->scx.flags & SCX_RQ_BAL_CB_PENDING)) {
 		rq->scx.flags &= ~SCX_RQ_BAL_CB_PENDING;
 		schedule_deferred(rq);
-- 
2.53.0




