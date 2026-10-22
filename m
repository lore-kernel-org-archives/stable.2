Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674283;
	b=XoSuJkCqHx5eaJFRmor6gHp1o0pj2qvNeHUrQ6XYi00k/BPE9EUBLIdQHEeu2vDVLloW
	 eXoaMHAuFt4C5h8+ABk5MH6XnV7EkwtM8UmKmompwVmTOLBGk5h94z9xXDGYO15LZifer
	 UMeT4NA2N0dhpQvPi4Cn6fP6SkK+NeelW1jo9OIrda8cX7xaos3Qj7B2TwtRibva0LEmc
	 rHRvRS8aO0BVnCcXoDeOY3y9jmbjWBWF3SLSsbG6vy3Dd89+MktjgSqglDNI6kmdOdYj6
	 x1SpRgHeb6r3zsU9jaB0whOh3qkWyW3IT8DIn8dv+szcmEyUNCCmkG4p6o4DqxbnwAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674283;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mcGvXn33ExlrirM8ShmLQDzD4eJ+wyPEJuB8HT0bod0=;
	b=2XCSRbqmhzp48n/b5ZOr9idU7vbncWmWbL4f5+o0r1oQmYzXV4MnZzNTjCsm6PNA+I1s
	 MnldqDh2g0FxzBbWbSLfUT8wJ2n/2IbJL8rbMUn7gcUb7dvjanllAUbJzX9LkERpisrpS
	 OisOJTiSs6E/fh/JlwgXsHl3Yqdj6YfRh54F9o7ULhMJNTQqZ/65gfKwf47+lfr+GEAWL
	 VYRMP7DRLY+9aMx6SDfkqd1ET6ZlYAF4rPAUygKCKGAi2NvsqEjw5jwIiJIUmydIkpoZR
	 lBfFSHPfwcjy/lkLC/n0b8dm42JGTB5XwFo8W/IZcF5gcrt04GEPqp7tPKc7SixmHfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1ru+616;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954EB606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1ru+616
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8DA1F000C1;
	Thu, 22 Oct 2026 13:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792674283;
	bh=mcGvXn33ExlrirM8ShmLQDzD4eJ+wyPEJuB8HT0bod0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K1ru+616N13Un70yktsI9PCHf9FUvUQHLu5Uhlh13ZZ5u/qEgerfrs/uPbc3zJ1Ct
	 6JMgiOHonMtxJPKGFiZv7rK9N1tPujCEdZFGsnZDWzRvMRMt0khljjfcYdXxzvbsIx
	 hvwUvYpGrW1zv7lT7zelYVzvgKvtyXEgLaKTy5W/k+xO6L5aLow/DChqAiUdnfFRtP
	 7B10Dr3ZNJFpusJEp9cO5PeA9ftwIJsF9CJMYgoghiX4XnWHr3DaRwubsEcNwx8Tqq
	 iihjhiT+pkbvL18ynnZbr4YOuQzkUhI7l+MTsa/+WSe3+l2MZU8Jp0FeQD4rIIFmld
	 I5Tr/ZtAzC62Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Xiangyu Bu <xbu@meta.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] sched_ext: Fix stall when a task enqueued with SCX_ENQ_LAST lands back on its CPU's local DSQ
Date: Thu, 22 Oct 2026 09:04:41 -0400
Message-ID: <20261022125422.1200151-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102101-hangup-favoring-37ae@gregkh>
References: <2026102101-hangup-favoring-37ae@gregkh>
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
[ sashal: adjusted context for do_enqueue_task() in the existing sched_ext file layout. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c          | 13 +++++++++++--
 kernel/sched/ext_internal.h |  5 +++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 55072a105cd6e..f3e3146e5febf 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2409,8 +2409,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		/*
 		 * If @p is runnable but we're about to enter a lower
 		 * sched_class, %SCX_OPS_ENQ_LAST must be set. Tell
-		 * ops.enqueue() that @p is the only one available for this cpu,
-		 * which should trigger an explicit follow-up scheduling event.
+		 * ops.enqueue() that @p is the only one available for this cpu.
 		 *
 		 * Core scheduling can force this CPU idle while @p stays
 		 * runnable. @p's cookie then won't match the core's, so skip
@@ -2420,6 +2419,16 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			WARN_ON_ONCE(sched_cpu_cookie_match(rq, p) &&
 				     !(sch->ops.flags & SCX_OPS_ENQ_LAST));
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
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 7cb9c8725b654..ed25c130b9994 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -949,8 +949,9 @@ enum scx_enq_flags {
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
 
-- 
2.53.0

