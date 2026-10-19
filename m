Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422852;
	b=CyaNhmPvrAjhj78hOI/gfdrP2E20hnwP3iWgcQ6omDForiLBhmIgMc0PkTgw137k5Res
	 3Zhdu+QA6/5kbJ1QDDbiYEkYd4JTEYkH7tX10sqmbja+LDl5M0fIhcIJbInZ/xr9dgHR0
	 cPLW1vaYaG8vNRVdiud9aUwwAIF+5ibXPxmKWE7UBz3UiojIEIL/XSd9V+ArTBhOS37gF
	 j5nkqpVoiQehhrjCtt6dQj7xmyiw60c36TufL9Sv+NzveNR4cRmrSzGTf/osPWBkj/i1W
	 g2XaYcHD1XzoCJ5mwOoiswv/omyMs5T5eDeqD2NC1XJ7VvcJICzUrQqXGlYAmJ2Omkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422852;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ExRw9WuWIr0p5AYjgul5hezibf1JXB0BJmVlaNloBdA=;
	b=ul17uyEyNWNaqHrM64exOFfWI1vC+BXy/RyMtoZaLlsuA3O+iIOaPuN2L3yR0DX1pXEz
	 W0Y9GqTimRm17+ibnjWT+F8GV/wgr87/QcHdyz3zBKwcj8YE1n1pSC8E482wW+EQpcEE+
	 PwBxl3+ZrOMaRRQm6vXYN2VVCEg7lgTDLvsmABG+M18kwdk4pTvpIixgG0sgar9dg1vML
	 Di1w8utLc2jSym19Wg8GL6vOKYQh327q4efeMT7cP3/9Q5E4yeZ1UxWzfLR7rMJEungpb
	 kh2bPKmWw+RtgSpOWGvujQynbbJdn58iHRqBIhG1671I2WTkMyy27Tbs08n9osndnTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mWWAch4u;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33250609B66C;
	Mon, 19 Oct 2026 15:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33250609B66C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mWWAch4u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792422851; x=1823958851;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9f4xcAeEk4Y2XZsQrlSHLA8dr7zRkDfjKkFP/Y8XoTs=;
  b=mWWAch4uCn64BSVq7LhyXfnDLUdx7YDhPcL2a0xlnQSnN+vUYZGus2pw
   q5r7/TGee8L2gVGRBwhruWU85u61jOPf9XVUyGnwbrtnnFGNyX+X1t5iL
   xGqupbif1/sHPa7IFoexg+CAP8W1fFm+1NK7qbCRh/uwdTrcEguUEmYJy
   +m9QqBq3VPyUkZTtOrMLJ7kz4UzHnzj3k0VkuRMirpKdI36DKMfVNa1qk
   85sOK8pDovPbNP2iy5AyrJh4Ah4p70uw17P5IbT4TnlYWqFEKHN/Anc/+
   XRi8dFC/XdvzoWSymNS3hebkDv3mCbvSk/GHER8TQ6vfBgTl7Mu3TW1TO
   A==;
X-CSE-ConnectionGUID: 9SiRVx6PRmSOmG0ydAQ7DA==
X-CSE-MsgGUID: WCJhci1PSpuv0qoNGt2DAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="986871"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="986871"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 08:14:10 -0700
X-CSE-ConnectionGUID: zJZvmXxpROKsCJn1yJ8EoA==
X-CSE-MsgGUID: PnyO1OXHR3S41b0OX43Iow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2536877"
Received: from jf5300-15a101203tc.jf.intel.com (HELO meta-crater2c.jf.intel.com) ([10.54.113.49])
  by orviesa003.jf.intel.com with ESMTP; 19 Oct 2026 08:14:10 -0700
From: Daniel Byrne <daniel1.byrne@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] io_uring: don't sleep on a claimed DEFER_TASKRUN wakeup
Date: Mon, 19 Oct 2026 08:06:07 -0700
Message-ID: <20261019150607.4026170-1-daniel1.byrne@intel.com>
X-Mailer: git-send-email 2.43.0
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

A producer that stalls between publishing local task work and
running the cq_wait_nr wake protocol can claim an arm from a later
wait cycle than the one its work belongs to. The waiter may already
have drained that work and re-armed for its next sleep. The claimed
wake then fires through wake_up_state() while the waiter is still
TASK_RUNNING, before it has set its task state for the sleep, and
is a no-op. The arm is spent and nothing restores it in time, so
every later producer reads a non-positive cq_wait_nr and skips the
wake. No producer wakes the waiter, which sleeps while the
completions it waits for pile up on ctx->work_list.

Three waiters arm cq_wait_nr. io_cqring_wait() and the BPF loop
waiter io_loop_wait() arm it a few instructions before
set_current_state(). The third waiter is the cancel wait in
io_uring_cancel_generic(), where exec waits for all of a task's
inflight requests and exit waits for its tracked ones, such as
futex waits. There, io_uring_try_cancel_requests() arms cq_wait_nr
at the start of each cancel pass. The task state is set only after
the whole pass, so the window spans the io-wq cancel, the local
work run and the cancel walkers. That wait has no timeout. A
stranded exec sleeps until a signal arrives, and a stranded exit of
the last thread, which no longer receives signals, can sleep for
good.

A prototype that busy-polls device completions in TASK_RUNNING from
io_cqring_wait_schedule() while armed (to be posted separately, as part of
the io_uring DMA copy offload) widens the io_cqring_wait() window to
tens of microseconds, and those completions push local work from many
CPUs, so what is a narrow race in upstream io_cqring_wait() wedged fio
reliably within seconds there. Every ring was parked in
io_cqring_wait() with exactly its queue depth of completions stranded
on ctx->work_list and cq_wait_nr at IO_CQ_WAKE_INIT.

Add io_cq_wait_arm_spent() and refuse to sleep in all three waiters
once the arm is spent. io_cqring_wait() runs its wait loop again,
and io_loop_wait() returns to the loop in __io_run_loop(). Both
loops drain anything pending and re-arm. The cancel wait runs
another pass, which re-arms. Each check follows the setting of the
task state, so a later claim can no longer be lost. The cancel wait
checks only the rings whose deferred work the task runs, because an
arm wakes only ctx->submitter_task. wait.h documents the rule next
to IO_CQ_WAKE_INIT.

The check relies on nothing else restoring a spent arm before it
runs. The min_wait timer stores an arm only during the timed sleep,
which starts after the check and cancels the timer before the
waiter checks again. io_uring_try_cancel_requests() also arms the
ring when io_ring_exit_work() runs it or when a task that does not
own the ring runs it, such as the creator of an R_DISABLED ring
that another task enabled. Such a store that lands between the
owner's test for pending local work and its check hides a spent
arm, and the owner sleeps on work that no later producer wakes it
for. Arm only in the owner's passes, the ones that also run the
ring's local work, as the owner is the only task an arm wakes.
io_ring_exit_work() never sleeps on the arm and runs stranded work
itself, so it needs no arm.

Fixes: d46ab2c98aba ("io_uring: switch local task_work to a mpscq")
Cc: stable@vger.kernel.org # v7.2
Assisted-by: Claude:claude-fable-5-1
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Daniel Byrne <daniel1.byrne@intel.com>
---
 io_uring/cancel.c | 25 +++++++++++++++++++++++--
 io_uring/loop.c   |  3 ++-
 io_uring/wait.c   | 19 +++++++++++++++++++
 io_uring/wait.h   | 20 ++++++++++++++++++++
 4 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 4f706aff14fc..0ed7544851f8 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -520,8 +520,18 @@ __cold bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
 	enum io_wq_cancel cret;
 	bool ret = false;
 
-	/* set it so io_req_local_work_add() would wake us up */
-	if (ctx->flags & IORING_SETUP_DEFER_TASKRUN) {
+	/*
+	 * Arm so that io_req_local_work_add() wakes ->submitter_task. An
+	 * arm wakes no other task, so only that task's passes arm, the same
+	 * ones that run the local work below. A store from another task
+	 * could restore an arm that a stalled add spent while the owner was
+	 * getting ready to sleep, and so hide the spent arm from the
+	 * owner's test. See the comment above IO_CQ_WAKE_INIT. This leaves
+	 * out io_ring_exit_work(), which never sleeps on the arm and runs
+	 * stranded work itself.
+	 */
+	if ((ctx->flags & IORING_SETUP_DEFER_TASKRUN) &&
+	    io_allowed_defer_tw_run(ctx)) {
 		atomic_set(&ctx->cq_wait_nr, 1);
 		smp_mb();
 	}
@@ -639,6 +649,17 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
 			if (io_local_work_pending(node->ctx) &&
 			    io_allowed_defer_tw_run(node->ctx))
 				goto end_wait;
+			/*
+			 * The pass armed ->cq_wait_nr while running, so a
+			 * stalled add may have spent the arm with a lost
+			 * wake up. See the comment above IO_CQ_WAKE_INIT.
+			 * Run another pass, which re-arms, instead of
+			 * sleeping. An arm only wakes the ring's
+			 * submitter_task.
+			 */
+			if (io_allowed_defer_tw_run(node->ctx) &&
+			    io_cq_wait_arm_spent(node->ctx))
+				goto end_wait;
 		}
 		/*
 		 * If we've seen completions, retry without waiting. This
diff --git a/io_uring/loop.c b/io_uring/loop.c
index 3d472b7827fa..55acd9580940 100644
--- a/io_uring/loop.c
+++ b/io_uring/loop.c
@@ -29,7 +29,8 @@ static void io_loop_wait(struct io_ring_ctx *ctx, struct iou_loop_params *lp,
 
 	if (unlikely(io_local_work_pending(ctx) ||
 		     io_loop_nr_cqes(ctx, lp) <= 0) ||
-		     READ_ONCE(ctx->check_cq)) {
+		     READ_ONCE(ctx->check_cq) ||
+		     io_cq_wait_arm_spent(ctx)) {
 		io_loop_wait_finish(ctx);
 		return;
 	}
diff --git a/io_uring/wait.c b/io_uring/wait.c
index a48523c2f356..221b5181dd25 100644
--- a/io_uring/wait.c
+++ b/io_uring/wait.c
@@ -178,6 +178,25 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 		return -EINTR;
 	if (unlikely(io_should_wake(iowq)))
 		return 0;
+	/*
+	 * A DEFER_TASKRUN producer that stalls between publishing its work
+	 * and claiming the wake can claim an arm from a later wait cycle
+	 * than the one its work belongs to: this task may already have
+	 * drained that work while disarmed and re-armed for the next sleep.
+	 * The claimed wake then lands via wake_up_state() while this task
+	 * is still TASK_RUNNING, between the arm and set_current_state(),
+	 * and is a no-op. The arm is gone, so every later producer reads a
+	 * non-positive ->cq_wait_nr and skips the wake, and this task would
+	 * sleep unwakeable under a non-empty work list. If the arm set at
+	 * the top of the wait loop is no longer intact, a claim has fired:
+	 * re-run the loop, which drains anything pending and re-arms,
+	 * instead of sleeping. From here to schedule() the state stays
+	 * TASK_INTERRUPTIBLE, so any later claim delivers its wake.
+	 */
+	if (io_cq_wait_arm_spent(ctx)) {
+		__set_current_state(TASK_RUNNING);
+		return 1;
+	}
 
 	return __io_cqring_wait_schedule(ctx, iowq, ext_arg, start_time);
 }
diff --git a/io_uring/wait.h b/io_uring/wait.h
index b7b9c46b1b01..a07c64696697 100644
--- a/io_uring/wait.h
+++ b/io_uring/wait.h
@@ -11,9 +11,29 @@
  * wake up is to be issued: IO_CQ_WAKE_INIT when no task is waiting (also
  * what a forced wake up resets it to when claiming one), zero once the
  * countdown has fired.
+ *
+ * An add can stall between publishing its work and claiming the wake up,
+ * and the waiter may run that work and arm a later cycle in between. The
+ * add then claims the new arm, and if the waiter has not set its task state
+ * yet, that wake up is a no-op. Every later add sees the spent arm and
+ * issues none. A waiter must therefore test io_cq_wait_arm_spent() after
+ * setting its task state and must not sleep if it returns true.
+ *
+ * The test is sound only if nothing but the waiter stores an arm while it
+ * gets ready to sleep, as such a store could restore a spent arm and hide
+ * it. io_uring_try_cancel_requests() therefore arms only in the
+ * submitter_task's own passes, and the min_wait timer stores an arm only
+ * during the timed sleep, which cancels the timer before the waiter tests
+ * again.
  */
 #define IO_CQ_WAKE_INIT		(-1)
 
+static inline bool io_cq_wait_arm_spent(struct io_ring_ctx *ctx)
+{
+	return (ctx->flags & IORING_SETUP_DEFER_TASKRUN) &&
+	       atomic_read(&ctx->cq_wait_nr) <= 0;
+}
+
 struct ext_arg {
 	size_t argsz;
 	struct timespec64 ts;

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.43.0

