Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594944;
	b=dHqLuIVk4AfBpnV2NZLJEqIOyx37y33nZfp6M8UIs5kWG6GvJGvPU+PL5U4yfPbVgs1a
	 gDwpWAC1eZGuHavM3nNyYtUywwwUCLU0ia2Q1f5iIfeu0fmILZ9Lr3jdjhKGS0CV/JPZe
	 VyEWi5TvQdEz8BR14195EpPUOpoG4uNWq3GjxG4X9FDwXMjYPvFhVV9ND0FTO2rS8Uzg2
	 qjyDB+vYvhhdI7jIiit0rXF4R8q8k40+ch2eJDcwLXOpyJ3pJPV4IZilwrgAbStwA+F6N
	 3Vbz2QEjo+CcaoirPmorXI67uWJGhkvM35TfVPFsG1yC3vkhprPJD2BdmyAiY/3eMgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594944;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dUCIexEMswk1vb0PiDy1woNXfEZGAnUVt2t9E+tC2FM=;
	b=ePLtTU8nX5/vxxl3E+0ZjVejtFCXzPKXNhRGGKni/k5SjQew6CYDu9j/Y2eQuWcJx8V6
	 g1hflz1bJNYpWeihaon8dB6JMQ3SU8vTtEHKcOBOrIvZWMInJTmuRVd/EHQYz2SwT8k6T
	 1Ioi7RakmhuVmKc2ZTEKDjZaX9B9aLU5RbklMq50n7GG6pxTRlHZrg2BPgGfAMMTwQDVl
	 WPD8NOvUj237KyqAMr6a9/j0TOH9C5ER6ZItbNV6v+ehBaC7WHRVMroW2AlkywFNi+dEr
	 DB3DH0BdHN+AZDBzca1KfZQ828GNpAAtsQ0a35jUkegUxuefdNWgGHbuL9K847FHBVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=m8b1se+J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3238B606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=m8b1se+J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FD91F000C2;
	Wed, 21 Oct 2026 15:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594944;
	bh=dUCIexEMswk1vb0PiDy1woNXfEZGAnUVt2t9E+tC2FM=;
	h=Subject:To:Cc:From:Date;
	b=m8b1se+JT7kGC/ZRplzWnpnuPKCp7+fdieD5836TIhSzrrGLwnS9+OKDCKcxalbGC
	 lRqAAZ8uCeBuNd2vxm9yPjTONtSwC/4yFiiURhBXhR59kYM67cxxVTV8AnZ+0FxZu4
	 hQ7chB9VgcSmGduztrBlDZ3QTQOXBzhK2n+JbduQ=
Subject: FAILED: patch "[PATCH] sched_ext: Wait for SCX_OPSS_DISPATCHING before moving tasks" failed to apply to 7.2-stable tree
To: jpiecuch@google.com,arighi@nvidia.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:50:09 +0200
Message-ID: <2026102109-rejoice-reboot-d810@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 2935062be77113c1c4565ca9d0c72180449aafee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102109-rejoice-reboot-d810@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2935062be77113c1c4565ca9d0c72180449aafee Mon Sep 17 00:00:00 2001
From: Kuba Piecuch <jpiecuch@google.com>
Date: Mon, 12 Oct 2026 21:07:46 +0000
Subject: [PATCH] sched_ext: Wait for SCX_OPSS_DISPATCHING before moving tasks
 off DSQs

A task can be found on a non-local DSQ while the CPU which dispatched it
is still running ops.dequeue() and hasn't cleared SCX_OPSS_DISPATCHING.
The DSQ consume and move paths don't wait for the dispatch to finish and
can operate on the task concurrently with the dispatcher.

Call scx_wait_dispatching() in scx_move_local_task_to_local_dsq(),
unlink_dsq_and_switch_rq_lock() and move_task_between_dsqs() before they
operate on the task. In scx_move_local_task_to_local_dsq(), wait before
scx_resolve_local_dsq() as it may update p->scx.flags.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Fixes: cb86607ada73 ("sched_ext: Don't run ops.dequeue() with a DSQ lock held")
Cc: stable@vger.kernel.org # v7.1+
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index cf6c9fead433..91120fc17d30 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2407,11 +2407,14 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 void scx_move_local_task_to_local_dsq(struct scx_sched *sch, struct task_struct *p,
 				      u64 enq_flags, struct rq *dst_rq)
 {
-	struct scx_dispatch_q *dst_dsq = scx_resolve_local_dsq(sch, dst_rq, p, &enq_flags);
+	struct scx_dispatch_q *dst_dsq;
 
 	lockdep_assert_rq_held(dst_rq);
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
+	scx_wait_dispatching(p);
+
+	dst_dsq = scx_resolve_local_dsq(sch, dst_rq, p, &enq_flags);
 
 	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
 		dsq_insert_head(dst_dsq, p);
@@ -2591,8 +2594,12 @@ static bool unlink_dsq_and_switch_rq_lock(struct task_struct *p,
 	switch_rq_lock(locked_rq, src_rq);
 
 	/* task_rq couldn't have changed if we're still the holding cpu */
-	return likely(p->scx.holding_cpu == cpu) &&
-		!WARN_ON_ONCE(src_rq != task_rq(p));
+	if (likely(p->scx.holding_cpu == cpu) && !WARN_ON_ONCE(src_rq != task_rq(p))) {
+		scx_wait_dispatching(p);
+		return true;
+	}
+
+	return false;
 }
 
 static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
@@ -2635,6 +2642,8 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 	lockdep_assert_held(&src_dsq->lock);
 	lockdep_assert_rq_held(src_rq);
 
+	scx_wait_dispatching(p);
+
 	if (dst_dsq->id == SCX_DSQ_LOCAL) {
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
 		if (src_rq != dst_rq &&

