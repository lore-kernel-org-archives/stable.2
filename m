Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D403C6606
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625447; cv=none; b=SVHYrZU8jwcj1FSCL1jViHZ2jA8OIG57wJmuZcmG1bgNc2i5fC7RtrLxYTVA7W+oOeQ3Bo6iTkqR9NUuuH7MoiClQkJUQDSW4C0EI3RsBYxOJa/EZZleo5ma4qAP7aNIyqYz3vZVJicHTiF63u0O9x8NYkMUaINT+SNLD9lrHXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625447; c=relaxed/simple;
	bh=S96ll6v17ex1V1Y55S6QAAmtCqj17D4riqeiFk/zkLg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KHNZMuBasM9uLR+l8zGelpxd2tcNvZs1rqDz9BZf4ZtgpPwEcKgLaBjP4NmQhspg58joFeD3ffczbc28cCnQtMjgAOo2P7kkzamjTsib1rj7BdogIWYn9ysBi8jIKF5kXEDRZlPz2f+N3Xf6hiZHqmb4690fBrO44BWJDju+YrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M/07x3NC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M/07x3NC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A421F000E9;
	Tue, 21 Jul 2026 09:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784625445;
	bh=7tiTFplqu3Xn2PQhwFMQeioXUugscnaUbMUj3oZHYZ8=;
	h=Subject:To:Cc:From:Date;
	b=M/07x3NCXdZANse0WY/C9ojvcxVijfn8OlJVNyEjhl6hM3bk6Xs7s0nKrKP/FfMgH
	 IbNL5wFIj9AXQ7pUirFnFxlDh0VKXE+HOiE1RJyAOGZun4hiM8dhdq071IAUfMYj95
	 J62nemNRizbT+78pSp+uWGmS7daJgQCWosrD9DcY=
Subject: FAILED: patch "[PATCH] sched_ext: Preserve rq tracking across local DSQ dispatch" failed to apply to 7.1-stable tree
To: arighi@nvidia.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:17:16 +0200
Message-ID: <2026072116-antivirus-displace-b981@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 18d62044cda7a2b40f59d910659c0b0d6accad37
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072116-antivirus-displace-b981@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 18d62044cda7a2b40f59d910659c0b0d6accad37 Mon Sep 17 00:00:00 2001
From: Andrea Righi <arighi@nvidia.com>
Date: Wed, 8 Jul 2026 10:43:27 +0200
Subject: [PATCH] sched_ext: Preserve rq tracking across local DSQ dispatch

dispatch_to_local_dsq() can run from scx_bpf_dsq_move_to_local() while
ops.dispatch() has recorded the current rq. Moving a task to a local DSQ
may switch to the source or destination rq before synchronously invoking
ops.dequeue() through the following path:

  SCX_CALL_OP(dispatch, rq)
    ops.dispatch()
      scx_bpf_dsq_move_to_local()
        scx_flush_dispatch_buf()
          finish_dispatch()
            dispatch_to_local_dsq()
              scx_dispatch_enqueue()
                local_dsq_post_enq()
                  call_task_dequeue()
                    SCX_CALL_OP_TASK(dequeue, locked_rq, ...)

The nested callback saves the recorded rq and restores it on return. If
the rq tracking does not follow the lock switch, update_locked_rq() can
trigger the following lockdep assertion while restoring an rq which is
no longer held:

  WARNING: kernel/sched/sched.h:1641 at call_task_dequeue+0x160/0x170
  Call Trace:
    scx_dispatch_enqueue+0x2b0/0x460
    dispatch_to_local_dsq+0x138/0x230
    scx_flush_dispatch_buf+0x1af/0x220
    scx_bpf_dsq_move_to_local___v2+0xe2/0x1c0
    bpf__sched_ext_ops_dispatch+0x4b/0xa7
    do_pick_task_scx+0x3b6/0x910
    __pick_next_task+0x105/0x1f0
    __schedule+0x3e7/0x1980

Introduce switch_rq_lock() to update the tracking state together with
each rq lock handoff. Use it in dispatch_to_local_dsq(),
move_remote_task_to_local_dsq() and the in-balance paths of
scx_dsq_move(), ensuring that scx_locked_rq() consistently refers to the
rq whose lock is actually held throughout the lock dance.

Fixes: 7fb39e4eb4c3 ("sched_ext: Save and restore scx_locked_rq across SCX_CALL_OP")
Cc: stable@vger.kernel.org # 7.1+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e75e2fd5ab7e..ee66dacfc92c 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -479,6 +479,18 @@ static bool rq_is_open(struct rq *rq, u64 enq_flags)
  */
 DEFINE_PER_CPU(struct rq *, scx_locked_rq_state);
 
+static void switch_rq_lock(struct rq *from, struct rq *to)
+{
+	bool tracked = scx_locked_rq() == from;
+
+	if (tracked)
+		update_locked_rq(NULL);
+	raw_spin_rq_unlock(from);
+	raw_spin_rq_lock(to);
+	if (tracked)
+		update_locked_rq(to);
+}
+
 /*
  * Flipped on enable per sch->is_cid_type. Declared in internal.h so
  * subsystem inlines can read it.
@@ -2274,8 +2286,7 @@ static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 	deactivate_task(src_rq, p, 0);
 	set_task_cpu(p, cpu_of(dst_rq));
 
-	raw_spin_rq_unlock(src_rq);
-	raw_spin_rq_lock(dst_rq);
+	switch_rq_lock(src_rq, dst_rq);
 
 	/*
 	 * We want to pass scx-specific enq_flags but activate_task() will
@@ -2608,9 +2619,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 
 	/* switch to @src_rq lock */
 	if (locked_rq != src_rq) {
-		raw_spin_rq_unlock(locked_rq);
+		switch_rq_lock(locked_rq, src_rq);
 		locked_rq = src_rq;
-		raw_spin_rq_lock(src_rq);
 	}
 
 	/* task_rq couldn't have changed if we're still the holding cpu */
@@ -2644,10 +2654,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	}
 
 	/* switch back to @rq lock */
-	if (locked_rq != rq) {
-		raw_spin_rq_unlock(locked_rq);
-		raw_spin_rq_lock(rq);
-	}
+	if (locked_rq != rq)
+		switch_rq_lock(locked_rq, rq);
 }
 
 /**
@@ -8825,10 +8833,8 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	in_balance = this_rq->scx.flags & SCX_RQ_IN_BALANCE;
 
 	if (in_balance) {
-		if (this_rq != src_rq) {
-			raw_spin_rq_unlock(this_rq);
-			raw_spin_rq_lock(src_rq);
-		}
+		if (this_rq != src_rq)
+			switch_rq_lock(this_rq, src_rq);
 	} else {
 		raw_spin_rq_lock(src_rq);
 	}
@@ -8860,10 +8866,8 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	dispatched = true;
 out:
 	if (in_balance) {
-		if (this_rq != locked_rq) {
-			raw_spin_rq_unlock(locked_rq);
-			raw_spin_rq_lock(this_rq);
-		}
+		if (this_rq != locked_rq)
+			switch_rq_lock(locked_rq, this_rq);
 	} else {
 		raw_spin_rq_unlock_irqrestore(locked_rq, flags);
 	}

