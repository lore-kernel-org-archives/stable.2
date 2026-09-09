Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2F4B4881
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948711; cv=none; b=OqYDOgq5vy1HNlEqu1kAJ0B7H1nP6008CnN1F38EICUBfjAcXcEKV0gx7NoEpvhAWMH8InqM7Jd+N/OtTJbnu3iK3gmzwCp3gdDsFkOydstz9lJMPNNMageaNv/VjTiZbcraW7m3NJ4JOsB6WwnYKV7tmAy9R2lgepkYGB2PUIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948711; c=relaxed/simple;
	bh=JY0swwK1KeOM7CFlimLgFwgTue2JWQNHLkojN1zS5as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qk8mSbnOaXFiUA8AFkxSYQb6iREuBkyq8+qE6VCxMeDstUrkl4f1bfo74kyl5YbNRFkXH99uriZReYnDnOtMMyI10JEzlHUKKblEqiOYZsmIVbztC1cscsO3gwsRWFNTeLdcEUwuZknJpHN0jfRv1rUrgw9ZPeNWPiQ6GI8hiPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToRTOwgW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToRTOwgW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5202B1F00A3D;
	Wed,  9 Sep 2026 10:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788948709;
	bh=Fe+niGyH98kxZ+GYzdPz6R0lRGO1ftCGHGXYlS6gsoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ToRTOwgWbUGuJaDoamOUIiqRzt5VFzMZ6s9/JNtuJdGvkY2fiVs+LTmGTw6Yv/sZ9
	 3ZuOSxK2YTS7jWHkh1oLYJTDVGPpigLSofGhfXud/GTPSWyOyP5o6RU2UZONZNxkAP
	 4aeOD8eRFXKcGxcw9s6rTy8NqTP7cCahA3Ilp0D4fCDNjG6Oi/sjW1ic6ZmBbzl5uz
	 KiePYV5do1e6iPVbITLqH5Zh+lu4sEiGTKFyQPc6SM7+ZfX3WHAsRT2G1iMPO/C328
	 7LdCC9ZWoaMru0jXQrRTysPbXmqUFHFw4x3Zb/Jg+dbVCCJVxPEygBKobg0bHz0RiE
	 6cbDsdB4q45Xw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] sched_ext: Fix inverted ops.core_sched_before() invocation
Date: Wed,  9 Sep 2026 06:11:47 -0400
Message-ID: <20260909101147.1462770-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090300-shifting-wobbly-b1a8@gregkh>
References: <2026090300-shifting-wobbly-b1a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit f7b6d128dd49a6eec09066ecfd29095f12588786 ]

scx_prio_less() implements prio_less() semantics - %true means that @a is
the lower priority and should run after @b. ops.core_sched_before() is
documented to return %true when @a should run before @b. scx_prio_less()
returns the op's value as-is, inverting the documented semantics at runtime.

Call the op with the arguments swapped.

scx_qmap followed the wiring instead of the documentation and returned %true
for the younger task, so the two inversions canceled out and it behaved as
intended. Flip its comparison to match. scx_qmap is likely the only current
user in or out of the kernel tree. Any scheduler written the same way needs
the same flip, while schedulers following the documentation are fixed by
this change.

Fixes: 7b0888b7cc19 ("sched_ext: Implement core-sched support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Tejun Heo <tj@kernel.org>
[ adapted the change to kernel/sched/ext.c with the older SCX_CALL_OP_2TASKS_RET() macro signature. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c             | 10 ++++++++--
 tools/sched_ext/scx_qmap.bpf.c |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 428cde37130df..40dbdfed42c9a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3173,19 +3173,25 @@ static struct task_struct *pick_task_scx(struct rq *rq)
  *
  * When ops.core_sched_before() is enabled, @p->scx.core_sched_at is used to
  * implement FIFO ordering within each local DSQ. See pick_task_scx().
+ *
+ * Return: %true if @a should run after @b.
  */
 bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 		   bool in_fi)
 {
 	/*
+	 * scx_prio_less() returns whether @a should run after @b while
+	 * ops.core_sched_before() returns whether its first argument should run
+	 * before the second. Swap the arguments.
+	 *
 	 * The const qualifiers are dropped from task_struct pointers when
 	 * calling ops.core_sched_before(). Accesses are controlled by the
 	 * verifier.
 	 */
 	if (SCX_HAS_OP(core_sched_before) && !scx_rq_bypassing(task_rq(a)))
 		return SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, core_sched_before,
-					      (struct task_struct *)a,
-					      (struct task_struct *)b);
+					      (struct task_struct *)b,
+					      (struct task_struct *)a);
 	else
 		return time_after64(a->scx.core_sched_at, b->scx.core_sched_at);
 }
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index e952f525599bd..6447502dde28d 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -529,7 +529,7 @@ static s64 task_qdist(struct task_struct *p)
 bool BPF_STRUCT_OPS(qmap_core_sched_before,
 		    struct task_struct *a, struct task_struct *b)
 {
-	return task_qdist(a) > task_qdist(b);
+	return task_qdist(a) < task_qdist(b);
 }
 
 void BPF_STRUCT_OPS(qmap_cpu_release, s32 cpu, struct scx_cpu_release_args *args)
-- 
2.53.0

