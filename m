Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32F64A0F1E
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818738; cv=none; b=epHUojduXV8u+FfVJi8qVyQcDqVGe4Jd86MkdkzwwHXKiv6jPMKJrOIMgqf+6VC0KJfUWz9VAB1zzTinLK/lPsgDhqdyIp//CU57gVQu8KJ2dj6DF7p1OUEZordF72ERKBAyZW9zq8Ag+uYQoR7Mth193IgaRtLVnAJVQAN8ed4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818738; c=relaxed/simple;
	bh=+WTBSze0CyjLQrPqY+5jeyi9F2WIyPfzcDO/JnSOH60=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M/57Ylcen+z1AXjC0KLfO7CGi79g3FowjNbSMMvME4+ZRFLHAdxk2gG2vzwzfsk1gYlaqpbpPk1Dir0cZ/nr9WT++1Gv0WlYIract6HmAPmsbjQ0VklYto+Uj6flJQVi7aENzb9FuNAalRdo3jGpz/n223V8neNILVAdwwdZKAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iwoJk3Ap; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iwoJk3Ap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B064E1F0089C;
	Mon, 12 Oct 2026 15:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791818734;
	bh=xbt+EveacZn/LpGLPqh+oDkJ+LaEDaOVarMRpAuNCYo=;
	h=Subject:To:Cc:From:Date;
	b=iwoJk3Ap+vDzmW7t6iZQLov4XOh7Z+/BncSqclT6vKPP5HNAL3q2Z4SLrd63pS80y
	 FI+ndM2ANLsh0LmjilZ0tHr+qGfRzTrCYJpnaWaLMCQl/F0oSByBDk0qzF2D5kMfoB
	 SVpA0A57zBabziTMref+IqulxMNp3crsKJWA6yOQ=
Subject: FAILED: patch "[PATCH] sched_ext: Call ops.dequeue() when a task arrives on a remote" failed to apply to 7.2-stable tree
To: jpiecuch@google.com,arighi@nvidia.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:25:33 +0200
Message-ID: <2026101233-atlantic-thwarting-31cc@gregkh>
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
git cherry-pick -x af701b8d3238b9eb7cd450b0491300452c700bf5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101233-atlantic-thwarting-31cc@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From af701b8d3238b9eb7cd450b0491300452c700bf5 Mon Sep 17 00:00:00 2001
From: Kuba Piecuch <jpiecuch@google.com>
Date: Wed, 30 Sep 2026 14:23:58 +0000
Subject: [PATCH] sched_ext: Call ops.dequeue() when a task arrives on a remote
 local DSQ

When a task in the BPF scheduler's custody is moved to another CPU's
local DSQ, ops.dequeue() is only called once the task is picked for
execution, from set_next_task_scx() with SCX_DEQ_CORE_SCHED_EXEC, even
though no core-sched pick took place. It should instead be called
without flags when the task is inserted into the destination DSQ, as it
is for same-rq dispatches.

move_remote_task_to_local_dsq() sets p->scx.sticky_cpu across the
migration so that deactivate_task() on the source rq doesn't end custody.
Since commit b75aaea24c9f ("sched_ext: Properly mark SCX-internal
migrations via sticky_cpu"), enqueue_task_scx() only clears it after
inserting the task, so task_leave_custody() still sees the migration in
progress and skips the custody exit.

Clear p->scx.sticky_cpu as soon as enqueue_task_scx() has read it, as
was done before that commit. The source side is unaffected.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Cc: stable@vger.kernel.org # 7.1.x: 18d62044cda7: sched_ext: Preserve rq tracking across local DSQ dispatch
Cc: stable@vger.kernel.org # 7.1.x
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 493b7aac7087..5209510d6a5e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2152,6 +2152,13 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 	int sticky_cpu = p->scx.sticky_cpu;
 	u64 enq_flags = core_enq_flags | rq->scx.remote_activate_enq_flags;
 
+	/*
+	 * An SCX-internal migration ends on arrival. Clear sticky_cpu so @p can
+	 * leave custody when inserted into the destination DSQ.
+	 */
+	if (sticky_cpu >= 0)
+		p->scx.sticky_cpu = -1;
+
 	/*
 	 * SCX_RQ_IN_WAKEUP promises a task_woken_scx() call once this enqueue
 	 * returns. Only the core's wakeup path delivers one. The flags stashed
@@ -2190,9 +2197,6 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 		dl_server_start(&rq->ext_server);
 
 	scx_do_enqueue_task(rq, p, enq_flags, sticky_cpu);
-
-	if (sticky_cpu >= 0)
-		p->scx.sticky_cpu = -1;
 out:
 	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
 

