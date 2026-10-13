Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886A2368D41
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882156; cv=none; b=qdWolPpqVWuyO6RBmKHBuCOCHPqVIkCCj9Quf4dNuzWnS39/VJ89uLbazMmq0Yf1VD2pKmaXXrq6P31jSmGXvd1unA8zsckU2207UY7bdqAiyij2wlRZeJ2TWFd2rsQ0VIOE3Gh6UPm8224M1YqqjA05f3erSijRFDH+a4hv8jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882156; c=relaxed/simple;
	bh=bEMfi14iNZlFPVJEvFx6rjDHjeEbg16oQ6iVpVKJYP4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oOExNVGzeYbrSDRGZTqF0U/XXE1z27TGZHZbgghYbfX9QQeC/kQaCcVLkKhso95jY9SmIilCqOXz2KM9GrJ92qw9SNNFYeBfL2clODAgAdC2x7vfKnfkylKS9TadQSCi2gWlp9eB8xdhzJtD9+f7UCjWiXLcWUkjGwm1yedkFbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IPnKKmly; arc=none smtp.client-ip=209.85.218.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IPnKKmly"
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c2e46c2a14bso282036466b.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791882153; x=1792486953; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8GdDy8FyaiVjo0NI/RO9ZfylaWZ9QX9qjzii64dBPaI=;
        b=IPnKKmly/bJ3R6erYDFX+irnrbr7uCOtqnbppATaLDpQJBy2k/qY+kmEDkvo8hZ/Ph
         3nJDtxJm8xyqEo09YYfjycQL2hi3ZxvwCC4GQF//qJOmwHI99b73PdLkyJFokkcMMSu2
         BDcQh0zQhRpp9JO8ARfrMH3vdkUFCEqUJoZRJ2+lwrT/zMY+sqdPLm4xWJpwoPdEuarB
         0/RHcIFq2nVNO+y2fQ+EkTJDmztrAQgt3iMEcYEMelanAjMA+g/4hPrLczXupS915nsd
         2Phy13IhrplSfr9asZq4d7p2sPvWNtOdhJ7KJGSCz66IAopr0BSdDaldzY5/EA+2neax
         bOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791882153; x=1792486953;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8GdDy8FyaiVjo0NI/RO9ZfylaWZ9QX9qjzii64dBPaI=;
        b=oVKZhNAFrh8Wf1B0iHwCXaZdKUIyPXzuEDdXyYwX9Tj6eLbqW/O4gVF8SbRguarBkg
         yBf5QKutMs1IuRzMaqy4Rc9ca99Ut29TUGoMg6Se83e8Vh52d+zUnkHbK7xZBlq/AWbM
         Z2QginuCmSW2nEHbWtsNa1xyDO6+zttbkgaamS/jPchn0XBfliWuv2x4f9QIWbx2CQEn
         HD+72pYf2Q9vrpm7ZQa7rJhUHU5/tHNqXBjznk/B+QqbdP0AOe24Oy+N3tmQgUE3HoeZ
         KtkXE4VI0JOWVJT6jtYVupG7kclvSfNo983XIM8gW3STTalqj/1DhZIvh4minEMKVtJo
         2fpA==
X-Gm-Message-State: AFq9FYIYWyTF4Vq0e/IH25UhF4UHSUUhu7aCMRzs71XM6Zxfsqx950TX
	sUDx8t4Biwj3pfEsA2KVd1WGxKNB/dhIXRInGaax5Mnf7NEv7Q7jhIrIpI9t6q8lhkLj1ZZxiwK
	B2jbv0Y6NrVDlkd5/1nGP4pjAbTaLcok0MeqLihUBAHg9S8Q8AfCQwb1FtxMOQ6hZwalc/oiZbA
	VUVey7z+U+YJKb5c1EphlSQ3j/I/SfvkFXi4TPUOhNkT6LVhY=
X-Received: from wrbfa9.prod.google.com ([2002:a05:6000:2589:b0:488:6ef3:8bb0])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6d27:b0:c2d:d019:d414 with SMTP id a640c23a62f3a-c31aa07b576mr1011488666b.29.1791882152284;
 Tue, 13 Oct 2026 02:02:32 -0700 (PDT)
Date: Tue, 13 Oct 2026 09:02:25 +0000
In-Reply-To: <2026101218-botch-overbook-03a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026101218-botch-overbook-03a8@gregkh>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013090229.3584603-2-jpiecuch@google.com>
Subject: [PATCH 6.12.y] sched_ext: Generate qseq from a per-task counter
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
[ jpiecuch: code lives in kernel/sched/ext.c and do_enqueue_task(); adjust
  struct/dump line context, name scx_bpf_dispatch() in the new comment ]
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 include/linux/sched/ext.h |  1 +
 kernel/sched/ext.c        | 20 +++++++++++++++-----
 kernel/sched/sched.h      |  1 -
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 2799e7284fff..880052a8f027 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -147,6 +147,7 @@ struct sched_ext_entity {
 	s32			sticky_cpu;
 	s32			holding_cpu;
 	u32			kf_mask;	/* see scx_kf_mask above */
+	u32			ops_qseq;	/* protected by rq lock */
 	struct task_struct	*kf_tasks[2];	/* see SCX_CALL_OP_TASK() */
 	atomic_long_t		ops_state;
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 40dbdfed42c9..3a1983ef278f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -835,6 +835,11 @@ enum scx_ops_state {
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
@@ -2040,8 +2045,14 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	if (!SCX_HAS_OP(enqueue))
 		goto global;
 
-	/* DSQ bypass didn't trigger, enqueue on the BPF scheduler */
-	qseq = rq->scx.ops_qseq++ << SCX_OPSS_QSEQ_SHIFT;
+	/*
+	 * DSQ bypass didn't trigger, enqueue on the BPF scheduler. Wrap the
+	 * per-task qseq counter where the QSEQ field wraps and skip 0, which is
+	 * what scx_bpf_dispatch() records for a task in NONE or DISPATCHING.
+	 */
+	p->scx.ops_qseq = ((p->scx.ops_qseq + 1) &
+			   (SCX_OPSS_QSEQ_MASK >> SCX_OPSS_QSEQ_SHIFT)) ?: 1;
+	qseq = (unsigned long)p->scx.ops_qseq << SCX_OPSS_QSEQ_SHIFT;
 
 	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
 	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
@@ -5053,10 +5064,9 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
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
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0073c5b7d07a..5e788dc39f63 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -796,7 +796,6 @@ struct scx_rq {
 	struct scx_dispatch_q	local_dsq;
 	struct list_head	runnable_list;		/* runnable tasks on this rq */
 	struct list_head	ddsp_deferred_locals;	/* deferred ddsps from enq */
-	unsigned long		ops_qseq;
 	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
 	u32			nr_running;
 	u32			flags;
-- 
2.56.0.385.gd3acb90ef8-goog

