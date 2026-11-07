Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047054;
	b=MMTsaYHiqqmxLgUhwVGfCRh0mPk9+9KF9d2ai+dLGqdzwq/nPp/t8hO64Q3YvTXmPxDY
	 I8GSr5pRs8ydRtT+xtjepsTOHyjSMjTzwnPbjKGBpKZgjmWoFF10BUSIbJRkQasGIwIWk
	 tRKH+4uXX+h4KY64uTnkeLVD8RgUYLW7hE6csS31ckkQDqRG5k3Su05EjsJj16q2j8Y9S
	 PbquTVnhEHv447CFvmZ6+9QXmkPEPkIHFelY7aC0OhTfE3geBvZk33+FknidMFKJz71H8
	 LhVHl0134xBJWVFZRlrV9J56GYDuzRcEC/T3BUd1Z6OwJSvYPtRdBgfUlLuKV90Fkaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047054;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PafRAERQZvpCORVxMh80XJIL8y0/oJz0VHYGicnMmi0=;
	b=ImJOLG/2J10U2XYSt9bq2S21t8AkVyGbw7oZwWjvaNkarKeVl3EyQoIhCclUYzlw93jN
	 rd1kG1VxsJK9x2Eker2Q2gSvyQH8suRERTF6hbBw/hdBEJBikn5voR9SRA00do1zwErps
	 Z0UP7JCHThbIz8s/HLibGF9RfLpLnz2fg8C2DozkSXwTDc/MuEqDIIa6YFjkBs4syfv5I
	 nmQ2aLcnpsTnkCpDKWEGZRwvMhtS2VnO1Q59pt+Pu39IqV9HXo1C9ZCD4xH3n1nOhZ0DN
	 kQZCFQt2zaqjLMgBxAWlK5mnnAElSh+BmNFq5j1Edv6uHPJ88DZmjfsU0/XkBLhdvmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kxeFMreu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0F3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kxeFMreu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F03B1F0089F;
	Sat,  7 Nov 2026 10:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047053;
	bh=PafRAERQZvpCORVxMh80XJIL8y0/oJz0VHYGicnMmi0=;
	h=From:To:Cc:Subject:Date;
	b=kxeFMreud9Y5GiDhC9yxX/VuKhdLUaApSlDEbPszxubAf/Q+qalRxsOD5LfgOr3AF
	 oTnsvrPKc4u/OSoBZVIL3unmzualuYA2hmBJgBR56u6tdtDNC7zAkCQ+cTR45AVYbh
	 oxszodIUhvfkgq9XgW8BKSBp9oAhF9c7PjZwNEULzzDDHnVnzpuLTYqE7STDS0pnEp
	 SVa+KpMnVtw6SFdb5gWiByRvlWkSj3W87jKJah8ZINPho+IdfuX9WO/HRyjmznJsSG
	 GibDIJ3DhMGsk4/V8w6d5GMbnaUVRHcZ85oY/TNZbi5ay9JrW/66a9zwHQBF7P4HTN
	 CgWS0yaoRcVmQ==
From: Sasha Levin <sashal@kernel.org>
To: michalblk@google.com,
	arighi@nvidia.com,
	tj@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] sched_ext: Reset runnable_at when a task leaves its scheduler" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:24:12 -0500
Message-ID: <20261107052412-failed-6.12-993e8fbfecbb@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 993e8fbfecbbf284b9644c6f10741b28fb914094
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052412-failed-6.12-993e8fbfecbb@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 993e8fbfecbbf284b9644c6f10741b28fb914094 Mon Sep 17 00:00:00 2001
From: Michal Blaszczyk <michalblk@google.com>
Date: Mon, 19 Oct 2026 12:41:45 +0000
Subject: [PATCH] sched_ext: Reset runnable_at when a task leaves its scheduler

The watchdog measures how long a task has been waiting from
p->scx.runnable_at, which set_task_runnable() resets when the task becomes
runnable after it last ran. ops_dequeue() never asks for a reset, as the
dequeue of a waiting task is temporary, e.g. for a migration or an
attribute change.

Leaving the scheduler isn't temporary. A task which is switched out of
SCHED_EXT while it's waiting keeps its runnable_at. When it's switched back
and becomes runnable, its wait appears to have started before it left, and
the time it spent in another class counts towards the timeout. If the
watchdog checks before the task runs, it aborts the scheduler:

  sched_ext: class_switch_stall: runner[418] failed to run for 3.010s

Here, the task waited for a few milliseconds before it was switched to
SCHED_OTHER, slept outside of SCHED_EXT for three seconds, and was charged
for all of it as soon as it woke up on SCHED_EXT again.

The same happens when scx_sub_enable_workfn() hands a waiting task over to
a new sub-scheduler, which can then be blamed for time the task waited
under the parent. scx_rehome_task() isn't affected, as it moves the task
through SCX_TASK_INIT, which resets runnable_at. The stale runnable_at also
skews the default core-sched ordering in scx_prio_less().

Reset runnable_at in scx_disable_task(), when the task leaves the control
of its scheduler.

Fixes: 8a010b81b3a5 ("sched_ext: Implement runnable task stall watchdog")
Cc: stable@vger.kernel.org # v6.12+
Assisted-by: LLM
Signed-off-by: Michal Blaszczyk <michalblk@google.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index aa00b75371822..6fec09fd09707 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2454,7 +2454,11 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 	struct scx_sched *sch = scx_task_sched(p);
 	unsigned long opss;
 
-	/* dequeue is always temporary, don't reset runnable_at */
+	/*
+	 * Don't reset runnable_at. If @p is waiting, the wait continues across
+	 * temporary dequeues, e.g. for a migration or an attribute change.
+	 * scx_disable_task() ends it if @p leaves its scheduler.
+	 */
 	clr_task_runnable(p, false);
 
 retry:
@@ -4554,6 +4558,14 @@ static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
 	scx_set_task_slice(p, 0);
 	p->scx.reenq_cnt = 0;
 
+	/*
+	 * If @p is runnable but not running, its wait started at runnable_at,
+	 * which ops_dequeue() didn't reset. Leaving @sch ends the wait. Reset
+	 * runnable_at the next time @p is enqueued on SCX, so that the watchdog
+	 * doesn't count the time @p spends elsewhere.
+	 */
+	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
+
 	/*
 	 * Verify the task is not in BPF scheduler's custody. If flag
 	 * transitions are consistent, the flag should always be clear
-- 
2.53.0




