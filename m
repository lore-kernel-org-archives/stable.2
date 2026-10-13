Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA103B38A4
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882156; cv=none; b=qu65fH1Mj6uycD055JMeowdO7C9K/1yHfkVlgKEDazUdBJIArdDe7NqkowfJFU4M+cTN6n4HnB778W5WUDPKMSRhyXHoH83AvpcgJYiGXs7kxi4FsZtCNfuc0oK2GhCN/LFSsXiW+zg6nrUQh/yoqBFsfgHTh3gjimSwi768MQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882156; c=relaxed/simple;
	bh=mByYy/wF1hQJXIToea1LLMF/FVXIhM2HPACW0o6Iies=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O2MJYfxw79bZCKvdmO5ZFL9GIFsLoW99Y/Lzf8DzAUGofq2F9gzCTVGoQA/yDyMrnqEOeWzbnRVzcKkujoEi/OVEgq4fXznMsKkkZ0aHz4izpgH+eS/Bz2hgSAqqHu2RjBcAB2hm3ExA7XwjTyanNXJT/rMsqOrrR2Ctd1AnN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lpu/6OiW; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpu/6OiW"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2e2a9fa1fcso313233166b.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791882153; x=1792486953; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OlV4rzarC4FHiFfq3DmV5gapLykaHerwGzs7rihRrhY=;
        b=lpu/6OiWs7yP5WCL/ugpymZcSkRxS9zAIFfoCWBQrVgAlYltuTftdI4456NjkzTIlZ
         j9xr6ZOq+ZV2o7zvT9o6vBJiILoQRVh5q+zTUUHXtAiQXxaXTpU9agF2ZvzDLJ6IqH5G
         h1uL7+fAoputNzfcr7yBYSZU3FsWLTMia6wcbJYaLGoKKXZf8pljkRoKZBdE1bfwVWw9
         xynWPVYSDT+j+r8Q6qbjpjnynBIhZrFciBvdkWNLtMELdKUJvTGp7b4OFPVfm50bozJI
         L0ShQdzZs3dPuIhAkHbXDPjnwfwHNjx0dv8M6A4pTq/NRF6AeISpO/bsDuD9tKd2ZewY
         nUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791882153; x=1792486953;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OlV4rzarC4FHiFfq3DmV5gapLykaHerwGzs7rihRrhY=;
        b=1KrK3k8SheflLH4eY8CDKxNNyJnVkX0A+RGyHhB1kymAiMrhtVYsGS4zMniF39r5Qn
         wFkVIm7ECEQ6QbjzQ6bO2L2JFiE5QKSunHnCQ/l00voeOe7+6KtdLscurDNGCS+63NbB
         GsAoJHBwVt+hnJEsWRkERseyU9fvBTo1Upvad8crGdZGRtyhoqunh49g5nj3t4PdWl5C
         KsFfPz/vrsDy8W9d0iUGJtmrwLFGTzgCyeOSe8RCIr206d4C6BDiafgI1NkKHzbPKgTJ
         //RxufSGJvIcjcv276VGvjuBAZKPDg0+8r0QScnC5ox7CcCY1b8DYFeb9beiVhBhL6aD
         Q8uQ==
X-Gm-Message-State: AFq9FYJepCjX7QXXl5uhlPBofmmfdwSpUoK6ZlXqFtkDf1kmPwIcSIvi
	odSVaOpLyZvoVgbaQ4gQ5JIDa873jBDW/+HWHImnb7r5NH8ESjmPXRbr+evO8LeZEQHUkmtwRf4
	/53sBJQaffpPX3O3y4325nBkAcMeHKTpiJOijRx6IoYgL13KDJ483pivNW6+swqBlJ0PtUnTvBE
	2iUX8kI5MDh/fr5jEq9ePd50XRUdNLdqEfhK0ySJDQB93AptQ=
X-Received: from wrof16.prod.google.com ([2002:adf:f590:0:b0:488:8db5:4123])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:2d12:b0:c2e:4292:d26b with SMTP id a640c23a62f3a-c31a9feb84amr1067574866b.17.1791882153180;
 Tue, 13 Oct 2026 02:02:33 -0700 (PDT)
Date: Tue, 13 Oct 2026 09:02:26 +0000
In-Reply-To: <2026101216-emptier-earthen-62f0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026101216-emptier-earthen-62f0@gregkh>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013090229.3584603-3-jpiecuch@google.com>
Subject: [PATCH 6.18.y] sched_ext: Generate qseq from a per-task counter
From: Kuba Piecuch <jpiecuch@google.com>
To: stable@vger.kernel.org
Cc: Kuba Piecuch <jpiecuch@google.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"

finish_dispatch() uses the qseq embedded in p->scx.ops_state to tell
whether the QUEUED instance of a task it's about to claim is the one
scx_bpf_dsq_insert() saw. qseq is generated from rq->scx.ops_qseq, but
the counters of different rqs are independent, so if a task is dequeued
and re-enqueued on a different rq between scx_bpf_dsq_insert() and
finish_dispatch(), the new QUEUED instance can end up with the same
qseq as the old one:

  CPU X                          CPU Z
  -----                          -----
                                 enqueue p on rq A, qseq = N
  ops.dispatch()
    scx_bpf_dsq_insert(p)
      records qseq N
                                 sched_setaffinity(p)
                                   dequeue p from rq A
                                   enqueue p on rq B, qseq = N
  finish_dispatch(p, N)
    qseq matches, p is claimed

The claim itself is still atomic so the core stays consistent, but an
insert issued for a previous QUEUED instance gets applied to a new one
which the BPF scheduler has just received through ops.enqueue(). This
breaks the guarantee that dispatches targeting a stale instance are
ignored.

Generate qseq from a per-task counter, p->scx.ops_qseq, instead so that
consecutive QUEUED instances of a task never share a qseq regardless of
which rq they're on. The counter is only updated in
scx_do_enqueue_task() with the task's rq locked, so no additional
synchronization is needed, and it fits in an existing hole in struct
sched_ext_entity on 64bit. Remove the now unused rq->scx.ops_qseq.

Never generate qseq 0. NONE and DISPATCHING don't carry a qseq, so
scx_bpf_dsq_insert() on a task in either state records 0. With a
per-task counter, every task's first QUEUED instance would otherwise get
qseq 0 and could be claimed by such an insert. Wrap the counter where
the QSEQ field wraps so that it can't reach a value that shifts to 0 on
32bit either.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit e6ac89b8b1c12e9104df45a14a26e2dfa96ded06)
[ jpiecuch: applied ext/ext.c and ext/internal.h hunks to ext.c and
  ext_internal.h; adjusted context in sched/ext.h, sched.h and dump line. ]
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 include/linux/sched/ext.h   |  1 +
 kernel/sched/ext.c          | 15 ++++++++++-----
 kernel/sched/ext_internal.h |  5 +++++
 kernel/sched/sched.h        |  1 -
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 9848aeab2786..7e5614e2a331 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -152,6 +152,7 @@ struct sched_ext_entity {
 	s32			holding_cpu;
 	s32			selected_cpu;
 	u32			kf_mask;	/* see scx_kf_mask above */
+	u32			ops_qseq;	/* protected by rq lock */
 	struct task_struct	*kf_tasks[2];	/* see SCX_CALL_OP_TASK() */
 	atomic_long_t		ops_state;
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 059675018c71..189a4e0658eb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1300,8 +1300,14 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	if (unlikely(!SCX_HAS_OP(sch, enqueue)))
 		goto global;
 
-	/* DSQ bypass didn't trigger, enqueue on the BPF scheduler */
-	qseq = rq->scx.ops_qseq++ << SCX_OPSS_QSEQ_SHIFT;
+	/*
+	 * DSQ bypass didn't trigger, enqueue on the BPF scheduler. Wrap the
+	 * per-task qseq counter where the QSEQ field wraps and skip 0, which is
+	 * what scx_bpf_dsq_insert() records for a task in NONE or DISPATCHING.
+	 */
+	p->scx.ops_qseq = ((p->scx.ops_qseq + 1) &
+			   (SCX_OPSS_QSEQ_MASK >> SCX_OPSS_QSEQ_SHIFT)) ?: 1;
+	qseq = (unsigned long)p->scx.ops_qseq << SCX_OPSS_QSEQ_SHIFT;
 
 	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
 	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
@@ -4392,10 +4398,9 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 		seq_buf_init(&ns, buf, avail);
 
 		dump_newline(&ns);
-		dump_line(&ns, "CPU %-4d: nr_run=%u flags=0x%x cpu_rel=%d ops_qseq=%lu pnt_seq=%lu",
+		dump_line(&ns, "CPU %-4d: nr_run=%u flags=0x%x cpu_rel=%d pnt_seq=%lu",
 			  cpu, rq->scx.nr_running, rq->scx.flags,
-			  rq->scx.cpu_released, rq->scx.ops_qseq,
-			  rq->scx.pnt_seq);
+			  rq->scx.cpu_released, rq->scx.pnt_seq);
 		dump_line(&ns, "          curr=%s[%d] class=%ps",
 			  rq->curr->comm, rq->curr->pid,
 			  rq->curr->sched_class);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 5b2dd105fa92..7cb9c8725b65 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1057,6 +1057,11 @@ enum scx_ops_state {
 	 * dequeue/requeue, the dispatcher can tell whether it still has a claim
 	 * on the task being dispatched.
 	 *
+	 * QSEQ is generated from the per-task p->scx.ops_qseq counter so that
+	 * it doesn't repeat across QUEUED instances of the same task even if
+	 * the task moves between rqs. 0 is never used as a valid QSEQ since
+	 * NONE and DISPATCHING map to this value.
+	 *
 	 * As some 32bit archs can't do 64bit store_release/load_acquire,
 	 * p->scx.ops_state is atomic_long_t which leaves 30 bits for QSEQ on
 	 * 32bit machines. The dispatch race window QSEQ protects is very narrow
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 97dddc148d71..4e58174d3d0b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -795,7 +795,6 @@ struct scx_rq {
 	struct scx_dispatch_q	local_dsq;
 	struct list_head	runnable_list;		/* runnable tasks on this rq */
 	struct list_head	ddsp_deferred_locals;	/* deferred ddsps from enq */
-	unsigned long		ops_qseq;
 	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
 	u32			nr_running;
 	u32			cpuperf_target;		/* [0, SCHED_CAPACITY_SCALE] */
-- 
2.56.0.385.gd3acb90ef8-goog

