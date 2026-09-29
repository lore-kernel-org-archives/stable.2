Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C32A514770
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682210; cv=none; b=s0/mJAiFUO3O5vDiTfMkVKGUThwYTL6anKIwyY+zt7z/vlCG8MOv0myXEr/7lcO8UUWbZj94jUD3dR8+hCPiGDvkujE5v8M3fjtaC1LT/x5hJrRXQD9t6gFsdkYx5Nr1T09J+xAewCnC8Ddd68qPXbnG3mQbm+psfe2dEEiM624=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682210; c=relaxed/simple;
	bh=nGelux3qL8y17/fNXQ9n8PK1l/WQQ3FydasJbxxGef4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hBmcSsdM8Gu3SRnuWnIBiB46cZybTdfliXs8ZgiVzSneHWaybCk5RsmxFaqUnaUvK8JrBzaoxRxxBfjilTiPKqZ9eHAeZWGZxcYtZRChTIUNgA+yTaTj0XVmm2HkBd0pRJZ2cgERDsgIh5vi8I1guXuh/XZo6EYcHhOqHE5m1NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=beY1SSOn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="beY1SSOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E5F1F000FF;
	Tue, 29 Sep 2026 11:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682208;
	bh=586ypL+wvE9FbCNe1Au+wAVLcf6fjJzfPGMlBECRh2Y=;
	h=Subject:To:Cc:From:Date;
	b=beY1SSOnZB0/WdvlO4DhnIn06+9nxi1HvKNSIfwRsdZwJ6AjizSCr33czwxAIxI/l
	 6+b3cWSOHBgvsa0mBvTXkXl1KS1SMlT9yIgkGAGhXGEomWSGnIFe2TyFAPTmPo0iE+
	 NB+B0rcTY+aOap7gHJgnNvCFPZFSs58R1wlFi2UQ=
Subject: FAILED: patch "[PATCH] sched_ext: Wait for SCX_OPSS_DISPATCHING before reenqueueing" failed to apply to 7.2-stable tree
To: tj@kernel.org,arighi@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:43:20 +0200
Message-ID: <2026092920-protector-confused-2f3e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 7de9a6fb44eae4f05e68c805d58b9c618815adfa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092920-protector-confused-2f3e@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7de9a6fb44eae4f05e68c805d58b9c618815adfa Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 15 Sep 2026 12:34:44 -1000
Subject: [PATCH] sched_ext: Wait for SCX_OPSS_DISPATCHING before reenqueueing
 a task

ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics") moved the final
ops_state store in scx_dispatch_enqueue() after the DSQ unlock so that the
custody update and ops.dequeue() precede it. A task can thus be found on a
DSQ while still SCX_OPSS_DISPATCHING.

The dequeue and core-sched pick paths wait for the state to clear in
ops_dequeue() but the reenqueue paths don't. A reenqueue in that window runs
ops.enqueue() and sets SCX_OPSS_QUEUED before the dispatch has completed.
The dispatcher's final store then overwrites it with SCX_OPSS_NONE and
finish_dispatch() drops every later dispatch of the task.

Wait for SCX_OPSS_DISPATCHING to clear before dequeueing a task for
reenqueue, the same way ops_dequeue() does.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 70b711c4de6e..725b890fcab9 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4404,6 +4404,17 @@ static bool local_task_should_reenq(struct rq *rq, struct task_struct *p,
 	return *reenq_flags & SCX_REENQ_ANY;
 }
 
+/*
+ * The dispatcher stores the final ops_state after dropping the DSQ lock, so @p
+ * can be found on a DSQ while still %SCX_OPSS_DISPATCHING. Reenqueueing @p
+ * before that store lands would have it clobber the new %SCX_OPSS_QUEUED.
+ */
+void scx_reenq_wait_dispatching(struct task_struct *p)
+{
+	if (unlikely(atomic_long_read_acquire(&p->scx.ops_state) == SCX_OPSS_DISPATCHING))
+		wait_ops_state(p, SCX_OPSS_DISPATCHING);
+}
+
 static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 {
 	LIST_HEAD(tasks);
@@ -4447,6 +4458,7 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 		if (!local_task_should_reenq(rq, p, &reenq_flags, &reason))
 			continue;
 
+		scx_reenq_wait_dispatching(p);
 		scx_dispatch_dequeue(rq, p);
 
 		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
@@ -4570,6 +4582,7 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
 		}
 
 		/* @p is on @dsq, its rq and @dsq are locked */
+		scx_reenq_wait_dispatching(p);
 		dispatch_dequeue_locked(p, dsq);
 		raw_spin_unlock(&dsq->lock);
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 3464e0f113c1..115c96fbf932 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2078,6 +2078,7 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
 u64 __scx_bpf_now(struct rq *rq);
 void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			u64 reenq_flags, struct rq *locked_rq);
+void scx_reenq_wait_dispatching(struct task_struct *p);
 int __scx_init_task(struct scx_sched *sch, struct task_struct *p,
 		    struct cgroup *cgrp, bool fork);
 void scx_enable_task(struct scx_sched *sch, struct task_struct *p);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index f7aeb1488566..a30c965b175d 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -801,6 +801,7 @@ void scx_reenq_reject(struct rq *rq)
 		if (WARN_ON_ONCE(p->migration_pending))
 			continue;
 
+		scx_reenq_wait_dispatching(p);
 		scx_dispatch_dequeue(rq, p);
 
 		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))

