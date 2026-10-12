Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DC349E144
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818720; cv=none; b=C87a0Nz3W1hALh6cpgJIp5SRybCSouEjyi8hz9rhlIs08yuP4crhXjawAjjbClMNUfodIaJ+iTQS2NnhbFPNLbzKA2w0HC+WIWBd2pNilJEvkMnIA/Lrt/MPLIfa9oTep4/6pDuCZyA64OgDNaqha3hhAvu0QgZIIht0prna8fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818720; c=relaxed/simple;
	bh=AZfJzf/ig2usIwRYkENOSJ8KoiGiJPchAVyfSJGTDII=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kmj9U7CFZwNYBPnxz3wBL9g2fOlrJ9hhwrFneyWqnG9Je0ddkPj0HnLjhBd27WL2duEz4Hl5PM0rs1j6CTAk+OTkgxbv5GW01ecOhcSnMR18VZRvPGo9ixJviJjeUUWOBS4lZDRm2EV5edFx1c2mJepC83+SX8Zj9vqPMBr90sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tXR0k7Xs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tXR0k7Xs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A2F1F008A1;
	Mon, 12 Oct 2026 15:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791818719;
	bh=s/WKgBE7PmW2/RA+aaKctpyoNgE5HYBYOKG909O4Og0=;
	h=Subject:To:Cc:From:Date;
	b=tXR0k7XsR9u0n2382clNEkRiegJD3fQgxu9E79rCZvQPfB+MrjFXDzWhYJxZ+ZqRT
	 YdvYPAqspOD0N056vdDV4HrDLMZAsmeQnNjXnRqrkuewripk3FLuDQaPITWeVXTb2v
	 gLh813vL1P5UApqtypNn6UJ680wrBsv4qWd93Tkc=
Subject: FAILED: patch "[PATCH] sched_ext: Generate qseq from a per-task counter" failed to apply to 6.12-stable tree
To: jpiecuch@google.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:25:18 +0200
Message-ID: <2026101218-botch-overbook-03a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e6ac89b8b1c12e9104df45a14a26e2dfa96ded06
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101218-botch-overbook-03a8@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e6ac89b8b1c12e9104df45a14a26e2dfa96ded06 Mon Sep 17 00:00:00 2001
From: Kuba Piecuch <jpiecuch@google.com>
Date: Sat, 3 Oct 2026 11:53:17 +0000
Subject: [PATCH] sched_ext: Generate qseq from a per-task counter

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

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 582d7cd4a983..36c04797436c 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -207,6 +207,7 @@ struct sched_ext_entity {
 	s32			holding_cpu;
 	s32			selected_cpu;
 	s32			runnable_cpu;	/* cpu @p is runnable on, -1 if not */
+	u32			ops_qseq;	/* protected by rq lock */
 	struct task_struct	*kf_tasks[2];	/* see SCX_CALL_OP_TASK() */
 
 	struct list_head	runnable_node;	/* rq->scx.runnable_list */
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 5209510d6a5e..ac8fe70a9fb6 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2057,8 +2057,14 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
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
@@ -6969,9 +6975,9 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	seq_buf_init(&ns, buf, avail);
 
 	dump_newline(&ns);
-	scx_dump_line(&ns, "CPU %-4d: nr_run=%u flags=0x%x cpu_rel=%d ops_qseq=%lu ksync=%lu",
+	scx_dump_line(&ns, "CPU %-4d: nr_run=%u flags=0x%x cpu_rel=%d ksync=%lu",
 		      cpu, rq->scx.nr_running, rq->scx.flags, rq->scx.cpu_released,
-		      rq->scx.ops_qseq, rq->scx.kick_sync);
+		      rq->scx.kick_sync);
 	scx_rescue_dump(&ns, rq);
 	scx_dump_line(&ns, "          curr=%s[%d] class=%ps",
 		      rq->curr->comm, rq->curr->pid, rq->curr->sched_class);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 1df8f583b0ec..5b37faa532d6 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1998,6 +1998,11 @@ enum scx_ops_state {
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
index 742cce9da4e9..9ed0cb605c33 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -813,7 +813,6 @@ struct scx_rq {
 #endif
 	struct list_head	runnable_list;		/* runnable tasks on this rq */
 	struct list_head	ddsp_deferred_locals;	/* deferred ddsps from enq */
-	unsigned long		ops_qseq;
 	/* both stashed across the activate_task() in move_remote_task_to_local_dsq() */
 	u64			remote_activate_enq_flags;
 	struct scx_sched	*remote_activate_sch;

