Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1EA3D669A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945991; cv=none; b=Bj3oFHwAky+x0tq77stXltmGDMM0d8sB1O0F3R0V5SQ3SxET5hWcOPyqyfTg+Q479yx6OypoS33BW4Oxh8IHNrs/opQjvz/mqSfJJhEFt/Tz/k5DHmqntPKR30568b/XKnsI4Klz50VvIUsdnDnCrdfgCyKoHal9WPIQKt02vL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945991; c=relaxed/simple;
	bh=nB//S7TsQ5Wqh6DfHK5cfAaLQy9NnTcDOV2g9XbmdTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnfpGcYrbKQguPMjFUfXVwm94+He2bYzHCWQFddjZlM7bh4ZRIePODW8FkUyn8nickujF5J2MRE6JW18pkc649/LFCaDHBKVc0sbYm+CpF/34PvGcCVC0wuPYSGEBDqAZU9O9OpiYbq6fylxUbre+p3D5TYCpX1/T793YDznNjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUU+CDIf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUU+CDIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D324A1F00A3D;
	Wed,  9 Sep 2026 09:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945990;
	bh=lBTLafVYqOeePKhxASeR2/KP5DjRp4EW4LIYbyGCLSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kUU+CDIf6+oRkDUS+JOYmuw+7HMNFwJejLXyll7Jl+p3YQrk0zppdVj15OZ4MpU0k
	 dGzz9Ahrg3n3UD049fcmdHIOrUWSoBTmLBZDQI1Yxo5ZcZyccBL8oje7OJzwCC7nG/
	 vRF8KKNSFIp3vQ0QFeFBZ2stHXS68ZCtCKbzP7FCfpYjsaybbWcAdQ6daf+Rsp/9Vq
	 DlhZedbDDPQ02x7sRn/WUUqhp6jkVBGWutG0MkbF6vlGp6Dvszi7V39PuxOkIKL3IL
	 lpeSvPUyttEGokGJrMbyiWMtZzD5ZnfrV5qSfiETHJo+Bh6Q/LmwmHUk/cZ7pvAtJe
	 guEK+Xp3HndmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] sched_ext: Fix inverted ops.core_sched_before() invocation
Date: Wed,  9 Sep 2026 05:26:27 -0400
Message-ID: <20260909092627.1296380-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090359-grew-grab-d96a@gregkh>
References: <2026090359-grew-grab-d96a@gregkh>
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
[ adapted kernel/sched/ext/ext.c changes to the older kernel/sched/ext.c layout ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c             | 10 ++++++++--
 tools/sched_ext/scx_qmap.bpf.c |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b5f95b379ea6c..695b7528b9369 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2513,6 +2513,8 @@ static struct task_struct *pick_task_scx(struct rq *rq)
  *
  * When ops.core_sched_before() is enabled, @p->scx.core_sched_at is used to
  * implement FIFO ordering within each local DSQ. See pick_task_scx().
+ *
+ * Return: %true if @a should run after @b.
  */
 bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 		   bool in_fi)
@@ -2520,6 +2522,10 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 	struct scx_sched *sch = scx_root;
 
 	/*
+	 * scx_prio_less() returns whether @a should run after @b while
+	 * ops.core_sched_before() returns whether its first argument should run
+	 * before the second. Swap the arguments.
+	 *
 	 * The const qualifiers are dropped from task_struct pointers when
 	 * calling ops.core_sched_before(). Accesses are controlled by the
 	 * verifier.
@@ -2528,8 +2534,8 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 	    !scx_rq_bypassing(task_rq(a)))
 		return SCX_CALL_OP_2TASKS_RET(sch, SCX_KF_REST, core_sched_before,
 					      task_rq(a),
-					      (struct task_struct *)a,
-					      (struct task_struct *)b);
+					      (struct task_struct *)b,
+					      (struct task_struct *)a);
 	else
 		return time_after64(a->scx.core_sched_at, b->scx.core_sched_at);
 }
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 3072b593f8981..4f65a7550fb2d 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -530,7 +530,7 @@ static s64 task_qdist(struct task_struct *p)
 bool BPF_STRUCT_OPS(qmap_core_sched_before,
 		    struct task_struct *a, struct task_struct *b)
 {
-	return task_qdist(a) > task_qdist(b);
+	return task_qdist(a) < task_qdist(b);
 }
 
 void BPF_STRUCT_OPS(qmap_cpu_release, s32 cpu, struct scx_cpu_release_args *args)
-- 
2.53.0

