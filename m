Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678751;
	b=aafnu18kh6SqBv1bQbUhAmSlcrA2/5T2bZKzpkitXsda9I0BqrJHJF+Oc1cLaeCzG3UE
	 +X1Z5lVuSQ+J2/jgXtnoCjVBSY1hXMFt3ZuWJ0VR5Da+4fm0WJbvb934aHOcHIC89itwp
	 q4ZCVF8jMQrSJLxrMxnHrWiCgikvWV4rAc0vaKL6cEMjnEunexOhv3+MSYMm2qnn7veG/
	 pPMCGN0xBteEdh4poPw5woe00g7G7a2Rje6ypn//+bOS148EHMsDCETjSaFZjk7gfeuK2
	 Yi6f9o7dqoo6WGaeRvhZUkA7ID5e8kd6XN7CnTjvhXfOo6IHQ1+ycYdfniBirLh/ycQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678751;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XVLJl6/F2raWBUV0gl06fxTC6SmLwzEIOWKACsZ0Rwc=;
	b=KMSD7gVIz8PgSJi9BIKwjwNOmvVdM/PXNG90QeT02DRf9+NsCGNaGYUMGw0IAL2uJvZe
	 w4DF768IeixBT/bxC9smHB/EXJlagUDTkFMa37bcNG5aTzDB0vqdbek6JVvXNJbHloQXv
	 L2aMHo+0wWPeGVR0yMoDa0XG3vyAb+rJlm8B02wEtL0gSNtorfdH9IepaI1evDA7MR9DB
	 QnhfJZWmG/WztlTM99DQvp/BXSYZYWVHBIsSOjHsyXSpfiBEvyjF8iOUhdaIzkhZaAspj
	 XIeCzR7jA5/D2Loin/Z6aQn5ssgvtEUWfLINGLe7X4xGBnjr1KKBLoPEZkhsRhJ/6Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXiMuZKi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C693B606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXiMuZKi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB641F000C2;
	Thu, 22 Oct 2026 14:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792678750;
	bh=XVLJl6/F2raWBUV0gl06fxTC6SmLwzEIOWKACsZ0Rwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PXiMuZKiGwc6/xm+QsowHqPw8BhKSHCKRP/z96XuXYst0VmREMWkK7EvoR3MbJoHS
	 coYDvv5bStXNy7yuS+1efQRr/VJTR5XxyX3iXu8ziHiR0z/uyG7T+e1CzcXx+W+1Wg
	 8sG08yFpImqY9+1WvQG7TJIYqLuMR23KNUrAhubwnyPDr9tVB3szRgB/MKkO6v+qwL
	 HuFgyLdpAzL0be6dfgYmnSd7yLQSZrlEyqsDVmfy7oYIYNvK1j0qCdxnJ18xRJnM7S
	 hJLon2LexYx6cidqUP/iVY2ohb6F9v19vUb0k/nXQTicaL9n9Cd5x3MVa6agQBduRD
	 KhaSSseioTglw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Xiangyu Bu <xbu@meta.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] sched_ext: Fix stall when a task enqueued with SCX_ENQ_LAST lands back on its CPU's local DSQ
Date: Thu, 22 Oct 2026 10:19:08 -0400
Message-ID: <20261022140850.1455884-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102101-kilogram-periscope-454b@gregkh>
References: <2026102101-kilogram-periscope-454b@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 7a9df76679633cf26e0fea882a684012c6ec245a ]

With SCX_OPS_ENQ_LAST, the last runnable task on a CPU is passed to
ops.enqueue() instead of being kept running. Exiting tasks without
SCX_OPS_ENQ_EXITING, migration disabled tasks without
SCX_OPS_ENQ_MIGRATION_DISABLED and tasks on an offline rq skip ops.enqueue()
and go straight to the local DSQ. This happens in put_prev_task_scx() after
the pick has settled on idle, so nothing reschedules the CPU, which idles
with the task queued until an unrelated wakeup lands on it or the watchdog
fires.

scx_mitosis, which sets SCX_OPS_ENQ_LAST without SCX_OPS_ENQ_EXITING, hit
this during mass cgroup teardown: exiting tasks stuck in exit_mmap() for
over 40 seconds.

A task put on the local DSQ runs, as anywhere else. If the SCX_ENQ_LAST
enqueue left the task on this CPU's local DSQ, set need_resched on the task
being switched in, as proxy_resched_idle() does. resched_curr() would flag
the task being put instead, and __schedule() clears that right after the
pick.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Reported-by: Xiangyu Bu <xbu@meta.com>
Link: https://github.com/sched-ext/scx/pull/3870
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
[ sashal: Relocated the hunks from separate source and header files into the monolithic sched_ext source file. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 876adf5568ed1..ded7a0dd2e533 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -730,8 +730,9 @@ enum scx_enq_flags {
 	 * %SCX_OPS_ENQ_LAST is specified, they're ops.enqueue()'d with the
 	 * %SCX_ENQ_LAST flag set.
 	 *
-	 * The BPF scheduler is responsible for triggering a follow-up
-	 * scheduling event. Otherwise, Execution may stall.
+	 * If the task is queued on the local DSQ of the CPU it was running on,
+	 * it continues to run. Otherwise, the CPU goes idle. A scheduler that
+	 * wants a full dispatch cycle on the CPU should kick it.
 	 */
 	SCX_ENQ_LAST		= 1LLU << 41,
 
@@ -3083,8 +3084,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		/*
 		 * If @p is runnable but we're about to enter a lower
 		 * sched_class, %SCX_OPS_ENQ_LAST must be set. Tell
-		 * ops.enqueue() that @p is the only one available for this cpu,
-		 * which should trigger an explicit follow-up scheduling event.
+		 * ops.enqueue() that @p is the only one available for this cpu.
 		 *
 		 * Core scheduling can force this CPU idle while @p stays
 		 * runnable. @p's cookie then won't match the core's, so skip
@@ -3094,6 +3094,16 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			WARN_ON_ONCE(sched_cpu_cookie_match(rq, p) &&
 				     !static_branch_unlikely(&scx_ops_enq_last));
 			do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
+
+			/*
+			 * A task put on the local DSQ runs, as anywhere else.
+			 * Here the insert can't reschedule on its own: the pick
+			 * has settled on @next and @p is still curr, so
+			 * resched_curr() would flag @p and __schedule() clears
+			 * that right after the pick. Flag @next instead.
+			 */
+			if (p->scx.dsq == &rq->scx.local_dsq)
+				set_tsk_need_resched(next);
 		} else {
 			do_enqueue_task(rq, p, 0, -1);
 		}
-- 
2.53.0

