Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408D33B05B5
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342279; cv=none; b=CDvt/mtOmFa95j8Gs/shXGSNjkmUo64vDrRdp0HMoU8B1bhyseKL5PBFScdRqNj6kTJSQxDr/iCpmt8xolXOLNXva52IjtafhJkK7Dgs5pgrSF22KUHogAojtnMs3V91WMSWqhZgxIiw2jluBOoE4m6yD29NDa9fsfXmfN65MmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342279; c=relaxed/simple;
	bh=v48CHed74aBTLDhAMMnrcGCDn6LTvmpdQYxgqqn1aaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcfxfk6sNfBlfquS43ZD199gGSpzEiCBK7G6oIfS012LkrOSpcWjIDbT52CIXruvg1IjE3oI88djYmy8im5nQrIY/ivlXUQ9OODSxCBgRb/590ynW/46soUckwomWPh1HO0XY8GhLJiVGfKTP/HCPEl6SrocCw3RWHVD8mI9Heg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmmLr9Wx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmmLr9Wx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7543A1F00ACF;
	Wed, 29 Jul 2026 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785342276;
	bh=vanVzq1o8P9KN4oPG3r3MGVZZlYoI6CetactMB89orc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LmmLr9Wxi8P7LVWtgocJoTdFBeWywWCQEUku+4NF8RdE8y0LpdeT4Bntt94ebU6eD
	 JuhN3xG0ECg3ccyqQr+hpuGmiqeSkK9g7qWIJNOf6wPRhITq4nRg9u2RXxXE1xly+6
	 54FEla4fHf/tddUfOvPMel/2AZ9Ur+ktkse6s+qTgBCMm2ChLqOnPuiP2P9QkJCRcX
	 gFwJQr48iNyCTBFKd+a9uOlFeOU2rRZ/9b02+kLnhh7lLzJ+KuWK9n3mkhsAXigZKv
	 TRjOOCWBF84X7XUFW/20gi1nzJlr2XT/gNnITD1lOTDG4pI1ZCRVXx/jNGqGCdixEw
	 /b7CB2yOD3gow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/2] sched_ext: Preserve rq tracking across local DSQ dispatch
Date: Wed, 29 Jul 2026 12:24:33 -0400
Message-ID: <20260729162433.3523095-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729162433.3523095-1-sashal@kernel.org>
References: <2026072116-antivirus-displace-b981@gregkh>
 <20260729162433.3523095-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrea Righi <arighi@nvidia.com>

[ Upstream commit 18d62044cda7a2b40f59d910659c0b0d6accad37 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index dc6138461ae3de..07e2c40b788dcc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -438,6 +438,18 @@ static bool rq_is_open(struct rq *rq, u64 enq_flags)
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
  * SCX ops can recurse via scx_bpf_sub_dispatch() - the inner call must not
  * clobber the outer's scx_locked_rq_state. Save it on entry, restore on exit.
@@ -2262,8 +2274,7 @@ static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 	deactivate_task(src_rq, p, 0);
 	set_task_cpu(p, cpu_of(dst_rq));
 
-	raw_spin_rq_unlock(src_rq);
-	raw_spin_rq_lock(dst_rq);
+	switch_rq_lock(src_rq, dst_rq);
 
 	/*
 	 * We want to pass scx-specific enq_flags but activate_task() will
@@ -2594,9 +2605,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 
 	/* switch to @src_rq lock */
 	if (locked_rq != src_rq) {
-		raw_spin_rq_unlock(locked_rq);
+		switch_rq_lock(locked_rq, src_rq);
 		locked_rq = src_rq;
-		raw_spin_rq_lock(src_rq);
 	}
 
 	/* task_rq couldn't have changed if we're still the holding cpu */
@@ -2624,10 +2634,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
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
@@ -8360,10 +8368,8 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
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
@@ -8395,10 +8401,8 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
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
-- 
2.53.0

