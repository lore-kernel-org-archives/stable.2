Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212519;
	b=U2GKA6NKw+IbA+8SWkf4EHwXZhpqub4JDXAEhx+vYUoYodThEB/lZ0JqROqoEu0yFxPm
	 zcU2BQEpGmdbcxjU2wNF2+cB6lrNFakAYu7z6U3i/pF7/zPsVuXYq9V34X7WyRIvvOA0E
	 Fu360WUz1ATGjLR7P+Ko3Zlf9SsxrmZMRn3EpQm8kD2YRnDZfzlEakxD9aw9xHeXsi3Hl
	 GzyKFreHyWVXKQb0pGLXpnT7DQzhY/Js4in23pMIg916gfXeEVbpQFogLebgqN8TQ7q9B
	 KT1Xjk10Z8jGxPsc+1H7dut/Bhr8WdXnIbUYkUyVsI4JCBgyEW04q4g4MwXw2/PSiQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212519;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/hLF8KiiU0r3qiIXdokIJkjf9E6BGUJYGyZxrN8hbwY=;
	b=x9SFA2Fbr5coflssuxrjGFPK5PSSW0xy9TJaKO2juP+3nMMHoK7hNs9SsG83GvRh/Mjx
	 vnMBGrWtn2SIPQNlx2sBA/sEnyeQOT2M71i+1a38jmAncVmiEf4gE8Jxc2Mw2n8+VLJlk
	 lWdVEKv9kV5+4gi3O0+UnnzqqYuN4LZJ4i4vllX0ynaojxUjHIf+8RXm6BufSnDuqeIj4
	 re5Zldn7CIRgmBFc8TYwYMaCJLqo88gJzuyckcJBoB+U123Wc9HsUOcTNwoHdMiQnMF3e
	 de1jp2hu2EkXF9cyNjKE2EmI5cc9Yi9uWT+G7OMlK5FRkA3JiMBdGXnKHIugusuA5PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUgs4eOf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5189606A321
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUgs4eOf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29CA1F01828;
	Wed, 28 Oct 2026 18:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793212518;
	bh=/hLF8KiiU0r3qiIXdokIJkjf9E6BGUJYGyZxrN8hbwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mUgs4eOf/HOYkFjQ1N8y9w+etB/HlwrYFd1CXftqHntx/ZdJvKR2EFvcCMmnbcway
	 hlEoz+M/SNWcXDPCp7jnfDK5e/c7JRfPHG6GrKYjgKrsJLk3MvlQTVxmWu1BOT80uL
	 x1kJyE1DFxYKvzhTp5Tjnf1u1dHGwnhK3zLPfzseh4DrOKZDWkX5pWAdxSUtGF4P/g
	 ZqvyCneAFqI0nEdlv4VLXnbqwv8HDQB6TYv/51S+s6r1r3LbCtxeRXdH1CzCasyLep
	 Q8E3ihUn/CNBE2YizTn70hhrtGrK6yXsA0k/ioKBpvJWsK7QJguXXNjF7J2hJGRyzJ
	 +20duKiIVnb1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>,
	Josh Don <joshdon@google.com>,
	Hao Luo <haoluo@google.com>,
	Barret Rhoden <brho@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] sched: Allow sched_cgroup_fork() to fail and introduce sched_cancel_fork()
Date: Wed, 28 Oct 2026 14:35:15 -0400
Message-ID: <20261028183504.1718588-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102801-startle-saddled-529f@gregkh>
References: <2026102801-startle-saddled-529f@gregkh>
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
index fc19837c8083e..6623edc6fbae0 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -62,7 +62,8 @@ extern asmlinkage void schedule_tail(struct task_struct *prev);
 extern void init_idle(struct task_struct *idle, int cpu);
 
 extern int sched_fork(unsigned long clone_flags, struct task_struct *p);
-extern void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs);
+extern int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs);
+extern void sched_cancel_fork(struct task_struct *p);
 extern void sched_post_fork(struct task_struct *p);
 extern void sched_dead(struct task_struct *p);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 396a1d4b05e59..7d5ec03d7caca 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2486,7 +2486,7 @@ __latent_entropy struct task_struct *copy_process(
 
 	retval = perf_event_init_task(p, clone_flags);
 	if (retval)
-		goto bad_fork_cleanup_policy;
+		goto bad_fork_sched_cancel_fork;
 	retval = audit_alloc(p);
 	if (retval)
 		goto bad_fork_cleanup_perf;
@@ -2619,7 +2619,9 @@ __latent_entropy struct task_struct *copy_process(
 	 * cgroup specific, it unconditionally needs to place the task on a
 	 * runqueue.
 	 */
-	sched_cgroup_fork(p, args);
+	retval = sched_cgroup_fork(p, args);
+	if (retval)
+		goto bad_fork_cancel_cgroup;
 
 	/*
 	 * From this point on we must avoid any synchronous user-space
@@ -2665,13 +2667,13 @@ __latent_entropy struct task_struct *copy_process(
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
@@ -2747,10 +2749,11 @@ __latent_entropy struct task_struct *copy_process(
 
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
@@ -2789,6 +2792,8 @@ __latent_entropy struct task_struct *copy_process(
 	audit_free(p);
 bad_fork_cleanup_perf:
 	perf_event_free_task(p);
+bad_fork_sched_cancel_fork:
+	sched_cancel_fork(p);
 bad_fork_cleanup_policy:
 	lockdep_free_task(p);
 #ifdef CONFIG_NUMA
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ae06385109049..4056dc6b95e21 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4801,7 +4801,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	return 0;
 }
 
-void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
+int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 {
 	unsigned long flags;
 
@@ -4828,6 +4828,12 @@ void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
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

