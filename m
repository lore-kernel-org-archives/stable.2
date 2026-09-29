Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B43516176
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682102; cv=none; b=aZYKIhQPWTip/hvWeXO3ADLrchOGtmHP7b6PR0wB+8Q7gGfXowgFGUtZmmW9GlHzKLGOOwQuDCIuZS5KZOBQ4vqye/XmryVZZBWBuqKkekugrWotqvqB1VB3ikTg4T3jye5Gb7Yr74PfOE/tbjNvO8Cbx6OdEYueDrsgAVz7U3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682102; c=relaxed/simple;
	bh=F7i078Hah50I/Qxbz02ezUCS7DQXsVrsmLG/JpuKsxQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T8OfxCdOyOHAPxmQ9BW9Pt3VOvX18tVDPyiYZTQlm0TjrJiR3g9XgDzt/Y4RvmYqBRKiitY8sia59ZS+InIjVpo7O5q/39U8T+y0ImTDFt3BhrImo2z90piiVYvks6tSX3h01Oa3vsLR/vqxvslLH8ykcY0YU0u9y6CReOC/RbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q2/3wY6v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q2/3wY6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6A71F000FF;
	Tue, 29 Sep 2026 11:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682100;
	bh=NjvEO4NKNro73+iVwiGi0qioqsKvkRmOb8naXMFF7DM=;
	h=Subject:To:Cc:From:Date;
	b=q2/3wY6v72PubIWAS5IZquVaQOq7fefcLNZkcmpMQKydQUXjboRr7CBOHmP8rJl3I
	 3WPUhzYBl6jID4DNheQKpsyKhtUhlnpp653PXzDvWdZrusAaTaCPZnX68vbvtavxni
	 Jz0yqujxPCYbE5G/NPFqQgbBVc8PvJc2/tG25AE8=
Subject: FAILED: patch "[PATCH] sched_ext: Derive SCX_RQ_IN_WAKEUP from the core enqueue" failed to apply to 6.18-stable tree
To: tj@kernel.org,arighi@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:41:35 +0200
Message-ID: <2026092935-grating-eloquence-e564@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x df5cdc2c832ca4e8a6d774596b9005558761a403
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092935-grating-eloquence-e564@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From df5cdc2c832ca4e8a6d774596b9005558761a403 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 16 Sep 2026 12:00:24 -1000
Subject: [PATCH] sched_ext: Derive SCX_RQ_IN_WAKEUP from the core enqueue
 flags

schedule_deferred_locked() skips scheduling a deferred action while
SCX_RQ_IN_WAKEUP is set and relies on the task_woken_scx() call that follows
a wakeup enqueue to run it. enqueue_task_scx() sets the flag from the merged
enqueue flags, which include the flags stashed for a remote activation.
move_remote_task_to_local_dsq() thus sets SCX_RQ_IN_WAKEUP on the
destination rq when the moved task was woken up, although no
task_woken_scx() follows that activation.

An IMMED insert into a busy destination requests a local reenqueue during
that enqueue. The request gets linked but not scheduled and stays pending
until an unrelated wakeup or preemption on that CPU runs the deferred
actions. The IMMED task sits behind the running task in the meantime. If
nothing runs them before the scheduler is disabled, the request outlives the
scheduler and points into its freed per-cpu area, which the next scheduler
dereferences from run_deferred().

Test the core enqueue flags for the wakeup bit. Only the core's wakeup path
is followed by task_woken_scx().

Fixes: 57ccf5ccdc56 ("sched_ext: Fix enqueue_task_scx() truncation of upper enqueue flags")
Cc: stable@vger.kernel.org # v7.1+
Reported-by: Andrea Righi <arighi@nvidia.com>
Link: https://lore.kernel.org/all/20260916145807.3250167-1-arighi@nvidia.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 725b890fcab9..e207ccd17164 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2141,7 +2141,12 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 	int sticky_cpu = p->scx.sticky_cpu;
 	u64 enq_flags = core_enq_flags | rq->scx.remote_activate_enq_flags;
 
-	if (enq_flags & ENQUEUE_WAKEUP)
+	/*
+	 * SCX_RQ_IN_WAKEUP promises a task_woken_scx() call once this enqueue
+	 * returns. Only the core's wakeup path delivers one. The flags stashed
+	 * for a remote activation may carry the wakeup bit without it.
+	 */
+	if (core_enq_flags & ENQUEUE_WAKEUP)
 		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
 
 	/*

