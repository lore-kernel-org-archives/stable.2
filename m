Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793216616;
	b=W3uw4kQkNZX+Qa2KcsgOGHwpFak+qP7znMNVugxsnrpAS1E3R9xwnxFM2nYFX0wrTOkk
	 MTXQ+2F0OwXwhn8T/cVIlKV37T8+JBfpZG/he4jVNGar7jJz2AO5lQFHuu+wmKj5ykS/a
	 FowYCVzVRN0DeZdb9Hk1ggwBH9XbYgh4F6JIjravwJvak4rnuRqKTqsDi7JrHpOPfb9jh
	 ARpLAGDS8Iq23pwgrE/cN/nX96zZ43gQJb/6SNM4zOaJwJ9VAdSl0rPHiNj8hGaMmpPQX
	 USCX59QIxsaVk9k3fiKLdp0YO/q/nt7kC25Rk15M0kpYZwqbIGcS9mzjlz80Xn7urpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793216616;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LJf9863IflwDAnnqoFf/i350ar3ByqJyKHGVy6EzDFA=;
	b=Y6WXZgNJJ+naaEBZ3DGIEGjPcef9ft//VDFReBpbVez8hsXoJu66Y/amjRyBuXaOxC8p
	 7ss9G05NmiE5LQjkU4CgdK1i2ITB0I4stF17hiXrlcd3VwC3sM3Rz3sbWAm6zgDIdB4d/
	 fD/wvxElMyqoNhwKWrlHzldUgcghIjj6NpNhCXBBS6FK//72BGWsSFPZwM7FPxbKGohjA
	 Yb2vwuZC/gGjCcbNQb5pzG0zJidFaBqb/xwwhvvJrPDu65r/JkVSa0ZrOiDF40nKfXnCQ
	 YLSlNv54A/Ca3lo4mPK6Y77Y7PUxjE+rDDaIwhwhTaZf+wb2lhocpzBfzZ17IxMSHaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NCrXIGs4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7CD606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NCrXIGs4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD611F01828;
	Wed, 28 Oct 2026 19:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793216615;
	bh=LJf9863IflwDAnnqoFf/i350ar3ByqJyKHGVy6EzDFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NCrXIGs4dAM9P9owAAzYM7hJau3JBr9nqCAgm+W9uflaon2NxDpBNZmxA9zxGImSZ
	 Adg7d0tZvVBpT2NU1LSV9e9xqQiNx/jyBbjQUWWJwO9gQOJtjPPdeRa9KjuqjJzzmK
	 WWLZjyF3xy6GMo88HeD5aAfJV4szmsCBpilFj//3Jj2t78EA0/00QrwlukyYEfLub9
	 bkwRErY5U3hmAK8JySeKaCBL5ikS/Vj0uzHBDhaSuZTLt+q10BCeAIOBdv7ljlwG7O
	 EM9QSsCtm2Ci3inZFopmqPH3MevxJVckTdi+4cC4veVdmSPnm0rBd7CjKCqN2zc8hP
	 R9Oqt6TWA7s3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>,
	Josh Don <joshdon@google.com>,
	Hao Luo <haoluo@google.com>,
	Barret Rhoden <brho@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] sched: Allow sched_cgroup_fork() to fail and introduce sched_cancel_fork()
Date: Wed, 28 Oct 2026 15:43:32 -0400
Message-ID: <20261028194315.2086000-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102802-progress-trodden-c504@gregkh>
References: <2026102802-progress-trodden-c504@gregkh>
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
index ff5aaed609695..50774dc8709c1 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -55,7 +55,8 @@ extern asmlinkage void schedule_tail(struct task_struct *prev);
 extern void init_idle(struct task_struct *idle, int cpu);
 
 extern int sched_fork(unsigned long clone_flags, struct task_struct *p);
-extern void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs);
+extern int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs);
+extern void sched_cancel_fork(struct task_struct *p);
 extern void sched_post_fork(struct task_struct *p);
 extern void sched_dead(struct task_struct *p);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 25fb13362d38c..8f925267e9c2d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2280,7 +2280,7 @@ static __latent_entropy struct task_struct *copy_process(
 
 	retval = perf_event_init_task(p, clone_flags);
 	if (retval)
-		goto bad_fork_cleanup_policy;
+		goto bad_fork_sched_cancel_fork;
 	retval = audit_alloc(p);
 	if (retval)
 		goto bad_fork_cleanup_perf;
@@ -2410,7 +2410,9 @@ static __latent_entropy struct task_struct *copy_process(
 	 * cgroup specific, it unconditionally needs to place the task on a
 	 * runqueue.
 	 */
-	sched_cgroup_fork(p, args);
+	retval = sched_cgroup_fork(p, args);
+	if (retval)
+		goto bad_fork_cancel_cgroup;
 
 	/*
 	 * From this point on we must avoid any synchronous user-space
@@ -2454,13 +2456,13 @@ static __latent_entropy struct task_struct *copy_process(
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
@@ -2536,10 +2538,11 @@ static __latent_entropy struct task_struct *copy_process(
 
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
@@ -2578,6 +2581,8 @@ static __latent_entropy struct task_struct *copy_process(
 	audit_free(p);
 bad_fork_cleanup_perf:
 	perf_event_free_task(p);
+bad_fork_sched_cancel_fork:
+	sched_cancel_fork(p);
 bad_fork_cleanup_policy:
 	lockdep_free_task(p);
 #ifdef CONFIG_NUMA
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c4e9fac7507a9..36580fe4ccfc0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4457,7 +4457,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	return 0;
 }
 
-void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
+int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 {
 	unsigned long flags;
 
@@ -4484,6 +4484,12 @@ void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
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

