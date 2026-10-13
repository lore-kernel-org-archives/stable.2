Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3CD3ADB89
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882160; cv=none; b=rFXmAwo5bKFAp+WATZiI3JlJL3gS4wxKRI7H9T6ZEOvYMmASws8cDGNZdQNDCAWoO49bxkb2nXNrQR5p5sgCSqsh49tPtg3Cm9YJj61IuyjexmexRR8BfTl2abngEpUnzQ5MiVo851WzF6l0YqFKjZ+0RNGvh5gjiwLISHILIfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882160; c=relaxed/simple;
	bh=qvtiffZ6r6QUrBfBaScQnnBj4UKb5CeWl8o0x8lPnhc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i2x2ZhHa605WL2JeM9ekIwLuGDHItS5TZymsyYtmey73aWLZ2R6zte2/3Q8V49bv7p7JGAVsHuDX6MCMoRbDk/wZ256/gzoHPALpN7T0os40k8AohJ6JQDdTdkeXGSd/rVZiSv1YO9b40jVfm98q9L+yItrBgfmYpRVKGCE45/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n9rQF4AV; arc=none smtp.client-ip=209.85.221.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n9rQF4AV"
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48b00febba3so2202129f8f.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791882155; x=1792486955; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W2cfjA07cNyLg0n+xK/oSZ84wD5+x3kisLmJntB9yaI=;
        b=n9rQF4AVEU9vf0p40W0fGmP/i7A3jL4gKAxjbD6eQKij6T/LuVPFl9AeUgHdQ8Qe9Y
         d6rYojY2kJI3jKmq3MAzRwA/sCeBWz0k1S3k6XNBjyxlqmYKmclyQxN0yjEF33nZtG7L
         TAQKK7BPl9UeMOOJsRM+ugTMvxSJO7rrv/3nPirmesJhUl0hcm/a4mr7XrUxCko/qIZS
         0lG+tx/VYsJsNCpEEvMvMIV9QV/MKcYuwxpmW6rqdow3uv++1A4FhYpCdYMwTBcFnc8n
         nSKcJ60EJsKQiRg3oRjl/a3Y5EUREZNAwWc/qMCajhuObvcSzPft4AVSrgEpcafIgElA
         gGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791882155; x=1792486955;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W2cfjA07cNyLg0n+xK/oSZ84wD5+x3kisLmJntB9yaI=;
        b=B+vAGdAPS/ykASHgKLAWzAzsWuRjyKxaFyMhxqIXcxG3d5fz1JDItTtNKESJ9Ojc60
         mjUF/X/Z7NlhUOw/WGY+fsUcZnHWFVZ2EFd06MAnIDWj3knFgYEaG5HnYD877VXMEnba
         38rNbF5/V6VCedPPy/N9Cn4KPnv1fc/1flLFHYnBnZtm8L7sxE4Ca065nn3FORj5u4m0
         Z78/qWi3toWjmkhC6D5yUvYiE0mj3IMEekNZHhdXpvSNRgso6Xcm9uz1qtYvJfuuXpW5
         5y9MC9X8qQ64r7UX3av5uZ1ceIfMi3W5Wm6jIERpuFfWmUPVOoxo3/10GPj0G8eU6ljs
         P8pQ==
X-Gm-Message-State: AFq9FYLFvWtCD9Mv+cgxKLoUzGr8StFh77rCev6nCZIrD2dNnw7hxNTQ
	4VlE+Ql+1cF05JIa6eYUk51IIlNR2ugZyriGYN58I/za8ofBw4qMZodZId3ouFOqe+I+FlbD65B
	W4+0H8iITMZuNbdwYtJo+SFnCPf4nh9NpvLHyJdNf/32+rYV9thyqnvoWntmhd9uShRCVREj+s9
	tY/1+Rb131BkE6g3WOY0aqW4mlLk5RUlUayadAqm9mOuT2EW4=
X-Received: from wrxl12.prod.google.com ([2002:a05:6000:12cc:b0:48b:1270:cbfa])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:420f:0:b0:48b:a7:6396 with SMTP id ffacd0b85a97d-48dbad28c47mr15344067f8f.41.1791882154241;
 Tue, 13 Oct 2026 02:02:34 -0700 (PDT)
Date: Tue, 13 Oct 2026 09:02:27 +0000
In-Reply-To: <2026101211-seismic-mutable-0582@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026101211-seismic-mutable-0582@gregkh>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013090229.3584603-4-jpiecuch@google.com>
Subject: [PATCH 7.2.y] sched_ext: Generate qseq from a per-task counter
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
[ jpiecuch: 7.2.y lacks runnable_cpu in sched_ext_entity, so ops_qseq goes
  after selected_cpu; adjust context in scx_rq and the dump_line() CPU line ]
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 include/linux/sched/ext.h   |  1 +
 kernel/sched/ext/ext.c      | 15 ++++++++++-----
 kernel/sched/ext/internal.h |  5 +++++
 kernel/sched/sched.h        |  1 -
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 87e353f7e011..67a97429d8a6 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -198,6 +198,7 @@ struct sched_ext_entity {
 	s32			sticky_cpu;
 	s32			holding_cpu;
 	s32			selected_cpu;
+	u32			ops_qseq;	/* protected by rq lock */
 	struct task_struct	*kf_tasks[2];	/* see SCX_CALL_OP_TASK() */
 
 	struct list_head	runnable_node;	/* rq->scx.runnable_list */
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index cd7cbd1c99a2..506e9b3a3fd6 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1953,8 +1953,14 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
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
@@ -6690,10 +6696,9 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	seq_buf_init(&ns, buf, avail);
 
 	dump_newline(&ns);
-	dump_line(&ns, "CPU %-4d: nr_run=%u flags=0x%x cpu_rel=%d ops_qseq=%lu ksync=%lu",
+	dump_line(&ns, "CPU %-4d: nr_run=%u flags=0x%x cpu_rel=%d ksync=%lu",
 		  cpu, rq->scx.nr_running, rq->scx.flags,
-		  rq->scx.cpu_released, rq->scx.ops_qseq,
-		  rq->scx.kick_sync);
+		  rq->scx.cpu_released, rq->scx.kick_sync);
 	dump_line(&ns, "          curr=%s[%d] class=%ps",
 		  rq->curr->comm, rq->curr->pid,
 		  rq->curr->sched_class);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index b295991b9f10..3cd223c6d763 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1508,6 +1508,11 @@ enum scx_ops_state {
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
index f76e6f7f4a01..a6c6f8165eec 100644
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

