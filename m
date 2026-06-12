Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0563596F8
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257259; cv=none; b=MS/c1fk7fwu3KYavMzTOUeDtZPshFMnMkF+rilBGYVcV6AVKSSzWHajxCc0dcCOpopX9QRoQCVO7kfcyaJsVBJsAe/ttxJlqpvPMpLApIal7fKqexfUZ/InpTYAsIBFLWuRykr5RHluh8a1MngpWRYUrJZwmUbPrxJkcl/G6XDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257259; c=relaxed/simple;
	bh=RdtnOaQ/45dYn/VGBVrYYUdalAsIkR0FBWEJgJ/G6PA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVK7g76IRpBZXTP6jPqMLKv4yyK+vJ4r2GdscaHqY1424oZMBk82880w+4CK9KApciS07ZWr0YXnJmNVqYs15RdqJjGczYcEkli2pwu64f5yD3ZX+V99nJ8/557tzsU0rB6/S0cHVDNidg2z5GBn7ug+I0rFYxNg+yPasiqmPG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hRZ7YAGr; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hRZ7YAGr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781257253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bw1xWLPB0CZgS93U9XBxSKNhegqUQ0O3PEyPxeYXm5M=;
	b=hRZ7YAGr1p84LtrvGgfOgrRKgPfQfKkMR3+8HJUZIvIReXEvJ/9W3TkLHsHIyyi4ddUIL4
	SqMaysNj+BsyDcIOuGmTnSnqOBQn1ryR2y0gDgeZft/lK+uHsN83KUvUNKqWPa8FAQ8KrS
	JdFj/BeP5avW7NREx86ZgvsVE9kM4TQ=
From: Usama Arif <usama.arif@linux.dev>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Cc: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	riel@surriel.com,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v2] block: invalidate cached plug timestamp after task switch
Date: Fri, 12 Jun 2026 02:40:42 -0700
Message-ID: <20260612094042.3350401-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

blk_time_get_ns() caches ktime_get_ns() in current->plug->cur_ktime
and marks the task with PF_BLOCK_TS. That cache is only valid while the
task keeps running; if the task is switched out, wall-clock time
advances and the cached value must not be reused when the task runs again.

The existing invalidation covers explicit plug flushes through
__blk_flush_plug(), and the schedule() / rtmutex paths through
sched_update_worker(). It does not cover in-kernel preemption paths such
as preempt_schedule(), preempt_schedule_notrace(), and
preempt_schedule_irq(), which enter __schedule(SM_PREEMPT) directly and
return without calling sched_update_worker().

As a result, a task preempted while holding a plug with PF_BLOCK_TS set
can reuse a stale plug->cur_ktime after it is scheduled back in. blk-iocost
then consumes that stale timestamp through ioc_now(), producing stale vnow
values for throttle decisions, and through ioc_rqos_done(), inflating
on-queue time and feeding false missed-QoS samples into vrate
adjustment.

Move the schedule-side invalidation to finish_task_switch(), which runs
for the scheduled-in task after every actual context switch regardless
of which schedule entry point was used. Keep __blk_flush_plug() as the
explicit flush/finish-plug invalidation path, and remove only the
PF_BLOCK_TS handling from sched_update_worker().

Fixes: 06b23f92af87 ("block: update cached timestamp post schedule/preemption")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
v1 -> v2: https://lore.kernel.org/all/20260611231428.345098-1-usama.arif@linux.dev/
- Make the function just blk_plug_invalidate_ts(), move the check for
PF_BLOCK_TS flag into blk_plug_invalidate_ts and make it __always_inline
(Peter Zijlstra).
---
 include/linux/blkdev.h | 17 ++++++++---------
 kernel/sched/core.c    | 12 ++++++++----
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 57e84d59a642..1c1fd31ce187 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1216,16 +1216,15 @@ static inline void blk_flush_plug(struct blk_plug *plug, bool async)
 		__blk_flush_plug(plug, async);
 }
 
-/*
- * tsk == current here
- */
-static inline void blk_plug_invalidate_ts(struct task_struct *tsk)
+static __always_inline void blk_plug_invalidate_ts(void)
 {
-	struct blk_plug *plug = tsk->plug;
+	if (unlikely(current->flags & PF_BLOCK_TS)) {
+		struct blk_plug *plug = current->plug;
 
-	if (plug)
-		plug->cur_ktime = 0;
-	current->flags &= ~PF_BLOCK_TS;
+		if (plug)
+			plug->cur_ktime = 0;
+		current->flags &= ~PF_BLOCK_TS;
+	}
 }
 
 int blkdev_issue_flush(struct block_device *bdev);
@@ -1251,7 +1250,7 @@ static inline void blk_flush_plug(struct blk_plug *plug, bool async)
 {
 }
 
-static inline void blk_plug_invalidate_ts(struct task_struct *tsk)
+static inline void blk_plug_invalidate_ts(void)
 {
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8b791e9e9f67..e97e98c33be5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5368,6 +5368,12 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 */
 	kmap_local_sched_in();
 
+	/*
+	 * Any cached block-layer timestamp (plug->cur_ktime) is stale now,
+	 * invalidate it.
+	 */
+	blk_plug_invalidate_ts();
+
 	fire_sched_in_preempt_notifiers(current);
 	/*
 	 * When switching through a kernel thread, the loop in
@@ -7290,12 +7296,10 @@ static inline void sched_submit_work(struct task_struct *tsk)
 
 static void sched_update_worker(struct task_struct *tsk)
 {
-	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER | PF_BLOCK_TS)) {
-		if (tsk->flags & PF_BLOCK_TS)
-			blk_plug_invalidate_ts(tsk);
+	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
 		if (tsk->flags & PF_WQ_WORKER)
 			wq_worker_running(tsk);
-		else if (tsk->flags & PF_IO_WORKER)
+		else
 			io_wq_worker_running(tsk);
 	}
 }
-- 
2.53.0-Meta

