Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214202;
	b=noc5t9HXmJH+Bu9c03Ht71NG1D5sCK72v84be0PhfpHc9nn03aYYdbq2MrZCaafR2wm7
	 aQO5CuCgBKPszUxdeU1XkrViGfFpaX0ynxuPPpjw+bKWfLLBQsoUAutP3h0hjdb5nf+vQ
	 3ZjJsS8RB3Pozv2O7nrR/SldqIA3qoLeWiouKwGiiBM/G1Y/UR2HC0stK1mXbjudNTyjW
	 B3gipeRfhJvYVfXnKjmXygoqUO6VMl3CZVFqSCGVFM8MlnY+RP5Aocyx8CYXWnEMSWcU9
	 HeJuDzhiQZR3+E0FQn1mGDoBM+3bvWEK7BB8qmENuA2MNlIjk2hljFmwkZtavmuokWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214202;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SoGfweSvmhSX2RWFu5Is195Lg4l0dkZ6SFuknv9bW6o=;
	b=q9qUsMLMb1xWdI7KB8y+OKXeORSMX/XIfZ5z8VOChQtsloY0avBmevOL0vPCQDW/3euY
	 H/heTl6taDvUxL60EwDxn0sAZNnIeL7MrodW7WCfvdtlk+USGckH+fAp2akfTCRVVBwPf
	 WEE9cfMrMTS8oxI1ylfxEA40sIQEFikH1O6FTZA72teNoTBwWU4ZN6CjwpaY4YaoTtOrS
	 ekkMUyJh26GgbNIQdkDqydqqPlAppOkHcF8bH1YQcHMHA+MNdaAyyDVRN2f5cnNn0DXZf
	 /VyXV6QRoxt1iVWMXJRLxE+whnyJlaNyxVyrDkIGNTL9pk3+ULprKaQSYgVQHSkEKsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRwKmsQ9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA485606BF93
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRwKmsQ9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D18B1F013C0;
	Wed, 28 Oct 2026 19:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793214201;
	bh=SoGfweSvmhSX2RWFu5Is195Lg4l0dkZ6SFuknv9bW6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MRwKmsQ9VCi3uu/yRGGoRvlPM/mxekkmlOoA+ErarrBsSB9saVHEemOQmbyv8+E2I
	 Z2aHDkdZhRgd/43DwR9nli4CtDfkke2pL0Fs5rsbV8J8qNuG3XfYxA19SYhQUnGBjT
	 X5MtpFKq/hm+7CqoVGCSroHHUc88O9Pn8FIK+2G15HuY+fZ3Hsg3LRPXyXx1TPWspu
	 dcEA8ChCbGHUBpwUNdFbBolneNgarIboueWrB3mH5ZHM77Pn3rXoPQEGZ7EK67Y+Tg
	 mDDGxIQS3Qs9En6tExpGXlpI7b6+OVUGCbvLj8rwsH3qOPupIuu1iOPGYUk2ccEvtc
	 EZ3vxZHJ1hKKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>,
	Josh Don <joshdon@google.com>,
	Hao Luo <haoluo@google.com>,
	Barret Rhoden <brho@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] sched: Allow sched_cgroup_fork() to fail and introduce sched_cancel_fork()
Date: Wed, 28 Oct 2026 15:03:18 -0400
Message-ID: <20261028190309.2072845-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102801-oaf-percolate-96a4@gregkh>
References: <2026102801-oaf-percolate-96a4@gregkh>
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

[ Upstream commit 304b3f2bc07ba7c74a1ebc7917a8f0549e6b8d54 ]

A new BPF extensible sched_class will need more control over the forking
process. It wants to be able to fail from sched_cgroup_fork() after the new
task's sched_task_group is initialized so that the loaded BPF program can
prepare the task with its cgroup association is established and reject fork
if e.g. allocation fails.

Allow sched_cgroup_fork() to fail by making it return int instead of void
and adding sched_cancel_fork() to undo sched_fork() in the error path.

sched_cgroup_fork() doesn't fail yet and this patch shouldn't cause any
behavior changes.

v2: Patch description updated to detail the expected use.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
Stable-dep-of: 296a98c1fa50 ("fork: release the files of a failed fork after sched_cancel_fork()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched/task.h |  3 ++-
 kernel/fork.c              | 15 ++++++++++-----
 kernel/sched/core.c        |  8 +++++++-
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 00135a8d57737..0abba8f8eaee0 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -59,7 +59,8 @@ extern asmlinkage void schedule_tail(struct task_struct *prev);
 extern void init_idle(struct task_struct *idle, int cpu);
 
 extern int sched_fork(unsigned long clone_flags, struct task_struct *p);
-extern void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs);
+extern int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs);
+extern void sched_cancel_fork(struct task_struct *p);
 extern void sched_post_fork(struct task_struct *p);
 extern void sched_dead(struct task_struct *p);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 37c5d6123cf62..7a83b068364d5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2335,7 +2335,7 @@ static __latent_entropy struct task_struct *copy_process(
 
 	retval = perf_event_init_task(p, clone_flags);
 	if (retval)
-		goto bad_fork_cleanup_policy;
+		goto bad_fork_sched_cancel_fork;
 	retval = audit_alloc(p);
 	if (retval)
 		goto bad_fork_cleanup_perf;
@@ -2468,7 +2468,9 @@ static __latent_entropy struct task_struct *copy_process(
 	 * cgroup specific, it unconditionally needs to place the task on a
 	 * runqueue.
 	 */
-	sched_cgroup_fork(p, args);
+	retval = sched_cgroup_fork(p, args);
+	if (retval)
+		goto bad_fork_cancel_cgroup;
 
 	/*
 	 * From this point on we must avoid any synchronous user-space
@@ -2514,13 +2516,13 @@ static __latent_entropy struct task_struct *copy_process(
 	/* Don't start children in a dying pid namespace */
 	if (unlikely(!(ns_of_pid(pid)->pid_allocated & PIDNS_ADDING))) {
 		retval = -ENOMEM;
-		goto bad_fork_cancel_cgroup;
+		goto bad_fork_core_free;
 	}
 
 	/* Let kill terminate clone/fork in the middle */
 	if (fatal_signal_pending(current)) {
 		retval = -EINTR;
-		goto bad_fork_cancel_cgroup;
+		goto bad_fork_core_free;
 	}
 
 	/* No more failure paths after this point. */
@@ -2595,10 +2597,11 @@ static __latent_entropy struct task_struct *copy_process(
 
 	return p;
 
-bad_fork_cancel_cgroup:
+bad_fork_core_free:
 	sched_core_free(p);
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
+bad_fork_cancel_cgroup:
 	cgroup_cancel_fork(p, args);
 bad_fork_put_pidfd:
 	if (clone_flags & CLONE_PIDFD) {
@@ -2637,6 +2640,8 @@ static __latent_entropy struct task_struct *copy_process(
 	audit_free(p);
 bad_fork_cleanup_perf:
 	perf_event_free_task(p);
+bad_fork_sched_cancel_fork:
+	sched_cancel_fork(p);
 bad_fork_cleanup_policy:
 	lockdep_free_task(p);
 #ifdef CONFIG_NUMA
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cf470ac63af72..87b4e7d5f70f5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4670,7 +4670,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	return 0;
 }
 
-void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
+int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 {
 	unsigned long flags;
 
@@ -4697,6 +4697,12 @@ void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 	if (p->sched_class->task_fork)
 		p->sched_class->task_fork(p);
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+
+	return 0;
+}
+
+void sched_cancel_fork(struct task_struct *p)
+{
 }
 
 void sched_post_fork(struct task_struct *p)
-- 
2.53.0

