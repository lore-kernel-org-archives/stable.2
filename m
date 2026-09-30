Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB2C140E5F
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772332; cv=none; b=KAdvY1Hl1GKx9+NaO3erV8+debx7PfovF/mzeaSQQj5qebdIQw/mxVSPLIl9MpXFjIn92VQBikXCQz3oCPedebvNSP5UMOddYLPn+/B5NONmFqlHqRFmjf10o89Mxr52AUKt0ddZbYAOIuxqj/LB29qLQ7sKdmCc9l6ag/Cspgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772332; c=relaxed/simple;
	bh=Xwj1lrWNlv25oTnljI5tRA+GH4HPGndy2OP6vFna2IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXmOYqU+tHUS3aZ0znczVMtKBhbTI4eLzVCIIVaSa3fu1fh6DqBHZemiGOsvgYOMqFleb3+j+YncwR6zZSXTR+5I1ZckXNw3t1+p5JXPBgIIN8fo2xCBkvWxuringB9rLbK0p+A03NtjAdMZxFiFEtkC1G8LSnwaDmeKy63s3M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltdw5UrZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltdw5UrZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A621F000FF;
	Wed, 30 Sep 2026 12:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790772330;
	bh=Hb7H1E8IlsObi7pk0YHwdlbBS+HuWoO/wmtmgZPFw+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ltdw5UrZcHy2hf6rKwZsfSNeUnTJ+Ya/QrBDI6nVooXGqDS0m744ye+rru4oAMOF0
	 CbmVqWWgFonfcMsoOWl+rNr9Cq1hKygCmHeClm/5yqtjwYtw68MSdVHOQZyltiFfF7
	 k6uft1VADNMMuMtFczR9lpFqp7+90lgw+jlwY07R9YXrBd7eQNR2696laRQ87ehCJg
	 D4RDqxiXNvKVxyomj1EupR3EX6xs0rjDduduCNYkLUe4UgoEtdyn8F5CXjZnJEQexD
	 yRmYKtkjfyFeOQcPjEoCQzeR26U8HCz01PItbotqmSM52lhEMVpGDa4mTWrZJOlEgv
	 k5N99f70fg1qA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] sched_ext: Derive SCX_RQ_IN_WAKEUP from the core enqueue flags
Date: Wed, 30 Sep 2026 08:45:28 -0400
Message-ID: <20260930124528.1670574-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092935-grating-eloquence-e564@gregkh>
References: <2026092935-grating-eloquence-e564@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit df5cdc2c832ca4e8a6d774596b9005558761a403 ]

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
[ Retargeted the patch to kernel/sched/ext.c with its older extra_enq_flags context. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 812e0c34bb801..059675018c718 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1382,7 +1382,12 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 	int sticky_cpu = p->scx.sticky_cpu;
 	u64 enq_flags = core_enq_flags | rq->scx.extra_enq_flags;
 
-	if (enq_flags & ENQUEUE_WAKEUP)
+	/*
+	 * SCX_RQ_IN_WAKEUP promises a task_woken_scx() call once this enqueue
+	 * returns. Only the core's wakeup path delivers one. The flags stashed
+	 * for a remote activation may carry the wakeup bit without it.
+	 */
+	if (core_enq_flags & ENQUEUE_WAKEUP)
 		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
 
 	if (sticky_cpu >= 0)
-- 
2.53.0

