Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876C7443313
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138065; cv=none; b=fjNVdOmvEaWfOyqloTM14yrzzBrx5pDHljb/V2Eal71KJKDQtSMtWQlFdAVkLPV3lWjLHuuwpl46IF0h/RKLU4KHDn0nQnk5jCpKixOFLCs3cZEQ+wgEcclyuewnHx/A5mWzEyl52yxlE+7/cKcY06xMO8RSrOERSXIl6NR4FK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138065; c=relaxed/simple;
	bh=qHdK46/WI4rKAS0pXQ62zuKEdEnpVXM6+omKKvnMI90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhIFf4uZaIoxpiluNdUhdxYX5nxAU4t/+41nd/0ZAiYP+c/RlRWq3dGBPS4jXGCcf/EEEoEb972bDkN2GHHLuTSWgmE5ow3VHjgVKCYxYKZxuVtMI7RZZfPKMGaLB++PYcyraWW8LybvOJAmpgvWNOdZoUHHEo1h6sAICNl7G0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coik6v+6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coik6v+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B761F00A3D;
	Wed, 19 Aug 2026 11:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138064;
	bh=R729++CO1H4JJpv9YGFL8WPKGbK37GpTGy3Nx2EIhU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=coik6v+6CGD/5i7Ks79zSVz/xOjE48yCxi3zY0zS6JMDpfB4ZJcumMaiXV9OSOi4k
	 y6QMLX9ORcvBTfnvdkXUpmaDTbaF3DVmVmg4kOJpWhfda7BCB2WvQzL7kT9Wm8fcyu
	 aLvrNQxpl1Ikv2GXWf94bGTuOH9ktHIp/9seR2BiO98svVfRpmQc3h8QW3Bu+5fcqY
	 OW1ZOi6f3G2P3aegi1Dig3bkhsnornQ9hg1dY/gl3nas6VIs/jrg5U8vF3EhXXixGR
	 8NzbiUVOvWQIg3EVRA/ENIAiyWhmGhtjwYwz4tLcoUfPHD7ZSwcI4yeOM5AeYLdmOc
	 IF6yG8vDaVGxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] sched_ext: Reorganize enable/disable path for multi-scheduler support
Date: Wed, 19 Aug 2026 07:14:19 -0400
Message-ID: <20260819111420.3549656-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819111420.3549656-1-sashal@kernel.org>
References: <2026081715-muscular-drizzly-bfad@gregkh>
 <20260819111420.3549656-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit dbd542a8fac7bcfba91e353f2a522e1bf2fbee27 ]

In preparation for multiple scheduler support, reorganize the enable and
disable paths to make scheduler instances explicit. Extract
scx_root_disable() from scx_disable_workfn(). Rename scx_enable_workfn()
to scx_root_enable_workfn(). Change scx_disable() to take @sch parameter
and only queue disable_work if scx_claim_exit() succeeds for consistency.
Move exit_kind validation into scx_claim_exit(). The sysrq handler now
prints a message when no scheduler is loaded.

These changes don't materially affect user-visible behavior.

v2: Keep scx_enable() name as-is and only rename the workfn to
    scx_root_enable_workfn(). Change scx_enable() return type to s32.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Stable-dep-of: 5f8b69642d18 ("sched_ext: Take cgroup_lock() first in scx_cgroup_lock()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 78 +++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4e06f0a0361c..e53ebad5f84b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3029,8 +3029,8 @@ void sched_ext_free(struct task_struct *p)
 	raw_spin_unlock_irqrestore(&scx_tasks_lock, flags);
 
 	/*
-	 * @p is off scx_tasks and wholly ours. scx_enable()'s READY -> ENABLED
-	 * transitions can't race us. Disable ops for @p.
+	 * @p is off scx_tasks and wholly ours. scx_root_enable()'s READY ->
+	 * ENABLED transitions can't race us. Disable ops for @p.
 	 */
 	if (scx_get_task_state(p) != SCX_TASK_NONE) {
 		struct rq_flags rf;
@@ -3962,24 +3962,12 @@ static void free_kick_pseqs(void)
 	}
 }
 
-static void scx_disable_workfn(struct kthread_work *work)
+static void scx_root_disable(struct scx_sched *sch)
 {
-	struct scx_sched *sch = container_of(work, struct scx_sched, disable_work);
 	struct scx_exit_info *ei = sch->exit_info;
 	struct scx_task_iter sti;
 	struct task_struct *p;
-	int kind, cpu;
-
-	kind = atomic_read(&sch->exit_kind);
-	while (true) {
-		if (kind == SCX_EXIT_DONE)	/* already disabled? */
-			return;
-		WARN_ON_ONCE(kind == SCX_EXIT_NONE);
-		if (atomic_try_cmpxchg(&sch->exit_kind, &kind, SCX_EXIT_DONE))
-			break;
-	}
-	ei->kind = kind;
-	ei->reason = scx_exit_reason(ei->kind);
+	int cpu;
 
 	/* guarantee forward progress by bypassing scx_ops */
 	scx_bypass(true);
@@ -4124,6 +4112,9 @@ static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 
 	lockdep_assert_preemption_disabled();
 
+	if (WARN_ON_ONCE(kind == SCX_EXIT_NONE || kind == SCX_EXIT_DONE))
+		kind = SCX_EXIT_ERROR;
+
 	if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
 		return false;
 
@@ -4136,21 +4127,31 @@ static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 	return true;
 }
 
-static void scx_disable(enum scx_exit_kind kind)
+static void scx_disable_workfn(struct kthread_work *work)
 {
-	struct scx_sched *sch;
+	struct scx_sched *sch = container_of(work, struct scx_sched, disable_work);
+	struct scx_exit_info *ei = sch->exit_info;
+	int kind;
 
-	if (WARN_ON_ONCE(kind == SCX_EXIT_NONE || kind == SCX_EXIT_DONE))
-		kind = SCX_EXIT_ERROR;
+	kind = atomic_read(&sch->exit_kind);
+	while (true) {
+		if (kind == SCX_EXIT_DONE)	/* already disabled? */
+			return;
+		WARN_ON_ONCE(kind == SCX_EXIT_NONE);
+		if (atomic_try_cmpxchg(&sch->exit_kind, &kind, SCX_EXIT_DONE))
+			break;
+	}
+	ei->kind = kind;
+	ei->reason = scx_exit_reason(ei->kind);
 
-	rcu_read_lock();
-	sch = rcu_dereference(scx_root);
-	if (sch) {
-		guard(preempt)();
-		scx_claim_exit(sch, kind);
+	scx_root_disable(sch);
+}
+
+static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind)
+{
+	guard(preempt)();
+	if (scx_claim_exit(sch, kind))
 		kthread_queue_work(sch->helper, &sch->disable_work);
-	}
-	rcu_read_unlock();
 }
 
 static void dump_newline(struct seq_buf *s)
@@ -4662,10 +4663,9 @@ struct scx_enable_cmd {
 	int			ret;
 };
 
-static void scx_enable_workfn(struct kthread_work *work)
+static void scx_root_enable_workfn(struct kthread_work *work)
 {
-	struct scx_enable_cmd *cmd =
-		container_of(work, struct scx_enable_cmd, work);
+	struct scx_enable_cmd *cmd = container_of(work, struct scx_enable_cmd, work);
 	struct sched_ext_ops *ops = cmd->ops;
 	struct scx_sched *sch;
 	struct scx_task_iter sti;
@@ -4915,12 +4915,12 @@ static void scx_enable_workfn(struct kthread_work *work)
 	 * Flush scx_disable_work to ensure that error is reported before init
 	 * completion. sch's base reference will be put by bpf_scx_unreg().
 	 */
-	scx_error(sch, "scx_enable() failed (%d)", ret);
+	scx_error(sch, "scx_root_enable() failed (%d)", ret);
 	kthread_flush_work(&sch->disable_work);
 	cmd->ret = 0;
 }
 
-static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
+static s32 scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 {
 	static struct kthread_worker *helper;
 	static DEFINE_MUTEX(helper_mutex);
@@ -4946,7 +4946,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		mutex_unlock(&helper_mutex);
 	}
 
-	kthread_init_work(&cmd.work, scx_enable_workfn);
+	kthread_init_work(&cmd.work, scx_root_enable_workfn);
 	cmd.ops = ops;
 
 	kthread_queue_work(READ_ONCE(helper), &cmd.work);
@@ -5089,7 +5089,7 @@ static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
 	struct sched_ext_ops *ops = kdata;
 	struct scx_sched *sch = ops->priv;
 
-	scx_disable(SCX_EXIT_UNREG);
+	scx_disable(sch, SCX_EXIT_UNREG);
 	kthread_flush_work(&sch->disable_work);
 	kobject_put(&sch->kobj);
 }
@@ -5217,7 +5217,15 @@ static struct bpf_struct_ops bpf_sched_ext_ops = {
 
 static void sysrq_handle_sched_ext_reset(u8 key)
 {
-	scx_disable(SCX_EXIT_SYSRQ);
+	struct scx_sched *sch;
+
+	rcu_read_lock();
+	sch = rcu_dereference(scx_root);
+	if (likely(sch))
+		scx_disable(sch, SCX_EXIT_SYSRQ);
+	else
+		pr_info("sched_ext: BPF schedulers not loaded\n");
+	rcu_read_unlock();
 }
 
 static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
-- 
2.53.0

