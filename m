Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE273C9EE8
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219705; cv=none; b=dQY8iiliNMOzn88mXgyfwwcNwN8VLG7FP1+TUvKg4Zda42s4VLpjaCrqG8hRweLxF8UArAPw80KI85JeOfLzqeoreCsXO6lmCe7mZaB4HyB9TNO1MLh6JIChTBVGKmZBc0pELEOHk53wrAN10+ap0V8xjC4rkMXue24sPJ8jHSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219705; c=relaxed/simple;
	bh=QD69d2OJHwOtuSaX+DoKywFbAEQo0UEq/e3/Fn2QjUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A7+VjQPp6mWajaVnZZzRZF0xFim02ZPmtNkUzc6LSI9gFjESSd/MJ8E6NME0EXQH+p11K1qoq1vHL7RZKZ+oAWe+JvyV58UScepSS8+LZCn5XQCCgzzpQnB0AIB2KtwVeM//1oi2ru4uC/iOyoTVYYTS4cVQtAdAPpcDlSeIHgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NVtko3so; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NVtko3so"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781219700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ShBjYPEYExajE8ngaKwJEtPoM9APFzTLlxCb37S7wzg=;
	b=NVtko3soc9++gRfLlIoaBBOFQi0d+fACKKMTE/tCvKwXnD6KettXDw90iH4kYyHTlloMkV
	Dq3bDtenVXhDxGVOo+guXKNmUzUGkxUOvAeeu0ETMVdZyBdZ6TA1UHu4fh05hjy/Y0/hFO
	sif6VgxrLQBckRWUx1Jvkn7itQFCQCI=
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
Subject: [PATCH] block: invalidate cached plug timestamp after task switch
Date: Thu, 11 Jun 2026 16:14:28 -0700
Message-ID: <20260611231428.345098-1-usama.arif@linux.dev>
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
 kernel/sched/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8b791e9e9f67..bf024ca115ff 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5368,6 +5368,13 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 */
 	kmap_local_sched_in();
 
+	/*
+	 * Any cached block-layer timestamp (plug->cur_ktime) is stale now,
+	 * invalidate it.
+	 */
+	if (unlikely(current->flags & PF_BLOCK_TS))
+		blk_plug_invalidate_ts(current);
+
 	fire_sched_in_preempt_notifiers(current);
 	/*
 	 * When switching through a kernel thread, the loop in
@@ -7290,12 +7297,10 @@ static inline void sched_submit_work(struct task_struct *tsk)
 
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

