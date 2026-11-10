Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272758;
	b=w1D+JwNKroiHs7rAs0G/MM0fHvjY1GcGwoNJcjvc74jEZNJTIyP+E43ev/GnGd4BaoE5
	 vNYwDTS8F+LmqAhuLq1qLniG52PR9bpELDbGv3hVgw/qLrPBLEZezAXqaSZbt7eI81sxl
	 lKI71chhpXrJMGyuZ0N8QfOJZsqZ4Z4Gke5+EPwMQQEJFh02faDwpwRODl/bYDU7z/e8i
	 JcVnAa2fv35tPuRiH14A8zocNhzvKjQV9rrt8+nixoJ8Eqmdmo1GZYCzvrCxSjR8F592M
	 eNPGIiA4AkHBoNU/6zBoBriBGknq80NaSXzJG7n91BlDO8JQRcdHjZGwvzBbhQkeDBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272758;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VHZK78ftECp16m/ZI2S3XEq6g+LWgxsAovGmzg8hfOQ=;
	b=VlzVFHarqHIggiBsFeyjw5e2/X+qDRqiXqFW8H6oUB3nPALEMJPurZSVyfQP1g9tE3To
	 t+47FLjbeUWRHP2qhr0TGx5JJvkrr1tZWr3vbt+ICSpMea1UnKyx95eC6ne6IVfm4m0Ha
	 EQEBhn8fOCUSs8aVOMGKgdWaHtapU0Sd9coXBZOBdZ07CKvnLk1CZ0zbD+3keeb3KZG/1
	 kf11y3FUjaYuPS7XJSv9HYioRWz7cm4VZpfqzViXvWU+2Qj8NLtLaYuamp1VyFBZfB6V8
	 5+GdFGEZxbMz65mdfSPco0j2fnP91CTgl+xKIqSITMfD/iVbjrUnRLoE95DO/e2+8tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BV4b15KS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3CD606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BV4b15KS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C362B1F0089F;
	Tue, 10 Nov 2026 01:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272758;
	bh=VHZK78ftECp16m/ZI2S3XEq6g+LWgxsAovGmzg8hfOQ=;
	h=From:To:Cc:Subject:Date;
	b=BV4b15KSqwibtOlj5wKOwiwO3veZr8b7CqWt6jVzopM2Sb665/iA5LFveA1k0bn5P
	 tCVmELPPveJli1/AZir5lQCXFRd4JNiUAeR4s3s8T8xKr9puvo0J8Y2Sxs9P9EjS5K
	 iDwlqpr9NxCmGmXUv3jEZfU+Tclyl+uic9saTOPJsTxfNhQa/J90/XU1eSzfELCZW2
	 JkS++3D0JOgOv9q7o6sj5U55BUxNdWR3FbylA54tm1SfC1PryzXVlgt7OF0Y3NcYf2
	 695Rzide7QWztSORDFeJ51G5GQIuF89B3fMithNCaiWsU2Gg2ZcS77Cu2Y5+3vaeaf
	 OnS+mpD96kKcA==
From: Sasha Levin <sashal@kernel.org>
To: 4ncienth@gmail.com,
	peterz@infradead.org,
	mingo@kernel.org,
	ziqianlu@bytedance.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] sched/fair: Clear throttle state when leaving the fair class" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:05:56 -0500
Message-ID: <20261109200556-failed-6.18-c282051fc2ca@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c282051fc2cae2ea54770ebe435dbea090272c25
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200556-failed-6.18-c282051fc2ca@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c282051fc2cae2ea54770ebe435dbea090272c25 Mon Sep 17 00:00:00 2001
From: Daehyeon Ko <4ncienth@gmail.com>
Date: Fri, 23 Oct 2026 08:52:33 +0900
Subject: [PATCH] sched/fair: Clear throttle state when leaving the fair class

Task-based CFS bandwidth throttling removes a task's fair sched_entity
while the scheduler core still considers the task queued. p->throttled
carries the fair-specific state across dequeue/enqueue operations.

DEQUEUE_CLASS removes the task from cfs_rq->throttled_limbo_list
but retains the bit. If the last finite CFS quota is disabled while
the task runs in another class, it is absent from the unthrottle walk and
the bit survives.
Returning to fair while cfs_bandwidth_used() is false then performs a real
fair enqueue with p->throttled still set.

After bandwidth is re-enabled, a class-change dequeue treats the
stale bit as limbo state and skips __dequeue_task(). p->se.on_rq therefore
remains set, and put_prev_task_fair() places the entity in the EEVDF tree
while the task moves to RT. On exit, the fair picker can select the
TASK_DEAD task. __schedule() then returns to do_task_dead(),
which hits BUG().

Keep p->throttled across migrations and group moves, but clear it on
DEQUEUE_CLASS because fair-specific state must not outlive fair-class
membership. A later return to fair uses the normal enqueue path. That path
still respects a throttled cfs_rq.

A KASAN, LOCKDEP and DEBUG_LIST v7.3 kernel reproduced the do_task_dead()
BUG in 3/3 root and 3/3 delegated uid-1000 runs with CapPrm=CapEff=0 and
RLIMIT_RTPRIO=1. The fix passed both matrices plus a 3/3 class-switch
control with bandwidth continuously enabled, without a scheduler warning,
KASAN report, lockdep splat or crash.

An AI coding assistant analyzed the state mismatch and drafted the initial
reproducer, fix candidate and this changelog. The source paths, trigger,
controls and results were rechecked against the cited revisions.

Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Aaron Lu <ziqianlu@bytedance.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261022235234.150957-1-4ncienth@gmail.com
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cfc982205b98c..ad414539bc4f4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6964,8 +6964,8 @@ static void dequeue_throttled_task(struct task_struct *p, int flags)
 	WARN_ON_ONCE(p->se.on_rq);
 	list_del_init(&p->throttle_node);
 
-	/* task blocked after throttled */
-	if (flags & DEQUEUE_SLEEP) {
+	/* Task blocked after throttling or is leaving the fair class: */
+	if (flags & (DEQUEUE_SLEEP | DEQUEUE_CLASS)) {
 		p->throttled = false;
 		return;
 	}
-- 
2.53.0




