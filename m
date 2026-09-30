Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B54E06D3
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781021; cv=none; b=tZRvrsO6ISFRBH8lfJG69yCfxGlcghbV1WmoLm1FSFWFNTQPrgkqB2m0/MJ9dabIJfYMco1QeuN4L9DpNtxnk5KQmhfRe7YwZ3z3KVyCKEMCGKagwgLYBY6HuPMcQJOlzevRk0WM1NxekttnOW+38plNPWX1cyuivd1lspsbT7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781021; c=relaxed/simple;
	bh=+dIcck7g2THqZtrsHsH6a7JurY9RcfVCAx3E1tXXCLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyka8zrSCpNA2PqYyvK6YySV4XnfUM8zblMp/Dw/cs4d5JXLWcliyowStmSFkcRttS3zXLC0FIyyfWJsFuK7dd0k/WNVsgzTnBaKyPNVfqCtuXiIWgzF3L9A7peuBXuaH1GonalU3vPBZY6ULecajDeDCTFEFWtJ4tK7TbIQbE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUISOZzz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUISOZzz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA621F0089C;
	Wed, 30 Sep 2026 15:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780984;
	bh=alsB2fNYWOSFcl5EX9EV1sZ180efRTuaOaQ4rtB8yvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FUISOZzzYoazaVUCKKW+nxj1AN36wD22lk+W7sthEZjDlZV1jFwh7ouy64LCdiAet
	 ZsQtpeUgQv4QszyJJMmamTMtUI//5NyMC8cYBJjh/+uuHWsQKtvJKmHyx8XikFY8oH
	 2CvxGdBAkrJETnTcxsQyGvii92UmNG/REfMZ47KB32l+p5JxjX6muSCQ7hjSkduFCM
	 M9QYoTj9HfZrukPLpg6ze5LEMTAfpGs74DLuwyAQZd4jcKDM4Jh8AdOkCvqe/Ao7O9
	 S09GCbUt0mSD02tjMlxxF4OYWMr3neGgEO5lyJLxBlT1ddWmDVn6J3+f/GyBbK8b+H
	 FNzdA2c8+WATQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] sched_ext: Wait for SCX_OPSS_DISPATCHING before reenqueueing a task
Date: Wed, 30 Sep 2026 11:09:41 -0400
Message-ID: <20260930150941.2349228-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930150941.2349228-1-sashal@kernel.org>
References: <2026092920-protector-confused-2f3e@gregkh>
 <20260930150941.2349228-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 7de9a6fb44eae4f05e68c805d58b9c618815adfa ]

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
[ inlined scx_reenq_wait_dispatching() into the existing reenqueue functions. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext/ext.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 665825f1d1ff4..2080e0c1edbcb 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4295,6 +4295,14 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 		if (!local_task_should_reenq(p, &reenq_flags, &reason))
 			continue;
 
+		/*
+		 * The dispatcher stores the final ops_state after dropping the DSQ
+		 * lock, so @p can be found on a DSQ while still
+		 * %SCX_OPSS_DISPATCHING. Reenqueueing @p before that store lands
+		 * would have it clobber the new %SCX_OPSS_QUEUED.
+		 */
+		if (unlikely(atomic_long_read_acquire(&p->scx.ops_state) == SCX_OPSS_DISPATCHING))
+			wait_ops_state(p, SCX_OPSS_DISPATCHING);
 		dispatch_dequeue(rq, p);
 
 		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
@@ -4417,6 +4425,8 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
 		}
 
 		/* @p is on @dsq, its rq and @dsq are locked */
+		if (unlikely(atomic_long_read_acquire(&p->scx.ops_state) == SCX_OPSS_DISPATCHING))
+			wait_ops_state(p, SCX_OPSS_DISPATCHING);
 		dispatch_dequeue_locked(p, dsq);
 		raw_spin_unlock(&dsq->lock);
 
-- 
2.53.0

